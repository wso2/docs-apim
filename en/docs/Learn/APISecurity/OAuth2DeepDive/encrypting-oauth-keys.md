# Encrypting OAuth Keys

WSO2 API Manager allows you to encrypt any sensitive OAuth2.0 keys that are created. The API Manager encrypts access tokens, client secrets and authorization codes (this can be extended to any other OAuth2.0 keys if needed) using the primary keystore. The result is encoded in Base64 and stored in the database. The RSA algorithm is used by default and the key strength (1024, 2048, etc) is based on the private key strength of the primary keystore. If SymmetricEncryption is enabled, the API Manager uses the AES algorithm by default, or the algorithm specified for the `SymmetricEncryption.Algorithm` in the `carbon.xml` file.

!!! info
        **Symmetric Encryption** is a form of encryption where the same key is used to encrypt and decrypt the message along with a mathematical algorithm. As long as both sender and recipient know the secret key, they can encrypt and decrypt all messages that use this key.

!!! warning
        It is recommended to switch this configuration on/off **before any keys have been generated in your system** . Once token encryption is switched on, the system encrypts all sensitive OAuth2.0 data such as Access Tokens, Consumer Secrets, etc. When reading that information, the system assumes that they are in the encrypted format and attempts to decrypt them. Therefore, switching this configuration on **after** any keys are created would break the system, unless the data is converted back into plain text.


In order to encrypt the OAuth keys, change the following configurations.

1.  In the `<APIM_HOME>/repository/conf/deployment.toml` file, add following configurations:
    ```
        [apim.oauth_config]
        enable_token_encryption = true
    ```
    ```
        [oauth]
        extensions.token_persistence_processor = "org.wso2.carbon.identity.oauth.tokenprocessor.EncryptionDecryptionPersistenceProcessor"
    ```
3.  Restart the server(s) after the above configuration changes are performed.

!!! tip

    -   If you use a [Distributed API Manager setup](../../../../SetupAndInstall/DeployingWSO2APIManager/DistributedDeployment/understanding-the-distributed-deployment-of-wso2-api-m) , the changes must be made on both the API Store and Key Manager nodes.
    -   If you use WSO2 Identity Server [(WSO2 IS) as the Key Manager setup](../../../../SetupAndInstall/DeployingWSO2APIManager/ThirdPartyKeyManager/configuring-wso2-identity-server-as-a-key-manager/) , you need to make changes in both WSO2 IS and WSO2 API Manager.


