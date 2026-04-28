# Pattern 0: API-M Deployment with All-in-One Setup

This deployment consists of a single API-M node with a single API-M runtime. You can use this pattern if you expect to receive low traffic to your deployment and do not need any high availability in your environment.

<a href="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png" alt="single-node api-m deployment" width="60%"></a>

!!! info
    For advanced details on the deployment pattern, please refer to the official [documentation](kubernetes-overview.md).

## Contents

- [Pattern 0: API-M Deployment with All-in-One Setup](#pattern-0-api-m-deployment-with-all-in-one-setup)
  - [Contents](#contents)
  - [Prerequisites](#prerequisites)
  - [Step 1 - Set Up Basic Configurations](#step-1---set-up-basic-configurations)
  - [Minimal Configuration](#minimal-configuration)
  - [Configuration](#configuration)
    - [1. General Configuration of Helm Charts](#1-general-configuration-of-helm-charts)
        - [1.1 Add Gateway API controller or Ingress controller](#11-add-gateway-api-controller-or-ingress-controller)
        - [1.2 Mount Keystore and Truststore](#12-mount-keystore-and-truststore)
        - [1.3 Configure Internal Encryption Key (Mandatory)](#13-configure-internal-encryption-key-mandatory)
        - [1.4 Encrypting Secrets (Cipher Tool and Secure Vault)](#14-encrypting-secrets-cipher-tool-and-secure-vault)
        - [1.5 Configure Docker Image and Databases](#15-configure-docker-image-and-databases)
        - [1.6 Configure SSL in Service Exposure](#16-configure-ssl-in-service-exposure)
    - [2. All-in-One Configurations](#2-all-in-one-configurations)
        - [2.1 Configure Multiple Gateways](#21-configure-multiple-gateways)
        - [2.2 Configure User Store Properties](#22-configure-user-store-properties)
        - [2.4 Configure JWKS URL](#24-configure-jwks-url)
        - [2.5 Deploy All-in-One](#25-deploy-all-in-one)
    - [3. Add a DNS Record Mapping the Hostnames and the External IP](#3-add-a-dns-record-mapping-the-hostnames-and-the-external-ip)
    - [4. Access Management Consoles](#4-access-management-consoles)

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

## Step 1 - Set Up Basic Configurations

!!! info
    The following tools and configurations are necessary for deploying WSO2 API-M in a Kubernetes environment.

1. Install the required tools:
   - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   - [Helm](https://helm.sh/docs/intro/install/)
   - [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

2. Ensure you have a running [Kubernetes cluster](https://kubernetes.io/docs/setup/).
3. Install a routing controller. Choose either:

    - **[Envoy Gateway](https://gateway.envoyproxy.io/docs/install/install-helm/)** (enabled by default) - **RECOMMENDED** (modern Gateway API-based routing)
    - **[NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)** (disabled by default) - **DEPRECATED** (traditional Ingress-based routing)

4. Add the WSO2 Helm chart repository:

   ```bash
   helm repo add wso2 https://helm.wso2.com && helm repo update
   ```

## Minimal Configuration

If you want to quickly try out WSO2 API Manager on Kubernetes with minimal configuration, you can use the default values provided in the `default_values.yaml` file.

!!! info "Quick Start Configuration"
    This minimal configuration includes:

    - H2 database (embedded)
    - Default keystore and truststore
    - Basic settings for testing purposes

    **Note:** This configuration is ideal for development environments or quick evaluation but is not recommended for production use.

Before running the Helm install command, set `wso2.apim.configurations.encryption.key` in the default values file.

- Create a namespace for the deployment

```bash
kubectl create namespace apim
```

- Install the Envoy Gateway as follows:

```bash
helm install envoy-gateway oci://docker.io/envoyproxy/gateway-helm \
  --version v1.7.0 -n envoy-gateway-system \
  --set config.envoyGateway.extensionApis.enableBackend=true \
  --set envoyGateway.gateway.experimentalFeatures.enabled=true \
  --create-namespace
```

- Apply the sample Gateway manifest to create Gateway and GatewayClass resources.

```bash
kubectl apply -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/assets/sample-gateway.yaml -n apim
```

- Deploy API Manager with minimal configuration using the following command.

```bash
helm install apim wso2/wso2am-all-in-one --version 4.7.0-1 -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/am-pattern-0-all-in-one/default_values.yaml -n apim
```

The Helm chart uses Gateway API by default. If you prefer Ingress instead, follow the steps in [1.1 Add Gateway API controller or Ingress controller](#11-add-gateway-api-controller-or-ingress-controller) to configure and enable it.

## Configuration

### 1. General Configuration of Helm Charts

The helm charts for the API Manager deployment are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.7.x). You can either use the charts from the repository or clone the repository and use the charts from the local copy.

!!! note "Resource Naming Convention"
    The helm naming convention for APIM follows a simple pattern:
    ```yaml
    <RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>
    ```

### 1.1 Add Gateway API controller or Ingress controller

You can use either **[Envoy Gateway](https://gateway.envoyproxy.io/docs/install/install-helm/)** (Gateway API-based) or **[NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)** (Ingress-based) for routing traffic to API Manager. By default, charts are configured to use Envoy Gateway. If you want to use NGINX Ingress Controller instead, disable Gateway API and enable Ingress in your Helm values.
> **Note:** It is recommended to use Gateway API with Envoy Gateway instead of NGINX Ingress Controller (Deprecated).

#### TLS Certificate Configuration (Required for both options)

Create a Kubernetes secret containing the TLS certificate and private key. This secret is used for TLS termination at the load balancer level.

```bash
kubectl create secret tls my-tls-secret --key <private key filename> --cert <certificate filename> -n <namespace>
```

If you use Gateway API, reference this secret in the TLS listeners of your Gateway manifest.
If you use NGINX Ingress Controller, set `tlsSecret` to this secret name in Helm values.

#### Option 1: Envoy Gateway (Gateway API-based approach) - RECOMMENDED

It is recommended to use Gateway API with Envoy Gateway instead of NGINX Ingress Controller. Gateway API provides a more expressive, extensible, and role-oriented API for configuring traffic routing in Kubernetes.

- Install Envoy Gateway.

  ```bash
  helm install envoy-gateway oci://docker.io/envoyproxy/gateway-helm \
    --version v1.7.0 -n envoy-gateway-system \
    --set config.envoyGateway.extensionApis.enableBackend=true \
    --set envoyGateway.gateway.experimentalFeatures.enabled=true \
    --create-namespace
  ```

- Create and apply Gateway and GatewayClass resources.

  ```bash
  kubectl apply -f <your-gateway-manifest> -n <namespace>
  ```

  Ensure that the hostnames and Gateway name in your created Gateway manifest match those configured in your Helm chart values. Additionally the TLS secret created above should be correctly referenced in the listeners of the Gateway resource for TLS termination.

- Create a ConfigMap containing the CA certificate for backend TLS verification and reference it under `backendTLSPolicy.caCertificateConfigMap` in the Helm chart values. This is required if you have enabled backend TLS verification in the Gateway configuration.
  > **Note:** A default ConfigMap with the name `wso2-ca-cert` is created when the `defaultConfigMapCreation` option is enabled in the values.yaml. This default ConfigMap uses the default certificates provided in the APIM truststore. However, for production deployments, it is recommended to create and manage the ConfigMap with the CA certificate yourself, and set `defaultConfigMapCreation` to false

  ```bash
  kubectl create configmap wso2-ca-cert --from-file=ca.crt=/path/to/your/certificate.pem -n <namespace>
  ```

- Update `values.yaml` to enable Gateway API and configure backend TLS policy.

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
  ```

- If you require further routing customizations, use [Gateway API Extensions](https://gateway.envoyproxy.io/docs/api/extension_types/) provided by Envoy.

#### Option 2: NGINX Ingress Controller (Ingress-based approach) - DEPRECATED

You can install the NGINX Ingress Controller using the official [Helm chart](https://kubernetes.github.io/ingress-nginx/deploy/)

Some sample annotations that can be used with Ingress resources are as follows:

- The ingress class should be `nginx` if you are using NGINX Ingress Controller.
- The following annotations can be included in Helm values for Ingress resources depending on requirements. Refer to [NGINX annotation documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) for details.

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

### 1.2 Mount Keystore and Truststore

- If you are not including the keystore and truststore into the docker image, you can mount them using a Kubernetes secret. Following steps shows how to mount the keystore and truststore using a Kubernetes secret.
- Create a Kubernetes secret with the keystore and truststore files. The secret should contain the primary keystore file, secondary keystore file, internal keystore file, and the truststore file. Note that the secret should be created in the same namespace in which you will be setting up the deployment.
- Make sure to use the same secret name when creating the secret and when configuring the helm chart.
- If you are using a different keystore file name and alias, make sure to update the helm chart configurations accordingly.
In addition to the primary, internal keystores and truststore files, you can also include the keystores for HTTPS transport as well.
- Refer the following sample command to create the secret and use it in the APIM.
  
  ```bash
  kubectl create secret generic apim-keystore-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks --from-file=wso2internal.jks -n <namespace>
  ```
  
> By default, this deployment uses the default keystores and truststores provided by the relevant WSO2 product.
> For advanced details with regards to managing custom Java keystores and truststores in a container based WSO2 product deployment
  please refer to the [official WSO2 container guide](https://github.com/wso2/container-guide/blob/master/deploy/Managing_Keystores_And_Truststores.md).

### 1.3 Configure Internal Encryption Key (Mandatory)

This section is for the internal encryption key (`wso2.apim.configurations.encryption.key`), which is mandatory and used by API Manager to encrypt and decrypt internal/shared data.

1. Generate a unique 256-bit secret key. If you use OpenSSL, the command will be as follows:

    ```bash
    openssl rand -hex 32
    ```

2. Add the generated key to the following location in your `values.yaml`:

    ```yaml
    wso2:
      apim:
        configurations:
          encryption:
            key: "<generated-64-char-hex-key>"
    ```

3. If secrets are encrypted using cipher tool and secure vault according to section 1.4, encrypt the generated internal encryption key and set the encrypted value to `wso2.apim.configurations.encryption.key`.

!!! warning
    **Distributed and Cloud Deployments**

    In a distributed or high-availability deployment, all API Manager instances must use the exact same internal encryption key (`wso2.apim.configurations.encryption.key`). Each instance encrypts and decrypts shared registry resources using this key, so a mismatch will cause decryption failures across the cluster. Configure the shared key on every node before the first startup.

### 1.4 Encrypting Secrets (Cipher Tool and Secure Vault)

- If you need to use the cipher tool to encrypt the passwords in the secret, first you need to encrypt the passwords using the cipher tool. The cipher tool can be found in the `bin` directory of the product pack. The following command can be used to encrypt the password:
  ```bash
  sh ciphertool.sh -Dconfigure -Dsymmetric -Dkey.based.encryption
  ```
- Also, the apictl can be used to encrypt passwords as well. Reference can be found in the [documentation]({{base_path}}/install-and-setup/setup/api-controller/encrypting-secrets-with-ctl/).
- Then, the encrypted values should be filled in the relevant fields of `values.yaml`.
- Since the encryption key is required to resolve the encrypted value at runtime, you need to store the value in the cloud provider's secret manager. You can use the cloud provider's secret store to store the encryption key. The following section can be used to add the cloud provider's credentials to fetch the encryption key. Configuration for AWS can be as below:
  ```yaml
  aws:
    secretsManager:
      secretIdentifiers:
        secretEncryptionKey:
          # -- AWS Secrets Manager secret name
          secretName: ""
          # -- AWS Secrets Manager secret key
          secretKey: ""
  ```
  > Please note that currently AWS, Azure, and GCP Secrets Managers are only supported for this.

!!! warning
    **Use the Same Secret Encryption Key Across All Nodes**

    If secure vault is enabled, all API-M nodes must use the same `secretEncryptionKey` reference and underlying key material. A mismatch will cause secret resolution and decryption failures across nodes.

!!! note
    These are two different keys serving distinct purposes. The internal encryption key (`wso2.apim.configurations.encryption.key`) defined in section 1.3 is **mandatory** and is used by API Manager for internal encryption of data such as registry resources and shared configuration. The secret encryption key (`secretEncryptionKey` under AWS/Azure/GCP) is a separate key used **only** when secure vault is enabled, allowing the runtime to fetch and decrypt secrets stored in a cloud provider's secret manager (which may itself include an encrypted copy of the internal encryption key).

### 1.5 Configure Docker Image and Databases

  - Add the following configurations to reflect the docker image created previously in the helm chart.
    
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
    > If you are using a **private Docker registry**, you must enable `imagePullSecrets.enabled` and provide the username and password.
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
    - If you need to change hostnames, update them under the Kubernetes Gateway API or Ingress section.
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
  
### 1.6 Configure SSL in Service Exposure

!!! info "SSL Configuration Best Practices"
    For WSO2 recommended best practices in configuring SSL when exposing internal services to outside of the Kubernetes cluster, refer to the [official WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

    Proper SSL configuration is critical for securing API traffic and maintaining compliance with security standards.


### 2. All-in-One Configurations

This section covers the specific configurations relevant to the All-in-One deployment pattern.

### 2.1 Configure Multiple Gateways

If you need to distribute the Gateway load that comes in, you can configure multiple API Gateway environments in WSO2 API Manager to publish to a single Developer Portal. [See more...](https://apim.docs.wso2.com/en/latest/manage-apis/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-through-multiple-api-gateways/)
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

### 2.2 Configure User Store Properties

You can configure user store properties as described in this [documentation](https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/working-with-properties-of-user-stores/):

```yaml
    userStore:
    # -- User store type.
    type: "database_unique_id"
    # -- User store properties
    properties:
        ReadGroups: true
```

!!! warning "Configuration Note"
    If you do not want to configure any of these properties, you must remove the `properties` block from the YAML file to prevent deployment issues.

For a complete list of available user store properties and their descriptions, refer to the [documentation](https://apim.docs.wso2.com/en/latest/administer/managing-users-and-roles/managing-user-stores/working-with-properties-of-user-stores/).

### 2.4 Configure JWKS URL
By default, for the super tenant, the Resident Key Manager's JWKS URL is set to `https://<HOSTNAME>:9443/oauth2/jwks`. If you are using a virtual host like `am.wso2.com` that is not globally routable, this URL will be incorrect. You can configure the correct JWKS URL for the super tenant using the Helm chart as shown below:

```yaml
wso2:
  apim:
    configurations:
      oauth_config:
        oauth2JWKSUrl: "https://localhost:9443/oauth2/jwks"
```

### 2.5 Deploy All-in-One

After configuring all the necessary parameters, you can deploy the All-in-One pattern using Helm:

1. Create a namespace for your deployment
2. Install the Helm chart with your custom configurations

```bash
# Create namespace for deployment
kubectl create namespace <namespace>

# Deploy API Manager using Helm
helm install <release-name> <helm-chart-path> \
  --version 4.7.0-1 \
  --namespace <namespace> \
  --dependency-update \
  -f values.yaml \
  --create-namespace
```

!!! tip "Deployment Parameters"
    - `<release-name>`: Choose a name for your release (e.g., `apim`)
    - `<namespace>`: Specify the Kubernetes namespace (e.g., `wso2`)
    - `<helm-chart-path>`: Path to the Helm chart (e.g., `./all-in-one` or use the repository URL)


### 3. Add a DNS record mapping the hostnames and the external IP

Obtain the external IP (`ADDRESS`) of Gateway API resources by listing Gateway objects.

```bash
kubectl get gateway -n <NAMESPACE>
```

If you are using Ingress instead of Gateway API, obtain the external IP from Ingress resources.

```bash
kubectl get ing -n <NAMESPACE>
```

Use the value from `ADDRESS` or `EXTERNAL-IP` as the external IP.

If the defined hostnames (in the previous step) are backed by a DNS service, add a DNS record mapping the hostnames and
the external IP in the relevant DNS service.

If the defined hostnames are not backed by a DNS service, for the purpose of evaluation you may add an entry mapping the
hostnames and the external IP in the `/etc/hosts` file at the client-side.

```yaml
<EXTERNAL-IP> <kubernetes.gatewayAPI.management.hostname> <kubernetes.gatewayAPI.gateway.hostname> <kubernetes.gatewayAPI.websub.hostname> <kubernetes.gatewayAPI.websocket.hostname>
```

### 4. Access Management Consoles

- API Manager Publisher: `https://<kubernetes.gatewayAPI.management.hostname>/publisher`

- API Manager DevPortal: `https://<kubernetes.gatewayAPI.management.hostname>/devportal`

- API Manager Carbon Console: `https://<kubernetes.gatewayAPI.management.hostname>/carbon`

- Universal Gateway: `https://<kubernetes.gatewayAPI.gateway.hostname>`

