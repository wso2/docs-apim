# Connecting to Oracle WebLogic

This section describes how to configure WSO2 Micro Integrator to connect with Oracle WebLogic 10.3.4.0.

## Starting WebLogic and WSO2 Micro Integrator

1.  Download and set up [Oracle WebLogic Server](http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-main-097127.html).
2.  Download and [start WSO2 Micro Integrator](https://docs.wso2.com/display/EI650/Running+the+Product) .
3.  Wrap the weblogic client jar and build a new OSGi bundle using the following [pom.xml](https://svn.wso2.org/repos/wso2/scratch/lasantha/weblogic-wrapper/pom.xml). The exporting of `javax.jms` package and `javax.xml.namespace` package of the client JAR should be prevented.
4.  Copy the client libraries file (`wlfullclient.jar`) from the `WEBLOGIC_HOME/wlserver_XX/server/lib` directory to the `MI_HOME/dropins` directory.

## Configuring the WebLogic server

Configure the required connection factories and queues in WebLogic. An entry for a JMS queue would look like the following. The configuration
files can be found inside the `WEBLOGIC_HOME/user_projects/domains/<DOMAIN_NAME>/config/jms` file. Alternatively you can configure using the WebLogic web console, which can be accessed through [http://localhost:7001](http://localhost:7001/) with default configurations.

```xml
<queue name="wso2MessageQueue">
  <sub-deployment-name>jms</sub-deployment-name>
  <jndi-name>jms/wso2MessageQueue</jndi-name>
</queue>
```

When you start the WebLogic server with the above changes, you can see the following on STDOUT.

```java
<Jun 25, 2013 11:20:02 AM IST> <Notice> <WebLogicServer> <BEA-000331> <Started WebLogic Admin Server "AdminServer" for domain "wso2" running in Development Mode> 
<Jun 25, 2013 11:20:02 AM IST> <Notice> <WebLogicServer> <BEA-000365> <Server state changed to RUNNING> 
<Jun 25, 2013 11:20:02 AM IST> <Notice> <WebLogicServer> <BEA-000360> <Server started in RUNNING mode> 
```

## Setting up the JMS listener amd Sender

If you want the Micro Integrator to receive messages from Weblogic instance, or to send messages to a Weblogic instance, you need to update the deployment.toml file with the relevant connection parameters.

Add the following configurations to enable the JMS sender and listener with Weblogic connection parameters.
    
```toml
[transport.jms]
sender_enable = true

[[transport.jms.listener]]
name = "myQueueConnectionFactory"
parameter.initial_naming_factory = "weblogic.jndi.WLInitialContextFactory"
parameter.provider_url = "t3://localhost:7001"
parameter.connection_factory_name = "jms/myConnectionFactory"
parameter.connection_factory_type = "queue"
parameter.username = "weblogic"
parameter.password = "admin123"

[[transport.jms.listener]]
name = "default"
parameter.initial_naming_factory = "weblogic.jndi.WLInitialContextFactory"
parameter.provider_url = "t3://localhost:7001"
parameter.connection_factory_name = "jms/myConnectionFactory"
parameter.connection_factory_type = "queue"
parameter.username = "weblogic"
parameter.password = "admin123"
```

## Setting up a message store

Create a message store using a configuration similar to the following:

```xml
<messageStore class="org.wso2.carbon.message.store.persistence.jms.JMSMessageStore"
        name="wso2MessageStore">       
    <parameter name="java.naming.factory.initial">weblogic.jndi.WLInitialContextFactory</parameter>
    <parameter name="store.jms.cache.connection">false</parameter>
    <parameter name="store.jms.password">admin123</parameter>
    <parameter name="java.naming.provider.url">t3://localhost:7001</parameter>
    <parameter name="store.jms.ConsumerReceiveTimeOut">300</parameter>
    <parameter name="store.jms.connection.factory">jms/myConnectionFactory</parameter>
    <parameter name="store.jms.username">weblogic</parameter>
    <parameter name="store.jms.JMSSpecVersion">1.1</parameter>
    <parameter name="store.jms.destination">jms/wso2MessageQueue</parameter>
</messageStore>
```

## JMS Producer Proxy Service

Use the following proxy service configuration in WSO2 Micro Integrator to publish messages to the WebLogic queue:

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="WeblogicJMSSenderProxy"
       transports="http"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
   <target>
      <inSequence>
         <property name="Accept-Encoding" scope="transport" action="remove"/>
         <property name="Content-Length" scope="transport" action="remove"/>
         <property name="Content-Type" scope="transport" action="remove"/>
         <property name="User-Agent" scope="transport" action="remove"/>
         <log level="custom">
            <property name="STATUS:"
                      value="------Message send by WeblogicJMSConsumerProxy--------"/>
         </log>
         <property name="OUT_ONLY" value="true"/>
         <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
         <send>
            <endpoint>
               <address uri="jms:/jms/TestJMSQueue1?transport.jms.ConnectionFactoryJNDIName=jms/TestConnectionFactory1&amp;java.naming.factory.initial=weblogic.jndi.WLInitialContextFactory&amp;java.naming.provider.url=t3://localhost:7001&amp;transport.jms.DestinationType=queue"/>
            </endpoint>
         </send>
      </inSequence>
      <outSequence>
         <send/>
      </outSequence>
   </target>
   <description/>
</proxy>
```

## JMS Consumer Proxy Service

Use the following proxy service configuration in WSO2 Micro Integrator to read messages from the WebLogic queue:

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="WeblogicJMSConsumerProxy"
       transports="jms"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
   <target>
      <inSequence>
         <log level="custom">
            <property name="STATUS:"
                      value="------Message consumed by WeblogicJMSConsumerProxy--------"/>
         </log>
         <log level="full"/>
      </inSequence>
      <outSequence>
         <send/>
      </outSequence>
   </target>
   <parameter name="transport.jms.Destination">jms/TestJMSQueue1</parameter>
   <description/>
</proxy>
```