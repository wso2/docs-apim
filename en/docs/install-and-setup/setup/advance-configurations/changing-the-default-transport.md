# Changing the Default Transport

APIs are made up of Apache Synapse configurations that WSO2 API Manager accesses through a transport protocol. The default API Manager transport is the PassThrough transport, but you can configure a different default transport in your `deployment.toml` file.

!!! info
    WSO2 API Manager does not use the HTTP/S servlet transport protocol configurations that are in the `axis2.xml` file. Instead, WSO2 API Manager's Management Console uses the Tomcat-level servlet transport protocols that are available in the `<API-M_HOME>/repository/conf/tomcat/catalina-server.xml` file.


The following topics provide more information on these transports:

-   [HTTP PassThrough Transport](#http-passthrough-transport)
-   [Transport Receiver Parameters](#transport-receiver-parameters)
-   [Transport Sender Parameters](#transport-sender-parameters)
-   [Connection Throttling](#connection-throttling)

### HTTP PassThrough Transport

HTTP PassThrough Transport is the default, non-blocking HTTP transport implementation based on HTTP Core NIO and is specially designed for streaming messages. It is similar to the old message relay transport, but it does not take the content type into consideration and simply streams all the messages that it receives. It also has a simpler and cleaner model for forwarding messages back and forth. The two classes that implement the receiver and sender APIs are `org.apache.synapse.transport.passthru.PassThroughHttpListener` and `org.apache.synapse.transport.passthru.PassThroughHttpSender`, respectively. The PassThrough Transport does not require the binary relay builder and expanding formatter.

### Transport Receiver Parameters

<table>
<colgroup>
<col width="15%" />
<col width="35%" />
<col width="10%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>port</p></td>
<td><p>The port on which this transport receiver should listen for incoming messages.</p></td>
<td><p>No</p></td>
<td><p>A positive integer less than 65535</p></td>
<td><p>8280</p></td>
</tr>
<tr class="even">
<td><p>non-blocking</p></td>
<td><p>Setting this parameter to true is vital for reliable messaging and a number of other scenarios to work properly.</p></td>
<td><p>Yes</p></td>
<td><p><code>              true             </code> or <code>              false             </code> <em><br />
</em></p></td>
<td><p><code>              true             </code></p></td>
</tr>
<tr class="odd">
<td><p>bind-address</p></td>
<td><p>The address of the interface to which the transport listener should bind.</p></td>
<td><p>No</p></td>
<td><p>A host name or an IP address</p></td>
<td><p>127.0.0.1</p></td>
</tr>
<tr class="even">
<td><p>WSDLEPRPrefix</p></td>
<td><p>A URL prefix which will be added to all service EPRs and EPRs in WSDLs etc.</p></td>
<td><p>No</p></td>
<td><p>A URL of the form &lt;protocol&gt;://&lt;hostname&gt;:&lt;port&gt;/</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>httpGetProcessor</p></td>
<td><p>An extension point used to execute a special interceptor for HTTP GET requests.</p></td>
<td><p>Yes</p></td>
<td><p>An extension point</p></td>
<td><p><code>              org.wso2.carbon.mediation.transport.handlers                            .PassThroughNHttpGetProcessor             </code></p></td>
</tr>
<tr class="even">
<td><p>priorityConfigFile</p></td>
<td><p>The location of the file containing the configuration for priority based dispatching.</p></td>
<td><p>No</p></td>
<td><p>A file location</p></td>
<td></td>
</tr>
</tbody>
</table>

### Transport Sender Parameters

<table>
<colgroup>
<col width="15%" />
<col width="35%" />
<col width="10%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>non-blocking</p></td>
<td><p>Setting this parameter to true is vital for reliable messaging and a number of other scenarios to work properly.</p></td>
<td>Yes</td>
<td><code>             true            </code> or <code>             false            </code></td>
<td><code>             true            </code></td>
</tr>
<tr class="even">
<td>warnOnHTTP500</td>
<td>Logs warnings for HTTP 500 responses only for the specified content-types. For example,
<p><code>              &lt;parameter name=&quot;warnOnHTTP500 locked=&quot;false&quot;&gt;x-application/hessian|none&lt;/parameter&gt;             </code> would log warnings for HTTP 500 responses of content-type 'x-application/hessian' or messages missing a content-type.</p></td>
<td>No</td>
<td>A list of content types separated by &quot;|&quot;</td>
<td></td>
</tr>
<tr class="odd">
<td><p>http.proxyHost</p></td>
<td><p>If the outgoing messages should be sent through an HTTP proxy server, use this parameter to specify the target proxy.</p></td>
<td><p>No</p></td>
<td><p>A host name or an IP address</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>http.proxyPort</p></td>
<td><p>The port through which the target proxy accepts HTTP traffic.</p></td>
<td><p>No</p></td>
<td><p>A positive integer less than 65535</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>http.nonProxyHosts</p></td>
<td><p>The list of hosts to which the HTTP traffic should be sent directly without going through the proxy.</p></td>
<td><p>No</p></td>
<td><p>A list of host names or IP addresses separated by '|'</p></td>
<td><p></p></td>
</tr>
</tbody>
</table>

### Connection Throttling

Using the HTTP PassThrough transport protocol, you can enable connection throttling to restrict the number of simultaneous open connections. To enable connection throttling, edit the `<APIM_HOME>/repository/conf/deployment.toml` and add the following configuration under `passthough_http` configurations.
    ``` java
        [passthru_http]
        max_open_connections = 2
    ```


This will restrict simultaneous open incoming connections to 2. To disable throttling, delete the `max_open_connections` setting or set it to -1.

!!! info
    Connection throttling is never exact. For example, setting this property to 2 will result in roughly two simultaneous open connections at any given time.

!!! Note "The following configurations should be added to the deployment.toml file in order to apply the changes"
    HTTP Transport Receiver Parameters
    ```
    [transport.passthru_http.listener.parameters]
    port=7003
    ```
    
    HTTP Transport Sender Parameters
    ```
    [transport.passthru_http.sender.parameters]
    non-blocking=false
    ```
    
    HTTPS Transport Receiver Parameters
    ```
    [transport.passthru_https.listener.parameters]
    port=7003
    ```

    HTTPS Transport Sender Parameters
    ```
    [transport.passthru_https.sender.parameters]
    non-blocking=false
    ```


