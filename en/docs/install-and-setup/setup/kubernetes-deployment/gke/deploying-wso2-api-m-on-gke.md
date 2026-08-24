# Deploying WSO2 API Manager on Google Cloud GKE

This guide provides a step-by-step approach to deploying WSO2 API Manager on Google Kubernetes Engine (GKE). This deployment follows the standard WSO2 Kubernetes architecture, extended to use Google Cloud-specific services such as Cloud SQL for databases and Artifact Registry for container image storage.

!!! info
    This deployment aligns with the standard deployment models described in [WSO2 API Manager Deployment Patterns]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/kubernetes-overview/#deployment-patterns) and [API-M Deployment with All-in-One HA Setup]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/am-pattern-1-all-in-one-ha/).

## Contents

- [Deploying WSO2 API Manager on Google Cloud GKE](#deploying-wso2-api-manager-on-google-cloud-gke)
  - [Contents](#contents)
  - [Prerequisites](#prerequisites)
    - [Google Cloud Requirements](#google-cloud-requirements)
    - [WSO2 Requirements](#wso2-requirements)
  - [Architecture Overview](#architecture-overview)
  - [Step 1: Create and Prepare the GKE Cluster](#step-1-create-and-prepare-the-gke-cluster)
  - [Step 2: Install Envoy Gateway API Controller](#step-2-install-envoy-gateway-api-controller)
  - [Step 3: Configure the Databases](#step-3-configure-the-databases)
    - [Create Database Instances](#create-database-instances)
    - [Initialize Database Schemas](#initialize-database-schemas)
  - [Step 4: Set Up Docker Images](#step-4-set-up-docker-images)
    - [Create a Custom Dockerfile](#create-a-custom-dockerfile)
    - [Build and Push to Artifact Registry](#build-and-push-to-artifact-registry)
    - [Grant GKE Access to Artifact Registry](#grant-gke-access-to-artifact-registry)
  - [Step 5: Generate Keystore and Truststore](#step-5-generate-keystore-and-truststore)
  - [Step 6: Deploy Helm Charts](#step-6-deploy-helm-charts)
    - [Connect to GKE Cluster](#connect-to-gke-cluster)
    - [Add WSO2 Helm Repository](#add-wso2-helm-repository)
    - [Create Kubernetes Secret for Keystores](#create-kubernetes-secret-for-keystores)
    - [Configure values.yaml](#configure-valuesyaml)
    - [Deploy the Helm Chart](#deploy-the-helm-chart)
    - [Verify the Deployment](#verify-the-deployment)
  - [Step 7: Configure Gateway and DNS](#step-7-configure-gateway-and-dns)
  - [Step 8: Access Management Consoles](#step-8-access-management-consoles)
  - [Troubleshooting](#troubleshooting)
  - [Next Steps](#next-steps)
  - [See Also](#see-also)

## Prerequisites

Before deploying WSO2 API Manager on Google Cloud GKE, ensure you have the following prerequisites in place:

### Google Cloud Requirements

- Google Cloud account with Project Owner, Editor, or equivalent IAM permissions
- Google Kubernetes Engine (GKE) cluster (or ability to create one)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [Helm](https://helm.sh/docs/intro/install/) installed locally
- [Google Cloud CLI (gcloud)](https://cloud.google.com/sdk/docs/install) configured with appropriate credentials
- [gke-gcloud-auth-plugin](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#install_plugin) installed for `kubectl` authentication with GKE
- Cloud SQL for PostgreSQL/MySQL provisioned

### WSO2 Requirements

- Access to WSO2 API Manager (APIM) Docker images
- Kubernetes deployment artifacts (Helm charts or YAML manifests from the WSO2 docs repository)
- Knowledge of:
    - API-M database schemas
    - Deployment patterns
    - Clustering requirements
    - Keystore and TLS configuration

## Architecture Overview

This deployment follows the standard WSO2 Kubernetes architecture, extended to use Google Cloud-specific services:

- Envoy Gateway (Gateway API) exposes the APIs and portals
- Cloud SQL for PostgreSQL/MySQL hosts API Manager databases
- GKE manages the Kubernetes cluster and worker nodes
- Envoy Gateway Controller manages Gateway API resources

## Step 1: Create and Prepare the GKE Cluster

If you do not have an existing GKE cluster, you can create one using `gcloud container clusters create`.

!!! info
    If the `gcloud` CLI is not installed, refer to the [Google Cloud CLI installation documentation](https://cloud.google.com/sdk/docs/install) for setup instructions.

Create a GKE cluster with the following command:

```bash
gcloud container clusters create apim-cluster \
  --project <PROJECT_ID> \
  --region us-central1 \
  --num-nodes 2 \
  --machine-type e2-standard-4 \
  --enable-autoscaling \
  --min-nodes 1 \
  --max-nodes 4
```

!!! tip
    Adjust the `--region`, `--machine-type`, and node count parameters based on your requirements and expected load.

## Step 2: Install Envoy Gateway API Controller

WSO2 API Manager uses the Gateway API to route traffic to the cluster. You can install it and configure additional settings as needed via the `values.yaml` file by following the instructions in the [API-M Deployment with All-in-One HA Routing Controller Setup]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/am-pattern-1-all-in-one-ha/#step-4-install-a-routing-controller) guide.

## Step 3: Configure the Databases

WSO2 API Manager requires external databases to store API metadata, user data, and other configurations. Navigate to Google Cloud SQL to create your preferred database instance.

!!! note
    WSO2 APIM supports MySQL, Microsoft SQL Server, PostgreSQL, Oracle, and DB2. This guide uses MySQL for simplicity.

### Create Database Instances

WSO2 APIM requires two databases:

- **apim_db** – Main API-M database
- **shared_db** – Common user and permission data

Connect to your Cloud SQL for MySQL/PostgreSQL instance and create the databases:

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

Replace `<DB_HOST>` with your Cloud SQL for MySQL/PostgreSQL private endpoint (recommended) or public endpoint.

!!! warning
    Ensure that the database users have appropriate permissions and that the authorized networks or Cloud SQL Auth Proxy settings allow connections from your GKE cluster.

## Step 4: Set Up Docker Images

The official WSO2 APIM Docker image does not include JDBC drivers. You need to build a custom image containing the necessary driver and push it to Google Artifact Registry.

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

### Build and Push to Artifact Registry

First, authenticate Docker with your Artifact Registry region:

```bash
gcloud auth configure-docker <REGION>-docker.pkg.dev
```

Build the custom Docker image:

```bash
docker build -t wso2am-mysql:4.7.0 .
```

Tag and push the image to your Artifact Registry repository:

```bash
docker tag wso2am-mysql:4.7.0 <REGION>-docker.pkg.dev/<PROJECT_ID>/<REPO_NAME>/wso2am-mysql:4.7.0

docker push <REGION>-docker.pkg.dev/<PROJECT_ID>/<REPO_NAME>/wso2am-mysql:4.7.0
```

!!! note
    Replace `<REGION>`, `<PROJECT_ID>`, and `<REPO_NAME>` with your actual Artifact Registry details. Ensure your repository exists before pushing.

### Grant GKE Access to Artifact Registry

GKE needs pull access to your Artifact Registry. If your GKE cluster uses the default compute service account, ensure it has the `Artifact Registry Reader` role:

```bash
gcloud projects add-iam-policy-binding <PROJECT_ID> \
    --member="serviceAccount:<PROJECT_NUMBER>-compute@developer.gserviceaccount.com" \
    --role="roles/artifactregistry.reader"
```

With this IAM binding, you can leave `imagePullSecrets.enabled: false` in `values.yaml`.

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

### Connect to GKE Cluster

Configure `kubectl` to connect to your GKE cluster:

```bash
gcloud container clusters get-credentials apim-cluster --region us-central1 --project <PROJECT_ID>
```

!!! note
    `gke-gcloud-auth-plugin` is required for this command to work. Install it with:
    ```bash
    gcloud components install gke-gcloud-auth-plugin
    ```

### Add WSO2 Helm Repository

Add the WSO2 Helm chart repository:

```bash
helm repo add wso2 https://helm.wso2.com && helm repo update
```

### Create Kubernetes Secret for Keystores

Create a Kubernetes secret to store the keystore and truststore files:

```bash
kubectl create namespace wso2

kubectl create secret generic apim-keystore-secret \
  --from-file=wso2carbon.jks \
  --from-file=client-truststore.jks \
  -n wso2
```

### Configure values.yaml

Before deploying, set the mandatory internal encryption key under `wso2.apim.configurations.encryption.key`. If your deployment runs more than one API-M pod or instance, use the same key value across all of them. For more information, see [Configuring Encryption Key]({{base_path}}/install-and-setup/setup/security/encryption/symmetric-encryption/#generate-a-secret-key).

Create a `values.yaml` file with the following configuration:

```yaml
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
      registry: "<REGION>-docker.pkg.dev"
      repository: "<PROJECT_ID>/<REPO_NAME>/wso2am-mysql"
      tag: "4.7.0"
      digest: "sha256:your-image-digest"
      imagePullSecrets:
        enabled: false
        username: ""
        password: ""
```

!!! tip "Advanced Configuration"
    WSO2 APIM offers extensive configuration options. You can review the full `values.yaml` file in the [WSO2 Helm APIM repository](https://github.com/wso2/helm-apim). For example:

      - The chart uses Gateway API by default. To switch to a different routing controller such as the native GKE Gateway Controller, the templated Gateway API resources can be disabled under `kubernetes.gatewayAPI`
      - Setting `gcp.enabled: true` in the helm-chart enables GCP-specific Helm resources. It activates two optional sub-features:
        - **GCP Secret Manager** — set `wso2.apim.secureVaultEnabled: true` and configure `gcp.secretsManager` (project ID, secret provider class, and the secret name and version under `secretEncryptionKey`) to use GCP Secret Manager via the Secrets Store CSI driver instead of plain Kubernetes secrets.
        - **GCP Filestore persistence** — set `wso2.deployment.persistence.solrIndexing.enabled: true` and configure `gcp.fs` (capacity, tier, network, location, and two separate fileshares under `gcp.fs.fileshares.carbonDB` and `gcp.fs.fileshares.solr` — each requiring a filestore name, fileshare name, and IP) to back both the CarbonDB and Solr indexed data with GCP Filestore instances.
    - For production deployments, review and adjust resource requests, limits, and autoscaling parameters.

### Deploy the Helm Chart

Deploy WSO2 API Manager using Helm:

```bash
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

Get the external IP address of the ingress:

```bash
kubectl get gateway -n wso2
```

Note the `ADDRESS` field, which will be the Google Cloud External IP address assigned to your Gateway.

### Configure DNS Records

Add DNS records (A records) in your DNS provider mapping your hostnames to the External IP address:

- `am.example.com` → Google Cloud External IP
- `gw.example.com` → Google Cloud External IP
- `websocket.example.com` → Google Cloud External IP
- `websub.example.com` → Google Cloud External IP

!!! note
    If you're using Cloud DNS, you can create A records pointing directly to the provisioned IP address.

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

- Network tags or Cloud SQL Auth Proxy are configured to allow traffic from GKE to Cloud SQL.
- Database credentials are correct in `values.yaml`.
- Database schemas are properly initialized.

### Gateway Not Working

Check:

- Envoy Gateway Controller is installed and running (`kubectl get pods -n envoy-gateway-system`).
- Gateway API resources are correctly created (`kubectl get gateway,httproute -n wso2`).
- VPC firewall rules and subnets are properly set up.

## Next Steps

- Set up [Rate Limiting]({{base_path}}/manage-apis/design/rate-limiting/introducing-throttling-use-cases/)
- Enable [Analytics]({{base_path}}/monitoring/api-analytics/analytics-overview/)

## See Also

- [Kubernetes Deployment Overview]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/kubernetes-overview/)
- [API-M Deployment with All-in-One HA Setup]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/am-pattern-1-all-in-one-ha/)
- [Envoy Gateway Documentation](https://gateway.envoyproxy.io/docs/)
