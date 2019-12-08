# Upgrading API Manager to 3.0.0

The following information describes how to upgrade your API Manager server **from APIM 2.1.0 to 3.0.0** .

!!! note
To upgrade **from a version older than 1.8.0** , follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

!!! tip
Before you begin

This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

-   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.0.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Getting+Started+with+WUM) .

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
Do not copy entire configuration files from the current version of WSO2 API Manager to the new one, as some configuration files (e.g., `api-manager.xml` ) may have changed. Instead, redo the configuration changes in the new configuration files.
Follow the instructions below to move all the existing API Manager configurations from the current environment to the new one.

1.  

    Back up all databases in your API Manager instances along with the Synapse configs of all the tenants and the super tenant.

    -   The Synapse configs of the super tenant are in the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory.

    -   The Synapse configs of tenants are in the `<CURRENT_APIM_HOME>/repository/tenants` directory.

    -   If you use a **clustered/distributed API Manager setup** , back up the available configurations in the API Gateway node.

2.  Download API Manager 2.6.0 from <https://wso2.com/api-management/> .
3.  Open the `<API-M_2.6.0_HOME>/repository/conf/datasources/master-datasources.xml` file and provide the datasource configurations for the following databases.
    You can copy the configuration values from the same file in the current WSO2 API Manager instance that is already being used.

    -   User Store
    -   Registry database/s
    -   API Manager databases
    -   Statistics database (If statistics are configured)

