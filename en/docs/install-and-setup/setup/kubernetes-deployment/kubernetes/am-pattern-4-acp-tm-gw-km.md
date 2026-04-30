# Pattern 4: Fully Distributed Setup

This pattern adds a dedicated Key Manager to the Pattern 3 setup, separating token issuance and validation from the Control Plane. It is the most scalable and production-ready deployment pattern, suitable for environments with high security and compliance requirements.

<a href="{{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png"><img src="{{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png" alt="fully distributed api-m deployment" width="60%"></a>

## How Pattern 4 Differs from Earlier Patterns

| | Pattern 2 | Pattern 3 | Pattern 4 |
|---|---|---|---|
| Control Plane | Embedded in All-in-One | Dedicated ACP | Dedicated ACP |
| Traffic Manager | Embedded in All-in-One | Dedicated TM | Dedicated TM |
| Gateway | Dedicated, independently scalable | Dedicated, independently scalable | Dedicated, independently scalable |
| Key Manager | Embedded in All-in-One | Embedded in ACP | Dedicated KM |
| Custom images | 2 images | 3 images | 3 images (KM reuses ACP image) |
| High availability | Gateway: Yes; All-in-One: Optional | Yes (all components) | Yes (all components) |

!!! note
    The Key Manager uses the same Docker image as the API Control Plane — no separate image build is required.

!!! warning "Pattern 4 requires the following before deploying:"

    1. **An external database** — H2 is not supported. Set up an external database before deploying.
    2. **Three custom Docker images** — one each for the API Control Plane, Traffic Manager, and Universal Gateway. The Key Manager reuses the ACP image.
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

    All nodes should show a `Ready` status..

### Step 3 — Add the WSO2 Helm Repository

1. Add the WSO2 Helm repository and update it:

    ```bash
    helm repo add wso2 https://helm.wso2.com && helm repo update
    ```

### Step 4 — Install the NGINX Ingress Controller

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

Pattern 4 requires three custom Docker images — one each for the API Control Plane, Traffic Manager, and Universal Gateway. The Key Manager reuses the ACP image, so no additional build is needed for it.

