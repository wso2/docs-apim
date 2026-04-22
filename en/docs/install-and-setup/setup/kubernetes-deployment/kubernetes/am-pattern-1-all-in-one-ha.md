# Pattern 1: All-in-One HA Setup

This pattern deploys WSO2 API Manager as a highly available active-active cluster with two nodes, each running all components — Control Plane, Gateway, Traffic Manager, and Key Manager. It is suitable for production environments that require high availability and can handle moderate traffic.

<a href="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png" alt="active-active api-m deployment" width="60%"></a>

## How Pattern 1 Differs from Pattern 0

| | Pattern 0 | Pattern 1 |
|---|---|---|
| Nodes | 1 | 2 (active-active) |
| Database | Embedded H2 | External database required |
| Docker image | Default WSO2 image | Custom image with JDBC driver required |
| High availability | No | Yes |

!!! warning "Complete these before running helm install"
    Pattern 1 requires three things that Pattern 0 does not:

    1. **An external database** — H2 is not supported. Set up an external database (inside Kubernetes or a managed service like RDS) before deploying.
    2. **A custom Docker image** — the default WSO2 image does not include JDBC drivers. Build and push a custom image before deploying.
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

    All nodes should show a `Ready` status. If you don't have a cluster set up yet, refer to [Setting Up a Local Kubernetes Cluster](kubernetes-overview.md#setting-up-a-local-kubernetes-cluster) in the overview.

### Step 3 — Add the WSO2 Helm Repository

1. Add the WSO2 Helm repository and update it:

    ```bash
    helm repo add wso2 https://helm.wso2.com && helm repo update
    ```

### Step 4 — Install the NGINX Ingress Controller

1. Install the NGINX ingress controller into your cluster:

    ```bash
    helm upgrade --install ingress-nginx ingress-nginx \
      --repo https://kubernetes.github.io/ingress-nginx \
      --namespace ingress-nginx --create-namespace
    ```

2. Verify the controller is running:

    ```bash
    kubectl get pods -n ingress-nginx
    ```

    The NGINX pod should show `1/1 Running` before proceeding.

### Step 5 — Build and Push a Custom Docker Image

Pattern 1 requires an external database. The default WSO2 image does not include JDBC drivers, so you must build a custom image with the appropriate driver.

1. Create a directory for the custom image:

    ```bash
    mkdir wso2am-custom && cd wso2am-custom
    ```

2. Create a file named `Dockerfile` with the following content. The example below adds the MySQL JDBC driver — adjust the URL for other databases:

    ```dockerfile
    FROM wso2/wso2am:4.6.0

    ADD --chown=wso2carbon:wso2 \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
      /home/wso2carbon/wso2am-4.6.0/repository/components/lib/
    ```

3. Build the image, replacing `<CONTAINER_REGISTRY>`, `<IMAGE_REPO>`, and `<TAG>` with your values:

    ```bash
    docker build -t <CONTAINER_REGISTRY>/<IMAGE_REPO>:<TAG> .
    ```

    !!! note "Image naming"
        - **Docker Hub**: use your Docker Hub username as the registry — e.g. `myusername/wso2am-mysql:4.6.0`
        - **AWS ECR**: `123456789.dkr.ecr.us-east-1.amazonaws.com/wso2am-mysql:4.6.0`
        - **GCP Artifact Registry**: `us-docker.pkg.dev/myproject/myrepo/wso2am-mysql:4.6.0`
        - **Azure ACR**: `myregistry.azurecr.io/wso2am-mysql:4.6.0`

4. Push the image to your container registry:

    ```bash
    docker push <CONTAINER_REGISTRY>/<IMAGE_REPO>:<TAG>
    ```

5. Get the image digest — you will need it when configuring `values.yaml`:

    ```bash
    docker inspect <CONTAINER_REGISTRY>/<IMAGE_REPO>:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'
    ```

    The digest will look like `docker.io/<your-org>/<image>@sha256:abcdef...`.

