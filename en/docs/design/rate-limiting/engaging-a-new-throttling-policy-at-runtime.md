# Engaging a new Throttling Policy at Runtime

WSO2 API Manager allows you to control the number of successful requests to your API during a given period. You can enable for APis in the CREATED and PUBLISHED state and also for published APIs at runtime. This feature protects your APIs, regulates traffic and access to the resources.

The steps below show how to engage a throttling policy to an API at runtime.

1.  Write a new throttling policy. For example, the following sample throttling policy points to a backend service and allows 1000 concurrent requests to a service.

    ```
        <wsp:Policy xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy"
        xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"
        xmlns:throttle="http://www.wso2.org/products/wso2commons/throttle"
                    wsu:Id="WSO2MediatorThrottlingPolicy">
            <throttle:MediatorThrottleAssertion>
                <throttle:MaximumConcurrentAccess>1000</throttle:MaximumConcurrentAccess>
                <wsp:Policy>
                    <throttle:ID throttle:type="IP">other</throttle:ID>           
                </wsp:Policy>
            </throttle:MediatorThrottleAssertion>
        </wsp:Policy>
    ```

!!! info
     Attributes

     -   Throttle policy - This section is used to specify the policy for throttling.
     -   Maximum concurrent accesses - The maximum number of messages that are served at a given time.
     -   Throttle assertion - Assertion for a concurrency-based policy.


2.  Log in to the API Manager's management console ( `https://localhost:9443/carbon` ) and go to the **Resource &gt; Browse** menu to view the registry.

    ![]({{base_path}}/assets/img/learn/learn-throttling-runtime-browse.png)

3.  Click the `/_system/goverence/apimgt/applicationdata` path to go to its detailed view.
    ![]({{base_path}}/assets/img/learn/learn-throttling-runtime-appdata.png)
4.  In the detail view, click **Add Resource** .
    ![]({{base_path}}/assets/img/learn/learn-throttling-runtime-addresource.png)

5.  Upload the policy file to the server as a registry resource.

6.  Open the synapse configuration file of a selected API you want to engage the policy, from the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/api` directory.

7.  To engage the policy to a selected API, add it to your API definition. In this example, we add it to the login API under APIThrottleHandler.

    ```
        <api xmlns="http://ws.apache.org/ns/synapse" name="_WSO2AMLoginAPI_" context="/login">
            <resource methods="POST" url-mapping="/*">
                <inSequence>
                    <send>
                        <endpoint>
                            <address uri="https://localhost:9493/oauth2/token"/>
                        </endpoint>
                    </send>
                </inSequence>
                <outSequence>
                    <send/>
                </outSequence>
            </resource>
            <handlers>
         <handler class="org.wso2.carbon.apimgt.gateway.handlers.throttling.APIThrottleHandler">
               <property name="id" value="A"/>
               <property name="policyKey" value="gov:/apimgt/applicationdata/throttle.xml"/>
               </handler> 
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler"/>
            </handlers>
        </api>
    ```

!!! note
    Be sure to specify the same path used in step 5 in the policy key of your API definition. Also, use the same tier name you selected when creating the API as the throttle id in the policy (example `<throttle:ID throttle:type ="ROLE">Gold</throttle:ID>)` .


You have successfully engaged a throttling policy to an API at runtime, without restarting the server.
