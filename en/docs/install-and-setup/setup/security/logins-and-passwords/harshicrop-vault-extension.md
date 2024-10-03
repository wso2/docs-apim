
# Integrate with HashiCorp Vault

Using [HashiCorp Vault extension](https://github.com/wso2-extensions/carbon-securevault-hashicorp/tree/master), you can set up HashiCorp Vault to store passwords that are mapped to aliases instead of the actual passwords. When setting up Hashicrop Vault with APIM you can use either of the following authentication methords, based on your requirment.
   
1. Using Root Token authentication
2. Using App-Role authentication

## Setting up using Root Token authentication

This method uses a static root token to authenticate with HashiCorp Vault, providing direct and full access to Vault's secrets.

### Step 1 - Setup HashiCorp Vault

1. Start the HashiCorp Vault server and create a new **KV engine**. Enter a path name when creating the kv engine (e.g., `wso2apim`). The following commands can be used to add secrets with the HashiCorp Vault.

    ```shell
    # Create a new kv engine
    vault secrets enable -path=wso2apim -version=2 kv

    # Add new secret
    vault kv put wso2apim/admin_password value=admin

    # Get a secret (To check)
    vault kv get -field=value wso2apim/admin_password
    ```

### Step 2 - Configure HashiCorp Vault extension

1. Clone [HashiCorp Vault extension](https://github.com/wso2-extensions/carbon-securevault-hashicorp/tree/master) repo.

2. Build the HashiCorp Vault Integration OSGI bundle using `mvn clean install` command and copy
   the `target/org.wso2.carbon.securevault.hashicorp-1.0.jar` file to the `<API-M_HOME>/repository/components/dropin/`
   directory.

3. Add **HashiCorp Vault Java Driver** (e.g., `vault-java-driver-5.1.0.jar`) to the
   `<API-M_HOME>/repository/components/lib/` directory.

4. Create the `/repository/conf/security/secret-conf.properties` file and set the following configurations.

    ```properties
    keystore.identity.location=repository/resources/security/wso2carbon.jks
    keystore.identity.type=JKS
    keystore.identity.store.password=identity.store.password
    keystore.identity.store.secretProvider=org.wso2.carbon.securevault.DefaultSecretCallbackHandler
    keystore.identity.key.password=identity.key.password
    keystore.identity.key.secretProvider=org.wso2.carbon.securevault.DefaultSecretCallbackHandler
    carbon.secretProvider=org.wso2.securevault.secret.handler.SecretManagerSecretCallbackHandler

    secVault.enabled=true
    secretRepositories=vault
    secretRepositories.vault.provider=org.wso2.carbon.securevault.hashicorp.repository.HashiCorpSecretRepositoryProvider
    secretRepositories.vault.properties.address=https://127.0.0.1:8200
    secretRepositories.vault.properties.namespace=ns1
    secretRepositories.vault.properties.enginePath=wso2apim
    secretRepositories.vault.properties.engineVersion=2
    secretRepositories.vault.properties.authType=ROOT_TOKEN
    ```

    !!! note
        In production, you should always use the vault address with TLS enabled.

5. Add the following lines to the `<API-M_HOME>/repository/conf/log4j2.properties` file.

    ```properties
    logger.org-wso2-carbon-securevault-hashicorp.name=org.wso2.carbon.securevault.hashicorp
    logger.org-wso2-carbon-securevault-hashicorp.level=INFO
    logger.org-wso2-carbon-securevault-hashicorp.additivity=false
    logger.org-wso2-carbon-securevault-hashicorp.appenderRefCARBON_CONSOLE.ref = CARBON_CONSOLE
    ```

6. Then append `org-wso2-carbon-securevault-hashicorp` to the `loggers` list in the same file as follows.

    ```properties
    loggers = AUDIT_LOG, trace-messages, ..., org-wso2-carbon-securevault-hashicorp
    ```

### Step 3 - Update passwords with their aliases

1. Open the `deployment.toml` file in the `<API-M_HOME>/repository/conf/` directory and add
   the `[secrets]` configuration section **at the bottom of the file** as shown below.
   Give an alias for the passwords and put the value as blank (`""`).

    ```toml
    [secrets]
    admin_password = ""
    ```

2. Add the encrypted password alias to the relevant sections in the `deployment.toml`
   file by using a placeholder: `$secret{alias}`. For example:

    ```toml
    [super_admin]
    username="admin"
    password="$secret{admin_password}"
    ```

### Step 4 - Start the server

1. Provide the `VAULT_TOKEN` to the prompted message in the console or by creating a new file in the `<API-M_HOME>` 
   directory. The file should be named according to your Operating System.

    === "Linux"
        The file name should be `hashicorpRootToken-tmp`.

      
    === "Windows"
        The file name should be `hashicorpRootToken-tmp.txt`.


    !!! note
        When you add `tmp` to the file name, note that this will automatically get deleted from the file system after the server starts. Alternatively, if you want to retain the password file after the server starts, the file should be named as follows:

        === "Linux"
            The file name should be `hashicorpRootToken-persist`.
        
        === "Windows"
            The file name should be `hashicorpRootToken-persist.txt`.



2. Start the WSO2 API Manager Server and enter the keystore password at startup when prompted:

    ><pre>[Enter KeyStore and Private Key Password :] wso2carbon</pre>


## Setting up using App-Role authentication

This method uses dynamic authentication based on role IDs and secret IDs, allowing for secure, scoped access to Vault without the need for storing static tokens.

### Step 1 - Setup HashiCorp Vault

1. Start the HashiCorp Vault server and set the environment variables.

    ><pre>export VAULT_ADDR='https://127.0.0.1:8200'
    export VAULT_TOKEN='xxxxxxxxxxxxxx'</pre>

2. Include the policy in the `kv-read-write.hcl` file as below.

    ```hcl
    path "wso2apim/data/*" {
        capabilities = ["create", "read", "update", "delete", "list"]
    }
    ```

3. Upload the kv policy using the command below.

    ><pre>vault policy write kv-read-write kv-read-write.hcl</pre>

4. The following commands can be used to create the AppRole using the created policy.

    ><pre>vault auth enable approle</pre>
    ><pre>vault write auth/approle/role/my-role \
        token_policies="kv-read-write" \
        token_type="service" \
        token_ttl="24h" \
        token_max_ttl="72h"
    </pre>

5. Get the role-id as below.

    ><pre>vault read auth/approle/role/my-role/role-id</pre>

6. Get the secret-id as below.

    ><pre>vault write -f auth/approle/role/my-role/secret-id</pre>

7. Create the kv engine with a path name (e.g., `wso2apim`).

    The following commands can be used to add secrets with the HashiCorp Vault.

    ```shell
    # Create a new kv engine
    vault secrets enable -path=wso2apim -version=2 kv

    # Add new secret
    vault kv put wso2apim/admin_password value=admin

    # Get a secret (To check)
    vault kv get -field=value wso2apim/admin_password
    ```

### Step 2 - Configure HashiCorp Vault extension

1. Clone [HashiCorp Vault extension](https://github.com/wso2-extensions/carbon-securevault-hashicorp/tree/master) repo.

2. Build the HashiCorp Vault Integration OSGI bundle using `mvn clean install` command and copy the `target/org.wso2.carbon.securevault.hashicorp-1.0.jar` file to the `<API-M_HOME>/repository/components/dropin/`
   directory.

3. Add **HashiCorp Vault Java Driver** (e.g., `vault-java-driver-5.1.0.jar`) to the
   `<API-M_HOME>/repository/components/lib/` directory.

4. Create the `/repository/conf/security/secret-conf.properties` file and set the following configurations.

    ```properties
    keystore.identity.location=repository/resources/security/wso2carbon.jks
    keystore.identity.type=JKS
    keystore.identity.store.password=identity.store.password
    keystore.identity.store.secretProvider=org.wso2.carbon.securevault.DefaultSecretCallbackHandler
    keystore.identity.key.password=identity.key.password
    keystore.identity.key.secretProvider=org.wso2.carbon.securevault.DefaultSecretCallbackHandler
    carbon.secretProvider=org.wso2.securevault.secret.handler.SecretManagerSecretCallbackHandler

    secVault.enabled=true
    secretRepositories=vault
    secretRepositories.vault.provider=org.wso2.carbon.securevault.hashicorp.repository.HashiCorpSecretRepositoryProvider
    secretRepositories.vault.properties.address=https://127.0.0.1:8200
    secretRepositories.vault.properties.namespace=ns1
    secretRepositories.vault.properties.enginePath=wso2apim
    secretRepositories.vault.properties.engineVersion=2
    secretRepositories.vault.properties.authType=APP_ROLE
    secretRepositories.vault.properties.roleId=<role id>
    ```
    !!! note
        In production, you should always use the vault address with TLS enabled.

5. Add the following lines to the `<API-M_HOME>/repository/conf/log4j2.properties` file.

    ```properties
    logger.org-wso2-carbon-securevault-hashicorp.name=org.wso2.carbon.securevault.hashicorp
    logger.org-wso2-carbon-securevault-hashicorp.level=INFO
    logger.org-wso2-carbon-securevault-hashicorp.additivity=false
    logger.org-wso2-carbon-securevault-hashicorp.appenderRef.CARBON_CONSOLE.ref = CARBON_CONSOLE
    ```

    Then append `org-wso2-carbon-securevault-hashicorp` to the `loggers` list in the same file as follows.

    ```properties
    loggers = AUDIT_LOG, trace-messages, ..., org-wso2-carbon-securevault-hashicorp
    ```

### Step 3 - Update passwords with their aliases

1. Open the `deployment.toml` file in the `<API-M_HOME>/repository/conf/` directory and add
   the `[secrets]` configuration section **at the bottom of the file** as shown below.
   Give an alias for the passwords and put the value as blank (`""`).

    ```toml
    [secrets]
    admin_password = ""
    ```

2. Add the encrypted password alias to the relevant sections in the `deployment.toml`
   file by using a placeholder: `$secret{alias}`. For example:

    ```toml
    [super_admin]
    username="admin"
    password="$secret{admin_password}"
    ```

### Step 4 - Start the server


1. Provide the `Secret ID` to the prompted message in the console or by creating a new file in the `<API-M_HOME>` 
   directory. The file should be named according to your Operating System.

    === "Linux"
        The file name should be `hashicorpSecretId-tmp`.
        
      
    === "Windows"
        The file name should be `hashicorpSecretId-tmp.txt`.
        
        
!!! note
    When you add `tmp` to the file name, note that this will automatically get deleted from the file system after the server starts. Alternatively, if you want to retain the password file after the server starts, the file should be named as follows.


    === "Linux"
        The file name should be `hashicorpSecretId-persist`.
        
        
    === "Windows"
        The file name should be `hashicorpSecretId-persist.txt`.



2. Start the WSO2 API Manager Server and enter the keystore password at startup when prompted.

    ><pre>[Enter KeyStore and Private Key Password :] wso2carbon  </pre>
    
    

