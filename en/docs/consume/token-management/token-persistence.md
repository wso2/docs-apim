# Token Persistence Management

In WSO2 API Manager, [OAuth2 token persistence](https://is.docs.wso2.com/en/latest/deploy/token-persistence/) is integral to authentication and authorization. By default, the API-M stores opaque tokens directly in the database, preserving their original form. For JSON Web Tokens (JWTs), the API Manager stores references instead of the complete tokens, optimizing storage. Token generation or validation triggers interactions with the database. Using JWTs instead of Opaque is the recommended apporach in WSO2 API Manager since, Gateway can self validate JWTS without additional hops to KeyManager unlike Opaque.

## Why Token Persistence Optimization

In large-scale deployments of WSO2 API Manager, when there are millions of users and concurrent user logins, number of tokens in database can exponentially grow and scaling will be extremely hard. This can also result in a noticeable decrease in Transactions Per Second (TPS) for token generation.  For example, consider a large telco provider company with 1.4 million subscribers with a 1000 per sec daily token generation rate. Scaling the deployment by increasing the number of key manager nodes, partitioning the database or periodically running the token clean up scripts might not give you the optimal TPS as needed. For such a requirements, token persistence optimization comes into play by using JWTs as both access and refresh tokens, not persisting them during generation while still supporting essential token revocation and refresh-grant functionalities.

## Things To Be Aware Before Enabling Token Persistence Optimization

- This solution is only recommended to be used in deployments where API-M is used as the Key Manager. It is not recommended to be used when WSO2 IS is used as a Key Manager.
- Once, token persistence optimization is enabled, DO NOT revert it back. If you revert, the tokens generated while it was on will be considered as invalid in the Key Manager.
- Token persistence optimization feature will only work with JWT tokens as they can be self validated.
- It is recommended to enable this feature always in a fresh API-M deployment.
- If you are enabling this feature in an existing or migrating setup,
      - The token type of all the existing applications should be changed to JWT (including the system applications; publisher, developer portal and admin portal). 
         - Follow [Update token type of an Application from OAUTH to JWT]({{base_path}}/reference/product-apis/devportal-apis/devportal-v3/devportal-v3/#tag/Applications/paths/~1applications~1%7BapplicationId%7D/put) to update the existing developer portal applications' token types.
         - Follow the instructions for existing deployments in [Enable JWT for Portals]({{base_path}}/install-and-setup/setup/security/securing-api-m-web-portals/#enable-jwt-for-web-portals) to update existing portal applications.
      - The already generated Opaque tokens before enabling the feature will continue to work. However, this solution will not be compatible with any Opaque token generated after enabling the feature.
- This optimization feature is not compatible with [Token Binding feature](https://is.docs.wso2.com/en/next/references/token-binding/) offered as an identity feature in API-M.
- The behavior to revoke existing active token during JWT generation for a matching clientid, user and scopes combination is no longer supported with the feature.
- This solution will not persist the tokens during generation, hence upon every token generation request, a new JWT access and refresh token pair will be generated. So it is recommended to use this feauture only with short lived access and refresh tokens.
- The session invalidation will not perform token revocation after user logout in portals.   
- If you are using a customized JWT token issuer and wish to enable this feature, to support the additional system claims, make sure your custom JWTTokenIssuer is extending `org.wso2.is.key.manager.tokenpersistence.issuer.ExtendedJWTTokenIssuer` class.
- After enabling this feature both access and refresh tokens will be generated in JWT which can be CPU intensive operations impacting the performance.

## Enabling Token Persistence Optimization

1. Follow the steps in [Enable JWT for Web Portal]({{base_path}}/install-and-setup/setup/security/securing-api-m-web-portals/#enable-jwt-for-web-portals).
2. Add the following to the `deployment.toml` in API Manager. Add this to the Control plane profile if you are using a distributed API-M setup.
    
   ```toml
    [oauth.token_persistence]
    enable=false

    [oauth.revoked_token_headers_in_response]
    enable=false

    [[oauth.extensions.token_types]]
    name = "JWT"
    issuer = "org.wso2.is.key.manager.tokenpersistence.issuer.ExtendedJWTTokenIssuer"  
   ``` 
3. Restart the server.
