# admin\_JMS Transport

JMS (Java Message Service) transport implementation also comes from the WS-Commons Transports project. All the relevant classes are packed into the `         axis2-transport-jms-<version>.jar        ` and the following classes act as the transport receiver and the sender respectively.

-   `          org.apache.axis2.transport.jms.JMSListener         `
-   `          org.apache.axis2.transport.jms.JMSSender         `

The JMS transport implementation requires an active JMS server instance to be able to receive and send messages. We recommend using Apache ActiveMQ JMS server, but other implementations such as Apache Qpid and Tibco are also supported. You also need to put the client JARs for your JMS server in Carbon classpath. In case of Apache ActiveMQ, you need to put the following JARs in the classpath:

-   `          activemq-core.jar         `
-   `          geronimo-j2ee-management_1.0_spec-1.0.jar         `
-   `          geronimo-jms_1.1_spec-1.1.1.jar         `

These JAR files can be obtained by downloading the latest version of Apache ActiveMQ (version 5.2.0 is recommended). Extract the downloaded archive and find the required dependencies in the `         $ACTIVEMQ_HOME/lib        ` directory. You need to copy these JAR files over to `         $CARBON_HOME/repository/components/lib        ` directory for Carbon to be able to pick them up at run-time.

Configuration parameters for JMS receiver and the sender are XML fragments that represent JMS connection factories. A typical JMS parameter configuration would look like this:

``` java
    <parameter name="myTopicConnectionFactory">
          <parameter name="java.naming.factory.initial">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
          <parameter name="java.naming.provider.url">tcp://localhost:61616</parameter>
          <parameter name="transport.jms.ConnectionFactoryJNDIName">TopicConnectionFactory</parameter>
          <parameter name="transport.jms.ConnectionFactoryType">topic</parameter>
    </parameter>
```

This is a bare minimal JMS connection factory configuration, which consists of four connection factory parameters. JMS connection factory parameters are described in detail below.

### JMS connection factory parameters

!!! tip
In transport parameter tables, literals displayed in italic mode under the "Possible Values" column should be considered as fixed literal constant values. Those values can be directly put in transport configurations.


