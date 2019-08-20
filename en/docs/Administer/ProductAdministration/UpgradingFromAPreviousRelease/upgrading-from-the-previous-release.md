# Upgrading from the Previous Release

The following information describes how to upgrade your API Manager server **from APIM 1.8.0/1.9.0/1.9.1/1.10.0/2.0.0/2.1.0/2.2.0/2.5.0** **to 2.6.0** .

!!! note
To upgrade **from a version older than 1.8.0** , follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

!!! tip
Before you begin

This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

-   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 2.6.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Getting+Started+with+WUM) .


-   [**Upgrading from 2.5.0 to 2.6.0**](#250)
-   [**Upgrading from 2.2.0 to 2.6.0**](#220)
-   [**Upgrading from 2.1.0 to 2.6.0**](#210)
-   [**Upgrading from 2.0.0 to 2.6.0**](#200)
-   [**Upgrading from 1.10.0 to 2.6.0**](#110)
-   [**Upgrading from 1.8.0/1.9.0/1.9.1 to 2.6.0**](#8910)

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
Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files (e.g., `            api-manager.xml           ` ) may have changed. Instead, redo the configuration changes in the new configuration files.
Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  Back up all databases in your API Manager instances along with the Synapse configurations of all the tenants and the super tenant.

    -   The Synapse configurations of the super tenant are in the `                <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default               ` directory.

    -   The Synapse configurations of tenants are in the `                <CURRENT_APIM_HOME>/repository/tenants               ` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download API Manager 2.6.0 from <https://wso2.com/api-management/> .
3.  Open the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file and provide the datasource configurations for the following databases. You can copy the configuration values from the same file in the current API Manager instance that you are already using.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (If statistics are configured)

4.  Edit the registry configurations in the `              <API-M_2.6.0_HOME>/repository/conf/registry.xml             ` file and the user database in the `              <API-M_2.6.0_HOME>/repository/conf/user-mgt.xml             ` file, similar to the configurations of the current WSO2 API Manager.

        !!! info
    If you are working with a **clustered/distributed API Manager setup** , follow step [5](#UpgradingfromthePreviousRelease-step5-2.2.0) on the Gateway node.


5.  Move all your Synapse configurations to API-M 2.6.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `               <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default              ` directory and replace the contents in the `               <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default              ` directory with the copied contents.
    -   Move all your tenant Synapse configurations.
        Copy the contents in the `               <CURRENT_API-M_HOME>/repository/tenants              ` directory and replace the contents in the `               <API-M_2.6.0_HOME>/repository/tenants              ` directory with the copied contents.

#### Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics

!!! warning
This step is **only required** if you have WSO2 API-M-Analytics configured in your current deployment.
Follow the steps below to migrate APIM Analytics 2.5.0 to APIM Analytics 2.6.0

##### Step 1.2.1 - Configure WSO2 API-M Analytics 2.6.0

1.  Download WSO2 API Manager Analytics 2.6.0 from [here](http://wso2.com/api-management/) .
2.  Create a new database for the new statistics database and configure it in the `              <APIM_ANALYTICS_2.6.0_HOME>/conf/worker/deployment.yaml             ` as follows:
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

3.  Copy the relevant JDBC driver to the `             <APIM_ANALYTICS_2.6.0_HOME>/lib            ` folder.
4.  Start the new API-M Analytics server.

    ``` java
            cd <APIM_ANALYTICS_2.6.0_HOME>/bin
            sh worker.sh
    ```

    When the WSO2 API-M Analytics 2.6.0 server starts, the new statistics tables will get generated in the database that you configured in **step 1.2.1 - (2.)** above.

##### Step 1.2.2 - Configure WSO2 API-M 2.6.0 for Analytics

Follow the instructions below to configure WSO2 API Manager for the WSO2 API-M Analytics migration in order to migrate the statistics related data.

1.  Configure the statistics related datasources for WSO2 API Manager Analytics.
    Configure the following 3 datasources in the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file.

        !!! warning
    The following 3 datasources should be configured in the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file **only until the stats migration is complete** . After the statistics migration is complete remove the `              APIM_ANALYTICS_DB             ` datasource configuration, which was added for the new statistics database, from the latter mentioned file.


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

        -   The second datasource points to the **WSO2** **Data Analytics (WSO2** **DAS) based previous datasource WSO2AM\_STATS\_DB for statistics** .

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
3.  Copy the **migrate.client-2.6.x-1.jar** to the `             <API-M_2.6.0_HOME>/repository/components/dropins            ` folder.
4.  Copy the relevant JDBC driver to the `             <API-M_2.6.0_HOME>/repository/components/lib            ` folder.
5.  Make sure that WSO2 API-M Analytics is disabled in the `              <API-M_2.6.0_HOME>/repository/conf/             ` `              api-manager.xml             ` file.

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

    You need to use the `                             statTable                           ` **** migration property for table wise migration.

    For example, if you need to migrate only the `              ApiPerDestinationAgg             ` and `              ApiResPathPerApp             ` tables use the following command:

        !!! note
    When you need to migrate multiple tables, the comma separated table names should without spaces before or after the comma as shown below.


    ``` java
        sh wso2server.sh -DmigrateStats=true -DstatTable=ApiPerDestinationAgg,ApiResPathPerApp
    ```

        !!! info
    If the default 3 datasource names/name, which you specified above, changed from the details that you specified in the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file. Use the following command to pass the values to the migration client.

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
    The following warning message could occur during migration if the relevant consumer key does not exist in the `              AM_APPLICATION_KEY_MAPPING             ` table due to Application deletion.

    ``` java
        ConsumerKey <consumerKey> does not contain in the AM_APPLICATION_KEY_MAPPING table.
    ```

    In such scenarios, you will face a migration data loss due to API or Application deletion.


7.  Stop the WSO2 API-M server and remove the migration JAR copied under [Step 1.2.2 - (3.)](http://docs.wso2.com#1223) above.
8.  Remove both the old and new `             STAT_DB            ` datasources from the `             <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml            ` file, which you defined in [step 1.2.2 - (1.)](http://docs.wso2.com#1221) .
9.  Enable analytics in WSO2 API-M by setting the following configuration to true in the `              <API-M_2.6.0_HOME>/repository/conf/             ` `              api-manager.xml             ` file.

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

    1.  Download `                                 apimgt-db-migration-scripts-2.5to2.6.zip                               ` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `               WSO2AM_DB              ` database.

4.  Re-index the artifacts in the registry.

    1.  Rename the `                <lastAccessTimeLocation>               ` element in the `                <API-M_2.6.0_HOME>               ` / `                repository/conf/registry.xml               ` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime               ` registry path to `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1               ` **

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `                <API-M_2.6.0_HOME>/               ` `                solr               ` directory exists, take a backup and thereafter delete it.

5.  Upgrade the Identity component in WSO2 API Manager from version 5.6.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 Identity Sever (WSO2 IS), this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `                               wso2is-5.7.0-migration.zip                             ` and extract it.
    2.  Copy the `               migration-resources              ` folder from the extracted folder to the `               <API-M_2.6.0_HOME>              ` directory.
    3.  Open the `                migration-config.yaml               ` file in the migration-resources directory and make sure that the `                currentVersion               ` element is set to 5.6.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.6.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `                migrationEnable               ` element to `                true               ` as shown above.


    4.  Copy the `                org.wso2.carbon.is.migration-5.7.0.jar               ` from the extracted folder to the `                <API-M_2.6.0_HOME>               ` / `                repository/components/dropins               ` directory.

    5.  Copy the keystores (i.e., `                client-truststore.jks               ` , `                wso2cabon.jks               ` and any other custom JKS) used in the previous version and replace the existing keystores in the `                <API-M_2.6.0_HOME>/repository/resources/security               ` directory

    6.  Start WSO2 API Manager 2.6.0 as follows to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux)
        -   [**Windows**](#windows)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

        `                   wso2server.bat -Dmigrate -Dcomponent=identity                  `

    7.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `                  org.wso2.carbon.is.migration-5.7.0.jar                 ` file, which is in the `                  <API-M_2.6.0_HOME>/repository/components/dropins                 ` directory.

        -   Remove the `                  migration-resources                 ` directory, which is in the `                  <API-M_2.6.0_HOME>                 ` directory.

    8.  Restart the WSO2 API-M server.

        -   [**Linux / Mac OS**](#linux)
        -   [**Windows**](#windows)

            sh wso2server.sh

        `                   wso2server.bat                  `

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.2.0 to 2.6.0** .

!!! note
If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading from the Previous Release when WSO2 IS is the Key Manager](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#220) .
-   [Step 1 - Migrate the configurations](#UpgradingfromthePreviousRelease-Step1-Migratetheconfigurations.1)
    -   [Step 1.1 - Migrate the API Manager configurations](#UpgradingfromthePreviousRelease-Step1.1-MigratetheAPIManagerconfigurations.1)
    -   [Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](#UpgradingfromthePreviousRelease-Step1.2-Optionally,migratetheconfigurationsforWSO2API-MAnalytics.1)
-   [Step 2 - Upgrade API Manager to 2.6.0](#UpgradingfromthePreviousRelease-Step2-UpgradeAPIManagerto2.6.0.1)

### Step 1 - Migrate the configurations

#### Step 1.1 - Migrate the API Manager configurations

!!! warning
Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files (e.g., `            api-manager.xml           ` ) may have changed. Instead, redo the configuration changes in the new configuration files.
Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  

    Back up all databases in your API Manager instances along with the Synapse configs of all the tenants and the super tenant.

    -   The Synapse configs of the super tenant are in the `                <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default               ` directory.

    -   The Synapse configs of tenants are in the `                <CURRENT_APIM_HOME>/repository/tenants               ` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download WSO2 API Manager 2.6.0 from <https://wso2.com/api-management/> .
3.  Open the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file and provide the datasource configurations for the following databases. You can copy the configuration values from the same file in the current WSO2 API Manager instance already being used.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (If statistics are configured)

4.  Edit the registry configurations in the `              <API-M_2.6.0_HOME>/repository/conf/registry.xml             ` file and the user database in the `              <API-M_2.6.0_HOME>/repository/conf/user-mgt.xml             ` file, similar to the configurations of the current API Manager.

        !!! info
    If you are working with a **clustered/distributed API Manager setup** , follow step [5](#UpgradingfromthePreviousRelease-step5-2.2.0) on the Gateway node.


5.  Move all your Synapse configurations to API-M 2.6.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `               <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default              ` directory and replace the contents in the `               <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default              ` directory with the copied contents.
    -   Move all your tenant Synapse configurations.
        Copy the contents in the `               <CURRENT_API-M_HOME>/repository/tenants              ` directory and replace the contents in the `               <API-M_2.6.0_HOME>/repository/tenants              ` directory with the copied contents.

#### Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics

!!! note
This step is **only required** if you have WSO2 API-M-Analytics configured in your current deployment.
!!! info
As you are upgrading from WSO2 API-M Analytics 2.2.0, in order migrate the configurations required to run WSO2 API-M Analytics for WSO2 API-M 2.6.0 carryout the same instructions as mentioned in
[Upgrading from 2.5.0 to 2.6.0 - Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .

### Step 2 - Upgrade API Manager to 2.6.0

1.  Stop all WSO2 API Manager server instances that are running.
2.  Make sure you backed up all the databases and Synapse configs, as instructed in [step 1](#UpgradingfromthePreviousRelease-1111-tab2) of the previous section.

3.  To start the migration process, run the respective migration script based on your environment.

    -   [**Linux/Mac OS**](#6b6143db34d549a19dbae2e5b29b2d2f)
    -   [**Windows**](#41c97331ae53472ab96176541d006363)

    Run the `                                       apim220_to_apim260_gateway_artifact_migrator.sh                                     ` script, as shown below, to migrate from WSO2 API Manager 2.2.0 to 2.6.0.

    ``` java
        ./apim220_to_apim260_gateway_artifact_migrator.sh <API-definitions-path>
    ```

    `                   <API-definition-path>                  ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.2.0 deployment, reside.

    The API definition paths `                   <API-definition-path>                  ` are as follows:

    -   Super Tenant - `                     <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                    `

    -   Tenant - `                     <API-M_2.6.0_HOME>/repository/tenants                    `

    Where, `                   <API-M_2.6.0_HOME>                  ` can be, for example, `                   /Users/user12/Documents/wso2am-2.6.0                  ` .

    -   [**Super Tenant**](#supertenant)
    -   [**Tenants**](#8cc7415520c24b539aa7abe95ce514ee)

    Run the PowerShell script `                                             apim220_to_apim260_gateway_artifact_migrator.ps1                                           ` as shown below, to migrate from WSO2 API Manager 2.2.0 to 2.6.0.

    1.  Open a Windows command prompt and type the following command.

        ``` java
                powershell
        ```

        A message about PowerShell appears, and the shell changes to PowserShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim220_to_apim260_gateway_artifact_migrator.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.2.0 deployment, reside.

        -   Super Tenant - `                          <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

    Run the PowerShell script `                                             apim220_to_apim260_gateway_artifact_migrator_for_tenants.ps1                                           ` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                    powershell
        ```

        A message about PowerShell appears, and the shell changes to PowserShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim220_to_apim260_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.2.0 deployment, reside.

        -   Tenants - `                          <API-M_2.6.0_HOME>/repository/tenants                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

        !!! note
        It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.
        !!! info
        Troubleshooting
    **Why do I get the following error - apim220\_to\_apim260\_gateway\_artifact\_migrator.ps1 / apim220\_to\_apim250\_gateway\_artifact\_migrator\_for\_tenants.ps1 cannot be loaded because the execution of scripts is disabled on this system?**

    When running the `                 apim220_to_apim260_gateway_artifact_migrator.ps1                ` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system.

    To overcome this issue and allow the execution of such scripts, run the following command in the terminal/command-line as the Administrator.

    ``` java
        Set-ExecutionPolicy RemoteSigned
    ```


4.  Upgrade the API Manager database from version 2.2.0 to version 2.6.0.

    1.  Download `                                 apimgt-db-migration-scripts-2.2to2.6.zip                               ` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `               WSO2AM_DB              ` database.

5.  Re-index the artifacts in the registry,

    1.  Rename the `                <lastAccessTimeLocation>               ` element in the `                <API-M_2.6.0_HOME>               ` / `                repository/conf/registry.xml               ` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime               ` registry path to `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1               `

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `                <API-M_2.6.0_HOME>/solr               ` directory exists, take a backup and thereafter delete it.

6.  Upgrade the Identity component in WSO2 API Manager from version 5.5.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `                               wso2is-5.7.0-migration.zip                             ` and extract it.
    2.  Copy the `               migration-resources              ` folder from the extracted folder to the `               <API-M_2.6.0_HOME>              ` directory.
    3.  Open the `                migration-config.yaml               ` file in the migration-resources directory and make sure define the `                currentVersion               ` element to 5.5.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.5.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `                migrationEnable element to true as shown above.               `


    4.  Copy the `                org.wso2.carbon.is.migration-5.7.0.jar               ` from the extracted folder to the `                <API-M_2.6.0_HOME>/repository/components/dropins               ` directory.

    5.  Copy the keystores (i.e., `                client-truststore.jks               ` , `                wso2cabon.jks               ` and any other custom JKS) used in the previous version and replace the existing keystores in the `                <API-M_2.6.0_HOME>/repository/resources/security               ` directory.

    6.  Start WSO2 API Manager 2.6.0 via the terminal as follows to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux)
        -   [**Windows**](#windows)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

        `                   wso2server.bat -Dmigrate -Dcomponent=identity                  `

    7.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `                  org.wso2.carbon.is.migration-5.7.0.jar                 ` file, which is in the `                  <API-M_2.6.0_HOME>/repository/components/dropins                 ` directory.

        -   Remove the `                  migration-resources                 ` directory, which is in the `                  <API-M_2.6.0_HOME>                 ` directory.

    8.  Restart the WSO2 API-M server.

        -   [**Linux / Mac OS**](#linux)
        -   [**Windows**](#windows)

            sh wso2server.sh

        `                   wso2server.bat                  `

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.1.0 to 2.6.0** .

!!! note
If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading from the Previous Release when WSO2 IS is the Key Manager](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#210) .
-   [Step 1 - Migrate the configurations](#UpgradingfromthePreviousRelease-Step1-Migratetheconfigurations.2)
    -   [Step 1.1 - Migrate the WSO2 API Manager configurations](#UpgradingfromthePreviousRelease-Step1.1-MigratetheWSO2APIManagerconfigurations)
    -   [Step 1.2 - Optionally, migrate the configurations for API-M Analytics](#UpgradingfromthePreviousRelease-Step1.2-Optionally,migratetheconfigurationsforAPI-MAnalytics)
-   [Step 2 - Upgrade API Manager to 2.6.0](#UpgradingfromthePreviousRelease-Step2-UpgradeAPIManagerto2.6.0.2)

### Step 1 - Migrate the configurations

#### Step 1.1 - Migrate the WSO2 API Manager configurations

!!! warning
Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files (e.g., `            api-manager.xml           ` ) may have changed. Instead, redo the configuration changes in the new configuration files.
Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  

    Back up all databases in your API Manager instances along with the Synapse configs of all the tenants and the super tenant.

    -   The Synapse configs of the super tenant are in the `                <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default               ` directory.

    -   The Synapse configs of tenants are in the `                <CURRENT_APIM_HOME>/repository/tenants               ` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download API Manager 2.6.0 from <https://wso2.com/api-management/> .
3.  Open the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file and provide the datasource configurations for the following databases.
    You can copy the configuration values from the same file in the current WSO2 API Manager instance that is already being used.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (If statistics are configured)

4.  Edit the registry configurations in the `              <API-M_2.6.0_HOME>/repository/conf/registry.xml             ` file and the user database in the `              <API-M_2.6.0_HOME>/repository/conf/user-mgt.xml             ` file, similar to the configurations of the current API Manager.

        !!! info
    In a **clustered/distributed API Manager setup** , follow steps [5](#UpgradingfromthePreviousRelease-step5-2.1.0) and [6](#UpgradingfromthePreviousRelease-step6-2.1.0) for the Gateway node.


5.  Move all your Synapse configurations **with the exception of the files mentioned below** , by copying the contents in the `              <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default             ` directory and by using it to replace the contents of the `              <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default             ` directory. `             `

        !!! warning
    **NOTE:** Do not replace the files listed below from the `              <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default             ` folder to API Manager 2.6.0. These are application-specific APIs and sequences. If you made any custom changes to the files below, you need to merge the changes to the corresponding files in 2.6.0.

    `              /api/_AuthorizeAPI_.xml             `

    `              /api/_RevokeAPI_.xml             `

    `              /api/_TokenAPI_.xml             `

    `              /api/_UserInfoAPI_.xml             `

    `              /sequences/_auth_failure_handler_.xml             `

    `              /sequences/_build_.xml             `

    `              /sequences/_cors_request_handler_.xml             `

    `              /sequences/fault.xml             `

    `              /sequences/main.xml             `

    `              /sequences/_production_key_error_.xml             `

    `              /sequences/_resource_mismatch_handler_.xml             `

    `              /sequences/_sandbox_key_error_.xml             `

    `              /sequences/_throttle_out_handler_.xml             `

    `              /sequences/_token_fault_.xml             `

    `              /proxy-services/WorkflowCallbackService.xml             `


6.  Move all your tenant Synapse configurations by copying the contents in the `              <CURRENT_API-M_HOME>/repository/tenants             ` directory and adding the copied contents to the `              <API-M_2.6.0_HOME>/repository/tenants             ` directory.

        !!! warning
    **NOTE:** Copy the files listed below from the `              <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default/sequences             ` directory and replace the corresponding files in the `              <API-M_2.6.0_HOME>/repository/tenants/<tenant-id>/synapse-configs/default/sequences             ` directory.

    `               _auth_failure_handler_.xml              `

    `               _cors_request_handler_.xml              `

    `               fault.xml              `

    `               main.xml              `

    `               _production_key_error_.xml              `

    `               _resource_mismatch_handler_.xml              `

    `               _sandbox_key_error_.xml              `

    `               _throttle_out_handler_.xml              `

        !!! info
    In a **clustered/distributed API Manager setup** , do this step on the Gateway node.


#### Step 1.2 - Optionally, migrate the configurations for API-M Analytics

!!! note
This step is **only required** if you have API-M-Analytics configured in your current deployment.
!!! info
As you are upgrading from WSO2 API-M Analytics 2.1.0, in order migrate the configurations required to run WSO2 API-M Analytics for WSO2 API-M 2.6.0 carryout the same instructions as mentioned in
[Upgrading from 2.5.0 to 2.6.0 - Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .

### Step 2 - Upgrade API Manager to 2.6.0

1.  Stop all WSO2 API Manager server instances that are running.
2.  Make sure you backed up all the databases and Synapse configs, as instructed in [step 1](#UpgradingfromthePreviousRelease-1111-tab3) of the previous section.

3.  To start the migration process, run the respective migration script based on your environment.

    -   [**Linux/Mac OS**](#ae3f026aabe44d8b9a7a7d836cf8ad55)
    -   [**Windows**](#c102cbf0528447e7ac5bf0a020df82ea)

    Run the `                                   apim210_to_apim260_gateway_artifact_migrator.sh                                 ` script, as shown below, to migrate from WSO2 API Manager 2.1.0 to 2.6.0.

    ``` java
        ./apim210_to_apim260_gateway_artifact_migrator.sh <API-definitions-path>
    ```

    `                 <API-definition-path>                ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.1.0 deployment, reside.

    The API definition paths `                 <API-definition-path>                ` are as follows:

    -   Super Tenant - `                   <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                  `

    -   Tenant - `                   <API-M_2.6.0_HOME>/repository/tenants                  `

    Where, `                 <API-M_2.6.0_HOME>                ` can be, for example, `                 /Users/user12/Documents/wso2am-2.6.0                ` . `                `

    -   [**Super Tenant**](#supertenant)
    -   [**Tenants**](#ab5422b341814c8eaddf4a4082f1b4a8)

    Run the PowerShell script `                                             apim210_to_apim260_gateway_artifact_migrator.ps1                                           ` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim210_to_apim260_gateway_artifact_migrator.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.1.0 deployment, reside.

        -   Super Tenant - `                          <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

    Run the PowerShell script `                                             apim210_to_apim260_gateway_artifact_migrator_for_tenants.ps1                                           ` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                    powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim210_to_apim260_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.1.0 deployment, reside.

        -   Tenants - `                          <API-M_2.6.0_HOME>/repository/tenants                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

        !!! note
        It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.
        !!! info
        Troubleshooting
    **Why do I get the following error - apim210\_to\_apim260\_gateway\_artifact\_migrator.ps1 / apim210\_to\_apim260\_gateway\_artifact\_migrator\_for\_tenants.ps1 cannot be loaded because the execution of scripts is disabled on this system?**

    When running the `                 apim210_to_apim260_gateway_artifact_migrator.ps1                ` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system. To overcome this issue and allow the execution of such scripts, run the following command in the terminal as the Administrator.

    ``` java
        Set-ExecutionPolicy RemoteSigned
    ```


4.  Upgrade the WSO2 API Manager database from version 2.1.0 to version 2.6.0.

    1.  Download the `                                 apimgt-db-migration-scripts-2.1to2.6.zip                               ` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `                WSO2AM_DB               ` database.

5.  If your MB Store database on WSO2 API-M 2.1.0 is not the default H2 DB, upgrade the MB Store database from version 3.1.0 to version 3.2.0.

        !!! note
    It is recommended to use the default H2 database for the MB store database in API-Manager.


    1.  Download `                                 mb-store-migration-scripts-3.1.0_to_3.2.0.zip                               ` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `                WSO2_MB_STORE_DB               ` database.

6.  To re-index the artifacts in the registry,

    1.  Rename the `                <lastAccessTimeLocation>               ` element in the `                <API-M_2.6.0_HOME>               ` / `                repository/conf/registry.xml               ` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime               ` registry path to `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1               ` **

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `                <API-M_2.6.0_HOME>/solr               ` directory exists, take a backup and thereafter delete it.

7.  Upgrade the Identity component in WSO2 API Manager from version 5.3.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `                               wso2is-5.7.0-migration.zip                             ` and extract it.
    2.  Copy the `               migration-resources              ` folder from the extracted folder to the `               <API-M_2.6.0_HOME>              ` directory.
    3.  Open the `                migration-config.yaml               ` file in the `                migration-resources               ` directory and edit the `                currentVersion               ` element to 5.3.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.3.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `                migrationEnable               ` element to `                true               ` .


    4.  Remove the following entry from the `                migration-config.yaml               ` file.

        ``` java
                   -
                    name: "EventPublisherMigrator"
                    order: 11
        ```

    5.  Copy the `                org.wso2.carbon.is.migration-5.7.0.jar               ` from the extracted folder to the `                <API-M_2.6.0_HOME>               ` / `                repository/components/dropins               ` directory.

    6.  Copy the keystores (i.e., `                client-truststore.jks               ` , `                wso2cabon.jks               ` and any other custom JKS) used in the previous version and replace the existing keystores in the `                <API-M_2.6.0_HOME>/repository/resources/security               ` directory

    7.  Start WSO2 API Manager 2.6.0 via the terminal to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux2)
        -   [**Windows**](#windows2)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

        `                   wso2server.bat -Dmigrate -Dcomponent=identity                  `

    8.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `                  org.wso2.carbon.is.migration-5.7.0.jar                 ` file, which is in the `                  <API-M_2.6.0_HOME>/repository/components/dropins                 ` directory.

        -   Remove the `                  migration-resources                 ` folder, which is in the `                  <API-M_2.6.0_HOME>                 ` directory.

8.  !!! note
    If you are upgrading from a vanilla distribution of WSO2 API Manager 2.1.0 or a WUM updated distribution taken before the 5th December 2017 of WSO2 API Manager 2.1.0, you have to run the following migration client for migrating Access Control support for API Publisher because [Publisher Access Control](https://docs.wso2.com/display/AM260/Enabling+Access+Control+Support+for+API+Publisher) is enabled by default in WSO2 API Manager 2.6.0. **If not, you can skip this step.**


    1.  Download [WSO2 API Manager Migration Client](https://docs.wso2.com/download/attachments/28718536/wso2-api-migration-client.zip?api=v2) and copy it to the `                <API-M_HOME>/repository/components/dropins               ` directory.

    2.  Start the WSO2 API-M server as follows.

        ``` java
                sh wso2server.sh -DmigrateAccessControl=true
        ```

9.  Restart the WSO2 API-M server.

    ``` java
            sh wso2server.sh
    ```

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.0.0 to 2.6.0** .

!!! note
If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading from the Previous Release when WSO2 IS is the Key Manager](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#200) .
-   [Step 1 - Migrate the configurations](#UpgradingfromthePreviousRelease-Step1-Migratetheconfigurations.3)
    -   [Step 1.1 - Migrate the API Manager configurations](#UpgradingfromthePreviousRelease-Step1.1-MigratetheAPIManagerconfigurations.2)
    -   [Step 1.2 - Optionally, migrate the configurations for API-M Analytics](#UpgradingfromthePreviousRelease-Step1.2-Optionally,migratetheconfigurationsforAPI-MAnalytics.1)
-   [Step 2 - Upgrade API Manager to 2.6.0](#UpgradingfromthePreviousRelease-Step2-UpgradeAPIManagerto2.6.0.3)

### Step 1 - Migrate the configurations

#### Step 1.1 - Migrate the API Manager configurations

!!! warning
Do not copy entire configuration files from the current version of API Manager to the new one, as some configuration files (e.g., `            api-manager.xml           ` ) may have changed. Instead, redo the configuration changes in the new configuration files.
In this section, you move all existing API Manager configurations from the current environment to the new one.

1.  

    Back up all databases in your API Manager instances along with the Synapse configs of all the tenants and the super tenant.

    -   The Synapse configs of the super tenant are in the `                <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default               ` directory.

    -   The Synapse configs of tenants are in the `                <CURRENT_APIM_HOME>/repository/tenants               ` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download API Manager 2.6.0 from <https://wso2.com/api-management/> .
3.  Open the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file and provide the datasource configurations for the following databases.
    You can copy the configuration values from the same file in the current WSO2 API Manager instance that is already being used.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (if statistics are configured)

4.  Edit the registry configurations in the `              <API-M_2.6.0_HOME>/repository/conf/registry.xml             ` file and the user database in the `              <API-M_2.6.0_HOME>/repository/conf/user-mgt.xml             ` file similar to the configurations of the current WSO2 API Manager.

        !!! info
    In a **clustered/distributed API Manager setup** , follow steps [5](#UpgradingfromthePreviousRelease-step5-200) and [6](#UpgradingfromthePreviousRelease-step6-200) for the Gateway node.


5.  Move all your Synapse configurations, **except the files mentioned below** , by copying the contents of the `              <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default             ` directory and by using it to replace the contents of the `              <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default             ` directory. `             `

        !!! warning
    **NOTE:** Do not replace the files listed below from the `              <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default             ` folder to WSO2 API Manager 2.6.0. These are application-specific APIs and sequences. If you made any custom changes to the files below, you need to merge the changes to the corresponding files in WSO2 API-M 2.6.0.

    `              /api/_AuthorizeAPI_.xml             `

    `              /api/_RevokeAPI_.xml             `

    `              /api/_TokenAPI_.xml             `

    `              /api/_UserInfoAPI_.xml             `

    `              /sequences/_auth_failure_handler_.xml             `

    `              /sequences/_build_.xml             `

    `              /sequences/_cors_request_handler_.xml             `

    `              /sequences/fault.xml             `

    `              /sequences/main.xml             `

    `              /sequences/_production_key_error_.xml             `

    `              /sequences/_resource_mismatch_handler_.xml             `

    `              /sequences/_sandbox_key_error_.xml             `

    `              /sequences/_throttle_out_handler_.xml             `

    `              /sequences/_token_fault_.xml             `

    `              /proxy-services/WorkflowCallbackService.xml             `


6.  Move all your tenant Synapse configurations by updating the configurations made in the `              <CURRENT_API-M_HOME>/repository/tenants             ` directory to the `              <API-M_2.6.0_HOME>/repository/tenants             ` directory.

        !!! warning
    **NOTE:** Get the files listed below from the `              <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default/sequences             ` directory and replace the corresponding files in the `              <API-M_2.6.0_HOME>/repository/tenants/<tenant-id>/synapse-configs/default/sequences             ` directory.

    `               _auth_failure_handler_.xml              `

    `               _cors_request_handler_.xml              `

    `               fault.xml              `

    `               main.xml              `

    `               _production_key_error_.xml              `

    `               _resource_mismatch_handler_.xml              `

    `               _sandbox_key_error_.xml              `

    `               _throttle_out_handler_.xml              `

        !!! info
    In a **clustered/distributed API Manager setup** , follow this step for the Gateway node.


#### Step 1.2 - Optionally, migrate the configurations for API-M Analytics

!!! note
This step is **only required** if you have WSO2 API-M Analytics configured in your current deployment.
!!! info
As you are upgrading from WSO2 API-M Analytics 2.0.0, in order migrate the configurations required to run WSO2 API-M Analytics for WSO2 API-M 2.6.0 carryout the same instructions as mentioned in [Upgrading from 2.5.0 to 2.6.0 - Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .
### Step 2 - Upgrade API Manager to 2.6.0

1.  Stop all WSO2 API Manager server instances that are running.
2.  Make sure you backed up all the databases and Synapse configs as instructed in [step 1](#UpgradingfromthePreviousRelease-1111-tab4) of the previous section.

3.  To start the migration process, run the respective migration script based on your environment.

    -   [**Linux/Mac OS**](#02e6043bc8244961a20080078c7f5776)
    -   [**Windows**](#e6006f469e4445e4884d96cc2921a816)

    Run the `                                   apim200_to_apim260_gateway_artifact_migrator.sh                                 ` script, as shown below, to migrate from API Manager 2.0.0 to 2.6.0.

    ``` java
        ./apim200_to_apim260_gateway_artifact_migrator.sh <API-definitions-path>
    ```

    `                 <API-definition-path>                ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.0.0 deployment, reside.

    The API definition paths `                 <API-definition-path>                ` are as follows:

    -   Super Tenant - `                   <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                  `

    -   Tenant - `                   <API-M_2.6.0_HOME>/repository/tenants                  `

    Where, `                 <API-M_2.6.0_HOME>                ` can be, for example, `                 /Users/user12/Documents/wso2am-2.6.0                ` . `                `

    -   [**Super Tenant**](#supertenant)
    -   [**Tenants**](#4314f6fd42184ef0b98e585488e1896f)

    Run the PowerShell script `                                             apim200_to_apim260_gateway_artifact_migrator.ps1                                           ` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim200_to_apim260_gateway_artifact_migrator.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which are copied from the WSO2 API-M 2.0.0 deployment, reside.

        -   Super Tenant - `                          <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

    Run the PowerShell script `                                             apim200_to_apim260_gateway_artifact_migrator_for_tenants.ps1                                           ` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                    powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell ( PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim200_to_apim260_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.0.0 deployment, reside.

        -   Tenants - `                          <API-M_2.6.0_HOME>/repository/tenants                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

        !!! note
        It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.
        !!! info
        Troubleshooting
    ##### Why do I get the following error - apim200\_to\_apim260\_gateway\_artifact\_migrator.ps1 / apim200\_to\_apim260\_gateway\_artifact\_migrator\_for\_tenants.ps1 cannot be loaded because the execution of scripts is disabled on this system?

    When running the `                 apim200_to_apim260_gateway_artifact_migrator.ps1                ` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system. To overcome this issue and allow the execution of such scripts, run the following command in the terminal as the Administrator.

    ``` java
        Set-ExecutionPolicy RemoteSigned
    ```


4.  Upgrade the WSO2 API Manager database from version 2.0.0 to version 2.6.0.

    1.  Download the [apimgt-db-migration-scripts-2.0to2.6.zip](attachments/103334533/103334535.zip) ZIP and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `               WSO2AM_DB              ` database.

5.  Do the following to re-index the artifacts in the registry:

    1.  Rename the `                <lastAccessTimeLocation>               ` element in the `                <API-M_2.6.0_HOME>               ` / `                repository/conf/registry.xml               ` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime               ` registry path to `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1               ` .

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `                <API-M_2.6.0_HOME>/solr               ` directory exists, take a backup and thereafter delete it.

6.  Upgrade the Identity component in WSO2 API Manager from version 5.2.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `                               wso2is-5.7.0-migration.zip                             ` and extract it.
    2.  Copy the `                migration-resources               ` folder in the extracted folder to the `                <API-M_2.6.0_HOME>               ` .

    3.  Open the `                migration-config.yaml               ` file in the `                migration-resources               ` directory and edit the `                currentVersion               ` element to 5.2.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.2.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `                migrationEnable               ` element to `                true               ` as defined above.


    4.  Remove the following entries from the `                migration-config.yaml               ` file, which is in the `                migration-resources               ` directory.

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

    5.  Copy the `                org.wso2.carbon.is.migration-5.7.0.jar               ` from the extracted folder to the `                <API-M_2.6.0_HOME>/repository/components/dropins               ` directory.

    6.  Copy the keystores (i.e., `                client-truststore.jks               ` , `                wso2cabon.jks               ` and any other custom JKS) used in the previous version and replace the existing keystores in the `                <API-M_2.6.0_HOME>/repository/resources/security               ` directory.

    7.  Start WSO2 API Manager 2.6.0 via the terminal to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux3)
        -   [**Windows**](#windows3)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

        `                   wso2server.bat -Dmigrate -Dcomponent=identity                  `

    8.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `                  org.wso2.carbon.is.migration-5.7.0.jar                 ` file, which is in the `                  <API-M_2.6.0_HOME>/repository/components/dropins                 ` directory.

        -   Remove the `                  migration-resources                 ` directory, which is in the `                  <API-M_2.6.0_HOME>                 ` directory.

7.  Download the [WSO2 API Manager Migration Client](https://docs.wso2.com/download/attachments/28718536/wso2-api-migration-client.zip?api=v2) and copy it to the `              <API-M_HOME>/repository/components/dropins             ` directory.

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

11. Preserve the case sensitive behavior for the migrated resources by adding the following property to the `              <API-M_HOME>/repository/conf/user-mgt.xml             ` file under `              <AuthorizationManager>             ` as follows:

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

Follow the instructions below to upgrade your WSO2 API Manager server **from APIM 1.10.0** **to 2.6.0** .

!!! note
If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading from the Previous Release when WSO2 IS is the Key Manager](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#110) .
-   [Step 1 - Migrate the configurations](#UpgradingfromthePreviousRelease-Step1-Migratetheconfigurations.4)
    -   [Step 1.1 - Migrate the WSO2 API Manager configurations](#UpgradingfromthePreviousRelease-Step1.1-MigratetheWSO2APIManagerconfigurations.1)
    -   [Step 1.2 - Optionally, migrate the statistics related data from WSO2 DAS to API Manager Analytics](#UpgradingfromthePreviousRelease-Step1.2-Optionally,migratethestatisticsrelateddatafromWSO2DAStoAPIManagerAnalytics)
-   [Step 2 - Upgrade WSO2 API Manager to 2.6.0](#UpgradingfromthePreviousRelease-Step2-UpgradeWSO2APIManagerto2.6.0)

### Step 1 - Migrate the configurations

#### Step 1.1 - Migrate the WSO2 API Manager configurations

!!! warning
Do not copy entire configuration files from the current version of API Manager to the new one, as some configuration files (e.g., `            api-manager.xml           ` ) may have changed. Instead, redo the configuration changes in the new configuration files.
Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  

    Back up all databases in your API Manager instances along with the Synapse configs of all the tenants and the super tenant.

    -   The Synapse configs of the super tenant are in the `                <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default               ` directory.

    -   The Synapse configs of tenants are in the `                <CURRENT_APIM_HOME>/repository/tenants               ` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download API Manager 2.6.0 from <http://wso2.com/api-management/> .
3.  Open the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file and provide the datasource configurations for the following databases. You can copy the configuration values from the same file in the current WSO2 API Manager instance that is already being used.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (if statistics are configured)

4.  Edit the registry configurations in the `              <API-M_2.6.0_HOME>/repository/conf/registry.xml             ` file and the user database in the `              <API-M_2.6.0_HOME>/repository/conf/user-mgt.xml             ` file similar to the configurations of the current WSO2 API Manager.

        !!! info
    In a **clustered/distributed API Manager setup** , follow steps [5](#UpgradingfromthePreviousRelease-stepM5-1100) and [6](#UpgradingfromthePreviousRelease-stepM6-1100) for the Gateway node.


5.  Move all your Synapse configurations, **except the files mentioned below** , by copying the contents in the `              <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default             ` directory and by using it to replace the contents in the `              <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default             ` directory.

        !!! warning
    **NOTE:** Do not replace the files listed below from the `              <CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default             ` folder to WSO2 API-M 2.6.0. These are application-specific APIs and sequences. If you made any custom changes to the files below, you need to merge the changes to the corresponding files in 2.6.0.

    `              /api/_AuthorizeAPI_.xml             `

    `              /api/_RevokeAPI_.xml             `

    `              /api/_TokenAPI_.xml             `

    `              /api/_UserInfoAPI_.xml             `

    `              /sequences/_auth_failure_handler_.xml             `

    `              /sequences/_build_.xml             `

    `              /sequences/_cors_request_handler_.xml             `

    `              /sequences/fault.xml             `

    `              /sequences/main.xml             `

    `              /sequences/_production_key_error_.xml             `

    `              /sequences/_resource_mismatch_handler_.xml             `

    `              /sequences/_sandbox_key_error_.xml             `

    `              /sequences/_throttle_out_handler_.xml             `

    `              /sequences/_token_fault_.xml             `

    `              /proxy-services/WorkflowCallbackService.xml             `


6.  Move all your tenant Synapse configurations.
    Copy the contents in the `              <CURRENT_API-M_HOME>/repository/tenants             ` directory. Replace the contents in the `              <API-M_2.6.0_HOME>/repository/tenants             ` directory with the copied contents.

        !!! warning
    **NOTE:** Get the files listed below from the `              <API_M_2.6.0_MANAGER_HOME>/repository/deployment/server/synapse-configs/default/sequences             ` directory and replace the corresponding files in the `              <API_M_2.6.0_MANAGER_HOME>/repository/tenants/<tenant-id>/synapse-configs/default/sequences             ` directory.

    `               _auth_failure_handler_.xml              `

    `               _cors_request_handler_.xml              `

    `               fault.xml              `

    `               main.xml              `

    `               _production_key_error_.xml              `

    `               _resource_mismatch_handler_.xml              `

    `               _sandbox_key_error_.xml              `

    `               _throttle_out_handler_.xml              `

        !!! info
    In a **clustered/distributed API Manager setup** , do this step for the Gateway node.


7.  If you have documentation defined for your APIs, make sure you add a value to the **Documentation Summary** field.
    Documentation summary is mandatory in APIM 2.0.0 onwards. Therefore, you may face issues when trying to migrate with an empty documentation summary field from an older version.

#### Step 1.2 - Optionally, migrate the statistics related data from WSO2 DAS to API Manager Analytics

!!! note
This step is **only required** if you have WSO2 Data Analytics Server (WSO2 DAS) configured in your current deployment for analytics.
From WSO2 API Manager 2.0.0 onwards, statistics can be configured only for RDBMS, because the WSO2 API Manager 1.10.0 REST based analytics configurations no longer exists. Follow the instructions below to migrate statistics data from a previous versions of API Manager to WSO2 API-M 2.6.0.

**If you have configured analytics using RDBMS -**

1.  Take a backup of the API Manager statistics DB ( `             STAT_DB            ` ).
2.  Execute the relevant DB script found in `             migration-scripts/110-200-migration/stat/            ` on the `             STAT_DB            ` database that you configured in WSO2 DAS for WSO2 API-M 1.10.0.
    After executing the DB script, now, your `             STAT_DB            ` is similar to the `             STAT_DB            ` in WSO2 API-M 2.0.0.
3.  Directly migrate to WSO2 API-M 2.6.0 as mention in [Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics, under the Upgrade from 2.5.0 to 2.6.0 tab](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .

    You may notice that the following exceptions are thrown in the console when migrating at this point. These exceptions occur because the following tables were introduced only after WSO2 API-M 2.0.0. Therefore, you can safely ignore these exceptions.

        !!! note
    `              com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'TestStatsDB_new.API_REQ_USER_BROW_SUMMARY' doesn't exist.             `

    `              com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'TestStatsDB_new.API_EXE_TME_SUMMARY' doesn't exist             `

    `              com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'TestStatsDB_new.API_REQ_GEO_LOC_SUMMARY' doesn't exist             `


**If you configured analytics using the REST client in API-M 1.10.0 with DAS 3.0.x -**

1.  Configure analytics using WSO2 API Manager 1.10.0 and WSO2 DAS 3.0.x with the RDBMS client based on the instructions in [Publishing API Runtime Statistics Using RDBMS](https://docs.wso2.com/display/AM1100/Publishing+API+Runtime+Statistics+Using+RDBMS) , which is in the WSO2 API-M 1.10.0 documentation.
2.  Wait for data to appear on the RDBMS and WSO2 API Manager statistics dashboard.
3.  Take a backup of the WSO2 API Manager statistics DB ( `              STAT_DB             ` ).

4.  Execute the relevant DB script found in `             migration-scripts/110-200-migration/stat/            ` on the `             STAT_DB            ` that you configured in WSO2 Data Analytics (WSO2 DAS) for WSO2 API Manager 1.10.0.
    After executing the DB script, now, your `             STAT_DB            ` is similar to the `             STAT_DB            ` in WSO2 API-M 2.0.0.
5.  Directly migrate to WSO2 API-M 2.6.0 as mention in [Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics, under the Upgrade from 2.5.0 to 2.6.0 tab](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .

### Step 2 - Upgrade WSO2 API Manager to 2.6.0

1.  Stop all WSO2 API Manager server instances that are running.
2.  Make sure you backed up all the databases and Synapse configs as instructed in [step 1](#UpgradingfromthePreviousRelease-1111-tab5) of the previous section.

3.  Before you run the migration client, open the `              <API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml             ` file, and set the `              <username>             ` , and `              <password>             ` elements of the `              AM_DB             ` JNDI to that of a user who has permissions to alter tables in the database.

        !!! tip
    **Tip** : After you are done running the migration client, you can switch these credentials back to a user with lesser privileges.


    **Example**

    ``` java
        <datasource>
                ...
                <definition type="RDBMS">
                    <configuration>
                        ...
                        <username>xxxxxx</username>
                        <password>xxxxxx</password>
                        ...
                    </configuration>
                 </definition>
        </datasource>
    ```

4.  Upgrade the Identity component in WSO2 API Manager from version 5.1.0 to 5.2.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the migration DB scripts for version 5.1.0 to 5.2.0 from [here](https://docs.wso2.com/download/attachments/56986329/wso2is-5.2.0-migration.zip?version=8&modificationDate=1510725555000&api=v2) .
    2.  Unzip and find the correct DB script in the `               wso2is-5.2.0-migration/dbscripts/identity/migration-5.1.0_to_5.2.0              ` directory.
    3.  Manually execute the DB scripts that correspond to the RDBMS that you are working with.

                !!! note
        Apply the respective DB script found inside the following directories against the respective DB as follows:

        <table>
        <thead>
        <tr class="header">
        <th>DB script directory</th>
        <th>Applicable DB</th>
        <th>Description</th>
        </tr>
        </thead>
        <tbody>
        <tr class="odd">
        <td><code>                    wso2is-5.2.0-migration/dbscripts/identity/migration-5.1.0_to_5.2.0                   </code></td>
        <td><code>                    AM_DB                   </code></td>
        <td><br />
        </td>
        </tr>
        <tr class="even">
        <td><code>                    wso2is-5.2.0-migration/dbscripts/migration-5.1.0_to_5.2.0                   </code></td>
        <td><code>                    UM_DB                   </code></td>
        <td>This script includes insert operations and some index creation scripts against the <code>                    UM_CLAIM                   </code> table, which are required in order for you to upgrade from your previous WSO2 API-M version to WSO2 API-M 2.0.0.</td>
        </tr>
        </tbody>
        </table>


        For example, if you are working with a MySQL DB, run the `                mysql.sql               ` script.

5.  Download and extract the [WSO2 API Manager migration client](https://docs.wso2.com/download/attachments/28718536/wso2-api-migration-client.zip?api=v2) and do the following to upgrade your version of WSO2 API Manager to WSO2 API-M 2.0.0:

        !!! info
    This migration client upgrades the WSO2 API Manager components from WSO2 API-M 1.10.0 to WSO2 API-M 2.0.0 first. Thereafter, from **[step 6](#UpgradingfromthePreviousRelease-GatewayScript)** onwards, you need to carryout the rest of the changes that are required to upgrade from version WSO2 API-M 2.0.0 to WSO2 API-M 2.6.0.


    1.  Copy the `               org.wso2.carbon.apimgt.migrate.client-2.0.X.jar              ` file to the `               <API-M_2.6.0_HOME>/repository/components/dropins              ` directory.
        If you use a **clustered/distributed API Manager setup** , copy the JAR file to the Publisher and Gateway nodes.
    2.  Copy the `               migration-script              ` folder into `               <API-M_2.6.0_HOME>              ` .
        If you use a **clustered/distributed API Manager setup** , copy the `               migration-script              ` folder to a Publisher node.
        1.  Start API Manager 2.6.0 with the following command-line options to migrate the database, registry, and the file system, separately, in the given order.

            <table>
            <thead>
            <tr class="header">
            <th>Description</th>
            <th>Command</th>
            </tr>
            </thead>
            <tbody>
            <tr class="odd">
            <td>To migrate the database only.<br />
            This migrates the <code>                      AM_DB                     </code> database. Please ensure that the <code>                      &lt;API_M_PUBLISHER&gt;/repository/conf/datasources/master-datasources.xml                     </code> file has an entry for <code>                      AM_DB                     </code> .</td>
            <td><code>                      -DmigrateDB=true -Dcomponent=apim -DmigrateFromVersion=1.10.0                     </code></td>
            </tr>
            <tr class="even">
            <td><div class="content-wrapper">
            <p>To migrate the registry only.<br />
            This migrates the registry-related resources such as <code>                        .rxt                       </code> and Swagger definitions.</p>
                        !!! note
                        <p>You may notice the &quot; <code>                        Fault sequence migration from APIM 2.0.0 to 2.1.0 has started                       </code> &quot; log message in this step which used for fault sequence migration. This migration is also done in this step.</p>

            </div></td>
            <td><code>                      -DmigrateReg=true -Dcomponent=apim -DmigrateFromVersion=1.10.0                     </code></td>
            </tr>
            <tr class="odd">
            <td>To migrate the file system only.<br />
            This migrates the Synapse config files such as APIs that reside in the file system. Therefore, you must run this command on the Gateway node/s of a distributed WSO2 API Manager setup.</td>
            <td><code>                      -DmigrateFS=true -Dcomponent=apim -DmigrateFromVersion=1.10.0                     </code></td>
            </tr>
            <tr class="even">
            <td><div class="content-wrapper">
            <p>To migrate to the new throttling engine and generate throttle policies.<br />
            This migrates Synapse config files, the API-M database with new throttle policies and generates throttle policies to the <code>                        &lt;API-M_2.6.0_HOME&gt;/executionplans                       </code> directory. Therefore, you must run this command against a node that has Synapse config files and the <code>                        AM_DB                       </code> . After the migration, copy the <code>                        &lt;API-M_2.6.0_HOME&gt;/executionplans                       </code> directory to the <code>                        &lt;API-M_2.6.0_HOME&gt;/repository/deployment/server/executionplans                       </code> directory <strong>of the Traffic Manager node</strong> . <strong></strong></p>
                        !!! note
                        <p>Please note that you need to use either this command or the one below in order to migrate to the new throttling engine of APIM 2.0.0.</p>

            </div></td>
            <td><code>                      -Dcomponent=apim -DmigrateFromVersion=1.10.0 -Doptions=migrateThrottling                     </code></td>
            </tr>
            <tr class="odd">
            <td><div class="content-wrapper">
            <p>To migrate to the new throttling engine and deploy throttle policies to the Traffic Manager node.<br />
            This migrates Synapse config files, the API-M database with new throttle policies, and deploys policies to the Traffic Manager node. Therefore, you must run this command against a node that has Synapse config files, the <code>                        AM_DB,                       </code> and is pointed to the Traffic Manager node.</p>
                        !!! note
                        <p>Please use this command if you want to deploy the throttle policies directly to the Traffic Manager node while performing the migration.</p>

            </div></td>
            <td><code>                      -Dcomponent=apim -DmigrateFromVersion=1.10.0 -Doptions=migrateThrottling,deployPolicies                     </code></td>
            </tr>
            </tbody>
            </table>

                        !!! tip
            If you are using a **clustered/distributed API Manager setup -**

            -   Run with the following options `                    -DmigrateDB=true -DmigrateReg=true -Dcomponent=apim -DmigrateFromVersion=1.10.0                   ` in the API Publisher node.

            -   Run the `                    -DmigrateFS=true -Dcomponent=apim -DmigrateFromVersion=1.10.0                   ` options in the API Gateway node.

                        !!! tip
            -   To migrate to the throttling engine of WSO2 API-M 2.6.0, you have to use a node that has `                    AM_DB                   ` pointed as well as API Gateway Synapse configurations in place in the file system.

            -   If you only use the `                    migrateThrottling                   ` option, you can use the API Gateway node.

            -   Make sure that `                    AM_DB                   ` is pointed to the Gateway at the time of migration.

            -   You can start the Gateway server with the `                    -Dcomponent=apim -DmigrateFromVersion=1.10.0 -Doptions=migrateThrottling                   ` command.

            -   After completing this execution, make sure you copy the generated throttle policies in the `                    <API-M_2.6.0_HOME>/executionplans                   ` directory to the `                    <API-M_2.6.0_HOME>/repository/deployment/server/executionplans                   ` directory of **the Traffic Manager Node** .

            -   If you use both the `                    migrateThrottling,deployPolicies                   ` options make sure that the Traffic Manager node is configured with the Gateway node, and that you avoid passing the `                    -Dprofile                   ` option while performing the migration. When using these options, you do not have to manually copy the throttling policies to the Traffic Manager.

            -   You can the start the Gateway server with the `                    -Dcomponent=apim -DmigrateFromVersion=1.10.0 -Doptions=migrateThrottling,deployPolicies                   ` command.

                        !!! info
            Troubleshooting

            If you have [enabled token encryption](https://docs.wso2.com/display/AM260/Encrypting+OAuth+Keys) in your database, those consumer keys need to be decrypted as part of the database migration. If you encounter the following error, it means that the migration client has failed to decrypt some of the keys in the old database.

            ``` java
                        ERROR {org.wso2.carbon.apimgt.migration.client.MigrateFrom19to110} -  Cannot decrypt consumer key : DRHbt68uSU4+7xtCEIzuf42CMaqXbNjYl3OYVJ0VL/H6EsFo8GBRaZGUhLHlTWIHzYrvoeOpb1YbauvRRIN/b6VqEd9m8HuYOIuLkkDd AM_APPLICATION_KEY_MAPPING table {org.wso2.carbon.apimgt.migration.client.MigrateFrom19to110}
            ```

            If this error occurs, by default, the migration client will terminate without updating databases in order to maintain database integrity. However, you can change this behavior by adding the following argument and running the WSO2 API-M migration client again from the beginning. ****Please note that the database is then updated with the keys where decryption was successful and failed keys are permanently deleted.
            ****

            ``` java
                            -DremoveDecryptionFailedKeysFromDB=true
            ```

                        !!! note
            Expected Errors

            The following are some errors that you may come across. **Do not get alarmed** as these errors are to be expected, because you are yet to complete the migration process.

            -   You may notice the following exception being thrown in the console when WSO2 API Manager 2.6.0 is started at this point,

                ``` java
                                org.wso2.carbon.idp.mgt.IdentityProviderManagementException: Error occurred while retrieving Identity Provider information for tenant : carbon.super and Identity Provider name : LOCAL
                ```

                This is due to the fact that the `                    IDP_METADATA                   ` table does not exist in the WSO2 API Manager database. The instructions given from **[step 9](#UpgradingfromthePreviousRelease-IDP_METADATA)** onwards address the creation of the `                    IDP_METADATA                   ` table after which this exception will no longer be thrown.

            -   You may notice the following error during the first stage of running the WSO2 API Manager Migration Client.

                ``` java
                                    com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'WSO2AM_DB.AM_POLICY_APPLICATION' doesn't exist
                ```

                This error will get resolved after the first run of the migration client.

            -   You may notice Gateway artifact deployment related errors.
                The following is one such exception that is thrown in the console when WSO2 API Manager 2.6.0 is started at this point.

                ``` java
                                    Error loading class : org.wso2.carbon.apimgt.usage.publisher.APIMgtResponseHandler - Class not found
                ```

                This error gets eliminated after executing the Gateway artifact migration script in **[step 6](#UpgradingfromthePreviousRelease-GatewayScript)** .

            -   You may also notice the following exceptions when WSO2 API Manager 2.6.0 is started at this point.

                ``` java
                                    com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'WSO2AM_DB.IDN_CLAIM_DIALECT' doesn't exist
                ```

                ``` java
                                    com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table 'WSO2AM_DB.IDN_OIDC_SCOPE' doesn't exist
                ```

                These errors will be resolved after following the instructions given under **[step 9](#UpgradingfromthePreviousRelease-IDP_METADATA)** below.


6.  Run the respective migration script, based on your environment.

    -   [**Linux/Mac OS**](#6856588de17d4f4585d5f97a8c1a2d09)
    -   [**Windows**](#e13babcdcd0c412e9482beac777a69e3)

    Run the `                                   apim200_to_apim260_gateway_artifact_migrator.sh                                 ` script, as shown below, to migrate from WSO2 API Manager 2.0.0 to 2.6.0.

    ``` java
        ./apim200_to_apim260_gateway_artifact_migrator.sh <API-definitions-path>
    ```

    `                 <API-definition-path>                ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.0.0 deployment, reside.

    The API definition paths `                 <API-definition-path>                ` are as follows:

    -   Super Tenant - `                   <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                  `

    -   Tenant - `                   <API-M_2.6.0_HOME>/repository/tenants                  `

    Where, `                 <API-M_2.6.0_HOME>                ` can be, for example, `                 /Users/user12/Documents/wso2am-2.6.0                ` . `                                 `

    -   [**Super Tenant**](#supertenant)
    -   [**Tenants**](#595cdd57b0e34ae583150868556c51e2)

    Run the PowerShell script `                                             apim200_to_apim260_gateway_artifact_migrator.ps1                                           ` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim200_to_apim260_gateway_artifact_migrator.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.0.0 deployment, reside.

        -   Super Tenant - `                          <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

    Run the PowerShell script `                                             apim200_to_apim260_gateway_artifact_migrator_for_tenants.ps1                                           ` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                    powershell
        ```

        A message about PowerShell (PS) appears, and the shell changes to PS.

    2.  Run the PowerShell script by passing the location of the Gateway artifacts that you need to migrate.

        ``` java
                    .\apim200_to_apim260_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
        ```

        `                        <API-definition-path>                       ` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.0.0 deployment, reside.

        -   Tenants - `                          <API-M_2.6.0_HOME>/repository/tenants                         `

        Where `                        <API-M_2.6.0_HOME>                       ` can be, for example, `                        /Users/user12/Documents/wso2am-2.6.0.                       `

        !!! note
        It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.
        !!! info
        Troubleshooting
    ##### Why do I get the following error - apim200\_to\_apim260\_gateway\_artifact\_migrator.ps1 / apim200\_to\_apim260\_gateway\_artifact\_migrator\_for\_tenants.ps1 cannot be loaded because the execution of scripts is disabled on this system?

    When running the `                 apim200_to_apim260_gateway_artifact_migrator.ps1                ` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system. To overcome this issue and allow the execution of such scripts, run the following command in the terminal/command-line as the Administrator.

    ``` java
        Set-ExecutionPolicy RemoteSigned
    ```


7.  Upgrade the WSO2 API Manager database from version 2.0.0 to version 2.6.0.

    1.  Download the [apimgt-db-migration-scripts-2.0to2.6.zip](attachments/103334533/103334535.zip) and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `               WSO2AM_DB              ` database.

8.  Do the following to re-index the artifacts in the registry:

    1.  Rename the `                <lastAccessTimeLocation>               ` element in the `                <API-M_2.6.0_HOME>/repository               ` `                /conf/registry.xml               ` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime               ` registry path to `                /_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1               ` .

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `                <API-M_2.6.0_HOME>/solr               ` directory exists, take a backup and thereafter delete it.

9.  Upgrade the Identity component in WSO2 API Manager from version 5.2.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `                               wso2is-5.7.0-migration.zip                             ` and extract it.
    2.  Copy the `               migration-resources              ` folder in the extracted folder to `               <API-M_2.6.0_HOME>              ` .
    3.  Open the `                migration-config.yaml               ` file in the migration-resources directory and edit the `                currentVersion               ` element to 5.2.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.2.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `                migrationEnable               ` element to `                true               ` as defined above.


    4.  Remove the following entries from the `                migration-config.yaml               ` file.

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

    5.  Copy the `                org.wso2.carbon.is.migration-5.7.0.jar               ` from the extracted folder to the `                <API-M_2.6.0_HOME>/repository/components/dropins               ` directory.

    6.  Copy the keystores (i.e., `                client-truststore.jks               ` , `                wso2cabon.jks               ` and any other custom JKS) used in the previous version and replace the existing keystores in the `                <API-M_2.6.0_HOME>/repository/resources/security               ` directory

    7.  Start API Manager 2.6.0 via the terminal to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux4)
        -   [**Windows**](#windows4)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

        `                   wso2server.bat -Dmigrate -Dcomponent=identity                  `

    8.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `                  org.wso2.carbon.is.migration-5.7.0.jar                 ` file, which is in the `                  <API-M_2.6.0_HOME>/repository/components/dropins                 ` directory.

        -   Remove the `                  migration-resources                 ` directory, which is in the `                  <API-M_2.6.0_HOME>                 ` directory.

10. !!! note
    You have to run the following migration client for migrating Access Control support for API Publisher, because [Publisher Access Control](https://docs.wso2.com/display/AM260/Enabling+Access+Control+Support+for+API+Publisher) is enabled by default in API Manager 2.6.0.


    1.  Download [WSO2 API Manager Migration Client](https://docs.wso2.com/download/attachments/28718536/wso2-api-migration-client.zip?api=v2) (You can use the same JAR that download in [step 5](#UpgradingfromthePreviousRelease-step5JAR) )  and copy it to the `                <API-M_HOME>/repository/components/dropins               ` directory.

    2.  Start the WSO2 API-M server as follows:

        ``` java
                sh wso2server.sh -DmigrateAccessControl=true
        ```

11. Preserve the case sensitive behavior for the migrated resources by adding the following property to the `              <API-M_HOME>/repository/conf/user-mgt.xml             ` file under `              <AuthorizationManager>             ` as follows:

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

Follow the instructions below to upgrade your WSO2 API Manager server **from APIM 1.8.0/1.9.0/1.9.1** **to 2.6.0** .

!!! note
If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading from the Previous Release when WSO2 IS is the Key Manager](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#8910) .
### Step 1 - Upgrade WSO2 API Manager to 2.0.0

!!! note
It is not possible to directly upgrade from WSO2 API Manager 1.8.0/1.9.0/1.9.1 to 2.6.0.
[Upgrade your current WSO2 API-M version (1.8.0/1.9.0/1.9.1) to WSO2 API-M 2.0.0](https://docs.wso2.com/display/AM200/Upgrading+from+the+Previous+Release) as expained in the WSO2 API-M 2.0.0 documentation.

### Step 2 - Upgrade WSO2 API Manager to 2.6.0

After you have successfully migrated your current WSO2 API-M version to 2.0.0, upgrade from API-M 2.0.0 to API-M 2.6.0. For more information, see [Upgrading from 2.5.0 to 2.6.0 - Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .

This concludes the upgrade process.

!!! tip
**Tip 1** : The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! tip
**Tip 2** : From 2.6.0 onwards, WSO2 API Manager is configured by default to trigger token clean up during token generation, token refreshing and token revocation. For more details, see [Configuring API Manager for token cleanup](https://docs.wso2.com/display/AM260/Removing+Unused+Tokens+from+the+Database#RemovingUnusedTokensfromtheDatabase-ConfiguringAPIManagerfortokencleanup) . Therefore, when the state of the token ( `         TOKEN_STATE)        ` is changed during any of the latter mentioned processes for tokens that were ACTIVE before the migration process and/or for tokens that will be generated after the migration process, by default, such tokens will be removed from the `         IDN_OAUTH2_ACCESS_TOKEN        ` table and stored in an audit table. However, the old tokens which were already inactive, revoked, or expired before the migration will not be cleaned by the same token cleanup process. Therefore, alternatively, after the migration, you could follow step 3 in the [Using stored procedures for token cleanup](https://docs.wso2.com/display/AM260/Removing+Unused+Tokens+from+the+Database#RemovingUnusedTokensfromtheDatabase-Usingstoredproceduresfortokencleanup) section and use the given token clean up script to manually clean up the old inactive, revoked, and expired tokens from the `         IDN_OAUTH2_ACCESS_TOKEN        ` table.

!!! tip
**Tip 3** : If you are using an SVN based deployment synchronizer, start with a clean SVN repository and point the new deployment nodes to the new SVN repository. In addition, you need to remove any existing `         .svn        ` directories in the new deployment's `         <API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default        ` directory and the `         <API-M_2.6.0_HOME>/repository/tenants/<tenant-id>/synapse-configs/default        ` directory before starting the servers. For more details, see [Configuring Deployment Synchronization](https://docs.wso2.com/display/CLUSTER44x/Configuring+SVN-Based+Deployment+Synchronizer) .


