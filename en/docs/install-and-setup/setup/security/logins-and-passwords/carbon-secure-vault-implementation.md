# Customizing Secure Vault

WSO2 products are shipped with a Secure Vault implementation, which is a modified version of Synapse Secure Vault. This allows you to store encrypted passwords that are mapped to aliases instead of the actual passwords.

You can implement your own Secure Vault configurations by changing the default **Secret Repository** and the **Secret Callback Handler**.

### Elements of the Secure Vault implementation

Some of the important elements in the secure vault implementation, which are used in Carbon products for encrypting plain text passwords are as follows:

-   **Secret Repository:** This is used to store the secret values (encrypted values). The `cipher-text.properties` file, located in the `<PRODUCT_HOME>/repository/conf/security` folder is the default file based secret repository used by the Secret Manager in your Carbon product. Note that, currently, Secure Vault only implements file based secret repositories. The Secret Repository stores aliases vs. their actual secrets in encrypted format (encrypted via a key in keystore). Any secret repositories can be written by implementing the `SecretRepository` and `SecretRepositoryProvider` classes. 

-   **Secret Manager:** The Secret Manager initializes the Secret Repository and the keystore configured for the Carbon server. The secrets stored in the Secret Repository are accessed using the aliases. The keystore is required to create the decryption crypto, which can be used to resolve encrypted secret values.

-   **Secret Callback:** This provides the actual password for a given alias. There is a SecretManagerSecretCallbackHandler, which is combined with Secret Manager to resolve the secret. Any callback can be written by implementing the SecretCallbackHandler class.

-   **Secret Resolver:** Any configuration builder that uses secret information within its own configuration file needs to initialize the Secret Resolver when building its own configuration. The Secret Resolver keeps a list of secured elements that need to be defined in the configuration file with secret aliases. Secret Resolver initializes the Secret Callback handler class, which is defined in the configuration file.