<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>java.naming.factory.initial</p></td>
<td><p>JNDI initial context factory class. The class must implement the <code>              java.naming.spi.InitialContextFactory             </code> interface.</p></td>
<td><p>Yes</p></td>
<td><p>A valid class name</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>java.naming.provider.url</p></td>
<td><p>URL of the JNDI provider.</p></td>
<td><p>Yes</p></td>
<td><p>A valid URL</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>java.naming.security.principal</p></td>
<td><p>JNDI Username.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>java.naming.security.credentials</p></td>
<td><p>JNDI password.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.Transactionality</p></td>
<td><p>Desired mode of transactionality.</p></td>
<td><p>No</p></td>
<td><p><em>none, local, jta</em></p></td>
<td><p>none</p></td>
</tr>
<tr class="even">
<td><p>transport.UserTxnJNDIName</p></td>
<td><p>JNDI name to be used to require user transaction.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p>java:comp/UserTransaction</p></td>
</tr>
<tr class="odd">
<td><p>transport.CacheUserTxn</p></td>
<td><p>Whether caching for user transactions should be enabled or not.</p></td>
<td><p>No</p></td>
<td><p><em>true, false</em></p></td>
<td><p>true</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.SessionTransacted</p></td>
<td><p>Whether the JMS session should be transacted or not.</p></td>
<td><p>No</p></td>
<td><p><em>true, false</em></p></td>
<td><p>true if transactionality is 'local'</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.SessionAcknowledgement</p></td>
<td><p>JMS session acknowledgment mode.</p></td>
<td><p>No</p></td>
<td><p><em>AUTO_ACKNOWLEDGE, CLIENT_ACKNOWLEDGE, DUPS_OK_ACKNOWLEDGE, SESSION_TRANSACTED</em></p></td>
<td><p>AUTO_ACKNOWLEDGE</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.ConnectionFactoryJNDIName</p></td>
<td><p>The JNDI name of the connection factory.</p></td>
<td><p>Yes</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.ConnectionFactoryType</p></td>
<td><p>Type of the connection factory.</p></td>
<td><p>No</p></td>
<td><p><em>queue, topic</em></p></td>
<td><p>queue</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.JMSSpecVersion</p></td>
<td><p>JMS API version.</p></td>
<td><p>No</p></td>
<td><p><em>1.1, 1.0.2b</em></p></td>
<td><p>1.1</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.UserName</p></td>
<td><p>The JMS connection username.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.jms.Password</p></td>
<td><p>The JMS connection password.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.Destination</p></td>
<td><p>The JNDI name of the destination.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p>Defaults to service name</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.DestinationType</p></td>
<td><p>Type of the destination.</p></td>
<td><p>No</p></td>
<td><p><em>queue, topic</em></p></td>
<td><p>queue</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.DefaultReplyDestination</p></td>
<td><p>JNDI name of the default reply destination.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.jms.DefaultReplyDestinationType</p></td>
<td><p>Type of the reply destination.</p></td>
<td><p>No</p></td>
<td><p><em>queue, topic</em></p></td>
<td><p>Defaults to the type of the destination</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.MessageSelector</p></td>
<td><p>Message selector implementation.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.jms.SubscriptionDurable</p></td>
<td><p>Whether the connection factory is subscription durable or not.</p></td>
<td><p>No</p></td>
<td><p><em>true, false</em></p></td>
<td><p>false</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.DurableSubscriberName</p></td>
<td><p>Name of the durable subscriber.</p></td>
<td><p>Yes if the subscription durable is turned on</p></td>
<td><p></p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>transport.jms.PubSubNoLocal</p></td>
<td><p>Whether the messages should be published by the same connection they were received.</p></td>
<td><p>No</p></td>
<td><p><em>true, false</em></p></td>
<td><p>false</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.CacheLevel</p></td>
<td><p>JMS resource cache level.</p></td>
<td><p>No</p></td>
<td><p>none, connection, session, consumer, producer, auto</p></td>
<td><p>auto</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.ReceiveTimeout</p></td>
<td><p>Time to wait for a JMS message during polling. Set this parameter value to a negative integer to wait indefinitely. Set to zero to prevent waiting.</p></td>
<td><p>No</p></td>
<td><p>Number of milliseconds to wait</p></td>
<td><p>1000 ms</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.ConcurrentConsumers</p></td>
<td><p>Number of concurrent threads to be started to consume messages when polling.</p></td>
<td><p>No</p></td>
<td><p>Any positive integer - For topics this must be always 1</p></td>
<td><p>1</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.MaxConcurrentConsumers</p></td>
<td><p>Maximum number of concurrent threads to use during polling.</p></td>
<td><p>No</p></td>
<td><p>Any positive integer - For topics this must be always 1</p></td>
<td><p>1</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.IdleTaskLimit</p></td>
<td><p>The number of idle runs per thread before it dies out.</p></td>
<td><p>No</p></td>
<td><p>Any positive integer</p></td>
<td><p>10</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.MaxMessagesPerTask</p></td>
<td><p>The maximum number of successful message receipts per thread.</p></td>
<td><p>No</p></td>
<td><p>Any positive integer - Use -1 to indicate infinity</p></td>
<td><p>-1</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.InitialReconnectDuration</p></td>
<td><p>Initial reconnection attempts duration in milliseconds.</p></td>
<td><p>No</p></td>
<td><p>Any positive integer</p></td>
<td><p>10000 ms</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.ReconnectProgressFactor</p></td>
<td><p>Factor by which the reconnection duration will be increased.</p></td>
<td><p>No</p></td>
<td><p>Any positive integer</p></td>
<td><p>2</p></td>
</tr>
<tr class="odd">
<td><p>transport.jms.MaxReconnectDuration</p></td>
<td><p>Maximum reconnection duration in milliseconds.</p></td>
<td><p>No</p></td>
<td><p></p></td>
<td><p>3600000 ms (1 hr)</p></td>
</tr>
</tbody>
</table>

JMS transport implementation has some parameters that should be configured at service level, in other words in service XML files of individual services.

### Service level JMS configuration parameters

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>transport.jms.ConnectionFactory</p></td>
<td><p>Name of the JMS connection factory the service should use.</p></td>
<td><p>No</p></td>
<td><p>A name of an already defined connection factory</p></td>
<td><p>default</p></td>
</tr>
<tr class="even">
<td><p>transport.jms.PublishEPR</p></td>
<td><p>JMS EPR to be published in the WSDL.</p></td>
<td><p>No</p></td>
<td><p>A JMS EPR</p></td>
<td><p></p></td>
</tr>
</tbody>
</table>


