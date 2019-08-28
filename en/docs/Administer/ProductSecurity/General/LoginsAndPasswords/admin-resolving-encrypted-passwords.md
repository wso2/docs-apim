# admin\_Resolving Encrypted Passwords

If you have secured the plain text passwords in configuration files using Secure Vault, the keystore password and private key password of the product's primary keystore will serve as the root passwords for Secure Vault. This is because the keystore passwords are needed to initialise the values encrypted by the Secret Manager in the Secret Repository. Therefore, the Secret Callback handler is used to resolve these passwords. Read about the [Secure Vault implementation](https://docs.wso2.com/display/ADMIN44x/Securing+Passwords+in+Configuration+Files) in WSO2 products. Also, see how passwords in [configuration files are encrypted](https://docs.wso2.com/display/ADMIN44x/Encrypting+Passwords+with+Cipher+Tool) using Secure Vault.

The default secret CallbackHandler in a WSO2 product provides two options for reading these encrypted passwords when you start the server:

-   [Enter password in command-line](#admin_ResolvingEncryptedPasswords-Enterpasswordincommand-line)
-   [Start server as a background job](#admin_ResolvingEncryptedPasswords-Startserverasabackgroundjob)

### Enter password in command-line

1.  Start the server by running the product start up script from the `           <PRODUCT_HOME>/bin/          ` directory as shown below.

    ``` java
        ./wso2server.sh 
    ```

2.  When you run the startup script, the following message will be prompted before starting the server: "\[Enter KeyStore and Private Key Password :\]". This is because, in order to connect to the default user store, the encrypted passwords should be decrypted. The administrator starting the server must provide the private key and keystore passwords using the command-line. Note that passwords are hidden from the terminal and log files.

### Start server as a background job

If you start the WSO2 Carbon server as a background job, you will not be able to provide password values on the command line. Therefore, you must start the server in "daemon" mode as explained below.

1.  Create a new file in the `          <PRODUCT_HOME>         ` directory. The file should be named according to your OS as explained below.

    -   For **Linux** : The file name should be `            password-           ` tmp.
    -   For **Windows** : The file name should be `            password-tmp.txt           ` .

        !!! info
    When you start the server (see step 3 below), the keystore password will be picked from this new file. Note that this file is automatically deleted from the file system after the server starts. Therefore, the admin has to create a new text file every time the server starts.

    Alternatively, if you want to retain the password file after the server starts, the file should be named as follows:

    -   For **Linux** : The file name should be `            password-persist           ` .
    -   For **Windows** : The file name should be `            password-persist.txt           ` .


2.  Add "wso2carbon" (the primary keystore password) to the new file and save. By default, the password provider assumes that both private key and keystore passwords are the same. If not, the private key password must be entered in the second line of the file.
3.  Now, start the server as a background process by running the following command.

    ``` java
        ./wso2server.sh start
    ```

4.  Start the server by running the product start-up script from the `           <PRODUCT_HOME>/bin          ` directory by executing the following command:

    ``` java
            daemon. sh wso2server.sh -start
    ```


