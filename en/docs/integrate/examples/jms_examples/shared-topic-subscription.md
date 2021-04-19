# Shared Topic Subscription

With JMS 1.1, a subscription on a topic is not permitted to have more than one consumer at a time. That is, if multiple JMS
consumers subscribe to a JMS topic, and if a message comes to that topic, multiple copies of the message is forwarded to each consumer. There is no way of sharing messages between consumers that come to the topic.

With the shared subscription feature in JMS 2.0, you can overcome this restriction. When shared subscription is used, a message that comes to a topic is forwarded to only one of the consumers. That is, if multiple JMS consumers subscribe to a JMS topic, consumers can share the messages that come to the topic. The advantage of shared topic subscription is that it allows to share the workload between consumers.

The Micro Integrator can be configured as a shared topic listener that can connect to a shared topic subscription as a message consumer (subscriber) to share workload between other consumers of the subscription.

To demonstrate the sample scenario, let's configure the JMS inbound endpoint in WSO2 Micro Integrator as a shared topic listener using HornetQ as the message broker.

## Synapse configurations

Given below are the synapse configurations that are required for mediating the above use case.

See the instructions on how to [build and run](#build-and-run) this example.

```xml tab="Inbound Endpoint"
<inboundEndpoint name="jms_inbound" sequence="request"onError="fault" protocol="jms" suspend="false">
  <parameters>
    <parameter name="interval">1000</parameter>
    <parameter name="transport.jms.Destination">/topic/exampleTopic</parameter>
    <parameter name="transport.jms.CacheLevel">3</parameter>
    <parameter name="transport.jms.ConnectionFactoryJNDIName">TopicConnectionFactory</parameter>
    <parameter name="sequential">true</parameter>
    <parameter name="java.naming.factory.initial">org.jnp.interfaces.NamingContextFactory</parameter>
    <parameter name="java.naming.provider.url">jnp://localhost:1099</parameter>
    <parameter name="transport.jms.SessionAcknowledgement">AUTO_ACKNOWLEDGE</parameter>
    <parameter name="transport.jms.SessionTransacted">false</parameter>
    <parameter name="transport.jms.ConnectionFactoryType">topic</parameter>
    <parameter name="transport.jms.JMSSpecVersion">2.0</parameter>
    <parameter name="transport.jms.SharedSubscription">true</parameter>
    <parameter name="transport.jms.DurableSubscriberName">mySubscription</parameter>
  </parameters>
</inboundEndpoint>
```

```xml tab="Registry Artifact"
<registry provider="org.wso2.micro.integrator.registry.MicroIntegratorRegistry">
  <parameter name="cachableDuration">15000</parameter>
</registry>
```

```xml tab="Task Manager"
<taskManager provider="org.wso2.micro.integrator.mediation.ntask.NTaskTaskManager">
  <parameter name="cachableDuration">15000</parameter>
</taskManager>
```

```xml tab="Sequence (Request)"
<sequence name="request" onError="fault">
  <log level="full"/>
  <drop/>
</sequence>
```

```xml tab="Sequence (Fault)"
<sequence name="fault">
  <log level="full">
    <property name="MESSAGE" value="Executing default &#34;fault&#34; sequence"/>
    <property name="ERROR_CODE" expression="get-property('ERROR_CODE')"/>
    <property name="ERROR_MESSAGE" expression="get-property('ERROR_MESSAGE')"/>
  </log>
  <drop/>
</sequence>
```

See the descriptions of the above configurations:

<table>
  <tr>
    <th>Artifact</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Inbound Endpoint</td>
    <td>
      Make sure to configure the below properties as follows when setting up the inbound endpoint:
      <ul>
        <li>
          Set the value of the <code>transport.jms.JMSSpecVersion </code> property as <code>2.0</code>.
        </li>
        <li>
          Set the value of the <code>transport.jms.SharedSubscription</code> propoerty as <code>true</code>.
        </li>
        <li>
          Specify a subscriber name as the value of the <code>transport.jms.DurableSubscriberName</code> property and use the same for all subscribers.
        </li>
      </ul>
    </td>
  </tr>
  <tr>
</table>

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), [registry artifact]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources), [scheduled task]({{base_path}}/integrate/develop/creating-artifacts/creating-scheduled-task), and [sequences]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the broker:

