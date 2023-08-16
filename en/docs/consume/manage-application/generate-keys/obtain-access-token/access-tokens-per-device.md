# Access Tokens Per Device

In WSO2 API Manager, the behavior for generating JWT tokens with the same application keys and scopes is different to the previous approach with Opaque tokens. For JWT tokens, WSO2 API Manager no longer returns the same existing valid JWT token for each token request. Additionally, if a valid token already exists for the requesting application and user, generating a new token will result in the revocation of the previous token associated with that application and user.

To address this, WSO2 API Manager employs a mechanism that leverages [OAuth2.0 Scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#fine-grained-access-control-with-oauth-scopes) to generate unique Access Tokens for each device using the same application. This mechanism allows users to request tokens for different scopes. To achieve this, you are required to prefix the scope names with the string `device_`. Notably, WSO2 API Manager applies special treatment to scopes that bear this particular prefix, by bypassing the usual validations typically performed when issuing tokens associated with scopes.


## Generating access tokens per device

Use the following sample cURL command format to request a token with a `device_` scope.

```
curl -k -d"grant_type=password&username=<username>&password=<password>&scope=device_ipad"-H"Authorization :Basic base64encode(consumer-key:consumer-secret), Content-Type: application/x-www-form-urlencoded"https://localhost:8243/token
```

Each token request that is made with a different scope, results in a different access token being issued. For example if you received a token named `abc` as a result of the scope `device_ipad`, you will not receive `abc` when you request for the token with the scope `device_iphone`. 

!!! note
    You can use the `device_` scopes in conjunction with other scopes as usual.
