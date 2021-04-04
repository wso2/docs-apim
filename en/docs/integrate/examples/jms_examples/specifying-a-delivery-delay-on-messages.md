# Specifying Delivery Delay on Messages

In a normal message flow, JMS messages that are sent by the JMS producer to the JMS broker are forwarded to the respective JMS consumer without any delay.

With the delivery delay messaging feature introduced with JMS 2.0, you can specify a delivery delay time value in each JMS message so that the JMS broker will not deliver the message until after the specified delivery delay has elapsed. Specifying a delivery delay is useful if there is a scenario where you do not want a message consumer to receive a message that is sent until a specified time duration has elapsed. To implement this, you need to add a delivery delay to the JMS producer so
that the publisher does not deliver a message until the specified delivery delay time interval is elapsed.

The following diagram illustrates how you can use WSO2 Micro Integrator as a JMS producer and specify a delivery delay on messages when you do not want the message consumer to receive a message until a specified time duration has elapsed.

## Synapse configuration

Given below are the synapse configurations that are required for mediating the above use case.

See the instructions on how to [build and run](#build-and-run) this example.

```xml tab="Proxy Service 1"
<proxy name="JMSDelivery" startOnLoad="true" trace="disable" transports="https http">
            <description/>
            <target>
                <inSequence>
                    <property name="OUT_ONLY" value="true"/>
                    <property name="FORCE_SC_ACCEPTED" scope="axis2" value="true"/>
                    <property action="remove" name="Content-Length" scope="transport"/>
                    <property action="remove" name="MIME-Version" scope="transport"/>
                    <property action="remove" name="Transfer-Encoding" scope="transport"/>
                    <property action="remove" name="User-Agent" scope="transport"/>
                    <property action="remove" name="Accept-Encoding" scope="transport"/>
                    <property name="messageType" scope="axis2" value="application/xml"/>
                    <property action="remove" name="Content-Type" scope="transport"/>
                    <log level="full"/>
                    <send>
                        <endpoint>
                            <address uri="jms:transport.jms.ConnectionFactory=myQueueConnectionFactory"/>
                        </endpoint>
                    </send>
                </inSequence>
                <outSequence>
                    <send/>
                </outSequence>
            </target>
            <publishWSDL uri="file:repository/samples/resources/proxy/sample_proxy_1.wsdl"/>
</proxy>
```

```xml tab="Proxy Service 2"
<proxy name="JMSDeliveryDelayed" startOnLoad="true" trace="disable" transports="https http">
            <description/>
            <target>
                <inSequence>
                    <property name="OUT_ONLY" value="true"/>
                    <property name="FORCE_SC_ACCEPTED" scope="axis2" value="true"/>
                    <property action="remove" name="Content-Length" scope="transport"/>
                    <property action="remove" name="MIME-Version" scope="transport"/>
                    <property action="remove" name="Transfer-Encoding" scope="transport"/>
                    <property action="remove" name="User-Agent" scope="transport"/>
                    <property action="remove" name="Accept-Encoding" scope="transport"/>
                    <property name="messageType" scope="axis2" value="application/xml"/>
                    <property action="remove" name="Content-Type" scope="transport"/>
                    <property name="JMS_MESSAGE_DELAY" scope="axis2" value="10000"/>
                    <log level="full"/>
                    <send>
                        <endpoint>
                            <address uri="jms:/transport.jms.ConnectionFactory=myQueueConnectionFactory"/>
                        </endpoint>
                    </send>
                </inSequence>
                <outSequence>
                    <send/>
                </outSequence>
            </target>
            <publishWSDL uri="file:repository/samples/resources/proxy/sample_proxy_1.wsdl"/>
</proxy>
```

```xml tab="Main Sequence"
<sequence name="main">
    <in>
        <!-- Log all messages passing through -->
       <log level="full"/>
        <!-- ensure that the default configuration only sends if it is one of samples -->
        <!-- Otherwise Synapse would be an open proxy by default (BAD!)               -->
        <filter regex="http://localhost:9000.*" source="get-property('To')">
        <!-- Send the messages where they have been sent (i.e. implicit "To" EPR) -->
        <send/>
        </filter>
   </in>
   <out>
        <send/>
   </out>
   <description>The main sequence for the message mediation</description>
</sequence>
```

```xml tab="Fault Sequence"
<sequence name="fault">
    <!-- Log the message at the full log level with the ERROR_MESSAGE and the ERROR_CODE-->
    <log level="full">
        <property name="MESSAGE" value="Executing default 'fault' sequence"/>
        <property expression="get-property('ERROR_CODE')" name="ERROR_CODE"/>
        <property expression="get-property('ERROR_MESSAGE')" name="ERROR_MESSAGE"/>
     </log>
     <!-- Drops the messages by default if there is a fault -->
    <drop/>
</sequence>
```

```xml tab="Registry Artifact"
<registry provider="org.wso2.micro.integrator.registry.MicroIntegratorRegistry">
   <parameter name="cachableDuration">15000</parameter>
</registry>
```

```xml tab="Task Manager"
<taskManager provider="org.wso2.micro.integrator.mediation.ntask.NTaskTaskManager"/>
```

See the descriptions of the above configurations:

<table>
    <tr>
        <th>Artifact</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Proxy Service 1</td>
        <td>
            The <code>JMSDeliveryDelayed</code> proxy service sets a delivery delay of 10 seconds on the message that it forwards
        </td>
    </tr>
    <tr>
        <td>Proxy Service 2</td>
        <td>The <code>JMSDelivery</code> proxy service does not set a delivery delay on the message.</td>
    </tr>
</table>


## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy services]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), [registry artifact]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources), [scheduled task]({{base_path}}/integrate/develop/creating-artifacts/creating-scheduled-task), and [sequences]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the broker:

1.  [Configure a broker]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transport#configuring-the-jms-transport) with your Micro Integrator instance. Let's use HornetQ for this example.
    
    -   On **Windows**: HORNETQ_HOME\bin\run.bat --run
    -   On **MacOS/Linux/Solaris**: sh HORNETQ_HOME/bin/run.sh

2.  Start the broker.
3.  Start the Micro Integrator.

Follow the steps given below to run the example:

1. Run the following java file (**QueueConsumer.java**), which acts as the JMS consumer that consumes messages from the queue:

    ```java
    package DeliveryDelay;
        
    import java.sql.Timestamp;
    import java.util.Date;
    import java.util.Properties;
        
    import javax.jms.Connection;
    import javax.jms.ConnectionFactory;
    import javax.jms.MessageConsumer;
    import javax.jms.Session;
    import javax.jms.TextMessage;
    import javax.jms.Queue;
    import javax.naming.Context;
    import javax.naming.InitialContext;
        
            /**
             * Sample consumer to demonstrate JMS 2.0 feature :
             * Message Delivery Delay
             * Classic API is used
             */
        
            public class QueueConsumer {
            private static final String DEFAULT_CONNECTION_FACTORY = "QueueConnectionFactory";
            private static final String DEFAULT_DESTINATION = "queue/mySampleQueue";
            private static final String INITIAL_CONTEXT_FACTORY = "org.jnp.interfaces.NamingContextFactory";
            private static final String PROVIDER_URL = "jnp://localhost:1099";
        
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
        
            // Step 1. Create an initial context to perform the JNDI lookup.
            final Properties env = new Properties();
                        env.put(Context.INITIAL_CONTEXT_FACTORY, INITIAL_CONTEXT_FACTORY);
                        env.put(Context.PROVIDER_URL, System.getProperty(Context.PROVIDER_URL, PROVIDER_URL));
                        initialContext = new InitialContext(env);
        
        
            // Step 2. perform a lookup on the Queue
            Queue queue = (Queue) initialContext.lookup(DEFAULT_DESTINATION);
        
        
            // Step 3. perform a lookup on the Connection Factory
            ConnectionFactory cf = (ConnectionFactory) initialContext.lookup(DEFAULT_CONNECTION_FACTORY);
        
        
            // Step 4. Create a JMS Connection
                        connection = cf.createConnection();
        
        
            // Step 5. Create a JMS Session
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        
            // Step 6. Create a JMS Message Consumer
            MessageConsumer messageConsumer = session.createConsumer(queue);
        
            // Step 7. Start the Connection
                        connection.start();
            System.out.println("JMS consumer stated on the queue " + DEFAULT_DESTINATION +
            "\n");
        
            //Clear the queue, if there is any previous messages in the queue
            TextMessage tempMessage;
            do{
                            tempMessage = (TextMessage) messageConsumer.receive(1); 
                        } while(tempMessage != null);
        
            // Step 8.1. Receive the message one
            TextMessage firstMessage = (TextMessage) messageConsumer.receive(); 
            long first = System.currentTimeMillis();
            System.out.println("Consumer received message: [ "+new Timestamp(new Date(first).getTime())+" ] " + firstMessage.getText() + "\n");
        
            // Step 8.2. Receive delayed
            TextMessage secondMessage = (TextMessage) messageConsumer.receive();    
            long second = System.currentTimeMillis();
            System.out.println("Consumer received dealyed message: [ "+new Timestamp(new Date(second).getTime())+" ] " + secondMessage.getText() + "\n");
            System.out.println("Time difference between two messages : "+(second-first)/1000+"s");
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

2. Invoke the two proxy services (http://localhost:8290/services/JMSDelivery, http://localhost:8290/services/JMSDeliveryDelayed) with the following payload:

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

You will see that two messages are received by the Java consumer with a time difference of more than 10 seconds.

This is because the `         JMSDeliveryDelayed        ` proxy service sets a delivery delay of 10 seconds on the message that it forwards, whereas the `         JMSDelivery        ` proxy service does not set a delivery delay on the message.