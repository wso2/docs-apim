# Production Deployment Guideline

Kubernetes should be used for Choreo Connect production deployments. The common guidelines for deploying Choreo Connect in a production environment using the [Helm deployment option]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-deploy-overview/) provided below.

You can deploy Choreo Connect using one of the following options.

- [API Manager as Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)
- [Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)

This document walk you through following sections.

- [Common Configurations](#common-configurations) - Common for both Standalone Gateway and API Manager as Control Plane
- [Mode 1: API Manager as Control Plane Configurations](#mode-1-api-manager-as-control-plane-configurations)
- [Mode 2: Standalone Gateway Configurations](#mode-2-standalone-gateway-configurations)

## Common Configurations

### Configuring Keystore

By default, Choreo Connect ships with default keystore certificates, and it is recommended to replace them with Self-Signed or CA signed certificates.
Following steps describes steps to generate self-signed certificates and configure keystore of Choreo Connect Adapter, Enforcer and Router. If you have CA signed certificates you can skip *Step: 1* of the following.

#### Step 1: Generate self-signed certs in PEM format (Optional)

Generate Self-Signed certs in PEM format by executing following sample commands. Let's create a directory called `certs` to hold certificates for Adapter, Enforcer and Router.

```bash
mkdir -p certs/adapter certs/enforcer certs/router
```

```bash tab='Format'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=<COUNTRY_CODE>/ST=<STATE_NAME>/L=<LOCALITY_NAME>/O=<ORGANIZATION_NAME>/OU=<ORGANIZATION_UNIT_NAME>/CN=<COMMON_NAME>"\
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:<DNS1>,DNS:<DNS2>")) \
    -keyout <KEY_FILE_PATH> \
    -out <CERT_FILE_PATH>
```

```bash tab='Adapter Sample'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=US/ST=CA/L=Mountain View/O=WSO2, Inc./OU=Choreo Connect/CN=yourdomain.com" \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:adapter")) \
    -keyout certs/adapter/tls.key \
    -out certs/adapter/tls.crt
```

```bash tab='Enforcer Sample'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=US/ST=CA/L=Mountain View/O=WSO2, Inc./OU=Choreo Connect/CN=yourdomain.com" \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:enforcer")) \
    -keyout certs/enforcer/tls.key \
    -out certs/enforcer/tls.crt
```

```bash tab='Router Sample'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=US/ST=CA/L=Mountain View/O=WSO2, Inc./OU=Choreo Connect/CN=yourdomain.com" \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:router")) \
    -keyout certs/router/tls.key \
    -out certs/router/tls.crt
```

By default, **SSL Hostnames** for adapter and enforcer is `adapter` and `enforcer`, in case if you want to have your own SAN names in the certificates, update the following values in the helm release with the SAN names in the certificates.

{!includes/deploy/cc-prod-guide-helm-values-yaml-tip.md!}

```bash tab='Format'
wso2.deployment.adapter.security.sslHostname=<ADAPTER_HOST_NAME>
wso2.deployment.gatewayRuntime.enforcer.security.sslHostname=<ENFORCER_HOST_NAME>
```

```bash tab='Default Values'
wso2.deployment.adapter.security.sslHostname=adapter
wso2.deployment.gatewayRuntime.enforcer.security.sslHostname=enforcer
```

#### Step 2: Create Kubernetes TLS Secrets

Create TLS secrets in the namespace that you wish to install Choreo Connect. Following are sample commands to create TLS secrets for above generated cert files.

!!! Info
    Change the value `NAMESPACE_OF_CC=<NAMESPACE_OF_CC>` in following samples with the namespace that you wish to install Choreo Connect.

```bash tab='Format'
kubectl create secret tls <SECRET_NAME> -n <NAMESPACE_OF_CC> --cert=<CERT_PATH> --key=<KEY_PATH>
```

```bash tab='Adapter Sample'
kubectl create secret tls adapter-keystore -n $NAMESPACE_OF_CC --cert=certs/adapter/tls.crt --key=certs/adapter/tls.key
```

```bash tab='Enforcer Sample'
kubectl create secret tls enforcer-keystore -n $NAMESPACE_OF_CC --cert=certs/enforcer/tls.crt --key=certs/enforcer/tls.key
```

```bash tab='Router Sample'
kubectl create secret tls router-keystore -n $NAMESPACE_OF_CC --cert=certs/router/tls.crt --key=certs/router/tls.key
```

#### Step 3: Configure Secrets

You can set the keystore secrets in the same namespace that Choreo Connect is going to be installed. Set the following values.

{!includes/deploy/cc-prod-guide-helm-values-yaml-tip.md!}

```yaml tab='Format'
        keystore:
          key:
            secretName: <SECRET_NAME_1>
            subPath: <KEY_OF_THE_SECRET_CONTAINS_THE_CERT>
          cert:
            secretName: <SECRET_NAME_2>
            subPath: <KEY_OF_THE_SECRET_CONTAINS_THE_CERT>
```

```yaml tab='Adapter Keystore'
wso2:
  deployment:
    adapter:
      security:
        keystore:
          key:
            secretName: "adapter-keystore"
            subPath: "tls.key"
          cert:
            secretName: "adapter-keystore"
            subPath: "tls.crt"
```

```yaml tab='Enforcer Keystore'
wso2:
  deployment:
    gatewayRuntime:
      enforcer:
        security:
          keystore:
            key:
              secretName: "enforcer-keystore"
              subPath: "tls.key"
            cert:
              secretName: "enforcer-keystore"
              subPath: "tls.crt"
```

```yaml tab='Router Keystore'
wso2:
  deployment:
    gatewayRuntime:
      router:
        security:
          keystore:
            key:
              secretName: "router-keystore"
              subPath: "tls.key"
            cert:
              secretName: "router-keystore"
              subPath: "tls.crt"
```

When you update the Keystore of any component, the **Truststore of other components get updated automatically**, so **no need to update Truststore manually**.

### Configuring Truststore

You can explicitly mount certs to the truststore of each component.
The following is a sample how to define the truststore. If you have created a secret in **the same namespace** that Choreo Connect going to be installed, you can refer them in the config as follows.

{!includes/deploy/cc-prod-guide-helm-values-yaml-tip.md!}

```yaml tab='Format'
...:
      security:
        truststore:
          - secretName: <SECRET_NAME_1>
            subPath: <KEY_OF_THE_SECRET_CONTAINS_THE_CERT>
            mountAs: <FILE_NAME_OF_THE_MOUNTED_CERT>
          - secretName: <SECRET_NAME_2>
            subPath: <KEY_OF_THE_SECRET_CONTAINS_THE_CERT>
            mountAs: <FILE_NAME_OF_THE_MOUNTED_CERT>
```

```yaml tab='Adapter Truststore'
wso2:
  deployment:
    adapter:
      security:
        truststore:
          - secretName: "abc-certs"
            subPath: "tls.crt"
            mountAs: "tls.crt"
```

```yaml tab='Enforcer Truststore'
wso2:
  deployment:
    gatewayRuntime:
      enforcer:
        security:
          truststore:
            - secretName: "controlplane-cert"
              subPath: "wso2carbon.pem"
              mountAs: "wso2carbon.pem"
            - secretName: "abc-certs"
              subPath: "tls.crt"
              mountAs: "tls.crt"
```

!!! note
    You can use `mountAs` to have your own file name inside the container. For example, you can mount the cert `tls.crt` in the secret `abc-certs` as `abc-tls-cert.crt`. Refer to the following example values.yaml.

    ```yaml
    wso2:
      deployment:
        adapter:
          security:
            truststore:
              - secretName: "abc-certs"
                subPath: "tls.crt"
                mountAs: "abc-tls-cert.crt"
    ```

    If `mountAs` is not defined, the Helm chart will rename the file as `<secretName>-<subPath replace '.' with '-' >.pem`.

You can verify the cert is successfully mounted to the container by executing the following command.

```sh tab='Format'
NAMESPACE=<NAMESPACE>
kubectl exec -n "$NAMESPACE" \
    "$(kubectl get pod -n $NAMESPACE -l app.kubernetes.io/component=<COMPONENT_NAME> -o jsonpath='{.items[0].metadata.name}')" \
    -c <CONTAINER_NAME> -- ls -alh /home/wso2/security/truststore/
```

```yaml tab='Adapter Truststore'
NAMESPACE=<NAMESPACE>
kubectl exec -n "$NAMESPACE" \
    "$(kubectl get pod -n $NAMESPACE -l app.kubernetes.io/component=choreo-connect-adapter -o jsonpath='{.items[0].metadata.name}')" \
    -c choreo-connect-adapter -- ls -alh /home/wso2/security/truststore/
```

```yaml tab='Enforcer Truststore'
NAMESPACE=<NAMESPACE>
kubectl exec -n "$NAMESPACE" \
    "$(kubectl get pod -n $NAMESPACE -l app.kubernetes.io/component=choreo-connect-gateway-runtime -o jsonpath='{.items[0].metadata.name}')" \
    -c choreo-connect-enforcer -- ls -alh /home/wso2/security/truststore/
```

### Change Default Passwords

You can change the default passwords or environment variables by setting/overriding them by defining them in the field `envOverride`.
These passwords or environment variables can be set directly as a plain text or can be referenced from a Kubernetes Secret.
This configuration is the same way you can define environment variables in Kubernetes Pods.

In the following sample, the `enforcer_admin_pwd` is set using the `value` field and the `tm_admin_pwd` is referred using a secret. 

```yaml tab='Sample'
wso2:
  deployment:
    gatewayRuntime:
      enforcer:
        envOverride:
          - name: enforcer_admin_pwd
            value: admin
          - name: tm_admin_pwd
            valueFrom:
              secretKeyRef:
                name: my-secret
                key: tm_password
```

{!includes/deploy/cc-prod-guide-helm-values-yaml-tip.md!}

Following are the default values, update to read them from a Kubernetes secret.

```yaml tab='Adapter Defaults'
wso2:
  deployment:
    adapter:
      envOverride:
        - name: cp_admin_pwd
          value: admin
        - name: adapter_admin_pwd
          value: admin
```

```yaml tab='Enforcer Defaults'
wso2:
  deployment:
    gatewayRuntime:
      enforcer:
        envOverride:
          - name: apim_admin_pwd
            value: "admin"
          - name: enforcer_admin_pwd
            value: "admin"
          - name: tm_admin_pwd
            value: "admin"
```

### Configure Ingress Secrets

By default, the helm chart installation of Choreo Connect creates default certificates for ingress resources.
Providing TLS Secret name in the following values will replace those default certs with provided certs.

!!! Note
    These Ingress Secrets should be [TLS secrets](https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets)

```bash tab='Adapter Ingress'
wso2.deployment.adapter.ingress.tlsSecretName=<TLS_CERT_SECRET_IN_THE_SAME_NAMESPACE>
```

```bash tab='Router Ingress'
wso2.deployment.gatewayRuntime.router.ingress.tlsSecretName=<TLS_CERT_SECRET_IN_THE_SAME_NAMESPACE>
```

### Disable Test Token Issuer

Choreo Connect provides the ability to generate a JWT as a test key to access the APIs. It is recommended to disable the `/testkey` endpoint in the Production environments.
Refer the document [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt/) to read more about Test JWT.

Set the following value to `false` when installing the helm chart or set it in the values.yaml file.

{!includes/deploy/cc-prod-guide-helm-values-yaml-tip.md!}

```bash
wso2.deployment.gatewayRuntime.enforcer.security.testTokenIssuer.enabled=false
```

### Create Custom Docker Image (Optionally)

You can create your own docker image using Choreo Connect docker images as the base image.

For example lets say you want to replace the CA certificates of Choreo Connect Router with your own set of certificates.
Create a Dockerfile as follows.

```dockerfile tab='Format'
FROM wso2/choreo-connect-router:{{choreo_connect.version}}
<YOUR_DOCKER_COMMANDS>
```

```dockerfile tab='Sample'
FROM wso2/choreo-connect-router:{{choreo_connect.version}}
COPY my-ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
```

Make sure the files you are adding or copying (with commands `ADD` and `COPY`) exist in the context path.

```bash tab='Format'
docker build -t <IMAGE_NAME> -f <DOCKER_FILE_PATH> <CONTEXT>
```

```bash tab='Sample'
docker build -t myimages/choreo-connect-router:{{choreo_connect.version}} -f Dockerfile .
```

### Mount files into the Dropins Directory (Optional)

**Option 1**

If you are using Choreo Connect as a Kubernetes Helm deployment, you can mount the dropins directory by following the instructions below. 

  1. Create a configmap file to define the JAR that you are using with the Enforcer.

    ```bash
     kubectl create configmap configMapName1 --from-file=path/to/jar
    ```

  2. In the `values.yaml` file, update the `wso2.deployment.gatewayRuntime.enforcer.dropins` array with your configmap name(s).

    ```bash tab='Example'
     wso2:
        deployment:
            gatewayRuntime:
                enforcer:
                    dropins:
                        - configMapName1
                        - configMapName2
    ```

**Option 2**

Instead of mounting the JAR file to the dropins directory, you can burn JAR files to the Enforcer docker image. Details relevant to the building customize Enforcer image 
explained in [here.]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/production-deployment-guideline/#create-custom-docker-image-optionally)
After referring to the above explanation, follow the steps explained below considering the `values.yaml` file. 

  1. Set `wso2.deployment.gatewayRuntime.enforcer.dropinsMountEmptyDir` value as `false`. Otherwise, the dropins already in the Docker image will be replaced with a Kubernetes empty directory.
  2. Set `wso2.deployment.gatewayRuntime.enforcer.imageName` and `wso2.deployment.gatewayRuntime.enforcer.imageTag` values to match with your docker image.

## Mode 1: API Manager as Control Plane Configurations

The default deployment mode of the Choreo Connect is Standalone Mode. You can change it by specifying the value `wso2.deployment.mode` as `APIM_AS_CP`.
Then configure the externally installed WSO2 API Manager by updating the following values of the helm release.

```yaml tab='Format'
wso2:
  apim:
    controlPlane:
      # Hostname of the control plane
      hostName: <HOST_NAME_OF_THE_CONTROL_PLANE>
      # K8s service name (if in another namespace, `<serviceName>.<namespace>`) of the control plane
      serviceName: <K8S_SERVICE_NAME>.<K8S_NAMESPACE_OF_THE_CONTROL_PLANE>
    trafficManager:
      # K8s service name of the traffic manager. If not defined, default to control plane service name
      serviceName: <K8S_SERVICE_NAME>.<K8S_NAMESPACE_OF_THE_TRAFFIC_MANAGER>

  deployment:
    # Deployment option: one of "STANDALONE" or "APIM_AS_CP"
    # Refer deployment options: {{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-deploy-overview/
    mode: APIM_AS_CP
```

```yaml tab='Sample'
wso2:
  apim:
    controlPlane:
      # Hostname of the control plane
      hostName: am.wso2.com
      # K8s service name (if in another namespace, `<serviceName>.<namespace>`) of the control plane
      serviceName: wso2am-single-node-am-service.apim
    trafficManager:
      # K8s service name of the traffic manager. If not defined, default to control plane service name
      serviceName: ""

  deployment:
    # Deployment option: one of "STANDALONE" or "APIM_AS_CP"
    # Refer deployment options: {{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-deploy-overview/
    mode: "APIM_AS_CP"
```

Please follow the document about [Deploying Choreo Connect on Kubernetes With WSO2 API Manager as a Control Plane - Helm Artifacts]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-kubernetes-with-apim-as-control-plane-helm-artifacts/) for deploying Choreo Connect.

## Mode 2: Standalone Gateway Configurations

### Deploy APIs as Immutable Gateway

The API Controller `apictl` can be used to deploy APIs in the standalone mode. Those APIs deployed with `apictl` will be lost if the Adapter container restarts for any reason.
Hence, in a production deployment with the Standalone deployment option, it is recommand to create a custom docker image of Adapter by including the `apictl projects`.

#### Step 1: Create Projects

Follow the steps (step 1 and step 2) in the document [Deploy APIs as Immutable Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-apis-as-immutable-gateway/) to create an `apictl project`. You can include multiple `apictl projects`.

For example lets create a directory `apictl-projects-dir` and copy all `apictl projects` (`petstore` project for following sample) to this directory. These projects can be zip files, unzipped project directory or projects that are exported from WSO2 API Manager.

```bash tab='Sample'
mkdir apictl-projects-dir
cp -r petstore/ apictl-projects-dir/petstore
```

#### Step 2: Create Custom Adapter Docker Image
Create a Dockerfile as follows.

```dockerfile tab='Format'
FROM wso2/choreo-connect-adapter:{{choreo_connect.version}}
COPY <DIR_WITH_APICTL_PROJECTS> /home/wso2/artifacts/apis
```

```dockerfile tab='Sample'
FROM wso2/choreo-connect-adapter:{{choreo_connect.version}}
COPY apictl-projects-dir /home/wso2/artifacts/apis
```

Make sure the files you are adding or copying (with commands `ADD` and `COPY`) exist in the context path.

```bash tab='Format'
docker build -t <IMAGE_NAME> -f <DOCKER_FILE_PATH> <CONTEXT>
```

```bash tab='Sample'
docker build -t myimages/choreo-connect-adapter-petstore:{{choreo_connect.version}} -f Dockerfile .
```

#### Step 3: Update Adapter Docker Image Name

Update the following values in the helm release with the Adapter docker image, image pull secrets. You can separate each gateway environments by specifying the value `wso2.deployment.labelName`.

{!includes/deploy/cc-prod-guide-helm-values-yaml-tip.md!}

!!! important
    Make sure to set `wso2.deployment.adapter.apiArtifactsMountEmptyDir=false`. This field is available from Helm chart version `1.1.0.5`.

```yaml tab='Format'
wso2:
  deployment:
    # Label (environment) name of the deployment
    labelName: "<ENVIRONMENT_LABEL_NAME>"
    # If a custom image must be used, define the docker registry. Default to DockerHub. If subscription specified it will be "docker.wso2.com"
    dockerRegistry: "<DOCKER_REGISTRY>"
    # Image pull secrets to pull images from docker registry. If subscriptions are specified a secret with subscriptions details are created and imagePullSecrets will be default to it.
    imagePullSecrets: <LIST_OF_PULL_SECRETS>

    adapter:
      # Docker registry. If this value is not empty, this overrides the value in 'wso2.deployment.dockerRegistry'
      dockerRegistry: <DOCKER_REGISTRY_FOR_ADAPTER>
      # Image name for adapter
      imageName: "<ADAPTER_IMAGE_NAME>"
      # Image tag for adapter
      imageTag: "<IMAGE_TAG>"
      # Refer to the Kubernetes documentation on updating images (https://kubernetes.io/docs/concepts/containers/images/#updating-images)
      imagePullPolicy: <IMAGE_PULL_POLICY>
      # Mount an empty directory on API artifacts directory
      apiArtifactsMountEmptyDir: false
```

```yaml tab='Sample'
wso2:
  deployment:
    # Label (environment) name of the deployment
    labelName: "default"
    # If a custom image must be used, define the docker registry. Default to DockerHub. If subscription specified it will be "docker.wso2.com"
    dockerRegistry: ""
    # Image pull secrets to pull images from docker registry. If subscriptions are specified a secret with subscriptions details are created and imagePullSecrets will be default to it.
    imagePullSecrets: []

    adapter:
      # Docker registry. If this value is not empty, this overrides the value in 'wso2.deployment.dockerRegistry'
      dockerRegistry: "myimages"
      # Image name for adapter
      imageName: "choreo-connect-adapter-petstore"
      # Image tag for adapter
      imageTag: "{{choreo_connect.version}}"
      # Refer to the Kubernetes documentation on updating images (https://kubernetes.io/docs/concepts/containers/images/#updating-images)
      imagePullPolicy: IfNotPresent
      # Mount an empty directory on API artifacts directory
      apiArtifactsMountEmptyDir: false
```

#### Step 4: Disable the Adapter Rest API

Since we want to make our gateway immutable, we can disable the Adapter Rest API which is used by the `apictl` communicate the Choreo Connect to
deploy, undeploy APIs. Update the following value of the helm release for that purpose.

{!includes/deploy/cc-prod-guide-helm-values-yaml-tip.md!}

```bash
wso2.deployment.adapter.security.adapterRestService.enabled="false"
```

!!! Note
    The above value is in String type which is one of `"default"`,  `"true"` or `"false"`. It is not a Boolean value.

#### Step 5: Deploy Choreo Connect

Follow the document on [Deploying Choreo Connect as a Standalone Gateway on Kubernetes - Helm Artifacts]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-kubernetes-helm-artifacts/) to deploy Choreo Connect.

### Applying config changes into a running instance of Choreo Connect 

When you have to deploy a config change to the Choreo Connect running on production environment, we recommand you to complete the following steps in order.

!!! Attention
    You must follow this, if the config change is related to the **Enforcer** as the `enforcer` fetches configs from the Adapter only at the startup.

Steps:

1. Do the config change and first [rollout restart](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#updating-resources) the Adapter.
2. After all the replicas of the Adapter pod have been started and are ready, [rollout restart](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#updating-resources) the Enforcer & Router (`choreo-connect-deployment`).
