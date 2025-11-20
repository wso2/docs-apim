# RabbitMQ Parameters

When you implement an integration use case that requires a RabbitMQ connection, you can use the following RabbitMQ parameters in your [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) artifact.

!!! Info
      The Micro Integrator can listen to a RabbitMQ instance or send messages to a RabbitMQ instance only if the RabbitMQ transport listener and sender are enabled and configured at the server level. Read about the [RabbitMQ transport]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitmq).

## RabbitMQ Listener Connection Configuration

Before configuring proxy service parameters, you need to configure the RabbitMQ connection factory in the `deployment.toml` file. This is mandatory for RabbitMQ listeners. See [Connecting to RabbitMQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitmq).

**Configuration example**:

Add the following configuration to your `deployment.toml` file:

```toml
[[transport.rabbitmq.listener]]
name = "AMQPConnectionFactory"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
parameter.virtual_host = "/"
```

The following parameters can be specified under the connection factory configuration:

### Basic Connection Parameters

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>parameter.hostname</td>
    <td>The hostname of the RabbitMQ server.</td>
  </tr>
  <tr>
    <td>parameter.port</td>
    <td>The port number of the RabbitMQ server.</td>
  </tr>
  <tr>
    <td>parameter.username</td>
    <td>The username for authenticating with the RabbitMQ server.</td>
  </tr>
  <tr>
    <td>parameter.password</td>
    <td>The password for authenticating with the RabbitMQ server.</td>
  </tr>
  <tr>
    <td>parameter.virtual_host</td>
    <td>The virtual host to connect to on the RabbitMQ server.</td>
  </tr>
</table>

### Connection Management Parameters

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>parameter.'rabbitmq.connection.factory.heartbeat'</td>
    <td>The heartbeat timeout in milliseconds that will be used when negotiating with the server. This mechanism helps detect network failures and ensures connection reliability.</td>
  </tr>
  <tr>
    <td>parameter.'rabbitmq.connection.factory.timeout'</td>
    <td>The connection timeout in milliseconds for establishing the initial connection to the RabbitMQ server.</td>
  </tr>
  <tr>
    <td>parameter.'rabbitmq.connection.factory.network.recovery.interval'</td>
    <td>The interval in milliseconds between automatic network recovery attempts when the connection is lost.</td>
  </tr>
  <tr>
    <td>parameter.retry_interval</td>
    <td>The interval in milliseconds between connection retry attempts when reconnection fails. See <a href="{{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitmq#configuring-connection-recovery">Configuring connection recovery</a> for more details.</td>
  </tr>
  <tr>
    <td>parameter.retry_count</td>
    <td>The maximum number of retry attempts when the connection is lost before giving up and terminating the connection.</td>
  </tr>
  <tr>
    <td>parameter.'rabbitmq.max.inbound.message.body.size'</td>
    <td>The maximum size limit in bytes for inbound message bodies.</td>
  </tr>
</table>

### SSL/TLS Parameters

For SSL configuration details, see [Enabling SSL]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitmq#enabling-ssl) in the RabbitMQ configuration guide.

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>parameter.ssl_enable</td>
    <td>Whether SSL is enabled for the connection. Set to <code>true</code> to enable SSL.</td>
  </tr>
  <tr>
    <td>parameter.keystore_location</td>
    <td>The location of the keystore file for SSL connections.</td>
  </tr>
  <tr>
    <td>parameter.keystore_type</td>
    <td>The type of the keystore (e.g., JKS, PKCS12).</td>
  </tr>
  <tr>
    <td>parameter.keystore_password</td>
    <td>The password for the keystore.</td>
  </tr>
  <tr>
    <td>parameter.truststore_location</td>
    <td>The location of the truststore file for SSL connections.</td>
  </tr>
  <tr>
    <td>parameter.truststore_type</td>
    <td>The type of the truststore (e.g., JKS, PKCS12).</td>
  </tr>
  <tr>
    <td>parameter.truststore_password</td>
    <td>The password for the truststore.</td>
  </tr>
  <tr>
    <td>parameter.ssl_version</td>
    <td>The SSL protocol version to use (e.g., TLSv1.2, TLSv1.3).</td>
  </tr>
</table>

## Service-Level Parameters (Receiving Messages)

{!reference/synapse-properties/pull/proxy-service-add-properties-pull.md!}

See [Creating a Proxy Service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) for instructions.

