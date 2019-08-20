# High Availability for Endpoints

#### Configuring Load Balancing Endpoints

WSO2 API Manager provides configuring load balancing endpoints through the API Publisher.

To configure load balanced endpoints go to the edit view of the API and navigate to the **Implement** tab and select the **Load Balanced** check box.

Following are the other configurations that you need to do in order to specify a load balancing endpoint.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Production Endpoints</td>
<td><div class="content-wrapper">
<p>The set of production endpoints can be specified here where te requests need to be load balanced. You can specify more than one endpoint by clicking on <strong>&quot;+&quot;</strong> sign and can delete the endpoints by clicking on <strong>&quot;-&quot;</strong> sign.</p>
</div></td>
</tr>
<tr class="even">
<td>Sandbox endpoints</td>
<td>The set of sandbox endpoints can be specified here where te requests need to be load balanced. You can specify more than one endpoint by clicking on <strong>&quot;+&quot;</strong> sign and can delete the endpoints by clicking on <strong>&quot;-&quot;</strong> sign</td>
</tr>
<tr class="odd">
<td>Algorithm</td>
<td><div class="content-wrapper">
<p>The load balancing algorithm is specified here.</p>
<p>The default is <strong>Round Robin</strong> Algorithm which has the className of <a href="https://synapse.apache.org/apidocs/org/apache/synapse/endpoints/algorithms/RoundRobin.html">org.apache.synapse.endpoints.algorithms.RoundRobin</a> <a href="https://synapse.apache.org/apidocs/org/apache/synapse/endpoints/algorithms/RoundRobin.html">.</a> If you select other from the dropdown list of Algorithms you need to specify the class name of the algorithm. Classnames of other algorithms can be found <a href="https://synapse.apache.org/apidocs/org/apache/synapse/endpoints/algorithms/package-summary.html">here</a> .</p>
<p></p>
</div></td>
</tr>
<tr class="even">
<td>Session Management</td>
<td><p>A session management method from the load balancing group. The possible values are as follows.</p>
<p><strong>None</strong> - If this is selected, session management is not used.</p>
<p><strong>Transport</strong> - If this is selected, session management is done on the transport level using HTTP cookies.</p>
<p><strong>SOAP</strong> - If this is selected, session management is done using SOAP sessions.</p>
<p><strong>Client ID</strong> - If this is selected, session management is done using an ID sent by the client.</p></td>
</tr>
<tr class="odd">
<td>Session Timeout</td>
<td>The number of milliseconds after which the session would time out.</td>
</tr>
</tbody>
</table>

After completing the configuration click save and publish the API.

#### Configuring Failover Group of Endpoints

WSO2 API Manager provides configuring failover group endpoints through the API Publisher.

To configure failover endpoints go to the edit view of the API and navigate to the **Implement** tab and click **Failover** under endpoint type.

At leaset one failover endpoint need to be added for production and sandbox (if you have specified)  Endpoints.

You can specify more than one endpoint by clicking on **"+"** sign and can delete the endpoints by clicking on **"-"** sign.

After completing the adding endpoints, click save and publish the API.
