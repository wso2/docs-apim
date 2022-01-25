# Production Deployment Guideline

Given below are the common guidelines for deploying Choreo Connect in a **production environment** using [Helm deployment option](http://localhost:8000/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-deploy-overview/).

## Configuring Keystore

By default, Choreo Connect ships with default keystore certificates, and it is recommended to replace them with Self-Signed or CA signed certificates.

### Setep 1: Generate Self-Signed certs in PEM format

Generate Self-Signed certs in PEM format by executing following sample commands. Let's create a directory called `certs`.

```shell
mkdir -p certs/adapter certs/enforcer certs/router
```

```shell tab='Format'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=<COUNTRY_CODE>/ST=<STATE_NAME>/L=<LOCALITY_NAME>/O=<ORGANIZATION_NAME>/OU=<ORGANIZATION_UNIT_NAME>/CN=<COMMON_NAME>"\
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:<DNS1>,DNS:<DNS2>")) \
    -keyout <KEY_FILE_PATH> \
    -out <CERT_FILE_PATH>
```

```shell tab='Adapter Sample'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=US/ST=CA/L=Mountain View/O=WSO2, Inc./OU=Choreo Connect/CN=yourdomain.com" \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:adapter")) \
    -keyout certs/adapter/tls.key \
    -out certs/adapter/tls.crt
```

```shell tab='Enforcer Sample'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=US/ST=CA/L=Mountain View/O=WSO2, Inc./OU=Choreo Connect/CN=yourdomain.com" \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:enforcer")) \
    -keyout certs/enforcer/tls.key \
    -out certs/enforcer/tls.crt
```

```shell tab='Router Sample'
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 \
    -subj "/C=US/ST=CA/L=Mountain View/O=WSO2, Inc./OU=Choreo Connect/CN=yourdomain.com" \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:router")) \
    -keyout certs/router/tls.key \
    -out certs/router/tls.crt
```

By default, SSL Hostnames for adapter and enforcer is `adapter` and `enforcer`, in case if you want to have your own SAN names in the certificates, update the following values in helm chart with the SAN names in the certificates.

```shell
wso2.deployment.adapter.security.sslHostname=<ADAPTER_HOST_NAME>
wso2.deployment.gatewayRuntime.enforcer.security.sslHostname=<ENFORCER_HOST_NAME>
```

### Step 2: Create Kubernetes TLS Secrets

Create TLS secrets in the namespace that you wish to install Choreo Connect. Following are sample commands to create TLS secrets for above generated cert files.

!!! note
    Change the value `NAMESPACE_OF_CC=<NAMESPACE_OF_CC>` in following samples with the namespace that you wish to install Choreo Connect.

```shell tab='Format'
kubectl create secret tls <SECRET_NAME> -n <NAMESPACE_OF_CC> --cert=<CERT_PATH> --key=<KEY_PATH>
```

```shell tab='Adapter Sample'
kubectl create secret tls adapter-keystore -n $NAMESPACE_OF_CC --cert=certs/adapter/tls.crt --key=certs/adapter/tls.key
```

```shell tab='Enforcer Sample'
kubectl create secret tls enforcer-keystore -n $NAMESPACE_OF_CC --cert=certs/enforcer/tls.crt --key=certs/enforcer/tls.key
```

```shell tab='Router Sample'
kubectl create secret tls router-keystore -n $NAMESPACE_OF_CC --cert=certs/router/tls.crt --key=certs/router/tls.key
```

### Step 3: Configure Secrets

You can set the keystore secrets in the same namespace that Choreo Connect is going to be installed. Set the following values.

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

When you update the Keystore of any component, the **Truststore of other components get updated automatically**,
so no need to update Truststore manually.

## Configuring Truststore

You can explicitly mount certs to the truststore of each component.
The following is a sample how to define the truststore. If you have created a secret in the same namespace that Choreo Connect going to be installed, you can refer them in the config as follows.

```yaml tab='Format'
...:
      security:
        truststore:
          - secretName: <SECRET_NAME_1>
            subPath: <KEY_OF_THE_SECRET_CONTAINS_THE_CERT>
          - secretName: <SECRET_NAME_2>
            subPath: <KEY_OF_THE_SECRET_CONTAINS_THE_CERT>
```

```yaml tab='Adapter Truststore'
wso2:
  deployment:
    adapter:
      security:
        truststore:
          - secretName: "abc-certs"
            subPath: "tls.crt"
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
            - secretName: "abc-certs"
              subPath: "tls.crt"
```

## Change Default Passwords

You can change the default passwords or environment variables by setting/overriding them by defining them in the field `envOverride`.
These passwords or environment variables can be set directly as a plain text or can be referenced from a Secret or ConfigMap.
This configuration is the same way you can define environment variables in Kubernetes Pods.

In the following sample, the `enforcer_admin_pwd` is set using the `value` field and the `tm_admin_pwd` is referred using a secret. 

```yaml
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

Following are the default values, update to read them from a Kubernetes secret.

```yaml tab='Adapter'
wso2:
  deployment:
    adapter:
      envOverride:
        - name: cp_admin_pwd
          value: admin
        - name: adapter_admin_pwd
          value: admin
```

```yaml tab='Enforcer'
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

## Configure Ingress Secrets

By default, the helm chart installation of Choreo Connect creates default certificates for ingress resources.
Providing TLS Secret name in the following values will replace those default certs with provided certs.

!!! Note
    Following certs should be [TLS secrets](https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets)

```shell tab='Adapter Ingress'
wso2.deployment.adapter.ingress.tlsSecretName=<TLS_CERT_SECRET_IN_THE_SAME_NAMESPACE>
```

```shell tab='Gateway Ingress'
wso2.deployment.gatewayRuntime.router.ingress.tlsSecretName=<TLS_CERT_SECRET_IN_THE_SAME_NAMESPACE>
```

## Disable Test Token Issuer

Choreo Connect provides the ability to generate a JWT as a test key to access the APIs. It is recommended to disable the `/testkey` endpoint in the Production environments.
Refer the document [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt/) to read more about Test JWT.

Set the following value to `false` when installing the helm chart or set it in the values.yaml file.

```shell
wso2.deployment.gatewayRuntime.enforcer.security.testTokenIssuer.enabled=false
```

## Create Custom Docker Image

You can create your own docker image using Choreo Connect docker images as the base image.

For example lets say you want to replace the CA certificates of Choreo Connect Router with your own set of certificates.
Create a Dockerfile as follows.

```dockerfile tab='Format'
FROM wso2/choreo-connect-router:1.0.0
<YOUR_DOCKER_COMMANDS>
```

```dockerfile tab='Sample'
FROM wso2/choreo-connect-router:1.0.0
COPY my-ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
```

Make sure the files you are adding or copying (with commands `ADD` and `COPY`) exist in the context path.

```shell tab='Format'
docker build -t <IMAGE_NAME> -f <DOCKER_FILE_PATH> <CONTEXT>
```

```shell tab='Sample'
docker build -t myimages/choreo-connect-router:1.0.0 -f Dockerfile .
```