### Required Parameters

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>rabbitmq.connection.factory</td>
    <td>The name of the connection factory.</td>
  </tr>
  <tr>
    <td>rabbitmq.exchange.name</td>
    <td>
      Name of the RabbitMQ exchange to which the queue is bound. Use this parameter instead of <code>rabbitmq.queue.routing.key</code> if you need to use the default exchange and publish to a queue.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.queue.name</td>
    <td>The queue name to send or consume messages. If you do not specify this parameter, you need to specify the <code>rabbitmq.queue.routing.key</code> parameter.</td>
  </tr>
</table>

### Other Parameters (Optional)

<table>
   <tr>
      <th>Parameter</th>
      <th>Description</th>
   </tr>
   <tbody>
      <tr>
         <td>rabbitmq.queue.auto.ack</td>
         <td>
            Defines how the message processor sends the acknowledgement when consuming messages recived from the RabbitMQ message store. If you set this to true, the message processor automatically sends the acknowledgement to the messages store as soon as it receives messages from it. This is called an auto acknowledgement.
            If you set it to <code>false</code>, the message processor waits until it receives the response from the backend to send the acknowledgement to the mssage store. This is called a client acknowledgement.</br>
            However, you can increase the performance of message processors either by increasing the member count or by having multiple message processors. If you increase the member count, it will create multiple child processors of the message processor.
         </td>
      </tr>
      <tr>
         <td>rabbitmq.consumer.tag</td>
         <td>The client­ generated consumer tag to establish context.</td>
      </tr>
      <tr>
         <td>rabbitmq.channel.consumer.qos</td>
         <td>
            The consumer's QoS value. You need to specify this parameter only if the <code>rabbitmq.queue.auto.ack</code> parameter is set to <code>false</code>.
         </td>
      </tr>
      <tr>
         <td>rabbitmq.queue.durable</td>
         <td>Whether the queue should remain declared even if the broker restarts.</td>
      </tr>
      <tr>
         <td>rabbitmq.queue.exclusive</td>
         <td>Whether the queue should be exclusive or should be consumable by other connections.</td>
      </tr>
      <tr>
         <td>rabbitmq.queue.auto.delete</td>
         <td>Whether to keep the queue even if it is not being consumed anymore.</td>
      </tr>
      <tr>
         <td>rabbitmq.queue.routing.key</td>
         <td>The routing key of the queue.</td>
      </tr>
      <tr>
         <td>rabbitmq.queue.autodeclare</td>
         <td>
           Whether or not to declare the queue. If set to <code>true</code>, the Micro Integrator creates queues if they are not already
present. If set to <code>false</code>, the Micro Integrator will assume that a queue is already available. However, you should set this parameter to true only if queues are not already declared in the RabbitMQ server. Setting this parameter to false in the publish URL improves RabbitMQ transport performance.
         </td>
      </tr>
      <tr>
         <td>rabbitmq.exchange.autodeclare</td>
         <td>
            Whether or not to declare the exchange. If set to <code>true</code>, the Micro Integrator creates exchanges. If set to <code>false</code>, the Micro Integrator will assume that an exchange is already available. However, you should set this parameter to true only if exchanges are not already declared in the RabbitMQ server. Setting this parameter to false in the publish URL improves RabbitMQ transport performance.
          </td>
      </tr>
      <tr>
         <td>rabbitmq.exchange.type</td>
         <td>The type of the exchange.</td>
      </tr>
      <tr>
         <td>rabbitmq.exchange.durable</td>
         <td>Whether the exchange should remain declared even if the broker restarts.</td>
      </tr>
      <tr>
         <td>rabbitmq.exchange.auto.delete</td>
         <td>
            Whether to keep the exchange even if it is not bound to any queue anymore.
         </td>
      </tr>
      <tr>
         <td>rabbitmq.message.content.type</td>
         <td>
            The content type of the consumer. <b>Note</b>: If the content type is specified in the message, this parameter does not override the specified content type. The default value is <code>text/xml</code>. <br><br>
            <b>Note:</b> If you are consuming SOAP messages, set this parameter to <code>application/soap+xml</code> or <code>text/xml</code>. For other XML messages, set this parameter to <code>application/xml</code>.
         </td>
      </tr>
      <tr>
         <td>rabbitmq.publisher.confirms.enabled</td>
         <td>
            Enables support for RabbitMQ publisher confirms, which allows the producer to receive acknowledgements from the broker when messages are successfully published. <br><br>
            <b>Note:</b> When using the Publisher Confirms scenario, do not set the <code>OUT_ONLY</code> property to <code>true</code> in the mediation flow, as this will prevent publisher confirms from working correctly.
         </td>
      </tr>
   </tbody>
