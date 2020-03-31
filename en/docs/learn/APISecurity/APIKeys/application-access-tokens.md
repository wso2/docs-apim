# duplicate\_Application Access Tokens

-   [Generating application access tokens](#duplicate_ApplicationAccessTokens-Generatingapplicationaccesstokens)
-   [Renewing application access tokens](#duplicate_ApplicationAccessTokens-Renewingapplicationaccesstokens)

### Generating application access tokens

Application access tokens are tokens that authenticate an application, which is a logical collection of APIs. You can access all APIs associated with an application using a single token, and also subscribe multiple times to a single API with different service level agreement (SLA) levels/tiers. Application access tokens leverage OAuth2 to provide simple key management.

The steps below describe how to generate/renew application access tokens:

1.  Sign in to WSO2 API Store.
2.  Click the **Applications** menu and open the application for which you want to generate an access token.
3.  Click the **Production Keys** tab and click **Generate Keys** to create an application access token. You can use this token to invoke all APIs that you subscribe to using the same application.

        !!! tip
    In the **Access token validity period** field, you can set an expiration period to determine the validity period of the token after generation. Set this to a negative value to ensure that the token never expires. Also see [Changing the default token expiration time](https://docs.wso2.com/display/SHAN/Am300Working+with+Access+Tokens#Am300WorkingwithAccessTokens-Changingthedefaulttokenexpirationtime) .

        !!! tip
    **Tip** : When you generate access tokens to APIs protected by [scope/s](https://docs.wso2.com/display/AM300/Key+Concepts#KeyConcepts-OAuthscopes) , you can select the scope/s and then generate the token for it.


### Renewing application access tokens

When an application access token expires, consumers can refresh the token by signing into the API Store, opening the application, and clicking **Re-generate** that appears in the **Production Keys** tab.
You can also specify a token expiration time for the application access token. Set this to a negative value to ensure that the token never expires.