1.  [Configure a broker]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transport#configuring-the-jms-transport) with your Micro Integrator instance. Let's use HornetQ for this example.
    
    -   Be sure to create a sample topic by editing the `HORNET_HOME/config/stand-alone/non-clustered/hornetq-jms.xml` file as follows:
        ```xml  
        <topic name="sampleTopic">
           <entry name="/topic/exampleTopic"/>
        </topic>
        ```

2.  Start HornetQ with the following command:             
    -   On **Windows**: HORNETQ_HOME\bin\run.bat --run
    -   On **MacOS/Linux/Solaris**: sh HORNETQ_HOME/bin/run.sh

3.  Start the Micro Integrator (after starting the broker).   

Follow the steps given below to create the topic consumer and publisher to run this example. 

1. Create and run the following topic consumer (**TopicConsumer.java**) and run.
    
    ```java
    package SharedTopicSubscribe;
        
    import java.util.Properties;
        
    import javax.jms.Connection;
    import javax.jms.ConnectionFactory;
    import javax.jms.MessageConsumer;
    import javax.jms.Session;
    import javax.jms.TextMessage;
    import javax.jms.Topic;
    import javax.naming.Context;
    import javax.naming.InitialContext;
        
    public class TopicConsumer {
      private static final String DEFAULT_CONNECTION_FACTORY = "TopicConnectionFactory";
      private static final String DEFAULT_DESTINATION = "/topic/exampleTopic";
      private static final String INITIAL_CONTEXT_FACTORY = "org.jnp.interfaces.NamingContextFactory";
      private static final String PROVIDER_URL = "jnp://localhost:1099";
      private static final String SUBSCRIPTION_NAME = "mySubscription";
        
      public static void main(final String[] args) {
        try {
                        runExample();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
            }
        
             public static void runExample() throws Exception {
                    Connection connection = null;
                    Context initialContext = null;
                    try {
                        // /Step 1. Create an initial context to perform the JNDI lookup.
                        final Properties env = new Properties();
                        env.put(Context.INITIAL_CONTEXT_FACTORY, INITIAL_CONTEXT_FACTORY);
                        env.put(Context.PROVIDER_URL, System.getProperty(Context.PROVIDER_URL, PROVIDER_URL));
                        initialContext = new InitialContext(env);
        
                        // Step 2. perform a lookup on the topic
                        Topic topic = (Topic) initialContext.lookup(DEFAULT_DESTINATION);
        
                        // Step 3. perform a lookup on the Connection Factory
                        ConnectionFactory cf =
                                               (ConnectionFactory) initialContext.lookup(DEFAULT_CONNECTION_FACTORY);
        
                        // Step 4. Create a JMS Connection
                        connection = cf.createConnection();
        
                        // Step 5. Create a JMS Session
                        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        
                        // Step 6. Create a JMS Message Consumer
                        MessageConsumer messageConsumer =
                                                          session.createSharedConsumer(topic, SUBSCRIPTION_NAME);
        
                        // Step 7. Start the Connection
                        connection.start();
                        System.out.println("Shared message consumer started on topic: " + DEFAULT_DESTINATION +
                                           "\n");
        
                        // Step 8. Receive the message
                        TextMessage messageReceived = null;
                        while (true) {
                            messageReceived = (TextMessage) messageConsumer.receive();
                            System.out.println("Consumer received message: " + messageReceived.getText() + "\n");
                        }
        
                    } finally {
        
                        // Step 9. Close JMS resources
                        if (connection != null) {
                            connection.close();
                        }
        
                        // Also the initialContext
                        if (initialContext != null) {
                            initialContext.close();
                        }
                    }
                }
            }
    ```

