# JMS Inbound 
## Introduction

The JMS inbound protocol is an alternative to the JMS transport. The JMS inbound protocol implementation requires an active JMS server instance to be able to receive messages, and you need to place the client JARs for your JMS server in the Micro Integrator.

## Properties

Listed below are the properties used for [creating a JMS inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

### Required Properties

The following properties are required when [creating a JMS inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>
      <p>java.naming.factory.initial</p>
    </td>
    <td>
      <p>The JNDI initial context factory class. The class must implement the <code>java.naming.spi.InitialContextFactory</code> interface.</p>
    </td>
  </tr>
  <tr>
    <td>
       <p>java.naming.provider.url</p>
     </td>
     <td>
       <p>The URL of the JNDI provider.</p>
     </td>
  </tr>
  <tr>
    <td>
      <p>transport.jms.ConnectionFactoryJNDIName</p>
    </td>
    <td>
      <p>The JNDI name of the connection factory.</p>
    </td>
  </tr>
  <tr>
    <td>interval</td>
    <td>
      The polling interval for the inbound endpoint to execute each cycle. This value is set in milliseconds.
    </td>
  </tr>
  <tr>
    <td>coordination</td>
    <td>
      This optional property is only applicable in a cluster environment. In a clustered environment, an inbound endpoint will only be executed in worker nodes. If set to <code>true</code> in a cluster setup, this will run the inbound only in a single worker node. Once the running worker is down, the inbound starts on another available worker in the cluster. By default, coordniation is enabled.
    </td>
  </tr>
  <tr>
    <td>
       sequential
     </td>
     <td>Whether the messages need to be polled and injected sequentially or not.</td>
  </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating a JMS inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
   <thead>
      <tr>
         <th>
            <p>Property Name</p>
         </th>
         <th>
            <p>Description</p>
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
            transport.jms.ConnectionFactoryType
         </td>
         <td>
            The type of the connection factory.</br></br>  Set to <b>queue</b> by default.
         </td>
      </tr>
      <tr>
         <td>
            <p>transport.jms.Destination/p>
         </td>
         <td>
            <p>The JNDI name of the destination.</p>
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.SessionAcknowledgement
         </td>
         <td>
            <p>The JMS session acknowledgment mode. You can use one of the following: <code>AUTO_ACKNOWLEDGE</code> , <code>CLIENT_ACKNOWLEDGE</code> , <code>DUPS_OK_ACKNOWLEDGE</code> , <code>SESSION_TRANSACTED</code>.</p>
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.CacheLevel
         </td>
         <td>
            <p>The JMS resource cache level. Possible values are as follows: <code>0</code>(none), <code>1</code>(connection), <code>2</code>(session), <code>3</code>(consumer).</br></br> The default value is <code>0-none</code>.</br></br>
            <b>Note</b>:To subscribe to topics, set the value of <code>transport.jms.CacheLevel</code> to <code>3</code>.</p>
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.UserName
         </td>
         <td>
            <p>The JMS connection username.</p>
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.Password
         </td>
         <td>
            <p>The JMS connection password.</p>
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.JMSSpecVersion
         </td>
         <td>
            <p>The JMS API version. The possible values are as follows: <code>1.0.2b</code>, <code>1.1</code>, <code>2.0</code>.</br></br> The default value is <code>1.1.</code>.</p>
         </td>
      </tr>
      <tr>
         <td>transport.jms.SubscriptionDurable</td>
         <td>Whether the connection factory is subscription durable or not.</td>
      </tr>
      <tr>
         <td>transport.jms.DurableSubscriberClientID</td>
         <td>The <code>ClientId</code> parameter when using durable subscriptions. This property is required if the value specified as <code>transport.jms.SubscriptionDurable</code> is <code>true</code>.</td>
      </tr>
      <tr>
         <td>
            transport.jms.DurableSubscriberName
         </td>
         <td>
            <p>The name of the durable subscriber. This property is required if the value specified as <code>transport.jms.SubscriptionDurable</code> is <code>true</code>.</p>
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.MessageSelector
         </td>
         <td>
            Message selector implementation.
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.ReceiveTimeout
         </td>
         <td>The time to wait for a JMS message during polling.<br />
            Set this parameter value to a negative integer to wait indefinitely. Set it to zero to prevent waiting.</br></br> The default value is 1.
         </td>
      </tr>
      <tr>
         <td>transport.jms.ContentType</td>
         <td>How the inbound listener should determine the content type of received messages. Priority is always given to the JMS message type. Possible values are any simple string value. In which case the transport listener assumes that the received messages always have the specified content type, or a set of rules. For more information, see <a href="http://axis.apache.org/axis2/java/transports/jms.html#Service_configuration">http://axis.apache.org/axis2/java/transports/jms.html#Service_configuration</a>.</td>
      </tr>
      <tr>
         <td>transport.jms.ContentTypeProperty</td>
         <td>Gets the content type from the message property.</td>
      </tr>
      <tr>
         <td>transport.jms.ReplyDestination</td>
         <td>The destination where the response generated by the back-end service is stored.</td>
      </tr>
      <tr>
         <td>
            <p>transport.jms.PubSubNoLocal</p>
         </td>
         <td>
            <p>Whether messages should be published via the same connection that they were received.</p>
         </td>
      </tr>
      <tr>
         <td>
            transport.jms.SharedSubscription
         </td>
         <td>
            <p>If set to <code>true</code>, messages will be forwarded to only one of the consumers and consumers will share the messages that are published to the topic.</p>
         </td>
      </tr>
      <tr>
         <td>
            <p>pinnedServers</p>
         </td>
         <td>
            <p>List of synapse server names separated by commas or spaces where this inbound endpoint should be deployed. If there is no pinned server list, the inbound endpoint configuration will be deployed in all server instances.</p>
         </td>
      </tr>
      <tr>
         <td>transport.jms.ConcurrentConsumers</td>
         <td>Number of concurrent threads to be started to consume messages when polling.</br></br> The default value is 1. You can change this to any positive integer. However, for topics the value must always be 1.</td>
      </tr>
      <tr>
         <td>
            transport.jms.retry.duration
         </td>
         <td>
            <p>The retry interval (in miliseconds) to reconnect to the JMS server.</p>
         </td>
      </tr>
      <tr>
         <td>transport.jms.RetriesBeforeSuspension</td>
         <td>The number of consecutive mediation failures after which polling should be suspended. Specify any positive numerical value based on your requirement. Polling will be suspended when the mediation failure count reaches the specified value.</td>
      </tr>
      <tr>
         <td>transport.jms.PollingSuspensionPeriod</td>
         <td>The period of time that polling is to be suspended when the <code>             transport.jms.RetriesBeforeSuspension</code> parameter is set.</br></br> Default value is 60000.</td>
      </tr>
   </tbody>
</table>