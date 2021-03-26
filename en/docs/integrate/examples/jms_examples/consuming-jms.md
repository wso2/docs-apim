# Consuming JMS Messages
This section describes how to configure WSO2 Micro Integrator to listen to a JMS Queue.

## Example 1: One-way messaging

In this example, the Micro Integrator listens to a JMS queue, consumes messages, and sends them to an HTTP back-end service.

### Synapse configuration

Given below is the synapse configuration of the proxy service that mediates the above use case. Note that you need to update the JMS connection URL according to your broker as explained below. 

See the instructions on how to [build and run](#build-and-run) this example.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="JMStoHTTPStockQuoteProxy" transports="jms" startOnLoad="true">
    <target>
        <inSequence>
            <header name="Action" value="urn:getQuote"/>
            <property action="set" name="OUT_ONLY" value="true"/>
        </inSequence>     
        <endpoint>
            <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
        </endpoint>
        <outSequence/>
    </target>
       <parameter name="transport.jms.ContentType">
      <rules>
         <jmsProperty>contentType</jmsProperty>
         <default>text/xml</default>
      </rules>
   </parameter>
</proxy>
```

The Synapse artifacts used are explained below.

<table>
    <tr>
        <th>Artifact Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            Proxy Service
        </td>
        <td>
            A proxy service is used to receive messages and to define the message flow. 
        </td>
    </tr>
    <tr>
        <td>
            Header Mediator
        </td>
        <td>
             A header mediator is used to set the SOAPAction header.
        </td>
    </tr>
    <tr>
        <td>
            Property Mediator
        </td>
        <td>
            The OUT_ONLY property is set to true to indicate that message exchange is one-way. 
        </td>
    </tr>
    <tr>
        <td>Endpoint Mediator</td>
        <td>
           To send a message to the HTTP backend, you should define the connection URL as the endpoint address. 
        </td>
    </tr>
</table>

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the broker:

1.  [Configure a broker]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transport#configuring-the-jms-transport) with your Micro Integrator instance. Let's use Active MQ for this example.
2.  Start the broker.
3.  Start the Micro Integrator (after starting the broker).

Set up the back-end service:

1. Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

You now have a running WSO2 Micro Integrator instance, ActiveMQ instance, and a sample back-end service to simulate the sample scenario.
Add a message in the `JMStoHTTPStockQuoteProxy` queue with the following XML payload using [ActiveMQ Web Console](https://activemq.apache.org/web-console.html).

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
The Micro Integrator will read the message from the ActiveMQ queue and send it to the back-end service. You will see the following response in the back-end service console:

```bash
INFO  [wso2/stockquote_service] - Stock quote service invoked.
INFO  [wso2/stockquote_service] - Generating getQuote response for IBM
INFO  [wso2/stockquote_service] - Stock quote generated.
```

!!! Info
    You can specify a different content type within the <code>transport.jms.ContentType</code> parameter. In the sample configuration above, the content type defined is `text/xml`. You can make the proxy service a JMS listener by setting its transport as <code>jms</code>. Once the JMS transport is enabled for a proxy service, the Micro Integrator listens on a JMS queue for the same name as the proxy service.</br>In the sample configuration above, the Micro Integrator listens to a JMS queue named <code>JMStoHTTPStockQuoteProxy</code>. To make the proxy service listen to a different JMS queue, define the <code>transport.jms.Destination</code> parameter with the name of the destination queue. For more information, you can refer details of the [JMS transport parameters]({{base_path}}/reference/synapse-properties/transport-parameters/jms-transport-parameters) used in the Micro Integrator.

## Example 2: Two-way HTTP back-end call

In addition to one-way invocations, the proxy service can listen to the queue, pick up a message, and do a two-way HTTP call as well. It allows the response to be delivered to a queue specified by the client. This is done by specifying a `ReplyDestination` element when placing a request message to a JMS queue.

### Synapse configuration

We can have a proxy service similar to the following to simulate a two-way invocation. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
           name="JMStoHTTPStockQuoteProxy1"
           transports="jms"
           startOnLoad="true"
           trace="disable">
       <description/>
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
      <parameter name="transport.jms.ReplyDestination">ResponseQueue</parameter>
</proxy>
```
The Synapse artifacts used are explained below.

<table>
    <tr>
        <th>Artifact Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            Proxy Service
        </td>
        <td>
            A proxy service is used to receive messages and to define the message flow. 
        </td>
    </tr>
    <tr>
        <td>
            Header Mediator
        </td>
        <td>
             A header mediator is used to set the SOAPAction header.
        </td>
    </tr>
    <tr>
        <td>Send Mediator</td>
        <td>
           To send a message to the HTTP backend, you should define the connection URL as the endpoint address. 
        </td>
    </tr>
</table>

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the broker:

1.  [Configure a broker]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transport#configuring-the-jms-transport) with your Micro Integrator instance. Let's use Active MQ for this example.
2.  Start the broker.
3.  Start the Micro Integrator (after starting the broker).

Set up the back-end service:

1. Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```
            
You now have a running WSO2 MI instance, an ActiveMQ instance, and a sample back-end service to simulate the sample scenario. Add a message in `JMStoHTTPStockQuoteProxy1` queue with the following XML payload using the [ActiveMQ Web Console](https://activemq.apache.org/web-console.html). You can view the responses from the back-end service in the `ResponseQueue`. 

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

!!! Info
    You can make the proxy service a JMS listener by setting its transport as <code>jms</code>. Once the JMS transport is enabled for a proxy service, the Micro Integrator listens on a JMS queue for the same name as the proxy service.</br>In the sample configuration above, the Micro Integrator listens to a JMS queue named <code>JMStoHTTPStockQuoteProxy1</code>. To make the proxy service listen to a different JMS queue, define the <code>transport.jms.Destination</code> parameter with the name of the destination queue. For more information, you can refer details of the [JMS transport parameters]({{base_path}}/reference/synapse-properties/transport-parameters/jms-transport-parameters) used in the Micro Integrator.
    
## Example 3: Set content type of incoming JMS messages

The Micro Integrator considers all messages consumed from a queue as SOAP messages by default. To consider that the messages consumed from a queue are of a different format, define the **transport.jms.ContentType** parameter with the respective content type as a proxy service parameter.

### Synapse configuration

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="JMStoHTTPStockQuoteProxy" transports="jms">
    <target>
        <inSequence>
            <header name="Action" value="urn:getQuote"/>
            <property action="set" name="OUT_ONLY" value="true"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence/>
    </target>
    <parameter name="transport.jms.ContentType">
        <rules>
            <jmsProperty>contentType</jmsProperty>
            <default>application/xml</default>
        </rules>
    </parameter>
    <parameter name="transport.jms.Destination">MyJMSQueue</parameter>
</proxy>
```

The Synapse artifacts used are explained below.

<table>
    <tr>
        <th>Artifact Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            Proxy Service
        </td>
        <td>
            A proxy service is used to receive messages and to define the message flow.
        </td>
    </tr>
    <tr>
        <td>
            Header Mediator
        </td>
        <td>
            A header mediator is used to set the SOAPAction header.
        </td>
    </tr>
    <tr>
        <td>Send Mediator</td>
        <td>
           To send a message to the HTTP backend, you should define the connection URL as the endpoint address. 
        </td>
    </tr>
</table>

!!! Info
    You can specify a different content type within the <code>transport.jms.ContentType</code> parameter. In the sample configuration above, the content type defined is <code>application/xml</code>. If you want the proxy service to listen to a queue where the queue name is different from the proxy service name, you can specify the queue name using the <code>transport.jms.Destination</code> parameter. In the sample configuration above, the Micro Integrator listens to a JMS queue named <b>MyJMSQueue</b>. For more information, you can refer details of the [JMS transport parameters]({{base_path}}/reference/synapse-properties/transport-parameters/jms-transport-parameters) used in the Micro Integrator.