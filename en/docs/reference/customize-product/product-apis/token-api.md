# Token API

Users need access tokens to invoke APIs subscribed under an application. Access tokens are passed in the HTTP header when invoking APIs. The API Manager provides a Token API that you can use to generate and renew user and application access tokens. The response of the Token API is a JSON message. You extract the token from the JSON and pass it with an HTTP Authorization header to access the API.

The topics below explain how to generate access tokens and authorize them. WSO2 API Manager supports the following common [authorization grant types](http://tools.ietf.org/html/rfc6749#section-1.3) and you can also define additional types.

For more information on Token APIs, see the following topics.

/\*\*/ Revoking access tokens Configuring the token expiration time Token Persistence

### Revoking access tokens

After issuing an access token, a user or an admin can revoke it in case of theft or a security violation. You can do this by calling the Revoke API using a utility like cURL. The Revoke API's endpoint URL is <http://localhost:8280/revoke> .

!!! note
    You can also revoke refresh tokens. For more information, see [Revoking a refresh token](../../OLD_learn/api-security/oauth2/grant-types/refresh-token-grant.md#revoking-a-refresh-token) .


You can use any of the following cURL command options to revoke an access token:

**Option 1**

The parameters required to invoke the following API are as follows:

-`token` - The token to be revoked

-`<base64 encoded (clientId:clientSecret)>` - Use a base64 encoder (e.g., <https://www.base64encode.org/> ) to encode your client ID and client secret using the following format: `<clientId>:<clientSecret>` Thereafter, enter the encoded value for this parameter.

-   [**Format**](#option1-format)
-   [**Example**](#option1-example)
-   [**Response**](#option1-response)

``` java
    curl -k -v -d "token=<REFRESH_TOKEN_TO_BE_REVOKED>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

``` java
    curl -k -v -d "token=a0d210c7a3de7d548e03f1986e9a5c39" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

You receive an empty response with the HTTP status as 200. The following HTTP headers are returned:

Note that if you use an invalid access token, you still receive an empty response with the HTTP status as 200 but only the following HTTP headers are returned:

``` java
    Revokedaccesstoken: a0d210c7a3de7d548e03f1986e9a5c39
    Authorizeduser: admin@carbon.super
    Revokedrefreshtoken: 5e87a8235cd4d066e15c4c989f5ecf94
    Content-Type: text/html
    Pragma: no-cache
    Cache-Control: no-store
    Date: Tue, 23 Aug 2016 19:28:52 GMT
    Transfer-Encoding: chunked
```

``` java
    Content-Type: text/html
    Pragma: no-cache
    Cache-Control: no-store
    Date: Tue, 23 Aug 2016 19:31:45 GMT
    Transfer-Encoding: chunked
```

**Option 2**

The parameters required to invoke the following API are as follows:

-`token` - The token to be revoked

-`<base64 encoded (clientId:clientSecret)>` - Use a base64 encoder (e.g., <https://www.base64encode.org/> ) to encode your client ID and client secret using the following format: `<clientId>:<clientSecret>` Thereafter, enter the encoded value for this parameter.

-`token_type_hint` = This parameter is optional. If you do not specify this parameter, then WSO2 Identity Server (WSO2 IS) will search in both key spaces (access and refresh) and if it finds a matching token then it will be revoked. Therefore, if this parameter it not specified the token revokation process takes longer. However, if you specify this parameter then WSO2 IS only searches in the respective token key space, hence the token revokation process is much faster.

-   [**Format**](#option2-format)
-   [**Example**](#option2-example)

``` java
    curl -k -v -d "token=<REFRESH_TOKEN_TO_BE_REVOKED>&token_type_hint=<access_token_or_refresh_token>" -H "Authorization: Basic <base64 encoded (clientId:clientSecret)>" -H Content-Type: application/x-www-form-urlencoded https://localhost:8243/revoke
```

``` java
    curl -k -v -d "token=1d18ec65-6151-3499-9352-68afe64299c3&token_type_hint=access_token" -H "Authorization: Basic OVRRNVJLZWFhVGZGeUpRSkRzam9aZmp4UkhjYTpDZnJ3ZXRual9ZOTdSSzFTZWlWQWx1aXdVVmth" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/revoke
```

!!! note
Revoking access tokens obtained with an Implicit grant

If you obtained an access token with the Implicit grant type, you do not have to provide the client secret to revoke it. The sample cURL command to revoke an access token with Implicit grant is given below.

``` java
    curl -X POST -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d "token=<REFRESH_TOKEN_TO_BE_REVOKED>&token_type_hint=access_token&client_id=<CLIENT_ID>" http://localhost:8243/revoke
```


### Configuring the token expiration time

User access tokens have a fixed expiration time, which is set to 60 minutes by default. Before deploying the API Manager to users, extend the default expiration time by editing the `<AccessTokenDefaultValidityPeriod>` element in the `<APIM_HOME>/repository/conf/identity/identity.xml` file.

Also take the **time stamp skew** into account when configuring the expiration time. The time stamp skew is used to manage small time gaps in the system clocks of different servers. For example, let's say you have two Key Managers and you generate a token from the first one and authenticate with the other. If the second server's clock runs 300 seconds ahead, you can configure a 300s time stamp skew in the first server. When the first Key Manager generates a token (e.g., with the default life span, which is 3600 seconds), the time stamp skew is deducted from the token's life span. The new life span is 3300 seconds and the first server calls the second server after 3200 seconds.

You configure the time stamp skew using the `<TimestampSkew>` element in the `<APIM_HOME>/repository/conf/identity/identity.xml` file.

!!! tip
**Tip** : Ideally, the time stamp skew should not be larger than the token's life span. We recommend you to set it to zero if the nodes in your cluster are synchronized.


When a user access token expires, the user can try regenerating the token.

### Token Persistence

The OAuth2 component in WSO2 API Manager (WSO2 API-M) has two implementations that you can use to handle token persistence in the database, which are namely synchronous and asynchronous token persistence. The following sections guide you through the difference between these two approaches and how to configure them in a production environment.

-   [Synchronous token persistence (When PoolSize = 0)](#TokenAPI-Synchronoustokenpersistence(WhenPoolSize=0))
-   [Asynchronous token persistence (When PoolSize &gt; 0)](#TokenAPI-Asynchronoustokenpersistence(WhenPoolSize%3E0))

The Synchronous or Asynchronous  behavior is governed by the `PoolSize` property under `SessionDataPersist` element in the `identity.xml` file.

#### Synchronous token persistence (When PoolSize = 0)

![]({{base_path}}/assets/attachments/103335249/103335250.png)
The flow of synchronous token persistence is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in WSO2 API-M checks for an existing active access token for the given client/user/scope.
    It first checks the cache and if an active token is not found, it then checks the database.

3.  If an active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component creates a new access token and persists it in the database using the same thread. Once it is persisted, the new token is returned to the client.

        !!! tip
    Enabling synchronous token persistence

    To enable synchronous token persistence, follow the steps in the [Enabling Authentication Session Persistence](_Enabling_Authentication_Session_Persistence_) tutorial and **set the `<poolsize>` property to 0** .


#### Asynchronous token persistence (When PoolSize &gt; 0)

![]({{base_path}}/assets/attachments/103335249/103335251.png)
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

    To enable asynchronous token persistence, follow the steps in the [Enabling Authentication Session Persistence](_Enabling_Authentication_Session_Persistence_) tutorial and **set the `<poolsize>` property to a value higher than 0** . The value provided for the `<poolsize>` property determines the number of threads in the thread pool that are used to consume the token persisting queue.

!!! info
The main difference between synchronous and asynchronous token persistence is that the OAuth2 component in the synchronous token persistence implementation waits for the access token to be persisted in the database before returning it to the client.


#### Recovery flow for token persistence

This section explains the recovery flow triggered in WSO2 API Manager for exceptional cases that may occur in a production environment caused by the client application mishandling the `CON_APP_KEY` constraint that is explained below.

-   [CON\_APP\_KEY constraint](#TokenAPI-CON_APP_KEYconstraint)
-   [Asynchronous token persistence](#TokenAPI-Asynchronoustokenpersistence)
-   [Synchronous token persistence](#TokenAPI-Synchronoustokenpersistence)

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

