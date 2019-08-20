# Engaging Multiple Throttling Policies to a Single API

You can apply different throttling policies at the same time to a single API. This is called **multi-layer throttling** .

The following example shows how to have two throttling policies for a single API at a given time. The table below shows the throttling information of the two throttling policies.

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th>Tier</th>
<th><div style="margin-left: 0.0pt;">
<p>throttle-l1</p>
</div></th>
<th>throttle-l2</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>free</td>
<td>300 per month</td>
<td>5 per 3 minutes</td>
</tr>
<tr class="even">
<td>Silver</td>
<td>2000 per month</td>
<td>1 per 5 seconds</td>
</tr>
<tr class="odd">
<td>Gold - Unlimited</td>
<td>Unlimited</td>
<td>Unlimited</td>
</tr>
</tbody>
</table>

To engage the two throttling layers, you add two throttling tier definitions and engage them to the API using the steps below:

1.  Go to the Synapse configuration file of the particular API located in `          <         ` `          API-M_HOME>/repository/deployment/server/synapse-configs/default/api         ` .
2.  Copy the following content inside the `           <handlers>          ` section in the API configuration.

    ``` xml
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler"/>
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.throttling.APIThrottleHandler">
            <property name="id" value="B"/>
            <property name="policyKey" value="gov:/apimgt/applicationdata/throttling-l2.xml"/>
        </handler>
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.throttling.APIThrottleHandler">
            <property name="id" value="A"/>
            <property name="policyKey" value="gov:/apimgt/applicationdata/tiers.xml"/>
        </handler>
    ```

3.  Replace the existing content of the `           /_system/governance/apimgt/applicationdata/tiers.xml          ` file with following content.

    **throttling-l1.xml**

    ``` xml
            <wsp:Policy xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy" xmlns:throttle="http://www.wso2.org/products/wso2commons/throttle">
                <throttle:MediatorThrottleAssertion>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">Gold</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>20</throttle:MaximumCount>
                                    <throttle:UnitTime>60000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">Silver</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>2000</throttle:MaximumCount>
                                    <throttle:UnitTime>2592000000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">free</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>300</throttle:MaximumCount>
                                    <throttle:UnitTime>2592000000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">Unauthenticated</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>60</throttle:MaximumCount>
                                    <throttle:UnitTime>60000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                </throttle:MediatorThrottleAssertion>
            </wsp:Policy>
    ```

4.  Create an XML as `           throttling-l2.xml          ` with the following content and add it to `           /_system/governance/apimgt/applicationdata          ` registry location.
    The code adds two policies for each role (free, Silver, Gold) and engages them to the APIs with different keys. Both throttling layers execute in runtime sequentially.

    **throttling-l2.xml**

    ``` xml
            <wsp:Policy xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy" xmlns:throttle="http://www.wso2.org/products/wso2commons/throttle">
                <throttle:MediatorThrottleAssertion>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">Gold</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>20</throttle:MaximumCount>
                                    <throttle:UnitTime>60000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">Silver</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>1</throttle:MaximumCount>
                                    <throttle:UnitTime>5000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">Free</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>5</throttle:MaximumCount>
                                    <throttle:UnitTime>180000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                    <wsp:Policy>
                        <throttle:ID throttle:type="ROLE">Unauthenticated</throttle:ID>
                        <wsp:Policy>
                            <throttle:Control>
                                <wsp:Policy>
                                    <throttle:MaximumCount>60</throttle:MaximumCount>
                                    <throttle:UnitTime>60000</throttle:UnitTime>
                                </wsp:Policy>
                            </throttle:Control>
                        </wsp:Policy>
                    </wsp:Policy>
                </throttle:MediatorThrottleAssertion>
            </wsp:Policy>
    ```


