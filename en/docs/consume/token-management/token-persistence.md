# Token Persistence Management

In WSO2 API Manager, [OAuth2 token persistence](https://is.docs.wso2.com/en/latest/deploy/token-persistence/) is integral to authentication and authorization. By default, the API-M stores opaque tokens directly in the database, preserving their original form. For JSON Web Tokens (JWTs), the API Manager stores references instead of the complete tokens, optimizing storage. Token generation or validation triggers interactions with the database. Using JWTs instead of Opaque is the recommended apporach in WSO2 API Manager since, Gateway can self validate JWTS without additional hops to KeyManager unlike Opaque.

## Why Token Persistence Optimization needed in API Manager for JWTs

Even when using JWTs, significant challenge arises due to the necessity of retaining JWT IDs (JTIs) for each access token generated. Currently this persistence is vital for two key functions:
   - Revocation: Access tokens may need revocation before their scheduled expiration, requiring token references.
   - Refresh Token Flow: The refresh token mechanism relies on these references to enable seamless token refresh.

In large-scale deployments of WSO2 API Manager, this approach strains the persistence layer, resulting in a noticeable decrease in Transactions Per Second (TPS) for token generation. The following sections describe a solution that optimizes TPS, especially during high-load scenarios, while still supporting essential token revocation and refresh-grant functionalities. for JWTs.

## How Token Persistence Optimization Works

### Access Token and Refresh Token Generation

API-M will only issue JWTs as access and refresh tokens during the generation process and will not be persisted in the database. As refresh token is a single use token, during generation a reference to the used refresh token will be persisted in the database for validation of future refresh grant requests. A new JWT access token will be generated per each token request without revoking the previously available active token.

### Token Revocation

Earlier, if a token is revoked directly by calling the `/oauth2/revoke` endpoint or indirectly revoked through a user change or an application change event, the persisted references to those tokens (JWT) are marked with a revoked state. With this solution, the behavior for direct token revocations occurred by calling `/oauth2/revoke` endpoint will remain the same. However, since we are not persisting the active tokens in the database, in cases of indirect token revocation due to changes in application or user operations, this solution will persist certain event relevant data such as client ID, username, and revocation time in the database.

### Token Validation

The following set of additional claims are introduced to both access and refresh JWTs, to self validate the token. So these claim names are reserved hence make sure that you dont use them as custom claims if using a custom JWT token issuer.
- entity_id
- is_federated
- is_refresh
- is_consented
- tenant_domain

Token introspection and User info OIDC endpoints of KeyManager will self validate the JWT tokens by validating the signature, client id etc. Additionally, it will validate the token against the persisted layer to check if token was revoked directly or indirectly (via user or application change event) or if is an invalidated refresh token.


## Prerequisits 

- Once, token persistence optimization is enabled, you cannot revert it back. If you revert, the tokens generated while it was on will be considered as invalid in the Key Manager.
- Once enabled, the product will only works with JWTs. Hence the token type of all the existing applications should be changed to JWT (including the OAuth system applications; publisher, developer portal and admin portal).
- This solution is only recommended to be used in deployments where API-M is used as the Key Manager. It is not recommended to be used when WSO2 IS is used as a Key Manager.


### If you are migrating from a previous API-M version

- Make sure to change the token type of all the old applications to JWT. 
- The already generated Opaque tokens before enabling the feature will continue to work. However, newly generated Opaque tokens will no longer work once feature is enabled.
- Change the token type of the system applications: publisher, devportal and admin portal to JWT from management console.


## Enabling Token Persistence Optimization

1. Add the following to the `deployment.toml` in API Manager. Add this to the Control plane profile if you are using a distributed API-M setup.
    

   ```toml
    [oauth.token_persistence]
    enable=false

    [oauth.revoked_token_headers_in_response]
    enable=false

    [[oauth.extensions.token_types]]
    name = "JWT"
    issuer = "org.wso2.is.key.manager.tokenpersistence.issuer.ExtendedJWTTokenIssuer"

    [transport.https.properties]
    maxHttpHeaderSize = "12288"

   [apim.oauth_config]
   enable_jwt_for_portals = true
   
   [oauth]
   add_tenant_domain_to_access_token = true
   ```
   
2. Restart the server.

## Limitation

- This optimization feature is not compatible with [Token Binding feature](https://is.docs.wso2.com/en/next/references/token-binding/) offered as an identity feature in API-M.
- This solution will not be compatible with any Opaque token generated after enabling the feature.
- The behavior to return revoke previosly available active token for a matching clientid, user and scopes combination by using the following configuration in `deployment.toml` is no longer supported with the feature. Returning previosly available active token is also no longer supported.

    ```toml
    [oauth.token_renewal]
    renew_access_token_per_request = true
    ``` 
- Tokens cannot be explictly marked as revoked up on indirect events like client application changes or user changes. All such changes to application and user entities will be persisted as separate events which will be evaludated during each token validaiton. Hence, assuming maximum number of apps is M and maximum number of users in the system are N, the idirectly revoked events in the persistence layer can grow upto O(M) and O(N) of records. 
- Simlarly Gateway will continue to have a similar number of entries in its revoked event in-memory maps. So it is recommended to not use long live access tokens or refresh tokens and make sure to manually clean up the following tables in AM table time to time.

     - `AM_APP_REVOKED_EVENTS`
     - `AM_SUBJECT_ENTITY_EVENTS`
     - `IDN_APP_REVOKED_EVENTS`
     - `IDN_SUBJECT_ENTITY_EVENTS`
     
- The SessionDataPublisher in API-M cannot no longer revoke the logged-in tokens during user logout.
- If you are using a customized JWT token issuer and wish to enable this feature, to support the additional system claims, make sure your custom JWTTokenIssuer is extending `org.wso2.is.key.manager.tokenpersistence.issuer.ExtendedJWTTokenIssuer` class.
