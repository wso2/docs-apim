# Token Persistence

In WSO2 API Manager, OAuth2 token persistence is integral to authentication and authorization. This guide describes OAuth2 token persistence with JWTs and Opaque tokens and the possible approaches you can follow for token persistence in a production environment. 

## JWT tokens

Using JWTs instead of Opaque is the recommended approach in WSO2 API Manager since Gateway can self validate JWTs without additional hops to KeyManager unlike Opaque.

For JSON Web Tokens (JWTs), by default API Manager stores references instead of the complete tokens, optimizing storage. For JWTs, token generation or validation triggers interactions with the database. 

The JWT token persistence behavior differs from the opaque token persistence behavior, where an existing active token is retrieved upon a token request. The JWT token issuer always provides a new JWT token because the complete JWT access token is not persisted in the database. Consequently, achieving the same token generation behavior for JWTs as for opaque tokens requires customizing the token issuer.

The following sections guide you through how you can further optimize the default JWT persistence in API Manager.

### Why Token Persistence Optimization for JWTs

In large-scale deployments of WSO2 API Manager, when there are millions of users and concurrent user logins, number of tokens in database can exponentially grow and scaling will be extremely hard. This can also result in a noticeable decrease in Transactions Per Second (TPS) for token generation.  For example, consider a large telco provider company with 1.4 million subscribers with a 1000 per sec daily token generation rate. Scaling the deployment by increasing the number of key manager nodes, partitioning the database or periodically running the token clean up scripts might not give you the optimal TPS as needed. For such a requirements, token persistence optimization comes into play by using JWTs as both access and refresh tokens, not persisting them during generation while still supporting essential token revocation and refresh-grant functionalities.

