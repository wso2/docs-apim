# Upgrading WSO2 IS as Key Manager to 5.11.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from API-M 1.8.0/1.9.0/1.9.1 to 4.0.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager** in the pre migrated setup.

!!! note
    -   You can follow the below information in either one of the following situations:
        -   You are currently using a WSO2 IS 5.0.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server as Key Manager 5.0.0 distribution.

-   [Step 1 - Upgrade WSO2 IS as Key Manager 5.0.0 to 5.2.0](#step-1-upgrade-5.0.0-to-5.2.0)
-   [Step 2 - Upgrade WSO2 IS as Key Manager 5.2.0 to WSO2 5.11.0](#step2-upgrade-5.2.0-to-5.11.0)

## Step 1 - Upgrade WSO2 IS as Key Manager 5.0.0 to 5.2.0

!!! note
    It is not possible to directly upgrade from WSO2 IS as Key Manager 5.0.0 to WSO2 IS 5.11.0 along with WSO2 API Manager 1.8.0/1.9.0/1.9.1 to 4.0.0.

[Upgrade your current WSO2 IS as KM version (5.0.0) to 5.2.0](https://docs.wso2.com/display/AM200/Upgrading+from+the+Previous+Release) as expained in the WSO2 API-M 2.0.0 documentation.

## Step 2 - Upgrade WSO2 IS as Key Manager 5.2.0 to WSO2 IS 5.11.0

After you have successfully migrated your current IS as KM version to 5.2.0 and WSO2 API-M version to 2.0.0, upgrade IS as KM 5.2.0 to IS 5.11.0 and API-M 2.0.0 to API-M 4.0.0. For more information, see [Upgrading WSO2 IS as Key Manager to 5.11.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-520-to-is-5110/).

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! note
    Prior to WSO2 API Manager 4.0.0, the distributed deployment comprised of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in APIM 4.0.0 only has three profiles, namely Gateway, Traffic Manager, and Default.
    All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Default profile.
    For more details on the WSO2 API-M 4.0.0 distributed deployment, see [WSO2 API Manager distributed documentation]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m).