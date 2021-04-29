# Upgrading WSO2 IS as Key Manager to 5.11.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 2.0.0 to 4.0.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager** in the pre migrated setup.

!!! note
    -   You can follow the below information in either one of the following situations:
        -   You are currently using a WSO2 IS 5.2.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server as Key Manager 5.2.0 distribution.

-   [Step 1 - Upgrade IS as Key Manager 5.2.0 to IS 5.11.0](#step-1-upgrade-is-as-key-manager-520-to-is-5110)
-   [Step 2 - Upgrade API Manager 2.0.0 to 4.0.0](#step-2-upgrade-api-manager-200-to-400)

## Step 1 - Upgrade IS as Key Manager 5.2.0 to IS 5.11.0

- [Step A - Setup IS 5.11.0 as a Key Manager](#step-a-setup-is-5110-as-a-key-manager)
- [Step B - Migrate IS from 5.2.0 to 5.11.0](#step-b-migrate-is-from-520-to-5110)

### Step A - Setup IS 5.11.0 as a Key Manager

1. Download and install WSO2 IS 5.11.0 distribution from [here](https://wso2.com/identity-and-access-management/).
   If you have downloaded the archive, extract it. `<IS_HOME>` refers to the root folder of the extracted WSO2 IS.
2. Add following configurations in the `<IS_HOME>/repository/conf/deployment.toml` file.

    ??? info "deployment.toml"
        ```
        [[event_listener]]
        id = "token_revocation"
        type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
        name = "org.wso2.is.notification.ApimOauthEventInterceptor"
        order = 1

        [event_listener.properties]
        notification_endpoint = "https://localhost:9443/internal/data/v1/notify"
        username = "${admin.username}"
        password = "${admin.password}"
        'header.X-WSO2-KEY-MANAGER' = "WSO2IS"

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

3. Download the [WSO2 IS Connector]({{base_path}}/assets/attachments/administer/wso2is-extensions-1.2.10.zip).

4. Extract the distribution and copy the following JAR files to the `<IS_HOME>/repository/components/dropins` directory.

     - `wso2is.key.manager.core-1.2.10.jar`
     - `wso2is.notification.event.handlers_1.2.10.jar`

5. Add `keymanager-operations.war` from the extracted distribution to the `<IS_HOME>/repository/deployment/server/webapps` directory.

### Step B - Migrate IS from 5.2.0 to 5.11.0

1. Follow Step 2 and 3 under [Step 2 - Upgrade API Manager to 4.0.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-200-to-400/#step-2-upgrade-api-manager-to-400) to backup and upgrade the WSO2 API-M `WSO2AM_DB` from 2.0.0 to 4.0.0. This will be used as the `identity_db` in IS 5.11.0.

2. Folllow the guidelines in [WSO2 IS 5.11.0 migration guide](https://is.docs.wso2.com/en/5.11.0/setup/migrating-to-5110/) to migrate your current IS as KM 5.2.0 distribution to IS 5.11.0.

    !!! Important
        When following the instructions in [Migrating the configurations](https://is.docs.wso2.com/en/5.11.0/setup/migrating-preparing-for-migration/#migrating-the-configurations) section of IS 5.11.0 migration guide, make sure to
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

    !!! Important
        Follow [Step 10 Part (d) of IS 5.11 migration guide](https://is.docs.wso2.com/en/5.11.0/setup/migrating-to-5110/) only if you have **enabled Symmetric Key Encryption** in the previous IS as KM setup. If not, that step can be skipped.

    !!! Important
        Before executing the IS migration client according to [Step 11 of IS 5.10 migration guide](https://is.docs.wso2.com/en/5.11.0/setup/migrating-to-5110/), keep in mind to remove the following entries from `migration-config.yaml` in the migration-resources directory.
        ```        
        - version: "5.3.0"
            migratorConfigs:
            -
                name: "ChallengeQuestionDataMigrator"
                order: 6
                parameters:
                schema: "identity"

        - version: "5.5.0"
            migratorConfigs:
            -
                name: "EventPublisherMigrator"
                order: 11

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

    !!! warning
    
        Depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do **NOT** stop the server during the migration process and please wait until the migration process finish completely and server get started.

3. After you have successfully completed the migration, stop the server and remove the following files and folders.

    -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<IS_HOME>/repository/components/dropins` directory.

    -   Remove the migration-resources directory, which is in the `<IS_HOME>` directory.

    -   If you ran WSO2 IS as a Windows Service when doing the IS migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the `wso2server.bat` file.
        ```
        -Dmigrate -Dcomponent=identity        
        ```

              
## Step 2 - Upgrade API Manager 2.0.0 to 4.0.0

Follow the steps mentioned in [Upgrading API-M from 2.0.0 to 4.0.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-200-to-400/) to upgrade your API-M environment from 2.0.0 to 4.0.0.

!!! important

    -   When following guidelines under [Step 1 - Migrate the API Manager configurations]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-200-to-400/#step-1-migrate-the-api-manager-configurations), make sure to add
    the following to the `<API-M_HOME>/repository/conf/deployment.toml`. This is to configure your IS 5.11.0 as the **Resident Key Manager** of your API-M 4.0.0 deployment.
        ```
        [apim.key_manager]
        service_url = "https://<IS_5.11.0_HOST_NAME>:<PORT>/services/"
        type = "WSO2-IS"
        ```

        -  Do NOT copy anyother Key Manager specific configurations coming from previous API-M version to the latest pointing to the IS instance.

    -   When following guidelines under [Step 2 - Upgrade API Manager to 4.0.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-200-to-400/#step-2-upgrade-api-manager-to-400), make sure you **SKIP** the following
    steps.

        -   **Step 3** to upgrade the `WSO2AM_DB` from 2.0.0 to 4.0.0. You have already done this in Step 1 of [Step A - Setup IS 5.11.0 as a Key Manager]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-520-to-is-5110/#step-a-setup-is-5110-as-a-key-manager).
        -   **Step 5** to upgrade identity component in API-M from 5.2.0 to 5.11.0. You have already done this in Step 2 of [Step A - Setup IS 5.11.0 as a Key Manager]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-520-to-is-5110/#step-a-setup-is-5110-as-a-key-manager).

    - After configuring WSO2 IS as the **Resident Key Manager** and before starting the API-M 4.0.0 server for the first time in **Step 6** under [Step 2 - Upgrade API Manager to 4.0.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-200-to-400/#step-2-upgrade-api-manager-to-400), make sure you have already started WSO2 IS 5.11.0.

!!! info

    If you want to use the latest user store, please update both the `<IS_HOME>/repository/conf/deployment.toml` and `<API-M_HOME>/repository/conf/deployment.toml` as follows after the migration.
    ```
    [user_store]
    type = "database_unique_id"
    ```    
