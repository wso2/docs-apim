# Transport Security

Using secured backends with Choreo Connect

When using endpoints secured with self signed certificates, the public certificate of the backend should be added as trusted certificate to the router.

If the certificate is not provided explicitly, the Choreo Connect router will use the default trusted certificates stored in, `/etc/ssl/certs/ca-certificates.crt`.

## Configuration
The following are the default configurations for a gateway instance. Add the following configuration block to the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect or choreo-connect-with-apim/conf/config.toml` to change default values.

``` toml tab="config.toml"
    [router.upstream.tls]
        minimumProtocolVersion = "TLS1_1"
        maximumProtocolVersion = "TLS1_2"
        ciphers = "ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, ECDHE-ECDSA-AES128-SHA, ECDHE-RSA-AES128-SHA, AES128-GCM-SHA256, AES128-SHA, ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES256-SHA, ECDHE-RSA-AES256-SHA, AES256-GCM-SHA384, AES256-SHA"  
        # the default endpoint certificates
        trustedCertPath = "/etc/ssl/certs/ca-certificates.crt"
        verifyHostName = true
        disableSslVerification = false
```

|Heading|Description|
|-------|-----------|
|router.upstream.tls|These are used to configure SSL properties for the upstream cluters (backend endpoints).|

| Sub Heading| Description                      | Default value|
|------------|----------------------------------|--------------|
|minimumProtocolVersion|The supported minimum tls version|`TLS1_1`|
|maximumProtocolVersion|The supported maximum tls version|`TLS1_2`|
|ciphers|List of ciphers to be used|`ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, ECDHE-ECDSA-AES128-SHA, ECDHE-RSA-AES128-SHA, AES128-GCM-SHA256, AES128-SHA, ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES256-SHA, ECDHE-RSA-AES256-SHA, AES256-GCM-SHA384, AES256-SHA`|
|trustedCertPath|The path where the trusted certificates are stored|`/etc/ssl/certs/ca-certificates.crt`|
|verifyHostName|Verify the backend hostname with the certificate SAN (Subject Alternative Name)|`true`|
|disableSslVerification|Disable SSL verification with backend clusters|`false`|

### Add a Certificate to Choreo Connect Router as a Trusted Certificate
Choreo Connect supports certificates in `pem` format. The trusted certificates are added as a single file which contains all the certificates.
To add a new certificate please follow the steps below.

!!!Important
    Mount the default certificate location of the Choreo Connect router in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect or choreo-connect-with-apim/docker-compose.yaml` file. This will allow modifying the certificates easily without loggin to the container.

    ``` tab="Example"
    router:
        image: wso2/choreo-connect-router:0.9.1-SNAPSHOT
        logging:
        options:
            max-size: "20m"
            max-file: "5"
        environment:
        ...
        - ENFORCER_CA_CERT_PATH=/home/wso2/security/truststore/mg.pem
        volumes:
        - ../resources/router/security:/home/wso2/security
        - <PATH>/ca-certificates.crt:/etc/ssl/certs/ca-certificates.crt
    ```

    If you need to change the location of the volume mount, the `trustedCertPath` value in config.toml should also be changed.

1. Convert the certificate into pem format
 
    ```tab="Format"
        openssl x509 -in <INPUT CERTIFICATE> -out <OUT_PUT_FILE_NAME>.pem
    ```

    ```tab="Example"
    openssl x509 -in backend.cert -out backend.pem
    ```

2. Open the converted backend.pem file and copy the certificate content. (along with `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`)

3. Open the default certificate (the mounted certificate) and append the new certificate content and save the file.
4. Restart the Router container.
    `docker restart <router_container_name>`


## Adding Certificates to Specific Cluters

The above section explains how a certificate can be added to the Choreo Connect router's global trusted certificates. But, if the certificate should be adde only to a specific API backend, it could be done as follows.

#### via API Manager

   Please follow [Adding a Certificate for an Endpoint]({{base_path}}/design/endpoints/certificates/#adding-a-certificate-for-an-endpoint)

<!-- #### via API CTL project

    Please follow -->
## Securing Communnication between the Components

Communication between internal components of Choreo Connect (adapter, enforcer and router) are secured via mutual ssl.

Each component has it's private key and truststore and it's configured in against each component tag `config.toml` file as below.

```toml
    [adapter.keystore] 
    certPath = "/home/wso2/security/keystore/mg.pem"
    keyPath = "/home/wso2/security/keystore/mg.key"

    [adapter.truststore]
    location = "/home/wso2/security/truststore"
```

## Adding a Certificate to Adapter/ Enforcer Truststore

The trusted certificate location is configured as a volume mount for Adapter and Enforcer components in the docker-compose.yaml file as below.

``` tab="docker-compose.yaml"
volumes:
        - ../resources/adapter/security:/home/wso2/security
```

To add a new certificate Choreo Connect component, it should be done by adding the pem formated certificate to the truststore location of that particular component.

For an example, if a new certificate needs to be added to the adapter component,

1. The certificate should be converted to PEM formate if it is not.
2. Copy the PEM certificate into `<CHOREO-CONNECT_HOME>/resources/adapter/security/truststore` directory.
3. Restart the adapter container.

## Changing the Private Certificate of a Component
If it is required to change the private certificate of a component, follow the steps below.

1. Copy the private key and certificate (in PEM format) into `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/keystore` directory and `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/truststore` directory.

    Ex: To change the certificate of Adapter component, copy the new certificate to `<CHOREO-CONNECT_HOME>/resources/adapter/security/keystore` and `<CHOREO-CONNECT_HOME>/resources/adapter/security/truststore` directories.

2. If the certificate/ key name is changed, edit the corresponding configuration in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect or choreo-connect-with-apim/conf/config.toml` file. 

3. Copy the public certificate (in PEM format) into the other two components. `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/truststore`

    Ex: Copy the certificate to `<CHOREO-CONNECT_HOME>/resources/enforcer/security/keystore` and `<CHOREO-CONNECT_HOME>/resources/router/security/keystore`

4. Restart the components.
