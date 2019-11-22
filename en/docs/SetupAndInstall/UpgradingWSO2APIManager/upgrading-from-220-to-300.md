# Upgrading API Manager from 2.2.0 to 3.0.0

The following information describes how to upgrade your API Manager server **from APIM 2.2.0 to 3.0.0** .

!!! note
To upgrade **from a version older than 1.8.0** , follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

!!! tip
    Before you begin

    - This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

        -   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.0.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Getting+Started+with+WUM).

    - Before starting the upgrade, run the [token and session cleanup scripts](../../Administer/ProductAdministration/removing-unused-tokens-from-the-database.md) in the databases of the environment, if you are not doing regular cleanups.

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
Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files (e.g., `api-manager.xml` ) may have changed. Instead, redo the configuration changes in the new configuration files.
Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  

    Back up all databases in your API Manager instances along with the Synapse configs of all the tenants and the super tenant.

    -   The Synapse configs of the super tenant are in the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory.

    -   The Synapse configs of tenants are in the `<CURRENT_APIM_HOME>/repository/tenants` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download WSO2 API Manager 2.6.0 from <https://wso2.com/api-management/> .
3.  Open the `<API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml` file and provide the datasource configurations for the following databases. You can copy the configuration values from the same file in the current WSO2 API Manager instance already being used.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (If statistics are configured)

4.  Edit the registry configurations in the `<API-M_2.6.0_HOME>/repository/conf/registry.xml` file and the user database in the `<API-M_2.6.0_HOME>/repository/conf/user-mgt.xml` file, similar to the configurations of the current API Manager.

        !!! info
    If you are working with a **clustered/distributed API Manager setup** , follow step [5](#UpgradingfromthePreviousRelease-step5-2.2.0) on the Gateway node.


5.  Move all your Synapse configurations to API-M 2.6.0 pack.
    -   Move your Synapse super tenant configurations.
        Copy the contents in the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and replace the contents in the `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default` directory with the copied contents.
    -   Move all your tenant Synapse configurations.
        Copy the contents in the `<CURRENT_API-M_HOME>/repository/tenants` directory and replace the contents in the `<API-M_2.6.0_HOME>/repository/tenants` directory with the copied contents.

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

    Run the `apim220_to_apim260_gateway_artifact_migrator.sh` script, as shown below, to migrate from WSO2 API Manager 2.2.0 to 2.6.0.

    ``` java
        ./apim220_to_apim260_gateway_artifact_migrator.sh <API-definitions-path>
    ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.2.0 deployment, reside.

    The API definition paths `<API-definition-path>` are as follows:

    -   Super Tenant - `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default`

    -   Tenant - `<API-M_2.6.0_HOME>/repository/tenants`

    Where, `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0` .

    -   [**Super Tenant**](#supertenant)
    -   [**Tenants**](#8cc7415520c24b539aa7abe95ce514ee)

    Run the PowerShell script `apim220_to_apim260_gateway_artifact_migrator.ps1` as shown below, to migrate from WSO2 API Manager 2.2.0 to 2.6.0.

    1.  Open a Windows command prompt and type the following command.

        ``` java
                powershell
        ```

        A message about PowerShell appears, and the shell changes to PowserShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim220_to_apim260_gateway_artifact_migrator.ps1 <API-definitions-path>
        ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.2.0 deployment, reside.

        -   Super Tenant - `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default`

        Where `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0.`

    Run the PowerShell script `apim220_to_apim260_gateway_artifact_migrator_for_tenants.ps1` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                    powershell
        ```

        A message about PowerShell appears, and the shell changes to PowserShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim220_to_apim260_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
        ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the API-M 2.2.0 deployment, reside.

        -   Tenants - `<API-M_2.6.0_HOME>/repository/tenants`

        Where `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0.`

        !!! note
        It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.
        !!! info
        Troubleshooting
    **Why do I get the following error - apim220\_to\_apim260\_gateway\_artifact\_migrator.ps1 / apim220\_to\_apim250\_gateway\_artifact\_migrator\_for\_tenants.ps1 cannot be loaded because the execution of scripts is disabled on this system?**

    When running the `apim220_to_apim260_gateway_artifact_migrator.ps1` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system.

    To overcome this issue and allow the execution of such scripts, run the following command in the terminal/command-line as the Administrator.

    ``` java
        Set-ExecutionPolicy RemoteSigned
    ```


4.  Upgrade the API Manager database from version 2.2.0 to version 2.6.0.

    1.  Download `apimgt-db-migration-scripts-2.2to2.6.zip` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `WSO2AM_DB` database.

5.  Re-index the artifacts in the registry,

    1.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_2.6.0_HOME>` / `repository/conf/registry.xml` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1`

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `<API-M_2.6.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

6.  Upgrade the Identity component in WSO2 API Manager from version 5.5.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `wso2is-5.7.0-migration.zip` and extract it.
    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_2.6.0_HOME>` directory.
    3.  Open the `migration-config.yaml` file in the migration-resources directory and make sure define the `currentVersion` element to 5.5.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.5.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `migrationEnable element to true as shown above.`


    4.  Copy the `org.wso2.carbon.is.migration-5.7.0.jar` from the extracted folder to the `<API-M_2.6.0_HOME>/repository/components/dropins` directory.

    5.  Copy the keystores (i.e., `client-truststore.jks` , `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_2.6.0_HOME>/repository/resources/security` directory.

    6.  Start WSO2 API Manager 2.6.0 via the terminal as follows to carry out the complete Identity component migration.

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

