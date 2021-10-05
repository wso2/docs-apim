# Configuring an External Key Manager

Choreo Connect provides the capability to configure external key managers through APIM admin portal. The issuer data is retrieved from the event hub at the startup and updated as the changes are made from the admin portal.

### Step 1 - Configure Choreo Connect with API Manager

Please refer [Configure Choreo Connect with API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/#configure-choreo-connect-with-api-manager).

### Step 2 - Add the external key manager to API Manager

Please refer [Multiple Key Manager Support in WSO2 API Manager]({{base_path}}/administer/key-managers/overview) to configure the desired key manager. 

!!! note
    Please note that Choreo Connect only supports self-validation of JWT tokens from key managers. (JWT tokens will be validated against the issuer data.)

!!! note
    Token services which are added from the `config.toml` file under `enforcer.security.tokenService` configuration will be overridden from the retrieved key manager configurations from the API Manager if the issuers are identical. Furthermore, if the corresponding key manager is removed from the API Manager admin portal, the token service added from the configuration will be used.


