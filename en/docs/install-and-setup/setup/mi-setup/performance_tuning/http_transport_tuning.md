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
See the [descriptions]({{base_path}}/reference/config-catalog-mi) of these parameters.

## Tuning blocking invocations

The [Callout mediator]({{base_path}}/reference/mediators/callout-mediator) as well
as the [Call mediator]({{base_path}}/reference/mediators/call-mediator) in blocking
mode uses the axis2 `CommonsHTTPTransportSender`
internally to invoke services. It uses the
`MultiThreadedHttpConnectionManager` to handle
connections, but by default it only allows two simultaneous connections
per host. So if there are more than two requests per host, the requests
have to wait until a connection is available. Therefore if the backend
service is slow, many requests have to wait until a connection is
available from the `MultiThreadedHttpConnectionManager`. This can lead to a significant degrade in the performance of WSO2 Micro Integrator.

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

See the [descriptions]({{base_path}}/reference/config-catalog-mi#http-transport) of these parameters.
