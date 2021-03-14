# Extending Scope Validation

OAuth scopes, allow you to have fine grained access control to API resources based on the user roles. It allows you to define scopes per API and associate defined scopes with API resources. OAuth 2.0 bearer tokens are obtained for a set of requested scopes and the token obtained is not allowed to access any API resources beyond the associated scopes. For more information, see [Fine Grained Access Control with OAuth Scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#fine-grained-access-control-with-oauth-scopes).

API Manager uses scopes as a way of defining permissions for a resource. If a resource is assigned a scope, then the token accessing the resource should be generated with that scope. By associating a scope with a role, you can control which users are permitted to have tokens under certain scopes. In this instance, associating a role to a scope seems legitimate.

Validating the role of a requester does not make much sense in some scenarios. For instance, when the scope is used as a means of generating an access token and not for securing a resource (e.g., openID scope). In such situations, scope validation can be extended to skip role validation for certain scopes.

### Skipping role validation for scopes

When scopes that cannot be associated with roles are requested, the token should be issued without validating the scope. In WSO2 API Manager, you do this by [allowlisting the scope]({{base_path}}/learn/api-security/oauth2/oauth2-scopes/scope-allowlisting) using configurations. Patterns of the allowed scopes are specified via a configuration under the `apim.oauth_config` element in the `<API-M_HOME>/repository/conf/deployment.toml` file. Scopes that match the pattern are not validated by role and are available to anyone requesting it.

Follow the instructions below to skip role validation for scopes:

1.  Start the API Manager server and sign in to the Developer Portal.
2.  Create an application. 

     Navigate to the **Production Keys** tab of your application, click **Generate Keys**.

3.  Obtain the **Base64** encoded representation of the Consumer Key and the Consumer Secret separated by a colon based on the following format.

      ``` java
      Base64(consumer-key:consumer-secret)
      ```

    !!! tip
        You can also use the cURL request listed under the **Generate Access Tokens** section for steps 3 and 4 based on the grant type.

    [![]({{base_path}}/assets/attachments/103334763/103334764.png)]({{base_path}}/assets/attachments/103334763/103334764.png)

    <a name="step4"></a>
    
4.  Use the Base64 encoded value obtained above in the Authorization header when invoking the following command. 

     This is used to get the token by calling the token API.

    !!! tip
        Make sure you include a random scope in the request which will be any value suitable for the name of the scope.

    ``` xml
    curl -k -d "grant_type=password&username=admin&password=admin&scope=some_random_scope" -H "Authorization: Basic WmRFUFBvZmZwYVFnR25ScG5iZldtcUtSS3IwYTpSaG5ocEVJYUVCMEN3T1FReWpiZTJwaDBzc1Vh" -H "Content-Type: application/x-www-form-urlencoded" https://10.100.0.3:8243/token
    ```

     Along with the token, you receive a response from the server similar to the one below.

    ``` java
    {"scope":"default","token_type":"bearer","expires_in":3600,"refresh_token":"23fac44e9b7e1ae95a33b85f4f26decd","access_token":"9474fa104ccb196303f41c8a5ee6f48"}
    ```

    You may not see the scope you requested for in this response as it has not been allowlisted yet.

5.  Shut down the server.

6.  To allowlist the scope, add the following under the `[apim.oauth_config]` element in the `<API-M_HOME>/repository/conf/deployment.toml` file and restart the server.

    ``` toml
    [apim.oauth_config]
    allowed_scopes = ["^device_.*", "openid", "some_random_scope"]
    ```

7.  Call the token API using the same request used in <a href="#step4">step 4</a>. 

     You will receive a response similar to the one below.

    ``` java
    {"scope":"some_random_scope","token_type":"bearer","expires_in":3600,"refresh_token":"59e6676db0addca46e68991e44f2b8b8","access_token":"48855d444db883171c347fa21ba77e8"}
    ```

     You see a successful response along with the allowlisted scope for which you requested.
