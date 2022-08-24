WSO2 API Manager Server 4.0.0 brings a range of new features and major improvements. The following aspects have changed in 4.0.0 compared to the previous WSO2 API-M versions.

This page provides details about the behavioral changes in WSO2 API Manager Server 4.0.0 compared to previous versions.

### Changes in WSO2 API Manager

#### API Manager 4.0.0

- Prior to WSO2 API Manager 4.0.0, the distributed deployment consisted of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in API-M 4.0.0 only has three profiles, namely **Gateway**, **Traffic Manager**, and **Control Plane**.

- From API-M 4.0.0 onwards, API Manager offers analytics as a cloud service.

    !!! Important "If you are using Analytics"
        As the on-premise analytics data cannot be migrated to the Cloud, you need to maintain the old analytics server and keep the UI running for as long as you need that data (e.g. 3 months) after migrating to the new version of analytics in WSO2 API-M 4.0.0.

- From **API-M 4.0.0**,  server startup script has renamed as <code>api-manager.sh</code> (for Linux) and <code>api-manager.bat</code> (for Windows)

- From API-M 4.0.0 onwards, synapse artifacts have been removed from the file system and are managed via database. At server startup the synapse configs are loaded to the memory from the Traffic Manager.

- All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Control Plane profile.

- From API-M 4.0.0, the kid claim has been removed from the backend JWT.
  If there are customizations that require validating the kid value of the backend JWT, please customize the JWT generator to include kid value.

- From API-M 4.0.0 onwards Other '_overview' type documents override the API description, if you had created such documents in your lower environments, please note that those documents will not be displayed in document listing page. You can edit those documents the same way you edit the API description.

  - From **WSO2 API_M 4.0.0 onwards** error responses in API calls has changed from XML to JSON format.

    ??? Attention "If you have developed client applications to handle XML error responses"
        If you have developed client applications to handle XML error responses you have to change the client applications to handle the JSON responses.
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
            **From WSO2 API_M 4.0.0 onwards**, following fault sequences were changed to send JSON responses as mentioned above. If you have done any custom changes to any of the following sequences previously,
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

#### API Manager 3.2.0

- Out-of-the-box support for Third Party Key Managers was introduced from 3.2.0 onwards
  API-M 3.2 is prepacked with an inbuilt resident Key Manager and has the inbuilt capability of configuring WSO2 Identity Server (WSO2 IS) as a third-party Key Manager using WSO2 IS Connector.
  API-M is capable of supporting other authorization servers like Keycloak, Okta, Auth0, PingFederate as a Key Manager.

- API Key Validation calls which were sent over the network will now be made against an in-memory store.

- From 3.2.0 onwards, previous Jaggery based Admin portal UI is replaced with a new ReactJS based application.

- Prior to 3.2.0, for simple approval and rejection tasks, having a separate BPS engine was mandatory. From API-M 3.2.0 this overhead is removed by introducing an Approval Workflow Executor with an inbuilt workflow to perform simple approvals and rejections without the BPS engine.

- Support for tag-wise grouping is removed in API-M 3.2.0 and the users are recommended to use [API category based grouping](https://apim.docs.wso2.com/en/latest/reference/customize-product/customizations/customizing-the-developer-portal/customize-api-listing/api-category-based-grouping/) instead.

- Out-of-the-box support to generate an Opaque (Reference) access token via the Developer Portal has been removed from WSO2 API Manager version 3.2.0 onwards. Hence, now the Application Developers can create new applications that only generate JWT type access tokens.

    ??? Note "What will happen to migrated applications?"
        However, the applications that are migrated from older versions would still have the support to generate Opaque (Reference) access tokens.

        Similar to previous versions, application developers get the OAuth2 bearer tokens, while generating tokens via the Developer Portal. The only difference is the format of the token as the JWT type token is self-contained.
      
        Opaque (Reference) tokens have become obsolete. All major IDPs have stopped or are in the process of retiring the support for Opaque (Reference) tokens. These tokens only work on systems where the resource server has access to or is co-located with the authorization server. As more and more systems become distributed and hybrid in nature, the use of reference tokens will eventually cease and also the organizations have full control of what information they include in the JWT. 
      
        Additionally, the use of JWT tokens decouples the Gateway component completely from the Key Manager component allowing for more freedom for innovation.
      
        When migrating from previous versions of WSO2 API Manager, if you are still willing to continue the use of Opaque (Reference) tokens, you will need to maintain a Gateway to Key Manager mapping where when the Gateways are scaled, the Key Manager should also be scaled. 
      
        The profiles supported in WSO2 API Manager 4.0.0 onwards for a distributed setup are only the Gateway Profile, Control Plane Profile, and the Traffic Manager Profile where the Key Manager component is embedded within the Control Plane. However, if your requirement is to continue using Opaque (Reference) tokens, you will need to maintain a separate Key Manager node or a Cluster to be able to scale it with the Gateway nodes. For instructions on how to configure a separate Key Manager profile along with the Control Plane, Gateway and Traffic Manager profiles, see [Deploying WSO2 API Manager in a Distributed Setup with Key Manager Separated]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-km-separated).


#### API Manager 3.1.0

- Due to security reasons, API-M from 3.1.0 onwards supports only pdf, doc and txt type files as file typed API documents.

#### API Manager 3.0.0

- Until WSO2 API Manager 2.6.0, users had to update multiple configuration files to configure the product. This overhead is removed with the new configuration model because now users only have to update a single file (deployment.toml).

    For more information on the configurations in the new configuration model, see the [Configuration Catalog]({{base_path}}/reference/config-catalog).
    For more information on the mapping between WSO2 API Manager's old configuration files and the new `deployment.toml` file, see [Understanding the New Configuration Model]({{base_path}}/reference/understanding-the-new-configuration-model).

- From 3.0.0 onwards, previous Jaggery based UIs for Publisher and Developer portals are replaced with new ReactJS based applications. 

    !!! note
        From API-M 3.0.0, Store Portal has been renamed as Developer Portal

- In previous API-M versions there used to be 4 Resource Level Security Schemes named `None`, `Application`, `Application User` and `Any`. From 3.0.0 onwards this has been reduced to 2 levels `None` and `Application and Application User`. If fine-grained security is required it is recommended to use [OAuth Scopes](https://apim.docs.wso2.com/en/4.0.0/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#applying-multiple-scopes-per-resource) instead.

- From 3.0.0 onwards, it is possible to enforce multiple authentication schemes for an API at same time.


