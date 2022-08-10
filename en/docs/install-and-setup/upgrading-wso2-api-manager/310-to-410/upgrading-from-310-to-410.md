# Upgrading API Manager from 3.1.0 to 4.1.0

The following information describes how to upgrade your API Manager server **from API-M 3.1.0 to 4.0.0**.

## Prerequisites

1. Review what has changed in this release. See [What Has Changed]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/310-to-410/what-has-changed).

2. Before you migrate, follow [Upgrading Guidelines]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-guidelines) to get an understanding on the migration process.

3. Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and unzip it in the <API-M_4.1.0_HOME> directory.

4. Update API-M 4.1.0 to the latest U2 update level.

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 3.1.0 to 4.0.0**.

- [Step 1 - Migrate the API Manager configurations](#step-1-migrate-the-api-manager-configurations)
- [Step 2 - Migrate the API Manager resources to API-M 4.1.0](#step-2-migrate-the-api-manager-resources)
- [Step 3 - Migrate the Identity Components](#step-3-migrate-the-identity-components)
- [Step 4 - Migrate the API Manager components to API-M 4.1.0](#step-4-migrate-the-api-manager-components)
- [Step 5 - Re-Index the API Manager artifacts](#step-5-re-index-the-api-manager-artifacts)
- [Step 6 - Restart the WSO2 API-M 4.1.0 server](#step-6-restart-the-wso2-api-m-410-server)

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files may have changed. Instead, redo the configuration changes in the new configuration files.

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and update to the latest U2 update level.

2.  Open the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file and provide the datasource configurations for the following databases.

    -   User Store
    -   Registry database/s
    -   API Manager databases

    !!! note
        If you have used separate DBs for user management and registry in the previous version, you need to configure WSO2REG_DB and WSO2UM_DB databases separately in API-M 4.1.0 to avoid any issues.

    SHARED_DB should point to the previous API-M version's `WSO2REG_DB`. This example shows how to configure MySQL database configurations.

    ```
    [database.apim_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/am_db"
    username = "username"
    password = "password"

    [database.shared_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/reg_db"
    username = "username"
    password = "password"
    ```

    Optionally add a new entry as below to the `deployment.toml` if you have configured a separate user management database in the previous API-M version.

    ```
    [database.user]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/um_db"
    username = "username"
    password = "password"
    ```

    !!! note
        If you have configured WSO2CONFIG_DB in the previous API-M version, add a new entry to the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` as below.

        ```
        [database.config]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/config_db"
        username = "username"
        password = "password"
        ```

    !!! attention "If you are using another DB type"
        If you are using another DB type other than **H2** or **MySQL** or **Oracle**, when defining the DB related configurations in the `deployment.toml` file, you need to add the `driver` and `validationQuery` parameters additionally as given below.

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

        ```tab="DB2"
        [database.apim_db]
        type = "db2"
        url = "jdbc:db2://localhost:50000/mig_am_db"
        username = "username"
        password = "password"
        driver = "com.ibm.db2.jcc.DB2Driver"
        validationQuery = "SELECT 1 FROM SYSIBM.SYSDUMMY1"
        ```
    !!! note
        It is not recommended to use default H2 databases other than `WSO2_MB_STORE_DB` in production. Therefore, migration of default H2 databases will not be supported since API-M 4.1.0.
        It is recommended to use the default H2 database for the `WSO2_MB_STORE_DB` database in API-Manager. So do **not** migrate `WSO2_MB_STORE_DB` database from API-M 3.1.0 version to API-M 4.1.0 version, and use the **default H2** `WSO2_MB_STORE_DB` database available in API-M 4.1.0 version.

3.   If you have used a separate DB for user management, you need to update `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the correct database for user management purposes.

    ```
    [realm_manager]
    data_source = "WSO2USER_DB"
    ```

4. Modify the `[apim.gateway.environment]` tag in the `<API-M_HOME>/repository/conf/deployment.toml` file, the name should change to "Production and Sandbox". By default, it is set as `Default` in API Manager 4.1.0.

    ```toml
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    ```
    Modify the `[apim.sync_runtime_artifacts.gateway]` tag in the `<API-M_HOME>/repository/conf/deployment.toml`, so that the value of `gateway_labels` should be the name of old gateway environment (old default one is "Production and Sandbox") or we need to add the old one as a new gateway environment, while the new current default label (current default one is "Default") remains as it is.

    ```toml
    [apim.sync_runtime_artifacts.gateway]
    gateway_labels = ["Production and Sandbox", "Default"]
    ```
    or
    ```toml
    [apim.sync_runtime_artifacts.gateway]
    gateway_labels = ["Production and Sandbox"]
    ```

    This config defines an array of the labels that the Gateway is going to subscribe to. Only the APIs with these labels will be pulled from the extension point and deployed.

    !!! info
        If you have changed the name of the gateway environment in your older version, then when migrating, make sure
        that you change the `[apim.gateway.environment]` tag  and `[apim.sync_runtime_artifacts.gateway]` tag  accordingly. For example, if your gateway environment was named `Test` in the `<OLD_API-M_HOME>/repository/conf/api-manager.xml` file, you have to change the toml config as shown below.
        
        ```toml
        [[apim.gateway.environment]]
        name = "Test"
        ``` 
        
        ```toml
        [apim.sync_runtime_artifacts.gateway]
        gateway_labels = ["Test"]
        ```

5. Disable versioning in the registry configuration

    If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 4.1.0.

    Therefore, if registry versioning was enabled in WSO2 API-M 3.1.0 setup, it is **required** run the below scripts against **the database that is used by the registry**. Follow the below steps to achieve this.

    !!! note "NOTE"
        Alternatively, it is possible to turn on registry versioning in API Manager 4.1.0 and continue. But this is
        highly **NOT RECOMMENDED** and these configurations should only be changed once.

    !!! info "Verifying registry versioning turned on in your current API-M and running the scripts"
        Open the `registry.xml` file in the `<OLD_API-M_HOME>/repository/conf` directory.
        Check whether `versioningProperties`, `versioningComments`, `versioningTags` and `versioningRatings` configurations are true.

        ```
        <staticConfiguration>
            <versioningProperties>true</versioningProperties>
            <versioningComments>true</versioningComments>
            <versioningTags>true</versioningTags>
            <versioningRatings>true</versioningRatings>
        </staticConfiguration>
        ```
                    
        !!! warning
            If the above configurations are already set as `false` you should not run the below scripts.
            
            From API-M 3.1.0 version onwards, those configurations are set to false by-default and since these configurations are now getting changed from old setup to new setup, you need to remove the versioning details from the database in order for the registry resources to work properly. For that, choose the relevant DB type and run the script against the DB that the registry resides in, to remove the registry versioning details.   
            ??? info "DB Scripts"
                ```tab="DB2"
                -- Update the REG_PATH_ID column mapped with the REG_RESOURCE table --
        
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_TAG.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION)
                /
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_COMMENT.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION)
                /
        
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_PROPERTY.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION)
                /
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_RATING.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION)
                /
        
                -- Delete versioned tags, were the PATH_ID will be null for older versions --
        
                delete from REG_RESOURCE_PROPERTY where REG_PATH_ID is NULL
                /
                delete from REG_RESOURCE_RATING where REG_PATH_ID is NULL
                /
                delete from REG_RESOURCE_TAG where REG_PATH_ID is NULL
                /
                delete from REG_RESOURCE_COMMENT where REG_PATH_ID is NULL
                /
                delete from REG_PROPERTY where REG_ID NOT IN (select REG_PROPERTY_ID from REG_RESOURCE_PROPERTY)
                /
                delete from REG_TAG where REG_ID NOT IN (select REG_TAG_ID from REG_RESOURCE_TAG)
                /
                delete from REG_COMMENT where REG_ID NOT IN (select REG_COMMENT_ID from REG_RESOURCE_COMMENT)
                /
                delete from REG_RATING where REG_ID NOT IN (select REG_RATING_ID from REG_RESOURCE_RATING)
                /
        
                -- Update the REG_PATH_NAME column mapped with the REG_RESOURCE table --
        
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_TAG.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION)
                /
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_PROPERTY.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION)
                /
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_COMMENT.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION)
                /
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_RATING.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION)
                /
        
                ```
            
                ```tab="MSSQL"
                -- Update the REG_PATH_ID column mapped with the REG_RESOURCE table --
                UPDATE REG_RESOURCE_TAG SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION);
                
                UPDATE REG_RESOURCE_COMMENT SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION);
                
                UPDATE REG_RESOURCE_PROPERTY SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION);
                
                UPDATE REG_RESOURCE_RATING SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION);
                
                -- Delete versioned tags, were the PATH_ID will be null for older versions --
                delete from REG_RESOURCE_PROPERTY where REG_PATH_ID is NULL;
                
                delete from REG_RESOURCE_RATING where REG_PATH_ID is NULL;
                
                delete from REG_RESOURCE_TAG where REG_PATH_ID is NULL;
                
                delete from REG_RESOURCE_COMMENT where REG_PATH_ID is NULL;
                
                delete from REG_PROPERTY where REG_ID NOT IN (select REG_PROPERTY_ID from REG_RESOURCE_PROPERTY);
                
                delete from REG_TAG where REG_ID NOT IN (select REG_TAG_ID from REG_RESOURCE_TAG);
                
                delete from REG_COMMENT where REG_ID NOT IN (select REG_COMMENT_ID from REG_RESOURCE_COMMENT);
                
                delete from REG_RATING where REG_ID NOT IN (select REG_RATING_ID from REG_RESOURCE_RATING);
                
                -- Update the REG_PATH_NAME column mapped with the REG_RESOURCE table --
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION);
                
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION);
                
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION);
                
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION);  
                ```
        
                ```tab="MySQL"
                -- Update the REG_PATH_ID column mapped with the REG_RESOURCE table --
        
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_TAG.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION);
        
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_COMMENT.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION);
        
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_PROPERTY.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION);
        
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_RATING.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION);
        
        
                -- Delete versioned tags, were the PATH_ID will be null for older versions --
        
                delete from REG_RESOURCE_PROPERTY where REG_PATH_ID is NULL;
        
                delete from REG_RESOURCE_RATING where REG_PATH_ID is NULL;
        
                delete from REG_RESOURCE_TAG where REG_PATH_ID is NULL;
        
                delete from REG_RESOURCE_COMMENT where REG_PATH_ID is NULL;
        
                delete from REG_PROPERTY where REG_ID NOT IN (select REG_PROPERTY_ID from REG_RESOURCE_PROPERTY);
        
                delete from REG_TAG where REG_ID NOT IN (select REG_TAG_ID from REG_RESOURCE_TAG);
        
                delete from REG_COMMENT where REG_ID NOT IN (select REG_COMMENT_ID from REG_RESOURCE_COMMENT);
        
                delete from REG_RATING where REG_ID NOT IN (select REG_RATING_ID from REG_RESOURCE_RATING);
        
                -- Update the REG_PATH_NAME column mapped with the REG_RESOURCE table --
        
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_TAG.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION);
        
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_PROPERTY.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION);
        
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_COMMENT.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION);
        
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_RATING.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION);
                ```
            
                ```tab="Oracle"
                -- Update the REG_PATH_ID column mapped with the REG_RESOURCE table --
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_TAG.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION)
                /
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_COMMENT.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION)
                /
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_PROPERTY.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION)
                /
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_RATING.REG_PATH_ID=(SELECT REG_RESOURCE.REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION)
                /
                
                -- Delete versioned tags, were the PATH_ID will be null for older versions --
                delete from REG_RESOURCE_PROPERTY where REG_PATH_ID is NULL
                /
                delete from REG_RESOURCE_RATING where REG_PATH_ID is NULL
                /
                delete from REG_RESOURCE_TAG where REG_PATH_ID is NULL
                /
                delete from REG_RESOURCE_COMMENT where REG_PATH_ID is NULL
                /
                delete from REG_PROPERTY where REG_ID NOT IN (select REG_PROPERTY_ID from REG_RESOURCE_PROPERTY)
                /
                delete from REG_TAG where REG_ID NOT IN (select REG_TAG_ID from REG_RESOURCE_TAG)
                /
                delete from REG_COMMENT where REG_ID NOT IN (select REG_COMMENT_ID from REG_RESOURCE_COMMENT)
                /
                delete from REG_RATING where REG_ID NOT IN (select REG_RATING_ID from REG_RESOURCE_RATING)
                /
                
                -- Update the REG_PATH_NAME column mapped with the REG_RESOURCE table --
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_TAG.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION)
                /
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_PROPERTY.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION)
                /
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_COMMENT.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION)
                /
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_RATING.REG_RESOURCE_NAME=(SELECT REG_RESOURCE.REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION)
                /
                COMMIT;
                /    
                ```
                
                ```tab="PostgreSQL"
                -- Update the REG_PATH_ID column mapped with the REG_RESOURCE table --
                UPDATE REG_RESOURCE_TAG SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION);
                
                UPDATE REG_RESOURCE_COMMENT SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION);
                
                UPDATE REG_RESOURCE_PROPERTY SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION);
                
                UPDATE REG_RESOURCE_RATING SET REG_PATH_ID=(SELECT REG_PATH_ID FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION);
                
                -- Delete versioned tags, were the PATH_ID will be null for older versions --
                delete from REG_RESOURCE_PROPERTY where REG_PATH_ID is NULL;
                
                delete from REG_RESOURCE_RATING where REG_PATH_ID is NULL;
                
                delete from REG_RESOURCE_TAG where REG_PATH_ID is NULL;
                
                delete from REG_RESOURCE_COMMENT where REG_PATH_ID is NULL;
                
                delete from REG_PROPERTY where REG_ID NOT IN (select REG_PROPERTY_ID from REG_RESOURCE_PROPERTY);
                
                delete from REG_TAG where REG_ID NOT IN (select REG_TAG_ID from REG_RESOURCE_TAG);
                
                delete from REG_COMMENT where REG_ID NOT IN (select REG_COMMENT_ID from REG_RESOURCE_COMMENT);
                
                delete from REG_RATING where REG_ID NOT IN (select REG_RATING_ID from REG_RESOURCE_RATING);
                
                -- Update the REG_PATH_NAME column mapped with the REG_RESOURCE table --
                UPDATE REG_RESOURCE_TAG SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_TAG.REG_VERSION);
                
                UPDATE REG_RESOURCE_PROPERTY SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_PROPERTY.REG_VERSION);
                
                UPDATE REG_RESOURCE_COMMENT SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_COMMENT.REG_VERSION);
                
                UPDATE REG_RESOURCE_RATING SET REG_RESOURCE_NAME=(SELECT REG_NAME FROM REG_RESOURCE WHERE REG_RESOURCE.REG_VERSION=REG_RESOURCE_RATING.REG_VERSION);
                ```

    !!! warning "Not recommended"
        If you decide to proceed with registry resource versioning enabled, Add the following configuration to the `<NEW_API-M_HOME>/repository/conf/deployment.toml` file of new WSO2 API Manager.
        
        ```
        [registry.static_configuration]
        enable=true
        ```
                
        !!! note "NOTE"
            Changing these configurations should only be done before the initial API-M Server startup. If changes are done after the initial startup, the registry resource created previously will not be available.

6.  If you have enabled any other feature related configurations at `<API-M_4.1.0_HOME>/repository/conf/deployment.toml`, make sure to add them in to `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.

### Step 2: Migrate the API Manager Resources

Follow the instructions below to migrate existing API Manager resources from the current environment to API-M 4.1.0.

1.  Copy the relevant JDBC driver to the `<API-M_4.1.0_HOME>/repository/components/lib` folder.

2.  If you manually added any custom OSGI bundles to the `<API-M_3.1.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

3.  If you manually added any JAR files to the `<API-M_3.1.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_4.1.0_HOME>/repository/components/lib` directory.

4. WSO2 API Manager 4.1.0 has been upgraded to log4j2 (from log4j). You will notice that there is a log4j2.properties file in the `<API-M_4.1.0_HOME>/repository/conf/` directory instead of the log4j.properties file. Follow [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to migrate your existing log4j.properties file to log4j2.properties file.

    !!! warning 
        Taking the log4j.properties file from your old WSO2 API-M Server and adding it to WSO2 API-M Server 4.1.0 will no longer work. Refer [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to see how to add a log appender or a logger to the log4j2.properties file.

    !!! note
        Log4j2 has hot deployment support, and **Managing Logs** section has been removed from the Management Console. You can now use the log4j2.properties file to modify logging configurations without restarting the server.

5.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_4.1.0_HOME>/repository/resources/security` directory. If you wish to add WSO2 IS 5.11.0 as the Resident Key Manager in API-M 4.1.0 new deployment, you have to copy the same keystores in to `<IS_5.11.0_HOME>/repository/resources/security` directory.

    !!! note "If you have enabled Secure Vault"
        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below. Refer [Encrypting Passwords in Configuration files]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords) for more details.

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

6. If you already have used secondary user stores in API-M 3.1.0, you have to copy the user store file created inside the old API-M version to the new API-M version.

   For secondary user stores created for the super tenant,

   You have to copy the `<API-M_3.1.0_HOME>/repository/deployment/server/userstores/` directory inside `<API-M_4.1.0_HOME>/repository/deployment/server/` directory.

   For secondary user stores created for tenants,

   You have to copy the userstores to respective tenant directories after executing [step 4](#step-4-migrate-the-api-manager-components) as the tenant directories (`<API-M_3.1.0_HOME>/repository/tenants/`) at API-M 4.1.0 are populated after migrating the api-m components.

### Step 3: Migrate the Identity Components

Follow the instruction below to upgrade the Identity component in WSO2 API Manager from version 5.9.0 to 5.11.0.

1.  Make sure you backed up all the databases in API-M 3.1.0

2.  Download the identity component migration resources and unzip it in a local directory.

    Navigate to the [latest release tag](https://github.com/wso2-extensions/apim-identity-migration-resources/releases) and download the `wso2is-migration-x.x.x.zip` under Assets.

    Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`.

3.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_4.1.0_HOME>` directory.

4.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.10.0, as shown below.

    ``` java
    migrationEnable: "true"
    currentVersion: "5.10.0"
    migrateVersion: "5.11.0"
    ```

5. Remove the following 3 steps from  migration-config.yaml which is included under version: "5.10.0"
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

6. Remove the following 3 steps from  migration-config.yaml which is included under version: "5.11.0"
    ```
    -
        name: "EncryptionAdminFlowMigrator"
        order: 1
        parameters:
            currentEncryptionAlgorithm: "RSA/ECB/OAEPwithSHA1andMGF1Padding"
            migratedEncryptionAlgorithm: "AES/GCM/NoPadding"
            schema: "identity"
    -
        name: "EncryptionUserFlowMigrator"
        order: 2
        parameters:
            currentEncryptionAlgorithm: "RSA/ECB/OAEPwithSHA1andMGF1Padding"
            migratedEncryptionAlgorithm: "AES/GCM/NoPadding"
            schema: "identity"
                       
    -   name: "SCIMGroupRoleMigrator"
        order: 18
    ```

7. Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

8. If the user store type in the previous version is set to "database" instead of default "database_unique_id", update `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the previous user store.

    ```
    [user_store]
    type = "database"
    ```
   
9. If you are migrating your user stores to the new user store managers with the unique ID capabilities, follow the guidelines given in the [Migrating User Store Managers documentation](https://is.docs.wso2.com/en/latest/setup/migrating-userstore-managers/) before moving to the next step.

10.  Start WSO2 API Manager 4.1.0 as follows to carry out the complete Identity component migration.

    ```tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -Dcomponent=identity
    ```

    ```tab="Windows"
    api-manager.bat -Dmigrate -Dcomponent=identity
    ```

    !!! note
        Note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and wait until the migration process finishes completely and the server gets started.
    
    !!! warning "Troubleshooting"
        When running the above step if you encounter the following error message, follow the steps in this section. Note that this error could occur only if the identity tables contain a huge volume of data.

        Sample exception stack trace is given below.
        ```
        ERROR {org.wso2.carbon.registry.core.dataaccess.TransactionManager} -  Failed to start new registry transaction. {org.wso2.carbon.registry.core.dataaccess.TransactionManager} org.apache.tomcat.jdbc.pool.PoolExhaustedException: [pool-30-thread-11] Timeout: Pool empty. Unable to fetch a connection in 60 seconds, none available[size:50; busy:50; idle:0; lastwait:60000
        ```

        1.  Add the following property in `<API-M_HOME>/repository/conf/deployment.toml` to a higher value (e.g., 10)
            ```
            [indexing]
            frequency= 10
            ```

        2.  Re-run the command above.

        **Make sure to revert the change done in Step 1 , after the migration is complete.**

11.  After you have successfully completed the migration, stop the server and remove the following files and folders.

    -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

    -   Remove the `migration-resources` directory, which is in the `<API-M_4.1.0_HOME>` directory.

    -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the api-manager.bat file.

        ```
        -Dmigrate -Dcomponent=identity
        ```

    -   If you followed step 8 above, and want to use the latest user store, update the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` as follows after the identity migration,

        ```
        [user_store]
        type = "database_unique_id"
        ``` 

### Step 4: Migrate the API Manager Components

You have to run the following migration client to update the API Manager artifacts.

1. Download and extract the [migration-resources.zip]({{base_path}}/assets/attachments/install-and-setup/migration/migration-resources.zip). Copy the extracted migration-resources to the `<API-M_4.1.0_HOME>` folder.

2. Copy the [org.wso2.carbon.apimgt.migrate.client-4.1.0.x.jar]({{base_path}}/assets/attachments/install-and-setup/migration/org.wso2.carbon.apimgt.migrate.client-4.1.0.31.jar) file into the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

3. Prior to API-M migration, run the below command to execute the pre-migration step that will validate your old data.

    - Available validators: `apiAvailabilityValidation`, `apiDefinitionValidation`

    In this step, you can run data validation on all the existing validators or selected validators. If you only use the `-DrunPreMigration` command, all existing validations will 
    be enabled. If not, you can provide a specific validator, such as  `-DrunPreMigration=apiDefinitionValidation`, which only validates the API definitions.

    ``` tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -DmigrateFromVersion=3.1.0 -DmigratedVersion=4.1.0 -DrunPreMigration
    ```

    ``` tab="Windows"
    api-manager.bat -Dmigrate -DmigrateFromVersion='3.1.0' -DmigratedVersion='4.1.0' 
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

    Check the server logs and verify if there are any errors logs. If you have encountered any errors in the API definitions, you have to correct them manually on the old version before proceeding to step 5.

4.  Start the API-M server to migrate the API-M components as follows.

    ``` tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -DmigrateFromVersion=3.1.0 -DmigratedVersion=4.1.0
    ```

    ``` tab="Windows"
    api-manager.bat -Dmigrate -DmigrateFromVersion=3.1.0 -DmigratedVersion=4.1.0
    ```

5.  Shutdown the API-M server.

    -   Remove the `org.wso2.carbon.apimgt.migrate.client-4.1.0.x.jar` file, which is in the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

    -   Remove the `migration-resources` directory, which is in the `<API-M_4.1.0_HOME>` directory.

### Step 5: Re-Index the API Manager artifacts

1. To re-index the API artifacts in the registry, Add the following configuration into the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.

    ```
    [indexing]
    re_indexing = 1
    ```

    Note that you need to increase the value of `re_indexing` by one each time you need to re-index.


2. If the `<API-M_4.1.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

    !!! important
        If you use a clustered/distributed API Manager setup, do the above change in `deployment.toml` of Publisher and Devportal nodes. Make sure to keep a delay between nodes to execute this step to re-index each node, as the database can experience a large load.

    !!! note
        Note that it takes a considerable amount of time for the API Manager to re-index the artifacts, depending on the API count and the number of tenants.

### Step 6 - Restart the WSO2 API-M 4.1.0 Server

1.  Restart the WSO2 API-M server.

    ```tab="Linux / Mac OS"
    sh api-manager.sh
    ```

    ```tab="Windows"
    api-manager.bat
    ```

!!! important "If you had configured custom key managers in API-M 3.1.0"
    With API-M 3.2.0 we have introduced an admin functionality for admins/tenant admins to configure different authorization servers as Key Managers. Please follow below steps for **each tenant** to configure the key managers in your migrated setup.
    
    1. Navigate to admin portal and register the relevant Identity Provider as a Key Manager in the Admin Portal by providing the required details.
       
        For more details please refer document [Configuring Key Managers]({{base_path}}/administer/key-managers/overview/#configuring-key-managers-with-wso2-api-m). If the custom Key Manager type is not among the out-of-the-box supported KM connector list, you may have to configure it as a custom Key manager as per document [Configure Custom Key Manager]({{basepath}}/administer/key-managers/configure-custom-connector/)

    2. Retrieve UUID of the Key Manager added in step 1.
        
        ??? "How to find the Key Manager UUID"
             Go to the Key Manager overview and locate the alphanemric string at the end of the URL as below. 
                
                 https://<host>:<port>/admin/settings/key-managers/0ccfca69-676f-4ee9-ae88-c231dc443cfb
    
    3. Update Key Manager UUID in `AM_APPLICATION_KEY_MAPPING` table.
        
        ```UPDATE AM_APPLICATION_KEY_MAPPING SET KEY_MANAGER  = '<uuid>' WHERE APPLICATION_ID IN (SELECT APPLICATION_ID FROM AM_APPLICATION WHERE ORGANIZATION="<tenantdomain>");```
    
    4. Update Key Manager UUID in `AM_APPLICATION_REGISTRATION` table.
        
        ```UPDATE AM_APPLICATION_REGISTRATION SET KEY_MANAGER  = '<uuid>' WHERE APP_ID IN (SELECT APPLICATION_ID FROM AM_APPLICATION WHERE ORGANIZATION="<tenantdomain>");```


This concludes the upgrade process.
