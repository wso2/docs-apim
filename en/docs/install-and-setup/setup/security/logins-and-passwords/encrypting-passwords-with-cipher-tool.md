# Encrypting Passwords with Cipher Tool

The instructions on this page explain how plain text passwords in configuration files can be encrypted using the secure vault implementation that is built into WSO2 products. Note that you can customize the default secure vault configurations in the product by implementing a new secret repository, call back handler etc. Read more about the [Secure Vault implementation](https://docs.wso2.com/display/ADMIN44x/Carbon+Secure+Vault+Implementation) in WSO2 products.

In any WSO2 product that is based on Carbon 4.4.0 or a later version, the Cipher Tool feature will be installed by default. You can use this tool to easily encrypt passwords or other elements in configuration files.

!!! note
-   If you are a developer who is building a Carbon product, see the topic on enabling [Cipher Tool for password encryption](https://docs.wso2.com/display/Carbon4410/Enabling+Cipher+Tool+for+Password+Encryption) for instructions on how to include the Cipher Tool as a feature in your product build.
-   The default keystore that is shipped with your WSO2 product (i.e. `wso2carbon.jks` ) is used for password encryption by default. See this [link](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) for details on how to set up and configure new keystores for encrypting plain text passwords.


Follow the topics given below for instructions.

-   [Before you begin](#EncryptingPasswordswithCipherTool-Beforeyoubegin)
-   [Encrypting passwords using the automated process](#EncryptingPasswordswithCipherTool-automatedEncryptingpasswordsusingtheautomatedprocess)
-   [Encrypting passwords manually](#EncryptingPasswordswithCipherTool-manual_processEncryptingpasswordsmanually)
-   [Changing encrypted passwords](#EncryptingPasswordswithCipherTool-changing_encrypted_passwordsChangingencryptedpasswords)

### Before you begin

If you are using Windows, you need to have **Ant** ( <http://ant.apache.org/> ) installed before using the Cipher Tool.

### Encrypting passwords using the automated process

This automated process can only be used for passwords that can be given as an XPath. If you cannot give an XPath for the password that you want to encrypt, you must use the [manual encryption process](#EncryptingPasswordswithCipherTool-manual_process) explained in the next section.

Follow the steps given below to have passwords encrypted using the automated process:

1.  The first step is to update the `cipher-tool.properties` file and the `cipher-text.properties` file with information of the passwords that you want to encrypt.

        !!! info
    By default, the `cipher-tool.properties` and `cipher-text.properties` files that are shipped with your product will contain information on the most common passwords that require encryption. If a required password is missing in the default files, you can **add them manually** .


    Follow the steps given below.

    1.  Open the `cipher-tool.properties` file stored in the `<PRODUCT_HOME>/repository/conf/security` folder. This file should contain information about the configuration files in which the passwords (that require encryption) are located. The following format is used:

        ``` java
                <alias>=<file_name>//<xpath>,<true/false>
        ```

                !!! info
        **Important!**

        -   The `<alias>` should be the same value that is hard-coded in the relevant Carbon component.
        -   The `<file_path>` specifies the path to the XML file that contains the password. This can be the relative file path, or the absolute file path (starting from `<PRODUCT_HOME>` ).

        -   The `<xpath>` specifies the XPath to the XML **element** / **attribute** / **tag** that should be encrypted. See the examples given below.
        -   The flag that follows the XPath should be set to 'false' if you are encrypting the value of an **XML element,** or the value of an **XML attribute's tag.** The flag should be 'true' if you are encrypting the **tag** of an **XML attribute** . See the examples given below.

        -   When using Secure Vault, as you use the password aliases in the `<PRODUCT_HOME>/repository/conf/carbon.xml` file, make sure to define these aliases in the following files, which are in the `<PRODUCT_HOME>/repository/conf/security` directory as follows:

            -   Define your password in the `cipher-text.properties` file.

                ``` java
                                Carbon.Security.InternalKeyStore.Password=[your_password]
                                Carbon.Security.InternalKeyStore.KeyPassword=[your_password]
                ```

            -   Define the XPath of your password in the `cipher-tool.properties` file.

                ``` java
                                    Carbon.Security.InternalKeyStore.Password=repository/conf/carbon.xml//Server/Security/InternalKeyStore/Password,false
                                    Carbon.Security.InternalKeyStore.KeyPassword=repository/conf/carbon.xml//Server/Security/InternalKeyStore/KeyPassword,false
                ```

                !!! note
        Only applicable when using WSO2 API Manager Analytics

        When using Secure Vault with WSO2 API Manager Analytics (WSO2 API-M Analytics), make sure to define the password aliases in the following files, which are in the `<PRODUCT_HOME>/repository/conf/security` directory as follows:

        -   Define your password in the `cipher-text.properties` file.

            ``` java
                        DataBridge.Config.keyStorePassword=[your_password]
                        Analytics.DASPassword=[your_password]
                        Analytics.DASRestApiPassword=[your_password]
            ```

        -   Define the XPath of your password in the `cipher-tool.properties` file.

            ``` java
                            DataBridge.Config.keyStorePassword=repository/conf/data-bridge/data-bridge-config.xml//dataBridgeConfiguration/keyStorePassword,false
                            Analytics.DASPassword=repository/conf/api-manager.xml//APIManager/analytics/DASPassword,true
                            Analytics.DASRestApiPassword=repository/conf/api-manager.xml//APIManager/analytics/DASRestApiPassword,true
            ```


        **
        Example 1:** Consider the admin user's password in the `user-mgt.xml` file shown below.

        ``` java
                <UserManager>
                    <Realm>
                        <Configuration>
                            <AddAdmin>true</AddAdmin>
                            <AdminRole>admin</AdminRole>
                            <AdminUser>
                                <UserName>admin</UserName>
                                <Password>admin</Password>
                            </AdminUser>
                            ........
                        </Configuation>
                        ........
                    </Realm>
                </UserManager>
        ```

        To encrypt this password, the `cipher-tool.properties` file should contain the details shown below. Note that this password is a value given to an XML **element** (which is 'Password'). Therefore, the XPath ends with the element name, and the flag that follows the XPath is set to 'false'.

        ``` java
                    UserManager.AdminUser.Password=repository/conf/user-mgt.xml//UserManager/Realm/Configuration/AdminUser/Password,false
        ```

        **Example 2:** Consider the password that is used to [connect to an LDAP user store](https://docs.wso2.com/display/ADMIN44x/Configuring+the+Primary+User+Store) (configured in the `user-mgt.xml` file) shown below.

        ``` java
                    <Property name="ConnectionPassword">admin</Property>
        ```

        To encrypt this password, the `cipher-tool.properties` file should be updated as shown below. Note that there are two possible alias values you can use for this attribute. In this example, the 'Property' **element** of the XML file uses the 'name' **attribute** with the "ConnectionPassword" **tag** . The password we are encrypting is the value of this "ConnectionPassword" tag. This is denoted in the XPath as 'Property\[@name='ConnectionPassword'\]', and the flag that follows the XPath is set to 'false'.

        -   Using the `UserStoreManager.Property.ConnectionPassword` alias:

            ``` java
                            UserStoreManager.Property.ConnectionPassword=repository/conf/user-mgt.xml//UserManager/Realm/UserStoreManager/Property[@name='ConnectionPassword'],false
            ```

        -   Using the `UserManager.Configuration.Property.ConnectionPassword` alias:

            ``` java
                            UserManager.Configuration.Property.ConnectionPassword=repository/conf/user-mgt.xml//UserManager/Realm/UserStoreManager/Property[@name='ConnectionPassword'],false
            ```

                !!! note
        If you are trying the above example, be sure that only the relevant user store manager is enabled in the `user-mgt.xml` file.


        **Example 3:** Consider the keystore password specified in the `catalina-server.xml` file shown below.

        ``` java
                <Connector protocol="org.apache.coyote.http11.Http11NioProtocol"  
                 ... 
                 keystorePass="wso2carbon" 
                ... >
        ```

        To encrypt this password, the `cipher-tool.properties` file should contain the details shown below. In this example, 'Connector' is the XML **element** , and 'keystorePass' is an **attribute** of that element. The password value that we are encrypting is the **tag** of the XML attribute. This is denoted in the XPath as 'Connector\[@keystorePass\]', and the flag that follows the XPath is set to ‘true’.

        ``` java
                    Server.Service.Connector.keystorePass=repository/conf/tomcat/catalina-server.xml//Server/Service/Connector[@keystorePass],true
        ```

    2.  Open the `cipher-text.properties` file stored in the `<PRODUCT_HOME>/repository/conf/security` folder. This file should contain the secret alias names and the corresponding plaintext passwords (enclosed within square brackets) as shown below.

        ``` java
                    <alias>=[plain_text_password]
        ```

        Shown below are the records in the `cipher-text.properties` file for the three examples discussed above.

        ``` java
                    //Example 1: Encrypting the admin user's password in the user-mgt.xml file.
                    UserManager.AdminUser.Password=[admin]
                    //Example 2: Encrypting the LDAP connection password in the user-mgt.xml file. Use one of the following:
                    UserStoreManager.Property.ConnectionPassword=[admin]
                    # UserManager.Configuration.Property.ConnectionPassword=[admin]
                    //Example 3: Encrypting the keystore password in the catalina-server.xml file.
                    Server.Service.Connector.keystorePass=[wso2carbon]
        ```

        !!! note
    If your password contains a backslash character (\\) you need to use an alias with the escape characters. For example, if your password is `admin\}` the value should be given as shown in the example below.

    ``` java
        UserStoreManager.Property.ConnectionPassword=[admin\\}]
    ```


2.  Open a command prompt and go to the `<PRODUCT_HOME>/bin` directory, where the cipher tool scripts (for Windows and Linux) are stored.

3.  Execute the cipher tool script from the command prompt using the command relevant to your OS:

    -   On Windows: `./ciphertool.bat -Dconfigure`

    -   On Linux: `./ciphertool.sh -Dconfigure`

4.  The following message will be prompted:  "\[Please Enter Primary KeyStore Password of Carbon Server :\]". Enter the keystore password (which is "wso2carbon" for the default [keystore](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption) ) and proceed. If the script execution is successful, you will see the following message: "Secret Configurations are written to the property file successfully".

        !!! note
    If you are using the cipher tool for the first time, the - `Dconfigure` command will first initialize the tool for your product. The tool will then start encrypting the plain text passwords you specified in the `cipher-text.properties` file.

    Shown below is an example of an alias and the corresponding plaintext password (in square brackets) in the `cipher-text.properties` file:

    ``` java
        UserManager.AdminUser.Password=[admin]
    ```

    If a password is not specified in the `cipher-text.properties` file for an alias, the user needs to provide it through the command line.  Check whether the alias is a known password alias in Carbon configurations. If the tool modifies the configuration element and file, you must replace the configuration element with the alias name. Define a Secret Callback in the configuration file and add proper namespaces for defining the Secure Vault.


5.  Now, to verify the password encryption:

    -   Open the `cipher-text.properties` file and see that the plain text passwords are replaced by a cipher value.

    -   Open the `secret-conf.properties` file from the `<PRODUCT_HOME>/repository/conf/security/` folder and see that the default configurations are changed.

### Encrypting passwords manually

This manual process can be used for encrypting any password in a configuration file. However, if you want to encrypt any elements that cannot use an XPath to specify the location in a configuration file, you must use manual encryption. It is not possible to use the [automated encryption process](#EncryptingPasswordswithCipherTool-automated) if an XPath is not specified for the element.

For example, consider the `log4j.properties` file given below, which does not use XPath notations. As shown below, the password of the `LOGEVENT` appender is set to `admin` :

``` java
    # LOGEVENT is set to be a LogEventAppender using a PatternLayout to send logs to LOGEVENT 
    log4j.appender.LOGEVENT=org.wso2.carbon.logging.service.appender.LogEventAppender
    log4j.appender.LOGEVENT.url=tcp://localhost:7611
    log4j.appender.LOGEVENT.layout=org.wso2.carbon.utils.logging.TenantAwarePatternLayout
    log4j.appender.LOGEVENT.columnList=%T,%S,%A,%d,%c,%p,%m,%I,%Stacktrace
    log4j.appender.LOGEVENT.userName=admin
    log4j.appender.LOGEVENT.password=admin
    log4j.appender.LOGEVENT.processingLimit=1000
    log4j.appender.LOGEVENT.maxTolerableConsecutiveFailure=20
```

Since we cannot use the [automated process](#EncryptingPasswordswithCipherTool-automated) to encrypt the `admin` password shown above, follow the steps given below to encrypt it manually.

1.  Download and install a WSO2 product.
2.  Open a command prompt and go to the `<PRODUCT_HOME>/bin` directory, where the cipher tool scripts (for Windows and Linux) are stored.

3.  You must first enable the Cipher tool for the product by executing the `-` Dconfigure command with the cipher tool script as shown below.

    -   On Linux: `./ciphertool.sh -Dconfigure`

    -   On Windows: `./ciphertool.bat -Dconfigure`

        !!! note
    If you are using the cipher tool for the first time, this command will first initialize the tool for your product. The tool will then encrypt any plain text passwords that are specified in the `cipher-text.properties` file. See the [automated encryption process](#EncryptingPasswordswithCipherTool-automated) for more information.


4.  Now, you can start encrypting the admin password manually. Execute the Cipher tool using the relevant command for your OS:

    -   On Linux: `./ciphertool.sh            `

    -   On Windows: `./ciphertool.bat            `

5.  You will be asked to enter the primary key password, which is by default 'wso2carbon'. Enter the password and proceed.
6.  You will now be asked to enter the plain text password that you want to encrypt. Enter the following element as the password and proceed:

    ``` java
        Enter Plain Text Value :admin
    ```

        !!! info
    Note that in certain configuration files, the password that requires encryption may not be specified as a single value as it is in the log4j.properties file. For example, the jndi.properties file used in WSO2 ESB contains the password in the connection URL. In such cases, you need to encrypt the entire connection URL as explained [here](#EncryptingPasswordswithCipherTool-encrypting_jndi) .


7.  You will receive the encrypted value. For example:

    ``` java
        Encrypted value is: 
        gaMpTzAccMScaHllsZLXspm1i4HLI0M/srL5pB8jyknRKQ2zT7NuCvt1+qEkElRLgwlrohz3lkuE0KFuapXrCSs5pxfGMOLn4/k7dNs2SlwbsG8C++/
        ZfUuft1Sl6cqvDRM55fQwzCPfybl713HvKu3oDaJ9VKgSbvHlQj6zqzg=
    ```

8.  Open the `cipher-text.properties` file, stored in the `<PRODUCT_HOME>/repository/conf/security` folder.

9.  Add the encrypted password against the secret alias as shown below.

    ``` java
            log4j.appender.LOGEVENT.password=cpw74SGeBNgAVpryqj5/xshSyW5BDW9d1UW0xMZ
            DxVeoa6RjyA1JRHutZ4SfzfSgSzy2GQJ/2jQIw70IeT5EQEAR8XLGaqlsE5IlNoe9dhyLiPXEPRGq4k/BgUQD
            YiBg0nU7wRsR8YXrvf+ak8ulX2yGv0Sf8=
    ```

10. Now, open the `log4j.properties` file, stored in the `<PRODUCT_HOME>/repository/conf` folder and replace the plain text element with the alias of the encrypted value as shown below.

    ``` java
            # LOGEVENT is set to be a LogEventAppender using a PatternLayout to send logs to LOGEVENT 
            ....
            log4j.appender.LOGEVENT.password=secretAlias:log4j.appender.LOGEVENT.password
            ....
    ```

11. If you are encrypting a password in the `<PRODUCT_HOME>/repository/conf/identity/EndpointConfig.properties` file, you need to add the encrypted values of the keys in the `EndpointConfig.properties` file itself.

        !!! note
    This step is **only applicable** if you are encrypting a password in the `EndpointConfig.properties` file.


    For example, if you have encrypted values for the following keys.

    -`Carbon.Security.KeyStore.Password`

    -`Carbon.Security.TrustStore.Password`

    Then you need to add a new key named `protectedTokens` in the `<PRODUCT_HOME>/repository/conf/identity/EndpointConfig.properties` file and add the above keys using comma separated values shown below:

    ``` java
        protectedTokens=Carbon.Security.KeyStore.Password,Carbon.Security.TrustStore.Password
    ```

    As we have already disabled this feature by setting "tenantListEnabled=false" in the EndpointConfig.properties, the mutual SSL is not required. Therefore, add below property as well to the properties.

``` java
    mutualSSLManagerEnabled=false
```

Another example of a configuration file that uses passwords without an XPath notation is the jndi.properties file. This file is used in WSO2 Enterprise Service Bus (WSO2 ESB) for the purpose of connecting to a message broker. You can read more about this functionality from [here](https://docs.wso2.com/display/ESB490/Configure+with+WSO2+Message+Broker) . As shown below, this file contains a password value (admin) in the connection URL ( <amqp://admin:admin@clientID/carbon?brokerlist=> ' <tcp://localhost:5673> '). To encrypt this password, you can follow the same manual process [explained above](#EncryptingPasswordswithCipherTool-encrypting_log4j) . However, you must encrypt the entire connection URL ( <amqp://admin:admin@clientID/carbon?brokerlist=> ' <tcp://localhost:5673> ') and not just the password value given in the URL.

``` java
    # register some connection factories
    # connectionfactory.[jndiname] = [ConnectionURL]
    connectionfactory.QueueConnectionFactory = amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5673'
# register some queues in JNDI using the form
# queue.[jndiName] = [physicalName]
queue.MyQueue = example.MyQueue

# register some topics in JNDI using the form
# topic.[jndiName] = [physicalName]
topic.MyTopic = example.MyTopic
```
!!! note
***NOTE! Please note that the following instructions are currently under review!***

If you have special characters in the passwords on your `jndi.properties` file, note the following:

-   It is not possible to use the `@` symbol in the username or password.
-   It is also not possible to use the percentage (%) sign in the password. When building the connection URL, the URL is parsed. This parsing exception happens because the percentage (%) sign acts as the escape character in URL parsing. If using the percentage (%) sign in the connection string is required, use the respective encoding character for the percentage (%) sign in the connection string. For example, if you need to pass `adm%in` as the password, then the `%` symbol should be encoded with its respective URL encoding character. Therefore, you have to send it as `adm%25in` .
    For a list of possible URL parsing patterns, see [URL encoding reference](http://www.w3schools.com/tags/ref_urlencode.asp) .


### Changing encrypted passwords

To change any password which we have encrypted already, follow the below steps:

1.  Be sure to shut down the server.

2.  Open a command prompt and go to the `<PRODUCT_HOME>/bin` directory, where the cipher tool scripts (for Windows and Linux) are stored.

3.  Execute the following command for your OS:

    -   On Linux: `./ciphertool.sh -Dchange`

    -   On Windows: `./ciphertool.bat -Dchange`

        !!! note
    If you are using the cipher tool for the first time, this command will first initialize the tool for your product. The tool will then encrypt any plain text passwords that are specified in the `cipher-text.properties` file for [automatic encryption](#EncryptingPasswordswithCipherTool-automated).


4.  It will prompt for the primary keystore password. Enter the keystore password (which is "wso2carbon" for the default keystore).

5.  The alias values of all the passwords that you encrypted will now be shown in a numbered list.

6.  The system will then prompt you to select the alias of the password which you want to change. Enter the list number of the password alias.

7.  The system will then prompt you (twice) to enter the new password. Enter your new password.

!!! info
If you have encrypted passwords as explained above, note that these passwords have to be decrypted again for the server to be usable. That is, the passwords have to be resolved by a system administrator during server startup. The [Resolving Passwords](https://docs.wso2.com/display/ADMIN44x/Resolving+Encrypted+Passwords) topic explains how encrypted passwords are resolved.


