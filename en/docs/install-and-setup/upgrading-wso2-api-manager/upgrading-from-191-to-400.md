# Upgrading API Manager from 1.8.0/1.9.0/1.9.1 to 3.2.0

The following information describes how to upgrade your API Manager server **from APIM 1.8.0/1.9.0/1.9.1 to 3.2.0**.

!!! note
    Before you follow this section, see [Upgrading Process]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-process) for more information.

Follow the instructions below to upgrade your WSO2 API Manager server **from APIM 1.8.0/1.9.0/1.9.1 to 3.2.0**.

!!! Attention
    If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, first follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.10.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-500-to-5100).

-   [Step 1 - Upgrade WSO2 API Manager to 2.0.0](#step-1-upgrade-wso2-api-manager-to-200)
-   [Step 2 - Upgrade WSO2 API Manager to 3.2.0](#step-2-upgrade-wso2-api-manager-to-320)

### Step 1 - Upgrade WSO2 API Manager to 2.0.0

!!! note
    It is not possible to directly upgrade from WSO2 API Manager 1.8.0/1.9.0/1.9.1 to 3.2.0.

[Upgrade your current WSO2 API-M version (1.8.0/1.9.0/1.9.1) to WSO2 API-M 2.0.0](https://docs.wso2.com/display/AM200/Upgrading+from+the+Previous+Release) as expained in the WSO2 API-M 2.0.0 documentation.

### Step 2 - Upgrade WSO2 API Manager to 3.2.0

After you have successfully migrated your current WSO2 API-M version to 2.0.0, upgrade from API-M 2.0.0 to API-M 3.2.0. For more information, see [Upgrading API Manager from 2.0.0 to 3.2.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-200-to-320).

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! note
    If you are using a migrated API and wants to consume it via an application which supports JWT authentication (default type in API-M 3.2.0), you need to republish the API. Without republishing the API, JWT authentication doesn't work as it looks for a local entry which will get populated while publishing.

    You can consume the migrated API via an OAuth2 application without an issue.
