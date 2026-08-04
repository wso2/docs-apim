# Encrypting Passwords in Configuration Files

All WSO2 products are shipped with a **Secure Vault** implementation that allows you to store encrypted passwords in configuration files. By default, the system user passwords, keystore passwords, encryption key, etc. in configuration files are stored in plain text, but storing sensitive data such as passwords in plain text makes the data more susceptible to compromise.

**Secure Vault** allows you to store encrypted passwords and map them with aliases, which are used in configuration files instead of the actual passwords. These encrypted passwords will be decrypted and resolved during runtime only.

For example, if the admin user password is `admin`, you can define an alias (such as `admin_password`) and map that particular alias to the actual password (admin). At runtime, the product will look up this alias in the secure vault, decrypt it, and use the mapped password.

The instructions below explain how plain text passwords in configuration files can be encrypted using the secure vault implementation that is built into WSO2 products.

!!! info "Before you begin"
    If you are using Windows, you need to have [**Ant**](http://ant.apache.org/) installed in order to use the Cipher Tool.

## Encrypting passwords in product configurations 

While you are able to encrypt passwords using symmetric or asymmetric encryption, it is recommended to use symmetric encryption due to its greater resilience against post-quantum threats. Asymmetric encryption methods like RSA are not recommended due to their vulnerability to quantum computing capabilities. If you are using asymmetric encryption for the cipher tool, you should switch to [asymmetric key encryption]({{base_path}}/install-and-setup/setup/security/encryption/asymmetric-encryption) for the system too.

1.  Open the `<APIM_HOME>/repository/conf/deployment.toml` file. 

2.  Add the `[secrets]` configuration section at the **bottom** of the `deployment.toml` file and include the passwords that you need to protect. 

    !!! warning "Important"
        The `[secrets]` configuration section should be added at the very end of the `deployment.toml` file or this will cause errors in server startup.

     Use the `<alias>="[<actual_password>]"` format, under `[secrets]`. Provide an alias for the password type followed by the actual password enclosed within square brackets `[]` as shown below. The most commonly used passwords in configuration files are listed in the example configuration.

    === "Format"
        ``` toml
        [secrets]
        <password_1_alias> = "[<password_1>]"
        <password_2_alias> = "[<password_2>]"
        ```
       
    === "Example"
        ``` toml
        [secrets]
        admin_password = "[admin]"
        keystore_password = "[wso2carbon]"
        key_password = "[wso2carbon]"
        truststore_password = "[wso2carbon]"
        encryption_key = "[748fe62b5b9f6560331d71f5d01017086506018bff7a0ca3347b7979d29b757f]"
        ```
    
3.  Locate the configurations with the plain text passwords in the `<APIM_HOME>/repository/conf/deployment.toml` configuration file, and replace them with `$secret{<alias>}` to refer to the encrypted password instead of the plain text password. 

     Note that the `alias` has to be the alias value that you configured in the above step as the mapping of the actual password. 

    The sample configuration for the most commonly used passwords is given below.
   
    === "Format"
        ``` toml
        [super_admin]
        username="admin"
        password="$secret{<admin_password_alias>}"
            
        [keystore.tls]
        password = "$secret{<keystore_password_alias>}" 
        key_password = "$secret{<key_password_alias>}"  
        
        [truststore]                  
        password = "$secret{<truststore_password_alias>}"       

        [encryption]
        key = "$secret{<encryption_key_alias>}"   
        ```
       
    === "Example"
        ``` toml
        [super_admin]
        username="admin"
        password="$secret{admin_password}"
            
        [keystore.tls]
        password = "$secret{keystore_password}" 
        key_password = "$secret{key_password}"  
        
        [truststore]                  
        password = "$secret{truststore_password}"   

        [encryption]
        key = "$secret{encryption_key}"   
        ``` 
       
    !!! Note
        You can also replace your passwords by referring to values passed by environment variables and system properties. For instructions, see [Set Passwords using Environment Variables/System Properties]({{base_path}}/administer/product-security/logins-and-passwords/set-passwords-using-vars-and-sys-props)
       
4.  Encrypt the passwords.
    1. Open a terminal and navigate to the `<APIM_HOME>/bin` directory.
    2. Execute the following command to encrypt the passwords. (You must first enable the Cipher tool for the product by executing the `-Dconfigure` command with the cipher tool script as shown below).

    === "Symmetric encryption"

        !!! note "Prerequisite"

            To support symmetric encryption, you should have a symmetric AES-256 encryption key. To generate a unique 256-bit secret key, you can use OpenSSL, the command will be as follows:

                openssl rand -hex 32

        - **For Linux**: `./ciphertool.sh -Dconfigure -Dsymmetric -Dkey.based.encryption`

        - **For Windows**: `ciphertool.bat -Dconfigure -Dsymmetric -Dkey.based.encryption`

        You will be prompted to enter the encryption key. 

        If the encryption is successful, you will see the following log.

        ```java
        Secret Configurations are written to the property file successfully
        ```

    === "Asymmetric encryption"

        !!! warning

            Asymmetric encryption methods like RSA are not recommended due to their vulnerability to post-quantum threats.

        - **For Linux**: `./ciphertool.sh -Dconfigure`

        - **For Windows**: `ciphertool.bat -Dconfigure`

        You will be prompted to enter the internal keystore password for the server. When prompted, if you have not configured a separate [internal keystore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#configuring-the-internal-keystore), enter the primary key password, which is by default `wso2carbon` and proceed. 

        If the encryption is successful, you will see the following log.

        ```java
        Internal KeyStore of Carbon Server is initialized Successfully
        
        Secret Configurations are written to the property file successfully
        ```

5.  Open the `<APIM_HOME>/repository/conf/deployment.toml` file. You will see that the alias passwords are encrypted.

    ```toml
    [secrets]
    admin_password  = "eyJjaXBoZXJUZXh0IjoiRE10RmtKTXVDVlpKZEFqOWJUc0crSXJIWlpocSIsIml2IjoiaGlDVEY0UFIzbE5yZ2ROZ01FYmhKOTBhTTJaMk9kMUtCbXZYY200V1UrOGJLNlJBQ1czK0RIemtHZERlSStTZzhLTlpJRnNZL0IxYzRsZDlGYUg3YU91MEkzWjZYWUNZMDN6SlFDczhLVG5wcFpiMUYvSUc4WnpDdFdneTZEbENmOEpzcFB0SFMwM3MrdW1IZm9VeHF4Q2xIVy9oWkp0Mmd0bTJ0b2t5YWZBXHUwMDNkIn0="
    keystore_password  = "eyJjaXBoZXJUZXh0IjoiVzAxeVZnNGY2L2cyWUhyaTRzTnBHWXNlcGV4YlhBNldlRVFcdTAwM2QiLCJpdiI6IkJZSStOUjRNWU5xT0hMNmJvY2VHeURsbFBya2lMZVN5Vit2WmovQ3pndmd4Tzl5YmdzQ1ViengzYXpXWUg5dmNkZlR0OTRTUWtYby8zVTk3VmRKbzE5TFllK0E5Mk5RS3FhckEwaTVqZXRaVS9zTUFJSW00OHc2bVpQTVpmVjlycG9RYTkwZnl3TUk4YVFpRmlleXpnYjZXRHJyRGU5TkJLR3c5Y2ZRaWlUa1x1MDAzZCJ9"
    key_password  = "eyJjaXBoZXJUZXh0IjoiQ0cwSjRncG1OeUZ2ZE9RU0F2dkdoL00ycjZXZHQycWVOZ2tcdTAwM2QiLCJpdiI6Im1CRldaUE1lV2ZMaEt5eklMT2xMdXpSdUFpUkN5TlhkWG9rKzVGSVg2RlZkdTZtSmkxeHFxYTd2R3hGSkxHQkNIWVRaVzJHdVNBV0kra2F3Y2Q5UkVTb01nZk03OCt5VC9NcDRBeGlWb2xtQlRUTUJIT0lKTGRZVzlzM0tRZXBLUGUyTmwyb04wN0hhRkVYSlQ0Tzcyd01BTklHRDdNck9NcXRtWTdGeGJiSVx1MDAzZCJ9"
    truststore_password  = "eyJjaXBoZXJUZXh0IjoidzZwM1dsS1d6V1EzV21HbE8xelZRQ21YeDFJODQzR3RKd0VcdTAwM2QiLCJpdiI6ImszanR1YlNKdUN2eThhbWlTVzdFeFRGOFVkckRwbUM1QURUdThzZ3hwcW5hUlpsZHBhb2ZqckxqV0FsVFV5ajZjd0RTREJYUGZuRU0vT3crSG45ZlgxL2FQWTFsYTdqNHQzVG9pQ3hPZUpLVjJSMW9xam8zN20rYnN5OEVmYmRSb2NYUkZjd0s1WTJNRE1WOCt2cHZ5a3JXZFNWZFFzVmRMTkJDNmtyT2pURVx1MDAzZCJ9"
    encryption_key  = "eyJjaXBoZXJUZXh0IjoiME1pcC9zbUZPNFlQdzM2eEpvSlhob1lTcUFrTjhxZUROTjFWR3JRNmt1ZFJ6dGc1Ly9UMzFBczdML3RYblcvTEhoRG1ZaVp3THBtdGVuQ3VlS1NvdWx2eUUxdjU1VjhZbGkxaWs1NklYaHdcdTAwM2QiLCJpdiI6IlpEYlI3ZE9reU9JQWdFUHd5REtlUEMzYzdqNHRYd1A0dkx4Mm03MjQxbW0zdVFpckZLTUEwbFh3ck84N3hWL3pDWmtPTjF1ZE00eTN5cHltOHUzVGRHQTVFK3FzTGo1bDJYTDFyOXdFanlrSG9rWmRhVUt5UFNhSi85VS8rRjZOdStEMEt4eTlDajhtdkZhWTVwZklLcTU2R09OdlVHTWtzZ3g0MW43RTZkNFx1MDAzZCJ9"
    ```

    To resolve the passwords during different modes of server startup, see [Resolving already encrypted passwords during server startup](#resolving-already-encrypted-passwords-during-server-startup).

## Encrypting secured endpoint passwords

When exposing an API backend, which is secured with [Digest]({{base_path}}/manage-apis/design/endpoints/endpoint-security/digest-auth) or [Basic]({{base_path}}/manage-apis/design/endpoints/endpoint-security/basic-auth) Authentication, the backend user credentials have to be provided under endpoint configuration. These credentials are encoded in base64 and stored in the API configuration as a Basic Authorization header (`Authorization: Basic base64Encode(<username>:password)`). By default, the Authorization header value is stored in plain text.

Follow the instructions below to secure the endpoint's password that is given in plain text in the UI.

1.  Shut down the server if it is already running.

2.  Open the `<APIM_HOME>/repository/conf/deployment.toml` file and add the following configuration to enable Secure Vault in API Manager. 

    ```toml
    [apim]
    enable_secure_vault=true
    ```
    
    !!! warning "Important"
        This configuration should be added before all the other `[apim]` elements or this will result in an error.

3.  Follow step 4 in [Encrypting passwords in product configurations]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords/#encrypting-passwords-in-product-configurations) to run the cipher tool.
    
4.  Restart the server. 

     * On Linux/Mac OS: `./api-manager.sh`
     * On Windows: `./api-manager.bat`
     
After enabling the backend Secure Vault for backend credentials, the Basic Authentication header, which is written in the Universal Gateway configuration file, will be encrypted. If there were APIs that were already created and published before these instructions were performed, an update to the particular API would trigger the encryption process of the credentials.

## Changing already encrypted passwords

Follow the instructions below to change any password that you have already encrypted:

1.  Shut down the server.
2.  Open a command prompt and go to the `<API-M_HOME>/bin/` directory, where the Cipher tool scripts (for Windows and Linux) are stored.
3.  Execute the following command for your OS:

    === "Symmetric encryption"

        - **For Linux**: `./ciphertool.sh -Dchange -Dsymmetric -Dkey.based.encryption`

        - **For Windows**: `ciphertool.bat -Dchange -Dsymmetric -Dkey.based.encryption`

        You will be prompted to enter the encryption key used for the cipher tool configuration.

    === "Asymmetric encryption"

        - **For Linux**: `./ciphertool.sh -Dchange`

        - **For Windows**: `ciphertool.bat -Dchange`

        You will be prompted to enter the internal keystore password. When prompted, if you have not configured a separate [internal keystore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#configuring-the-internal-keystore), enter the primary key password, which is by default `wso2carbon` and proceed. 

4.  The alias values of all the passwords that you encrypted will now be shown in a numbered list as follows.

    ```bash
    [1] keystore_password
    [2] key_password
    [3] admin_password
    [4] truststore_password
    [5] encryption_key
    [Please enter the Number which is corresponding to the Password that is needed be changed [Press Enter to Skip] : ]
    ```
     The system will then prompt you to select the alias of the password which you want to change. 

5.  Enter the number corresponding to the alias of the password you want to change.

     For example, if you want to change the password for `admin_password`, enter `3`. 

     The system will then prompt you (twice) to enter the new password.
    
6.  Enter your new password.

     If the encryption is successful, you will get the `Encryption is done Successfully` message.


## Rotating Encryption Secrets

You can rotate encryption keys by switching between symmetric and asymmetric encryption or by changing the encryption keys within the same encryption mode. Follow the steps below.

1. Generate the new key material:

    === "Symmetric encryption"

        Use the following command to generate an AES-256 symmetric encryption key:
        ```bash
        openssl rand -hex 32
        ```
        You will be prompted to enter the old encryption key and a new encryption key. You can use the generated key above as the new encryption key.
    
    === "Asymmetric encryption"

        Use the following command to add a new key to an existing keystore with a new alias:
        ```bash
        keytool -genkeypair -alias new_alias -keyalg RSA -keystore wso2carbon.jks -storepass password -keypass password
        ```
        Then, update the `deployment.toml` file found in the `<APIM_HOME>/repository/conf` directory to reflect the new key or secret alias:

        ```toml
        [keystore.internal]
        file_name = "internal.jks"
        type = "JKS"
        alias = "new_alias"
        password = "$secret{keystore_password}"
        key_password = "$secret{keystore_password}"
        ```

2. Navigate to the `<APIM_HOME>/bin/` directory using the command prompt, where the cipher tool scripts reside.

3. Execute the cipher tool script to re-encrypt the passwords with the new key or secret. Use the `-Drotate` option.

    === "Symmetric encryption"

        - For Linux: `./ciphertool.sh -Drotate -Dsymmetric -Dkey.based.encryption`

        - For Windows: `ciphertool.bat -Drotate -Dsymmetric -Dkey.based.encryption`

    === "Asymmetric encryption"

        - On Linux: `./ciphertool.sh -Drotate -Dold.alias=wso2carbon`

        - On Windows: `ciphertool.bat -Drotate -Dold.alias=wso2carbon`

4. Go back to the `deployment.toml` file and see that the passwords are re-encrypted with the new encryption key.

## Resolving already encrypted passwords during server startup

**Secure Vault** provides two options for resolving the encrypted passwords during server startup:

-   [Enter password in command-line](#enter-password-in-command-line)
-   [Start server as a background job](#start-server-as-a-background-job)

=== "Symmetric encryption"

    !!! Note
            If you have secured the plain text passwords in configuration files using Secure Vault with symmetric encryption, the symmetric encryption key will serve as the root key for Secure Vault. This key is needed to initialize the values encrypted by the **Secret Manager** in the **Secret Repository**. Therefore, the **Secret Callback handler** is used to resolve the encryption key. The default Secret CallbackHandler provides the two options given below. For more information on secure vault concepts, see [Secure Vault concepts]({{base_path}}/administer/product-security/logins-and-passwords/carbon-secure-vault-implementation/#elements-of-the-secure-vault-implementation).
=== "Asymmetric encryption"

    !!! Note
            If you have secured the plain text passwords in configuration files using Secure Vault, the keystore password and private key password of the product's [primary keystore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager) will serve as the root passwords for Secure Vault, if you have not configured a separate [internal keystore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#configuring-the-internal-keystore). This is because the keystore passwords are needed to initialize the values encrypted by the **Secret Manager** in the **Secret Repository**. Therefore, the **Secret Callback handler** is used to resolve these passwords. The default Secret CallbackHandler provides the two options given below. For more information on secure vault concepts, see [Secure Vault concepts]({{base_path}}/administer/product-security/logins-and-passwords/carbon-secure-vault-implementation/#elements-of-the-secure-vault-implementation).

### Enter password in command-line

=== "Symmetric encryption"

    1.  Start the server by running the product startup script from the `<APIM_HOME>/bin` directory as shown below.

        * On Linux: `./api-manager.sh`
        * On Windows: `./api-manager.bat`

        When you run the startup script, the following message will appear before starting the server: `[Enter Symmetric Encryption Key:]`.

        !!! note "YAJSW wrapper behavior on Windows"
            When starting WSO2 API Manager via the YAJSW wrapper on Windows (for example, through `runConsole.bat` or `api-manager.bat start`), no interactive console is available for key input. Therefore, the encryption key prompt (`[Enter Symmetric Encryption Key:]`) will not appear. In such cases, you must provide the encryption key through a key file (`encryption-key-tmp.txt` or `encryption-key-persist.txt`) placed under the `<APIM_HOME>` directory. For more information, see [Start server as a background job](#start-server-as-a-background-job).

    2.  When prompted, you as the administrator who is starting the server must provide the symmetric encryption key using the command line to proceed.

         Note that the encryption key is hidden from the terminal and log files.

        !!! Info
            During the server startup, it tries to connect to the default user store. To connect to the default user store, the encrypted passwords should be decrypted. Therefore, the server admin will be prompted for the encryption key to proceed with the decryption.

=== "Asymmetric encryption"

    1.  Start the server by running the product startup script from the `<APIM_HOME>/bin` directory as shown below.

        * On Linux: `./api-manager.sh`
        * On Windows: `./api-manager.bat`

        When you run the startup script, the following message will appear before starting the server: `[Enter KeyStore and Private Key Password:]`.

        !!! note "YAJSW wrapper behavior on Windows"
            When starting WSO2 API Manager via the YAJSW wrapper on Windows (for example, through `runConsole.bat` or `api-manager.bat start`), no interactive console is available for password input. Therefore, the keystore password prompt (`[Enter KeyStore and Private Key Password:]`) will not appear. In such cases, you must provide the keystore password through a password file (`password-tmp.txt` or `password-persist.txt`) placed under the `<APIM_HOME>` directory. For more information, see [Start server as a background job](#start-server-as-a-background-job).

    2.  When prompted, you as the administrator who is starting the server must provide the private key password and the keystore password using the command line to proceed.

         Note that passwords are hidden from the terminal and log files.

        !!! Info
            During the server startup, it tries to connect to the default user store. To connect to the default user store, the encrypted passwords should be decrypted. Therefore, the server admin will be prompted for the keystore password to proceed with the decryption.
        

### Start server as a background job

If you start the WSO2 API Manager as a background job, you will not be able to provide password values on the command line. Therefore, you must start the server in `daemon` mode as explained below.

=== "Symmetric encryption"

    !!! note "Required for YAJSW wrapper on Windows"
        This method is mandatory when starting WSO2 API Manager via the YAJSW wrapper on Windows (for example, using `runConsole.bat` or the Windows service), as the wrapper does not provide an interactive console for encryption key input.

    1.  Create a new file in the `<APIM_HOME>` directory. The file should be named according to your OS as explained below.

        * For Linux: The file name should be `encryption-key-tmp`
        * For Windows: The file name should be `encryption-key-tmp.txt`

        !!! Note
            When you start the server, the encryption key will be picked up from this new file. Note that this file is automatically deleted from the file system after the server starts. Therefore, the admin has to create a new text file every time the server starts.

            Alternatively, if you want to retain the encryption key file after the server starts, the file should be named as follows:

            * For Linux: The file name should be `encryption-key-persist`
            * For Windows: The file name should be `encryption-key-persist.txt`

    2.  Add the symmetric encryption key to the new file and save it. 

    3. Start the server as a background process by running the following command.

        * On Linux: `./api-manager.sh start`
        * On Windows: `./api-manager.bat start`

=== "Asymmetric encryption"

    !!! note "Required for YAJSW wrapper on Windows"
        This method is mandatory when starting WSO2 API Manager via the YAJSW wrapper on Windows (for example, using `runConsole.bat` or the Windows service), as the wrapper does not provide an interactive console for password input.

    1.  Create a new file in the `<APIM_HOME>` directory. The file should be named according to your OS as explained below.

        * For Linux: The file name should be `password-tmp`
        * For Windows: The file name should be `password-tmp.txt`

        !!! Note
            When you start the server, the keystore password will be picked up from this new file. Note that this file is automatically deleted from the file system after the server starts. Therefore, the admin has to create a new text file every time the server starts.

            Alternatively, if you want to retain the password file after the server starts, the file should be named as follows:

            * For Linux: The file name should be `password-persist`
            * For Windows: The file name should be `password-persist.txt`

    2.  Add the primary keystore password (which is `wso2carbon` by default) to the new file and save it. 

         By default, the password provider assumes that both the private key password and keystore password are the same. If not, the private key password must be entered in the second line of the file.

    3. Start the server as a background process by running the following command.

        * On Linux: `./api-manager.sh start`
        * On Windows: `./api-manager.bat start`
   
   
 
