# Resequence Message Store
## Introduction
Used for storing a stream of related but out-of-sequence messages so that they can be put back into the correct order. It collects and reorders the stored messages based on a defined sequence number derived from some part of the message. The messages are then published to the output channel in a specific order. This helps when the order of message delivery is important. For example, it avoids some messages arriving earlier than others.</br>

The resequencing store is an extension of the existing JDBC-based message store. Hence, it inherits most of its properties from the <b>JDBC message store</b>.

## Properties

Listed below are the properties used for [creating a Resequence Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

### Required Properties

The following properties are required when [creating a Resequence Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
  <tr>
    <th>Name</th>
    <th>
      The name of the message store.
    </th>
  </tr>
  <tr>
    <td>Database Table</td>
    <td>
      The name of the database table.
    </td>
  </tr>
  <tr>
    <td>Driver</td>
    <td>
      The class name of the database driver.
    </td>
  </tr>
  <tr>
    <td>URL</td>
    <td>
      The JDBC URL of the database that the data will be written to.
    </td>
  </tr>
  <tr>
    <td>User</td>
    <td>
      The user name used to connect to the database.
    </td>
  </tr>
  <tr>
    <td>Password</td>
    <td>
      The password used to connect to the database.
    </td>
  </tr>
  <tr>
    <td>Resequence Timeout (Seconds)</td>
    <td>
      The time the Message Processor waits for a message, which is missing to reorder them based on a specified order.
    </td>
  </tr>
  <tr>
    <td>Sequence ID Path</td>
    <td>
      The path from which, the Store identifies the sequence ID from the message content.
    </td>
  </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating a Resequencer Message Store]({{base_path}}/integrate/develop/creating-artifacts/creating-a-message-store.md).

<table>
   <thead>
      <tr>
         <th>Property</th>
         <th>Description</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>store.resequence.timeout</td>
         <td>
            The time the Processor waits for a message, which is missing to reorder them based on a specified order. If the current message sequence is 3, its predecessor would be 2 and the successor would be 4, and thereby, if 4 is not present, then there is a gap in the sequence. Therefore, the processor waits until the specified set time-out exceeds, and selects the next minimum sequence ID available as the predecessor. However, the time-out will be a rough estimate. The durations could vary depending on the load of the machine. Specify a positive integer for the count and the timeout in seconds. If you specify the count as -1, then the processor will wait indefinitely until the correct sequence ID is present to fill the gap.
         </td>
      </tr>
      <tr>
         <td>
            store.producer.guaranteed.delivery.enable
         </td>
         <td>Whether you want to enable guaranteed delivery or not. For more information, see <b>Guaranteed Delivery with Failover Message Store</b> and <b>Scheduled Failover Message Forwarding Processor</b>. Set True/False.</td>
      </tr>
      <tr>
         <td>
            store.failover.message.store.name</pre>
         </td>
         <td>The name of the Message Store used if the original message store fails. For more information, see <b>Guaranteed Delivery with Failover Message Store</b> and <b>Scheduled Failover Message Forwarding Processor</b>. An appropriate String value</td>
      </tr>
      <tr>
         <td>store.resequence.id.path</td>
         <td>
            <p>The path from which, the Store identifies the sequence ID from the message content. The path could be either XPath or JSON. You can specify it in the expression field. Set a positive integer as the sequence ID. The store expects the sequence ID to start from 1.</p>
         </td>
      </tr>
      <tr>
         <td>store.jdbc.password</td>
         <td>The password to access the database. An appropriate String value</td>
      </tr>
      <tr>
         <td>store.jdbc.driver</td>
         <td>The class name of the database driver. An appropriate String value.</td>
      </tr>
      <tr>
         <td>store.jdbc.username</td>
         <td>The username to access the database. An appropriate String value.</td>
      </tr>
      <tr>
         <td>store.jdbc.connection.url</td>
         <td>The database URL. An appropriate String value of a URL.</td>
      </tr>
      <tr>
         <td>store.jdbc.table</td>
         <td>Table name of the database in which, messages will be stored. An appropriate String value</td>
      </tr>
   </tbody>
</table>