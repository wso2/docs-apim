# Pattern 3: Distributed Setup

This pattern deploys dedicated nodes for the API Control Plane, Traffic Manager, and Classic Gateway. Each component scales independently, making it suitable for production environments with high API traffic where fine-grained control over scaling and fault isolation is required.

<a href="{{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png"><img src="{{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png" alt="distributed api-m deployment" width="60%"></a>

## How Pattern 3 Differs from Earlier Patterns

| | Pattern 1 | Pattern 2 | Pattern 3 |
|---|---|---|---|
| Nodes | 2 All-in-One (active-active) | 1 All-in-One + dedicated Gateway | Dedicated ACP + dedicated TM + dedicated Gateway |
| Control Plane | Embedded | Embedded | Dedicated (ACP), independently scalable |
| Traffic Manager | Embedded | Embedded | Dedicated, independently scalable |
| Custom images | Required (All-in-One) | Required (All-in-One) | Required (ACP) |
| High availability | Yes (All-in-One) | Gateway: Yes; All-in-One: Optional | Yes (all components) |

!!! warning "Pattern 3 requires the following before deploying:"

    1. **An external database** — H2 is not supported. Set up an external database before deploying.
    2. **A custom Docker image** — for the API Control Plane, with the JDBC driver for your database.
    3. **Database schema initialised** — run the WSO2 schema scripts against both databases before the pods start.

---

## Quick Start

### Step 1 — Install Required Tools

