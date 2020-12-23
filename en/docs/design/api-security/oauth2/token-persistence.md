# Token Persistence

This guide describes OAuth2 token persistence and the possible approaches you can follow for token persistence in a production environment. The OAuth2 component in WSO2 API Manager has two implementations that you can use to handle token persistence in the database, which are namely synchronous and asynchronous token persistence. 

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

If an existing access token is not found, the OAuth2 component creates a new access token and adds it to a persisting queue. Once the token is added to the queue, the token is returned to the client.There are background threads that consume the queue, and persist the tokens in the queue to the database.

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

    ```
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

