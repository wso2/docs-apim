# Upgrading API Manager from 1.10.0 to 4.0.0

!!! warning
    **The contents on this page are currently under review!**

Before you begin:

-   See [Upgrading Process]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-process) for detailed guidelines on how you should prepare for the upgrading process.

-   Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 1.10.0 to 4.0.0**.

-   If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, first follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.10.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-510-to-is-5110).

-   **If you are using PostgreSQL**, the DB user needs to have the `superuser` role to run the migration client and the relevant scripts.

    ```
    ALTER USER <user> WITH SUPERUSER;
    ```

-   **If you are using Oracle**, commit the changes after running the scripts given below.
    
### Preparing for Migration
#### Disabling versioning in the registry configuration

If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 4.0.0.

Therefore, if registry versioning was enabled in WSO2 API-M 1.10.0 setup, it is **required** to turn off the registry 
versioning in the migrated 4.0.0 setup. Follow the instructions below to disable versioning in the registry configuration:

!!! note "NOTE"
    Alternatively, you can turn on registry versioning in API Manager 4.0.0 and continue. However, this is
    highly **NOT RECOMMENDED** and these configurations should only be changed once.

!!! info "Turning off the registry versioning"
    1. Open the `registry.xml` file in the `<OLD_API-M_HOME>/repository/conf` directory.
    2. Check whether `versioningProperties`, `versioningComments`, `versioningTags`, and `versioningRatings` configurations are `true`.

        ```
        <staticConfiguration>
            <versioningProperties>true</versioningProperties>
            <versioningComments>true</versioningComments>
            <versioningTags>true</versioningTags>
            <versioningRatings>true</versioningRatings>
        </staticConfiguration>
        ```

    !!! warning
        If the above configurations are already set as `false` you should not run the following scripts.

        From API-M 3.0.0 onwards, by default, these configurations are set to `false` and now as these configurations are being changed from the old setup to the new setup, you need to remove the versioning details from the database in order for the registry resources to work properly. As a result in order to remove the registry versioning details, you need to select the relevant DB type and run the script against the DB that the registry resides in. 

    ??? info "DB Scripts"
        ```tab="H2"
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
    If you decide to proceed with the registry resource versioning enabled, add the following configuration to the `<NEW_API-M_HOME>/repository/conf/deployment.toml` file of the new WSO2 API Manager. 
    
    ```
    [registry.static_configuration]
    enable=true
    ```
    
    !!! note "NOTE"
        You should only change these configurations before the initial WSO2 API-M Server startup. If you do these changes after the initial startup, the registry resource that was created previously will not be available.

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy the entire configuration files from the current version of WSO2 API Manager to the new one, as the configuration model has been changed and now all the configurations are done via a single file (`deployment.toml`). Instead, redo the configuration changes in the new configuration file.

!!! note
    
    - For more information on the configurations in the new configuration model, see the [Configuration Catalog]({{base_path}}/reference/config-catalog).
    - For more information on the mapping between WSO2 API Manager's old configuration files and the new `deployment.toml` file, see [Understanding the New Configuration Model]({{base_path}}/reference/understanding-the-new-configuration-model).

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Back up all databases in your API Manager instances along with the Synapse configurations of all the tenants and the super tenant.

    -   The Synapse configurations of the super tenant are in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory.

    -   The Synapse configurations of the tenants are in the `<OLD_API-M_HOME>/repository/tenants` directory.

    -   If you use a **clustered/distributed API Manager setup**, backup the available configurations in the **API Gateway** node.

2.  Download [WSO2 API Manager 4.0.0](http://wso2.com/api-management/).

3.  Open the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file and provide the datasource configurations for the following databases.

    -   User Store
    -   Registry database/s
    -   API Manager databases

    !!! note
        In API-M 4.0.0, a combined **SHARED_DB** has been introduced to keep both the user-related data (`WSO2UM_DB`) and the registry data (`WSO2REG_DB`). If you have used separate DBs for user management and registry in the previous version, you need to configure the `WSO2REG_DB` and `WSO2UM_DB` databases separately in API-M 4.0.0 to avoid any issues.

    The **SHARED_DB** should point to the previous API-M version's `WSO2REG_DB`. The following example shows you how you can define the configurations related to a MySQL database.

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

    Optionally, add a new entry as follows to the `deployment.toml` file if you have configured a separate user management database in the previous API-M version.

    ```
    [database.user]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/um_db"
    username = "username"
    password = "password"
    ```

    !!! note
        If you have configured the `WSO2CONFIG_DB` in the previous API-M version, add a new entry to the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file as follows:

        ```
        [database.config]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/config_db"
        username = "username"
        password = "password"
        ```

    !!! attention "If you are using another DB type"
        If you are using another DB type other than **H2**, **MySQL** or **Oracle**, when defining the DB related configurations in the `deployment.toml` file, you need to add the `driver` and `validationQuery` parameters additionally as mentioned below.

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
        validationQuery = "SELECT 1; COMMIT"
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
        It is recommended to use the default H2 database for the `WSO2_MB_STORE_DB` database in API-Manager. Therefore, ** do not** migrate the `WSO2_MB_STORE_DB` database from API-M 2.0.0 to API-M 4.0.0. Just use the **default H2** `WSO2_MB_STORE_DB` database that is available in API-M 4.0.0.

4.  Point to the correct database for user management purposes by updating the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file as follows:

    ```
    [realm_manager]
    data_source = "WSO2USER_DB"
    ```

5.  Copy the relevant JDBC driver to the `<API-M_4.0.0_HOME>/repository/components/lib` directory.

    !!! info
        In API-M 4.0.0, you do not need to configure the registry configurations as you did in the `<OLD_API-M_HOME>/repository/conf/registry.xml` file and the user database configurations as you did in the `<OLD_API-M_HOME>/repository/conf/user-mgt.xml` file, as those configurations have been handled internally.

6.  Move all your Synapse configurations to the API-M 4.0.0 pack.
    -   Move your Synapse super tenant configurations.
         Copy the contents in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and replace the content in the `<API-M_4.0.0_HOME>/repository/deployment/server/synapse-configs/default` directory with the copied content.

    -   Move all your tenant Synapse configurations.
         Copy the content in the `<OLD_API-M_HOME>/repository/tenants` directory and replace the content in the `<API-M_4.0.0_HOME>/repository/tenants` directory with the copied contents.

    !!! warning
        When moving the Synapse configurations, **do not replace** the following set of files as they contain some modifications in API-M 4.0.0.

        -   /api/_RevokeAPI_.xml
        -   /sequences/_cors_request_handler_.xml
        -   /sequences/_resource_mismatch_handler_.xml
        -   /sequences/main.xml
        -   /sequences/_throttle_out_handler.xml
        -   /sequences/fault.xml
        -   /proxy-services/WorkflowCallbackService.xml
                
    !!! attention 
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Gateway** node.

7.  If you manually added any custom OSGI bundles to the `<API-M_1.10.0_HOME>/repository/components/dropins` directory, copy those custom OSGI bundles to the `<API-M_4.0.0_HOME>/repository/components/dropins` directory. 

8.  If you manually added any JAR files to the `<API-M_1.10.0_HOME>/repository/components/lib` directory, copy those JAR files and paste them in the `<API-M_4.0.0_HOME>/repository/components/lib` directory.

9. Migrate your existing log4j.properties file to the log4j2.properties file. For more information, see [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2).

     WSO2 API Manager 4.0.0 has been upgraded to log4j2 (from log4j). You will notice that there is a `log4j2.properties` file in the `<API-M_4.0.0_HOME>/repository/conf/` directory instead of the `log4j.properties` file. Therefore, you need to upgrade to log4j2.

    !!! warning
        Taking the `log4j.properties` file from your old WSO2 API-M Server and adding it to the WSO2 API-M 4.0.0 Server will no longer work. Refer to [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to see how to add a log appender or a logger to the `log4j2.properties` file.

    !!! note
        Log4j2 has hot deployment support therefore the **Managing Logs** section has been removed from the Management Console. You can now use the `log4j2.properties` file to modify the required logging configurations without restarting the server.

### Step 2 - Upgrade API Manager to 4.0.0

1.  Stop all the WSO2 API Manager server instances that are running.

2.  Make sure you backed up all the databases and Synapse configurations as instructed in [step 1](#step-1-migrate-the-api-manager-configurations).

3.  To start the migration process, run the respective migration script based on your environment.

    ??? note "Linux/Mac OS"
        Run the [apim110_to_apim320_gateway_artifact_migrator.sh]({{base_path}}/assets/attachments/install-and-setup/apim110_to_apim320_gateway_artifact_migrator.sh) script, as shown below, to migrate from WSO2 API Manager 1.10.0 to 4.0.0. 
        ```
        ./apim110_to_apim320_gateway_artifact_migrator.sh <API-definitions-path>
        ```

        !!! note
            If you are getting a "Permission Denied" message when you execute the above command, grant the permission as follows:
            ```
            chmod 777 apim110_to_apim320_gateway_artifact_migrator.sh
            ```

        `<API-definition-path>` - This is the location where the WSO2 API-M 4.0.0 API definitions, which were copied from the API-M 1.10.0 deployment, reside.

        The API definition paths `<API-definition-path>` are as follows:

        -   Super Tenant - `<API-M_4.0.0_HOME>/repository/deployment/server/synapse-configs/default`

        -   Tenant - `<API-M_4.0.0_HOME>/repository/tenants`

        Where, `<API-M_4.0.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-4.0.0` which is the **full path** to the particular location.

    ??? note "Windows"
        !!! note "Super Tenant"
            Run the PowerShell script [apim110_to_apim320_gateway_artifact_migrator.ps1]({{base_path}}/assets/attachments/install-and-setup/apim110_to_apim320_gateway_artifact_migrator.ps1) as shown below, to migrate from WSO2 API Manager 1.10.0 to 4.0.0.

            1.  Open a Windows command prompt and type the following command.
                ```
                powershell
                ```
                A message about PowerShell appears, and the shell changes to PowerShell (PS).

            2.  Run the PowerShell script by passing the location of the Gateway artifacts that you need to migrate.
            ```
            .\apim110_to_apim320_gateway_artifact_migrator.ps1 <API-definitions-path>
            ```

            `<API-definition-path>` - This is the location where the WSO2 API-M 4.0.0 API definitions, which were copied from the API-M 1.10.0 deployment, reside.

            -   Super Tenant - `<API-M_4.0.0_HOME>/repository/deployment/server/synapse-configs/default`

            Where `<API-M_4.0.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-4.0.0`, which is the **full path** to the particular location.

        !!! note "Tenants"
            Run the PowerShell script [apim110_to_apim320_gateway_artifact_migrator_for_tenants.ps1]({{base_path}}/assets/attachments/install-and-setup/apim110_to_apim320_gateway_artifact_migrator_for_tenants.ps1) as shown below, to migrate from WSO2 API Manager 2.0.0 to 4.0.0.

            1.  Open a Windows command prompt and type the following command.
                ```
                powershell
                ```
                A message about PowerShell appears, and the shell changes to PowerShell (PS).

            2.  Run the PowerShell script by passing the location of the Gateway artifacts that you need to migrate.
            ```
            .\apim110_to_apim320_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
            ```

            `<API-definition-path>` - This is the location where the WSO2 API-M 4.0.0 API definitions, which were copied from the API-M 1.10.0 deployment, reside.

            -   Tenants - `<API-M_4.0.0_HOME>/repository/tenants`

            Where `<API-M_4.0.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-4.0.0`, which is the **full path** to the particular location.

    !!! warning
            It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.

    !!! info "Troubleshooting"

        **Why do I get the following error - `apim110_to_apim400_gateway_artifact_migrator.ps1`/`apim110_to_apim400_gateway_artifact_migrator_for_tenants.ps1` cannot be loaded because the execution of scripts is disabled on this system?**

        When running the `apim110_to_apim400_gateway_artifact_migrator.ps1` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system.
        
        To overcome this issue and allow the execution of such scripts, run the following command in the terminal as the **Administrator**.

        ``` java
        Set-ExecutionPolicy RemoteSigned
        ```


4.  Upgrade the WSO2 API Manager database from version 1.10.0 to version 4.0.0 by executing the relevant database script, from the scripts that are provided below, on the `WSO2AM_DB` database.

    ??? info "DB Scripts"
    
        ```tab="H2"
        ALTER TABLE AM_API  ADD COLUMN API_TIER VARCHAR(256);
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
                    ALERT_TYPE_ID INTEGER AUTO_INCREMENT,
                    ALERT_TYPE_NAME VARCHAR(256) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL,
                    PRIMARY KEY (ALERT_TYPE_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES_VALUES (
                    ALERT_TYPE_ID INTEGER,
                    USER_NAME VARCHAR(256) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
        	    CONSTRAINT AM_ALERT_TYPES_VALUES_CONSTRAINT UNIQUE (ALERT_TYPE_ID,USER_NAME,STAKE_HOLDER)
        );
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_EMAILLIST (
        	    EMAIL_LIST_ID INTEGER AUTO_INCREMENT,
                    USER_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    PRIMARY KEY (EMAIL_LIST_ID),
                    CONSTRAINT AM_ALERT_EMAILLIST_CONSTRAINT UNIQUE (EMAIL_LIST_ID,USER_NAME,STAKE_HOLDER)
        );
        
        CREATE TABLE IF NOT EXISTS  AM_ALERT_EMAILLIST_DETAILS (
                    EMAIL_LIST_ID INTEGER,
        	    EMAIL VARCHAR(255),	    
                    CONSTRAINT AM_ALERT_EMAILLIST_DETAILS_CONSTRAINT UNIQUE (EMAIL_LIST_ID,EMAIL)
        );
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalResponseTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalBackendTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalRequestsPerMin', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('RequestPatternChanged', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccessAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRefreshAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierHittingAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalTierUsage', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('healthAvailabilityPerMin', 'publisher');
        
        
        -- AM Throttling tables --
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT(11) NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL,
                    UNIT_TIME INT(11) NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    RATE_LIMIT_COUNT INT(11) NULL DEFAULT NULL,
                    RATE_LIMIT_TIME_UNIT VARCHAR(25) NULL DEFAULT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
        			      CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
                    STOP_ON_QUOTA_REACH BOOLEAN NOT NULL DEFAULT 0,
                    BILLING_PLAN VARCHAR(20) NOT NULL,
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX AM_POLICY_SUBSCRIPTION_NAME_TENANT (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_APPLICATION (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT(11) NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INT(11) NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
        			CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
        			      UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX APP_NAME_TENANT (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_HARD_THROTTLING (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(512) NOT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT(11) NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INT(11) NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX POLICY_HARD_NAME_TENANT (NAME, TENANT_ID)
        );
        
        
        CREATE TABLE IF NOT EXISTS AM_API_THROTTLE_POLICY (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR (1024),
                    DEFAULT_QUOTA_TYPE VARCHAR(25) NOT NULL,
                    DEFAULT_QUOTA INTEGER NOT NULL,
                    DEFAULT_QUOTA_UNIT VARCHAR(10) NULL,
                    DEFAULT_UNIT_TIME INTEGER NOT NULL,
                    DEFAULT_TIME_UNIT VARCHAR(25) NOT NULL,
                    APPLICABLE_LEVEL VARCHAR(25) NOT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX API_NAME_TENANT (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_CONDITION_GROUP (
                    CONDITION_GROUP_ID INTEGER NOT NULL AUTO_INCREMENT,
                    POLICY_ID INTEGER NOT NULL,
                    QUOTA_TYPE VARCHAR(25),
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    DESCRIPTION VARCHAR (1024) NULL DEFAULT NULL,
                    PRIMARY KEY (CONDITION_GROUP_ID),
                    FOREIGN KEY (POLICY_ID) REFERENCES AM_API_THROTTLE_POLICY(POLICY_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS AM_QUERY_PARAMETER_CONDITION (
                    QUERY_PARAMETER_ID INTEGER NOT NULL AUTO_INCREMENT,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    PARAMETER_NAME VARCHAR(255) DEFAULT NULL,
                    PARAMETER_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_PARAM_MAPPING BOOLEAN DEFAULT 1,
                    PRIMARY KEY (QUERY_PARAMETER_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS AM_HEADER_FIELD_CONDITION (
                    HEADER_FIELD_ID INTEGER NOT NULL AUTO_INCREMENT,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    HEADER_FIELD_NAME VARCHAR(255) DEFAULT NULL,
                    HEADER_FIELD_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_HEADER_FIELD_MAPPING BOOLEAN DEFAULT 1,
                    PRIMARY KEY (HEADER_FIELD_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS AM_JWT_CLAIM_CONDITION (
                    JWT_CLAIM_ID INTEGER NOT NULL AUTO_INCREMENT,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    CLAIM_URI VARCHAR(512) DEFAULT NULL,
                    CLAIM_ATTRIB VARCHAR(1024) DEFAULT NULL,
        	    IS_CLAIM_MAPPING BOOLEAN DEFAULT 1,
                    PRIMARY KEY (JWT_CLAIM_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS AM_IP_CONDITION (
          AM_IP_CONDITION_ID INT NOT NULL AUTO_INCREMENT,
          STARTING_IP VARCHAR(45) NULL,
          ENDING_IP VARCHAR(45) NULL,
          SPECIFIC_IP VARCHAR(45) NULL,
          WITHIN_IP_RANGE BOOLEAN DEFAULT 1,
          CONDITION_GROUP_ID INT NULL,
          PRIMARY KEY (AM_IP_CONDITION_ID),
           FOREIGN KEY (CONDITION_GROUP_ID)    REFERENCES AM_CONDITION_GROUP (CONDITION_GROUP_ID)  ON DELETE CASCADE ON UPDATE CASCADE);
        
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_GLOBAL (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(512) NOT NULL,
                    KEY_TEMPLATE VARCHAR(512) NOT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    SIDDHI_QUERY BLOB DEFAULT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (UUID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_THROTTLE_TIER_PERMISSIONS (
          THROTTLE_TIER_PERMISSIONS_ID INT NOT NULL AUTO_INCREMENT,
          TIER VARCHAR(50) NULL,
          PERMISSIONS_TYPE VARCHAR(50) NULL,
          ROLES VARCHAR(512) NULL,
          TENANT_ID INT(11) NULL,
          PRIMARY KEY (THROTTLE_TIER_PERMISSIONS_ID));
        
        CREATE TABLE `AM_BLOCK_CONDITIONS` (
          `CONDITION_ID` int(11) NOT NULL AUTO_INCREMENT,
          `TYPE` varchar(45) DEFAULT NULL,
          `VALUE` varchar(45) DEFAULT NULL,
          `ENABLED` varchar(45) DEFAULT NULL,
          `DOMAIN` varchar(45) DEFAULT NULL,
          `UUID` VARCHAR(256),
          PRIMARY KEY (`CONDITION_ID`),
          UNIQUE (UUID)
        );
        
        -- End of API-MGT Tables --
        
        ALTER TABLE AM_SUBSCRIPTION_KEY_MAPPING ALTER COLUMN ACCESS_TOKEN VARCHAR(512);
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ALTER COLUMN TOKEN_SCOPE VARCHAR(1500);
        
        ALTER TABLE AM_APPLICATION ADD TOKEN_TYPE VARCHAR(10);
        
        ALTER TABLE AM_API_SCOPES ADD PRIMARY KEY (API_ID, SCOPE_ID);
        
        DELETE FROM AM_ALERT_TYPES_VALUES WHERE ALERT_TYPE_ID = (SELECT ALERT_TYPE_ID FROM AM_ALERT_TYPES WHERE ALERT_TYPE_NAME = 'AbnormalRefreshAlert' AND STAKE_HOLDER = 'subscriber');
        
        DROP TABLE IF EXISTS AM_ALERT_TYPES;
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
            ALERT_TYPE_ID INTEGER AUTO_INCREMENT,
            ALERT_TYPE_NAME VARCHAR(256) NOT NULL,
            STAKE_HOLDER VARCHAR(100) NOT NULL,
            PRIMARY KEY (ALERT_TYPE_ID)
        );
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalResponseTime', 'publisher');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalBackendTime', 'publisher');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestsPerMin', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestPattern', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccess', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierLimitHitting', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('ApiHealthMonitor', 'publisher');
        
        CREATE TABLE IF NOT EXISTS `AM_CERTIFICATE_METADATA` (
            `TENANT_ID` INT(11) NOT NULL,
            `ALIAS` VARCHAR(45) NOT NULL,
            `END_POINT` VARCHAR(100) NOT NULL,
            CONSTRAINT PK_ALIAS PRIMARY KEY (`ALIAS`)
        );
        
        CREATE TABLE IF NOT EXISTS AM_APPLICATION_GROUP_MAPPING (
            APPLICATION_ID INTEGER NOT NULL,
            GROUP_ID VARCHAR(512) NOT NULL,
            TENANT VARCHAR(255),
            PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
            TENANT_DOMAIN varchar(255) NOT NULL,
            FILE_NAME varchar(255) NOT NULL,
            FILE_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FILE_PROCESSED tinyint(1) DEFAULT 0,
            FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
            PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP)
        );
        
        CREATE TABLE IF NOT EXISTS AM_API_LC_PUBLISH_EVENTS (
            ID INTEGER(11) NOT NULL AUTO_INCREMENT,
            TENANT_DOMAIN VARCHAR(500) NOT NULL,
            API_ID VARCHAR(500) NOT NULL,
            EVENT_TIME TIMESTAMP NOT NULL,
            PRIMARY KEY (ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_APPLICATION_ATTRIBUTES (
            APPLICATION_ID int(11) NOT NULL,
            NAME varchar(255) NOT NULL,
            VALUE varchar(1024) NOT NULL,
            TENANT_ID int(11) NOT NULL,
            PRIMARY KEY (APPLICATION_ID,NAME),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION (APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS AM_LABELS (
            LABEL_ID VARCHAR(50),
            NAME VARCHAR(255),
            DESCRIPTION VARCHAR(1024),
            TENANT_DOMAIN VARCHAR(255),
            UNIQUE (NAME,TENANT_DOMAIN),
            PRIMARY KEY (LABEL_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_LABEL_URLS (
            LABEL_ID VARCHAR(50),
            ACCESS_URL VARCHAR(255),
            PRIMARY KEY (LABEL_ID,ACCESS_URL),
            FOREIGN KEY (LABEL_ID) REFERENCES AM_LABELS(LABEL_ID) ON UPDATE CASCADE ON DELETE CASCADE
        );
        
        CREATE INDEX IDX_AUTHORIZATION_CODE ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHORIZATION_CODE,CONSUMER_KEY_ID);
        
        CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
            ID int(11) NOT NULL AUTO_INCREMENT,
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
            UNIQUE (NAME),
            UNIQUE (CONSUMER_KEY),
            PRIMARY KEY (ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_API_CLIENT_CERTIFICATE (
            TENANT_ID INT(11) NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            API_ID INTEGER NOT NULL,
            CERTIFICATE BLOB NOT NULL,
            REMOVED BOOLEAN NOT NULL DEFAULT 0,
            TIER_NAME VARCHAR (512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE ON UPDATE CASCADE,
            PRIMARY KEY (ALIAS,TENANT_ID, REMOVED)
        );
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION
        ADD (
            MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL,
            FIXED_RATE VARCHAR(15) NULL DEFAULT NULL,
            BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL,
            PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL,
            CURRENCY VARCHAR(15) NULL DEFAULT NULL
        );
        
        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY (ID)
        );
        
        ALTER TABLE AM_API_COMMENTS
        MODIFY COLUMN COMMENT_ID VARCHAR(255) NOT NULL;
        
        ALTER TABLE AM_API_RATINGS
        MODIFY COLUMN RATING_ID VARCHAR(255) NOT NULL;
        
        CREATE TABLE IF NOT EXISTS AM_NOTIFICATION_SUBSCRIBER (
            UUID VARCHAR(255),
            CATEGORY VARCHAR(255),
            NOTIFICATION_METHOD VARCHAR(255),
            SUBSCRIBER_ADDRESS VARCHAR(255) NOT NULL,
            PRIMARY KEY(UUID,SUBSCRIBER_ADDRESS)
        );
        
        ALTER TABLE AM_EXTERNAL_STORES
        ADD LAST_UPDATED_TIME TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6);
        
        CREATE TABLE IF NOT EXISTS AM_API_PRODUCT_MAPPING (
            API_PRODUCT_MAPPING_ID INTEGER AUTO_INCREMENT,
            API_ID INTEGER,
            URL_MAPPING_ID INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(API_PRODUCT_MAPPING_ID)
        );
        
        ALTER TABLE AM_API
            ADD API_TYPE VARCHAR(10) NULL DEFAULT NULL;
        
        CREATE TABLE IF NOT EXISTS AM_REVOKED_JWT (
            UUID VARCHAR(255) NOT NULL,
            SIGNATURE VARCHAR(2048) NOT NULL,
            EXPIRY_TIMESTAMP BIGINT NOT NULL,
            TENANT_ID INTEGER DEFAULT -1,
            TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
            TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (UUID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_API_CATEGORIES (
            UUID VARCHAR(50),
            NAME VARCHAR(255),
            DESCRIPTION VARCHAR(1024),
            TENANT_ID INTEGER,
            UNIQUE (NAME,TENANT_ID),
            PRIMARY KEY (UUID)
        );
        
        ALTER TABLE AM_SYSTEM_APPS
        ADD TENANT_DOMAIN VARCHAR(255) DEFAULT 'carbon.super';
        
        CREATE TABLE IF NOT EXISTS AM_USER (
            USER_ID VARCHAR(255) NOT NULL,
            USER_NAME VARCHAR(255) NOT NULL,
            PRIMARY KEY(USER_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_SECURITY_AUDIT_UUID_MAPPING (
            API_ID INTEGER NOT NULL,
            AUDIT_UUID VARCHAR(255) NOT NULL,
            PRIMARY KEY (API_ID),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID)
        );          
        
         CREATE TABLE IF NOT EXISTS AM_KEY_MANAGER (
          UUID VARCHAR(50) NOT NULL,
          NAME VARCHAR(100) NOT NULL,
          DISPLAY_NAME VARCHAR(100) NULL,
          DESCRIPTION VARCHAR(256) NULL,
          TYPE VARCHAR(45) NULL,
          CONFIGURATION BLOB NULL,
          ENABLED BOOLEAN DEFAULT 1,
          TENANT_DOMAIN VARCHAR(100) NULL,
          PRIMARY KEY (UUID),
          UNIQUE (NAME,TENANT_DOMAIN)
          );
        
         CREATE TABLE IF NOT EXISTS AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          PRIMARY KEY (API_ID)
          );
        
         CREATE TABLE IF NOT EXISTS AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          ARTIFACT blob,
          GATEWAY_INSTRUCTION varchar(20),
          GATEWAY_LABEL varchar(255),
          TIME_STAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
          PRIMARY KEY (GATEWAY_LABEL, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
         );
        
        CREATE ALIAS IF NOT EXISTS DROP_FK AS $$ void executeSql(Connection conn, String sql)
        throws SQLException { conn.createStatement().executeUpdate(sql); } $$;
        
        call drop_fk('ALTER TABLE AM_APPLICATION_REGISTRATION DROP CONSTRAINT ' ||
        (SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.CONSTRAINTS
        WHERE TABLE_NAME = 'AM_APPLICATION_REGISTRATION' AND COLUMN_LIST  = 'SUBSCRIBER_ID,APP_ID,TOKEN_TYPE'));
        
        call drop_fk('ALTER TABLE AM_APPLICATION_KEY_MAPPING DROP CONSTRAINT ' ||
        (SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.CONSTRAINTS
        WHERE TABLE_NAME = 'AM_APPLICATION_KEY_MAPPING' AND COLUMN_LIST  = 'APPLICATION_ID,KEY_TYPE'));
        DROP ALIAS IF EXISTS DROP_FK;
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD KEY_MANAGER VARCHAR(255) DEFAULT 'Resident Key Manager';
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD UNIQUE (SUBSCRIBER_ID,APP_ID,TOKEN_TYPE,KEY_MANAGER);
        
        
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD UUID VARCHAR(512) NULL;
        UPDATE AM_APPLICATION_KEY_MAPPING SET UUID = random_uuid() WHERE UUID IS NULL;
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD KEY_MANAGER VARCHAR(512) NOT NULL DEFAULT 'Resident Key Manager';
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD APP_INFO BLOB;
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD PRIMARY KEY(APPLICATION_ID,KEY_TYPE,KEY_MANAGER);
        
        ALTER TABLE AM_WORKFLOWS ADD WF_METADATA BLOB NULL;
        ALTER TABLE AM_WORKFLOWS ADD WF_PROPERTIES BLOB NULL;
        
        ALTER TABLE AM_SUBSCRIPTION ADD TIER_ID_PENDING VARCHAR(50);
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD MAX_COMPLEXITY INT(11) NOT NULL DEFAULT 0;
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD MAX_DEPTH INT(11) NOT NULL DEFAULT 0;
        
        CREATE TABLE IF NOT EXISTS AM_API_RESOURCE_SCOPE_MAPPING (
            SCOPE_NAME VARCHAR(255) NOT NULL,
            URL_MAPPING_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES   AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(SCOPE_NAME, URL_MAPPING_ID)
        );
        
        
        CREATE TABLE IF NOT EXISTS AM_SHARED_SCOPE (
             NAME VARCHAR(255),
             UUID VARCHAR (256),
             TENANT_ID INTEGER,
             PRIMARY KEY (UUID)
        );
        
        ALTER TABLE IDN_OAUTH2_RESOURCE_SCOPE DROP PRIMARY KEY;
        
        DROP TABLE IF EXISTS AM_TENANT_THEMES;
        CREATE TABLE IF NOT EXISTS AM_TENANT_THEMES (
          TENANT_ID INTEGER NOT NULL,
          THEME BYTEA NOT NULL,
          PRIMARY KEY (TENANT_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_GRAPHQL_COMPLEXITY (
            UUID VARCHAR(256),
            API_ID INTEGER NOT NULL,
            TYPE VARCHAR(256),
            FIELD VARCHAR(256),
            COMPLEXITY_VALUE INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE,
            PRIMARY KEY(UUID),
            UNIQUE (API_ID,TYPE,FIELD)
        );
        
        UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL="" WHERE CALLBACK_URL IS NULL;
        
        CREATE TABLE IF NOT EXISTS AM_SCOPE (
                    SCOPE_ID INTEGER NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(255) NOT NULL,
                    DESCRIPTION VARCHAR(512),
                    TENANT_ID INTEGER NOT NULL DEFAULT -1,
                    SCOPE_TYPE VARCHAR(255) NOT NULL,
                    PRIMARY KEY (SCOPE_ID)
        );
        CREATE TABLE IF NOT EXISTS AM_SCOPE_BINDING (
                    SCOPE_ID INTEGER NOT NULL,
                    SCOPE_BINDING VARCHAR(255) NOT NULL,
                    BINDING_TYPE VARCHAR(255) NOT NULL,
                    FOREIGN KEY (SCOPE_ID) REFERENCES AM_SCOPE(SCOPE_ID) ON DELETE CASCADE
        );
        ```

        ```tab="DB2"
        ALTER TABLE AM_API  ADD API_TIER VARCHAR(256);
        CALL SYSPROC.ADMIN_CMD('REORG TABLE AM_API');
        
        CREATE TABLE AM_ALERT_TYPES (
                    ALERT_TYPE_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    ALERT_TYPE_NAME VARCHAR(256) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL,
                    PRIMARY KEY (ALERT_TYPE_ID)
        )/
        
        CREATE TABLE AM_ALERT_TYPES_VALUES (
                    ALERT_TYPE_ID INTEGER NOT NULL,
                    USER_NAME VARCHAR(256) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    CONSTRAINT AM_ALERT_TYPES_VALUES_CONSTRAINT UNIQUE (ALERT_TYPE_ID,USER_NAME,STAKE_HOLDER)
        )/
        
        CREATE TABLE AM_ALERT_EMAILLIST (  
        	    EMAIL_LIST_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),                   
                    USER_NAME VARCHAR(256) NOT NULL ,	    
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    PRIMARY KEY (EMAIL_LIST_ID),
            	    CONSTRAINT AM_ALERT_EMAILLIST_CONSTRAINT UNIQUE (EMAIL_LIST_ID,USER_NAME,STAKE_HOLDER)
        )/
        
        CREATE TABLE AM_ALERT_EMAILLIST_DETAILS (
                    EMAIL_LIST_ID INTEGER NOT NULL,
        	    EMAIL VARCHAR(255) NOT NULL,
                    CONSTRAINT AM_ALERT_EMAILLIST_DETAILS_CONSTRAINT UNIQUE (EMAIL_LIST_ID,EMAIL)
        )/
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalResponseTime', 'publisher')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalBackendTime', 'publisher')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalRequestsPerMin', 'subscriber')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('RequestPatternChanged', 'subscriber')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccessAlert', 'subscriber')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRefreshAlert', 'subscriber')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierHittingAlert', 'subscriber')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalTierUsage', 'publisher')/
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('healthAvailabilityPerMin', 'publisher')/
        
        
        
        -- AM Throttling tables --
        
        CREATE TABLE AM_POLICY_SUBSCRIPTION (
                    POLICY_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL,
                    UNIT_TIME INT NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    RATE_LIMIT_COUNT INT NULL DEFAULT NULL,
                    RATE_LIMIT_TIME_UNIT VARCHAR(25) NULL DEFAULT NULL,
                    IS_DEPLOYED SMALLINT NOT NULL DEFAULT 0,
        	          CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
                    STOP_ON_QUOTA_REACH SMALLINT NOT NULL DEFAULT 0,
                    BILLING_PLAN VARCHAR(20) NOT NULL,
                    UUID VARCHAR(256) NOT NULL,
                    PRIMARY KEY (POLICY_ID),
                    CONSTRAINT AM_POLICY_SUBSCRIPTION_NAME_TENANT UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )/
        
        CREATE TABLE AM_POLICY_APPLICATION (
                    POLICY_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INT NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED SMALLINT NOT NULL DEFAULT 0,
        	          CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
        	          UUID VARCHAR(256) NOT NULL,
                    PRIMARY KEY (POLICY_ID),
                    CONSTRAINT APP_NAME_TENANT UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )/
        
        CREATE TABLE AM_POLICY_HARD_THROTTLING (
                    POLICY_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    NAME VARCHAR(512) NOT NULL,
                    TENANT_ID INT NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INT NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED SMALLINT NOT NULL DEFAULT 0,
                    PRIMARY KEY (POLICY_ID),
                    CONSTRAINT POLICY_HARD_NAME_TENANT UNIQUE (NAME, TENANT_ID)
        )/
        
        
        CREATE TABLE AM_API_THROTTLE_POLICY (
                    POLICY_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT NOT NULL,
                    DESCRIPTION VARCHAR (1024),
                    DEFAULT_QUOTA_TYPE VARCHAR(25) NOT NULL,
                    DEFAULT_QUOTA INTEGER NOT NULL,
                    DEFAULT_QUOTA_UNIT VARCHAR(10) NULL,
                    DEFAULT_UNIT_TIME INTEGER NOT NULL,
                    DEFAULT_TIME_UNIT VARCHAR(25) NOT NULL,
                    APPLICABLE_LEVEL VARCHAR(25) NOT NULL,
                    IS_DEPLOYED SMALLINT NOT NULL DEFAULT 0,
                    UUID VARCHAR(256) NOT NULL,
                    PRIMARY KEY (POLICY_ID),
                    CONSTRAINT API_NAME_TENANT UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )/
        
        CREATE TABLE AM_CONDITION_GROUP (
                    CONDITION_GROUP_ID INTEGER NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    POLICY_ID INTEGER NOT NULL,
                    QUOTA_TYPE VARCHAR(25),
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    DESCRIPTION VARCHAR (1024) NULL DEFAULT NULL,
                    PRIMARY KEY (CONDITION_GROUP_ID),
                    FOREIGN KEY (POLICY_ID) REFERENCES AM_API_THROTTLE_POLICY(POLICY_ID) ON DELETE CASCADE
        )/
        
        CREATE TABLE AM_QUERY_PARAMETER_CONDITION (
                    QUERY_PARAMETER_ID INTEGER NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    PARAMETER_NAME VARCHAR(255) DEFAULT NULL,
                    PARAMETER_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_PARAM_MAPPING SMALLINT DEFAULT 1,
                    PRIMARY KEY (QUERY_PARAMETER_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE
        )/
        
        CREATE TABLE AM_HEADER_FIELD_CONDITION (
                    HEADER_FIELD_ID INTEGER NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    HEADER_FIELD_NAME VARCHAR(255) DEFAULT NULL,
                    HEADER_FIELD_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_HEADER_FIELD_MAPPING SMALLINT DEFAULT 1,
                    PRIMARY KEY (HEADER_FIELD_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE
        )/
        
        CREATE TABLE AM_JWT_CLAIM_CONDITION (
                    JWT_CLAIM_ID INTEGER NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    CLAIM_URI VARCHAR(512) DEFAULT NULL,
                    CLAIM_ATTRIB VARCHAR(1024) DEFAULT NULL,
        	    IS_CLAIM_MAPPING SMALLINT DEFAULT 1,
                    PRIMARY KEY (JWT_CLAIM_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE
        )/
        
        CREATE TABLE AM_IP_CONDITION (
          AM_IP_CONDITION_ID INT NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
          STARTING_IP VARCHAR(45) NULL,
          ENDING_IP VARCHAR(45) NULL,
          SPECIFIC_IP VARCHAR(45) NULL,
          WITHIN_IP_RANGE SMALLINT DEFAULT 1,
          CONDITION_GROUP_ID INT NULL,
          PRIMARY KEY (AM_IP_CONDITION_ID),
          CONSTRAINT fk_AM_IP_CONDITION_1    FOREIGN KEY (CONDITION_GROUP_ID)
          REFERENCES AM_CONDITION_GROUP (CONDITION_GROUP_ID)   ON DELETE CASCADE)
        /
        
        
        CREATE TABLE AM_POLICY_GLOBAL (
                    POLICY_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
                    NAME VARCHAR(512) NOT NULL,
                    KEY_TEMPLATE VARCHAR(512) NOT NULL,
                    TENANT_ID INT NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    SIDDHI_QUERY BLOB DEFAULT NULL,
                    IS_DEPLOYED SMALLINT NOT NULL DEFAULT 0,
                    UUID VARCHAR(256) NOT NULL,
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (UUID)
        )/
        
        CREATE TABLE AM_THROTTLE_TIER_PERMISSIONS (
          THROTTLE_TIER_PERMISSIONS_ID INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
          TIER VARCHAR(50) NULL,
          PERMISSIONS_TYPE VARCHAR(50) NULL,
          ROLES VARCHAR(512) NULL,
          TENANT_ID INT NULL,
          PRIMARY KEY (THROTTLE_TIER_PERMISSIONS_ID))
        /
        
        CREATE TABLE AM_BLOCK_CONDITIONS (
          CONDITION_ID INT NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
          TYPE varchar(45) DEFAULT NULL,
          VALUE varchar(45) DEFAULT NULL,
          ENABLED varchar(45) DEFAULT NULL,
          DOMAIN varchar(45) DEFAULT NULL,
          UUID VARCHAR(256) NOT NULL,
          PRIMARY KEY (CONDITION_ID),
          UNIQUE (UUID)
        ) /
        
        -- End of API-MGT Tables --
        
        -- Performance indexes start--
        
        CREATE INDEX fk_AM_IP_CONDITION_1_idx ON AM_IP_CONDITION (CONDITION_GROUP_ID)/
        CREATE INDEX IDX_SUB_APP_ID ON AM_SUBSCRIPTION (APPLICATION_ID, SUBSCRIPTION_ID)/
        
        create index IDX_ITS_LMT on IDN_THRIFT_SESSION (LAST_MODIFIED_TIME)/
        create index IDX_IOAT_AT on IDN_OAUTH2_ACCESS_TOKEN (ACCESS_TOKEN)/
        create index IDX_IOAT_UT on IDN_OAUTH2_ACCESS_TOKEN (USER_TYPE)/
        create index IDX_AAI_CTX on AM_API (CONTEXT)/
        create index IDX_AAKM_CK on AM_APPLICATION_KEY_MAPPING (CONSUMER_KEY)/
        create index IDX_AAUM_AI on AM_API_URL_MAPPING (API_ID)/
        create index IDX_AAUM_TT on AM_API_URL_MAPPING (THROTTLING_TIER)/
        create index IDX_AATP_DQT on AM_API_THROTTLE_POLICY (DEFAULT_QUOTA_TYPE)/
        create index IDX_ACG_QT on AM_CONDITION_GROUP (QUOTA_TYPE)/
        create index IDX_APS_QT on AM_POLICY_SUBSCRIPTION (QUOTA_TYPE)/
        create index IDX_AS_AITIAI on AM_SUBSCRIPTION (API_ID,TIER_ID,APPLICATION_ID)/
        create index IDX_APA_QT on AM_POLICY_APPLICATION (QUOTA_TYPE)/
        create index IDX_AA_AT_CB on AM_APPLICATION (APPLICATION_TIER,CREATED_BY)/
        
        -- Performance indexes end--
        
        ALTER TABLE AM_SUBSCRIPTION_KEY_MAPPING ALTER COLUMN ACCESS_TOKEN SET DATA TYPE VARCHAR(512)
        /
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ALTER COLUMN TOKEN_SCOPE SET DATA TYPE VARCHAR(1500)
        /
        
        ALTER TABLE AM_APPLICATION ADD COLUMN TOKEN_TYPE VARCHAR(100)
        /
        
        ALTER TABLE AM_API_SCOPES ADD PRIMARY KEY (API_ID, SCOPE_ID)
        /
        
        DELETE FROM AM_ALERT_TYPES_VALUES WHERE ALERT_TYPE_ID = (SELECT ALERT_TYPE_ID FROM AM_ALERT_TYPES WHERE ALERT_TYPE_NAME = 'AbnormalRefreshAlert' AND STAKE_HOLDER = 'subscriber')
        /
        
        DROP TABLE AM_ALERT_TYPES
        /
        
        CREATE TABLE AM_ALERT_TYPES (
            ALERT_TYPE_ID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
            ALERT_TYPE_NAME VARCHAR(256) NOT NULL ,
            STAKE_HOLDER VARCHAR(100) NOT NULL,           
            PRIMARY KEY (ALERT_TYPE_ID)
        )
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalResponseTime', 'publisher')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalBackendTime', 'publisher')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestsPerMin', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestPattern', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccess', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierLimitHitting', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('ApiHealthMonitor', 'publisher')
        /
        
        CREATE TABLE AM_CERTIFICATE_METADATA (
            TENANT_ID INT NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            END_POINT VARCHAR(100) NOT NULL,
            CONSTRAINT PK_ALIAS PRIMARY KEY (ALIAS)
        ) 
        /
        
        CREATE TABLE IF NOT EXISTS AM_APPLICATION_GROUP_MAPPING (
            APPLICATION_ID INTEGER NOT NULL,
            GROUP_ID VARCHAR(512)NOT NULL,
            TENANT VARCHAR(255),
            PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE
        ) 
        /
        
        CREATE TABLE AM_USAGE_UPLOADED_FILES (
            TENANT_DOMAIN varchar(255) NOT NULL,
            FILE_NAME varchar(255) NOT NULL,
            FILE_TIMESTAMP TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
            FILE_PROCESSED SMALLINT NOT NULL DEFAULT 0,
            FILE_CONTENT BLOB DEFAULT NULL,
            PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP)
        ) 
        /
        
        CREATE TABLE AM_API_LC_PUBLISH_EVENTS (
            ID INTEGER NOT NULL,
            TENANT_DOMAIN VARCHAR(500) NOT NULL,
            API_ID VARCHAR(500) NOT NULL,
            EVENT_TIME TIMESTAMP(0) NOT NULL,
            PRIMARY KEY (ID)
        ) 
        /
        
        CREATE TABLE AM_LABELS (
            LABEL_ID VARCHAR(50) NOT NULL,
            NAME VARCHAR(255) NOT NULL,
            DESCRIPTION VARCHAR(1024),
            TENANT_DOMAIN VARCHAR(255) NOT NULL,
            UNIQUE (NAME,TENANT_DOMAIN),
            PRIMARY KEY (LABEL_ID)
        ) 
        /
        
        CREATE TABLE AM_LABEL_URLS (
            LABEL_ID VARCHAR(50) NOT NULL,
            ACCESS_URL VARCHAR(255) NOT NULL,
            PRIMARY KEY (LABEL_ID,ACCESS_URL),
            FOREIGN KEY (LABEL_ID) REFERENCES AM_LABELS(LABEL_ID) ON DELETE CASCADE
        ) 
        /
        
        CREATE TABLE AM_APPLICATION_ATTRIBUTES (
            APPLICATION_ID INTEGER NOT NULL,
            NAME VARCHAR(255) NOT NULL,
            VALUE VARCHAR(1024) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            PRIMARY KEY (APPLICATION_ID,NAME),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION (APPLICATION_ID) ON DELETE CASCADE
        ) 
        /
        
        CREATE INDEX IDX_AUTHORIZATION_CODE ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHORIZATION_CODE,CONSUMER_KEY_ID)
        /
        
        CREATE TABLE AM_SYSTEM_APPS (
            ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
            UNIQUE (NAME),
            UNIQUE (CONSUMER_KEY),
            PRIMARY KEY (ID)
        )
        /
        
        CREATE TABLE AM_API_CLIENT_CERTIFICATE (
            TENANT_ID INT NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            API_ID INTEGER NOT NULL,
            CERTIFICATE BLOB NOT NULL,
            REMOVED SMALLINT NOT NULL DEFAULT 0,
            TIER_NAME VARCHAR (512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
            PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
        )
        /
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION 
            ADD MONETIZATION_PLAN VARCHAR(25) DEFAULT NULL
            ADD FIXED_RATE VARCHAR(15) DEFAULT NULL
            ADD BILLING_CYCLE VARCHAR(15) DEFAULT NULL 
            ADD PRICE_PER_REQUEST VARCHAR(15) DEFAULT NULL 
            ADD CURRENCY VARCHAR(15) DEFAULT NULL
        /
        
        CREATE TABLE AM_MONETIZATION_USAGE (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        )
        /
        
        ALTER TABLE AM_API_COMMENTS DROP PRIMARY KEY;
        ALTER TABLE AM_API_COMMENTS DROP COMMENT_ID;
        ALTER TABLE AM_API_COMMENTS ADD COMMENT_ID VARCHAR(255) NOT NULL DEFAULT '0';
        CALL ADMIN_CMD('REORG table AM_API_COMMENTS');
        UPDATE AM_API_COMMENTS SET COMMENT_ID=(hex(GENERATE_UNIQUE())) WHERE COMMENT_ID='0';
        ALTER TABLE AM_API_COMMENTS PRIMARY KEY (COMMENT_ID);
        
        ALTER TABLE AM_API_RATINGS DROP PRIMARY KEY;
        ALTER TABLE AM_API_RATINGS DROP RATING_ID;
        ALTER TABLE AM_API_RATINGS ADD RATING_ID VARCHAR(255) NOT NULL DEFAULT '0';
        CALL ADMIN_CMD('REORG table AM_API_RATINGS');
        UPDATE AM_API_RATINGS SET RATING_ID=(hex(GENERATE_UNIQUE())) WHERE RATING_ID='0';
        ALTER TABLE AM_API_RATINGS PRIMARY KEY (RATING_ID);
        
        CREATE TABLE IF NOT EXISTS AM_NOTIFICATION_SUBSCRIBER (
            UUID VARCHAR(255) NOT NULL,
            CATEGORY VARCHAR(255) NOT NULL,
            NOTIFICATION_METHOD VARCHAR(255) NOT NULL,
            SUBSCRIBER_ADDRESS VARCHAR(255) NOT NULL,
            PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
        )
        /
        
        ALTER TABLE AM_EXTERNAL_STORES
            ADD LAST_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        /
        
        ALTER TABLE AM_API
            ADD API_TYPE VARCHAR(10) NULL DEFAULT NULL
        /
        
        CREATE TABLE AM_API_PRODUCT_MAPPING (
            API_PRODUCT_MAPPING_ID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
            API_ID INTEGER,
            URL_MAPPING_ID INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(API_PRODUCT_MAPPING_ID)
        )
        /
        
        CREATE TABLE AM_REVOKED_JWT (
            UUID VARCHAR(255) NOT NULL,
            SIGNATURE VARCHAR(2048) NOT NULL,
            EXPIRY_TIMESTAMP BIGINT NOT NULL,
            TENANT_ID INTEGER DEFAULT -1,
            TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
            TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (UUID)
        )
        /
        
        CREATE TABLE AM_API_CATEGORIES (
            UUID VARCHAR(50) NOT NULL,
            NAME VARCHAR(255) NOT NULL,
            DESCRIPTION VARCHAR(1024),
            TENANT_ID INTEGER NOT NULL DEFAULT -1,
            UNIQUE (NAME,TENANT_ID),
            PRIMARY KEY (UUID)
        ) /
        
        ALTER TABLE AM_SYSTEM_APPS
        ADD TENANT_DOMAIN VARCHAR(255) DEFAULT 'carbon.super'
        /
        
        CREATE TABLE AM_USER (
            USER_ID VARCHAR(255) NOT NULL,
            USER_NAME VARCHAR(255) NOT NULL,
            PRIMARY KEY(USER_ID)
        ) /
        
        CREATE TABLE AM_SECURITY_AUDIT_UUID_MAPPING (
            API_ID INTEGER NOT NULL,
            AUDIT_UUID VARCHAR(255) NOT NULL,
            PRIMARY KEY (API_ID),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID)
        ) /
        
        ALTER TABLE AM_WORKFLOWS
          ADD WF_METADATA BLOB DEFAULT NULL
          ADD WF_PROPERTIES BLOB DEFAULT NULL
        /
        
        CREATE TABLE AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          PRIMARY KEY (API_ID)
        ) /
        
        CREATE TABLE AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          ARTIFACT blob,
          GATEWAY_INSTRUCTION varchar(20),
          GATEWAY_LABEL varchar(255) NOT NULL,
          TIME_STAMP TIMESTAMP NOT NULL GENERATED ALWAYS FOR EACH ROW ON UPDATE AS ROW CHANGE TIMESTAMP,
          PRIMARY KEY (GATEWAY_LABEL, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS (API_ID) ON DELETE NO ACTION ON UPDATE RESTRICT
        ) /
        
        ALTER TABLE AM_SUBSCRIPTION ADD TIER_ID_PENDING VARCHAR(50) /
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION
            ADD MAX_COMPLEXITY INT NOT NULL DEFAULT 0
            ADD MAX_DEPTH INT NOT NULL DEFAULT 0
        /
        
        CREATE TABLE IF NOT EXISTS AM_API_RESOURCE_SCOPE_MAPPING (
            SCOPE_NAME varchar(255) NOT NULL,
            URL_MAPPING_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES   AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(SCOPE_NAME, URL_MAPPING_ID)
        ) /
        
        
        CREATE TABLE IF NOT EXISTS AM_SHARED_SCOPE (
             NAME varchar(255),
             UUID varchar(256) NOT NULL,
             TENANT_ID INTEGER,
             PRIMARY KEY (UUID)
        ) /
        
        ALTER TABLE IDN_OAUTH2_RESOURCE_SCOPE DROP PRIMARY KEY /
        
        CREATE TABLE AM_KEY_MANAGER (
          UUID VARCHAR(50) NOT NULL,
          NAME VARCHAR(100) NOT NULL,
          DISPLAY_NAME VARCHAR(100) NULL,
          DESCRIPTION VARCHAR(256) NULL,
          TYPE VARCHAR(45) NULL,
          CONFIGURATION BLOB NULL,
          ENABLED SMALLINT DEFAULT 1,
          TENANT_DOMAIN VARCHAR(100) NOT NULL,
          PRIMARY KEY (UUID),
          UNIQUE (NAME,TENANT_DOMAIN)
        )
         /
        
         CREATE TABLE AM_TENANT_THEMES (
          TENANT_ID INTEGER NOT NULL,
          THEME BLOB NOT NULL,
          PRIMARY KEY (TENANT_ID)
        ) /
        
        CREATE TABLE AM_GRAPHQL_COMPLEXITY (
            UUID VARCHAR(256) NOT NULL,
            API_ID INTEGER NOT NULL,
            TYPE VARCHAR(256) NOT NULL,
            FIELD VARCHAR(256) NOT NULL,
            COMPLEXITY_VALUE INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            PRIMARY KEY(UUID),
            UNIQUE (API_ID,TYPE,FIELD)
        )/
        
        UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL='' WHERE CALLBACK_URL IS NULL /
        
        BEGIN
        DECLARE const_name VARCHAR(128);
        DECLARE STMT VARCHAR(200);
        select CONSTNAME into const_name from SYSCAT.TABCONST WHERE TABNAME='AM_APPLICATION_REGISTRATION' AND TYPE = 'U';
        SET STMT = 'ALTER TABLE AM_APPLICATION_REGISTRATION DROP UNIQUE ' ||  const_name;
        PREPARE S1 FROM STMT;
        EXECUTE S1;
        END
        /
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD KEY_MANAGER VARCHAR(255) DEFAULT 'Resident Key Manager'/
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD UNIQUE (SUBSCRIBER_ID,APP_ID,TOKEN_TYPE,KEY_MANAGER)/
        
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD UUID VARCHAR(50)/
        UPDATE AM_APPLICATION_KEY_MAPPING SET UUID = (VARCHAR(HEX(GENERATE_UNIQUE()))) WHERE UUID IS NULL;
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD KEY_MANAGER VARCHAR(50) NOT NULL DEFAULT 'Resident Key Manager'/
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD APP_INFO BLOB/
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD UNIQUE(APPLICATION_ID,KEY_TYPE,KEY_MANAGER)/
        ALTER TABLE AM_APPLICATION_KEY_MAPPING DROP PRIMARY KEY/

        CREATE TABLE AM_SCOPE (
            SCOPE_ID INTEGER NOT NULL,
            NAME VARCHAR(255) NOT NULL,
            DISPLAY_NAME VARCHAR(255) NOT NULL,
            DESCRIPTION VARCHAR(512),
            TENANT_ID INTEGER NOT NULL DEFAULT -1,
            SCOPE_TYPE VARCHAR(255) NOT NULL,
            PRIMARY KEY (SCOPE_ID))
        /
        CREATE SEQUENCE AM_SCOPE_SEQUENCE START WITH 1 INCREMENT BY 1 NOCACHE
        /
        CREATE TRIGGER AM_SCOPE_TRIGGER NO CASCADE BEFORE INSERT ON AM_SCOPE
        REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL

        BEGIN ATOMIC

            SET (NEW.SCOPE_ID)
            = (NEXTVAL FOR AM_SCOPE_SEQUENCE);

        END
        /
        CREATE TABLE AM_SCOPE_BINDING (
                    SCOPE_ID INTEGER NOT NULL,
                    SCOPE_BINDING VARCHAR(255) NOT NULL,
                    BINDING_TYPE VARCHAR(255) NOT NULL,
                    FOREIGN KEY (SCOPE_ID) REFERENCES AM_SCOPE(SCOPE_ID) ON DELETE CASCADE)
        /
        ```

        ```tab="MSSQL"
        ALTER TABLE AM_API  ADD API_TIER VARCHAR(256);
        
        
        CREATE TABLE  AM_ALERT_TYPES (
                    ALERT_TYPE_ID INTEGER NOT NULL IDENTITY,
                    ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
        	          STAKE_HOLDER VARCHAR(10) NOT NULL,
                    PRIMARY KEY (ALERT_TYPE_ID)
        );
        
        CREATE TABLE  AM_ALERT_TYPES_VALUES (
                      ALERT_TYPE_ID INTEGER, 
                      USER_NAME VARCHAR(255) NOT NULL ,
        	      STAKE_HOLDER VARCHAR(100) NOT NULL ,
        	      CONSTRAINT AM_ALERT_TYPES_VALUES_CONST UNIQUE (ALERT_TYPE_ID,USER_NAME,STAKE_HOLDER)
        );
        
        CREATE TABLE AM_ALERT_EMAILLIST (  
        	     EMAIL_LIST_ID INTEGER NOT NULL IDENTITY,
                     USER_NAME VARCHAR(255) NOT NULL ,	    
        	     STAKE_HOLDER VARCHAR(100) NOT NULL ,
        	     CONSTRAINT AM_ALERT_EMAILLIST_CONST UNIQUE (EMAIL_LIST_ID,USER_NAME,STAKE_HOLDER),
                     PRIMARY KEY (EMAIL_LIST_ID)
        );
        
        CREATE TABLE  AM_ALERT_EMAILLIST_DETAILS (             
                      EMAIL_LIST_ID INTEGER,
        	      EMAIL VARCHAR(255),
        	      CONSTRAINT AM_ALERT_EMAILLIST_DETAILS_CONST UNIQUE (EMAIL_LIST_ID,EMAIL)
        );
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalResponseTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalBackendTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalRequestsPerMin', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('RequestPatternChanged', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccessAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRefreshAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierHittingAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalTierUsage', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('healthAvailabilityPerMin', 'publisher');
        
        
        
        -- AM Throttling tables --
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_POLICY_SUBSCRIPTION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_POLICY_SUBSCRIPTION (
                    POLICY_ID INTEGER IDENTITY(1,1),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    RATE_LIMIT_COUNT INTEGER NULL DEFAULT NULL,
                    RATE_LIMIT_TIME_UNIT VARCHAR(25) NULL DEFAULT NULL,
                    IS_DEPLOYED BIT NOT NULL DEFAULT 0,
        			CUSTOM_ATTRIBUTES VARBINARY(MAX) DEFAULT NULL,
                    STOP_ON_QUOTA_REACH BIT NOT NULL DEFAULT 0,
                    BILLING_PLAN VARCHAR(20) NOT NULL,
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_POLICY_APPLICATION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_POLICY_APPLICATION (
                    POLICY_ID INTEGER IDENTITY(1,1),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED BIT NOT NULL DEFAULT 0,
        			CUSTOM_ATTRIBUTES VARBINARY(MAX) DEFAULT NULL,
        			      UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE  (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_POLICY_HARD_THROTTLING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_POLICY_HARD_THROTTLING (
                    POLICY_ID INTEGER IDENTITY(1,1),
                    NAME VARCHAR(512) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED BIT NOT NULL DEFAULT 0,
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE  (NAME, TENANT_ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_THROTTLE_POLICY]') AND TYPE IN (N'U'))
        CREATE TABLE AM_API_THROTTLE_POLICY (
                    POLICY_ID INTEGER IDENTITY(1,1),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR (1024),
                    DEFAULT_QUOTA_TYPE VARCHAR(25) NOT NULL,
                    DEFAULT_QUOTA INTEGER NOT NULL,
                    DEFAULT_QUOTA_UNIT VARCHAR(10) NULL,
                    DEFAULT_UNIT_TIME INTEGER NOT NULL,
                    DEFAULT_TIME_UNIT VARCHAR(25) NOT NULL,
                    APPLICABLE_LEVEL VARCHAR(25) NOT NULL,
                    IS_DEPLOYED BIT NOT NULL DEFAULT 0,
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE  (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_CONDITION_GROUP]') AND TYPE IN (N'U'))
        CREATE TABLE AM_CONDITION_GROUP (
                    CONDITION_GROUP_ID INTEGER IDENTITY(1,1),
                    POLICY_ID INTEGER NOT NULL,
                    QUOTA_TYPE VARCHAR(25),
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    DESCRIPTION VARCHAR (1024) NULL DEFAULT NULL,
                    PRIMARY KEY (CONDITION_GROUP_ID),
                    FOREIGN KEY (POLICY_ID) REFERENCES AM_API_THROTTLE_POLICY(POLICY_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_QUERY_PARAMETER_CONDITION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_QUERY_PARAMETER_CONDITION (
                    QUERY_PARAMETER_ID INTEGER IDENTITY(1,1),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    PARAMETER_NAME VARCHAR(255) DEFAULT NULL,
                    PARAMETER_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_PARAM_MAPPING BIT DEFAULT 1,
                    PRIMARY KEY (QUERY_PARAMETER_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_HEADER_FIELD_CONDITION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_HEADER_FIELD_CONDITION (
                    HEADER_FIELD_ID INTEGER IDENTITY(1,1),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    HEADER_FIELD_NAME VARCHAR(255) DEFAULT NULL,
                    HEADER_FIELD_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_HEADER_FIELD_MAPPING BIT DEFAULT 1,
                    PRIMARY KEY (HEADER_FIELD_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_JWT_CLAIM_CONDITION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_JWT_CLAIM_CONDITION (
                    JWT_CLAIM_ID INTEGER IDENTITY(1,1),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    CLAIM_URI VARCHAR(512) DEFAULT NULL,
                    CLAIM_ATTRIB VARCHAR(1024) DEFAULT NULL,
        	    IS_CLAIM_MAPPING BIT DEFAULT 1,
                    PRIMARY KEY (JWT_CLAIM_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_IP_CONDITION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_IP_CONDITION (
          AM_IP_CONDITION_ID INTEGER IDENTITY(1,1),
          STARTING_IP VARCHAR(45) NULL,
          ENDING_IP VARCHAR(45) NULL,
          SPECIFIC_IP VARCHAR(45) NULL,
          WITHIN_IP_RANGE BIT DEFAULT 1,
          CONDITION_GROUP_ID INT NULL,
          PRIMARY KEY (AM_IP_CONDITION_ID),
          FOREIGN KEY (CONDITION_GROUP_ID)
            REFERENCES AM_CONDITION_GROUP (CONDITION_GROUP_ID)   ON DELETE CASCADE ON UPDATE CASCADE);
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_POLICY_GLOBAL]') AND TYPE IN (N'U'))
        CREATE TABLE AM_POLICY_GLOBAL (
                    POLICY_ID INTEGER IDENTITY(1,1),
                    NAME VARCHAR(512) NOT NULL,
                    KEY_TEMPLATE VARCHAR(512) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    SIDDHI_QUERY VARBINARY(MAX) DEFAULT NULL,
                    IS_DEPLOYED BIT NOT NULL DEFAULT 0,
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (UUID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_THROTTLE_TIER_PERMISSIONS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_THROTTLE_TIER_PERMISSIONS (
          THROTTLE_TIER_PERMISSIONS_ID INTEGER IDENTITY(1,1),
          TIER VARCHAR(50) NULL,
          PERMISSIONS_TYPE VARCHAR(50) NULL,
          ROLES VARCHAR(512) NULL,
          TENANT_ID INTEGER NULL,
          PRIMARY KEY (THROTTLE_TIER_PERMISSIONS_ID));
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_BLOCK_CONDITIONS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_BLOCK_CONDITIONS (
          CONDITION_ID INTEGER IDENTITY(1,1),
          TYPE varchar(45) DEFAULT NULL,
          VALUE varchar(45) DEFAULT NULL,
          ENABLED varchar(45) DEFAULT NULL,
          DOMAIN varchar(45) DEFAULT NULL,
          UUID VARCHAR(256),
          PRIMARY KEY (CONDITION_ID),
          UNIQUE (UUID)
        );
        
        -- End of API-MGT Tables --
        
        
        --Performance indexes start--
        
        create index IDX_ITS_LMT on IDN_THRIFT_SESSION (LAST_MODIFIED_TIME);
        create index IDX_IOAT_AT on IDN_OAUTH2_ACCESS_TOKEN (ACCESS_TOKEN);
        create index IDX_IOAT_UT on IDN_OAUTH2_ACCESS_TOKEN (USER_TYPE);
        create index IDX_AAI_CTX on AM_API (CONTEXT);
        create index IDX_AAKM_CK on AM_APPLICATION_KEY_MAPPING (CONSUMER_KEY);
        create index IDX_AAUM_AI on AM_API_URL_MAPPING (API_ID);
        create index IDX_AAUM_TT on AM_API_URL_MAPPING (THROTTLING_TIER);
        create index IDX_AATP_DQT on AM_API_THROTTLE_POLICY (DEFAULT_QUOTA_TYPE);
        create index IDX_ACG_QT on AM_CONDITION_GROUP (QUOTA_TYPE);
        create index IDX_APS_QT on AM_POLICY_SUBSCRIPTION (QUOTA_TYPE);
        create index IDX_AS_AITIAI on AM_SUBSCRIPTION (API_ID,TIER_ID,APPLICATION_ID);
        create index IDX_APA_QT on AM_POLICY_APPLICATION (QUOTA_TYPE);
        create index IDX_AA_AT_CB on AM_APPLICATION (APPLICATION_TIER,CREATED_BY);
        
        -- Performance indexes end--
        
        ALTER TABLE AM_SUBSCRIPTION_KEY_MAPPING ALTER COLUMN ACCESS_TOKEN VARCHAR(512);
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ALTER COLUMN TOKEN_SCOPE VARCHAR(1500);
        
        ALTER TABLE AM_APPLICATION ADD TOKEN_TYPE VARCHAR(10);
        
        ALTER TABLE AM_API_SCOPES ADD PRIMARY KEY (API_ID, SCOPE_ID);
        
        DELETE FROM AM_ALERT_TYPES_VALUES WHERE ALERT_TYPE_ID = (SELECT ALERT_TYPE_ID FROM AM_ALERT_TYPES WHERE ALERT_TYPE_NAME = 'AbnormalRefreshAlert' AND STAKE_HOLDER = 'subscriber');
        
        DROP TABLE IF EXISTS AM_ALERT_TYPES;
        
        CREATE TABLE  AM_ALERT_TYPES (
            ALERT_TYPE_ID INTEGER NOT NULL IDENTITY,
            ALERT_TYPE_NAME VARCHAR(255) NOT NULL,
            STAKE_HOLDER VARCHAR(10) NOT NULL,
            PRIMARY KEY (ALERT_TYPE_ID)
        );
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalResponseTime', 'publisher');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalBackendTime', 'publisher');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestsPerMin', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestPattern', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccess', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierLimitHitting', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('ApiHealthMonitor', 'publisher');
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_CERTIFICATE_METADATA]') AND TYPE IN (N'U'))
        CREATE TABLE AM_CERTIFICATE_METADATA (
            TENANT_ID INTEGER NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            END_POINT VARCHAR(100) NOT NULL,
            CONSTRAINT PK_ALIAS PRIMARY KEY (ALIAS),
            CONSTRAINT END_POINT_CONSTRAINT UNIQUE (END_POINT)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_APPLICATION_GROUP_MAPPING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_APPLICATION_GROUP_MAPPING (
            APPLICATION_ID INTEGER NOT NULL,
            GROUP_ID VARCHAR(512),
            TENANT VARCHAR(255),
            PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_USAGE_UPLOADED_FILES]') AND TYPE IN (N'U'))
        CREATE TABLE AM_USAGE_UPLOADED_FILES (
            TENANT_DOMAIN VARCHAR(255) NOT NULL,
            FILE_NAME VARCHAR(255) NOT NULL,
            FILE_TIMESTAMP DATETIME DEFAULT GETDATE(),
            FILE_PROCESSED INTEGER DEFAULT 0,
            FILE_CONTENT VARBINARY(MAX) DEFAULT NULL,
            PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_LC_PUBLISH_EVENTS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_API_LC_PUBLISH_EVENTS (
            ID INTEGER NOT NULL IDENTITY,
            TENANT_DOMAIN VARCHAR(255) NOT NULL,
            API_ID VARCHAR(500) NOT NULL,
            EVENT_TIME DATETIME DEFAULT GETDATE(),
            PRIMARY KEY (ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_APPLICATION_ATTRIBUTES]') AND TYPE IN (N'U'))
        CREATE TABLE AM_APPLICATION_ATTRIBUTES (
            APPLICATION_ID INTEGER NOT NULL,
            NAME VARCHAR(255) NOT NULL,
            VALUE VARCHAR(1024) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            PRIMARY KEY (APPLICATION_ID,NAME),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION (APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_LABELS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_LABELS (
            LABEL_ID VARCHAR(50),
            NAME VARCHAR(255),
            DESCRIPTION VARCHAR(1024),
            TENANT_DOMAIN VARCHAR(255),
            UNIQUE (NAME,TENANT_DOMAIN),
            PRIMARY KEY (LABEL_ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_LABEL_URLS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_LABEL_URLS (
            LABEL_ID VARCHAR(50),
            ACCESS_URL VARCHAR(255),
            PRIMARY KEY (LABEL_ID,ACCESS_URL),
            FOREIGN KEY (LABEL_ID) REFERENCES AM_LABELS(LABEL_ID) ON UPDATE CASCADE ON DELETE CASCADE
        );
        
        CREATE INDEX IDX_AUTHORIZATION_CODE ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHORIZATION_CODE,CONSUMER_KEY_ID);
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'AM_SYSTEM_APPS') AND TYPE IN (N'U'))
        CREATE TABLE AM_SYSTEM_APPS (
            ID INTEGER IDENTITY,
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME DATETIME2(6) DEFAULT CURRENT_TIMESTAMP,
            UNIQUE (NAME),
            UNIQUE (CONSUMER_KEY),
            PRIMARY KEY (ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_CLIENT_CERTIFICATE]') AND TYPE IN (N'U'))
        CREATE TABLE AM_API_CLIENT_CERTIFICATE (
            TENANT_ID INTEGER NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            API_ID INTEGER NOT NULL,
            CERTIFICATE VARBINARY(MAX) NOT NULL,
            REMOVED BIT NOT NULL DEFAULT 0,
            TIER_NAME VARCHAR(512),
            PRIMARY KEY (ALIAS, TENANT_ID, REMOVED),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE
        );
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD
        MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL,
        FIXED_RATE VARCHAR(15) NULL DEFAULT NULL, 
        BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL, 
        PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL, 
        CURRENCY VARCHAR(15) NULL DEFAULT NULL
        ;
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_MONETIZATION_USAGE]') AND TYPE IN (N'U'))
        
        CREATE TABLE AM_MONETIZATION_USAGE (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        );
        
        DECLARE @con_com as VARCHAR(8000);
        SET @con_com = (SELECT name from sys.objects where parent_object_id=object_id('AM_API_COMMENTS') AND type='PK');
        EXEC('ALTER TABLE AM_API_COMMENTS
        drop CONSTRAINT ' + @con_com);
        ALTER TABLE AM_API_COMMENTS
        DROP COLUMN COMMENT_ID;
        ALTER TABLE AM_API_COMMENTS
        ADD COMMENT_ID VARCHAR(255) NOT NULL DEFAULT NEWID();
        ALTER TABLE AM_API_COMMENTS
        ADD PRIMARY KEY (COMMENT_ID);
        
        DECLARE @con_rat as VARCHAR(8000);
        SET @con_rat = (SELECT name from sys.objects where parent_object_id=object_id('AM_API_RATINGS') AND type='PK');
        EXEC('ALTER TABLE AM_API_RATINGS
        drop CONSTRAINT ' + @con_rat);
        ALTER TABLE AM_API_RATINGS
        DROP COLUMN RATING_ID;
        ALTER TABLE AM_API_RATINGS
        ADD RATING_ID VARCHAR(255) NOT NULL DEFAULT NEWID();
        ALTER TABLE AM_API_RATINGS
        ADD PRIMARY KEY (RATING_ID);
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_NOTIFICATION_SUBSCRIBER]') AND TYPE IN (N'U'))
        CREATE TABLE AM_NOTIFICATION_SUBSCRIBER (
            UUID VARCHAR(255),
            CATEGORY VARCHAR(255),
            NOTIFICATION_METHOD VARCHAR(255),
            SUBSCRIBER_ADDRESS VARCHAR(255) NOT NULL,
            PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
        );
        
        ALTER TABLE AM_EXTERNAL_STORES
        ADD LAST_UPDATED_TIME DATETIME DEFAULT GETDATE();
        
        ALTER TABLE AM_API
            ADD API_TYPE VARCHAR(10) NULL DEFAULT NULL;
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_PRODUCT_MAPPING]') AND TYPE IN (N'U'))
        
        CREATE TABLE AM_API_PRODUCT_MAPPING (
            API_PRODUCT_MAPPING_ID INTEGER IDENTITY(1,1),
            API_ID INTEGER,
            URL_MAPPING_ID INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(API_PRODUCT_MAPPING_ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_REVOKED_JWT]') AND TYPE IN (N'U'))
        CREATE TABLE AM_REVOKED_JWT (
            UUID VARCHAR(255) NOT NULL,
            SIGNATURE VARCHAR(2048) NOT NULL,
            EXPIRY_TIMESTAMP BIGINT NOT NULL,
            TENANT_ID INTEGER DEFAULT -1,
            TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
            TIME_CREATED DATETIME DEFAULT GETDATE(),
            PRIMARY KEY (UUID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_CATEGORIES]') AND TYPE IN (N'U'))
        CREATE TABLE AM_API_CATEGORIES (
            UUID VARCHAR(50),
            NAME VARCHAR(255),
            DESCRIPTION VARCHAR(1024),
            TENANT_ID INTEGER DEFAULT -1,
            UNIQUE (NAME,TENANT_ID),
            PRIMARY KEY (UUID)
        );
        
        ALTER TABLE AM_SYSTEM_APPS
        ADD TENANT_DOMAIN VARCHAR(255) DEFAULT 'carbon.super';
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_USER]') AND TYPE IN (N'U'))
        CREATE TABLE AM_USER (
            USER_ID VARCHAR(255) NOT NULL,
            USER_NAME VARCHAR(255) NOT NULL,
            PRIMARY KEY(USER_ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_SECURITY_AUDIT_UUID_MAPPING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_SECURITY_AUDIT_UUID_MAPPING (
            API_ID INTEGER NOT NULL,
            AUDIT_UUID VARCHAR(255) NOT NULL,
            PRIMARY KEY (API_ID),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID)
        );
        
        ALTER TABLE AM_WORKFLOWS ADD
        WF_METADATA VARBINARY(MAX) NULL DEFAULT NULL,
        WF_PROPERTIES VARBINARY(MAX) NULL DEFAULT NULL
        ;
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GW_PUBLISHED_API_DETAILS]') AND TYPE IN (N'U'))
        CREATE TABLE  AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          PRIMARY KEY (API_ID)
        );
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GW_API_ARTIFACTS]') AND TYPE IN (N'U'))
        CREATE TABLE  AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          ARTIFACT VARBINARY(MAX),
          GATEWAY_INSTRUCTION varchar(20),
          GATEWAY_LABEL varchar(255),
          TIMESTAMP DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (GATEWAY_LABEL, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
        );
        
        GO
        CREATE TRIGGER dbo.TIMESTAMP ON dbo.AM_GW_API_ARTIFACTS
        AFTER INSERT, UPDATE
          AS
          UPDATE f set TIMESTAMP=GETDATE()
          FROM
          dbo.[AM_GW_API_ARTIFACTS] AS f
          INNER JOIN inserted
          AS i
          ON f.TIMESTAMP = i.TIMESTAMP;
        GO
        
        ALTER TABLE AM_SUBSCRIPTION ADD TIER_ID_PENDING VARCHAR(50);
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD
          MAX_COMPLEXITY INTEGER NOT NULL DEFAULT 0,
          MAX_DEPTH INTEGER NOT NULL DEFAULT 0
        ;
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_RESOURCE_SCOPE_MAPPING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_API_RESOURCE_SCOPE_MAPPING (
            SCOPE_NAME VARCHAR(255) NOT NULL,
            URL_MAPPING_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES   AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(SCOPE_NAME, URL_MAPPING_ID)
        );
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_SHARED_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE AM_SHARED_SCOPE (
            NAME VARCHAR(255),
            UUID VARCHAR (256),
            TENANT_ID INTEGER,
            PRIMARY KEY (UUID)
        );
        
        DECLARE @SQL VARCHAR(4000);
        SET @SQL = 'ALTER TABLE |TABLE_NAME| DROP CONSTRAINT |CONSTRAINT_NAME|';
        
        SET @SQL = REPLACE(@SQL, '|CONSTRAINT_NAME|',( SELECT name FROM sysobjects WHERE xtype = 'PK' AND parent_obj = OBJECT_ID('IDN_OAUTH2_RESOURCE_SCOPE')));
        SET @SQL = REPLACE(@SQL,'|TABLE_NAME|','IDN_OAUTH2_RESOURCE_SCOPE');
        EXEC (@SQL);
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_KEY_MANAGER]') AND TYPE IN (N'U'))
        CREATE TABLE AM_KEY_MANAGER (
          UUID VARCHAR(50) NOT NULL,
          NAME VARCHAR(100) NULL,
          DISPLAY_NAME VARCHAR(100) NULL,
          DESCRIPTION VARCHAR(256) NULL,
          TYPE VARCHAR(45) NULL,
          CONFIGURATION VARBINARY(MAX) NULL,
          ENABLED BIT DEFAULT 1,
          TENANT_DOMAIN VARCHAR(100) NULL,
          PRIMARY KEY (UUID),
          UNIQUE (NAME,TENANT_DOMAIN)
        );
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_TENANT_THEMES]') AND TYPE IN (N'U'))
        CREATE TABLE AM_TENANT_THEMES (
          TENANT_ID INTEGER NOT NULL,
          THEME VARBINARY(MAX) NOT NULL,
          PRIMARY KEY (TENANT_ID)
        );
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GRAPHQL_COMPLEXITY]') AND TYPE IN (N'U'))
        CREATE TABLE AM_GRAPHQL_COMPLEXITY (
            UUID VARCHAR(256),
            API_ID INTEGER NOT NULL,
            TYPE VARCHAR(256),
            FIELD VARCHAR(256),
            COMPLEXITY_VALUE INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE,
            PRIMARY KEY(UUID),
            UNIQUE (API_ID,TYPE,FIELD)
        );
        
        UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL='' WHERE CALLBACK_URL IS NULL;
        
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD UUID VARCHAR(50);
        GO
        UPDATE AM_APPLICATION_KEY_MAPPING SET UUID = NEWID() WHERE UUID IS NULL;
        GO
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD KEY_MANAGER VARCHAR(50) NOT NULL DEFAULT 'Resident Key Manager';
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD APP_INFO VARBINARY;
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD CONSTRAINT app_key_unique_cns UNIQUE (APPLICATION_ID,KEY_TYPE,KEY_MANAGER);
        DECLARE @ap_keymap as VARCHAR(8000);
        SET @ap_keymap = (SELECT name from sys.objects where parent_object_id=object_id('AM_APPLICATION_KEY_MAPPING') AND type='PK');
        EXEC('ALTER TABLE AM_APPLICATION_KEY_MAPPING
        drop CONSTRAINT ' + @ap_keymap);
        
        DECLARE @am_appreg as VARCHAR(8000);
        SET @am_appreg = (SELECT name from sys.objects where parent_object_id=object_id('AM_APPLICATION_REGISTRATION') AND type='UQ');
        EXEC('ALTER TABLE AM_APPLICATION_REGISTRATION
        drop CONSTRAINT ' + @am_appreg);
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD KEY_MANAGER VARCHAR(255) DEFAULT 'Resident Key Manager';
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD UNIQUE (SUBSCRIBER_ID,APP_ID,TOKEN_TYPE,KEY_MANAGER); 
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE AM_SCOPE (
          SCOPE_ID INTEGER IDENTITY,
          NAME VARCHAR(255) NOT NULL,
          DISPLAY_NAME VARCHAR(255) NOT NULL,
          DESCRIPTION VARCHAR(512),
          TENANT_ID INTEGER NOT NULL DEFAULT -1,
          SCOPE_TYPE VARCHAR(255) NOT NULL,
          PRIMARY KEY (SCOPE_ID)
        );
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_SCOPE_BINDING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_SCOPE_BINDING (
        SCOPE_ID INTEGER NOT NULL,
          SCOPE_BINDING VARCHAR(255) NOT NULL,
          BINDING_TYPE VARCHAR(255) NOT NULL,
          FOREIGN KEY (SCOPE_ID) REFERENCES AM_SCOPE(SCOPE_ID) ON DELETE CASCADE
        );        
        ```

        ```tab="MySQL"
        ALTER TABLE AM_API  ADD COLUMN API_TIER VARCHAR(256);
        ALTER TABLE AM_APPLICATION MODIFY COLUMN UUID VARCHAR(254);
        ALTER TABLE AM_SUBSCRIPTION MODIFY COLUMN UUID VARCHAR(254);
        ALTER TABLE AM_SUBSCRIPTION_KEY_MAPPING MODIFY COLUMN KEY_TYPE VARCHAR(255) NOT NULL;
        ALTER TABLE AM_APPLICATION_KEY_MAPPING MODIFY COLUMN KEY_TYPE VARCHAR(255) NOT NULL;
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
                    ALERT_TYPE_ID INTEGER AUTO_INCREMENT,
                    ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL,
                    PRIMARY KEY (ALERT_TYPE_ID)
        )ENGINE = INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES_VALUES (
                    ALERT_TYPE_ID INTEGER,
                    USER_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    CONSTRAINT AM_ALERT_TYPES_VALUES_CONSTRAINT UNIQUE (ALERT_TYPE_ID,USER_NAME,STAKE_HOLDER)
        )ENGINE = INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_EMAILLIST (
        	    EMAIL_LIST_ID INTEGER AUTO_INCREMENT,
                    USER_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    PRIMARY KEY (EMAIL_LIST_ID),
            	    CONSTRAINT AM_ALERT_EMAILLIST_CONSTRAINT UNIQUE (EMAIL_LIST_ID,USER_NAME,STAKE_HOLDER)
        )ENGINE = INNODB;
        
        CREATE TABLE IF NOT EXISTS  AM_ALERT_EMAILLIST_DETAILS (
                    EMAIL_LIST_ID INTEGER,
        	    EMAIL VARCHAR(255),
                    CONSTRAINT AM_ALERT_EMAILLIST_DETAILS_CONSTRAINT UNIQUE (EMAIL_LIST_ID,EMAIL)
        )ENGINE = INNODB;
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalResponseTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalBackendTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalRequestsPerMin', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('RequestPatternChanged', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccessAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRefreshAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierHittingAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalTierUsage', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('healthAvailabilityPerMin', 'publisher');
        
        -- AM Throttling tables --
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT(11) NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL,
                    UNIT_TIME INT(11) NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    RATE_LIMIT_COUNT INT(11) NULL DEFAULT NULL,
                    RATE_LIMIT_TIME_UNIT VARCHAR(25) NULL DEFAULT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
        	    CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
                    STOP_ON_QUOTA_REACH BOOLEAN NOT NULL DEFAULT 0,
                    BILLING_PLAN VARCHAR(20) NOT NULL,
                    UUID VARCHAR(254),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX AM_POLICY_SUBSCRIPTION_NAME_TENANT (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )ENGINE = InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_APPLICATION (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT(11) NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INT(11) NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
        	    CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
        	          UUID VARCHAR(254),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX APP_NAME_TENANT (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )ENGINE = InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_HARD_THROTTLING (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(255) NOT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INT(11) NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INT(11) NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX POLICY_HARD_NAME_TENANT (NAME, TENANT_ID)
        )ENGINE = InnoDB;
        
        
        CREATE TABLE IF NOT EXISTS AM_API_THROTTLE_POLICY (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR (1024),
                    DEFAULT_QUOTA_TYPE VARCHAR(25) NOT NULL,
                    DEFAULT_QUOTA INTEGER NOT NULL,
                    DEFAULT_QUOTA_UNIT VARCHAR(10) NULL,
                    DEFAULT_UNIT_TIME INTEGER NOT NULL,
                    DEFAULT_TIME_UNIT VARCHAR(25) NOT NULL,
                    APPLICABLE_LEVEL VARCHAR(25) NOT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                    UUID VARCHAR(254),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE INDEX API_NAME_TENANT (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_CONDITION_GROUP (
                    CONDITION_GROUP_ID INTEGER NOT NULL AUTO_INCREMENT,
                    POLICY_ID INTEGER NOT NULL,
                    QUOTA_TYPE VARCHAR(25),
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    DESCRIPTION VARCHAR (1024) NULL DEFAULT NULL,
                    PRIMARY KEY (CONDITION_GROUP_ID),
                    FOREIGN KEY (POLICY_ID) REFERENCES AM_API_THROTTLE_POLICY(POLICY_ID) ON DELETE CASCADE ON UPDATE CASCADE
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_QUERY_PARAMETER_CONDITION (
                    QUERY_PARAMETER_ID INTEGER NOT NULL AUTO_INCREMENT,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    PARAMETER_NAME VARCHAR(255) DEFAULT NULL,
                    PARAMETER_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_PARAM_MAPPING BOOLEAN DEFAULT 1,
                    PRIMARY KEY (QUERY_PARAMETER_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_HEADER_FIELD_CONDITION (
                    HEADER_FIELD_ID INTEGER NOT NULL AUTO_INCREMENT,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    HEADER_FIELD_NAME VARCHAR(255) DEFAULT NULL,
                    HEADER_FIELD_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_HEADER_FIELD_MAPPING BOOLEAN DEFAULT 1,
                    PRIMARY KEY (HEADER_FIELD_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_JWT_CLAIM_CONDITION (
                    JWT_CLAIM_ID INTEGER NOT NULL AUTO_INCREMENT,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    CLAIM_URI VARCHAR(512) DEFAULT NULL,
                    CLAIM_ATTRIB VARCHAR(1024) DEFAULT NULL,
        	    IS_CLAIM_MAPPING BOOLEAN DEFAULT 1,
                    PRIMARY KEY (JWT_CLAIM_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_IP_CONDITION (
          AM_IP_CONDITION_ID INT NOT NULL AUTO_INCREMENT,
          STARTING_IP VARCHAR(45) NULL,
          ENDING_IP VARCHAR(45) NULL,
          SPECIFIC_IP VARCHAR(45) NULL,
          WITHIN_IP_RANGE BOOLEAN DEFAULT 1,
          CONDITION_GROUP_ID INT NULL,
          PRIMARY KEY (AM_IP_CONDITION_ID),
          INDEX fk_AM_IP_CONDITION_1_idx (CONDITION_GROUP_ID ASC),  CONSTRAINT fk_AM_IP_CONDITION_1    FOREIGN KEY (CONDITION_GROUP_ID)
            REFERENCES AM_CONDITION_GROUP (CONDITION_GROUP_ID)   ON DELETE CASCADE ON UPDATE CASCADE)
        ENGINE = InnoDB;
        
        
        CREATE TABLE IF NOT EXISTS AM_POLICY_GLOBAL (
                    POLICY_ID INT(11) NOT NULL AUTO_INCREMENT,
                    NAME VARCHAR(255) NOT NULL,
                    KEY_TEMPLATE VARCHAR(512) NOT NULL,
                    TENANT_ID INT(11) NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    SIDDHI_QUERY BLOB DEFAULT NULL,
                    IS_DEPLOYED TINYINT(1) NOT NULL DEFAULT 0,
                    UUID VARCHAR(254),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (UUID)
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_THROTTLE_TIER_PERMISSIONS (
          THROTTLE_TIER_PERMISSIONS_ID INT NOT NULL AUTO_INCREMENT,
          TIER VARCHAR(50) NULL,
          PERMISSIONS_TYPE VARCHAR(50) NULL,
          ROLES VARCHAR(512) NULL,
          TENANT_ID INT(11) NULL,
          PRIMARY KEY (THROTTLE_TIER_PERMISSIONS_ID))
        ENGINE = InnoDB;
        
        CREATE TABLE `AM_BLOCK_CONDITIONS` (
          `CONDITION_ID` int(11) NOT NULL AUTO_INCREMENT,
          `TYPE` varchar(45) DEFAULT NULL,
          `VALUE` varchar(45) DEFAULT NULL,
          `ENABLED` varchar(45) DEFAULT NULL,
          `DOMAIN` varchar(45) DEFAULT NULL,
          `UUID` VARCHAR(254),
          PRIMARY KEY (`CONDITION_ID`),
          UNIQUE (`UUID`)
        ) ENGINE=InnoDB;
        
        -- End of API-MGT Tables --
        
        -- Performance indexes start--
        
        create index IDX_ITS_LMT on IDN_THRIFT_SESSION (LAST_MODIFIED_TIME);
        create index IDX_IOAT_AT on IDN_OAUTH2_ACCESS_TOKEN (ACCESS_TOKEN);
        create index IDX_IOAT_UT on IDN_OAUTH2_ACCESS_TOKEN (USER_TYPE);
        create index IDX_AAI_CTX on AM_API (CONTEXT);
        create index IDX_AAKM_CK on AM_APPLICATION_KEY_MAPPING (CONSUMER_KEY);
        create index IDX_AAUM_AI on AM_API_URL_MAPPING (API_ID);
        create index IDX_AAUM_TT on AM_API_URL_MAPPING (THROTTLING_TIER);
        create index IDX_AATP_DQT on AM_API_THROTTLE_POLICY (DEFAULT_QUOTA_TYPE);
        create index IDX_ACG_QT on AM_CONDITION_GROUP (QUOTA_TYPE);
        create index IDX_APS_QT on AM_POLICY_SUBSCRIPTION (QUOTA_TYPE);
        create index IDX_AS_AITIAI on AM_SUBSCRIPTION (API_ID,TIER_ID,APPLICATION_ID);
        create index IDX_APA_QT on AM_POLICY_APPLICATION (QUOTA_TYPE);
        create index IDX_AA_AT_CB on AM_APPLICATION (APPLICATION_TIER,CREATED_BY);
        
        -- Performance indexes end--
        
        ALTER TABLE AM_SUBSCRIPTION_KEY_MAPPING MODIFY ACCESS_TOKEN VARCHAR(512);
        ALTER TABLE AM_APPLICATION_REGISTRATION MODIFY TOKEN_SCOPE VARCHAR(1500);
        ALTER TABLE AM_APPLICATION ADD TOKEN_TYPE VARCHAR(10);
        ALTER TABLE AM_API_SCOPES ADD PRIMARY KEY (API_ID, SCOPE_ID);
        DELETE FROM AM_ALERT_TYPES_VALUES WHERE ALERT_TYPE_ID = (SELECT ALERT_TYPE_ID FROM AM_ALERT_TYPES WHERE ALERT_TYPE_NAME = 'AbnormalRefreshAlert' AND STAKE_HOLDER = 'subscriber');
        DROP TABLE IF EXISTS AM_ALERT_TYPES;
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
                    ALERT_TYPE_ID INTEGER AUTO_INCREMENT,
                    ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL,
                    PRIMARY KEY (ALERT_TYPE_ID)
        )ENGINE = INNODB;
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalResponseTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalBackendTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestsPerMin', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestPattern', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccess', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierLimitHitting', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('ApiHealthMonitor', 'publisher');
        
        CREATE TABLE IF NOT EXISTS `AM_CERTIFICATE_METADATA` (
          `TENANT_ID` INT(11) NOT NULL,
          `ALIAS` VARCHAR(45) NOT NULL,
          `END_POINT` VARCHAR(100) NOT NULL,
          CONSTRAINT PK_ALIAS PRIMARY KEY (`ALIAS`)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_APPLICATION_GROUP_MAPPING (
            APPLICATION_ID INTEGER NOT NULL,
            GROUP_ID VARCHAR(512)NOT NULL,
            TENANT VARCHAR(255),
            PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
          TENANT_DOMAIN varchar(255) NOT NULL,
          FILE_NAME varchar(255) NOT NULL,
          FILE_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          FILE_PROCESSED tinyint(1) DEFAULT FALSE,
          FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
          PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_API_LC_PUBLISH_EVENTS (
            ID INTEGER(11) NOT NULL AUTO_INCREMENT,
            TENANT_DOMAIN VARCHAR(500) NOT NULL,
            API_ID VARCHAR(500) NOT NULL,
            EVENT_TIME TIMESTAMP NOT NULL,
            PRIMARY KEY (ID)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_LABELS (
          LABEL_ID VARCHAR(50),
          NAME VARCHAR(255),
          DESCRIPTION VARCHAR(1024),
          TENANT_DOMAIN VARCHAR(255),
          UNIQUE (NAME,TENANT_DOMAIN),
          PRIMARY KEY (LABEL_ID)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_LABEL_URLS (
          LABEL_ID VARCHAR(50),
          ACCESS_URL VARCHAR(255),
          PRIMARY KEY (LABEL_ID,ACCESS_URL),
          FOREIGN KEY (LABEL_ID) REFERENCES AM_LABELS(LABEL_ID) ON UPDATE CASCADE ON DELETE CASCADE
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_APPLICATION_ATTRIBUTES (
          APPLICATION_ID int(11) NOT NULL,
          NAME varchar(255) NOT NULL,
          VALUE varchar(1024) NOT NULL,
          TENANT_ID int(11) NOT NULL,
          PRIMARY KEY (APPLICATION_ID,NAME),
          FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION (APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB;
        
        CREATE INDEX IDX_AUTHORIZATION_CODE ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHORIZATION_CODE,CONSUMER_KEY_ID);
        
        CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
            ID INTEGER AUTO_INCREMENT,
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE (NAME),
            UNIQUE (CONSUMER_KEY),
            PRIMARY KEY (ID)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_API_CLIENT_CERTIFICATE (
            TENANT_ID INT(11) NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            API_ID INTEGER NOT NULL,
            CERTIFICATE BLOB NOT NULL,
            REMOVED BOOLEAN NOT NULL DEFAULT 0,
            TIER_NAME VARCHAR (512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE ON UPDATE CASCADE,
            PRIMARY KEY (ALIAS,TENANT_ID, REMOVED)
        );
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION 
        ADD MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL, 
        ADD FIXED_RATE VARCHAR(15) NULL DEFAULT NULL, 
        ADD BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL, 
        ADD PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL, 
        ADD CURRENCY VARCHAR(15) NULL DEFAULT NULL;
        
        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        ) ENGINE INNODB;
        
        ALTER TABLE AM_API_COMMENTS
        MODIFY COLUMN COMMENT_ID VARCHAR(255) NOT NULL;
        
        ALTER TABLE AM_API_RATINGS
        MODIFY COLUMN RATING_ID VARCHAR(255) NOT NULL;
        
        CREATE TABLE IF NOT EXISTS AM_NOTIFICATION_SUBSCRIBER (
            UUID VARCHAR(255),
            CATEGORY VARCHAR(255),
            NOTIFICATION_METHOD VARCHAR(255),
            SUBSCRIBER_ADDRESS VARCHAR(255) NOT NULL,
            PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
        ) ENGINE INNODB;
        
        ALTER TABLE AM_EXTERNAL_STORES
        ADD LAST_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
        
        ALTER TABLE AM_API
        ADD API_TYPE VARCHAR(10) NULL DEFAULT NULL;
        
        CREATE TABLE IF NOT EXISTS AM_API_PRODUCT_MAPPING (
            API_PRODUCT_MAPPING_ID INTEGER AUTO_INCREMENT,
            API_ID INTEGER,
            URL_MAPPING_ID INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(API_PRODUCT_MAPPING_ID)
        ) ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS AM_REVOKED_JWT (
            UUID VARCHAR(255) NOT NULL,
            SIGNATURE VARCHAR(2048) NOT NULL,
            EXPIRY_TIMESTAMP BIGINT NOT NULL,
            TENANT_ID INTEGER DEFAULT -1,
            TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
            TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (UUID)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_API_CATEGORIES (
            UUID VARCHAR(50),
            NAME VARCHAR(255),
            DESCRIPTION VARCHAR(1024),
            TENANT_ID INTEGER DEFAULT -1,
            UNIQUE (NAME,TENANT_ID),
            PRIMARY KEY (UUID)
        ) ENGINE=InnoDB;
        
        ALTER TABLE AM_SYSTEM_APPS
        ADD TENANT_DOMAIN VARCHAR(255) DEFAULT 'carbon.super';
        
        ALTER TABLE AM_SYSTEM_APPS
        DROP INDEX NAME;
        
        CREATE TABLE IF NOT EXISTS AM_USER (
            USER_ID VARCHAR(255) NOT NULL,
            USER_NAME VARCHAR(255) NOT NULL,
            PRIMARY KEY(USER_ID)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_SECURITY_AUDIT_UUID_MAPPING (
            API_ID INTEGER NOT NULL,
            AUDIT_UUID VARCHAR(255) NOT NULL,
            PRIMARY KEY (API_ID),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID)
        ) ENGINE INNODB;
        
         CREATE TABLE IF NOT EXISTS AM_KEY_MANAGER (
          UUID VARCHAR(50) NOT NULL,
          NAME VARCHAR(100) NOT NULL,
          DISPLAY_NAME VARCHAR(100) NULL,
          DESCRIPTION VARCHAR(256) NULL,
          TYPE VARCHAR(45) NULL,
          CONFIGURATION BLOB NULL,
          ENABLED BOOLEAN DEFAULT 1,
          TENANT_DOMAIN VARCHAR(100) NULL,
          PRIMARY KEY (UUID),
          UNIQUE (NAME,TENANT_DOMAIN)
          );
        
         CREATE TABLE IF NOT EXISTS AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          PRIMARY KEY (API_ID)
         ) ENGINE=InnoDB;
        
         CREATE TABLE IF NOT EXISTS AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          ARTIFACT blob,
          GATEWAY_INSTRUCTION varchar(20),
          GATEWAY_LABEL varchar(255),
          TIME_STAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
          PRIMARY KEY (GATEWAY_LABEL, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
         ) ENGINE=InnoDB;
        
        SELECT CONCAT("ALTER TABLE AM_APPLICATION_REGISTRATION DROP INDEX ",constraint_name)
        INTO @sqlst
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        WHERE TABLE_SCHEMA = database() AND TABLE_NAME = "AM_APPLICATION_REGISTRATION"
        AND constraint_type='UNIQUE';
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD KEY_MANAGER VARCHAR(255) DEFAULT 'Resident Key Manager';
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD UNIQUE (SUBSCRIBER_ID,APP_ID,TOKEN_TYPE,KEY_MANAGER);
        
        PREPARE stmt FROM @sqlst;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SET @sqlst = NULL;
        
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD UUID VARCHAR(50);
        UPDATE AM_APPLICATION_KEY_MAPPING SET UUID = UUID() WHERE UUID IS NULL;
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD KEY_MANAGER VARCHAR(50) NOT NULL DEFAULT 'Resident Key Manager';
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD APP_INFO BLOB;
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD CONSTRAINT UNIQUE(APPLICATION_ID,KEY_TYPE,KEY_MANAGER);
        ALTER TABLE AM_APPLICATION_KEY_MAPPING DROP PRIMARY KEY;
        
        ALTER TABLE AM_WORKFLOWS ADD WF_METADATA BLOB NULL DEFAULT NULL;
        ALTER TABLE AM_WORKFLOWS ADD WF_PROPERTIES BLOB NULL DEFAULT NULL;
        
        ALTER TABLE AM_SUBSCRIPTION ADD TIER_ID_PENDING VARCHAR(50);
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD MAX_COMPLEXITY INT(11) NOT NULL DEFAULT 0;
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD MAX_DEPTH INT(11) NOT NULL DEFAULT 0;
        
        CREATE TABLE IF NOT EXISTS AM_API_RESOURCE_SCOPE_MAPPING (
            SCOPE_NAME VARCHAR(255) NOT NULL,
            URL_MAPPING_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES   AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(SCOPE_NAME, URL_MAPPING_ID)
        );
        
        
        CREATE TABLE IF NOT EXISTS AM_SHARED_SCOPE (
             NAME VARCHAR(255),
             UUID VARCHAR (256),
             TENANT_ID INTEGER,
             PRIMARY KEY (UUID)
        );
        
        ALTER TABLE IDN_OAUTH2_RESOURCE_SCOPE DROP PRIMARY KEY;
        
        CREATE TABLE IF NOT EXISTS AM_TENANT_THEMES (
          TENANT_ID INTEGER NOT NULL,
          THEME MEDIUMBLOB NOT NULL,
          PRIMARY KEY (TENANT_ID)
        ) ENGINE=InnoDB;
        
        CREATE TABLE IF NOT EXISTS AM_GRAPHQL_COMPLEXITY (
            UUID VARCHAR(256),
            API_ID INTEGER NOT NULL,
            TYPE VARCHAR(256),
            FIELD VARCHAR(256),
            COMPLEXITY_VALUE INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE,
            PRIMARY KEY(UUID),
            UNIQUE (API_ID,TYPE,FIELD)
        )ENGINE INNODB;
        
        UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL="" WHERE CALLBACK_URL IS NULL;

        CREATE TABLE IF NOT EXISTS AM_SCOPE (
            SCOPE_ID INTEGER NOT NULL AUTO_INCREMENT,
            NAME VARCHAR(255) NOT NULL,
            DISPLAY_NAME VARCHAR(255) NOT NULL,
            DESCRIPTION VARCHAR(512),
            TENANT_ID INTEGER NOT NULL DEFAULT -1,
            SCOPE_TYPE VARCHAR(255) NOT NULL,
            PRIMARY KEY (SCOPE_ID)
        )ENGINE INNODB;

        CREATE TABLE IF NOT EXISTS AM_SCOPE_BINDING (
                    SCOPE_ID INTEGER NOT NULL,
                    SCOPE_BINDING VARCHAR(255) NOT NULL,
                    BINDING_TYPE VARCHAR(255) NOT NULL,
                    FOREIGN KEY (SCOPE_ID) REFERENCES AM_SCOPE (SCOPE_ID) ON DELETE CASCADE
        )ENGINE INNODB;
        ```

        ```tab="Oracle"
        ALTER TABLE AM_API  ADD  API_TIER VARCHAR(256)
        /
        
        CREATE TABLE  AM_ALERT_TYPES (
                    ALERT_TYPE_ID INTEGER,
                    ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL,
                    PRIMARY KEY (ALERT_TYPE_ID))
        /
        
        CREATE SEQUENCE AM_ALERT_TYPES_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER AM_ALERT_TYPES_TRIG
                    BEFORE INSERT
                    ON AM_ALERT_TYPES
                    REFERENCING NEW AS NEW
                    FOR EACH ROW
                       BEGIN
                           SELECT AM_ALERT_TYPES_SEQ.nextval INTO :NEW.ALERT_TYPE_ID FROM dual;
                       END;
        /
        
        
        CREATE TABLE  AM_ALERT_TYPES_VALUES (
                    ALERT_TYPE_ID INTEGER,
                    USER_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    CONSTRAINT AM_ALERT_TYPES_VALUES_CONST UNIQUE (ALERT_TYPE_ID,USER_NAME,STAKE_HOLDER))
        /
        
        CREATE TABLE  AM_ALERT_EMAILLIST (
        	    EMAIL_LIST_ID INTEGER,
                    USER_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    CONSTRAINT AM_ALERT_EMAILLIST_CONST UNIQUE (EMAIL_LIST_ID,USER_NAME,STAKE_HOLDER),
                     PRIMARY KEY (EMAIL_LIST_ID))
        /
        
        CREATE SEQUENCE AM_ALERT_EMAILLIST_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER AM_ALERT_EMAILLIST_TRIG
                    BEFORE INSERT
                    ON AM_ALERT_EMAILLIST
                    REFERENCING NEW AS NEW
                    FOR EACH ROW
                       BEGIN
                           SELECT AM_ALERT_EMAILLIST_SEQ.nextval INTO :NEW.EMAIL_LIST_ID FROM dual;
                       END;
        /
        
        CREATE TABLE  AM_ALERT_EMAILLIST_DETAILS (
                    EMAIL_LIST_ID INTEGER,
        	    EMAIL VARCHAR(255),	    
                    CONSTRAINT AM_ALERT_EMAIL_LIST_DET_CONST UNIQUE (EMAIL_LIST_ID,EMAIL))
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalResponseTime', 'publisher')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalBackendTime', 'publisher')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalRequestsPerMin', 'subscriber')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('RequestPatternChanged', 'subscriber')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccessAlert', 'subscriber')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRefreshAlert', 'subscriber')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierHittingAlert', 'subscriber')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalTierUsage', 'publisher')
        /
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('healthAvailabilityPerMin', 'publisher')
        /
        
        -- AM Throttling tables --
        
        CREATE TABLE AM_POLICY_SUBSCRIPTION (
                    POLICY_ID INTEGER NOT NULL,
                    NAME VARCHAR2(512) NOT NULL,
                    DISPLAY_NAME VARCHAR2(512) DEFAULT NULL NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR2(1024) DEFAULT NULL NULL,
                    QUOTA_TYPE VARCHAR2(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR2(10) NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR2(25) NOT NULL,
                    RATE_LIMIT_COUNT INTEGER DEFAULT NULL NULL,
                    RATE_LIMIT_TIME_UNIT VARCHAR2(25) DEFAULT NULL NULL,
                    IS_DEPLOYED INTEGER DEFAULT 0 NOT NULL,
        	    CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
        	    STOP_ON_QUOTA_REACH INTEGER DEFAULT 0 NOT NULL,
        	    BILLING_PLAN VARCHAR2(20),
        	          UUID VARCHAR2(256),
                    PRIMARY KEY (POLICY_ID),
                    CONSTRAINT SUBSCRIPTION_NAME_TENANT UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_POLICY_SUBSCRIPTION_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_POLICY_SUBSCRIPTION_seq_tr
         BEFORE INSERT ON AM_POLICY_SUBSCRIPTION FOR EACH ROW
         WHEN (NEW.POLICY_ID IS NULL)
        BEGIN
         SELECT AM_POLICY_SUBSCRIPTION_seq.NEXTVAL INTO :NEW.POLICY_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_POLICY_APPLICATION (
                    POLICY_ID INTEGER NOT NULL,
                    NAME VARCHAR2(512) NOT NULL,
                    DISPLAY_NAME VARCHAR2(512) DEFAULT NULL NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR2(1024) DEFAULT NULL NULL,
                    QUOTA_TYPE VARCHAR2(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR2(10) DEFAULT NULL NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR2(25) NOT NULL,
                    IS_DEPLOYED INTEGER DEFAULT 0 NOT NULL,
        			CUSTOM_ATTRIBUTES BLOB DEFAULT NULL,
        			      UUID VARCHAR2(256),
                    PRIMARY KEY (POLICY_ID),
                    CONSTRAINT AM_POLICY_APP_NAME_TENANT UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_POLICY_APPLICATION_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_POLICY_APPLICATION_seq_tr
         BEFORE INSERT ON AM_POLICY_APPLICATION FOR EACH ROW
         WHEN (NEW.POLICY_ID IS NULL)
        BEGIN
         SELECT AM_POLICY_APPLICATION_seq.NEXTVAL INTO :NEW.POLICY_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_API_THROTTLE_POLICY (
                    POLICY_ID INTEGER NOT NULL,
                    NAME VARCHAR2(512) NOT NULL,
                    DISPLAY_NAME VARCHAR2(512) DEFAULT NULL NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR2 (1024),
                    DEFAULT_QUOTA_TYPE VARCHAR2(25) NOT NULL,
                    DEFAULT_QUOTA INTEGER NOT NULL,
                    DEFAULT_QUOTA_UNIT VARCHAR2(10) NULL,
                    DEFAULT_UNIT_TIME INTEGER NOT NULL,
                    DEFAULT_TIME_UNIT VARCHAR2(25) NOT NULL,
                    APPLICABLE_LEVEL VARCHAR2(25) NOT NULL,
                    IS_DEPLOYED INTEGER DEFAULT 0 NOT NULL,
                    UUID VARCHAR2(256),
                    PRIMARY KEY (POLICY_ID),
                    CONSTRAINT API_POLICY_NAME_TENANT UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_API_THROTTLE_POLICY_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_API_THROTTLE_POLICY_seq_tr
         BEFORE INSERT ON AM_API_THROTTLE_POLICY FOR EACH ROW
         WHEN (NEW.POLICY_ID IS NULL)
        BEGIN
         SELECT AM_API_THROTTLE_POLICY_seq.NEXTVAL INTO :NEW.POLICY_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_CONDITION_GROUP (
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    POLICY_ID INTEGER NOT NULL,
                    QUOTA_TYPE VARCHAR2(25),
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR2(10) DEFAULT NULL NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR2(25) NOT NULL,
                    DESCRIPTION VARCHAR2(1024) DEFAULT NULL NULL,
                    PRIMARY KEY (CONDITION_GROUP_ID),
                    FOREIGN KEY (POLICY_ID) REFERENCES AM_API_THROTTLE_POLICY(POLICY_ID) ON DELETE CASCADE
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_CONDITION_GROUP_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_CONDITION_GROUP_seq_tr
         BEFORE INSERT ON AM_CONDITION_GROUP FOR EACH ROW
         WHEN (NEW.CONDITION_GROUP_ID IS NULL)
        BEGIN
         SELECT AM_CONDITION_GROUP_seq.NEXTVAL INTO :NEW.CONDITION_GROUP_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_QUERY_PARAMETER_CONDITION (
                    QUERY_PARAMETER_ID INTEGER NOT NULL,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    PARAMETER_NAME VARCHAR2(255) DEFAULT NULL,
                    PARAMETER_VALUE VARCHAR2(255) DEFAULT NULL,
        	    	IS_PARAM_MAPPING CHAR(1) DEFAULT 1,
                    PRIMARY KEY (QUERY_PARAMETER_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE QUERY_PARAMETER_CONDITION_seq START WITH 1 INCREMENT BY 1
        /
        
        CREATE OR REPLACE TRIGGER QUERY_PARAMETER_CONDITION_tr
         BEFORE INSERT ON AM_QUERY_PARAMETER_CONDITION FOR EACH ROW
         WHEN (NEW.QUERY_PARAMETER_ID IS NULL)
        BEGIN
         SELECT AM_QUERY_PARAMETER_CONDITION_seq.NEXTVAL INTO :NEW.QUERY_PARAMETER_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_HEADER_FIELD_CONDITION (
                    HEADER_FIELD_ID INTEGER NOT NULL,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    HEADER_FIELD_NAME VARCHAR2(255) DEFAULT NULL,
                    HEADER_FIELD_VALUE VARCHAR2(255) DEFAULT NULL,
        	    	IS_HEADER_FIELD_MAPPING CHAR(1) DEFAULT 1,
                    PRIMARY KEY (HEADER_FIELD_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_HEADER_FIELD_CONDITION_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_HEADER_FIELD_CONDITION_tr
         BEFORE INSERT ON AM_HEADER_FIELD_CONDITION FOR EACH ROW
         WHEN (NEW.HEADER_FIELD_ID IS NULL)
        BEGIN
         SELECT AM_HEADER_FIELD_CONDITION_seq.NEXTVAL INTO :NEW.HEADER_FIELD_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_JWT_CLAIM_CONDITION (
                    JWT_CLAIM_ID INTEGER NOT NULL,
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    CLAIM_URI VARCHAR2(512) DEFAULT NULL,
                    CLAIM_ATTRIB VARCHAR2(1024) DEFAULT NULL,
        	    IS_CLAIM_MAPPING CHAR(1) DEFAULT 1,
                    PRIMARY KEY (JWT_CLAIM_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_JWT_CLAIM_CONDITION_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_JWT_CLAIM_CONDITION_seq_tr
         BEFORE INSERT ON AM_JWT_CLAIM_CONDITION FOR EACH ROW
         WHEN (NEW.JWT_CLAIM_ID IS NULL)
        BEGIN
         SELECT AM_JWT_CLAIM_CONDITION_seq.NEXTVAL INTO :NEW.JWT_CLAIM_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_IP_CONDITION (
          AM_IP_CONDITION_ID INTEGER NOT NULL,
          STARTING_IP VARCHAR2(45) NULL,
          ENDING_IP VARCHAR2(45) NULL,
          SPECIFIC_IP VARCHAR2(45) NULL,
          WITHIN_IP_RANGE CHAR(1) DEFAULT 1,
          CONDITION_GROUP_ID INTEGER NULL,
          PRIMARY KEY (AM_IP_CONDITION_ID)
         ,  CONSTRAINT fk_AM_IP_CONDITION_1    FOREIGN KEY (CONDITION_GROUP_ID)
            REFERENCES AM_CONDITION_GROUP (CONDITION_GROUP_ID)   ON DELETE CASCADE )
        
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_IP_CONDITION_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_IP_CONDITION_seq_tr
         BEFORE INSERT ON AM_IP_CONDITION FOR EACH ROW
         WHEN (NEW.AM_IP_CONDITION_ID IS NULL)
        BEGIN
         SELECT AM_IP_CONDITION_seq.NEXTVAL INTO :NEW.AM_IP_CONDITION_ID FROM DUAL;
        END;
        /
        
        CREATE INDEX fk_AM_IP_CONDITION_1_idx ON AM_IP_CONDITION (CONDITION_GROUP_ID ASC)
        /
        
        CREATE TABLE AM_POLICY_GLOBAL (
                    POLICY_ID INTEGER NOT NULL,
                    NAME VARCHAR2(512) NOT NULL,
                    KEY_TEMPLATE VARCHAR2(512) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR2(1024) DEFAULT NULL NULL,
                    SIDDHI_QUERY BLOB DEFAULT NULL,
                    IS_DEPLOYED INTEGER DEFAULT 0 NOT NULL,
                    UUID VARCHAR2(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (UUID)
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_POLICY_GLOBAL_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_POLICY_GLOBAL_seq_tr
         BEFORE INSERT ON AM_POLICY_GLOBAL FOR EACH ROW
         WHEN (NEW.POLICY_ID IS NULL)
        BEGIN
         SELECT AM_POLICY_GLOBAL_seq.NEXTVAL INTO :NEW.POLICY_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_THROTTLE_TIER_PERMISSIONS (
          THROTTLE_TIER_PERMISSIONS_ID INTEGER NOT NULL,
          TIER VARCHAR2(50) NULL,
          PERMISSIONS_TYPE VARCHAR2(50) NULL,
          ROLES VARCHAR2(512) NULL,
          TENANT_ID INTEGER NULL,
          PRIMARY KEY (THROTTLE_TIER_PERMISSIONS_ID))
        /
        
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE THROTTLE_TIER_PERMISSIONS_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER THROTTLE_TIER_PERMISSIONS_tr
         BEFORE INSERT ON AM_THROTTLE_TIER_PERMISSIONS FOR EACH ROW
         WHEN (NEW.THROTTLE_TIER_PERMISSIONS_ID IS NULL)
        BEGIN
         SELECT THROTTLE_TIER_PERMISSIONS_seq.NEXTVAL INTO :NEW.THROTTLE_TIER_PERMISSIONS_ID FROM DUAL;
        END;
        /
        
        CREATE TABLE AM_BLOCK_CONDITIONS (
          CONDITION_ID INTEGER NOT NULL,
          TYPE varchar2(45) DEFAULT NULL,
          VALUE varchar2(45) DEFAULT NULL,
          ENABLED varchar2(45) DEFAULT NULL,
          DOMAIN varchar2(45) DEFAULT NULL,
          UUID VARCHAR2(256),
          PRIMARY KEY (CONDITION_ID),
          UNIQUE (UUID)
        )
        /
        -- Generate ID using sequence and trigger
        CREATE SEQUENCE AM_BLOCK_CONDITIONS_seq START WITH 1 INCREMENT BY 1
        /
        CREATE OR REPLACE TRIGGER AM_BLOCK_CONDITIONS_seq_tr
         BEFORE INSERT ON AM_BLOCK_CONDITIONS FOR EACH ROW
         WHEN (NEW.CONDITION_ID IS NULL)
        BEGIN
         SELECT AM_BLOCK_CONDITIONS_seq.NEXTVAL INTO :NEW.CONDITION_ID FROM DUAL;
        END;
        /
        
        -- End of API-MGT Tables --
        
        --permance indexes start--
        /
        create index IDX_ITS_LMT on IDN_THRIFT_SESSION (LAST_MODIFIED_TIME)
        /
        create index IDX_IOAT_AT on IDN_OAUTH2_ACCESS_TOKEN (ACCESS_TOKEN)
        /
        create index IDX_IOAT_UT on IDN_OAUTH2_ACCESS_TOKEN (USER_TYPE)
        /
        create index IDX_AAI_CTX on AM_API (CONTEXT)
        /
        create index IDX_AAKM_CK on AM_APPLICATION_KEY_MAPPING (CONSUMER_KEY)
        /
        create index IDX_AAUM_AI on AM_API_URL_MAPPING (API_ID)
        /
        create index IDX_AAUM_TT on AM_API_URL_MAPPING (THROTTLING_TIER)
        /
        create index IDX_AATP_DQT on AM_API_THROTTLE_POLICY (DEFAULT_QUOTA_TYPE)
        /
        create index IDX_ACG_QT on AM_CONDITION_GROUP (QUOTA_TYPE)
        /
        create index IDX_APS_QT on AM_POLICY_SUBSCRIPTION (QUOTA_TYPE)
        /
        create index IDX_AS_AITIAI on AM_SUBSCRIPTION (API_ID,TIER_ID,APPLICATION_ID)
        /
        create index IDX_APA_QT on AM_POLICY_APPLICATION (QUOTA_TYPE)
        /
        create index IDX_AA_AT_CB on AM_APPLICATION (APPLICATION_TIER,CREATED_BY)
        /
        -- Performance indexes end--
        
        ALTER TABLE AM_APPLICATION_REGISTRATION MODIFY TOKEN_SCOPE VARCHAR(1500)
        /
        
        ALTER TABLE AM_SUBSCRIBER MODIFY USER_ID VARCHAR2(255)
        /
        
        ALTER TABLE AM_APPLICATION ADD TOKEN_TYPE VARCHAR2(100)
        /
        
        ALTER TABLE AM_API_SCOPES ADD PRIMARY KEY (API_ID, SCOPE_ID)
        /
        
        DELETE FROM AM_ALERT_TYPES_VALUES WHERE ALERT_TYPE_ID = (SELECT ALERT_TYPE_ID FROM AM_ALERT_TYPES WHERE ALERT_TYPE_NAME = 'AbnormalRefreshAlert' AND STAKE_HOLDER = 'subscriber')
        /
        
        DROP TABLE AM_ALERT_TYPES;
        /
        
        DROP SEQUENCE AM_ALERT_TYPES_SEQ;
        /
        
        CREATE TABLE  AM_ALERT_TYPES (
            ALERT_TYPE_ID INTEGER,
            ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
            STAKE_HOLDER VARCHAR(100) NOT NULL,
            PRIMARY KEY (ALERT_TYPE_ID))
        /
        
        CREATE SEQUENCE AM_ALERT_TYPES_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER AM_ALERT_TYPES_TRIG
            BEFORE INSERT
            ON AM_ALERT_TYPES
            REFERENCING NEW AS NEW
            FOR EACH ROW
                BEGIN
                    SELECT AM_ALERT_TYPES_SEQ.nextval INTO :NEW.ALERT_TYPE_ID FROM dual;
                END;
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalResponseTime', 'publisher')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalBackendTime', 'publisher')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestsPerMin', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestPattern', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccess', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierLimitHitting', 'subscriber')
        /
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('ApiHealthMonitor', 'publisher')
        /
        
        CREATE TABLE AM_CERTIFICATE_METADATA (
            TENANT_ID INTEGER NOT NULL,
            ALIAS VARCHAR2(45) NOT NULL,
            END_POINT VARCHAR2(100) NOT NULL,
            CONSTRAINT PK_ALIAS PRIMARY KEY (ALIAS)
        )
        /
        
        CREATE TABLE AM_APPLICATION_GROUP_MAPPING (
            APPLICATION_ID INTEGER NOT NULL,
            GROUP_ID VARCHAR2(512) NOT NULL,
            TENANT VARCHAR2 (255),
            PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE
        )
        /
        
        CREATE TABLE AM_USAGE_UPLOADED_FILES (
            TENANT_DOMAIN VARCHAR2 (255) NOT NULL,
            FILE_NAME VARCHAR2 (255) NOT NULL,
            FILE_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FILE_PROCESSED INTEGER DEFAULT 0,
            FILE_CONTENT BLOB DEFAULT NULL,
            PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP))
        /
        
        CREATE TABLE AM_API_LC_PUBLISH_EVENTS (
            ID INTEGER,
            TENANT_DOMAIN VARCHAR2 (500) NOT NULL,
            API_ID VARCHAR2 (500) NOT NULL,
            EVENT_TIME TIMESTAMP NOT NULL,
            PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE AM_API_LC_PUBLISH_EVENTS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER AM_API_LC_PUBLISH_EVENTS_TRIG
            BEFORE INSERT
            ON AM_API_LC_PUBLISH_EVENTS
            REFERENCING NEW AS NEW
            FOR EACH ROW
                BEGIN
                    SELECT AM_API_LC_PUBLISH_EVENTS_SEQ.nextval INTO :NEW.ID FROM dual;
                END;
        /
        
        CREATE TABLE AM_LABELS (
            LABEL_ID VARCHAR2(50),
            NAME VARCHAR2(255) NOT NULL,
            DESCRIPTION VARCHAR2(1024),
            TENANT_DOMAIN VARCHAR2(255),
            UNIQUE (NAME,TENANT_DOMAIN),
            PRIMARY KEY (LABEL_ID)
        )
        /
        
        CREATE TABLE AM_LABEL_URLS (
            LABEL_ID VARCHAR2(50),
            ACCESS_URL VARCHAR2(255),
            PRIMARY KEY (LABEL_ID,ACCESS_URL),
            FOREIGN KEY (LABEL_ID) REFERENCES AM_LABELS(LABEL_ID) ON DELETE CASCADE
            )
        /
        
        CREATE TABLE AM_APPLICATION_ATTRIBUTES (
            APPLICATION_ID INTEGER,
            NAME VARCHAR2(255),
            VALUE VARCHAR2(1024),
            TENANT_ID INTEGER,
            PRIMARY KEY (APPLICATION_ID,NAME),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION (APPLICATION_ID) ON DELETE CASCADE
            )
        /
        
        CREATE INDEX IDX_AUTHORIZATION_CODE ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHORIZATION_CODE,CONSUMER_KEY_ID)
        /
        
        CREATE TABLE AM_SYSTEM_APPS (
            ID INTEGER,
            NAME VARCHAR2(50) NOT NULL,
            CONSUMER_KEY VARCHAR2(512) NOT NULL,
            CONSUMER_SECRET VARCHAR2(512) NOT NULL,
            CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE (NAME),
            UNIQUE (CONSUMER_KEY),
            PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE AM_SYSTEM_APP_SEQUENCE START WITH 1 INCREMENT BY 1 NOCACHE
        /
        CREATE OR REPLACE TRIGGER AM_SYSTEM_APPS_TRIG
        BEFORE INSERT
        ON AM_SYSTEM_APPS
        REFERENCING NEW AS NEW
        FOR EACH ROW
            BEGIN
                SELECT AM_SYSTEM_APP_SEQUENCE.nextval INTO :NEW.ID FROM dual;
            END;
        /
        
        CREATE TABLE AM_API_CLIENT_CERTIFICATE (
            TENANT_ID INTEGER NOT NULL,
            ALIAS VARCHAR2(45) NOT NULL,
            API_ID INTEGER NOT NULL,
            CERTIFICATE BLOB NOT NULL,
            REMOVED INTEGER DEFAULT 0 NOT NULL,
            TIER_NAME VARCHAR2 (512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
            PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
        )
        /
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD (
            MONETIZATION_PLAN VARCHAR(25) DEFAULT NULL NULL, 
            FIXED_RATE VARCHAR(15) DEFAULT NULL NULL, 
            BILLING_CYCLE VARCHAR(15) DEFAULT NULL NULL, 
            PRICE_PER_REQUEST VARCHAR(15) DEFAULT NULL NULL, 
            CURRENCY VARCHAR(15) DEFAULT NULL NULL
        )
        /
        
        CREATE TABLE AM_MONETIZATION_USAGE (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        )
        /
        
        ALTER TABLE AM_API_COMMENTS
            DROP COLUMN COMMENT_ID
        /
        
        ALTER TABLE AM_API_COMMENTS
            ADD COMMENT_ID VARCHAR(255) DEFAULT (SYS_GUID()) NOT NULL
        /
        
        ALTER TABLE AM_API_RATINGS
            DROP COLUMN RATING_ID
        /
        
        ALTER TABLE AM_API_RATINGS
            ADD RATING_ID VARCHAR(255) DEFAULT (SYS_GUID()) NOT NULL
        /
        
        CREATE TABLE AM_NOTIFICATION_SUBSCRIBER (
            UUID VARCHAR2(255),
            CATEGORY VARCHAR2(255),
            NOTIFICATION_METHOD VARCHAR2(255),
            SUBSCRIBER_ADDRESS VARCHAR2(255) NOT NULL,
            PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
        )
        /
        
        DROP SEQUENCE AM_API_COMMENTS_SEQUENCE
        /
        
        DROP TRIGGER AM_API_COMMENTS_TRIGGER
        /
        
        ALTER TABLE AM_EXTERNAL_STORES
        ADD LAST_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        /
        
        ALTER TABLE AM_API
        ADD API_TYPE VARCHAR(10) DEFAULT NULL NULL
        /
        
        CREATE TABLE AM_API_PRODUCT_MAPPING (
            API_PRODUCT_MAPPING_ID INTEGER,
            API_ID INTEGER,
            URL_MAPPING_ID INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(API_PRODUCT_MAPPING_ID)
        )
        /
        
        CREATE SEQUENCE AM_API_PRODUCT_MAPPING_SEQ START WITH 1 INCREMENT BY 1
        /
        
        CREATE OR REPLACE TRIGGER AM_API_PRODUCT_MAPPING_TRIGGER
        BEFORE INSERT
        ON AM_API_PRODUCT_MAPPING
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
            SELECT AM_API_PRODUCT_MAPPING_SEQ.nextval INTO :NEW.API_PRODUCT_MAPPING_ID FROM dual;
        END;
        /
        
        CREATE TABLE AM_REVOKED_JWT (
        UUID VARCHAR(255) NOT NULL,
        SIGNATURE VARCHAR(2048) NOT NULL,
        EXPIRY_TIMESTAMP NUMBER(19) NOT NULL,
        TENANT_ID INTEGER DEFAULT -1,
        TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
        TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (UUID)
        )
        /
        
        CREATE TABLE AM_API_CATEGORIES (
            UUID VARCHAR2(50),
            NAME VARCHAR2(255) NOT NULL,
            DESCRIPTION VARCHAR2(1024),
            TENANT_ID INTEGER DEFAULT -1,
            UNIQUE (NAME,TENANT_ID),
            PRIMARY KEY (UUID)
        )
        /
        
        ALTER TABLE AM_SYSTEM_APPS
        ADD TENANT_DOMAIN VARCHAR2(255) DEFAULT 'carbon.super'
        /
        
        ALTER TABLE AM_SYSTEM_APPS
        DROP UNIQUE (NAME)
        /
        
        CREATE TABLE AM_USER (
            USER_ID VARCHAR(255) NOT NULL,
            USER_NAME VARCHAR(255) NOT NULL,
            PRIMARY KEY(USER_ID)
        )
        /
        
        CREATE TABLE AM_SECURITY_AUDIT_UUID_MAPPING (
            API_ID INTEGER NOT NULL,
            AUDIT_UUID VARCHAR(255) NOT NULL,
            PRIMARY KEY (API_ID),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID)
        )
        /
        
        ALTER TABLE AM_WORKFLOWS ADD (
          WF_METADATA BLOB DEFAULT NULL NULL,
          WF_PROPERTIES BLOB DEFAULT NULL NULL
        )
        /
        
        CREATE TABLE AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          PRIMARY KEY (API_ID)
        )
        /
        
        CREATE TABLE AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          ARTIFACT blob,
          GATEWAY_INSTRUCTION varchar(20),
          GATEWAY_LABEL varchar(255),
          TIME_STAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (GATEWAY_LABEL, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON DELETE CASCADE
        )
        /
        
        CREATE OR REPLACE TRIGGER update_timestamp
            BEFORE INSERT OR UPDATE ON AM_GW_API_ARTIFACTS
            FOR EACH ROW
        BEGIN
            :NEW.TIME_STAMP := systimestamp;
        END;
        /
        
        ALTER TABLE AM_SUBSCRIPTION ADD TIER_ID_PENDING VARCHAR2(50)
        /
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD (
            MAX_COMPLEXITY INTEGER DEFAULT 0 NOT NULL,
            MAX_DEPTH INTEGER DEFAULT 0 NOT NULL
        )
        /
        
        CREATE TABLE AM_API_RESOURCE_SCOPE_MAPPING (
            SCOPE_NAME VARCHAR(255) NOT NULL,
            URL_MAPPING_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(SCOPE_NAME, URL_MAPPING_ID)
        )
        /
        
        CREATE TABLE AM_SHARED_SCOPE (
             NAME VARCHAR(255),
             UUID VARCHAR (256),
             TENANT_ID INTEGER,
             PRIMARY KEY (UUID)
        )
        /
        
        ALTER TABLE IDN_OAUTH2_RESOURCE_SCOPE DROP PRIMARY KEY
        /
        
        CREATE TABLE AM_KEY_MANAGER (
          UUID VARCHAR(50) NOT NULL,
          NAME VARCHAR(100) NULL,
          DISPLAY_NAME VARCHAR(100) NULL,
          DESCRIPTION VARCHAR(256) NULL,
          TYPE VARCHAR(45) NULL,
          CONFIGURATION BLOB NULL,
          ENABLED CHAR(1) DEFAULT 1,
          TENANT_DOMAIN VARCHAR(100) NULL,
          PRIMARY KEY (UUID),
          UNIQUE (NAME,TENANT_DOMAIN)
        )
        /
        
        CREATE TABLE AM_TENANT_THEMES (
          TENANT_ID INTEGER NOT NULL,
          THEME BLOB NOT NULL,
          PRIMARY KEY (TENANT_ID)
        )
        /
        
        CREATE TABLE AM_GRAPHQL_COMPLEXITY (
            UUID VARCHAR(256),
            API_ID INTEGER NOT NULL,
            TYPE VARCHAR(256),
            FIELD VARCHAR(256),
            COMPLEXITY_VALUE INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            PRIMARY KEY(UUID),
            UNIQUE (API_ID,TYPE,FIELD)
        )
        /
        
        UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL='' WHERE CALLBACK_URL IS NULL
        /
        
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD UUID VARCHAR(50)
        /
        UPDATE AM_APPLICATION_KEY_MAPPING SET UUID = SYS_GUID() WHERE UUID IS NULL
        /
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD KEY_MANAGER VARCHAR(50) DEFAULT 'Resident Key Manager' NOT NULL
        /
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD APP_INFO BLOB
        /
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD UNIQUE(APPLICATION_ID,KEY_TYPE,KEY_MANAGER)
        /
        ALTER TABLE AM_APPLICATION_KEY_MAPPING DROP PRIMARY KEY
        /
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD KEY_MANAGER VARCHAR2(255) DEFAULT 'Resident Key Manager' NOT NULL
        /
        ALTER TABLE AM_APPLICATION_REGISTRATION ADD UNIQUE(SUBSCRIBER_ID,APP_ID,TOKEN_TYPE,KEY_MANAGER)
        /
        
        CREATE TABLE AM_SCOPE (
                    SCOPE_ID INTEGER NOT NULL,
                    NAME VARCHAR2(255) NOT NULL,
                    DISPLAY_NAME VARCHAR2(255) NOT NULL,
                    DESCRIPTION VARCHAR2(512),
                    TENANT_ID INTEGER DEFAULT -1 NOT NULL,
                    SCOPE_TYPE VARCHAR2(255) NOT NULL,
                    PRIMARY KEY (SCOPE_ID))
        /
        CREATE SEQUENCE AM_SCOPE_SEQUENCE START WITH 1 INCREMENT BY 1 NOCACHE
        /
        CREATE OR REPLACE TRIGGER AM_SCOPE_TRIGGER
        		    BEFORE INSERT
                    ON AM_SCOPE
                    REFERENCING NEW AS NEW
                    FOR EACH ROW
                    BEGIN
                        SELECT AM_SCOPE_SEQUENCE.nextval INTO :NEW.SCOPE_ID FROM dual;
                    END;
        /
        CREATE TABLE AM_SCOPE_BINDING (
                    SCOPE_ID INTEGER NOT NULL,
                    SCOPE_BINDING VARCHAR2(255) NOT NULL,
                    BINDING_TYPE VARCHAR2(255) NOT NULL,
                    FOREIGN KEY (SCOPE_ID) REFERENCES AM_SCOPE(SCOPE_ID) ON DELETE CASCADE)
        /
        COMMIT;
        /       
        ```

        ```tab="PostgreSQL"
        ALTER TABLE AM_API  ADD COLUMN API_TIER VARCHAR(256);
        
        CREATE SEQUENCE AM_ALERT_TYPES_SEQ START WITH 1 INCREMENT BY 1;
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
                    ALERT_TYPE_ID INTEGER DEFAULT NEXTVAL('am_alert_types_seq'),
                    ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL,
                    PRIMARY KEY (ALERT_TYPE_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES_VALUES (
                    ALERT_TYPE_ID INTEGER,
                    USER_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    CONSTRAINT AM_ALERT_TYPES_VALUES_CONST UNIQUE (ALERT_TYPE_ID,USER_NAME,STAKE_HOLDER)
        );
        
        CREATE SEQUENCE AM_ALERT_EMAILLIST_SEQ START WITH 1 INCREMENT BY 1;
        
        CREATE TABLE IF NOT EXISTS AM_ALERT_EMAILLIST (
        	    EMAIL_LIST_ID INTEGER DEFAULT NEXTVAL('am_alert_emaillist_seq'),
                    USER_NAME VARCHAR(255) NOT NULL ,
        	    STAKE_HOLDER VARCHAR(100) NOT NULL ,
                    CONSTRAINT AM_ALERT_EMAILLIST_CONST UNIQUE (EMAIL_LIST_ID,USER_NAME,STAKE_HOLDER),
                    PRIMARY KEY (EMAIL_LIST_ID)
        );
        
        CREATE TABLE IF NOT EXISTS  AM_ALERT_EMAILLIST_DETAILS (
                    EMAIL_LIST_ID INTEGER,
        	    EMAIL VARCHAR(255),	    
                    CONSTRAINT AM_ALERT_EMAILLIST_DETAILS_CONST UNIQUE (EMAIL_LIST_ID,EMAIL)
        );
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalResponseTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalBackendTime', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('abnormalRequestsPerMin', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('RequestPatternChanged', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccessAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRefreshAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierHittingAlert', 'subscriber');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalTierUsage', 'publisher');
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('healthAvailabilityPerMin', 'publisher');
        
        
        
        -- AM Throttling tables --
        CREATE SEQUENCE AM_POLICY_SUBSCRIPTION_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                    POLICY_ID INTEGER DEFAULT NEXTVAL('AM_POLICY_SUBSCRIPTION_SEQ'),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    RATE_LIMIT_COUNT INTEGER NULL DEFAULT NULL,
                    RATE_LIMIT_TIME_UNIT VARCHAR(25) NULL DEFAULT NULL,
                    IS_DEPLOYED BOOLEAN NOT NULL DEFAULT '0',
        			      CUSTOM_ATTRIBUTES BYTEA DEFAULT NULL,
                    STOP_ON_QUOTA_REACH BOOLEAN NOT NULL DEFAULT '0',
                    BILLING_PLAN VARCHAR(20) NOT NULL,
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        CREATE SEQUENCE AM_POLICY_APPLICATION_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_POLICY_APPLICATION (
                    POLICY_ID INTEGER DEFAULT NEXTVAL('AM_POLICY_APPLICATION_SEQ'),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED BOOLEAN NOT NULL DEFAULT '0',
        			CUSTOM_ATTRIBUTES BYTEA DEFAULT NULL,
        			      UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE  (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        CREATE SEQUENCE AM_POLICY_HARD_THROTTLING_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_POLICY_HARD_THROTTLING (
                    POLICY_ID INTEGER DEFAULT NEXTVAL('AM_POLICY_HARD_THROTTLING_SEQ'),
                    NAME VARCHAR(512) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    QUOTA_TYPE VARCHAR(25) NOT NULL,
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    IS_DEPLOYED BOOLEAN NOT NULL DEFAULT '0',
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE  (NAME, TENANT_ID)
        );
        
        CREATE SEQUENCE AM_API_THROTTLE_POLICY_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_API_THROTTLE_POLICY (
                    POLICY_ID INTEGER DEFAULT NEXTVAL('AM_API_THROTTLE_POLICY_SEQ'),
                    NAME VARCHAR(512) NOT NULL,
                    DISPLAY_NAME VARCHAR(512) NULL DEFAULT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR (1024),
                    DEFAULT_QUOTA_TYPE VARCHAR(25) NOT NULL,
                    DEFAULT_QUOTA INTEGER NOT NULL,
                    DEFAULT_QUOTA_UNIT VARCHAR(10) NULL,
                    DEFAULT_UNIT_TIME INTEGER NOT NULL,
                    DEFAULT_TIME_UNIT VARCHAR(25) NOT NULL,
                    APPLICABLE_LEVEL VARCHAR(25) NOT NULL,
                    IS_DEPLOYED BOOLEAN NOT NULL DEFAULT '0',
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE  (NAME, TENANT_ID),
                    UNIQUE (UUID)
        );
        
        CREATE SEQUENCE AM_CONDITION_GROUP_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_CONDITION_GROUP (
                    CONDITION_GROUP_ID INTEGER DEFAULT NEXTVAL('AM_CONDITION_GROUP_SEQ'),
                    POLICY_ID INTEGER NOT NULL,
                    QUOTA_TYPE VARCHAR(25),
                    QUOTA INTEGER NOT NULL,
                    QUOTA_UNIT VARCHAR(10) NULL DEFAULT NULL,
                    UNIT_TIME INTEGER NOT NULL,
                    TIME_UNIT VARCHAR(25) NOT NULL,
                    DESCRIPTION VARCHAR (1024) NULL DEFAULT NULL,
                    PRIMARY KEY (CONDITION_GROUP_ID),
                    FOREIGN KEY (POLICY_ID) REFERENCES AM_API_THROTTLE_POLICY(POLICY_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE SEQUENCE AM_QUERY_PARAMETER_CONDITION_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_QUERY_PARAMETER_CONDITION (
                    QUERY_PARAMETER_ID INTEGER DEFAULT NEXTVAL('AM_QUERY_PARAMETER_CONDITION_SEQ'),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    PARAMETER_NAME VARCHAR(255) DEFAULT NULL,
                    PARAMETER_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_PARAM_MAPPING BOOLEAN DEFAULT '1',
                    PRIMARY KEY (QUERY_PARAMETER_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE SEQUENCE AM_HEADER_FIELD_CONDITION_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_HEADER_FIELD_CONDITION (
                    HEADER_FIELD_ID INTEGER DEFAULT NEXTVAL('AM_HEADER_FIELD_CONDITION_SEQ'),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    HEADER_FIELD_NAME VARCHAR(255) DEFAULT NULL,
                    HEADER_FIELD_VALUE VARCHAR(255) DEFAULT NULL,
        	    	IS_HEADER_FIELD_MAPPING BOOLEAN DEFAULT '1',
                    PRIMARY KEY (HEADER_FIELD_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE SEQUENCE AM_JWT_CLAIM_CONDITION_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_JWT_CLAIM_CONDITION (
                    JWT_CLAIM_ID INTEGER DEFAULT NEXTVAL('AM_JWT_CLAIM_CONDITION_SEQ'),
                    CONDITION_GROUP_ID INTEGER NOT NULL,
                    CLAIM_URI VARCHAR(512) DEFAULT NULL,
                    CLAIM_ATTRIB VARCHAR(1024) DEFAULT NULL,
        	    IS_CLAIM_MAPPING BOOLEAN DEFAULT '1',
                    PRIMARY KEY (JWT_CLAIM_ID),
                    FOREIGN KEY (CONDITION_GROUP_ID) REFERENCES AM_CONDITION_GROUP(CONDITION_GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        CREATE SEQUENCE AM_IP_CONDITION_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_IP_CONDITION (
          AM_IP_CONDITION_ID INTEGER DEFAULT NEXTVAL('AM_IP_CONDITION_SEQ'),
          STARTING_IP VARCHAR(45) NULL,
          ENDING_IP VARCHAR(45) NULL,
          SPECIFIC_IP VARCHAR(45) NULL,
          WITHIN_IP_RANGE BOOLEAN DEFAULT '1',
          CONDITION_GROUP_ID INT NULL,
          PRIMARY KEY (AM_IP_CONDITION_ID),
          FOREIGN KEY (CONDITION_GROUP_ID)
            REFERENCES AM_CONDITION_GROUP (CONDITION_GROUP_ID)   ON DELETE CASCADE ON UPDATE CASCADE);
        
        CREATE SEQUENCE AM_POLICY_GLOBAL_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_POLICY_GLOBAL (
                    POLICY_ID INTEGER DEFAULT NEXTVAL('AM_POLICY_GLOBAL_SEQ'),
                    NAME VARCHAR(512) NOT NULL,
                    KEY_TEMPLATE VARCHAR(512) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DESCRIPTION VARCHAR(1024) NULL DEFAULT NULL,
                    SIDDHI_QUERY BYTEA DEFAULT NULL,
                    IS_DEPLOYED BOOLEAN NOT NULL DEFAULT '0',
                    UUID VARCHAR(256),
                    PRIMARY KEY (POLICY_ID),
                    UNIQUE (UUID)
        );
        
        CREATE SEQUENCE AM_THROTTLE_TIER_PERMISSIONS_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_THROTTLE_TIER_PERMISSIONS (
          THROTTLE_TIER_PERMISSIONS_ID INTEGER DEFAULT NEXTVAL('AM_THROTTLE_TIER_PERMISSIONS_SEQ'),
          TIER VARCHAR(50) NULL,
          PERMISSIONS_TYPE VARCHAR(50) NULL,
          ROLES VARCHAR(512) NULL,
          TENANT_ID INTEGER NULL,
          PRIMARY KEY (THROTTLE_TIER_PERMISSIONS_ID));
        
        CREATE SEQUENCE AM_BLOCK_CONDITIONS_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE AM_BLOCK_CONDITIONS (
          CONDITION_ID INTEGER DEFAULT NEXTVAL('AM_BLOCK_CONDITIONS_SEQ'),
          TYPE varchar(45) DEFAULT NULL,
          VALUE varchar(45) DEFAULT NULL,
          ENABLED varchar(45) DEFAULT NULL,
          DOMAIN varchar(45) DEFAULT NULL,
          UUID VARCHAR(256),
          PRIMARY KEY (CONDITION_ID),
          UNIQUE (UUID)
        );
        
        -- End of API-MGT Tables --
        
        -- Performance indexes start--
        
        create index IDX_ITS_LMT on IDN_THRIFT_SESSION (LAST_MODIFIED_TIME);
        create index IDX_IOAT_AT on IDN_OAUTH2_ACCESS_TOKEN (ACCESS_TOKEN);
        create index IDX_IOAT_UT on IDN_OAUTH2_ACCESS_TOKEN (USER_TYPE);
        create index IDX_AAI_CTX on AM_API (CONTEXT);
        create index IDX_AAKM_CK on AM_APPLICATION_KEY_MAPPING (CONSUMER_KEY);
        create index IDX_AAUM_AI on AM_API_URL_MAPPING (API_ID);
        create index IDX_AAUM_TT on AM_API_URL_MAPPING (THROTTLING_TIER);
        create index IDX_AATP_DQT on AM_API_THROTTLE_POLICY (DEFAULT_QUOTA_TYPE);
        create index IDX_ACG_QT on AM_CONDITION_GROUP (QUOTA_TYPE);
        create index IDX_APS_QT on AM_POLICY_SUBSCRIPTION (QUOTA_TYPE);
        create index IDX_AS_AITIAI on AM_SUBSCRIPTION (API_ID,TIER_ID,APPLICATION_ID);
        create index IDX_APA_QT on AM_POLICY_APPLICATION (QUOTA_TYPE);
        create index IDX_AA_AT_CB on AM_APPLICATION (APPLICATION_TIER,CREATED_BY);
        
        -- Performance indexes end--
        
        ALTER TABLE AM_APPLICATION_REGISTRATION ALTER COLUMN TOKEN_SCOPE TYPE VARCHAR(1500);
        
        ALTER TABLE AM_APPLICATION ADD TOKEN_TYPE VARCHAR(10);
        
        ALTER TABLE AM_API_SCOPES ADD PRIMARY KEY (API_ID, SCOPE_ID);
        
        DELETE FROM AM_ALERT_TYPES_VALUES WHERE ALERT_TYPE_ID = (SELECT ALERT_TYPE_ID FROM AM_ALERT_TYPES WHERE ALERT_TYPE_NAME = 'AbnormalRefreshAlert' AND STAKE_HOLDER = 'subscriber');
        
        DROP TABLE IF EXISTS AM_ALERT_TYPES;
        DROP SEQUENCE IF EXISTS  AM_ALERT_TYPES_SEQ;
        CREATE SEQUENCE AM_ALERT_TYPES_SEQ START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
            ALERT_TYPE_ID INTEGER DEFAULT NEXTVAL('am_alert_types_seq'),
            ALERT_TYPE_NAME VARCHAR(255) NOT NULL ,
            STAKE_HOLDER VARCHAR(100) NOT NULL,           
            PRIMARY KEY (ALERT_TYPE_ID)
        );
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalResponseTime', 'publisher');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalBackendTime', 'publisher');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestsPerMin', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('AbnormalRequestPattern', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('UnusualIPAccess', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('FrequentTierLimitHitting', 'subscriber');
        
        INSERT INTO AM_ALERT_TYPES (ALERT_TYPE_NAME, STAKE_HOLDER) VALUES ('ApiHealthMonitor', 'publisher');
        
        DROP TABLE IF EXISTS AM_CERTIFICATE_METADATA;
        CREATE TABLE AM_CERTIFICATE_METADATA (
            TENANT_ID INTEGER NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            END_POINT VARCHAR(45) NOT NULL,
            CONSTRAINT PK_ALIAS PRIMARY KEY (ALIAS)
        );
        
        DROP TABLE IF EXISTS AM_APPLICATION_GROUP_MAPPING;
        CREATE TABLE AM_APPLICATION_GROUP_MAPPING (
            APPLICATION_ID INTEGER NOT NULL,
            GROUP_ID VARCHAR(512) NOT NULL,
            TENANT VARCHAR(255),
            PRIMARY KEY (APPLICATION_ID,GROUP_ID,TENANT),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        DROP TABLE IF EXISTS AM_USAGE_UPLOADED_FILES;
        CREATE TABLE AM_USAGE_UPLOADED_FILES (
            TENANT_DOMAIN VARCHAR(255) NOT NULL,
            FILE_NAME VARCHAR(255) NOT NULL,
            FILE_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            FILE_PROCESSED INTEGER DEFAULT 0,
            FILE_CONTENT BYTEA DEFAULT NULL,
            PRIMARY KEY (TENANT_DOMAIN, FILE_NAME, FILE_TIMESTAMP)
        );
        
        DROP TABLE IF EXISTS AM_API_LC_PUBLISH_EVENTS;
        DROP SEQUENCE IF EXISTS AM_API_LC_PUBLISH_EVENTS_PK_SEQ;
        CREATE SEQUENCE AM_API_LC_PUBLISH_EVENTS_PK_SEQ;
        CREATE TABLE IF NOT EXISTS AM_API_LC_PUBLISH_EVENTS (
            ID INTEGER NOT NULL DEFAULT NEXTVAL('AM_API_LC_PUBLISH_EVENTS_PK_SEQ'),
            TENANT_DOMAIN VARCHAR(500) NOT NULL,
            API_ID VARCHAR(500) NOT NULL,
            EVENT_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (ID)
        );
        
        DROP TABLE IF EXISTS AM_APPLICATION_ATTRIBUTES;
        CREATE TABLE IF NOT EXISTS AM_APPLICATION_ATTRIBUTES (
            APPLICATION_ID INTEGER NOT NULL,
            NAME VARCHAR(255) NOT NULL,
            VALUE VARCHAR(1024) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            PRIMARY KEY (APPLICATION_ID,NAME),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION (APPLICATION_ID) ON DELETE CASCADE ON UPDATE CASCADE
        );
        
        DROP TABLE IF EXISTS AM_LABELS;
        CREATE TABLE IF NOT EXISTS AM_LABELS (
            LABEL_ID VARCHAR(50),
            NAME VARCHAR(255),
            DESCRIPTION VARCHAR(1024),
            TENANT_DOMAIN VARCHAR(255),
            UNIQUE (NAME,TENANT_DOMAIN),
            PRIMARY KEY (LABEL_ID)
        );
        
        DROP TABLE IF EXISTS AM_LABEL_URLS;
        CREATE TABLE IF NOT EXISTS AM_LABEL_URLS (
            LABEL_ID VARCHAR(50),
            ACCESS_URL VARCHAR(255),
            PRIMARY KEY (LABEL_ID,ACCESS_URL),
            FOREIGN KEY (LABEL_ID) REFERENCES AM_LABELS(LABEL_ID) ON UPDATE CASCADE ON DELETE CASCADE
        );
        
        CREATE INDEX IDX_AUTHORIZATION_CODE ON IDN_OAUTH2_AUTHORIZATION_CODE (AUTHORIZATION_CODE,CONSUMER_KEY_ID);
        
        ALTER TABLE AM_SUBSCRIBER
            ALTER COLUMN DATE_SUBSCRIBED TYPE TIMESTAMP,
            ALTER COLUMN DATE_SUBSCRIBED SET NOT NULL,
            ALTER COLUMN CREATED_TIME TYPE TIMESTAMP,
            ALTER COLUMN UPDATED_TIME TYPE TIMESTAMP;
        
        ALTER TABLE AM_APPLICATION
            ALTER COLUMN CREATED_TIME TYPE TIMESTAMP,
            ALTER COLUMN UPDATED_TIME TYPE TIMESTAMP;
        
        ALTER TABLE AM_API
            ALTER COLUMN CREATED_TIME TYPE TIMESTAMP,
            ALTER COLUMN UPDATED_TIME TYPE TIMESTAMP;
        
        ALTER TABLE AM_SUBSCRIPTION
            ALTER COLUMN LAST_ACCESSED TYPE TIMESTAMP,
            ALTER COLUMN CREATED_TIME TYPE TIMESTAMP,
            ALTER COLUMN UPDATED_TIME TYPE TIMESTAMP;
        
        ALTER TABLE AM_API_LC_EVENT
            ALTER COLUMN EVENT_DATE TYPE TIMESTAMP,
            ALTER COLUMN EVENT_DATE SET NOT NULL;
        
        ALTER TABLE AM_API_COMMENTS
            ALTER COLUMN DATE_COMMENTED TYPE TIMESTAMP,
            ALTER COLUMN DATE_COMMENTED SET NOT NULL;
        
        DROP TABLE IF EXISTS AM_SYSTEM_APPS;
        CREATE SEQUENCE AM_API_SYSTEM_APPS_SEQUENCE START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
            ID INTEGER NOT NULL DEFAULT NEXTVAL('AM_API_SYSTEM_APPS_SEQUENCE'),
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            UNIQUE (NAME),
            UNIQUE (CONSUMER_KEY),
            PRIMARY KEY (ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_API_CLIENT_CERTIFICATE (
            TENANT_ID INTEGER NOT NULL,
            ALIAS VARCHAR(45) NOT NULL,
            API_ID INTEGER NOT NULL,
            CERTIFICATE BYTEA NOT NULL,
            REMOVED BOOLEAN NOT NULL DEFAULT '0',
            TIER_NAME VARCHAR(512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
            PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
        );
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL,
        ADD FIXED_RATE VARCHAR(15) NULL DEFAULT NULL, 
        ADD BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL, 
        ADD PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL, 
        ADD CURRENCY VARCHAR(15) NULL DEFAULT NULL;
        
        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        );
        
        CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
        
        ALTER TABLE AM_API_COMMENTS
        DROP COLUMN COMMENT_ID,
        ADD COLUMN COMMENT_ID VARCHAR(255) NOT NULL DEFAULT uuid_generate_v1(),
        ADD PRIMARY KEY (COMMENT_ID);
        
        ALTER TABLE AM_API_RATINGS
        DROP COLUMN RATING_ID,
        ADD COLUMN RATING_ID VARCHAR(255) NOT NULL DEFAULT uuid_generate_v1(),
        ADD PRIMARY KEY (RATING_ID);
        
        CREATE TABLE IF NOT EXISTS AM_NOTIFICATION_SUBSCRIBER (
            UUID VARCHAR(255),
            CATEGORY VARCHAR(255),
            NOTIFICATION_METHOD VARCHAR(255),
            SUBSCRIBER_ADDRESS VARCHAR(255) NOT NULL,
            PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
        );
        
        ALTER TABLE AM_EXTERNAL_STORES
        ADD LAST_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
        
        ALTER TABLE AM_API
        ADD API_TYPE VARCHAR(10) NULL DEFAULT NULL;
        
        CREATE SEQUENCE AM_API_PRODUCT_MAPPING_SEQUENCE START WITH 1 INCREMENT BY 1;
        CREATE TABLE IF NOT EXISTS AM_API_PRODUCT_MAPPING (
            API_PRODUCT_MAPPING_ID INTEGER DEFAULT nextval('am_api_product_mapping_sequence'),
            API_ID INTEGER,
            URL_MAPPING_ID INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(API_PRODUCT_MAPPING_ID)
        );
        
        DROP TABLE IF EXISTS AM_REVOKED_JWT;
        CREATE TABLE IF NOT EXISTS AM_REVOKED_JWT (
            UUID VARCHAR(255) NOT NULL,
            SIGNATURE VARCHAR(2048) NOT NULL,
            EXPIRY_TIMESTAMP BIGINT NOT NULL,
            TENANT_ID INTEGER DEFAULT -1,
            TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
            TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (UUID)
        );
        
        DROP TABLE IF EXISTS AM_API_CATEGORIES;
        CREATE TABLE IF NOT EXISTS AM_API_CATEGORIES (
            UUID VARCHAR(50),
            NAME VARCHAR(255),
            DESCRIPTION VARCHAR(1024),
            TENANT_ID INTEGER DEFAULT -1,
            UNIQUE (NAME,TENANT_ID),
            PRIMARY KEY (UUID)
        );
        
        ALTER TABLE AM_SYSTEM_APPS
        ADD TENANT_DOMAIN VARCHAR(255) DEFAULT 'carbon.super';
        
        ALTER TABLE AM_SYSTEM_APPS
        DROP CONSTRAINT AM_SYSTEM_APPS_NAME_KEY;
        
        DROP TABLE IF EXISTS AM_USER;
        CREATE TABLE IF NOT EXISTS AM_USER (
            USER_ID VARCHAR(255) NOT NULL,
            USER_NAME VARCHAR(255) NOT NULL,
            PRIMARY KEY(USER_ID)
        );
        
        DROP TABLE IF EXISTS AM_SECURITY_AUDIT_UUID_MAPPING;
        CREATE TABLE IF NOT EXISTS AM_SECURITY_AUDIT_UUID_MAPPING (
            API_ID INTEGER NOT NULL,
            AUDIT_UUID VARCHAR(255) NOT NULL,
            PRIMARY KEY (API_ID),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID)
        );
        
        DROP TABLE IF EXISTS AM_KEY_MANAGER;
        CREATE TABLE  IF NOT EXISTS AM_KEY_MANAGER (
          UUID VARCHAR(50) NOT NULL,
          NAME VARCHAR(100) NULL,
          DISPLAY_NAME VARCHAR(100) NULL,
          DESCRIPTION VARCHAR(256) NULL,
          TYPE VARCHAR(45) NULL,
          CONFIGURATION BYTEA NULL,
          ENABLED BOOLEAN DEFAULT '1',
          TENANT_DOMAIN VARCHAR(100) NULL,
          PRIMARY KEY (UUID),
          UNIQUE (NAME,TENANT_DOMAIN)
        );
        
        DROP TABLE IF EXISTS AM_GW_PUBLISHED_API_DETAILS;
        CREATE TABLE IF NOT EXISTS AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          PRIMARY KEY (API_ID)
        );
        
        DROP TABLE IF EXISTS AM_GW_API_ARTIFACTS;
        CREATE TABLE IF NOT EXISTS AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          ARTIFACT BYTEA,
          GATEWAY_INSTRUCTION varchar(20),
          GATEWAY_LABEL varchar(255),
          TIME_STAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (GATEWAY_LABEL, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
        );
        
        CREATE OR REPLACE FUNCTION update_modified_column()
        RETURNS TRIGGER AS $$
        BEGIN
            NEW.TIME_STAMP= now();
            RETURN NEW;
        END;
        $$ language 'plpgsql';
        
        CREATE TRIGGER TIME_STAMP AFTER UPDATE ON AM_GW_API_ARTIFACTS FOR EACH ROW EXECUTE PROCEDURE  update_modified_column();
        
        DO $$ DECLARE con_name varchar(200);
        BEGIN
        SELECT 'ALTER TABLE AM_APPLICATION_REGISTRATION DROP CONSTRAINT ' || tc .constraint_name || ';' INTO con_name
        FROM information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
        WHERE constraint_type = 'UNIQUE' AND tc.table_name = 'am_application_registration' AND kcu.column_name = 'token_type';
        
        EXECUTE con_name;
        END $$;
        
        ALTER TABLE AM_APPLICATION_REGISTRATION
            ADD KEY_MANAGER VARCHAR(255) DEFAULT 'Resident Key Manager',
            ADD UNIQUE (SUBSCRIBER_ID,APP_ID,TOKEN_TYPE,KEY_MANAGER);
        
        CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
        ALTER TABLE AM_APPLICATION_KEY_MAPPING
            ADD UUID VARCHAR(50) NOT NULL DEFAULT uuid_generate_v1(),
            ADD KEY_MANAGER VARCHAR(50) NOT NULL DEFAULT 'Resident Key Manager',
            ADD APP_INFO BYTEA NULL,
            ADD CONSTRAINT application_key_unique UNIQUE(APPLICATION_ID,KEY_TYPE,KEY_MANAGER);
        
        DO $$ DECLARE con_name varchar(200);
        BEGIN
        SELECT 'ALTER TABLE AM_APPLICATION_KEY_MAPPING DROP CONSTRAINT ' || tc .constraint_name || ';' INTO con_name
        FROM information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
        WHERE constraint_type = 'PRIMARY KEY' AND tc.table_name = 'am_application_key_mapping';
        EXECUTE con_name;
        END $$;
        
        ALTER TABLE AM_WORKFLOWS
            ADD WF_METADATA BYTEA NULL,
            ADD WF_PROPERTIES BYTEA NULL;
        
        ALTER TABLE AM_SUBSCRIPTION ADD TIER_ID_PENDING VARCHAR(50);
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION
            ADD MAX_COMPLEXITY INTEGER NOT NULL DEFAULT 0,
            ADD MAX_DEPTH INTEGER NOT NULL DEFAULT 0;
        
        CREATE TABLE IF NOT EXISTS AM_API_RESOURCE_SCOPE_MAPPING (
            SCOPE_NAME VARCHAR(255) NOT NULL,
            URL_MAPPING_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            FOREIGN KEY (URL_MAPPING_ID) REFERENCES   AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
            PRIMARY KEY(SCOPE_NAME, URL_MAPPING_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_SHARED_SCOPE (
             NAME VARCHAR(255),
             UUID VARCHAR (256),
             TENANT_ID INTEGER,
             PRIMARY KEY (UUID)
        );
        
        DO $$ DECLARE con_name varchar(200);
        BEGIN SELECT 'ALTER TABLE IDN_OAUTH2_RESOURCE_SCOPE DROP CONSTRAINT ' || tc .constraint_name || ';' INTO con_name
        FROM information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
        JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
        WHERE constraint_type = 'PRIMARY KEY' AND tc.table_name = 'IDN_OAUTH2_RESOURCE_SCOPE';
        EXECUTE con_name;
        END $$;
        
        DROP TABLE IF EXISTS AM_TENANT_THEMES;
        CREATE TABLE IF NOT EXISTS AM_TENANT_THEMES (
          TENANT_ID INTEGER NOT NULL,
          THEME BYTEA NOT NULL,
          PRIMARY KEY (TENANT_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_GRAPHQL_COMPLEXITY (
            UUID VARCHAR(256),
            API_ID INTEGER NOT NULL,
            TYPE VARCHAR(256),
            FIELD VARCHAR(256),
            COMPLEXITY_VALUE INTEGER,
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE,
            PRIMARY KEY(UUID),
            UNIQUE (API_ID,TYPE,FIELD)
        );
        
        DROP TABLE IF EXISTS AM_SCOPE;
        DROP SEQUENCE IF EXISTS AM_SCOPE_PK_SEQ;
        CREATE SEQUENCE AM_SCOPE_PK_SEQ;
        CREATE TABLE IF NOT EXISTS AM_SCOPE (
                    SCOPE_ID INTEGER DEFAULT NEXTVAL('AM_SCOPE_PK_SEQ'),
                    NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(255) NOT NULL,
                    DESCRIPTION VARCHAR(512),
                    TENANT_ID INTEGER NOT NULL DEFAULT -1,
                    SCOPE_TYPE VARCHAR(255) NOT NULL,
                    PRIMARY KEY (SCOPE_ID)
        );
        
        DROP TABLE IF EXISTS AM_SCOPE_BINDING;
        CREATE TABLE IF NOT EXISTS AM_SCOPE_BINDING (
                    SCOPE_ID INTEGER NOT NULL,
                    SCOPE_BINDING VARCHAR(255) NOT NULL,
                    BINDING_TYPE VARCHAR(255) NOT NULL,
                    FOREIGN KEY (SCOPE_ID) REFERENCES AM_SCOPE(SCOPE_ID) ON DELETE CASCADE
        );
        
        UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL='' WHERE CALLBACK_URL IS NULL;
        ```

5.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_4.0.0_HOME>/repository/resources/security` directory.

    !!! Attention
        In API Manager 4.0.0, it is required to use a certificate with the RSA key size greater than 2048. If you have used a certificate that has a weak RSA key (key size less than 2048) in the previous version, you need to add the following configuration to the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file to configure the internal and primary keystores. You should point the internal keystore to the keystore copied from API Manager 2.0.0 and the primary keystore can be pointed to a keystore with a certificate that has a strong RSA key. 

        ``` java
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
        If you have enabled Secure Vault in the previous API-M version, you need to add the property values again according to the new configuration model and run the following script. For more information, see [Encrypting Passwords in Configuration files]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords).

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

6.  Upgrade the Identity component in WSO2 API Manager from version 5.1.0 to 5.10.0.

    !!! note
        If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.10.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-510-to-5100) instead of the steps mentioned below.

        But, if you are not using WSO2 IS as a Key Manager, you have to follow the steps mentioned below in order to upgrade the identity components that have been shared with WSO2 API-M.

    ??? note "If you are using DB2"
        Move indexes to the TS32K Tablespace. The index tablespace in the `IDN_OAUTH2_ACCESS_TOKEN` and `IDN_OAUTH2_AUTHORIZATION_CODE` tables need to be moved to the existing TS32K tablespace in order to support the newly added table indexes.

        SQLADM or DBADM authority is required in order to invoke the `ADMIN_MOVE_TABLE` stored procedure. You must also have the appropriate object creation authorities, including authorities to issue the SELECT statement on the source table and to issue the INSERT statement on the target table. 

        ??? info "Click here to see the stored procedure" 
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

        If you get an error due to missing `SYSTOOLSPACE` or `SYSTOOLSTMPSPACE` tablespaces, create those tablespaces manually using the following script prior to executing the stored procedure given above. For more information, see [SYSTOOLSPACE and SYSTOOLSTMPSPACE table
        spaces](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_10.5.0/com.ibm.db2.luw.admin.gui.doc/doc/c0023713.html) in the IBM documentation.   

        ``` java
        CREATE TABLESPACE SYSTOOLSPACE IN IBMCATGROUP
        MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
        EXTENTSIZE 4;
        
        CREATE USER TEMPORARY TABLESPACE SYSTOOLSTMPSPACE IN IBMCATGROUP
        MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
        EXTENTSIZE 4;
        ```

    1.  Download the identity component migration resources and unzip it in a local directory.
        
        Navigate to the [latest release tag](https://github.com/wso2-extensions/identity-migration-resources/releases/latest) and download the `wso2is-migration-x.x.x.zip` under **Assets**.

    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_4.0.0_HOME>` directory.

    3.  Open the `migration-config.yaml` file in the `migration-resources` directory and make sure that the `currentVersion` element is set to 5.2.0, as shown below.

        ``` java
        migrationEnable: "true"
        currentVersion: "5.1.0"
        migrateVersion: "5.10.0"
        ```

        !!! note
            Make sure you have enabled migration by setting the `migrationEnable` element to `true` as shown above. You have to remove the following 2 steps from the `migration-config.yaml` file in version: "5.10.0"
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
                ```

    4. Remove the following entries from the `migration-config.yaml` file, which is in the `migration-resources` directory.

        ``` java
        -
        name: "EventPublisherMigrator"
        order: 11
        ```
        and
        ``` java
        -
        name: "ChallengeQuestionDataMigrator"
        order: 6
        parameters:
            schema: "identity"
        ```

    5.  Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

    6. Update the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the previous user store.
    
        ```
        [user_store]
        type = "database"
        ```

    7.  Start WSO2 API Manager 4.0.0 as follows to carry out the complete Identity component migration.
        
        !!! note
            If you are migrating your user stores to the new user store managers with the unique ID capabilities, follow the guidelines given in the [Migrating User Store Managers](https://is.docs.wso2.com/en/latest/setup/migrating-userstore-managers/) section before moving to the next step.

        ```tab="Linux / Mac OS"
        sh api-manager.sh -Dmigrate -Dcomponent=identity
        ```

        ```tab="Windows"
        api-manager.bat -Dmigrate -Dcomponent=identity
        ```

        !!! note
            Note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and wait until the migration process finishes completely and the server gets started.
        
        !!! note
            Note that if you want to use the latest user store, you need to update the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file as follows after the identity migration.

            ```
            [user_store]
            type = "database_unique_id"
            ``` 

        !!! warning "Troubleshooting"
            When running the above step if you encounter the following error message, follow the steps in this section. Note that the following error can occur only if the identity tables contain a huge volume of data.

            The following is a sample stack trace that contains the exception.
            ```
            ERROR {org.wso2.carbon.registry.core.dataaccess.TransactionManager} -  Failed to start new registry transaction. {org.wso2.carbon.registry.core.dataaccess.TransactionManager} org.apache.tomcat.jdbc.pool.PoolExhaustedException: [pool-30-thread-11] Timeout: Pool empty. Unable to fetch a connection in 60 seconds, none available[size:50; busy:50; idle:0; lastwait:60000
            ```
             <a name="stepT1"></a>
             1.  Add the following property in the `<API-M_HOME>/repository/conf/deployment.toml` file to a higher value (e.g., 10).
                 ```
                 [indexing]
                 frequency= 10
                 ```

             2.  Re-run the command above.

            **Make sure to revert the change done in <a href="#stepT1">Step 1</a>, after the migration is complete.**
    
    8.  After you have successfully completed the migration, stop the server, and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` directory, which is in the `<API-M_4.0.0_HOME>` directory.

        -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration, then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the `api-manager.bat` file.

            ```
            -Dmigrate -Dcomponent=identity
            ```

7.  Migrate the API Manager artifacts.

    1. Download and extract the [migration-resources.zip]({{base_path}}/assets/attachments/install-and-setup/migration-resources.zip).   
    
         Copy the extracted `migration-resources` and `migration-scripts` folders to the `<API-M_4.0.0_HOME>` folder.

    2. Download and copy the [API Manager Migration Client]({{base_path}}/assets/attachments/install-and-setup/org.wso2.carbon.apimgt.migrate.client-3.2.0-2.jar) to the `<API-M_4.0.0_HOME>/repository/components/dropins` folder.

    3. Migrate API Manager artifacts from 1.10 to 2.0
     
        1. Migrate registry resources from 1.10 to 2.0 as follows.
            ``` tab="Linux / Mac OS"
            sh api-manager.sh -DmigrateReg=true -Dcomponent=apim -DmigrateFromVersion=1.10.0
            ```
    
            ``` tab="Windows"
            api-manager.bat -DmigrateReg=true -Dcomponent=apim -DmigrateFromVersion=1.10.0
            ```
            
        2. Migrate file system from 1.10 to 2.0. 
        
             This migrates the Synapse config files such as APIs that reside in the file system. Therefore, you must run this command on the Gateway node/s of a distributed WSO2 API Manager setup.

            ``` tab="Linux / Mac OS"
            sh api-manager.sh -DmigrateFS=true -Dcomponent=apim -DmigrateFromVersion=1.10.0
            ```
    
            ``` tab="Windows"
            api-manager.bat -DmigrateFS=true -Dcomponent=apim -DmigrateFromVersion=1.10.0
            ```
        
        3. Migrate to the new throttling engine and generate throttle policies. 
        
             This migrates Synapse config files, the API-M database with new throttle policies and generates throttle policies in the `<API-M_4.0.0_HOME>/executionplans` directory. Therefore, you must run this command against a node that has Synapse config files and the `AM_DB`. After the migration, copy the `<API-M_4.0.0_HOME>/executionplans` directory to the `<API-M_4.0.0_HOME>/repository/deployment/server/executionplans` directory of the Traffic Manager node.

            ``` tab="Linux / Mac OS"
            sh api-manager.sh -Dcomponent=apim -DmigrateFromVersion=1.10.0 -Doptions=migrateThrottling
            ```
    
            ``` tab="Windows"
            api-manager.bat -Dcomponent=apim -DmigrateFromVersion=1.10.0 -Doptions=migrateThrottling
            ```
            
    4. Start the API-M server as follows to migrate API Manager artifacts from 2.0 to 3.2.
    
        ``` tab="Linux / Mac OS"
        sh api-manager.sh -DmigrateFromVersion=2.0.0
        ```

        ``` tab="Windows"
        api-manager.bat -DmigrateFromVersion=2.0.0
        ```

    4. Shutdown the API-M server.
    
       -   Remove the `org.wso2.carbon.apimgt.migrate.client-3.2.0-2.jar` file, which is in the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

       -   Remove the `migration-resources` and `migration-scripts` directories, which are in the `<API-M_4.0.0_HOME>` directory.

8.  Preserve the case sensitive behavior for the migrated resources by adding the following property to the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file:

    ``` java
    [authorization_manager.properties]
    PreserveCaseForResources = false
    ```

9. Re-index the artifacts in the Registry.

    1.  Run the [reg-index.sql]({{base_path}}/assets/attachments/install-and-setup/reg-index.sql) script against the `SHARED_DB` database.

        !!! note
            Note that depending on the number of records in the `REG_LOG` table, this script will take a considerable amount of time to finish. Do not stop the execution of the script until it is completed.

    2.  Add the [tenantloader-1.0.jar]({{base_path}}/assets/attachments/install-and-setup/tenantloader-1.0.jar) to the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

        !!! attention
            If you are working with a **clustered/distributed API Manager setup**,  carry out this step on the **Developer Portal** and the **Publisher** nodes.

        !!! note
            You need to do this step only if you have **multiple tenants**.

    3.  Add the following configuration in `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file.

        ```
        [indexing]
        re_indexing= 1
        ```
        Note that you need to increase the value of `re_indexing` by one each time you need to re-index.
        
        !!! info 
            If you use a clustered/distributed API Manager setup, do the above change in deployment.toml of Publisher and Devportal nodes
            
    4.  If the `<API-M_4.0.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

    5.  Start the WSO2 API-M server.

    6.  Shutdown the WSO2 API-M server and remove the `tenantloader-1.0.jar` from the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

This concludes the upgrading process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! note
    If you are using a migrated API and need to consume it via an application that supports JWT authentication (default type in API-M 4.0.0), you need to republish the API. JWT authentication will not work if you do not republish the API, as it looks for a local entry that will get populated while publishing.

    You can consume the migrated API via an OAuth2 application without an issue.

!!! note
    Prior to WSO2 API Manager 4.0.0, the distributed deployment comprised of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in APIM 4.0.0 only has three profiles, namely Gateway, Traffic Manager, and Default.
    All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Default profile.
    For more details on the WSO2 API-M 4.0.0 distributed deployment, see [WSO2 API Manager distributed documentation]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m).    

!!! important

    **From WSO2 API_M 4.0.0 onwards** error responses in API calls has changed from XML to JSON format.
    If you have developed client applications to handle XML error responses you give have to change the client applications to handle the JSON responses.
    As an example for a 404 error response previously it was as follows
       
        <am:fault xmlns:am="http://wso2.org/apimanager">
           <am:code>404</am:code>
           <am:type>Status report</am:type>
           <am:message>Not Found</am:message>
           <am:description>The requested resource is not available.</am:description>
        </am:fault>
     
    In API-M 4.0.0 onwards the above resopnse will changed as follows.
    
        {
           "code":"404",
           "type":"Status report",
           "message":"Not Found",
           "description":"The requested resource is not available."
        }
     
!!! important
        
    In API-M 4.0.0 following fault sequences were changed to send JSON responses as mentioned above. If you have done any custom changes to any of the following sequences previously,
    you have to add those custom changes manually to these changed files. 
    
    -   _auth_failure_handler_.xml
    -   _backend_failure_handler_.xml
    -   _block_api_handler_.xml
    -   _graphql_failure_handler_.xml
    -   _threat_fault_.xml
    -   _throttle_out_handler_.xml
    -   _token_fault_.xml
    -   fault.xml
    -   main.xml
