# Encrypting OAuth2 Tokens 

WSO2 API Manager provides the capability to encrypt OAuth2 tokens (OAuth2 access tokens, refresh tokens, consumer secrets, authorization codes, or any other OAuth2 key) using a symmetric encryption key. The result is encoded in Base64 and stored in the database.

!!! info
        **Symmetric Encryption** is a form of encryption where the same key is used to encrypt and decrypt the message along with a mathematical algorithm. As long as both sender and recipient know the secret key, they can encrypt and decrypt all messages that use this key.

        For comprehensive information about encryption in WSO2 API Manager, including symmetric and asymmetric encryption options, see [Symmetric Encryption]({{base_path}}/install-and-setup/setup/security/encryption/symmetric-encryption) and [Working with Encrypted Passwords]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords).

!!! warning
        It is recommended to switch this configuration on/off **before any keys have been generated in your system** . Once token encryption is switched on, the system encrypts all sensitive OAuth2.0 data such as Access Tokens, Consumer Secrets, etc. When reading that information, the system assumes that they are in the encrypted format and attempts to decrypt them. Therefore, switching this configuration off **after** any keys are created would break the system, unless the data is converted back into plain text.

        - To enable OAuth2 token encryption in a running deployment with existing tokens, you must manually encrypt the existing OAuth2 data using a custom Java client before restarting the server with encryption enabled.

        - Similarly, if token encryption was previously enabled and you wish to disable it, all existing encrypted OAuth2 data must be manually decrypted back to plain text using a custom Java client.

Follow the steps below to enable OAuth2 token encryption

1.  Stop the API Manager server if it is already running.
2.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file, uncomment the following configuration and set the `enable_token_encryption` value to be `true`.   

    ```toml
    [apim.oauth_config]
    enable_token_encryption = true
    ```
    
3.  [Start the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server). 

4.  Follow the [Generate Application Keys]({{base_path}}/consume/manage-application/generate-keys/generate-api-keys) guide to create a new application, generate application consumer keys, and to obtain an access token.

    !!! tip

        -   If you use a [Distributed API Manager setup]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m) , the changes must be made on both the Developer Portal and Key Manager nodes.
        -   If you use WSO2 Identity Server [(WSO2 IS) as the Key Manager setup]({{base_path}}/api-security/key-management/third-party-key-managers/configure-wso2is-connector/) , you need to make changes in both WSO2 IS and WSO2 API Manager.


