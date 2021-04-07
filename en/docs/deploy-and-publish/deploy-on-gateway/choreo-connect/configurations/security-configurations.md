# Security configurations in config.toml

The following are the configurations with regard to security. The configuration file ( `config.toml` ) for the Choreo Connect is located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory.


   | Heading                     | Description                                                                          |
    |-----------------------------------|--------------------------------------------------------------------------------------|
    | `security.adapter`              | The configurations required for adapter to provide API authorization security for Choreo Connect and the backend. By default `enableOutboundAuthHeader` is false which removes the authorization header from the backend request.  `authorizationHeader` configuration defines the authorization header expected by the Choreo Connect. It can be overridden at API level using the `x-auth-header` extension.                       |
    | `security.enforcer`                    | The configurations required for enforcer to apply API management security. |
    | `security.enforcer.tokenService`                    | `tokenService` defines the configuration required to JWT token authorization. You can provide multiple JWT issuers. When the Choreo Connect connects with WSO2 API Manager, the tokenService configurations defined at config.toml are overridden by the APIM keymanager configurations receiving through the add/update events, if the same token service persists in both side. But for the delete events will not be proceed, if it still persists in config.toml |

### Sample

The following is a sample security configurations.

``` java
[security]

[security.adapter]
  enableOutboundAuthHeader = false
  authorizationHeader = "authorization"

[security.enforcer]
# Issuer 1
[[security.enforcer.tokenService]]
  name="Resident Key Manager"
  issuer = "https://localhost:9443/oauth2/token"
  certificateAlias = ""
  # URL of the JWKs endpoint
  jwksURL = ""
  # Validate subscribed APIs
  validateSubscription = false
  # The claim in which the consumer key of the application is coming
  consumerKeyClaim = "azp"
  # Certificate Filepath within enforcer
  certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"

# Issuer 2
[[security.enforcer.tokenService]]
    name="MGW"
    issuer = "https://localhost:9095/testkey"
    certificateAlias = "mgw"
    # URL of the JWKs endpoint
    jwksURL = ""
    # Validate subscribed APIs
    validateSubscription = false
    # The claim in which the consumer key of the application is coming
    consumerKeyClaim = ""
    # Certificate Filepath within enforcer
    certificateFilePath = "/home/wso2/security/truststore/mg.pem"
```
