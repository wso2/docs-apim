# Working with Encrypted Passwords

All WSO2 products are shipped with a **Secure Vault** implementation that allows you to store encrypted passwords that are mapped to aliases. This approach allows you to use the aliases instead of the actual passwords in your configurations for better security. For example, some configurations require the admin username and password. If the admin user's password is "admin", you could use `UserManager.AdminUser.Password` as the password alias. You will then map that alias to the actual "admin" password using Secure Vault. The WSO2 product will then look up this alias in Secure Vault during runtime, decrypt and use its password.


In all WSO2 products, Secure Vault is commonly used for encrypting passwords and other sensitive information in configuration files. When you use WSO2 API-M, you can encrypt sensitive information contained in synapse configurations (i.e., mediation flow) in addition to the information in configuration files. For more information, see the following topics:

-   [Encrypting passwords in configuration files](#WorkingwithEncryptedPasswords-Encryptingpasswordsinconfigurationfiles)
-   [Encrypting passwords for mediation flow](#WorkingwithEncryptedPasswords-Encryptingpasswordsformediationflow)
-   [Using encrypted passwords in mediation flow](#WorkingwithEncryptedPasswords-Usingencryptedpasswordsinmediationflow)

### Encrypting passwords in configuration files

To encrypt passwords in configuration files, you simply have to update the `cipher-text.properties` and `cipher-tool.properties` files that are stored in the `<API-M_HOME>/conf/security` directory and then run the Cipher tool that is shipped with the product. Go to the links given below to see instructions in the WSO2 administration guide:

-   [Encrypting passwords using the automated process](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool#EncryptingPasswordswithCipherTool-automated) .
-   [Encrypting passwords using the manual process](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool#EncryptingPasswordswithCipherTool-manual_process) .
    The manual encryption process is relevant when the location of the configuration files, which contain the elements to be encrypted, cannot be specified using an xpath in the `cipher` - `tool.properties` file. The `log4j.properties` file and `jndi.properties` file are two such files which require the manual password encryption process.
-   [Changing already encrypted passwords](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool#EncryptingPasswordswithCipherTool-changing_encrypted_passwords) .
-   [Resolving already encrypted passwords](https://docs.wso2.com/display/ADMIN44x/Resolving+Encrypted+Passwords) .

### Encrypting passwords for mediation flow

!!! note
**Before you begin
** If you are using Windows, you need to have **Ant** ( <http://ant.apache.org/> ) installed before using the Cipher Tool.


The WSO2 API-M provides a UI that can be used for encrypting passwords and other sensitive information in synapse configurations. Follow the steps below.

1.  If you are using the Cipher tool for the first time in your environment, you must first enable the Cipher tool by executing the `-Dconfigure` command with the cipher tool script:

    1.  Open a terminal and navigate to the `<API-M_HOME>/bin` directory.
    2.  Execute one of the following commands based on your OS:

        -   On Linux: `./ciphertool.sh -Dconfigure`

        -   On Windows: `./ciphertool.bat -Dconfigure`

                !!! note
        If you are using the Cipher tool for the first time, this command first initializes the tool for your product.


2.  When prompted, enter the primary key password, which is by default `wso2carbon` .
    Enter the password and proceed.
3.  When prompted, enter the plain text password that you want to encrypt.
    Enter the following element as the password and proceed.

    ``` java
        Enter Plain Text Value :admin
    ```

    Now, you will receive the encrypted value.

    **Example**

    ``` java
            Encrypted value is: 
            gaMpTzAccMScaHllsZLXspm1i4HLI0M/srL5pB8jyknRKQ2zT7NuCvt1+qEkElRLgwlrohz3lkuE0KFuapXrCSs5pxfGMOLn4/k7dNs2SlwbsG8C++/
            ZfUuft1Sl6cqvDRM55fQwzCPfybl713HvKu3oDaJ9VKgSbvHlQj6zqzg=
    ```

4.  Start WSO2 API-M and sign in to the management console:
    1.  Open a terminal and navigate to the `<API-M_HOME>/bin` directory.
    2.  Execute one of the following scripts:
        -   On Windows: `wso2server.bat --run`
        -   On Linux/Mac OS: `sh wso2server.sh`
    3.  Sign in to the management console.
`https://<server-host>:9443/carbon           `
5.  Select **Browse** under **Resources** to access the registry browser and go to the `/_system/config/repository/components/secure-vault` location.

6.  Add the aliases and the encrypted value as a property.

!!! info
Encrypting passwords in api-manager.xml file
The `api-manager.xml` file does not contain any plaintext passwords. Therefore, encrypting the plaintext passwords in `user-mgt.xml` file as shown in [Encrypting Passwords with Cipher Tool](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool) is sufficient. We recommend having the same admin user on all nodes in a clustered setup.

However if you need to use an alias to encrypt passwords in the `<APIM_HOME>/repository/conf/api-manager.xml` file using the cipher tool, do the following.

To derive the alias, ignore the root XML element (i.e. `<APIManager>` ) in the `api-manager.xml` file. Denote the subsequent XML elements separated by a dot (.), according to the hiearchy. You can derive the alias **`AuthManager.Password`** from the xml example given below.

``` java
    <APIManager xmlns:svns="http://org.wso2.securevault/configuration">
        <DataSourceName>jdbc/WSO2AM_DB</DataSourceName>
        <GatewayType>Synapse</GatewayType>
        <EnableSecureVault>false</EnableSecureVault>
        <AuthManager>
            <ServerURL>https://localhost:${mgt.transport.https.port}${carbon.context}services/</ServerURL>
            <Username>${admin.username}</Username>
            <Password>${admin.password}</Password>
            .
            .
    </APIManager>
```

Following are some sample aliases derived for other passwords in the `api-manager.xml` file

``` java
    ThrottlingConfigurations.DataPublisher.Password 
    ThrottlingConfigurations.PolicyDeployer.Password
    ThrottlingConfigurations.JMSConnectionDetails.Password
    Analytics.DASPassword.
    Analytics.DASRestApiPassword
```


### Using encrypted passwords in mediation flow

To use the alias of an encrypted password in a mediation flow, you need to add the `{wso2:vault-lookup('alias')}` custom path expression when you define the mediation flow. For example, instead of hard coding the admin user's password as `<Password>admin</Password>` , you can encrypt and store the password using the `AdminUser.Password` alias as follows: `<Password>{wso2:vault-lookup('AdminUser.Password')}</Password>.        `

This password in the mediation flow can now be retrieved by using the `{wso2:vault-lookup('alias')}` custom path expression to logically reference the password mapping.
