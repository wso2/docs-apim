# Upgrading API Manager from 2.5.0 to 4.1.0

The following information describes how to upgrade your API Manager server **from API-M 2.5.0 to 4.1.0**.

## Prerequisites

1. Before you migrate, follow [Upgrading Guidelines]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-guidelines) to get an understanding on the migration process.

2. Download [WSO2 API Manager 4.1.0](http://wso2.com/api-management/) and unzip it in the <API-M_4.1.0_HOME> directory.

3. Update API-M 4.1.0 to the latest U2 update level.

4. If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager, first follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.11.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-km-560-to-is-5110).

Follow the instructions below to upgrade your WSO2 API Manager server **from WSO2 API-M 2.5.0 to 4.1.0**.

## Steps to migrate to WSO2 API-M 4.1.0

- [Step 1 - Upgrade WSO2 API Manager to 2.6.0](#step-1---upgrade-wso2-api-manager-to-260)
- [Step 2 - Upgrade WSO2 API Manager to 4.1.0](#step-2---upgrade-wso2-api-manager-to-410)

### Step 1 - Upgrade WSO2 API Manager to 2.6.0

!!! note
It is not possible to directly upgrade from WSO2 API Manager 2.5.0 to 4.0.0.

[Upgrade API-M 2.5.0 to WSO2 API-M 2.6.0](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) as explained in the WSO2 API-M 2.6.0 documentation.

### Step 2 - Upgrade WSO2 API Manager to 4.0.0

After you have successfully migrated WSO2 API-M 2.5.0 to 2.6.0, upgrade from API-M 2.6.0 to API-M 4.1.0. For more information, see [Upgrading API Manager from 2.6.0 to 4.1.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/260-to-410/upgrading-from-260-to-410/).

This concludes the upgrade process.

!!! tip
    The migration client that you use in this guide automatically migrates your tenants, workflows, external user stores, etc. to the upgraded environment. Therefore, there is no need to migrate them manually.

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

