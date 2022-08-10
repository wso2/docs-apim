# Upgrading API Manager from 4.0.0 to 4.1.0

The following information describes how to upgrade your WSO2 API Manager server **from API Manager 4.0.0 to 4.1.0**.

## Prerequisites

1. Review what has been changed in this release. See [What Has Changed]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/400-to-410/what-has-changed).

2. Before you migrate, follow the [Upgrading Guidelines]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-guidelines) to get an understanding of the migration process.

3. Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and unzip it in the <API-M_4.1.0_HOME> directory.

4. Update API-M 4.1.0 to the latest U2 update level.

## Steps to migrate to WSO2 API-M 4.1.0

Follow step 1 to step 6 below to upgrade your WSO2 API Manager server.

-   [Step 1 - Migrate the API Manager configurations to API-M 4.1.0](#step-1-migrate-the-api-manager-configurations)    
    
-   [Step 2 - Migrate the API Manager resources to API-M 4.1.0](#step-2-migrate-the-api-manager-resources)
    
-   [Step 3 - Migrate the API Manager components to API-M 4.1.0](#step-3-migrate-the-api-manager-components)
    
-   [Step 4 - Re-Index the API Manager artifacts](#step-4-re-index-the-api-manager-artifacts)

-   [Step 5 - Restart WSO2 API-M 4.1.0 server](#step-5-restart-the-api-manager-server)

### Step 1: Migrate the API Manager configurations 

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1. Open the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file and configure the datasource configurations for the available databases in the API-M 4.0.0 API-M set up to migrate them to API-M-4.1.0

    -   API Manager database (WSO2AM_DB)

        E.g., 
        
        ```
        [database.apim_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/am_db"
        username = "username"
        password = "password"
        ```

    -   Shared database(s) (WSO2_SHARED_DB)
        
        E.g.,
        
        ```
        [database.shared_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/shared_db"
        username = "username"
        password = "password"
        ```

        -  Registry database
            
            E.g.,
            
            ```
            [database.shared_db]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/reg_db"
            username = "username"
            password = "password"
            ```
            
            - Config DB  (WSO2CONFIG_DB)
                
                E.g.,

                ```
                [database.config]
                type = "mysql"
                url = "jdbc:mysql://localhost:3306/config_db"
                username = "username"
                password = "password"
                ```

        - User Stores (WSO2UM_DB) 
        
            E.g.,
            
            ```
            [database.user]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/um_db"
            username = "username"
            password = "password"
            ```    

    !!! attention "If you are using another DB type"
        If you are using a DB type other than **H2**, **MySQL**, or **Oracle**, you need to add the `driver` and `validationQuery` parameter configuration additionally as given below.

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

2. If you have used a separate DB for user management, you need to update the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the correct database for user management purposes.

    ```
    [realm_manager]
    data_source = "WSO2USER_DB"
    ```

3. If you are using WSO2 IS 5.11.0 as the Resident Key Manager in your API-M 4.0.0 deployment, add the follow configuration to the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.

    ```
    [apim.key_manager]
    service_url = "https://<IS_5.11.0_HOST_NAME>:<PORT>/services/"
    type = "WSO2-IS"
    ``` 

4. If you have configured the encryption key for [SymmetricKeyInternalCryptoProvider](https://is.docs.wso2.com/en/5.11.0/administer/symmetric-overview/) in API-M 4.0.0 `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file, add the same configuration into `<API-M_4.1.0_HOME>/repository/conf/deployment.toml`
       
       ```
       [encryption]
       key = "<provide-your-key-here>"

       ```

5. If you have enabled any other feature related configurations at `<API-M_4.0.0_HOME>/repository/conf/deployment.toml`, make sure to add them in to `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.

### Step 2: Migrate the API Manager resources

Follow the instructions below to migrate existing API Manager resources from the current environment to API Manager 4.1.0.

1.  Copy the relevant JDBC driver to the `<API-M_4.1.0_HOME>/repository/components/lib` folder.

2.  If you manually added any custom OSGi bundles to the `<API-M_4.0.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_4.1.0_HOME>/repository/components/dropins` directory. 

3.  If you manually added any JAR files to the `<API-M_4.0.0_HOME>/repository/components/lib` directory, copy those and paste them into the `<API-M_4.1.0_HOME>/repository/components/lib` directory.

4.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks`, and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_4.1.0_HOME>/repository/resources/security` directory to persist the information about the added private keys, certificates, and the list of trusted CA that have been used in API Manager 4.0.0. If you wish to add WSO2 IS 5.11.0 as the Resident Key Manager in API-M 4.1.0 new deployment, you have to copy the same keystores in to `<IS_5.11.0_HOME>/repository/resources/security` directory.

    !!! note "If you have enabled Secure Vault"

        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below. Refer to [Encrypting Passwords in Configuration files]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords) for more details.

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

5. If you already have used secondary user stores in API-M 4.0.0, you have to copy the user store file created inside the old API-M version to the new APIM version. 

    - For secondary user stores created for the super tenant, you have to copy the `<API-M_4.0.0_HOME>/repository/deployment/server/userstores/` directory inside `<API-M_4.1.0_HOME>/repository/deployment/server/` directory. 
    
    - For secondary user stores created for tenants, you have to copy the userstores to respective tenant directories after executing [step 4](#step-4-migrate-the-api-manager-components) as the tenant directories (`<API-M_4.1.0_HOME>/repository/tenants/`) at API-M 4.1.0 are populated after migrating the API Manager components. 

If you wish to configure WSO2 IS 5.11.0 as the Resident Key Manager in API-M 4.1.0 new deployment, aforementioned secondary user stores needs to be stored in to same path in IS.

### Step 3: Migrate the API Manager Components

You have to follow the below instructions to upgrade the API Manager components.

1. Make sure you backed up all the databases in API-M 4.0.0

2. Download and extract the [migration-resources.zip]({{base_path}}/assets/attachments/install-and-setup/migration/migration-resources.zip). Copy the extracted migration-resources to the `<API-M_4.1.0_HOME>` folder.

3. Copy the [org.wso2.carbon.apimgt.migrate.client-4.1.0.x.jar]({{base_path}}/assets/attachments/install-and-setup/migration/org.wso2.carbon.apimgt.migrate.client-4.1.0.31.jar) file into the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

    !!! note "If you have configured WSO2 IS 5.11.0 as Resident Key Manager"
        Make sure you have already started the WSO2 Identity Server instance before executing the next step.

4. Prior to API-M migration, run the below command to execute the pre-migration step that will validate your old data.

    - Available validators: `apiAvailabilityValidation`, `apiDefinitionValidation`

    In this step, you can run data validation on all the existing validators or selected validators. If you only use the `-DrunPreMigration` command, all existing validations will 
    be enabled. If not, you can provide a specific validator, such as  `-DrunPreMigration=apiDefinitionValidation`, which only validates the API definitions.

    ``` tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -DmigrateFromVersion=4.0.0 -DmigratedVersion=4.1.0 -DrunPreMigration
    ```

    ``` tab="Windows"
    api-manager.bat -Dmigrate -DmigrateFromVersion='4.0.0' -DmigratedVersion='4.1.0' 
    -DrunPreMigration
    ```

    !!! note "If you want to save the invalid api definitions"
        You can save the invalid api definitions to the local file system during this data validation step if required. Use the `-DsaveInvalidDefinition` option for this as follows. The invalid definitions will be stored under a folder named `<API-M_4.1.0_HOME>/invalid-swagger-definitions` in the form of `<API_UUID>.json`. Then you can manually correct these definitions.

        ```tab="Linux / Mac OS"
        sh api-manager.sh -Dmigrate -DmigrateFromVersion=4.0.0 -DmigratedVersion=4.1.0 -DrunPreMigration -DsaveInvalidDefinition
        ```

        ``` tab="Windows"
        api-manager.bat -Dmigrate -DmigrateFromVersion='4.0.0' -DmigratedVersion='4.1.0' -DrunPreMigration -DsaveInvalidDefinition
        ```
    
    Check the server logs and verify if there are any errors logs. If you have encountered any errors in the API definitions, you have to correct them manually on an old version before the component migration. 

5.  Start the API Manager server to migrate the API Manager components as follows.

    ``` tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -DmigrateFromVersion=4.0.0 -DmigratedVersion=4.1.0
    ```
    
    ``` tab="Windows"
    api-manager.bat -Dmigrate -DmigrateFromVersion=4.0.0 -DmigratedVersion=4.1.0
    ```

6.  Shut down the API Manager server.
    
    -   Remove the `org.wso2.carbon.apimgt.migrate.client-4.1.0.x.jar` file, which is in the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

    -   Remove the `migration-resources` directory, which is in the `<API-M_4.1.0_HOME>` directory.

    !!! note

        Make sure you have copied the tenant's userstores if you have configured them in WSO2 API Manager 4.0.0.

### Step 4: Re-index the API Manager artifacts

1. To re-index the API artifacts in the registry, add the following configuration into the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.
        
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
        If you use a clustered/distributed API Manager setup, do the above change in the deployment.toml file of the Publisher and Developer Portal nodes. Make sure to keep a delay between nodes to execute this step to re-index each node, as the database can experience a large load.

    !!! note

        Note that it takes a considerable amount of time for the API Manager to re-index the artifacts, depending on the API and the number of tenants.

### Step 5 - Restart the API Manager server

1. Restart the server.

    ```tab="Linux / Mac OS"
        sh api-manager.sh
    ```

    ```tab="Windows"
        api-manager.bat
    ```

This concludes the upgrade process.

