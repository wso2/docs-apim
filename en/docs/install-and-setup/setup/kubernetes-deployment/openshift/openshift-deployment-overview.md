# Deploy WSO2 API Manager on OpenShift

OpenShift is a Kubernetes distribution with stricter security defaults. The core deployment approach — Helm charts, the same patterns (P0–P5) — is identical to standard Kubernetes. The key difference is that OpenShift ignores the UID defined in the Docker image and injects a random UID at runtime, which requires additional file permission configuration in the image and specific security context settings in the Helm values.

For routing, OpenShift supports both `Route` objects (native to OpenShift) and standard Kubernetes `Ingress` (if an ingress controller is installed). The default OpenShift values file uses Routes.

!!! warning "OpenShift deployment requires the following before deploying:"

    1. **A custom Docker image** — with GID 0 group-write permissions and the JDBC driver for your database. Standard WSO2 images will fail to start on OpenShift.
    2. **An external database** — required for distributed deployments (P1–P5). The All-in-One pattern (P0) can use the embedded H2 database for evaluation purposes.
    3. **Database schema initialised** — if using an external database, run the WSO2 schema scripts against both databases before the pods start.

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

2. Verify your connection and create the namespace:

    ```bash
    oc whoami
    oc create namespace apim
    ```

### Step 3 — Add the WSO2 Helm Repository { #step-3 }

1. Add the WSO2 Helm repository and update it:

    ```bash
    helm repo add wso2 https://helm.wso2.com && helm repo update
    ```

### Step 4 — Build an OpenShift-Compatible Docker Image { #step-4 }

Standard WSO2 images run as a fixed UID (`wso2carbon`, UID 802). OpenShift injects a random UID at runtime, so any directories the server writes to must have **group-write permissions with root group (GID 0) ownership**.

