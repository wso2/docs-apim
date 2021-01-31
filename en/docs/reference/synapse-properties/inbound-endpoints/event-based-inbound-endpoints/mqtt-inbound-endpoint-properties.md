# MQTT Inbound Endpoint
## Introduction

MQ Telemetry Transport (MQTT) is a lightweight broker-based publish/subscribe messaging protocol, designed to be open, simple, lightweight and easy to implement. These characteristics make it ideal for use in constrained environments:
<ul>
    <li>Where the network is expensive, has low bandwidth, or is unreliable.</li>
    <li>When running on an embedded device with limited processor or memory resources.</li>
</ul>

## Syntax

```xml
<inboundEndpoint xmlns="http://ws.apache.org/ns/synapse" name="Test" sequence="TestIn" onError="fault" protocol="mqtt" suspend="false">
   <parameters>
      <parameter name="sequential">true</parameter>
      <parameter name="mqtt.connection.factory">mqttFactory</parameter>
      <parameter name="mqtt.server.host.name">localhost</parameter>
      <parameter name="mqtt.server.port">1883</parameter>
      <parameter name="mqtt.topic.name">ei.test2</parameter>
      <parameter name="mqtt.subscription.qos">2</parameter>
      <parameter name="content.type">application/xml</parameter>
      <parameter name="mqtt.session.clean">false</parameter>
      <parameter name="mqtt.ssl.enable">false</parameter>
      <parameter name="mqtt.subscription.username">client</parameter>
      <parameter name="mqtt.subscription.password">e13</parameter>
      <parameter name="mqtt.temporary.store.directory">m1y</parameter>
      <parameter name="mqtt.reconnection.interval">5</parameter>
   </parameters>
</inboundEndpoint>
```

## Properties

Listed below are the properties used for [creating an MQTT inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

### Required Properties

The following properties are required when [creating a MQTT inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
   <tr>
      <td>
         mqtt.connection.factory
      </td>
      <td>Name of the connection factory.</td>
   </tr>
   <tr>
      <td>
         mqtt.server.host.name
      </td>
      <td>
        Address of the message broker (eg., localhost).
      </td>
   </tr>
   <tr>
      <td>
         mqtt.server.port
      </td>
      <td>Port of the message broker (e.g., 1883).</td>
   </tr>
   <tr>
      <td>
         mqtt.topic.name
      </td>
      <td>MQTT topic to which the message should be published.</td>
   </tr>
   <tr>
      <td>
         content.type
      </td>
      <td>The content type of the message, i.e., XML or JSON)</td>
   </tr>
   <tr>
         <td>coordination</td>
         <td>This parameter is only applicable in a clustered environment.<br />
            In a cluster environment an inbound endpoint will only be executed in worker nodes. If this parameter is set to <code>true</code> in a clustered environment, the inbound will only be executed in a single worker node. Once the running worker node is down, the inbound will start on another available worker node in the cluster. By default, this setting is <code>true</code>.
         </td>
      </tr>
      <tr>
      <td>
         sequential
      </td>
      <td>The behaviour when executing the given sequence.</td>
   </tr>
   <tr>
         <td>sequential</td>
         <td>The behavior when executing the given sequence.<br />
            When set as <code>true</code> , mediation will happen within the same thread. When set as <code>false</code> , the mediation engine will use the inbound thread pool. The default thread pool values can be found in the <code>MI_HOME/conf/deployment.toml</code> file, under the `[mediation]` section. The default setting is <code>true</code>.
         </td>
      </tr>
      <tr>
        <td>Suspend</td>
        <td>
          If the inbound listener should pause when accepting incoming requests, set this to <code>true</code>. If the inbound listener should not pause when accepting incoming requests, set this to <code>false</code>.
        </td>
      </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating an MQTT inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
<thead>
   <tr>
      <th>
        Property
      </th>
      <th>
        Description
      </th>
   </tr>
</thead>
<tbody>
   <tr>
      <td>
         mqtt.subscription.qos
      </td>
      <td>The quality of service level that need to be maintained with the subscription. The quality of service level can be either 0,1 or 2.<br />
         0 -  Specifying this level ensures that the message delivery is efficient. However, specifying this level does not guarantee that the message will be delivered to its recipient.<br />
         1 -  Specifying this level ensures that the message is delivered at least once, but this can lead to messages being duplicated.<br />
         2 - This is the highest level of quality of service. Specifying this guarantees that the message is delivered and that it is delivered only once.
      </td>
   </tr>
   <tr>
      <td>
         mqtt.client.id
      </td>
      <td>The id of the client.</td>
   </tr>
   <tr>
      <td>
         mqtt.session.clean
      </td>
      <td>
        Whether the client and server should remember the state across restarts and reconnects.
      </td>
   </tr>
   <tr>
      <td>
         mqtt.ssl.enable
      </td>
      <td>
        Whether to use TCP connection or SSL connection.
      </td>
   </tr>
   <tr>
      <td>
         mqtt.subscription.username
      </td>
      <td>The username for the subscription.</td>
   </tr>
   <tr>
      <td>
         mqtt.subscription.password
      </td>
      <td>The password for the subscription.</td>
   </tr>
   <tr>
      <td>
         mqtt.temporary.store.directory
      </td>
      <td>
        Path of the directory to be used as the persistent data store for quality of service purposes.
      </td>
   </tr>
   <tr>
      <td>
         mqtt.reconnection.interval
      </td>
      <td>
        The retry interval to reconnect to the MQTT server.
      </td>
   </tr>
</tbody>
</table>