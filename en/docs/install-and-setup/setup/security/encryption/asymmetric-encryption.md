# Asymmetric Encryption

Asymmetric encryption uses public and private keys to encrypt and decrypt data. While the **public key** of the key pair is shared with external parties, the **private key** is kept secret. When one of the key pairs is used to encrypt a message, the other key can be used to decrypt it. In a **keystore**, you can store both private and public keys, and in a **truststore** you can store only public keys.

!!! info
    For more information on how to configure the keystores for asymmetric key encryption, see [Configuring Keystores in WSO2 API Manager]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager).


!!! note
    In WSO2 API Manager, [symmetric encryption]({{base_path}}/install-and-setup/setup/security/encryption/symmetric-encryption/) is used by default.

    To switch to asymmetric encryption, add the following configurations to the `deployment.toml` file located in the `<APIM_HOME>/repository/conf` directory.
    
    The `[keystore]` property should be added before the `[keystore.primary]` entry in the `deployment.toml` file. The other two properties can be added to the end of the file. 

    ```toml
    [keystore]
    userstore_password_encryption = "InternalKeyStore"

    [system.parameter]
    "org.wso2.CipherTransformation"="RSA/ECB/OAEPwithSHA1andMGF1Padding"

    [encryption]
    internal_crypto_provider = "org.wso2.carbon.crypto.provider.KeyStoreBasedInternalCryptoProvider"
    ```

!!! warning
    It is recommended to switch the cryptography configuration before starting WSO2 API Manager for the first time. Once the system has been started with the default symmetric encryption, all sensitive data such as passwords, tokens, and secrets are encrypted using symmetric encryption. Switching to asymmetric encryption after the system has encrypted data would break the system, unless the data is migrated properly.

    To switch from symmetric to asymmetric encryption in a running deployment with existing encrypted data, you must manually decrypt and re-encrypt the existing data using the new cryptographic mechanism before restarting the server.

    Similarly, if you wish to switch back from asymmetric to symmetric encryption, all existing encrypted data must be properly migrated to use the symmetric encryption format.