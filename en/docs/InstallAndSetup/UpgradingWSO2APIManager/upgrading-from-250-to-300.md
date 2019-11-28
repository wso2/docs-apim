# Upgrading API Manager from 2.5.0 to 3.0.0

The following information describes how to upgrade your API Manager server **from APIM 2.5.0 to 3.0.0** .

!!! note
    Before you follow this section, see [Upgrading Process](../UpgradingWSO2APIManager/upgrading-process.md) for more information.

!!! attention "Before you Begin"

    1. This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

        -   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.0.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/updates/Using+WSO2+Update+Manager).

    2. Before starting the upgrade, run the [token and session cleanup scripts](../../Administer/ProductAdministration/removing-unused-tokens-from-the-database.md) in the databases of the environment, if you are not doing regular cleanups.

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.5.0 to 3.0.0** .

### Preparing for Migration
#### Disabling versioning in the registry configuration

If there are frequently updating registry properties, having the versioning enabled for registry resources can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 3.0.0.

Therefore, when migrating to API Manager 3.0.0, it is **required** to turn off the registry versioning in your
current API Manager 2.5.0 version and run the below scripts against **the registry database**.

!!! note
    Alternatively, it is possible to turn on registry versioning in API Manager 3.0.0 and continue. But this is
    highly **NOT RECOMMENDED** and these configurations should only be changed once.

!!! info "Turning off registry versioning in your current API-M and running the scripts"
    Open the `registry.xml` file in the `<OLD_API-M_HOME>/repository/conf` directory.
    Set the `versioningProperties`, `versioningComments`, `versioningTags` and `versioningRatings`
    false.
    
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
!!! warning "Not Recommeded"
    If you decided to proceed with registry resource versioning enabled, add the following configuration to the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file. 
    
    ```
    [registry.static_configuration]
    enable=true
    ```
    
    !!! note
        Changing these configuration should only be done before the initial API-M Server startup. If changes are done after the initial startup, the registry resource created previously will not be available.

!!! note
    If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.9.0](../UpgradingWSO2ISAsKeyManager/upgrading-from-is-km-560-to-590.md).

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
        In API-M 3.0.0, a combined **SHARED_DB** has been introduced to keep both the user related data (`WSO2UM_DB`) and the registry data (`WSO2REG_DB`). If you have used separate DBs for user management and registry in the older version, you need to configure WSO2REG_DB and WSO2UM_DB databases separately in API-M 3.0.0 to avoid any issues.

    **SHARED_DB** should be pointed to the previous API-M version's `WSO2REG_DB`. This example shows to configure MySQL database configurations.

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

4.  Update `<API-M_3.0.0_HOME>/repository/resources/conf/default.json` file by pointing to the **WSO2UM_DB**.

    ```
    "realm_manager": {
        "data_source": "WSO2USER_DB",
        "properties": {
        "isCascadeDeleteEnabled": true,
        "initializeNewClaimManager": true
        }
    }
    ```

    !!! info
        In API-M 3.0.0, you do not need to configure the registry configurations as you did in the `<OLD_API-M_HOME>/repository/conf/registry.xml` file and the user database configurations as you did in in the `<OLD_API-M_HOME>/repository/conf/user-mgt.xml` file, as those configurations have been handled internally.


5.  Copy the relevant JDBC driver to the `<API-M_3.0.0_HOME>/repository/components/lib` folder.

