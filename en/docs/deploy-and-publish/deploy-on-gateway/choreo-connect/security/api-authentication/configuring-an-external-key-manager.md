# Configuring an External Key Manager

You can configure an external Key Manager or a Token Service in the following ways depending on the Choreo Connect **mode** you have chosen.

|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Admin Portal](#via-wso2-api-manager-admin-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[Via the Choreo Connect Config File](#via-the-choreo-connect-config-file) |

## Via WSO2 API Manager Admin Portal

Choreo Connect provides the capability to configure external Key Managers through the API Manager Admin Portal. The issuer data is retrieved from the event hub at the startup, and updated as the changes are made from the Admin Portal.

### Step 1 - Configure Choreo Connect with API Manager

Please refer [Configure Choreo Connect with API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-docker-with-apim-as-control-plane).

### Step 2 - Add the external key manager to API Manager

Please refer [Multiple Key Manager Support in WSO2 API Manager]({{base_path}}/administer/key-managers/overview) to configure the desired key manager. 

!!! note
    Please note that Choreo Connect only supports self-validation of JWT tokens from key managers. (JWT tokens will be validated against the issuer data.)

!!! important
    Token services which are added from the `config.toml` file under `enforcer.security.tokenService` configuration will be overridden from the retrieved key manager configurations from the API Manager if the issuers are identical. Furthermore, if the corresponding key manager is removed from the API Manager admin portal, the token service added from the configuration will be used.

## Via the Choreo Connect Config File

When Choreo Connect runs as a standalone Gateway, the external Key Managers, Token Services or JWT issuers used for API authentication must be configured in the [config.toml]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configuration-overview/#configurations-overview). To know what these parameters mean, you can go through the descriptions given under [Token Service in Enforcer Configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/enforcer-configurations/#token-service). The following are the token services configured by default. The template with the default values can also be found in `config.toml.template` located together with `config.toml`.

``` toml
# Issuer 1 - Resident Key Manager Issuer for Access tokens
[[enforcer.security.tokenService]]
  name="Resident Key Manager"
  issuer = "https://localhost:9443/oauth2/token"
  certificateAlias = "wso2carbon"
  jwksURL = "https://apim:9443/t/wso2.com/oauth2/jwks"
  validateSubscription = false
  consumerKeyClaim = "azp"
  certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"

# Issuer 2 - Issuer for Enforcer test key
[[enforcer.security.tokenService]]
  name = "MGW"
  issuer = "https://localhost:9095/testkey"
  certificateAlias = "mgw"
  jwksURL = ""
  validateSubscription = false
  consumerKeyClaim = ""
  certificateFilePath = "/home/wso2/security/truststore/mg.pem"

# Issuer 3 - Issuer for API Manager Internal Key
[[enforcer.security.tokenService]]
  name = "APIM Publisher"
  issuer = "https://localhost:9443/publisher"
  validateSubscription = true
  certificateAlias = ""
  certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"

# Issuer 4 - Issuer for API Manager API Key
[[enforcer.security.tokenService]]
    # Provide unique name for the JWT issuer
    name = "APIM APIkey"
    validateSubscription = true
    # Alias name given in Enforcer truststore for the public certificate of the JWT issuer
    certificateAlias = "apikey_certificate_alias"
    # Certificate Filepath within Enforcer
    certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"
```

!!! tip

    In the configuration file (**config.toml** or **config-toml-configmap.yaml** depending on whether you have deployed Choreo Connect on Docker Compose or K8s), the token services are configured as an array in **toml** format. Therefore when updating the token services, the entire array or all the token services required must exist in this file for all of them to be used. If none of the `[[enforcer.security.tokenService]]` sections are present, then the default array that consists of,

    - "Resident Key Manager" of WSO2 API-M with configs for Access tokens
    - token service exposed by Choreo Connect Enforcer named as "MGW"
    - token service exposed by WSO2 API-M Publisher
    - "Resident Key Manager" of WSO2 API-M with configs for API Keys (hence named as "APIM APIkey") 

    will be set as given in the toml format above.