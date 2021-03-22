# Upgrading WSO2 IS as Key Manager to 5.11.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 1.10.0 to 4.0.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager** in the pre migrated setup.

!!! note
    -   You can follow the below information in either one of the following situations:
        -   You are currently using a WSO2 IS 5.1.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server as Key Manager 5.1.0 distribution.

-   [Step 1 - Upgrade WSO2 IS as Key Manager 5.1.0 to 5.7.0](#step-1-upgrade-5.1.0-to-5.7.0)
-   [Step 2 - Upgrade WSO2 IS as Key Manager 5.7.0 to WSO2 5.11.0](#step2-upgrade-5.7.0-to-5.11.0)

## Step 1 - Upgrade WSO2 IS as Key Manager 5.1.0 to 5.7.0

!!! note
    It is not possible to directly upgrade from WSO2 IS as Key Manager 5.1.0 to WSO2 IS 5.11.0 along with WSO2 API Manager 1.10.0 to 4.0.0.

[Upgrade your current WSO2 IS as KM version (5.1.0) to 5.7.0](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#110) as expained in the WSO2 API-M 2.6.0 documentation.

## Step 2 - Upgrade WSO2 IS as Key Manager 5.7.0 to WSO2 IS 5.11.0

After you have successfully migrated your current IS as KM version to 5.7.0 and WSO2 API-M version to 2.6.0, upgrade IS as KM 5.7.0 to IS 5.11.0 and API-M 2.6.0 to API-M 4.0.0. For more information, see [Upgrading WSO2 IS as Key Manager to 5.11.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-570-to-is-5110/).

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.
