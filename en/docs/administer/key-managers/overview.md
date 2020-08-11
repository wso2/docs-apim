# Multiple Key Manager support in WSO2 API Manager

Wso2 API Manager provides an admin functionality for admins/tenant admins to configure different authorization servers as key managers.
This brings the capability of supporting multiple key managers for a given API.

When a key manager is added from the admin portal, it is persisted in the APIM DB as well as an event is triggered to the Traffic Manager.
So the gateway will receive the event and register the key manager in the gateway.
Hence, the key manager will be registered as another key manager and it will be available for the APIs that are created within the tenant.

![Add new Key Manager]({{base_path}}/assets/img/administer/add-km-overview.png)


Key Manager configuration initialization at server startup happens through an internal API.
However, the UI components in publisher/devportal/admin portals populate key manager details from the Database.


For a selected key manager when generation keys, it checks if the Key manager configurations have the consumer app creation enabled.
If it is enabled it generates consumer App upon validation of the required parameters.

### Token Validation

![alt text]({{base_path}}/assets/img/administer/multiple-km-token-validation.png)

If the token is a JWT token, it retrieves Issuer from the JWT and obtain the relevant key manager. If the key manager is not enabled for the API, token validation fails.
If the key manager is enabled, token is validated through the JWT validator.

For non JWT tokens, token is validated according to the token handling options provided in the key manager configurations of the intended key manager.

Upon token validation by the retrieved consumer key, subscription validation happens at the gateway.
If the subscription validation is successful, the scope validation happens.

Finally if the back end JWT generation is enabled, it generates the JWT.

[Configuring WSO2 IS as a Key Manager]({{base_path}}/administer/key-managers/how-to-configure-wso2is-connector/)

[Configuring Key Cloak as a Key Manager]({{base_path}}/administer/key-managers/how-to-configure-key-cloak-connector/)

[Configuring Okta as a Key Manager]({{base_path}}/administer/key-managers/how-to-configure-okta-connector/)






