# Communnication between the Components

Communication between internal components of Choreo Connect (Adapter, Enforcer, Router and API-M control plane) are secured via mutual ssl.

Each component has its private-public key pair and truststore. In the adapter's case, it is configured using the `config.toml` file as indicated below.

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

    E.g., To change the certificate of Adapter component, copy the new certificate to `<CHOREO-CONNECT_HOME>/resources/adapter/security/keystore` directory.

3. If the certificate/ key name is changed, edit the corresponding configuration in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect or choreo-connect-with-apim/conf/config.toml` file. Otherwise, use the same name as `mg.pem` and `mg.key` for the new certificate and key.

4. Copy the public certificate (in PEM format) into the other two components. `<CHOREO-CONNECT_HOME>/resources/<COMPONENT>/security/truststore`

    E.g., Copy the certificate to `<CHOREO-CONNECT_HOME>/resources/enforcer/security/keystore` and `<CHOREO-CONNECT_HOME>/resources/router/security/keystore`

5. Restart the components.
