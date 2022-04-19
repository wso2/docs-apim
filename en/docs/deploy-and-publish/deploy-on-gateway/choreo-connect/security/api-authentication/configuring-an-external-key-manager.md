# Configuring an External Key Manager

You can configure an external Key Manager or a Token Service in the following ways depending on the Choreo Connect **mode** you have chosen.

|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Admin Portal](#via-wso2-api-manager-admin-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[Via the Choreo Connect Config File](#via-the-choreo-connect-config-file) |

## Via WSO2 API Manager Admin Portal

Choreo Connect provides the capability to configure external key managers through APIM admin portal. The issuer data is retrieved from the event hub at the startup and updated as the changes are made from the admin portal.

### Step 1 - Configure Choreo Connect with API Manager

Please refer [Configure Choreo Connect with API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-docker-with-apim-as-control-plane).

### Step 2 - Add the external key manager to API Manager

Please refer [Multiple Key Manager Support in WSO2 API Manager]({{base_path}}/administer/key-managers/overview) to configure the desired key manager. 

!!! note
    Please note that Choreo Connect only supports self-validation of JWT tokens from key managers. (JWT tokens will be validated against the issuer data.)

!!! important
    Token services which are added from the `config.toml` file under `enforcer.security.tokenService` configuration will be overridden from the retrieved key manager configurations from the API Manager if the issuers are identical. Furthermore, if the corresponding key manager is removed from the API Manager admin portal, the token service added from the configuration will be used.

## Via the Choreo Connect Config File

When Choreo Connect does not depend on a control plane, the external Key Managers, Token Services or JWT issuers can be configured in [config.toml]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configuration-overview/#configurations-overview) as given below.

``` toml
# Issuer 1
[[enforcer.security.tokenService]]
  name="Resident Key Manager"
  issuer = "https://localhost:9443/oauth2/token"
  certificateAlias = "wso2carbon"
  # URL of the JWKs endpoint
  jwksURL = "https://apim:9443/t/wso2.com/oauth2/jwks"
  # Validate subscribed APIs
  validateSubscription = false
  # The claim in which the consumer key of the application is coming
  consumerKeyClaim = "azp"
  # Certificate Filepath within enforcer
  certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"

# Issuer 2
[[enforcer.security.tokenService]]
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