- Currently, this solution is only recommended to be used in deployments where API-M is used as the Key Manager. It is not yet recommended to be used when WSO2 IS is used as a Key Manager.
- Token persistence optimization feature will only work with JWT tokens as they can be self validated.
- If you are enabling this feature in an existing or migrating setup,
      - The token type of all the existing applications should be changed to JWT (including the system applications; publisher, developer portal and admin portal). 
         - Follow [Update token type of an Application from OAUTH to JWT]({{base_path}}/reference/product-apis/devportal-apis/devportal-v3/devportal-v3/#tag/Applications/paths/~1applications~1%7BapplicationId%7D/put) to update the existing developer portal applications' token types.
         - Follow the instructions for existing deployments in [Enable JWT for Portals]({{base_path}}/install-and-setup/setup/security/securing-api-m-web-portals/#enable-jwt-for-web-portals) to update existing portal applications.
      - The already generated Opaque tokens before enabling the feature will continue to work.
- This solution will not persist the tokens during generation, hence upon every token generation request, a new JWT access and refresh token pair will be generated. So it is recommended to use this feature only with short lived access and refresh tokens.
- The session invalidation will not perform token revocation after user logout in portals.   
- This optimization feature is not compatible with [Token Binding feature](https://is.docs.wso2.com/en/next/references/token-binding/) available as an identity feature in API-M.
- If you are using a customized JWT token issuer and wish to enable this feature, to support the additional system claims, make sure your custom JWTTokenIssuer is extending `org.wso2.is.key.manager.tokenpersistence.issuer.ExtendedJWTTokenIssuer` class.

### Enabling Token Persistence Optimization

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


## Opaque tokens

By default, the API-M stores opaque tokens directly in the database, preserving their original form. The OAuth2 component in WSO2 API Manager(WSO2 API-M) has two implementations you can use to handle opaque token persistence in the database, which are namely synchronous and asynchronous token persistence.

The following sections guide you through the difference between these two approaches and how to configure them in a production environment.

-   [Synchronous token persistence](#synchronous-token-persistence)
-   [Asynchronous token persistence](#asynchronous-token-persistence)

### Synchronous token persistence

[![Synchronous token persistence]({{base_path}}/assets/img/learn/synchronous-token-persistence.png)]({{base_path}}/assets/img/learn/synchronous-token-persistence.png)

The flow of synchronous token persistence is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in WSO2 API-M checks for an existing active access token for the given client/user/scope.
    It first checks the cache and if an active token is not found, it then checks the database.

3.  If an active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component creates a new access token and persists it in the database using the same thread. Once it is persisted, the new token is returned to the client.

!!! Info
    Synchronous token persistence can be enabled by adding the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file to **set the `poolsize` property to 0**.

``` toml
[session_data]
persistence.persistence_pool_size = 0
```

By default, synchronous token persistence is enabled in WSO2 API Manager 4.0.0. To indicate the number of times to retry in the event of a `CONN_APP_KEY` violation when storing the access token, navigate to file `<APIM_HOME>/repository/conf/deployment.toml` and add the following configuration.

``` toml
[oauth.token_generation]
"retry_count_on_persistence_failures"=5
```
    
### Asynchronous token persistence

[![Asynchronous token persistence]({{base_path}}/assets/img/learn/asynchronous-token-generation.png)]({{base_path}}/assets/img/learn/synchronous-token-persistence.png)

If an existing access token is not found, the OAuth2 component creates a new access token and adds it to a persisting queue. Once the token is added to the queue, the token is returned to the client. There are background threads that consume the queue, and persist the tokens in the queue to the database.

!!! info

    To enable asynchronous token persistence, add following configuration in the `<APIM_HOME>/repository/conf/deployment.toml` to **set the `poolsize` property to a value higher than 0**

    ``` toml
        [session_data]
        persistence.persistence_pool_size = 100
    ```

!!! Attention "Going Forward"

    Previously, WSO2 recommended asynchronous token persistence for certain scenarios. However, we have empirically found out that synchronous token persistence has a better overall performance in general. Hence, asynchronous token persistence support will be deprecated in future versions.


### Recovery flow for token persistence

This section explains the recovery flow triggered in WSO2 API Manager for exceptional cases that may occur in a production environment caused by the client application mishandling the `CON_APP_KEY` constraint that is explained below.

-   [CON\_APP\_KEY constraint](#conn-app-key-constraint)
-   [Asynchronous token persistence](#asynchronous-token-persistence-recovery-flow)
-   [Synchronous token persistence](#synchronous-token-persistence-recovery-flow)

<h4 id="conn-app-key-constraint"> CON_APP_KEY constraint </h4>

For a given set of consumer key, user, and scope values, there can be only one ACTIVE access token. The CON_APP_KEY constraint in the IDN_OAUTH2_ACCESS_TOKEN table enforces this by allowing only one active access token for a given set of consumer key, user, and scope values. This constraint may be violated in a scenario where two or more identical token requests come from the same application.

The above scenario is unlikely, because in practice an application is usually designed to handle this situation using scopes, or in the case of a multi-threaded client, there is usually a separate thread to acquire access tokens so that other threads can retrieve from it.

<h4 id="asynchronous-token-persistence-recovery-flow"> Asynchronous token persistence </h4>

##### Flow

For instance, if the violation mentioned above occurs with two nodes of a cluster receiving identical access token requests, the flow of the asynchronous token persistence is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in both nodes of WSO2 API-M checks for an existing active access token for the given client/user/scope. Both nodes first check the cache and if an active token is not found, the it checks the database.

3.  If an existing active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component in **both nodes** creates a new access token and adds it to the persisting queue.
5.  After adding it to the queue, the access token is returned to the client.
6.  However, the background threads that consume the persisting queue in both servers (nodes) attempt to persist the token to the database. One of the servers succeed and successfully persist the access token to the database, and the other server receives an error due to violation of the `CON_APP_KEY` constraint. The violation is due to the fact that the same access token was already persisted by the first server in the cluster and is currently active.

#### Recovery flow

To handle this situation, WSO2 API Manager has a recovery flow for token persistence that does the following:

-   As both access tokens were returned to the client, there must be a database entry for both tokens.
-   As the access token that the second node is attempting to persist is not allowed due to the violation, the recovery flow takes the latest entry in the database, which is the active access token persisted by the first node, and marks it as INACTIVE.
-   The access token that is received from the second node is now saved as an ACTIVE access token in the database. Therefore, one of the access tokens returned to the client is an INACTIVE token.

!!! tip
    If the client application is not designed to handle the `CONN_APP_KEY` constraint violation using scopes, you can avoid the situation described above and avoid any invalid tokens by using synchronous token persistence. To do this, add following configuration in the `<APIM_HOME>/repository/conf/deployment.toml` to **set the `poolsize` property to 0**.

    ```toml
        [session_data]
        persistence.persistence_pool_size = 0
    ``` 

<h4 id="synchronous-token-persistence-recovery-flow"> Synchronous token persistence </h4>

##### Flow

The flow of the synchronous token persistence when receiving two identical access token requests is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in both nodes of WSO2 API-M checks for an existing active access token for the given client/user/scope. Both nodes first check the cache and if an active token is not found, the database is checked.

3.  If an existing active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component in **both nodes** creates a new access token and persists the access token to the database using the same thread.
5.  One of the nodes will persist the token successfully and return it to the client but the other node will receive an error due to the violation of the CON_APP_KEY constraint.

#### Recovery flow

The process flow now moves on to the recovery flow in order to handle the `CON_APP_KEY` constraint violation and it is executed as follows: 

-   As the same thread is being used, the OAuth2 component in the second node checks the database again for an ACTIVE access token.
-   As there is now an ACTIVE token, which was persisted by the first node, the second node now returns the access token persisted by the first node to the client.
-   Both access token requests receive the same access token.
