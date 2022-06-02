# Component Certificates

Choreo Connect components use SSL certificates (public keys and private keys) for two main purposes.

1. Establish TLS connections
2. Component specific tasks

### Using certificates for Transport Layer Security

Transport Layer Security (TLS) is a point-to-point security mechanism that can be used for authentication, message integrity and confidentiality. Whether it is a HTTPS connection to an external entity or multiple gRPC connections among the Choreo Connect components, valid up-to-date digital certificates must exist in the locations referred by the components.

Each Choreo Connect component (Adapter, Enforcer, Router) has its own certificate location. By default, a set of certificates are already placed in these locations.

- Truststore (certificates trusted by the component) - `<CHOREO-CONNECT_HOME>/docker-compose/resources/<COMPONENT>/security/truststore`
- Keystore (private key certificates used for TLS) `<CHOREO-CONNECT_HOME>/docker-compose/resources/<COMPONENT>/security/keystore`

### Using certificates for component specific tasks

Certificates are also used for component specific purposes.

- The Enforcer uses its truststore for signature validation of JWTs and to connect to external Key Manager endpoints. Therefore, in this case the public certificate of the external Key Manager (Identity Provider) should be added to the Enforcer truststore.
- Adapter uses its certificates to connect to external entities such as the Control Plane, and Service Discovery entities.
- Although the router also has its truststore and keystore in the above mentioned locations, there is a special case when the above locations will not be referred. This is when connecting to backend services exposed by the APIs. For more information on how to add certificates of backend services, see [Backend Certificates]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/backend-certificates/#adding-certificates-to-specific-clusters).

As the certificates are used for different purposes, the certificate location referred for each purpose can be changed by editing the `config.toml` and the relevant Docker container volume mounts.

## Adding a certificate to a component truststore

To add a new certificate to a Choreo Connect component, the PEM formatted certificate must be added to the *truststore* location of that particular component.

1.  Convert the public certificate to a PEM format. For example,

    `openssl x509 -inform der -in public_certificate.cert -out certificate.pem`

2.  Add the certificate to the relevant component's resource folder.

    ``` tab="adapter"
    <CHOREO-CONNECT_HOME>/docker-compose/resources/adapter/security/truststore
    ```

    ``` tab="enforcer"
    <CHOREO-CONNECT_HOME>/docker-compose/resources/enforcer/security/truststore
    ```

    ``` tab="router"
    <CHOREO-CONNECT_HOME>/docker-compose/resources/router/security/truststore
    ```
        
3.  Restart the component.
   
    `docker restart <container_name>`
   

!!! info

    The certificate locations are configured as a volume mount for each component container in the `docker-compose.yaml` file as given below.

    ``` tab="adapter"
    volumes:
            - ../resources/adapter/security:/home/wso2/security
    ```

    ``` tab="enforcer"
    volumes:
            - ../resources/enforcer/security:/home/wso2/security
    ```

    ``` tab="router"
    volumes:
            - ../resources/router/security:/home/wso2/security
    ```

    This mounts both the key store and truststore locations to the container.


## Changing the private certificate of a component

Follow the instructions below to change the private certificate of a component:

1. Generate a new key pair for the component.
   
2. Copy the private key and certificate (in PEM format) into `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/keystore` directory.

    Example: 
    
    To change the private key of the Adapter component, copy the new certificate to  the `<CHOREO-CONNECT_HOME>/resources/adapter/security/keystore` directory.

3. If you change the private key file name, edit the corresponding configuration in the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/config.toml` or `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/config.toml` file. Otherwise, use the same name as `mg.pem` and `mg.key` for the new certificate and key.

4. Copy the public certificate (in PEM format) into the other two components. `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/truststore`

    Example: 
    
    Copy the certificate to `<CHOREO-CONNECT_HOME>/resources/enforcer/security/keystore` and `<CHOREO-CONNECT_HOME>/resources/router/security/keystore`

5. Restart the components.
