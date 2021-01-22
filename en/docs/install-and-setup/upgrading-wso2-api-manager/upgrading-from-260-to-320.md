# Upgrading API Manager from 2.6.0 to 3.2.0

The following information describes how to upgrade your API Manager server **from APIM 2.6.0 to 3.2.0**.

!!! note
    Before you follow this section, see [Upgrading Process]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-process) for more information.

!!! Attention
    If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, first you have to follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.10.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-570-to-5100) instead of below steps.

!!! note "If you are using PostgreSQL"
    The DB user needs to have superuser role to run the migration client and the relevant scripts
    ```
    ALTER USER <user> WITH SUPERUSER;
    ```
!!! note "If you are using Oracle"
    Please commit the changes after running the scripts given below
    
Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.6.0 to 3.2.0**.

### Preparing for Migration
#### Disabling versioning in the registry configuration

If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 3.2.0.

Therefore, if registry versioning was enabled in WSO2 API-M 2.6.0 setup, it is **required** run the below scripts against **the database that is used by the registry**. Follow the below steps to achieve this.

!!! note "NOTE"
    Alternatively, it is possible to turn on registry versioning in API Manager 3.2.0 and continue. But this is
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
    If you decide to proceed with registry resource versioning enabled, Add the following configuration to the `<NEW_API-M_HOME>/repository/conf/deployment.toml` file of new WSO2 API Manager. 
    
    ```
    [registry.static_configuration]
    enable=true
    ```
    
    !!! note "NOTE"
        Changing these configuration should only be done before the initial API-M Server startup. If changes are done after the initial startup, the registry resource created previously will not be available.

