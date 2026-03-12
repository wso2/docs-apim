# Symmetric Encryption

Symmetric encryption uses a single key to encrypt and decrypt information. WSO2 API Manager uses symmetric encryption by default.

!!! note
    If required, you may switch to [asymmetric key encryption]({{base_path}}/install-and-setup/setup/security/encryption/asymmetric-encryption).

### Why symmetric key encryption?

From WSO2 API Manager version 4.7.0 onwards, symmetric key encryption is used as the default encryption mechanism due to the following reasons:

- **Ability to easily change key stores** - In earlier versions, internal data was encrypted using asymmetric key encryption. This means that whenever the certificates expire, or when the keystore is changed, all encrypted data should be migrated. With the shift to symmetric encryption, this overhead is now removed.

- **Industry-wide usage** - Symmetric key encryption is used as an accepted industry-wide mechanism for encrypting internal sensitive data. This includes both on-premise and cloud platforms. 

- **Post-Quantum Security** - Quantum computers have the potential to break widely-used asymmetric encryption algorithms such as RSA and ECC by efficiently solving the underlying mathematical problems. Symmetric key encryption, on the other hand, is more resistant to quantum attacks. 

### How is it used?

WSO2 API Manager uses the `AES/GCM/NoPadding` algorithm for symmetric key encryption. GCM is a stream cipher and therefore, enables simultaneous encryption of multiple blocks, resulting in faster data encryption. WSO2 API Manager supports AES-256 key size.

WSO2 API Manager uses symmetric key encryption to encrypt the following sensitive data and credentials.

- **Backend security secrets** - Passwords and credentials for secured backend endpoints configured in the Publisher Portal. For more information on encrypting secured endpoint passwords, see [Working with Encrypted Passwords]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords/#encrypting-secured-endpoint-passwords).

- **Key Manager secrets** - Credentials and configuration secrets for Key Manager components managed in the Admin Portal.

- **Gateway secrets** - API Gateway related credentials and security configurations managed in the Admin Portal.

- **API Policy secrets** - Sensitive data within API policies and configurations managed in the Publisher Portal.

- **Access Tokens** - OAuth 2.0 access tokens, refresh tokens, authorization codes, and consumer secrets when token encryption is enabled in the Developer Portal. For more information on encrypting OAuth 2.0 tokens, see [Encrypting OAuth2 Tokens]({{base_path}}/api-security/key-management/tokens/encrypting-oauth2-tokens/).

- **Mediation Policy secrets** - Sensitive data and credentials within mediation policies configured in the Publisher Portal.

- **User store configuration credentials** - Secondary user store properties and authentication credentials managed in the Carbon Console.

- **AI API Key secrets** - API keys and credentials for AI APIs configured in the Publisher Portal.

### Generate a secret key

For enhanced security, it is recommended to generate your own secret key for symmetric key encryption in WSO2 API Manager.

!!! warning
    Apply all changes before starting WSO2 API Manager for the first time.

To do so,

1. Generate a unique 256-bit secret key. If you use OpenSSL, the command will be as follows:

    ```bash
    openssl rand -hex 32
    ```

2. Add your generated key to the `deployment.toml` found in the `<APIM_HOME>/repository/conf/` directory as follows:

    ```toml
    [encryption]
    key = "748fe62b5b9f6560331d71f5d01017086506018bff7a0ca3347b7979d29b757f"
    ```  

If a custom encryption key is not provided, it will auto-generate a random encryption key during server startup with the following warning message.

!!! warning
    ```
    ##################################  ALERT  ##################################
    [WARNING]: A random encryption key has been created and added to deployment.toml at
    <APIM_HOME>/repository/conf/deployment.toml.
    Please modify this [encryption] key and follow the production guidelines in the documentation for a safe production deployment.
    #############################################################################
    ```

It is recommended to change the encryption key before using WSO2 API Manager for the first time. If not, you need to run a key rotation tool to encrypt the secrets and credentials that were already encrypted using the generated random encryption key.

!!! note "Important"

    It is highly recommended to encrypt the secret key using the [cipher tool]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords/).