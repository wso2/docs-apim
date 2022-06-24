# Upgrading WSO2 IS as Key Manager to 5.11.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 3.0.0 to 4.1.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager** in the pre-migrated setup.

!!! note
    -   You can follow the below information in either one of the following situations:
        -   You are currently using a WSO2 IS 5.9.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server as Key Manager 5.9.0 distribution.

-   [Step A - Upgrade IS as Key Manager 5.10.0 to IS 5.11.0](#upgrade-is-as-key-manager-5100-to-is-5110)
-   [Step B - Upgrade API Manager 3.0.0 to 4.1.0](#step-b-upgrade-api-manager-300-to-410)

## Step A - Upgrade IS as Key Manager 5.10.0 to IS 5.11.0

Follow step 1 to step 3 below to upgrade your IS as Key Manager 5.10.0 to IS 5.11.0

-   [Step 1 - Migrate the IS as KM configurations to IS 5.11.0](#step-1-migrate-the-is-as-km-configurations)

-   [Step 2 - Migrate the IS as KM resources to IS 5.11.0](#step-2-migrate-the-is-as-km-resources)

-   [Step 3 - Migrate the IS as KM components to IS 5.11.0](#step-3-migrate-the-is-as-km-components)

### Step 1 - Migrate the IS as KM configurations

1. Download WSO2 IS 5.11.0 distribution from [here](https://wso2.com/identity-and-access-management/) and extract it.
   `<IS_HOME>` refers to the root folder of the extracted WSO2 IS 5.11.0.
   
2. Add following configurations in the `<IS_HOME>/repository/conf/deployment.toml` file.

    ??? info "deployment.toml"
        ```
        [[event_listener]]
        id = "token_revocation"
        type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
        name = "org.wso2.is.notification.ApimOauthEventInterceptor"
        order = 1

        [[resource.access_control]]
        context = "(.)/keymanager-operations/user-info/claims(.)"
        secure = true
        http_method = "GET"
        permissions = "/permission/admin/manage/identity/usermgt/list"
        scopes = "internal_user_mgt_list"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/user-info/claims/generate"
        secure = true
        http_method = "POST"
        permissions = "/permission/admin/manage/identity/usermgt/list"
        scopes = "internal_user_mgt_list"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register"
        secure = true
        http_method = "POST"
        permissions = "/permission/admin/manage/identity/applicationmgt/create"
        scopes = "internal_application_mgt_create"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register(.*)"
        secure = true
        http_method = "GET"
        permissions = "/permission/admin/manage/identity/applicationmgt/view"
        scopes = "internal_application_mgt_view"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register(.*)"
        secure = true
        http_method = "PUT"
        permissions = "/permission/admin/manage/identity/applicationmgt/update"
        scopes = "internal_application_mgt_update"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register(.*)"
        secure = true
        http_method = "DELETE"
        permissions = "/permission/admin/manage/identity/applicationmgt/delete"
        scopes = "internal_application_mgt_delete"

        [tenant_context.rewrite]
        custom_webapps = ["/keymanager-operations/"]
        ```
3. Configure the event listener endpoint to publish controller events to the Traffic Manager.

    ```
    [event_listener.properties]
    notification_endpoint = "https://<tm.wso2.com>:9443/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "WSO2-IS"
    ```
   
4. IS 5.11.0 uses Symmetric encryption as default and APIM 410 uses Asymmetric algorithm as default. So when using IS 5.11.0 as KM please add below configurations to `deployment.toml`.
   ```
   [keystore]
   userstore_password_encryption = "InternalKeyStore"
   
   [system.parameter]
   "org.wso2.CipherTransformation"="RSA/ECB/OAEPwithSHA1andMGF1Padding"
   
   [encryption]
   internal_crypto_provider = "org.wso2.carbon.crypto.provider.KeyStoreBasedInternalCryptoProvider"
   ```   

5. Migrate IS KM 5.10.0 configurations as per the instructions in [Migrating the configurations](https://is.docs.wso2.com/en/5.11.0/setup/migrating-preparing-for-migration/#migrating-the-configurations).

    !!! Important
        When following the instructions in [Migration the configurations](https://is.docs.wso2.com/en/5.11.0/setup/migrating-preparing-for-migration/#migrating-the-configurations) section of IS 5.11.0 migration guide, make sure to
        follow the below guidelines as well.

        -   Configure the `identity_db` datasource in `<IS_HOME>/repository/conf/deployment.toml` of IS 5.11.0  by pointing to the **old** `WSO2AM_DB`.
            ```
            [database.identity_db]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/am_db"
            username = "wso2carbon"
            password = "wso2carbon"
            ```

        -   If you have used a **JDBCUserStoreManager** as the userstore in previous IS as KM setup, comment/remove the following from `<IS_HOME>/repository/conf/deployment.toml` in IS 5.11.0.
            ```
            #[user_store]
            #type = "read_write_ldap_unique_id"
            #connection_url = "ldap://localhost:${Ports.EmbeddedLDAP.LDAPServerPort}"
            #connection_name = "uid=admin,ou=system"
            #connection_password = "admin"
            #base_dn = "dc=wso2,dc=org"      
            ```
            Instead, add the following to the `<IS_HOME>/repository/conf/deployment.toml` in IS 5.11.0
            ```
            [user_store]
            type = "database"
            ```

        -   If you have used **separate DBs** for user management and registry in the previous IS as KM version, you need to configure WSO2REG_DB and WSO2USER_DB databases separately in `<IS_HOME>/repository/conf/deployment.toml` of IS 5.11.0 to avoid any issues.
            ```
            [database.shared_db]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/reg_db"
            username = "wso2carbon"
            password = "wso2carbon"

            [database.user]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/um_db"
            username = "wso2carbon"
            password = "wso2carbon"
            ```

        -   If you have used a separate user management database as the primary userstore in previous IS as KM setup, add the following to the `<IS_HOME>/repository/conf/deployment.toml` in IS 5.11.0.
            ```
            [realm_manager]
            data_source = "WSO2USER_DB"
            ```
        -   You **DO NOT NEED** to copy the API-M Key Manager specific configurations from `<OLD_IS_KM_HOME>/repository/conf/api-manager.xml` of previous IS as KM version to IS 5.11.0.

### Step 2 - Migrate the IS as KM Resources

1. Download the [WSO2 IS Connector]({{base_path}}/assets/attachments/administer/wso2is-extensions-1.4.2.zip).

2. Extract the distribution and copy the following JAR files to the `<IS_HOME>/repository/components/dropins` directory.

    - `wso2is.key.manager.core-1.2.10.jar`
    - `wso2is.notification.event.handlers_1.2.10.jar`

3. Add `keymanager-operations.war` from the extracted distribution to the `<IS_HOME>/repository/deployment/server/webapps` directory.

4. Follow the steps 1 to 8 in [WSO2 IS 5.11.0 migration guide](https://is.docs.wso2.com/en/5.11.0/setup/migrating-to-5110/) **except for step 6** to prepare your current IS as KM 5.10.0 for migration to IS 5.11.0.

### Step 3 - Migrate the IS as KM Components

1.  Make sure you backed up all the databases in API-M 3.0.0

3.  Download the identity component migration resources and unzip it in a local directory.

    Navigate to the [latest release tag](https://github.com/wso2-extensions/apim-identity-migration-resources/releases) and download the `wso2is-migration-x.x.x.zip` under **Assets**.

    Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`.

4.  Copy the `migration-resources` folder from the extracted folder to the `<IS_HOME>` directory.

5.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.10.0, as shown below.

    ``` java
    migrationEnable: "true"
    currentVersion: "5.9.0"
    migrateVersion: "5.11.0"
    ```
6. Remove the following 2 steps from  migration-config.yaml which is included under version: "5.10.0"

    ```
    - version: "5.10.0"
        migratorConfigs:
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

7. Remove the following 2 steps from  migration-config.yaml which is included under version: "5.11.0"

    ```
    -
        name: "EncryptionAdminFlowMigrator"
        order: 1
        parameters:
           currentEncryptionAlgorithm: "RSA/ECB/OAEPwithSHA1andMGF1Padding"
           migratedEncryptionAlgorithm: "AES/GCM/NoPadding"
           schema: "identity"
    -
        name: "EncryptionUserFlowMigrator"
        order: 2
        parameters:
           currentEncryptionAlgorithm: "RSA/ECB/OAEPwithSHA1andMGF1Padding"
           migratedEncryptionAlgorithm: "AES/GCM/NoPadding"
           schema: "identity"
    ```

8.  Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<IS_HOME>/repository/components/dropins` directory.

9.  Start WSO2 API Manager 4.1.0 as follows to carry out the complete Identity component migration.

    ```tab="Linux / Mac OS"
    sh api-manager.sh -Dmigrate -Dcomponent=identity
    ```

    ```tab="Windows"
    api-manager.bat -Dmigrate -Dcomponent=identity
    ```

    !!! warning

        Depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do **NOT** stop the server during the migration process and please wait until the migration process finish completely and server get started.

10. After you have successfully completed the migration, stop the server and remove the following files and folders.

    -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<IS_HOME>/repository/components/dropins` directory.

    -   Remove the migration-resources directory, which is in the `<IS_HOME>` directory.

    -   If you ran WSO2 IS as a Windows Service when doing the IS migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the `wso2server.bat` file.
        ```
        -Dmigrate -Dcomponent=identity        
        ```

              
## Step B - Upgrade API Manager 3.0.0 to 4.1.0

Follow the steps mentioned in [Upgrading API-M from 3.0.0 to 4.1.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-300-to-410/) to upgrade your API-M environment from 3.0.0 to 4.1.0.

!!! important

    -   When following guidelines under [Step 1 - Migrate the API Manager configurations]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-300-to-410/#step-1-migrate-the-api-manager-configurations), make sure to add
    the following to the `<API-M_HOME>/repository/conf/deployment.toml`. This is to configure your IS 5.11.0 as the **Resident Key Manager** of your API-M 4.1.0 deployment.
        ```
        [apim.key_manager]
        service_url = "https://<IS_5.11.0_HOST_NAME>:<PORT>/services/"
        type = "WSO2-IS"
        ```

        -  Do NOT copy any other Key Manager specific configurations coming from previous API-M version to the latest pointing to the IS instance.

    -   **SKIP** guidelines under [Step 3 - Migrate the Identity Components]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/300-to-410/upgrading-from-300-to-410/#step-3-migrate-the-identity-components)

        -   You have already done this in Step 3 of [Step A - Upgrade IS as Key Manager 5.9.0 to IS 5.11.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-590-to-is-5110/#upgrade-is-as-key-manager-590-to-is-5110).

    - After configuring WSO2 IS as the **Resident Key Manager** and before starting the API-M 4.1.0 server for the first time in **Step 6** under [Step 6 - Restart the WSO2 API-M 4.1.0 Server]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/300-to-410/upgrading-from-300-to-410/#step-6-restart-the-wso2-api-m-410-server), make sure you have already started WSO2 IS 5.11.0.

!!! info

    If you want to use the latest user store, please update both the `<IS_HOME>/repository/conf/deployment.toml` and `<API-M_HOME>/repository/conf/deployment.toml` as follows after the migration.
    ```
    [user_store]
    type = "database_unique_id"
    ``` 

