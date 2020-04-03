# Upgrading API Manager from 3.1.0 to 3.1.0

The following information describes how to upgrade your API Manager server **from APIM 3.1.0 to 3.1.0**.

!!! note
    Before you follow this section, see [Upgrading Process](../upgrading-wso2-api-manager/upgrading-process.md) for more information.

!!! attention "Before you Begin"
    This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

    -   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.1.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/updates/Using+WSO2+Update+Manager).

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 3.0.0 to 3.1.0**.

### Preparing for Migration
#### Disabling versioning in the registry configuration

If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 3.1.0.

Therefore, when migrating to API Manager 3.1.0, it is **required** to turn off the registry versioning in your
current API Manager 3.0.0 version and run the below scripts against **the database that is used by the registry**.

!!! note "NOTE"
    Alternatively, it is possible to turn on registry versioning in API Manager 3.1.0 and continue. But this is
    highly **NOT RECOMMENDED** and these configurations should only be changed once.
    
!!! warning "Not recommended"
    If you decide to proceed with registry resource versioning enabled, Add the following configuration to the `<NEW_API-M_HOME>/repository/conf/deployment.toml` file of new WSO2 API Manager. 
    
    ```
    [registry.static_configuration]
    enable=true
    ```
    
    !!! note "NOTE"
        Changing these configuration should only be done before the initial API-M Server startup. If changes are done after the initial startup, the registry resource created previously will not be available.

!!! note
    If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.10.0](../upgrading-wso2-is-as-key-manager/upgrading-from-is-km-590-to-5100.md).

