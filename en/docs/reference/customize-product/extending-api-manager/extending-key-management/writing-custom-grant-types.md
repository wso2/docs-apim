# Writing Custom Grant Types

OAuth 2.0 authorization servers provide support for four main grant types according to the OAuth 2.0 specification. They also allow you to add custom grant types and extend the existing ones.

To implement custom grant types for the API Manager, see [Writing a Custom OAuth 2.0 Grant Type](https://is.docs.wso2.com/en/5.11.0/learn/writing-a-custom-oauth-2.0-grant-type/) in the WSO2 Identity Server documentation. If you require any additional functionality for authorization_code , password , client_credentials, refresh_token and saml2-bearer grant types, its advisable to extend the following grant handler implementations.

| Grant Type                                                               | Existing Handler Class (which can be extended if required)                                              |
|--------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| `authorization_code`| `org.wso2.carbon.identity.oauth2.token.handlers.grant.AuthorizationCodeGrantHandler` |
| `password`| `org.wso2.carbon.identity.oauth2.token.handlers.grant.PasswordGrantHandler`|
| `refresh_token`| `org.wso2.carbon.identity.oauth2.token.handlers.grant.RefreshGrantHandler`|
| `client_credentials`| `org.wso2.carbon.identity.oauth2.token.handlers.grant.ClientCredentialsGrantHandler` |
| `urn:ietf:params:oauth:grant-type:saml2-bearer` | `org.wso2.carbon.identity.oauth2.token.handlers.grant.saml.SAML2BearerGrantHandler`|

## Important considerations when removing custom grant types

!!! warning "Clean up OAuth applications before removing custom grant types"

    When you remove a custom grant type from `deployment.toml`, any existing OAuth applications that used that grant type will still keep it in their client settings. This can cause issues when you perform operations on these applications later, such as changing the application owner.

    **Before removing a custom grant type from `deployment.toml`:**

    1. Find all applications that use the custom grant type.
    2. Update those applications to remove or replace the grant type. Use the Key Manager or client registration update APIs for this purpose.
    3. Only after completing these steps, remove the grant type from `deployment.toml`.

    If you skip this cleanup step, operations such as application updates or ownership changes can fail with errors like "grant type is not allowed" and can cause inconsistencies between the Service Provider and Application tables.