# RabbitMQ Inbound 
## Introduction

<a href="http://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol">AMQP</a> is a wire-level messaging protocol that describes the format of the data that is sent across the network. If a system or application can read and write AMQP, it can exchange messages with any other system or application that understands AMQP regardless of the implementation language.

## Syntax

```xml
<inboundEndpoint xmlns="http://ws.apache.org/ns/synapse" name="RabbitMQConsumer" sequence="amqpSeq" onError="amqpErrorSeq" protocol="rabbitmq" suspend="false">
   <parameters>
      <parameter name="sequential">true</parameter>
      <parameter name="coordination">true</parameter>
      <parameter name="rabbitmq.connection.factory">AMQPConnectionFactory</parameter>
      <parameter name="rabbitmq.server.host.name">localhost</parameter>
      <parameter name="rabbitmq.server.port">5672</parameter>
      <parameter name="rabbitmq.server.user.name">guest</parameter>
      <parameter name="rabbitmq.server.password">guest</parameter>
      <parameter name="rabbitmq.queue.name">queue</parameter>
      <parameter name="rabbitmq.exchange.name">exchange</parameter>
      <parameter name="rabbitmq.connection.ssl.enabled">false</parameter>
   </parameters>
</inboundEndpoint>
```

## Properties

Listed below are the properties used for [creating a RabbitMQ inbound endpiont]({{base_path}}/integrate//develop/creating-artifacts/creating-an-inbound-endpoint).

### Required Properties

The following properties are required when [creating a RabbitMQ inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).

<table>
  <tr>
    <th>Property</th>
    <th>Description</th>
  </tr>
  <tr>
         <td>sequential</td>
         <td>The behavior when executing the given sequence.<br />
            When set as <code>true</code> , mediation will happen within the same thread. When set as <code>false</code> , the mediation engine will use the inbound thread pool. The default thread pool values can be found in the <code>MI_HOME/conf/deployment.toml</code> file, under the `[mediation]` section. The default setting is <code>true</code>.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.factory
         </td>
         <td>Name of the connection factory.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.server.host.name
         </td>
         <td>
            Host name of the server.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.server.port
         </td>
         <td>The port number of the server.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.server.user.name
         </td>
         <td>The user name to connect to the server.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.server.password
         </td>
         <td>The password to connect to the server.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.queue.name
         </td>
         <td>The queue name to send or consume messages.</td>
      </tr>
      <tr>
         <td>coordination</td>
         <td>This parameter is only applicable in a clustered environment.<br />
            In a cluster environment an inbound endpoint will only be executed in worker nodes. If this parameter is set to <code>true</code> in a clustered environment, the inbound will only be executed in a single worker node. Once the running worker node is down, the inbound will start on another available worker node in the cluster. By default, this setting is <code>true</code>.
         </td>
      </tr>
</table>

### Optional Properties

The following optional properties can be configured when [creating an RabbitMQ inbound endpiont]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint).
Note that the optional properties related to defining a **queue** should contain the `rabbitmq.queue.optional.` prefix,
and the optional properties related to defining an **exchange** should contain the `rabbitmq.exchange.optional.` prefix.

!!! Tip
    Note that keystore information is not required for an SSL connection if the <code>fail_if_no_peer_cert</code> parameter is set to 'false' in the RabbitMQ broker. You only need to enable SSL in the Micro Integrator (using the `rabbitmq.connection.ssl.enabled` parameter).

    However, if the <code>fail_if_no_peer_cert</code> parameter is set to 'true' in RabbitMQ, the keystore configurations (given below) are also required for the Micro Integrator.

    Shown below is an example of the config file where `fail_if_no_peer_cert` is set to `false`:
    ```
    ssl_options.cacertfile = /path/to/ca_certificate.pem
    ssl_options.certfile   = /path/to/server_certificate.pem
    ssl_options.keyfile    = /path/to/server_key.pem
    ssl_options.verify     = verify_peer
    ssl_options.fail_if_no_peer_cert = false
    ```

