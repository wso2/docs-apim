# Pattern 6: All-in-One with WSO2 IS as Key Manager

This pattern deploys WSO2 API Manager as a single All-in-One node with WSO2 Identity Server 7.x acting as a third-party Key Manager. Token issuance and validation are delegated to WSO2 IS, which runs as a separate component in the same Kubernetes cluster.

## How Pattern 6 Differs from Earlier Patterns

| | Pattern 1 | Pattern 5 | Pattern 6 |
|---|---|---|---|
| Control Plane | Embedded in All-in-One | Embedded in All-in-One | Embedded in All-in-One |
| Gateway | Embedded | Dedicated, independently scalable | Embedded |
| Key Manager | Embedded in All-in-One | Dedicated KM (WSO2 APIM KM) | WSO2 Identity Server 7.x |
| Custom images | Required (All-in-One) | Required (All-in-One); KM reuses ACP image | Required (APIM + IS) |
| High availability | Yes (2 pods) | Gateway: Yes; KM: Yes; AIO: Optional | Optional |

!!! note
    WSO2 IS 7.x in this pattern acts as a **third-party Key Manager** only. The following limitations apply:

    - Tenancy is not supported.
    - WSO2 IS 7.x cannot be configured as the Resident Key Manager — only as a third-party Key Manager.
    - Role creation in WSO2 IS 7.x requires WSO2 API Manager 4.4.0.5 update level or later.

!!! warning "Pattern 6 requires the following before deploying:"

    1. **An external database** — H2 is not supported for production. Set up an external database before deploying.
    2. **Two custom Docker images** — one for WSO2 API Manager (with JDBC driver) and one for WSO2 Identity Server (with the APIM notification event handler JAR).
    3. **Database schema initialised** — run the WSO2 schema scripts against both databases before the APIM pods start.

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

Pattern 6 requires two custom Docker images — one for WSO2 API Manager and one for WSO2 Identity Server.

#### 5.1 — Create the WSO2 API Manager Dockerfile

