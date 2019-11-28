# Hashing OAuth2 Access Tokens


WSO2 API Manager allows you to enable OAuth2 token hashing to protect OAuth2 access tokens, refresh tokens, consumer secrets, and authorization codes.

Follow the instructions below to set up OAuth token hashing.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file and uncomment enable_token_hashing following config and enable token hashing by setting the.   

    ``` 
    [apim.oauth_config]
    enable_token_hashing = true
    ```

2.  Run the appropriate database command to remove the
        `           CONN_APP_KEY          ` constraint from the
        `           IDN_OAUTH2_ACCESS_TOKEN          ` table. For example,
        if you are using an H2 database, you need to run the following
        command:
    ``` sql
    ALTER TABLE IDN_OAUTH2_ACCESS_TOKEN DROP CONSTRAINT IF EXISTS CON_APP_KEY
    ```
    
    
    !!! tip
            In general, for a specified consumer key, user, and scope, there can
            be only one active access token. The
            `           CON_APP_KEY          ` constraint in the
            `           IDN_OAUTH2_ACCESS_TOKEN          ` table enforces this
            by allowing only one active access token to exist for specified
            consumer key, user, and scope values.  
            With regard to hashing, a new access token is issued for every
            access token request . Therefore, for a given consumer key, user,
            and scope, there can be multiple active access tokens. To allow
            existence of multiple active access tokens, you need to remove the
            `           CONN_APP_KEY          ` constraint from
            `           IDN_OAUTH2_ACCESS_TOKEN          ` table.

3.  Restart the server. 

4.  Please follow the steps given in [Generate Application Keys]({{base_path}}/Learn/ConsumeAPI/ManageApplication/GenerateKeys/generate-api-keys) to create a new application, generate application consumer key secrets and obtain an access token

 Once the token hashing is enabled, all the OAuth2 access tokens, refresh tokens, consumer secrets, and authorization codes will be hashed in the database.




