# Prevent API Suspension

WSO2 API Manager suspends your API if the endpoint of your API cannot be reached. The default suspension time is 30 seconds. Any requests to your API will not be able to reach your endpoint for 30 seconds and will return an error message, as shown below.

``` java
<am:fault xmlns:am="http://wso2.org/apimanager">
<am:code>303001</am:code>
<am:type>Status report</am:type>
<am:message>Runtime Error</am:message>
<am:description>Currently , Address endpoint : [ Name : somename-AT-sometenant--test_me_APIproductionEndpoint_0 ] [ State : SUSPENDED ]</am:description>
</am:fault>
```

Follow the instructions below to prevent or turn off API suspension:

1. Sign in to the API Publisher Portal.
   
    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    Use your username and password to sign in. 

2. Click **Endpoints**.

3. Click on the cogwheel, which is inline with the endpoint that you need to re-configure, and update the endpoint related configurations as required.

     [![Link to advanced endpoint configurations]({{base_path}}/assets/img/learn/prevent-endpoint-suspension.png)]({{base_path}}/assets/img/learn/prevent-endpoint-suspension.png)

4. Configure the **Endpoint Suspension State**. 

     Set the value for **Initial Duration** and **Max Duration** to zero to turn off suspension.

    [![Set the Endpoint Suspension State]({{base_path}}/assets/img/learn/initial-duration-and-max-duration.png)]({{base_path}}/assets/img/learn/initial-duration-and-max-duration.png)

5.  Click **Save** and re-publish the API.

     For more details on creating and publishing an API, see [Create an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api) and [Publish an API]({{base_path}}/learn/design-api/publish-api/publish-an-api).

!!! info
    To avoid backend endpoint suspension:

    1. Navigate to the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/endpoints` directory. 
    
    2. Open the configuration file of the API that has to be prevented from being suspended. 
    
        (e.g., `admin--testApi_v1.0.0.xml`) 
    
    3. Add the following configurations.

        ``` java
        <endpoint name="admin--testApi_APIproductionEndpoint_0">
        <address uri="http://localhost:9000/services/SimpleStockQuoteService">
            <timeout>
                <duration>30000</duration>
                <responseAction>fault</responseAction>
            </timeout>
            <suspendOnFailure>
                <errorCodes>-1</errorCodes>
                <initialDuration>0</initialDuration>
                <progressionFactor>1.0</progressionFactor>
                <maximumDuration>0</maximumDuration>
            </suspendOnFailure>
            <markForSuspension>
                <errorCodes>-1</errorCodes>
            </markForSuspension>
        </address>
        </endpoint>
        ```

For more details on configuring different timeouts, see [Timeout configurations for an API call]({{base_path}}/install-and-setup/setup/deployment-best-practices/tuning-performance/) in the Performance Tuning guide.
