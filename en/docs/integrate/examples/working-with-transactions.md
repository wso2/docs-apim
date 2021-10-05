# Working with Transactions

!!! Warning
    **Please note that the contents on this page are under review!**

A **transaction** is a set of operations executed as a single unit. It
also can be defined as an agreement, which is carried out between
separate entities or objects. A transaction can be considered as
indivisible or atomic when it has the characteristic of either being
completed in its entirety or not at all. During the event of a failure
for a transaction update, atomic transaction type guarantees transaction
integrity such that any partial updates are rolled back automatically.

Transactions have many different forms, such as financial transactions,
database transactions etc.

## Distributed transactions

A **distributed transaction** is a transaction that updates data on two
or more networked computer systems, such as two databases, or a database
and a message queue such as JMS. Implementing robust distributed
applications is difficult because these applications are subject to
multiple failures, including failure of the client, the server, and the
network connection between the client and server. For distributed
transactions, each computer has a local transaction manager. When a
transaction works at multiple computers, the transaction managers
interact with other transaction managers via either a superior or
subordinate relationship. These relationships are relevant only for a
particular transaction.

For an example that demonstrates how the [transaction
mediator]({{base_path}}/reference/mediators/transaction-mediator/) can
be used to manage distributed transactions , see [Transaction Mediator
Example](https://docs.wso2.com/display/EI650/Transaction+Mediator+Example).

### Java Message Service (JMS) transactions

In addition to the [transaction
mediator]({{base_path}}/reference/mediators/transaction-mediator/) ,
WSO2 Micro Integrator (WSO2 MI) also supports JMS transactions.

!!! Note
    In WSO2 MI, JMS transactions only work with either the Callout mediator or the Call mediator in blocking mode.

The [JMS transport](https://docs.wso2.com/display/EI650/JMS+Transport)
shipped with WSO2 MI supports both local and distributed JMS
transactions. You can use local transactions to group messages
received in a JMS queue. Local transactions are not supported for
messages sent to a JMS queue.

## JMS consumer transactions

Following sections describe the JMS consumer transactions.

### JMS local transactions

A **local transaction** represents a unit of work on a single connection
to a data source managed by a resource manager. In JMS, you can use the
JMS API to get a transacted session and to call methods for commit or
roll back for the relevant transaction objects. This is managed
internally by a resource manager. There is no external transaction
manager involved in the coordination of such transactions.

Let's explore a sample scenario that demonstrates how to handle a
transaction using JMS in a situation where the back-end service is
unreachable.

#### Sample scenario

A message is read from a JMS queue and is processed by a back-end
service. In the successful scenario, the transaction will be committed
and the request will be sent to the back end service. In the failure
scenario, while executing a sequence, a failure occurs and WSO2 MI
receives a fault. This cause the JMS transaction to roll back.

The sample scenario can be depicted as follows:

![]({{base_path}}/assets/img/integrate/jms_transaction.png)

#### Prerequisites

-   Windows, Linux or Solaris operating systems with WSO2 MI
    installed. For instructions on downloading and installing WSO2 MI,
    see [Installation Guide]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi) .
-   WSO2 MI JMS transport configured with ActiveMQ. For instructions,
    see [Configure with ActiveMQ](https://ei.docs.wso2.com/en/latest/micro-integrator/setup/brokers/configure-with-ActiveMQ/)
    .

#### Configuring the sample scenario

1.  Configure the JMS local transaction by defining the following
    parameter in the
    `           <MI_HOME>/conf/deployment.toml          ` file. By default the session is not transacted. In order to 
    make it transacted, we set the session_transaction parameter to true .
    
    ```
    [[transport.jms.listener]]
    name = "myTopicConnectionFactory"
    parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
    parameter.provider_url = "tcp://localhost:61616"
    parameter.connection_factory_name = "TopicConnectionFactory"
    parameter.connection_factory_type = "topic"
    parameter.session_transaction = true

    [[transport.jms.listener]]
    name = "myQueueConnectionFactory"
    parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
    parameter.provider_url = "tcp://localhost:61616"
    parameter.connection_factory_name = "QueueConnectionFactory"
    parameter.connection_factory_type = "queue" # [queue, topic]
    parameter.session_transaction = true

    [[transport.jms.listener]]
    name = "default"
    parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
    parameter.provider_url = "tcp://localhost:61616"
    parameter.connection_factory_name = "QueueConnectionFactory"
    parameter.connection_factory_type = "queue" # [queue, topic]
    parameter.session_transaction = true
    ```

2.  Copy and paste the following configuration into the Synapse
    configuration in \<
    `           MI_HOME>/repository/deployment/server/synapse-configs/<node>/synapse.xml          `
    .

    ```xml
       <proxy xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteProxy" transports="jms" startOnLoad="true">
          <target>
             <inSequence>
                <property name="OUT_ONLY" value="true"/>
                <callout serviceURL="http://localhost:9000/services/SimpleStockQuoteService">
                   <source type="envelope"/>
                   <target key="placeOrder"/>
                </callout>
                <log level="custom">
                   <property name="Transaction Action" value="Committed"/>
                </log>
             </inSequence>
             <faultSequence>
                <property name="SET_ROLLBACK_ONLY" value="true" scope="axis2"/>
                <log level="custom">
                   <property name="Transaction Action" value="Rollbacked"/>
                </log>
             </faultSequence>
          </target>
          <parameter name="transport.jms.ContentType">
             <rules>
                <jmsProperty>contentType</jmsProperty>
                <default>application/xml</default>
             </rules>
          </parameter>
       </proxy>
    ```

    According to the above configuration, a message will be read from
    the JMS queue and will be sent to the
    `           SimpleStockQuoteService          `. If a failure occurs, the transaction will roll
    back.

    In the above configuration, the following property is set to
    **true** in the fault handler, in order to roll back the transaction
    when a failure occurs.

    ```xml
    <property name="SET_ROLLBACK_ONLY" value="true" scope="axis2"/>
    ```

    !!! Tip
        If you are using a JMS Inbound endpoint for the transaction, set the
        scope of the `           SET_ROLLBACK_ONLY          ` property to
        `           default          ` as follows: 
        
    ```xml
    <property name="SET_ROLLBACK_ONLY" scope="default" type="STRING" value="true"/>
    ```
    
3.  Deploy the back-end service
    `          SimpleStockQuoteService         ` . 
    * Download the ZIP file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
    * Extract the downloaded zip file.
    * Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
    * Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```
            
    You now have a running WSO2 MI instance, ActiveMQ instance and a
    sample back-end service to simulate the sample scenario.

    !!! Info
        Due to the asynchronous behavior of the [Send
        Mediator]({{base_path}}/reference/mediators/send-mediator/) , you
        cannot you use it with a http/https endpoint, but you can use it in
        asynchronous use cases, for example with another JMS as endpoint.
    
#### Executing the sample scenario

   To execute the sample scenario we need to trigger a sample message to the JMS Server.
   Add a message in `StockQuoteProxy` queue with an XML payload using the [ActiveMQ Web Console](https://activemq.apache.org/web-console.html).
     
#### Testing the sample scenario

You can test the sample scenario as follows.

**Successful scenario**

If the message mediates successfully, the MI log will display an
INFO message indicating that the transaction is committed.

**Failure scenario**

Stop the SimpleStockQuoteService and add a message in StockQuoteProxy queue once again to
simulate the failure scenario. In this scenario, the MI log will
display an INFO message indicating that the transaction is rolled back.

### JMS distributed transactions

WSO2 MI also supports distributed JMS transactions. You can use the JMS
transport with more than one distributed resource, for example, two
remote database servers. An external transaction manager coordinates the
transaction. Designing and using JMS distributed transactions is more
complex than using local JMS transactions.

The transaction manager is the primary component of the distributed
transaction infrastructure and distributed JMS transactions are managed
by the
[XAResource](http://docs.oracle.com/javaee/5/api/javax/transaction/xa/XAResource.html)
enabled transaction manager in the Java 2 Platform, Enterprise Edition
(J2EE) application server.

!!! Info
    You will need to check if your message broker supports [XA transactions](https://docs.oracle.com/cd/E19509-01/820-5892/ref_xatrans/index.html) prior to implementing distributed JMS transactions.

#### XA two-phase commit process

XA is a two-phase commit specification that is used in distributed
transaction processing. Let's look at a sample scenario for JMS
distributed transactions.

##### Sample Scenario

MI listens to the message queue and sends that message to multiple
queues. If something goes wrong in sending the message to one of those
queues, the original message should be rolled back to the listening
queue and none of the other queues should receive the message. Thus, the
entire transaction should be rolled back.

##### Prerequisites

-   Windows, Linux or Solaris operating systems with WSO2 MI
    installed. For instructions on downloading and installing WSO2 MI,
    see [Installation
    Guide]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi) .
-   WSO2 MI JMS transport configured with ActiveMQ. For instructions,
    see [Configure with
    ActiveMQ](https://ei.docs.wso2.com/en/latest/micro-integrator/setup/brokers/configure-with-ActiveMQ/)
    .

##### Configuring the sample scenario

1.  Create the `             JMSListenerProxy            ` proxy service
    in WSO2 MI with the following configuration:

    ```
        <proxy xmlns="http://ws.apache.org/ns/synapse"
               name="JMSListenerProxy"
               transports="https http jms"
               startOnLoad="true">
           <description/>
           <target>
              <inSequence>
                 <property name="OUT_ONLY" value="true"/>
                 <log level="custom">
                    <property name="MESSAGE_ID_A" expression="get-property('MessageID')"/>
                 </log>
                 <log level="custom">
                    <property name="BEFORE" expression="$body"/>
                 </log>
                 <property name="MESSAGE_ID_B"
                           expression="get-property('MessageID')"
                           scope="operation"
                           type="STRING"/>
                 <property name="failureResultProperty"
                           scope="default"
                           description="FailureResultProperty">
                    <result xmlns="">failure</result>
                 </property>
                 <enrich>
                    <source clone="true" xpath="$ctx:failureResultProperty"/>
                    <target type="body"/>
                 </enrich>
                 <log level="custom">
                    <property name="AFTER" expression="$body"/>
                 </log>
                 <property name="BEFORE1" value="ABCD" scope="axis2" type="STRING"/>
                <callout serviceURL="jms:/ActiveMQPublisher1?transport.jms.ConnectionFactoryJNDIName=XAConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616&amp;transport.jms.DestinationType=queue;transport.jms.TransactionCommand=begin">
                    <source type="envelope"/>
                    <target xmlns:s12="http://www.w3.org/2003/05/soap-envelope"
                            xmlns:s11="http://schemas.xmlsoap.org/soap/envelope/"
                            xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
                 </callout>
                 <callout serviceURL="jms:/ActiveMQPublisher2?transport.jms.ConnectionFactoryJNDIName=XAConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616&amp;transport.jms.DestinationType=queue">
                    <source type="envelope"/>
                    <target xmlns:s12="http://www.w3.org/2003/05/soap-envelope"
                            xmlns:s11="http://schemas.xmlsoap.org/soap/envelope/"
                            xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
                 </callout>
                 <callout serviceURL="jms:/ActiveMQPublisher3?transport.jms.ConnectionFactoryJNDIName=XAConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616&amp;transport.jms.DestinationType=queue;transport.jms.TransactionCommand=end">
                    <source type="envelope"/>
                    <target xmlns:s12="http://www.w3.org/2003/05/soap-envelope"
                            xmlns:s11="http://schemas.xmlsoap.org/soap/envelope/"
                            xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
                 </callout>
                 <drop/>
              </inSequence>
              <faultSequence>
                 <log level="custom">
                    <property name="Transaction Action" value="Rollbacked"/>
                 </log>
                 <callout serviceURL="jms:/ActiveMQPublisherFault?transport.jms.ConnectionFactoryJNDIName=XAConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616&amp;transport.jms.DestinationType=queue;transport.jms.TransactionCommand=rollback">
                    <source type="envelope"/>
                    <target xmlns:s12="http://www.w3.org/2003/05/soap-envelope"
                            xmlns:s11="http://schemas.xmlsoap.org/soap/envelope/"
                            xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
                 </callout>
              </faultSequence>
           </target>
           <parameter name="transport.jms.ContentType">
              <rules>
                 <jmsProperty>contentType</jmsProperty>
                 <default>application/xml</default>
              </rules>
           </parameter>
           <parameter name="transport.jms.Destination">MyJMSQueue</parameter>
        </proxy>
    ```

    In the above configuration,  WSO2 MI listens to a JMS queue named
    `             MyJMSQueue            ` and consumes messages as well
    as sends messages to multiple JMS queues in a transactional manner.

2.  Place a message in `MyJMSQueue` using the [ActiveMQ Web Console](https://activemq.apache.org/web-console.html).

    You can see how WSO2 MI consumes messages from the queue named
    `             MyJMSQueue            ` and sends the messages to
    multiple queues.

    To check the rollback functionality provide an unreachable hostname
    to any destination queue and save the configurations. You should be
    able to observe WSO2 MI fault sequence getting invoked and failed
    message delivered to the destination configured in the fault
    sequence.

#### JMS publisher transactions

When you do not enable publisher transactions, the message publishing
call to the Broker will not wait until the messages are persisted to the
database. As a result, a successful HTTP response will be returned back
to the caller even in a state where the database is disconnected. Hence,
the message might actually be lost and not persisted in the Broker.
Therefore, you can achieve guaranteed delivery by enabling publisher
transactions.

The below is a sample scenario that demonstrates how to handle a
publisher transaction using JMS.

##### Sample scenario

In this scenario, the client publishes JMS messages to the WSO2 MI. Then, WSO2 MI publishes those messages to the JMS
queue, which acts as the JMS endpoint. The sample scenario can be
depicted as follows.

##### Prerequisites

-   Install WSO2 MI. For instructions , see [Installation
    Guide]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi) .
-   WSO2 MI JMS transport configured with ActiveMQ. For instructions,
        see [Configure with
        ActiveMQ](https://ei.docs.wso2.com/en/latest/micro-integrator/setup/brokers/configure-with-ActiveMQ/)
    .

##### Configuring the sample scenario

1.  Configure the JMS sender for the WSO2 MI by adding the following configurations in deployment.toml file
    available in
    `             <MI_HOME>/conf/deployment.toml            `

    !!! Info
        By default, the session is not transacted. Set the value of the
        `             session_transaction            ` property to true, to
        make it transacted to publish transactions successfully.
    
    ```
        [[transport.blocking.jms.sender]]   # jms sender for blocking transport
        name = "commonTopicPublisherConnectionFactory"
        parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "TopicConnectionFactory"
        parameter.connection_factory_type = "topic"
        parameter.cache_level = "producer"
        parameter.session_transaction = true
        
        [[transport.blocking.jms.sender]]   # jms sender for blocking transport
        name = "commonJmsSenderConnectionFactory"
        parameter.initial_naming_factory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory"
        parameter.provider_url = "tcp://localhost:61616"
        parameter.connection_factory_name = "QueueConnectionFactory"
        parameter.connection_factory_type = "queue"
        parameter.cache_level = "producer"
        parameter.session_transaction = true
    ```

2.  Create an XML file with the below Synapse configuration of a sample
    publisher Proxy Service, and place the file inside the
    `             <MI_HOME>/repository/deployment/server/synapse-configs/default/proxy-services/            `
    directory.

    ```
            <proxy name="SampleProxy" transports="http" startOnLoad="true" xmlns="http://ws.apache.org/ns/synapse">
               <description/>
               <target>
                  <inSequence>
                     <property name="OUT_ONLY" value="true"/>
                     <property name="messageType" value="text/xml" scope="axis2" type="STRING"/>
                     <property name="routingKey" value="example.MyTopic" type="STRING"/>
                     <call blocking="true">
                        <endpoint>
                           <address uri="jms:/example.MyTopic?transport.jms.ConnectionFactory=commonTopicPublisherConnectionFactory"/>
                        </endpoint>
                     </call>
                     <payloadFactory media-type="xml">
                        <format>
                           <serviceResponse xmlns="">
                              <returnCode>200</returnCode>
                              <returnDesc>Successful</returnDesc>
                              <returnData>
                                 <data name="routingKey" type="xml">$1</data>
                              </returnData>
                           </serviceResponse>
                        </format>
                        <args>
                           <arg evaluator="xml" expression="$ctx:routingKey"/>
                        </args>
                     </payloadFactory>
                     <property name="HTTP_SC" value="200" scope="axis2" type="STRING"/>
                     <respond/>
                  </inSequence>
                  <outSequence/>
                  <faultSequence>
                     <property name="SET_ROLLBACK_ONLY" value="true" scope="axis2"/>
                     <payloadFactory media-type="xml">
                        <format>
                           <serviceResponse xmlns="">
                              <returnCode>500</returnCode>
                              <returnDesc>Failure</returnDesc>
                              <returnData>
                                 <data name="routingKey" type="xml">$1</data>
                              </returnData>
                           </serviceResponse>
                        </format>
                        <args>
                           <arg evaluator="xml" expression="$ctx:routingKey"/>
                        </args>
                     </payloadFactory>
                     <property name="HTTP_SC" value="500" scope="axis2" type="STRING"/>
                     <log level="full"/>
                     <respond/>
                  </faultSequence>
               </target>
            </proxy>
    ```

##### Executing the sample scenario

Use a JMS client such as [Apache JMeter](https://jmeter.apache.org/) to
execute this sample scenario.

##### Testing the sample scenario

When a message is successfully published, it returns an HTTP 200
response to the client (successful scenario). In a case where it fails
to publish a message, it executes the fault sequence returning an HTTP
500 response to the client (failure scenario) .
