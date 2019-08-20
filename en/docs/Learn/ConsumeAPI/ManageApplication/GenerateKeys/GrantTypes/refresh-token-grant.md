# Refresh Token Grant

After an access token is generated, sometimes you might have to renew the old token due to expiration or security concerns. You can renew an access token using a refresh token, by issuing a REST call to the Token API with the following parameters. With this grant type, the refresh token acts as credentials that are issued to the client by the authorization server. Issuing a refresh token is optional. If the authorization server issues a refresh token, it is included when issuing an access token. Refresh tokens are issued for all other grant types other than the **implicit grant** as recommended by the OAuth 2.0 specification.

!!! tip
**Tip** : Be sure to keep the refresh token private, similar to the access token as this token issues access tokens without user interactions.


-   [Generating a new access token and refresh token](#RefreshTokenGrant-Generatinganewaccesstokenandrefreshtoken)
-   [Revoking a refresh token](#RefreshTokenGrant-Revokingarefreshtoken)

### Generating a new access token and refresh token

To use this grant type, you need a refresh token, using which you can get a new access token and a refresh token. This can be done by issuing a REST call to the Token API through a REST client like cURL, with the following parameters:

-   The Token API URL is [https://localhost:8243/token](https://localhost:8243/login) , assuming that both the client and the Gateway are run on the same server.
-   payload: `          "grant_type=refresh_token&refresh_token=<retoken>"         ` . Replace the `          <retoken>         ` value with the refresh token generated in the previous step.
-   headers: `          Authorization :Basic <base64 encoded string>, Content-Type: application/x-www-form-urlencoded         ` . Replace `          <base64 encoded string>         ` as appropriate.

For example, the following cURL command can be used to access the Token API.

``` java
    curl -k -d "grant_type=refresh_token&refresh_token=<retoken>" -H "Authorization: Basic SVpzSWk2SERiQjVlOFZLZFpBblVpX2ZaM2Y4YTpHbTBiSjZvV1Y4ZkM1T1FMTGxDNmpzbEFDVzhh" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
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

The above REST message grants you a renewed access token along with a refresh token, which you can use the next time you renew the access token. A refresh token can be used only once. You can configure an expiration time for the refresh token by setting it in the `         <RefreshTokenValidityPeriod>        ` element in the `         <APIM_HOME>/repository/conf/identity/identity.xml        ` file.

### Revoking a refresh token

After issuing an access token and refresh token, a user or an admin can revoke it in case of theft or a security violation. You can do this by calling the Revoke API using a utility like cURL. The Revoke API's endpoint URL is <http://localhost:8280/revoke> .

****Option 1****

The parameters required to invoke the following API are as follows:

-   <refresh_token_to_be_revoked> - The token to be revoked

-   `          <base64 encoded (clientId:clientSecret)>         ` - Use a base64 encoder (e.g., <https://www.base64encode.org/> ) to encode your client ID and client secret using the following format: `          <clientId>:<clientSecret>         ` Thereafter, enter the encoded value for this parameter.

-   [**Format**](#option1-format)
-   [**Example**](#option1-example)
-   [**Response**](#option1-response)

``` java
    curl -k -v -d "token=<refresh_token_to_be_revoked>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

``` java
    curl -k -v -d "token=c8e8eec2-0092-3ac6-b23f-ef7492f345a6" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

``` java
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

********

The parameters required to invoke the following API are as follows:

-   `            <refresh_token_to_be_revoked>           ` - The token to be revoked.

-   `           <base64 encoded (clientId:clientSecret)>          ` - Use a base64 encoder (e.g., <https://www.base64encode.org/> ) to encode your client ID and client secret using the following format: `           <clientId>:<clientSecret>          ` Thereafter, enter the encoded value for this parameter.
-   `           token_type_hint -          ` This parameter is optional. If you do not specify this parameter, then WSO2 Identity Server (WSO2 IS) will search in both key spaces (access and refresh) and if it finds a matching token then it will be revoked. Therefore, if this parameter it not specified the token revokation process takes longer. However, if you specify this parameter then WSO2 IS will only searches in the respective token key space, hence the token revokation process is much faster.

-   [**Format**](#option2-format)
-   [**Example**](#option2-example)
-   [**Response**](#option2-response)

``` java
    curl -k -v -d "token=<refresh_token_to_be_revoked>&token_type_hint=<access_token_or_refresh_token>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H Content-Type: application/x-www-form-urlencoded https://localhost:8243/revoke
```

``` java
    curl -k -v -d "token=4ed29669-a457-3f83-af1e-180cad271cca&token_type_hint=refresh_token" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

``` java
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

!!! note
Note that for users to be counted in the [Registered Users for Application statistics](https://docs.wso2.com/display/AM260/Viewing+API+Statistics#ViewingAPIStatistics-topUsers) which takes the number of users shared each of the Application, they should have to generate access tokens using [Password Grant](https://docs.wso2.com/display/AM210/Password+Grant) type.


