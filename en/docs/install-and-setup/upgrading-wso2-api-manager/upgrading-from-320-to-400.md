# Upgrading API Manager from 3.2.0 to 4.0.0

The following information describes how to upgrade your API Manager server **from APIM 3.2.0 to 4.0.0**.

!!! note
    Before you follow this section, see [Upgrading Process]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-process) for more information.

!!! Attention
    If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, first follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.11.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-5100-to-is-5110).    

!!! Attention
    If you are using WSO2 API Manager Analytics. Please contact WSO2 Team for migration purposes.
    
!!! note "If you are using PostgreSQL"
    The DB user needs to have superuser role to run the migration client and the relevant scripts
    ```
    ALTER USER <user> WITH SUPERUSER;
    ```
!!! note "If you are using Oracle"
    Cmmit the changes after running the scripts given below
    
Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 3.2.0 to 4.0.0**.

### Preparing for Migration
#### Disabling versioning in the registry configuration if it was enabled

If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default from API Manager 3.0.0 onwards.

But, if registry versioning was enabled by you in WSO2 API-M 3.2.0 setup, it is **required** run the below scripts against **the database that is used by the registry**. Follow the below steps to achieve this.

!!! note "NOTE"
    Alternatively, it is possible to turn on registry versioning in API Manager 4.0.0 and continue. But this is
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
-   [Step 2 - Upgrade API Manager to 4.0.0](#step-2-upgrade-api-manager-to-400)
-   [Step 3 - Restart the WSO2 API-M 3.2.0 server](#step-3-restart-the-wso2-api-m-400-server)

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files may have changed. Instead, redo the configuration changes in the new configuration files.

!!! note
    
    - For more information on the configurations in the new configuration model, see the [Configuration Catalog]({{base_path}}/reference/config-catalog).
    - For more information on the mapping between WSO2 API Manager's old configuration files and the new `deployment.toml` file, see [Understanding the New Configuration Model]({{base_path}}/reference/understanding-the-new-configuration-model).

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Download [WSO2 API Manager 4.0.0](http://wso2.com/api-management/).

2.  Open the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file and provide the datasource configurations for the following databases.

    -   User Store
    -   Registry database/s
    -   API Manager databases

    !!! note
        If you have used separate DBs for user management and registry in the previous version, you need to configure WSO2REG_DB and WSO2UM_DB databases separately in API-M 4.0.0 to avoid any issues.

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
        If you have configured WSO2CONFIG_DB in the previous API-M version, add a new entry to the `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` as below.

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
        It is not recommend to use default H2 databases other than `WSO2_MB_STORE_DB` in production. Therefore migration of default H2 databases will not be supported since API-M 4.0.0.
        It is recommended to use the default H2 database for the `WSO2_MB_STORE_DB` database in API-Manager. So do **not** migrate `WSO2_MB_STORE_DB` database from API-M 2.1.0 version to API-M 4.0.0 version, and use the **default H2** `WSO2_MB_STORE_DB` database available in API-M 4.0.0 version.

3.   If you have used separate DB for user management, you need to update `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the correct database for user management purposes.

    ```
    [realm_manager]
    data_source = "WSO2USER_DB"
    ```

4.  Copy the relevant JDBC driver to the `<API-M_4.0.0_HOME>/repository/components/lib` folder.

5.  If you manually added any custom OSGI bundles to the `<API-M_3.2.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_4.0.0_HOME>/repository/components/dropins` directory. 

6.  If you manually added any JAR files to the `<API-M_3.2.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_4.0.0_HOME>/repository/components/lib` directory.

### Step 2 - Upgrade API Manager to 4.0.0

1.  Stop all WSO2 API Manager server instances that are running.

2.  Make sure you backed up all the databases as instructed in [step 1](#step-1-migrate-the-api-manager-configurations) of the previous section.

3.  Upgrade the WSO2 API Manager database from version 3.2.0 to version 4.0.0 by executing the relevant database script, from the scripts that are provided below, on the `WSO2AM_DB` database.

    ??? info "DB Scripts"
        ```tab="DB2"
        ALTER TABLE AM_API ADD API_UUID VARCHAR(255) /
        ALTER TABLE AM_API ADD STATUS VARCHAR(30) /
        ALTER TABLE AM_CERTIFICATE_METADATA ADD CERTIFICATE BLOB DEFAULT NULL /
        ALTER TABLE AM_API ADD REVISIONS_CREATED INTEGER DEFAULT 0 /
        
        CREATE TABLE AM_REVISION (
                    ID INTEGER NOT NULL,
                    API_UUID VARCHAR(256) NOT NULL,
                    REVISION_UUID VARCHAR(255) NOT NULL,
                    DESCRIPTION VARCHAR(255),
                    CREATED_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    CREATED_BY VARCHAR(255),
                    PRIMARY KEY (ID, API_UUID),
                    UNIQUE(REVISION_UUID))
        /
        CREATE TABLE AM_API_REVISION_METADATA (
            API_UUID VARCHAR(64),
            REVISION_UUID VARCHAR(64),
            API_TIER VARCHAR(128),
            UNIQUE (API_UUID,REVISION_UUID)
        )/
        CREATE TABLE AM_DEPLOYMENT_REVISION_MAPPING (
                    NAME VARCHAR(255) NOT NULL,
                    VHOST VARCHAR(255) NULL,
                    REVISION_UUID VARCHAR(255) NOT NULL,
                    DISPLAY_ON_DEVPORTAL BOOLEAN DEFAULT 0,
                    DEPLOYED_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (NAME, REVISION_UUID),
                    FOREIGN KEY (REVISION_UUID) REFERENCES AM_REVISION(REVISION_UUID) ON UPDATE CASCADE ON DELETE CASCADE)
        /
        
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD REVISION_UUID VARCHAR(255) NOT NULL DEFAULT 'Current API' /
        ALTER TABLE AM_API_CLIENT_CERTIFICATE DROP PRIMARY KEY /
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD PRIMARY KEY(ALIAS,TENANT_ID, REMOVED, REVISION_UUID) /
        
        ALTER TABLE AM_API_URL_MAPPING ADD REVISION_UUID VARCHAR(256) /
        
        ALTER TABLE AM_GRAPHQL_COMPLEXITY ADD REVISION_UUID VARCHAR(256) /
        
        ALTER TABLE AM_API_PRODUCT_MAPPING ADD REVISION_UUID VARCHAR(256) /
        
        DROP TABLE IF EXISTS AM_GW_API_DEPLOYMENTS /
        DROP TABLE IF EXISTS AM_GW_API_ARTIFACTS /
        DROP TABLE IF EXISTS AM_GW_PUBLISHED_API_DETAILS /
        
        CREATE TABLE AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          API_TYPE varchar(50),
          PRIMARY KEY (API_ID)
        ) /
        
        CREATE TABLE AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          REVISION_ID varchar(255) NOT NULL,
          ARTIFACT blob,
          TIME_STAMP TIMESTAMP NOT NULL GENERATED ALWAYS FOR EACH ROW ON UPDATE AS ROW CHANGE TIMESTAMP,
          PRIMARY KEY (REVISION_ID, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS (API_ID) ON DELETE NO ACTION ON UPDATE RESTRICT)
           /
        
        CREATE TABLE IF NOT EXISTS AM_GW_API_DEPLOYMENTS (
          API_ID VARCHAR(255) NOT NULL,
          REVISION_ID VARCHAR(255) NOT NULL,
          LABEL VARCHAR(255) NOT NULL,
          VHOST VARCHAR(255) NULL,
          PRIMARY KEY (REVISION_ID, API_ID,LABEL),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
        )
        /
        
        -- Service Catalog --
        CREATE TABLE AM_SERVICE_CATALOG (
                    UUID VARCHAR(36) NOT NULL,
                    SERVICE_KEY VARCHAR(100) NOT NULL,
                    MD5 VARCHAR(100) NOT NULL,
                    SERVICE_NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(255) NOT NULL,
                    SERVICE_VERSION VARCHAR(30) NOT NULL,
                    SERVICE_URL VARCHAR(2048) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    DEFINITION_TYPE VARCHAR(20),
                    DEFINITION_URL VARCHAR(2048),
                    DESCRIPTION VARCHAR(1024),
                    SECURITY_TYPE VARCHAR(50),
                    MUTUAL_SSL_ENABLED SMALLINT DEFAULT 0,
                    CREATED_TIME TIMESTAMP NULL,
                    LAST_UPDATED_TIME TIMESTAMP NULL,
                    CREATED_BY VARCHAR(255),
                    UPDATED_BY VARCHAR(255),
                    SERVICE_DEFINITION BLOB NOT NULL,
                    METADATA BLOB NOT NULL,
                    PRIMARY KEY (UUID),
                    CONSTRAINT SERVICE_KEY_TENANT UNIQUE(SERVICE_KEY, TENANT_ID),
                    CONSTRAINT SERVICE_NAME_VERSION_TENANT UNIQUE (SERVICE_NAME, SERVICE_VERSION, TENANT_ID))
        /
        
        -- Webhooks --
        CREATE TABLE AM_WEBHOOKS_SUBSCRIPTION (
                    WH_SUBSCRIPTION_ID INTEGER,
                    API_UUID VARCHAR(255) NOT NULL,
                    APPLICATION_ID VARCHAR(20) NOT NULL,
                    TENANT_DOMAIN VARCHAR(255) NOT NULL,
                    HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                    HUB_TOPIC VARCHAR(255) NOT NULL,
                    HUB_SECRET VARCHAR(2048),
                    HUB_LEASE_SECONDS INTEGER,
                    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    EXPIRY_AT BIGINT,
                    DELIVERED_AT TIMESTAMP NULL,
                    DELIVERY_STATE SMALLINT,
                    PRIMARY KEY (WH_SUBSCRIPTION_ID))
        /
        CREATE SEQUENCE AM_WEBHOOKS_SUBSCRIPTION_SEQUENCE START WITH 1 INCREMENT BY 1 NOCACHE
        /
        CREATE TRIGGER AM_WEBHOOKS_SUBSCRIPTION_TRIGGER NO CASCADE BEFORE INSERT ON AM_WEBHOOKS_SUBSCRIPTION
        REFERENCING NEW AS NEW FOR EACH ROW MODE DB2SQL
        
        BEGIN ATOMIC
        
            SET (NEW.WH_SUBSCRIPTION_ID)
               = (NEXTVAL FOR AM_WEBHOOKS_SUBSCRIPTION_SEQUENCE);
        
        END
        /
        
        CREATE TABLE AM_WEBHOOKS_UNSUBSCRIPTION (
                    API_UUID VARCHAR(255) NOT NULL,
                    APPLICATION_ID VARCHAR(20) NOT NULL,
                    TENANT_DOMAIN VARCHAR(255) NOT NULL,
                    HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                    HUB_TOPIC VARCHAR(255) NOT NULL,
                    HUB_SECRET VARCHAR(2048),
                    HUB_LEASE_SECONDS INTEGER,
                    ADDED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
        /
        
        CREATE TABLE AM_API_SERVICE_MAPPING (
            API_ID INTEGER NOT NULL,
            SERVICE_KEY VARCHAR(256) NOT NULL,
            MD5 VARCHAR(100) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            PRIMARY KEY (API_ID, SERVICE_KEY),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE
        )
        /
        
        -- Gateway Environments Table --
        CREATE TABLE AM_GATEWAY_ENVIRONMENT (
                    ID INTEGER NOT NULL,
                    UUID VARCHAR(45) NOT NULL,
                    NAME VARCHAR(255) NOT NULL,
                    TENANT_DOMAIN VARCHAR(255),
                    DISPLAY_NAME VARCHAR(255) NULL,
                    DESCRIPTION VARCHAR(1023) NULL,
                    UNIQUE (NAME, TENANT_DOMAIN),
                    UNIQUE (UUID),
                    PRIMARY KEY (ID))
        /
        CREATE SEQUENCE AM_GATEWAY_ENV_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        CREATE OR REPLACE TRIGGER AM_GATEWAY_ENVIRONMENT_TRIGGER
        		    BEFORE INSERT
                    ON AM_GATEWAY_ENVIRONMENT
                    REFERENCING NEW AS NEW
                    FOR EACH ROW
                    BEGIN
                        SELECT AM_GATEWAY_ENV_SEQ.nextval INTO :NEW.ID FROM dual;
                    END;
        /
        
        -- Virtual Hosts Table --
        CREATE TABLE AM_GW_VHOST (
                    GATEWAY_ENV_ID INTEGER,
                    HOST VARCHAR(255) NOT NULL,
                    HTTP_CONTEXT VARCHAR(255) NULL,
                    HTTP_PORT VARCHAR(5) NOT NULL,
                    HTTPS_PORT VARCHAR(5) NOT NULL,
                    WS_PORT VARCHAR(5) NOT NULL,
                    WSS_PORT VARCHAR(5) NOT NULL,
                    FOREIGN KEY (GATEWAY_ENV_ID) REFERENCES AM_GATEWAY_ENVIRONMENT(ID) ON DELETE CASCADE,
                    PRIMARY KEY (GATEWAY_ENV_ID, HOST))
        /
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD CONNECTIONS_COUNT INTEGER DEFAULT 0 NOT NULL
        /
        
        ALTER TABLE AM_API_COMMENTS RENAME COLUMN COMMENTED_USER TO CREATED_BY
        /
        ALTER TABLE AM_API_COMMENTS RENAME COLUMN DATE_COMMENTED TO CREATED_TIME
        /
        ALTER TABLE AM_API_COMMENTS ADD UPDATED_TIME DATE
        /
        ALTER TABLE AM_API_COMMENTS ADD PARENT_COMMENT_ID VARCHAR2(255) DEFAULT NULL
        /
        ALTER TABLE AM_API_COMMENTS ADD ENTRY_POINT VARCHAR2(20) DEFAULT 'DEVPORTAL'
        /
        ALTER TABLE AM_API_COMMENTS ADD CATEGORY VARCHAR2(20) DEFAULT 'general'
        /
        ALTER TABLE AM_API_COMMENTS ADD FOREIGN KEY(PARENT_COMMENT_ID) REFERENCES AM_API_COMMENTS(COMMENT_ID)
        /
        ```

        ```tab="MySQL"
         ALTER TABLE AM_API ADD API_UUID VARCHAR(255);
         ALTER TABLE AM_API ADD STATUS VARCHAR(30);
         ALTER TABLE AM_CERTIFICATE_METADATA ADD CERTIFICATE BLOB DEFAULT NULL;
         ALTER TABLE AM_API ADD REVISIONS_CREATED INTEGER DEFAULT 0;
         
         CREATE TABLE IF NOT EXISTS AM_REVISION (
           ID INTEGER NOT NULL,
           API_UUID VARCHAR(256) NOT NULL,
           REVISION_UUID VARCHAR(255) NOT NULL,
           DESCRIPTION VARCHAR(255),
           CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
           CREATED_BY VARCHAR(255),
           PRIMARY KEY (ID, API_UUID),
           UNIQUE(REVISION_UUID)
         )ENGINE INNODB;
         
         CREATE TABLE IF NOT EXISTS AM_API_REVISION_METADATA (
             API_UUID VARCHAR(64),
             REVISION_UUID VARCHAR(64),
             API_TIER VARCHAR(128),
             UNIQUE (API_UUID,REVISION_UUID)
         )ENGINE INNODB;
         
         CREATE TABLE IF NOT EXISTS AM_DEPLOYMENT_REVISION_MAPPING (
           NAME VARCHAR(255) NOT NULL,
           VHOST VARCHAR(255) NULL,
           REVISION_UUID VARCHAR(255) NOT NULL,
           DISPLAY_ON_DEVPORTAL BOOLEAN DEFAULT 0,
           DEPLOYED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
           PRIMARY KEY (NAME, REVISION_UUID),
           FOREIGN KEY (REVISION_UUID) REFERENCES AM_REVISION(REVISION_UUID) ON UPDATE CASCADE ON DELETE CASCADE
         )ENGINE INNODB;
         
         ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD REVISION_UUID VARCHAR(255) NOT NULL DEFAULT 'Current API';
         ALTER TABLE AM_API_CLIENT_CERTIFICATE DROP PRIMARY KEY;
         ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD PRIMARY KEY(ALIAS,TENANT_ID, REMOVED, REVISION_UUID);
         
         ALTER TABLE AM_API_URL_MAPPING ADD REVISION_UUID VARCHAR(256);
         
         ALTER TABLE AM_GRAPHQL_COMPLEXITY ADD REVISION_UUID VARCHAR(256);
         
         ALTER TABLE AM_API_PRODUCT_MAPPING ADD REVISION_UUID VARCHAR(256);
         
         
         
         DROP TABLE IF EXISTS AM_GW_API_DEPLOYMENTS;
         DROP TABLE IF EXISTS AM_GW_API_ARTIFACTS;
         DROP TABLE IF EXISTS AM_GW_PUBLISHED_API_DETAILS;
         
         CREATE TABLE IF NOT EXISTS AM_GW_PUBLISHED_API_DETAILS (
           API_ID varchar(255) NOT NULL,
           TENANT_DOMAIN varchar(255),
           API_PROVIDER varchar(255),
           API_NAME varchar(255),
           API_VERSION varchar(255),
           API_TYPE varchar(50),
           PRIMARY KEY (API_ID)
         )ENGINE=InnoDB;
         CREATE TABLE IF NOT EXISTS AM_GW_API_ARTIFACTS (
           API_ID VARCHAR(255) NOT NULL,
           REVISION_ID VARCHAR(255) NOT NULL,
           ARTIFACT blob,
           TIME_STAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
           PRIMARY KEY (REVISION_ID, API_ID),
           FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
         )ENGINE=InnoDB;
         
         CREATE TABLE IF NOT EXISTS AM_GW_API_DEPLOYMENTS (
           API_ID VARCHAR(255) NOT NULL,
           REVISION_ID VARCHAR(255) NOT NULL,
           LABEL VARCHAR(255) NOT NULL,
           VHOST VARCHAR(255) NULL,
           PRIMARY KEY (REVISION_ID, API_ID,LABEL),
           FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
         ) ENGINE=InnoDB;
         
         -- Service Catalog --
         CREATE TABLE IF NOT EXISTS AM_SERVICE_CATALOG (
                     UUID VARCHAR(36) NOT NULL,
                     SERVICE_KEY VARCHAR(100) NOT NULL,
                     MD5 VARCHAR(100) NOT NULL,
                     SERVICE_NAME VARCHAR(255) NOT NULL,
                     DISPLAY_NAME VARCHAR(255) NOT NULL,
                     SERVICE_VERSION VARCHAR(30) NOT NULL,
                     TENANT_ID INTEGER NOT NULL,
                     SERVICE_URL VARCHAR(2048) NOT NULL,
                     DEFINITION_TYPE VARCHAR(20),
                     DEFINITION_URL VARCHAR(2048),
                     DESCRIPTION VARCHAR(1024),
                     SECURITY_TYPE VARCHAR(50),
                     MUTUAL_SSL_ENABLED BOOLEAN DEFAULT 0,
                     CREATED_TIME TIMESTAMP NULL,
                     LAST_UPDATED_TIME TIMESTAMP NULL,
                     CREATED_BY VARCHAR(255),
                     UPDATED_BY VARCHAR(255),
                     SERVICE_DEFINITION BLOB NOT NULL,
                     METADATA BLOB NOT NULL,
                     PRIMARY KEY (UUID),
                     UNIQUE (SERVICE_NAME, SERVICE_VERSION, TENANT_ID),
                     UNIQUE (SERVICE_KEY, TENANT_ID)
         )ENGINE=InnoDB;
         
         CREATE TABLE IF NOT EXISTS AM_API_SERVICE_MAPPING (
             API_ID INTEGER NOT NULL,
             SERVICE_KEY VARCHAR(256) NOT NULL,
             MD5 VARCHAR(100) NOT NULL,
             TENANT_ID INTEGER NOT NULL,
             PRIMARY KEY (API_ID, SERVICE_KEY),
             FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE
         )ENGINE=InnoDB;
         
         -- Webhooks --
         CREATE TABLE IF NOT EXISTS AM_WEBHOOKS_SUBSCRIPTION (
                     WH_SUBSCRIPTION_ID INTEGER NOT NULL AUTO_INCREMENT,
                     API_UUID VARCHAR(255) NOT NULL,
                     APPLICATION_ID VARCHAR(20) NOT NULL,
                     TENANT_DOMAIN VARCHAR(255) NOT NULL,
                     HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                     HUB_TOPIC VARCHAR(255) NOT NULL,
                     HUB_SECRET VARCHAR(2048),
                     HUB_LEASE_SECONDS INTEGER,
                     UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                     EXPIRY_AT BIGINT,
                     DELIVERED_AT TIMESTAMP NULL,
                     DELIVERY_STATE TINYINT(1),
                     PRIMARY KEY (WH_SUBSCRIPTION_ID)
         )ENGINE INNODB;
         
         CREATE TABLE IF NOT EXISTS AM_WEBHOOKS_UNSUBSCRIPTION (
                     API_UUID VARCHAR(255) NOT NULL,
                     APPLICATION_ID VARCHAR(20) NOT NULL,
                     TENANT_DOMAIN VARCHAR(255) NOT NULL,
                     HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                     HUB_TOPIC VARCHAR(255) NOT NULL,
                     HUB_SECRET VARCHAR(2048),
                     HUB_LEASE_SECONDS INTEGER,
                     ADDED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
         )ENGINE INNODB;
         
         -- Gateway Environments Table --
         CREATE TABLE IF NOT EXISTS AM_GATEWAY_ENVIRONMENT (
           ID INTEGER NOT NULL AUTO_INCREMENT,
           UUID VARCHAR(45) NOT NULL,
           NAME VARCHAR(255) NOT NULL,
           TENANT_DOMAIN VARCHAR(255),
           DISPLAY_NAME VARCHAR(255) NULL,
           DESCRIPTION VARCHAR(1023) NULL,
           UNIQUE (NAME, TENANT_DOMAIN),
           UNIQUE (UUID),
           PRIMARY KEY (ID)
         )ENGINE INNODB;
         
         -- Virtual Hosts Table --
         CREATE TABLE IF NOT EXISTS AM_GW_VHOST (
           GATEWAY_ENV_ID INTEGER,
           HOST VARCHAR(255) NOT NULL,
           HTTP_CONTEXT VARCHAR(255) NULL,
           HTTP_PORT VARCHAR(5) NOT NULL,
           HTTPS_PORT VARCHAR(5) NOT NULL,
           WS_PORT VARCHAR(5) NOT NULL,
           WSS_PORT VARCHAR(5) NOT NULL,
           FOREIGN KEY (GATEWAY_ENV_ID) REFERENCES AM_GATEWAY_ENVIRONMENT(ID) ON UPDATE CASCADE ON DELETE CASCADE,
           PRIMARY KEY (GATEWAY_ENV_ID, HOST)
         )ENGINE INNODB;
         
         ALTER TABLE AM_POLICY_SUBSCRIPTION ADD CONNECTIONS_COUNT INT(11) NOT NULL DEFAULT 0;
         
         ALTER TABLE AM_API_COMMENTS CHANGE COMMENT_ID COMMENT_ID VARCHAR(64);
         ALTER TABLE AM_API_COMMENTS CHANGE COMMENTED_USER CREATED_BY VARCHAR(512);
         ALTER TABLE AM_API_COMMENTS CHANGE DATE_COMMENTED CREATED_TIME TIMESTAMP NOT NULL;
         ALTER TABLE AM_API_COMMENTS ADD UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
         ALTER TABLE AM_API_COMMENTS ADD PARENT_COMMENT_ID VARCHAR(64) DEFAULT NULL;
         ALTER TABLE AM_API_COMMENTS ADD ENTRY_POINT VARCHAR(20) DEFAULT 'DEVPORTAL';
         ALTER TABLE AM_API_COMMENTS ADD CATEGORY VARCHAR(20) DEFAULT 'general';
         ALTER TABLE AM_API_COMMENTS ADD FOREIGN KEY(PARENT_COMMENT_ID) REFERENCES AM_API_COMMENTS(COMMENT_ID);       
        ```
    
        ```tab="Oracle"
        ALTER TABLE AM_API ADD API_UUID VARCHAR(255)
        /
        ALTER TABLE AM_API ADD STATUS VARCHAR(30)
        /
        ALTER TABLE AM_CERTIFICATE_METADATA ADD CERTIFICATE BLOB DEFAULT NULL
        /
        ALTER TABLE AM_API ADD REVISIONS_CREATED INTEGER DEFAULT 0
        /
        
        CREATE TABLE AM_REVISION (
                    ID INTEGER NOT NULL,
                    API_UUID VARCHAR(256) NOT NULL,
                    REVISION_UUID VARCHAR(255) NOT NULL,
                    DESCRIPTION VARCHAR(255),
                    CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    CREATED_BY VARCHAR(255),
                    PRIMARY KEY (ID, API_UUID),
                    UNIQUE(REVISION_UUID))
        /
        
        CREATE TABLE AM_API_REVISION_METADATA (
            API_UUID VARCHAR(64),
            REVISION_UUID VARCHAR(64),
            API_TIER VARCHAR(128),
            UNIQUE (API_UUID,REVISION_UUID)
        )
        /
        
        CREATE TABLE AM_DEPLOYMENT_REVISION_MAPPING (
                    NAME VARCHAR(255) NOT NULL,
                    VHOST VARCHAR(255) NULL,
                    REVISION_UUID VARCHAR(255) NOT NULL,
                    DISPLAY_ON_DEVPORTAL INTEGER DEFAULT 0,
                    DEPLOYED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (NAME, REVISION_UUID),
                    FOREIGN KEY (REVISION_UUID) REFERENCES AM_REVISION(REVISION_UUID) ON DELETE CASCADE)
        /
        
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD REVISION_UUID VARCHAR(255) DEFAULT 'Current API' NOT NULL
        /
        ALTER TABLE AM_API_CLIENT_CERTIFICATE DROP PRIMARY KEY
        /
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD PRIMARY KEY(ALIAS,TENANT_ID, REMOVED, REVISION_UUID)
        /
        
        ALTER TABLE AM_API_URL_MAPPING ADD REVISION_UUID VARCHAR(256)
        /
        ALTER TABLE AM_GRAPHQL_COMPLEXITY ADD REVISION_UUID VARCHAR(256)
        /
        ALTER TABLE AM_API_PRODUCT_MAPPING ADD REVISION_UUID VARCHAR(256)
        /
        
        DROP TABLE AM_GW_API_ARTIFACTS
        /
        DROP TABLE AM_GW_PUBLISHED_API_DETAILS
        /
        
        CREATE TABLE AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          API_TYPE varchar(50),
          PRIMARY KEY (API_ID)
        )
        /
        CREATE TABLE AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          REVISION_ID varchar(255) NOT NULL,
          ARTIFACT blob,
          TIME_STAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (REVISION_ID, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID)
        )
        /
        CREATE TABLE AM_GW_API_DEPLOYMENTS (
          API_ID VARCHAR(255) NOT NULL,
          REVISION_ID VARCHAR(255) NOT NULL,
          LABEL VARCHAR(255) NOT NULL,
          VHOST VARCHAR(255) NULL,
          PRIMARY KEY (REVISION_ID, API_ID,LABEL),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID)
        )
        /
        
        -- Service Catalog --
        CREATE TABLE AM_SERVICE_CATALOG (
                    UUID VARCHAR(36) NOT NULL,
                    SERVICE_KEY VARCHAR(100) NOT NULL,
                    MD5 VARCHAR(100) NOT NULL,
                    SERVICE_NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(255) NOT NULL,
                    SERVICE_VERSION VARCHAR(30) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    SERVICE_URL VARCHAR(2048) NOT NULL,
                    DEFINITION_TYPE VARCHAR(20),
                    DEFINITION_URL VARCHAR(2048),
                    DESCRIPTION VARCHAR(1024),
                    SECURITY_TYPE VARCHAR(50),
                    MUTUAL_SSL_ENABLED NUMBER(1,0) DEFAULT 0,
                    CREATED_TIME TIMESTAMP NULL,
                    LAST_UPDATED_TIME TIMESTAMP NULL,
                    CREATED_BY VARCHAR(255),
                    UPDATED_BY VARCHAR(255),
                    SERVICE_DEFINITION BLOB NOT NULL,
                    METADATA BLOB NOT NULL,
                    PRIMARY KEY (UUID),
                    CONSTRAINT SERVICE_KEY_TENANT UNIQUE(SERVICE_KEY, TENANT_ID),
                    CONSTRAINT SERVICE_NAME_VERSION_TENANT UNIQUE (SERVICE_NAME, SERVICE_VERSION, TENANT_ID))
        /
        
        -- Webhooks --
        CREATE TABLE AM_WEBHOOKS_SUBSCRIPTION (
                    WH_SUBSCRIPTION_ID INTEGER NOT NULL,
                    API_UUID VARCHAR(255) NOT NULL,
                    APPLICATION_ID VARCHAR(255) NOT NULL,
                    TENANT_DOMAIN VARCHAR(255) NOT NULL,
                    HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                    HUB_TOPIC VARCHAR(255) NOT NULL,
                    HUB_SECRET VARCHAR(2048),
                    HUB_LEASE_SECONDS INTEGER,
                    UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    EXPIRY_AT NUMBER(19),
                    DELIVERED_AT TIMESTAMP NULL,
                    DELIVERY_STATE INTEGER,
                    PRIMARY KEY (WH_SUBSCRIPTION_ID))
        /
        
        CREATE SEQUENCE AM_WEBHOOKS_SUBSCRIPTION_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER AM_WEBHOOKS_SUB_TRIGGER
        		    BEFORE INSERT
                    ON AM_WEBHOOKS_SUBSCRIPTION
                    REFERENCING NEW AS NEW
                    FOR EACH ROW
                    BEGIN
                        SELECT AM_WEBHOOKS_SUBSCRIPTION_SEQ.nextval INTO :NEW.WH_SUBSCRIPTION_ID FROM dual;
                    END;
        /
        
        CREATE TABLE AM_WEBHOOKS_UNSUBSCRIPTION (
                    API_UUID VARCHAR(255) NOT NULL,
                    APPLICATION_ID VARCHAR(20) NOT NULL,
                    TENANT_DOMAIN VARCHAR(255) NOT NULL,
                    HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                    HUB_TOPIC VARCHAR(255) NOT NULL,
                    HUB_SECRET VARCHAR(2048),
                    HUB_LEASE_SECONDS INTEGER,
                    ADDED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
        /
        
        CREATE TABLE AM_API_SERVICE_MAPPING (
            API_ID INTEGER NOT NULL,
            SERVICE_KEY VARCHAR(256) NOT NULL,
            MD5 VARCHAR(100) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            PRIMARY KEY (API_ID, SERVICE_KEY),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE
        )
        /
        -- Gateway Environments Table --
        CREATE TABLE AM_GATEWAY_ENVIRONMENT (
                    ID INTEGER NOT NULL,
                    UUID VARCHAR(45) NOT NULL,
                    NAME VARCHAR(255) NOT NULL,
                    TENANT_DOMAIN VARCHAR(255),
                    DISPLAY_NAME VARCHAR(255) NULL,
                    DESCRIPTION VARCHAR(1023) NULL,
                    UNIQUE (NAME, TENANT_DOMAIN),
                    UNIQUE (UUID),
                    PRIMARY KEY (ID))
        /
        CREATE SEQUENCE AM_GATEWAY_ENV_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        CREATE OR REPLACE TRIGGER AM_GATEWAY_ENVIRONMENT_TRIGGER
        		    BEFORE INSERT
                    ON AM_GATEWAY_ENVIRONMENT
                    REFERENCING NEW AS NEW
                    FOR EACH ROW
                    BEGIN
                        SELECT AM_GATEWAY_ENV_SEQ.nextval INTO :NEW.ID FROM dual;
                    END;
        /
        
        -- Virtual Hosts Table --
        CREATE TABLE AM_GW_VHOST (
                    GATEWAY_ENV_ID INTEGER,
                    HOST VARCHAR(255) NOT NULL,
                    HTTP_CONTEXT VARCHAR(255) NULL,
                    HTTP_PORT VARCHAR(5) NOT NULL,
                    HTTPS_PORT VARCHAR(5) NOT NULL,
                    WS_PORT VARCHAR(5) NOT NULL,
                    WSS_PORT VARCHAR(5) NOT NULL,
                    FOREIGN KEY (GATEWAY_ENV_ID) REFERENCES AM_GATEWAY_ENVIRONMENT(ID) ON DELETE CASCADE,
                    PRIMARY KEY (GATEWAY_ENV_ID, HOST))
        /
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD CONNECTIONS_COUNT INTEGER DEFAULT 0 NOT NULL
        /
        
        ALTER TABLE AM_API_COMMENTS RENAME COLUMN COMMENTED_USER TO CREATED_BY
        /
        ALTER TABLE AM_API_COMMENTS RENAME COLUMN DATE_COMMENTED TO CREATED_TIME
        /
        ALTER TABLE AM_API_COMMENTS ADD UPDATED_TIME DATE
        /
        ALTER TABLE AM_API_COMMENTS ADD PARENT_COMMENT_ID VARCHAR2(255) DEFAULT NULL
        /
        ALTER TABLE AM_API_COMMENTS ADD ENTRY_POINT VARCHAR2(20) DEFAULT 'DEVPORTAL'
        /
        ALTER TABLE AM_API_COMMENTS ADD CATEGORY VARCHAR2(20) DEFAULT 'general'
        /
        ALTER TABLE AM_API_COMMENTS ADD FOREIGN KEY(PARENT_COMMENT_ID) REFERENCES AM_API_COMMENTS(COMMENT_ID)
        /
        ```
        
        ```tab="PostgreSQL"
        ALTER TABLE AM_API ADD API_UUID VARCHAR(255);
        ALTER TABLE AM_API ADD STATUS VARCHAR(30);
        ALTER TABLE AM_CERTIFICATE_METADATA ADD CERTIFICATE BYTEA DEFAULT NULL;
        ALTER TABLE AM_API ADD REVISIONS_CREATED INTEGER DEFAULT 0;
        
        DROP TABLE IF EXISTS AM_REVISION;
        CREATE TABLE IF NOT EXISTS AM_REVISION (
                    ID INTEGER NOT NULL,
                    API_UUID VARCHAR(256) NOT NULL,
                    REVISION_UUID VARCHAR(255) NOT NULL,
                    DESCRIPTION VARCHAR(255),
                    CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    CREATED_BY VARCHAR(255),
                    PRIMARY KEY (ID, API_UUID),
                    UNIQUE(REVISION_UUID)
        );
        
        DROP TABLE IF EXISTS AM_API_REVISION_METADATA;
        CREATE TABLE IF NOT EXISTS AM_API_REVISION_METADATA (
            API_UUID VARCHAR(64),
            REVISION_UUID VARCHAR(64),
            API_TIER VARCHAR(128),
            UNIQUE (API_UUID,REVISION_UUID)
        );
        
        DROP TABLE IF EXISTS AM_DEPLOYMENT_REVISION_MAPPING;
        CREATE TABLE IF NOT EXISTS AM_DEPLOYMENT_REVISION_MAPPING (
                    NAME VARCHAR(255) NOT NULL,
                    VHOST VARCHAR(255) NULL,
                    REVISION_UUID VARCHAR(255) NOT NULL,
                    DISPLAY_ON_DEVPORTAL BOOLEAN DEFAULT '0',
                    DEPLOYED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (NAME, REVISION_UUID),
                    FOREIGN KEY (REVISION_UUID) REFERENCES AM_REVISION(REVISION_UUID) ON UPDATE CASCADE ON DELETE CASCADE
        );
        
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD REVISION_UUID VARCHAR(255) NOT NULL DEFAULT 'Current API';
        ALTER TABLE AM_API_CLIENT_CERTIFICATE DROP CONSTRAINT AM_API_CLIENT_CERTIFICATE_PKEY;
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD PRIMARY KEY(ALIAS,TENANT_ID, REMOVED, REVISION_UUID);
        
        ALTER TABLE AM_API_URL_MAPPING ADD REVISION_UUID VARCHAR(256);
        
        ALTER TABLE AM_GRAPHQL_COMPLEXITY ADD REVISION_UUID VARCHAR(256);
        
        ALTER TABLE AM_API_PRODUCT_MAPPING ADD REVISION_UUID VARCHAR(256);
        
        DROP TABLE IF EXISTS AM_GW_API_DEPLOYMENTS;
        DROP TABLE IF EXISTS AM_GW_API_ARTIFACTS;
        DROP TABLE IF EXISTS AM_GW_PUBLISHED_API_DETAILS;
        
        CREATE TABLE IF NOT EXISTS AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          API_TYPE varchar(50),
          PRIMARY KEY (API_ID)
        );
        
        CREATE TABLE IF NOT EXISTS AM_GW_API_ARTIFACTS (
          API_ID VARCHAR(255) NOT NULL,
          REVISION_ID VARCHAR(255) NOT NULL,
          ARTIFACT bytea,
          TIME_STAMP TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (REVISION_ID, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
        );
        CREATE TABLE IF NOT EXISTS AM_GW_API_DEPLOYMENTS (
          API_ID VARCHAR(255) NOT NULL,
          REVISION_ID VARCHAR(255) NOT NULL,
          LABEL VARCHAR(255) NOT NULL,
          VHOST VARCHAR(255) NULL,
          PRIMARY KEY (REVISION_ID, API_ID,LABEL),
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
        
        -- Service Catalog --
        DROP TABLE IF EXISTS AM_SERVICE_CATALOG;
        CREATE TABLE IF NOT EXISTS AM_SERVICE_CATALOG (
                    UUID VARCHAR(36) NOT NULL,
                    SERVICE_KEY VARCHAR(100) NOT NULL,
                    MD5 VARCHAR(100) NOT NULL,
                    SERVICE_NAME VARCHAR(255) NOT NULL,
                    DISPLAY_NAME VARCHAR(255) NOT NULL,
                    SERVICE_VERSION VARCHAR(30) NOT NULL,
                    TENANT_ID INTEGER NOT NULL,
                    SERVICE_URL VARCHAR(2048) NOT NULL,
                    DEFINITION_TYPE VARCHAR(20),
                    DEFINITION_URL VARCHAR(2048),
                    DESCRIPTION VARCHAR(1024),
                    SECURITY_TYPE VARCHAR(50),
                    MUTUAL_SSL_ENABLED BOOLEAN DEFAULT '0',
                    CREATED_TIME TIMESTAMP NULL,
                    LAST_UPDATED_TIME TIMESTAMP NULL,
                    CREATED_BY VARCHAR(255),
                    UPDATED_BY VARCHAR(255),
                    SERVICE_DEFINITION BYTEA NOT NULL,
                    METADATA BYTEA NOT NULL,
                    PRIMARY KEY (UUID),
                    UNIQUE (SERVICE_NAME, SERVICE_VERSION, TENANT_ID),
                    UNIQUE (SERVICE_KEY, TENANT_ID)
        );
        
        -- Webhooks --
        DROP SEQUENCE IF EXISTS AM_WEBHOOKS_PK_SEQ;
        CREATE SEQUENCE AM_WEBHOOKS_PK_SEQ;
        DROP TABLE IF EXISTS AM_WEBHOOKS_SUBSCRIPTION;
        CREATE TABLE IF NOT EXISTS AM_WEBHOOKS_SUBSCRIPTION (
                    WH_SUBSCRIPTION_ID INTEGER DEFAULT NEXTVAL('AM_WEBHOOKS_PK_SEQ'),
                    API_UUID VARCHAR(255) NOT NULL,
                    APPLICATION_ID VARCHAR(20) NOT NULL,
                    TENANT_DOMAIN VARCHAR(255) NOT NULL,
                    HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                    HUB_TOPIC VARCHAR(255) NOT NULL,
                    HUB_SECRET VARCHAR(2048),
                    HUB_LEASE_SECONDS INTEGER,
                    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    EXPIRY_AT BIGINT,
                    DELIVERED_AT TIMESTAMP NULL,
                    DELIVERY_STATE INTEGER,
                    PRIMARY KEY (WH_SUBSCRIPTION_ID)
        );
        
        DROP TABLE IF EXISTS AM_WEBHOOKS_UNSUBSCRIPTION;
        CREATE TABLE IF NOT EXISTS AM_WEBHOOKS_UNSUBSCRIPTION (
                  API_UUID VARCHAR(255) NOT NULL,
                  APPLICATION_ID VARCHAR(20) NOT NULL,
                  TENANT_DOMAIN VARCHAR(255) NOT NULL,
                  HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
                  HUB_TOPIC VARCHAR(255) NOT NULL,
                  HUB_SECRET VARCHAR(2048),
                  HUB_LEASE_SECONDS INTEGER,
                  ADDED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
        
        DROP TABLE IF EXISTS AM_API_SERVICE_MAPPING;
        CREATE TABLE AM_API_SERVICE_MAPPING (
            API_ID INTEGER NOT NULL,
            SERVICE_KEY VARCHAR(256) NOT NULL,
            MD5 VARCHAR(100) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            PRIMARY KEY (API_ID, SERVICE_KEY),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE
        );
        
        
        -- Gateway Environments Table --
        DROP SEQUENCE IF EXISTS AM_GATEWAY_ENVIRONMENT_PK_SEQ;
        CREATE SEQUENCE AM_GATEWAY_ENVIRONMENT_PK_SEQ;
        CREATE TABLE IF NOT EXISTS AM_GATEWAY_ENVIRONMENT (
          ID INTEGER NOT NULL DEFAULT NEXTVAL('AM_GATEWAY_ENVIRONMENT_PK_SEQ'),
          UUID VARCHAR(45) NOT NULL,
          NAME VARCHAR(255) NOT NULL,
          TENANT_DOMAIN VARCHAR(255),
          DISPLAY_NAME VARCHAR(255) NULL,
          DESCRIPTION VARCHAR(1023) NULL,
          UNIQUE (NAME, TENANT_DOMAIN),
          UNIQUE (UUID),
          PRIMARY KEY (ID)
        );
        
        -- Virtual Hosts Table --
        CREATE TABLE IF NOT EXISTS AM_GW_VHOST (
          GATEWAY_ENV_ID INTEGER,
          HOST VARCHAR(255) NOT NULL,
          HTTP_CONTEXT VARCHAR(255) NULL,
          HTTP_PORT VARCHAR(5) NOT NULL,
          HTTPS_PORT VARCHAR(5) NOT NULL,
          WS_PORT VARCHAR(5) NOT NULL,
          WSS_PORT VARCHAR(5) NOT NULL,
          FOREIGN KEY (GATEWAY_ENV_ID) REFERENCES AM_GATEWAY_ENVIRONMENT(ID) ON UPDATE CASCADE ON DELETE CASCADE,
          PRIMARY KEY (GATEWAY_ENV_ID, HOST)
        );
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD CONNECTIONS_COUNT INTEGER NOT NULL DEFAULT 0;
        
        ALTER TABLE AM_API_COMMENTS RENAME COLUMN COMMENTED_USER TO CREATED_BY;
        ALTER TABLE AM_API_COMMENTS RENAME COLUMN DATE_COMMENTED TO CREATED_TIME;
        ALTER TABLE AM_API_COMMENTS ADD UPDATED_TIME TIMESTAMP;
        ALTER TABLE AM_API_COMMENTS ADD PARENT_COMMENT_ID VARCHAR(255) DEFAULT NULL;
        ALTER TABLE AM_API_COMMENTS ADD ENTRY_POINT VARCHAR(20) DEFAULT 'DEVPORTAL';
        ALTER TABLE AM_API_COMMENTS ADD CATEGORY VARCHAR(20) DEFAULT 'general';
        ALTER TABLE AM_API_COMMENTS ADD FOREIGN KEY(PARENT_COMMENT_ID) REFERENCES AM_API_COMMENTS(COMMENT_ID);
        ```
                
        ```tab="MSSQL"
        ALTER TABLE AM_API ADD API_UUID VARCHAR(255);
        ALTER TABLE AM_API ADD STATUS VARCHAR(30);
        ALTER TABLE AM_CERTIFICATE_METADATA ADD CERTIFICATE VARBINARY(MAX) DEFAULT NULL;
        ALTER TABLE AM_API ADD REVISIONS_CREATED INTEGER DEFAULT 0;
        
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_REVISION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_REVISION (
          ID INTEGER NOT NULL,
          API_UUID VARCHAR(256) NOT NULL,
          REVISION_UUID VARCHAR(255) NOT NULL,
          DESCRIPTION VARCHAR(255),
          CREATED_TIME DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          CREATED_BY VARCHAR(255),
          PRIMARY KEY (ID, API_UUID),
          UNIQUE(REVISION_UUID)
        );
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_REVISION_METADATA]') AND TYPE IN (N'U'))
        
        CREATE TABLE AM_API_REVISION_METADATA (
            API_UUID VARCHAR(64),
            REVISION_UUID VARCHAR(64),
            API_TIER VARCHAR(128),
            UNIQUE (API_UUID,REVISION_UUID)
        );
        

        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_DEPLOYMENT_REVISION_MAPPING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_DEPLOYMENT_REVISION_MAPPING (
          NAME VARCHAR(255) NOT NULL,
          VHOST VARCHAR(255) NULL,
          REVISION_UUID VARCHAR(255) NOT NULL,
          DISPLAY_ON_DEVPORTAL BIT DEFAULT 0,
          DEPLOYED_TIME DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (NAME, REVISION_UUID),
          FOREIGN KEY (REVISION_UUID) REFERENCES AM_REVISION(REVISION_UUID) ON UPDATE CASCADE ON DELETE CASCADE
        );
        
        DECLARE @con_com as VARCHAR(8000);
        SET @con_com = (SELECT name from sys.objects where parent_object_id=object_id('AM_API_CLIENT_CERTIFICATE') AND type='PK');
        EXEC('ALTER TABLE AM_API_CLIENT_CERTIFICATE
        drop CONSTRAINT ' + @con_com);
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD REVISION_UUID VARCHAR(255) NOT NULL DEFAULT 'Current API';
        ALTER TABLE AM_API_CLIENT_CERTIFICATE ADD PRIMARY KEY(ALIAS,TENANT_ID, REMOVED, REVISION_UUID);
        
        ALTER TABLE AM_API_URL_MAPPING ADD REVISION_UUID VARCHAR(256);
        
        ALTER TABLE AM_GRAPHQL_COMPLEXITY ADD REVISION_UUID VARCHAR(256);
        
        ALTER TABLE AM_API_PRODUCT_MAPPING ADD REVISION_UUID VARCHAR(256);
        
        DROP TABLE IF EXISTS AM_GW_API_DEPLOYMENTS;
        DROP TABLE IF EXISTS AM_GW_API_ARTIFACTS;
        DROP TABLE IF EXISTS AM_GW_PUBLISHED_API_DETAILS;
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GW_PUBLISHED_API_DETAILS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_GW_PUBLISHED_API_DETAILS (
          API_ID varchar(255) NOT NULL,
          TENANT_DOMAIN varchar(255),
          API_PROVIDER varchar(255),
          API_NAME varchar(255),
          API_VERSION varchar(255),
          API_TYPE varchar(50),
          PRIMARY KEY (API_ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GW_API_ARTIFACTS]') AND TYPE IN (N'U'))
        CREATE TABLE  AM_GW_API_ARTIFACTS (
          API_ID varchar(255) NOT NULL,
          REVISION_ID varchar(255) NOT NULL,
          ARTIFACT VARBINARY(MAX),
          TIME_STAMP DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (REVISION_ID, API_ID),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GW_API_DEPLOYMENTS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_GW_API_DEPLOYMENTS (
          API_ID VARCHAR(255) NOT NULL,
          REVISION_ID VARCHAR(255) NOT NULL,
          LABEL VARCHAR(255) NOT NULL,
          VHOST VARCHAR(255) NULL,
          PRIMARY KEY (REVISION_ID, API_ID,LABEL),
          FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE NO ACTION
        ) ;
        
        -- Service Catalog Tables --
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_SERVICE_CATALOG]') AND TYPE IN (N'U'))
        CREATE TABLE AM_SERVICE_CATALOG (
          UUID VARCHAR(36) NOT NULL,
          SERVICE_KEY VARCHAR(100) NOT NULL,
          MD5 VARCHAR(100) NOT NULL,
          SERVICE_NAME VARCHAR(255) NOT NULL,
          DISPLAY_NAME VARCHAR(255) NOT NULL,
          SERVICE_VERSION VARCHAR(30) NOT NULL,
          SERVICE_URL VARCHAR(2048) NOT NULL,
          TENANT_ID INTEGER NOT NULL,
          DEFINITION_TYPE VARCHAR(20),
          DEFINITION_URL VARCHAR(2048),
          DESCRIPTION VARCHAR(1024),
          SECURITY_TYPE VARCHAR(50),
          MUTUAL_SSL_ENABLED BIT DEFAULT 0,
          CREATED_TIME DATETIME NULL,
          LAST_UPDATED_TIME DATETIME NULL,
          CREATED_BY VARCHAR(255),
          UPDATED_BY VARCHAR(255),
          SERVICE_DEFINITION VARBINARY(MAX) NOT NULL,
          METADATA VARBINARY(MAX) NOT NULL,
          PRIMARY KEY (UUID),
          CONSTRAINT SERVICE_KEY_TENANT UNIQUE(SERVICE_KEY, TENANT_ID),
          CONSTRAINT SERVICE_NAME_VERSION_TENANT UNIQUE (SERVICE_NAME, SERVICE_VERSION, TENANT_ID)
        );
        
        -- Webhooks --
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_WEBHOOKS_SUBSCRIPTION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_WEBHOOKS_SUBSCRIPTION (
            WH_SUBSCRIPTION_ID INTEGER IDENTITY,
            API_UUID VARCHAR(255) NOT NULL,
            APPLICATION_ID VARCHAR(20) NOT NULL,
            TENANT_DOMAIN VARCHAR(255) NOT NULL,
            HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
            HUB_TOPIC VARCHAR(255) NOT NULL,
            HUB_SECRET VARCHAR(2048),
            HUB_LEASE_SECONDS INTEGER,
            UPDATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            EXPIRY_AT BIGINT,
            DELIVERED_AT DATETIME NULL,
            DELIVERY_STATE INTEGER,
            PRIMARY KEY (WH_SUBSCRIPTION_ID)
        );
        
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_WEBHOOKS_UNSUBSCRIPTION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_WEBHOOKS_UNSUBSCRIPTION (
            API_UUID VARCHAR(255) NOT NULL,
            APPLICATION_ID VARCHAR(20) NOT NULL,
            TENANT_DOMAIN VARCHAR(255) NOT NULL,
            HUB_CALLBACK_URL VARCHAR(1024) NOT NULL,
            HUB_TOPIC VARCHAR(255) NOT NULL,
            HUB_SECRET VARCHAR(2048),
            HUB_LEASE_SECONDS INTEGER,
            ADDED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_API_SERVICE_MAPPING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_API_SERVICE_MAPPING (
            API_ID INTEGER NOT NULL,
            SERVICE_KEY VARCHAR(256) NOT NULL,
            MD5 VARCHAR(100) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            PRIMARY KEY (API_ID, SERVICE_KEY),
            FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE
        );
        
        -- Gateway Environments Table --
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GATEWAY_ENVIRONMENT]') AND TYPE IN (N'U'))
        CREATE TABLE AM_GATEWAY_ENVIRONMENT (
          ID INTEGER IDENTITY,
          UUID VARCHAR(45) NOT NULL,
          NAME VARCHAR(255) NOT NULL,
          TENANT_DOMAIN VARCHAR(255),
          DISPLAY_NAME VARCHAR(255) NULL,
          DESCRIPTION VARCHAR(1023) NULL,
          UNIQUE (NAME, TENANT_DOMAIN),
          UNIQUE (UUID),
          PRIMARY KEY (ID)
        );
        
        -- Virtual Hosts Table --
        IF NOT EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_GW_VHOST]') AND TYPE IN (N'U'))
        CREATE TABLE AM_GW_VHOST (
          GATEWAY_ENV_ID INTEGER,
          HOST VARCHAR(255) NOT NULL,
          HTTP_CONTEXT VARCHAR(255) NULL,
          HTTP_PORT VARCHAR(5) NOT NULL,
          HTTPS_PORT VARCHAR(5) NOT NULL,
          WS_PORT VARCHAR(5) NOT NULL,
          WSS_PORT VARCHAR(5) NOT NULL,
          FOREIGN KEY (GATEWAY_ENV_ID) REFERENCES AM_GATEWAY_ENVIRONMENT(ID) ON UPDATE CASCADE ON DELETE CASCADE,
          PRIMARY KEY (GATEWAY_ENV_ID, HOST)
        );
        
        ALTER TABLE AM_POLICY_SUBSCRIPTION ADD CONNECTIONS_COUNT INTEGER NOT NULL DEFAULT 0;
        
        EXEC sp_rename 'AM_API_COMMENTS.COMMENTED_USER', 'CREATED_BY', 'COLUMN';
        EXEC sp_rename 'AM_API_COMMENTS.DATE_COMMENTED', 'CREATED_TIME', 'COLUMN';
        ALTER TABLE AM_API_COMMENTS ADD UPDATED_TIME DATETIME;
        ALTER TABLE AM_API_COMMENTS ADD PARENT_COMMENT_ID VARCHAR(255) DEFAULT NULL;
        ALTER TABLE AM_API_COMMENTS ADD ENTRY_POINT VARCHAR(20) DEFAULT 'DEVPORTAL';
        ALTER TABLE AM_API_COMMENTS ADD CATEGORY VARCHAR(20) DEFAULT 'general';
        ALTER TABLE AM_API_COMMENTS ADD FOREIGN KEY(PARENT_COMMENT_ID) REFERENCES AM_API_COMMENTS(COMMENT_ID);
        ```

4.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_4.0.0_HOME>/repository/resources/security` directory.

    !!! note "If you have enabled Secure Vault"
        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below. Refer [Encrypting Passwords in Configuration files]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/working-with-encrypted-passwords) for more details.

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```
    - In order to work with the [API Security Audit Feature]({{base_path}}/design/api-security/configuring-api-security-audit/) you need to have the public certificate of the [42crunch](https://42crunch.com/) in the client-truststore. Follow the guidelines given in [Importing Certificates to the Truststore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore).


6.  Configure the [SymmetricKeyInternalCryptoProvider](https://is.docs.wso2.com/en/5.11.0/administer/symmetric-overview/) as the default internal cryptor provider.
    Generate your own secret key using a tool like OpenSSL.
    
    i.e.,
       ```
        openssl enc -nosalt -aes-128-cbc -k hello-world -P
       ```        
    Add the configuration to the <NEW_IS_HOME>/repository/conf/deployment.toml file.
    
       ```
       [encryption]
       key = "<provide-your-key-here>"
       ```

6.  Upgrade the Identity component in WSO2 API Manager from version 5.10.0 to 5.11.0.

    1.  Download the identity component migration resources and unzip it in a local directory.

        Navigate to the [latest release tag](https://github.com/wso2-extensions/apim-identity-migration-resources/tags) and download the `wso2is-migration-x.x.x.zip` under Assets.
         
        Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`. 

    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_4.0.0_HOME>` directory.

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

    4.  Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

    5. Update <API-M_4.0.0_HOME>/repository/conf/deployment.toml file as follows, to point to the previous user store.
    
        !!! note
                This step is only required if the user store type in previous version is set to "database" instead of default "database_unique_id".
        
           ```
           [user_store]
           type = "database"
           ```
    6.  Start WSO2 API Manager 4.0.0 as follows to carry out the complete Identity component migration.
        
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
            Note that if you want to use the latest user store, update the <API-M_4.0.0_HOME>/repository/conf/deployment.toml as follows after the identity migration,

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

            1.  Add the following property in `<API-M_HOME>/repository/conf/deployment.toml` to a higher value (e.g., 10)
                ```
                [indexing]
                frequency= 10
                ```

            2.  Re-run the command above.

            **Make sure to revert the change done in Step 1 , after the migration is complete.**

    7.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` directory, which is in the `<API-M_4.0.0_HOME>` directory.

        -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the api-manager.bat file.

            ```
            -Dmigrate -Dcomponent=identity
            ```

6.  Migrate the API Manager artifacts.

    You have to run the following migration client to update the API Manager artifacts.

    1. Download and extract the [migration-resources.zip]({{base_path}}/assets/attachments/install-and-setup/migration-resources.zip). Copy the extracted `migration-resources`  to the `<API-M_4.0.0_HOME>` folder.

    2. Download and copy the [API Manager Migration Client]({{base_path}}/assets/attachments/install-and-setup/org.wso2.carbon.apimgt.migrate.client-4.0.0.jar) to the `<API-M_4.0.0_HOME>/repository/components/dropins` folder.

    3.  Start the API-M server as follows.

        ``` tab="Linux / Mac OS"
        sh api-manager.sh -DmigrateFromVersion=3.2.0
        ```

        ``` tab="Windows"
        api-manager.bat -DmigrateFromVersion=3.2.0
        ```

    4. Shutdown the API-M server.
    
       -   Remove the `org.wso2.carbon.apimgt.migrate.client-4.0.0.jar` file, which is in the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

       -   Remove the `migration-resources` directory, which is in the `<API-M_4.0.0_HOME>` directory.
       
    5. Execute the following DB script in the respective AM database.

        ??? info "DB Scripts"
            ```tab="DB2"
            ALTER TABLE AM_API ADD CONSTRAINT API_UUID_CONSTRAINT UNIQUE(API_UUID)
            /
        
            ```
            
            ```tab="MySQL"
            ALTER TABLE AM_API ADD CONSTRAINT API_UUID_CONSTRAINT UNIQUE(API_UUID);
    
            ```
                    
            ```tab="MSSQL"
            ALTER TABLE AM_API ADD CONSTRAINT API_UUID_CONSTRAINT UNIQUE(API_UUID);
    
            ``` 

            ```tab="PostgreSQL"
            ALTER TABLE AM_API ADD CONSTRAINT API_UUID_CONSTRAINT UNIQUE(API_UUID);
    
            ```
                    
            ```tab="Oracle"
            ALTER TABLE AM_API ADD CONSTRAINT API_UUID_CONSTRAINT UNIQUE(API_UUID)
            /
    
            ```
        
7.  Re-index the artifacts in the registry.
    1.  Run the [reg-index.sql]({{base_path}}/assets/attachments/install-and-setup/reg-index.sql) script against the `SHARED_DB` database.

        !!! note
            Note that depending on the number of records in the REG_LOG table, this script will take a considerable amount of time to finish. Do not stop the execution of script until it is completed.

    2.  Add the [tenantloader-1.0.jar]({{base_path}}/assets/attachments/install-and-setup/tenantloader-1.0.jar) to `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

        !!! attention
            If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Store and Publisher** nodes.

        !!! note
            You need to do this step, if you have **multiple tenants** only.

    3.  Add the following configuration in to `<API-M_4.0.0_HOME>/repository/conf/deployment.toml` file.
        
        ```
        [indexing]
        re_indexing = 1
        ```

        !!! info 
             If you use a clustered/distributed API Manager setup, do the above change in deployment.toml of Publisher and Devportal nodes
             
    4.  If the `<API-M_4.0.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

    5.  Start the WSO2 API-M server.

    6.  Stop the WSO2 API-M server and remove the `tenantloader-1.0.jar` from the `<API-M_4.0.0_HOME>/repository/components/dropins` directory.

### Step 3 - Restart the WSO2 API-M 4.0.0 server

1.  Restart the WSO2 API-M server.

    ```tab="Linux / Mac OS"
    sh api-manager.sh
    ```

    ```tab="Windows"
    api-manager.bat
    ```

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, synapse artifacts, execution plans, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.
!!! note
   - API-M 4.0.0 synapse artifacts have been removed from the file system and are managed via database. At server startup the synapse configs are loaded to the memory from the Traffic Manager.

   - When Migrating a Kubernetes environment to a newer API Manager version it is recommended to do the data migration in a single container and then do the deployment.    
<<<<<<< HEAD

   - Prior to WSO2 API Manager 4.0.0, the distributed deployment comprised of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in APIM 4.0.0 only has three profiles, namely Gateway, Traffic Manager, and Default.
   
     All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Default profile.
     
     For more details on the WSO2 API-M 4.0.0 distributed deployment, see [WSO2 API Manager distributed documentation]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m).
     
   - If you have done any customizations to the **default sequences** that ship with product, you may merge the customizations. Also note that the the fault messages have been changed from XML to JSON in API-M 4.0.0.  
   
   - Prior to WSO2 API Manager 4.0.0, the distributed deployment comprised of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in APIM 4.0.0 only has three profiles, namely Gateway, Traffic Manager, and Default.
     All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Default profile.
     For more details on the WSO2 API-M 4.0.0 distributed deployment, see [WSO2 API Manager distributed documentation]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m).
     
   - **API-M 4.0.0** Server startup script has renamed as <code>api-manager.sh</code> (for Linux) and <code>api-manager.bat</code> (for Windows)    
 
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
