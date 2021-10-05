# Encrypting OAuth2 Tokens 

WSO2 API Manager provides the capability to encrypt OAuth2 tokens (OAuth2 access tokens, refresh tokens, consumer secrets, authorization codes, or any other OAuth2 key) using the primary keystore. The result is encoded in Base64 and stored in the database.

!!! info
        **Symmetric Encryption** is a form of encryption where the same key is used to encrypt and decrypt the message along with a mathematical algorithm. As long as both sender and recipient know the secret key, they can encrypt and decrypt all messages that use this key.

!!! warning
        It is recommended to switch this configuration on/off **before any keys have been generated in your system** . Once token encryption is switched on, the system encrypts all sensitive OAuth2.0 data such as Access Tokens, Consumer Secrets, etc. When reading that information, the system assumes that they are in the encrypted format and attempts to decrypt them. Therefore, switching this configuration on **after** any keys are created would break the system, unless the data is converted back into plain text.

Follow the steps below to enable OAuth2 token encryption

1.  Stop the API Manager server if it is already running.
2.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file, uncomment the following configuration and set the `enable_token_encryption` value to be `true`.   

    ``` 
    [apim.oauth_config]
    enable_token_encryption = true
    ```

    !!! Note
        By default, WSO2 API Manager uses `RSA/ECB/OAEPwithSHA1andMGF1Padding` algorithm for token encryption. If you want to change the algorithm, please add following configuration to deployment.toml, specifying the preferred algorithm.
    
        ```
        [system.parameter]
        "org.wso2.CipherTransformation" = "<Algorithm>"
        ```
    
3.  [Start the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server). 

4.  Follow the [Generate Application Keys]({{base_path}}/consume/manage-application/generate-keys/generate-api-keys) guide to create a new application, generate application consumer keys, and to obtain an access token.

    !!! tip

        -   If you use a [Distributed API Manager setup]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m) , the changes must be made on both the Developer Portal and Key Manager nodes.
        -   If you use WSO2 Identity Server [(WSO2 IS) as the Key Manager setup]({{base_path}}/install-and-setup/deploying-wso2-api-manager/ThirdPartyKeyManager/configuring-wso2-identity-server-as-a-key-manager/) , you need to make changes in both WSO2 IS and WSO2 API Manager.


