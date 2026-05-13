# Pattern 6: All-in-One with WSO2 IS as Key Manager

This pattern deploys WSO2 API Manager as a single All-in-One node with WSO2 Identity Server 7.x acting as a third-party Key Manager. Token issuance and validation are delegated to WSO2 IS, which runs as a separate component in the same Kubernetes cluster.

## How Pattern 6 Differs from Earlier Patterns

| | Pattern 1 | Pattern 5 | Pattern 6 |
|---|---|---|---|
| Control Plane | Embedded in All-in-One | Embedded in All-in-One | Embedded in All-in-One |
| Gateway | Embedded | Dedicated, independently scalable | Embedded |
| Key Manager | Embedded in All-in-One | Dedicated KM (WSO2 APIM KM) | WSO2 Identity Server 7.x |
| Custom images | Required (All-in-One) | Required (All-in-One + Gateway + ACP); KM uses ACP image | Required (IS only) |
| High availability | Yes (2 pods) | Gateway: Yes; KM: Yes; AIO: Optional | Optional |

!!! note
    WSO2 IS 7.x in this pattern acts as a **third-party Key Manager** only. The following limitations apply:

    - Tenancy is not supported.
    - WSO2 IS 7.x cannot be configured as the Resident Key Manager — only as a third-party Key Manager.
    - Role creation in WSO2 IS 7.x requires WSO2 API Manager 4.4.0.5 update level or later.

!!! warning "Pattern 6 requires the following before deploying:"

    1. **One custom Docker image** — for WSO2 Identity Server, with the APIM notification event handler JAR included.

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

Install the NGINX Ingress Controller into your cluster:

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

Verify the controller is running:

```bash
kubectl get pods -n ingress-nginx
```

The NGINX pod should show `1/1 Running` before proceeding.

### Step 5 — Build and Push the WSO2 Identity Server Image

WSO2 IS 7.x needs a custom image that includes the APIM notification event handler JAR. This JAR enables IS to notify APIM when tokens are revoked.

