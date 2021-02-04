# Refresh Token Grant

The refresh token grant can be used when the current access token is expired or when a new access token is needed. With this grant type, the refresh token acts as a credential and is issued to the client by the authorization server. Issuing a refresh token is optional and if the authorization server issues a refresh token, it is included when issuing an access token. WSO2 Identity Server issues refresh tokens for all other grant types other than the **implicit and client credentials grant types**, as recommended by the OAuth 2.0 specification.

!!! note
    
    This refresh token needs to be kept private, similar to the access token. When using this token, keep in mind that it issues the access token without a user interaction.

#### Flow

After an access token is generated, sometimes you might have to renew the old token due to expiration or security concerns. You can renew an access token using a refresh token, by issuing a REST call to the Token API with the following parameters.
A refresh token has to be obtained before using it with a grant type such as the authorization code or password grant type. Using the obtained refresh token, you can obtain a new access token along with a renewed refresh token without having to go through any other additional steps.

The diagram below illustrates the refresh token grant flow.

![]({{base_path}}/assets/img/learn/oauth-refresh-token-diagram.png)

-   [Generating a new access token and refresh token](#generating-a-new-access-token-and-refresh-token)
-   [Revoking a refresh token](#revoking-a-refresh-token)

### Generating a new access token and refresh token

To use this grant type, you need a refresh token, using which you can get a new access token and a refresh token. This can be done by issuing a REST call to the Token API through a REST client like cURL, with the following parameters:

-   The Token API URL is [https://localhost:8243/token](https://localhost:8243/login) , assuming that both the client and the Gateway are running on the same server.
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

``` java tab="Format"
curl -k -d "grant_type=refresh_token&refresh_token=<refresh-token>" -H "Authorization: Basic SVpzSWk2SERiQjVlOFZLZFpBblVpX2ZaM2Y4YTpHbTBiSjZvV1Y4ZkM1T1FMTGxDNmpzbEFDVzhh" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
```

``` java tab="Example"
curl -k -d "grant_type=refresh_token&refresh_token=3154090c-37f1-3268-90f9-8bd84daf135c" -H "Authorization: Basic UXk3RUZfVEtMbEVLWTlVRFpiWHVscVA4ZVVBYTpKSWN3VTlIX1hGUFdTcW1RQmllZ3lJUzRKazhh" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
```

You receive a response similar to the following:

``` java
{
    "scope":"default",
    "token_type":"Bearer",
    "expires_in":3600,
    "refresh_token":"7ed6bae2b1d36c041787e8c8e2d6cbf8",
    "access_token":"b7882d23f1f8257f4bc6cf4a20633ab1"
}
```

The above REST response grants you a renewed access token along with a refresh token, which you can use the next time you renew the access token. A refresh token can be used only once. You can configure an expiration time for the refresh token by adding following configuration in the `<APIM_HOME>/repository/conf/deployment.toml` file.

```
    [oauth.token_validation]
    refresh_token_validity = 3600
```

### Revoking a refresh token

After issuing an access token and refresh token, a user or an admin can revoke it in case of theft or a security violation. You can do this by calling the Revoke API using a utility like cURL. The Revoke API's endpoint URL is <https://localhost:8243/revoke>.

#### Option 1

The parameters required to invoke the following API are as follows:

- The token to be revoked

- <code>base64Encode(clientId:clientSecret)</code> - Use a [base64 encoder](https://www.base64encode.org/) to encode your client ID and client secret in the format - `<clientId>:<clientSecret>`.

``` java tab="Format"
curl -k -v -d "token=<refresh_token_to_be_revoked>" -H "Authorization: Basic <base64Encode(clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

``` java tab="Example"
curl -k -v -d "token=c8e8eec2-0092-3ac6-b23f-ef7492f345a6" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

**Response**

```
    > Host: localhost:8243
    > User-Agent: curl/7.50.2
    > Accept: */*
    > Authorization: Basic YjNtTzdkQ2h3UHBfdTVHOFN6cVBzSDVTRnZRYTo4OG16bGFaejc2T2RlekJSNDBwcmZBa2ZNUjBh
    > Content-Type: application/x-www-form-urlencoded
    > Content-Length: 42
    > 
    < HTTP/1.1 200 OK
    < X-Frame-Options: DENY
    < RevokedRefreshToken: c8e8eec2-0092-3ac6-b23f-ef7492f345a6
    < Cache-Control: no-store
    < X-Content-Type-Options: nosniff
    < AuthorizedUser: admin@carbon.super
    < Pragma: no-cache
    < RevokedAccessToken: c7febbd3-5f35-3727-ae5f-5a8492b04f93
    < X-XSS-Protection: 1; mode=block
    < Content-Type: text/html
    < Date: Thu, 02 Nov 2017 12:57:58 GMT
    < Transfer-Encoding: chunked
```

#### Option 2

The parameters required to invoke the following API are as follows:

- The token to be revoked.

- `base64Encode(clientId:clientSecret)` - Use a [base64 encoder](https://www.base64encode.org) to encode your client ID and client secret in the format: `<clientId>:<clientSecret>`.

- `token_type_hint -` This parameter is **optional**. If you do not specify this parameter, then WSO2 API Manager will search in both key spaces (access token and refresh token) and if it finds a matching token then it will be revoked. Therefore, if this parameter it not specified the token revokation process takes longer. However, if you specify this parameter then it will only searches in the respective token key space, hence the token revokation process is much faster.

``` java tab="Format"
curl -k -v -d "token=<refresh_token_to_be_revoked>&token_type_hint=<access_token_or_refresh_token>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H Content-Type: application/x-www-form-urlencoded https://localhost:8243/revoke
```

``` java tab="Example"
curl -k -v -d "token=4ed29669-a457-3f83-af1e-180cad271cca&token_type_hint=refresh_token" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

**Response**

```
    > POST /revoke HTTP/1.1
    > Host: localhost:8243
    > User-Agent: curl/7.50.2
    > Accept: */*
    > Authorization: Basic YjNtTzdkQ2h3UHBfdTVHOFN6cVBzSDVTRnZRYTo4OG16bGFaejc2T2RlekJSNDBwcmZBa2ZNUjBh
    > Content-Type: application/x-www-form-urlencoded
    > Content-Length: 72
    > 
    < HTTP/1.1 200 OK
    < X-Frame-Options: DENY
    < RevokedRefreshToken: 4ed29669-a457-3f83-af1e-180cad271cca
    < Cache-Control: no-store
    < X-Content-Type-Options: nosniff
    < AuthorizedUser: admin@carbon.super
    < Pragma: no-cache
    < RevokedAccessToken: 23562997-bbc7-353f-a650-16558b7147bc
    < X-XSS-Protection: 1; mode=block
    < Content-Type: text/html
    < Date: Thu, 02 Nov 2017 12:59:41 GMT
    < Transfer-Encoding: chunked
```

!!! tip
    If you want to **disable the Refresh Token grant type** in the APIM instance, add the following entry to the `deployment.toml` file in the `<APIM_HOME>/repository/conf/` folder.

    ``` toml
    [oauth.grant_type.refresh_token]
    enable = false
    ```
