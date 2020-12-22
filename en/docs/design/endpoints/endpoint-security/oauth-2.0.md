# Secure Endpoint with OAuth 2.0

A secured endpoint is when you have access-protected resources. WSO2 API Manager supports Basic Authentication, Digest Authentication, and OAuth 2.0. They differ on how the credentials are communicated and how access is granted by the backend server.

OAuth 2.0 is the industry-standard delegation protocol for authorization and focuses on client developer simplicity while providing specific authorization flows for applications. In other words, OAuth 2.0 enables an application to obtain limited access to an HTTP service, without actually revealing a resource owner's long-term credentials or identity.

OAuth brings in a separate authorization layer in order to separate the role of the client from that of the resource owner. In order to gain access to a protected resource, the client should obtain a set of properties including an access token, its lifetime, and scope instead of credentials of the resource owner, from the backend server.

## Authorization grant types supported by OAuth 2.0 Endpoint Security

The OAuth 2.0 Authorization Framework specification declares 4 grant-types to obtain an access token. OAuth 2.0 Endpoint Security supports the following grant types:

1. Client Credentials

2. Resource Owner Password

## Securing an endpoint with OAuth 2.0 in WSO2 API Manager

When you [create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api) using the API Publisher, you can specify the production and sandbox endpoints of the API backend implementation via the **Endpoints** page.

Follow the instructions below to use OAuth 2.0 as the endpoint authorization type when using a secured endpoint and allow WSO2 API Manager to communicate with the backend to retrieve access tokens on behalf of the API.

1. Click **Endpoints** in API Publisher.

2. Click the Endpoint Security symbol that corresponds to the endpoint that you want to secure with OAuth 2.0.

      [![Endpoint security symbol]({{base_path}}/assets/img/design/endpoints/endpoint-security/endpoint-security-symbol.png)]({{base_path}}/assets/img/learn/endpoint-security-symbol.png)

3. Click on OAuth 2.0 from the drop-down menu.

     [![OAuth2 dropdown]({{base_path}}/assets/img/learn/oauth-2-dropdown.png)]({{base_path}}/assets/img/learn/oauth-2-dropdown.png)

4. Select the preferred grant-type from the next drop-down menu and enter the required properties.

     ![oauth-2-grant-type]({{base_path}}/assets/img/learn/oauth-2-grant-type.png)

     a. Provide the following properties with regard to **Client Credentials**:

     <table>
      <tbody>
         <tr>
            <td>`Token URL`</td>
            <td>This is the URL for the token endpoint of the OAuth-protected backend server.</td>
         </tr>
         <tr>
            <td>`Client ID`</td>
            <td>A unique ID used to identify the application.</td>
         </tr>
         <tr>
            <td>`Client Secret`</td>
            <td>A unique key that must be known only to the application and the backend server.</td>
         </tr>                  
      </tbody>
     </table>

     ![client credentials config]({{base_path}}/assets/img/learn/client-credentials-config.png)

    b. Provide the following properties with regard to the **Resource Owner Password** in addition to the properties that you entered as the Client Credentials grant-type:

    * **Username** - Username of a user with access to the resource.
        
    * **Password** - Password of a user with access to the resource.
    
     [![resource owner password config]({{base_path}}/assets/img/learn/resource-owner-password-config.png)]({{base_path}}/assets/img/learn/resource-owner-password-config.png)

5. If the OAuth-2.0-protected backend server token endpoint requires any other properties to be passed in addition to the above, click **Add Parameter** and provide the required properties and their respective values. 
      
      Editing and removing parameter name-value pairs are also supported.

     [![oauth-2-add-parameter]({{base_path}}/assets/img/learn/oauth-2-add-parameter.png)]({{base_path}}/assets/img/learn/oauth-2-add-parameter.png)

6. Click **Submit** to confirm the details of the respective endpoint, and then click **Save** in the **Endpoints** page to save all the changes.

     [![oauth-2-submit-button]({{base_path}}/assets/img/learn/oauth-2-submit-button.png)]({{base_path}}/assets/img/learn/oauth-2-submit-button.png)

     [![endpoints-save-button]({{base_path}}/assets/img/design/endpoints/endpoint-security/endpoints-save-button.png)]({{base_path}}/assets/img/design/endpoints/endpoint-security/endpoints-save-button.png)

    !!! info
        The Endpoint Auth Type selected should match with the authentication mechanism supported by the secured endpoint.

## Using a Redis Server to handle access token caching instead of the default in-memory cache

OAuth 2.0 Endpoint Security in WSO2 API Manager allows you to use a remote Redis Server as a cache to store access tokens and other relevant properties instead of the default in-memory cache. This step is **highly-recommended** when your WSO2 API Manager deployment includes multiple API Gateways, in order to allow the sharing of access tokens and other relevant properties between API Gateways and prevent the irregular syncing of access tokens.

Follow the instructions below to point WSO2 API Manager to a remote Redis Server that you can use as a Cache for OAuth 2.0 Endpoint Security token management:

### Unauthenticated Redis Server

If you are using an unauthenticated Redis server, you should add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` bash tab="Format"
[redis_config]
host = {redis-server-hostname}
port = {redis-server-port}
```

``` bash tab="Example"
[redis_config]
host = "localhost"
port = 8080
```

### Authenticated Redis Server

If you are using an authenticated Redis server, you should add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` bash tab="Format"
[redis_config]
host = {redis-server-hostname}
port = {redis-server-port}
user = {redis-server-username}
password = {redis-server-password}
database_id = {redis-server-database-id}
connection_timeout = {redis-server-connection-timeout-in-seconds}
ssl = {redis-server-is-ssl-enabled}
```

``` bash tab="Example"
[redis_config]
host = "localhost"
port = 8080
user = "admin"
password = "admin"
database_id = 1
connection_timeout = 36000
ssl = true
```
