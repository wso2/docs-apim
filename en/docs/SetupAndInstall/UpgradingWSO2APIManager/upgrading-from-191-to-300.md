# Upgrading API Manager from 1.9.1 to 3.0.0

The following information describes how to upgrade your API Manager server **from APIM 1.8.0/1.9.0/1.9.1 to 3.0.0** .

!!! note
To upgrade **from a version older than 1.8.0** , follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

!!! tip
    Before you begin

    - This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

        -   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.0.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Getting+Started+with+WUM).

    - Before starting the upgrade, run the [token and session cleanup scripts](../../Administer/ProductAdministration/removing-unused-tokens-from-the-database.md) in the databases of the environment, if you are not doing regular cleanups.

Follow the instructions below to upgrade your WSO2 API Manager server **from APIM 1.8.0/1.9.0/1.9.1 to 2.6.0** .

!!! note
If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, follow the instructions in [Upgrading from the Previous Release when WSO2 IS is the Key Manager](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release+when+WSO2+IS+is+the+Key+Manager#8910) .
### Step 1 - Upgrade WSO2 API Manager to 2.0.0

!!! note
It is not possible to directly upgrade from WSO2 API Manager 1.8.0/1.9.0/1.9.1 to 2.6.0.
[Upgrade your current WSO2 API-M version (1.8.0/1.9.0/1.9.1) to WSO2 API-M 2.0.0](https://docs.wso2.com/display/AM200/Upgrading+from+the+Previous+Release) as expained in the WSO2 API-M 2.0.0 documentation.

### Step 2 - Upgrade WSO2 API Manager to 2.6.0

After you have successfully migrated your current WSO2 API-M version to 2.0.0, upgrade from API-M 2.0.0 to API-M 2.6.0. For more information, see [Upgrading from 2.5.0 to 2.6.0 - Step 1.2 - Optionally, migrate the configurations for WSO2 API-M Analytics](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .

This concludes the upgrade process.



