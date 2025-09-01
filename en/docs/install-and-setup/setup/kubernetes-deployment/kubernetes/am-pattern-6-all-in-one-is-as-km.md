# Pattern 6: API-M Deployment with IS as Key Manager

This deployment consists of a single API-M node with a single API-M runtime with IS configured as a third party key manager.


## Contents

- [Pattern 6: API-M Deployment with IS as Key Manager](#pattern-6-api-m-deployment-with-is-as-key-manager)
  - [Contents](#contents)
  - [Prerequisites](#prerequisites)
    - [Set Up Basic Configurations](#set-up-basic-configurations)
    - [Build WSO2 Identity Server Docker Image](#build-wso2-identity-server-docker-image)
    - [Configure WSO2 Identity Server as Key Manager](#configure-wso2-identity-server-as-key-manager)
  - [Minimal Configuration](#minimal-configuration)
  - [Further IS Customizations](#further-is-customizations)
  - [Configuration](#configuration)
    - [1. General Configuration of Helm Charts](#1-general-configuration-of-helm-charts)
        - [1.1 Add Ingress Controller](#11-add-ingress-controller)
        - [1.2 Mount Keystore and Truststore](#12-mount-keystore-and-truststore)
        - [1.3 Encrypting Secrets](#13-encrypting-secrets)
        - [1.4 Configure Docker Image and Databases](#14-configure-docker-image-and-databases)
        - [1.5 Configure SSL in Service Exposure](#15-configure-ssl-in-service-exposure)
    - [2. Add WSO2 Identity Server as Key Manager](#2-add-wso2-identity-server-as-key-manager)
    - [3. Add a DNS Record Mapping the Hostnames and the External IP](#3-add-a-dns-record-mapping-the-hostnames-and-the-external-ip)
    - [4. Access Management Consoles](#4-access-management-consoles)

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

### Set Up Basic Configurations

!!! info
    The following tools and configurations are necessary for deploying WSO2 API-M in a Kubernetes environment.

1. Install the required tools:
   - [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   - [Helm](https://helm.sh/docs/intro/install/)
   - [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

2. Ensure you have a running [Kubernetes cluster](https://kubernetes.io/docs/setup/).

3. Install the [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/).

4. Add the WSO2 Helm chart repository:
   ```bash
   helm repo add wso2 https://helm.wso2.com && helm repo update
   ```

### Build WSO2 Identity Server Docker Image

- This deployment pattern uses WSO2 Identity Server 7.x as a third-party Key Manager.
- Download the WSO2 Identity Server Docker image from [DockerHub](https://hub.docker.com/r/wso2/wso2is) or use the [WSO2 Private Docker Registry](https://docker.wso2.com/) if you have an active WSO2 subscription.
- Since WSO2 IS 7.x needs to be configured as a Key Manager for WSO2 API Manager, you need to create a custom Docker image with the necessary configurations and extensions.
- Below is a sample Dockerfile to build a custom WSO2 IS image for use as a Key Manager:

    ```dockerfile
    FROM docker.wso2.com/wso2is:7.1.0.0

    ARG USER=wso2carbon
    ARG USER_HOME=/home/${USER}
    ARG WSO2_SERVER_NAME=wso2is
    ARG WSO2_SERVER_VERSION=7.1.0
    ARG WSO2_SERVER=${WSO2_SERVER_NAME}-${WSO2_SERVER_VERSION}
    ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER}

    # Add notification event handler JAR for API Manager integration
    ADD --chown=wso2carbon:wso2 https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/km/ext/wso2is/wso2is.notification.event.handlers/2.0.5/wso2is.notification.event.handlers-2.0.5.jar ${WSO2_SERVER_HOME}/repository/components/dropins
    ```
 

- After building your custom Docker image, push it to your container registry so it can be accessed by your Kubernetes cluster:
  ```bash
  docker build -t CONTAINER_REGISTRY/wso2is:7.1.0.0 .
  docker push CONTAINER_REGISTRY/wso2is:7.1.0.0
  ```

### Configure WSO2 Identity Server as Key Manager

This section explains how to configure WSO2 Identity Server 7.x as a Key Manager for WSO2 API Manager. In this deployment pattern, both API Manager and Identity Server run as separate containerized applications in the Kubernetes cluster.

!!! info
    Before you begin:
    You need to import the public certificate of the WSO2 Identity Server 7.x to the truststore of the WSO2 API Manager, and vice-versa. For information on importing the certificates, see the [Importing certificates to the truststore](https://apim.docs.wso2.com/en/4.5.0/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) guide.

To configure WSO2 Identity Server 7.x to work as a Key Manager with WSO2 API Manager, you need to apply the following configurations:

1. Configure WSO2 Identity Server using the Helm chart's values.yaml file:

    ```yaml
        deploymentToml:
          extraConfigs: |
            [oauth]
            authorize_all_scopes = true

            [[resource.access_control]]
            context="(.*)/scim2/Me"
            secure=true
            http_method="GET"
            cross_tenant=true
            permissions=[]
            scopes=[]

            [[event_listener]]
            id = "token_revocation"
            type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
            name = "org.wso2.is.notification.ApimOauthEventInterceptor"
            order = 1
            [event_listener.properties]
            notification_endpoint = "https://<APIM_HOST>:<APIM_PORT>/internal/data/v1/notify"
            username = "${admin.username}"
            password = "${admin.password}"
            'header.X-WSO2-KEY-MANAGER' = "WSO2-IS"
    ```


## Minimal Configuration

If you want to quickly try out WSO2 API Manager with WSO2 Identity Server 7.x as a Key Manager on Kubernetes with minimal configuration, you can use the default values provided in the `default_values.yaml` file.

!!! info "Quick Start Configuration"
    This minimal configuration includes:
    
    - H2 database (embedded)
    - Default keystore and truststore
    - Basic settings for testing purposes

    **Note:** This configuration is ideal for development environments or quick evaluation but is not recommended for production use.

!!! info "Before you begin"

    You need to import the public certificate of the WSO2 Identity Server 7.x to the truststore of the WSO2 API Manager, and vice-versa. For information on importing the certificates, see the Importing certificates to the truststore guide.

    Follow the steps in the [1.2 Mount Keystore and Truststore](#12-mount-keystore-and-truststore) section to create a Kubernetes secret containing the keystore and truststore files. Here you will need two keystores: one for the API Manager and one for the Identity Server. The truststore should contain the public certificate of the Identity Server.

    - To add external keystores and truststores to IS, you can enable `externalJKS` and define the `secretName`
    - To add external keystores and truststores to API Manager, you can specify `jksSecretName`

- First download the IS values.yaml
```bash
helm show values wso2/identity-server --version next > default_values.yaml
```

- Update the IS `default_values.yaml` file with the above configurations.

- Deploy IS with minimal configuration using the following command:

```bash
helm install is wso2/identity-server --version next \
-f default_values.yaml
```

- Deploy API Manager with minimal configuration using the following command:

```bash
helm install apim wso2/wso2am-all-in-one --version 4.5.0-3 -f https://raw.githubusercontent.com/wso2/helm-apim/main/docs/am-pattern-0-all-in-one/default_values.yaml
```

Once the service is up and running, make sure you have the NGINX Ingress Controller deployed by following the steps outlined in the [Add Ingress Controller](#11-add-ingress-controller) section.

For this pattern, you will need to deploy both API Manager and Identity Server in your Kubernetes cluster. Configure the values files for both API Manager and Identity Server with the necessary settings and deploy them using Helm.

## Further IS Customizations

For advanced deployment scenarios and further customizations of WSO2 Identity Server on Kubernetes, refer to the [official WSO2 Identity Server Kubernetes deployment documentation](https://is.docs.wso2.com/en/next/deploy/deploy-is-on-kubernetes/). This guide covers topics such as:

- Customizing Helm chart values for production
- Enabling persistence and external databases
- Integrating with external identity providers
- Configuring monitoring and logging
- Scaling and high availability options

Review these resources to tailor your deployment to your specific requirements and production standards.

## Configuration

### 1. General Configuration of Helm Charts

The Helm charts for the API Manager deployment are available in the [WSO2 Helm Chart Repository](https://github.com/wso2/helm-apim/tree/4.5.x). You can either use the charts from the repository or clone the repository and use the charts from the local copy.

!!! note "Resource Naming Convention"
    The helm naming convention for APIM follows a simple pattern:
    ```
    <RELEASE_NAME>-<CHART_NAME>-<RESOURCE_NAME>
    ```

#### 1.1 Add Ingress Controller

The recommendation is to use [**NGINX Ingress Controller**](https://kubernetes.github.io/ingress-nginx/deploy/) suitable for your cloud environment or local deployment. Some sample annotations that could be used with the ingress resources are as follows.

  - The ingress class should be set to nginx in the ingress resource if you are using the NGINX Ingress Controller.
  - Following are some of the recommended annotations to include in the helm charts for ingresses. These may vary depending on the requirements. Please refer to the [documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/) for more information about the annotations.
  
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
  - You need to create a kubernetes secret including the certificate and the private key and include the name of the secret in the helm charts. This will be used for TLS termination in load balancer level by the ingress controller. Please refer to the [documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) for more information.
    ```
    kubectl create secret tls my-tls-secret --key <private key filename> --cert <certificate filename>
    ```

#### 1.2 Mount Keystore and Truststore

If you are not including the keystore and truststore in the Docker image, you can mount them using a Kubernetes secret. The following steps show how to mount the keystore and truststore using a Kubernetes secret.

- Create a keystore using the following command. Since WSO2 API Manager currently supports only JKS keystores, and newer Java versions default to generating PKCS keystores, we need to explicitly specify the store type as JKS.
  ```bash
  keytool -genkey -alias wso2carbon -keyalg RSA -keysize 2048 -validity 3650 -keystore wso2carbon.jks -storetype JKS -dname "CN=*.wso2.com, OU=MS,O=WSO2,L=Colombo,ST=Colombo,C=LK" -ext san=dns:am.wso2.com,dns:gw.wso2.com,dns:localhost -storepass wso2carbon -keypass wso2carbon
  ```

- Upload the newly created keystore certificate to the trust store.
  ```bash
  keytool -export -keystore wso2carbon.jks -alias wso2carbon -storepass wso2carbon | keytool -import -alias wso2carbonssl -keystore client-truststore.jks -storepass wso2carbon -noprompt
  ```
  You can locate the existing trust store at `repository/resources/security/client-truststore.jks`

- Create a Kubernetes secret with the keystore and truststore files. 
    + The secret should contain the primary keystore file, secondary keystore file, internal keystore file, and the truststore file. Note that the secret should be created in the same namespace in which you will be setting up the deployment.

    + Make sure to use the same secret name when creating the secret and when configuring the Helm chart.

    + If you are using a different keystore file name and alias, make sure to update the Helm chart configurations accordingly. In addition to the primary, internal keystores and truststore files, you can also include the keystores for HTTPS transport as well.

    + Refer to the following sample command to create the secret and use it in the APIM.
    ```bash
    kubectl create secret generic apim-keystore-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks --from-file=wso2internal.jks -n <namespace>
    ```

- Update the values.yaml file.
  ```yaml
  security:
      # -- Kubernetes secret containing the keystores and truststore
      jksSecretName: "jks-secret"
  ```

> By default, this deployment uses the default keystores and truststores provided by the relevant WSO2 product.
> For advanced details regarding managing custom Java keystores and truststores in a container-based WSO2 product deployment,
  please refer to the [official WSO2 container guide](https://github.com/wso2/container-guide/blob/master/deploy/Managing_Keystores_And_Truststores.md).


#### 1.3 Encrypting Secrets

The apictl can be used to encrypt passwords as in the below steps.
For further guidance, refer [Encrypting Secrets with apictl]({{base_path}}/install-and-setup/setup/api-controller/encrypting-secrets-with-ctl)

- Initialize the apictl using the trust store.
  ```bash
  apictl secret init
  ```

!!! example "Example"

    ```
    apictl secret init
    Enter Key Store location: /home/wso2am-4.5.0/repository/resources/security/wso2carbon.jks
    Enter Key Store password: 
    Enter Key alias: wso2carbon
    Enter Key password: 
    ```

    Response:

    ```
    Key Store initialization completed
    ```

- Encrypt the values listed below using the command,
  ```bash
    apictl secret create
  ```

    - admin_password
    - keystore_password
    - keystore_key_password
    - ssl_keystore_password
    - ssl_key_password
    - internal_keystore_password
    - internal_keystore_key_password
    - truststore_password
    - apim_db_password
    - shared_db_password

!!! example "Example"

    ```bash
    apictl secret create
    Enter plain alias for secret:db_password
    Enter plain text secret:
    Repeat plain text secret:
    ```

    Response:
    ```
    db_password : eKALmLVA+HFVl7vxxxxxxxxxxxxxxxxxxxxxxxxxxxjakhHN
    ```

- Replace all the above listed values with the encrypted values in the relevant fields of `values.yaml`.

- Enable secure vault by adding the following configuration.
  ```yaml
  # -- Secure vault enabled
  secureVaultEnabled: true
  ```

- If you have configured a cloud provider, enable it by adding the following configuration. 
  ```yaml
  aws:
    # -- If AWS is used as the cloud provider
    enabled: true

  ```

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

!!! info "SSL Configuration Best Practices"
    For WSO2 recommended best practices in configuring SSL when exposing internal services to outside of the Kubernetes cluster, refer to the [official WSO2 container guide](https://github.com/wso2/container-guide/blob/master/route/Routing.md#configuring-ssl).

    Proper SSL configuration is critical for securing API traffic and maintaining compliance with security standards.

### 2. Add WSO2 Identity Server as Key Manager

After setting up WSO2 Identity Server 7.x, you need to configure API Manager to use it as a Key Manager:

1. Access the API Manager Admin Portal: `https://<API-M-HOSTNAME>:9443/admin`

2. Navigate to **Key Managers** and click **Add Key Manager**.

3. Configure the Key Manager with the following settings:

   | Field | Value |
   |-------|-------|
   | Name | WSO2IS7 |
   | Display Name | WSO2 Identity Server 7 |
   | Key Manager Type | WSO2 Identity Server 7 |
   | Well-known URL | https://wso2is.km:9443/oauth2/token/.well-known/openid-configuration |
   | Issuer | https://wso2is.km:9443/oauth2/token |
   | Client Registration Endpoint | https://wso2is.km:9443/api/identity/oauth2/dcr/v1.1/register |
   | Introspection Endpoint | https://wso2is.km:9443/oauth2/introspect |
   | Token Endpoint | https://wso2is.km:9443/oauth2/token |
   | Display Token Endpoint | https://wso2is.km:9443/oauth2/token |
   | Revoke Endpoint | https://wso2is.km:9443/oauth2/revoke |
   | Display Revoke Endpoint | https://wso2is.km:9443/oauth2/revoke |
   | UserInfo Endpoint | https://wso2is.km:9443/scim2/Me |
   | Authorize Endpoint | https://wso2is.km:9443/oauth2/authorize |
   | Scope Management Endpoint | https://wso2is.km:9443/api/identity/oauth2/v1.0/scopes |
   | Certificate Type | JWKS |
   | JWKS URL | https://wso2is.km:9443/oauth2/jwks |
   | Username (connector config) | admin |
   | Password (connector config) | admin |
   | WSO2 Identity Server 7 API Resource Management Endpoint | https://wso2is.km:9443/api/server/v1/api-resources |
   | WSO2 Identity Server 7 Roles Endpoint | https://wso2is.km:9443/scim2/v2/Roles |
   | Create roles in WSO2 Identity Server 7 | Enable if needed |
   
4. For all these configurations to work correctly in Kubernetes, you must ensure proper service discovery between API Manager and Identity Server pods. Configure the necessary Kubernetes services and ingresses to enable communication between these components.

5. Update your Helm chart values to include the Identity Server deployment and services along with API Manager.

!!! note
    When using WSO2 IS 7.x as a Key Manager, note the following limitations:
    - Tenancy is not supported.
    - WSO2 IS 7.x cannot be set up as a Resident Key Manager. It can only be set up as a Third-party Key Manager.
    - Role creation in WSO2 Identity Server 7.x is supported from WSO2 API Manager 4.4.0.5 update level onwards.


### 3. Add a DNS record mapping the hostnames and the external IP

Obtain the external IP (EXTERNAL-IP) of the API Manager Ingress resources, by listing down the Kubernetes Ingresses.
```bash
kubectl get ing -n <NAMESPACE>
```

If the defined hostnames (in the previous step) are backed by a DNS service, add a DNS record mapping the hostnames and
the external IP (`EXTERNAL-IP`) in the relevant DNS service.

If the defined hostnames are not backed by a DNS service, for the purpose of evaluation you may add an entry mapping the
hostnames and the external IP in the `/etc/hosts` file at the client-side.

```
<EXTERNAL-IP> <kubernetes.ingress.management.hostname> <kubernetes.ingress.gateway.hostname> <kubernetes.ingress.websub.hostname> <kubernetes.ingress.websocket.hostname>
```

### 4. Access Management Consoles

- API Manager Publisher: `https://<kubernetes.ingress.management.hostname>/publisher`

- API Manager DevPortal: `https://<kubernetes.ingress.management.hostname>/devportal`

- API Manager Carbon Console: `https://<kubernetes.ingress.management.hostname>/carbon`

- Universal Gateway: `https://<kubernetes.ingress.gateway.hostname>`

- Identity Server Management Console: `https://<kubernetes.ingress.is.hostname>/carbon`
- Universal Gateway: `https://<kubernetes.ingress.gateway.hostname>`

- Identity Server Management Console: `https://<kubernetes.ingress.is.hostname>/carbon`


