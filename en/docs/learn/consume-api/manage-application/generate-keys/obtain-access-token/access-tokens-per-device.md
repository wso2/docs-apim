# Access Tokens Per Device

WSO2 API Manager returns the same token repeatedly if a valid token exists for the requesting Application, on behalf of the user. However, the latter mentioned scenario becomes an issue if the same user is using the same Application in two devices (e.g., If you have two instances of the same Application running on your iPhone and iPad, and your iPhone already has a token on behalf of you, your iPad will get the same token if you requested for it within the same validity period. Therefore, if one of your devices revoke this token (e.g., revoke on logout), the token that you obtained for your other device becomes invalid as the devices use the identical tokens.

WSO2 API Manager overcomes the latter mentioned problem by using a mechanism that uses [OAuth2.0 Scopes]({{base_path}}/learn/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#fine-grained-access-control-with-oauth-scopes) to obtain a unique Access Token for each device that uses the same Application. Thereby allowing users to request tokens for different scopes. You need to prefix the scope names with the string `device_`. WSO2 API Manager uses special treatment for the scopes that are prefixed with the latter mentioned string by ignoring the usual validations it does when issuing tokens that are associated to scopes. 

## Generating access tokens per device

Use the following sample cURL command format to request a token with a `device_` scope.

```
curl -k -d"grant_type=password&username=<username>&password=<password>&scope=device_ipad"-H"Authorization :Basic base64encode(consumer-key:consumer-secret), Content-Type: application/x-www-form-urlencoded"https://localhost:8243/token
```

Each token request that is made with a different scope, results in a different access token being issued. For example if you received a token named `abc` as a result of the scope `device_ipad`, you will not receive `abc` when you request for the token with the scope `device_iphone`. 

!!! note
    You can use the `device_` scopes in conjunction with other scopes as usual.