<table>
   <thead>
      <tr>
         <th>
          Property Name
         </th>
         <th>
          Description
         </th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
            rabbitmq.server.virtual.host
         </td>
         <td>The virtual host name of the server (if available).</td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.enabled
         </td>
         <td>Whether to use TCP connection or SSL connection.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.keystore.location
         </td>
         <td>The keystore location.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.keystore.type
         </td>
         <td>
          The keystore type.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.keystore.password
         </td>
         <td>The keystore password.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.truststore.location
         </td>
         <td>The truststore location.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.truststore.type
         </td>
         <td>The truststore type.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.truststore.password
         </td>
         <td>The truststore password.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.ssl.version
         </td>
         <td>The SSL version.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.channel.consumer.qos
         </td>
         <td>
         The prefetch message count. This many messaged will be prefetched before the application sees it.
         If a value is not set, 0 will be used as the default value.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.consumer.tag
         </td>
         <td>
        RabbitMQ consumer identifier.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.connection.factory.network.recovery.interval
         </td>
         <td>
         Interval at which the server will retry connecting to the RabbitMQ server in the case of a failure in the established connection.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.factory.connection.timeout
         </td>
         <td>Timeout for the connection initialization.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.queue.durable
         </td>
         <td>Whether the queue should remain declared even if the broker restarts.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.queue.exclusive
         </td>
         <td>Whether the queue should be exclusive or should be consumable by other connections.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.queue.auto.delete
         </td>
         <td>Whether to keep the queue even if it is not being consumed anymore.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.queue.auto.ack
         </td>
         <td>Whether to send back an acknowledgment.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.exchange.name
         </td>
         <td>The name of the RabbitMQ exchange to which the queue is bound.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.queue.routing.key
         </td>
         <td>The routing key of the queue.</td>
      </tr>
      <tr>
         <td>
           rabbitmq.queue.autodeclare
         </td>
         <td>
           Whether or not to declare the queue. If set to <code>true</code>, the Micro Integrator creates queues if they are not already
present. If set to <code>false</code>, the Micro Integrator will assume that a queue is already available. However, you should set this parameter to true only if queues are not already declared in the RabbitMQ server. Setting this parameter to false in the publish URL improves RabbitMQ transport performance.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.exchange.type
         </td>
         <td>The type of the exchange.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.exchange.durable
         </td>
         <td>Whether the exchange should remain declared even if the broker restarts.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.exchange.auto.delete
         </td>
         <td>Whether to keep the queue even if it is not used anymore.</td>
      </tr>
      <tr>
         <td>
            rabbitmq.exchange.autodeclare
         </td>
         <td>
            Whether or not to declare the exchange. If set to <code>true</code>, the Micro Integrator creates exchanges. If set to <code>false</code>, the Micro Integrator will assume that an exchange is already available. However, you should set this parameter to true only if exchanges are not already declared in the RabbitMQ server. Setting this parameter to false in the publish URL improves RabbitMQ transport performance.
          </td>
      </tr>
      <tr>
         <td>
            rabbitmq.factory.heartbeat
         <td>
            <p>The period of time after which the connection should be considered dead.</p>
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.message.max.dead.lettered.count
         </td>
         <td>
            The maximum number of attempts a message is allowed to be dead lettered. 
            Once the count exceeds, the message will be discarded or published to the given 
            'rabbitmq.message.error.queue.routing.key'.
         </td>
      </tr>
      <tr>
         <td>
            rabbitmq.message.requeue.delay
         </td>
         <td>
           Delay for the message to be requeued in the case of immediate requeing.
         </td>
      </tr>
      <tr>
          <td>
             rabbitmq.message.error.queue.routing.key
          </td>
          <td>
           The routing key to publish the message after the 'max.dead.lettered' count has been reached.
          </td>
      </tr>
      <tr>
         <td>
           rabbitmq.message.error.exchange.name
         </td>
         <td>
         The exchange to which messages are published after the `max.dead.lettered` count has been reached.
         </td>
      </tr>
   </tbody>
</table>

!!! Note
    The property rabbitmq.exchange.name becomes mandatory if you are trying to connect to a new queue, so that it can be bound to an exchange for messages to flow.

### Connection Recovery Properties

In case of a network failure or broker shutdown, the Micro Integrator can try to
recreate the connection.

If you want to enable connection recovery, you should configure the
following parameters in the inbound endpoint:

```xml
<parameter name="rabbitmq.connection.retry.interval" locked="false">10000</parameter>
<parameter name="rabbitmq.connection.retry.count" locked="false">5</parameter>   
```

If the parameters are configured with sample values as given above, the
server makes 5 retry attempts with a time interval of 10000 miliseconds between each
retry attempt to reconnect when the connection is lost. If reconnecting
fails after 5 retry attempts, the Micro Integrator terminates the connection.

### Mediator Properties

In addition to the parameters described above, you can define RabbitMQ properties using the [Property mediator]({{base_path}}/reference/mediators/property-mediator) and the [Property Group mediator]({{base_path}}/reference/mediators/property-group-mediator).
