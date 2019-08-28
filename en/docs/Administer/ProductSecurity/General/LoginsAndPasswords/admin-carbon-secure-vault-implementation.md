# admin\_Carbon Secure Vault Implementation

WSO2 Carbon is shipped with a Secure Vault implementation, which is a modified version of synapse Secure Vault. This allows you to store encrypted passwords that are mapped to aliases. That is, you can use the aliases instead of the actual passwords in your configuration files for better security. For example, some configurations require the admin username and password. If the admin user password is "admin", you could use the alias `         UserManager.AdminUser.Password        ` in your configuration file. You would then map that alias to the actual password "admin". At runtime, the product will look up this alias in the secure vault and then decrypt and use its password.

!!! note
The Cipher Tool is used in WSO2 products to create encrypted values for passwords. See the following sections in the documentation for more information:

-   [Encrypting Passwords with Cipher Tool](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool)
-   [Resolving Encrypted Passwords](https://docs.wso2.com/display/ADMIN44x/Resolving+Encrypted+Passwords)


See the following topics:

-   [Elements of the Secure Vault implementation](#admin_CarbonSecureVaultImplementation-ElementsoftheSecureVaultimplementation)
-   [Customizing the Secure Vault configuration](#admin_CarbonSecureVaultImplementation-CustomizingtheSecureVaultconfiguration)
    -   [Creating a Secret Callback Handler](#admin_CarbonSecureVaultImplementation-CreatingaSecretCallbackHandler)
    -   [Creating a custom Secret Repository](#admin_CarbonSecureVaultImplementation-CreatingacustomSecretRepository)

### Elements of the Secure Vault implementation

Some of the important elements in the secure vault implementation, which are used in Carbon products for encrypting plain text passwords are as follows:

-   **Secret Repository:** This is used to store the secret values (encrypted values). T he `          cipher-text.properties         ` file, located in the `          <PRODUCT_HOME>/repository/conf/security         ` folder is the default file based secret repository used by the Secret Manager in your Carbon product. Note that, currently, Secure Vault only implements file based secret repositories. The Secret Repository stores aliases vs. their actual secrets in encrypted format (encrypted via a key in keystore). Any secret repositories can be written by implementing the `          SecretRepository         ` and `          SecretRepositoryProvider         ` classes. See the topic on [customizing the Secure Vault configuration](#admin_CarbonSecureVaultImplementation-CustomizingtheSecureVaultconfiguration) .
-   **Secret Manager:** The Secret Manager initializes the Secret Repository and the keystore configured for the Carbon server. The secrets stored in the Secret Repository are accessed using the aliases indicated in the `          cipher-text.properties         ` file. The keystore is required to create the decryption crypto, which can be used to resolve encrypted secret values. The keystore and Secret Repository are configurable through the `          secret-conf.properties         ` file, which is created in the `          <PRODUCT_HOME>/repository/conf/security         ` folder when you execute the Cipher Tool.
-   **Secret Callback:** This provides the actual password for a given alias. There is a SecretManagerSecretCallbackHandler, which is combined with Secret Manager to resolve the secret. Any callback can be written by implementing the SecretCallbackHandler class. See the topic on [customizing the Secure Vault configuration](#admin_CarbonSecureVaultImplementation-CustomizingtheSecureVaultconfiguration) .
-   **Secret Resolver:** Any configuration builder that uses secret information within its own configuration file needs to initialize the Secret Resolver when building its own configuration. The Secret Resolver keeps a list of secured elements that need to be defined in the configuration file with secret aliases. Secret Resolver initializes the Secret Callback handler class, which is defined in the configuration file.

### Customizing the Secure Vault configuration

You can implement your own Secure Vault configurations by changing the default **Secret Repository** and the **Secret Callback Handler** . See the following for topics for instructions:

#### Creating a Secret Callback Handler

Let's see how we can write a new Secret Callback Handler class to secure the user management and registry database connection password. In this sample, you do not need to configure a Secret Repository or keystore (cipher-text.properties) as you are not going to store the secret or encrypted values.

1.  Write a Secret Callback class. You need to implement the SecretCallbackHandler interface or extend the AbstractSecretCallbackHandler abstract class. For example,

    ``` java
        public class HardCodedSecretCallbackHandler extends AbstractSecretCallbackHandler {
             protected void handleSingleSecretCallback(SingleSecretCallback singleSecretCallback) {
                    singleSecretCallback.setSecret("password");
             }
        }
    ```

2.  We can set multiple password-based as follows:

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

3.  Create a JAR or an OSGI bundle and copy the JAR file to the `          <PRODUCT_HOME>/repository/component/lib/         ` directory or the OSGI bundle to the `          <PRODUCT_HOME>/repository/component/dropins/ directory         ` .
4.  Configure the `           master-datasources.xml          ` file with an alias name and your Secret Callback handler class name. For example,

    ``` java
            <datasource>
                        <name>WSO2_CARBON_DB</name>
                        <description>The datasource used for registry and user manager</description>
                        <jndiConfig>
                            <name>jdbc/WSO2CarbonDB</name>
                        </jndiConfig>
                        <definition type="RDBMS">
                            <configuration>
             <url>jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000</url>
                                <username>wso2carbon</username>
                                <password svns:secretAlias="Datasources.WSO2_CARBON_DB.Configuration.Password">password</password>
                                <driverClassName>org.h2.Driver</driverClassName>
                                <maxActive>50</maxActive>
                                <maxWait>60000</maxWait>
                                <testOnBorrow>true</testOnBorrow>
                                <validationQuery>SELECT 1</validationQuery>
                                <validationInterval>30000</validationInterval>
                            </configuration>
                        </definition>
                    </datasource>
    ```

5.  Go to `           <PRODUCT_HOME>/bin          ` and execute `           ./ciphertool.sh -Dconfigure          `

6.  Replace the values of two the properties `           keystore.identity.store.secretProvider          ` and `           keystore.identity.key.secretProvider          ` in `           <PRODUCT_HOME>/repository/conf/security/secret-conf.properties          ` file with your Secret Callback handler class name.

7.  Restart the server.

#### Creating a custom Secret Repository

To create a custom secret repository, you need to implement the `             SecretRepository            ` and `             SecretRepositoryProvider            ` interfaces:

1.  Create your custom secret repository by implementing the `                   org.wso2.securevault.secret.SecretRepository                  ` interface:

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

2.  Then you need to implement the `                   org.wso2.securevault.secret.SecretRepositoryProvider                  ` class as shown below. This class returns an instance of the custom `                   SecretRepository                  ` that you implemented above.

    ``` java
            public class CustomSecretRepositoryProvider implements SecretRepositoryProvider {
               public SecretRepository getSecretRepository(IdentityKeyStoreWrapper identityKeyStoreWrapper,
                   TrustKeyStoreWrapper trustKeyStoreWrapper) {
                return new CustomSecretRepositoryImpl(identityKeyStoreWrapper, trustKeyStoreWrapper);
              }
            } 
    ```

3.  Create a JAR or an OSGI bundle.

4.  Then, copy the JAR file to the `               <PRODUCT_HOME>/repository/component/lib/              ` directory or the OSGI bundle to the `               <PRODUCT_HOME>/repository/component/              ` dropins `               /              ` directory .

5.  Replace the `                   secretRepositories.file.provider                  ` entry in the `                   secret-conf.properties                  ` file (stored in the `                   <PRODUCT_HOME>/repository/conf/security/                  ` directory) with your secret repository class name.


