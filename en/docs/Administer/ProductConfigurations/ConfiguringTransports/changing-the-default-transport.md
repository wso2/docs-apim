# Changing the Default Transport

On the back end, APIs are Apache Synapse configurations that WSO2 API Manager accesses through a transport. The default API Manager transport is the PassThrough transport, but you can configure a different default transport in your `         axis2.xml        ` file. For example, to use the HTTP-NIO transport as the default, go to the `         <APIM_HOME>/repository/conf/axis2        ` folder, open the `         axis2.xml        ` file, and then in the "Transport Ins" and "Transport Outs" sections, comment out the PassThrough configurations and uncomment the configurations for the HTTP-NIO transport.

!!! info
WSO2 products do not use the HTTP/S servlet transport configurations that are in `         axis2.xml        ` file. Instead, they use Tomcat-level servlet transports, which are used by the management console in `         <PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml        ` file .


The following topics provide more information on these transports:

-   [HTTP PassThrough transport](#ChangingtheDefaultTransport-HTTPPassThroughtransport)
-   [HTTP-NIO transport](#ChangingtheDefaultTransport-HTTP-NIOtransport)
-   [Transport receiver parameters](#ChangingtheDefaultTransport-Transportreceiverparameters)
-   [Transport sender parameters](#ChangingtheDefaultTransport-Transportsenderparameters)
-   [Connection throttling](#ChangingtheDefaultTransport-Connectionthrottling)

### HTTP PassThrough transport

HTTP PassThrough Transport is the default, non-blocking HTTP transport implementation based on HTTP Core NIO and is specially designed for streaming messages. It is similar to the old message relay transport, but it does not care about the content type and simply streams all received messages through. It also has a simpler and cleaner model for forwarding messages back and forth. The two classes that implement the receiver and sender APIs are `         org.apache.synapse.transport.passthru.PassThroughHttpListener        ` and `         org.apache.synapse.transport.passthru.PassThroughHttpSender        ` , respectively. The PassThrough Transport does not require the binary relay builder and expanding formatter.

### HTTP-NIO transport

The HTTP-NIO transport is a module of the Apache Synapse project. Apache Synapse ships the HTTP-NIO transport as the default, non-blocking HTTP transport implementation. The two classes that implement the receiver and sender APIs are `         org.apache.synapse.transport.nhttp.HttpCoreNIOListener        ` and `         org.apache.synapse.transport.nhttp.HttpCoreNIOSender        ` , respectively. These classes are available in the JAR file named `         synapse-nhttp-transport.jar        ` . The transport implementation is based on Apache HTTP Core - NIO and uses a configurable pool of non-blocking worker threads to grab incoming HTTP messages off the wire. The PassThrough transport is the preferred default transport for WSO2 API Manager, but HTTP-NIO is supported for backward compatibility.

### Transport receiver parameters

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
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

### Transport sender parameters

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
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

### Connection throttling

With the HTTP PassThrough and HTTP NIO transports, you can enable connection throttling to restrict the number of simultaneous open connections. To enable connection throttling, edit the `         <PRODUCT_HOME>/repository/conf/nhttp.properties        ` (for the HTTP NIO transport) or `         <PRODUCT_HOME>/repository/conf/passthru.properties        ` (for the PassThrough transport) and add the following line: `         max_open_connections = 2        `

This will restrict simultaneous open incoming connections to 2. To disable throttling, delete the `         max_open_connections        ` setting or set it to -1.

!!! info
Connection throttling is never exact. For example, setting this property to 2 will result in roughly two simultaneous open connections at any given time.


