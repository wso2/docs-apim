# Backend Certificates

To connect to endpoints (backends) with TLS, the public certificate of the backend should be added as a trusted certificate to the router.

If the certificate is not provided explicitly, the Choreo Connect router will use the default trusted certificates stored in, `/etc/ssl/certs/ca-certificates.crt`.

## Configuration
The following are the default configurations for a Gateway instance. Add the following configuration block to `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/config.toml` or `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/config.toml` depending on the execution to change default values.

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
|router.upstream.tls|These are used to configure SSL properties for the upstream clusters (backend endpoints).|

| Sub Heading| Description                      | Default value|
|------------|----------------------------------|--------------|
|minimumProtocolVersion|The supported minimum tls version|`TLS1_1`|
|maximumProtocolVersion|The supported maximum tls version|`TLS1_2`|
|ciphers|List of ciphers to be used|`ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, ECDHE-ECDSA-AES128-SHA, ECDHE-RSA-AES128-SHA, AES128-GCM-SHA256, AES128-SHA, ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES256-SHA, ECDHE-RSA-AES256-SHA, AES256-GCM-SHA384, AES256-SHA`|
|trustedCertPath|The path where the trusted certificates are stored|`/etc/ssl/certs/ca-certificates.crt`|
|verifyHostName|Verify the backend hostname with the certificate SAN (Subject Alternative Name)|`true`|
|disableSslVerification|Disable SSL verification with backend clusters|`false`|

### Add a Certificate to Choreo Connect Router as a Trusted Certificate
Choreo Connect supports certificates in `pem` format. The trusted certificates are added as a single file that contains all the certificates.
To add a new certificate please follow the steps below.

!!!Important
    Mount the default certificate location of the Choreo Connect router in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect or choreo-connect-with-apim/docker-compose.yaml` file. This will allow modifying the certificates easily without logging in to the container.

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


## Adding Certificates to Specific Clusters

The above section explains how a certificate can be added to the Choreo Connect router's global trusted certificates. However, if the certificate should be added only to a specific API backend, it could be done as follows.

#### via API Manager

   Please follow [Adding a Certificate for an Endpoint]({{base_path}}/design/endpoints/certificates/#adding-a-certificate-for-an-endpoint)

#### via API CTL

1. Create a new API Project by following the [Importing APIs via Developer First Approach]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/)
2. Copy the backend certificate to `<API_PROJECT_HOME>/Endpoint-certificates` directory in PEM format.
3. Generate the Deployment directory for the API project following [Generating the Deployment Directory]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#generating-the-deployment-directory)
4. Following [Defining the parameters file for an API]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#defining-the-params-file-for-an-api), edit the params.yaml file in the generated deployment directory.
5. Bundle the generated Deployment directory with the project, [Bundling the generated directory before Import]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#bundling-the-generated-directory-before-import)
6. Deploy the API project into Choreo Connect [Deploy an API]({{base_path}}/install-and-setup/setup/api-controller/managing-choreo-connect/managing-choreo-connect-with-ctl/#deploy-an-api)
