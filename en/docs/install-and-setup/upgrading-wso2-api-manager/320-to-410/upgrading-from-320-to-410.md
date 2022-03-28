# Upgrading API Manager from 3.2.0 to 4.1.0

!!! warning
    **The contents on this page are currently under review!**

The following information describes how to upgrade your API Manager server **from APIM 3.2.0 to 4.1.0**.

## Prerequisites
1. Review what has been changed in this release. see [What Has Changed]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/320-to-410/what-has-changed.md)

2. Before you migrate, follow [Upgrading Guidelines]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-guidelines) to get an understanding on the migration process.

3. Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and unzip it in the <API-M_4.1.0_HOME> directory.
    
Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 3.2.0 to 4.1.0**.

## Steps to migrate to WSO2 API-M 4.1.0
-   [Step 1 - Migrate the API Manager configurations to API-M 4.1.0](#step-1-migrate-the-api-manager-configurations)    
    
-   [Step 2 - Migrate the API Manager resources to API-M 4.1.0](#step-2-migrate-the-api-manager-resources)
    
-   [Step 3 - Migrate the database to API-M 4.1.0](#step-3-migrate-the-api-manager-database)

-   [Step 4 - Migrate the Identity Components](#step-4-migrate-the-identity-component)
    
-   [Step 5 - Migrate the API Manager components to API-M 4.1.0](#step-5-migrate-the-api-manager-components)
    
-   [Step 6 - Execute post migration scripts](#step-6-execute-post-migration-scripts)
    
-   [Step 7 - Re-Index the API artifacts](#step-7-re-Index-the-api-artifacts)

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files may have changed. Instead, redo the configuration changes in the new configuration files.

1. Open the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file and configure the datasource configurations for the available databases in the API-M 3.2.0 API-M set up to migrate them to API-M-4.1.0

    1.  API Manager database (WSO2AM_DB)

        Ex: 
        ```
        [database.apim_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/am_db"
        username = "username"
        password = "password"
        ```

    2.   Shared database/s (WSO2_SHARED_DB)
        
        Ex:
        ```
        [database.shared_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/shared_db"
        username = "username"
        password = "password"
        ```

        1. Registry database(WSO2REG_DB)
            
            Ex:
            ```
            [database.shared_db]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/reg_db"
            username = "username"
            password = "password"
            ```
            
            - Config DB  (WSO2CONFIG_DB)
                
                Ex:

                ```
                [database.config]
                type = "mysql"
                url = "jdbc:mysql://localhost:3306/config_db"
                username = "username"
                password = "password"
                ```


        2. User Stores (WSO2UM_DB) 
        
        Ex:
        ```
        [database.user]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/um_db"
        username = "username"
        password = "password"
        ```    

    !!! attention "If you are using another DB type"
        If you are using DB type other than **H2** or **MySQL** or **Oracle**, you need to add the `driver` and `validationQuery` parameter configuration additionally as given below.

        ```tab="MSSQL"
        [database.apim_db]
        type = "mssql"
        url = "jdbc:sqlserver://localhost:1433;databaseName=mig_am_db;SendStringParametersAsUnicode=false"
        username = "username"
        password = "password"
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
        validationQuery = "SELECT 1"
        ```

        ```tab="PostgreSQL"
        [database.apim_db]
        type = "postgre"
        url = "jdbc:postgresql://localhost:5432/mig_am_db"
        username = "username"
        password = "password"
        driver = "org.postgresql.Driver"
        validationQuery = "SELECT 1"
        ```

        ```tab="Oracle"
        [database.apim_db]
        type = "oracle"
        url = "jdbc:oracle:thin:@localhost:1521/mig_am_db"
        username = "username"
        password = "password"
        driver = "oracle.jdbc.driver.OracleDriver"
        validationQuery = "SELECT 1 FROM DUAL"
        ```    

2.   If you have used separate DB for user management, you need to update `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the correct database for user management purposes.

    ```
    [realm_manager]
    data_source = "WSO2USER_DB"
    ```

3. Modify the `[apim.gateway.environment]` tag in the `<API-M_HOME>/repository/conf/deployment.toml` file, the name should change to "Production and Sandbox". By default, it is set as `Default` in API Manager 4.1.0.
    
    ```toml
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    ```

    !!! Info
        If you have changed the name of the gateway environment in your older version, then when migrating, make sure
        that you change the `[apim.gateway.environment]` tag accordingly. For example, if your gateway environment was named `Test` in the `<OLD_API-M_HOME>/repository/conf/api-manager.xml` file, you have to change the toml config as shown below.

        ```toml
        [[apim.gateway.environment]]
        name = "Test"
        ``` 

4. Configure the [SymmetricKeyInternalCryptoProvider](https://is.docs.wso2.com/en/5.11.0/administer/symmetric-overview/) as the default internal cryptor provider as the WSO2 Identity Server 5.11.0 onwards, symmetric encryption will be used by default.

    Generate your own secret key using a tool like OpenSSL.
    
    i.e.,
       ```
        openssl enc -nosalt -aes-128-cbc -k hello-world -P
       ```        
    Add the configuration to the <NEW_APIM_HOME>/repository/conf/deployment.toml file.
    
       ```
       [encryption]
       key = "<provide-your-key-here>"

       ``` 

5. If you have enabled any other feature related configurations at `<API-M_4.1.0_HOME>/repository/conf/deployment.toml`, make sure to add them in to `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.

### Step 2: Migrate the API Manager Resources

Follow the instructions below to migrate existing API Manager resources from the current environment to API-M 4.1.0.

1.  Copy the relevant JDBC driver to the `<API-M_4.1.0_HOME>/repository/components/lib` folder.

2.  If you manually added any custom OSGI bundles to the `<API-M_3.2.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_4.1.0_HOME>/repository/components/dropins` directory. 

3.  If you manually added any JAR files to the `<API-M_3.2.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_4.1.0_HOME>/repository/components/lib` directory.

4.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_4.1.0_HOME>/repository/resources/security` directory to persist 
the information about the added private keys, certificates and the list of trusted CA that have been used in API-M_3.2.0.

    !!! note "If you have enabled Secure Vault"

        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below. Refer [Encrypting Passwords in Configuration files]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords) for more details.

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

5. If you already have used secondary user stores in API-M 3.2.0, you have to copy the user store file created inside the old API-M version to the new APIM version. 

    For secondary user stores created for the super tenant, 
    
    You have to copy the `<API-M_3.2.0_HOME>/repository/deployment/server/userstores/` directory inside `<API-M_4.1.0_HOME>/repository/deployment/server/` directory. 
    
    For secondary user stores created for tenants, 
    
    You have to copy the userstores to respective tenant directories after executing [step 4](#step-4-migrate-the-api-manager-components) as the tenant directories (`<API-M_3.2.0_HOME>/repository/tenants/`) at API-M 4.1.0 are populated after migrating the api-m components. 

### Step 3: Migrate the API Manager Database 

1.  Make sure you backed up all the databases in APIM 3.2.0

    !!! note "If you are using PostgreSQL"
        The database user should have the 'Superuser' permission to migrate the API Manager Databases. If the user is not already a superuser, assign the permission before starting the migration.

        ```
        ALTER USER <user> WITH SUPERUSER;
        ```

2.  Navigate to the [latest release tag (v4.1.0.x)](https://github.com/wso2-extensions/apim-migration-resources/tags) and download the `wso2am-migration-4.1.0.x.zip`. Unzip it to a local directory.  

    !!! note

        x of wso2am-migration-4.1.0.x.zip denotes the version number of the most recently-released migration resources.

        The directory where the wso2am-migration-4.1.0.x.zip is unziped will be referred to as `<AM_MIGRATION_CLIENT_HOME>`


3. Execute the script on the `WSO2AM_DB` database which is presented inside the `<AM_MIGRATION_CLIENT_HOME>/migration-script-3.2.0_to_4.1.0` directory for relevant database type. 

### Step 4: Migrate the Identity Components

Follow the instruction below to upgrade the Identity component in WSO2 API Manager from version 5.10.0 to 5.11.0.

1.  Download the identity component migration resources and unzip it in a local directory.

    Navigate to the [latest release tag](https://github.com/wso2-extensions/apim-identity-migration-resources/tags) and download the `wso2is-migration-x.x.x.zip` under Assets.
         
    Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`. 

2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_4.1.0_HOME>` directory.

3.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.10.0, as shown below.

    ``` java
    migrationEnable: "true"
    currentVersion: "5.10.0"
    migrateVersion: "5.11.0"
    ```

    !!! note
        Make sure you have enabled migration by setting the `migrationEnable` element to `true` as shown above. You have to remove the following 3 steps from  migration-config.yaml which is included under version: "5.10.0"
            ```
                -
                    name: "MigrationValidator"
                    order: 2
                -
                    name: "SchemaMigrator"
                    order: 5
                    parameters:
                    location: "step2"
                    schema: "identity"            
                -
                    name: "TenantPortalMigrator"
                    order: 11
            ```

4.  Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

5. Update <API-M_4.1.0_HOME>/repository/conf/deployment.toml file as follows, to point to the previous user store.
    
    !!! note
        This step is only required if the user store type in previous version is set to "database" instead of default "database_unique_id".
        
    ```
        [user_store]
        type = "database"
    ```

6.  Start WSO2 API Manager 4.1.0 as follows to carry out the complete Identity component migration.
        
    !!! note
        If you are migrating your user stores to the new user store managers with the unique ID capabilities, Follow the guidelines given in the [Migrating User Store Managers](https://is.docs.wso2.com/en/latest/setup/migrating-userstore-managers/) before moving to the next step
                    
    ```tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -Dcomponent=identity
    ```

    ```tab="Windows"
    api-manager.bat -Dmigrate -Dcomponent=identity
    ```

    !!! note
        Note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and wait until the migration process finish completely and server get started.
        
    !!! note
        Note that if you want to use the latest user store, update the <API-M_4.1.0_HOME>/repository/conf/deployment.toml as follows after the identity migration,

    ```
    [user_store]
    type = "database_unique_id"
    ``` 

    !!! warning "Troubleshooting"
        When running the above step if you encounter the following error message, follow the steps in this section. Note that this error could occur only if the identity tables contain a huge volume of data.

    Sample exception stack trace is given below.
        ```
        ERROR {org.wso2.carbon.registry.core.dataaccess.TransactionManager} -  Failed to start new registry transaction. {org.wso2.carbon.registry.core.dataaccess.TransactionManager} org.apache.tomcat.jdbc.pool.PoolExhaustedException: [pool-30-thread-11] Timeout: Pool empty. Unable to fetch a connection in 60 seconds, none available[size:50; busy:50; idle:0; lastwait:60000
        ```

    1.  Add the following property in `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` to a higher value (e.g., 10)
        ```
        [indexing]
        frequency= 10
        ```

    2.  Re-run the command above.
        **Make sure to revert the change done in Step 1 , after the migration is complete.**

7.  After you have successfully completed the migration, stop the server and remove the following files and folders.

    -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

    -   Remove the `migration-resources` directory, which is in the `<API-M_4.1.0_HOME>` directory.

    -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the api-manager.bat file.

    ```
    -Dmigrate -Dcomponent=identity
    ```

### Step 5: Migrate the API Manager Components

You have to run the following migration client to update the API Manager artifacts.

1. Copy the `<AM_MIGRATION_CLIENT_HOME>/migration-resources` to the `<API-M_4.1.0_HOME>` directory.

2. Copy the org.wso2.carbon.am.migration-4.1.0.x.jar file in the `<AM_MIGRATION_CLIENT_HOME>/dropin` directory into the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

3. Start the API-M server to validate the api definitions.
       
    ``` tab="Linux / Mac OS"
    sh api-manager.sh -DmigrateFromVersion=3.2.0 -DrunPreMigrationStep=apiDefinitionValidation
    ```

    ``` tab="Windows"
    api-manager.bat -DmigrateFromVersion=3.2.0 -DrunPreMigrationStep=apiDefinitionValidation
    ```

    Check the server logs and verify are there any errors logs. If you have encounter any errors in  api definitions, you have to correct them manually on old version before the component migration. 

4.  Start the API-M server to migrate the api-m components as follows.

    ``` tab="Linux / Mac OS"
    sh api-manager.sh -DmigrateFromVersion=3.2.0
    ```
    
    ``` tab="Windows"
    api-manager.bat -DmigrateFromVersion=3.2.0
    ```

5.  Shutdown the API-M server.
    
    -   Remove the `org.wso2.carbon.apimgt.migrate.client-4.1.0.x.jar` file, which is in the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

    -   Remove the `migration-resources` directory, which is in the `<API-M_4.1.0_HOME>` directory.

    !!! note

        Make sure you have copied the tenants userstores if you have configured them in API-M 3.2.0


### Step 6: Execute post migration scripts

1. Execute the post migration script on the `WSO2AM_DB` database which is located inside the `<AM_MIGRATION_CLIENT_HOME>/post-migration-script` directory for relevant database type.

2. Execute the post migration script `reg-index.sql` on the `WSO2SHARED_DB` database (or REG_DB if you have separate DB for registry) which is located inside the `<AM_MIGRATION_CLIENT_HOME>/post-migration-script/reg-db` directory

    !!! note
        Note that depending on the number of records in the REG_LOG table, this script will take a considerable amount of time to finish. Do not stop the execution of the script until it is completed.

### Step 7: Re-Index the API Manager artifacts

1. To re-index the API artifacts in the registry, Add the following configuration into the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.
        
    ```
    [indexing]
    re_indexing = 1
    ```
        
    Note that you need to increase the value of `re_indexing` by one each time you need to re-index.

             
2. If the `<API-M_4.1.0_HOME>/solr` directory exists, take a backup and thereafter delete it. 

3. Restart the server.

    ```tab="Linux / Mac OS"
        sh api-manager.sh
    ```

    ```tab="Windows"
        api-manager.bat
    ```

    !!! important 
        If you use a clustered/distributed API Manager setup, do the above change in deployment.toml of Publisher and Devportal nodes. Make sure to keep a delay between nodes to execute this step to re-index each node, as the database can experience a large load.

    !!! note

        Note that it takes a considerable amount of time for the API Manager to re-index the artifacts, depending on the API and the number of tenants.

This concludes the upgrade process.