6.  Move all your Synapse configurations to API-M 3.0.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and replace the contents in the `<API-M_3.0.0_HOME>/repository/deployment/server/synapse-configs/default` directory with the copied contents.
    -   Move all your tenant Synapse configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/tenants` directory and replace the contents in the `<API-M_3.0.0_HOME>/repository/tenants` directory with the copied contents.

    !!! warning
        When moving the Synapse configurations, **do not replace** the following set of files as they contain some modifications in API-M 3.0.0 version.

        -   \_RevokeAPI_.xml
        -   \_cors_request_handler_.xml
        -   main.xml

    !!! attention          
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Gateway** node.

7. Move all your Execution plans from <API-M_2.5.0_HOME>/repository/deployment/server/executionplans directory to <API-M_3.0.0_HOME>/repository/deployment/server/executionplans directory.

    !!! note
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Traffic Manager** node.

8. If you manually added any custom OSGI bundles to the `<API-M_2.5.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_3.0.0_HOME>/repository/components/dropins` directory. 

9. If you manually added any JAR files to the `<API-M_2.5.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_3.0.0_HOME>/repository/components/lib` directory.

10. WSO2 API Manager 3.0.0 has been upgraded to log4j2 (from log4j). You will notice that there is a log4j2.properties file in the `<API-M_3.0.0_HOME>/repository/conf/` directory instead of the log4j.properties file. Follow [Upgrading to Log4j2](../UpgradingWSO2APIManager/upgrading-to-log4j2.md) to migrate your existing log4j configurations.

    !!! warning
        Taking the log4j.properties file from your old WSO2 API-M Server and adding it to WSO2 API-M Server 3.0.0 will no longer work. Refer [Upgrading to Log4j2](../UpgradingWSO2APIManager/upgrading-to-log4j2.md) to see how to add a log appender or a logger to the log4j2.properties file.

    !!! note
        Log4j2 has hot deployment support, and **Managing Logs** section has been removed from the Management Console. You can now use the log4j2.properties file to modify logging configurations without restarting the server.

### Step 2 - Upgrade API Manager to 3.0.0

1.  Stop all WSO2 API Manager server instances that are running.

2.  Make sure you backed up all the databases and Synapse configurations as instructed in [step 1](#step-1-migrate-the-api-manager-configurations) of the previous section.

3.   Upgrade the WSO2 API Manager database from version 2.5.0 to version 3.0.0 by executing the relevant database script, provided below, on the `WSO2AM_DB` database.

    !!! note
            If you are using DB2 database, follow the follwoing steps before executing the database script.

            DB2 doesn't have an inbuilt function to generate a UUID. Insert the jar file which does the UUID generation logic as guided below.

            1.  Time to fire up DB2
            ```
            db2 -t
            ```

            2.  Connect to the database
            ```
            connect to <WSO2AM_DB>
            ```

            3.  Register the [UUIDUDF.jar](../../assets/attachments/SetupAndInstall/UUIDUDF.jar) file with the database.
            ```
            call sqlj.install_jar('file:.\UUIDUDF.jar', 'UUIDUDFJAR')
            ```

            You may want to move the JAR file to a safe place and adjust the path above accordingly.
            In a multi-member environment, make sure the file is accessible to all members.

    ??? info "DB Scripts"
        ```tab="H2"
        DROP TABLE IF EXISTS AM_ALERT_TYPES;

        CREATE TABLE IF NOT EXISTS AM_ALERT_TYPES (
                    ALERT_TYPE_ID INTEGER AUTO_INCREMENT,
                    ALERT_TYPE_NAME VARCHAR(256) NOT NULL ,
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

        ALTER TABLE AM_CERTIFICATE_METADATA DROP CONSTRAINT IF EXISTS END_POINT_CONSTRAINT;

        CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
            ID int(11) NOT NULL AUTO_INCREMENT,
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
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

        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE_PUBLISHER (
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

        -- Start of Data Migration Scripts --
        UPDATE AM_API_RATINGS SET RATING_ID=(SELECT RANDOM_UUID());
        UPDATE AM_API_COMMENTS SET COMMENT_ID=(SELECT RANDOM_UUID());

        CREATE TABLE IF NOT EXISTS AM_REVOKED_JWT (
        UUID VARCHAR(255) NOT NULL,
        SIGNATURE VARCHAR(2048) NOT NULL,
        EXPIRY_TIMESTAMP BIGINT NOT NULL,
        TENANT_ID INTEGER DEFAULT -1,
        TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
        TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (UUID)
        );          
        ```
    
        ```tab="DB2"
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

        BEGIN
        DECLARE CONTINUE HANDLER FOR SQLSTATE '42704'
        BEGIN END;
        EXECUTE IMMEDIATE 'ALTER TABLE AM_CERTIFICATE_METADATA DROP CONSTRAINT END_POINT_CONSTRAINT';
        END
        /

        CREATE TABLE AM_SYSTEM_APPS (
            ID INTEGER NOT NULL,
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (ID)
        )
        /

        CREATE SEQUENCE AM_SYSTEM_APPS_SEQUENCE START WITH 1 INCREMENT BY 1 NOCACHE
        /
        CREATE TRIGGER AM_SYSTEM_APPS_TRIGGER NO CASCADE BEFORE INSERT ON AM_SYSTEM_APPS
        REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
            SET (NEW.ID)
            = (NEXTVAL FOR AM_SYSTEM_APPS_SEQUENCE);
        END
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
        CREATE TABLE AM_MONETIZATION_USAGE_PUBLISHER (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        )/

        ALTER TABLE AM_API_COMMENTS
            ALTER COLUMN COMMENT_ID
            SET DATA TYPE VARCHAR(255) NOT NULL
        /

        ALTER TABLE AM_API_RATINGS
            ALTER COLUMN RATING_ID
            SET DATA TYPE VARCHAR(255) NOT NULL
        /

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

        -- Start of Data Migration Scripts --
        -- DB2 doesn't have an inbuilt function to generate a UUID. --
        -- Make sure you have registered the jar file which does the logic as guided in the doc. --

        CREATE OR REPLACE FUNCTION RANDOMUUID()
        RETURNS VARCHAR(36)
        LANGUAGE JAVA
        PARAMETER STYLE JAVA
        NOT DETERMINISTIC NO EXTERNAL ACTION NO SQL
        EXTERNAL NAME 'UUIDUDFJAR:UUIDUDF.randomUUID' ;
        /

        UPDATE AM_API_RATINGS SET RATING_ID=(RANDOMUUID())
        /
        UPDATE AM_API_COMMENTS SET COMMENT_ID=(RANDOMUUID())
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
        ```

        ```tab="MSSQL"
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

        ALTER TABLE AM_CERTIFICATE_METADATA DROP CONSTRAINT IF EXISTS END_POINT_CONSTRAINT;

        CREATE TABLE AM_SYSTEM_APPS (
            ID INTEGER IDENTITY,
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME DATETIME2(6) DEFAULT CURRENT_TIMESTAMP,
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

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_MONETIZATION_USAGE_PUBLISHER]') AND TYPE IN (N'U'))

        CREATE TABLE AM_MONETIZATION_USAGE_PUBLISHER (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        );

        DECLARE @con as VARCHAR(8000);
        SET @con = (SELECT name from sys.objects where parent_object_id=object_id('AM_API_COMMENTS') AND type='PK');
        EXEC('ALTER TABLE AM_API_COMMENTS
        drop CONSTRAINT ' + @con);
        ALTER TABLE AM_API_COMMENTS
        DROP COLUMN COMMENT_ID;
        ALTER TABLE AM_API_COMMENTS
        ADD COMMENT_ID VARCHAR(255) NOT NULL;
        ALTER TABLE AM_API_COMMENTS
        ADD PRIMARY KEY (COMMENT_ID);

        DECLARE @con as VARCHAR(8000);
        SET @con = (SELECT name from sys.objects where parent_object_id=object_id('AM_API_RATINGS') AND type='PK');
        EXEC('ALTER TABLE AM_API_RATINGS
        drop CONSTRAINT ' + @con);
        ALTER TABLE AM_API_RATINGS
        DROP COLUMN RATING_ID;
        ALTER TABLE AM_API_RATINGS
        ADD RATING_ID VARCHAR(255) NOT NULL;
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

        -- Start of Data Migration Scripts --
        UPDATE AM_API_RATINGS SET RATING_ID=(SELECT NEWID());
        UPDATE AM_API_COMMENTS SET COMMENT_ID=(SELECT NEWID());

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
        ```

        ```tab="MySQL"
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

        DELIMITER //
        CREATE PROCEDURE DeleteEndPointConstraintIndex()
        BEGIN
        IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.STATISTICS  WHERE TABLE_NAME = 'AM_CERTIFICATE_METADATA'
                    AND INDEX_NAME = 'END_POINT_CONSTRAINT') THEN
        ALTER TABLE  AM_CERTIFICATE_METADATA DROP INDEX END_POINT_CONSTRAINT;
        END IF;
        END//
        DELIMITER ;
        CALL DeleteEndPointConstraintIndex();
        DROP PROCEDURE IF EXISTS DeleteEndPointConstraintIndex;

        CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
            ID int(11) NOT NULL AUTO_INCREMENT,
            NAME VARCHAR(50) NOT NULL,
            CONSUMER_KEY VARCHAR(512) NOT NULL,
            CONSUMER_SECRET VARCHAR(512) NOT NULL,
            CREATED_TIME TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
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
        ADD MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL, 
        ADD FIXED_RATE VARCHAR(15) NULL DEFAULT NULL, 
        ADD BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL, 
        ADD PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL, 
        ADD CURRENCY VARCHAR(15) NULL DEFAULT NULL;

        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE_PUBLISHER (
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
        )ENGINE INNODB;

        -- Start of Data Migration Scripts --
        UPDATE AM_API_RATINGS SET RATING_ID=(SELECT UUID());
        UPDATE AM_API_COMMENTS SET COMMENT_ID=(SELECT UUID());

        CREATE TABLE IF NOT EXISTS AM_REVOKED_JWT (
        UUID VARCHAR(255) NOT NULL,
        SIGNATURE VARCHAR(2048) NOT NULL,
        EXPIRY_TIMESTAMP BIGINT NOT NULL,
        TENANT_ID INTEGER DEFAULT -1,
        TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
        TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (UUID)
        ) ENGINE=InnoDB;
        ```
    
        ```tab="Oracle"
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

        BEGIN
        DECLARE
        COUNT_CONSTRAINTS INTEGER;
        BEGIN
            COUNT_CONSTRAINTS :=0;
            SELECT COUNT(*) INTO COUNT_CONSTRAINTS 
            FROM USER_CONSTRAINTS 
            WHERE CONSTRAINT_NAME = 'END_POINT_CONSTRAINT';
            IF COUNT_CONSTRAINTS > 0 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE AM_CERTIFICATE_METADATA DROP CONSTRAINT END_POINT_CONSTRAINT';
            END IF;
        END;
        END;
        /

        CREATE TABLE AM_SYSTEM_APPS (
            ID INTEGER NOT NULL,
            NAME VARCHAR (50) NOT NULL,
            CONSUMER_KEY VARCHAR (512) NOT NULL,
            CONSUMER_SECRET VARCHAR (512) NOT NULL,
            CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
                SELECT SEQUENCE AM_SYSTEM_APP_SEQUENCE.nextval INTO :NEW.ID FROM dual;
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

        CREATE TABLE AM_MONETIZATION_USAGE_PUBLISHER (
            ID VARCHAR(100) NOT NULL,
            STATE VARCHAR(50) NOT NULL,
            STATUS VARCHAR(50) NOT NULL,
            STARTED_TIME VARCHAR(50) NOT NULL,
            PUBLISHED_TIME VARCHAR(50) NOT NULL,
            PRIMARY KEY(ID)
        )
        /

        ALTER TABLE AM_API_COMMENTS
        MODIFY COMMENT_ID VARCHAR(255) NOT NULL
        /

        ALTER TABLE AM_API_RATINGS
        MODIFY RATING_ID VARCHAR(255) NOT NULL
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

        -- Start of Data Migration Scripts --
        UPDATE AM_API_RATINGS SET RATING_ID=(SELECT REGEXP_REPLACE(SYS_GUID(), '(.{8})(.{4})(.{4})(.{4})(.{12})', '\1-\2-\3-\4-\5') MSSQL_GUID  FROM DUAL)
        /
        UPDATE AM_API_COMMENTS SET COMMENT_ID=(SELECT REGEXP_REPLACE(SYS_GUID(), '(.{8})(.{4})(.{4})(.{4})(.{12})', '\1-\2-\3-\4-\5') MSSQL_GUID  FROM DUAL)
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
        ```
        
        ```tab="PostgreSQL"
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

        ALTER TABLE AM_CERTIFICATE_METADATA DROP CONSTRAINT IF EXISTS END_POINT_CONSTRAINT;

        CREATE SEQUENCE AM_SYSTEM_APP_SEQUENCE START WITH 1 INCREMENT BY 1 ;
        CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
                    ID INTEGER DEFAULT nextval('am_system_app_sequence'),
                    NAME VARCHAR(50) NOT NULL,
                    CONSUMER_KEY VARCHAR(512) NOT NULL,
                    CONSUMER_SECRET VARCHAR(512) NOT NULL,
                    CREATED_TIME TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
                    PRIMARY KEY (ID)
        );

        CREATE TABLE IF NOT EXISTS AM_API_CLIENT_CERTIFICATE (
        TENANT_ID INTEGER NOT NULL,
        ALIAS VARCHAR(45) NOT NULL,
        API_ID INTEGER NOT NULL,
        CERTIFICATE BYTEA NOT NULL,
        REMOVED BOOLEAN NOT NULL DEFAULT 0,
        TIER_NAME VARCHAR (512),
        FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE ON UPDATE CASCADE,
        PRIMARY KEY (ALIAS,TENANT_ID, REMOVED)
        );

        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL,
        ADD FIXED_RATE VARCHAR(15) NULL DEFAULT NULL, 
        ADD BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL, 
        ADD PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL, 
        ADD CURRENCY VARCHAR(15) NULL DEFAULT NULL;

        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE_PUBLISHER (
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
        ```

4.  Copy the keystores (i.e., `client-truststore.jks` , `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_3.0.0_HOME>/repository/resources/security` directory.

    !!! note "If you have enabled Secure Vault"
        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below.

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

5.  Upgrade the Identity component in WSO2 API Manager from version 5.6.0 to 5.9.0.

    !!! note
        As WSO2 API-M shares identity components with WSO2 Identity Sever (WSO2 IS), this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).

    ??? note "If you are using DB2"
        Move indexes to the the TS32K Tablespace. The index tablespace in the `IDN_OAUTH2_ACCESS_TOKEN`  and `IDN_OAUTH2_AUTHORIZATION_CODE` tables need
        to be moved to the existing TS32K tablespace in order to support newly added table indexes.

        SQLADM or DBADM authority is required in order to invoke the `ADMIN_MOVE_TABLE` stored procedure. You must also have the appropriate object creation authorities, including authorities to issue the SELECT statement on the source table and to issue the INSERT statement on the target table.
        

        ??? info "Click here to see the stored procedure" 
            ``` java
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

        If you recieve an error due to missing `SYSTOOLSPACE` or `SYSTOOLSTMPSPACE` tablespaces, create those tablespaces manually using the following script prior to executing the stored procedure given above. For more information, see [SYSTOOLSPACE and SYSTOOLSTMPSPACE tablespaces](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_10.5.0/com.ibm.db2.luw.admin.gui.doc/doc/c0023713.html) in the IBM documentation.           

        ``` java
        CREATE TABLESPACE SYSTOOLSPACE IN IBMCATGROUP
        MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
        EXTENTSIZE 4;
        
        CREATE USER TEMPORARY TABLESPACE SYSTOOLSTMPSPACE IN IBMCATGROUP
        MANAGED BY AUTOMATIC STORAGE USING STOGROUP IBMSTOGROUP
        EXTENTSIZE 4;
        ```
    1.  Download the [wso2is-5.9.0-migration.zip](../../assets/attachments/SetupAndInstall/wso2is-5.9.0-migration.zip) and extract it.

    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_3.0.0_HOME>` directory.

    3.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.6.0, as shown below.

        ``` java
        migrationEnable: "true"
        currentVersion: "5.6.0"
        migrateVersion: "5.9.0"
        ```

        !!! note
            Make sure you have enabled migration by setting the **migrationEnable** element to `true` as shown above.

    4.  Copy the `org.wso2.carbon.is.migration-1.0.23.jar` from the extracted folder to the `<API-M_3.0.0_HOME>/repository/components/dropins` directory.

    5.  Start WSO2 API Manager 3.0.0 as follows to carry out the complete Identity component migration.

        ```tab="Linux / Mac OS"
        sh wso2server.sh -Dmigrate -Dcomponent=identity
        ```

        ```tab="Windows"
        wso2server.bat -Dmigrate -Dcomponent=identity
        ```

        !!! note
            Please note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and please wait until the migration process finish completely and server get started.

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

    6.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-1.0.23.jar` file, which is in the `<API-M_3.0.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` directory, which is in the `<API-M_3.0.0_HOME>` directory.

        -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the wso2server.bat file.

            ```
            -Dmigrate -Dcomponent=identity
            ```

6.  Re-index the artifacts in the registry.

    1.  Run the [reg-index.sql](../../assets/attachments/SetupAndInstall/reg-index.sql) script against the configured `SHARED_DB` database.

        !!! note
            Please note that depending on the number of records in the REG_LOG table, this script will take a considerable amount of time to finish. Do not stop the execution of script until it is completed.

    2.  Add the [tenantloader-1.0.jar](../../assets/attachments/SetupAndInstall/tenantloader-1.0.jar) to `<API-M_3.0.0_HOME>/repository/components/dropins` directory.

        !!! attention
            If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Store and Publisher** nodes.

        !!! note
            You need to do this step, if you have **multiple tenants** only.

    3. Rename the **<lastAccessTimeLocation>** element by adding the following configuration in `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file.

        ```
        [indexing]
        re_indexing= 1
        ```

        !!! info 
            If you use a clustered/distributed API Manager setup, change the file in the API Publisher node. For example, change the /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime registry path to /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1

    4. If the `<API-M_3.0.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

    5.  Start the WSO2 API-M server.

    6.  Stop the WSO2 API-M server and remove the tenantloader-1.0.jar from the `<API-M_3.0.0_HOME>/repository/components/dropins` directory.

### Step 3 - Optionally, migrate the configurations for WSO2 API-M Analytics

!!! warning
    This step is **only required** if you have WSO2 API-M-Analytics configured in your current deployment.

Follow the steps below to migrate APIM Analytics 2.5.0 to APIM Analytics 3.0.0

#### Step 3.1 - Configure WSO2 API-M Analytics 3.0.0

!!! note
    -   In API-M 2.5.0, when working with API-M Analytics, only the worker profile has been used by default and dashboard profile is used only when there are custom dashboards.
    -   In API-M 3.0.0, both the worker and dashboard profiles are being used. The default Store and Publisher dashboards are now being moved to the Analytics dashboard server side and they have been removed from the API-M side.
    -   The same set of DBs will be used in the Analytics side and additionally you need to share the WSO2AM_DB with the dashboard server node.

1.  Download WSO2 API Manager Analytics 3.0.0 from [here](http://wso2.com/api-management/).

2.  Create a new database for the new statistics database and configure it in the `<APIM_ANALYTICS_3.0.0_HOME>/conf/dashboard/deployment.yaml` and `<API-M_ANALYTICS_3.0.0_HOME>/conf/worker/deployment.yaml` as follows:

    In this example shows to configure MySQL database configurations.

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
            username: username
            password: password
            driverClassName: com.mysql.jdbc.Driver
            maxPoolSize: 50
            idleTimeout: 60000
            connectionTestQuery: SELECT 1
            validationTimeout: 30000
            isAutoCommit: false
    ```

3.  Share the AM_DB with dashboard profile by adding following configuration to `<API-M_ANALYTICS_3.0.0_HOME>/conf/dashboard/deployment.yaml`. 

    ``` java
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

3.  Copy the relevant JDBC driver OSGI bundle to the `<APIM_ANALYTICS_3.0.0_HOME>/lib` folder.

    !!! info "To convert the jar files to OSGi bundles, follow the steps given below."
        1. Download the non-OSGi jar for the required third party product, and save it in a preferred directory in your machine.
        2. Go to the <API-M_ANALYTICS_HOME>/bin directory. Run the command given below, to generate the converted file in the <API-M_ANALYTICS_HOME>/lib directory.

        ```
        ./jartobundle.sh <PATH_TO_NON-OSGi_JAR> ../lib
        ```

4.  Start the worker and dashboard profiles using following commands.

    ```tab="Worker"
    sh worker.sh
    ```

    ```tab="Dashboard"
    sh dashboard.sh
    ```

#### Step 3.2 - Configure WSO2 API-M 3.0.0 for Analytics

Follow the instructions below to configure WSO2 API Manager for the WSO2 API-M Analytics migration in order to migrate the statistics related data.

1.  Configure following statistics related datasources for WSO2 API Manager Analytics in the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file.

    !!! warning
        The following 3 datasources should be configured in the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file **only until the stats migration is complete** . After the statistics migration is completed remove the `APIM_ANALYTICS_DB` datasource configuration, which was added for the new statistics database, from the latter mentioned file.


    The following in an example of how the configurations should be defined when using MySQL.

    -   The first datasource points to the **previous API-M version's AM\_DB datasource.**

        ``` java
        [database.apim_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/am_db"
        username = "username"
        password = "password"
        ```

    -   The second datasource points to the **WSO2 Data Analytics (WSO2 DAS) based previous datasource WSO2AM\_STATS\_DB for statistics** .

        ``` java
        [[datasource]]
        id = "WSO2AM_STATS_DB"
        url = "jdbc:oracle:thin:@localhost:1521/wso2carbon"
        username = "mig_stats"
        password = "wso2carbon"
        driver = "oracle.jdbc.driver.OracleDriver"
        validationQuery = "SELECT 1 FROM DUAL"
        pool_options.maxActive = 50
        pool_options.maxWait = 60000
        pool_options.validationInterval = 30000
        pool_options.defaultAutoCommit = false
        ```

    -   The third datasource points to the **WSO2 Stream Processor (WSO2 SP) based new datasource APIM\_ANALYTICS\_DB for statistics.**

        ``` java
        [[datasource]]
        id = "APIM_ANALYTICS_DB"
        url = "jdbc:oracle:thin:@localhost:1521/wso2carbon"
        username = "analyticsDB"
        password = "wso2carbon"
        driver = "oracle.jdbc.driver.OracleDriver"
        validationQuery = "SELECT 1 FROM DUAL"
        pool_options.maxActive = 50
        pool_options.maxWait = 60000
        pool_options.validationInterval = 30000
        pool_options.defaultAutoCommit = false
        ```

2.  Download and copy the [org.wso2.carbon.apimgt.migrate.client-3.0.x-1.jar](../../assets/attachments/SetupAndInstall/org.wso2.carbon.apimgt.migrate.client-3.0.x-1.jar) to the `<API-M_3.0.0_HOME>/repository/components/dropins` folder.

3.  Copy the relevant JDBC driver to the `<API-M_3.0.0_HOME>/repository/components/lib` folder.

4.  Make sure that WSO2 API-M Analytics is disabled in the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file.

    ``` java
    [apim.analytics]
    enable = false
    ```

5.  After setting the above configurations in place, start up the WSO2 API-M 3.0.0 server with the following commands.

    ``` tab="Linux / Mac OS"
    sh wso2server.sh -DmigrateStats=true
    ```

    ``` tab="Windows"
    wso2server.bat -DmigrateStats=true
    ```

    !!! info "Table-wise Migration"
        The migration client provides the support for table-wise migration. The following are the table names that needs to be migrated.

        ``` java
        ApiPerDestinationAgg
        ApiResPathPerApp
        ApiVersionPerAppAgg
        ApiLastAccessSummary
        ApiFaultyInvocationAgg
        ApiUserBrowserAgg
        GeoLocationAgg
        ApiExeTimeDay
        ApiExeTimeHour
        ApiExeTimeMinute
        ApiThrottledOutAgg
        APIM_ReqCountAgg
        ApiUserPerAppAgg
        ```

        You need to use the `statTable` migration property for table wise migration.

        For example, if you need to migrate only the `ApiPerDestinationAgg` and `ApiResPathPerApp` tables use the following command:

        !!! attention
            When you need to migrate multiple tables, the comma separated table names should without spaces before or after the comma as shown below.


        ``` java
            sh wso2server.sh -DmigrateStats=true -DstatTable=ApiPerDestinationAgg,ApiResPathPerApp
        ```

    !!! info
        If the default 3 datasource names/name, which you specified above, changed from the details that you specified in the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file. Use the following command to pass the values to the migration client.

        ??? info "Click here to see a code snippet of the definition of the datasource name"

            ``` java
            <jndiConfig>
                <name>jdbc/WSO2AM_DB</name>
            </jndiConfig>
            ```

        ``` tab="Format"
        sh wso2server.sh -DdataSource=<AM_DATASOURCE_NAME>,<OLD_STAT_DATASOURCE_NAME>,<NEW_STAT_DATASOURCE_NAME>
        ```

        ``` tab="Example"
        sh wso2server.sh -DdataSource=jdbc/WSO2AM_DB,jdbc/WSO2AM_STATS_DB,jdbc/APIM_ANALYTICS_DB
        ```

    !!! warning
        The following warning message could occur during migration if the relevant consumer key does not exist in the `AM_APPLICATION_KEY_MAPPING` table due to Application deletion.

        ``` java
        ConsumerKey <consumerKey> does not contain in the AM_APPLICATION_KEY_MAPPING table.
        ```

        In such scenarios, you will face a migration data loss due to API or Application deletion.


6.  Stop the WSO2 API-M server and remove the migration JAR copied under **Step 3.2 - 3**.

7.  Remove both the old and new `STAT_DB` datasources from the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file, which you defined in **Step 3.2 - 1**.

8.  Enable analytics in WSO2 API-M by setting the following configuration to true in the `<API-M_3.0.0_HOME>/repository/conf/deployment.toml` file.

    ``` java
    [apim.analytics]
    enable = true
    ```
### Step 4 - Restart the WSO2 API-M 3.0.0 server

1. Restart the WSO2 API-M Server.

    ``` tab="Linux / Mac OS"
    sh wso2server.sh
    ```

    ``` tab="Windows"
    wso2server.bat
    ```

This concludes the upgrade process.

!!! tip
        The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! note
    If you are using a migrated API and wants to consume it via an application which supports JWT authentication (default type in API-M 3.0.0), you need to republish the API. Without republishing the API, JWT authentication doesn't work as it looks for a local entry which will get populated while publishing.

    You can consume the migrated API via an OAuth2 application without an issue.