!!! note "Choosing a base image"
    - **DockerHub** (`wso2/wso2am:4.7.0`) — packages the GA release. Suitable for evaluation and development.
    - **WSO2 Private Registry** (`registry.wso2.com/wso2-apim/am:4.7.0.0`) — includes WSO2 Updates and is recommended for production. Requires an active [WSO2 Subscription](https://wso2.com/subscription).

1. Create a directory for the custom images:

    ```bash
    mkdir wso2am-custom && cd wso2am-custom
    ```

2. Create a `Dockerfile.apim` with the MySQL JDBC driver — adjust the URL for other databases:

    ```dockerfile
    FROM wso2/wso2am:4.7.0

    ADD --chown=wso2carbon:wso2 \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
      /home/wso2carbon/wso2am-4.7.0/repository/components/lib/
    ```

#### 5.2 — Create the WSO2 Identity Server Dockerfile

WSO2 IS 7.x needs a custom image that includes the APIM notification event handler JAR. This JAR enables IS to notify APIM when tokens are revoked.

!!! note "Choosing a base image"
    - **DockerHub** (`wso2/wso2is:7.2.0`) — packages the GA release. Suitable for evaluation and development.
    - **WSO2 Private Registry** (`registry.wso2.com/wso2-is/is:7.2.0.0`) — includes WSO2 Updates and is recommended for production. Requires an active [WSO2 Subscription](https://wso2.com/subscription).

1. Create a `Dockerfile.is`:

    ```dockerfile
    FROM wso2/wso2is:7.2.0

    ADD --chown=wso2carbon:wso2 \
      https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/km/ext/wso2is/wso2is.notification.event.handlers/2.1.3/wso2is.notification.event.handlers-2.1.3.jar \
      /home/wso2carbon/wso2is-7.2.0/repository/components/dropins/
    ```

#### 5.3 — Build and Push Both Images

1. Build and push both images, replacing `<REGISTRY>` and `<TAG>` with your values:

    ```bash
    docker buildx build --platform linux/amd64 -f Dockerfile.apim -t <REGISTRY>/wso2am-mysql:<TAG> .
    docker buildx build --platform linux/amd64 -f Dockerfile.is -t <REGISTRY>/wso2is-km:<TAG> .

    docker push <REGISTRY>/wso2am-mysql:<TAG>
    docker push <REGISTRY>/wso2is-km:<TAG>
    ```

    !!! note "Matching your cluster architecture"
        The `--platform` flag ensures the image is built for the architecture your cluster nodes run on. Most managed clusters (AKS, GKE) and Linux servers use `linux/amd64`. If you are building on Apple Silicon (M1/M2/M3/M4) without this flag, the pod will fail to start with `no match for platform in manifest`.

        To check your cluster node architecture:

        ```bash
        kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.architecture}'
        ```

2. Get the image digests — you will need them when configuring values files:

    ```bash
    docker inspect <REGISTRY>/wso2am-mysql:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'

    docker inspect <REGISTRY>/wso2is-km:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'
    ```

### Step 6 — Extract APIM Keystores { #step-6 }

WSO2 IS uses a self-signed certificate for its HTTPS endpoints. APIM calls IS over the Kubernetes service name `is-identity-server:9443`, so APIM must trust that certificate before it starts. Extract the default APIM keystores now so you can import the IS certificate into the truststore after IS is running in [Step 8](#step-8).

1. Extract the default keystores from your APIM image:

    ```bash
    mkdir -p keystores

    docker run --rm -v "$(pwd)/keystores:/keystores" --entrypoint bash <REGISTRY>/wso2am-mysql:<TAG> -c \
      "cp /home/wso2carbon/wso2am-4.7.0/repository/resources/security/wso2carbon.jks \
          /home/wso2carbon/wso2am-4.7.0/repository/resources/security/client-truststore.jks \
          /keystores/"
    ```

    You will import the IS certificate into `client-truststore.jks` and create the Kubernetes secret in [Step 8](#step-8) after IS is deployed.

### Step 7 — Deploy WSO2 Identity Server { #step-7 }

1. Download the default IS values file:

    ```bash
    helm show values wso2/identity-server > values-is.yaml
    ```

2. Open `values-is.yaml` and update the following sections before deploying.

    **Custom image** — point to the IS image you built in Step 5:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "docker.io"
          repository: "<your-username>/wso2is-km"
          tag: "<TAG>"
          digest: "sha256:abcdef..."
    ```

    **APIM notification configuration** — add the following block so IS can notify APIM when tokens are revoked. Replace `<APIM_SERVICE_NAME>` with the Kubernetes service name of the APIM pod (typically `apim-wso2am-all-in-one-service` if you use release name `apim`):

    ```yaml
    deploymentToml:
      extraConfigs: |
        oauth.authorize_all_scopes = true

        [[resource.access_control]]
        context="(.*)/scim2/Me"
        secure=true
        http_method="GET"
        cross_tenant=true

        [[event_listener]]
        id = "token_revocation"
        type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
        name = "org.wso2.is.notification.ApimOauthEventInterceptor"
        order = 1
        [event_listener.properties]
        notification_endpoint = "https://<APIM_SERVICE_NAME>:9443/internal/data/v1/notify"
        username = "${admin.username}"
        password = "${admin.password}"
        'header.X-WSO2-KEY-MANAGER' = "WSO2-IS"
    ```

    !!! warning "Use dotted key form for the oauth setting"
        The IS Helm chart's base `deployment.toml` already defines `[oauth.token_cleanup]` and `[oauth.token_generation]`. Redeclaring `[oauth]` as a section header in `extraConfigs` causes a TOML parser crash (`StackOverflowError`) at startup. Use `oauth.authorize_all_scopes = true` (dotted key form) instead of a `[oauth]` section block.

    !!! note
        The `notification_endpoint` must use the APIM pod's internal Kubernetes service name, not the ingress hostname — IS communicates with APIM from inside the cluster. With the default release name `apim`, the service name is `apim-wso2am-all-in-one-am-service`. Verify with `kubectl get svc -n apim` after deploying APIM.

3. Deploy WSO2 Identity Server:

    ```bash
    helm install is wso2/identity-server \
      --namespace apim --create-namespace \
      -f values-is.yaml
    ```

4. Wait for the IS pod to be ready:

    ```bash
    kubectl get pods -n apim -w
    ```

    The IS pod should show `1/1 Running` before deploying APIM.

### Step 8 — Import IS Certificate and Create Keystore Secret { #step-8 }

APIM calls IS over HTTPS using the Kubernetes service name `is-identity-server:9443`. Because IS uses a self-signed certificate, APIM fails with a `PKIX path building failed` error unless that certificate is imported into APIM's truststore before APIM starts.

1. Port-forward the IS service to your local machine:

    ```bash
    kubectl port-forward -n apim svc/is-identity-server 9444:9443 &
    ```

    Wait until you see `Forwarding from 127.0.0.1:9444 -> 9443` before running the next command.

2. Extract the IS certificate:

    ```bash
    openssl s_client -connect localhost:9444 -servername wso2is.km < /dev/null 2>/dev/null | openssl x509 > is-cert.pem
    ```

    Then stop the port-forward:

    ```bash
    kill %1
    ```

    !!! warning
        Run the port-forward and `openssl` as **separate commands** — do not chain them together. If you run them in the same line, `openssl` starts before the tunnel is ready and the extraction fails with `Could not find certificate from <stdin>`.

    Verify the certificate was captured — the output should start with `-----BEGIN CERTIFICATE-----`:

    ```bash
    cat is-cert.pem
    ```

3. Import the IS certificate into the APIM truststore you extracted in [Step 6](#step-6):

    ```bash
    keytool -importcert -trustcacerts -alias wso2is -file is-cert.pem \
      -keystore keystores/client-truststore.jks -storepass wso2carbon -noprompt
    ```

4. Create the `apim-keystore-secret` Kubernetes secret with the updated truststore:

    ```bash
    kubectl create secret generic apim-keystore-secret \
      --from-file=wso2carbon.jks=keystores/wso2carbon.jks \
      --from-file=client-truststore.jks=keystores/client-truststore.jks \
      -n apim
    ```

5. Generate the encryption key — you will need it in the next step:

    ```bash
    openssl rand -hex 32
    ```

    !!! warning "Encryption key is mandatory"
        WSO2 API Manager 4.7.0 requires a 256-bit encryption key before first startup. Store this key securely — you will need the same key if you redeploy.

6. Create `values-apim.yaml` with the following content, replacing all placeholder values:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "docker.io"
          repository: "<your-username>/wso2am-mysql"
          tag: "<TAG>"
          digest: "sha256:<digest>"
      apim:
        configurations:
          encryption:
            key: "<generated-64-char-hex-key>"
          security:
            jksSecretName: "apim-keystore-secret"
            truststore:
              password: "wso2carbon"
    ```

    Replace:
    - Image fields with the values from Step 5 (`docker inspect` output)
    - `<generated-64-char-hex-key>` with the `openssl rand -hex 32` output above

    !!! note
        `jksSecretName` tells the Helm chart to mount the keystore secret into the APIM pod. Without this setting, APIM uses its embedded default keystores and ignores `apim-keystore-secret`.

    !!! note "Adding an external database"
        The template above uses the embedded H2 database from the default values file, which is sufficient for evaluation. For production deployments, add a `databases` block to `values-apim.yaml`:

        ```yaml
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

        For JDBC URL formats per database type, see [Setting Up Databases]({{base_path}}/install-and-setup/setup/setting-up-databases/overview/#changing-the-default-databases).

### Step 9 — Deploy WSO2 API Manager { #step-9 }

1. Deploy WSO2 API Manager using the default values file and the `values-apim.yaml` you created in [Step 8](#step-8):

    ```bash
    helm install apim wso2/wso2am-all-in-one \
      --version 4.7.0-1 \
      --namespace apim \
      -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/resources/am-pattern-0-all-in-one/default_values.yaml \
      -f values-apim.yaml \
      --set wso2.apim.configurations.encryption.key=$(openssl rand -hex 32)
    ```

    !!! warning "Encryption key is mandatory"
        WSO2 API Manager 4.7.0 requires a 256-bit encryption key before first startup. The command above generates one automatically. For production or shared environments, generate the key separately, store it securely, and set it explicitly in your `values-apim.yaml` under `wso2.apim.configurations.encryption.key`.

2. Wait for the APIM pod to be ready:

    ```bash
    kubectl get pods -n apim -w
    ```

    The APIM pod should show `1/1 Running` before proceeding.

### Step 10 — Configure DNS { #step-10 }

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
        127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com wso2is.km
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
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com wso2is.km
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
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com wso2is.km
        ```

        For a production setup, create DNS records in your DNS provider mapping these hostnames to the external IP.

!!! note
    These are the default hostnames. If you customised the hostnames in your `values.yaml`, use those values here instead:

    - **Envoy Gateway**: `kubernetes.gatewayAPI.management.hostname`, `kubernetes.gatewayAPI.gateway.hostname`, etc.
    - **NGINX**: `ingress.controlPlane.hostname`, `ingress.gateway.hostname`, etc.
    - `wso2is.km` is the default IS hostname (configure in `values-is.yaml`).

### Step 11 — Register IS as Key Manager { #step-11 }

Once both APIM and IS are running and DNS is configured, register IS as a Key Manager through the APIM Admin Portal.

1. Open the Admin Portal at `https://am.wso2.com/admin` and log in with **admin / admin**.

2. Navigate to **Key Managers** and click **Add Key Manager**.

3. Configure the Key Manager with the following settings:

    | Field | Value |
    |-------|-------|
    | Name | WSO2IS7 |
    | Display Name | WSO2 Identity Server 7 |
    | Key Manager Type | WSO2 Identity Server 7 |
    | Well-known URL | `https://is-identity-server:9443/oauth2/token/.well-known/openid-configuration` |
    | Issuer | `https://is-identity-server:9443/oauth2/token` |
    | Client Registration Endpoint | `https://is-identity-server:9443/api/identity/oauth2/dcr/v1.1/register` |
    | Introspection Endpoint | `https://is-identity-server:9443/oauth2/introspect` |
    | Token Endpoint | `https://is-identity-server:9443/oauth2/token` |
    | Display Token Endpoint | `https://wso2is.km:9443/oauth2/token` |
    | Revoke Endpoint | `https://is-identity-server:9443/oauth2/revoke` |
    | Display Revoke Endpoint | `https://wso2is.km:9443/oauth2/revoke` |
    | UserInfo Endpoint | `https://is-identity-server:9443/scim2/Me` |
    | Authorize Endpoint | `https://wso2is.km:9443/oauth2/authorize` |
    | Scope Management Endpoint | `https://is-identity-server:9443/api/identity/oauth2/v1.0/scopes` |
    | Certificate Type | JWKS |
    | JWKS URL | `https://is-identity-server:9443/oauth2/jwks` |
    | Username (connector config) | admin |
    | Password (connector config) | admin |
    | WSO2 IS 7 API Resource Management Endpoint | `https://is-identity-server:9443/api/server/v1/api-resources` |
    | WSO2 IS 7 Roles Endpoint | `https://is-identity-server:9443/scim2/v2/Roles` |

    !!! warning "Use the Kubernetes service name for operational endpoints"
        Operational endpoints (`Well-known URL`, `Token Endpoint`, `Revoke Endpoint`, etc.) must use `is-identity-server:9443` — the Kubernetes cluster DNS name for the IS service. APIM calls these from inside the cluster and cannot resolve `/etc/hosts` entries that map `wso2is.km` to an external IP.

        Display endpoints (`Display Token Endpoint`, `Display Revoke Endpoint`, `Authorize Endpoint`) use `wso2is.km:9443` because they are opened by end users in a browser, where the external hostname resolves correctly.

4. Click **Add** to save.

### Step 12 — Access the Portals

1. Once DNS is configured, open the following URLs in your browser:

    === "Envoy Gateway (Recommended)"

        | Portal | URL |
        | ------ | --- |
        | Publisher | `https://<kubernetes.gatewayAPI.management.hostname>/publisher` |
        | Developer Portal | `https://<kubernetes.gatewayAPI.management.hostname>/devportal` |
        | Admin Portal | `https://<kubernetes.gatewayAPI.management.hostname>/admin` |
        | Carbon Console | `https://<kubernetes.gatewayAPI.management.hostname>/carbon` |
        | IS Management Console | `https://wso2is.km/console` |

    === "NGINX Ingress Controller (Deprecated)"

        | Portal | URL |
        | ------ | --- |
        | Publisher | `https://<kubernetes.ingress.management.hostname>/publisher` |
        | Developer Portal | `https://<kubernetes.ingress.management.hostname>/devportal` |
        | Admin Portal | `https://<kubernetes.ingress.management.hostname>/admin` |
        | Carbon Console | `https://<kubernetes.ingress.management.hostname>/carbon` |
        | IS Management Console | `https://wso2is.km/console` |

    Replace the hostname placeholders with the actual values from your `values.yaml`. With default values, the management hostname resolves to `am.wso2.com`.

    !!! note "Chrome may block access"
        Chrome enforces HSTS preloading for `*.wso2.com` domains, which removes the option to bypass the self-signed certificate warning entirely. Use Firefox or Safari instead, and click through the certificate warning when prompted.

    Default credentials: **admin / admin**

2. Complete [Step 11](#step-11) — register IS as Key Manager in the Admin Portal — if you have not done so already.

---

## Additional Configuration

All configurations in this section are made by editing your `values-apim.yaml` or `values-is.yaml` files.

The Helm charts for WSO2 API Manager are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.7.x). For WSO2 Identity Server, refer to the [WSO2 IS Kubernetes deployment documentation](https://is.docs.wso2.com/en/7.0.0/deploy/deploy-is-on-kubernetes/).

!!! note "Resource Naming Convention"
    Kubernetes resources created by the Helm charts follow this naming pattern:
    ```
    <RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>
    ```

### 1. Image and Registry

#### 1.1 Private Registry Authentication

If your registry is private and requires authentication, enable `imagePullSecrets` in both values files:

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

The default admin credentials are `admin/admin`. Change these before deploying to any shared or production environment.

```yaml
wso2:
  apim:
    configurations:
      adminUsername: ""
      adminPassword: ""
```

#### 2.2 Update Keystore Passwords

If you are mounting custom keystores (see [section 3.1](#section-3-1)), update the passwords here to match.

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

#### 2.3 Component Configuration References

- [All-in-One Helm chart](https://github.com/wso2/helm-apim/blob/main/all-in-one/README.md)

### 3. Security

#### 3.1 Mount Keystore and Truststore { #section-3-1 }

In [Step 8](#step-8), you created `apim-keystore-secret` using the default WSO2 keystores with the IS certificate imported. Those are self-signed certificates suitable for evaluation only.

For production-level keystore setup, refer to [Configuring Keystores in WSO2 API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/). Then recreate the secret with your own certificates:

```bash
kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  -n apim
```

For mutual certificate trust between APIM and IS, import each product's public certificate into the other's truststore. Refer to the [Importing certificates to the truststore](https://apim.docs.wso2.com/en/4.7.0/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) guide.

For more details on configuring keystores, see [Configuring Keystores in WSO2 API Manager](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/).

#### 3.2 Configure the Internal Encryption Key

!!! warning "Mandatory in 4.7.0"
    The internal encryption key is **required** in WSO2 API Manager 4.7.0. You must set this before the first startup — changing it afterwards will cause decryption failures for any data already encrypted.

1. Generate a unique 256-bit key:

    ```bash
    openssl rand -hex 32
    ```

2. Add the key to your `values-apim.yaml`:

    ```yaml
    wso2:
      apim:
        configurations:
          encryption:
            key: "<generated-64-char-hex-key>"
    ```

    If you encrypt secrets using the cipher tool and secure vault (see [Section 3.3](#33-encrypt-secrets)), also encrypt the internal encryption key and set the encrypted value here instead of the plaintext key.

#### 3.3 Encrypt Secrets

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
    Enter Key Store location: /home/wso2carbon/wso2am-4.7.0/repository/resources/security/wso2carbon.jks
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

#### 3.4 Configure SSL

For WSO2 recommended SSL best practices when exposing services outside the cluster, refer to the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

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

### 5. High Availability

#### 5.1 Enable High Availability for APIM

To run two All-in-One pods in an active-active configuration, set:

```yaml
wso2:
  deployment:
    highAvailability: true
```

#### 5.2 Configure User Store Properties

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

Once your values files are configured, deploy both components:

```bash
helm install is wso2/identity-server \
  --namespace apim --create-namespace \
  -f values-is.yaml

helm install apim wso2/wso2am-all-in-one \
  --version 4.7.0-1 \
  --namespace apim \
  -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/resources/am-pattern-0-all-in-one/default_values.yaml \
  -f values-apim.yaml \
  --set wso2.apim.configurations.encryption.key=$(openssl rand -hex 32)
```

!!! tip "Deployment Parameters"
    - Release names: `is`, `apim`
    - `<namespace>` — Kubernetes namespace to deploy into (e.g. `apim`)
    - Helm chart paths: `wso2/identity-server`, `wso2/wso2am-all-in-one` (or local clones)
