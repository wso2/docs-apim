# Customizing Secure Vault

WSO2 products are shipped with a Secure Vault implementation, which is a
modified version of Synapse Secure Vault. This allows you to store
encrypted passwords that are mapped to aliases instead of the actual passwords. 

For example, if the admin user password is `admin`, you can define an alias (such as `admin_password`) and map that alias to the actual password (`admin`). At runtime, the product will look up this alias in the secure
vault, decrypt it, and use its password.

You can implement your own Secure Vault configurations by changing the
default **Secret Repository** and the **Secret Callback Handler**.

## Elements of the Secure Vault implementation

-   **Secret Repository:** This is used to store the secret values
    (encrypted values). Note that, currently, Secure Vault
    only implements file based secret repositories. The Secret
    Repository stores aliases vs. their actual secrets in encrypted
    format (encrypted via a key in keystore). Any secret repositories
    can be written by implementing the `SecretRepository` and `SecretRepositoryProvider` classes. 
-   **Secret Manager:** The Secret Manager initializes the Secret
    Repository and the keystore configured for the Carbon server. The
    secrets stored in the Secret Repository are accessed using the
    aliases. The keystore is required to create the decryption crypto,
    which can be used to resolve encrypted secret values.  
-   **Secret Callback:** This provides the actual password for a given
    alias. There is a SecretManagerSecretCallbackHandler, which is
    combined with Secret Manager to resolve the secret. Any callback can
    be written by implementing the SecretCallbackHandler class.
-   **Secret Resolver:** Any configuration builder that uses secret
    information within its own configuration file needs to initialize
    the Secret Resolver when building its own configuration. The Secret
    Resolver keeps a list of secured elements that need to be defined in
    the configuration file with secret aliases. Secret Resolver
    initializes the Secret Callback handler class, which is defined in
    the configuration file.

## Step 1: Creating a Secret Callback Handler

Let's see how we can write a new Secret Callback Handler class to secure
the user management and registry database connection password. In this
sample, you do not need to configure a Secret Repository or keystore as you are not going to store the secret or
encrypted values.

1.  Write a Secret Callback class. You need to implement the
    SecretCallbackHandler interface or extend the
    AbstractSecretCallbackHandler abstract class. For example,  

    ``` java
        public class HardCodedSecretCallbackHandler extends AbstractSecretCallbackHandler {
             protected void handleSingleSecretCallback(SingleSecretCallback singleSecretCallback) {
                    singleSecretCallback.setSecret("password");
             }
        }
    ```

2.  We can set multiple password-based as follows: <span
    class="underline"><span class="underline">  
    </span></span>

    ``` java
            public class HardCodedSecretCallbackHandler extends AbstractSecretCallbackHandler {
                protected void handleSingleSecretCallback(SingleSecretCallback singleSecretCallback) {
                     if("foo".equals(singleSecretCallback.getId())){
                        singleSecretCallback.setSecret("foo_password");
                     } else if("bar".equals(singleSecretCallback.getId())){
                        singleSecretCallback.setSecret("bar_password");
                       }
               }
            }
    ```

3.  Create a JAR or an OSGI bundle and copy the JAR file to the
    `          MI_HOME/repository/component/lib/         `
    directory or the OSGI bundle to the
    `          MI_HOME/repository/component/dropins/ directory         `
    .
4.  Configure the ei.toml file
    with an alias name and your Secret Callback handler class name. For
    example,  

    ``` java
    [config_heading]
    alias_name=value
    secret_callback_handler_class=value
    ```

5.  Restart the server.

## Step 2: Creating a custom Secret Repository

To create a custom secret repository, you need to implement the
`SecretRepository` and `SecretRepositoryProvider` interfaces:

1.  Create your custom secret repository by implementing the `org.wso2.securevault.secret.SecretRepository` interface:

    ``` java
    public class CustomSecretRepositoryImpl extends SecretRepository {
    public void init(Properties properties, String s) {
    }
    public String getSecret(String s) {
        return null;
    }
    public String getEncryptedData(String s) {
        return null;
    }
    public void setParent(SecretRepository secretRepository) {
    }
    public SecretRepository getParent() {
        return null;
    }
    } 
    ```

2.  Then you need to implement the `org.wso2.securevault.secret.SecretRepositoryProvider                  `
    class as shown below. This class returns an instance of the custom
    `SecretRepository` that you implemented above.

    ``` java
    public class CustomSecretRepositoryProvider implements SecretRepositoryProvider {
        public SecretRepository getSecretRepository(IdentityKeyStoreWrapper identityKeyStoreWrapper,
        TrustKeyStoreWrapper trustKeyStoreWrapper) {
        return new CustomSecretRepositoryImpl(identityKeyStoreWrapper, trustKeyStoreWrapper);
        }
    } 
    ```

3.  Create a JAR or an OSGI bundle.

4.  Then, copy the JAR file to the
    `MI_HOME/repository/component/lib/              `
    directory or the OSGI bundle to the
    `MI_HOME/repository/component/dropins/ ` directory.
