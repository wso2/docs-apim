# Configuring an External Key Manager

WSO2 API Microgateway can be configured with an external key manager. Token introspection is

[OAuth 2.0 Token Introspection](https://tools.ietf.org/html/rfc7662) is a specification that defines how a protected resource can validate and obtain meta-information of OAuth2.0 tokens issued by an authorization server. This specification defines an introspect endpoint that provides meta-information including the token validity of a given OAuth2.0 token.  The introspection endpoint is implemented on the authorization server-side.

WSO2 Microgateway can be configured to connect with an introspect endpoint (/introspect) of an external key manager.  If the API Microgateway receives an opaque (non-JWT) token, then the external key manager's introspect endpoint will be called in order to validate the token upon configuration is enabled. Microgateway will cache the tokens once it is identfied as an valid token, upon recieving the same token it will take the decision from the cache without connecting again with the key manager.

### Enable introspection with external key managers

Microgateway by default connect with WSO2 API Manager key validation service which is different from standard introspection. Provide following configurations in the `micro-gw.conf` to configure key manager. In order to enable introspection with external key manager "external" parameter should be set under the key manager configurations.

``` toml
# Key manager configurations
[keyManager]
    # Connection URL of the Key Manager server
    serverUrl = "https://localhost:9443"
    # The token endpoint context of the Key Manager server
    tokenContext = "oauth2"
    # timestamp skew in seconds which added when checking the token validity period
    timestampSkew = 5000
    # External Key Manager
    external = true
```

Different key managers might use different mechanisms to **secure the introspect endpoint.** Microgateway supports following authentication schemes with introspection endpoint

#### Basic Authentication

Following configuration in `micro-gw.conf` can be used to provide the basic authentication details.

``` toml
# Basic security configurations
[keymanager.security.basic]
    enabled = true
    username = "admin"
    password = "admin"
```

These values can be set as environment variables as well.

#### OAuth2

Provide following configurations in the `micro-gw.conf` to configure the key manager.

If OAuth2 is used in key manager to protect the introspect endpoint then in microgateway oauth2 authentication should be enabled for introspection. 

``` toml
[keymanager.security.oauth2]
    enabled = true
    # Authentication credentials should be sent via (AUTH_HEADER_BEARER/POST_BODY_BEARER/NO_BEARER)?
    credentialBearer = "AUTH_HEADER_BEARER"
    # Token URL for the authorization endpoint
    tokenUrl = ""
```

Microgateway supports different grants when introspect endpoint is secured with the OAuth2.

 - Client Credentials - Client Credentials Grant config

    ``` yml
    # Oauth2 security grants
    [keymanager.security.oauth2.clientCredential]
        enabled = true
        clientId = ""
        clientSecret = ""
        scopes = ""
    ```

    This will use the client credential grant type to get a valid token in order to call the introspect endpoint. The gateway will re use this token until its expiry time and renew the token only when token gets expired.

 - Password grant

    ``` yml
    [keymanager.security.oauth2.password]
        enabled = true
        clientId = ""
        clientSecret = ""
        scopes = ""
        username = ""
        password = ""
    ```

 - Direct token -Direct Access Token Method

    ``` yml
    [keymanager.security.oauth2.directToken]
        enabled = true
        accessToken = ""
    ```

    In this method the access token can be directly configured in the configuration, so that gateway will send that token when calling the secured introspection endpoint

-   Refresh Grant

    ``` yml
    [keymanager.security.oauth2.refresh]
        enabled = true
        refreshUrl = ""
        scopes = ""
        refreshToken = ""
        clientId = ""
        clientSecret = ""
    ```

    The refresh grant can used with "Password Grant" or with "Direct Token" method in order to renew the token in case of the access token expires. When refresh config is enabled, if password grant is used then gateway will automatically renews the access token if the existing token expires. And also it will renew the token when direct token method is used also.


