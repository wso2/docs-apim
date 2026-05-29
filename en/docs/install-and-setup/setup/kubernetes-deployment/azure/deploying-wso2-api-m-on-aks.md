# Deploying WSO2 API Manager on Azure AKS

This guide provides a step-by-step approach to deploying WSO2 API Manager on Azure Kubernetes Service (AKS). This deployment follows the standard WSO2 Kubernetes architecture, extended to use Azure-specific services such as Azure Database for PostgreSQL/MySQL for databases and Azure Application Gateway for ingress.

!!! info
    This deployment aligns with the standard deployment models described in [WSO2 API Manager Deployment Patterns]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/kubernetes-overview/#deployment-patterns) and [API-M Deployment with All-in-One HA Setup]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/am-pattern-1-all-in-one-ha/).

## Contents

- [Deploying WSO2 API Manager on Azure AKS](#deploying-wso2-api-manager-on-azure-aks)
  - [Contents](#contents)
  - [Prerequisites](#prerequisites)
    - [Azure Requirements](#azure-requirements)
    - [WSO2 Requirements](#wso2-requirements)
  - [Architecture Overview](#architecture-overview)
    - [Azure Deployment Architecture](#azure-deployment-architecture)
    - [WSO2 API Manager Deployment Architecture](#wso2-api-manager-deployment-architecture)
  - [Step 1: Create and Prepare the AKS Cluster](#step-1-create-and-prepare-the-aks-cluster)
  - [Step 2: Install Envoy Gateway API Controller](#step-2-install-envoy-gateway-api-controller)
  - [Step 3: Configure the Databases](#step-3-configure-the-databases)
    - [Create Database Instances](#create-database-instances)
    - [Initialize Database Schemas](#initialize-database-schemas)
  - [Step 4: Set Up Docker Images](#step-4-set-up-docker-images)
    - [Create a Custom Dockerfile](#create-a-custom-dockerfile)
    - [Build and Push to ACR](#build-and-push-to-acr)
    - [Grant AKS Access to ACR](#grant-aks-access-to-acr)
  - [Step 5: Generate Keystore and Truststore](#step-5-generate-keystore-and-truststore)
    - [Locate Default Keystores](#locate-default-keystores)
    - [Create a New Keystore](#create-a-new-keystore)
    - [Import Certificate to Truststore](#import-certificate-to-truststore)
  - [Step 6: Deploy Helm Charts](#step-6-deploy-helm-charts)
    - [Connect to AKS Cluster](#connect-to-aks-cluster)
    - [Add WSO2 Helm Repository](#add-wso2-helm-repository)
    - [Create Kubernetes Secret for Keystores](#create-kubernetes-secret-for-keystores)
    - [Configure values.yaml](#configure-valuesyaml)
    - [Deploy the Helm Chart](#deploy-the-helm-chart)
    - [Verify the Deployment](#verify-the-deployment)
  - [Step 7: Configure Gateway and DNS](#step-7-configure-gateway-and-dns)
    - [Obtain the Load Balancer Address](#obtain-the-load-balancer-address)
    - [Configure DNS Records](#configure-dns-records)
  - [Step 8: Access Management Consoles](#step-8-access-management-consoles)
  - [Troubleshooting](#troubleshooting)
    - [Pods Not Starting](#pods-not-starting)
    - [Database Connection Issues](#database-connection-issues)
    - [Gateway Not Working](#gateway-not-working)
  - [Next Steps](#next-steps)
  - [See Also](#see-also)

## Prerequisites

Before deploying WSO2 API Manager on Azure AKS, ensure you have the following prerequisites in place:

### Azure Requirements

- Azure account with admin or strong IAM permissions
- Azure Kubernetes Service (AKS) cluster (or ability to create one)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [Helm](https://helm.sh/docs/intro/install/) installed locally
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) configured with appropriate credentials
- Azure Database for PostgreSQL/MySQL provisioned

### WSO2 Requirements

- Access to WSO2 API Manager (APIM) Docker images
- Kubernetes deployment artifacts (Helm charts or YAML manifests from the WSO2 docs repository)
- Knowledge of:
    - API-M database schemas
    - Deployment patterns
    - Clustering requirements
    - Keystore and TLS configuration

## Architecture Overview

This deployment follows the standard WSO2 Kubernetes architecture, extended to use Azure-specific services:

- Envoy Gateway (Gateway API) exposes the APIs and portals
- Azure Database for PostgreSQL/MySQL hosts API Manager databases
- AKS manages the Kubernetes cluster and worker nodes
- Envoy Gateway Controller manages Gateway API resources

### Azure Deployment Architecture

<a href="{{base_path}}/assets/img/setup-and-install/azure-aks-deployment-architecture.png"><img src="{{base_path}}/assets/img/setup-and-install/azure-aks-deployment-architecture.png" alt="Azure deployment architecture overview" width="80%"></a>

### WSO2 API Manager Deployment Architecture

<a href="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png" alt="WSO2 API Manager deployment architecture" width="80%"></a>

## Step 1: Create and Prepare the AKS Cluster

If you do not have an existing AKS cluster, you can create one using `az aks create`.

!!! info
    If `az` CLI is not installed, refer to the [Azure CLI installation documentation](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) for setup instructions.

Create an AKS cluster with the following command:

```bash
az aks create \
  --name apim \
  --resource-group <RESOURCE_GROUP> \
  --location eastus \
  --nodepool-name apimng \
  --node-vm-size Standard_D4ds_v5 \
  --node-count 2 \
  --min-count 1 \
  --max-count 4 \
  --enable-cluster-autoscaler \
  --enable-addons monitoring \
  --generate-ssh-keys
```

!!! tip
    Adjust the `--location`, `--node-vm-size`, and node count parameters based on your requirements and expected load.

## Step 2: Install Envoy Gateway API Controller

WSO2 API Manager uses the Gateway API to route traffic to the cluster. You can install it and configure additional settings as needed via the `values.yaml` file by following the instructions in the [API-M Deployment with All-in-One HA Routing Controller Setup]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/am-pattern-1-all-in-one-ha/#step-4-install-a-routing-controller) guide.

## Step 3: Configure the Databases

WSO2 API Manager requires external databases to store API metadata, user data, and other configurations. Navigate to Azure Database for MySQL or Azure Database for PostgreSQL to create your preferred database instance.

!!! note
    WSO2 APIM supports MySQL, Microsoft SQL Server, PostgreSQL, Oracle, and DB2. This guide uses MySQL for simplicity.

### Create Database Instances

WSO2 APIM requires two databases:

- **apim_db** – Main API-M database
- **shared_db** – Common user and permission data

Connect to your Azure Database for MySQL/PostgreSQL instance and create the databases:

```sql
CREATE DATABASE apim_db;
CREATE DATABASE shared_db;
```

### Initialize Database Schemas

Download the WSO2 APIM distribution from the [official website](https://wso2.com/api-manager/). Once unzipped, you can find all the necessary SQL scripts within the `dbscripts` directory.

Execute the database scripts using the following commands:

```bash
mysql -h <DB_HOST> -P 3306 -u sharedadmin -p -Dshared_db < './dbscripts/mysql.sql'
mysql -h <DB_HOST> -P 3306 -u apimadmin -p -Dapim_db < './dbscripts/apimgt/mysql.sql'
```

Replace `<DB_HOST>` with your Azure Database for MySQL/PostgreSQL endpoint.

!!! warning
    Ensure that the database users have appropriate permissions and that the firewall rules allow connections from your AKS cluster.

## Step 4: Set Up Docker Images

The official WSO2 APIM Docker image does not include JDBC drivers. You need to build a custom image containing the necessary driver and push it to Azure Container Registry (ACR).

### Create a Custom Dockerfile

Create a `Dockerfile` with the following content:

```dockerfile
FROM registry.wso2.com/wso2-apim/am:4.7.0.0

ARG USER=wso2carbon
ARG USER_HOME=/home/${USER}
ARG WSO2_SERVER_NAME=wso2am
ARG WSO2_SERVER_VERSION=4.7.0
ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}

USER root

RUN curl -fSL https://repo1.maven.org/maven2/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar \
    -o ${WSO2_SERVER_HOME}/repository/components/lib/mysql-connector-j-8.0.33.jar \
    && chown wso2carbon:wso2 ${WSO2_SERVER_HOME}/repository/components/lib/mysql-connector-j-8.0.33.jar

USER wso2carbon
```

### Build and Push to ACR

Build the custom Docker image:

```bash
docker build -t wso2am-mysql:4.7.0 .
```

Tag and push the image to your ACR repository:

```bash
az acr login --name <ACR_NAME>

docker tag wso2am-mysql:4.7.0 <ACR_NAME>.azurecr.io/wso2am-mysql:4.7.0

docker push <ACR_NAME>.azurecr.io/wso2am-mysql:4.7.0
```

!!! note
    Replace `<ACR_NAME>` with your actual Azure Container Registry name. Ensure your ACR repository exists before pushing.

### Grant AKS Access to ACR

AKS needs pull access to your ACR. There are two ways to achieve this:

**Option 1 — Attach ACR to AKS (recommended)**

This is the preferred approach for AKS. It uses the cluster's managed identity and requires no credentials in your `values.yaml`:

```bash
az aks update \
  --name <AKS_CLUSTER_NAME> \
  --resource-group <RESOURCE_GROUP> \
  --attach-acr <ACR_NAME>
```

With this option, leave `imagePullSecrets.enabled: false` in `values.yaml` (the default).

**Option 2 — Kubernetes image pull secret**

If managed identity is not available, create a pull secret manually and reference it in the Helm chart:

```bash
kubectl create secret docker-registry acr-secret \
  --docker-server=<ACR_NAME>.azurecr.io \
  --docker-username=<SERVICE_PRINCIPAL_ID> \
  --docker-password=<SERVICE_PRINCIPAL_PASSWORD> \
  -n wso2
```

Then set the following in `values.yaml`:

```yaml
wso2:
  deployment:
    image:
      imagePullSecrets:
        enabled: true
        username: "<SERVICE_PRINCIPAL_ID>"
        password: "<SERVICE_PRINCIPAL_PASSWORD>"
```

## Step 5: Generate Keystore and Truststore

WSO2 APIM uses Java keystores for internal communication. While self-signed certificates are sufficient for internal traffic, you should use publicly trusted certificates for external communication.

### Locate Default Keystores

You can find the existing keystore and truststore in the WSO2 APIM distribution under the `/repository/resources/security/` directory.

### Create a New Keystore

Generate a new JKS keystore with the following command:

```bash
keytool -genkey -alias wso2carbon -keyalg RSA -keysize 2048 -validity 3650 \
  -keystore wso2carbon.jks \
  -dname "CN=<your-domain>, OU=MS,O=WSO2,L=Colombo,ST=Colombo,C=LK" \
  -ext san=dns:<your-domain>,dns:gateway.<your-domain>,dns:localhost \
  -storepass wso2carbon -keypass wso2carbon
```

!!! important
    WSO2 APIM currently only supports JKS keystores. Newer JDK versions default to PKCS12 format, so ensure you specify JKS explicitly when creating keystores.

### Import Certificate to Truststore

Import the certificate from the keystore into the client truststore:

```bash
keytool -export -keystore wso2carbon.jks -alias wso2carbon -storepass wso2carbon | \
  keytool -import -alias wso2carbonssl -keystore client-truststore.jks \
  -storepass wso2carbon -noprompt
```

Replace `<your-domain>` with your actual domain name.

## Step 6: Deploy Helm Charts

### Connect to AKS Cluster

Configure `kubectl` to connect to your AKS cluster:

```bash
az aks get-credentials --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME>
```

### Add WSO2 Helm Repository

Add the WSO2 Helm chart repository:

```bash
helm repo add wso2 https://helm.wso2.com && helm repo update
```

### Create Kubernetes Secret for Keystores

Create a Kubernetes secret to store the keystore and truststore files:

```bash
kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  -n <namespace>
```

Replace `<namespace>` with your target namespace (e.g., `wso2`).

### Configure values.yaml

Before deploying, set the mandatory internal encryption key under `wso2.apim.configurations.encryption.key`. If your deployment runs more than one API-M pod or instance, use the same key value across all of them. For more information, see [Configuring Encryption Key]({{base_path}}/install-and-setup/setup/security/encryption/symmetric-encryption/#generate-a-secret-key).

Create a `values.yaml` file with the following configuration:

```yaml
azure:
  enabled: true

kubernetes:
  gatewayAPI:
    enabled: true
    management:
      enabled: true
      hostname: "am.example.com"
    gateway:
      enabled: true
      hostname: "gw.example.com"
    websocket:
      enabled: true
      hostname: "websocket.example.com"
    websub:
      enabled: true
      hostname: "websub.example.com"

wso2:
  apim:
    configurations:
      encryption:
        key: "<generated-64-char-hex-key>"
      databases:
        type: "mysql"
        jdbc:
          driver: "com.mysql.cj.jdbc.Driver"
        apim_db:
          url: "jdbc:mysql://<DB_HOST>:3306/apim_db?useSSL=false"
          username: "apimadmin"
          password: "db_password"
        shared_db:
          url: "jdbc:mysql://<DB_HOST>:3306/shared_db?useSSL=false"
          username: "sharedadmin"
          password: "db_password"

      security:
        jksSecretName: "apim-keystore-secret"
        keystores:
          tls:
            enabled: true
            password: "wso2carbon"
            keyPassword: "wso2carbon"
        truststore:
          name: "client-truststore.jks"
          password: "wso2carbon"

  deployment:
    highAvailability: true
    image:
      registry: "<ACR_NAME>.azurecr.io"
      repository: "wso2am-mysql"
      tag: "4.7.0"
      digest: "sha256:your-image-digest"
      imagePullSecrets:
        enabled: false
        username: ""
        password: ""
```

!!! tip "Advanced Configuration"
    WSO2 APIM offers extensive configuration options. You can review the full `values.yaml` file in the [WSO2 Helm APIM repository](https://github.com/wso2/helm-apim). For example:

    - The chart uses Gateway API by default. To switch to a different ingress controller such as NGINX, disable Gateway API under `kubernetes.gatewayAPI` and configure the `kubernetes.ingress` section instead.
    - Setting `azure.enabled: true` (as shown above) enables Azure-specific Helm resources. It activates two optional sub-features:
        - **Azure Key Vault** — set `wso2.apim.secureVaultEnabled: true` and configure `azure.keyVault` (vault name, service principal, tenant ID, subscription, and secret identifiers) to use Azure Key Vault via the Secrets Store CSI driver instead of plain Kubernetes secrets.
        - **Azure File persistence** — set `wso2.deployment.persistence.solrIndexing.enabled: true` and configure `azure.persistence` (storage class, file share name, and secret name) to back Solr indexing data with an Azure File Share.
    - For production deployments, review and adjust resource requests, limits, and autoscaling parameters.

### Deploy the Helm Chart

Deploy WSO2 API Manager using Helm:

```bash
kubectl create namespace wso2

helm install apim wso2/wso2am-all-in-one \
  --version 4.7.0-1 \
  --namespace wso2 \
  -f values.yaml \
  --dependency-update
```

### Verify the Deployment

Check the deployment status:

```bash
kubectl get pods -n wso2
kubectl get svc -n wso2
```

Wait for all pods to be in the `Running` state before proceeding.

## Step 7: Configure Gateway and DNS

### Obtain the Load Balancer Address

Get the external address of the ingress:

```bash
kubectl get gateway -n wso2
```

Note the `ADDRESS` field, which will be the Azure Load Balancer DNS name.

### Configure DNS Records

Add DNS records (A or CNAME) in your DNS provider mapping your hostnames to the Load Balancer address:

- `am.example.com` → Azure Load Balancer DNS name
- `gw.example.com` → Azure Load Balancer DNS name
- `websocket.example.com` → Azure Load Balancer DNS name
- `websub.example.com` → Azure Load Balancer DNS name

!!! note
    If you're using Azure DNS, you can create alias records pointing to the Azure Load Balancer for better performance.

## Step 8: Access Management Consoles

Once DNS propagation is complete, you can access the API Manager consoles:

- **Publisher Portal**: `https://am.example.com/publisher`
- **Developer Portal**: `https://am.example.com/devportal`
- **Admin Portal**: `https://am.example.com/admin`
- **Carbon Console**: `https://am.example.com/carbon`
- **Gateway**: `https://gw.example.com`

!!! tip
    Default admin credentials are `admin/admin`. Change these immediately in a production environment.

## Troubleshooting

### Pods Not Starting

Check pod logs for errors:

```bash
kubectl logs <pod-name> -n wso2
kubectl describe pod <pod-name> -n wso2
```

### Database Connection Issues

Verify:

- Network security groups allow traffic from AKS to Azure Database
- Database credentials are correct in `values.yaml`
- Database schemas are properly initialized

### Gateway Not Working

Check:

- Envoy Gateway Controller is installed and running (`kubectl get pods -n envoy-gateway-system`)
- Gateway API resources are correctly created (`kubectl get gateway,httproute -n wso2`)
- Network security groups and subnet configurations are properly set

## Next Steps

- Set up [Rate Limiting]({{base_path}}/manage-apis/design/rate-limiting/introducing-throttling-use-cases/)
- Enable [Analytics]({{base_path}}/monitoring/api-analytics/analytics-overview/)

## See Also

- [Kubernetes Deployment Overview]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/kubernetes-overview/)
- [API-M Deployment with All-in-One HA Setup]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/am-pattern-1-all-in-one-ha/)
- [Envoy Gateway Documentation](https://gateway.envoyproxy.io/docs/)
