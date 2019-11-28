# Upgrading WSO2 IS as Key Manager to 5.9.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 2.6.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager**.

!!! tip
    You can download the **pre-packaged WSO2 Identity Server 5.9.0, which is also known as Identity Server as the Key Manager 5.9.0** from [here](https://wso2.com/api-management/install/key-manager/).

!!! note
    -   You can use the following steps in either one of the following situations:
        -   You are currently using a WSO2 IS 5.7.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server 5.7.0 distribution.

    -   If you wish to upgrade your APIM environment from **API-M 2.6.0 to 3.0.0** , which is using the **internal** WSO2 Identity Server (**WSO2 IS**) **capabilities** , follow the instructions in [Upgrading API-M from 2.6.0 to 3.0.0](../UpgradingWSO2APIManager/upgrading-from-260-to-300.md).

Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 2.6.0 to 3.0.0** when using **WSO2 IS** as the **Key Manager:**

1.  Migrate the WSO2 Identity Server (WSO2 IS) from version 5.7.0 to 5.9.0.
    [Migrate the WSO2 Identity Server (WSO2 IS) from version 5.7.0 to 5.9.0](https://is.docs.wso2.com/en/5.9.0/setup/migrating-to-590/) as described in the WSO2 Identity Server 5.9.0 documentation.

2.  Migrate WSO2 API-M from 2.6.0 to 3.0.0.
    Follow the instructions mentioned in [Upgrading API-M from 2.6.0 to 3.0.0](../UpgradingWSO2APIManager/upgrading-from-260-to-300.md), but **skip the step 2 - (5)**, which explains how to migrate the WSO2 API-M Identity components.
