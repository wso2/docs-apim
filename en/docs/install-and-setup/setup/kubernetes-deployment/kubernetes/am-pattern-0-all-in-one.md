# Pattern 0: All-in-One Setup

This pattern deploys all WSO2 API Manager components — Control Plane, Gateway, Traffic Manager, and Key Manager — in a single node. It is suitable for development, testing, and evaluation environments where high availability is not required.

<a href="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png" alt="single-node api-m deployment" width="60%"></a>

---

## Quick Start

This section gets WSO2 API Manager running on Kubernetes with default settings. No custom database or image configuration is needed — ideal for local evaluation.

### Step 1 — Install Required Tools

1. Ensure the following tools are installed on your machine:

    | Tool | Purpose | Install Guide |
    | ---- | ------- | ------------- |
    | `kubectl` | Kubernetes CLI for managing cluster resources | [Install](https://kubernetes.io/docs/tasks/tools/) |
    | `helm` (v3) | Package manager for deploying WSO2 Helm charts | [Install](https://helm.sh/docs/intro/install/) |

2. Verify all tools are installed and check their versions:

    ```bash
    kubectl version --client
    helm version
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

### Step 5 — Deploy WSO2 API Manager

1. Deploy using the default values, which include an embedded H2 database and default keystores:

    ```bash
    helm install apim wso2/wso2am-all-in-one \
      --version 4.6.0-1 \
      --namespace wso2 --create-namespace \
      -f https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-0-all-in-one/default_values.yaml
    ```

2. Wait for the pod to be ready:

    ```bash
    kubectl get pods -n wso2 -w
    ```

    The API Manager pod should show `1/1 Running` before proceeding.

    !!! info "Default Configuration"
        The default deployment uses:

        - Embedded H2 database (not suitable for production)
        - Default WSO2 keystores and truststores
        - Hostname: `am.wso2.com`

### Step 6 — Configure Local DNS

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
        127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

=== "Rancher Desktop"

    1. Get the external IP assigned to the ingress:

        ```bash
        kubectl get ing -n wso2
        ```

    2. Add the following entry to your `/etc/hosts` file, replacing `<EXTERNAL-IP>` with the value from the output above:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

=== "Managed cluster (AKS / GKE)"

    1. Get the external IP assigned to the ingress:

        ```bash
        kubectl get ing -n wso2
        ```

    2. For quick testing, add the `ADDRESS` value to your `/etc/hosts`:

        ```
        <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
        ```

        For a production setup, create a DNS record in your DNS provider (e.g. Route 53, Azure DNS, Cloud DNS) mapping the hostnames to the external IP instead of using `/etc/hosts`.

!!! note
    These are the default hostnames. If you customised `ingress.controlPlane.hostname`, `ingress.gateway.hostname`, `ingress.websocket.hostname`, or `ingress.websub.hostname` in your `values.yaml`, use those values here instead.

### Step 7 — Access the Portals

Once DNS is configured, open the following URLs in your browser.

| Portal | URL |
| ------ | --- |
| Publisher | `https://<kubernetes.ingress.management.hostname>/publisher` |
| Developer Portal | `https://<kubernetes.ingress.management.hostname>/devportal` |
| Carbon Console | `https://<kubernetes.ingress.management.hostname>/carbon` |
| Gateway | `https://<kubernetes.ingress.gateway.hostname>` |

!!! note
    Replace the hostname placeholders with the actual values from your `values.yaml`. Default credentials: **admin / admin**

---

## Additional Configuration

The settings below are for production deployments or scenarios where you need to go beyond the defaults. All configurations in this section are made by editing your `values.yaml` file — the Helm chart's configuration file. Once all changes are in place, deploy using the command in [Section 6](#section-6).

The Helm charts for WSO2 API Manager are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.6.x). You can use the charts directly from the repository or clone it and use a local copy.

!!! note "Resource Naming Convention"
    Kubernetes resources created by the Helm charts follow this naming pattern:
    ```
    <RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>
    ```

### 1. Image and Registry

#### 1.1 Configure Docker Image and Registry { #section-1-1 }

By default, the Helm chart pulls the official WSO2 Docker image. Configure this section if you need to use a custom image — for example, if you have built an image with additional JARs, configurations, or security patches — or if your image is hosted in a private registry that requires authentication.

```yaml
wso2:
  deployment:
    image:
      registry: ""        # e.g. docker.io/myorg
      repository: ""      # e.g. wso2am
      digest: ""
      imagePullSecrets:
        enabled: false
        username: ""
        password: ""
```

> Enable `imagePullSecrets` if your registry is private.

### 2. Database and Credentials

#### 2.1 Configure Databases

The quick start uses an embedded H2 database which is not persistent and will lose data when the pod restarts. For any environment beyond local testing, configure an external database (MySQL, PostgreSQL, Oracle, or MSSQL) to ensure data persistence and reliability.

!!! warning "JDBC Driver Required"
    The default WSO2 Docker image does not include third-party JDBC drivers. Before configuring an external database, you must rebuild the Docker image with the appropriate JDBC driver for your database (e.g. `mysql-connector-java.jar` for MySQL, `postgresql.jar` for PostgreSQL). See [section 1.1](#section-1-1) for how to configure a custom image.

```yaml
wso2:
  apim:
    configurations:
      databases:
        apim_db:
          url: ""         # JDBC URL for the APIM database
          username: ""
          password: ""
        shared_db:
          url: ""         # JDBC URL for the shared database
          username: ""
          password: ""
```

#### 2.2 Configure Admin Credentials

The default admin credentials are `admin/admin`. Change these before deploying to any shared or production environment to prevent unauthorised access.

```yaml
wso2:
  apim:
    configurations:
      adminUsername: ""
      adminPassword: ""
```

#### 2.3 Update Keystore Passwords

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

#### 2.4 Component Configuration References

All available configuration options for each Helm chart are documented in their respective component guides:

- [All-in-One Helm chart](https://github.com/wso2/helm-apim/blob/main/all-in-one/README.md)
- [Universal Gateway Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/gateway/README.md)

### 3. Security

#### 3.1 Mount Keystore and Truststore { #section-3-1 }

The default WSO2 keystores use a self-signed certificate which is fine for evaluation but not for production. Use this section to mount your own organisation-issued or CA-signed certificates so that clients can establish trusted SSL connections to your API Manager deployment. The secret must include the primary keystore, internal keystore, and truststore. You can also include keystores for HTTPS transport.

```bash
kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  --from-file=wso2internal.jks \
  -n wso2
```

Keep the following in mind:

- The secret must be created in the **same namespace** as the deployment (e.g. `wso2`).
- Use the **same secret name** in both the `kubectl` command above and in your `values.yaml`.
- If you are using different keystore filenames or aliases, update the helm chart configurations accordingly.

Then reference the secret name in your `values.yaml`. For more details on configuring keystores, see [Configuring Keystores in WSO2 API Manager](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/).

#### 3.2 Encrypt Secrets

By default, database passwords and other sensitive values are stored as plain text in `values.yaml`. This is acceptable for local testing but a security risk in production. Use `apictl` to encrypt these values before deploying. For further guidance, refer to [Encrypting Secrets with apictl](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/api-controller/encrypting-secrets-with-ctl/).

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

3. Replace the plain text values in your `values.yaml` with the encrypted values.

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

WSO2 API Manager exposes multiple services (Publisher, DevPortal, Gateway) over HTTPS. Proper SSL configuration ensures that traffic between clients and the cluster is encrypted and that certificates are trusted. For WSO2 recommended best practices, refer to the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

#### 3.4 Configure JWKS URL

!!! note "Important for local deployments"
    By default, the JWKS URL is set to `https://am.wso2.com:9443/oauth2/jwks`. If `am.wso2.com` is not globally routable (e.g., local `/etc/hosts` setup), token verification will fail. Override the URL to use `localhost` or the actual routable hostname:

```yaml
wso2:
  apim:
    configurations:
      oauth_config:
        oauth2JWKSUrl: "https://localhost:9443/oauth2/jwks"
```

### 4. Routing Controller { #4-routing-controller }

#### 4.1 Configure NGINX Ingress Controller

**Configure Ingress Annotations**

By default, the Helm chart applies a basic set of NGINX ingress annotations. You may need to customise these if you want to enable sticky sessions (required for HA setups), change the backend protocol, or apply rate limiting.

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

### 5. Gateway and User Management

#### 5.1 Configure Multiple Gateways

By default, a single gateway environment is configured. Use this section if you need to register multiple gateway environments — for example, to route traffic to different gateways based on the API type (Regular vs APK), or to publish APIs to a single Developer Portal while serving traffic through geographically distributed gateways.

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

#### 5.2 Configure User Store Properties

By default, WSO2 API-M uses a JDBC-based user store. Configure this section if you need to connect to an external user store such as LDAP or Active Directory, or if you need to customise how users and groups are read and managed.

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

Once your `values.yaml` is configured, deploy with:

```bash
helm install <release-name> <helm-chart-path> \
  --version 4.6.0-1 \
  --namespace <namespace> --create-namespace \
  --dependency-update \
  -f values.yaml
```

!!! tip "Deployment Parameters"
    - `<release-name>` — Name for your Helm release (e.g. `apim`)
    - `<namespace>` — Kubernetes namespace to deploy into (e.g. `wso2`)
    - `<helm-chart-path>` — Path to the Helm chart, either the repository chart (`wso2/wso2am-all-in-one`) or a local clone (e.g. `./all-in-one`)
