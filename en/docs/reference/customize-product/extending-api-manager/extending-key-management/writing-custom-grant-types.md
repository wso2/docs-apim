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