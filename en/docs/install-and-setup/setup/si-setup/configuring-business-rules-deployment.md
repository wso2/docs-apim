## Configuring Business Rules Deployment

The Business Rules Manager derives business rules from the rule templates within template groups. Each rule template has a UUID(Universally Unique Identifier) for the purpose of uniquely identifying it.
When you configure a Streaming Integrator node to use a specific rule template, Siddhi applications deployed in the node are derived from the business rules created from that rule template.

To configure a Streaming Integrator node to use specific rules templates, follow the steps below:

1. Open the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file.

2. In the `wso2.business.rules.manager` -> `deployment_configs:` section, provide the URL(s) of  the Streaming Integrator node(s) in which you want to deploy Siddhi applications. The required format is `<HOST_NAME>:<PORT>`.
    
    ```yaml
     deployment_configs:
        - <NODE1_HOST_NAME>:<NODE1_PORT>
          <NODE2_HOST_NAME>:<NODE2_PORT>
    ``` 
     
    e.g.,
     ```yaml
      deployment_configs:
          - localhost:9090
            10.100.4.140:9090
     ```
    
3. List down the UUIDs of required rule templates under each node. As a result, Siddhi applications are created out of the business rules that are derived from these templates for the required nodes.

    ```yaml    
     deployment_configs:
         - <NODE1_HOST_NAME>:<NODE1_PORT>:
             - ruleTemplate1_UUID
             - ruleTemplate2_UUID
             - ruleTemplate3_UUID
    ``` 
    e.g., 
    
    ```yaml
     deployment_configs:
         - localhost:9090:
            - sweet-production-kpi-analysis
            - stock-exchange-input
            - stock-exchange-output
    ```
   !!! tip
       If required, you can enter a specific rule template under multiple nodes as shown below. Before doing so, ensure the you have selected **Many** for the **Instance Count** field of the template. For more information, see [Creating a Business Rules Template]({{base_path}}/use-cases/streaming-tutorials/creating-business-rules-templates/creating-business-rules-templates/#creating-a-business-rules-template).<br/><br/>
       ```yaml
        deployment_configs:
            - <NODE1_HOST_NAME>:<NODE1_PORT>:
                - ruleTemplate1_UUID
                - ruleTemplate2_UUID
                - ruleTemplate3_UUID
              <NODE2_HOST_NAME>:<NODE2_PORT>:
                - ruleTemplate1_UUID
                - ruleTemplate3_UUID
              <NODE3_HOST_NAME>:<NODE3_PORT>:
                - ruleTemplate2_UUID
                - ruleTemplate3_UUID
                - ruleTemplate4_UUID
       ```<br/><br/>
       e.g.,
       ```yaml
        deployment_configs:
            - localhost:9090:
                - sweet-production-kpi-analysis
                - stock-exchange-input
                - stock-exchange-output
              10.100.40.169:9090:
                - identifying-continuous-production-decrease
                - sweet-production-kpi-analysis
       ```<br/><br/>
       In the above example, the `sweet-production-kpi-analysis` UUID is configured under two Streaming Integrator nodes. Therefore, if you derive a business rule from the `sweet-production-kpi-analysis` template, the Siddhi applications created from it are deployed in both the nodes.
       
4. Specify the username and password that are common for all the Streaming Integrator nodes.

    ```yaml
     username: admin
     password: admin
    ```

The complete deployment configuration for Business Rules looks as follows.

```yaml
    wso2.business.rules.manager:
        datasource: BUSINESS_RULES_DB
        deployment_configs:
            - localhost:9090:
                - stock-data-analysis
                - stock-exchange-input
                - stock-exchange-output
                - identifying-continuous-production-decrease
                - sweet-production-kpi-analysis
        username: admin
        password: admin
```