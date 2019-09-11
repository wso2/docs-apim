# Token Persistence

The OAuth2 component in WSO2 API Manager (WSO2 API-M) has two implementations that you can use to handle token persistence in the database, which are namely synchronous and asynchronous token persistence. The following sections guide you through the difference between these two approaches and how to configure them in a production environment.

-   [Synchronous token persistence (When PoolSize = 0)](https://docs.wso2.com/display/SHAN/Token+API#TokenAPI-Synchronoustokenpersistence(WhenPoolSize=0))
-   Asynchronous token persistence (When PoolSize &gt; 0)

The Synchronous or Asynchronous  behavior is governed by the `PoolSize` property under `SessionDataPersist` element in the `identity.xml` file.

#### Synchronous token persistence (When PoolSize = 0)

The flow of synchronous token persistence is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in WSO2 API-M checks for an existing active access token for the given client/user/scope.
    It first checks the cache and if an active token is not found, it then checks the database.

3.  If an active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component creates a new access token and persists it in the database using the same thread. Once it is persisted, the new token is returned to the client.

        !!! tip
    Enabling synchronous token persistence

    To enable synchronous token persistence, follow the steps in the [Enabling Authentication Session Persistence](https://docs.wso2.com/display/SHAN/Enabling+Authentication+Session+Persistence) tutorial and **set the `<poolsize>` property to 0** .


#### Asynchronous token persistence (When PoolSize &gt; 0)

The flow of asynchronous token persistence is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in WSO2 API-M checks for an existing active access token for the given client/user/scope.
    It first checks the cache and if an active token is not found, it then checks the database.

3.  If an active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component creates a new access token and adds it to a persisting queue.
5.  Once the token is added to the queue, the token is returned to the client.
6.  Thereafter, there are background threads that consume the above queue and they in-turn will persist these tokens to the DB.

        !!! tip
    Enabling asynchronous token persistence

    To enable asynchronous token persistence, follow the steps in the [Enabling Authentication Session Persistence](https://docs.wso2.com/display/SHAN/Enabling+Authentication+Session+Persistence) tutorial and **set the `<poolsize>` property to a value higher than 0** . The value provided for the `<poolsize>` property determines the number of threads in the thread pool that are used to consume the token persisting queue.


!!! info
The main difference between synchronous and asynchronous token persistence is that the OAuth2 component in the synchronous token persistence implementation waits for the access token to be persisted in the database before returning it to the client.

#### Recovery flow for token persistence

This section explains the recovery flow triggered in WSO2 API Manager for exceptional cases that may occur in a production environment caused by the client application mishandling the `CON_APP_KEY` constraint that is explained below.

-   [CON\_APP\_KEY constraint](https://docs.wso2.com/display/SHAN/Token+API#TokenAPI-CON_APP_KEYconstraint)
-   [Asynchronous token persistence](https://docs.wso2.com/display/SHAN/Token+API#TokenAPI-Asynchronoustokenpersistence)
-   [Synchronous token persistence](https://docs.wso2.com/display/SHAN/Token+API#TokenAPI-Synchronoustokenpersistence)

##### CON\_APP\_KEY constraint

`CONSTRAINT CON_APP_KEY UNIQUE (CONSUMER_KEY, AUTHZ_USER,USER_TYPE,TOKEN_STATE,TOKEN_STATE_ID,TOKEN_SCOPE)`

As seen in the code snippet above for a given set of consumer key, user, and scope values, there can be only one ACTIVE access token. The `CON_APP_KEY` constraint in the `IDN_OAUTH2_ACCESS_TOKEN` table enforces this by allowing only one active access token for a given set of consumer key, user, and scope values. This constraint may be violated in a scenario where two or more i dentical token requests come from the same application. **
**

!!! info
The above scenario is unlikely, because in practice an application is usually designed to handle this situation using scopes, or in the case of a multi-threaded client, there is usually a separate thread to acquire access tokens so that other threads can retrieve from it.


##### Asynchronous token persistence

**Flow**

For instance, if the violation mentioned above occurs with two nodes of a cluster receiving identical access token requests, the flow of the asynchronous token persistence is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in both nodes of WSO2 API-M checks for an existing active access token for the given client/user/scope. Both nodes first check the cache and if an active token is not found, the it checks the database.

3.  If an existing active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component in **both nodes** creates a new access token and adds it to the persisting queue.
5.  After adding it to the queue, the access token is returned to the client.
6.  However, the background threads that consume the persisting queue in both servers (nodes) attempt to persist the token to the database. One of the servers succeed and successfully persist the access token to the database, and the other server receives an error due to violation of the `CON_APP_KEY` constraint. The violation is due to the fact that the same access token was already persisted by the first server in the cluster and is currently active.

**Recovery flow**

To handle this situation, WSO2 API Manager has a recovery flow for token persistence that does the following:

-   As both access tokens were returned to the client, there must be a database entry for both tokens.
-   As the access token that the second node is attempting to persist is not allowed due to the violation, the recovery flow takes the latest entry in the database, which is the active access token persisted by the first node, and marks it as INACTIVE.
-   The access token that is received from the second node is now saved as an ACTIVE access token in the database. Therefore, one of the access tokens returned to the client is an INACTIVE token.

!!! tip
**Tip:** If the client application is not designed to handle the `CONN_APP_KEY` constraint violation using scopes, you can avoid the situation described above and avoid any invalid tokens by using synchronous token persistence. To do this, set the `<PoolSize>` property in the `<API-M_HOME>/repository/conf/identity/identity.xml` file to 0.


##### Synchronous token persistence

**Flow**

The flow of the synchronous token persistence when receiving two identical access token requests is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in both nodes of WSO2 API-M checks for an existing active access token for the given client/user/scope. Both nodes first check the cache and if an active token is not found, the database is checked.

3.  If an existing active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component in **both nodes** creates a new access token and persists the access token to the database using the same thread.
5.  Either one of the nodes persist the token successfully and returns it to the client, but the other node receives an error due to violation of the `CON_APP_KEY` constraint.

**Recovery flow**

The process flow now moves on to the recovery flow described above in order to handle the `CON_APP_KEY` constraint violation and is executed as follows:

-   As the same thread is being used, the OAuth2 component in the second node checks the database again for an ACTIVE access token.
-   As there is now an ACTIVE token, which was persisted by the first node, the second node now returns the access token persisted by the first node to the client.
-   Both access token requests receive the same access token.