-   [Step 1 - Migrate the API Manager configurations](#step-1-migrate-the-api-manager-configurations)
-   [Step 2 - Upgrade API Manager to 3.2.0](#step-2-upgrade-api-manager-to-320)
-   [Step 3 - Optionally, migrate the configurations for WSO2 API-M Analytics](#step-3-optionally-migrate-the-configurations-for-wso2-api-m-analytics)
-   [Step 4 - Restart the WSO2 API-M 3.2.0 server](#step-4-restart-the-wso2-api-m-320-server)

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as the configuration modal has been changed and now all the configurations are being done via a single file (deployment.toml). Instead, redo the configuration changes in the new configuration file. For more information refer [Configuration Catalog]({{base_path}}/reference/config-catalog).

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Back up all databases in your API Manager instances along with the Synapse configurations of all the tenants and the super tenant.

    -   The Synapse configurations of the super tenant are in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory.

    -   The Synapse configurations of tenants are in the `<OLD_API-M_HOME>/repository/tenants` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the **API Gateway** node.

2.  Download [WSO2 API Manager 3.2.0](http://wso2.com/api-management/).

3.  Open the `<API-M_3.2.0_HOME>/repository/conf/deployment.toml` file and provide the datasource configurations for the following databases.

    -   User Store
    -   Registry database/s
    -   API Manager databases

    !!! note
        In API-M 3.x versions, a combined SHARED_DB has been introduced to keep both the user related data (`WSO2UM_DB`) and the registry data (`WSO2REG_DB`). If you have used separate DBs for user management and registry in the previous version, you need to configure WSO2REG_DB and WSO2UM_DB databases separately in API-M 3.2.0 to avoid any issues.

    SHARED_DB should point to the previous API-M version's `WSO2REG_DB`. This example shows to configure MySQL database configurations.

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

    Optionally add a new entry as below to the `deployment.toml` if you have configured a seperate user management database in the previous API-M version.

    ```
    [database.user]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/um_db"
    username = "username"
    password = "password"
    ```

    !!! note
        If you have configured WSO2CONFIG_DB in the previous API-M version, add a new entry to the `<API-M_3.2.0_HOME>/repository/conf/deployment.toml` as below.

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

4.  Update `<API-M_3.2.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the correct database for user management purposes.

    ```
    [realm_manager]
    data_source = "WSO2USER_DB"
    ```

5.  Copy the relevant JDBC driver to the `<API-M_3.2.0_HOME>/repository/components/lib` folder.

    !!! info
        In API-M 3.2.0, you do not need to configure the registry configurations as you did in the `<OLD_API-M_HOME>/repository/conf/registry.xml` file and the user database configurations as you did in in the `<OLD_API-M_HOME>/repository/conf/user-mgt.xml` file, as those configurations have been handled internally.

6.  Move all your Synapse configurations to API-M 3.2.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and replace the contents in the `<API-M_3.2.0_HOME>/repository/deployment/server/synapse-configs/default` directory with the copied contents.
    -   Move all your tenant Synapse configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/tenants` directory and replace the contents in the `<API-M_3.2.0_HOME>/repository/tenants` directory with the copied contents.

    !!! warning
        When moving the Synapse configurations, **do not replace** the following set of files as they contain some modificatiosn in API-M 3.2.0 version.

        -   /api/\_RevokeAPI_.xml
        -   /sequences/\_cors_request_handler_.xml
        -   /sequences/main.xml
        -   /proxy-services/WorkflowCallbackService.xml        

    !!! attention 
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Gateway** node.

7.  Move all your Execution plans from `<API-M_2.6.0_HOME>/repository/deployment/server/executionplans` directory to `<API-M_3.2.0_HOME>/repository/deployment/server/executionplans` directory.

    !!! note
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Traffic Manager** node.

8.  If you manually added any custom OSGI bundles to the `<API-M_2.6.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_3.2.0_HOME>/repository/components/dropins` directory. 

9.  If you manually added any JAR files to the `<API-M_2.6.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_3.2.0_HOME>/repository/components/lib` directory.

10. WSO2 API Manager 3.2.0 has been upgraded to log4j2 (from log4j). You will notice that there is a log4j2.properties file in the `<API-M_3.2.0_HOME>/repository/conf/` directory instead of the log4j.properties file. Follow [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to migrate your existing log4j.properties file to log4j2.properties file.

    !!! warning
        Taking the log4j.properties file from your old WSO2 API-M Server and adding it to WSO2 API-M Server 3.2.0 will no longer work. Refer [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to see how to add a log appender or a logger to the log4j2.properties file.

    !!! note
        Log4j2 has hot deployment support, and **Managing Logs** section has been removed from the Management Console. You can now use the log4j2.properties file to modify logging configurations without restarting the server.

### Step 2 - Upgrade API Manager to 3.2.0

1.  Stop all WSO2 API Manager server instances that are running.

2.  Make sure you backed up all the databases and Synapse configurations as instructed in [step 1](#step-1-migrate-the-api-manager-configurations) of the previous section.

3.  Upgrade the WSO2 API Manager database from version 2.6.0 to version 3.2.0 by executing the relevant database script, from the scripts that are provided below, on the `WSO2AM_DB` database.

    ??? info "DB Scripts"
        ```tab="H2"
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

        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            RESOURCE_ID VARCHAR(255),
            RESOURCE_NAME VARCHAR(255),
            TIME_CREATED TIMESTAMP NOT NULL,
            RESOURCE_OWNER_NAME VARCHAR(255),
            CLIENT_ID VARCHAR(255),
            TENANT_ID INTEGER DEFAULT -1234,
            USER_DOMAIN VARCHAR(50),
            PRIMARY KEY (ID)
        );

        CREATE INDEX IF NOT EXISTS IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);

        CREATE INDEX IF NOT EXISTS IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);

        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_META_DATA (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            PROPERTY_KEY VARCHAR(40),
            PROPERTY_VALUE VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_SCOPE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            SCOPE_NAME VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        CREATE INDEX IF NOT EXISTS IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);

        CREATE TABLE IF NOT EXISTS IDN_UMA_PERMISSION_TICKET (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            PT VARCHAR(255) NOT NULL,
            TIME_CREATED TIMESTAMP NOT NULL,
            EXPIRY_TIME TIMESTAMP NOT NULL,
            TICKET_STATE VARCHAR(25) DEFAULT 'ACTIVE',
            TENANT_ID INTEGER DEFAULT -1234,
            PRIMARY KEY (ID)
        );

        CREATE INDEX IF NOT EXISTS IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);

        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_ID INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE_SCOPE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_SCOPE_ID    INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
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

        DELETE FROM IDN_OAUTH2_SCOPE_BINDING WHERE SCOPE_BINDING IS NULL OR SCOPE_BINDING = '';
        ```
    
        ```tab="DB2"
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
        )/

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
            ID INTEGER NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            PROPERTY_KEY VARCHAR(40),
            PROPERTY_VALUE VARCHAR(255),
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
            ID INTEGER NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            SCOPE_NAME VARCHAR(255),
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
            ID INTEGER NOT NULL,
            PT VARCHAR(255) NOT NULL,
            TIME_CREATED TIMESTAMP NOT NULL,
            EXPIRY_TIME TIMESTAMP NOT NULL,
            TICKET_STATE VARCHAR(25) DEFAULT 'ACTIVE',
            TENANT_ID INTEGER DEFAULT -1234,
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
            ID INTEGER NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_ID INTEGER NOT NULL,
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
            ID INTEGER NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_SCOPE_ID INTEGER NOT NULL,
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

        DELETE FROM IDN_OAUTH2_SCOPE_BINDING WHERE SCOPE_BINDING IS NULL OR SCOPE_BINDING = ''  / 
        ```

        ```tab="MSSQL"
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

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE (
        ID INTEGER IDENTITY NOT NULL,
        RESOURCE_ID VARCHAR(255),
        RESOURCE_NAME VARCHAR(255),
        TIME_CREATED DATETIME NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID VARCHAR(255),
        TENANT_ID INTEGER DEFAULT -1234,
        USER_DOMAIN VARCHAR(50),
        PRIMARY KEY (ID)
        );

        IF NOT EXISTS (SELECT * FROM SYS.indexes WHERE name = 'IDX_RID' and object_id = OBJECT_ID('IDN_UMA_RESOURCE'))
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE(RESOURCE_ID);

        IF NOT EXISTS (SELECT * FROM SYS.indexes WHERE name = 'IDX_USER' and object_id = OBJECT_ID('IDN_UMA_RESOURCE'))
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE(RESOURCE_OWNER_NAME, USER_DOMAIN);

        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE_META_DATA]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
            ID INTEGER IDENTITY NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            PROPERTY_KEY VARCHAR(40),
            PROPERTY_VALUE VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
            ID INTEGER IDENTITY NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            SCOPE_NAME VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        IF NOT EXISTS (SELECT * FROM SYS.indexes WHERE name = 'IDX_RS' and object_id = OBJECT_ID('IDN_UMA_RESOURCE_SCOPE'))
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE(SCOPE_NAME);

        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PERMISSION_TICKET]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
            ID INTEGER IDENTITY NOT NULL,
            PT VARCHAR(255) NOT NULL,
            TIME_CREATED DATETIME NOT NULL,
            EXPIRY_TIME DATETIME NOT NULL,
            TICKET_STATE VARCHAR(25) DEFAULT 'ACTIVE',
            TENANT_ID INTEGER     DEFAULT -1234,
            PRIMARY KEY (ID)
        );
        GO
        IF NOT EXISTS (SELECT * FROM SYS.indexes WHERE name = 'IDX_PT' and object_id = OBJECT_ID('IDN_UMA_PERMISSION_TICKET'))
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET(PT);
        GO
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PT_RESOURCE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PT_RESOURCE (
            ID INTEGER IDENTITY NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_ID INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID)
        );

        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PT_RESOURCE_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
            ID INTEGER IDENTITY NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_SCOPE_ID INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID)
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

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GW_PUBLISHED_API_DETAILS]') AND TYPE IN (N'U'))
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

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_KEY_MANAGER]') AND TYPE IN (N'U'))
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

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GRAPHQL_COMPLEXITY]') AND TYPE IN (N'U'))
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
        ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD APP_INFO VARBINARY(MAX);
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

        DELETE FROM IDN_OAUTH2_SCOPE_BINDING WHERE SCOPE_BINDING IS NULL OR SCOPE_BINDING = '';
        ```

        ```tab="MySQL"
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

        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            RESOURCE_ID VARCHAR(255),
            RESOURCE_NAME VARCHAR(255),
            TIME_CREATED TIMESTAMP NOT NULL,
            RESOURCE_OWNER_NAME VARCHAR(255),
            CLIENT_ID VARCHAR(255),
            TENANT_ID INTEGER DEFAULT -1234,
            USER_DOMAIN VARCHAR(50),
            PRIMARY KEY (ID)
        );

        DELIMITER $$
        create procedure SKIP_INDEX_IF_EXISTS(indexName varchar(64), tableName varchar(64), tableColumns varchar(255))
        BEGIN
            BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN
                END;
            SET @s = CONCAT('CREATE INDEX ', indexName, ' ON ', tableName, tableColumns); PREPARE stmt FROM @s;
                EXECUTE stmt; 
            END;
        END $$
        DELIMITER ;
        
        CALL SKIP_INDEX_IF_EXISTS('IDX_RID', 'IDN_UMA_RESOURCE', '(RESOURCE_ID)');
        
        CALL SKIP_INDEX_IF_EXISTS('IDX_USER', 'IDN_UMA_RESOURCE', '(RESOURCE_OWNER_NAME, USER_DOMAIN)');

        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_META_DATA (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            PROPERTY_KEY VARCHAR(40),
            PROPERTY_VALUE VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_SCOPE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            SCOPE_NAME VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        CALL SKIP_INDEX_IF_EXISTS('IDX_RS', 'IDN_UMA_RESOURCE_SCOPE', '(SCOPE_NAME)');

        CREATE TABLE IF NOT EXISTS IDN_UMA_PERMISSION_TICKET (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            PT VARCHAR(255) NOT NULL,
            TIME_CREATED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            EXPIRY_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            TICKET_STATE VARCHAR(25) DEFAULT 'ACTIVE',
            TENANT_ID INTEGER DEFAULT -1234,
            PRIMARY KEY (ID)
        );

        CALL SKIP_INDEX_IF_EXISTS('IDX_PT', 'IDN_UMA_PERMISSION_TICKET', '(PT)');

        DROP PROCEDURE IF EXISTS SKIP_INDEX_IF_EXISTS;

        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_ID INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE_SCOPE (
            ID INTEGER AUTO_INCREMENT NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_SCOPE_ID INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        );

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

        DELETE FROM IDN_OAUTH2_SCOPE_BINDING WHERE SCOPE_BINDING IS NULL OR SCOPE_BINDING = '';        
        ```
    
        ```tab="Oracle"
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

        DECLARE table_count NUMBER;
          BEGIN
            table_count := 0;
            SELECT COUNT(1) INTO table_count from user_tables WHERE table_name= 'AM_API_CLIENT_CERTIFICATE';
            IF table_count = 0 THEN
            EXECUTE IMMEDIATE 'CREATE TABLE AM_API_CLIENT_CERTIFICATE (
            TENANT_ID INTEGER NOT NULL,
            ALIAS VARCHAR2(45) NOT NULL,
            API_ID INTEGER NOT NULL,
            CERTIFICATE BLOB NOT NULL,
            REMOVED INTEGER DEFAULT 0 NOT NULL,
            TIER_NAME VARCHAR2 (512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
            PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
            )';
          END IF;
        END;
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

        CREATE TABLE IDN_UMA_RESOURCE (
            ID INTEGER,
            RESOURCE_ID VARCHAR2(255),
            RESOURCE_NAME VARCHAR2(255),
            TIME_CREATED TIMESTAMP NOT NULL,
            RESOURCE_OWNER_NAME VARCHAR2(255),
            CLIENT_ID VARCHAR2(255),
            TENANT_ID INTEGER DEFAULT -1234,
            USER_DOMAIN VARCHAR2(50),
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

        CREATE OR REPLACE PROCEDURE add_index_if_not_exists (query IN VARCHAR2)
          IS
        BEGIN
          execute immediate query;
          dbms_output.put_line(query);
        exception WHEN OTHERS THEN
          dbms_output.put_line( 'Skipped ');
        END;
        /
        
        CALL add_index_if_not_exists('CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID)')
        /
        
        CALL add_index_if_not_exists('CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN)')
        /

        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
            ID INTEGER,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            PROPERTY_KEY VARCHAR2(40),
            PROPERTY_VALUE VARCHAR2(255),
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
            ID INTEGER,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            SCOPE_NAME VARCHAR2(255),
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

        CALL add_index_if_not_exists('CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME)')
        /

        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
            ID INTEGER,
            PT VARCHAR2(255) NOT NULL,
            TIME_CREATED TIMESTAMP NOT NULL,
            EXPIRY_TIME TIMESTAMP NOT NULL,
            TICKET_STATE VARCHAR2(25) DEFAULT 'ACTIVE',
            TENANT_ID INTEGER DEFAULT -1234,
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

        CALL add_index_if_not_exists('CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT)')
        /
        
        DROP PROCEDURE add_index_if_not_exists
        /

        CREATE TABLE IDN_UMA_PT_RESOURCE (
            ID INTEGER,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_ID INTEGER NOT NULL,
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
            ID INTEGER,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_SCOPE_ID INTEGER NOT NULL,
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
        DELETE FROM IDN_OAUTH2_SCOPE_BINDING WHERE SCOPE_BINDING IS NULL
        /
        COMMIT;
        /    
        ```
        
        ```tab="PostgreSQL"
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
            TIER_NAME VARCHAR (512),
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

        DROP TABLE IF EXISTS IDN_UMA_RESOURCE;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE (
            ID INTEGER DEFAULT NEXTVAL('IDN_UMA_RESOURCE_SEQ') NOT NULL,
            RESOURCE_ID VARCHAR(255),
            RESOURCE_NAME VARCHAR(255),
            TIME_CREATED TIMESTAMP NOT NULL,
            RESOURCE_OWNER_NAME VARCHAR(255),
            CLIENT_ID VARCHAR(255),
            TENANT_ID INTEGER DEFAULT -1234,
            USER_DOMAIN VARCHAR(50),
            PRIMARY KEY (ID)
        );

        CREATE INDEX IF NOT EXISTS IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);

        CREATE INDEX IF NOT EXISTS IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);

        DROP TABLE IF EXISTS IDN_UMA_RESOURCE_META_DATA;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_META_DATA_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
            ID INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_META_DATA_SEQ') NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            PROPERTY_KEY VARCHAR(40),
            PROPERTY_VALUE VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        DROP TABLE IF EXISTS IDN_UMA_RESOURCE_SCOPE;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SCOPE_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
            ID INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_SCOPE_SEQ') NOT NULL,
            RESOURCE_IDENTITY INTEGER NOT NULL,
            SCOPE_NAME VARCHAR(255),
            PRIMARY KEY (ID),
            FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        CREATE INDEX IF NOT EXISTS IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);

        DROP TABLE IF EXISTS IDN_UMA_PERMISSION_TICKET;
        DROP SEQUENCE IF EXISTS IDN_UMA_PERMISSION_TICKET_SEQ;
        CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ;
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
            ID INTEGER DEFAULT NEXTVAL('IDN_UMA_PERMISSION_TICKET_SEQ') NOT NULL,
            PT VARCHAR(255) NOT NULL,
            TIME_CREATED TIMESTAMP NOT NULL,
            EXPIRY_TIME TIMESTAMP NOT NULL,
            TICKET_STATE VARCHAR(25) DEFAULT 'ACTIVE',
            TENANT_ID INTEGER DEFAULT -1234,
            PRIMARY KEY (ID)
        );

        CREATE INDEX IF NOT EXISTS IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);

        DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE;
        DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SEQ;
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ;
        CREATE TABLE IDN_UMA_PT_RESOURCE (
            ID INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SEQ') NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_ID INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );

        DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE;
        DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE_SCOPE (
            ID INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SCOPE_SEQ') NOT NULL,
            PT_RESOURCE_ID INTEGER NOT NULL,
            PT_SCOPE_ID INTEGER NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
            FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
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
        WHERE constraint_type = 'PRIMARY KEY' AND tc.table_name = 'idn_oauth2_resource_scope';
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
        
        UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL='' WHERE CALLBACK_URL IS NULL;

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

        DELETE FROM IDN_OAUTH2_SCOPE_BINDING WHERE SCOPE_BINDING IS NULL OR SCOPE_BINDING = '';
        ```

4.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_3.2.0_HOME>/repository/resources/security` directory.

    !!! Attention
        In API Manager 3.2.0, it is required to use a certificate with the RSA key size greater than 2048. If you have used a certificate tha   t has a weak RSA key (key size less than 2048) in previous version, you need to add the following configuration to `<API-M_3.2.0_HOME>/repository/conf/deployment.toml` file to configure internal and primary keystores. You should point the internal keystore to the keystore copied from API Manager 2.6.0 and primary keystore can be pointed to a keystore with a ceritificate, which has strong RSA key. 

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
        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below. Please refer [Encrypting Passwords in Configuration files]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords) for more details.

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

    - In order to work with the [API Security Audit Feature]({{base_path}}/learn/api-security/configuring-api-security-audit/) you need to have the public certificate of the [42crunch](https://42crunch.com/) in the client-truststore. Follow the guidelines given in [Importing Certificates to the Truststore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore).

5.  Upgrade the Identity component in WSO2 API Manager from version 5.7.0 to 5.10.0.

    ??? note "If you are using DB2"
        Move indexes to the the TS32K Tablespace. The index tablespace in the `IDN_OAUTH2_ACCESS_TOKEN` and `IDN_OAUTH2_AUTHORIZATION_CODE` tables need to be moved to the existing TS32K tablespace in order to support newly added table indexes.

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

        If you recieve an error due to missing `SYSTOOLSPACE` or `SYSTOOLSTMPSPACE` tablespaces, create those tablespaces manually using the following script prior to executing the stored procedure given above. For more information, see [SYSTOOLSPACE and SYSTOOLSTMPSPACE table
        spaces](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_10.5.0/com.ibm.db2.luw.admin.gui.doc/doc/c0023713.html) in the IBM documentation.          
        ``` java
        CREATE TABLESPACE SYSTOOLSPACE IN IBMCATGROUP
        MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
        EXTENTSIZE 4;
        
        CREATE USER TEMPORARY TABLESPACE SYSTOOLSTMPSPACE IN IBMCATGROUP
        MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
        EXTENTSIZE 4;
        ```

    1.  Download the identity component migration resources and unzip it in a local directory.

        Navigate to the [latest release tag](https://github.com/wso2-extensions/identity-migration-resources/releases/latest) and download the `wso2is-migration-x.x.x.zip` under Assets.
         
        Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`. 

    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_3.2.0_HOME>` directory.

    3.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.7.0, as shown below.

        ``` java
        migrationEnable: "true"
        currentVersion: "5.7.0"
        migrateVersion: "5.10.0"
        ```

        !!! note
            Make sure you have enabled migration by setting the `migrationEnable` element to `true` as shown above. You have to remove the following 2 steps from  migration-config.yaml which is included under version: "5.10.0"
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

    4.  Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<API-M_3.2.0_HOME>/repository/components/dropins` directory.

    5. Update <API-M_3.2.0_HOME>/repository/conf/deployment.toml file as follows, to point to the previous user store.
    
        ```
        [user_store]
        type = "database"
        ```
    
    6.  Start WSO2 API Manager 3.2.0 as follows to carry out the complete Identity component migration.
        
        !!! note
            If you are migrating your user stores to the new user store managers with the unique ID capabilities, Follow the guidelines given in the [Migrating User Store Managers](https://is.docs.wso2.com/en/latest/setup/migrating-userstore-managers/) before moving to the next step
                    
        ```tab="Linux / Mac OS"
        sh wso2server.sh -Dmigrate -Dcomponent=identity
        ```

        ```tab="Windows"
        wso2server.bat -Dmigrate -Dcomponent=identity
        ```

        !!! note
            Please note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and please wait until the migration process finish completely and server get started.
        
        !!! note
            Please note that if you want to use the latest user store, please update the <API-M_3.2.0_HOME>/repository/conf/deployment.toml as follows after the identity migration,

            ```
            [user_store]
            type = "database_unique_id"
            ``` 

        !!! warning "Troubleshooting"
            When running the above step if you encounter the following error message, please follow the steps in this section. Please note that this error could occur only if the identity tables contain a huge volume of data.

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

    7.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<API-M_3.2.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` directory, which is in the `<API-M_3.2.0_HOME>` directory.

        -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the wso2server.bat file.

            ```
            -Dmigrate -Dcomponent=identity
            ```

6.  Migrate the API Manager artifacts.

    You have to run the following migration client to update the registry artifacts.

    1. Download and extract the [migration-resources.zip]({{base_path}}/assets/attachments/install-and-setup/migration-resources.zip). Copy the extracted `migration-resources`  to the `<API-M_3.2.0_HOME>` folder.

    2. Download and copy the [API Manager Migration Client]({{base_path}}/assets/attachments/install-and-setup/org.wso2.carbon.apimgt.migrate.client-3.2.0-1.jar) to the `<API-M_3.2.0_HOME>/repository/components/dropins` folder.

    3.  Start the API-M server as follows.

        ``` tab="Linux / Mac OS"
        sh wso2server.sh -DmigrateFromVersion=2.6.0
        ```

        ``` tab="Windows"
        wso2server.bat -DmigrateFromVersion=2.6.0
        ```

        Note:  If cross tenant API subscriptions exist, the migration will be aborted. 
        To ignore this, Please set the flag ``ignoreCrossTenantSubscriptions`` to true as below.
    
        ``` tab="Linux / Mac OS"
        sh wso2server.sh -DignoreCrossTenantSubscriptions=true -DmigrateFromVersion=2.6.0
        ```
    
        ``` tab="Windows"
        wso2server.bat -DignoreCrossTenantSubscriptions=true -DmigrateFromVersion=2.6.0
        ```
        
    4. Shutdown the API-M server.
    
       -   Remove the `org.wso2.carbon.apimgt.migrate.client-3.2.0-1.jar` file, which is in the `<API-M_3.2.0_HOME>/repository/components/dropins` directory.

       -   Remove the `migration-resources` directory, which is in the `<API-M_3.2.0_HOME>` directory.

7.  Re-index the artifacts in the registry.
    1.  Run the [reg-index.sql]({{base_path}}/assets/attachments/install-and-setup/reg-index.sql) script against the `SHARED_DB` database.

        !!! note
            Please note that depending on the number of records in the REG_LOG table, this script will take a considerable amount of time to finish. Do not stop the execution of script until it is completed.

    2.  Add the [tenantloader-1.0.jar]({{base_path}}/assets/attachments/install-and-setup/tenantloader-1.0.jar) to `<API-M_3.2.0_HOME>/repository/components/dropins` directory.

        !!! attention
            If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Store and Publisher** nodes.

        !!! note
            You need to do this step, if you have **multiple tenants** only.

    3.  Add the following configuration in `<API-M_3.2.0_HOME>/repository/conf/deployment.toml` file.
        
        ```
        [indexing]
        re_indexing= 1
        ```

        !!! info 
             If you use a clustered/distributed API Manager setup, do the above change in deployment.toml of Publisher and Devportal nodes
             
    4.  If the `<API-M_3.2.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

    5.  Start the WSO2 API-M server.

    6.  Stop the WSO2 API-M server and remove the `tenantloader-1.0.jar` from the `<API-M_3.2.0_HOME>/repository/components/dropins` directory.

### Step 3 - Optionally, migrate the configurations for WSO2 API-M Analytics

!!! warning
    This step is **only required** if you have WSO2 API-M-Analytics configured in your current deployment.

Follow the steps below to migrate APIM Analytics 2.6.0 to APIM Analytics 3.2.0

#### Step 3.1 - Migrating the Analytics Database

Upgrade the WSO2 API Manager Analytics database from version 2.6.0 to version 3.2.0 by executing the relevant database script, from the scripts that are provided below, on the `APIM_ANALYTICS_DB` database.

??? info "DB Scripts"
    ```tab="H2"
    ALTER TABLE APILASTACCESSSUMMARY DROP PRIMARY KEY;
    ALTER TABLE APILASTACCESSSUMMARY ALTER COLUMN APIVERSION VARCHAR(254) NOT NULL;
    ALTER TABLE APILASTACCESSSUMMARY ADD PRIMARY KEY (APINAME,APIVERSION,APICREATOR,APICREATORTENANTDOMAIN);           
    ```
    
    ```tab="DB2"
    ALTER TABLE APILASTACCESSSUMMARY DROP PRIMARY KEY;
    ALTER TABLE APILASTACCESSSUMMARY ALTER COLUMN APIVERSION VARCHAR(254) NOT NULL;
    ALTER TABLE APILASTACCESSSUMMARY ADD PRIMARY KEY (APINAME,APIVERSION,APICREATOR,APICREATORTENANTDOMAIN);
    ```

    ```tab="MSSQL"
    DECLARE @con_com as VARCHAR(8000);
    SET @con_com = (SELECT name from sys.objects where parent_object_id=object_id('APILASTACCESSSUMMARY') AND type='PK');
    EXEC('ALTER TABLE APILASTACCESSSUMMARY DROP CONSTRAINT ' + @con_com);
    ALTER TABLE APILASTACCESSSUMMARY ALTER COLUMN APIVERSION VARCHAR(254) NOT NULL;
    ALTER TABLE APILASTACCESSSUMMARYADD PRIMARY KEY (APINAME,APICREATOR,APIVERSION,APICREATORTENANTDOMAIN);
    ```

    ```tab="MySQL"
    ALTER TABLE APILASTACCESSSUMMARY DROP PRIMARY KEY;
    ALTER TABLE APILASTACCESSSUMMARY ADD PRIMARY KEY (APINAME,APICREATOR,APIVERSION,APICREATORTENANTDOMAIN);
    ```
    
    ```tab="Oracle"
    ALTER TABLE APILASTACCESSSUMMARY DROP PRIMARY KEY;
    ALTER TABLE APILASTACCESSSUMMARY ADD PRIMARY KEY (APINAME,APICREATOR,APIVERSION,APICREATORTENANTDOMAIN);
    COMMIT;
    ```
        
    ```tab="PostgreSQL"
    ALTER TABLE APILASTACCESSSUMMARY DROP CONSTRAINT APILASTACCESSSUMMARY_pkey;
    ALTER TABLE APILASTACCESSSUMMARY ADD PRIMARY KEY (APINAME,APICREATOR,APIVERSION,APICREATORTENANTDOMAIN);
    ```
The schema for table APIMALLALERT is changed in analytics version 3.2. So it is recommended to drop the above table
prior to the migration so that it will be recreated at the server startup using the new script. 
If you think that you require the already available data in the above table you can take a backup of it. But the above 
table is just used to maintain a summary of all types of alerts in a single place. As 
these alerts are persisted individually as well in tables specific for the type of the alert, you will not loose any
data related to alerts by dropping this table.

??? info "DB Scripts"
     DROP TABLE APIMALLALERT;

!!! note
    Type and name of a column of few tables were changed through WUM in analytics version 2.6. It is important to 
    add the above change into your database prior to migration. So execute the below queries which checks whether 
    the above change is already available in your DB and if not, it will add the relevant change. Ensure to replace 
    "Enter Analytics DB name here" with the correct DB name in the scripts.
    
    ```tab="MSSQL"
    CREATE PROCEDURE dbo.alter_geolocation_table_if_coloumn_not_exist
    AS
    BEGIN
    IF NOT EXISTS(
    	SELECT name  FROM SYS.COLUMNS
        	WHERE OBJECT_ID = OBJECT_ID('geolocationagg_seconds') AND NAME = 'agg_count')
    	BEGIN
    		ALTER TABLE GeoLocationAgg_SECONDS ALTER COLUMN totalCount BIGINT;
    		EXEC sp_RENAME 'GeoLocationAgg_SECONDS.totalCount' , 'AGG_COUNT', 'COLUMN';
    		ALTER TABLE GeoLocationAgg_MINUTES ALTER COLUMN totalCount BIGINT;
    		EXEC sp_RENAME 'GeoLocationAgg_MINUTES.totalCount' , 'AGG_COUNT', 'COLUMN';
    		ALTER TABLE GeoLocationAgg_HOURS ALTER COLUMN totalCount BIGINT;
    		EXEC sp_RENAME 'GeoLocationAgg_HOURS.totalCount' , 'AGG_COUNT', 'COLUMN';
    		ALTER TABLE GeoLocationAgg_DAYS ALTER COLUMN totalCount BIGINT;
    		EXEC sp_RENAME 'GeoLocationAgg_DAYS.totalCount' , 'AGG_COUNT', 'COLUMN';
    		ALTER TABLE GeoLocationAgg_MONTHS ALTER COLUMN totalCount BIGINT;
    		EXEC sp_RENAME 'GeoLocationAgg_MONTHS.totalCount' , 'AGG_COUNT', 'COLUMN';
    		ALTER TABLE GeoLocationAgg_YEARS ALTER COLUMN totalCount BIGINT;
    		EXEC sp_RENAME 'GeoLocationAgg_YEARS.totalCount' , 'AGG_COUNT', 'COLUMN';
    	END 	
    END
    GO
    
    USE <Enter Analytics DB name here>;
    EXEC dbo.alter_geolocation_table_if_coloumn_not_exist;
    DROP PROCEDURE dbo.alter_geolocation_table_if_coloumn_not_exist;
    ```
    
    ```tab="MySQL"
    DROP PROCEDURE IF EXISTS alter_geolocation_table_if_coloumn_not_exist;
    
    DELIMITER $$
    
    CREATE DEFINER=CURRENT_USER PROCEDURE alter_geolocation_table_if_coloumn_not_exist (IN dbName varchar(50)) 
    BEGIN
    	DECLARE colName TEXT;
    	SELECT column_name INTO colName
    	FROM information_schema.columns WHERE table_schema = dbName AND table_name = 'GeoLocationAgg_SECONDS'
    	AND column_name = 'AGG_COUNT'; 
    	IF colName is null THEN 
    		ALTER TABLE GeoLocationAgg_SECONDS CHANGE totalCount AGG_COUNT bigint(20);
    		ALTER TABLE GeoLocationAgg_MINUTES CHANGE totalCount AGG_COUNT bigint(20);
    		ALTER TABLE GeoLocationAgg_HOURS CHANGE totalCount AGG_COUNT bigint(20);
    		ALTER TABLE GeoLocationAgg_DAYS CHANGE totalCount AGG_COUNT bigint(20);
    		ALTER TABLE GeoLocationAgg_MONTHS CHANGE totalCount AGG_COUNT bigint(20);
    		ALTER TABLE GeoLocationAgg_YEARS CHANGE totalCount AGG_COUNT bigint(20);
    	END IF; 
    END$$
    
    DELIMITER ;
    CALL alter_geolocation_table_if_coloumn_not_exist('<Enter Analytics DB name here>');
    ```
    
    ```tab="Oracle"
    DECLARE
      column_exists number := 0;  
    BEGIN
      Select count(*) into column_exists
      from user_tab_cols
      where upper(column_name) = 'AGG_COUNT'
      and upper(table_name) = 'GEOLOCATIONAGG_SECONDS';
          
      IF (column_exists = 0) then
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_SECONDS modify (totalCount INTEGER DEFAULT 0)';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_SECONDS RENAME COLUMN totalCount to AGG_COUNT';           
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_MINUTES modify (totalCount INTEGER DEFAULT 0)';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_MINUTES RENAME COLUMN totalCount to AGG_COUNT';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_HOURS modify (totalCount INTEGER DEFAULT 0)';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_HOURS RENAME COLUMN totalCount to AGG_COUNT';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_DAYS modify (totalCount INTEGER DEFAULT 0)';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_DAYS RENAME COLUMN totalCount to AGG_COUNT';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_MONTHS modify (totalCount INTEGER DEFAULT 0)';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_MONTHS RENAME COLUMN totalCount to AGG_COUNT';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_YEARS modify (totalCount INTEGER DEFAULT 0)';
           EXECUTE IMMEDIATE 'ALTER TABLE GeoLocationAgg_YEARS RENAME COLUMN totalCount to AGG_COUNT';   
      END IF;
    END;
    /
    COMMIT;
    /    
    ```
    
    ```tab="PostgreSQL"
    CREATE OR REPLACE FUNCTION alter_geolocation_table_if_coloumn_not_exist(IN dbName varchar(50))
      returns void AS $$
      declare
       tableName VARCHAR(50) := 'geolocationagg_seconds';
       tableColumn VARCHAR(50) := 'agg_count'; 
       colName VARCHAR(50);
      begin
    	  select column_name into colName FROM information_schema.columns where table_catalog = dbName and 
    	  table_name = tableName and column_name = tableColumn;
    	  if colName is null then
    	  	ALTER TABLE GeoLocationAgg_SECONDS ALTER COLUMN totalCount TYPE INTEGER;
    		ALTER TABLE GeoLocationAgg_SECONDS rename totalCount to AGG_COUNT;
    		ALTER TABLE GeoLocationAgg_MINUTES ALTER COLUMN totalCount TYPE INTEGER;
    		ALTER TABLE GeoLocationAgg_MINUTES rename totalCount to AGG_COUNT;
    		ALTER TABLE GeoLocationAgg_HOURS ALTER COLUMN totalCount TYPE INTEGER;
    		ALTER TABLE GeoLocationAgg_HOURS rename totalCount to AGG_COUNT;
    		ALTER TABLE GeoLocationAgg_DAYS ALTER COLUMN totalCount TYPE INTEGER;
    		ALTER TABLE GeoLocationAgg_DAYS rename totalCount to AGG_COUNT;
    		ALTER TABLE GeoLocationAgg_MONTHS ALTER COLUMN totalCount TYPE INTEGER;
    		ALTER TABLE GeoLocationAgg_MONTHS rename totalCount to AGG_COUNT;
    		ALTER TABLE GeoLocationAgg_YEARS ALTER COLUMN totalCount TYPE INTEGER;
    		ALTER TABLE GeoLocationAgg_YEARS rename totalCount to AGG_COUNT;
    	 end if;
      END; $$
      LANGUAGE plpgsql;
    select alter_geolocation_table_if_coloumn_not_exist(<Enter Analytics DB name here>);
    ```
    
    ```tab="db2"
    CREATE OR REPLACE PROCEDURE alter_geolocation_table_if_coloumn_not_exist ()
         MODIFIES SQL DATA
         LANGUAGE SQL
    BEGIN
        IF (NOT EXISTS(SELECT 1 FROM SYSCAT.COLUMNS WHERE TABNAME = 'GEOLOCATIONAGG_SECONDS' AND COLNAME = 'AGG_COUNT'))
        THEN
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_SECONDS ALTER COLUMN TOTALCOUNT SET DATA TYPE INTEGER';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_SECONDS RENAME COLUMN totalCount TO AGG_COUNT';   
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_MINUTES ALTER COLUMN TOTALCOUNT SET DATA TYPE INTEGER';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_MINUTES RENAME COLUMN totalCount TO AGG_COUNT';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_HOURS ALTER COLUMN TOTALCOUNT SET DATA TYPE INTEGER';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_HOURS RENAME COLUMN totalCount TO AGG_COUNT';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_DAYS ALTER COLUMN TOTALCOUNT SET DATA TYPE INTEGER';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_DAYS RENAME COLUMN totalCount TO AGG_COUNT';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_MONTHS ALTER COLUMN TOTALCOUNT SET DATA TYPE INTEGER';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_MONTHS RENAME COLUMN totalCount TO AGG_COUNT';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_YEARS ALTER COLUMN TOTALCOUNT SET DATA TYPE INTEGER';
            EXECUTE IMMEDIATE 'ALTER TABLE GEOLOCATIONAGG_YEARS RENAME COLUMN totalCount TO AGG_COUNT';
        END IF;
    END
    /
    
    CALL alter_geolocation_table_if_coloumn_not_exist()
    /

    ```    


#### Step 3.2 - Configure WSO2 API-M Analytics 3.2.0

!!! note
    -   In API-M 2.6.0, when working with API-M Analytics, only the worker profile has been used by default and dashboard profile is used only when there are custom dashboards.
    -   Now with API-M 3.1.0 onwards, both the worker and dashboard profiles are being used. The default Store and Publisher dashboards are now being moved to the Analytics dashboard server side and they have been removed from the API-M side.
    -   The same set of DBs will be used in the Analytics side and additionally you need to share the WSO2AM_DB with the dashboard server node.

!!! info
    Sometimes due to case insensitivity of primary keys in aggregation tables, primary key violation errors are thrown when you try to insert a new record with the same value as an existing record. To overcome this, you need to add encoding and collation to database when the Analytics DB is created (i.e., before the tables are created). For more information on collation, see [MySQL](https://dev.mysql.com/doc/refman/5.7/en/charset-collation-names.html) or [MS SQL](https://docs.microsoft.com/en-us/sql/relational-databases/collations/collation-and-unicode-support?view=sql-server-ver15) based on the database that you are using. Sample commands are provided below.

    !!! example

        ```sql tab="MySQL"
        ALTER DATABASE <DB-NAME> COLLATE latin1_general_cs ;
        ```

        ```sql tab="MS SQL"
        ALTER DATABASE <DB-NAME> COLLATE SQL_Latin1_General_CP1_CS_AS ;
        ```

Follow the instructions below to configure WSO2 API Manager Analytics for the WSO2 API-M Analytics migration in order to migrate the statistics related data.

1.  Download [WSO2 API Manager Analytics 3.2.0](http://wso2.com/api-management/).

2.  Configure the following 2 datasources in the `<API-M_ANALYTICS_3.2.0_HOME>/conf/dashboard/deployment.yaml` file by pointing to the **old** `WSO2AM_DB` and `APIM_ANALYTICS_DB`.

    ``` java
    #Data source for APIM Analytics
    - name: APIM_ANALYTICS_DB
        description: Datasource used for APIM Analytics
        jndiConfig:
        name: jdbc/APIM_ANALYTICS_DB
        definition:
        type: RDBMS
        configuration:
            jdbcUrl: 'jdbc:mysql://localhost:3306/analytics_db'
            username: root
            password: root
            driverClassName: com.mysql.jdbc.Driver
            minIdle: 5
            maxPoolSize: 50
            idleTimeout: 60000
            connectionTestQuery: SELECT 1
            validationTimeout: 30000
            isAutoCommit: false

    #Main datasource used in API Manager
    - name: AM_DB
        description: Main datasource used by API Manager
        jndiConfig:
        name: jdbc/AM_DB
        definition:
        type: RDBMS
        configuration:
            jdbcUrl: "jdbc:mysql://localhost:3306/am_db"
            username: root
            password: root
            driverClassName: com.mysql.jdbc.Driver
            maxPoolSize: 10
            idleTimeout: 60000
            connectionTestQuery: SELECT 1
            validationTimeout: 30000
            isAutoCommit: false
    ```

3.  Configure the following datasource in the `<API-M_ANALYTICS_3.2.0_HOME>/conf/worker/deployment.yaml` file by pointing to the **old** `APIM_ANALYTICS_DB`.

    ``` java
    #Data source for APIM Analytics
    - name: APIM_ANALYTICS_DB
      description: "The datasource used for APIM statistics aggregated data."
      jndiConfig:
        name: jdbc/APIM_ANALYTICS_DB
      definition:
        type: RDBMS
        configuration:
          jdbcUrl: 'jdbc:mysql://localhost:3306/analytics_db'
          username: root
          password: root
          driverClassName: com.mysql.jdbc.Driver
          minIdle: 5
          maxPoolSize: 50
          idleTimeout: 60000
          connectionTestQuery: SELECT 1
          validationTimeout: 30000
          isAutoCommit: false
    ```

4.  Copy the relevant JDBC driver OSGI bundle to the `<APIM_ANALYTICS_3.2.0_HOME>/lib` folder.

    !!! info "To convert the jar files to OSGi bundles, follow the steps given below."
        1. Download the non-OSGi jar for the required third party product, and save it in a preferred directory in your machine.
        2. Go to the `<API-M_ANALYTICS_HOME>/bin` directory. Run the command given below, to generate the converted file in the `<API-M_ANALYTICS_HOME>/lib` directory.

        ```
        ./jartobundle.sh <PATH_TO_NON-OSGi_JAR> ../lib
        ```
5.  Copy the keystores (i.e., `client-truststore.jks` , `wso2cabon.jks` and any other custom JKS) used in the previous version from `<OLD_API-M_ANALYTICS_HOME>/repository/resources/security` and replace the existing keystores in the `<NEW_API-M_ANALYTICS_HOME>/resources/security` directory.

6.  Start the Worker and Dashboard profiles as below by navigating to `<API-M_ANALYTICS_3.2.0_HOME>/bin` location.
    
    ```tab="Worker"
    sh worker.sh
    ```

    ```tab="Dashboard"
    sh dashboard.sh
    ```

!!! note
    If you have developed any custom dashboards in API-M 2.6.0 Analytics using Stream Processor, you will be able to use the same in API-M Anaytics 3.2.0 as well. If you require any guidance regarding this, you can contact [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa).

#### Step 3.3 - Configure WSO2 API-M 3.2.0 for Analytics

Follow the instructions below to configure WSO2 API Manager for the WSO2 API-M Analytics migration in order to migrate the statistics related data.

1.  Configure the following datasources in the `<API-M_3.2.0_HOME>/repository/conf/deployment.toml` file.

    The following is an example of how the configurations should be defined when using MySQL.

    This datasource points to the **previous API-M version's WSO2AM_DB datasource.**

    ``` java
    [database.apim_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/am_db"
    username = "username"
    password = "password"
    ```

2.  Enable analytics in WSO2 API-M by setting the following configuration to true in the `<API-M_3.2.0_HOME>/repository/conf/deployment.toml` file.

    ``` java
    [apim.analytics]
    enable = true
    ```

### Step 4 - Restart the WSO2 API-M 3.2.0 server

1.  Restart the WSO2 API-M server.

    ```tab="Linux / Mac OS"
    sh wso2server.sh
    ```

    ```tab="Windows"
    wso2server.bat
    ```

    !!! note "If you have enabled Analytics"
        After starting the WSO2 API-M server and the WSO2 API-M Analytics 3.2.0 server from worker and dashboard profiles, the dashboards can be accessed via `https://<dashboard-server-host-name>:9643/analytics-dashboard` link.

        !!! warning
            Make sure you have started the API-M server node before accessing the Dashboard profile as the authentication happens via the API-M's authentication admin service.

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! note
    If you are using a migrated API and wants to consume it via an application which supports JWT authentication (default type in API-M 3.2.0), you need to republish the API. Without republishing the API, JWT authentication doesn't work as it looks for a local entry which will get populated while publishing.

    You can consume the migrated API via an OAuth2 application without an issue.
