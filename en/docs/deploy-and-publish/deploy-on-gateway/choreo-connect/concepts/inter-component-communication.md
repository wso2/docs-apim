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
