# Configuring an External Key Manager

Choreo Connect provides the capability to configure external key managers through WSO2 API Manager Admin Portal. The issuer data is retrieved from the event hub at the startup and updated as the changes are made from the Admin Portal.

### Step 1 - Configure Choreo Connect with API Manager

Please refer [Configure Choreo Connect with API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-docker-with-apim).

### Step 2 - Add the external key manager to API Manager

Please refer [Multiple Key Manager Support in WSO2 API Manager]({{base_path}}/administer/key-managers/overview) to configure the desired Key Manager. 

!!! note
    Please note that Choreo Connect only supports self-validation of JWT tokens from Key Managers (JWT tokens will be validated against the issuer data).

!!! note
    Token services that are added from the `config.toml` file under the `enforcer.security.tokenService` configuration will be overridden from the retrieved Key Manager configurations from the API Manager if the issuers are identical. Furthermore, if the corresponding Key Manager is removed from the API Manager Admin Portal, the token service added from the configuration is used.


