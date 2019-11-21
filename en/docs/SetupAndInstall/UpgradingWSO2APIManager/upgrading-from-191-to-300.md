# Upgrading API Manager to 3.0.0

The following information describes how to upgrade your API Manager server **from APIM 1.8.0/1.9.0/1.9.1 to 3.0.0** .

!!! note
To upgrade **from a version older than 1.8.0** , follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

!!! tip
Before you begin

This release is a WUM-only release. This means that there are no manual patches. Any further fixes or latest updates for this release can be updated through the WSO2 Update Manager (WUM).

-   **If you are upgrading to this version, in order to use this version in your production environment** , use the WSO2 Update Manager and get the latest available updates for WSO2 API Manager 3.0.0. For more information on how to do this, see [Updating WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Getting+Started+with+WUM) .

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

!!! tip
**Tip 1** : The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! tip
**Tip 2** : From 2.6.0 onwards, WSO2 API Manager is configured by default to trigger token clean up during token generation, token refreshing and token revocation. For more details, see [Configuring API Manager for token cleanup](https://docs.wso2.com/display/AM260/Removing+Unused+Tokens+from+the+Database#RemovingUnusedTokensfromtheDatabase-ConfiguringAPIManagerfortokencleanup) . Therefore, when the state of the token ( `TOKEN_STATE)` is changed during any of the latter mentioned processes for tokens that were ACTIVE before the migration process and/or for tokens that will be generated after the migration process, by default, such tokens will be removed from the `IDN_OAUTH2_ACCESS_TOKEN` table and stored in an audit table. However, the old tokens which were already inactive, revoked, or expired before the migration will not be cleaned by the same token cleanup process. Therefore, alternatively, after the migration, you could follow step 3 in the [Using stored procedures for token cleanup](https://docs.wso2.com/display/AM260/Removing+Unused+Tokens+from+the+Database#RemovingUnusedTokensfromtheDatabase-Usingstoredproceduresfortokencleanup) section and use the given token clean up script to manually clean up the old inactive, revoked, and expired tokens from the `IDN_OAUTH2_ACCESS_TOKEN` table.

!!! tip
**Tip 3** : If you are using an SVN based deployment synchronizer, start with a clean SVN repository and point the new deployment nodes to the new SVN repository. In addition, you need to remove any existing `.svn` directories in the new deployment's `<API-M_2.6.0_HOME>/repository/deployment/server/synapse-configs/default` directory and the `<API-M_2.6.0_HOME>/repository/tenants/<tenant-id>/synapse-configs/default` directory before starting the servers. For more details, see [Configuring Deployment Synchronization](https://docs.wso2.com/display/CLUSTER44x/Configuring+SVN-Based+Deployment+Synchronizer) .



