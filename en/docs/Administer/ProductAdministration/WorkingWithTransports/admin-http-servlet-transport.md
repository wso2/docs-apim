# admin\_HTTP Servlet Transport

The HTTP and [HTTPS](https://docs.wso2.com/display/ADMIN44x/HTTPS+Servlet+Transport) transports in WSO2 products are based on Apache Tomcat's connector implementation. The connector configurations for both HTTP and HTTPS are available in the `catalina-server.xml` file (stored in the `<PRODUCT_HOME>/repository/conf/tomcat/` directory). The transport class that should be specified for each connector configuration in the `catalina-server.xml` file is as follows:

``` java
    <Connector protocol="org.apache.coyote.http11.Http11NioProtocol"/>
```

See the following topics for instructions on configuring this transport:

-   [Configuring the HTTP Connector Parameters](#admin_HTTPServletTransport-ConfiguringtheHTTPConnectorParameters)
-   [Defining multiple tomcat connectors](#admin_HTTPServletTransport-Definingmultipletomcatconnectors)

### Configuring the HTTP Connector Parameters

The following table lists the parameters that you can configure for the HTTP connector. Note that these are only a subset of the supported parameters. The servlet HTTP transport uses the [org.apache.catalina.connector.Connector](http://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/catalina/connector/Connector.html) implementation from Apache Tomcat. So the servlet HTTP transport actually accepts any parameter accepted by the connector implementation. For the complete list of supported parameters, see [Apache Tomcat's connector configuration reference](http://tomcat.apache.org/tomcat-7.0-doc/config/http.html) .

!!! tip
In the transport parameter tables, the literals displayed in italics under the "Possible Values" column should be considered as fixed literal constant values. Those values can be directly put into the transport configurations.


<table>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>port</p></td>
<td><p>The port over which this transport receiver listens for incoming messages.</p></td>
<td><p>A positive integer less than 65535</p></td>
<td><p>9763 for HTTP Connector</p>
<p>9443 for HTTPS Connector</p></td>
</tr>
<tr class="even">
<td>redirectPort</td>
<td>If this Connector is supporting non-SSL requests, and a request is received for which a matching <code>             &lt;security-constraint&gt;            </code> requires SSL transport, Catalina will automatically redirect the request to the port number specified here.</td>
<td>A positive integer less than 65535</td>
<td>9443</td>
</tr>
<tr class="odd">
<td>bindOnInit</td>
<td>Controls when the socket used by the connector is bound. By default it is bound when the connector is initiated and unbound when the connector is destroyed. If set to <code>             false            </code> , the socket will be bound when the connector is started and unbound when it is stopped.</td>
<td><br />
</td>
<td>false</td>
</tr>
<tr class="even">
<td><p>proxyPort</p></td>
<td><p>When used, this transport listener will accept messages arriving through a HTTP proxy server which listens on the specified proxy port. Apache <code>              mod_proxy             </code> should be enabled on the proxy server. All the WSDLs generated will contain the proxy port value as the listener port.</p></td>
<td><p>A positive integer less than 65535</p></td>
<td><p><br />
</p></td>
</tr>
<tr class="odd">
<td><p>maxHttpHeaderSize</p></td>
<td><p>The maximum size of the HTTP request and response header<br />
in bytes.</p></td>
<td><p>A positive integer</p></td>
<td><p>4096</p></td>
</tr>
<tr class="even">
<td>acceptorThreadCount</td>
<td>The number of threads to be used to accept connections. Increase this value on a multi CPU machine, although you would never really need more than <code>             2            </code> . Also, with a lot of non keep alive connections, you might want to increase this value as well.</td>
<td><br />
</td>
<td>2</td>
</tr>
<tr class="odd">
<td><p>maxThreads</p></td>
<td><p>The maximum number of worker threads created by the receiver to handle incoming requests. This parameter largely determines the number of concurrent connections that can be handled by the transport.</p></td>
<td><p>A positive integer</p></td>
<td><p>40</p></td>
</tr>
<tr class="even">
<td>minSpareThreads</td>
<td>The minimum number of threads always kept running. If not specified, the default will be used.</td>
<td><br />
</td>
<td>50</td>
</tr>
<tr class="odd">
<td><p>enableLookups</p></td>
<td><p>Use this parameter to enable DNS lookups in order to return the actual host name of the remote client. Disabling DNS lookups at transport level generally improves performance. By default, DNS lookups are disabled.<br />
</p></td>
<td><p><em>true, false</em></p></td>
<td><p>false</p></td>
</tr>
<tr class="even">
<td><p>disableUploadTimeout</p></td>
<td><p>This flag allows the servlet container to use a different, longer connection timeout while a servlet is being executed, which in the end allows either the servlet a longer amount of time to complete its execution, or a longer timeout during data upload.</p></td>
<td><p><em>true, false</em></p></td>
<td><p>true</p></td>
</tr>
<tr class="odd">
<td>connectionUploadTimeout</td>
<td>Specifies the timeout, in milliseconds, to use while a data upload is in progress. This only takes effect if <code>             disableUploadTimeout            </code> is set to <code>             false            </code> .</td>
<td><br />
</td>
<td><br />
</td>
</tr>
<tr class="even">
<td><p>clientAuth</p></td>
<td><p>Set to true if you want the SSL stack to require a valid certificate chain from the client before accepting a connection. Set to want if you want the SSL stack to request a client Certificate, but not fail if one is not present. A false value (which is the default) will not require a certificate chain unless the client requests a resource protected by a security constraint that uses CLIENT-CERT authentication.</p></td>
<td><p><em>true, false, want</em></p></td>
<td><p>false</p></td>
</tr>
<tr class="odd">
<td><p>maxKeepAliveRequests</p></td>
<td><p>The maximum number of HTTP requests which can be pipelined until the connection is closed by the server. Setting this attribute to 1 will disable HTTP/1.0 keep-alive, as well as HTTP/1.1 keep-alive and pipelining. Setting this to -1 will allow an unlimited amount of pipelined or keep-alive HTTP requests.</p></td>
<td><p>-1 or any positive integer</p></td>
<td><p>100</p></td>
</tr>
<tr class="even">
<td><p>acceptCount</p></td>
<td><p>The maximum queue length for incoming connection requests when all possible request processing threads are in use. Any requests received when the queue is full will be refused.</p></td>
<td><p>A positive integer</p></td>
<td><p>10</p></td>
</tr>
<tr class="odd">
<td>server</td>
<td>Overrides the Server header for the http response. If set, the value for this attribute overrides the Tomcat default and any Server header set by a web application. If not set, any value specified by the application is used.</td>
<td>Any string</td>
<td>WSO2 Carbon Server</td>
</tr>
<tr class="even">
<td><p>compression</p></td>
<td><p>The <strong>Connector</strong> may use HTTP/1.1 GZIP compression in an attempt to save server bandwidth.</p>
<p>The acceptable values for the parameter is &quot;off&quot; (disable compression), &quot;on&quot; (allow compression, which causes text data to be compressed), &quot;force&quot; (forces compression in all cases), or a numerical integer value (which is equivalent to &quot;on&quot;, but specifies the minimum amount of data before the output is compressed). If the content-length is not known and compression is set to &quot;on&quot; or more aggressive, the output will also be compressed. If not specified, this attribute is set to &quot;off&quot;.</p></td>
<td><p><em>on, off, force</em></p></td>
<td><p>off</p></td>
</tr>
<tr class="odd">
<td>compressionMinSize</td>
<td><p>If <strong>compression</strong> is set to &quot;on&quot; then this attribute may be used to specify the minimum amount of data before the output is compressed.</p></td>
<td>A positive integer</td>
<td>2048</td>
</tr>
<tr class="even">
<td><p>noCompressionUserAgents</p></td>
<td><p>Indicate a list of regular expressions matching user-agents of HTTP clients for which compression should not be used, because these clients, although they do advertise support for the feature, have a broken implementation.</p></td>
<td><p>A comma-separated list of<br />
regular expressions</p></td>
<td><p>empty string</p></td>
</tr>
<tr class="odd">
<td><p>compressableMimeType</p></td>
<td><p>Use this parameter to indicate a list of MIME types for which HTTP compression may be used.</p></td>
<td><p>A comma-separated list of<br />
valid mime types</p></td>
<td><p>text/html, text/xml, text/plain</p></td>
</tr>
<tr class="even">
<td>URIEncoding</td>
<td>This specifies the character encoding used to decode the URI bytes, after %xx decoding the URL.</td>
<td>URI encoding Character set name</td>
<td>ISO-8859-1</td>
</tr>
</tbody>
</table>

This servlet transport implementation can be further tuned up using the following parameters for **outbound connections** .

| Parameter Name    | Description                                                                                                                                                                        | Requried | Possible Values      | Default Value |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|----------------------|---------------|
| PROTOCOL          | The version of HTTP protocol to be used for outgoing messages.                                                                                                                     | No       | *HTTP/1.0, HTTP/1.1* | HTTP/1.1      |
| Transfer-Encoding | Effective only when the HTTP version is 1.1 (i.e. the value of the PROTOCOL parameter should be HTTP/1.1). Use this parameter to enable chunking support for the transport sender. | No       | *chunked*            | Not Chunked   |
| SocketTimeout     | The socket timeout value in milliseconds, for outbound connections.                                                                                                                | No       | A positive integer   | 60000 ms      |
| ConnectionTimeout | The connection timeout value in milliseconds, for outbound connections.                                                                                                            | No       | A positive integer   | 60000 ms      |
| OmitSOAP12Action  | Set this parameter to "true" if you need to disable the soap action for SOAP 1.2 messages.                                                                                         | No       | *true, false*        | false         |

### Defining multiple tomcat connectors

You have the option of defining multiple tomcat connectors in the `catalina-server.xml` file. Note that when you define multiple connectors, all the endpoints of the applications deployed in your WSO2 server will still be exposed through all the connector ports. However, you can configure your load balancer to ensure that only the relevant applications are exposed through the required connector port.

Therefore, you can use multiple connectors to strictly separate the applications deployed in your server as explained below.

1.  See the example given below where two connectors are defined in the `catalina-server.xml` file.

    ``` java
        <!-- Connector using port 9763 -->
         <Connector protocol="org.apache.coyote.http11.Http11NioProtocol"
                           port="9763"
                           ......
                           ....../>
        <!-- Connector using port 9764 -->
         <Connector protocol="org.apache.coyote.http11.Http11NioProtocol"
                           port="9764"
                           ......
                           ....../>
    ```

2.  Configure your load balancer so that the relevant applications are exposed through the required connector port.

