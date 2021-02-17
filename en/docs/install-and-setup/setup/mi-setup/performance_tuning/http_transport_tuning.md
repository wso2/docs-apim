# Tuning the HTTP Transport

See the following topics to tune the HTTP passthrough transport:

## Tuning non-blocking invocations

You can improve performance of your non-blocking invocations by configuring the following parameters related to the HTTP Pass Through transport in the deployment.toml file (stored in the `MI_HOME/conf` directory):

```toml
[transport.http]
socket_timeout = 180000
core_worker_pool_size = 400
max_worker_pool_size = 400
worker_pool_queue_length = -1
io_buffer_size = 16384
max_http_connection_per_host_port = 32767
preserve_http_user_agent = false
preserve_http_headers = ["Content-Type"]
```
See the [descriptions](../../../references/config-catalog/#http-transport) of these parameters.

<!--

## Configuring passthru-http.properties

You can configure the following properties as required in the `         <EI_Home>/conf/passthru-http.properties        ` file:

<table>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
<th>Default Value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>             ****** worker_pool_size_core             </code></p></td>
<td><p>WSO2 Micro Integrator uses a thread pool executor to create threads and to handle incoming requests. This parameter controls the number of core threads used by the executor pool. If you increase this parameter value, the number of requests received that can be processed by the integrator increases, hence, the throughput also increases. The nature of the integration scenario and the number of concurrent requests received by the integrator are the main factors that helps to determine this parameter.</p></td>
<td>400</td>
</tr>
<tr class="even">
<td><p><code>              ***** worker_pool_size_max             </code></p></td>
<td>This is the maximum number of threads in the worker thread pool. Specifying a maximum limit avoids performance degradation that can occur due to context switching. If the specified value is reached, you will see the error 'SYSTEM ALERT - HttpServerWorker threads were in BLOCKED state during last minute'. This can occur due to an extraordinarily high number of requests sent at a time when all the threads in the pool are busy, and the maximum number of threads is already reached.</td>
<td>500</td>
</tr>
<tr class="odd">
<td><p><code>             ****** http.socket.timeout             </code></p></td>
<td>This is the maximum period of inactivity between two consecutive data packets, specified in milliseconds.</td>
<td>120000</td>
</tr>
<tr class="even">
<td><p><code>              worker_thread_keepalive_sec             </code></p></td>
<td>This defines the keep-alive time for extra threads in the worker pool. The value specified here should be less than the socket timeout value. Once this time has elapsed for an extra thread, it will be destroyed. The purpose of this parameter is to optimize the usage of resources by avoiding wastage that results by having unutilized extra threads.</td>
<td>60</td>
</tr>
<tr class="odd">
<td><p><code>            *******  worker_pool_queue_length             </code></p></td>
<td>This defines the length of the queue that is used to hold runnable tasks to be executed by the worker pool. The thread pool starts queuing jobs when all the existing threads are busy, and the pool has reached the maximum number of threads. The value for this parameter should be -1 to use an unbound queue. If a bound queue is used and the queue gets filled to its capacity, any further attempts to submit jobs fail causing some messages to be dropped by Synapse.</td>
<td>-1</td>
</tr>
<tr class="even">
<td><p><code>              io_threads_per_reactor             </code></p></td>
<td>This defines the number of IO dispatcher threads used per reactor. The value specified should not exceed the number of cores in the server.</td>
<td>The default value is equal to number of cores in the server.</td>
</tr>
<tr class="odd">
<td><p><code>             ******** io_buffer_size             </code></p></td>
<td>This is the value of the memory buffer allocated when reading data into the memory from the underlying socket/file channels. You should leave this property set to the default value.</td>
<td>16384</td>
</tr>
<tr class="even">
<td><p><code>           *******   http.max.connection.per.host.port             </code></p></td>
<td>This defines the maximum number of connections allowed per host port.</td>
<td>32767</td>
</tr>
<tr class="odd">
<td><p><code>              http.socket.reuseaddr             </code></p></td>
<td>If this parameter is set to true, it is possible to open another socket on the same port as the socket that is currently used by the EI server to listen to connections. This is useful when recovering from a crash. In such instances, if the socket is not properly closed, a new socket can be opened to listen to connections.</td>
<td><code>             true            </code></td>
</tr>
<tr class="even">
<td><p><code>              http.socket.buffer-size             </code></p></td>
<td>This is used to configure the SessionInputBuffer size of http core. The SessionInputBuffer is used to fill data that is read from the OS socket. This parameter does not affect the OS socket buffer size.</td>
<td>8192</td>
</tr>
<tr class="odd">
<td><p><code>              http.block_service_list             </code></p></td>
<td>If this parameter is set to true, all services deployed to WSO2 EI cannot be accessed via the http <code>             :&lt;EI&gt;:8240/services/            </code> and <code>             https:&lt;EI&gt;:8243/services/            </code> URls.</td>
<td><code>             true            </code></td>
</tr>
<tr class="even">
<td><code>          *******   http.user.agent.preserve            </code></td>
<td>If this parameter is set to true, the user-agent HTTP header of messages passing through the integrator is preserved and printed in the outgoing message.</td>
<td><code>             false            </code></td>
</tr>
<tr class="odd">
<td><p><code>            ******  http.headers.preserve             </code></p></td>
<td><div class="content-wrapper">
<p>This parameter allows you to specify the header field/s of messages passing through the EI that need to be preserved and printed in the outgoing message such as <code>Location</code>, CommonsHTTPTransportSenderKeep-Alive<code>, <code>Date</code>, <code>Server</code>, <code>User-Agent</code>, and <code>Host</code>. For example, <code>http.headers.preserve = Location, Date, Server</code>.</p>
!!! note
<b>Note</b>: When uploading files using this property, if you run into any header dropping issues such as content type (or any other headers) not passing to back end or media type (charset) being missing at the Pass Through Transport level, add the <code>http.headers.preserve = Content-Type</code> property and restart the server.
When you add the <code>http.headers.preserve=Content-Length</code> property, if the client sends a chunked request (with the <code>Transfer-Encoding: chunked</code> header), the integrator forwards it to the backend. Else, if the client sends a request with the <code>Content-Length</code> header, the integrator forwards that header to the backend. Thus, if you are changing the message payload before sending it to the backend, the request will fail as the content length you sent is not the actual content length of the message.</p>
<div>
The main difference between using this property and using the <a href="https://docs.wso2.com/display/EI650/HTTP+Transport+Properties"><code>                FORCE_HTTP_CONTENT_LENGTH               </code> and <code>                COPY_CONTENT_LENGTH_FROM_INCOMING               </code></a> properties together in an API/proxy service is that <code>               http.headers.preserve=Content-Length              </code> property applies at a global (server) level, whereas, you can use the other two properties to have this behaviour locally in the API/proxy service.
</div>

</div></td>
<td><code>             Content-Type            </code></td>
</tr>
<tr class="even">
<td><p><code>           *******   http.connection.disable.keepalive             </code></p></td>
<td>If this parameter is set to true, the HTTP connections with the back end service are closed soon after the request is served. It is recommended to set this property to false so that the integrator does not have to create a new connection every time it sends a request to a back-end service. However, you may need to close connections after they are used if the back-end service does not provide sufficient support for keep-alive connections.</td>
<td><code>             false            </code></td>
</tr>
</tbody>
</table>
-->

## Tuning blocking invocations

The [Callout mediator](../.././references/mediators/callout-Mediator.md) as well
as the [Call mediator](../.././references/mediators/call-Mediator.md) in blocking
mode uses the axis2 `         CommonsHTTPTransportSender        `
internally to invoke services. It uses the
`         MultiThreadedHttpConnectionManager        ` to handle
connections, but by default it only allows two simultaneous connections
per host. So if there are more than two requests per host, the requests
have to wait until a connection is available. Therefore if the backend
service is slow, many requests have to wait until a connection is
available from the `         MultiThreadedHttpConnectionManager        `. This can lead to a significant degrade in the performance of WSO2 Micro Integrator.

In order to overcome this issue, setting the `defaultMaxConnectionsPerHost` parameter to `100` in the deployment.toml file (stored in the `MI_HOME/conf` directory).

```toml
[transport.blocking.http]
sender.enable_client_caching = true
sender.transfer_encoding = "chunked"
sender.default_connections_per_host = 100

```

<!--
``` xml
    <transportsender class="org.apache.axis2.transport.http.CommonsHTTPTransportSender" name="http">
            <parameter name="PROTOCOL">HTTP/1.1</parameter>
            <parameter name="Transfer-Encoding">chunked</parameter>
            <parameter name="cacheHttpClient">true</parameter>
            <parameter name="defaultMaxConnectionsPerHost">100</parameter>
    </transportsender>
```
-->

See the [descriptions](../../../references/config-catalog/#http-transport) of these parameters.
