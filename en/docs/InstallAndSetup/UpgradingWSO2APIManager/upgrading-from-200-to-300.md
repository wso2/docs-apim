# Upgrading API Manager from 2.0.0 to 3.0.0

The following information describes how to upgrade your API Manager server **from APIM 2.0.0 to 3.0.0**.

!!! note
    Before you follow this section, see [Upgrading Process](../UpgradingWSO2APIManager/upgrading-process.md) for more information.

!!! attention "Before you Begin"
    1.  This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

        -   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.0.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/updates/Using+WSO2+Update+Manager).

    2.  Before starting the upgrade, run the [token and session cleanup scripts](../../Administer/ProductAdministration/removing-unused-tokens-from-the-database.md) in the databases of the environment, if you are not doing regular cleanups.

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.0.0 to 2.6.0**.

### Preparing for Migration
#### Disabling versioning in the registry configuration

If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 3.0.0.

Therefore, when migrating to API Manager 3.0.0, it is **required** to turn off the registry versioning in your
current API Manager 2.0.0 version and run the below scripts against **the database that is used by the registry**.

!!! note "NOTE"
    Alternatively, it is possible to turn on registry versioning in API Manager 3.0.0 and continue. But this is
    highly **NOT RECOMMENDED** and these configurations should only be changed once.

!!! info "Turning off registry versioning in your current API-M and running the scripts"
    Open the `registry.xml` file in the `<OLD_API-M_HOME>/repository/conf` directory.
    Set the `versioningProperties`, `versioningComments`, `versioningTags` and `versioningRatings` false.

     ```
    <staticConfiguration>
        <versioningProperties>false</versioningProperties>
        <versioningComments>false</versioningComments>
        <versioningTags>false</versioningTags>
        <versioningRatings>false</versioningRatings>
    </staticConfiguration>
    ```

    !!! warning
        If the above configurations are already set as `false` you should not run the below scripts.

    When the above configurations are turned off, you need to remove the versioning details from the database in order for the registry resources to work properly. Choose the relevant DB type and run the script against the DB that the registry resides in.
    
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
    If you decide to proceed with registry resource versioning enabled, add the following configuration to the `<NEW_API-M_HOME>/repository/conf/deployment.toml` file of new WSO2 API Manager. 
    
    ```
    [registry.static_configuration]
    enable=true
    ```
    
    !!! note "NOTE"
        Changing these configuration should only be done before the initial API-M Server startup. If changes are done after the initial startup, the registry resource created previously will not be available.

!!! note
    If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.9.0](../UpgradingWSO2ISAsKeyManager/upgrading-from-is-km-520-to-590.md).