!!! note "Why GID 0?"
    OpenShift assigns a random UID to the container process but always uses GID 0 (root group). By granting group-write access to the root group, the container can write to its directories regardless of which UID OpenShift assigns. See [Red Hat's guide to OpenShift and UIDs](https://www.redhat.com/en/blog/a-guide-to-openshift-and-uids) and [group ownership and file permission](https://developers.redhat.com/blog/2020/10/26/adapting-docker-and-kubernetes-containers-to-run-on-red-hat-openshift-container-platform#group_ownership_and_file_permission) for more detail.

1. Create a `Dockerfile` for the All-in-One image:

    === "Evaluation (H2 database)"

        ```dockerfile
        FROM wso2/wso2am:4.7.0

        # Grant root group write access for OpenShift arbitrary UID support
        USER root
        RUN chgrp -R 0 /home/wso2carbon && chmod -R g=u /home/wso2carbon
        USER wso2carbon
        ```

    === "Production (external database)"

        WSO2 images do not include a JDBC driver. Add the driver for your database:

        ```dockerfile
        FROM wso2/wso2am:4.7.0

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
        - **OpenShift Local (CRC) on Apple Silicon (M1/M2/M3/M4)** — use `linux/arm64`

        Using the wrong platform will cause `ErrImagePull` when the pod starts.

3. Get the image digest — you will need it when configuring your values file:

    ```bash
    docker inspect <REGISTRY>/wso2am-ocp:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'
    ```

### Step 5 — Set Up the Database { #step-5 }

The All-in-One pattern uses an embedded H2 database by default, which is suitable for evaluation. For production deployments, set up an external database before the pods start.

If you are using H2, skip this step and proceed to [Step 6](#step-6).

For production, follow the [Setting Up Databases]({{base_path}}/install-and-setup/setup/setting-up-databases/overview/) guide to:

1. Set up a database instance accessible from your cluster
2. Obtain the schema scripts for your database type
3. Run the scripts to initialise both databases

### Step 6 — Create the Keystore Secret { #step-6 }

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
    The commands above use the default WSO2 keystores which are suitable for evaluation only. For production-level keystore setup, refer to [Configuring Keystores in WSO2 API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/).

### Step 7 — Deploy the All-in-One { #step-7 }

1. Download the OpenShift default values file:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/all-in-one/default_openshift_values.yaml \
      -o values.yaml
    ```

2. Open `values.yaml` and update the following sections:

    **Custom image** — point to the OpenShift-compatible image you built in Step 4:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "<YOUR_REGISTRY>"
          repository: "wso2am-ocp"
          tag: "<YOUR_TAG>"
          digest: "sha256:..."
    ```

    **Database connection:**

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

    **Route hostnames** — update the hostnames to match your cluster's DNS:

    !!! note "Prefer Ingress over Routes?"
        If you have an ingress controller installed on your OpenShift cluster, you can use standard Kubernetes Ingress instead. In `values.yaml`, disable the `kubernetes.route.*` entries and enable the `kubernetes.ingress.*` entries instead.

    ```yaml
    kubernetes:
      route:
        management:
          hostname: "am.example.com"
        gateway:
          hostname: "gw.example.com"
        websocket:
          hostname: "websocket.example.com"
        websub:
          hostname: "websub.example.com"
    ```

3. Deploy:

    ```bash
    helm install apim wso2/wso2am-all-in-one \
      --version 4.7.0-1 \
      --namespace apim \
      --dependency-update \
      -f values.yaml \
      --set wso2.apim.configurations.encryption.key=$(openssl rand -hex 32)
    ```

    !!! warning "Encryption key is mandatory"
        WSO2 API Manager 4.7.0 requires a 256-bit encryption key to be set before the first startup. The command above generates one automatically using `openssl`. If you are deploying to a shared or production environment, generate the key separately and store it securely — you will need the same key if you redeploy or scale the deployment. For more information, see [Configuring the Internal Encryption Key]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords/).

4. Wait for the pod to be ready:

    ```bash
    oc get pods -n apim -w
    ```

    The pod should show `1/1 Running` before proceeding.

### Step 8 — Verify Routes { #step-8 }

The Helm chart creates OpenShift `Route` objects automatically. Verify they were created:

```bash
oc get routes -n apim
```

You should see routes for `management`, `gateway`, `websocket`, and `websub` with the hostnames you configured.

### Step 9 — Configure DNS { #step-9 }

You need to point your route hostnames to the correct address depending on your environment.

=== "OpenShift Local (CRC)"

    The CRC VM is always reachable at `127.0.0.1` from your local machine. Add the route hostnames to your `/etc/hosts` file:

    ```bash
    sudo sh -c 'echo "127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com" >> /etc/hosts'
    ```

=== "Managed cluster (ROSA / ARO)"

    1. Get the router's external IP:

        ```bash
        oc get svc router-default -n openshift-ingress
        ```

        Note the `EXTERNAL-IP` value from the output.

    2. For quick testing, add the external address to your `/etc/hosts` file:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

    For a production setup, create DNS records in your DNS provider mapping the hostnames to the external IP instead of using `/etc/hosts`.

!!! note
    These are the default hostnames. If you customised the hostnames in your `values.yaml`, use those values here instead (`kubernetes.route.management.hostname`, `kubernetes.route.gateway.hostname`, etc.).

### Step 10 — Access the Portals { #step-10 }

Once DNS is configured, open the following URLs in your browser:

| Portal | URL |
| ------ | --- |
| Publisher | `https://<kubernetes.route.management.hostname>/publisher` |
| Developer Portal | `https://<kubernetes.route.management.hostname>/devportal` |
| Admin Portal | `https://<kubernetes.route.management.hostname>/admin` |
| Carbon Console | `https://<kubernetes.route.management.hostname>/carbon` |
| Gateway | `https://<kubernetes.route.gateway.hostname>` |

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

1. **Build an OpenShift-compatible image** — apply the same `USER root` / `chgrp` / `chmod` / `USER wso2carbon` pattern from [Step 4](#step-4) to each component's base image (`wso2/wso2am-acp:4.7.0`, `wso2/wso2am-tm:4.7.0`, `wso2/wso2am-universal-gw:4.7.0`). TM and Gateway do not need the JDBC driver.
2. **Add the security context block** from [Section 1](#section-1) to each component's values file.
3. **Use the same encryption key across all components** — generate it once and pass it to every `helm install` command:

    ```bash
    export APIM_ENCRYPTION_KEY=$(openssl rand -hex 32)
    ```

**Example — Pattern 3 (ACP + TM + Gateway):**

Create a values file for each component. For the ACP (`values-acp.yaml`):

```yaml
kubernetes:
  securityContext:
    runAsUser: null
    seLinux:
      enabled: false
      level: ""
    seccompProfile:
      type: RuntimeDefault
      localhostProfile: ""
  enableAppArmor: false
  configMaps:
    scripts:
      defaultMode: "0457"

wso2:
  deployment:
    image:
      registry: "<YOUR_REGISTRY>"
      repository: "<YOUR_ACP_IMAGE>"
      tag: "<YOUR_TAG>"
      digest: "sha256:..."
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

Create equivalent `values-tm.yaml` and `values-gw.yaml` with the security context block and the custom image reference — TM and GW do not require database configuration.

Deploy in order:

```bash
export APIM_ENCRYPTION_KEY=$(openssl rand -hex 32)

helm install apim-acp wso2/wso2am-acp \
  --version 4.7.0-1 \
  --namespace apim --create-namespace \
  --dependency-update \
  -f values-acp.yaml \
  --set wso2.apim.configurations.encryption.key=$APIM_ENCRYPTION_KEY

helm install apim-tm wso2/wso2am-tm \
  --version 4.7.0-1 \
  --namespace apim \
  --dependency-update \
  -f values-tm.yaml \
  --set wso2.apim.configurations.encryption.key=$APIM_ENCRYPTION_KEY

helm install apim-gw wso2/wso2am-universal-gw \
  --version 4.7.0-1 \
  --namespace apim \
  --dependency-update \
  -f values-gw.yaml \
  --set wso2.apim.configurations.encryption.key=$APIM_ENCRYPTION_KEY
```

---

## Troubleshooting

### Permission denied errors

**Symptom:** Pod fails to start with `Permission denied` in the logs.

**Cause:** The container process cannot write to a directory because the image was not prepared with GID 0 group ownership.

**Fix:** Ensure your Dockerfile includes the `chgrp -R 0` and `chmod -R g=u` steps from [Step 4](#step-4). Check the pod logs and the applied security context:

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
