# JMS Synchronous Invocations: Dual Channel HTTP-to-JMS

A JMS synchronous invocation takes place when a JMS producer receives a response to a JMS request produced by it when invoked. The WSO2 Micro Integrator uses an internal **JMS correlation ID** to correlate the request and the response. See [JMSRequest/ReplyExample](http://www.eaipatterns.com/RequestReplyJmsExample.html) for more information. JMS synchronous invocations are further explained in the following use case.

When the proxy service named `SMSSenderProxy` receives an HTTP request, it publishes that request in a JMS queue named `SMSStore` . Another proxy service named `SMSForwardProxy` subscribes to messages published in this queue and forwards them to a back-end service named `         SimpleStockQuoteService        ` . When this back-end service returns an HTTP response, internal ESB logic is used to save that
message as a JMS message in a JMS queue named `SMSReceiveNotification`. The `SMSSenderProxy` proxy service picks the response from the `SMSReceiveNotification` queue and delivers it to the client as an HTTP message using the internal mediation logic.

**Note** that the `         SMSSenderProxy        ` proxy service is able to pick up the message from the `         SMSReceiveNotification        ` queue because the `         transport.jms.ReplyDestination        ` parameter of the `         SMSSenderProxy        ` proxy service is set to the same `         SMSReceiveNotification        ` queue.

!!! Info
    **Correlation between request and response**:
    
    Note that the message that is passed to the back-end service contains the JMS message ID. However, the back-end service is required to return the response using the JMS correlation ID. Therefore, the back-end service should be configured to copy the message ID from the request (the value of the **JMSMessageID** header) to the correlation ID of the response (using the **JMSCorrelationID** header).

## Synapse configurations

Create two proxy services with the JMS publisher configuration and JMS consumer configuration given below and then deploy the proxy service artifacts in the Micro Integrator.

See the instructions on how to [build and run](#build-and-run) this example.

### JMS publisher configuration

Shown below is the `SMSSenderProxy` proxy service.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
           name="SMSSenderProxy"
           transports="https,http"
           statistics="disable"
           trace="disable"
           startOnLoad="true">
       <target>
          <inSequence>
             <property name="transport.jms.ContentTypeProperty"
                       value="Content-Type"
                       scope="axis2"/>
          </inSequence>
          <outSequence>
             <property name="TRANSPORT_HEADERS" scope="axis2" action="remove"/>
             <send/>
          </outSequence>
          <endpoint>
             <address uri="jms:/SMSStore?transport.jms.ConnectionFactoryJNDIName=QueueConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616&amp;transport.jms.DestinationType=queue&amp;transport.jms.ReplyDestination=SMSReceiveNotificationStore"/>
          </endpoint>
       </target>
       <description/>
</proxy>
```

Listed below are some of the properties that can be used with the **Property** mediator used in this proxy service:

<table>
<colgroup>
<col style="width: 23%" />
<col style="width: 76%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>TRANSPORT_HEADERS</code></pre></td>
<td><p>This property is used in the out sequence to make sure that transport headers (which are JMS headers in this example) are removed from the message when it is passed to the back-end client.</p>
<p>It is recommended to set this property because (according to the JMS specification) a property name can contain any character for which the <code>              Character.isJavaIdentifierPart             </code> Java method returns 'true'. Therefore when there are headers that contain special characters (e.g accept-encoding), some JMS brokers will give errors.</p></td>
</tr>
<tr class="even">
<td><pre><code>transport.jms.ContentTypeProperty</code></pre></td>
<td><p>The JMS transport uses this property in the above configuration to determine the content type of the response message. If this property is not set, the JMS transport treats the incoming message as plain text.</p>
<p><strong>Note:</strong> When this property is used, the content type is determined by the out transport. For example, if the proxy service/API is sending a request, the endpoint reference will determine the content type. Also, if the proxy service/API is sending the response back to the client, the configuration of the service/API will determine the content type.</p></td>
</tr>
<tr class="odd">
<td><pre><code>JMS_WAIT_REPLY</code></pre></td>
<td><div class="content-wrapper">
<p>This property can be used to specify how long the system should wait for the JMS queue (SMSRecieveNotification queue) to send the response back. You can add this property to the in sequence as shown below.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb4" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb4-1"><a href="#cb4-1"></a>&lt;property name=<span class="st">&quot;JMS_WAIT_REPLY&quot;</span> value=<span class="st">&quot;60000&quot;</span> scope=<span class="st">&quot;axis2&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td><p><code>              JMS_TIME_TO_LIVE             </code></p></td>
<td><div class="content-wrapper">
<p>This property can be set in the InSequence of the proxy service to specify the maximum time period for which a message can live without being consumed.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb5" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb5-1"><a href="#cb5-1"></a>&lt;property name=<span class="st">&quot;JMS_TIME_TO_LIVE&quot;</span> scope=<span class="st">&quot;axis2&quot;</span> value=<span class="st">&quot;20000&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

The endpoint of this proxy service uses the properties listed below to connect the proxy service to the JMS queue in the Message Broker.

<table>
<thead>
<tr class="header">
<th>Property</th>
<th>Value for this use case</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><strong>address uri</strong></p></td>
<td><p><code>              jms:/SMSStore             </code></p></td>
<td>The destination in which the request received by the proxy service is stored. Note that there are two ways to define the URL: </br>
  <ul>
    <li>
      Specify the JNDI name of the JMS queue and the connection factory parameters in the connection URL as shown in the above example.
    </li>
    <li>
      If you have already specified the endpoint's connection factory parameters (for the JMS sender configuration) in the deployment.toml file, the connection URL in the proxy service should be as shown below. In this example, the endpoint URL of the proxy service refers the relevant connection factory in the deployment.toml file:
      <code>
        jms:/SMSStore?transport.jms.ConnectionFactory=QueueConnectionFactory
      </code>
    </li>
  </ul>
</td>
</tr>
<tr class="even">
<td><p><strong>java.naming.factory.initial</strong></p></td>
<td><p><code>              org.wso2.andes.jndi.PropertiesFileInitialContextFactory             </code></p></td>
<td><div class="itemizedlist">
<p>The initial context factory to use.<br />
The value specified here should be the same as that specified in the <code>               &lt;MI_HOME&gt;/conf/deployment.toml              </code> `parameter.initial_naming_factory` for the JMS transport receiver (Under <code>[[transport.jms.listener]]</code> section).</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>java.naming.provider.url</strong></td>
<td><p><code>              conf/jndi.properties             </code></p></td>
<td>The location of the JNDI service provider.</td>
</tr>
<tr class="even">
<td><p><strong>transport.jms.DestinationType</strong></p></td>
<td><code>             queue            </code></td>
<td>The destination type of the JMS message that will be generated by the proxy service.</td>
</tr>
<tr class="odd">
<td><strong>transport.jms.ReplyDestination</strong></td>
<td><p><code>              SMSReceiveNotificationStore             </code></p></td>
<td>The destination in which the response generated by the back-end service is stored.</td>
</tr>
</tbody>
</table>

### JMS consumer configuration

Create a proxy service named `         SMSForwardProxy        ` with the configuration given below. This proxy service will consume messages from the `         SMSStore        ` queue of the Message Broker Profile, and forward the messages to the back-end service.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
           name="SMSForwardProxy"
           transports="jms"
           statistics="disable"
           trace="disable"
           startOnLoad="true">
       <target>
          <inSequence>
            <header name="Action" value="urn:getQuote"/>
             <send>
                <endpoint>
                   <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
             </send>
          </inSequence>
          <outSequence>
             <send/>
          </outSequence>
       </target>
       <parameter name="transport.jms.ContentType">
          <rules>
             <jmsProperty>contentType</jmsProperty>
             <default>text/xml</default>
          </rules>
       </parameter>
       <parameter name="transport.jms.ConnectionFactory">myQueueConnectionFactory</parameter>
       <parameter name="transport.jms.DestinationType">queue</parameter>
       <parameter name="transport.jms.Destination">SMSStore</parameter>
       <description/>
</proxy>
```

The `         transport.jms.ConnectionFactory        ` , `         transport.jms.DestinationType        ` parameter and the
`         transport.jms.Destination properties        ` parameter map the proxy service to the `         SMSStore        ` queue.

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy services]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the broker:

1.  [Configure a broker](../../../setup/transport_configurations/configuring-transports.md#configuring-the-jms-transport) with your Micro Integrator instance. Let's use Active MQ for this example.
2.  Start the broker.
3.  Start the Micro Integrator (after starting the broker).

    !!! Warning
        If you are using message processor with Active MQ broker add the following configuration to the startup script before starting the server as shown below,
        For Linux/Mac OS update `micro-integrator.sh` and for Windows update `micro-integrator.bat` with `-Dorg.apache.activemq.SERIALIZABLE_PACKAGES="*"` system property.

Set up the back-end service:

1. Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

To invoke this service, the address URI of this proxy service is defined as `         http://localhost:9000/services/SimpleStockQuoteService        `. Send a POST request to the above address URI with the following payload:

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getQuote>
         <ser:request>
            <xsd:symbol>IBM</xsd:symbol>
         </ser:request>
      </ser:getQuote>
   </soapenv:Body>
</soapenv:Envelope>
```