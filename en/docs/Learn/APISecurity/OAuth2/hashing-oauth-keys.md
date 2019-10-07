# Hashing OAuth Keys

!!! note
If you want to enable this feature, we strongly recommend to use a fresh database. You will need data migration, if you want to go with the existing database. If you are interested in this feature, please [contact us](https://wso2.com/contact/) .


WSO2 API Manager allows you to hash any sensitive OAuth2.0 keys you create. API Manager can hash access tokens, refresh tokens, client secrets, and authorization codes. Follow the steps below to configure this feature.

1.  Open the `<API-M_HOME>/repository/conf/api-manager.xml` file. To enable token hashing, set the `<EnableTokenHashMode>` parameter to `true` under `<OAuthConfigurations>.         `
2.  Open the `<APIM_HOME>/repository/conf/identity/identity.xml` file and add the following configurations. Within the `<OAuth>` root tag, add the `<TokenPersistenceProcessor>` parameter. Add the `<EnableClientSecretHash>` parameter and set it to `true` .

    ``` java
        <OAuth>
        ...
        <TokenPersistenceProcessor>org.wso2.carbon.identity.oauth.tokenprocessor.HashingPersistenceProcessor</TokenPersistenceProcessor>
        <EnableClientSecretHash>true</EnableClientSecretHash>
        <HashAlgorithm>SHA-256</HashAlgorithm>
        ...
    ```

    WSO2 API Manager supports hashing algorithms supported by MessageDigest. For more information about supported hashing algorithms, see [MessageDigest Algorithms](https://www.google.com/url?q=https://docs.oracle.com/javase/7/docs/technotes/guides/security/StandardNames.html%23MessageDigest&sa=D&ust=1527836916055000) . The default algorithm used for hashing is SHA-256.

3.  Run the following commands against the database.
    -   Remove the CONN\_APP\_KEY constraint from IDN\_OAUTH2\_ACCESS\_TOKEN table.
        For a given set of consumer key, user, and scope values, there can be only one active access token. The CON\_APP\_KEY constraint in the IDN\_OAUTH2\_ACCESS\_TOKEN table enforces this by allowing only one active access token for a given set of consumer key, user, and scope values.
        But with this hashing feature for every access token request a new access token will be issued. So for a given set of consumer key, user, and scope values, there can be multiple ACTIVE access tokens. To keep multiple ACTIVE access tokens, we need to remove the CONN\_APP\_KEY constraint from IDN\_OAUTH2\_ACCESS\_TOKEN table.
        E.g., For an H2 database

        ``` java
                ALTER TABLE IDN_OAUTH2_ACCESS_TOKEN DROP CONSTRAINT IF EXISTS CON_APP_KEY
        ```

4.  Restart the server.
5.  Log in to the API Store.
    ![](/assets/attachments/103334938/103334937.png)
6.  Click on the **Applications** tab. Click **Add Application** to create a new application
    ![](/assets/attachments/103334938/103334936.png)
    Click **Add** to save the application.
    ![](/assets/attachments/103334938/103334935.png)
7.  Select the application and go to the **Production Keys** tab. Click **Generate** to generate the access token for your application.
    ![](/assets/attachments/103334938/103334934.png)
8.  The consumer secret and access token will be displayed in a pop-up window as shown below. Make sure you note these down, as this will be displayed only once.
    ![](/assets/attachments/103334938/103334933.png)
9.  The consumer key will be accessible through the UI.
    ![](/assets/attachments/103334938/103334932.png)

!!! info
Regenerating the consumer secret

You can regenerate the consumer key in the following ways.

1.  To regenerate the consumer secret through the UI, click **Regenerate** below the **Consumer Secret** label.
    ![](/assets/attachments/103334938/103334931.png)
    The new consumer secret will be displayed in a pop-up window as shown below. ![](/assets/attachments/103334938/103334930.png)
2.  You can regenerate the consumer secret by sending a cURL request. The sample command is given below.

    ``` java
        curl -k -H "Authorization: Bearer a891187c-9907-3e89-a019-9fb41cd4e275" -H "Content-Type: application/json" -X POST -d @data.json "https://localhost:9443/api/am/store/v0.12/applications/regenerate-consumersecret"
        {
           "consumerKey": "vYDoc9s7IgAFdkSyNDaswBX7ejoa"
        }
    ```


