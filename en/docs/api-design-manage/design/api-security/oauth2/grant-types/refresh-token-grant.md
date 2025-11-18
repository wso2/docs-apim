# Refresh Token Grant

The refresh token grant can be used when the current access token is expired or when a new access token is needed. With this grant type, the refresh token acts as a credential and is issued to the client by the authorization server. Issuing a refresh token is optional and if the authorization server issues a refresh token, it is included when issuing an access token. WSO2 Identity Server issues refresh tokens for all other grant types other than the **implicit and client credentials grant types**, as recommended by the OAuth 2.0 specification.

!!! note
    
    This refresh token needs to be kept private, similar to the access token. When using this token, keep in mind that it issues the access token without a user interaction.

#### Flow

After an access token is generated, sometimes you might have to renew the old token due to expiration or security concerns. You can renew an access token using a refresh token, by issuing a REST call to the Token API with the following parameters.
A refresh token has to be obtained before using it with a grant type such as the authorization code or password grant type. Using the obtained refresh token, you can obtain a new access token along with a renewed refresh token without having to go through any other additional steps.

The diagram below illustrates the refresh token grant flow.

![]({{base_path}}/assets/img/learn/oauth-refresh-token-diagram.png)

- [Refresh Token Grant](#refresh-token-grant)
      - [Flow](#flow)
    - [Generating a new access token and refresh token](#generating-a-new-access-token-and-refresh-token)
    - [Revoking a refresh token](#revoking-a-refresh-token)
      - [Option 1](#option-1)
      - [Option 2](#option-2)

### Generating a new access token and refresh token

To use this grant type, you need a refresh token, using which you can get a new access token and a refresh token. This can be done by issuing a REST call to the Token API through a REST client like cURL, with the following parameters:

-   The Token API URL is [https://localhost:9443/oauth2/token](https://localhost:9443/oauth2/token) , assuming that both the client and the Gateway are running on the same server.
-   payload 
```
    "grant_type=refresh_token&refresh_token=<refresh-token>"
``` 
Replace the `<refresh-token>` value with the refresh token generated in the previous step.
-   headers 
```
    Authorization :Basic <base64(client-id:client-secret)>, 
    Content-Type: application/x-www-form-urlencoded
``` 
Replace `<base64(client-id:client-secret)>` as appropriate.

For example, the following cURL command can be used to access the Token API.

=== "Format"
    ``` java
    curl -k -d "grant_type=refresh_token&refresh_token=<refresh-token>" -H "Authorization: Basic <base64Encode(clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:9443/oauth2/token
    ```

=== "Example"
    ``` java
    curl -k -d "grant_type=refresh_token&refresh_token=bd63be3d-d37e-3689-9488-b9dbbe8d3f9e" -H "Authorization: Basic dTJRMGpDb2RhWklnRlZoZkxUY3VSNHJCX05ZYTpCWkVmaUZBd043NkJDUUxKTjFTcW5YaGxVcm9h" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:9443/oauth2/token
    ```

You receive a response similar to the following:

``` json
{
   "access_token":"eyJ4NXQiOiJPREJtTVRVMFpqSmpPREprTkdZMVpUaG1ZamsyWVRZek56UmpZekl6TVRCbFlqRTBNV0prWTJJeE5qZzNPRGRqWVdRNVpXWmhOV0kwTkRBM1pqTTROUSIsImtpZCI6Ik9EQm1NVFUwWmpKak9ESmtOR1kxWlRobVlqazJZVFl6TnpSall6SXpNVEJsWWpFME1XSmtZMkl4TmpnM09EZGpZV1E1WldaaE5XSTBOREEzWmpNNE5RX1JTMjU2IiwidHlwIjoiYXQrand0IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI5Zjg1MGViNi04NGQ0LTQwZDItYmRhNi04ZWJmYWI2YTUxMWIiLCJhdXQiOiJBUFBMSUNBVElPTl9VU0VSIiwiYXVkIjoidTJRMGpDb2RhWklnRlZoZkxUY3VSNHJCX05ZYSIsIm5iZiI6MTcxMzE2Mjc4NCwiYXpwIjoidTJRMGpDb2RhWklnRlZoZkxUY3VSNHJCX05ZYSIsInNjb3BlIjoiZGVmYXVsdCIsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0Ojk1MDAvb2F1dGgyL3Rva2VuIiwiZXhwIjoxNzEzMTY2Mzg0LCJpYXQiOjE3MTMxNjI3ODQsImp0aSI6IjgzNTc2NDEwLTA4NGItNDg4Mi1hZGZlLTYyYjM4M2VjZWI0NCIsImNsaWVudF9pZCI6InUyUTBqQ29kYVpJZ0ZWaGZMVGN1UjRyQl9OWWEifQ.vg_YgUfGWqy6z_LFfJAv0MZtRax09b9MHtA-RA4OKkUISnqcgJiqcP7X4K2NE0sLiL7v3mihBS-gLRb6lH7L2b4nCWwAVD0XR3PVviEBfzeGgse2QTbx_kc7gP10UfqrqBg0-Cj4SHW4XXGXcHytg6n-txJmZwtPNnA3RZSPcIIJbna3iPtfndqLbAJntP45vL-ug_tUKfuW6pKlKcU5yTkEfeajNCr1miRcg4jEfG_fG_iVTYXo9hdR5yeW8l5iU4bDrd9M9UKXpyCsfszlGEBK71qCm2mq2HZOOxn1Cpx2JE6ekfVF85Y_amB-56wsh8HXj22FaZCgU-bCgpmWzw",
   "refresh_token":"af018b89-8cda-3a01-8c48-c10eff0d1cef",
   "scope":"default",
   "token_type":"Bearer",
   "expires_in":3600
}
```

The above REST response grants you a renewed access token along with a refresh token, which you can use the next time you renew the access token. A refresh token can be used only once. You can configure an expiration time for the refresh token by adding following configuration in the `<APIM_HOME>/repository/conf/deployment.toml` file.

```toml
    [oauth.token_validation]
    refresh_token_validity = 3600
```

### Revoking a refresh token

After issuing an access token and refresh token, a user or an admin can revoke it in case of theft or a security violation. You can do this by calling the Revoke API using a utility like cURL. The Revoke API's endpoint URL is <https://localhost:9443/oauth2/revoke>.

#### Option 1

The parameters required to invoke the following API are as follows:

- The token to be revoked

- <code>base64Encode(clientId:clientSecret)</code> - Use a base64 encoder to encode your client ID and client secret in the format - `<clientId>:<clientSecret>`. WSO2 does not recommend the use of online base64 encoders for this purpose.

=== "Format"
    ``` java
    curl -k -v -d "token=<refresh_token_to_be_revoked>" -H "Authorization: Basic <base64Encode(clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:9443/oauth2/revoke
    ```

=== "Example"
    ``` java
    curl -k -v -d "token=af018b89-8cda-3a01-8c48-c10eff0d1cef" -H "Authorization: Basic dTJRMGpDb2RhWklnRlZoZkxUY3VSNHJCX05ZYTpCWkVmaUZBd043NkJDUUxKTjFTcW5YaGxVcm9h" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:9443/oauth2/revoke
    ```

**Response**

```
> POST /oauth2/revoke HTTP/1.1
> Host: localhost:9443
> User-Agent: curl/8.4.0
> Accept: */*
> Authorization: Basic dTJRMGpDb2RhWklnRlZoZkxUY3VSNHJCX05ZYTpCWkVmaUZBd043NkJDUUxKTjFTcW5YaGxVcm9h
> Content-Length: 42
> Content-Type: application/x-www-form-urlencoded
>
< HTTP/1.1 200
< X-WSO2-TraceId: e74786fd-f680-4ae3-b8fe-e1df5aa904a4
< X-Frame-Options: DENY
< X-Content-Type-Options: nosniff
< Cache-Control: no-store
< Pragma: no-cache
< RevokedAccessToken: 83576410-084b-4882-adfe-62b383eceb44
< RevokedRefreshToken: af018b89-8cda-3a01-8c48-c10eff0d1cef
< AuthorizedUser: admin@carbon.super
< Date: Mon, 15 Apr 2024 07:26:42 GMT
< Content-Type: application/json
< Content-Length: 0
< Server: WSO2 Carbon Server
```

#### Option 2

The parameters required to invoke the following API are as follows:

- The token to be revoked.

- `base64Encode(clientId:clientSecret)` - Use a base64 encoder to encode your client ID and client secret in the format: `<clientId>:<clientSecret>`. WSO2 does not recommend the use of online base64 encoders for this purpose.

- `token_type_hint -` This parameter is **optional**. If you do not specify this parameter, then WSO2 API Manager will search in both key spaces (access token and refresh token) and if it finds a matching token then it will be revoked. Therefore, if this parameter is not specified the token revocation process takes longer. However, if you specify this parameter then it will only search in the respective token key space, hence the token revocation process is much faster.

=== "Format"
    ``` java
    curl -k -v -d "token=<refresh_token_to_be_revoked>&token_type_hint=<access_token_or_refresh_token>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H Content-Type: application/x-www-form-urlencoded https://localhost:9443/oauth2/revoke
    ```

=== "Example"
    ``` java
    curl -k -v -d "token=b6b5db36-9c1e-31dc-a3c2-283377736dd0&token_type_hint=refresh_token" -H "Authorization: Basic dTJRMGpDb2RhWklnRlZoZkxUY3VSNHJCX05ZYTpCWkVmaUZBd043NkJDUUxKTjFTcW5YaGxVcm9h" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:9443/oauth2/revoke
    ```

**Response**

```
> POST /oauth2/revoke HTTP/1.1
> Host: localhost:9443
> User-Agent: curl/8.4.0
> Accept: */*
> Authorization: Basic dTJRMGpDb2RhWklnRlZoZkxUY3VSNHJCX05ZYTpCWkVmaUZBd043NkJDUUxKTjFTcW5YaGxVcm9h
> Content-Length: 72
> Content-Type: application/x-www-form-urlencoded
>
< HTTP/1.1 200
< X-WSO2-TraceId: b29c94ad-6d1c-435a-9423-f8a7ae2d8ddd
< X-Frame-Options: DENY
< X-Content-Type-Options: nosniff
< Cache-Control: no-store
< Pragma: no-cache
< RevokedAccessToken: c120a072-b5a6-4dc7-9889-dda037011917
< RevokedRefreshToken: b6b5db36-9c1e-31dc-a3c2-283377736dd0
< AuthorizedUser: admin@carbon.super
< Date: Mon, 15 Apr 2024 07:33:41 GMT
< Content-Type: application/json
< Content-Length: 0
< Server: WSO2 Carbon Server
```

!!! tip
    If you want to **disable the Refresh Token grant type** in the APIM instance, add the following entry to the `deployment.toml` file in the `<APIM_HOME>/repository/conf/` folder.

    ``` toml
    [oauth.grant_type.refresh_token]
    enable = false
    ```
