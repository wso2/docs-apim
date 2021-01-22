# Load Balancing with Message Forwarding Processor
This example demonstrates how the message forwarding processor handles load balancing.

## Synapse configuration

Following are the artifact configurations that we can use to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Proxy Service'
<proxy xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteProxy"
              transports="https http"
              startOnLoad="true">
    <description/>
    <target>
       <inSequence>
          <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
          <property name="OUT_ONLY" value="true"/>
          <store messageStore="JMSMS"/>
       </inSequence>
       <outSequence/>
       <faultSequence/>
    </target>
 </proxy>
```

```xml tab='Endpoint 1'
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="SimpleStockQuoteService1">
  <address uri="http://localhost:9001/services/SimpleStockQuoteService"/>
</endpoint>
```

```xml tab='Endpoint 2'
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="SimpleStockQuoteService2">
  <address uri="http://localhost:9002/services/SimpleStockQuoteService"/>
</endpoint>
```

```xml tab='Endpoint 3'
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="SimpleStockQuoteService3">
  <address uri="http://localhost:9003/services/SimpleStockQuoteService"/>
</endpoint>
```

```xml tab='Message Store'
<messageStore xmlns="http://ws.apache.org/ns/synapse" class="org.apache.synapse.message.store.impl.jms.JmsStore" name="JMSMS">
  <parameter name="java.naming.factory.initial">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
  <parameter name="store.jms.cache.connection">false</parameter>
  <parameter name="java.naming.provider.url">tcp://localhost:61616</parameter>
  <parameter name="store.jms.JMSSpecVersion">1.1</parameter>
  <parameter name="store.jms.destination">JMSMS</parameter>
</messageStore>
```

```xml tab='Message Processor 1'
<messageProcessor xmlns="http://ws.apache.org/ns/synapse" class="org.apache.synapse.message.processor.impl.forwarder.ScheduledMessageForwardingProcessor"
                         name="Forwarder1"
                         targetEndpoint="SimpleStockQuoteService1"
                         messageStore="JMSMS">
  <parameter name="client.retry.interval">1000</parameter>
  <parameter name="interval">1000</parameter>
  <parameter name="is.active">true</parameter>
</messageProcessor>
```

```xml tab='Message Processor 2'
<messageProcessor xmlns="http://ws.apache.org/ns/synapse" class="org.apache.synapse.message.processor.impl.forwarder.ScheduledMessageForwardingProcessor"
                         name="Forwarder2"
                         targetEndpoint="SimpleStockQuoteService2"
                         messageStore="JMSMS">
  <parameter name="client.retry.interval">1000</parameter>
  <parameter name="interval">1000</parameter>
  <parameter name="is.active">true</parameter>
</messageProcessor>
```

```xml tab='Message Processor 3'
<messageProcessor xmlns="http://ws.apache.org/ns/synapse" class="org.apache.synapse.message.processor.impl.forwarder.ScheduledMessageForwardingProcessor"
                         name="Forwarder3"
                         targetEndpoint="SimpleStockQuoteService3"
                         messageStore="JMSMS">
  <parameter name="client.retry.interval">1000</parameter>
  <parameter name="interval">1000</parameter>
  <parameter name="is.active">true</parameter>
</messageProcessor>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), [endpoints]({{base_path}}/integrate/develop/creating-artifacts/creating-endpoints), [message stores]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store) and [message processors]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-processor) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

[Configure the ActiveMQ broker](../../../../setup/brokers/configure-with-ActiveMQ).

You can analyze the message sent by the Micro Integrator to the secure service using TCPMon.

On successful execution of the placeorder request, you will see the following message on the back-end:

```xml
Sun Aug 18 10:58:00 IST 2013 samples.services.SimpleStockQuoteService :: Accepted order #5 for : 18851 stocks of WSO2 at $ 61.782478265721714
```

If you send the placeorder request to the proxy service several times and observe the log on the back-end server, you will see that the messages are distributed among the back-end nodes.