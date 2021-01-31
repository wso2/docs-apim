# Switching from JMS to HTTP(S)

This example demonstrates how the Micro Integrator receives a messages over the JMS transport and forwards it over an HTTP/S transport. In this sample, the client sends a request message to the proxy service exposed in JMS. The Micro Integrator forwards this message to the HTTP endpoint and returns the reply back to the client through a JMS temporary queue.

## Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="JMStoHTTPStockQuoteProxy" transports="jms">
      <target>
          <inSequence>
              <property action="set" name="OUT_ONLY" value="true"/>
              <send>
                  <endpoint>
                      <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                  </endpoint>
              </send>
          </inSequence>
      </target>
      <parameter name="transport.jms.ContentType">
          <rules>
              <jmsProperty>contentType</jmsProperty>
              <default>text/xml</default>
          </rules>
      </parameter>
      <parameter name="transport.jms.Destination">Queue1</parameter>
      <parameter name="transport.jms.ConnectionFactory">myQueueListener</parameter>
  </proxy>
```

## Build and Run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.
5. Start the selected message broker and create a queue with name <strong>Queue1</strong>. 
6. [Configure MI with the selected message broker](../../../../setup/brokers/configure-with-ActiveMQ) and start the Micro-Integrator.

Set up the back-end service:

1. Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

Publish the following XML message to the Queue1.
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header/>
   <soapenv:Body>
   	<m0:placeOrder xmlns:m0="http://services.samples">
	    <m0:order>
	        <m0:price>172.23182849731984</m0:price>
	        <m0:quantity>18398</m0:quantity>
	        <m0:symbol>IBM</m0:symbol>
	    </m0:order>
	</m0:placeOrder>
   </soapenv:Body>
</soapenv:Envelope>
```