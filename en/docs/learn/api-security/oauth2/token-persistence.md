# Token Persistence

This guide describes OAuth2 token persistence and the possible approaches you can follow for token persistence in a production environment. 

## JWT tokens

The JWT token persistence behaviour is different to the opaque token persistence behaviour. The JWT token issuer always provides a new JWT token upon a token request and it does not persist a complete JWT access token in the database but only the JTI value of the JWT token. Therefore, there is no way to achieve the same behaviour for JWT tokens as opaque tokens other than customizing the token issuer. 

### Synchronous token handling

The JWT component in WSO2 API Manager(WSO2 API-M) has synchronous implementation you can use to handle JWT token.

The following sections guide you through the synchronous token handling and how to configure it in a production environment.

## Opaque tokens

The OAuth2 component in WSO2 API Manager(WSO2 API-M) has synchronous implementation you can use to handle opaque token persistence in the database.

The following sections guide you through the synchronous token persistence and how to configure it in a production environment.

### Synchronous token persistence

[![Synchronous token persistence]({{base_path}}/assets/img/learn/synchronous-token-persistence.png)]({{base_path}}/assets/img/learn/synchronous-token-persistence.png)

The flow of synchronous token persistence is as follows:

1.  The client sends an access token request.
2.  The OAuth2 component in WSO2 API-M checks for an existing active access token for the given client/user/scope.
    It first checks the cache and if an active token is not found, it then checks the database.

3.  If an active access token is found, the token is returned to the client.
4.  Alternatively, if an existing access token is not found, the OAuth2 component creates a new access token and persists it in the database using the same thread. Once it is persisted, the new token is returned to the client.

By default, synchronous token persistence is enabled in WSO2 API Manager 3.2.0. To indicate the number of times to retry in the event of a `CONN_APP_KEY` violation when storing the access token, navigate to file `<APIM_HOME>/repository/conf/deployment.toml` and add the following configuration.

``` toml
[oauth.token_generation]
"retry_count_on_persistence_failures"=5
``` 

## Recovery flow of token persistent

This section explains the recovery flow triggered in WSO2 API Manager for exceptional cases that may occur in a production environment caused by the client application mishandling the `CON_APP_KEY` constraint that is explained below.

-   [CON\_APP\_KEY constraint](#conn-app-key-constraint)
-   [Synchronous token persistence in Opaque tokens](#synchronous-opaque-token-persistence-recovery-flow)
-   [Synchronous token handling in JWT tokens](#synchronous-jwt-token-persistence-recovery-flow)

<h4 id="conn-app-key-constraint"> CON_APP_KEY constraint </h4>

For a given set of consumer key, user, and scope values, there can be only one ACTIVE access token. The CON_APP_KEY constraint in the IDN_OAUTH2_ACCESS_TOKEN table enforces this by allowing only one active access token for a given set of consumer key, user, and scope values. This constraint may be violated in a scenario where two or more identical token requests come from the same application.

The above scenario is unlikely, because in practice an application is usually designed to handle this situation using scopes, or in the case of a multi-threaded client, there is usually a separate thread to acquire access tokens so that other threads can retrieve from it.

<h4 id="synchronous-opaque-token-persistence-recovery-flow"> Synchronous token persistence in Opaque tokens </h4>

##### Flow

The flow of the synchronous token persistence in Opaque tokens when receiving two identical access token requests is as follows:

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

<h4 id="synchronous-jwt-token-persistence-recovery-flow"> Synchronous token handling in JWT tokens </h4>

Since there is no token persistent in the JWT token flow, for each access renewal request for JWT component will result in a new access token by revoking the latest ACTIVE access token.

##### Flow

The flow of the synchronous token persistence in JWT when receiving two identical access token requests is as follows:

1.  The client sends an access token request.
2.  The JWT component in both nodes try to revoke the existing active token and one node only get succeeded in revocation. Other node get skipped over the revocation flow since the access token intended to revoke was revoked by previous node.
3.  Then initial node creates the access token and persists the JTI value in the database. As the other node cannot create the access token, it will receive an error due to the violation of the CON_APP_KEY constraint.

#### Recovery flow

The process flow now moves on to the recovery flow in order to handle the `CON_APP_KEY` constraint violation and it is executed as follows: 

-   As the same thread is being used, the OAuth2 component in the second node checks the database again for the latest ACTIVE access token.
-   As there is now an ACTIVE token, which was persisted by the first node, the second node now expires the existing token. Then this latest token is updated with the current timestamp.
- Second node tries to save this access token again until the `retry_count_on_persistence_failures` count exceeded.
- If success the newest acess token will be returned to client.