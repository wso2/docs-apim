# MQTT Parameters

When you implement an integration use case that requires an MQTT connection, you can use the following MQTT parameters in your [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) artifact.

!!! Info
    The Micro Integrator can communicate through MQTT only if the MQTT transport listener and sender are enabled and configured at the server level. Read about the [MQTT transport]({{base_path}}/install-and-setup/transport_configurations/configuring-transports/#configuring-the-mqtt-transport).

{!reference/synapse-properties/pull/proxy-service-add-properties-pull.md!}

See [Creating a Proxy Service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) for instructions.

## Service-Level Parameters

### Required Parameters

<table>
	<tr>
		<th>Property</th>
		<th>Description</th>
	</tr>
	<tr>
      <td>mqtt.server.host.name</td>
      <td>The name of the host.</td>
   </tr>
   <tr>
      <td>mqtt.server.port</td>
      <td>The port ID. The possible values are <code>1883</code> or <code>1885</code>.</td>
   </tr>
   <tr>
      <td>mqtt.client.id</td>
      <td>The client ID.</td>
   </tr>
   <tr>
      <td>mqtt.topic.name</td>
      <td>The name of the topic</td>
   </tr>
</table>

### Optional Parameters

<table>
   <tr>
      <th>
         Parameter
      </th>
      <th>
         Description
      </th>
   </tr>
   <tbody>
      <tr>
         <td>mqtt.subscription.qos</td>
         <td>The QoS value. The possible values are <code>0</code>, <code>1</code>, or <code>2</code>.</td>
      </tr>
      <tr>
         <td>mqtt.session.clean</td>
         <td>Whether session clean should be enabled or not.</td>
      </tr>
      <tr>
         <td>mqtt.ssl.enable</td>
         <td>Whether SSL should be enabled or not.</td>
      </tr>
      <tr>
         <td>mqtt.subscription.username</td>
         <td>The username for the subscription.</td>
      </tr>
      <tr>
         <td>mqtt.subscription.password</td>
         <td>The password for the subscription.</td>
      </tr>
      <tr>
         <td>mqtt.temporary.store.directory</td>
         <td>The path of the directory to be used as the persistent data store for quality of service purposes. The default value is the Micro Integrator temp path.</td>
      </tr>
      <tr>
         <td>mqtt.blocking.sender</td>
         <td>Whether blocking sender should be enabled or not.</td>
      </tr>
      <tr>
         <td>mqtt.content.type</td>
         <td>The content type. The default content type is <code>text/plain</code>.</td>
      </tr>
      <tr>
         <td>mqtt.message.retained</td>
         <td>Whether the messaging engine should retain a published message or not. This parameter can be used only in the transport sender. By default, this parameter is set to <code>false</code>.</td>
      </tr>
   </tbody>
</table>
