# Using the RabbitMQ Message Store

In this example, the client sends requests to a **proxy service**, which stores the messages in a **RabbitMQ message store**. The **message forwarding processor** then picks the stored messages from the RabbitMQ message store and invokes the back-end service.

### Synapse configurations

Following are the artifact configurations that we can use to implement this scenario. See the instructions on how to [build and run](#build-and-run-example-1) this example.

```xml tab="Message Store"
<?xml version="1.0" encoding="UTF-8"?>
<messageStore class="org.apache.synapse.message.store.impl.rabbitmq.RabbitMQStore" name="rabbitmq" xmlns="http://ws.apache.org/ns/synapse">
    <parameter name="store.rabbitmq.host.name">localhost</parameter>
    <parameter name="store.producer.guaranteed.delivery.enable">false</parameter>
    <parameter name="store.rabbitmq.host.port">5672</parameter>
    <parameter name="store.rabbitmq.route.key"/>
    <parameter name="store.rabbitmq.username"/>
    <parameter name="store.rabbitmq.virtual.host"/>
    <parameter name="rabbitmq.connection.ssl.enabled">false</parameter>
    <parameter name="store.rabbitmq.exchange.name"/>
    <parameter name="store.rabbitmq.queue.name">xyz</parameter>
    <parameter name="store.rabbitmq.password"/>
</messageStore>
```

```xml tab="Endpoint"
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="SimpleStockQuoteService"> 
    <address uri="http://127.0.0.1:9000/services/SimpleStockQuoteService"/>
</endpoint>
```

```xml tab="Proxy Service"
<proxy xmlns="http://ws.apache.org/ns/synapse" name="Proxy1" transports="https http" startOnLoad="true" trace="disable">   
  <target>
    <inSequence>
      <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
      <property name="OUT_ONLY" value="true"/>
      <log level="full"/>
      <store messageStore="rabbitmq"/>
    </inSequence>
  </target>
</proxy>
```

```xml tab="Message Processor"
<messageProcessor xmlns="http://ws.apache.org/ns/synapse" class="org.apache.synapse.message.processor.impl.forwarder.ScheduledMessageForwardingProcessor" name="Processor1" targetEndpoint="SimpleStockQuoteService" messageStore="rabbitmq">
       <parameter name="max.delivery.attempts">4</parameter>
       <parameter name="interval">4000</parameter>
       <parameter name="is.active">true</parameter>
</messageProcessor>
```

See the descriptions of the above configurations:

<table>
  <tr>
    <th>Artifact</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Message Store</td>
    <td>
      The <b>RabbitMQ message store</b>.
    </td>
  </tr>
  <tr>
    <td>Endpoint</td>
    <td>
      Define an endpoint which is used to send the message to the back-end service.
    </td>
  </tr>
  <tr>
    <td>Proxy Service</td>
    <td>
      Create a proxy service which stores messages to the created Message Store. Note that you can use the FORCE_SC_ACCEPTED property in the message flow to send an Http 202 status to the client after the Micro Integrator accepts a message. If this property is not specified, the client that sends the request to the proxy service will timeout since it isbnot getting any response back from the proxy.
    </td>
  </tr>
  <tr>
    <td>Message Processor</td>
    <td>
      Create a message forwarding processor using the below configuration. Message forwarding processor consumes the messages stored in the message store.
    </td>
  </tr>
</table>

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), [endpoint]({{base_path}}/integrate/develop/creating-artifacts/creating-endpoints), and [message processor]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-processor) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

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

[Configure the RabbitMQ broker](../../../../setup/brokers/configure-with-rabbitMQ) with the Micro Integrator.

Invoke the service:

```bash
POST http://localhost:9090/services/Proxy1 HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: text/xml;charset=UTF-8
SOAPAction: "urn:getQuote"
Content-Length: 492
Host: localhost:9090
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getQuote xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
         <ser:request>
            <xsd:symbol>IBM</xsd:symbol>
         </ser:request>
      </ser:getQuote>
   </soapenv:Body>
</soapenv:Envelope>
```

Note a message similar to the following example:  

```bash
SimpleStockQuoteService :: Accepted order for : 7482 stocks of IBM at $ 169.27205579038733
```