-   [Step 1 - Migrate the API Manager configurations](#step-1-migrate-the-api-manager-configurations)
-   [Step 2 - Upgrade API Manager to 3.1.0](#step-2-upgrade-api-manager-to-310)
-   [Step 3 - Optionally, migrate the configurations for WSO2 API-M Analytics](#step-3-optionally-migrate-the-configurations-for-wso2-api-m-analytics)
-   [Step 4 - Restart the WSO2 API-M 3.1.0 server](#step-4-restart-the-wso2-api-m-300-server)

### Step 1 - Migrate the API Manager configurations

!!! warning
    Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as the configuration modal has been changed and now all the configurations are being done via a single file (deployment.toml). Instead, redo the configuration changes in the new configuration file. For more information refer [Configuration Catalog](../../reference/ConfigCatalog.md).

Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Back up all databases in your API Manager instances along with the Synapse configurations of all the tenants and the super tenant.

    -   The Synapse configurations of the super tenant are in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory.

    -   The Synapse configurations of tenants are in the `<OLD_API-M_HOME>/repository/tenants` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the **API Gateway** node.

2.  Download [WUM updated](https://docs.wso2.com/display/updates/Getting+Started) pack for [WSO2 API Manager 3.1.0](http://wso2.com/api-management/).

3.  Open the `<API-M_3.1.0_HOME>/repository/conf/deployment.toml` file and provide the datasource configurations for the following databases.

    -   User Store
    -   Registry database/s
    -   API Manager databases

    !!! note
        If you have used separate DBs for user management and registry in the previous version, you need to configure WSO2REG_DB and WSO2UM_DB databases separately in API-M 3.1.0 to avoid any issues.

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
        If you have configured WSO2CONFIG_DB in the previous API-M version, add a new entry to the `<API-M_3.1.0_HOME>/repository/conf/deployment.toml` as below.

        ```
        [database.config]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/config_db"
        username = "username"
        password = "password"
        ```

    !!! attention "If you are using another DB type"
        If you are using another DB type other than **H2** or **MySQL**, when defining the DB related configurations in the `deployment.toml` file, you need to add the `driver` and `validationQuery` parameters additionally as given below.

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

4.  Update `<API-M_3.1.0_HOME>/repository/conf/deployment.toml` file as follows, to point to the correct database for user management purposes.

    ```
    [realm_manager]
    data_source = "WSO2USER_DB"
    ```

5.  Copy the relevant JDBC driver to the `<API-M_3.1.0_HOME>/repository/components/lib` folder.


6.  Move all your Synapse configurations to API-M 3.1.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and replace the contents in the `<API-M_3.1.0_HOME>/repository/deployment/server/synapse-configs/default` directory with the copied contents.
    -   Move all your tenant Synapse configurations.
        Copy the contents in the `<OLD_API-M_HOME>/repository/tenants` directory and replace the contents in the `<API-M_3.1.0_HOME>/repository/tenants` directory with the copied contents.

    !!! warning
        When moving the Synapse configurations, **do not replace** the following set of files as they contain some modificatiosn in API-M 3.1.0 version.

        -   /api/\_RevokeAPI_.xml
        -   /sequences/\_cors_request_handler_.xml
        -   /sequences/main.xml

    !!! attention 
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Gateway** node.

7.  Move all your Execution plans from `<API-M_3.0.0_HOME>/repository/deployment/server/executionplans` directory to `<API-M_3.1.0_HOME>/repository/deployment/server/executionplans` directory.

    !!! note
        If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Traffic Manager** node.

8.  If you manually added any custom OSGI bundles to the `<API-M_3.0.0_HOME>/repository/components/dropins` directory, copy those to the `<API-M_3.1.0_HOME>/repository/components/dropins` directory. 

9.  If you manually added any JAR files to the `<API-M_3.0.0_HOME>/repository/components/lib` directory, copy those and paste them in the `<API-M_3.1.0_HOME>/repository/components/lib` directory.

### Step 2 - Upgrade API Manager to 3.1.0

1.  Stop all WSO2 API Manager server instances that are running.

2.  Make sure you backed up all the databases and Synapse configurations as instructed in [step 1](#step-1-migrate-the-api-manager-configurations) of the previous section.

3.  Upgrade the WSO2 API Manager database from version 3.0.0 to version 3.1.0 by executing the relevant database script, from the scripts that are provided below, on the `WSO2AM_DB` database.

    ??? info "DB Scripts"
        ```tab="H2"
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
        ```
    
        ```tab="DB2"
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
        ```

        ```tab="MSSQL"
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
        ```

        ```tab="MySQL"
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
        ```
    
        ```tab="Oracle"
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
        ```
        
        ```tab="PostgreSQL"
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
        ```

4.  Copy the keystores (i.e., `client-truststore.jks`, `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_3.1.0_HOME>/repository/resources/security` directory.

    !!! note "If you have enabled Secure Vault"
        If you have enabled secure vault in the previous API-M version, you need to add the property values again according to the new config modal and run the script as below. Please refer [Encrypting Passwords in Configuration files](../../administer/product-security/logins-and-passwords/working-with-encrypted-passwords.md) for more details.

        ```tab="Linux"
        ./ciphertool.sh -Dconfigure
        ```

        ```tab="Windows"
        ./ciphertool.bat -Dconfigure
        ```

5.  Upgrade the Identity component in WSO2 API Manager from version 5.9.0 to 5.10.0.

    !!! note
        As WSO2 API-M shares identity components with WSO2 Identity Sever (WSO2 IS), this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).

    1.  Download the identity component migration resources and unzip it in a local directory.

         Navigate to the [latest release tag](https://github.com/wso2-extensions/identity-migration-resources/releases/latest) and download the `wso2is-migration-x.x.x.zip` under Assets. Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`. 

    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_3.1.0_HOME>` directory.

    3.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.9.0, as shown below.

        ``` java
        migrationEnable: "true"
        currentVersion: "5.9.0"
        migrateVersion: "5.10.0"
        ```

        !!! note
            Make sure you have enabled migration by setting the `migrationEnable` element to `true` as shown above.

    4.  Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<API-M_3.1.0_HOME>/repository/components/dropins` directory.

    5. Update <API-M_3.1.0_HOME>/repository/conf/deployment.toml file as follows, to point to the previous user store.
    
        ```
        [user_store]
        type = "database"
        ```

    6.  Start WSO2 API Manager 3.1.0 as follows to carry out the complete Identity component migration.

        ```tab="Linux / Mac OS"
        sh wso2server.sh -Dmigrate -Dcomponent=identity
        ```

        ```tab="Windows"
        wso2server.bat -Dmigrate -Dcomponent=identity
        ```

        !!! note
            Please note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and please wait until the migration process finish completely and server get started.

        !!! note
            Please note that if you want to use the latest user store, please update the <API-M_3.1.0_HOME>/repository/conf/deployment.toml as follows after the identity migration,

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

    6.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<API-M_3.1.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` directory, which is in the `<API-M_3.1.0_HOME>` directory.

        -   If you ran WSO2 API-M as a Windows Service when doing the identity component migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the wso2server.bat file.

            ```
            -Dmigrate -Dcomponent=identity
            ```

6.  Re-index the artifacts in the registry.

    1.  Run the [reg-index.sql](../../assets/attachments/install-and-setup/reg-index.sql) script against the `SHARED_DB` database.

        !!! note
            Please note that depending on the number of records in the REG_LOG table, this script will take a considerable amount of time to finish. Do not stop the execution of script until it is completed.

    2.  Add the [tenantloader-1.0.jar](../../assets/attachments/install-and-setup/tenantloader-1.0.jar) to `<API-M_3.1.0_HOME>/repository/components/dropins` directory.

        !!! attantion
            If you are working with a **clustered/distributed API Manager setup**, follow this step on the **Store and Publisher** nodes.

        !!! note
            You need to do this step, if you have **multiple tenants** only.

    3.  Rename the **<lastAccessTimeLocation>** element by adding the following configuration in `<API-M_3.1.0_HOME>/repository/conf/deployment.toml` file.
        
        ```
        [indexing]
        re_indexing= 1
        ```

        !!! info 
            If you use a clustered/distributed API Manager setup, change the file in the API Publisher node. For example, change the /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime registry path to /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1

    4.  If the `<API-M_3.1.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

    5.  Start the WSO2 API-M server.

    6.  Stop the WSO2 API-M server and remove the `tenantloader-1.0.jar` from the `<API-M_3.1.0_HOME>/repository/components/dropins` directory.

### Step 3 - Optionally, migrate the configurations for WSO2 API-M Analytics

!!! warning
    This step is **only required** if you have WSO2 API-M-Analytics configured in your current deployment.

Follow the steps below to migrate APIM Analytics 3.0.0 to APIM Analytics 3.1.0

#### Step 3.1 - Migrating the Analytics Database

Upgrade the WSO2 API Manager Analytics database from version 3.0.0 to version 3.1.0 by executing the relevant database script, from the scripts that are provided below, on the `APIM_ANALYTICS_DB` database.

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
    ```
        
    ```tab="PostgreSQL"
    ALTER TABLE APILASTACCESSSUMMARY DROP CONSTRAINT APILASTACCESSSUMMARY_pkey;
    ALTER TABLE APILASTACCESSSUMMARY ADD PRIMARY KEY (APINAME,APICREATOR,APIVERSION,APICREATORTENANTDOMAIN);
    ```

#### Step 3.2 - Configure WSO2 API-M Analytics 3.1.0

!!! note
    -   In API-M 3.0.0, when working with API-M Analytics, only the worker profile has been used by default and dashboard profile is used only when there are custom dashboards.
    -   Now with API-M 3.1.0, both the worker and dashboard profiles are being used. The default Store and Publisher dashboards are now being moved to the Analytics dashboard server side and they have been removed from the API-M side.
    -   The same set of DBs will be used in the Analytics side and additionally you need to share the WSO2AM_DB with the dashboard server node.

Follow the instructions below to configure WSO2 API Manager Analytics for the WSO2 API-M Analytics migration in order to migrate the statistics related data.

1.  Download [WUM updated](https://docs.wso2.com/display/updates/Getting+Started) pack for [WSO2 API Manager Analytics 3.1.0](http://wso2.com/api-management/).

    !!! note
        It is **mandatory** to use a WUM updated WSO2 API Manager Analytics 3.1.0 pack when migrating the configurations for WSO2 API-M Analytics.

2.  Configure the following 2 datasources in the `<API-M_ANALYTICS_3.1.0_HOME>/conf/dashboard/deployment.yaml` file by pointing to the **old** `WSO2AM_DB` and `APIM_ANALYTICS_DB`.

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

3.  Configure the following datasource in the `<API-M_ANALYTICS_3.1.0_HOME>/conf/worker/deployment.yaml` file by pointing to the **old** `APIM_ANALYTICS_DB`.

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
          maxPoolSize: 50
          idleTimeout: 60000
          connectionTestQuery: SELECT 1
          validationTimeout: 30000
          isAutoCommit: false
    ```

4.  Copy the relevant JDBC driver OSGI bundle to the `<APIM_ANALYTICS_3.1.0_HOME>/lib` folder.

    !!! info "To convert the jar files to OSGi bundles, follow the steps given below."
        1. Download the non-OSGi jar for the required third party product, and save it in a preferred directory in your machine.
        2. Go to the `<API-M_ANALYTICS_HOME>/bin` directory. Run the command given below, to generate the converted file in the `<API-M_ANALYTICS_HOME>/lib` directory.

        ```
        ./jartobundle.sh <PATH_TO_NON-OSGi_JAR> ../lib
        ```

5.  Start the Worker and Dashboard profiles as below by navigating to `<API-M_ANALYTICS_3.1.0_HOME>/bin` location.
    
    ```tab="Worker"
    sh worker.sh
    ```

    ```tab="Dashboard"
    sh dashboard.sh
    ```

!!! note
    If you have developed any custom dashboards in API-M 3.0.0 Analytics using Stream Processor, you will be able to use the same in API-M Anaytics 3.1.0 as well. If you require any guidance regarding this, you can contact [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa).

#### Step 3.3 - Configure WSO2 API-M 3.1.0 for Analytics

Follow the instructions below to configure WSO2 API Manager for the WSO2 API-M Analytics migration in order to migrate the statistics related data.

1.  Configure the following datasources in the `<API-M_3.1.0_HOME>/repository/conf/deployment.toml` file.

    The following is an example of how the configurations should be defined when using MySQL.

    This datasource points to the **previous API-M version's WSO2AM_DB datasource.**

    ``` java
    [database.apim_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/am_db"
    username = "username"
    password = "password"
    ```

2.  Enable analytics in WSO2 API-M by setting the following configuration to true in the `<API-M_3.1.0_HOME>/repository/conf/deployment.toml` file.

    ``` java
    [apim.analytics]
    enable = true
    ```

### Step 4 - Restart the WSO2 API-M 3.1.0 server

1.  Restart the WSO2 API-M server.

    ```tab="Linux / Mac OS"
    sh wso2server.sh
    ```

    ```tab="Windows"
    wso2server.bat
    ```

    !!! note "If you have enabled Analytics"
        After starting the WSO2 API-M server and the WSO2 API-M Analytics 3.1.0 server from worker and dashboard profiles, the dashboards can be accessed via `https://<dashboard-server-host-name>:9643/analytics-dashboard` link.

        !!! warning
            Make sure you have started the API-M server node before accessing the Dashboard profile as the authentication happens via the API-M's authentication admin service.

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! Important
    In API Manager 3.1.0, login flow is changed with role base access control where user should have respective roles to access Publisher and Developer Portal. Since 3.1.0 UI depends completely on REST APIs, authentication to access different components solely depends on the scope-role mapping defined in registry file `tenant-conf.json`. 

    By default, the scope-role mapping is added only for the internal roles such as `Internal/publisher`, `Internal/creator` and `Internal/subscriber`. If there are any custom roles defined for API Creator, API Publisher, API Subscriber and Admin, those roles should be configured under relevant scopes. To edit the `tenant-conf.json` in order to assign custom roles to the scopes, follow the steps given below:

    1. Log in to the Management Console and click **Main > Resource > Browse**.

    2. Browse to the **/_system/config/apimgt/applicationdata/tenant-conf.json** file and click **Edit as Text**.
    
    Scopes required to invoke each APIs can be found under `OAuth2Security` section for each resources. The swagger definition for the Publisher RESTful APIs can be found [here](https://raw.githubusercontent.com/wso2/carbon-apimgt/v6.5.349/components/apimgt/org.wso2.carbon.apimgt.rest.api.publisher.v1/src/main/resources/publisher-api.yaml) and swagger definition for the Developer Portal REST APIs can be found [here](https://raw.githubusercontent.com/wso2/carbon-apimgt/v6.5.349/components/apimgt/org.wso2.carbon.apimgt.rest.api.store.v1/src/main/resources/store-api.yaml). 
