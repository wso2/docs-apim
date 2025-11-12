# Secure Endpoint with OAuth 2.0

A secured endpoint is when you have access-protected resources. WSO2 API Manager supports Basic Authentication, Digest Authentication, and OAuth 2.0. They differ on how the credentials are communicated and how access is granted by the backend server.

OAuth 2.0 is the industry-standard delegation protocol for authorization and focuses on client developer simplicity while providing specific authorization flows for applications. In other words, OAuth 2.0 enables an application to obtain limited access to an HTTP service, without actually revealing a resource owner's long-term credentials or identity.

OAuth brings in a separate authorization layer in order to separate the role of the client from that of the resource owner. In order to gain access to a protected resource, the client should obtain a set of properties including an access token, its lifetime, and scope instead of credentials of the resource owner, from the backend server.

## Authorization grant types supported by OAuth 2.0 Endpoint Security

The OAuth 2.0 Authorization Framework specification declares 4 grant-types to obtain an access token. OAuth 2.0 Endpoint Security supports the following grant types:

1. Client Credentials

2. Resource Owner Password

## Securing an endpoint with OAuth 2.0 in WSO2 API Manager

When you [create an API]({{base_path}}/manage-apis/design/create-api/create-rest-api/create-a-rest-api) using the API Publisher, you can specify the production and sandbox endpoints of the API backend implementation via the **Endpoints** page.

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

6. Click **Submit** to confirm the details of the respective endpoint, and then click **Save and deploy** in the **Endpoints** page to save all the changes.

     [![oauth-2-submit-button]({{base_path}}/assets/img/learn/oauth-2-submit-button.png)]({{base_path}}/assets/img/learn/oauth-2-submit-button.png)

     [![endpoints-save-button]({{base_path}}/assets/img/design/endpoints/endpoint-security/endpoints-save-button.png)]({{base_path}}/assets/img/design/endpoints/endpoint-security/endpoints-save-button.png)

    !!! info
        The Endpoint Auth Type selected should match with the authentication mechanism supported by the secured endpoint.

## Using a Redis Server to handle access token caching instead of the default in-memory cache

OAuth 2.0 Endpoint Security in WSO2 API Manager allows you to use a remote Redis Server as a cache to store access tokens and other relevant properties instead of the default in-memory cache. This step is **highly-recommended** when your WSO2 API Manager deployment includes multiple API Gateways, in order to allow the sharing of access tokens and other relevant properties between API Gateways and prevent the irregular syncing of access tokens.

Follow the instructions below to point WSO2 API Manager to a remote Redis Server that you can use as a Cache for OAuth 2.0 Endpoint Security token management:

### Unauthenticated Redis Server

If you are using an unauthenticated Redis server, you should add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file.

=== "Format"
      ```toml
      [apim.redis_config]
      host = {redis-server-hostname}
      port = {redis-server-port}
      ```

=== "Example"
      ```toml
      [apim.redis_config]
      host = "localhost"
      port = 8080
      ```

### Authenticated Redis Server

If you are using an authenticated Redis server, you should add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file.

=== "Format"
      ```toml
      [apim.redis_config]
      host = {redis-server-hostname}
      port = {redis-server-port}
      user = {redis-server-username}
      password = {redis-server-password}
      database_id = {redis-server-database-id}
      connection_timeout = {redis-server-connection-timeout-in-seconds}
      ssl = {redis-server-is-ssl-enabled}
      ```

=== "Example"
      ```toml
      [apim.redis_config]
      host = "localhost"
      port = 8080
      user = "admin"
      password = "admin"
      database_id = 1
      connection_timeout = 36000
      ssl = true
      ```

## Configuring a dedicated trust store for OAuth token endpoint connections

By default, OAuth token endpoint connections use the existing SSL context in the system. If you want to configure a separate trust store for the OAuth token endpoint connection, you can use the following configuration.

Add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file:

=== "Format"
      ```toml
      [apim.mediator_config.oauth.trust_store]
      location = "<path to the trust store file>"
      type = "<trust store type, e.g., JKS>"
      password = "<trust store password>"
      ```

=== "Example"
      ```toml
      [apim.mediator_config.oauth.trust_store]
      location = "repository/resources/security/client-truststore-oauth.jks"
      type = "JKS"
      password = "wso2carbon"
      ```

## Implementing OAuth token retry mechanism for protected backends