!!! note "Choosing a base image"
    - **DockerHub** (`wso2/wso2am-acp:4.6.0`, `wso2/wso2am-tm:4.6.0`, `wso2/wso2am-universal-gw:4.6.0`) — packages the GA release. Suitable for evaluation and development.
    - **WSO2 Private Registry** (`docker.wso2.com/wso2am-acp:4.6.0.0`, `docker.wso2.com/wso2am-tm:4.6.0.0`, `docker.wso2.com/wso2am-universal-gw:4.6.0.0`) — includes WSO2 Updates and is recommended for production. Requires an active [WSO2 Subscription](https://wso2.com/subscription).

1. Create a directory for the custom images:

    ```bash
    mkdir wso2am-custom && cd wso2am-custom
    ```

2. Create a `Dockerfile.acp` for the API Control Plane image (also used for the Key Manager):

    ```dockerfile
    FROM wso2/wso2am-acp:4.6.0

    ADD --chown=wso2carbon:wso2 \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
      /home/wso2carbon/wso2am-acp-4.6.0/repository/components/lib/
    ```

3. Create a `Dockerfile.tm` for the Traffic Manager image:

    ```dockerfile
    FROM wso2/wso2am-tm:4.6.0

    ADD --chown=wso2carbon:wso2 \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
      /home/wso2carbon/wso2am-tm-4.6.0/repository/components/lib/
    ```

4. Create a `Dockerfile.gw` for the Universal Gateway image:

    ```dockerfile
    FROM wso2/wso2am-universal-gw:4.6.0

    ADD --chown=wso2carbon:wso2 \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar \
      /home/wso2carbon/wso2am-universal-gw-4.6.0/repository/components/lib/
    ```

5. Build all three images, replacing `<REGISTRY>` and `<TAG>` with your values:

    ```bash
    docker buildx build --platform linux/amd64 -f Dockerfile.acp -t <REGISTRY>/wso2am-acp-mysql:<TAG> .
    docker buildx build --platform linux/amd64 -f Dockerfile.tm -t <REGISTRY>/wso2am-tm-mysql:<TAG> .
    docker buildx build --platform linux/amd64 -f Dockerfile.gw -t <REGISTRY>/wso2am-gw-mysql:<TAG> .
    ```

    !!! note "Matching your cluster architecture"
        The `--platform` flag ensures the image is built for the architecture your cluster nodes run on. Most managed clusters (AKS, GKE) and Linux servers use `linux/amd64`. If you are building on Apple Silicon (M1/M2/M3/M4) without this flag, the image will be built for `linux/arm64` and the pod will fail to start with `no match for platform in manifest`.

        To check your cluster node architecture:

        ```bash
        kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.architecture}'
        ```

6. Push all three images to your container registry:

    ```bash
    docker push <REGISTRY>/wso2am-acp-mysql:<TAG>
    docker push <REGISTRY>/wso2am-tm-mysql:<TAG>
    docker push <REGISTRY>/wso2am-gw-mysql:<TAG>
    ```

7. Get the image digests — you will need them when configuring your values files:

    ```bash
    docker inspect <REGISTRY>/wso2am-acp-mysql:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'

    docker inspect <REGISTRY>/wso2am-tm-mysql:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'

    docker inspect <REGISTRY>/wso2am-gw-mysql:<TAG> \
      --format='{% raw %}{{index .RepoDigests 0}}{% endraw %}'
    ```

### Step 6 — Deploy the Database

Pattern 4 requires two databases: `apim_db` and `shared_db`. The database must be reachable from inside the Kubernetes cluster. Choose the approach that fits your setup:

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

### Step 7 — Create the Keystore Secret { #step-7 }

The Helm chart mounts a Kubernetes secret named `apim-keystore-secret` as a volume into the pods. The pods will not start if this secret does not exist.

1. Extract the default keystores from your ACP image and create the secret:

    ```bash
    mkdir -p keystores

    docker run --rm -v "$(pwd)/keystores:/keystores" --entrypoint bash <REGISTRY>/wso2am-acp-mysql:<TAG> -c "cp /home/wso2carbon/wso2am-acp-4.6.0/repository/resources/security/wso2carbon.jks /home/wso2carbon/wso2am-acp-4.6.0/repository/resources/security/client-truststore.jks /keystores/"

    kubectl create secret generic apim-keystore-secret \
      --from-file=wso2carbon.jks=keystores/wso2carbon.jks \
      --from-file=client-truststore.jks=keystores/client-truststore.jks \
      -n wso2
    ```

2. Verify the secret was created:

    ```bash
    kubectl get secret apim-keystore-secret -n wso2
    ```

!!! note
    The commands above use the default WSO2 keystores which are suitable for evaluation. For production, replace the `.jks` files with your own organisation-issued or CA-signed certificates before creating the secret.

### Step 8 — Deploy the API Control Plane { #step-8 }

1. Download the default values file for the API Control Plane:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-4-ACP_TM_GW_KM/default_acp_values.yaml \
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

    === "MySQL inside Kubernetes"

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

3. Deploy the API Control Plane:

    ```bash
    helm install apim-acp wso2/wso2am-acp \
      --version 4.6.0-1 \
      --namespace wso2 --create-namespace \
      -f values-acp.yaml
    ```

4. Wait for the ACP pods to be ready:

    ```bash
    kubectl get pods -n wso2 -w
    ```

    The ACP pods should show `1/1 Running` before deploying the Key Manager.

### Step 9 — Deploy the Key Manager { #step-9 }

1. Download the default values file for the Key Manager:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-4-ACP_TM_GW_KM/default_km_values.yaml \
      -o values-km.yaml
    ```

2. Open `values-km.yaml` and update the following sections.

    **Custom image** — the Key Manager uses the same image as the ACP:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "docker.io"
          repository: "<your-username>/wso2am-acp-mysql"
          tag: "<TAG>"
          digest: "sha256:abcdef..."
    ```

    **ACP connection** — the default values assume the ACP was deployed with release name `apim-acp`. If you used a different release name, find the actual service names and update accordingly:

    ```bash
    kubectl get svc -n wso2
    ```

    ```yaml
    eventhub:
      serviceUrl: "<ACP_SERVICE_NAME>"
      urls:
        - "<ACP_POD_1_SERVICE_NAME>"
        - "<ACP_POD_2_SERVICE_NAME>"
    ```

    **Database connection** — the Key Manager needs access to both databases:

    === "MySQL inside Kubernetes"

        ```yaml
        wso2:
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

        ```yaml
        wso2:
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

3. Deploy the Key Manager:

    ```bash
    helm install apim-km wso2/wso2am-km \
      --version 4.6.0-1 \
      --namespace wso2 \
      -f values-km.yaml
    ```

4. Wait for the Key Manager pods to be ready:

    ```bash
    kubectl get pods -n wso2 -w
    ```

    The KM pods should show `1/1 Running` before deploying the Traffic Manager.

### Step 10 — Deploy the Traffic Manager { #step-10 }

1. Download the default values file for the Traffic Manager:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-4-ACP_TM_GW_KM/default_tm_values.yaml \
      -o values-tm.yaml
    ```

2. Open `values-tm.yaml` and update the following sections.

    **Custom image** — point to the Traffic Manager image you built in Step 5:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "docker.io"
          repository: "<your-username>/wso2am-tm-mysql"
          tag: "<TAG>"
          digest: "sha256:abcdef..."
    ```

    **KM and ACP connection** — the default values assume the KM and ACP were deployed with release names `apim-km` and `apim-acp`. If you used different release names, find the actual service names and update accordingly:

    ```bash
    kubectl get svc -n wso2
    ```

    ```yaml
    km:
      serviceUrl: "<KM_SERVICE_NAME>"

    eventhub:
      serviceUrl: "<ACP_SERVICE_NAME>"
      urls:
        - "<ACP_POD_1_SERVICE_NAME>"
        - "<ACP_POD_2_SERVICE_NAME>"
    ```

    **Database connection** — the Traffic Manager needs access to both databases:

    === "MySQL inside Kubernetes"

        ```yaml
        wso2:
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

        ```yaml
        wso2:
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

3. Deploy the Traffic Manager:

    ```bash
    helm install apim-tm wso2/wso2am-tm \
      --version 4.6.0-1 \
      --namespace wso2 \
      -f values-tm.yaml
    ```

4. Wait for the Traffic Manager pods to be ready:

    ```bash
    kubectl get pods -n wso2 -w
    ```

    The TM pods should show `1/1 Running` before deploying the Gateway.

### Step 11 — Deploy the Universal Gateway { #step-11 }

1. Download the default values file for the Universal Gateway:

    ```bash
    curl -L https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-4-ACP_TM_GW_KM/default_gw_values.yaml \
      -o values-gw.yaml
    ```

2. Open `values-gw.yaml` and update the following sections.

    **Custom image** — point to the Universal Gateway image you built in Step 5:

    ```yaml
    wso2:
      deployment:
        image:
          registry: "docker.io"
          repository: "<your-username>/wso2am-gw-mysql"
          tag: "<TAG>"
          digest: "sha256:abcdef..."
    ```

    **KM, ACP, and TM connection** — the default values assume the KM, ACP, and TM were deployed with release names `apim-km`, `apim-acp`, and `apim-tm`. If you used different release names, find the actual service names and update accordingly:

    ```bash
    kubectl get svc -n wso2
    ```

    ```yaml
    km:
      serviceUrl: "<KM_SERVICE_NAME>"

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
    ```

    **Database connection** — the Gateway needs access to `shared_db` for user store lookups:

    === "MySQL inside Kubernetes"

        ```yaml
        wso2:
          apim:
            configurations:
              databases:
                shared_db:
                  url: "jdbc:mysql://mysql:3306/shared_db?useSSL=false&amp;allowPublicKeyRetrieval=true"
                  username: "root"
                  password: "root"
        ```

    === "Externally managed database"

        ```yaml
        wso2:
          apim:
            configurations:
              databases:
                shared_db:
                  url: "jdbc:mysql://<endpoint>:3306/shared_db?useSSL=true&amp;requireSSL=true"
                  username: "<db-username>"
                  password: "<db-password>"
        ```

3. Deploy the Universal Gateway:

    ```bash
    helm install apim-gw wso2/wso2am-universal-gw \
      --version 4.6.0-1 \
      --namespace wso2 \
      -f values-gw.yaml
    ```

4. Wait for the Gateway pods to be ready:

    ```bash
    kubectl get pods -n wso2 -w
    ```

    The Gateway pods should show `1/1 Running`. If pods are `OOMKilled`, your cluster may not have enough resources — see the [Resource Requirements](kubernetes-overview.md#resource-requirements) section. If a pod is restarting for other reasons, check for errors:

    ```bash
    kubectl logs -n wso2 <pod-name> --previous | grep -E "ERROR|FATAL"
    kubectl describe pod -n wso2 <pod-name>
    ```

### Step 12 — Configure DNS

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
    These are the default hostnames. If you customised `ingress.controlPlane.hostname`, `ingress.gateway.hostname`, `ingress.websocket.hostname`, or `ingress.websub.hostname` in your values files, use those values here instead.

### Step 13 — Access the Portals

1. Once DNS is configured, open the following URLs in your browser:

    | Portal | URL |
    | ------ | --- |
    | Publisher | `https://am.wso2.com/publisher` |
    | Developer Portal | `https://am.wso2.com/devportal` |
    | Carbon Console | `https://am.wso2.com/carbon` |
    | Gateway | `https://gw.wso2.com` |

    !!! note "Chrome may block access"
        Chrome enforces HSTS preloading for `*.wso2.com` domains, which removes the option to bypass the self-signed certificate warning entirely. Use Firefox or Safari instead, and click through the certificate warning when prompted.

    Default credentials: **admin / admin**

---

## Additional Configuration

All configurations in this section are made by editing your `values-acp.yaml`, `values-km.yaml`, `values-tm.yaml`, or `values-gw.yaml` files. Once all changes are in place, deploy using the commands in [Step 8](#step-8) through [Step 11](#step-11).

The Helm charts for WSO2 API Manager are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.6.x).

!!! note "Resource Naming Convention"
    Kubernetes resources created by the Helm charts follow this naming pattern:
    ```
    <RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>
    ```

### 1. Image and Registry

#### 1.1 Private Registry Authentication

If your registry is private and requires authentication, enable `imagePullSecrets` in all values files:

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

#### 2.3 Component Configuration References

All available configuration options for each Helm chart are documented in their respective component guides:

- [API Control Plane Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/control-plane/README.md)
- [Key Manager Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/key-manager/README.md)
- [Traffic Manager Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/traffic-manager/README.md)
- [Universal Gateway Helm chart](https://github.com/wso2/helm-apim/blob/main/distributed/gateway/README.md)

### 3. Security

#### 3.1 Mount Keystore and Truststore { #section-3-1 }

In [Step 7](#step-7), you created `apim-keystore-secret` using the default WSO2 keystores. For production, replace the `.jks` files with your own organisation-issued or CA-signed certificates and recreate the secret:

```bash
kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  -n wso2
```

Keep the following in mind:

- The secret must be created in the **same namespace** as the deployment (e.g. `wso2`).
- Use the **same secret name** in both the `kubectl` command above and in your values files.
- If you are using different keystore filenames or aliases, update the helm chart configurations accordingly.

For more details, see the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/deploy/Managing_Keystores_And_Truststores.md).

#### 3.2 Encrypt Secrets

By default, database passwords and other sensitive values are stored as plain text in the values files. Use the WSO2 cipher tool or `apictl` to encrypt these values before deploying to production.

```bash
sh cipher-tool.sh -Dconfigure
```

Store the internal keystore password in your cloud provider's secret manager and reference it:

```yaml
internalKeystorePassword:
  secretName: ""   # Secret name in Azure/GCP Secrets Manager
  secretKey: ""
```

> Supported secret managers: Azure Key Vault, GCP Secret Manager.

Alternatively, use `apictl` to encrypt secrets — see the [apictl documentation](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/api-controller/encrypting-secrets-with-ctl/).

#### 3.3 Configure SSL

For WSO2 recommended SSL best practices when exposing services outside the cluster, refer to the [WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

#### 3.4 Configure JWKS URL

!!! note "Important for Pattern 4 deployments"
    In Pattern 4, the Key Manager handles token issuance. Use the KM Kubernetes service name for the JWKS URL so all components can resolve it via cluster DNS:

```yaml
wso2:
  apim:
    configurations:
      oauth_config:
        oauth2JWKSUrl: "https://<KM_SERVICE_NAME>:9443/oauth2/jwks"
```

### 4. Ingress

#### 4.1 Configure Ingress Annotations

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

Then set the secret name in your values file under `ingress.tlsSecret`. Refer to the [Kubernetes ingress TLS documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) for more details.

### 5. Gateway, Traffic Manager, and High Availability

#### 5.1 Configure Key Manager, EventHub, and Throttling

In Pattern 4, the Gateway connects to the dedicated KM for token validation, to the ACP for event subscriptions, and to the Traffic Manager for throttling:

=== "Single instances"

    ```yaml
    km:
      serviceUrl: "<KM_SERVICE_NAME>"

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

=== "All components with High Availability"

    ```yaml
    km:
      serviceUrl: "<KM_SERVICE_NAME>"

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

```yaml
wso2:
  deployment:
    replicas: 2
    minReplicas: 1
    maxReplicas: 3
```

#### 5.3 Configure Multiple Gateways

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
```

See [Deploy through multiple API Gateways](https://apim.docs.wso2.com/en/latest/manage-apis/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-through-multiple-api-gateways/) for more details.

#### 5.4 Configure User Store Properties

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

Once your values files are configured, deploy all four components in order:

```bash
helm install apim-acp wso2/wso2am-acp \
  --version 4.6.0-1 \
  --namespace wso2 --create-namespace \
  --dependency-update \
  -f values-acp.yaml

helm install apim-km wso2/wso2am-km \
  --version 4.6.0-1 \
  --namespace wso2 \
  --dependency-update \
  -f values-km.yaml

helm install apim-tm wso2/wso2am-tm \
  --version 4.6.0-1 \
  --namespace wso2 \
  --dependency-update \
  -f values-tm.yaml

helm install apim-gw wso2/wso2am-universal-gw \
  --version 4.6.0-1 \
  --namespace wso2 \
  --dependency-update \
  -f values-gw.yaml
```

!!! tip "Deployment Parameters"
    - Release names: `apim-acp`, `apim-km`, `apim-tm`, `apim-gw`
    - `<namespace>` — Kubernetes namespace to deploy into (e.g. `wso2`)
    - Helm chart paths: `wso2/wso2am-acp`, `wso2/wso2am-km`, `wso2/wso2am-tm`, `wso2/wso2am-universal-gw` (or local clones)
