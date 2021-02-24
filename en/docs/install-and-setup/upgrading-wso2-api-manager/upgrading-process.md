# Upgrading Process

This section contains the complete upgrading process related to the WSO2 API Manager.
Go through the guidelines given below before attempting to upgrade the production environment.

!!! note
    To upgrade **from a version older than 1.8.0**, follow the instructions in the document that was released immediately after your current release and upgrade incrementally.

!!! info
    For more information about this release, see [About this Release]({{base_path}}/getting-started/about-this-release).


1.  If you already have a [WSO2 subscription](https://wso2.com/subscription), reach out to our support team through 
your [support account](https://support.wso2.com/jira/secure/Dashboard.jspa).

2.  Always migrate to the [latest version](https://wso2.com/api-management/) 
    as the latest fixes and new features are available in the latest version. If you have a particular requirement to migrate to an intermediate version, contact 
    [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa).

    !!! note
        Migrating the production environment requires additional hardware/VM resources because both the old environment and the new environment will be running until all the traffic is routed to the new environment.    
    
3. If you have customizations in your setup, check if they are supported out-of-the-box in the latest 
version.
    - If your customizations are already available in the latest version, you can remove the 
    customization after migration. You can contact [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa)
     for assistance.
    - If any custom requirement is not available in the latest version, 
    migrate the customization to support the latest product version. Note the following points.
      
        !!! info "Migrating the customizations that are not available in the latest version"
            - Initially, update the dependency version of the 
            dependant WSO2 components and re-build the customized component.
            - As a practice, WSO2 does not make API changes in minor releases of the dependency JARs. However, if 
            there are API changes, please update the custom code and re-build.
                        
4.  List down the functional and non-functional use cases in your deployment and create test cases for them. 

    !!! Note
        This step is crucial to verify that the migrated environment works as expected.     

5.  Identify the configuration migrations required for the new setup. 

     For more information on the new config model introduced, see the [Configuration Catalog]({{base_path}}/reference/config-catalog).
        
6.  Prepare a test setup of the upgrading version with customizations and necessary config changes, and 
test your functional and non-functional requirements.


7.  Before start the upgrading process, Please make sure that you have read the whole documentation specific to the version upgarde and have a clear understanding of the upgrading process.

8. If you have expired certificates in client-trustore, follow [Renewing a CA-Signed Certificate in a Keystore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/renewing-a-ca-signed-certificate-in-a-keystore/#renewing-a-ca-signed-certificate-in-a-keystore)

9.  Start the migration from the lowest environment (e.g., dev) and continue up to the highest before the production 
(e.g., pre-prod). Run the test cases in the migrated environments to confirm that your functional and non-functional requirements are met in the migrated environment.

10. Before you carry out the production migration, run a pilot migration on your pre-prod environment. 

    It will be ideal if the pre-prod environment is similar to the production environment.

    -  If possible, restore a database dump of the production environment to the pre-prod environment and perform the pilot migration.

    -  If the production database dump cannot be used, at least ensure that you have a sufficient amount of data in the database to mimic the production environment.
    
11. When you follow the above instructions, you can get a rough estimate of the time for the final production update, and you can allocate time slots based on the above analysis. 

    WSO2 recommends that you perform the migration while the system is under minimum traffic. 

After you have completed the above instructions and are satisfied with the outcome, proceed with the production migration process. After the migration is complete, verify the migration process using the following instructions.
    
-  Monitor the system health (CPU, memory usage etc.).
-  Monitor the WSO2 logs for errors.
