# Upgrading API Manager to 3.0.0

The following information describes how to upgrade your API Manager server **from APIM 2.5.0 to 3.0.0** .

!!! note
To upgrade **from a version older than 1.8.0** , follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

!!! tip
Before you begin

This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

-   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.0.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Getting+Started+with+WUM) .

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.5.0 to 2.6.0** .

!!! note
If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading from the Previous Release when WSO2 IS is the Key Manager](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#250) .
-   [Step 1 - Migrate the configurations](#UpgradingfromthePreviousRelease-Step1-Migratetheconfigurations)
    -   [Step 1.1 - Migrate the API Manager configurations](#UpgradingfromthePreviousRelease-Step1.1-MigratetheAPIManagerconfigurations)
    -   [Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](#UpgradingfromthePreviousRelease-Step1.2-Optionally,migratetheconfigurationsforWSO2API-MAnalytics)
-   [Step 2 - Upgrade API Manager to 2.6.0](#UpgradingfromthePreviousRelease-Step2-UpgradeAPIManagerto2.6.0)

### Step 1 - Migrate the configurations

#### Step 1.1 - Migrate the API Manager configurations

!!! warning
Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files (e.g., `api-manager.xml` ) may have changed. Instead, redo the configuration changes in the new configuration files.
Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Back up all databases in your API Manager instances along with the Synapse configurations of all the tenants and the super tenant.

    -   The Synapse configurations of the super tenant are in the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory.

    -   The Synapse configurations of tenants are in the `<CURRENT_APIM_HOME>/repository/tenants` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download API Manager 2.6.0 from <https://wso2.com/api-management/> .
3.  Open the `<API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml` file and provide the datasource configurations for the following databases. You can copy the configuration values from the same file in the current API Manager instance that you are already using.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (If statistics are configured)

4.  Edit the registry configurations in the `<API-M_2.6.0_HOME>/repository/conf/registry.xml` file and the user database in the `<API-M_2.6.0_HOME>/repository/conf/user-mgt.xml` file, similar to the configurations of the current WSO2 API Manager.

        !!! info
    If you are working with a **clustered/distributed API Manager setup** , follow step [5](#UpgradingfromthePreviousRelease-step5-2.2.0) on the Gateway node.


5.  Move all your Synapse configurations to API-M 2.6.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and replace the contents in the `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default` directory with the copied contents.
    -   Move all your tenant Synapse configurations.
        Copy the contents in the `<CURRENT_API-M_HOME>/repository/tenants` directory and replace the contents in the `<API-M_2.6.0_HOME>/repository/tenants` directory with the copied contents.

#### Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics

!!! warning
This step is **only required** if you have WSO2 API-M-Analytics configured in your current deployment.
Follow the steps below to migrate APIM Analytics 2.5.0 to APIM Analytics 2.6.0

##### Step 1.2.1 - Configure WSO2 API-M Analytics 2.6.0

1.  Download WSO2 API Manager Analytics 2.6.0 from [here](http://wso2.com/api-management/) .
2.  Create a new database for the new statistics database and configure it in the `<APIM_ANALYTICS_2.6.0_HOME>/conf/worker/deployment.yaml` as follows:
    In this example shows to configure MySQL database configurations.

    ``` java
        - name: APIM_ANALYTICS_DB
              description: "The datasource used for APIM statistics aggregated data."
              jndiConfig:
                name: jdbc/APIM_ANALYTICS_DB
              definition:
                type: RDBMS
                configuration:
                  jdbcUrl: 'jdbc:mysql://localhost:3306/spDatabase?autoReconnect=true'
                  username: username
                  password: password
                  driverClassName: com.mysql.jdbc.Driver
                  maxPoolSize: 50
                  idleTimeout: 60000
                  connectionTestQuery: SELECT 1
                  validationTimeout: 30000
                  isAutoCommit: false
    ```

3.  Copy the relevant JDBC driver to the `<APIM_ANALYTICS_2.6.0_HOME>/lib` folder.
4.  Start the new API-M Analytics server.

    ``` java
            cd <APIM_ANALYTICS_2.6.0_HOME>/bin
            sh worker.sh
    ```

    When the WSO2 API-M Analytics 2.6.0 server starts, the new statistics tables will get generated in the database that you configured in **step 1.2.1 - (2.)** above.

##### Step 1.2.2 - Configure WSO2 API-M 2.6.0 for Analytics

Follow the instructions below to configure WSO2 API Manager for the WSO2 API-M Analytics migration in order to migrate the statistics related data.

1.  Configure the statistics related datasources for WSO2 API Manager Analytics.
    Configure the following 3 datasources in the `<API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml` file.

        !!! warning
    The following 3 datasources should be configured in the `<API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml` file **only until the stats migration is complete** . After the statistics migration is complete remove the `APIM_ANALYTICS_DB` datasource configuration, which was added for the new statistics database, from the latter mentioned file.


    The following in an example of how the configurations should be defined when using MySQL.

    -   -   The first datasource points to the **previous API-M version's AM\_DB datasource.**

            ``` java
                              <datasource>
                                    <name>WSO2AM_DB</name>
                                    <description>The datasource used for API Manager database</description>
                                    <jndiConfig>
                                        <name>jdbc/WSO2AM_DB</name>
                                    </jndiConfig>
                                    <definition type="RDBMS">
                                        <configuration>
                                            <url>jdbc:mysql://localhost:3306/AM_DB?autoReconnect=true</url>
                                            <username>username</username>
                                            <password>password</password>
                                            <defaultAutoCommit>true</defaultAutoCommit>
                                            <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                                            <maxActive>50</maxActive>
                                            <maxWait>60000</maxWait>
                                            <testOnBorrow>true</testOnBorrow>
                                            <validationQuery>SELECT 1</validationQuery>
                                            <validationInterval>30000</validationInterval>
                                        </configuration>
                                    </definition>
                             </datasource>
            ```

        -   The second datasource points to the **WSO2 Data Analytics (WSO2 DAS) based previous datasource WSO2AM\_STATS\_DB for statistics** .

            ``` java
                                   <datasource>
                                        <name>WSO2AM_STATS_DB</name>
                                        <description>The datasource used for getting statistics to API Manager</description>
                                        <jndiConfig>
                                            <name>jdbc/WSO2AM_STATS_DB</name>
                                        </jndiConfig>
                                        <definition type="RDBMS">
                                            <configuration>
                                                <url>jdbc:mysql://localhost:3306/dasDatabase?autoReconnect=true</url>
                                                <username>username</username>
                                                <password>password</password>
                                                <defaultAutoCommit>true</defaultAutoCommit>
                                                <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                                                <maxActive>50</maxActive>
                                                <maxWait>60000</maxWait>
                                                <testOnBorrow>true</testOnBorrow>
                                                <validationQuery>SELECT 1</validationQuery>
                                                <validationInterval>30000</validationInterval>
                                            </configuration>
                                        </definition>
                                     </datasource>
            ```

        -   The third datasource points to the **WSO2 Stream Processor (WSO2 SP) based new datasource APIM\_ANALYTICS\_DB for statistics.**

            ``` java
                                     <datasource>
                                        <name>APIM_ANALYTICS_DB</name>
                                        <description>The datasource used for getting statistics to API Manager for APIM 2.6.0</description>
                                        <jndiConfig>
                                            <name>jdbc/APIM_ANALYTICS_DB</name>
                                        </jndiConfig>
                                        <definition type="RDBMS">
                                            <configuration>
                                                <url>jdbc:mysql://localhost:3306/spDatabase?autoReconnect=true</url>
                                                <username>username</username>
                                                <password>password</password>
                                                <defaultAutoCommit>true</defaultAutoCommit>
                                                <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                                                <maxActive>50</maxActive>
                                                <maxWait>60000</maxWait>
                                                <testOnBorrow>true</testOnBorrow>
                                                <validationQuery>SELECT 1</validationQuery>
                                                <validationInterval>30000</validationInterval>
                                            </configuration>
                                        </definition>
                                     </datasource>
            ```

2.  Download and extract the [WSO2 API Manager migration client](https://docs.wso2.com/download/attachments/28718536/wso2-api-migration-client.zip?api=v2) and carry out the following steps to upgrade to WSO2 API Manager Analytics 2.6.0.
3.  Copy the **migrate.client-2.6.x-1.jar** to the `<API-M_2.6.0_HOME>/repository/components/dropins` folder.
4.  Copy the relevant JDBC driver to the `<API-M_2.6.0_HOME>/repository/components/lib` folder.
5.  Make sure that WSO2 API-M Analytics is disabled in the `<API-M_2.6.0_HOME>/repository/conf/api-manager.xml` file.

    ``` java
            <Analytics>    
                <Enabled>false</Enabled>
                ...
            <Analytics>
    ```

6.  After setting the above configurations in place, start up the WSO2 API-M 2.6.0 server with the following commands.

    ``` java
            cd <API-M_2.6.0_HOME>/bin
            sh wso2server.sh -DmigrateStats=true
    ```

        !!! info
    Table-wise Migration

    The migration client provides the support for table-wise migration.

    The following are the table names that needs to be migrated.

    ``` java
        ApiPerDestinationAgg,ApiResPathPerApp,ApiVersionPerAppAgg,ApiLastAccessSummary,ApiFaultyInvocationAgg,ApiUserBrowserAgg,GeoLocationAgg,ApiExeTimeDay,ApiExeTimeHour,ApiExeTimeMinute,ApiThrottledOutAgg,APIM_ReqCountAgg,ApiUserPerAppAgg
    ```

    You need to use the `statTable` migration property for table wise migration.

    For example, if you need to migrate only the `ApiPerDestinationAgg` and `ApiResPathPerApp` tables use the following command:

        !!! note
    When you need to migrate multiple tables, the comma separated table names should without spaces before or after the comma as shown below.


    ``` java
        sh wso2server.sh -DmigrateStats=true -DstatTable=ApiPerDestinationAgg,ApiResPathPerApp
    ```

        !!! info
    If the default 3 datasource names/name, which you specified above, changed from the details that you specified in the `<API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml` file. Use the following command to pass the values to the migration client.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Click here to see a code snippet of the definition of the datasource name...

    ``` java
        <jndiConfig>
            <name>jdbc/WSO2AM_DB</name>
        </jndiConfig>
    ```

    -   [**Format**](#code)
    -   [**Example**](#example)

    ``` java
            sh wso2server.sh -DdataSource=<AM_DATASOURCE_NAME>,<OLD_STAT_DATASOURCE_NAME>,<NEW_STAT_DATASOURCE_NAME>
    ```

    ``` java
            sh wso2server.sh -DdataSource=jdbc/WSO2AM_DB,jdbc/WSO2AM_STATS_DB,jdbc/APIM_ANALYTICS_DB
    ```

        !!! warning
    The following warning message could occur during migration if the relevant consumer key does not exist in the `AM_APPLICATION_KEY_MAPPING` table due to Application deletion.

    ``` java
        ConsumerKey <consumerKey> does not contain in the AM_APPLICATION_KEY_MAPPING table.
    ```

    In such scenarios, you will face a migration data loss due to API or Application deletion.


7.  Stop the WSO2 API-M server and remove the migration JAR copied under [Step 1.2.2 - (3.)](http://docs.wso2.com#1223) above.
8.  Remove both the old and new `STAT_DB` datasources from the `<API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml` file, which you defined in [step 1.2.2 - (1.)](http://docs.wso2.com#1221) .
9.  Enable analytics in WSO2 API-M by setting the following configuration to true in the `<API-M_2.6.0_HOME>/repository/conf/api-manager.xml` file.

    ``` java
        <Analytics>    
            <Enabled>true</Enabled>
            ...
        <Analytics>
    ```

10. Restart the WSO2 API-M Server.

    ``` java
            cd <API-M_2.6.0_HOME>/bin
            sh wso2server.sh
    ```

### Step 2 - Upgrade API Manager to 2.6.0

1.  Stop all WSO2 API Manager server instances that are running.
2.  Make sure you backed up all the databases and Synapse configurations as instructed in [step 1](http://docs.wso2.com#1101) of the previous section.

3.  Upgrade the WSO2 API Manager database from version 2.5.0 to version 2.6.0.

    1.  Download `apimgt-db-migration-scripts-2.5to2.6.zip` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `WSO2AM_DB` database.

4.  Re-index the artifacts in the registry.

    1.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_2.6.0_HOME>` / `repository/conf/registry.xml` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1` **

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `<API-M_2.6.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

5.  Upgrade the Identity component in WSO2 API Manager from version 5.6.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 Identity Sever (WSO2 IS), this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `wso2is-5.7.0-migration.zip` and extract it.
    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_2.6.0_HOME>` directory.
    3.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.6.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.6.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `migrationEnable` element to `true` as shown above.


    4.  Copy the `org.wso2.carbon.is.migration-5.7.0.jar` from the extracted folder to the `<API-M_2.6.0_HOME>`/`repository/components/dropins` directory.

    5.  Copy the keystores (i.e., `client-truststore.jks` , `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_2.6.0_HOME>/repository/resources/security` directory

    6.  Start WSO2 API Manager 2.6.0 as follows to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux)
        -   [**Windows**](#windows)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

`wso2server.bat -Dmigrate -Dcomponent=identity`

    7.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-5.7.0.jar` file, which is in the `<API-M_2.6.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` directory, which is in the `<API-M_2.6.0_HOME>` directory.

    8.  Restart the WSO2 API-M server.

        -   [**Linux / Mac OS**](#linux)
        -   [**Windows**](#windows)

            sh wso2server.sh

`wso2server.bat`
