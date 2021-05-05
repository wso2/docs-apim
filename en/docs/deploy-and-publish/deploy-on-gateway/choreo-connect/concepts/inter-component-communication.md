# Communnication between the Components

Communication between internal components of Choreo Connect (adapter, enforcer, router and apim control plane) are secured via mutual ssl.

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

For an example, if a new certificate (router/enforcer or control plane) needs to be added to the adapter component,

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