1. Ensure the following tools are installed on your machine:

    | Tool | Purpose | Install Guide |
    | ---- | ------- | ------------- |
    | `kubectl` | Kubernetes CLI for managing cluster resources | [Install](https://kubernetes.io/docs/tasks/tools/) |
    | `helm` (v3) | Package manager for deploying WSO2 Helm charts | [Install](https://helm.sh/docs/intro/install/) |
    | `docker` | Required to build and push custom WSO2 images | [Install](https://docs.docker.com/get-docker/) |

2. Verify all tools are installed and check their versions:

    ```bash
    kubectl version --client
    helm version
    docker info
    ```

    !!! note "Version Compatibility"
        Ensure your tool versions are within the supported ranges listed in the [Prerequisites](kubernetes-overview.md#prerequisites) page before proceeding.

### Step 2 — Verify Your Cluster is Running

1. Ensure your Kubernetes cluster is up and running:

    ```bash
    kubectl cluster-info
    kubectl get nodes
    ```

    All nodes should show a `Ready` status.

### Step 3 — Add the WSO2 Helm Repository

1. Add the WSO2 Helm repository and update it:

    ```bash
    helm repo add wso2 https://helm.wso2.com && helm repo update
    ```

### Step 4 — Install a Routing Controller

WSO2 API Manager 4.7.0 uses Envoy Gateway by default for routing and it is the recommended option. NGINX Ingress Controller is also available for users who require it.

=== "Envoy Gateway (Recommended)"

    1. Install Envoy Gateway:

        ```bash
        helm install envoy-gateway oci://docker.io/envoyproxy/gateway-helm \
          --version v1.7.0 -n envoy-gateway-system \
          --set config.envoyGateway.extensionApis.enableBackend=true \
          --set envoyGateway.gateway.experimentalFeatures.enabled=true \
          --create-namespace
        ```

    2. Create the `apim` namespace and apply the sample Gateway manifest:

        ```bash
        kubectl create namespace apim
        kubectl apply \
          -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/resources/assets/sample-gateway.yaml \
          -n apim
        ```

    3. Verify the gateway is ready:

        ```bash
        kubectl get gateway -n apim
        ```

    See [Section 4 — Routing Controller](#4-routing-controller) for full Envoy Gateway values configuration.

=== "NGINX Ingress Controller (Deprecated)"

    1. Install the NGINX ingress controller into your cluster:

        === "Local cluster (Minikube / Rancher Desktop)"

            ```bash
            helm upgrade --install ingress-nginx ingress-nginx \
              --repo https://kubernetes.github.io/ingress-nginx \
              --namespace ingress-nginx --create-namespace
            ```

        === "Managed cluster (AKS / GKE)"

            ```bash
            helm upgrade --install ingress-nginx ingress-nginx \
              --repo https://kubernetes.github.io/ingress-nginx \
              --namespace ingress-nginx --create-namespace \
              --set controller.service.externalTrafficPolicy=Local
            ```

            !!! note
                `externalTrafficPolicy=Local` is required on managed Kubernetes services. Without it, the cloud load balancer health probes fail and traffic never reaches the ingress controller.

    2. Verify the controller is running:

        ```bash
        kubectl get pods -n ingress-nginx
        ```

        The NGINX pod should show `1/1 Running` before proceeding.

### Step 5 — Build and Push Custom Docker Images

Pattern 3 requires a custom Docker image for the API Control Plane with the JDBC driver for your database.

!!! note "Choosing a base image"
    - **DockerHub** (`wso2/wso2am-acp:4.7.0`, `wso2/wso2am-tm:4.7.0`, `wso2/wso2am-universal-gw:4.7.0`) — packages the GA release. Suitable for evaluation and development.
    - **WSO2 Private Registry** (`registry.wso2.com/wso2-apim/am-acp:4.7.0.0`, `registry.wso2.com/wso2-apim/am-tm:4.7.0.0`, `registry.wso2.com/wso2-apim/am-universal-gw:4.7.0.0`) — includes WSO2 Updates and is recommended for production. Requires an active [WSO2 Subscription](https://wso2.com/subscription).

1. Create a directory for the custom images:

    ```bash
    mkdir wso2am-custom && cd wso2am-custom
    ```

2. Create a `Dockerfile.acp` for the API Control Plane image:

    ```dockerfile
    FROM wso2/wso2am-acp:4.7.0

    ADD --chown=wso2carbon:wso2 \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
      /home/wso2carbon/wso2am-acp-4.7.0/repository/components/lib/
    ```

3. Build the ACP image, replacing `<REGISTRY>` and `<TAG>` with your values:

    ```bash
    docker buildx build --platform linux/amd64 -f Dockerfile.acp -t <REGISTRY>/wso2am-acp-mysql:<TAG> .
    ```

    !!! note "Matching your cluster architecture"
        The `--platform` flag ensures the image is built for the architecture your cluster nodes run on. Most managed clusters (AKS, GKE) and Linux servers use `linux/amd64`. If you are building on Apple Silicon (M1/M2/M3/M4) without this flag, the image will be built for `linux/arm64` and the pod will fail to start with `no match for platform in manifest`.

        To check your cluster node architecture:

        ```bash
        kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.architecture}'
        ```

4. Push the image to your container registry:

    ```bash
    docker push <REGISTRY>/wso2am-acp-mysql:<TAG>
    ```

5. Get the image digest — you will need it when configuring your values files:

    ```bash
    docker inspect <REGISTRY>/wso2am-acp-mysql:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'
    ```

### Step 6 — Set Up the Database

Pattern 3 requires two databases: `apim_db` and `shared_db`. Both must be reachable from inside the Kubernetes cluster before the pods start.

Follow the [Setting Up Databases]({{base_path}}/install-and-setup/setup/setting-up-databases/overview/) guide to:

1. Set up a database instance accessible from your cluster
2. Obtain the schema scripts for your database type
3. Run the scripts to initialise both databases

!!! note
    The JDBC driver for your database is already included in the custom Docker image you built in Step 5. You do not need to follow the JDBC driver steps in the VM-oriented sections of that guide.

Once the scripts have been run, verify that both databases are set up correctly before proceeding:

- Connect to your database instance and confirm that `apim_db` and `shared_db` both exist
- Check that tables have been created in each database (the `shared_db` script creates `UM_*` and `REG_*` tables; the `apim_db` script creates `AM_*` tables)

### Step 7 — Create the Keystore Secret { #step-7 }

The Helm chart mounts a Kubernetes secret named `apim-keystore-secret` as a volume into the pods. The pods will not start if this secret does not exist.

1. Extract the default keystores from your ACP image and create the secret:

    ```bash
    mkdir -p keystores

    docker run --rm -v "$(pwd)/keystores:/keystores" --entrypoint bash <REGISTRY>/wso2am-acp-mysql:<TAG> -c "cp /home/wso2carbon/wso2am-acp-4.7.0/repository/resources/security/wso2carbon.jks /home/wso2carbon/wso2am-acp-4.7.0/repository/resources/security/client-truststore.jks /keystores/"

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

### Step 8 — Deploy the API Control Plane { #step-8 }

1. Download the default values file for the API Control Plane:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/am-pattern-3-ACP_TM_GW/default_acp_values.yaml \
      -o values-acp.yaml
    ```

2. Open `values-acp.yaml` and update the two sections below before deploying.

    **Custom image** — point to the ACP image you built in Step 5:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "docker.io"
          repository: "<your-username>/wso2am-acp-mysql"
          tag: "<TAG>"
          digest: "sha256:abcdef..."
    ```

    **Database connection** — point to the database you set up in Step 6:

    ```yaml
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

    Replace `<JDBC_URL_FOR_APIM_DB>` and `<JDBC_URL_FOR_SHARED_DB>` with the JDBC connection URL for your database. For URL formats per database type, see [Setting Up Databases]({{base_path}}/install-and-setup/setup/setting-up-databases/overview/#changing-the-default-databases).

3. Deploy the API Control Plane:

    ```bash
    helm install apim-acp wso2/wso2am-acp \
      --version 4.7.0-1 \
      --namespace apim --create-namespace \
      --dependency-update \
      -f values-acp.yaml \
      --set wso2.apim.configurations.encryption.key=$(openssl rand -hex 32)
    ```

    !!! warning "Encryption key is mandatory"
        WSO2 API Manager 4.7.0 requires a 256-bit encryption key before first startup. In a distributed deployment, **all components must use the same key** — generate it once, store it securely, and set it explicitly in all values files rather than relying on the auto-generated value above.

4. Wait for the ACP pod to be ready:

    ```bash
    kubectl get pods -n apim -w
    ```

    The ACP pod should show `1/1 Running` before deploying the Traffic Manager.

### Step 9 — Deploy the Traffic Manager { #step-9 }

Deploy the Traffic Manager using the default values:

```bash
helm install apim-tm wso2/wso2am-tm \
  --version 4.7.0-1 \
  --namespace apim \
  --dependency-update \
  -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/am-pattern-3-ACP_TM_GW/default_tm_values.yaml
```

!!! note "To customise before deploying"
    If you used a different release name than `apim-acp` for the ACP, or want to make other changes, download the values file first, edit it, then replace the `-f <url>` above with `-f values-tm.yaml`:
    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/am-pattern-3-ACP_TM_GW/default_tm_values.yaml \
      -o values-tm.yaml
    ```

### Step 10 — Deploy the Classic Gateway { #step-10 }

Deploy the Classic Gateway using the default values:

```bash
helm install apim-gw wso2/wso2am-universal-gw \
  --version 4.7.0-1 \
  --namespace apim \
  --dependency-update \
  -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/am-pattern-3-ACP_TM_GW/default_gw_values.yaml
```

!!! note "To customise before deploying"
    If you used different release names than `apim-acp` and `apim-tm`, or want to make other changes, download the values file first, edit it, then replace the `-f <url>` above with `-f values-gw.yaml`:
    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/am-pattern-3-ACP_TM_GW/default_gw_values.yaml \
      -o values-gw.yaml
    ```

### Step 11 — Configure DNS

!!! note "Envoy Gateway users"
    If you installed Envoy Gateway (the default), get the external address from the Gateway resource:

    ```bash
    kubectl get gateway -n apim
    ```

    Then map the `kubernetes.gatewayAPI.*` hostnames from your `values.yaml` to the external address.

=== "Minikube"

    1. Run the following command in a **separate terminal** and keep it running:

        ```bash
        minikube tunnel
        ```

        !!! note
            `minikube tunnel` requires sudo privileges to expose ports 80 and 443. You will be prompted for your system password. Once entered, the tunnel will stay running silently — this is expected. **Do not close this terminal.** Open a new terminal for the next steps.

    2. Get the external IP:

        === "Envoy Gateway (Recommended)"
            ```bash
            kubectl get gateway -n apim
            ```
        === "NGINX Ingress Controller (Deprecated)"
            ```bash
            kubectl get ing -n apim
            ```

        The ADDRESS column should now show `127.0.0.1`.

    3. Add the following entry to your `/etc/hosts` file:

        ```
        127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

=== "Rancher Desktop"

    1. Get the external IP:

        === "Envoy Gateway (Recommended)"
            ```bash
            kubectl get gateway -n apim
            ```
        === "NGINX Ingress Controller (Deprecated)"
            ```bash
            kubectl get ing -n apim
            ```

    2. Add the following entry to your `/etc/hosts` file, replacing `<EXTERNAL-IP>` with the value from the output above:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

=== "Managed cluster (AKS / GKE)"

    1. Get the external IP:

        === "Envoy Gateway (Recommended)"
            ```bash
            kubectl get gateway -n apim
            ```
        === "NGINX Ingress Controller (Deprecated)"
            ```bash
            kubectl get ing -n apim
            ```

    2. For quick testing, add the `ADDRESS` value to your `/etc/hosts`:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

        For a production setup, create a DNS record in your DNS provider (e.g. Route 53, Azure DNS, Cloud DNS) mapping the hostnames to the external IP instead of using `/etc/hosts`.

!!! note
    These are the default hostnames. If you customised the hostnames in your `values.yaml`, use those values here instead:

    - **Envoy Gateway**: `kubernetes.gatewayAPI.management.hostname`, `kubernetes.gatewayAPI.gateway.hostname`, etc.
    - **NGINX**: `ingress.controlPlane.hostname`, `ingress.gateway.hostname`, etc.

### Step 12 — Access the Portals

1. Once DNS is configured, open the following URLs in your browser:

    === "Envoy Gateway (Recommended)"

        | Portal | URL |
        | ------ | --- |
        | Publisher | `https://<kubernetes.gatewayAPI.management.hostname>/publisher` |
        | Developer Portal | `https://<kubernetes.gatewayAPI.management.hostname>/devportal` |
        | Carbon Console | `https://<kubernetes.gatewayAPI.management.hostname>/carbon` |
        | Gateway | `https://<kubernetes.gatewayAPI.gateway.hostname>` |

    === "NGINX Ingress Controller (Deprecated)"

        | Portal | URL |
        | ------ | --- |
        | Publisher | `https://<kubernetes.ingress.management.hostname>/publisher` |
        | Developer Portal | `https://<kubernetes.ingress.management.hostname>/devportal` |
        | Carbon Console | `https://<kubernetes.ingress.management.hostname>/carbon` |
        | Gateway | `https://<kubernetes.ingress.gateway.hostname>` |

    Replace the hostname placeholders with the actual values from your `values.yaml`. With default values, all hostnames resolve to `am.wso2.com` (management) and `gw.wso2.com` (gateway).

    !!! note "Chrome may block access"
        Chrome enforces HSTS preloading for `*.wso2.com` domains, which removes the option to bypass the self-signed certificate warning entirely. Use Firefox or Safari instead, and click through the certificate warning when prompted.

    Default credentials: **admin / admin**

---

## Additional Configuration

All configurations in this section are made by editing your `values-acp.yaml`, `values-tm.yaml`, or `values-gw.yaml` files. Once all changes are in place, deploy using the commands in [Step 8](#step-8), [Step 9](#step-9), and [Step 10](#step-10).

The Helm charts for WSO2 API Manager are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.7.x).

!!! note "Resource Naming Convention"
    Kubernetes resources created by the Helm charts follow this naming pattern:
    ```
    <RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>
    ```

### 1. Image and Registry

#### 1.1 Private Registry Authentication

The image registry and repository are configured in [Step 8](#step-8), [Step 9](#step-9), and [Step 10](#step-10). If your registry is private and requires authentication, enable `imagePullSecrets` in all three values files:

```yaml
wso2:
  deployment:
    image:
      imagePullSecrets:
        enabled: true
        username: ""
        password: ""
```

### 2. Database and Credentials

#### 2.1 Configure Admin Credentials

The default admin credentials are `admin/admin`. Change these before deploying to any shared or production environment to prevent unauthorised access.

```yaml
wso2:
  apim:
    configurations:
      adminUsername: ""
      adminPassword: ""
```

#### 2.2 Update Keystore Passwords

If you are mounting custom keystores (see [section 3.1](#section-3-1)), update the passwords here to match. If left as defaults while using custom keystores, WSO2 API-M will fail to start due to password mismatch.

```yaml
wso2:
  apim:
    configurations:
      security:
        keystores:
          primary:
            password: ""
            keyPassword: ""
          internal:
            password: ""
            keyPassword: ""
          tls:
            password: ""
            keyPassword: ""
        truststore:
          password: ""
```

!!! note
    `keyPassword` must equal `password` for each keystore. WSO2 API Manager requires these to be identical due to a limitation in internal third-party components — setting them to different values will cause startup failures.

#### 2.3 Configure the Internal Encryption Key

In a distributed deployment, all API Manager nodes must use the same internal encryption key to encrypt and decrypt shared data. Set this before the first startup — changing it afterwards will cause decryption failures for any data already encrypted.

1. Generate a unique 256-bit key:

    ```bash
    openssl rand -hex 32
    ```

2. Add the key to all your values files:

    ```yaml
    wso2:
      apim:
        configurations:
          encryption:
            key: "<generated-64-char-hex-key>"
    ```

    If you encrypt secrets using the cipher tool and secure vault (see [Section 3.2](#32-encrypt-secrets)), also encrypt the internal encryption key and set the encrypted value here instead of the plaintext key.

!!! warning
    All nodes in the deployment must use the exact same key. A mismatch will cause decryption failures across the cluster.

#### 2.4 Component Configuration References

All available configuration options for each Helm chart are documented in their respective component guides:

- [API Control Plane Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/control-plane/README.md)
- [Traffic Manager Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/traffic-manager/README.md)
- [Classic Gateway Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/gateway/README.md)

### 3. Security

#### 3.1 Mount Keystore and Truststore { #section-3-1 }

In [Step 7](#step-7), you created `apim-keystore-secret` using the default WSO2 keystores extracted from the Docker image. Those are self-signed certificates suitable for evaluation only.

For production-level keystore setup, refer to [Configuring Keystores in WSO2 API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/). Then recreate the secret with your own certificates:

```bash
kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  -n apim
```

Keep the following in mind:

- The secret must be created in the **same namespace** as the deployment (e.g. `apim`).
- Use the **same secret name** in both the `kubectl` command above and in your values files.
- If you are using different keystore filenames or aliases, update the helm chart configurations accordingly.
- You can also include keystores for HTTPS transport.

For more details on configuring keystores, see [Configuring Keystores in WSO2 API Manager](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/).

#### 3.2 Encrypt Secrets

By default, database passwords and other sensitive values are stored as plain text in the values files. This is acceptable for local testing but a security risk in production.

**Option 1: Cipher Tool**

Use the cipher tool from the product pack to encrypt secrets:

```bash
sh ciphertool.sh -Dconfigure -Dsymmetric -Dkey.based.encryption
```

**Option 2: apictl**

You can also use `apictl` to encrypt secrets. For further guidance, refer to [Encrypting Secrets with apictl](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/api-controller/encrypting-secrets-with-ctl/).

1. Initialize `apictl` using the trust store:

    ```bash
    apictl secret init
    ```

    Example:

    ```
    apictl secret init
    Enter Key Store location: /home/wso2carbon/wso2am-acp-4.7.0/repository/resources/security/wso2carbon.jks
    Enter Key Store password: 
    Enter Key alias: wso2carbon
    Enter Key password: 

    Key Store initialization completed
    ```

2. Encrypt each of the following values using `apictl secret create`:

    - `admin_password`
    - `keystore_password`
    - `keystore_key_password`
    - `ssl_keystore_password`
    - `ssl_key_password`
    - `internal_keystore_password`
    - `internal_keystore_key_password`
    - `truststore_password`
    - `apim_db_password`
    - `shared_db_password`

    Example:

    ```
    apictl secret create
    Enter plain alias for secret: db_password
    Enter plain text secret: 
    Repeat plain text secret: 

    db_password : eKALmLVA+HFVl7vxxxxxxxxxxxxxxxxxxxxxxxxxxxjakhHN
    ```

3. Replace the plain text values in your values files with the encrypted values.

4. Enable secure vault:

    ```yaml
    # -- Secure vault enabled
    secureVaultEnabled: true
    ```

5. If you are using a cloud provider secret manager, store the secret encryption key there and reference it so the runtime can fetch and use it to decrypt secrets:

    ```yaml
    aws:
      secretsManager:
        secretIdentifiers:
          secretEncryptionKey:
            # -- Secret name in the cloud provider's secret manager
            secretName: ""
            # -- Secret key in the cloud provider's secret manager
            secretKey: ""
    ```

    !!! note
        Currently, AWS, Azure, and GCP Secrets Managers are supported.

#### 3.3 Configure SSL

For WSO2 recommended SSL best practices when exposing services outside the cluster, refer to the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

#### 3.4 Configure JWKS URL

!!! note "Important for Pattern 3 deployments"
    In Pattern 3, the Gateway and Traffic Manager are on separate pods from the ACP. Use the ACP Kubernetes service name for the JWKS URL so all components can resolve it via cluster DNS:

```yaml
wso2:
  apim:
    configurations:
      oauth_config:
        oauth2JWKSUrl: "https://<ACP_SERVICE_NAME>:9443/oauth2/jwks"
```

### 4. Routing Controller { #4-routing-controller }

#### 4.1 Configure Envoy Gateway (Default in 4.7.x)

Envoy Gateway is the default routing controller in WSO2 API Manager 4.7.0. It uses the Kubernetes Gateway API, which provides more flexibility than traditional Ingress resources.

**Step 1: Create a TLS secret**

```bash
kubectl create secret tls apim-tls-secret \
  --key <private-key-file> \
  --cert <certificate-file> \
  -n apim
```

**Step 2: Install Envoy Gateway** (if not already done in Step 4 of the Quick Start)

```bash
helm install envoy-gateway oci://docker.io/envoyproxy/gateway-helm \
  --version v1.7.0 -n envoy-gateway-system \
  --set config.envoyGateway.extensionApis.enableBackend=true \
  --set envoyGateway.gateway.experimentalFeatures.enabled=true \
  --create-namespace
```

**Step 3: Apply the Gateway manifest**

```bash
kubectl apply \
  -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/resources/assets/sample-gateway.yaml \
  -n apim
```

**Step 4: (Optional) Create a CA ConfigMap for backend TLS**

If you want Envoy Gateway to verify backend TLS certificates, create a ConfigMap with your CA certificate:

```bash
kubectl create configmap wso2-ca-cert \
  --from-file=ca.crt=<path-to-ca-cert> \
  -n apim
```

**Step 5: Configure Envoy Gateway in `values.yaml`**

```yaml
kubernetes:
  gatewayAPI:
    enabled: true
    gatewayName: "wso2-apim-gateway"
    defaultConfigMapCreation: false
    management:
      enabled: true
      hostname: "am.wso2.com"
    gateway:
      enabled: true
      hostname: "gw.wso2.com"
    websocket:
      enabled: true
      hostname: "websocket.wso2.com"
    websub:
      enabled: true
      hostname: "websub.wso2.com"
    backendTLSPolicy:
      enabled: true
      caCertificateConfigMap: "wso2-ca-cert"
      hostname: "<hostname used in the TLS certificate>"
    backendTrafficPolicy:
      enabled: true
      cookie:
        name: "WSO2_CP_STICKY_SESSION"
        ttl: "0s"
```

#### 4.2 Configure NGINX Ingress Controller

Use this section if you are using NGINX Ingress Controller instead of Envoy Gateway.

**Configure ingress annotations**

You may need to customise these if you want to enable sticky sessions, change the backend protocol, or apply rate limiting.

```yaml
ingressClass: "nginx"
ingress:
  tlsSecret: ""
  ratelimit:
    enabled: false
    zoneName: ""
    burstLimit: ""
  controlPlane:
    hostname: "am.wso2.com"
    annotations:
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
      nginx.ingress.kubernetes.io/affinity: "cookie"
      nginx.ingress.kubernetes.io/session-cookie-name: "route"
      nginx.ingress.kubernetes.io/session-cookie-hash: "sha1"
```

Refer to the [NGINX ingress annotations documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) for the full list of supported options.

**Configure TLS for Ingress**

```bash
kubectl create secret tls my-tls-secret \
  --key <private-key-file> \
  --cert <certificate-file> \
  -n apim
```

Then set the secret name in your `values.yaml` under `ingress.tlsSecret`. Refer to the [Kubernetes ingress TLS documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) for more details.

### 5. Gateway, Traffic Manager, and High Availability

#### 5.1 Configure Key Manager, EventHub, and Throttling

The Gateway connects to the ACP for token validation and event subscriptions, and to the Traffic Manager for throttling. When components run in HA mode (two pods each), provide the individual pod service names in the EventHub and throttling URLs:

=== "Single ACP and TM"

    ```yaml
    km:
      serviceUrl: "<ACP_SERVICE_NAME>"

    eventhub:
      serviceUrl: "<ACP_SERVICE_NAME>"
      urls:
        - "<ACP_SERVICE_NAME>"

    throttling:
      serviceUrl: "<TM_SERVICE_NAME>"
      servicePort: 9443
      urls:
        - "<TM_SERVICE_NAME>"
      unlimitedTier: true
      headerBasedThrottling: false
      jwtClaimBasedThrottling: false
      queryParamBasedThrottling: false
    ```

=== "ACP and TM with High Availability"

    ```yaml
    km:
      serviceUrl: "<ACP_SERVICE_NAME>"

    eventhub:
      serviceUrl: "<ACP_SERVICE_NAME>"
      urls:
        - "<ACP_POD_1_SERVICE_NAME>"
        - "<ACP_POD_2_SERVICE_NAME>"

    throttling:
      serviceUrl: "<TM_SERVICE_NAME>"
      servicePort: 9443
      urls:
        - "<TM_POD_1_SERVICE_NAME>"
        - "<TM_POD_2_SERVICE_NAME>"
      unlimitedTier: true
      headerBasedThrottling: false
      jwtClaimBasedThrottling: false
      queryParamBasedThrottling: false
    ```

#### 5.2 Configure Gateway Replicas

The Classic Gateway supports horizontal scaling. Configure the number of replicas in `values-gw.yaml`:

```yaml
wso2:
  deployment:
    replicas: 2
    minReplicas: 1
    maxReplicas: 3
```

#### 5.3 Configure Multiple Gateways

Use this section if you need to register multiple gateway environments — for example, to route traffic to different gateways based on API type, or to serve traffic through geographically distributed gateways.

```yaml
gateway:
  environments:
    - name: "Default"
      type: "hybrid"
      gatewayType: "Regular"
      provider: "wso2"
      displayInApiConsole: true
      description: "Handles both production and sandbox token traffic."
      showAsTokenEndpointUrl: true
      serviceName: "apim-gw-wso2am-gateway-service"
      servicePort: 9443
      wsHostname: "websocket.wso2.com"
      httpHostname: "gw.wso2.com"
      websubHostname: "websub.wso2.com"
    - name: "Default_apk"
      type: "hybrid"
      gatewayType: "APK"
      provider: "wso2"
      displayInApiConsole: true
      description: "Handles both production and sandbox token traffic."
      showAsTokenEndpointUrl: true
      serviceName: "apim-gw-wso2am-gateway-service"
      servicePort: 9443
      wsHostname: "websocket.wso2.com"
      httpHostname: "default.gw.wso2.com:9095"
      websubHostname: "websub.wso2.com"
```

See [Deploy through multiple API Gateways](https://apim.docs.wso2.com/en/latest/manage-apis/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-through-multiple-api-gateways/) for more details.

#### 5.4 Configure User Store Properties

By default, WSO2 API-M uses a JDBC-based user store. Configure this section if you need to connect to an external user store such as LDAP or Active Directory.

```yaml
userStore:
  type: "database_unique_id"
  properties:
    ReadGroups: true
```

!!! warning
    If you do not need to set any custom properties, remove the `properties` block entirely. An empty `properties` block will cause the deployment to fail.

See [Working with user store properties](https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/working-with-properties-of-user-stores/) for the full list of options.

### 6. Deploy with Custom Values { #section-6 }

Once your values files are configured, deploy all three components with:

```bash
helm install apim-acp wso2/wso2am-acp \
  --version 4.7.0-1 \
  --namespace apim --create-namespace \
  --dependency-update \
  -f values-acp.yaml \
  --set wso2.apim.configurations.encryption.key=$(openssl rand -hex 32)

helm install apim-tm wso2/wso2am-tm \
  --version 4.7.0-1 \
  --namespace apim \
  --dependency-update \
  -f values-tm.yaml

helm install apim-gw wso2/wso2am-universal-gw \
  --version 4.7.0-1 \
  --namespace apim \
  --dependency-update \
  -f values-gw.yaml
```

!!! tip "Deployment Parameters"
    - `<release-name>` — Name for each Helm release (e.g. `apim-acp`, `apim-tm`, `apim-gw`)
    - `<namespace>` — Kubernetes namespace to deploy into (e.g. `apim`)
    - Helm chart paths: `wso2/wso2am-acp`, `wso2/wso2am-tm`, `wso2/wso2am-universal-gw` (or local clones)
