# Setting Maximum Backend Throughput Limits

The maximum backend throughput setting limits the total number of calls a particular API in the API Manager is allowed to make to the backend. While the [other throttling levels](Setting-Throttling-Limits_103334955.html#SettingThrottlingLimits-Differentlevelsofthrottling) define the quota the API invoker gets, they do not ensure that the backend is protected from overuse. The maximum backend throughput setting limits the quota the backend can handle. The counters maintained when evaluating the maximum backend throughput are shared across all nodes of the Gateway cluster and apply across all users using any application that accesses that particular API.

You set a maximum backend throughput using the **Manage** tab of the **API Publisher** when creating or editing an API. Under the **Throttling Settings** section, select the **Specify** option for the maximum backend throughput and specify the limits of the Production and Sandbox endpoints separately, as the two endpoints can come from two servers with different capacities.

![](/assets/attachments/103334952/103334953.png)
Alternatively, you can go to the synapse configuration of the API, which is created at the point of creating the API, in the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/api` directory (for a tenant user, the location would be the `<API-M_HOME>/repository/tenants/<TenantID>/synapse-configs/default/api directory` ), and specify the maximum backend throughput by modifying the synapse configuration. Maximum backend throughput limits are usually counted over a duration of 1 second, but you can increase the duration using the `productionUnitTime` and `sandboxUnitTime` properties in the API's synapse configuration. For example,

If you want to accept only 600 requests by the production endpoint within a minute of duration and 700 total requests within 5 minutes by sandbox endpoint you can modify the synapse configuration as below.

``` xml
    <handlers>
         <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.CORSRequestHandler">
            <property name="apiImplementationType" value="ENDPOINT"/>
         </handler>
         <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler"/>
         <handler class="org.wso2.carbon.apimgt.gateway.handlers.throttling.ThrottleHandler">
            <property name="id" value="A"/>
            <property name="productionMaxCount" value="600"/>
            <property name="productionUnitTime" value="60000"/>
            <property name="sandboxMaxCount" value="700"/>
            <property name="sandboxUnitTime" value="300000"/>
            <property name="policyKey" value="gov:/apimgt/applicationdata/tiers.xml"/>
         </handler>
         <handler class="org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageHandler"/>
         ...
    </handlers> 
```

Note that the duration is specified in milliseconds.
