# Tuning Performance

This section describes some recommended performance tuning configurations to optimize WSO2 API Manager. It assumes that you have set up the API Manager on Unix/Linux, which is recommended for a production deployment.

!!! warning
    Performance tuning requires you to modify important system files, which affect all programs running on the server. WSO2 recommends that you familiarize yourself with these files using Unix/Linux documentation before editing them.

!!! info
    The values that WSO2 discusses here are general recommendations. They might not be the optimal values for the specific hardware configurations in your environment. WSO2 recommends that you carry out load tests on your environment to tune the API Manager accordingly.

!!! note
    Over time, databases accumulate large volumes of data including invalid access tokens, revoked access tokens, registry transaction-related logs, authorization codes, and user sessions. Therefore, cleaning up outdated and unnecessary data helps maintain optimal database performance by reducing storage overhead, improving query execution times, and ensuring that the system can handle higher loads effectively. WSO2 API Manager provides mechanisms to [manage data growth and improve performance](#configuring-wso2-api-m-to-perform-regular-cleaning).

## OS-level settings

When it comes to performance, the OS that the server runs plays an important role.

!!! info
    If you are running MacOS Sierra and experiencing long startup times for WSO2 products, try mapping your Mac hostname to 127.0.0.1 and ::1 in the `/etc/hosts` file as described. For example, if your Macbook hostname is "john-mbpro. local", then add the mapping to the canonical 127.0.0.1 address in the `/etc/hosts` file, as shown in the example below.

    ``` java
    127.0.0.1 localhost john-mbpro.local
    ```


Following are the configurations that can be applied to optimize the OS-level performance:

1.  To optimize network and OS performance, configure the following settings in the `/etc/sysctl.conf` file of Linux. These settings specify a larger port range, a more effective TCP connection timeout value, and a number of other important parameters at the OS-level.

    !!! info
        It is **not recommended** to use `net.ipv4.tcp_tw_recycle = 1` when working with network address translation (NAT), such as if you are deploying products in EC2 or any other environment configured with NAT.


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

    For more information on the above configurations, see [sysctl](https://wiki.archlinux.org/index.php/Sysctl).

2.  To alter the number of allowed open files for system users, configure the following settings in the `/etc/security/limits.conf` file of Linux (be sure to include the leading \* character).

    ``` java
    * soft nofile 4096
    * hard nofile 65535
    ```

    Optimal values for these parameters depend on the environment.

3.  To alter the maximum number of processes your user is allowed to run at a given time, configure the following settings in the `/etc/security/limits.conf` file of Linux (be sure to include the leading \* character). Each Carbon server instance you run would require up to 1024 threads (with default thread pool configuration). Therefore, you need to increase the nproc value by 1024 per each Carbon server (both hard and soft).

    ``` java
    * soft nproc 20000
    * hard nproc 20000
    ```

## JVM-level settings

When an XML element has a large number of sub-elements and the system tries to process all the sub-elements, the system can become unstable due to a memory overhead. This is a security risk.

To avoid this issue, you can define a maximum level of entity substitutions that the XML parser allows in the system. You do this using the `entity expansion limit` as follows in the `<API-M_HOME>/bin/api-manager.bat` file (for Windows) or the `<API-M_HOME>/bin/api-manager.sh` file (for Linux/Solaris). The default entity expansion limit is 64000.

``` java
-DentityExpansionLimit=10000
```

In a clustered environment, the entity expansion limit has no dependency on the number of worker nodes.

## WSO2 Carbon platform-level settings

In multi-tenant mode, the WSO2 Carbon runtime limits the thread execution time. That is, if a thread is stuck or taking a long time to process, Carbon detects such threads, interrupts, and stops them. Note that Carbon prints the current stack trace before interrupting the thread. This mechanism is implemented as an Apache Tomcat valve. Therefore, it should be configured in the `<PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml` file as shown below.

``` xml
<Valve className="org.wso2.carbon.tomcat.ext.valves.CarbonStuckThreadDetectionValve" threshold="600"/>
```

-   The `className` is the Java class used for the implementation. Set it to `org.wso2.carbon.tomcat.ext.valves.CarbonStuckThreadDetectionValve`.
-   The `threshold` gives the minimum duration in seconds after which a thread is considered stuck. The default value is 600 seconds.

## API-M-level settings

### Timeout configurations for an API call

The following diagram shows the communication/network paths that occur when an API is called. The timeout configurations for each network call are explained below.

![]({{base_path}}/assets/img/setup-and-install/gateway-to-keymanager-ws-call.png)

!!! info
    The Gateway to Key Manager network call to validate the token only happens with the OAuth token. This network call does not happen for JSON Web Tokens (JWTs). JWT access tokens are the default token type for applications. As JWTs are self-contained access tokens, the Key Manager is not needed to validate the token, and the token is validated from the Gateway.

-   **Client call Universal Gateway + Universal Gateway call Backend**

    For backend communication, the API Manager uses PassThrough transport. This is configured in the `<API-M_HOME>/repository/conf/deployment.toml` file. For more information, see [Configuring PassThrough properties]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-httphttps-transport). Add the following section to the `deployment.toml` file to configure the Socket timeout value.
            ``` java
                [passthru_http]
                http.socket.timeout=180000
            ```

    !!! info
        The default value for `http.socket.timeout` differs between WSO2 products. In WSO2 API-M, the default value for `http.socket.timeout` is 180000ms.


### General API-M-level recommendations

Some general API-M-level recommendations are listed below:

<table>
<thead>
<tr class="header">
<th><b>Improvement Area</b></th>
<th><b>Performance Recommendations</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Universal Gateway nodes</td>
<td><div class="content-wrapper">
<p>Increase memory allocated by modifying the <code>/bin/api-manager.sh</code>  file with the following setting:</p>
<table>
<tr class="odd">
<td>
<ul>
<li><code> -Xms2048m -Xmx2048m -XX:MaxPermSize=1024m </code></li>
</ul>
<p>Set the following in the <code>               &lt;API-M_HOME&gt;/repository/conf/deployment.toml              </code> file:</p>

<div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>
     The default values mentioned are the values identified at the time of releasing API-M. However, if you want high concurrency, use the values mentioned below:</p>

</div>
     <div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;"  style="brush: java; gutter: false;"><code>
[transport.client]
default_max_connection_per_host = 1000
max_total_connections = 30000 
</code>
</pre>
</div>

<p><strong>Transport Client Configuration Details:</strong></p>
<p>The <code>[transport.client]</code> section configures the HTTP client used by the API Gateway for outbound connections to backend services and internal components.</p>

<ul>
<li><p><strong>default_max_connection_per_host:</strong> Defines the maximum number of concurrent connections that can be established to a single backend host/endpoint. This prevents any single backend service from consuming all available connections. The default value of 1000 connections per host is suitable for high-throughput scenarios where individual backend services can handle substantial concurrent load.</p></li>

<li><p><strong>max_total_connections:</strong> Sets the total maximum number of concurrent connections that the HTTP client connection pool can maintain across all backend hosts combined. This global limit prevents the Gateway from exhausting system resources by creating too many simultaneous connections. The value of 30000 provides a large pool suitable for environments with multiple backend services and high concurrent API traffic.</p></li>
</ul>

<p>These configurations are critical for:</p>
<ul>
<li>Optimizing connection reuse and reducing connection establishment overhead</li>
<li>Preventing connection exhaustion under high load</li>
<li>Ensuring balanced connection distribution across multiple backend services</li>
<li>Supporting high-concurrency API traffic patterns in production environments</li>
</ul>
</td>
</tr>
<tr class="odd">
<td>
<p>
For the default JWT tokens (from APIM 3.2.0 onwards, the default token type is JWT), the key validation takes place within GW node itself, as the JWT token is self-contained. So no key validation call is made for JWT tokens.
But if the token used is a reference token (if the deployment is migrated from older version which used reference tokens), the key validation http calls will be made to the Key manager component for token introspection. A dedicated http client is used for this purpose.
</p>
<div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>
     Because of this architecture, the axis2 based client, which is used in older APIM versions is not used further on. So previous axis2 based configs are not applicable for key validation in APIM 3.2.0 onwards.
     </p>
</div>
<p>The configurations related to this http client are as below with the default recommended values.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;" style="brush: java; gutter: false;">
<code>[apim.http_client]
max_total = 100
default_max_per_route = 50
</code>
</pre>
</div>
</div>
<p><b>max_total:</b> The maximum number of connections that will be created for the key validation calls. If there is a considerable latency, the connections in use at a given time will take a long time to be released and added back to the connection pool. As a result, connections may not be available for some requests. In such situations, it is recommended to increase the value for this parameter.</p>
<p><b>default_max_per_route:</b> The maximum number of connections that will be created per host server by the client. Will have to increase this too, when required as similarly for the config <b>max_total</b>. </p>
</td>
</tr>
</table>

</td>
</tr>
<tr class="even">
<tr class="odd">
<td>PassThrough transport of Universal Gateway</td>
<td><p>Recommended values for the <code>&lt;API-M_HOME&gt;/repository/conf/deployment.toml</code> file are given below. Note that the commented out values in this file are the default values that will be applied if you do not change anything. These properties need to be added under <code>[passthru_http]</code> file.</p>
<p><strong>Property descriptions</strong></p>
<div class="table-wrap">
<table>
<colgroup>

</colgroup>
<tbody>
<tr class="odd">
<td><p><code style="white-space: nowrap;">worker_thread_keepalive_sec</code></p></td>
<td>Defines the keep-alive time for extra threads in the worker pool
</td>
</td>
</tr>
<tr class="even">
<td><code style="white-space: nowrap;">worker_pool_queue_length</code></td>
<td>Defines the length of the queue that is used to hold runnable tasks to be executed by the worker pool</td>
</tr>
<tr class="odd">
<td><code style="white-space: nowrap;">io_threads_per_reactor</code></td>
<td>Defines the number of IO dispatcher threads used per reactor 
</td>
</td>
</tr>
<tr class="even">
<td><p><code style="white-space: nowrap;"> 'http.max.connection.per.host.port'</code></p></td>
<td>Defines the maximum number of connections per host port</td>
</tr>
<tr class="odd">
<td><code>'http.connection.timeout'</code></td>
<td>Defines a maximum time period to establish a connection with the remote host. The <code>http.connection.timeout</code> and the <code>http.socket.timeout</code>, which is explained below, are two different configuration definitions used to handle connection time out and read timeout for Sockets respectively. 
</td>
</tr>
<tr class="even">
<td><p><code>'http.socket.timeout'</code></p></td>
<td>Defines the waiting time for data after establishing the connection, which refers to the maximum time of inactivity between two data packets.
</td>
</tr>
</tbody>
</table>
</div>
<p><strong>Recommended values</strong></p>
<ul>
<li><p><code>                worker_thread_keepalive_sec:               </code> Default value is 60s. This should be less than the Socket timeout.</p></li>
<li><p><code>                worker_pool_queue_length:               </code> Set to -1 to use an unbounded queue. If a bound queue is used and the queue gets filled to its capacity, any further attempts to submit jobs will fail, causing some messages to be dropped by Synapse. The thread pool starts queuing jobs when all the existing threads are busy and when the pool has reached the maximum number of threads. So, the recommended queue length is -1.</p></li>
<li><p><code>                io_threads_per_reactor:               </code> Value is based on the number of processor cores in the system. (<code>Runtime.getRuntime().availableProcessors()</code>)</p></li>
<li><p><code>                'http.max.connection.per.host.port' :               </code> Default value is 32767, which works for most systems, but you can tune it based on your operating system (for example, Linux supports 65K connections).</p></li>
<li><code>               core_worker_pool_size: 400              </code></li>
<li><code>               max_worker_pool_size: 500              </code></li>
<li><code>               io_buffer_size: 16384              </code></li>
<li><code>               'http.socket.timeout' : 180000              </code></li>
</ul>

<div class="admonition tip">
     <p class="admonition-title">Tip</p>
     <p>
     Make the number of threads equal to the number of processor cores.</p>
</div>
</td>
</tr>
<tr class="even">
<td>Timeout configurations</td>
<td><div class="content-wrapper">
<p>The Universal Gateway routes the requests from your client to an appropriate endpoint. The most common reason for your client getting a timeout is when the Gateway's timeout is larger than the client's timeout values. You can resolve this by either increasing the timeout on the client's side or by decreasing it on the Universal Gateway's side.</p>
<p>Here are a few parameters, in <strong>addition to the timeout parameters discussed in the previous sections</strong>.</p>
<div class="table-wrap">
<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><code style="white-space: nowrap;"><br />Synapse global <br />timeout interval</code></td>
<td><p>Defines the maximum time that a callback waits in the Gateway for a response from the backend. If no response is received within this time, the Gateway drops the message and clears out the callback. This is a global level parameter that affects all the endpoints configured in the Gateway.</p>
<p>The global timeout is defined in the <code>                    &lt;API-M_HOME&gt;/repository/conf/deployment.toml                   </code> file. The recommended value is 120000 ms.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;" style="brush: java; gutter: false;"><code>
[synapse_properties]
'synapse.global_timeout_interval' = 120000
</code></pre>
</div>
</div>


 </td>
</td>
</tr>
<tr class="even">
<td><code style="white-space: nowrap;"><br />Endpoint-level <br />timeout</code></td>
<td><div class="content-wrapper">
<p>You can define timeouts per endpoint for different backend services, along with the action to be taken in case of a timeout.</p>
<p>You can set this through the Publisher UI by following the steps below:</p>
<ol>
<li>Sign in to the API Publisher (<code>https://&lt;HostName&gt;:9443/publisher</code>). Select your API and click <strong>Endpoints</strong>.</li>
<li>Click the cogwheel icon next to the endpoint you want to re-configure.</li>
<li><p>In the <strong>Advanced Settings</strong> dialog box that appears, increase the duration by modifying the default property set as 3000 ms.</p>

<div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>Note that when the endpoint is suspended, the default action is defined here as invoking the fault sequence.</p>
</div> 
<p><img src="{{base_path}}/assets/img/setup-and-install/timeout-configuration.png" alt="timeout-configuration.png" width="734" /></p></li>
<li><p>Click <strong>Save</strong>.</p></li>
</ol>
<div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The <code>                     http.socket.timeout                    </code> parameter needs to be adjusted based on the endpoint-level timeout so that it's value is equal or higher than the highest endpoint-level timeout.</p>
</div>
<div class="admonition warning">
     <p class="admonition-title">Warning</p>
<p>If your API is marked as the default version</a>, it has a different template (without the version number) that comes with a predefined timeout for the endpoint. This timeout does not change with the changes you do to the API by editing the Advanced Endpoint Configuration. Therefore, if this predefined timeout (60 seconds) is less than the actual API timeout, it triggers the timeout before the actual configured API timeout.</p>
<p>To overcome this, update the <code>                     default_api_template.xml                    </code> residing in the <code>                     &lt;API-M_HOME&gt;/repository/resources/api_templates                    </code> directory by removing the endpoint timeout configuration from the default API. Then, the APIs marked as the default version also trigger the timeout when the actual API timeout is met.</p>
<p>Follow the steps below to update the <code>                     default_api_template.xml                    </code> to remove the endpoint configuration for the default APIs.</p>
<div class="admonition tip">
    <p class="admonition-title">Tip</p>
    <p>If you are using a distributed (clustered) setup, follow these steps in the Publisher node as it is the API Publisher that creates the API definition and pushes it to the Gateway.</p>
</div> 


<ol>
<li><p>Open the <code style="white-space: nowrap;">                       &lt;API-M_HOME&gt;/repository/resources/api_templates/default_api_template.xml                      </code> file and remove the following configuration:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;" style="brush: java; gutter: false;"><code>&lt;timeout&gt;
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
 

</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;" style="brush: java; gutter: false;"><code>&lt;suspendOnFailure&gt;
    &lt;errorCodes&gt;-1&lt;/errorCodes&gt;
    &lt;initialDuration&gt;0&lt;/initialDuration&gt;
    &lt;progressionFactor&gt;1.0&lt;/progressionFactor&gt;
    &lt;maximumDuration&gt;0&lt;/maximumDuration&gt;
&lt;/suspendOnFailure&gt;
&lt;markForSuspension&gt;
    &lt;errorCodes&gt;-1&lt;/errorCodes&gt;
&lt;/markForSuspension&gt;</code></pre>
</div>
</div>
<div class="admonition info">
    <p class="admonition-title">Info</p>
    <p>By adding this configuration, you ensure that the APIs marked as the default version never timeout or are suspended using the endpoint configuration defined in the synapse file of the API.</p>
</div></li>

<li><p>Go to the API Publisher and republish the default API by clicking <strong>Save and Publish</strong>.</p></li>
</ol>
</div>
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
<pre class="html/xml" data-syntaxhighlighter-params="brush: html/xml; gutter: false;" style="brush: html/xml; gutter: false"><code>mysql&gt; show variables like &quot;max_connections&quot;; 
 max_connections was 151 
 set to global max_connections = 250; </code></pre>
</div>
</div>
<p>Set the open files limit to 200000 by editing the <code>               /etc/sysctl.conf              </code> file:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;" style="brush: java; gutter: false;"><code>sudo sysctl -p</code></pre>
</div>
</div>
<p>Set the following in the <code>               &lt;API-M_HOME&gt;/repository/conf/deployment.toml              </code> file.</p>
<div class="admonition info">
    <p class="admonition-title">Info</p>
    <p>If you use WSO2 Identity Server (WSO2 IS) as the Key Manager, then the root location of the above path and the subsequent path needs to change from <code>               &lt;API-M_HOME&gt;              </code> to <code>               &lt;IS_HOME&gt;</code>.</p>
</div>


<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;" style="brush: java; gutter: false;"><code>[transport.https.properties]
maxThreads="750" 
minSpareThreads="150" 
disableUploadTimeout="false" 
enableLookups="false" 
connectionUploadTimeout="120000" 
maxKeepAliveRequests="600" 
acceptCount="600" </code></pre>
</div>
</div>
<p>Set the following connection pool elements in the same file. Time values are defined in milliseconds.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false;" style="brush: java; gutter: false;"><code>
[database.apim_db.pool_options]
maxActive = 51
maxWait = 60001
testOnBorrow = true
validationInterval = 30001

[database.apim_db]
validationQuery = "SELECT 2"
</code></pre>
</div>
</div>
<p>Note that you set the <code>               &lt;testOnBorrow&gt;              </code> element to <code>               true              </code> and provide a validation query (e.g., in Oracle, <code>               SELECT 1 FROM DUAL              </code> ), which is run to refresh any stale connections in the connection pool. Set a suitable value for the <code>               &lt;validationInterval&gt;              </code> element, which defaults to 30000 milliseconds. It determines the time period, after which the next iteration of the validation query will be run on a particular connection. It avoids excess validations and ensures better performance.</p>
</div></td>
</tr>
</tbody>
</table>

### Registry indexing configurations

The registry indexing process, which indexes the APIs in the Registry, is only required to be run on the API Publisher and Developer Portal nodes. To disable the indexing process from running on the other nodes (Gateways and Key Managers), you need to add the following configuration section in the `<API-M_HOME>/repository/conf/deployment.toml` file.

```java
[indexing]
enable = false
```

### Optimizing database indexing for case-sensitive and case-insensitive user stores

One key aspect of performance optimization is database indexing. While API Manager includes essential database indexes in its default database scripts, certain scenarios may require additional indexing. Database Administrators (DBAs) are responsible for implementing these additional indexes to ensure optimal performance.

For user stores configured with case-insensitive usernames in databases such as Oracle, PostgreSQL, or SQL Server, the DBA should create the necessary indexes using the `LOWER(UM_USER_NAME)` function.

If a case-sensitive database is in use, only the indexes listed below should be added. Note that these indexes may not cover all possible indexing needs.

```sql
[apim_db]
CREATE INDEX IDX_AT_CK_AU_LO ON IDN_OAUTH2_ACCESS_TOKEN(CONSUMER_KEY_ID, LOWER(AUTHZ_USER), TOKEN_STATE, USER_TYPE);
CREATE INDEX IDX_AT_TI_UD_LO ON IDN_OAUTH2_ACCESS_TOKEN(LOWER(AUTHZ_USER), TENANT_ID, TOKEN_STATE, USER_DOMAIN);
CREATE INDEX IDX_AT_AU_TID_UD_TS_CKID_LO ON IDN_OAUTH2_ACCESS_TOKEN(LOWER(AUTHZ_USER), TENANT_ID, USER_DOMAIN, TOKEN_STATE, CONSUMER_KEY_ID);
CREATE INDEX IDX_AT_AU_CKID_TS_UT_LO ON IDN_OAUTH2_ACCESS_TOKEN(LOWER(AUTHZ_USER), CONSUMER_KEY_ID, TOKEN_STATE, USER_TYPE);
CREATE INDEX IDX_AT_CIDAUTID_UD_TSH_TS_LO ON IDN_OAUTH2_ACCESS_TOKEN(CONSUMER_KEY_ID, LOWER(AUTHZ_USER), TENANT_ID, USER_DOMAIN, TOKEN_SCOPE_HASH, TOKEN_STATE);
CREATE INDEX IDX_AUTH_CODE_AU_TI_LO ON IDN_OAUTH2_AUTHORIZATION_CODE (LOWER(AUTHZ_USER), TENANT_ID, USER_DOMAIN, STATE);
CREATE INDEX IDX_AUTH_USER_UN_TID_DN_LO ON IDN_AUTH_USER (LOWER(USER_NAME), TENANT_ID, DOMAIN_NAME);
CREATE INDEX IDX_OCA_UM_TID_UD_APN_LO ON IDN_OAUTH_CONSUMER_APPS(LOWER(USERNAME),TENANT_ID,USER_DOMAIN, APP_NAME);
CREATE INDEX INDEX_IDN_USER_DK_LO_UNIQUE ON IDN_IDENTITY_USER_DATA (TENANT_ID, LOWER(USER_NAME), DATA_KEY);
CREATE INDEX INDEX_IDN_USER_LO_UNIQUE ON IDN_IDENTITY_USER_DATA (TENANT_ID, LOWER(USER_NAME));

[shared_db]
CREATE INDEX IDX_UU_LO_UI_UUN_TI ON UM_USER(UM_ID,LOWER(UM_USER_NAME),UM_TENANT_ID);
CREATE INDEX INDEX_UM_USER_LO_UNIQUE ON UM_USER (LOWER(UM_USER_NAME), UM_TENANT_ID);
CREATE INDEX INDEX_UM_SYSTEM_USER_LO_UNIQUE ON UM_SYSTEM_USER (LOWER(UM_USER_NAME), UM_TENANT_ID);
CREATE INDEX INDEX_UM_ACC_MAPPING_LO_UNIQUE ON UM_ACCOUNT_MAPPING (LOWER(UM_USER_NAME), UM_TENANT_ID, UM_USER_STORE_DOMAIN, UM_ACC_LINK_ID);
CREATE INDEX INDEX_UM_HYBRID_UR_LO_UNIQUE ON UM_HYBRID_USER_ROLE (LOWER(UM_USER_NAME), UM_ROLE_ID, UM_TENANT_ID);
CREATE INDEX INDEX_UM_SYSTEM_UR_LO_UNIQUE ON UM_SYSTEM_USER_ROLE (LOWER(UM_USER_NAME), UM_ROLE_ID, UM_TENANT_ID);
```

For case-insensitive databases like MySQL or MSSQL, add the following configuration to avoid using the `LOWER` function in queries. This configuration should be applied across all user stores that function as case-insensitive databases, and API Manager must be restarted afterward for the changes to take effect.

In the `<APIM_HOME>/repository/conf` directory, set the following property to `false` in the `deployment.toml` file, according to the specific user store.

```toml
[user_store]
properties.CaseInsensitiveUsername = false
properties.UseCaseSensitiveUsernameForCacheKeys = false
```