!!! note "Choosing a base image"
    - **DockerHub** (`wso2/wso2is:7.2.0`) — packages the GA release. Suitable for evaluation and development.
    - **WSO2 Private Registry** (`docker.wso2.com/wso2is:7.2.0.0`) — includes WSO2 Updates and is recommended for production. Requires an active [WSO2 Subscription](https://wso2.com/subscription).

1. Create a `Dockerfile.is`:

    ```dockerfile
    FROM wso2/wso2is:7.2.0

    ADD --chown=wso2carbon:wso2 \
      https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/km/ext/wso2is/wso2is.notification.event.handlers/2.1.3/wso2is.notification.event.handlers-2.1.3.jar \
      /home/wso2carbon/wso2is-7.2.0/repository/components/dropins/
    ```

2. Build and push the IS image:

    ```bash
    docker buildx build --platform linux/amd64 -f Dockerfile.is -t <REGISTRY>/wso2is-km:<TAG> .
    docker push <REGISTRY>/wso2is-km:<TAG>
    ```

3. Get the IS image digest — you will need it when configuring the values file:

    ```bash
    docker inspect <REGISTRY>/wso2is-km:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'
    ```

### Step 6 — Extract the APIM Keystores { #step-6 }

In Pattern 6, APIM must trust the IS self-signed certificate. This step extracts the default APIM keystores to your local machine so you can import the IS certificate into the truststore in [Step 8](#step-8). The Kubernetes secret is created at that point, after the IS certificate has been added.

1. Create the `wso2` namespace:

    ```bash
    kubectl create namespace wso2
    ```

2. Extract the default keystores from the APIM image:

    ```bash
    mkdir -p keystores

    docker run --rm -v "$(pwd)/keystores:/keystores" --entrypoint bash wso2/wso2am:4.6.0 -c \
      "cp /home/wso2carbon/wso2am-4.6.0/repository/resources/security/wso2carbon.jks \
          /home/wso2carbon/wso2am-4.6.0/repository/resources/security/client-truststore.jks \
          /keystores/"
    ```

!!! note
    The commands above use the default WSO2 keystores which are suitable for evaluation only. For production-level keystore setup, refer to [Configuring Keystores in WSO2 API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/). You must also exchange the public certificates of APIM and IS and import them into each other's truststore — see [Importing certificates to the truststore](https://apim.docs.wso2.com/en/4.6.0/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore).

### Step 7 — Deploy WSO2 Identity Server { #step-7 }

1. Download the default IS values file:

    ```bash
    helm show values wso2/identity-server > values-is.yaml
    ```

2. Open `values-is.yaml` and update the following sections before deploying.

    **Custom image** — point to the IS image you built in Step 5:

    ```yaml
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

    !!! warning
        The IS Helm chart's base `deployment.toml` already defines `[oauth.token_cleanup]` and `[oauth.token_generation]`. Re-declaring `[oauth]` as a section header in `extraConfigs` will cause a TOML parser crash (StackOverflowError) at startup. Use the dotted key form `oauth.authorize_all_scopes = true` instead.

    !!! note
        The `notification_endpoint` must point to the APIM pod's internal Kubernetes service name, not the ingress hostname. The IS pod communicates directly with the APIM pod via cluster DNS.

3. Deploy WSO2 Identity Server:

    ```bash
    helm install is wso2/identity-server \
      --namespace wso2 --create-namespace \
      -f values-is.yaml
    ```

4. Wait for the IS pod to be ready:

    ```bash
    kubectl get pods -n wso2 -w
    ```

    The IS pod should show `1/1 Running` before deploying APIM.

### Step 8 — Import IS Certificate and Create Keystore Secret { #step-8 }

APIM must trust the IS self-signed certificate to communicate with IS during Key Manager registration. This step imports the IS certificate into the APIM truststore and creates the `apim-keystore-secret` Kubernetes secret with the final truststore content.

For background, refer to [Importing the Identity Server certificate to WSO2 API Manager]({{base_path}}/install-and-setup/setup/sso/configuring-identity-server-as-external-idp-using-oidc/#step-1-import-the-identity-server-certificate-to-wso2-api-manager).

1. Port-forward the IS service to your local machine and extract the IS public certificate.

    Start the port-forward in the background:

    ```bash
    kubectl port-forward -n wso2 svc/is-identity-server 9444:9443 &
    ```

    Wait until you see the `Forwarding from 127.0.0.1:9444 -> 9443` message before proceeding. Then extract the certificate:

    ```bash
    openssl s_client -connect localhost:9444 -servername wso2is.com < /dev/null 2>/dev/null | openssl x509 > is-cert.pem
    ```

    Then stop the port-forward:

    ```bash
    kill %1
    ```

    !!! warning
        Run these as **separate commands**, not in a single block. If you run the port-forward and `openssl` together, `openssl` starts before the port-forward is ready and the certificate extraction fails with `Could not find certificate from <stdin>`.

    Verify the certificate was captured:

    ```bash
    cat is-cert.pem
    ```

    The output should start with `-----BEGIN CERTIFICATE-----`.

2. Import the IS certificate into the APIM truststore you extracted in [Step 6](#step-6):

    ```bash
    keytool -importcert -trustcacerts -alias wso2is -file is-cert.pem -keystore keystores/client-truststore.jks -storepass wso2carbon -noprompt
    ```

3. Create the `apim-keystore-secret` Kubernetes secret with the updated truststore:

    ```bash
    kubectl create secret generic apim-keystore-secret \
      --from-file=wso2carbon.jks=keystores/wso2carbon.jks \
      --from-file=client-truststore.jks=keystores/client-truststore.jks \
      -n wso2
    ```

4. Create a `values-apim.yaml` file to configure APIM to mount the keystore secret:

    ```yaml
    wso2:
      apim:
        configurations:
          security:
            jksSecretName: "apim-keystore-secret"
            truststore:
              password: "wso2carbon"
    ```

    !!! note
        Without setting `jksSecretName`, APIM uses its embedded default keystores and ignores the `apim-keystore-secret` entirely. This value tells the Helm chart to mount the secret into the APIM pod at startup.

### Step 9 — Deploy WSO2 API Manager { #step-9 }

1. Deploy WSO2 API Manager using the default values file and the `values-apim.yaml` you created in [Step 8](#step-8):

    ```bash
    helm install apim wso2/wso2am-all-in-one \
      --version 4.6.0-1 \
      --namespace wso2 \
      -f https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-0-all-in-one/default_values.yaml \
      -f values-apim.yaml
    ```

2. Wait for the APIM pod to be ready:

    ```bash
    kubectl get pods -n wso2 -w
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

    2. Get the external IP assigned to the ingress:

        ```bash
        kubectl get ing -n wso2
        ```

        The ADDRESS column should now show `127.0.0.1`.

    3. Add the following entry to your `/etc/hosts` file:

        ```
        127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com wso2is.com
        ```

=== "Rancher Desktop"

    1. Get the external IP assigned to the ingress:

        ```bash
        kubectl get ing -n wso2
        ```

    2. Add the following entry to your `/etc/hosts` file, replacing `<EXTERNAL-IP>` with the value from the output above:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com wso2is.com
        ```

=== "Managed cluster (AKS / GKE)"

    1. Get the external IP assigned to the ingress:

        ```bash
        kubectl get ing -n wso2
        ```

    2. For quick testing, add the `ADDRESS` value to your `/etc/hosts`:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com wso2is.com
        ```

        For a production setup, create DNS records in your DNS provider mapping these hostnames to the external IP.

!!! note
    `wso2is.com` is the default IS ingress hostname. If you changed it in `values-is.yaml`, use that hostname here instead.

### Step 11 — Register IS as Key Manager { #step-11 }

Once both APIM and IS are running, register IS as a Key Manager through the APIM Admin Portal.

1. Open the Admin Portal at `https://am.wso2.com/admin` and log in with **admin / admin**.

2. Navigate to **Key Managers** and click **Add Key Manager**.

3. Configure the Key Manager with the following settings.

    !!! important "Use the Kubernetes service name, not the ingress hostname"
        APIM calls these endpoints from **inside the cluster**, so they must use the IS Kubernetes service name (`is-identity-server`) rather than the ingress hostname (`wso2is.com`). The ingress hostname is only resolvable on your local machine via `/etc/hosts` — it is not visible to pods inside the cluster.

        If you deployed IS with release name `is`, the service name is `is-identity-server`. Adjust if you used a different release name.

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
    | Display Token Endpoint | `https://wso2is.com:9443/oauth2/token` |
    | Revoke Endpoint | `https://is-identity-server:9443/oauth2/revoke` |
    | Display Revoke Endpoint | `https://wso2is.com:9443/oauth2/revoke` |
    | UserInfo Endpoint | `https://is-identity-server:9443/scim2/Me` |
    | Authorize Endpoint | `https://wso2is.com:9443/oauth2/authorize` |
    | Scope Management Endpoint | `https://is-identity-server:9443/api/identity/oauth2/v1.0/scopes` |
    | Certificate Type | JWKS |
    | JWKS URL | `https://is-identity-server:9443/oauth2/jwks` |
    | Username (connector config) | admin |
    | Password (connector config) | admin |
    | WSO2 IS 7 API Resource Management Endpoint | `https://is-identity-server:9443/api/server/v1/api-resources` |
    | WSO2 IS 7 Roles Endpoint | `https://is-identity-server:9443/scim2/v2/Roles` |
    | Create roles in WSO2 Identity Server 7 | Enable if needed |

4. Click **Add** to save.

### Step 12 — Access the Portals

Once DNS is configured, open the following URLs in your browser.

| Portal | URL |
| ------ | --- |
| Publisher | `https://am.wso2.com/publisher` |
| Developer Portal | `https://am.wso2.com/devportal` |
| Admin Portal | `https://am.wso2.com/admin` |
| Carbon Console | `https://am.wso2.com/carbon` |
| IS Management Console | `https://wso2is.com/console` |

!!! note "Chrome may block access"
    Chrome enforces HSTS preloading for `*.wso2.com` domains, which removes the option to bypass the self-signed certificate warning entirely. Use Firefox or Safari instead, and click through the certificate warning when prompted.

Replace the hostname placeholders with the actual values from your values files. Default credentials: **admin / admin**


---

## Additional Configuration

All configurations in this section are made by editing your `values-apim.yaml` or `values-is.yaml` files.

The Helm charts for WSO2 API Manager are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.6.x). For WSO2 Identity Server, refer to the [WSO2 IS Kubernetes deployment documentation](https://is.docs.wso2.com/en/7.0.0/deploy/deploy-is-on-kubernetes/).

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

In [Step 8](#step-8), you created `apim-keystore-secret` containing the default APIM keystores with the IS certificate imported into the truststore. Those are self-signed certificates suitable for evaluation only.

For production-level keystore setup, refer to [Configuring Keystores in WSO2 API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/). Then recreate the secret with your own certificates:

```bash
kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  -n wso2
```

For mutual certificate trust between APIM and IS, import each product's public certificate into the other's truststore. Refer to the [Importing certificates to the truststore](https://apim.docs.wso2.com/en/4.6.0/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) guide.

For more details on configuring keystores, see [Configuring Keystores in WSO2 API Manager](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/).

#### 3.2 Encrypt Secrets

By default, database passwords and other sensitive values are stored as plain text in the values files. This is acceptable for local testing but a security risk in production. Use `apictl` to encrypt these values before deploying.

1. Initialize `apictl` using the trust store:

    ```bash
    apictl secret init
    ```

    Example:

    ```
    apictl secret init
    Enter Key Store location: /home/wso2carbon/wso2am-4.6.0/repository/resources/security/wso2carbon.jks
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

5. If you are using a cloud provider secret manager, enable it and reference the internal keystore password:

    ```yaml
    aws:
      # -- If AWS is used as the cloud provider
      enabled: true

    internalKeystorePassword:
      # -- Secret name in the cloud provider's secret manager
      secretName: ""
      # -- Secret key in the cloud provider's secret manager
      secretKey: ""
    ```

    !!! note
        Currently, AWS, Azure, and GCP Secrets Managers are supported.

#### 3.3 Configure SSL

For WSO2 recommended SSL best practices when exposing services outside the cluster, refer to the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

### 4. Routing Controller { #4-routing-controller }

#### 4.1 Configure NGINX Ingress Controller

**Configure Ingress Annotations**

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
  -n wso2
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
  --namespace wso2 --create-namespace \
  -f values-is.yaml

helm install apim wso2/wso2am-all-in-one \
  --version 4.6.0-1 \
  --namespace wso2 \
  -f values-apim.yaml
```

!!! tip "Deployment Parameters"
    - Release names: `is`, `apim`
    - `<namespace>` — Kubernetes namespace to deploy into (e.g. `wso2`)
    - Helm chart paths: `wso2/identity-server`, `wso2/wso2am-all-in-one` (or local clones)
