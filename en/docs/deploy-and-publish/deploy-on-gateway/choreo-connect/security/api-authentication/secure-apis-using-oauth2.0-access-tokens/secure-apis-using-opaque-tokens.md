# Secure APIs Using Opaque Tokens

WSO2 API Microgateway can be configured to connect to a key manager (external or to the WSO2 API Manager). Token introspection is one of the main tasks carried out by the key manager in addition to token generation, revocation, and invalidation.

[OAuth 2.0 Token Introspection](https://tools.ietf.org/html/rfc7662) is a specification that defines how a protected resource can validate and obtain meta-information of OAuth2.0 tokens issued by an authorization server. This specification defines an introspect endpoint that provides meta-information including the token validity of a given OAuth2.0 token.  The introspection endpoint is implemented on the authorization server-side.

WSO2 Microgateway can be configured to connect with an introspect endpoint (/introspect) of a key manager.  If the API Microgateway receives an opaque (non-JWT) token, then the external key manager's introspect endpoint will be invoked to validate the token. Upon validation of the token,  API  Microgateway will cache the token. A subsequent request with the same token will first check the cache before connecting with the key manager.

### Configure API Microgateway to validate OAuth2 Opaque tokens

Microgateway by default connects with the key managers with the token introspection enpoint.

``` java
[keyManager]
    serverUrl = "https://localhost:9443"
    tokenContext = "oauth2"
    [keymanager.security.basic]
        enabled = true
        username = "admin"
        password = "admin"
```

### Securing the Introspect Endpoint

 Different key managers might use different mechanisms to **secure the introspect endpoint.** Microgateway supports following authentication schemes with introspection endpoint

#### Basic Authentication

 The following configuration can be used to provide the basic authentication details.

##### Basic authentication configs

``` yml
# Basic security configurations
[keymanager.security.basic]
    enabled = true
    username = "admin"
    password = "admin"
```

 These values can be set as environment variables as well.

#### OAuth2

 If OAuth2 is used in key manager to protect the introspect endpoint then oauth2 authentication should be enabled for introspection in Microgateway.

##### OAuth2 authentication

``` yml
[keymanager.security.oauth2]
    enabled = true
    # Authentication credentials should be sent via (AUTH_HEADER_BEARER/POST_BODY_BEARER/NO_BEARER)?
    credentialBearer = "AUTH_HEADER_BEARER"
    # Token URL for the authorization endpoint
    tokenUrl = ""
```

 Microgateway supports different grants when introspect endpoint is secured with the OAuth2.

 - **Client Credentials** - Client Credentials Grant config

      ``` yml
        # Oauth2 security grants
        [keymanager.security.oauth2.clientCredential]
            enabled = true
            clientId = ""
            clientSecret = ""
            scopes = ""
      ```

      This will use the client credential grant type to get a valid token in order to call the introspect endpoint. The gateway will reuse this token until its expiry time and renew the token only when token gets expired.

 - **Password grant**

    ``` yml
    [keymanager.security.oauth2.password]
        enabled = true
        clientId = ""
        clientSecret = ""
        scopes = ""
        username = ""
        password = ""
    ```

- **Direct token**  - Direct Access Token Method

    ``` yml
    [keymanager.security.oauth2.directToken]
        enabled = true
        accessToken = ""
    ```

     In this method, the access token can be directly configured in the configuration, so that gateway will send that token when calling the secured introspection endpoint.

- **Refresh Grant**

    ``` yml
    [keymanager.security.oauth2.refresh]
        enabled = true
        refreshUrl = ""
        scopes = ""
        refreshToken = ""
        clientId = ""
        clientSecret = ""
    ```

      The refresh grant can be used with "Password Grant" or "Direct Token" method in order to renew the token in case the access token expires. When refresh config is enabled, if password grant is used then gateway will automatically renews the access token if the existing token expires. And also it will renew the token when the direct token method is used.

### Subscription Validation

WSO2 Microgateway can be configured to validate the API subscriptions when using opaque tokens. This can only be used for APIs which are published in API Manager.

For information on the subscription model and configuration steps, please refer to [the document on Subscription Validation]({{base_path}}/deploy/api-microgateway/security/api-authorization/subscription-validation/).

!!! note
    When the API is created using the dev-first approach, the API Name may contain spaces. But, in order to validate the subscriptions, the same API should be published in API Manager and it does not allow to create APIs with spaces in API Name. Therefore, when using subscription validation in Microgateway, use the API Name without spaces.

    ```
        Ex: My API → My_API or MyAPI
    ```
