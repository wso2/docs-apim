# Upgrading Process

This section contains the complete upgrading process related to the WSO2 API Manager.
Go through the guidelines given below before attempting to upgrade the production environment.

!!! note
    To upgrade **from a version older than 1.8.0** , follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

1.  If you already have a [WSO2 subscription](https://wso2.com/subscription), reach out to our support team through 
your [support account](https://support.wso2.com/jira/secure/Dashboard.jspa).

2.  Always migrate to the [latest version](https://wso2.com/api-management/) 
    since latest fixes and new features are available in the newest version. If you have a particular 
    requirement to migrate to an intermediate version, contact 
    [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa).

!!! note
    Migrating the production environment requires additional hardware/VM resources since both the old 
    environment and the new environment will be running until all the traffic is routed to the new 
    environment.    
    
3. If you have customizations in your setup, check if they are supported out of the box in the latest 
version.
    - If your customizations are already available in the latest version, you can remove the 
    customization after migration. You can contact [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa)
     for assistance.
    - If any custom requirement is not available in the latest version, 
    migrate the customization to support the latest product version. Note the following points.
      
        !!! info "Migrating the customizations that are not available in the latest version"
            - First update the dependency version of the 
            dependant WSO2 components and re-build the customized component.
            - As a practice, WSO2 does not make API changes in minor releases of the dependency jars. However, if 
            there are API changes, please update the custom code and re-build.
                        
4.  List down the functional and nonfunctional use cases in your deployment and create test cases for them. 
**NOTE:** This step is crucial to verify that the migrated environment works as expected.     

6.  Identify the configuration migrations required for the new setup. Refer [Configuration Catalog](../../Reference/ConfigCatalog.md) for more information.

    !!! note
        For more information about this release, see [About this Release](../../GettingStarted/about-this-release.md).
        
6.  Prepare a test setup of the upgrading version with customizations and necessary config changes, and 
test your functional and nonfunctional requirements.

7.  Before starting the upgrade, run the [token and session 
cleanup scripts](../../Administer/ProductAdministration/removing-unused-tokens-from-the-database.md)
 in the databases of the environment, if you are not doing regular cleanups.

    !!! tip
        From 2.6.0 onwards, WSO2 API Manager is configured by default to trigger token clean up during token generation, token refreshing and token revocation. For more details, see [Configuring API Manager for token cleanup](../../Administer/ProductAdministration/removing-unused-tokens-from-the-database.md) . Therefore, when the state of the token ( `TOKEN_STATE)` is changed during any of the latter mentioned processes for tokens that were ACTIVE before the migration process and/or for tokens that will be generated after the migration process, by default, such tokens will be removed from the `IDN_OAUTH2_ACCESS_TOKEN` table and stored in an audit table. However, the old tokens which were already inactive, revoked, or expired before the migration will not be cleaned by the same token cleanup process. Therefore, alternatively, after the migration, you could follow step 3 in the [Using stored procedures for token cleanup](../../Administer/ProductAdministration/removing-unused-tokens-from-the-database.md) section and use the given token clean up script to manually clean up the old inactive, revoked, and expired tokens from the `IDN_OAUTH2_ACCESS_TOKEN` table.

8.  Start the migration from the lowest environment such as dev and continue up to the highest before the production 
such as pre-prod. Run the test cases in the migrated environments to confirm that your functional and nonfunctional 
requirements are met in the migrated environment.

9. Prior to the production migration, run a pilot migration on your pre-prod environment. It would be 
ideal if the pre-prod environment is similar to the production environment.
    +   If possible, restore a database dump of the production environment to the pre-prod environment and 
    perform the pilot migration.
    +   If the production database dump cannot be used, at least ensure that you have a sufficient amount 
    of data in the database to mimic the production environment.
    
10. When you follow the above steps, you can get a rough estimate of the time for the final 
production update and you can allocate time slots as per the above analysis. WSO2 recommends performing the 
migration while the system is under minimum traffic. 

Once you are satisfied with the above steps, proceed with production migration. After the migration is complete, 
verify it using the following steps.
    
+  Monitor the system health (CPU, memory usage etc).
+  Monitor the WSO2 logs for errors.

**NOTE:** If you see any problems in the migrated system, revert the traffic back to the previous setup and 
investigate the problem.
