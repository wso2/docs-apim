# Pattern 5: API-M Deployment with Simple Scalable Setup with Key Manager Separated

This document provides step-by-step instructions to deploy WSO2 API Manager in a standard distributed setup on Kubernetes. This pattern consists of a single API Control Plane (All-in-One), two Key Manager instances, and two Universal Gateway instances. It provides an optimal balance between high availability and resource utilization.

!!! info "About this Pattern"
    This deployment pattern consists of:
    
    - 1 Control Plane instance (All-in-One)
    - 2 Key Manager instances
    - 2 Universal Gateway instances
    - External databases for high availability

<a href="{{base_path}}/assets/img/setup-and-install/deployment-km.png"><img src="{{base_path}}/assets/img/setup-and-install/deployment-km.png" alt="Simple Scalable Deployment" width="100%"></a>

!!! tip
    For advanced details on this deployment pattern, please refer to the official [WSO2 API Manager documentation](kubernetes-overview.md).

## Contents

- [WSO2 API Manager Pattern 5: API-M Deployment with Simple Scalable Setup](#wso2-api-manager-pattern-5-api-m-deployment-with-simple-scalable-setup)
  - [Contents](#contents)
  - [Prerequisites](#prerequisites)
    - [Step 1 - Set Up Basic Configurations](#step-1---set-up-basic-configurations)
    - [Step 2 - Build Docker Images](#step-2---build-docker-images)
    - [Step 3 - Configure Database](#step-3---configure-database)
  - [Minimal Configuration](#minimal-configuration)
  - [Advanced Configuration](#advanced-configuration)
    - [1. General Configuration of Helm Charts](#1-general-configuration-of-helm-charts)
        - [1.1 Add Ingress Controller](#11-add-ingress-controller)
        - [1.2 Mount Keystore and Truststore](#12-mount-keystore-and-truststore)
        - [1.3 Encrypting Secrets](#13-encrypting-secrets)
        - [1.4 Configure Docker Image and Databases](#14-configure-docker-image-and-databases)
        - [1.5 Configure SSL in Service Exposure](#15-configure-ssl-in-service-exposure)
    - [2. All-in-One Configurations](#2-all-in-one-configurations)
        - [2.1 Configure Multiple Gateways](#21-configure-multiple-gateways)
        - [2.2 Configure User Store Properties](#22-configure-user-store-properties)
        - [2.3 Configure JWKS URL](#23-configure-jwks-url)
        - [2.4 Deploy All-in-One](#24-deploy-all-in-one)
    - [3. Key Manager Configuration](#3-key-manager-configuration)
        - [3.1 Configure Eventhub](#31-configure-eventhub)
        - [3.2 Deploy Key Manager](#32-deploy-key-manager)
    - [4. Universal Gateway Configuration](#4-universal-gateway-configuration)
        - [4.1 Configure Key Manager, Eventhub, and Throttling](#41-configure-key-manager-eventhub-and-throttling)
        - [4.2 Enable Replicas](#42-enable-replicas)
        - [4.3 Deploy Universal Gateway](#43-deploy-universal-gateway)
    - [5. Add DNS Records](#5-add-dns-records)
    - [6. Access Management Consoles](#6-access-management-consoles)

## Prerequisites

Before you begin, ensure you have met the following requirements:

!!! info "Prerequisites"
    The following tools and configurations are necessary for deploying WSO2 API-M in a Kubernetes environment:
    
    - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
    - [Helm](https://helm.sh/docs/intro/install/) (version 3 or newer)
    - [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
    - A running [Kubernetes cluster](https://kubernetes.io/docs/setup/) (version 1.16 or newer)
    - [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)
    - Access to a container registry (Docker Hub or private registry)
    - Database server (MySQL, MSSQL, PostgreSQL, etc.) accessible from the Kubernetes cluster

## Deployment Steps

### Step 1 - Set Up Basic Configurations

1. Add the WSO2 Helm chart repository:
   ```bash
   helm repo add wso2 https://helm.wso2.com && helm repo update
   ```

### Step 2 - Build Docker Images

!!! info "Docker Images"
    This pattern requires docker images for the WSO2 API Manager components. You can either use the official images or build custom images.

WSO2 provides Docker images in two ways:
- **Public DockerHub**: [WSO2 DockerHub](https://hub.docker.com/u/wso2/) offers General Availability (GA) versions with no additional updates
- **Private Docker Registry**: [WSO2 Private Docker Registry](https://docker.wso2.com/) provides production-grade images with WSO2 Updates (requires an active [WSO2 Subscription](https://wso2.com/subscription))

For this pattern, you will need:
- All-in-One image - [wso2am](https://hub.docker.com/r/wso2/wso2am) (for Control Plane and Key Manager)
- Universal Gateway image - [wso2am-universal-gw](https://hub.docker.com/r/wso2/wso2am-universal-gw)

!!! note "Key Manager Image"
    There is no separate Docker image for the Key Manager component. The All-in-One image should be used for the Key Manager component.

#### Building Custom Docker Images

If you need to customize the Docker images (e.g., adding JDBC drivers, custom libraries):

1. **Include JDBC Drivers**:
   Since products need to connect to databases, include JDBC drivers in your custom image:

   ```dockerfile
   ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar ${WSO2_SERVER_HOME}/repository/components/lib
   ```

2. **Sample Dockerfiles**:

   **All-in-One** (Control Plane/Key Manager):
   ```dockerfile
   FROM docker.wso2.com/wso2am:4.5.0.0

   ARG USER_HOME=/home/${USER}
   ARG WSO2_SERVER_NAME=wso2am
   ARG WSO2_SERVER_VERSION=4.5.0
   ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
   ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}

   # Copy JDBC MySQL driver
   ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar ${WSO2_SERVER_HOME}/repository/components/lib
   ```

   **Universal Gateway**:
   ```dockerfile
   FROM docker.wso2.com/wso2am-universal-gw:4.5.0.0

   ARG USER_HOME=/home/${USER}
   ARG WSO2_SERVER_NAME=wso2am-universal-gw
   ARG WSO2_SERVER_VERSION=4.5.0
   ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
   ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}

   # Copy JDBC MySQL driver
   ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar ${WSO2_SERVER_HOME}/repository/components/lib
   ```
    ARG WSO2_SERVER_VERSION=4.5.0
    ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
    ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}

    # Copy jdbc mysql driver
    ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar ${WSO2_SERVER_HOME}/repository/components/lib
    ```

- Once the required changes have been made to the Dockerfile, you can use the following command to build the custom image. Replace CONTAINER_REGISTRY, IMAGE_REPO, and TAG accordingly.
  ```bash
  docker build -t CONTAINER_REGISTRY/IMAGE_REPO:TAG .
  ```
- After building your custom Docker image, you need to push it to your container registry so it can be accessed by your Kubernetes cluster. Use the following command, replacing `CONTAINER_REGISTRY`, `IMAGE_REPO`, and `TAG` with your values:
  ```bash
  docker push CONTAINER_REGISTRY/IMAGE_REPO:TAG
  ```

## Step 3 - Configure Database

- Before running the API Manager, you must configure the databases and populate them with the initial data. All required database scripts are available in the `dbscripts` directory of the product pack. Locate the appropriate scripts for your chosen database engine and execute them accordingly. It is recommended to use two separate database users with limited permissions for enhanced security.

- An example for MySQL is provided below:
  ```sql
  CREATE DATABASE apim_db CHARACTER SET latin1;
  CREATE DATABASE shared_db CHARACTER SET latin1;

  GRANT ALL ON apim_db.* TO 'apimadmin'@'%';

  CREATE USER 'sharedadmin'@'%' IDENTIFIED BY 'sharedadmin';
  GRANT ALL ON shared_db.* TO 'sharedadmin'@'%';
  ```
  ```bash
  mysql -h <DB_HOST> -P 3306 -u sharedadmin -p -Dshared_db < './dbscripts/mysql.sql';
  mysql -h <DB_HOST> -P 3306 -u apimadmin -p -Dapim_db < './dbscripts/apimgt/mysql.sql';
  ```

## Minimal Configuration

If you want to quickly try out WSO2 API Manager on Kubernetes with minimal configuration, you can use the default values provided in the pre-configured YAML files.

!!! info "Quick Start Configuration"
    This minimal setup provides:
    
    - External database connection (requires setup as per Step 3)
    - Default keystores and truststores
    - Basic settings for a simple scalable deployment
    - Ready-to-use configuration for testing environments

1. **Create Kubernetes Secret for Keystores**:

   ```bash
   # Create secret with default WSO2 keystores and truststores
   kubectl create secret generic apim-keystore-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks
   ```

2. **Deploy Components Using Default Values**:

!!! warning "Important"
    Naming conventions are crucial. If you modify the component names, ensure consistency throughout your configuration files.

   **Deploy Control Plane (All-in-One)**:
   ```bash
   helm install apim wso2/wso2am-all-in-one --version 4.5.0-3 \
     -f https://raw.githubusercontent.com/wso2/helm-apim/main/docs/am-pattern-5-all-in-one_GW_KM/default_values.yaml
   ```

   **Deploy Key Manager**:
   ```bash
   helm install km wso2/wso2am-acp --version 4.5.0-3 \
     -f https://raw.githubusercontent.com/wso2/helm-apim/main/docs/am-pattern-5-all-in-one_GW_KM/default_km_values.yaml
   ```

   **Deploy Universal Gateway**:
   ```bash
   helm install gw wso2/wso2am-universal-gw --version 4.5.0-3 \
     -f https://raw.githubusercontent.com/wso2/helm-apim/main/docs/am-pattern-5-all-in-one_GW_KM/default_gw_values.yaml
   ```

3. **Set Up Ingress**:
   
   Once the services are deployed, configure the NGINX Ingress Controller by following the steps in [1.1 Add Ingress Controller](#11-add-ingress-controller).

## Advanced Configuration

### 1. General Configuration of Helm Charts

The Helm charts for the API Manager deployment are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.5.x). You can either use the charts from the repository or clone the repository and use the charts from the local copy.
- The Helm naming convention for APIM follows a simple pattern. The following format is used for naming the resources:
```<RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>```

#### 1.1 Add Ingress Controller

The recommendation is to use the [**NGINX Ingress Controller**](https://kubernetes.github.io/ingress-nginx/deploy/) suitable for your cloud environment or local deployment. Some sample annotations that could be used with the ingress resources are as follows:

  - The ingress class should be set to nginx in the ingress resource if you are using the NGINX Ingress Controller.
  - The following are some of the recommended annotations to include in the Helm charts for ingresses. These may vary depending on the requirements. Please refer to the [documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) for more information about the annotations.
  
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
  - You need to create a Kubernetes secret including the certificate and the private key and include the name of the secret in the Helm charts. This will be used for TLS termination at the load balancer level by the ingress controller. Please refer to the [documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) for more information.
    ```
    kubectl create secret tls my-tls-secret --key <private key filename> --cert <certificate filename>
    ```

#### 1.2 Mount Keystore and Truststore

- If you are not including the keystore and truststore in the Docker image, you can mount them using a Kubernetes secret. The following steps show how to mount the keystore and truststore using a Kubernetes secret.
- Create a Kubernetes secret with the keystore and truststore files. The secret should contain the primary keystore file, secondary keystore file, internal keystore file, and the truststore file. Note that the secret should be created in the same namespace in which you will be setting up the deployment.
- Make sure to use the same secret name when creating the secret and when configuring the Helm chart.
- If you are using a different keystore file name and alias, make sure to update the Helm chart configurations accordingly.
In addition to the primary, internal keystores and truststore files, you can also include the keystores for HTTPS transport as well.
- Refer to the following sample command to create the secret and use it in the APIM.
  
  ```
  kubectl create secret generic apim-keystore-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks --from-file=wso2internal.jks -n <namespace>
  ```
> By default, this deployment uses the default keystores and truststores provided by the relevant WSO2 product.
> For advanced details regarding managing custom Java keystores and truststores in a container-based WSO2 product deployment,
  please refer to the [official WSO2 container guide](https://github.com/wso2/container-guide/blob/master/deploy/Managing_Keystores_And_Truststores.md).

#### 1.3 Encrypting Secrets

- If you need to use the cipher tool to encrypt the passwords in the secret, first you need to encrypt the passwords using the cipher tool. The cipher tool can be found in the bin directory of the product pack. The following command can be used to encrypt the password:
  ```
  sh cipher-tool.sh -Dconfigure
  ```
- Also, the apictl can be used to encrypt passwords as well. Reference can be found in the [following](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/api-controller/encrypting-secrets-with-ctl/).
- Then the encrypted values should be filled in the relevant fields of values.yaml.
- Since the internal keystore password is required to resolve the encrypted value at runtime, you need to store the value in the cloud provider's secret manager. You can use the cloud provider's secret store to store the password of the internal keystore. The following section can be used to add the cloud provider's credentials to fetch the internal keystore password. Configuration for AWS can be as below: 
  ```yaml
  internalKeystorePassword:
    # -- AWS Secrets Manager secret name
    secretName: ""
    # -- AWS Secrets Manager secret key
    secretKey: ""
  ```
  > Please note that currently AWS, Azure, and GCP Secrets Managers are only supported for this.

#### 1.4 Configure Docker Image and Databases

  - Add the following configurations to reflect the Docker image created previously in the Helm chart.
    
    ```yaml
    wso2:
      deployment:
        image:
          imagePullSecrets:
            enabled: false
            username: ""
            password: ""		
          registry: ""
          repository: ""
          digest: ""
    ```

!!! info
    If you are using a **private Docker registry**, you must enable `imagePullSecrets.enabled` and provide the username and password.

  - Provide the database configurations under the following section.

    ```yaml
    wso2:
      apim:
        configurations:
          databases:
            apim_db:
              url: ""
              username: ""
              password: ""
            shared_db:
              url: ""
              username: ""
              password: ""
    ```
    - If you need to change the hostnames, update them under the Kubernetes ingress section.
    - Update the keystore passwords in the security section of the `values.yaml` file.
    - Review the descriptions of other configurations and modify them as needed to meet your requirements. A simple deployment can be achieved using the basic configurations provided in the `values.yaml` file. All configuration options for each Helm chart are documented in their respective component guides:
      - [All-in-one](https://github.com/wso2/helm-apim/blob/main/all-in-one/README.md)
      - [Universal Gateway](https://github.com/wso2/helm-apim/blob/main/distributed/gateway/README.md)
    - Update the admin credentials in the configuration directory.
    ```yaml
      # -- Super admin username
      adminUsername: ""
      # -- Super admin password
      adminPassword: ""
    ```
  
#### 1.5 Configure SSL in Service Exposure

* For WSO2 recommended best practices in configuring SSL when exposing the internal product services outside of the Kubernetes cluster,
  please refer to the [official WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

### 2. All-in-one Configurations

#### 2.1 Configure Multiple Gateways

If you need to distribute the Gateway load, you can configure multiple API Gateway environments in WSO2 API Manager to publish to a single Developer Portal. [See more...](https://apim.docs.wso2.com/en/latest/manage-apis/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-through-multiple-api-gateways/)
```yaml
    gateway:
        # -- APIM Gateway environments
        environments:
        - name: "Default"
          type: "hybrid"
          gatewayType: "Regular"
          provider: "wso2"
          visibility:
          displayInApiConsole: true
          description: "This is a hybrid gateway that handles both production and sandbox token traffic."
          showAsTokenEndpointUrl: true
          serviceName: "apim-gw-wso2am-gateway-service"
          servicePort: 9443
          wsHostname: "websocket.wso2.com"
          httpHostname: "gw.wso2.com"
          websubHostname: "websub.wso2.com"
        - name: "Default_apk"
          type: "hybrid"
          provider: "wso2"
          gatewayType: "APK"
          displayInApiConsole: true
          description: "This is a hybrid gateway that handles both production and sandbox token traffic."
          showAsTokenEndpointUrl: true
          serviceName: "apim-gw-wso2am-gateway-service"
          servicePort: 9443
          wsHostname: "websocket.wso2.com"
          httpHostname: "default.gw.wso2.com:9095"
          websubHostname: "websub.wso2.com"
```

#### 2.2 Configure User Store Properties

You can configure user store properties to customize authentication and user management according to your requirements:

!!! info "User Store Configuration"
    For detailed information on user store properties, refer to the [WSO2 API-M documentation](https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/working-with-properties-of-user-stores/).

```yaml
userStore:
  # -- User store type.
  type: "database_unique_id"
  # -- User store properties
  properties:
    ReadGroups: true
```

!!! warning "Important"
    If you don't need to configure any user store properties, you must remove the `properties` block from the YAML file to avoid configuration errors.

#### 2.3 Configure JWKS URL

For the super tenant, the Resident Key Manager's default JWKS URL is `https://<HOSTNAME>:9443/oauth2/jwks`. When using virtual hosts like `am.wso2.com`, you need to configure the correct JWKS URL:

```yaml
wso2:
  apim:
    configurations:
      oauth_config:
        oauth2JWKSUrl: "https://<ALL-IN-ONE_SERVICE_NAME>:9443/oauth2/jwks"
```

!!! tip
    Using a properly configured JWKS URL ensures that token validation works correctly between components.

#### 2.4 Deploy All-in-One

Deploy the Control Plane (All-in-One) component with your custom configuration:

```bash
# Create namespace for deployment
kubectl create namespace <namespace>

# Install using Helm
helm install <release-name> wso2/wso2am-all-in-one \
  --version 4.5.0-3 \
  --namespace <namespace> \
  --dependency-update \
  -f values.yaml \
  --create-namespace
```

### 3. Key Manager Configuration

#### 3.1 Configure Eventhub

The Key Manager component needs to connect to the Control Plane's event hub for synchronizing data:

```yaml
eventhub:
  # -- Event hub (control plane) loadbalancer service url
  serviceUrl: "<ACP_SERVICE_NAME>"
  # -- Event hub service urls (for high availability setup)
  urls:
    - "<ACP-1_SERVICE_NAME>"
    - "<ACP-2_SERVICE_NAME>"
```

!!! info "Event Hub"
    The Event Hub enables communication between API Manager components. Configure the service URLs to point to your Control Plane instances.

#### 3.2 Deploy Key Manager

Deploy the Key Manager component with your custom configuration:

```bash
# Install Key Manager component
helm install <release-name> wso2/wso2am-acp \
  --version 4.5.0-3 \
  --namespace <namespace> \
  --dependency-update \
  -f km-values.yaml \
  --create-namespace
```

!!! tip
    Store your Key Manager configuration in a separate file (e.g., `km-values.yaml`) to keep your configurations organized.

### 4. Universal Gateway Configuration

#### 4.1 Configure Key Manager, Eventhub, and Throttling

The Universal Gateway needs to connect to several components to function properly:

!!! info "Gateway Configuration"
    Configure the Gateway to connect to the Control Plane and Key Manager components for proper operation.

**Configure Key Manager Connection**:
```yaml
km:
  # -- Key manager service name
  serviceUrl: "<ALL-IN-ONE_SERVICE_NAME>"
```

**Configure Event Hub Connection**:

=== "Single All-in-One"

    ```yaml
    eventhub:
      # -- Event hub (control plane) service URL
      serviceUrl: "<CONTROL_PLANE_SERVICE_NAME>"
      # -- Event hub service URLs
      urls:
        - "<CONTROL_PLANE_SERVICE_NAME>"
    ```

=== "All-in-One with High Availability"

    ```yaml
    eventhub:
      # -- Event hub (control plane) load balancer service URL
      serviceUrl: "<CONTROL_PLANE_SERVICE_NAME>"
      # -- Event hub service URLs
      urls:
        - "<CONTROL_PLANE_1_SERVICE_NAME>"
        - "<CONTROL_PLANE_2_SERVICE_NAME>"
    ```

**Configure Throttling**:

=== "Single All-in-One"

    ```yaml
    throttling:
      # -- Traffic Manager service URL
      serviceUrl: "<CONTROL_PLANE_SERVICE_NAME>"
      # -- Port offset
      portOffset: 0
      # -- Service port
      servicePort: 9443
      # -- Traffic manager service URLs
      urls:
        - "<CONTROL_PLANE_1_SERVICE_NAME>"
      # -- Enable unlimited throttling tier
      unlimitedTier: true
      # -- Advanced throttling options
      headerBasedThrottling: false
      jwtClaimBasedThrottling: false
      queryParamBasedThrottling: false
    ```

=== "All-in-One with High Availability"

    ```yaml
    throttling:
      # -- Traffic Manager service URL
      serviceUrl: "<CONTROL_PLANE_SERVICE_NAME>"
      # -- Port offset
      portOffset: 0
      # -- Service port
      servicePort: 9443
      # -- Traffic manager service URLs
      urls:
        - "<CONTROL_PLANE_1_SERVICE_NAME>"
        - "<CONTROL_PLANE_2_SERVICE_NAME>"
      # -- Enable unlimited throttling tier
      unlimitedTier: true
      # -- Advanced throttling options
      headerBasedThrottling: false
      jwtClaimBasedThrottling: false
      queryParamBasedThrottling: false


Choose the configuration that matches your deployment pattern. For high availability, specify all Control Plane service URLs under `urls` for both `eventhub` and `throttling` sections.

#### 4.2 Enable Replicas

To ensure high availability and scalability of the Universal Gateway, you can configure the number of replicas in the `wso2.deployment` section of your `values.yaml` file.

```yaml
wso2:
  deployment:
    replicas: 2
    minReplicas: 1
    maxReplicas: 3
```

!!! info
    - `replicas`: The initial number of pods to start with (e.g., 2).
    - `minReplicas`: The minimum number of pods that should always be running (e.g., 1).
    - `maxReplicas`: The maximum number of pods that can be scaled up to (e.g., 3).

#### 4.3 Deploy Universal Gateway

Deploy the Universal Gateway component with your custom configuration:

```bash
# Install Gateway component
helm install <release-name> wso2/wso2am-universal-gw \
  --version 4.5.0-3 \
  --namespace <namespace> \
  --dependency-update \
  -f gw-values.yaml \
  --create-namespace
```

!!! tip
    Store your Gateway configuration in a separate file (e.g., `gw-values.yaml`) for better organization and maintenance.

### 5. Add DNS Records

After deploying the components, you need to configure DNS records for accessing the services:

1. **Get the External IP of Ingress Resources**:

   ```bash
   kubectl get ing -n <NAMESPACE>
   ```

2. **Configure DNS Records**:

   !!! info "DNS Configuration"
       You have two options for configuring hostname resolution:

   **Option 1**: If you have a DNS service, add proper DNS records:
   - Add A records in your DNS service mapping the hostnames to the `EXTERNAL-IP`

   **Option 2**: For local testing, add entries in your hosts file:
   ```
   <EXTERNAL-IP> <kubernetes.ingress.management.hostname> <kubernetes.ingress.gateway.hostname> <kubernetes.ingress.websub.hostname> <kubernetes.ingress.websocket.hostname>
   ```

   !!! tip
       For production environments, always use a proper DNS service with valid domain names and SSL certificates.

### 6. Access Management Consoles

After completing the deployment and DNS configuration, you can access the management consoles:

| Console | URL | Description |
|---------|-----|-------------|
| API Publisher | `https://<kubernetes.ingress.management.hostname>/publisher` | Create and manage APIs |
| Developer Portal | `https://<kubernetes.ingress.management.hostname>/devportal` | Discover and subscribe to APIs |
| Carbon Console | `https://<kubernetes.ingress.management.hostname>/carbon` | Administrative tasks |
| Universal Gateway | `https://<kubernetes.ingress.gateway.hostname>` | API Gateway endpoint |

!!! tip "Default Credentials"
    The default username is `admin` with password `admin`. For production environments, change these credentials immediately after first login.

