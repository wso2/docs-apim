# Maintaining Separate Production and Sandbox Gateways

With WSO2 API Manager, you can maintain a production and a sandbox endpoint for a given API. The production endpoint is the actual location of the API, whereas the sandbox endpoint points to its testing/pre-production environment.

When you publish an API using the API Publisher, it gets deployed on the API Gateway. By default, there's a single Gateway instance (deployed either externally or embedded within the publisher), but you can also set up multiple Gateways:

-   [Single Gateway to handle both production and sandbox requests](#MaintainingSeparateProductionandSandboxGateways-SingleGatewaytohandlebothproductionandsandboxrequests)
-   [Multiple Gateways to handle production and sandbox requests separately](#MaintainingSeparateProductionandSandboxGateways-MultipleGatewaystohandleproductionandsandboxrequestsseparately)

#### Single Gateway to handle both production and sandbox requests

This is the default scenario. Because this Gateway instance handles both production and sandbox token traffic, it is called a hybrid API Gateway. When an API request comes to the API Gateway, it checks whether the requesting token is of type PRODUCTION or SANDBOX and forwards the request to the appropriate endpoint. The diagram below depicts this scenario.

![](attachments/103333581/103333584.png)
#### Multiple Gateways to handle production and sandbox requests separately

Having a single Gateway instance to pass through both types of requests can negatively impact the performance of the production server. To avoid this, you can set up separate API Gateways. The production API Gateway handles requests that are made using PRODUCTION type tokens and the sandbox API Gateway handles requests that are made using SANDBOX type tokens.

The diagram below depicts this using two Gateways:

![](attachments/103333581/103333583.png)
In either of the two approaches, if an API Gateway receives an invalid token, it returns an error to the requesting client saying that the token is invalid.

You configure production and sandbox Gateways using the `<Environments>` element in the `<API-M_HOME>/repository/conf/api-manager.xml` file in API Publisher nodes, as shown in the following example:

``` java
    <Environments>
        <Environment type="production">
            <Name>Production</Name>
            <ServerURL>https://localhost:9445/services/</ServerURL>
            <Username>admin</Username>
            <Password>admin</Password>
            <GatewayEndpoint>http://localhost:8282,https://localhost:8245</GatewayEndpoint>
        </Environment>   
        <Environment type="sandbox">
            <Name>Sandbox</Name>
            <ServerURL>https://localhost:9448/services/</ServerURL>
            <Username>admin</Username>
            <Password>admin</Password>        
            <GatewayEndpoint>http://localhost:8285,https://localhost:8248</GatewayEndpoint>
        </Environment>
    </Environments>
```

The `<ServerURL>` parameter should have the value of the environment instance. For information about the `<GatewayEndpoint>` , see [Working with Endpoints](https://docs.wso2.com/display/AM260/Working+with+Endpoints) .

The `type` attribute of the `<Environment>` element can take the following values:

-   **Production** : A production type Gateway
-   **Sandbox** : A sandbox type Gateway
-   **Hybrid** : The Gateway handles both types of tokens

If you work with Gateways in different geographical locations, configuring multiple environments using the `<APIGateway>` element in the `<API-M_HOME>/repository/conf/api-manager.xml` file is recommended. The diagram below depicts a sample setup:

![](attachments/103333581/103333582.png)
**Figure** : API Gateways in different geographical regions

!!! info
Note that in addition to the configuration mentioned above, all the other required configuration for Publisher and other Components should be done. If you are using a multi-tenanted setup, would need to share the registry database mount with the Gateway Sandbox and Production nodes.