!!! note
    The sample above uses the public image from [DockerHub](https://hub.docker.com/r/wso2/wso2am) (`wso2/wso2am:4.6.0`), which is suitable for evaluation. For production, use the image from the [WSO2 Private Docker Registry](https://docker.wso2.com/) (`docker.wso2.com/wso2am:4.6.0.0`) which includes WSO2 Updates — this requires an active [WSO2 Subscription](https://wso2.com/subscription).

### Step 6 — Deploy the Database

Pattern 1 requires two databases: `apim_db` and `shared_db`. The database must be reachable from inside the Kubernetes cluster. Choose the approach that fits your setup:

!!! note
    The example below uses MySQL, but WSO2 API Manager supports PostgreSQL, Oracle, and MSSQL. The schema scripts for all supported databases are bundled in the product pack.

=== "MySQL inside Kubernetes"

    #### 6.1 — Deploy MySQL

    1. Create the namespace and deploy MySQL:

        ```bash
        kubectl create namespace wso2

        kubectl apply -f - <<EOF
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: mysql
          namespace: wso2
        spec:
          selector:
            matchLabels:
              app: mysql
          template:
            metadata:
              labels:
                app: mysql
            spec:
              containers:
              - name: mysql
                image: mysql:8.0
                env:
                - name: MYSQL_ROOT_PASSWORD
                  value: "root"
                ports:
                - containerPort: 3306
        ---
        apiVersion: v1
        kind: Service
        metadata:
          name: mysql
          namespace: wso2
        spec:
          selector:
            app: mysql
          ports:
          - port: 3306
            targetPort: 3306
        EOF
        ```

    2. Wait for MySQL to be ready:

        ```bash
        kubectl get pods -n wso2 -w
        ```

        The MySQL pod should show `1/1 Running` before proceeding.

    #### 6.2 — Create the Databases

    1. Once MySQL is running, create both databases:

        ```bash
        kubectl exec -n wso2 \
          $(kubectl get pod -n wso2 -l app=mysql -o jsonpath='{.items[0].metadata.name}') \
          -- mysql -u root -proot -e "
            CREATE DATABASE apim_db CHARACTER SET latin1;
            CREATE DATABASE shared_db CHARACTER SET latin1;
          "
        ```

    #### 6.3 — Download the Product Pack

    1. Download the WSO2 API Manager product pack from the WSO2 GitHub releases page:

        ```bash
        curl -L https://github.com/wso2/product-apim/releases/download/v4.6.0/wso2am-4.6.0.zip \
          -o wso2am-4.6.0.zip
        unzip wso2am-4.6.0.zip
        ```

        This produces a folder called `wso2am-4.6.0` containing the `dbscripts` directory.

    #### 6.4 — Run the Schema Scripts

    1. Copy the scripts into the MySQL pod and run them:

        ```bash
        MYSQL_POD=$(kubectl get pod -n wso2 -l app=mysql -o jsonpath='{.items[0].metadata.name}')

        kubectl cp wso2am-4.6.0/dbscripts/mysql.sql wso2/$MYSQL_POD:/tmp/mysql.sql
        kubectl cp wso2am-4.6.0/dbscripts/apimgt/mysql.sql wso2/$MYSQL_POD:/tmp/apimgt_mysql.sql

        kubectl exec -n wso2 $MYSQL_POD -- \
          bash -c "mysql -u root -proot shared_db < /tmp/mysql.sql"

        kubectl exec -n wso2 $MYSQL_POD -- \
          bash -c "mysql -u root -proot apim_db < /tmp/apimgt_mysql.sql"
        ```

    2. Verify the tables were created:

        ```bash
        kubectl exec -n wso2 $MYSQL_POD -- \
          mysql -u root -proot -e "SHOW TABLES;" shared_db

        kubectl exec -n wso2 $MYSQL_POD -- \
          mysql -u root -proot -e "SHOW TABLES;" apim_db
        ```

        !!! note
            You may see a warning about using a password on the command line — this is a security notice, not an error. The scripts have run successfully if no `ERROR` lines appear.

=== "Externally managed database"

    #### 6.1 — Create the Databases

    1. Connect to your managed database instance and create both databases:

        ```bash
        mysql -h <endpoint> -u <user> -p -e "
          CREATE DATABASE apim_db CHARACTER SET latin1;
          CREATE DATABASE shared_db CHARACTER SET latin1;
        "
        ```

        Replace `<endpoint>` and `<user>` with your managed database host and credentials.

    #### 6.2 — Download the Product Pack

    1. Download the WSO2 API Manager product pack from the WSO2 GitHub releases page:

        ```bash
        curl -L https://github.com/wso2/product-apim/releases/download/v4.6.0/wso2am-4.6.0.zip \
          -o wso2am-4.6.0.zip
        unzip wso2am-4.6.0.zip
        ```

        This produces a folder called `wso2am-4.6.0` containing the `dbscripts` directory.

    #### 6.3 — Run the Schema Scripts

    1. Run the schema scripts directly against your managed database:

        ```bash
        mysql -h <endpoint> -u <user> -p shared_db < wso2am-4.6.0/dbscripts/mysql.sql
        mysql -h <endpoint> -u <user> -p apim_db < wso2am-4.6.0/dbscripts/apimgt/mysql.sql
        ```

    2. Verify the tables were created:

        ```bash
        mysql -h <endpoint> -u <user> -p -e "SHOW TABLES;" shared_db
        mysql -h <endpoint> -u <user> -p -e "SHOW TABLES;" apim_db
        ```

!!! note
    Scripts for other databases (PostgreSQL, Oracle, MSSQL) are in `wso2am-4.6.0/dbscripts`. For production, use separate database users with limited permissions instead of `root`.

### Step 7 — Create the Keystore Secret

The Helm chart mounts a Kubernetes secret named `apim-keystore-secret` as a volume into the pods. The pods will not start if this secret does not exist — you will see a `MountVolume.SetUp failed: secret "apim-keystore-secret" not found` error.

!!! note "Why Pattern 1 requires this but Pattern 0 does not"
    In Pattern 0 (single node), the keystore secret is optional and the chart does not mount it, so pods start without it. In Pattern 1, `highAvailability: true` is set and the chart treats the keystore secret as a required volume — the assumption is that HA deployments are production-grade and should use explicit certificates rather than relying on defaults baked into the image.

1. WSO2 API Manager ships with default keystores inside the Docker image. Extract them and create the secret:

    ```bash
    mkdir -p keystores

    docker run --rm -v "$(pwd)/keystores:/keystores" --entrypoint bash <CONTAINER_REGISTRY>/<IMAGE_REPO>:<TAG> -c "cp /home/wso2carbon/wso2am-4.6.0/repository/resources/security/wso2carbon.jks /home/wso2carbon/wso2am-4.6.0/repository/resources/security/client-truststore.jks /keystores/"

    kubectl create secret generic apim-keystore-secret --from-file=wso2carbon.jks=keystores/wso2carbon.jks --from-file=client-truststore.jks=keystores/client-truststore.jks -n wso2
    ```

2. Verify the secret was created:

    ```bash
    kubectl get secret apim-keystore-secret -n wso2
    ```

!!! note
    The commands above use the default WSO2 keystores which are suitable for evaluation. For production, replace the `.jks` files with your own organisation-issued or CA-signed certificates before creating the secret.

### Step 8 — Deploy WSO2 API Manager

Pattern 1 uses a single Helm chart release with two pod replicas forming the active-active cluster. Before deploying, you must configure your custom image and database connection in a `values.yaml` file.

1. Download the default values file as a starting point:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-1-all-in-one-HA/default_values.yaml \
      -o values.yaml
    ```

2. Open `values.yaml` and update the two sections below before deploying.

    **Custom image** — point to the image you built and pushed in Step 5. The `registry` and `repository` together form the full image name. For Docker Hub, `registry` is `docker.io` and `repository` is `<your-username>/<image-name>`.

    Set both `tag` (the tag you used in `docker build`) and `digest` (from `docker inspect` in Step 5):

    ```yaml
    wso2:
      deployment:
        image:
          registry: "docker.io"                       # your container registry
          repository: "<your-username>/wso2am-mysql"  # your Docker Hub username + image name
          tag: "4.6.0"                                # tag used in docker build
          digest: "sha256:abcdef..."                  # sha256 digest from docker inspect in Step 5
    ```

    **Database connection** — point to the database you set up in Step 6:

    === "MySQL inside Kubernetes"

        The hostname `mysql` is the Kubernetes service name — pods resolve it via cluster DNS:

        ```yaml
          apim:
            configurations:
              databases:
                apim_db:
                  url: "jdbc:mysql://mysql:3306/apim_db?useSSL=false&amp;allowPublicKeyRetrieval=true"
                  username: "root"
                  password: "root"
                shared_db:
                  url: "jdbc:mysql://mysql:3306/shared_db?useSSL=false&amp;allowPublicKeyRetrieval=true"
                  username: "root"
                  password: "root"
        ```

    === "Externally managed database"

        Replace the hostname with your managed database endpoint and update the credentials. Most managed database services (e.g. RDS, Cloud SQL) require SSL:

        ```yaml
          apim:
            configurations:
              databases:
                apim_db:
                  url: "jdbc:mysql://<endpoint>:3306/apim_db?useSSL=true&amp;requireSSL=true"
                  username: "<db-username>"
                  password: "<db-password>"
                shared_db:
                  url: "jdbc:mysql://<endpoint>:3306/shared_db?useSSL=true&amp;requireSSL=true"
                  username: "<db-username>"
                  password: "<db-password>"
        ```


3. Deploy with:

    ```bash
    helm install apim-1 wso2/wso2am-all-in-one \
      --version 4.6.0-1 \
      --namespace wso2 \
      -f values.yaml
    ```

4. Wait for both pods to be ready:

    ```bash
    kubectl get pods -n wso2 -w
    ```

    Both WSO2 pods should show `1/1 Running`. This typically takes 3–5 minutes on first startup. If a pod is restarting, check for errors:

    ```bash
    kubectl logs -n wso2 <pod-name> --previous | grep -E "ERROR|FATAL"
    kubectl describe pod -n wso2 <pod-name>
    ```

### Step 9 — Configure Local DNS

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

!!! note
    These are the default hostnames. If you customised `ingress.controlPlane.hostname`, `ingress.gateway.hostname`, `ingress.websocket.hostname`, or `ingress.websub.hostname` in your `values.yaml`, use those values here instead.

If your hostnames are backed by a real DNS service (e.g. Route 53, Cloud DNS), add a DNS record mapping the hostnames to the external IP in your DNS provider instead of editing `/etc/hosts`.

### Step 10 — Access the Portals

1. Once DNS is configured, open the following URLs in your browser:

    | Portal | URL |
    | ------ | --- |
    | Publisher | `https://am.wso2.com/publisher` |
    | Developer Portal | `https://am.wso2.com/devportal` |
    | Carbon Console | `https://am.wso2.com/carbon` |
    | Gateway | `https://gw.wso2.com` |

    !!! note
        These URLs use the default hostnames. If you changed the hostnames in your `values.yaml`, substitute them accordingly.

    !!! note "Chrome may block access"
        Chrome enforces HSTS for `*.wso2.com` domains and may refuse to open the portals with a security warning that cannot be bypassed. If this happens, use Firefox instead — click **Advanced → Accept the Risk and Continue** when prompted about the self-signed certificate.

    Default credentials: **admin / admin**

---

## Advanced Configuration

All configurations in this section are made by editing your `values.yaml` file. Once all changes are in place, deploy using the command in [Section 6](#6-deploy-with-custom-values).

The Helm charts for WSO2 API Manager are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.6.x).

!!! note "Resource Naming Convention"
    Kubernetes resources created by the Helm charts follow this naming pattern:
    ```
    <RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>
    ```

### 1. Image and Registry

#### 1.1 Configure Docker Image and Registry

Configure this section to point the Helm chart to the custom image you built in Step 5.

```yaml
wso2:
  deployment:
    image:
      registry: ""        # e.g. docker.io/myorg
      repository: ""      # e.g. wso2am-mysql
      digest: ""          # sha256:... from docker inspect
      imagePullSecrets:
        enabled: false
        username: ""
        password: ""
```

> Enable `imagePullSecrets` if your registry is private.

!!! warning "Digest must not be empty"
    The Helm chart always appends the digest to the image name. Leaving `digest` empty will cause an `InvalidImageName` error on pod startup. Always provide the `sha256:...` digest obtained from `docker inspect`.

### 2. Database and Credentials

#### 2.1 Configure Databases

Point the Helm chart to the external databases you created in Step 6.

!!! warning "JDBC Driver Required"
    The default WSO2 Docker image does not include third-party JDBC drivers. Ensure you have built a custom image with the appropriate driver (see Step 5) before configuring an external database.

```yaml
wso2:
  apim:
    configurations:
      databases:
        apim_db:
          url: ""         # JDBC URL — use &amp; to separate parameters, not &
          username: ""
          password: ""
        shared_db:
          url: ""
          username: ""
          password: ""
```

#### 2.2 Configure Admin Credentials

The default admin credentials are `admin/admin`. Change these before deploying to any shared or production environment.

```yaml
wso2:
  apim:
    configurations:
      adminUsername: ""
      adminPassword: ""
```

#### 2.3 Update Keystore Passwords

If you are mounting custom keystores (see section 3.1), update the passwords here to match.

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

- [All-in-One Helm chart](https://github.com/wso2/helm-apim/blob/main/all-in-one/README.md)
- [Universal Gateway Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/gateway/README.md)

### 3. Security

#### 3.1 Mount Keystore and Truststore

The default WSO2 keystores use a self-signed certificate. Mount your own certificates for production.

```bash
kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  -n wso2
```

Keep the following in mind:

- The secret must be created in the **same namespace** as the deployment (e.g. `wso2`).
- Use the **same secret name** in both the `kubectl` command above and in your `values.yaml`.
- If you are using different keystore filenames or aliases, update the helm chart configurations accordingly.
- You can also include keystores for HTTPS transport.

Then reference the secret name in your `values.yaml`. For more details, see the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/deploy/Managing_Keystores_And_Truststores.md).

#### 3.2 Encrypt Secrets

By default, database passwords and other sensitive values are stored as plain text in `values.yaml`. Use the WSO2 cipher tool or `apictl` to encrypt these values before deploying.

```bash
sh cipher-tool.sh -Dconfigure
```

Store the internal keystore password in your cloud provider's secret manager and reference it:

```yaml
internalKeystorePassword:
  secretName: ""   # Secret name in AWS/Azure/GCP Secrets Manager
  secretKey: ""
```

> Supported secret managers: AWS Secrets Manager, Azure Key Vault, GCP Secret Manager.

Alternatively, use `apictl` to encrypt secrets — see the [apictl documentation](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/api-controller/encrypting-secrets-with-ctl/).

#### 3.3 Configure SSL

For WSO2 recommended SSL best practices when exposing services outside the cluster, refer to the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

#### 3.4 Configure JWKS URL

!!! note "Important for multi-pod deployments"
    In Pattern 1, two pods share the same hostname `am.wso2.com`. Using `localhost` for the JWKS URL will only resolve to the pod handling the request, causing token verification failures on the other pod. Use the Kubernetes service name instead so both pods can resolve it correctly:

```yaml
wso2:
  apim:
    configurations:
      oauth_config:
        oauth2JWKSUrl: "https://<service-name>:9443/oauth2/jwks"
```

### 4. Ingress

#### 4.1 Configure Ingress Annotations

Customise these if you want to enable sticky sessions, change the backend protocol, or apply rate limiting.

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

#### 4.2 Configure TLS for Ingress

```bash
kubectl create secret tls my-tls-secret \
  --key <private-key-file> \
  --cert <certificate-file> \
  -n wso2
```

Then set the secret name in your `values.yaml` under `ingress.tlsSecret`. Refer to the [Kubernetes ingress TLS documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) for more details.

### 5. Gateway, High Availability, and User Management

#### 5.1 Configure Multiple Gateways

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

```yaml
userStore:
  type: "database_unique_id"
  properties:
    ReadGroups: true
```

!!! warning
    If you do not need to set any custom properties, remove the `properties` block entirely. An empty `properties` block will cause the deployment to fail.

See [Working with user store properties](https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/working-with-properties-of-user-stores/) for the full list of options.

#### 5.3 Configure High Availability

High availability is enabled by default in Pattern 1, which deploys two pods. For local testing where resources are limited, you can disable it to run a single pod:

```yaml
wso2:
  deployment:
    highAvailability: false
```

### 6. Deploy with Custom Values

Once your `values.yaml` is configured, deploy with:

```bash
helm install <release-name> <helm-chart-path> \
  --version 4.6.0-1 \
  --namespace <namespace> --create-namespace \
  --dependency-update \
  -f values.yaml
```

!!! tip "Deployment Parameters"
    - `<release-name>` — Name for your Helm release (e.g. `apim-1`)
    - `<namespace>` — Kubernetes namespace to deploy into (e.g. `wso2`)
    - `<helm-chart-path>` — Path to the Helm chart, either the repository chart (`wso2/wso2am-all-in-one`) or a local clone (e.g. `./all-in-one`)
