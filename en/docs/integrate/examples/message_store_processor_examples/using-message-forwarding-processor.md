# Using the Message Forwarding Processor
This example demonstrates the usage of the message forwarding processor.

## Synapse configuration
Following are the artifact configurations that we can use to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Proxy Service'
<proxy xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteProxy" transports="https http" startOnLoad="true" trace="disable">
          <description />
    <target>
       <inSequence>
        <log level="full"/>
        <property name="FORCE_SC_ACCEPTED" scope="axis2" value="true"/>
        <property name="OUT_ONLY" value="true"/>
        <store messageStore="MyStore"/>
    </inSequence>
    <outSequence>
      <send />
    </outSequence>
</target>
</proxy>
```

```xml tab='Message Store'
<messageStore xmlns="http://ws.apache.org/ns/synapse" name="MyStore"/>
```

```xml tab='Message Processor'
<messageProcessor xmlns="http://ws.apache.org/ns/synapse"
    class="org.apache.synapse.message.processor.impl.forwarder.ScheduledMessageForwardingProcessor"
    messageStore="MyStore" name="ScheduledProcessor" targetEndpoint="StockQuoteServiceEp">
    <parameter name="interval">10000</parameter>
    <parameter name="throttle">false</parameter>
    <parameter name="target.endpoint">StockQuoteServiceEp</parameter>
</messageProcessor>
```

```xml tab='Endpoint'
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteServiceEp">
    <address uri="http://localhost:9000/services/SimpleStockQuoteService">
        <suspendOnFailure>
            <errorCodes>-1</errorCodes>
            <progressionFactor>1.0</progressionFactor>
        </suspendOnFailure>
    </address>
</endpoint>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), [endpoint]({{base_path}}/integrate/develop/creating-artifacts/creating-endpoints), [message store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store) and [message processor]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-processor) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

[Configure the ActiveMQ broker]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-activemq) and set up the JMS Sender.

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

Send the following request to invoke the service:

```bash
POST http://localhost:9090/services/StockQuoteProxy HTTP/1.1
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

Now Start the SimpleStockQuoteService. When you Start the service you will see message getting delivered to the service. Even though service is down when we invoke it from the client. Here in the Proxy Service store mediator will store the getQuote request message in the "MyStore" Message Store. Message Processor will send the message to the endpoint configured as a message context property. Message processor will remove the message from the store only if message delivered successfully.
