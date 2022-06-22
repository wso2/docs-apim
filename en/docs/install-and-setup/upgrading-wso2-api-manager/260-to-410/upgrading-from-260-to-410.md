# Upgrading API Manager from 2.6.0 to 4.1.0

The following information describes how to upgrade your API Manager server **from API-M 2.6.0 to 4.1.0**.

## Prerequisites

1. Review what has changed in this release. See [What Has Changed]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/320-to-410/what-has-changed).

2. Before you migrate, follow [Upgrading Guidelines]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-guidelines) to get an understanding on the migration process.

3. Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and unzip it in the <API-M_4.1.0_HOME> directory.

4. Update API-M 4.1.0 to the latest U2 update level.

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.6.0 to 4.1.0**.

 - [Step 1 - Migrate the API Manager configurations](#step-1-migrate-the-api-manager-configurations)
 - [Step 2 - Migrate the API Manager resources to API-M 4.1.0](#step-2-migrate-the-api-manager-resources)
 - [Step 3 - Migrate the Identity Components](#step-3-migrate-the-identity-components)
 - [Step 4 - Migrate the API Manager components to API-M 4.1.0](#step-4-migrate-the-api-manager-components)
 - [Step 5 - Re-Index the API Manager artifacts](#step-5-re-index-the-api-manager-artifacts)
 - [Step 6 - Restart the WSO2 API-M 4.1.0 server](#step-6-restart-the-wso2-api-m-410-server)

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as the configuration modal has been changed and now all the configurations are being done via a single file (deployment.toml). Instead, redo the configuration changes in the new configuration file.

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and update to the latest U2 update level.

2.  Open the `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file and provide the datasource configurations for the following databases.

    -   User Store
    -   Registry database/s
    -   API Manager databases

    !!! note
        Since API-M 3.x versions, a combined SHARED_DB has been introduced to keep both the user related data (`WSO2UM_DB`) and the registry data (`WSO2REG_DB`). If you have used separate DBs for user management and registry in the previous version, you need to configure WSO2REG_DB and WSO2UM_DB databases separately in API-M 4.1.0 to avoid any issues.

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

    !!! info
        In API-M 4.1.0, you do not need to configure the registry configurations as you did in the `<OLD_API-M_HOME>/repository/conf/registry.xml` file and the user database configurations as you did in in the `<OLD_API-M_HOME>/repository/conf/user-mgt.xml` file, as those configurations have been handled internally.

    !!! note
        It is not recommended to use default H2 databases other than `WSO2_MB_STORE_DB` in production. Therefore migration of default H2 databases will not be supported since API-M 4.0.0.
        It is recommended to use the default H2 database for the `WSO2_MB_STORE_DB` database in API-Manager. So do **not** migrate `WSO2_MB_STORE_DB` database from API-M 2.6.0 version to API-M 4.1.0 version, and use the **default H2** `WSO2_MB_STORE_DB` database available in API-M 4.1.0 version.

3.  Update <API-M_4.1.0_HOME>/repository/conf/deployment.toml file as follows, to point to the correct database for user management purposes.

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
    
    !!! Info
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
    
    Therefore, if registry versioning was enabled in WSO2 API-M 2.6.0 setup, it is **required** run the below scripts against **the database that is used by the registry**. Follow the below steps to achieve this.
    
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
            
            From API-M 3.0.0 version onwards, those configurations are set to false by-default and since these configurations are now getting changed from old setup to new setup, you need to remove the versioning details from the database in order for the registry resources to work properly. For that, choose the relevant DB type and run the script against the DB that the registry resides in, to remove the registry versioning details.   
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

6. If you have enabled any other feature related configurations in API Manager 2.6.0, make sure to add them in to `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file.

### Step 2: Migrate the API Manager Resources

Follow the instructions below to migrate existing API Manager resources from the current environment to API-M 4.1.0.

1.  Copy the relevant JDBC driver to the `<API-M_4.1.0_HOME>/repository/components/lib` folder.

2.  If you manually added any custom OSGI bundles to the `<API-M_2.6.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_4.1.0_HOME>/repository/components/dropins` directory. 

3.  If you manually added any JAR files to the `<API-M_2.6.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_4.1.0_HOME>/repository/components/lib` directory.

4. WSO2 API Manager 4.1.0 has been upgraded to log4j2 (from log4j). You will notice that there is a log4j2.properties file in the `<API-M_4.1.0_HOME>/repository/conf/` directory instead of the log4j.properties file. Follow [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to migrate your existing log4j.properties file to log4j2.properties file.

    !!! warning
        Taking the log4j.properties file from your old WSO2 API-M Server and adding it to WSO2 API-M Server 4.1.0 will no longer work. Refer [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to see how to add a log appender or a logger to the log4j2.properties file.

    !!! note
        Log4j2 has hot deployment support, and **Managing Logs** section has been removed from the Management Console. You can now use the log4j2.properties file to modify logging configurations without restarting the server.

5.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_4.1.0_HOME>/repository/resources/security` directory.

    !!! Attention
        In API Manager 4.1.0, it is required to use a certificate with the RSA key size greater than 2048. If you have used a certificate that has a weak RSA key (key size less than 2048) in previous version, you need to add the following configuration to `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file to configure internal and primary keystores. You should point the internal keystore to the keystore copied from API Manager 2.6.0 and the primary keystore can be pointed to a keystore with a certificate, which has a strong RSA key.
    
        ``` java
            [keystore.tls]
            file_name = "internal.jks"
            type = "JKS"
            password = "wso2carbon"
            alias = "wso2carbon"
            key_password = "wso2carbon"
                    
            [keystore.primary]
            file_name = "primary.jks"
            type = "JKS"
            password = "wso2carbon"
            alias = "wso2carbon"
            key_password = "wso2carbon"
    
            [keystore.internal]
            file_name = "internal.jks"
            type = "JKS"
            password = "wso2carbon"
            alias = "wso2carbon"
            key_password = "wso2carbon"
        ```

    !!! note "If you have enabled Secure Vault"
        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below. Refer [Encrypting Passwords in Configuration files]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords) for more details.
    
        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

6. If you already have used secondary user stores in API-M 2.6.0, you have to copy the user store file created inside the old API-M version to the new API-M version.

    For secondary user stores created for the super tenant,
    
    You have to copy the `<API-M_2.6.0_HOME>/repository/deployment/server/userstores/` directory inside `<API-M_4.1.0_HOME>/repository/deployment/server/` directory.
    
    For secondary user stores created for tenants,
    
    You have to copy the userstores to respective tenant directories after executing [step 4](#step-4-migrate-the-api-manager-components) as the tenant directories (`<API-M_2.6.0_HOME>/repository/tenants/`) at API-M 4.1.0 are populated after migrating the api-m components.

### Step 3: Migrate the Identity Components

Follow the instruction below to upgrade the Identity component in WSO2 API Manager from version 5.7.0 to 5.11.0.

!!! note "If you are using PostgreSQL"

    The database user should have the 'Superuser' permission to migrate the API Manager Databases. If the user is not already a superuser, assign the permission before starting the migration.
        ```
        ALTER USER <user> WITH SUPERUSER;
        ```

!!! note "If you are using Oracle"
    Commit the changes after running the scripts given below

!!! note "If you are using DB2"
    Move indexes to the TS32K Tablespace. The index tablespace in the `IDN_OAUTH2_ACCESS_TOKEN` and `IDN_OAUTH2_AUTHORIZATION_CODE` tables need to be moved to the existing TS32K tablespace in order to support newly added table indexes.

    SQLADM or DBADM authority is required in order to invoke the `ADMIN_MOVE_TABLE` stored procedure. You must also have the appropriate object creation authorities, including authorities to issue the SELECT statement on the source table and to issue the INSERT statement on the target table.    

    ??? Info "Click here to see the stored procedure" 
        ``` java
        CREATE BUFFERPOOL BP32K IMMEDIATE SIZE 250 AUTOMATIC PAGESIZE 32K
        /
        CREATE LARGE TABLESPACE TS32K PAGESIZE 32K MANAGED by AUTOMATIC STORAGE BUFFERPOOL BP32K
        /
        
        CALL SYSPROC.ADMIN_MOVE_TABLE(
        <TABLE_SCHEMA_OF_IDN_OAUTH2_ACCESS_TOKEN_TABLE>,
        'IDN_OAUTH2_ACCESS_TOKEN',
        (SELECT TBSPACE FROM SYSCAT.TABLES where TABNAME = 'IDN_OAUTH2_ACCESS_TOKEN' AND TABSCHEMA = <TABLE_SCHEMA_OF_IDN_OAUTH2_ACCESS_TOKEN_TABLE>),
        'TS32K',
        (SELECT TBSPACE FROM SYSCAT.TABLES where TABNAME = 'IDN_OAUTH2_ACCESS_TOKEN' AND TABSCHEMA = <TABLE_SCHEMA_OF_IDN_OAUTH2_ACCESS_TOKEN_TABLE>),
        '',
        '',
        '',
        '',
        '',
        'MOVE');

        CALL SYSPROC.ADMIN_MOVE_TABLE(
        <TABLE_SCHEMA_OF_IDN_OAUTH2_AUTHORIZATION_CODE_TABLE>,
        'IDN_OAUTH2_AUTHORIZATION_CODE',
        (SELECT TBSPACE FROM SYSCAT.TABLES where TABNAME = 'IDN_OAUTH2_AUTHORIZATION_CODE' AND TABSCHEMA = <TABLE_SCHEMA_OF_IDN_OAUTH2_AUTHORIZATION_CODE_TABLE>),
        'TS32K',
        (SELECT TBSPACE FROM SYSCAT.TABLES where TABNAME = 'IDN_OAUTH2_AUTHORIZATION_CODE' AND TABSCHEMA = <TABLE_SCHEMA_OF_IDN_OAUTH2_AUTHORIZATION_CODE_TABLE>),
        '',
        '',
        '',
        '',
        '',
        'MOVE');

        Where,

        <TABLE_SCHEMA_OF_IDN_OAUTH2_ACCESS_TOKEN_TABLE> and <TABLE_SCHEMA_OF_IDN_OAUTH2_AUTHORIZATION_CODE_TABLE> : Replace these schema’s with each respective schema for the table.
        ```

    If you receive an error due to missing `SYSTOOLSPACE` or `SYSTOOLSTMPSPACE` tablespaces, create those tablespaces manually using the following script prior to executing the stored procedure given above. For more information, see [SYSTOOLSPACE and SYSTOOLSTMPSPACE table
    spaces](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_10.5.0/com.ibm.db2.luw.admin.gui.doc/doc/c0023713.html) in the IBM documentation.          
    ``` java
    CREATE TABLESPACE SYSTOOLSPACE IN IBMCATGROUP
    MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
    EXTENTSIZE 4;
    
    CREATE USER TEMPORARY TABLESPACE SYSTOOLSTMPSPACE IN IBMCATGROUP
    MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
    EXTENTSIZE 4;
    ```

1.  Make sure you backed up all the databases in API-M 2.6.0

2. Run the below script against the AM_DB.
   
    ??? info "DB Scripts"
        ```tab="DB2"
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER   NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        TIMESTAMP NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_RESOURCE_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_RESOURCE_SEQ);
        END
        /
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID)
        /
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN)
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER NOT NULL,
        RESOURCE_IDENTITY INTEGER NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_RESOURCE_META_DATA_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_META_DATA
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_RESOURCE_META_DATA_SEQ);
        END
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER NOT NULL,
        RESOURCE_IDENTITY INTEGER NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_RESOURCE_SCOPE_TRIG  NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_RESOURCE_SCOPE_SEQ);
        END
        /
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME)
        /
        
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER      NOT NULL,
        PT              VARCHAR(255) NOT NULL,
        TIME_CREATED    TIMESTAMP    NOT NULL,
        EXPIRY_TIME     TIMESTAMP    NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_PERMISSION_TICKET_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_PERMISSION_TICKET
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_PERMISSION_TICKET_SEQ);
        END
        /
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT)
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER NOT NULL,
        PT_RESOURCE_ID INTEGER NOT NULL,
        PT_ID          INTEGER NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_PT_RESOURCE_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_PT_RESOURCE_SEQ);
        END
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER NOT NULL,
        PT_RESOURCE_ID INTEGER NOT NULL,
        PT_SCOPE_ID    INTEGER NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_PT_RESOURCE_SCOPE_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_PT_RESOURCE_SCOPE_SEQ);
        END
        /
        ```
    
        ```tab="MSSQL"
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER IDENTITY NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        DATETIME         NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);
        
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE_META_DATA]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER IDENTITY NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
    
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER IDENTITY NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);
        
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PERMISSION_TICKET]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER IDENTITY NOT NULL,
        PT              VARCHAR(255)     NOT NULL,
        TIME_CREATED    DATETIME         NOT NULL,
        EXPIRY_TIME     DATETIME         NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);
    
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PT_RESOURCE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER IDENTITY NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID)
        );
    
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PT_RESOURCE_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER IDENTITY NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID)
        );
        ```
    
        ```tab="MySQL"
        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE (
        ID                  INTEGER AUTO_INCREMENT NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        TIMESTAMP              NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER AUTO_INCREMENT NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER AUTO_INCREMENT NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER AUTO_INCREMENT NOT NULL,
        PT              VARCHAR(255)           NOT NULL,
        TIME_CREATED    TIMESTAMP              NOT NULL,
        EXPIRY_TIME     TIMESTAMP              NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE (
        ID             INTEGER AUTO_INCREMENT NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER AUTO_INCREMENT NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        );
        ```
    
        ```tab="Oracle"
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER,
        RESOURCE_ID         VARCHAR2(255),
        RESOURCE_NAME       VARCHAR2(255),
        TIME_CREATED        TIMESTAMP              NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR2(255),
        CLIENT_ID           VARCHAR2(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR2(50),
        PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_TRIG
        BEFORE INSERT
        ON IDN_UMA_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID)
        /
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN)
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR2(40),
        PROPERTY_VALUE    VARCHAR2(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_METADATA_TRIG
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_META_DATA
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_RESOURCE_META_DATA_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR2(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_SCOPE_TRIG
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME)
        /
        
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER,
        PT              VARCHAR2(255)           NOT NULL,
        TIME_CREATED    TIMESTAMP              NOT NULL,
        EXPIRY_TIME     TIMESTAMP              NOT NULL,
        TICKET_STATE    VARCHAR2(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_PERMISSION_TICKET_TRIG
        BEFORE INSERT
        ON IDN_UMA_PERMISSION_TICKET
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_PERMISSION_TICKET_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT)
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_TRIG
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_PT_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_SCOPE_TRIG
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_PT_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        ```
    
        ```tab="PostgreSQL"
        DROP TABLE IF EXISTS IDN_UMA_RESOURCE;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER DEFAULT NEXTVAL('IDN_UMA_RESOURCE_SEQ') NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        TIMESTAMP                                   NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        );
        
        DROP INDEX IF EXISTS IDX_RID;
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);
        
        DROP INDEX IF EXISTS IDX_USER;
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);
        
        DROP TABLE IF EXISTS IDN_UMA_RESOURCE_META_DATA;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_META_DATA_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_META_DATA_SEQ') NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        DROP TABLE IF EXISTS IDN_UMA_RESOURCE_SCOPE;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SCOPE_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_SCOPE_SEQ') NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        DROP INDEX IF EXISTS IDX_RS;
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);
        
        DROP TABLE IF EXISTS IDN_UMA_PERMISSION_TICKET;
        DROP SEQUENCE IF EXISTS IDN_UMA_PERMISSION_TICKET_SEQ;
        CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ;
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER DEFAULT NEXTVAL('IDN_UMA_PERMISSION_TICKET_SEQ') NOT NULL,
        PT              VARCHAR(255)                                         NOT NULL,
        TIME_CREATED    TIMESTAMP                                            NOT NULL,
        EXPIRY_TIME     TIMESTAMP                                            NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        );
        
        DROP INDEX IF EXISTS IDX_PT;
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);
        
        DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE;
        DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SEQ;
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ;
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SEQ') NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE;
        DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SCOPE_SEQ') NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        );
        ```

    
3.  Download the identity component migration resources and unzip it in a local directory.

    Navigate to the [latest release tag](https://github.com/wso2-extensions/apim-identity-migration-resources/releases) and download the `wso2is-migration-x.x.x.zip` under Assets.

    Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`.

4.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_4.1.0_HOME>` directory.

5.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.7.0, as shown below.

    ``` java
    migrationEnable: "true"
    currentVersion: "5.7.0"
    migrateVersion: "5.11.0"
    ```

6. Remove the following 3 steps from  migration-config.yaml which is included under version: "5.10.0"
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

7. Remove the following 2 steps from  migration-config.yaml which is included under version: "5.11.0"
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
    ```
   
8. Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

9. Update `<API-M_4.1.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the previous user store.

    ```
    [user_store]
    type = "database"
    ```

10. If you are migrating your user stores to the new user store managers with the unique ID capabilities, Follow the guidelines given in the [Migrating User Store Managers](https://is.docs.wso2.com/en/latest/setup/migrating-userstore-managers/) before moving to the next step

11. Start WSO2 API Manager 4.1.0 as follows to carry out the complete Identity component migration.

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

12.  After you have successfully completed the migration, stop the server and remove the following files and folders.

    -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.
    
    -   Remove the `migration-resources` directory, which is in the `<API-M_4.1.0_HOME>` directory.
    
    -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the api-manager.bat file.
    
        ```
        -Dmigrate -Dcomponent=identity
        ```
    
    -   If you followed step 9 above, and want to use the latest user store, update the <API-M_4.1.0_HOME>/repository/conf/deployment.toml as follows after the identity migration,
    
        ```
        [user_store]
        type = "database_unique_id"
        ```
        
### Step 4: Migrate the API Manager Components

You have to run the following migration client to update the API Manager artifacts.

1.  Navigate to the [latest release tag (v4.1.0.x)](https://github.com/wso2-extensions/apim-migration-resources/releases) under **Assets** and download the `wso2am-migration-4.1.0.x.zip`. Unzip it to a local directory.

    !!! note

        x of wso2am-migration-4.1.0.x.zip denotes the version number of the most recently-released migration resources.

        The directory where the wso2am-migration-4.1.0.x.zip is unziped will be referred to as `<AM_MIGRATION_CLIENT_HOME>`

2. Copy the `<AM_MIGRATION_CLIENT_HOME>/migration-resources` to the `<API-M_4.1.0_HOME>` directory.

3. Copy the org.wso2.carbon.am.migration-4.1.0.x.jar file in the `<AM_MIGRATION_CLIENT_HOME>/dropins` directory into the `<API-M_4.1.0_HOME>/repository/components/dropins` directory.

4. Prior to API-M migration run the below command to validate the API definitions.

    ``` tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -DmigrateFromVersion=2.6.0 -DmigratedVersion=4.1.0 -DrunPreMigration=apiDefinitionValidation
    ```

    ``` tab="Windows"
    api-manager.bat -Dmigrate -DmigrateFromVersion=2.6.0 -DmigratedVersion=4.1.0 -DrunPreMigration=apiDefinitionValidation
    ```

    Check the server logs and verify if there are any errors logs. If you have encountered any errors in the API definitions, you have to correct them manually on the old version before proceeding to step 5.

5.  Start the API-M server to migrate the API-M components as follows.

    ``` tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -DmigrateFromVersion=2.6.0 -DmigratedVersion=4.1.0
    ```

    ``` tab="Windows"
    api-manager.bat -Dmigrate -DmigrateFromVersion=2.6.0 -DmigratedVersion=4.1.0
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
    Note that it takes a considerable amount of time for the API Manager to re-index the artifacts, depending on the API count and the number of tenants.

### Step 6 - Restart the WSO2 API-M 4.1.0 server

1. In WSO2 Identity Server 5.11.0, groups include user store roles and roles include internal roles. To enable this role and group separation the following property should be enabled via the deployment.toml file.

    ```
    [authorization_manager.properties]
    GroupAndRoleSeparationEnabled = true
    ```

2.  Restart the WSO2 API-M server.

    ```tab="Linux / Mac OS"
    sh api-manager.sh
    ```

    ```tab="Windows"
    api-manager.bat
    ```

This concludes the upgrade process.

