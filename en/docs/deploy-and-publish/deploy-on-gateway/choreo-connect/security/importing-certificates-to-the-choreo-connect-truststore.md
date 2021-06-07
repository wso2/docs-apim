# Importing Certificates to the API Choreo Connect Truststore

For signature validation of JWTs and to connect to external key manager endpoints, the public certificate of the external key manager should be added to the Choreo Connect Enforcer.

Follow the steps below to add a new certificate to the enforcer trusted certs.

1.  Convert the public certificate to a PEM format. For example,

    `openssl x509 -inform der -in public_certificate.cert -out certificate.pem`

2.  Add the certificate to the relevant components resource folder `<CHOREO-CONNECT_HOME>/docker-compose/resources/<component>/security/truststore` directory.

    !!! note
        For signature validation of JWTs, you need to add the public certificate of the Identity Provider to the truststore of the API Choreo Connect. 
        Therefore add public certificate of identity provider in PEM format to `<CHOREO-CONNECT_HOME>/docker-compose/resources/enforcer/security/truststore` directory.
        
3.  Restart the component.
   
   `docker restart choreo-connect_enforcer_1`
   
## Adding a Certificate to Adapter Truststore

The trusted certificate location is configured as a volume mount for Adapter in the docker-compose.yaml file as below.

``` tab="docker-compose.yaml"
volumes:
        - ../resources/adapter/security:/home/wso2/security
```

This mounts both the key store and truststore locations to the container.

To add a new certificate Choreo Connect component, it should be done by adding the pem formated certificate to the *truststore* location of that particular component.

For an example, if a new certificate (router/enforcer or control plane) needs to be added to the adapter component,

1. The certificate should be converted to PEM formate if it is not.
2. Copy the PEM certificate into `<CHOREO-CONNECT_HOME>/resources/adapter/security/truststore` directory.
3. Restart the adapter container.

## Changing the Private Certificate of a Component
If it is required to change the private certificate of a component, follow the steps below.

1. Generate a new key pair for the component.
   
2. Copy the private key and certificate (in PEM format) into `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/keystore` directory.

    Ex: To change the certificate of Adapter component, copy the new certificate to `<CHOREO-CONNECT_HOME>/resources/adapter/security/keystore` directory.

3. If the certificate/ key name is changed, edit the corresponding configuration in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect or choreo-connect-with-apim/conf/config.toml` file. Otherwise, use the same name as `mg.pem` and `mg.key` for the new certificate and key.

4. Copy the public certificate (in PEM format) into the other two components. `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/truststore`

    Ex: Copy the certificate to `<CHOREO-CONNECT_HOME>/resources/enforcer/security/keystore` and `<CHOREO-CONNECT_HOME>/resources/router/security/keystore`

5. Restart the components.
