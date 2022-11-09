# Upgrading WSO2 API Manager

This document walks you through the process of upgrading WSO2 API Manager. 

## Why migrate?

There are multiple reasons why you would want to upgrade the WSO2 product to the latest version. These reasons include but are not limited to the following.  

- The current product version you are using is reaching its end of life. To see if this is the case, view the [support matrix documentation](https://wso2.com/products/support-matrix/). 
- You want to leverage the new features of the latest version of the product.
- The version of the product you have does not have certain security and bug fixes that you require.

## What has changed

Over the course of its lifetime, WSO2 API Manager has changed significantly and some of the features you were using in an older version may not work the same way. This section summarizes the key changes that have taken place in each version of WSO2 APi Manager.

??? note "API Manager 4.1.0"

    ##### Mediation policies migration

    With the 4.1.0 release, WSO2 API Manager has realigned its previous API-level mediation policies feature to a more sophisticated policy feature that provides support for not only mediation policies, but a vast number of different use cases. 
    
    Instead of API-level policy allocation, the new feature supports policies at the operation level for the regular Gateway (Synapse-based) and at resource level for the Choreo Connect Gateway. With this support, previous mediation policy support via Admin REST APIs is no longer available. Instead, Publisher REST API `operation policies` support the same functionality. Publisher UI mediation policies, which were displayed under the runtime configuration, have been removed, and it is moved to a separate tab called `policies`. Therefore, you will be able to see the mediation policies in previous API-M versions under the policies UI.

    The major functionalities of the new policies feature are listed below.

    1. A new UI to manage common policies which can be shared across all the APIs.
    2. An interactive UI in the API configurations to allocate the policies.
    3. Increased granularity for the policy allocation that is spread until the operation level.
    4. Ability to apply multiple policies for a single operation and has an interactive UI to manage the policy execution order.
    5. Ability to parameterize the policies with dynamic values and reuse the same policy across different operations with different configurations.

    With these new features, WSO2 has removed the API level mediation policies. If you need to apply a policy with the same configurations across the API, you can do so by selecting the `Apply to all resources` option.

    Previous mediation related resources from the Publisher and Admin REST API have been removed. However, you can achieve the same functionality via the operation-policies resource in the Publisher REST API.

    Mediation policies that you have attached to API types other than REST (i.e., SOAP, GraphQL, etc.) will no longer be manageable after you have migrated to WSO2 API-M 4.1.0. With the API Policies feature, the policy support was only provided for REST APIs. However, extending the same support for other API types is still on the roadmap, and WSO2 hopes to send an update to WSO2 API-M 4.1.0 to add this support.

    !!! note "For API types excluding REST APIs"
        For APIs like SOAP, GraphQL, etc., even though the functionality is still intact (runtime is not affected), the design time is affected as you can no longer manage policies using the UI, or the file system. To further elaborate on this, if you had policies attached to an API and you've migrated to 4.1.0, those policies are still attached to the said API, but they are immutable.

    APICTL project structure has been changed and the Sequences directory has been replaced with a new Policies directory. This Policies directory contains the policies applied to the API at the operation level. Each policy has a specification file (YAML or JSON), which has all the meta information about the policy and a policy definition file (j2 file for regular Gateway and gotmpl file for Choreo Connect), which contains the logic behind the policy. Policy allocation and policy order of each operation is recorded in the api.yaml file and if the policy is parameterized, values of each parameterized attribute are defined in this section.

    For more information, see [OPA policy support]({{base_path}}/design/api-security/opa-validation/overview/#attaching-opa-policy).

    ##### GraphQL subscription
    If the GraphQL subscription operations are available on your existing GraphQL APIs in WSO2 API-M 4.0.0,  WSO2 API-M 4.1.0 is supported for the subscription operation under the WebSocket flow.

    For more information see, [GraphQL subscription]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console/#invoke-a-graphql-subscription-operation).

    For more details on the API-M 4.1.0 release, see the [About this Release page]({{base_path}}/get-started/about-this-release/).

??? note "API Manager 4.0.0"

    - Prior to WSO2 API Manager 4.0.0, the distributed deployment consisted of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in API-M 4.0.0 only has three profiles, namely **Gateway**, **Traffic Manager**, and **Control Plane**.

    - From API-M 4.0.0 onwards, API Manager offers analytics as a cloud service.

        !!! Important "If you are using analytics"
            As the on-premise analytics data cannot be migrated to the Cloud, you need to maintain the old analytics server and keep the UI running for as long as you need that data (e.g., 3 months) after migrating to the new version of analytics in WSO2 API-M 4.0.0.

    - From **WSO2 API-M 4.0.0**, the server startup script is renamed as <code>api-manager.sh</code> (for Linux/Mac OS) and <code>api-manager.bat</code> (for Windows).

    - From WSO2 API-M 4.0.0 onwards, Synapse artifacts have been removed from the file system and are managed via the database. At server startup, the Synapse configurations are loaded to the memory from the Traffic Manager.

    - Token and Revoke endpoints have been removed from the Gateway artifacts from WSO2 API-M 4.0.0 onwards. Use endpoints in the Control Plane instead.

        ```tab="3.2.0"
        https://localhost:8243/token
        https://localhost:8243/revoke
        ```

        ```tab="4.0.0"
        https://localhost:9443/oauth2/token
        https://localhost:9443/oauth2/revoke
        ```

    - All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Control Plane profile.

    - From WSO2 API-M 4.0.0, the kid claim has been removed from the backend JWT.
  
        If there are customizations that require validating the kid value of the backend JWT, you need to customize the JWT generator to include the kid value.

    - From WSO2 API-M 4.0.0 onwards, Other '_overview' type documents override the API description. If you have created such documents in your lower environments, note that those documents will not be displayed in the document listing page. You can edit those documents the same way you edit the API description.

    - From **WSO2 API_M 4.0.0 onwards**, error responses in API calls have changed from XML to JSON format.

        ??? Attention "If you have developed client applications to handle XML error responses"
            If you have developed client applications to handle XML error responses you have to change the client applications to handle the JSON responses.
            
            For example, for a 404 error response, previously it was as follows:
    
            ```xml
            <am:fault xmlns:am="http://wso2.org/apimanager">
            <am:code>404</am:code>
            <am:type>Status report</am:type>
            <am:message>Not Found</am:message>
            <am:description>The requested resource is not available.</am:description>
            </am:fault>
            ```
    
            In API-M 4.0.0 onwards the above response is as follows:
            
            ```json
            {
            "code":"404",
            "type":"Status report",
            "message":"Not Found",
            "description":"The requested resource is not available."
            }
            ```
    
            !!! important
                **From WSO2 API_M 4.0.0 onwards**, the following fault sequences were changed to send JSON responses as mentioned above. If you have previously made any custom changes to any of the following sequences, you have to add those custom changes manually to the following changed files.
    
                -   _auth_failure_handler_.xml
                -   _backend_failure_handler_.xml
                -   _block_api_handler_.xml
                -   _graphql_failure_handler_.xml
                -   _threat_fault_.xml
                -   _throttle_out_handler_.xml
                -   _token_fault_.xml
                -   fault.xml
                -   main.xml 

??? note "API Manager 3.2.0"

    - Out-of-the-box support for third-party Key Managers was introduced from WSO2 API-M 3.2.0 onwards. WSO2 API-M 3.2.0 is pre-packed with an inbuilt resident Key Manager and has the inbuilt capability of configuring the WSO2 Identity Server (WSO2 IS) as a third-party Key Manager using WSO2 IS Connector.
    
      API-M is capable of supporting other authorization servers like Keycloak, Okta, Auth0, and PingFederate as a Key Manager.

    - API Key Validation calls, which were sent over the network, will now be made against an in-memory store.

    - From WSO2 API-M 3.2.0 onwards, backend JWT generation happens at the Gateway. 
      If you have implemented a custom JWT generator extending the AbstractJWTGenerator, then that custom JAR file should be added to the **Gateway Node** not the Key Manager Node. 

    - From WSO2 API-M 3.2.0 onwards, the previous Jaggery-based Admin Portal UI is replaced with a new ReactJS-based application.

    - Prior to WSO2 API-M 3.2.0, it was mandatory to have a separate BPS engine for simple approval and rejection tasks. From WSO2 API-M 3.2.0, this overhead is removed by introducing an Approval Workflow Executor with an inbuilt workflow to perform simple approvals and rejections without the BPS engine.

    - Support for tag-wise grouping is removed in WSO2 API-M 3.2.0 and the users are recommended to use [API category based grouping](https://apim.docs.wso2.com/en/latest/reference/customize-product/customizations/customizing-the-developer-portal/customize-api-listing/api-category-based-grouping/) instead.

    - From API-M 3.2.0 onwards, support for implicit grant type has been removed.

    - Out-of-the-box support to generate an Opaque (Reference) access token via the Developer Portal has been removed from WSO2 API Manager version 3.2.0 onwards. Now the Application Developers can create new applications that only generate JWT type access tokens.

        ??? Note "What will happen to migrated applications?"
            However, the applications that are migrated from older versions would still have the support to generate Opaque (Reference) access tokens.

            Similar to previous versions, Application Developers get the OAuth2 bearer tokens, while generating tokens via the Developer Portal. The only difference is the format of the token as the JWT type token is self-contained.
      
            Opaque (Reference) tokens have become obsolete. All major IDPs have stopped or are in the process of retiring the support for Opaque (Reference) tokens. These tokens only work on systems where the resource server has access to or is co-located with the authorization server. As more and more systems become distributed and hybrid in nature, the use of reference tokens will eventually cease, and the organizations will have full control of what information they include in the JWT. 
      
            Additionally, the use of JWT tokens decouples the Gateway component completely from the Key Manager component allowing for more freedom for innovation.
      
            When migrating from previous versions of WSO2 API Manager, if you are still willing to continue using Opaque (Reference) tokens, you need to maintain a Gateway to Key Manager mapping where when the Gateways are scaled, the Key Manager should be scaled as well.
      
            The profiles supported in WSO2 API Manager 4.0.0 onwards for a distributed setup are only the Gateway Profile, Control Plane Profile, and the Traffic Manager Profile, where the Key Manager component is embedded within the Control Plane. However, if your requirement is to continue using Opaque (Reference) tokens, you will need to maintain a separate Key Manager node or a Cluster to be able to scale it with the Gateway nodes. For instructions on how to configure a separate Key Manager profile along with the Control Plane, Gateway, and Traffic Manager profiles, see [Deploying WSO2 API Manager in a Distributed Setup with Key Manager Separated]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-km-separated).


??? note "API Manager 3.1.0"

    - WSO2 API-M from 3.1.0 onwards supports only pdf, doc and txt type files as file-typed API documents by default. If you wish to support other document types, you need to add the following configuration in to the `deployment.toml` file.

        ```tab="Format"
        [apim.publisher]
        supported_document_types = "<DOCUMENT TYPES LIST>"
        ``` 

        ```tab="Example"
        [apim.publisher]
        supported_document_types = "pdf, txt, zip, json, yaml"
        ``` 

    - From WSO2 API-M 3.1.0 onwards, tag-wise grouping has been deprecated. You need to use [API category based grouping](https://apim.docs.wso2.com/en/latest/reference/customize-product/customizations/customizing-the-developer-portal/customize-api-listing/api-category-based-grouping/) instead.

    - New user store managers with inbuilt unique ID support were introduced in WSO2 IS 5.10.0 and named with the UniqueID prefix. User store managers that do not have a UniqueID as part of the user store manager name are only available for backward compatibility purposes and can only be used if you are migrating from a previous version of WSO2 Identity Server.
  
    For more information, see the [Migration of user store managers with unique ID support](https://is.docs.wso2.com/en/5.11.0/setup/migrating-what-has-changed/#migration-of-user-store-managers-with-unique-id-support).

??? note "API Manager 3.0.0"

    - If you have used OIDC or SAML2 for SSO in the portal login in an older APIM version, you have to re-configure them as per the [documentation to configure WSO2 IS as an external IDP using OIDC]({{base_path}}/install-and-setup/setup/sso/configuring-identity-server-as-external-idp-using-oidc/).

    - Until WSO2 API Manager 2.6.0, users had to update multiple configuration files to configure the product. This overhead is removed with the new configuration model because now users only have to update a single file (`deployment.toml`).

      For more information on the configurations in the new configuration model, see the [Configuration Catalog]({{base_path}}/reference/config-catalog).
      For more information on the mapping between WSO2 API Manager's old configuration files and the new `deployment.toml` file, see [Understanding the New Configuration Model]({{base_path}}/reference/understanding-the-new-configuration-model).

    - From 3.0.0 onwards, the previous Jaggery-based UIs for the Publisher and Developer Portals are replaced with new ReactJS-based applications.

        !!! note
            From WSO2 API-M 3.0.0, the Store Portal has been renamed as the Developer Portal.

    - From WSO2 API-M 3.0.0 onwards, WSO2 API Manager has been upgraded to **log4j2** (from log4j). You will notice that there is a `log4j2.properties` file in the `<API-M_4.0.0_HOME>/repository/conf/` directory instead of the `log4j.properties` file. Follow [Upgrading to Log4j2]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-to-log4j2) to migrate your existing `log4j.properties` file to the `log4j2.properties` file.

    - In previous API-M versions, there used to be 4 Resource Level Security Schemes named `None`, `Application`, `Application User` and `Any`. From WSO2 API-M 3.0.0 onwards, this has been reduced to 2 levels `None` and `Application and Application User`. If fine-grained security is required it is recommended to use [OAuth Scopes](https://apim.docs.wso2.com/en/4.0.0/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#fine-grained-access-control-with-oauth-scopes) instead.

    - From 3.0.0 onwards, it is possible to enforce multiple authentication schemes for an API at the same time.

## Upgrading guidelines

This section contains a general set of guidelines that you can follow when upgrading WSO2 API Manager.

Go through the guidelines given below before attempting to upgrade the production environment.

!!! important
    If you require a zero downtime migration, you must contact WSO2 Support. WSO2 does not recommend proceeding with a zero downtime migration without WSO2 Support. You can also get the migration resources from WSO2 Support in order to upgrade the product with minimal issues and difficulties. You can [contact WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa) for assistance.

- If you already have a [WSO2 subscription](https://wso2.com/subscription), reach out to our support team through your [support account](https://support.wso2.com/jira/secure/Dashboard.jspa).

- Always migrate to the [latest version](https://wso2.com/api-management/) as the latest fixes and new features are available in the latest version. If you already have a [WSO2 subscription](https://wso2.com/subscription), you can use the Update Management Tool (UMT) to get any fixes or latest updates for this release. If you have a particular requirement to migrate to an intermediate version, contact [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa).

    !!! note
        Migrating the production environment requires additional hardware/VM resources because both the old environment and the new environment will be running until all the traffic is routed to the new environment.

- Understand how the target version differs from the source version and its impact on your setup. For example, some of the product profiles that you currently use may not be available with the latest version. In that case, you may have to make architectural changes along with the upgrade. 

- Before starting the upgrading process, make sure that you have read the whole documentation specific to the version upgrade and have a clear understanding of the upgrading process.

- Before you start the upgrade process, check the [compatibility matrix]({{base_path}}/install-and-setup/setup/reference/product-compatibility/) of the target version to get information on operating systems, JDKs and DBMSs that the target version has been tested with. If the operating system, JDK, or the DBMS that you use is not listed in the documentation, reach out to WSO2 Support and get further assistance.

- Make sure to take backups of the existing databases used by the current WSO2 API Manager server. This backup is necessary in case the migration causes any issues in the existing database.

    !!! important
        Check on the [Tested DBMS]({{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-dbmss) for API-M 4.1.0. Only those versions will be supported in migration as well. 
        Therefore, if you are currently on an older database version, you need to first migrate your database to the supported version before proceeding with the migration.

- If you have customizations in your setup, check if they are supported out-of-the-box in the latest version.
    - If your customizations are already available in the latest version, you can remove the customization after migration. You can contact [WSO2 Support](https://support.wso2.com/jira/secure/Dashboard.jspa) for assistance.
    - If any custom requirement is not available in the latest version, migrate the customization to support the latest product version. Note the following points.
      
    !!! info "Migrating the customizations that are not available in the latest version"
        - Initially, update the dependency version of the dependant WSO2 components and re-build the customized component.
        - As a practice, WSO2 does not make API changes in minor releases of the dependency JARs. However, if there are API changes, please update the custom code and re-build.
                        
- List down the functional and non-functional use cases in your deployment and create test cases for them. 

    !!! Note
        This step is crucial to verify that the migrated environment works as expected.     

- Identify the configuration migrations required for the new setup. 

     For more information on the new config model introduced, see the [Configuration Catalog]({{base_path}}/reference/config-catalog).
        
- Prepare a test setup of the upgrading version with customizations and necessary config changes, and 
test your functional and non-functional requirements.
    
- Before start the upgrading process, Please make sure that you have read the whole documentation specific to the version upgrade and have a clear understanding of the upgrading process.

- If you have expired certificates in client-trustore, follow [Renewing a CA-Signed Certificate in a Keystore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/renewing-a-ca-signed-certificate-in-a-keystore/#renewing-a-ca-signed-certificate-in-a-keystore)

- If you have many APIs, there could be a high load on the database during the migration. Hence, increase the database pool size during migration. Refer to [Tuning JDBC Pool Configurations]({{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/jdbc_tuning/) for more details.
   
- Start the migration from the lowest environment (e.g., dev) and continue up to the highest before the production (e.g., pre-prod). Run the test cases in the migrated environments to confirm that your functional and non-functional requirements are met in the migrated environment.

- Before you carry out the production migration, run a pilot migration on your pre-prod environment. 

    It will be ideal if the pre-prod environment is similar to the production environment.

    -  If possible, restore a database dump of the production environment to the pre-prod environment and perform the pilot migration.

    -  If the production database dump cannot be used, at least ensure that you have a sufficient amount of data in the database to mimic the production environment.
    
- When you follow the above instructions, you can get a rough estimate of the time for the final production update, and you can allocate time slots based on the above analysis. WSO2 recommends that you perform the migration while the system is under minimum traffic. 

- When attempting to migrate a distributed setup, you need to do the data migration for the Control Plane profile only. 

- Disable versioning in the registry configuration when migrating IS as a Key Manager from versions older than IS 5.9.0.

    If there are frequently updating registry properties, having the versioning enabled for registry resources in the registry can lead to unnecessary growth in the registry related tables in the database. To avoid this, versioning has been disabled by default in API Manager 4.1.0.
    
    Therefore, if registry versioning was enabled in older versions of WSO2 API-M, it is **required** to run registry version disabling scripts against **the database that is used by the registry**. For example, see step 5 under [Migrating the API Manager configurations]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/260-to-410/upgrading-from-260-to-410/#step-1-migrate-the-api-manager-configurations) for the associated scripts.

- If you are using PostgreSQL, during the migration, "uuid-ossp" extension is created in the database. In order to create this extension, the database user should have the 'Superuser' permission. If the user is not already a superuser, assign the permission before starting the migration.

- When migrating a Kubernetes environment to a newer API Manager version, it is recommended to do the data migration in a separate VM, a local machine, or a single container. Once the data migration is complete, you can simply move the migrated databases into the containerized deployment in Kubernetes. 

    To implement this kind of scenario you have to follow the first four steps in the migration documentation (for example [the first four steps when migrating API-M 3.2.0 to API-M 4.1.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/320-to-410/upgrading-from-320-to-410/) in a separate VM/container/local machine and then move the databases to a containerized setup before doing [step 5, which is to re-index the API-M artifacts]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/320-to-410/upgrading-from-320-to-410/#step-5-re-index-the-api-manager-artifacts). Make sure to use a new mount for the solr and remove the older solr mount from the deployment.

After you have completed the above instructions and are satisfied with the outcome, proceed with the production migration process. After the migration is complete, verify the migration process using the following instructions.
    
-  Monitor the system health (CPU, memory usage, etc.).
-  Monitor the WSO2 logs for errors.

## Prerequisites

1. Review what has changed in this release.

2. Before you upgrade the product, follow the upgrading guidelines mentioned in this document to get an understanding of the migration process.

3. Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and extract it.

4. [Update API-M 4.1.0]({{base_path}}/administer/updating-wso2-api-manager/) to the latest U2 update level.

## Upgrade process

Create a [support ticket](https://support.wso2.com/jira/secure/Dashboard.jspa) with migration requirements and one of our support engineers get in touch with you.