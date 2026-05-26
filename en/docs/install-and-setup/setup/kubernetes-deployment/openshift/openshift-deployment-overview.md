# Deploy WSO2 API Manager on OpenShift

OpenShift is a Kubernetes distribution with stricter security defaults. The core deployment approach — Helm charts, the same patterns (P0–P5) — is identical to standard Kubernetes. The key difference is that OpenShift ignores the UID defined in the Docker image and injects a random UID at runtime, which requires additional file permission configuration in the image and specific security context settings in the Helm values.

For routing, WSO2 API Manager 4.6.0 uses standard Kubernetes Ingress. An **NGINX Ingress Controller** must be installed on your OpenShift cluster before deploying.

!!! warning "OpenShift deployment requires the following before deploying:"

    1. **A custom Docker image** — with GID 0 group-write permissions and the JDBC driver for your database. Standard WSO2 images will fail to start on OpenShift.
    2. **An external database** — required for distributed deployments (P1–P5). The All-in-One pattern (P0) can use the embedded H2 database for evaluation purposes.
    3. **Database schema initialised** — if using an external database, run the WSO2 schema scripts against both databases before the pods start.
    4. **NGINX Ingress Controller** — must be installed on the OpenShift cluster before the Helm chart is deployed.

---

## Quick Start

### Step 1 — Install Required Tools { #step-1 }