4.  Edit the registry configurations in the `<API-M_2.6.0_HOME>/repository/conf/registry.xml` file and the user database in the `<API-M_2.6.0_HOME>/repository/conf/user-mgt.xml` file, similar to the configurations of the current API Manager.

        !!! info
    In a **clustered/distributed API Manager setup** , follow steps [5](#UpgradingfromthePreviousRelease-step5-2.1.0) and [6](#UpgradingfromthePreviousRelease-step6-2.1.0) for the Gateway node.


5.  Move all your Synapse configurations **with the exception of the files mentioned below** , by copying the contents in the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` directory and by using it to replace the contents of the `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default` directory. ``

        !!! warning
    **NOTE:** Do not replace the files listed below from the `<CURRENT_API-M_HOME>/repository/deployment/server/synapse-configs/default` folder to API Manager 2.6.0. These are application-specific APIs and sequences. If you made any custom changes to the files below, you need to merge the changes to the corresponding files in 2.6.0.

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


6.  Move all your tenant Synapse configurations by copying the contents in the `<CURRENT_API-M_HOME>/repository/tenants` directory and adding the copied contents to the `<API-M_2.6.0_HOME>/repository/tenants` directory.

        !!! warning
    **NOTE:** Copy the files listed below from the `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default/sequences` directory and replace the corresponding files in the `<API-M_2.6.0_HOME>/repository/tenants/<tenant-id>/synapse-configs/default/sequences` directory.

`_auth_failure_handler_.xml`

`_cors_request_handler_.xml`

`fault.xml`

`main.xml`

`_production_key_error_.xml`

`_resource_mismatch_handler_.xml`

`_sandbox_key_error_.xml`

`_throttle_out_handler_.xml`

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

    Run the `apim210_to_apim260_gateway_artifact_migrator.sh` script, as shown below, to migrate from WSO2 API Manager 2.1.0 to 2.6.0.

    ``` java
        ./apim210_to_apim260_gateway_artifact_migrator.sh <API-definitions-path>
    ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.1.0 deployment, reside.

    The API definition paths `<API-definition-path>` are as follows:

    -   Super Tenant - `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default`

    -   Tenant - `<API-M_2.6.0_HOME>/repository/tenants`

    Where, `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0` .

    -   [**Super Tenant**](#supertenant)
    -   [**Tenants**](#ab5422b341814c8eaddf4a4082f1b4a8)

    Run the PowerShell script `apim210_to_apim260_gateway_artifact_migrator.ps1` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim210_to_apim260_gateway_artifact_migrator.ps1 <API-definitions-path>
        ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.1.0 deployment, reside.

        -   Super Tenant - `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default`

        Where `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0.`

    Run the PowerShell script `apim210_to_apim260_gateway_artifact_migrator_for_tenants.ps1` as follows:

    1.  Open a Windows command prompt and type the following command.

        ``` java
                    powershell
        ```

        A message about PowerShell appears, and the shell changes to PowerShell (PS).

    2.  Run the PowerShell script by passing the location of the gateway artifacts that you need to migrate.

        ``` java
                    .\apim210_to_apim260_gateway_artifact_migrator_for_tenants.ps1 <API-definitions-path>
        ```

`<API-definition-path>` - This is the location where the WSO2 API-M 2.6.0 API definitions, which were copied from the WSO2 API-M 2.1.0 deployment, reside.

        -   Tenants - `<API-M_2.6.0_HOME>/repository/tenants`

        Where `<API-M_2.6.0_HOME>` can be, for example, `/Users/user12/Documents/wso2am-2.6.0.`

        !!! note
        It may take a considerable amount of time, which is proportionate to the amount of artifacts, to complete the migration process.
        !!! info
        Troubleshooting
    **Why do I get the following error - apim210\_to\_apim260\_gateway\_artifact\_migrator.ps1 / apim210\_to\_apim260\_gateway\_artifact\_migrator\_for\_tenants.ps1 cannot be loaded because the execution of scripts is disabled on this system?**

    When running the `apim210_to_apim260_gateway_artifact_migrator.ps1` script, if the execution process is aborted with the above error, it means that the execution of unknown scripts is disabled in the system. To overcome this issue and allow the execution of such scripts, run the following command in the terminal as the Administrator.

    ``` java
        Set-ExecutionPolicy RemoteSigned
    ```


4.  Upgrade the WSO2 API Manager database from version 2.1.0 to version 2.6.0.

    1.  Download the `apimgt-db-migration-scripts-2.1to2.6.zip` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `WSO2AM_DB` database.

5.  If your MB Store database on WSO2 API-M 2.1.0 is not the default H2 DB, upgrade the MB Store database from version 3.1.0 to version 3.2.0.

        !!! note
    It is recommended to use the default H2 database for the MB store database in API-Manager.


    1.  Download `mb-store-migration-scripts-3.1.0_to_3.2.0.zip` and extract it.

    2.  Execute the relevant database script, from the scripts that are provided in the extracted directory, on the `WSO2_MB_STORE_DB` database.

6.  To re-index the artifacts in the registry,

    1.  Rename the `<lastAccessTimeLocation>` element in the `<API-M_2.6.0_HOME>` / `repository/conf/registry.xml` file.
        If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node.
        For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1` **

    2.  Shut down WSO2 API Manager 2.6.0 (if you have already started it).

    3.  If the `<API-M_2.6.0_HOME>/solr` directory exists, take a backup and thereafter delete it.

7.  Upgrade the Identity component in WSO2 API Manager from version 5.3.0 to 5.7.0.

        !!! note
    As WSO2 API-M shares identity components with WSO2 IS, this step is necessary to upgrade those components (even if you are not using WSO2 IS as a Key Manager).


    1.  Download the `wso2is-5.7.0-migration.zip` and extract it.
    2.  Copy the `migration-resources` folder from the extracted folder to the `<API-M_2.6.0_HOME>` directory.
    3.  Open the `migration-config.yaml` file in the `migration-resources` directory and edit the `currentVersion` element to 5.3.0, as shown below.

        ``` java
                migrationEnable: "true"
        currentVersion: "5.3.0"
        migrateVersion: "5.7.0"
        ```
                !!! note
        Make sure you have enabled migration by setting the `migrationEnable` element to `true` .


    4.  Remove the following entry from the `migration-config.yaml` file.

        ``` java
                   -
                    name: "EventPublisherMigrator"
                    order: 11
        ```

    5.  Copy the `org.wso2.carbon.is.migration-5.7.0.jar` from the extracted folder to the `<API-M_2.6.0_HOME>` / `repository/components/dropins` directory.

    6.  Copy the keystores (i.e., `client-truststore.jks` , `wso2cabon.jks` and any other custom JKS) used in the previous version and replace the existing keystores in the `<API-M_2.6.0_HOME>/repository/resources/security` directory

    7.  Start WSO2 API Manager 2.6.0 via the terminal to carry out the complete Identity component migration.

        -   [**Linux / Mac OS**](#linux2)
        -   [**Windows**](#windows2)

            sh wso2server.sh -Dmigrate -Dcomponent=identity

`wso2server.bat -Dmigrate -Dcomponent=identity`

    8.  After you have successfully completed the migration, stop the server and remove the following files and folders.

        -   Remove the `org.wso2.carbon.is.migration-5.7.0.jar` file, which is in the `<API-M_2.6.0_HOME>/repository/components/dropins` directory.

        -   Remove the `migration-resources` folder, which is in the `<API-M_2.6.0_HOME>` directory.

8.  !!! note
    If you are upgrading from a vanilla distribution of WSO2 API Manager 2.1.0 or a WUM updated distribution taken before the 5th December 2017 of WSO2 API Manager 2.1.0, you have to run the following migration client for migrating Access Control support for API Publisher because [Publisher Access Control](https://docs.wso2.com/display/AM260/Enabling+Access+Control+Support+for+API+Publisher) is enabled by default in WSO2 API Manager 2.6.0. **If not, you can skip this step.**


    1.  Download [WSO2 API Manager Migration Client](https://docs.wso2.com/download/attachments/28718536/wso2-api-migration-client.zip?api=v2) and copy it to the `<API-M_HOME>/repository/components/dropins` directory.

    2.  Start the WSO2 API-M server as follows.

        ``` java
                sh wso2server.sh -DmigrateAccessControl=true
        ```

9.  Restart the WSO2 API-M server.

    ``` java
            sh wso2server.sh
    ```

