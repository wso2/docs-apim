# Application Access Tokens

### Generating application access tokens

Application access tokens are tokens that authenticate an application, which is a logical collection of APIs. In other words, an application access token does not directly associate with any specific user who uses the application. You can access all APIs associated with an application using a single token, and also subscribe multiple times to a single API with different service level agreement (SLA) levels/tiers. Application access tokens leverage OAuth2 to provide simple key management.
When generating an application access token, WSO2 API Manager uses **client_credentials** OAuth2 grant type.

The steps below describe how to generate/renew application access tokens:

1.  Sign in to WSO2 Developer Portal.
2.  Click the **Applications** on the top menu and open the application for which you want to generate an access token.
3.  Click the **Production Keys** menu and click **GENERATE KEYS** to create an application access token. You can use this token to invoke all APIs that you subscribe to using the same application.

### Renewing application access tokens

When an application access token expires, consumers can refresh the token by signing into the Developer Portal, opening the application, and clicking **Re-generate** that appears in the **Production Keys** tab.
You can also specify a token expiration time for the application access token. Set this to a negative value to ensure that the token never expires.

!!! tip
    In the **Access token validity period** field, you can set an expiration period to determine the validity period of the token after generation. Set this to a negative value to ensure that the token never expires. Also see [Changing the default token expiration time](../changing-the-default-token-expiration-time) .
