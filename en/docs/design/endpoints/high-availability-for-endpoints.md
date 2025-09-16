# High Availability for Endpoints

## Configuring Load Balancing Endpoints

When using WSO2 API Manager, you can configure load balancing endpoints via the API Publisher.

1. When you [create an API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api), to configure load balancing endpoints go to the edit view of the API, click **Endpoint** to view the Endpoint page.

2. Expand **Load balance and Failover Configurations**.

     [![load balance and fail over]({{base_path}}/assets/img/learn/load-balance-and-fail-over.png)]({{base_path}}/assets/img/learn/load-balance-and-fail-over.png)

3. Select **Load Balanced** as the endpoint type.

     ![load-balanced]({{base_path}}/assets/img/learn/load-balanced-configurations.png)

4. Configure the endpoint.

    ![load-balanced]({{base_path}}/assets/img/learn/load-balanced-configured.png)
    
    The following are the other configurations that you need to define in order to specify a load balancing endpoint.
<table>
     <thead>
     <tr>
     <th width="20%"><b>Configuration</b></th>
     <th width="80%"><b>Description</b></th>
     </tr>
     </thead>
     <tbody>
     <tr>
     <td><b>Production Endpoints</b></td>
     <td>
     Specify the set of production endpoints here where the requests need to be load balanced.<br/>
     If required, you can specify more than one endpoint by clicking <strong>+</strong>, and can delete the endpoints by clicking on the <strong>bin</strong> icon.
     </td>
     </tr>
     <tr>
     <td><b>Sandbox Endpoints</b></td>
     <td>
     The set of sandbox endpoints can be specified here where the requests need to be load balanced.<br/>
     If required, you can specify more than one endpoint by clicking <strong>+</strong>, and can delete the endpoints by clicking on the <strong>bin</strong> icon.
     </td>
     </tr>
     <tr>
     <td><b>Algorithm</b></td>
     <td>
     The load balancing algorithm is specified here.<br/>
     Click on the cogwheel icon to define the algorithm.<br/>
     The default value is the <strong>Round-Robin</strong> Algorithm, which has the <a href="https://synapse.apache.org/apidocs/org/apache/synapse/endpoints/algorithms/RoundRobin.html">org.apache.synapse.endpoints.algorithms.RoundRobin</a> className.<br/>
     If you select another algorithm, you need to specify the class name of the algorithm. Class names of other algorithms can be found <a href="https://synapse.apache.org/apidocs/org/apache/synapse/endpoints/algorithms/package-summary.html">here</a>.
     </td>
     </tr>
     <tr>
     <td><b>Session Management</b></td>
     <td>
     Click on the cogwheel icon to configure session management.<br/>
     This refers to a session management method from the load balancing group. The possible values are:
     <ul>
     <li><strong>None</strong> - Session management is not used.</li>
     <li><strong>Transport</strong> - Session management is done on the transport level using HTTP cookies.</li>
     <li><strong>SOAP</strong> - Session management is done using SOAP sessions.</li>
     <li><strong>Client ID</strong> - Session management is done using an ID sent by the client.</li>
     </ul>
     </td>
     </tr>
     <tr>
     <td><b>Session Timeout</b></td>
     <td>
     The number of milliseconds after which the session would time out.<br/>
     Click on the cogwheel icon to set up session timeout.
     </td>
     </tr>
     <tr>
     <td><b>Enable Failover</b></td>
     <td>
     When session management is set to <strong>None</strong>, failover can be explicitly enabled or disabled as required.<br/>
     The <strong>Enable Failover</strong> button is available for all session management types; however, it only functions when session management is set to <strong>None</strong>.

     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The <strong>Enable Failover</strong> button has been available since the GA release but was not functional until update level <em>41</em>.<br/>
     To enable or disable failover when session management is set to <strong>None</strong>, update your pack to the specified update level and add the following configuration to the <code>deployment.toml</code> file:</p>

     <pre><code>[apim.endpoint_config.loadbalanced]
     enable_failover = true
     </code></pre>
     </div>

     Select the <strong>Enable Failover</strong> checkbox to turn failover on or off.
     </td>
     </tr>
     </tbody>
</table>
    
5. Click **SAVE**.

## Configuring Failover Group of Endpoints
When using WSO2 API Manager, you can configure failover group endpoints via the API Publisher.

1. When you [create an API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api), to configure failover endpoints go to the edit view of the API, click **Endpoint** to view the Endpoint page.

2. Expand **Load balance and Failover Configurations**.

     ![failover]({{base_path}}/assets/img/learn/failover.png)

3. Select **Failover** as the endpoint type.

4. Configure the endpoint.

     ![failover]({{base_path}}/assets/img/learn/failover-configured.png)
     
     You need to add at least one failover endpoint as the production and sandbox (based on the endpoints that you have specified) endpoints. 
     
     If required, you can specify more than one endpoint by clicking <strong>+</strong>, and can delete the endpoints by clicking on the <strong>bin</strong> icon.
     
     

5. Click **SAVE**.
