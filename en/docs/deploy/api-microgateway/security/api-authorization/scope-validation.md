# Scope Validation

Scopes are used to validating the rights to access the requested API resource. When an API/operation is protected with scopes, the invocation request should have a token with one of the required scopes to successfully access the resource. To provide scopes for authorization, we need to define the OAuth2 security scheme with relevant scopes for the operation in the API Definition.

WSO2 Microgateway provide scope validation for below API security types,

-   OAuth2 tokens (JWT only) <!-- TODO: Enable once the feature is completed for MGW 4.0.0
    Basic authentication
-->


### Define supported scopes in API definition

First, define an OAuth2 scheme under components/securitySchemes with all supported scopes. If you define multiple scopes under a security scheme, they will be in OR relationship. i.e. Providing at least one scope of them, is enough to authorize the request successfully.

!!! note
    The following example shows how to define OAuth2 security schemes in [OAS3](https://swagger.io/docs/specification/authentication/oauth2/) . If you are using an OAS2 API definition, please refer to [this](https://swagger.io/docs/specification/2-0/authentication/api-keys/) [swagger document](https://swagger.io/docs/specification/2-0/authentication/) on defining authorization in OAS2.

``` yml
components:
  securitySchemes:
    OAuth2:
      type: oauth2
      flows:
        authorizationCode:
          authorizationUrl: https://example.com/oauth/authorize
          tokenUrl: https://example.com/oauth/token
          scopes:
            read: Grants read access
            write: Grants write access
            admin: Grants access to admin operations
```

Then, list the scopes requires by each operation or API by listing oauth2 security with relevant scopes.

List the scopes required by each operation in the `security` section of that operation:

``` yml
# Assign oauth2 security scheme with scopes to the operation
paths:
  "/pet/{petId}":
     get:
       security:
         - OAuth2:
           - read
           - write
```

!!! note
    When an oauth2 type security scheme is given under operation or API, it will secure the operation or API with OAuth2 security (JWT and opaque security tokens).

### Validating scopes through JWT authentication

If the operation or API is secured with an OAuth2 security scheme with scopes, you can authenticate the API request with a valid JWT token. However, the JWT token should have at least one required scope under the "scopes" claim to authorize the request.

``` yml
"scope": "read write" # payload of the JWT should contain required scopes separated by space
```

<!-- TODO: Enable once the feature is completed for MGW 4.0.0
### Validating scopes through opaque token authentication

If the operation or API is secured with an OAuth2 security scheme with scopes and configured the key manager properly, then you can authenticate the API request with a valid opaque token. However, then the key manager should provide the required scopes after validating the token to authorize the request.

### Validating scopes through basic authentication

Scopes in security schemes (typically OAuth schemes) provide the ability to restrict the usage of certain endpoints to the users by limiting the access of that endpoint to the users with the corresponding scopes. In micro-gateway it is possible to validate the users (basic authentication) with scopes.

First, in the operation level or the API level, basic authentication security should be declared alongside oauth2 security with scopes.

``` yml
paths:
 "/pet/{petId}":
    get:
      security:
        - mybasic: []
          - OAuth2:
            - read
            - write
        
components:
  securitySchemes:
    mybasic:
      type: http
      scheme: basic
    OAuth2:
      type: oauth2
      flows:
      authorizationCode:
        authorizationUrl: https://example.com/oauth/authorize
        tokenUrl: https://example.com/oauth/token
        scopes:
          read: Grants read access
          write: Grants write access
          admin: Grants access to admin operations
```

Then, the required scopes should be added to the "micro-gw.conf" file (comma separated) under the users which are provided access to certain endpoints.

``` java tab="Format"
[b7a.users.<username>]
    password="@<HASH_ALGO>:{<HASH_ALGO(password)>}"
    scopes="scope1,scope2"
```

``` java tab="Example"
["b7a.users.shani"]
    password="@sha256:{5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8}"
    scopes="read,write"
```

 The users with the scopes in the configuration can access the endpoints with certain scopes included in the oauth2 scheme using basic authentication.
-->

