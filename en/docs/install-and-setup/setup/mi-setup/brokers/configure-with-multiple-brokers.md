# Connecting to Multiple Brokers

If your system uses more than one broker, you need to add multiple broker configurations to the deployment.toml file (stored in the `MI_HOME/conf` directory. In such situations, each transport receiver should have a separate name.

## Configuring multiple broker types

The following example illustrates how to configure WSO2 Micro Integrator to listen to
both ActiveMQ and WSO2 MB messages.

1.  Download ActiveMQ (version 5.8.0 or later) from the [Apache ActiveMQ](http://activemq.apache.org/) site. 
2.  Download the WSO2 Message Broker from the [WSO2 Message Broker](http://wso2.com/products/message-broker/) site.
3.  Copy the following client libraries from `AMQ_HOME/lib` directory to `MI_HOME/lib` directory.  
    -   `            activemq-broker-5.8.0.jar           `
    -   `            activemq-client-5.8.0.jar           `
    -   `            geronimo-jms_1.1_spec-1.1.1.jar           `
    -   `            geronimo-j2ee-management_1.1_spec-1.0.1.jar           `
    -   `            hawtbuf-1.9.jar           `
4.  Copy the andes-client-0.13.wso2v10.jar from <MB_HOME>/client-lib directory to <EI_HOME>/lib directory.
5.  Add two JMS listener configurations to the deployment.toml file as shown below. Update connection parameters for the ActiveMQ and WSO2 MB brokers respectively.

    ```toml
    [[transport.jms.listener]]
    name = "mbQueueListener"
    parameter.initial_naming_factory = "org.wso2.andes.jndi.PropertiesFileInitialContextFactory"
    parameter.provider_url = "conf/jndi.properties"
    parameter.connection_factory_name = "QueueConnectionFactoryMB"
    parameter.connection_factory_type = "queue"
    parameter.cache_level = "consumer"

    [[transport.jms.listener]]
    name = "myQueueListener"
    parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
    parameter.provider_url = "tcp://localhost:61616"
    parameter.connection_factory_name = "QueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    parameter.cache_level = "consumer"

    [transport.jndi.connection_factories]
    'connectionfactory.QueueConnectionFactoryMB' = "amqp://admin:admin@clientID/carbon?brokerlist='tcp://localhost:5675'"

    [transport.jndi.queue]
    queue_jndi_name = "Queue1"
    ```

    !!! Info
        Note that the transport receiver name is different in each configuration.

7.  Start both ActiveMQ and WSO2 MB.
8.  Start WSO2 Micro Integrator.

Now ActiveMQ proxy service can be configured as follows to read messages from ActiveMQ server.

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
      <parameter name="transport.jms.Destination">Queue1</parameter>
      <parameter name="transport.jms.ConnectionFactory">myQueueListener</parameter>
  </proxy>
```

WSO2 MB proxy service can be configured as follows to read messages from WSO2 MB server.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="JMStoHTTPStockQuoteProxyMB" transports="jms">
      <target>
          <inSequence>
               <property action="set" name="OUT_ONLY" value="true"/>
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
              <default>application/json</default>
          </rules>
      </parameter>
      <parameter name="transport.jms.Destination">Queue1</parameter>
      <parameter name="transport.jms.ConnectionFactory">mbQueueListener</parameter>
  </proxy>
```

## Connecting multiple ActiveMQ brokers

WSO2 Micro Integrator can be configured as described below to work with two ActiveMQ brokers. In this example, port 61616 is used for one
ActiveMQ instance and port 61617 is used for another ActiveMQ instance.

```toml tab='ActiveMQ Broker 1'
[[transport.jms.listener]]
name = "jms1"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.provider_url = "tcp://localhost:61616"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
```

```toml tab='ActiveMQ Broker 2'
[[transport.jms.listener]]
name = "jms2"
parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
parameter.provider_url = "tcp://localhost:61617"
parameter.connection_factory_name = "TopicConnectionFactory"
parameter.connection_factory_type = "topic"
```

!!! Note 
    The name of the transport receivers as well as the ports are different in the two configurations.
