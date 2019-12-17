# Encrypting Passwords in Configuration files

All WSO2 products are shipped with a **Secure Vault** implementation that allows you to store encrypted passwords in configuration files. By default, the system user passwords, key store passwords etc in configuration files are stored in plain text, but storing sensitive data such as passwords in plaintext makes the data more susceptible to compromise.

**Secure Vault** allows you to store encrypted passwords and map them with aliases, which are used in configuration files instead of the actual passwords. These encrypted passwords will be decrypted and resolved during runtime only.

For example, if the admin user password is `admin`, you can define an alias (such as `admin_password`) and map that particular alias to the actual password (admin). At runtime, the product will look up this alias in the secure vault, decrypt it, and use the mapped password.

The instructions below explain how plain text passwords in configuration files can be encrypted using the secure vault implementation that is built into WSO2 products.


## Encrypting passwords

1.  Open `<APIM_HOME>/repository/conf/deployment.toml` file. 

2.  Add `[secrets]` configuration section and include the passwords which you need to protect in the format of `<alias>="[<actual_password>]"`, under `[secrets]` as shown below (The most commonly used passwords in configuration files are listed in the example configuration).
   
       
       ``` tab="Format"
       [secrets]
       <password_1_alias> = "[<password_1>]"
       <password_2_alias> = "[<password_2>]"
       ```
       
       ``` tab="Example"
       [secrets]
       admin_password = "[admin]"
       keystore_password = "[wso2carbon]"
       key_password = "[wso2carbon]"
       truststrore_password = "[wso2carbon]"
       ```    

3.  Locate the configurations with the plain text passwords in `<APIM_HOME>/repository/conf/deployment.toml` configuration file. Then replace them with `$secret(<alias>)` in order to refer the encrypted password instead of plain text password. Please note that the `alias` has to be the alias value configured in above step as the mapping of the actual password . 

    Sample configuration for most commonly used passwords is given below.
   
       ``` tab="Format"
       [super_admin]
       username="admin"
       password="$secret{<admin_password_alias>}"
       
       [keystore.tls]
       password = "$secret{<keystore_password_alias>}" 
       key_password = "$secret{<key_password_alias>}"  
   
       [truststore]                  
       password = "$secret{<truststore_password>}"       
       ```
       
       ``` tab="Example"
       [super_admin]
       username="admin"
       password="$secret{admin_password}"
       
       [keystore.tls]
       password = "$secret{keystore_password}" 
       key_password = "$secret{key_password}"  
   
       [truststore]                  
       password = "$secret{truststrore_password}"   
       ``` 
       
    !!!Note
        You can also replace your passwords by referring values passed by environment variables and system properties. See the instructions on [Set Passwords using Environment Variables/System Properties]({{base_path}}/Administer/ProductSecurity/General/LoginsAndPasswords/set-passwords-using-vars-and-sys-props)
       
4.  Open a terminal, navigate to the `<APIM_HOME>/bin` directory, and execute the following command to encrypt the passwords (You must first enable the Cipher tool for the product by executing the `-Dconfigure` command with the cipher tool script as shown below).

    * On Linux: `./ciphertool.sh -Dconfigure`
    * On Windows: `./ciphertool.bat -Dconfigure`

5.  Then you will be prompted to enter the internal key store password for the server. When prompted, enter the primary key password, which is by default `wso2carbon` and proceed. 

    If the encryption is successful, you will see the following log.

    ```java
    Internal KeyStore of Carbon Server is initialized Successfully
    
    Secret Configurations are written to the property file successfully
    ```

6.  Go back to the `<APIM_HOME>/repository/conf/deployment.toml` file and see that the alias passwords are encrypted.

    ```toml
    [secrets]
    admin_password  = "gss3W6fPqm5YdCCBUxTJsFAONjt4NvnLK8ab5Ob5sgRXWMFEQW8mvVxnpnKlMKwqgV9dlUwG4RCzT9hcc2TKkbkxZDDQnGczgwMnlTaiviGkm/D4FIuuGqhh1i1KBNIShUMCPGIFBpqGbvTe4R4CQjZc3kw9FEOBZni7EJFkKCKeSI4d9bDZUmGpNsMzIsqXSqklxQ+zq/ZAcx3ctQZU9QsfXaknqHSWr0sFNzlyMc/o70kOcUyFb3UYxE1knrGvPMMHaVK7ZbI40c0G4vPxsDnliOv/KvpMhTd6AIuY9gzP9lChzmWq7SgLrBVrqDMBWsteKOvAgaQNri6vXmDykQ=="
    keystore_password  = "cGsMesQfdbElQusfsc7FxXdc89Ak88rwtcW7jaHtGqCNZFYUJpyJ+551xXTWhSXZP/CS7mqTmPYWOOKfeIalSlv1ULSsH5JIpOROsTsJgZ3Bu4RpsypMan9UMpc5xjoMaNr955WD03DfDZ2PSZFSx78GoKEr8RSzNSBlr2q3hxaujHfGzjXMhkuZmIsnI77zFxVXb5iDz/n6oh9Mz7xRheXy3CsxLxm2sNGsr9+GL4ZrKWlQ7dZdbWk0N3HtpJbyDGa58yHaswxJHe8eVnTn66c3C9QlRDNL9JSHppzk+03xTzStb9v9Y4a+Fdz9ckBY1zQ3NPVUOjMToPKEaNPVoA=="
    key_password  = "hCmOjvWOmCCH8qsIhSecVewvgtStrM+QeZFKWfLqo1Mui2TuDpX4PKm4M2XQ/gRAH7GFP8AZStKN9QwjdyhGU3O6KuwhyIoKNH0Wkf/2jafShChLQj7jmd2fFxWYZLgnd9h36LEQEYgYGhyoyfZWmJknn6c4RxxNrSk3PJbWl8pft3ylRpYRIPhPUXegTI1XMuLgTiUMmB2wLF12QBFLOHLJhFWZx2E1ngpSoWsxdEcluQeJiTwR1ltrk23WY8N54xaZOsVN8zSniEGpwt6Jo8eij9Rjl+5r8wgErdYvX16xKQxBiQxjuEazzH4h29Ey/pf5S4y2oFX1WElIo51knw=="
    truststrore_password  = "FEQvzFCYpJfuD9XYb0H4KW/lZICu7vaPMzC02kIIbMy47q1q68QxIdOAwQxv+wiRAI/fQIxX6ygTjWV+3bjYmP1Mj0qrhx6CeH6L467ISIHT8oTdecqq5kcGqMEBanexQ7Wu/ULeiiaGLA4x9OXHgJsKd9x3yf6Vm56FzmVkUM5+HAX6pYpBSEFuDKJprhlJtvrEN//nGb0p342g4CqG9VqW3UFbkQaawmItSd9pMnBlDM6+STmiDBUFrV7gdJfrCzGnJs7QBl20Kxg5aznNkwnpJ3bEwj3Trkzsxujk1wMOnhk5XvwdeKRevkX8MyHrnUICyXZ6TK0po1wrYZjYvw=="
    ```

