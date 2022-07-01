WSO2 API Manager Server 4.1.0 brings a range of new features and major improvements. The following aspects have changed in 4.1.0 compared to the previous WSO2 API-M versions.

!!! Attention "If you are using WSO2 Identity Server (WSO2 IS) as a Key Manager"
   
    Follow the instructions in [Upgrading WSO2 IS as the Key Manager to 5.11.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-5100-to-is-5110).
  
This page provides details about the behavioral changes from WSO2 API Manager Server 3.2.0 to 4.1.0

### Changes in WSO2 API Manager 4.1.0

- From API-M 4.0.0 onwards, API Manager offers analytics as a cloud service.

    !!! Important "If you are using Analytics"
        As the on-premise analytics data cannot be migrated to the Cloud, you need to maintain the old analytics server and keep the UI running for as long as you need that data (e.g., 3 months) after migrating to the new version of analytics in WSO2 API-M 4.1.0.

- From API-M 4.0.0 onwards, synapse artifacts have been removed from the file system and are managed via database. At server startup the synapse configs are loaded to the memory from the Traffic Manager.

- When Migrating a Kubernetes environment to a newer API Manager version it is recommended to do the data migration in a single container and then do the deployment.  - If you have done any customizations to the **default sequences** that ship with the product, you may merge the customizations. Also note that the fault messages have been changed from XML to JSON from API-M 4.0.0 onwards.

- Prior to WSO2 API Manager 4.0.0, the distributed deployment consisted of five main product profiles, namely Publisher, Developer Portal, Gateway, Key Manager, and Traffic Manager. However, the new architecture in API-M 4.0.0 only has three profiles, namely **Gateway**, **Traffic Manager**, and **Control Plane**.

- All the data is persisted in databases **from WSO2 API-M 4.0.0 onwards**. Therefore, it is recommended to execute the migration client in the Control Plane profile.

- For more details on the WSO2 API-M 4.1.0 distributed deployment, see [WSO2 API Manager distributed documentation]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m).

- From **API-M 4.0.0**,  server startup script has renamed as <code>api-manager.sh</code> (for Linux) and <code>api-manager.bat</code> (for Windows)

- From **API_M 4.0.0 onwards** error responses in API calls has changed from XML to JSON format.

    !!! Attention "If you have developed client applications to handle XML error responses"
        If you have developed client applications to handle XML error responses you have to change the client applications to handle the JSON responses.
        As an example for a 404 error response previously it was as follows
        
          <am:fault xmlns:am="http://wso2.org/apimanager">
          <am:code>404</am:code>
          <am:type>Status report</am:type>
          <am:message>Not Found</am:message>
          <am:description>The requested resource is not available.</am:description>
          </am:fault>
        
        In API-M 4.0.0 onwards the above resopnse will changed as follows.
          
          
          {
          "code":"404",
          "type":"Status report",
          "message":"Not Found",
          "description":"The requested resource is not available."
          }
    
    
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

### REST API versions 
If you consume APIs which are exposed from the API Publisher, Developer Portal, Admin Portal and Gateway directly through the UIs or an external REST client like cURL, please note the latest version of them as below.  

  -   Publisher API (v3) 
  -   Admin Portal (v3)
  -   Developer Portal (v2)
  -   Gateway (v2)

### Mediation policies migration

With 4.1.0 release, WSO2 API manager has realigned its previous API level mediation policies feature to a more sophisticated policy feature which provides support for not only mediation policies, but a vast number of different use cases. Instead of API level policy allocation, the new feature supports policies at the operation level for regular gateway (synapse based) and at resource level for the Choreo Connect gateway. With this support, previous mediation policy support via Admin REST APIs is no longer available, instead  publisher REST API `operation-policies` support the same functionality. Publisher UI mediation policies which were displayed under runtime configuration has been removed and it is moved to a separate tab called `policies`. Therefore, you will be able to see the mediation policies in previous apim versions under policies UI.

Major functionalities of the new policies feature are listed below.

1. A new UI to manage common policies which can be shared across all the APIs.
2. An interactive UI in the API configurations to allocate the policies.
3. Increased granularity for the policy allocation which is spread until operation level.
4. Ability to apply multiple policies for a single operation and has an interactive UI to manage the policy execution order.
5. Ability to parameterize the policies with dynamic values and reuse the same policy across different operations with different configurations.

With these new features, we have removed the API level mediation policies and if you need to apply a policy with the same configurations across the API, you can do so by selecting the `Apply to all resources` option.

Previous mediation related resources from the Publisher and Admin REST API have been removed and you can achieve the same functionality via the operation-policies resource in the Publisher REST API.

APICTL Project structure has been changed and Sequences directory has been replaced with a new Policies directory. This policies directory contains the policies applied to the API at the operation level. Each policy has a specification file (yaml or json) which has all the meta information about the policy and a policy definition file (j2 file for regular gateway and gotmpl file for choreo connect) which contains the logic behind the policy. Policy allocation and policy order of each operation is recorded in the api.yaml file and if the policy is parameterized, values of each parameterized attribute are defined in this section.

For more information see, [OPA policy support]({{base_path}}/design/api-security/opa-validation/overview/#attaching-opa-policy)

### GraphQL subscription 
If the GraphQL subscription operations are available on your existing GraphQL APIs in 4.0.0,  API-M 4.1.0 is supported for subscription opertaion under websocket flow.

For more information see, [GraphQL subscription]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console/#invoke-a-graphql-subscription-operation)