1. Ensure the following tools are installed on your machine:

    | Tool | Purpose | Install Guide |
    | ---- | ------- | ------------- |
    | `oc` | OpenShift CLI for managing cluster resources | [Install](https://docs.openshift.com/container-platform/latest/cli_reference/openshift_cli/getting-started-cli.html) |
    | `kubectl` | Kubernetes CLI (used alongside `oc`) | [Install](https://kubernetes.io/docs/tasks/tools/) |
    | `helm` (v3) | Package manager for deploying WSO2 Helm charts | [Install](https://helm.sh/docs/intro/install/) |
    | `docker` | Required to build and push custom WSO2 images | [Install](https://docs.docker.com/get-docker/) |

2. Verify all tools are installed:

    ```bash
    oc version
    helm version
    docker info
    ```

### Step 2 — Log in to OpenShift { #step-2 }

1. Authenticate with the OpenShift CLI:

    === "Username / Password"

        ```bash
        oc login <API_SERVER_URL> -u <USERNAME> -p <PASSWORD>
        ```

    === "Token"

        ```bash
        oc login <API_SERVER_URL> --token=<TOKEN>
        ```

2. Once authenticated, verify your connection and check your currently selected project:

      ```bash
      # Verify connection
      oc whoami

      # Check current project
      oc project
      ```

!!! warning "Important"
    Always create a dedicated project for your deployments instead of using the ```default``` to ensure proper resource isolation and security policy enforcement. Using a separate project allows you to manage access control and quotas independently from cluster infrastructure services.

    - **To create a new project**:
      ```bash
      oc new-project <PROJECT-NAME>
      ```
    
    Creating an OpenShift project automatically creates the corresponding Kubernetes namespace and switches the current context to it.

### Step 3 — Add the WSO2 Helm Repository { #step-3 }

```bash
helm repo add wso2 https://helm.wso2.com && helm repo update
```

### Step 4 — Install NGINX Ingress Controller { #step-4 }

WSO2 API Manager 4.6.0 uses Kubernetes Ingress for external access. Install the NGINX Ingress Controller on your OpenShift cluster:

```bash
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --set controller.service.type=LoadBalancer \
  --set controller.admissionWebhooks.enabled=false
```

OpenShift's default Security Context Constraints (SCCs) block the NGINX controller pod from starting. Grant the `privileged` SCC to its service account and restart the deployment:

```bash
oc adm policy add-scc-to-user privileged system:serviceaccount:ingress-nginx:ingress-nginx
kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx
```

Wait for the controller pod to be ready:

```bash
kubectl get pods -n ingress-nginx -w
```

Make sure the deployment is up and running and the pods are ready before proceeding.

### Step 5 — Build an OpenShift-Compatible Docker Image { #step-5 }

Standard WSO2 images run as a fixed UID (`wso2carbon`, UID 802). OpenShift injects a random UID at runtime, so any directories the server writes to must have **group-write permissions with root group (GID 0) ownership**.

!!! note "Why GID 0?"
    OpenShift assigns a random UID to the container process but always uses GID 0 (root group). By granting group-write access to the root group, the container can write to its directories regardless of which UID OpenShift assigns. See [Red Hat's guide to OpenShift and UIDs](https://www.redhat.com/en/blog/a-guide-to-openshift-and-uids) and [group ownership and file permission](https://developers.redhat.com/blog/2020/10/26/adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform#group_ownership_and_file_permission) for more detail.

1. Create a `Dockerfile` for the All-in-One image:

    === "Evaluation (H2 database)"

        ```dockerfile
        FROM wso2/wso2am:4.6.0

        # Grant root group write access for OpenShift arbitrary UID support
        USER root
        RUN chgrp -R 0 /home/wso2carbon && chmod -R g=u /home/wso2carbon
        USER wso2carbon
        ```

    === "Production (external database)"

        WSO2 images do not include a JDBC driver. Add the driver for your database:

        ```dockerfile
        FROM wso2/wso2am:4.6.0

        # Grant root group write access for OpenShift arbitrary UID support
        USER root
        RUN chgrp -R 0 /home/wso2carbon && chmod -R g=u /home/wso2carbon
        USER wso2carbon

        # Add MySQL JDBC driver — replace URL for other databases
        ADD --chown=wso2carbon:wso2 \
          https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
          ${WSO2_SERVER_HOME}/repository/components/lib/
        ```

2. Build and push the image, replacing `<REGISTRY>` and `<TAG>` with your values:

    ```bash
    docker buildx build --platform linux/amd64 -t <REGISTRY>/wso2am-ocp:<TAG> .
    docker push <REGISTRY>/wso2am-ocp:<TAG>
    ```

    !!! note "Matching your cluster architecture"
        The `--platform` flag must match the architecture of your cluster nodes:

        - **Managed clusters (AKS, ROSA, ARO)** — use `linux/amd64`
        - **ARM based VMs** — use `linux/arm64`

        Using the wrong platform will cause `ErrImagePull` when the pod starts. You can check a node's architecture with `kubectl get nodes -o wide`

3. Get the image digest — you will need it when configuring your values file:

    ```bash
    docker inspect <REGISTRY>/wso2am-ocp:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'
    ```

### Step 6 — Set Up the Database { #step-6 }

The All-in-One pattern uses an embedded H2 database by default, which is suitable for evaluation. For production deployments, set up an external database before the pods start.

If you are using H2, skip this step and proceed to [Step 7](#step-7).

For production, follow the [Setting Up Databases]({{base_path}}/install-and-setup/setup/setting-up-databases/overview/) guide to:

1. Set up a database instance accessible from your cluster
2. Obtain the schema scripts for your database type
3. Run the scripts to initialise both databases

### Step 7 — Create the Keystore Secret { #step-7 }

The Helm chart mounts a Kubernetes secret named `apim-keystore-secret` as a volume into the pods. The pods will not start if this secret does not exist.

1. Extract the default keystores from your image and create the secret:

    ```bash
    mkdir -p keystores

    docker run --rm -v "$(pwd)/keystores:/keystores" --entrypoint bash \
      <REGISTRY>/wso2am-ocp:<TAG> \
      -c "cp \${WSO2_SERVER_HOME}/repository/resources/security/wso2carbon.jks \
             \${WSO2_SERVER_HOME}/repository/resources/security/client-truststore.jks \
             /keystores/"

    kubectl create secret generic apim-keystore-secret \
      --from-file=wso2carbon.jks=keystores/wso2carbon.jks \
      --from-file=client-truststore.jks=keystores/client-truststore.jks \
      -n apim
    ```

2. Verify the secret was created:

    ```bash
    kubectl get secret apim-keystore-secret -n apim
    ```

!!! note
    - Make sure to create the secret inside the namespace which will be used for installing the API Manager.
    - The commands above use the default WSO2 keystores which are suitable for evaluation only. For production-level keystore setup, refer to [Configuring Keystores in WSO2 API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/).

### Step 8 — Deploy the All-in-One { #step-8 }

1. Download the OpenShift default values file:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/all-in-one/default_openshift_values.yaml \
      -o values.yaml
    ```

2. Open `values.yaml` and update the following sections:

    **Custom image** — point to the OpenShift-compatible image you built in Step 5:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "<YOUR_REGISTRY>"
          repository: "wso2am-ocp"
          tag: "<YOUR_TAG>"
          digest: "sha256:..."
    ```

    **Enable OpenShift mode:**

    ```yaml
    kubernetes:
      openshift:
        enabled: true
    ```

    !!! note
        The `default_openshift_values.yaml` has `openshift.enabled: false` — make sure to set this to `true`.

    **Ingress hostnames** — update to match your cluster's DNS:

    ```yaml
    kubernetes:
      ingress:
        management:
          hostname: "am.example.com"
        gateway:
          hostname: "gw.example.com"
        websocket:
          hostname: "websocket.example.com"
        websub:
          hostname: "websub.example.com"
    ```

    **Database connection** (skip if using H2):

    ```yaml
    wso2:
      apim:
        configurations:
          databases:
            apim_db:
              url: "<JDBC_URL_FOR_APIM_DB>"
              username: "<DB_USERNAME>"
              password: "<DB_PASSWORD>"
            shared_db:
              url: "<JDBC_URL_FOR_SHARED_DB>"
              username: "<DB_USERNAME>"
              password: "<DB_PASSWORD>"
    ```

3. Deploy:

    ```bash
    helm install apim wso2/wso2am-all-in-one \
      --version 4.6.0-1 \
      --namespace apim \
      --dependency-update \
      -f values.yaml
    ```

4. Wait for the pod to be ready:

    ```bash
    oc get pods -n apim -w
    ```

    The pod should show `1/1 Running` before proceeding.

### Step 9 — Verify Ingress { #step-9 }

The Helm chart creates Kubernetes `Ingress` objects automatically. Verify they were created:

```bash
kubectl get ing -n apim
```

You should see ingress entries for management, gateway, websocket, and websub with the hostnames you configured.

### Step 10 — Configure DNS { #step-10 }

You need to point your ingress hostnames to the NGINX Ingress Controller's external address.

1. Get the NGINX controller's external IP:

    ```bash
    kubectl get svc -n ingress-nginx ingress-nginx-controller
    ```

    Note the `EXTERNAL-IP` value from the output.

2. Map the hostnames to that IP:

    === "OpenShift Local (CRC)"

        CRC does not provision a load balancer, so `EXTERNAL-IP` will show `<pending>`. The NGINX NodePorts (`30400` for HTTPS) are not forwarded from the Mac to the CRC VM, so the browser cannot reach them directly.

        The recommended workaround is to create OpenShift Routes manually. CRC's built-in HAProxy router handles port 443 traffic natively, so Routes work on standard ports without any extra configuration:

        ```bash
        oc create route passthrough apim-management \
          --service=apim-wso2am-all-in-one-am-service \
          --port=9443 \
          --hostname=am.wso2.com \
          -n apim

        oc create route passthrough apim-gateway \
          --service=apim-wso2am-all-in-one-am-service \
          --port=8243 \
          --hostname=gw.wso2.com \
          -n apim

        oc create route passthrough apim-websocket \
          --service=apim-wso2am-all-in-one-am-service \
          --port=8099 \
          --hostname=websocket.wso2.com \
          -n apim

        oc create route passthrough apim-websub \
          --service=apim-wso2am-all-in-one-am-service \
          --port=8021 \
          --hostname=websub.wso2.com \
          -n apim
        ```

        Then add the hostnames to your `/etc/hosts`:

        ```bash
        sudo sh -c 'echo "127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com" >> /etc/hosts'
        ```

    === "Managed cluster (ROSA / ARO)"

        For quick testing, add the external address to your `/etc/hosts` file:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

        For a production setup, create DNS records in your DNS provider mapping the hostnames to the external IP instead of using `/etc/hosts`.

!!! note
    These are the default hostnames. If you customised the hostnames in your `values.yaml`, use those values here instead.

### Step 11 — Access the Portals { #step-11 }

Once DNS is configured, open the following URLs in your browser:

=== "OpenShift Local (CRC)"

    If you created Routes manually in Step 10, access the portals on the standard port via the CRC HAProxy router:

    | Portal | URL |
    | ------ | --- |
    | Publisher | `https://am.wso2.com/publisher` |
    | Developer Portal | `https://am.wso2.com/devportal` |
    | Admin Portal | `https://am.wso2.com/admin` |
    | Carbon Console | `https://am.wso2.com/carbon` |
    | Gateway | `https://gw.wso2.com` |

=== "Managed cluster (ROSA / ARO)"

    | Portal | URL |
    | ------ | --- |
    | Publisher | `https://<kubernetes.ingress.management.hostname>/publisher` |
    | Developer Portal | `https://<kubernetes.ingress.management.hostname>/devportal` |
    | Admin Portal | `https://<kubernetes.ingress.management.hostname>/admin` |
    | Carbon Console | `https://<kubernetes.ingress.management.hostname>/carbon` |
    | Gateway | `https://<kubernetes.ingress.gateway.hostname>` |

    Replace the hostname placeholders with the actual values from your `values.yaml`. With default values, the management hostname is `am.wso2.com` and the gateway hostname is `gw.wso2.com`.

Default credentials: **admin / admin**

---

## Advanced Configuration

### 1. OpenShift Security Context { #section-1 }

Every component deployed on OpenShift requires the following block in its values file. The `default_openshift_values.yaml` used in the Quick Start already includes this — you only need to add it manually when creating values files for distributed deployments.

```yaml
kubernetes:
  securityContext:
    # Allow OpenShift to assign arbitrary UIDs
    runAsUser: null
    seLinux:
      enabled: false
      level: ""
    seccompProfile:
      type: RuntimeDefault
      localhostProfile: ""
  # AppArmor is not available on OpenShift (which uses SELinux instead)
  enableAppArmor: false
  configMaps:
    scripts:
      # Startup scripts mounted via ConfigMap require execute permission
      defaultMode: "0457"
```

| Setting | Why it's needed |
|---|---|
| `runAsUser: null` | Lets OpenShift assign its random UID instead of the image's fixed UID |
| `enableAppArmor: false` | AppArmor is not supported on OpenShift |
| `seLinux.enabled: false` | Leave off unless your cluster has SELinux policies configured for WSO2 |
| `configMaps.scripts.defaultMode: "0457"` | Startup scripts mounted as a ConfigMap need execute permission |

### 2. Distributed Deployments { #section-2 }

For distributed patterns, follow the corresponding Kubernetes pattern guide and apply the OpenShift-specific changes described in this page on top.

| Pattern | Guide |
|---|---|
| Pattern 1 — HA All-in-One | [am-pattern-1-all-in-one-ha.md](../kubernetes/am-pattern-1-all-in-one-ha.md) |
| Pattern 2 — All-in-One + Gateway | [am-pattern-2-all-in-one-gw.md](../kubernetes/am-pattern-2-all-in-one-gw.md) |
| Pattern 3 — ACP + TM + Gateway | [am-pattern-3-acp-tm-gw.md](../kubernetes/am-pattern-3-acp-tm-gw.md) |
| Pattern 4 — ACP + TM + Gateway + KM | [am-pattern-4-acp-tm-gw-km.md](../kubernetes/am-pattern-4-acp-tm-gw-km.md) |
| Pattern 5 — All-in-One + Gateway + KM | [am-pattern-5-all-in-one-gw-km.md](../kubernetes/am-pattern-5-all-in-one-gw-km.md) |

**For each component in your chosen pattern:**

1. **Build an OpenShift-compatible image** — apply the same `USER root` / `chgrp` / `chmod` / `USER wso2carbon` pattern from [Step 5](#step-5) to each component's base image (`wso2/wso2am-acp:4.6.0`, `wso2/wso2am-tm:4.6.0`, `wso2/wso2am-universal-gw:4.6.0`). TM and Gateway do not need the JDBC driver.
2. **Add the security context block** from [Section 1](#section-1) to each component's values file.
3. **Set `kubernetes.openshift.enabled: true`** in each component's values file.

---

## Troubleshooting

### Permission denied errors

**Symptom:** Pod fails to start with `Permission denied` in the logs.

**Cause:** The container process cannot write to a directory because the image was not prepared with GID 0 group ownership.

**Fix:** Ensure your Dockerfile includes the `chgrp -R 0` and `chmod -R g=u` steps from [Step 5](#step-5). Check the pod logs and the applied security context:

```bash
oc logs <pod-name> -n apim
oc get pod <pod-name> -n apim -o yaml | grep -A 10 securityContext
```

### Image pull errors

**Symptom:** Pod stuck in `ImagePullBackOff` or `ErrImagePull`.

**Fix:** Create an image pull secret and link it to the service account:

```bash
oc create secret docker-registry registry-credentials \
  --docker-server=<YOUR_REGISTRY> \
  --docker-username=<USERNAME> \
  --docker-password=<PASSWORD> \
  -n apim

oc secrets link default registry-credentials --for=pull -n apim
```

### Ingress not reachable

**Symptom:** Hostnames don't resolve or the browser cannot connect.

**Fix:**

1. Confirm the NGINX Ingress Controller has an external IP:

    ```bash
    kubectl get svc -n ingress-nginx ingress-nginx-controller
    ```

    If `EXTERNAL-IP` is `<pending>`, the load balancer hasn't been provisioned yet. On CRC this may stay pending — use `127.0.0.1` instead.

2. Confirm the Ingress objects were created:

    ```bash
    kubectl get ing -n apim
    ```

### Volume mount errors

**Symptom:** Pod crashes with volume-related errors.

**Fix:** Check that PersistentVolumeClaims are bound:

```bash
oc get pvc -n apim
```

If a volume fails due to fsGroup permissions, patch the deployment:

```bash
oc patch deployment <deployment-name> -n apim \
  -p '{"spec":{"template":{"spec":{"securityContext":{"fsGroup":0}}}}}'
```

### Inter-component communication failures

**Symptom:** Components cannot reach each other (e.g. GW cannot connect to ACP).

**Cause:** OpenShift may enforce network policies that block cross-pod traffic within the namespace.

**Fix:** Check for blocking policies and apply a permissive one for all APIM pods:

```bash
oc get netpol -n apim
```

```bash
oc apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-apim-internal
  namespace: apim
spec:
  podSelector: {}
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: apim
EOF
```

This allows all pods within the `apim` namespace to communicate with each other.