7.  Please refer [Resolving already encrypted passwords during server startup](#resolving-already-encrypted-passwords-during-server-startup) in order to resolve the passwords during different modes of server startup.

## Changing already encrypted passwords

To change any password which we have encrypted already, follow the below steps:

1.  Be sure to shut down the server.
2.  Open a command prompt and go to the MI_HOME/bin/ directory, where the cipher tool scripts (for Windows and Linux) are stored.
3.  Execute the following command for your OS:
    * On Linux: `./ciphertool.sh -Dchange`
    * On Windows: `./ciphertool.bat -Dchange`
4.  It will prompt for the internal keystore password. Enter the keystore password (which is "wso2carbon" for the default keystore).
5.  The alias values of all the passwords that you encrypted will now be shown in a numbered list as follows.

    ```bash
    Internal KeyStore of Carbon Server is initialized Successfully
    
    [1] keystore_password
    [2] key_password
    [3] admin_password
    [4] truststrore_password
    [Please enter the Number which is corresponding to the Password that is needed be changed [Press Enter to Skip] : ]
    ```
6.  The system will then prompt you to select the alias of the password which you want to change. Enter the list number of the password alias.

    For example, if you want to change the password for `admin_password`, enter `3`. 
    
7.  The system will then prompt you (twice) to enter the new password. Enter your new password.

8.  If the encryption is successful, you will get `Encryption is done Successfully` message.

## Resolving already encrypted passwords during server startup

**Secure Vault** provides two options of resolving the encrypted passwords during server startup

-   [Enter password in command-line](#enter-password-in-command-line)
-   [Start server as a background job](#start-server-as-a-background-job)

!!! Note
    If you have secured the plain text passwords in configuration files using Secure Vault, the keystore password and private key password of the product's [primary keystore]({{base_path}}/Administer/ProductConfigurations/configuring-keystores-in-wso2-api-manager/) will serve as the root passwords for Secure Vault. This is because the keystore passwords are needed to initialise the values encrypted by the **Secret Manager** in the **Secret Repository**. Therefore, the **Secret Callback 
    handler** is used to resolve these passwords. The default secret CallbackHandler provides the two options given below. Read more about [Secure Vault concepts]({{base_path}}/Administer/ProductSecurity/General/LoginsAndPasswords/carbon-secure-vault-implementation)


### Enter password in command-line

1.  Start the server by running the product start up script from the `<APIM_HOME>/bin` directory as shown below.

    * On Linux: `./wso2server.sh`
    * On Windows: `./wso2server.bat`
    
2.  When you run the startup script, the following message will be prompted before starting the server: `[Enter KeyStore and Private Key Password:]`. When this is prompted, the administrator starting the server must provide the private key and keystore passwords using the command-line to proceed. Note that passwords are hidden from the terminal and log files.

    !!!Note
        During the server startup, it tries to connect to default user store. In order to connect to the default user store, the encrypted passwords should be decrypted. Therefore, the server admin will be prompted with key store password in order to proceed with the decryption.
        

### Start server as a background job

If you start the WSO2 API Manager as a background job, you will not be able to provide password values on the command line. Therefore, you must start the server in `daemon` mode as explained below.

1.  Create a new file in the <APIM_HOME> directory. The file should be named according to your OS as explained below.

    * For Linux: The file name should be `password-tmp`.
    * For Windows: The file name should be `password-tmp.txt`.

    !!! Note
        When you start the server, the keystore password will be picked from this new file. Note that this file is automatically deleted from the file system after the server starts. Therefore, the admin has to create a new text file every time the server starts.

        Alternatively, if you want to retain the password file after the server starts, the file should be named as follows:

        * For Linux: The file name should be `password-persist`
        * For Windows: The file name should be `password-persist.txt`

2.  Add the primary keystore password (which is `wso2carbon` by default) to the new file and save. By default, the password provider assumes that both private key and keystore passwords are the same. If not, the private key password must be entered in the second line of the file.

3. Now, start the server as a background process by running the following command.

    * On Linux: `./wso2server.sh start`
    * On Windows: `./wso2server.bat start`
   
   
 