2.  Run the following java file (**TopicPublisher.java**) to publish 5 messages to the HornetQ topic:

    ```java
    package SharedTopicSubscribe;
        
    import java.util.Properties;
        
    import javax.jms.Connection;
    import javax.jms.ConnectionFactory;
    import javax.jms.MessageProducer;
    import javax.jms.Session;
    import javax.jms.TextMessage;
    import javax.jms.Topic;
    import javax.naming.Context;
    import javax.naming.InitialContext;
        
    public class TopicPublisher {
        private static final String DEFAULT_CONNECTION_FACTORY = "TopicConnectionFactory";
        private static final String DEFAULT_DESTINATION = "/topic/exampleTopic";
        private static final String INITIAL_CONTEXT_FACTORY = "org.jnp.interfaces.NamingContextFactory";
        private static final String PROVIDER_URL = "jnp://localhost:1099";
        // Set up all the default values
        private static final String param = "IBM";

        public static void main(final String[] args) {
            try {
                runExample();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public static boolean runExample() throws Exception {
            Connection connection = null;
            Context initialContext = null;
            try {
                // /Step 1. Create an initial context to perform the JNDI lookup.
                // Set up the namingContext for the JNDI lookup
                final Properties env = new Properties();
                env.put(Context.INITIAL_CONTEXT_FACTORY, INITIAL_CONTEXT_FACTORY);
                env.put(Context.PROVIDER_URL, System.getProperty(Context.PROVIDER_URL, PROVIDER_URL));
                initialContext = new InitialContext(env);

                // Step 2. perform a lookup on the topic
                Topic topic = (Topic) initialContext.lookup(DEFAULT_DESTINATION);

                // Step 3. perform a lookup on the Connection Factory
                ConnectionFactory cf =
                        (ConnectionFactory) initialContext.lookup(DEFAULT_CONNECTION_FACTORY);

                // Step 4. Create a JMS Connection
                connection = cf.createConnection();

                // Step 5. Create a JMS Session
                Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

                // Step 6. Create a Message Producer
                MessageProducer producer = session.createProducer(topic);
                System.out.println("Publishing 5 messages to topic/exampleTopic");
                for (int i = 0; i < 5; i++) {

                    // Step 7. Create a Text Message
                    TextMessage message = session.createTextMessage(getMessage());

                    // Step 8. Send the Message
                    producer.send(message);
                }
                return true;
            } finally {

                // Step 9. Close JMS resources
                if (connection != null) {
                    connection.close();
                }

                // Also the initialContext
                if (initialContext != null) {
                    initialContext.close();
                }
            }
        }

        private static double getRandom(double base, double varience, boolean onlypositive) {
            double rand = Math.random();
            return (base + (rand > 0.5 ? 1 : -1) * varience * base * rand) *
                    (onlypositive ? 1 : rand > 0.5 ? 1 : -1);
        }

        private static String getMessage() {
            return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                    "   <soapenv:Header/>\n" + "<soapenv:Body>\n" +
                    "<m:placeOrder xmlns:m=\"http://services.samples\">\n" + "    <m:order>\n" +
                    "        <m:price>" + getRandom(100, 0.9, true) + "</m:price>\n" +
                    "        <m:quantity>" + (int) getRandom(10000, 1.0, true) + "</m:quantity>\n" +
                    "        <m:symbol>" + param + "</m:symbol>\n" + "    </m:order>\n" +
                    "</m:placeOrder>" + "   </soapenv:Body>\n" + "</soapenv:Envelope>";
        }
    }
    ```

You will see that the 5 messages are shared between the inbound listener and `TopicConsumer.java`. This is because both the inbound listener and `TopicConsumer.java` are configured as shared subscribers.

The total number of consumed messages between the inbound listener and `TopicConsumer.java` will be equal to the number messages published by `         TopicPublisher.java`.
