# JMS Message Store
## Introduction
Persists messages in a JMS queue inside a JMS Broker. Since messages are persisted in an orderly manner, JMS message stores implement the <b>Store and Forward</b> integration pattern. This message store can be configured by specifying the class as <code>org.apache.synapse.message.store.impl.jms.JmsStore</code>.

To try this out quickly, see the [JMS Message Store example]({{base_path}}/integrate/examples/message_store_processor_examples/using-jms-message-stores.md).

## Properties

Listed below are the properties used for [creating a JMS Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

### Required Properties

The following properties are required when [creating a JMS Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Message Store Name</td>
    <td>A unique name for the JMS message store.</td>
  </tr>
  <tr>
    <td>Message Store Type</td>
    <td>Select <b>JMS Message Store</b> from the list.</td>
  </tr>
  <tr>
    <td>Initial Context Factory</td>
    <td>
      The JNDI initial context factory class. This class must implement the java.naming.spi.InitialContextFactory interface. Initial Context Factory used to connect to the JMS broker.
    </td>
  </tr>
  <tr>
    <td>Provider URL</td>
    <td>
      The URL of the JNDI provider. URL of the naming provider to be used by the context factory.
    </td>
  </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating a JMS Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>JNDI Queue Name</td>
    <td>
      The message store queue name. Though this is not a required parameter, we recommend specifying a value for this.
    </td>
  </tr>
  <tr>
    <td>Connection factory</td>
    <td>
      The JNDI name of the connection factory that is used to create jms connections. Though this is not a required parameter, we recommend specifying a value for this.
    </td>
  </tr>
  <tr>
    <td>User Name</td>
    <td>
      The user name to connect to the broker.
    </td>
  </tr>
  <tr>
    <td>Password</td>
    <td>
      The password to connect to the broker.
    </td>
  </tr>
  <tr>
    <td>JMS API Specification Version</td>
    <td>
      The JMS API version to be used. Possible values are 1.1 (default) or 1.0.
    </td>
  </tr>
  <tr>
    <td>vender.class.loader.enabled</td>
    <td>
      Set to false when using IBM MQ, which requires skipping the external class loader. Recommended when using IBM MQ.
    </td>
  </tr>
  <tr>
    <td>store.jms.cache.connection</td>
    <td>
      true/false Enable Connection caching.
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