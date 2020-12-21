# Obtaining User Profile Information with OpenID Connect

[OpenID Connect](http://openid.net/connect/) is an **authentication protocol** that is a simple identity layer on top of the OAuth 2.0 protocol. It allows clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user in an interoperable and REST-like manner.

You can use WSO2 API Manager to obtain basic profile information about the user who generates the access token. To obtain this information, the `openid` scope needs to be passed, when generating the access token. API Manager will send a JSON Web Token (JWT), which contains information about the user who generates the token, as part of the response for this request. You can configure the information returned with the JWT access token.


The following two options are available to obtain the actual user information.
    -   [Decoding the id_token](#decoding-the-id_token)
    -   [Invoking the userinfo endpoint](#invoking-the-userinfo-endpoint)
    
#### Decoding the id_token

Follow the instructions below to obtain user profile information with OpenID connect with WSO2 API Manager.

1.  Obtain a token using password grant type and `openid` scope. For more information on token generation with password grant type, see [Password Grant Type]({{base_path}}/learn/api-security/oauth2/grant-types/password-grant/). The format of the curl command and a sample is given below :

    ``` bash tab="Format"
    curl -k -d "grant_type=password&username=<USERNAME>&password=<PASSWORD>&scope=openid" -H "Authorization: Basic <BASE64 ENCODED CONSUMER_KEY:CONSUMER_SECRET>, Content-Type: application/x-www-form-urlencoded" https://<GATEWAY_HOSTNAME>:<PORT>/token
    ```
    
    ``` bash tab="Example"
    curl -k -d "grant_type=password&username=testuser&password=testuserpassword&scope=openid" -H "Authorization: Basic M1J6RFNrRFI5ZmQ5czRqY296R2xfVjh0QU5JYTpXeElqSkFJd0dqRWVYOHdHZGFfcGM1Wl94RjRh, Content-Type: application/x-www-form-urlencoded" https://apim.wso2.com:8243/token
            
    ```

2.  You will receive a response in the format shown below. Note that the `id_token` parameter contains the JWT related to user information.
    ``` java
    {
      "access_token": "83705add-d77e-3cc8-9b6a-53d210ed3fed",
      "refresh_token": "4b283fb8-942f-316d-ba90-44b4c76ae419",
      "scope": "openid",
      "id_token": "eyJ4NXQiOiJObUptT0dVeE16WmxZak0yWkRSaE5UWmxZVEExWXpkaFpUUmlPV0UwTldJMk0ySm1PVGMxWkEiLCJraWQiOiJkMGVjNTE0YTMyYjZmODhjMGFiZDEyYTI4NDA2OTliZGQzZGViYTlkIiwiYWxnIjoiUlMyNTYifQ.eyJhdF9oYXNoIjoiY1hoV0l2SXdSYlBnVDBBTG1hekpIUSIsImFjciI6InVybjptYWNlOmluY29tbW9uOmlhcDpzaWx2ZXIiLCJzdWIiOiJzdWJzY3JpYmVyQGNhcmJvbi5zdXBlciIsImF1ZCI6WyJLb05EbGVTckYzbmFYV3doYXZhbzRiQm9NWWNhIl0sImF6cCI6IktvTkRsZVNyRjNuYVhXd2hhdmFvNGJCb01ZY2EiLCJvcmdhbml6YXRpb24iOiJXU08yIiwiaXNzIjoiaHR0cHM6XC9cLzE3Mi4xNi4yLjExMTo5NDQzXC9vYXV0aDJcL3Rva2VuIiwiZXhwIjoxNTExOTUwNDEzLCJpYXQiOjE1MTE5NDY4MTMsImVtYWlsIjoic3ViMUBnbWFpbC5jb20ifQ.gdj0jn4PX5R4j5Y0ZNyEwi2G-NPq3_iW89NqkRxeszdcMLvDP-ncRWMaYyUYc-bQqADekTdQUC6ACSVUlJBKau3Oy8uu-AO8pajIm-hWEX_PBqoMRtFztxggmKFaL6G0rdRBIu8LzL5lbX2cTKss_zYwNmcPDsKDWdQDmL089Wg",
      "token_type": "Bearer",
      "expires_in": 3600
    }
    ```
    
3.  By decoding the `id_token` , a payload similar to the following can be obtained, with user information such as email, organization, etc. For an online tool to decode the JWT, go to <https://jwt.io/>

    ``` java
    {
      "at_hash": "cXhWIvIwRbPgT0ALmazJHQ",
      "acr": "urn:mace:incommon:iap:silver",
      "sub": "user1@carbon.super",
      "aud": [
         "KoNDleSrF3naXWwhavao4bBoMYca"
      ],
      "azp": "KoNDleSrF3naXWwhavao4bBoMYca",
      "organization": "WSO2",
      "iss": "https://172.16.2.111:9443/oauth2/token",
      "exp": 1511950413,
      "iat": 1511946813,
      "email": "user1@gmail.com"
    }
    ```

#### Invoking the userinfo endpoint

You can obtain user information as a payload by invoking the userinfo endpoint with the access token obtained in step 1. The format of the curl command and a sample is given below

``` bash tab="Format"
curl -k -v -H "Authorization: Bearer <ACCESS_TOKEN>" https://<GATEWAY_HOSTNAME>:<PORT>/userinfo
```

``` bash tab="Example"
curl -k -v -H "Authorization: Bearer 83705add-d77e-3cc8-9b6a-53d210ed3fed" https://apim.wso2.com:8243/userinfo
```

The response will be a JSON payload as shown below:

``` java
{
  "sub": "user1@carbon.super",
  "organization": "WSO2",
  "email": "user1@gmail.com"
}
```

!!! note
    By default, only the username (sub claim) information will be available in the response. You can customize the user information returned in the id_token by configuring the user claims for the corresponding Service Provider generated for the Application created in API DevPortal. 
    
    In order to modify the service provider, you can login to APIM Management console(`https://localhost:9443/carbon`), locate the relevant service provider(The corresponding service provider generated for a given application created in API DevPortal will be in 
    `<username>_<application-name>_<environment>` format. ie: `john_pizzashackapp_PRODUCTION`) and follow the steps given in [Service Provider Claim Configuration](https://is.docs.wso2.com/en/5.10.0/learn/configuring-claims-for-a-service-provider/#claim-mapping) to configure the required user claims.


