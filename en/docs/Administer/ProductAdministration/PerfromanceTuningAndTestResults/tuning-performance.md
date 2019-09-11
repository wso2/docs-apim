# Tuning Performance

This section describes some recommended performance tuning configurations to optimize the API Manager. It assumes that you have set up the API Manager on Unix/Linux, which is recommended for a production deployment. We also recommend [a distributed API Manager setup](https://docs.wso2.com/display/AM260/Distributed+Deployment+of+API+Manager) for most production systems. Out of all components of an API Manager distributed setup, the API Gateway is the most critical, because it handles all inbound calls to APIs. Therefore, we recommend you to have at least a 2-node cluster of API Gateways in a distributed setup.

-   [OS-level settings](#TuningPerformance-OS-levelsettings)
-   [JVM-level settings](#TuningPerformance-JVM-levelsettings)
-   [WSO2 Carbon platform-level settings](#TuningPerformance-WSO2Carbonplatform-levelsettings)
-   [APIM-level settings](#TuningPerformance-APIM-levelsettings)
-   [Throttle data and Analytics-related settings](#TuningPerformance-ThrottledataandAnalytics-relatedsettings)

!!! note
**Important** :

-   Performance tuning requires you to modify important system files, which affect all programs running on the server. We recommend you to familiarize yourself with these files using Unix/Linux documentation before editing them.
-   The values we discuss here are general recommendations. They might not be the optimal values for the specific hardware configurations in your environment. We recommend you to carry out load tests on your environment to tune the API Manager accordingly.


#### OS-level settings

When it comes to performance, the OS that the server runs plays an important role.

!!! info
If you are running MacOS Sierra and experiencing long startup times for WSO2 products, try mapping your Mac hostname to 127.0.0.1 and ::1 in the `/etc/hosts` file as described. For example, if your Macbook hostname is "john-mbpro. local", then add the mapping to the canonical 127.0.0.1 address in the `/etc/hosts` file, as shown in the example below.

``` java
    127.0.0.1 localhost john-mbpro.local
```


Following are the configurations you can apply to optimize OS-level performance:

1.  To optimize network and OS performance, configure the following settings in the `/etc/sysctl.conf` file of Linux. These settings specify a larger port range, a more effective TCP connection timeout value, and a number of other important parameters at the OS-level.

        !!! info
    It is not recommended to use `net.ipv4.tcp_tw_recycle = 1` when working with network address translation (NAT), such as if you are deploying products in EC2 or any other environment configured with NAT.


    ``` java
        net.ipv4.tcp_fin_timeout = 30
        fs.file-max = 2097152
        net.ipv4.tcp_tw_recycle = 1
        net.ipv4.tcp_tw_reuse = 1
        net.core.rmem_default = 524288
        net.core.wmem_default = 524288
        net.core.rmem_max = 67108864
        net.core.wmem_max = 67108864
        net.ipv4.tcp_rmem = 4096 87380 16777216
        net.ipv4.tcp_wmem = 4096 65536 16777216
        net.ipv4.ip_local_port_range = 1024 65535      
    ```

2.  To alter the number of allowed open files for system users, configure the following settings in the `/etc/security/limits.conf` file of Linux (be sure to include the leading \* character).

    ``` java
            * soft nofile 4096
            * hard nofile 65535
    ```

    Optimal values for these parameters depend on the environment.

3.  To alter the maximum number of processes your user is allowed to run at a given time, configure the following settings in the `/etc/security/limits.conf` file of Linux (be sure to include the leading \* character). Each carbon server instance you run would require upto 1024 threads (with default thread pool configuration). Therefore, you need to increase the nproc value by 1024 per each carbon server (both hard and soft).

    ``` java
            * soft nproc 20000
            * hard nproc 20000
    ```

#### JVM-level settings

When an XML element has a large number of sub elements and the system tries to process all the sub elements, the system can become unstable due to a memory overhead. This is a security risk.

To avoid this issue, you can define a maximum level of entity substitutions that the XML parser allows in the system. You do this using the `entity expansion limit` as follows in the `<API-M_HOME>/bin/wso2server.bat` file (for Windows) or the `<API-M_HOME>/bin/wso2server.sh` file (for Linux/Solaris). The default entity expansion limit is 64000.

``` java
    -DentityExpansionLimit=10000
```

In a clustered environment, the entity expansion limit has no dependency on the number of worker nodes.

#### WSO2 Carbon platform-level settings

In multitenant mode, the WSO2 Carbon runtime limits the thread execution time. That is, if a thread is stuck or taking a long time to process, Carbon detects such threads, interrupts and stops them. Note that Carbon prints the current stack trace before interrupting the thread. This mechanism is implemented as an Apache Tomcat valve. Therefore, it should be configured in the `<PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml` file as shown below.

``` xml
    <Valve className="org.wso2.carbon.tomcat.ext.valves.CarbonStuckThreadDetectionValve" threshold="600"/>
```

-   The `className` is the Java class used for the implementation. Set it to `org.wso2.carbon.tomcat.ext.valves.CarbonStuckThreadDetectionValve` .
-   The `threshold` gives the minimum duration in seconds after which a thread is considered stuck. The default value is 600 seconds.

#### APIM-level settings

-   [Timeout configurations for an API call](#TuningPerformance-TimeoutconfigurationsforanAPIcall)
-   [General APIM-level recommendations](#TuningPerformance-GeneralAPIM-levelrecommendations)
-   [Registry indexing configurations](#TuningPerformance-Registryindexingconfigurations)
-   [Tuning data-agent parameters](#TuningPerformance-Tuningdata-agentparameters)

##### Timeout configurations for an API call

The following diagram shows the communication/network paths that occur when an API is called. The timeout configurations for each network call are explained below.
![](attachments/103333648/103333650.png)
-   **Key validation**
    Key validation occurs via a Servlet HTTP call and the connection timeout can be configured by changing the following configuration details in the `<API-M_HOME>/repository/conf/axis2/axis2_client.xml` file. All timeout values are in milliseconds.

    ``` xml
            <transportSender name="https" class="org.apache.axis2.transport.http.CommonsHTTPTransportSender">
            <parameter name="SO_TIMEOUT">60000</parameter>
            <parameter name="CONNECTION_TIMEOUT">60000</parameter>
            </transportSender>
    ```

    If the Key Manager caching is enabled, the calls between the API Gateway and Key Manager are cached. As a result, the Key Manager is not invoked for each API call.

-   **Client call API Gateway + API Gateway call Backend**
    For backend communication, the API Manager uses PassThrough transport. This is configured in the `<API-M_HOME>/repository/conf/passthru-http.properties` file. For more information, see [Configuring passthru-http.properties](https://docs.wso2.com/display/EI620/Configuring+passthru-http.properties) in the EI documentation.

        !!! note
    Note that the default value for `http.socket.timeout` differs between WSO2 products. In WSO2 API-M, the default value for `http.socket.timeout` is 180000ms.


##### General APIM-level recommendations

Some general APIM-level recommendations are listed below:

<table>
<thead>
<tr class="header">
<th>Improvement Area</th>
<th>Performance Recommendations</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>API Gateway nodes</td>
<td><div class="content-wrapper">
<p>Increase memory allocated by modifying the <code>               /bin/wso2server.              </code> <code>               sh              </code> file with the following setting:</p>
<ul>
<li><code>                -Xms2048m -Xmx2048m -XX:MaxPermSize=1024m               </code></li>
</ul>
<p>Set the following in the <code>               &lt;API-M_HOME&gt;/repository/conf/axis2/axis2_client.xml              </code> file:</p>
!!! note
<ul>
<li>The following Axis2 client configurations are only applicable when Web Services key validation (WS key validation) is enabled.</li>
<li>The default values mentioned are the values identified at the time of releasing API-M. However, if you want high concurrency, use the values mentioned below:</li>
</ul>

<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;parameter name=&quot;defaultMaxConnPerHost&quot;&gt;1000&lt;/parameter&gt; 
&lt;parameter name=&quot;maxTotalConnections&quot;&gt;30000&lt;/parameter&gt; </code></pre>
</div>
</div>
!!! info
<p>The above configurations are only applicable when WS key validation is enabled.</p>

</div></td>
</tr>
<tr class="even">
<td>NHTTP transport of API Gateway</td>
<td><p>Recommended values for the <code>              &lt;API-M_HOME&gt;/repository/conf/nhttp.properties             </code> file are given below. Note that the commented out values in this file are the default values that will be applied if you do not change anything.</p>
<p><strong>Property descriptions:</strong></p>
<div class="table-wrap">
<table>
<tbody>
<tr class="odd">
<td>snd_t_core</td>
<td>Transport sender worker pool's initial thread count</td>
</tr>
<tr class="even">
<td>snd_t_max</td>
<td>Transport sender worker pool's maximum thread count</td>
</tr>
<tr class="odd">
<td>snd_io_threads</td>
<td>Sender-side IO workers, which is recommended to be equal to the number of CPU cores. I/O reactors usually employ a small number of dispatch threads (often as few as one) to dispatch I/O event notifications to a greater number (often as many as several thousands) of I/O sessions or connections. Generally, one dispatch thread is maintained per CPU core.</td>
</tr>
<tr class="even">
<td>snd_alive_sec</td>
<td>Sender-side keep-alive seconds</td>
</tr>
<tr class="odd">
<td>snd_qlen</td>
<td>Sender queue length, which is infinite by default</td>
</tr>
</tbody>
</table>
</div>
<p><strong>Recommended values:</strong></p>
<ul>
<li>HTTP Sender thread pool parameters
<ul>
<li><code>                 snd_t_core=200                </code></li>
<li><code>                 snd_t_max=250                </code></li>
<li><code>                 snd_alive_sec=5                </code></li>
<li><code>                 snd_qlen=-1                </code></li>
<li><code>                 snd_io_threads=16                </code></li>
</ul></li>
<li>HTTP Listener thread pool parameters
<ul>
<li><code>                 lst_t_core=200                </code></li>
<li><code>                 lst_t_max=250                </code></li>
<li><code>                 lst_alive_sec=5                </code></li>
<li><code>                 lst_qlen=-1                </code></li>
<li><code>                 lst_io_threads=16                </code></li>
</ul></li>
<li>timeout parameters
<ul>
<li><p><code>                  http.socket.timeout.receiver                 </code> : Recommended socket timeout for listener is 180000 ms.</p></li>
<li><p><code>                  http.socket.timeout.sender                 </code> : Recommended socket timeout for sender is 180000 ms.</p></li>
</ul></li>
</ul></td>
</tr>
<tr class="odd">
<td>PassThrough transport of API Gateway</td>
<td><p>Recommended values for the <code>              &lt;API-M_HOME&gt;/repository/conf/passthru-http.properties             </code> file are given below. Note that the commented out values in this file are the default values that will be applied if you do not change anything.</p>
<p><strong>Property descriptions</strong></p>
<div class="table-wrap">
<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><code>                   worker_thread_keepalive_sec                  </code></p></td>
<td>Defines the keep-alive time for extra threads in the worker pool</td>
</tr>
<tr class="even">
<td><code>                  worker_pool_queue_length                 </code></td>
<td>Defines the length of the queue that is used to hold runnable tasks to be executed by the worker pool</td>
</tr>
<tr class="odd">
<td><code>                  io_threads_per_reactor                 </code></td>
<td>Defines the number of IO dispatcher threads used per reactor</td>
</tr>
<tr class="even">
<td><p><code>                   http.max.connection.per.host.port                  </code></p></td>
<td>Defines the maximum number of connections per host port</td>
</tr>
<tr class="odd">
<td><code>                  worker_pool_queue_length                 </code></td>
<td>Determines the length of the queue used by the PassThrough transport thread pool to store pending jobs.</td>
</tr>
</tbody>
</table>
</div>
<p><strong>Recommended values</strong></p>
<ul>
<li><p><code>                worker_thread_keepalive_sec:               </code> Default value is 60s. This should be less than the socket timeout.</p></li>
<li><p><code>                worker_pool_queue_length:               </code> Set to -1 to use an unbounded queue. If a bound queue is used and the queue gets filled to its capacity, any further attempts to submit jobs will fail, causing some messages to be dropped by Synapse. The thread pool starts queuing jobs when all the existing threads are busy and the pool has reached the maximum number of threads. So, the recommended queue length is -1.</p></li>
<li><p><code>                io_threads_per_reactor:               </code> Value is based on the number of processor cores in the system. (Runtime.getRuntime().availableProcessors())</p></li>
<li><p><code>                http.max.connection.per.host.port :               </code> Default value is 32767, which works for most systems but you can tune it based on your operating system (for example, Linux supports 65K connections).</p></li>
<li><code>               worker_pool_size_core: 400              </code></li>
<li><code>               worker_pool_size_max: 500              </code></li>
<li><code>               io_buffer_size: 16384              </code></li>
<li><code>               http.              </code> socket.timeout <code>               : 180000              </code></li>
</ul>
Make the number of threads equal to the number of processor cores.</td>
</tr>
<tr class="even">
<td>Timeout configurations</td>
<td><div class="content-wrapper">
<p>The API Gateway routes the requests from your client to an appropriate endpoint. The most common reason for your client getting a timeout is when the Gateway's timeout is larger than the client's timeout values. You can resolve this by either increasing the timeout on the client's side or by decreasing it on the API Gateway's side.</p>
<p>Here are a few parameters, in <strong>addition to the timeout parameters discussed in the previous sections</strong> .</p>
<div class="table-wrap">
<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><code>                   synapse.global_timeout_interval                  </code></td>
<td><p>Defines the maximum time that a callback waits in the Gateway for a response from the backend. If no response is received within this time, the Gateway drops the message and clears out the callback. This is a global level parameter that affects all the endpoints configured in the Gateway.</p>
<p>The global timeout is defined in the <code>                    &lt;API-M_HOME&gt;/repository/conf/synapse.properties                   </code> file. The recommended value is 120000 ms.</p></td>
</tr>
<tr class="even">
<td><code>                   Endpoint-level timeout                  </code></td>
<td><div class="content-wrapper">
<p>You can define timeouts per endpoint for different backend services, along with the action to be taken in case of a timeout.</p>
<p>The example below sets the endpoint to 50 seconds (50000 ms) and executes the fault handler in case of a timeout.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;timeout&gt;
   &lt;duration&gt;50000&lt;/duration&gt;
   &lt;responseAction&gt;fault&lt;/responseAction&gt;
&lt;/timeout&gt;</code></pre>
</div>
</div>
<p>Alternatively, you can set this through the Publisher UI as well, by following the steps below:</p>
<ol>
<li>Log in to the API Publisher ( <code>                      https://&lt;HostName&gt;:9443/publisher                     </code> ). Select your API and click <strong>Edit API</strong> .</li>
<li>Click the <strong>Implement</strong> tab and click the cogwheel icon next to the endpoint you want to re-configure.</li>
<li><p>In the <strong>Advanced Settings</strong> dialog box that appears, increase the duration by modifying the default property set as 3000 ms.</p>
<p>!!! note</p>
<p>Note that when the endpoint is suspended, the default action is defined here as invoking the fault sequence.</p>
</p>
<p><img src="attachments/50518314/80711443.png" alt="timeout.png" width="734" /></p></li>
<li><p>Click <strong>Save</strong> and re-publish the API.</p></li>
</ol>
!!! note
<p>The <code>                     http.socket.timeout                    </code> parameter needs to be adjusted based on the endpoint-level timeout so that it's value is equal or higher than the highest endpoint-level timeout.</p>
!!! warning
<p>If your <a href="https://docs.wso2.com/display/AM260/Create+a+New+API+Version#CreateaNewAPIVersion-step4">API is marked as the default version</a> , it has a different template (without the version number) that comes with a pre-defined timeout for the endpoint. This timeout does not change with the changes you do to the API by editing the Advanced Endpoint Configuration. Therefore, if this predefined timeout (60 seconds) is less than the actual API timeout, it triggers the timeout before the actual configured API timeout.</p>
<p>To overcome this, update the <code>                     default_api_template.xml                    </code> residing in the <code>                     &lt;API-M_HOME&gt;/                    </code> <code>                     repository/resources/api_templates                    </code> directory by removing the endpoint timeout configuration from the default API. Then, the APIs marked as the default version also trigger the timeout when the actual API timeout is met.</p>
<p>Follow the steps below to update the <code>                     default_api_template.xml                    </code> to remove the endpoint configuration for the default APIs.</p>
!!! tip
<p>If you are using a distributed (clustered) setup, follow these steps in the Publisher node as it is the API Publisher that creates the API definition and pushes it to the Gateway.</p>

<ol>
<li><p>Open the <code style="white-space: nowrap;">                       &lt;API-M_HOME&gt;/repository/resources/api_templates/default_api_template.xml                      </code> file and remove the following configuration:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;timeout&gt;
    &lt;duration&gt;60000&lt;/duration&gt;
    &lt;responseAction&gt;fault&lt;/responseAction&gt;
&lt;/timeout&gt;
&lt;suspendOnFailure&gt;
    &lt;progressionFactor&gt;1.0&lt;/progressionFactor&gt;
&lt;/suspendOnFailure&gt;
&lt;markForSuspension&gt;
    &lt;retriesBeforeSuspension&gt;0&lt;/retriesBeforeSuspension&gt;
    &lt;retryDelay&gt;0&lt;/retryDelay&gt;
&lt;/markForSuspension&gt;</code></pre>
</div>
</div></li>
<li><p>Add the following configuration to the same place in the <code>                       default_api_template.xml                      </code> file.</p>
<p>!!! info</p>
<p>By adding this configuration, you ensure that the APIs marked as the default version never timeout or are suspended using the endpoint configration defined in the synapse file of the API.</p>
</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;suspendOnFailure&gt;
    &lt;errorCodes&gt;-1&lt;/errorCodes&gt;
    &lt;initialDuration&gt;0&lt;/initialDuration&gt;
    &lt;progressionFactor&gt;1.0&lt;/progressionFactor&gt;
    &lt;maximumDuration&gt;0&lt;/maximumDuration&gt;
&lt;/suspendOnFailure&gt;
&lt;markForSuspension&gt;
    &lt;errorCodes&gt;-1&lt;/errorCodes&gt;
&lt;/markForSuspension&gt;</code></pre>
</div>
</div></li>
<li><p>Go to the API Publisher and republish the default API by clicking <strong>Save and Publish</strong> .</p></li>
</ol>

</div></td>
</tr>
</tbody>
</table>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Key Manager nodes</td>
<td><div class="content-wrapper">
<p>Set the MySQL maximum connections:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="html/xml" data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"><code>mysql&gt; show variables like &quot;max_connections&quot;; 
 max_connections was 151 
 set to global max_connections = 250; </code></pre>
</div>
</div>
<p>Set the open files limit to 200000 by editing the <code>               /etc/sysctl.conf              </code> file:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>sudo sysctl -p</code></pre>
</div>
</div>
<p>Set the following in the <code>               &lt;API-M_HOME&gt;/repository/conf/tomcat/catalina-server.xml              </code> file.</p>
!!! note
<p>If you use WSO2 Identity Server (WSO2 IS) as the Key Manager, then the root location of the above path and the subsequent path needs to change from <code>               &lt;API-M_HOME&gt;              </code> to <code>               &lt;IS_HOME&gt;              </code> .</p>

<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>maxThreads=&quot;750&quot; 
minSpareThreads=&quot;150&quot; 
disableUploadTimeout=&quot;false&quot; 
enableLookups=&quot;false&quot; 
connectionUploadTimeout=&quot;120000&quot; 
maxKeepAliveRequests=&quot;600&quot; 
acceptCount=&quot;600&quot; </code></pre>
</div>
</div>
<p>Set the following connection pool elements in the <code>               &lt;API-M_HOME&gt;/repository/conf/datasources/master-datasources.xml              </code> file. Time values are defined in milliseconds.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;maxActive&gt;50&lt;/maxActive&gt;
&lt;maxWait&gt;60000&lt;/maxWait&gt;
&lt;testOnBorrow&gt;true&lt;/testOnBorrow&gt;
&lt;validationQuery&gt;SELECT 1&lt;/validationQuery&gt;
&lt;validationInterval&gt;30000&lt;/validationInterval&gt;</code></pre>
</div>
</div>
<p>Note that you set the <code>               &lt;testOnBorrow&gt;              </code> element to <code>               true              </code> and provide a validation query (e.g., in Oracle, <code>               SELECT 1 FROM DUAL              </code> ), which is run to refresh any stale connections in the connection pool. Set a suitable value for the <code>               &lt;validationInterval&gt;              </code> element, which defaults to 30000 milliseconds. It determines the time period after which the next iteration of the validation query will be run on a particular connection. It avoids excess validations and ensures better performance.</p>
</div></td>
</tr>
</tbody>
</table>

##### Registry indexing configurations

The registry indexing process is only required to be run on the API Publisher and API Store nodes. To disable the indexing process from running on the other nodes (Gateways and Key Managers), you need to set the `<wso2registry><indexingConfiguration><startIndexing>` element to false in the `<API-M_HOME>/repository/conf/registry.xml` file of the relevant nodes.

#### Throttle data and Analytics-related settings

This section describes the parameters you need to configure to tune the performance of API-M Analytics and Throttling when it is affected by high load, network traffic etc. You need to tune these parameters based on the deployment environment.

##### Tuning data-agent parameters

The following parameters should be configured in the `<APIM_ANALYTICS_HOME>/repository/conf/data-bridge/data-agent-config.xml` file. Note that there are two sub-sections in this file, named **Thrift** and **Binary** .

``` xml
    <DataAgentsConfiguration>
        <Agent>
            <Name>Thrift</Name>
            ...
        </Agent>
    <Agent>
        <Name>Binary</Name>
        ...
    </Agent>
</DataAgentsConfiguration>
```
The Thrift section is related to Analytics and the Binary section is related to Throttling. Same set of parameters mentioned below can be found in both sections. The parameter descriptions and recommendations are intended towards the for performance tuning of Analytics, but the same recommendations are relevant for Throttling data related tuning in the Binary section. Note that the section for Thrift is relevant only if Analytics is enabled.

<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
<th>Default Value</th>
<th>Tuning Recommendation</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>             QueueSize            </code></td>
<td>The number of messages that can be stored in WSO2 API-M at a given time before they are published to the Analytics Server.</td>
<td>32768</td>
<td><div class="content-wrapper">
<p>This value should be increased when the Analytics Server is busy due to a request overload or if there is high network traffic. This prevents the generation of the queue <code>               full,              </code> <code>               dropping message              </code> error.</p>
<p>When the Analytics server is not very busy and when the network traffic is relatively low, the queue size can be reduced to avoid an overconsumption of memory.</p>
!!! info
<p>The number specified for this parameter should be a power of 2.</p>

</div></td>
</tr>
<tr class="even">
<td><code>             BatchSize            </code></td>
<td>The WSO2 API-M statistical data sent to the Analytics Server to be published in the Analytics Dashboard are grouped into batches. This parameter specifies the number of requests to be included in a batch.</td>
<td>200</td>
<td>This value should be tuned in proportion to the volume of requests sent from WSO2 API-M to the Analytics Server. This value should be reduced if you want to reduce the system overhead of the Analytics Server. This value should be increased if WSO2 API-M is generating a high amount of statistics and if the <code>             QueueSize            </code> cannot be further increased without causing an overconsumption of memory.</td>
</tr>
<tr class="odd">
<td><code>             CorePoolSize            </code></td>
<td>The number of threads allocated to publish WSO2 API-M statistical data to the Analytics Server via Thrift at the time WSO2 API-M is started. This value increases when the throughput of statistics generated increases. However, the number of threads will not exceed the number specified for the <code>             MaxPoolSize            </code> parameter.</td>
<td>1</td>
<td>The number of available CPU cores should be taken into account when specifying this value. Increasing the core pool size may improve the throughput of statistical data published in the Analytics Dashboard, but latency will also be increased due to context switching.</td>
</tr>
<tr class="even">
<td><code>             MaxPoolSize            </code></td>
<td>The maximum number of threads that should be allocated at any given time to publish WSO2 API-M statistical data to the Analytics Server.</td>
<td>1</td>
<td>The number of available CPU cores should be taken into account when specifying this value. Increasing the maximum core pool size may improve the throughput of statistical data published in the Analytics Dashboard, since more threads can be spawned to handle an increased number of events. However, latency will also increase since a higher number of threads would cause context switching to take place more frequently.</td>
</tr>
<tr class="odd">
<td><code>             MaxTransportPoolSize            </code></td>
<td>The maximum number of transport threads that should be allocated at any given time to publish WSO2 API-M statistical data to the Analytics Server.</td>
<td>250</td>
<td>This value must be increased when there is an increase in the throughput of events handled by WSO2 API-M Analytics.<br />
<br />
The value of the <code>             tcpMaxWorkerThreads            </code> parameter in the <code>             &lt;APIM-ANALYTICS_HOME&gt;/repository/conf/data-bridge/data-bridge-config.xml            </code> must change based on the value specified for this parameter and the number of data publishers publishing statistics. e.g., When the value for this parameter is <code>             250            </code> and the number of data publishers is 7, the value for the <code>             tcpMaxWorkerThreads            </code> parameter must be <code>             1750            </code> (i.e., 7 * 250). This is because you need to ensure that there are enough receiver threads to handle the number of messages published by the data publishers.</td>
</tr>
<tr class="even">
<td><code>             SecureMaxTransportPoolSize            </code></td>
<td>The maximum number of secure transport threads that should be allocated at any given time to publish WSO2 API-M statistical data to the Analytics Server.</td>
<td>250</td>
<td><p>This value must be increased when there is an increase in the throughput of events handled by WSO2 API-M Analytics.</p>
<p>The value of the <code>              sslMaxWorkerThreads             </code> parameter in the <code>              &lt;APIM-ANALYTICS_HOME&gt;/repository/conf/data-bridge/data-bridge-config.xml             </code> must change based on the value specified for this parameter and the number of data publishers publishing statistics. e.g., When the value for this parameter is <code>              250             </code> and the number of data publishers is 7, the value for the <code>              sslMaxWorkerThreads             </code> parameter must be <code>              1750             </code> (i.e., 7 * 250). This is because you need to ensure that there are enough receiver threads to handle the number of messages published by the data publishers.</p></td>
</tr>
</tbody>
</table>