WSO2 API Manager provides an advanced token retry mechanism for OAuth-protected backends. This feature enables the API Gateway to automatically retry failed requests to OAuth-protected backend services when the backend returns a 401 Unauthorized status code. When a 401 error occurs, the API Manager automatically renews the access token by invoking the token endpoint and retries the original request with the new token.

This mechanism improves the resilience of API calls to OAuth-protected backends by handling token expiration scenarios transparently, reducing the likelihood of API request failures due to expired tokens.

### Key features

- **Automatic token renewal**: When a backend returns a 401 status code, the API Manager automatically requests a new access token from the OAuth token endpoint.
- **Seamless retry**: After obtaining a new token, the original API request is retried with the updated credentials.
- **Configurable behavior**: You can enable or disable the retry mechanism based on your requirements.
- **Enhanced reliability**: Reduces API failures caused by token expiration in OAuth-protected backend scenarios.

### Configuration

To enable the OAuth token retry mechanism, add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file:

=== "Format"
    ```toml
    [apim.mediator_config.oauth]
    expires_in = "{token-expiration-time-in-minutes}"
    enable_retry_call_with_new_token = {true|false}
    ```

=== "Example"
    ```toml
    [apim.mediator_config.oauth]
    expires_in = "10"
    enable_retry_call_with_new_token = true
    ```

### Configuration parameters

<table>
<thead>
<tr>
<th>Parameter</th>
<th>Description</th>
<th>Default Value</th>
<th>Required</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>expires_in</code></td>
<td>Specifies the token expiration time in minutes. This parameter is only applicable when <code>enable_retry_call_with_new_token</code> is set to <code>false</code>. When retry is enabled (<code>true</code>), this parameter is ignored as the token expiration is determined dynamically based on the backend response.</td>
<td>No default</td>
<td>No</td>
</tr>
<tr>
<td><code>enable_retry_call_with_new_token</code></td>
<td>Enables or disables the automatic token retry mechanism. When set to <code>true</code>, the API Manager will automatically retry requests with a new token upon receiving a 401 response. When set to <code>false</code>, the retry mechanism is disabled.</td>
<td><code>false</code></td>
<td>Yes</td>
</tr>
</tbody>
</table>

### Configuration behavior

The relationship between the `expires_in` and `enable_retry_call_with_new_token` parameters is important to understand:

- **When `enable_retry_call_with_new_token = true`**: The `expires_in` parameter is not applicable. The API Manager dynamically handles token expiration based on actual backend responses (401 errors) rather than predefined expiration times.

- **When `enable_retry_call_with_new_token = false`**: The `expires_in` parameter becomes applicable and controls the token caching behavior. The API Manager uses this value to determine when to proactively refresh tokens.

!!! info "Important Configuration Note"
    The `expires_in` parameter is only effective when `enable_retry_call_with_new_token` is set to `false`. When the retry mechanism is enabled (`true`), token expiration is handled dynamically based on backend responses, making the `expires_in` setting unnecessary.

### How the retry mechanism works

When the OAuth token retry mechanism is enabled, the following sequence occurs:

1. **Initial request**: The API Manager sends a request to the OAuth-protected backend using the current access token.

2. **401 response handling**: If the backend returns a 401 Unauthorized status code, the API Manager detects that the token may have expired.

3. **Token renewal**: The API Manager automatically invokes the configured OAuth token endpoint to obtain a new access token using the stored client credentials.

4. **Request retry**: Once a new token is obtained, the API Manager retries the original request with the updated access token.

5. **Response handling**: The backend processes the retry request with the valid token and returns the appropriate response to the client.

!!! warning "Single Retry Policy"
    The retry mechanism attempts token renewal only once per request. If the retry also fails with a 401 status code, the error is returned to the client to prevent infinite retry loops.

### Best practices

When implementing the OAuth token retry mechanism, consider the following best practices:

- **Enable retry for production environments**: The retry mechanism is particularly useful in production environments where token expiration can cause intermittent API failures.

- **Monitor backend compatibility**: Ensure that your OAuth-protected backend correctly returns 401 status codes for expired tokens to trigger the retry mechanism.

- **Configure appropriate timeouts**: Set reasonable timeout values for token endpoint calls to avoid delays in request processing during token renewal.

- **Test retry scenarios**: Thoroughly test the retry mechanism by simulating token expiration scenarios to ensure proper functionality.

!!! note "Performance Considerations"
    While the retry mechanism improves reliability, it may introduce slight latency during token renewal. Consider this when setting API response time expectations.
