# admin\_HTTPS Servlet Transport

Similar to the [HTTP transport](https://docs.wso2.com/display/ADMIN44x/HTTP+Servlet+Transport) , the HTTPS transport is also based on Apache Tomcat's connector implementation. Both the HTTP and HTTPS connector configurations are available in the `catalina-server.xml` file (stored in the `<PRODUCT_HOME>/repository/conf/tomcat/` directory). The transport class that should be specified for each connector configuration in the `catalina-server.xml` file is as follows:

``` java
    <Connector protocol="org.apache.coyote.http11.Http11NioProtocol"/>
```

See the following topics for instructions on configuring this transport:

-   [Configuring the HTTPS connector parameters](#admin_HTTPSServletTransport-ConfiguringtheHTTPSconnectorparameters)
-   [Defining multiple tomcat connectors](#admin_HTTPSServletTransport-Definingmultipletomcatconnectors)

### Configuring the HTTPS connector parameters

In addition to the configuration parameters supported by the [HTTP servlet transport](https://docs.wso2.com/display/ADMIN44x/HTTP+Servlet+Transport) , the HTTPS servlet transport supports the configuration parameters listed below. You can configure these parameters in the `catalina-server.xml` file (stored in the `<PRODUCT_HOME>/repository/conf/tomcat/` directory). For a complete list of supported parameters, see [Apache Tomcat's connector configuration reference](http://tomcat.apache.org/tomcat-7.0-doc/config/http.html) .

!!! tip
In transport parameter tables, literals displayed in italic mode under the "Possible Values" column should be considered as fixed literal constant values. Those values can be directly put in transport configurations.


<table>
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
<td><p>sslProtocol</p></td>
<td><p>Transport level security protocol to be used.</p></td>
<td><p>No</p></td>
<td><p><em>TLS, SSL</em></p></td>
<td><p>TLS</p></td>
</tr>
<tr class="even">
<td><p>keystore</p></td>
<td><p>Path to the keystore which should be used for encryption/decryption.</p></td>
<td><p>Yes</p></td>
<td><p>A valid file path to a keystore file</p></td>
<td><p><br />
</p></td>
</tr>
<tr class="odd">
<td><p>keypass</p></td>
<td><p>Password to access the specified keystore.</p></td>
<td><p>Yes</p></td>
<td><p>A valid password</p></td>
<td><p><br />
</p></td>
</tr>
</tbody>
</table>

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

