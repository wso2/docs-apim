# Upgrading WSO2 IS as Key Manager to 5.10.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 2.5.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager**.

!!! tip
    You can download the **pre-packaged WSO2 Identity Server 5.10.0, which is also known as Identity Server as the Key Manager 5.10.0** from [here](https://wso2.com/api-management/install/key-manager/). Make sure you are using the latest [WUM updated](https://docs.wso2.com/display/updates/Getting+Started) pack.

!!! note
    -   You can use the following steps in either one of the following situations:
        -   You are currently using a WSO2 IS 5.6.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server 5.6.0 distribution.

    -   If you wish to upgrade your APIM environment from **API-M 2.5.0 to 3.1.0**, which is using the **internal** WSO2 Identity Server (**WSO2 IS**) **capabilities**, follow the instructions in [Upgrading API-M from 2.5.0 to 3.1.0](../upgrading-wso2-api-manager/upgrading-from-250-to-310.md).

Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 2.5.0 to 2.6.0** when using **WSO2 IS** as the **Key Manager:**

1.  Migrate the WSO2 Identity Server (WSO2 IS) from version 5.6.0 to 5.10.0.
    [Migrate the WSO2 Identity Server (WSO2 IS) from version 5.6.0 to 5.10.0](https://is.docs.wso2.com/en/5.10.0/setup/migrating-to-5100/) as described in the WSO2 Identity Server 5.10.0 documentation.

2.  Migrate WSO2 API-M from 2.5.0 to 3.1.0.
    Follow the instructions mentioned in [Upgrading API-M from 2.5.0 to 3.1.0](../upgrading-wso2-api-manager/upgrading-from-250-to-310.md), but **skip the step 2 - (5)**, which explains how to migrate the WSO2 API-M Identity components.
