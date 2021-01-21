# About Message Stores and Processors

A **Message Store** is used by a [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties.md) to temporarily store messages before they are delivered to their destination. This approach is useful for serving traffic to back-end services that can only accept messages at a given rate, whereas incoming traffic arrives at different rates. 

The [Store Mediator]({{base_path}}/reference/mediators/store-mediator.md) in a mediation sequence is used to store incoming messages in the message store. The **Message Processor** retrieves the messages from the message store and delivers them to the back-end service at a given rate.

Multiple message processors can use the same message store. For example, in a clustered environment, each of the nodes would have an instance of the same message processor, each of which would connect to the same message store and evenly consume messages. The message store acts as a manager of these consumers and their connections and ensures that messages are processed by only one message processor, preventing message duplication. You can further control which nodes a message processor runs on by specifying pinned servers.

!!! Info
    You can increase performance of message processors either by **increasing the member count** or by having multiple message processors. If you increase the member count, it will create multiple child processors of the message processor.

## List of Message Stores

- <a href="{{base_path}}/reference/synapse-properties/message-stores/jms-msg-store-properties">JMS Message Store</a>
- <a href="{{base_path}}/reference/synapse-properties/message-stores/jdbc-msg-store-properties">JDBC Message Store</a>
- <a href="{{base_path}}/reference/synapse-properties/message-stores/rabbitmq-msg-store-properties">RabbitMQ Message Store</a>
- <a href="{{base_path}}/reference/synapse-properties/message-stores/resequence-msg-store-properties">Resequence Message Store</a>
- <a href="{{base_path}}/reference/synapse-properties/message-stores/wso2mb-msg-store-properties">WSO2 MB Message Store</a>
- <a href="{{base_path}}/reference/synapse-properties/message-stores/in-memory-msg-store-properties">In-Memory Message Store</a>
- <a href="{{base_path}}/reference/synapse-properties/message-stores/custom-msg-store-properties">Custom Message Store</a>

<!--

<table>
  <tr>
    <th>Message Store Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>
      JDBC Message Store
    </td>
    <td>
      Used for storing and retrieving messages more efficiently in comparison with other message stores. This is a variation of the already existing synapse message store implementation and is designed in a manner similar to the same message store. The JDBC message store uses a JDBC connector to connect to external relational databases.</br></br>
      The advantages of using a JDBC message store instead of any other message store are as follows:
      <ul>
        <li>
          <b>Easy to connect</b>: You only need to have a JDBC connector to connect to an external relational database.
        </li>
        <li>
          <b>Quick transactions</b>: JDBC message stores are capable of handling a large number of transactions per second.
        </li>
        <li>
          <b>Ability to work with a high capacity for a long period of time</b>: Since JDBC stores use databases as the medium to store data, it can store a large volume of data and is capable of handling data for a longer period of time.
        </li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      JMS Message Store
    </td>
    <td>
      Persists messages in a JMS queue inside a JMS Broker. Since messages are persisted in an orderly manner, JMS message stores implement the <b>Store and Forward</b> integration pattern. This message store can be configured by specifying the class as <code>org.apache.synapse.message.store.impl.jms.JmsStore</code>.
    </td>
  </tr>
  <tr>
    <td>
      RabbitMQ Message Store
    </td>
    <td>
      Persists messages in a RabbitMQ queue inside a RabbitMQ broker. The RabbitMQ message store can be configured by specifying the class as <code>org.apache.synapse.message.store.impl.rabbitmq.RabbitmqStore</code>.
    </td>
  </tr>
  <tr>
    <td>
      Resequence Message Store
    </td>
    <td>
      Used for storing a stream of related but out-of-sequence messages so that they can be put back into the correct order. It collects and reorders the stored messages based on a defined sequence number derived from some part of the message. The messages are then published to the output channel in a specific order. This helps when the order of message delivery is important. For example, it avoids some messages arriving earlier than others.</br>
      The resequencing store is an extension of the existing JDBC-based message store. Hence, it inherits most of its properties from the <b>JDBC message store</b>.
    </td>
  </tr>
  <tr>
    <td>
      WSO2 MB Message Store
    </td>
    <td>
      WSO2 Message Broker is used as the <b>message store</b> for the Micro Integrator.
    </td>
  </tr>
  <tr>
    <td>
      In-Memory Message Store
    </td>
    <td>
      This is a basic <b>message store</b> that stores messages in an in-memory queue. This means that all the stored messages will be lost when the server restarts. The in memory message store is a lot faster than a persistent message store. Therefore, it can be used to temporarily store messages for high-speed <b>store and forward</b> integrations where message persistence is not a requirement.</br></br>
      <b>Note</b>: In memory message stores are not recommended for use in production as well as in scenarios where large scale message storing is required. You can use an external message store (e.g., <b>JMS message store</b>) for such scenarios.
    </td>
  </tr>
  <tr>
    <td>Custom Message Store</td>
    <td>
      Users can create a message store with their own message store implementation. Custom message stores are configured by giving the fully qualified class name of the message store implementation as the class value. Any configuration parameter that is needed by the message store implementation class can be passed.
    </td>
  </tr>
</table>
-->

## List of Message Processors

- <a href="{{base_path}}/reference/synapse-properties/message-processors/msg-sampling-processor-properties">Message Sampling Processor</a>
- <a href="{{base_path}}/reference/synapse-properties/message-processors/msg-sched-forwarding-processor-properties">Scheduled Message Forwarding Processor</a>
- <a href="{{base_path}}/reference/synapse-properties/message-processors/msg-sched-failover-forwarding-processor-properties">Scheduled Failover Message Forwarding Processor</a>

<!--
<table>
  <tr>
    <th>Message Processor</th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      Message Sampling Processor
    </td>
    <td>
      The message sampling processor consumes messages in a <a href="#list-of-message-stores">message store</a> and sends them to a configured <a href="{{base_path}}/reference/synapse-properties/sequence-properties">sequence</a>. This process happens at a preconfigured interval. This message processor does not ensure reliable messaging.
    </td>
  </tr>
  <tr>
    <td>Scheduled Failover Message Forwarding Processor</td>
    <td>
      The scheduled failover message forwarding processor ensures reliable message delivery. This helps ensure guaranteed message delivery even when there is a failure in the message store.</br></br>
      The only difference between the scheduled failover message forwarding processor and the scheduled message forwarding processor is that the scheduled message forwarding processor forwards messages to a defined endpoint, whereas the scheduled failover message forwarding processor forwards messages to a target message store.
    </td>
  </tr>
  <tr>
    <td>Scheduled Message Forwarding Processor</td>
    <td>
      The scheduled message forwarding processor consumes messages in a message store and sends them to an <a href="{{base_path}}/reference/synapse-properties/endpoint-properties">endpoint</a>. If a message is successfully delivered to the endpoint, the processor deletes the message from the message store. In case of a failure, it will retry after a specified interval.
    </td>
  </tr>
  <tr>
    <td>Custom Message Processor</td>
    <td>
      Existing message processor implementations are created using the <a href="http://quartz-scheduler.org/">Quartz</a> enterprise job scheduler. If needed, you can create your own implementation of message processors by creating a Java class that implements the <code>MessageProcessor</code> interface. You can then add your custom message processor by specifying your implementation class.</br></br>
      <b>Note</b> that message processors go through several life-cycle stages. Therefore, it is recommended to use existing implementations, which are tested and proven under high loads whenever possible.
    </td>
  </tr>
</table>
-->