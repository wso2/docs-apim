# Securing Sensitive Data via the Secure Vault

The WSO2 API Manager offers the Cipher tool to encrypt sensitive data (e.g., access tokens, passwords, etc.) in deployment configurations. This tool works in conjunction with [WSO2 Secure Vault](https://github.com/wso2/carbon-secvault/blob/master/README.md) to replace sensitive data that is in plain text with an alias. 
You can use the aliases instead of the actual passwords in your configuration files for better security.The actual value is then encrypted and securely stored in the SecureVault. At runtime, the actual value is retrieved from the alias and used. 

1. Navigate to `<API-M_ANALYTICS_HOME>/conf/worker/secrets.properties`. Enter the required sensitive data element with the value in plain text as shown in the example below. 
You need to enter the password after a space to `plainText` . If not error will be thrown when running the cipher tool.

    ```
    wso2.sample.password1=plainText ABC@123
    ```
              
2. Navigate to `<API-M_ANALYTICS_HOME>/conf/worker/deployment.toml`. Enter the alias to be used in the required configuration file instead of the actual value of sensitive data you specified in the previous step. 
For example if you need to secure the password in Authentication configuration you need to add the configuration as below : 
    ```
    # Authentication configuration
    auth.configs:
      type: 'local'        # Type of the IdP client used
      userManager:
        adminRole: admin   # Admin role which is granted all permissions
        userStore:         # User store
          users:
           -
             user:
               username: admin
               password: ${sec:wso2.sample.password1}
               roles: 1
          roles:
           -
             role:
               id: 1
               displayName: admin
    ```

3. To encrypt the sensitive data element and store it in the secure vault, Navigate to the `<API-M_ANALYTICS_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.
                                                                        
    - On Windows: `ciphertool.bat --run`
    - On Linux/Mac OS: `sh ciphertool.sh -runtime worker`

4. Navigate to `<API-M_ANALYTICS_HOME>/conf/worker/secrets.properties`. You can find the encrypted value of your piece of data.


