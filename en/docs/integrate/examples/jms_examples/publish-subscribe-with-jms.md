# Publish and Subscribe with JMS

JMS supports two models for messaging as follows:

- Queues: point-to-point
- Topics: publish and subscribe  

There are many business use cases that can be implemented using the publisher-subscriber (pub-sub) pattern. For example, consider a blog with subscribed readers. The blog author posts a blog entry, which the subscribers of the blog can view. In other words, the blog author publishes a message (the blog post content) and the subscribers (the blog readers) receive that message. Popular publisher-subscriber patterns like these can be implemented using JMS topics.

In this sample scenario, two proxy services in the Micro Integrator act as the publisher and subscriber to a topic defined in the message broker. 

When we invoke the back-end service, the publisher is invoked and sends the message to the JMS topic. The topic delivers the message to all the subscribers of that topic. In this case, the subscribers are Micro Integrator proxy services.

## Synapse configurations

Shown below are the synapse artifacts that are used to define this use case. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab="Proxy Service (Publisher)"
<proxy name="StockQuoteProxy" transports="http" startOnLoad="true" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
  <target>
    <endpoint>
      <address uri="jms:/SimpleStockQuoteService?transport.jms.ConnectionFactoryJNDIName=TopicConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616&amp;transport.jms.DestinationType=topic"/>
    </endpoint>
    <inSequence>
        <property name="OUT_ONLY" value="true"/>
        <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
    </inSequence>
    <outSequence>
      <send/>
    </outSequence>
  </target>
</proxy>

```

```xml tab="Proxy Service (Subscriber 1)"
<proxy name="SimpleStockQuoteService1" transports="jms" startOnLoad="true" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
      <target>
        <inSequence>
          <property name="OUT_ONLY" value="true"/>
          <log level="custom">
            <property name="Subscriber1" value="I am Subscriber1"/>
          </log>
          <drop/>
        </inSequence>
        <outSequence>
           <send/>
        </outSequence>
      </target>
  <parameter name="transport.jms.ContentType">
      <rules>
        <jmsProperty>contentType</jmsProperty>
        <default>application/xml</default>
      </rules>
  </parameter>
  <parameter name="transport.jms.ConnectionFactory">myTopicConnectionFactory</parameter>
  <parameter name="transport.jms.DestinationType">topic</parameter>
  <parameter name="transport.jms.Destination">SimpleStockQuoteService</parameter>
</proxy>
```

```xml tab="Proxy Service (Subscriber 2)"
<proxy name="SimpleStockQuoteService2" transports="jms" startOnLoad="true" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
  <target>
    <inSequence>
      <property name="OUT_ONLY" value="true"/>
      <log level="custom">
        <property name="Subscriber2" value="I am Subscriber2"/>
      </log>
      <drop/>
    </inSequence>
    <outSequence>
      <send/>
    </outSequence>
  </target>
  <parameter name="transport.jms.ContentType">
    <rules>
      <jmsProperty>contentType</jmsProperty>
      <default>application/xml</default>
    </rules>
  </parameter>
  <parameter name="transport.jms.ConnectionFactory">myTopicConnectionFactory</parameter>
  <parameter name="transport.jms.DestinationType">topic</parameter>
  <parameter name="transport.jms.Destination">SimpleStockQuoteService</parameter>
</proxy>
```

See the descriptions of the above configurations:

<table>
  <tr>
    <th>Artifact</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Publisher</td>
    <td>
      This proxy service (StockQuoteProxy) is configure to publish messages to the <code>SimpleStockQuoteService</code> topic in the broker. Note that there are two ways to define the endpoint URL:
      <ul>
        <li>
          Specify the JNDI name of the JMS topic and the connection factory parameters in the connection URL as shown in the above example.
        </li>
        <li>
          If you have already specified the endpoint's connection factory parameters (for the JMS sender configuration) in the <code>deployment.toml</code> file, the connection URL in the proxy service should be as shown below. In this example, the endpoint URL of the proxy service refers the relevant connection factory in the <code>deployment.toml</code> file. </br></br>
          <b>When the broker is ActiveMQ</b></br>
          <code>jms:/StockQuotesQueue?transport.jms.ConnectionFactory=QueueConnectionFactory</code></br></br>
          <b>When the broker is WSO2 Message Broker</b></br>
          <code>jms:/StockQuotesQueue?transport.jms.ConnectionFactory=QueueConnectionFactory</code></br>
        </li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>Subscriber 1</td>
    <td>Proxy service that consumes messages from the broker.</td>
  </tr>
  <tr>
    <td>Subscriber 2</td>
    <td>Proxy service that consumes messages from the broker.</td>
  </tr>
</table>

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create [proxy services]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the broker:

1.  [Configure a broker]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transport#configuring-the-jms-transport) with your Micro Integrator instance. Let's use Active MQ for this example.
2.  Start the broker.
3.  Start the Micro Integrator (after starting the broker).

Publishing to the topic:

1. Start the Micro Integrator. A log message similar to the following will appear:
    ```bash
    INFO {org.apache.axis2.transport.jms.JMSListener} - Started to listen on destination : SimpleStockQuoteService of type topic for service SimpleStockQuoteService2
    INFO {org.apache.axis2.transport.jms.JMSListener} - Started to listen on destination : SimpleStockQuoteService of type topic for service SimpleStockQuoteService1
    ```
 
2. To invoke the publisher, send a request to `StockQuoteProxy` (http://localhost:8290/services/StockQuoteProxy) with the following payload:
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

    When the stockquote client sends the message to the `StockQuoteProxy` service, the publisher is invoked and sends the message to the JMS topic. The topic delivers the message to all the subscribers of that topic. In this case, the subscribers are proxy services deployed in the Micro Integrator.

    !!! Note
        There can be many types of publishers and subscribers for a given JMS topic. The following [article in the WSO2 library](http://wso2.org/library/articles/2011/12/wso2-esb-example-pubsub-soa) provides more information on different types of publishers and subscribers.