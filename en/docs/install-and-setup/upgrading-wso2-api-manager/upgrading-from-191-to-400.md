# Upgrading API Manager from 1.8.0/1.9.0/1.9.1 to 4.0.0

!!! warning
    **The contents on this page are currently under review!**

Before you begin:

-   See [Upgrading Process]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-process) for more information.

-   If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, first follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.10.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-500-to-is-5110).

The following information describes how to upgrade your API Manager server **from APIM 1.8.0/1.9.0/1.9.1 to 4.0.0**.

-   [Step 1 - Upgrade WSO2 API Manager to 2.0.0](#step-1-upgrade-wso2-api-manager-to-200)
-   [Step 2 - Upgrade WSO2 API Manager to 4.0.0](#step-2-upgrade-wso2-api-manager-to-320)

### Step 1 - Upgrade WSO2 API Manager to 2.0.0

!!! note
    It is not possible to directly upgrade from WSO2 API Manager 1.8.0/1.9.0/1.9.1 to 4.0.0.

[Upgrade your current WSO2 API-M version (1.8.0/1.9.0/1.9.1) to WSO2 API-M 2.0.0](https://docs.wso2.com/display/AM200/Upgrading+from+the+Previous+Release) as expained in the WSO2 API-M 2.0.0 documentation.

### Step 2 - Upgrade WSO2 API Manager to 4.0.0

After you have successfully migrated your current WSO2 API-M version to 2.0.0, upgrade from API-M 2.0.0 to API-M 4.0.0. For more information, see [Upgrading API Manager from 2.0.0 to 4.0.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-200-to-400).

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

!!! note
    If you are using a migrated API and wants to consume it via an application which supports JWT authentication (default type in API-M 4.0.0), you need to republish the API. Without republishing the API, JWT authentication doesn't work as it looks for a local entry which will get populated while publishing.

    You can consume the migrated API via an OAuth2 application without an issue.
        
!!! note
    Prior to WSO2 API Manager 4.0.0, the distributed deployment comprised of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in APIM 4.0.0 only has three profiles, namely Gateway, Traffic Manager, and Default.
    All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Default profile.
    For more details on the WSO2 API-M 4.0.0 distributed deployment, see [WSO2 API Manager distributed documentation]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m).    

!!! important

    **From WSO2 API_M 4.0.0 onwards** error responses in API calls has changed from XML to JSON format.
    If you have developed client applications to handle XML error responses you give have to change the client applications to handle the JSON responses.
    As an example for a 404 error response previously it was as follows
       
       ```
        <am:fault xmlns:am="http://wso2.org/apimanager">
           <am:code>404</am:code>
           <am:type>Status report</am:type>
           <am:message>Not Found</am:message>
           <am:description>The requested resource is not available.</am:description>
        </am:fault>
        ```
     
    In API-M 4.0.0 onwards the above resopnse will changed as follows.
    
        ```
        {
           "code":"404",
           "type":"Status report",
           "message":"Not Found",
           "description":"The requested resource is not available."
        }
        ```
     
!!! important
        
    In API-M 4.0.0 following fault sequences were changed to send JSON responses as mentioned above. If you have done any custom changes to any of the following sequences previously,
    you have to add those custom changes manually to these changed files. 
    
    -   _auth_failure_handler_.xml
    -   _backend_failure_handler_.xml
    -   _block_api_handler_.xml
    -   _graphql_failure_handler_.xml
    -   _threat_fault_.xml
    -   _throttle_out_handler_.xml
    -   _token_fault_.xml
    -   fault.xml
    -   main.xml