-   [Step 1 - Migrate the API Manager configurations](#step-1-migrate-the-api-manager-configurations)
-   [Step 2 - Upgrade API Manager to 3.0.0](#step-2-upgrade-api-manager-to-300)
-   [Step 3 - Optionally, migrate the configurations for WSO2 API-M Analytics](#step-3-optionally-migrate-the-configurations-for-wso2-api-m-analytics)
-   [Step 4 - Restart the WSO2 API-M 3.0.0 server](#step-4-restart-the-wso2-api-m-300-server)

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as the configuration modal has been changed and now all the configurations are being done via a single file (deployment.toml). Instead, redo the configuration changes in the new configuration file. For more information refer [Configuration Catalog](../../Reference/ConfigCatalog.md).

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Back up all databases in your API Manager instances along with the Synapse configurations of all the tenants and the super tenant.

    -   The Synapse configurations of the super tenant are in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory.

    -   The Synapse configurations of tenants are in the `<OLD_API-M_HOME>/repository/tenants` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the **API Gateway** node.

2.  Download API Manager 3.0.0 from <https://wso2.com/api-management/>.

3.  Open the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file and provide the datasource configurations for the following databases.

    -   User Store
    -   Registry database/s
    -   API Manager databases

    !!! note
        In API-M 3.0.0, a combined **SHARED_DB** has been introduced to keep both the user related data (`WSO2UM_DB`) and the registry data (`WSO2REG_DB`). If you have used separate DBs for user management and registry in the previous version, you need to configure WSO2REG_DB and WSO2UM_DB databases separately in API-M 3.0.0 to avoid any issues.

    **SHARED_DB** should point to the previous API-M version's `WSO2REG_DB`. This example shows to configure MySQL database configurations.

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
        If you have configured WSO2CONFIG_DB in the previous API-M version, add a new entry to the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` as below.

        ```
        [database.config]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/config_db"
        username = "username"
        password = "password"
        ```

    !!! attention "If you are using another DB type"
        If you are using another DB type other than **H2** or **MySQL**, when defining the DB related configurations in the `deployment.toml` file, you need to add the `driver` and `validationQuery` parameters optionally. For example MSSQL database configuration is as follows for the API Manager database.

        ```
        [database.apim_db]
        type = "mssql"
        url = "jdbc:sqlserver://localhost:1433;databaseName=mig_am_db;SendStringParametersAsUnicode=false"
        username = "username"
        password = "password"
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
        validationQuery = "SELECT 1"
        ```

4.  Update `<API-M_3.0.0_HOME>/repository/resources/conf/default.json` file by pointing to the WSO2UM_DB.

    ```
    "realm_manager": {
        "data_source": "WSO2USER_DB",
        "properties": {
        "isCascadeDeleteEnabled": true,
        "initializeNewClaimManager": true
        }
    }
    ```

5.  Copy the relevant JDBC driver to the `<API-M_3.0.0_HOME>/repository/components/lib` folder.

    !!! info
        In API-M 3.0.0, you do not need to configure the registry configurations as you did in the `<OLD_API-M_HOME>/repository/conf/registry.xml` file and the user database configurations as you did in in the `<OLD_API-M_HOME>/repository/conf/user-mgt.xml` file, as those configurations have been handled internally.

6.  Move all your Synapse configurations to API-M 3.0.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and replace the contents in the `<API-M_3.0.0_HOME>/repository/deployment/server/synapse-configs/default` directory with the copied contents.

    -   Move all your tenant Synapse configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/tenants` directory and replace the contents in the `<API-M_3.0.0_HOME>/repository/tenants` directory with the copied contents.

    !!! warning
        When moving the Synapse configurations, **do not replace** the following set of files as they contain some modificatiosn in API-M 3.0.0 version.

        -   \_RevokeAPI_.xml
        -   \_cors_request_handler_.xml
        -   main.xml

    !!! attention 
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Gateway** node.

7.  Move all your Execution plans from `<API-M_2.0.0_HOME>/repository/deployment/server/executionplans` directory to `<API-M_3.0.0_HOME>/repository/deployment/server/executionplans` directory.

    !!! note
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Traffic Manager** node.

8.  If you manually added any custom OSGI bundles to the `<API-M_2.0.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_3.0.0_HOME>/repository/components/dropins` directory. 

9.  If you manually added any JAR files to the `<API-M_2.0.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_3.0.0_HOME>/repository/components/lib` directory.

10. WSO2 API Manager 3.0.0 has been upgraded to log4j2 (from log4j). You will notice that there is a log4j2.properties file in the `<API-M_3.0.0_HOME>/repository/conf/` directory instead of the log4j.properties file. Follow [Upgrading to Log4j2](../UpgradingWSO2APIManager/upgrading-to-log4j2.md) to migrate your existing log4j.properties file to log4j2.properties file.

    !!! warning
        Taking the log4j.properties file from your old WSO2 API-M Server and adding it to WSO2 API-M Server 3.0.0 will no longer work. Refer [Upgrading to Log4j2](../UpgradingWSO2APIManager/upgrading-to-log4j2.md) to see how to add a log appender or a logger to the log4j2.properties file.

    !!! note
        Log4j2 has hot deployment support, and **Managing Logs** section has been removed from the Management Console. You can now use the log4j2.properties file to modify logging configurations without restarting the server.

!!! warning
    **NOTE:** Do not replace the files listed below from the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` folder to WSO2 API Manager 2.6.0. These are application-specific APIs and sequences. If you made any custom changes to the files below, you need to merge the changes to the corresponding files in WSO2 API-M 2.6.0.

`/api/_AuthorizeAPI_.xml`

`/api/_RevokeAPI_.xml`

`/api/_TokenAPI_.xml`

`/api/_UserInfoAPI_.xml`

`/sequences/_auth_failure_handler_.xml`

`/sequences/_build_.xml`

`/sequences/_cors_request_handler_.xml`

`/sequences/fault.xml`

`/sequences/main.xml`

`/sequences/_production_key_error_.xml`

`/sequences/_resource_mismatch_handler_.xml`

`/sequences/_sandbox_key_error_.xml`

`/sequences/_throttle_out_handler_.xml`

`/sequences/_token_fault_.xml`

`/proxy-services/WorkflowCallbackService.xml`


6.  Move all your tenant Synapse configurations by updating the configurations made in the `<CURRENT_API-M_HOME>/repository/tenants` directory to the `<API-M_2.6.0_HOME>/repository/tenants` directory.

        !!! warning
    **NOTE:** Get the files listed below from the `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default/sequences` directory and replace the corresponding files in the `<API-M_2.6.0_HOME>/repository/tenants/<tenant-id>/synapse-configs/default/sequences` directory.

`_auth_failure_handler_.xml`

`_cors_request_handler_.xml`

`fault.xml`

`main.xml`

`_production_key_error_.xml`

`_resource_mismatch_handler_.xml`

`_sandbox_key_error_.xml`

`_throttle_out_handler_.xml`

### Step 2 - Upgrade API Manager to 3.0.0

1.  Stop all WSO2 API Manager server instances that are running.

2.  Make sure you backed up all the databases and Synapse configurations as instructed in [step 1](#step-1-migrate-the-api-manager-configurations) of the previous section.

3.  To start the migration process, run the respective migration script based on your environment.

    -   [**Linux/Mac OS**](#02e6043bc8244961a20080078c7f5776)
    -   [**Windows**](#e6006f469e4445e4884d96cc2921a816)

    Run the `apim200_to_apim260_gateway_artifact_migrator.sh` script, as shown below, to migrate from API Manager 2.0.0 to 2.6.0.

    ``` java
        ./apim200_to_apim260_gateway_artifact_migrator.sh <API-definitions-path>
    ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.0.0 deployment, reside.

    The API definition paths `<API-definition-path>` are as follows:

    -   Super Tenant - `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default`

    -   Tenant - `<API-M_2.6.0_HOME>/repository/tenants`

    Where, `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0` .

    -   [**Super Tenant**](#supertenant)
    -   [**Tenants**](#4314f6fd42184ef0b98e585488e1896f)

    Run the PowerShell script `apim200_to_apim260_gateway_artifact_migrator.ps1` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim200_to_apim260_gateway_artifact_migrator.ps1 <API-definitions-path>
        ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which are copied from the WSO2 API-M 2.0.0 deployment, reside.

        -   Super Tenant - `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default`

        Where `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0.`

    Run the PowerShell script `apim200_to_apim260_gateway_artifact_migrator_for_tenants.ps1` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                    powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell ( PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim200_to_apim260_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
        ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.0.0 deployment, reside.

        -   Tenants - `<API-M_2.6.0_HOME>/repository/tenants`

        Where `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0.`

        !!! note
        It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.
        !!! info
        Troubleshooting
    ##### Why do I get the following error - apim200\_to\_apim260\_gateway\_artifact\_migrator.ps1 / apim200\_to\_apim260\_gateway\_artifact\_migrator\_for\_tenants.ps1 cannot be loaded because the execution of scripts is disabled on this system?

    When running the `apim200_to_apim260_gateway_artifact_migrator.ps1` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system. To overcome this issue and allow the execution of such scripts, run the following command in the terminal as the Administrator.

    ``` java
        Set-ExecutionPolicy RemoteSigned
    ```


4.  Upgrade the WSO2 API Manager database from version 2.0.0 to version 2.6.0.

    1.  Download the [apimgt-db-migration-scripts-2.0to2.6.zip]({{base_path}}/assets/attachments/103334533/103334535.zip) ZIP and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `WSO2AM_DB` database.

5.  Do the following to re-index the artifacts in the registry:

    1.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_2.6.0_HOME>` / `repository/conf/registry.xml` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1` .

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `<API-M_2.6.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

6.  Upgrade the Identity component in WSO2 API Manager from version 5.2.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `wso2is-5.7.0-migration.zip` and extract it.
    2.  Copy the `migration-resources` folder in the extracted folder to the `<API-M_2.6.0_HOME>` .

    3.  Open the `migration-config.yaml` file in the `migration-resources` directory and edit the `currentVersion` element to 5.2.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.2.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `migrationEnable` element to `true` as defined above.


    4.  Remove the following entries from the `migration-config.yaml` file, which is in the `migration-resources` directory.

        ``` java
                   -
                    name: "EventPublisherMigrator"
                    order: 11
        ```

        and

        ``` java
                       -
                        name: "ChallengeQuestionDataMigrator"
                        order: 5
                        parameters:
                          schema: "identity"
        ```

    5.  Copy the `org.wso2.carbon.is.migration-5.7.0.jar` from the extracted folder to the `<API-M_2.6.0_HOME>/repository/components/dropins` directory.

    6.  Copy the keystores (i.e., `client-truststore.jks` , `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_2.6.0_HOME>/repository/resources/security` directory.

    7.  Start WSO2 API Manager 2.6.0 via the terminal to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux3)
        -   [**Windows**](#windows3)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

`wso2server.bat -Dmigrate -Dcomponent=identity`

    8.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-5.7.0.jar` file, which is in the `<API-M_2.6.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` directory, which is in the `<API-M_2.6.0_HOME>` directory.

7.  Download the [WSO2 API Manager Migration Client](https://docs.wso2.com/download/attachments/28718536/wso2-api-migration-client.zip?api=v2) and copy it to the `<API-M_HOME>/repository/components/dropins` directory.

8.  Stop the WSO2 API-M server if you have started it.

9.  Migrate Access Control support for API Publisher.
    You have to run the following migration client to migrate the Access Control support for the API Publisher, because [Publisher Access Control](https://docs.wso2.com/display/AM260/Enabling+Access+Control+Support+for+API+Publisher) is enabled by default in WSO2 API Manager 2.6.0.

    ``` java
            sh wso2server.sh -DmigrateAccessControl=true
    ```

10. Carryout migration for fault sequence from API-M 2.0.0 to API-M 2.6.0.

    ``` java
            sh wso2server.sh -DmigrateFromVersion=2.0.0
    ```

11. Preserve the case sensitive behavior for the migrated resources by adding the following property to the `<API-M_HOME>/repository/conf/user-mgt.xml` file under `<AuthorizationManager>` as follows:

    ``` xml
            <AuthorizationManager class="org.wso2.carbon.user.core.authorization.JDBCAuthorizationManager">
                ...
                <Property name="PreserveCaseForResources">false</Property>
            </AuthorizationManager>
    ```

12. Restart the WSO2 API-M Server.

    ``` java
            sh wso2server.sh
    ```



#### Step 1.2 - Optionally, migrate the configurations for API-M Analytics

!!! note
This step is **only required** if you have WSO2 API-M Analytics configured in your current deployment.
!!! info
As you are upgrading from WSO2 API-M Analytics 2.0.0, in order migrate the configurations required to run WSO2 API-M Analytics for WSO2 API-M 2.6.0 carryout the same instructions as mentioned in [Upgrading from 2.5.0 to 2.6.0 - Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .
### Step 2 - Upgrade API Manager to 2.6.0