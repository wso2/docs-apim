# Upgrading WSO2 IS as Key Manager to 5.10.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 2.1.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager**.

!!! tip
    - Download the **pre-packaged WSO2 Identity Server 5.10.0, which is also known as Identity Server as the Key Manager 5.10.0**.
    
         Navigate to the [WSO2 API Manager page](https://wso2.com/api-management/), click **DOWNLOAD** to expand the installation options; thereafter, scroll down past the installation options to navigate to the **OTHER RESOURCES** section, and click **Identity Server as a Key Manager Pack**. 
    
    - Make sure you are using the latest [WUM updated](https://docs.wso2.com/display/updates/Getting+Started) pack.

!!! note
    -   You can use the following steps in either one of the following situations:
        -   You are currently using a WSO2 IS 5.3.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server 5.3.0 distribution.

    -   Prior to upgrade the **WSO2 Identity Server (WSO2 IS) AS Key Manager**, you have to follow the steps mentioned in [Upgrading API-M from 2.1.0 to 3.1.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-210-to-310) to upgrade your APIM environment from API-M 2.1.0 to 3.1.0.

Before executing the IS migration client, keep in mind to follow the below steps.

1. Remove the following entries from migration-config.yaml in the migration-resources directory.
                
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
               

2. Update <IS-KM-HOME>/repository/conf/deployment.toml file as follows, to point to the previous user store.

        [user_store]
        type = "database"


Now, follow the WSO2 Identity Server 5.10.0 documentation [Migrate the WSO2 Identity Server (WSO2 IS) from version 5.3.0 to 5.10.0](https://is.docs.wso2.com/en/5.10.0/setup/migrating-to-5100/) to migrate the WSO2 Identity Server (WSO2 IS) from version 5.3.0 to 5.10.0.

!!! note
    
    Please note that depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do not stop the server during the migration process and please wait until the migration process finish completely and server get started.

!!! note
    
    Please note that if you want to use the latest user store, please update the <API-M_3.1.0_HOME>/repository/conf/deployment.toml as follows after the identity migration,
        ```
        [user_store]
        type = "database_unique_id"
        ```