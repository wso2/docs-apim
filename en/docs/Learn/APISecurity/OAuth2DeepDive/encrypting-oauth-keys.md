# Encrypting OAuth2 Tokens 

WSO2 API Manager facilitates OAuth2 token encryption in order to protect OAuth2 access tokens, refresh tokens, consumer secrets, and authorization codes (this can be extended to any other OAuth2.0 keys if needed) using the primary keystore. The result is encoded in Base64 and stored in the database. 

!!! info
        **Symmetric Encryption** is a form of encryption where the same key is used to encrypt and decrypt the message along with a mathematical algorithm. As long as both sender and recipient know the secret key, they can encrypt and decrypt all messages that use this key.

!!! warning
        It is recommended to switch this configuration on/off **before any keys have been generated in your system** . Once token encryption is switched on, the system encrypts all sensitive OAuth2.0 data such as Access Tokens, Consumer Secrets, etc. When reading that information, the system assumes that they are in the encrypted format and attempts to decrypt them. Therefore, switching this configuration on **after** any keys are created would break the system, unless the data is converted back into plain text.

Please follow below steps to enable OAuth token encryption. 

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file and add following config.   

    ``` 
    [apim.oauth_config]
    enable_token_encryption = true
    ```

    !!! Note
        By default, WSO2 API Manager uses `RSA/ECB/OAEPwithSHA1andMGF1Padding` algorithm for token encryption. If you want to change the algorithm, please add following config to deployment.toml, specifying the preferred algorithm.
    
        ```
        [system.parameter]
        "org.wso2.CipherTransformation" = "<Algorithm>"
        ```
    
2.  Restart the server. 
3.  Please follow the steps given in [Generate Application Keys]({{base_path}}/Learn/ConsumeAPI/ManageApplication/GenerateKeys/generate-api-keys) to create a new application, generate application consumer key secrets and obtain an access token

 Once the token encryption is enabled, all the OAuth2 access tokens, refresh tokens, consumer secrets, and authorization codes will be encrypted in the database.


!!! tip

    -   If you use a [Distributed API Manager setup](../../../../InstallAndSetup/DeployingWSO2APIManager/DistributedDeployment/understanding-the-distributed-deployment-of-wso2-api-m) , the changes must be made on both the API Store and Key Manager nodes.
    -   If you use WSO2 Identity Server [(WSO2 IS) as the Key Manager setup](../../../../InstallAndSetup/DeployingWSO2APIManager/ThirdPartyKeyManager/configuring-wso2-identity-server-as-a-key-manager/) , you need to make changes in both WSO2 IS and WSO2 API Manager.