</table>

[//]: # (### SSL Parameters &#40;Optional&#41;)

[//]: # ()
[//]: # (To enable SSL support in RabbitMQ, you need to configure the following parameters.)

[//]: # ()
[//]: # (<table>)

[//]: # (  <tr>)

[//]: # (    <th>Parameter</th>)

[//]: # (    <th>Description</th>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.enabled</td>)

[//]: # (    <td>)

[//]: # (       Specifies whether SSL is enabled for the connection.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.version</td>)

[//]: # (    <td>)

[//]: # (       When SSL is enabled, you can specify the SSL protocols that are supported.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (</table>)

[//]: # ()
[//]: # (!!! Tip)

[//]: # (    Note that keystore information is not required for an SSL connection if the <code>fail_if_no_peer_cert</code> parameter is set to 'false' in the RabbitMQ broker. You only need to enable SSL in the Micro Integrator &#40;using the `rabbitmq.connection.ssl.enabled` parameter&#41;.)

[//]: # ()
[//]: # (    However, if the <code>fail_if_no_peer_cert</code> parameter is set to 'true' in RabbitMQ, the keystore configurations &#40;given below&#41; are also required for the Micro Integrator.)

[//]: # ()
[//]: # (    Shown below is an example of the config file where `fail_if_no_peer_cert` is set to `false`:)

[//]: # (    ```)

[//]: # (    ssl_options.cacertfile = /path/to/ca_certificate.pem)

[//]: # (    ssl_options.certfile   = /path/to/server_certificate.pem)

[//]: # (    ssl_options.keyfile    = /path/to/server_key.pem)

[//]: # (    ssl_options.verify     = verify_peer)

[//]: # (    ssl_options.fail_if_no_peer_cert = false)

[//]: # (    ```)

[//]: # ()
[//]: # (<table>)

[//]: # (  <tr>)

[//]: # (    <th>Parameter</th>)

[//]: # (    <th>Description</th>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.keystore.location</td>)

[//]: # (    <td>)

[//]: # (       The location of the keystore that is used.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.keystore.type</td>)

[//]: # (    <td>)

[//]: # (       The type of keystore.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.keystore.password</td>)

[//]: # (    <td>)

[//]: # (       The keystore password.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.truststore.location</td>)

[//]: # (    <td>)

[//]: # (       The location of the truststore.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.truststore.type</td>)

[//]: # (    <td>)

[//]: # (       The type of the truststore.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (  <tr>)

[//]: # (    <td>rabbitmq.connection.ssl.truststore.password</td>)

[//]: # (    <td>)

[//]: # (       The password of the keystore.)

[//]: # (    </td>)

[//]: # (  </tr>)

[//]: # (</table>)

## Service-Level Parameters (Sending Messages)

In your integration solution, the following RabbitMQ send parameters can be specified in the **Address URL** that you specify in your [Endpoint artifact]({{base_path}}/integrate/develop/creating-artifacts/creating-endpoints).

**Format of the Address URL**:

```
rabbitmq:/<placeholder>?<query-parameter-name1>=<query-parameter-value1>&amp;<query-parameter-name2>=<query-parameter-value2>
```

**Example**:

-   Design view of an address endpoint in WSO2 Integration Studio:

    Double-click the **Address Endpoint** artifact to open the **Properties** tab and enter the address URL with RabbitMQ parameters.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/address-endpoint-url.png" width="800">

-   Source view of an address endpoint:

    ```xml
    <endpoint>
       <address uri="rabbitmq:/AMQPProducerSample?rabbitmq.server.host.name=localhost&amp;rabbitmq.server.port=5672&amp;rabbitmq.queue.name=queue&amp;rabbitmq.queue.routing.key=route&amp;rabbitmq.exchange.name=exchange">
       </address>
    </endpoint>
    ```

### Parameters

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>placeholder</td>
    <td>Specifies the routing key to use when both rabbitmq.queue.name and rabbitmq.queue.routing.key query parameters are not defined. If both parameters are provided, this path value is not used for routing and can be omitted from the URI.</td>
  </tr>
  <tr>
    <td>rabbitmq.server.host.name</td>
    <td>Host name of the server.</td>
  </tr>
  <tr>
    <td>rabbitmq.server.port</td>
    <td>Port number of the server.</td>
  </tr>
  <tr>
    <td>rabbitmq.server.user.name</td>
    <td>The username for authenticating with the RabbitMQ server.</td>
  </tr>
  <tr>
    <td>rabbitmq.server.password</td>
    <td>The password for authenticating with the RabbitMQ server.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.factory</td>
    <td>The name of the connection factory defined in the deployment.toml file. When specified, the connection parameters are retrieved from the global configuration. See <a href="#global-connection-factory-configuration">Global connection factory configuration</a>.</td>
  </tr>
  <tr>
    <td>rabbitmq.exchange.name</td>
    <td>
      The name of the RabbitMQ exchange to which the queue is bound. Use this parameter instead of <code>rabbitmq.queue.routing.key</code>, if you need to use the default exchange and publish to a queue.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.queue.routing.key</td>
    <td>The exchange and queue binding key that will be used to route messages.</td>
  </tr>
  <tr>
    <td>rabbitmq.replyto.name</td>
    <td>The name of the callback­ queue. Specify this parameter if you expect a response.</td>
  </tr>
  <tr>
    <td>rabbitmq.queue.delivery.mode</td>
    <td>
      The delivery mode of the queue. Possible values are 1 and 2.<br/>
         1 - Non­-persistent.<br/>
         2 - Persistent. This is the default value.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.exchange.type</td>
    <td>The type of the exchange.</td>
  </tr>
  <tr>
    <td>rabbitmq.queue.name</td>
    <td>The queue name to send or consume messages. If you do not specify this parameter, you need to specify the <code>rabbitmq.queue.routing.key</code> parameter.</td>
  </tr>
  <tr>
    <td>rabbitmq.queue.durable</td>
    <td>Whether the queue should remain declared even if the broker restarts. The default value is <code>false</code>.</td>
  </tr>
  <tr>
    <td>rabbitmq.queue.exclusive</td>
    <td>Whether the queue should be exclusive or should be consumable by other connections. The default value is <code>false</code>.</td>
  </tr>
  <tr>
    <td>rabbitmq.queue.auto.delete</td>
    <td>Whether to keep the queue even if it is not being consumed anymore. The default value is <code>false</code>.</td>
  </tr>
  <tr>
    <td>rabbitmq.exchange.durable</td>
    <td>Whether the exchange should remain declared even if the broker restarts.</td>
  </tr>
  <tr>
    <td>rabbitmq.exchange.auto.delete</td>
    <td>Whether to automatically delete the exchange when it is no longer bound to any queue. The default value is <code>false</code>.</td>
  </tr>
  <tr>
    <td>rabbitmq.queue.autodeclare</td>
    <td>
      Whether to create queues if they are not present. However, you should set this parameter only if queues are not declared prior on the broker. Setting this parameter in the publish URL to <code>false</code> improves RabbitMQ transport performance.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.exchange.autodeclare</td>
    <td>Whether to create exchanges if they are not present. However, you should set this parameter only if exchanges are not declared prior on the broker. Setting this parameter in the publish URL to <code>false</code> improves RabbitMQ transport performance.</td>
  </tr>
  <tr>
    <td>rabbitmq.message.correlation.id</td>
    <td>
      The correlation ID is required to identify a message that comes through one queue and requires a response back via another queue. This ID helps you map the messages and is unique for every request.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.message.id</td>
    <td>Every message has its own unique message ID.</td>
  </tr>
  <tr>
    <td>CachedRabbitMQConnectionFactory</td>
    <td>
      This parameter increases the performance and provides higher throughput in message delivery.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.factory.heartbeat</td>
    <td>The heartbeat timeout in milliseconds that will be used when negotiating with the server. Set to 0 to disable heartbeats.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.factory.timeout</td>
    <td>The connection timeout in milliseconds for the RabbitMQ connection factory.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.factory.network.recovery.interval</td>
    <td>The interval in milliseconds between network recovery attempts when the connection is lost.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.retry.interval</td>
    <td>The interval in milliseconds between connection retry attempts.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.enabled</td>
    <td>Whether SSL is enabled for the connection. Set to <code>true</code> to enable SSL.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.keystore.location</td>
    <td>The location of the keystore file for SSL connections.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.keystore.type</td>
    <td>The type of the keystore (e.g., JKS, PKCS12).</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.keystore.password</td>
    <td>The password for the keystore.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.truststore.location</td>
    <td>The location of the truststore file for SSL connections.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.truststore.type</td>
    <td>The type of the truststore (e.g., JKS, PKCS12).</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.truststore.password</td>
    <td>The password for the truststore.</td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.version</td>
    <td>The SSL protocol version to use (e.g., TLSv1.2, TLSv1.3).</td>
  </tr>
  <tr>
    <td>rabbitmq.max.inbound.message.body.size</td>
    <td>The maximum size limit for inbound message bodies in bytes.</td>
  </tr>
  <tr>
    <td>rabbitmq.virtual.host</td>
    <td>The virtual host to connect to on the RabbitMQ server.</td>
  </tr>
  <tr>
   <td>rabbitmq.publisher.confirms.enabled</td>
   <td>
      Enables support for RabbitMQ publisher confirms, which allows the producer to receive acknowledgements from the broker when messages are successfully published. <br><br>
      <b>Note:</b> When using the Publisher Confirms scenario, do not set the <code>OUT_ONLY</code> property to <code>true</code> in the mediation flow, as this will prevent publisher confirms from working correctly.
   </td>
  </tr>
</table>

### Global connection factory configuration

Optionally, you can define the connection-related parameters globally, for message sender in the `deployment.toml` file. This approach centralizes connection management and improves reusability across multiple endpoints.

**Configuration example**:

Add the following configuration to your `deployment.toml` file:

```toml
[[transport.rabbitmq.sender]]
name = "AMQPConnectionFactory"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
```

**Usage example**:

When using a connection factory defined in the `deployment.toml` file, reference it in your endpoint configuration as follows:

```xml
<endpoint>
   <address uri="rabbitmq:/AMQPProducerSample?rabbitmq.connection.factory=AMQPConnectionFactory&amp;rabbitmq.queue.name=queue&amp;rabbitmq.queue.routing.key=route&amp;rabbitmq.exchange.name=exchange">
   </address>
</endpoint>
```

!!! Important "Parameter Precedence"
    When a connection factory is defined in the `deployment.toml` file and referenced in the endpoint URL, the global configuration takes precedence over URL parameters for specific connection-related settings.
    
    The following parameters defined in the global connection factory will override any corresponding values specified in the endpoint URL:
    
    **Basic connection parameters:**
    
    - `rabbitmq.server.host.name` - Server hostname
    - `rabbitmq.server.port` - Server port number
    - `rabbitmq.server.user.name` - Authentication username
    - `rabbitmq.server.password` - Authentication password
    - `rabbitmq.server.virtual.host` - Virtual host name
    
    **Connection management parameters:**
    
    - `rabbitmq.connection.factory.heartbeat` - Heartbeat interval
    - `rabbitmq.connection.factory.timeout` - Connection timeout
    - `rabbitmq.connection.factory.network.recovery.interval` - Network recovery interval
    - `rabbitmq.connection.retry.interval` - Connection retry interval
    - `rabbitmq.max.inbound.message.body.size` - Maximum message body size limit

    
    **SSL/TLS security parameters:**
    
    - `rabbitmq.connection.ssl.enabled` - SSL enablement flag
    - `rabbitmq.connection.ssl.keystore.location` - Keystore file path
    - `rabbitmq.connection.ssl.keystore.type` - Keystore type
    - `rabbitmq.connection.ssl.keystore.password` - Keystore password
    - `rabbitmq.connection.ssl.truststore.location` - Truststore file path
    - `rabbitmq.connection.ssl.truststore.type` - Truststore type
    - `rabbitmq.connection.ssl.truststore.password` - Truststore password
    - `rabbitmq.connection.ssl.version` - SSL/TLS protocol version    
    
    !!! Note
        This precedence rule ensures that centrally managed connection settings in `deployment.toml` maintain consistency across all endpoints that reference the same connection factory.

### Mediator Properties

In addition to the parameters described above, you can define RabbitMQ properties using the [Property mediator]({{base_path}}/reference/mediators/property-mediator/) and the [Property Group mediator]({{base_path}}/reference/mediators/property-group-mediator/).
