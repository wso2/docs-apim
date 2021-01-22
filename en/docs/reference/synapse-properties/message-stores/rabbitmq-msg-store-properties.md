# RabbitMQ Message Store
## Introduction
Persists messages in a RabbitMQ queue inside a RabbitMQ broker. The RabbitMQ message store can be configured by specifying the class as <code>org.apache.synapse.message.store.impl.rabbitmq.RabbitmqStore</code>.

## Properties

Listed below are the properties used for [creating a RabbitMQ Message Store]({{base_path}}/integrate//develop/creating-artifacts/creating-a-message-store.md).

###  Required Properties

The following optional properties can be configured when [creating a RabbitMQ Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Name</td>
    <td>A unique name for the RabbitMQ message store.</td>
  </tr>
  <tr>
    <td>RabbitMQ Server Host Name</td>
    <td>The address of the RabbitMQ broker.</td>
  </tr>
  <tr>
    <td>RabbitMQ Server Host Port</td>
    <td>The port number of the RabbitMQ message broker.</td>
  </tr>
  <tr>
    <td>SSL Enabled</td>
    <td>
      Whether or not SSL is enabled on the message store. When SSL Enabled is set to true, you can set the parameters relating to the SSL configuration. For descriptions of each of these parameters you can set, see SSL enabled RabbitMQ message store parameters.
    </td>
  </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating a RabbitMQ Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>RabbitMQ Queue Name (store.rabbitmq.queue.name)</td>
    <td>
      The message store queue name. Though this is not a required parameter, we recommend specifying a value for this.
    </td>
  </tr>
  <tr>
    <td>RabbitMQ Exchange Name (store.rabbitmq.exchange.name)</td>
    <td>
      The name of the RabbitMQ exchange to which the queue is bound (If the ESB profile has to declare this exchange it will be declared as a direct exchange).
    </td>
  </tr>
  <tr>
    <td>Routing key (store.rabbitmq.route.key)</td>
    <td>
      The exchange and queue binding value. Messages will be routed using this. This is considered only when both the exchange name and type are provided. Else messages will be routed using the default exchange and queue name as the routing key.
    </td>
  </tr>
  <tr>
    <td>User Name (store.rabbitmq.username)</td>
    <td>
      The user name to connect to the broker.
    </td>
  </tr>
  <tr>
    <td>Password (store.rabbitmq.password)</td>
    <td>
      The password to connect to the broker.
    </td>
  </tr>
  <tr>
    <td>Virtual Host (store.rabbitmq.virtual.host)</td>
    <td>
      The virtual host name of the broker.
    </td>
  </tr>
  <tr>
    <td>Enable Producer Guaranteed Delivery</td>
    <td>
      See the <a href="#properties-guaranteed-delivery-of-messages">Properties for Guaranteed Delivery of Messages</a>.
    </td>
  </tr>
  <tr>
    <td>Failover Message Store</td>
    <td>
      See the <a href="#properties-guaranteed-delivery-of-messages">Properties for Guaranteed Delivery of Messages</a>.
    </td>
  </tr>
</table>

### SSL Properties

!!! Note
    Configuring parameters that provide information related to keystores and truststores can be optional based on your broker configuration. For example, if `         fail_if_no_peer_cert        ` is set to `         false        ` in the RabbitMQ broker configuration, then you only need to specify `         <parameter name="rabbitmq.connection.ssl.enabled" locked="false">true</parameter>        `. Additionally, you can also set `         <parameter name="rabbitmq.connection.ssl.version" locked="false">true</parameter>        ` parameter to specify the SSL version. If `         fail_if_no_peer_cert        ` is set to `         true        ` , you need to provide keystore and truststore information.

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>SSL Key Store Location</td>
    <td>The location of the keystore file.</td>
  </tr>
  <tr>
    <td>SSL Key Store Type</td>
    <td>
      The type of the keystore used (e.g., JKS, PKCS12).
    </td>
  </tr>
  <tr>
    <td>SSL Key Store Password</td>
    <td>
      The password to access the keystore.
    </td>
  </tr>
  <tr>
    <td>SSL Trust Store Location</td>
    <td>
      The location of the Java keystore file containing the collection of CA certificates trusted by this application process (truststore).
    </td>
  </tr>
  <tr>
    <td>SSL Trust Store Type</td>
    <td>
      The type of the truststore used.
    </td>
  </tr>
  <tr>
    <td>SSL Trust Store Password</td>
    <td>
      The password to unlock the trust store file specified in rabbitmq.connection.ssl.truststore.location.
    </td>
  </tr>
  <tr>
    <td>SSL Version</td>
    <td>
      SSL protocol version (e.g., SSL, TLSV1, TLSV1.2).
    </td>
  </tr>
</table>

### Properties: Guaranteed Delivery of Messages

If you need to ensure guaranteed delivery of your messages, specify values for the following parameters:

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Enable Producer Guaranteed Delivery</td>
    <td>
      This flag specifies whether guaranteed delivery is enabled on the producer side. The value is set to <code>false</code> by default.
    </td>
  </tr>
  <tr>
    <td>Failover Message Store</td>
    <td>
      The message store to which the store mediator should send messages when the original message store fails.
    </td>
  </tr>
</table> 