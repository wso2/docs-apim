# Connecting to ActiveMQ

This section describes how to configure WSO2 Micro Integrator to connect with ActiveMQ.

## Setting up the Micro Integrator with ActiveMQ

Follow the instructions below to set up and configure.

1.  Download [Apache ActiveMQ](http://activemq.apache.org/).
2.  Download and install WSO2 Micro Integrator.
3.  Copy the following client libraries from the `ACTIVEMQ_HOME/lib` directory to the `MI_HOME/lib` directory.

    **ActiveMQ 5.8.0 and above**

    -   activemq-broker-5.8.0.jar
    -   activemq-client-5.8.0.jar
    -   activemq-kahadb-store-5.8.0.jar  
    -   geronimo-jms_1.1_spec-1.1.1.jar
    -   geronimo-j2ee-management_1.1_spec-1.0.1.jar
    -   geronimo-jta_1.0.1B_spec-1.0.1.jar
    -   hawtbuf-1.9.jar
    -   Slf4j-api-1.6.6.jar
    -   activeio-core-3.1.4.jar (available in the `ACTIVEMQ_HOME/lib/optional` directory)  

    **Earlier version of ActiveMQ**

    -   activemq-core-5.5.1.jar
    -   geronimo-j2ee-management_1.0_spec-1.0.jar
    -   geronimo-jms_1.1_spec-1.1.1.jar

4.  If you want the Micro Integrator to receive messages from an ActiveMQ instance, or to send messages to an ActiveMQ instance, you need to update the deployment.toml file with the relevant connection parameters.

    - Add the following configurations to enable the JMS listener with ActiveMQ connection parameters.
        ```toml
        [[transport.jms.listener]]
        name = "myTopicListener"
        parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "TopicConnectionFactory"
        parameter.connection_factory_type = "topic"
        parameter.cache_level = "consumer"
        ```
        ```toml
        [[transport.jms.listener]]
        name = "myQueueListener"
        parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "QueueConnectionFactory"
        parameter.connection_factory_type = "queue"
        parameter.cache_level = "consumer"
        ```        
    !!! Note
        When configuring the jms listener, be sure to add the connection factory [service-level jms parameter]({{base_path}}/reference/synapse-properties/transport-parameters/jms-transport-parameters) to the synapse configuration with the name of the already defined connection factory.
        ```xml
        <parameter name="transport.jms.ConnectionFactory">myQueueListener</parameter>
        ```

    - Add the following configurations to enable the JMS sender with ActiveMQ connection parameters.
        ```toml
        [[transport.jms.sender]]
        name = "myTopicSender"
        parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "TopicConnectionFactory"
        parameter.connection_factory_type = "topic"
        parameter.cache_level = "producer"
        ```
        ```toml
        [[transport.jms.sender]]
        name = "myQueueSender"
        parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "QueueConnectionFactory"
        parameter.connection_factory_type = "queue"
        parameter.cache_level = "producer"
        ```
        
    !!! Note
        - When configuring the JMS transport with ActiveMQ, you can append [ActiveMQ-specific properties](http://activemq.apache.org/connection-configuration-uri.html) to the value of the `parameter.provider_url` property. For example, you can set the `redeliveryDelay` and `initialRedeliveryDelay` properties when configuring a JMS inbound endpoint as follows:
          ```toml
          parameter.provider_url = "tcp://localhost:61616?jms.redeliveryPolicy.redeliveryDelay=10000&amp;jms.redeliveryPolicy.initialRedeliveryDelay=10000"
          ```
        - The above configurations do not address the problem of transient failures of the ActiveMQ message broker.
          For example, if the ActiveMQ goes down and becomes active again after a while, the Micro Integrator will not reconnect to ActiveMQ. Instead, an error will be thrown until the Micro Integrator is restarted.</br>
          To avoid this problem, you need to add the following value as the `parameter.provider_url`: `failover:tcp://localhost:61616`. This simply makes sure that reconnection takes place. The `failover` prefix is associated with the [Failover transport of ActiveMQ](http://activemq.apache.org/failover-transport-reference.html).
    
5.  Start ActiveMQ by navigating to the `ACTIVEMQ_HOME/bin` directory and executing `./activemq console` (on Linux/OSX) or `activemq start ` (on Windows).

## Configuring redelivery in ActiveMQ queues

When the Micro Integrator is configured to consume messages from an ActiveMQ queue, you have the option to configure message re-delivery. This is useful when the Micro Integrator is unable to process messages due to failures. 

- **JMS parameters**

    Add the following JMS parameters to the proxy service configuration.
    
      ```xml
      <parameter name="redeliveryPolicy.maximumRedeliveries">1</parameter>
      <parameter name="transport.jms.DestinationType">queue</parameter>
      <parameter name="transport.jms.SessionTransacted">true</parameter>
      <parameter name="transport.jms.Destination">JMStoHTTPStockQuoteProxy</parameter>
      <parameter name="redeliveryPolicy.redeliveryDelay">2000</parameter>
      <parameter name="transport.jms.CacheLevel">consumer</parameter>
      ```

      -   `redeliveryPolicy.maximumRedeliveries`: Maximum number of retries for delivering the message. If set to `-1` ActiveMQ will retry inifinitely.
      -   `transport.jms.SessionTransacted`: When set to `true`, this enables the JMS session transaction for the proxy service.
      -   `redeliveryPolicy.redeliveryDelay`: Delay time in milliseconds between retries.
      -   `transport.jms.CacheLevel`: This needs to be set to `consumer` for the ActiveMQ redelivery mechanism to work.

- **Fault sequence**

    Add the following line in your fault sequence: `<property name="SET_ROLLBACK_ONLY" value="true" scope="axis2"/>`
  
    !!! Info
        When the Micro Integrator is unable to deliver a message to the back-end service due to an error, it will be routed to the fault sequence in the configuration. When the `SET_ROLLBACK_ONLY` property is set in the fault sequence, the Micro Integrator informs ActiveMQ to redeliver the message.

Following is a sample proxy service configuration:

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="JMStoHTTPStockQuoteProxy"
       transports="jms"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
   <target>
      <inSequence>
         <property name="transactionID"
                   expression="get-property('MessageID')"
                   scope="default"/>
         <property name="sourceMessageID"
                   expression="get-property('MessageID')"
                   scope="default"/>
         <property name="proxyMessageID"
                   expression="get-property('MessageID')"
                   scope="default"/>
         <log level="full">
            <property name="transactionID" expression="get-property('transactionID')"/>
            <property name="sourceMessageID" expression="get-property('sourceMessageID')"/>
            <property name="MessageID" expression="get-property('proxyMessageID')"/>
         </log>
         <property name="SET_ROLLBACK_ONLY" value="true" scope="axis2"/>
         <drop/>               
      </inSequence>
      <faultSequence name="jms_fault"/>
   </target>
   <parameter name="redeliveryPolicy.maximumRedeliveries">1</parameter>
   <parameter name="transport.jms.DestinationType">queue</parameter>
   <parameter name="transport.jms.SessionTransacted">true</parameter>
   <parameter name="transport.jms.Destination">JMStoHTTPStockQuoteProxy</parameter>
   <parameter name="redeliveryPolicy.redeliveryDelay">2000</parameter>
   <parameter name="transport.jms.CacheLevel">consumer</parameter>
   <description/>
</proxy>
```

## Securing the ActiveMQ server

JMS is an integral part of enterprise integration solutions that are highly-reliable, loosely-coupled, and asynchronous. As a result, implementing proper security to your JMS deployments is vital. The below sections discuss some of the best practices of an effective JMS security implementation when used in combination with WSO2 Micro Integrator.

Let's see how some of the key concepts of system security such as authentication, authorization, and availability are implemented in different types of brokers. Given below is an overview of how some common security concepts are implemented in Apache ActiveMQ.

| Security Concept                               | How it is Implemented                                          |
|------------------------------------------------|----------------------------------------------------------------|
| [Authentication](#authentication) | Simple authentication and JAAS plugins.                                     |
| [Authorization](#authorization) | Built-in authorization mechanism using XML configuration.                     |
| [Availability](#availability)  | Primary/secondary configurations using fail-over transport in ActiveMQ (not to be confused with the Micro Integrator's transports). |
| [Integrity](#integrity)  | WS-Security                                                                          |

### Authentication

Simple Authentication: ActiveMQ comes with an authentication plugin, which provides basic authentication between the ActiveMQ JMS and the Micro Integrator. The steps below describe how to configure.

1.  Add the following configuration in `ACTIVEMQ_HOME/conf/activemq-security.xml` file.
      ```xml
      <simpleAuthenticationPlugin anonymousAccessAllowed="true">
         <users>
             <authenticationUser username="system" password="${activemq.password}" groups="users,admins"/>
             <authenticationUser username="user" password="${guest.password}" groups="users"/>
             <authenticationUser username="guest" password="${guest.password}" groups="guests"/>
         </users> 
      </simpleAuthenticationPlugin>
      ```

2.  Update the `ACTIVEMQ_HOME/conf/credentials.properties` file (for credentials in plain text) or the `ACTIVEMQ_HOME/conf/credentials-enc.properties` file for encrypted version to define the list of usernames and passwords lists referenced in the configuration above.

    - The **anonymousAccessAllowed** attribute defines whether or not to allow anonymous access. 
    - The groups and users defined in step 1 are used to provide authorization schemes. Refer to section [Authorization](#authorization) for more information.

3.  When you configure the JMS listener in the deployment.toml file of your Micro Integrator, use the ActiveMQ user name and password you cofigured above.
      ```toml
      [[transport.jms.listener]]
      name = "myTopicListener"
      parameter.initial_naming_factory = "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory"
      parameter.provider_url = "tcp://localhost:61616"
      parameter.connection_factory_name = "TopicConnectionFactory"
      parameter.connection_factory_type = "topic"
      parameter.cache_level = "consumer"
      parameter.username = "system"
      parameter.password = "manager"
      ```

!!! Info
    For more advanced authentication schemes that use JAAS, which are supported in ActiveMQ, refer the official [ActiveMQ documentation](http://activemq.apache.org/security.html).

### Authorization

ActiveMQ provides authorization schemes using simple XML configurations, which you can apply to the users defined in the [authentication plugin](#authentication). To setup authorization, ensure you have the following configuration in the `ACTIVEMQ_HOME/conf/activemq-sequrity.xml` file.

```xml
<authorizationPlugin>
     <map>
      <authorizationMap>
        <authorizationEntries>
          <authorizationEntry queue=">" read="admins" write="admins" admin="admins" />
          <authorizationEntry queue="USERS.>" read="users" write="users" admin="users" />
          <authorizationEntry queue="GUEST.>" read="guests" write="guests,users" admin="guests,users" />
      <authorizationEntry topic=">" read="admins" write="admins" admin="admins" />
      <authorizationEntry topic="USERS.>" read="users" write="users" admin="users" />
      <authorizationEntry topic="GUEST.>" read="guests" write="guests,users" admin="guests,users" />
      <authorizationEntry topic="ActiveMQ.Advisory.>" read="guests,users" write="guests,users" admin="guests,users"/>
    </authorizationEntries>
  </authorizationMap>
 </map>
</authorizationPlugin> 
```
    
!!! Info
    This configuration defines role-based authorization on queues and topics, and uses ActiveMQ wildcards. For information on wildcards, refer the official [ActiveMQ documentation](http://activemq.apache.org/security.html).

### Availability

ActiveMQ supports the use of primary and secondary configurations and the failover transport to provide high availability. ActiveMQ supports two types of primary and secondary configurations and they are as follows:

-   Primary/secondary configurations using shared file systems
-   Primary/secondary configurations using JDBC

!!! Info
    For more information on either model, see the [ActiveMQ documentation](http://activemq.apache.org/masterslave.html).

**Primary/secondary configurations using JDBC**

ActiveMQ uses a special URI similar to the following to facilitate fail-over functionality: `failover://(tcp://127.0.0.1:61616,tcp://127.0.0.1:61617,tcp://127.0.0.1:61618)?initialReconnectDelay=100`. Use this URI inside the Micro Integrator for a highly-available JMS solution. See the example proxy service given below.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="FailOverJMS"
transports="http" startOnLoad="true" trace="disable">
   <target>
       <inSequence>
           <log level="full"/>
           <property name="OUT_ONLY" value="true" scope="default"/>
           <clone>
               <target>
                   <endpoint>
               <address                         uri="jms:/OMS?transport.jms.ConnectionFactoryJNDIName=QueueConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=failover:(tcp://localhost:61616,tcp://localhost:61617)?randomize=false&amp;transport.jms.DestinationType=queue"/>
           </endpoint>
               </target>
           </clone>
       </inSequence>
   </target>
   <publishWSDL key="gov:/services/FileService.wsdl">
       <resource location="Message.xsd" key="gov:/services/Message.xsd"/>
   </publishWSDL>
</proxy> 
```

Note `java.naming.provider.url=failover:(tcp://localhost:61616,tcp://localhost:61617)?randomize=false` inside the address endpoint uri attribute. The `randomize=false` parameter allows the fail-over configuration to be prioratized. This ensures that when the first instance fails, it moves to the next. For more information on ActiveMQ fail-over transport and its parameters, refer the [official documentation of ActiveMQ](http://activemq.apache.org/failover-transport-reference.html).

### Integrity

Integrity is part of message-level security and can be implemented using a standard like WS-Security. The following sample shows the application of WS-Security for message-level encryption where messages are stored in a message store in WSO2 Micro Integrator.

```xml
    <localEntry key="sec_policy" src="file:repository/samples/resources/policy/policy_3.xml" xmlns="http://ws.apache.org/ns/synapse"/>
```

```xml
    <proxy name="FailOverJMS" startOnLoad="true" transports="http" xmlns="http://ws.apache.org/ns/synapse">
        <target>
            <inSequence>
                <send>
                    <endpoint>
                        <address uri="jms:/StockQuoteJmsProxy2?transport.jms.ConnectionFactoryJNDIName=QueueConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616">
                            <enableAddressing version="submission"/>
                            <enableSec policy="sec_policy"/>
                    </address>
                </endpoint>
            </send>
            </inSequence>
            <outSequence>
                <header action="remove" name="wsse:Security" scope="default" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"/>
                <send/>
            </outSequence>
            <faultSequence/>
        </target>
    </proxy>
```
