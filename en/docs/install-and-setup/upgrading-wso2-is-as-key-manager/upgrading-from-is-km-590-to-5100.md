# Upgrading WSO2 IS as Key Manager to 5.10.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 3.0.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager**.

!!! tip
    You can download the **pre-packaged WSO2 Identity Server 5.10.0, which is also known as Identity Server as the Key Manager 5.10.0** from [here](https://wso2.com/api-management/install/key-manager/). Make sure you are using the latest [WUM updated](https://docs.wso2.com/display/updates/Getting+Started) pack.

!!! note
    -   You can use the following steps in either one of the following situations:
        -   You are currently using a WSO2 IS 5.9.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server 5.9.0 distribution.

    -   If you wish to upgrade your APIM environment from **API-M 3.0.0 to 3.1.0** , which is using the **internal** WSO2 Identity Server (**WSO2 IS**) **capabilities** , follow the instructions in [Upgrading API-M from 3.0.0 to 3.1.0](../upgrading-wso2-api-manager/upgrading-from-300-to-310.md).


Upgrade WSO2 API-M **from WSO2 API-M 3.0.0 to 3.1.0** when using **WSO2 IS** as the **Key Manager:** as mentioned in below.

Follow the instructions mentioned in [Upgrading API-M from 3.0.0 to 3.1.0](../upgrading-wso2-api-manager/upgrading-from-300-to-310.md), 
but **instead of step 2 - (5)**, which explains how to migrate the WSO2 API-M Identity components, 
follow the WSO2 Identity Server 5.10.0 documentation to migrate the WSO2 Identity Server (WSO2 IS) from version 5.9.0 to 5.10.0.
[Migrate the WSO2 Identity Server (WSO2 IS) from version 5.9.0 to 5.10.0](https://is.docs.wso2.com/en/5.10.0/setup/migrating-to-5100/)

Before execute the IS migration client, follow the below steps.

    1. Remove the following entries from migration-config.yaml in the migration-resources directory.
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
                ```
    2. Update <IS-KM-HOME>/repository/conf/deployment.toml file as follows, to point to the previous user store.
    
        ```
        [user_store]
        type = "database"
        ```

        !!! note
            Please note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and please wait until the migration process finish completely and server get started.

        !!! note
            Please note that if you want to use the latest user store, please update the <API-M_3.1.0_HOME>/repository/conf/deployment.toml as follows after the identity migration,

            ```
            [user_store]
            type = "database_unique_id"
            ```