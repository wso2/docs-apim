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


7.  Before start the upgrading process, Please make sure that you have read the whole documentation specific to the version upgrade and have a clear understanding of the upgrading process.

8. If you have expired certificates in client-trustore, follow [Renewing a CA-Signed Certificate in a Keystore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/renewing-a-ca-signed-certificate-in-a-keystore/#renewing-a-ca-signed-certificate-in-a-keystore)

9.  Start the migration from the lowest environment (e.g., dev) and continue up to the highest before the production 
(e.g., pre-prod). Run the test cases in the migrated environments to confirm that your functional and non-functional requirements are met in the migrated environment.

10. When attempting to migrate a distributed setup, you need to do the data migration for the Control Plane profile only. You can do the migration using the following command:

    ```bash
    sh api-manager.sh -Dprofile=control-plane -Dmigrate -DmigrateFromVersion=<product-version-number> -DmigratedVersion=4.1.0 -DrunPreMigration
    ```

11. Disable versioning in the registry configuration when migrating IS as a Key Manager from versions older than IS 5.9.0.

    If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 4.1.0.

    Therefore, if registry versioning was enabled in older versions of WSO2 API-M, it is **required** to run registry version disabling scripts against **the database that is used by the registry**. For example, see step 5 under [Migrating the API Manager configurations]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/260-to-410/upgrading-from-260-to-410/#step-1-migrate-the-api-manager-configurations) for the associated scripts.

12. If you are using PostgreSQL, during the migration, "uuid-ossp" extension is created in the database. In order to create this extension, the database user should have the 'Superuser' permission. If the user is not already a superuser, assign the permission before starting the migration.

    ```
    ALTER USER <user> WITH SUPERUSER;
    ```

13. When migrating a Kubernetes environment to a newer API Manager version, it is recommended to do the data migration in a separate VM, a local machine, or a single container. Once the data migration is complete, you can simply move the migrated databases into the containerized deployment in Kubernetes. 

    To implement this kind of scenario you have to follow the first four steps in the migration documentation (for example [the first four steps when migrating API-M 3.2.0 to API-M 4.1.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/320-to-410/upgrading-from-320-to-410/) in a separate VM/container/local machine and then move the databases to a containerized setup before doing [step 5, which is to re-index the API-M artifacts]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/320-to-410/upgrading-from-320-to-410/#step-5-re-index-the-api-manager-artifacts). Make sure to use a new mount for the solr and remove the older solr mount from the deployment.

14. Before you carry out the production migration, run a pilot migration on your pre-prod environment. 

    It will be ideal if the pre-prod environment is similar to the production environment.

    -  If possible, restore a database dump of the production environment to the pre-prod environment and perform the pilot migration.

    -  If the production database dump cannot be used, at least ensure that you have a sufficient amount of data in the database to mimic the production environment.
    
15. When you follow the above instructions, you can get a rough estimate of the time for the final production update, and you can allocate time slots based on the above analysis. 

    WSO2 recommends that you perform the migration while the system is under minimum traffic. 

After you have completed the above instructions and are satisfied with the outcome, proceed with the production migration process. After the migration is complete, verify the migration process using the following instructions.
    
-  Monitor the system health (CPU, memory usage etc.).
-  Monitor the WSO2 logs for errors.

!!! Note
    Out-of-the-box support to generate an Opaque (Reference) access token via the Developer Portal has been removed from WSO2 API Manager version 3.2.0 onwards. Hence, now the Application Developers can create new applications that only generate JWT type access tokens. However, the applications that are migrated from older versions would still have the support to generate Opaque (Reference) access tokens.

    Similar to previous versions, application developers get the OAuth2 bearer tokens, while generating tokens via the Developer Portal. The only difference is the format of the token as the JWT type token is self-contained.

    Opaque (Reference) tokens have become obsolete. All major IDPs have stopped or are in the process of retiring the support for Opaque (Reference) tokens. These tokens only work on systems where the resource server has access to or is co-located with the authorization server. As more and more systems become distributed and hybrid in nature, the use of reference tokens will eventually cease and also the organizations have full control of what information they include in the JWT. 
 
    Additionally, the use of JWT tokens decouples the Gateway component completely from the Key Manager component allowing for more freedom for innovation.

    When migrating from previous versions of WSO2 API Manager, if you are still willing to continue the use of Opaque (Reference) tokens, you will need to maintain a Gateway to Key Manager mapping where when the Gateways are scaled, the Key Manager should also be scaled. 

    The profiles supported in WSO2 API Manager 4.0.0 onwards for a distributed setup are only the Gateway Profile, Control Plane Profile, and the Traffic Manager Profile where the Key Manager component is embedded within the Control Plane. However, if your requirement is to continue using Opaque (Reference) tokens, you will need to maintain a separate Key Manager node or a Cluster to be able to scale it with the Gateway nodes. For instructions on how to configure a separate Key Manager profile along with the Control Plane, Gateway and Traffic Manager profiles, see [Deploying WSO2 API Manager in a Distributed Setup with Key Manager Separated]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-km-separated).
