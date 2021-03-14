# RabbitMQ Parameters

When you implement an integration use case that requires a RabbitMQ connection, you can use the following RabbitMQ parameters in your [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) artifact.

!!! Info
      The Micro Integrator can listen to a RabbitMQ instance or send messages to a RabbitMQ instance only if the RabbitMQ transport listener and sender are enabled and configured at the server level. Read about the [RabbitMQ transport]({{base_path}}/install-and-setup/brokers/configure-with-rabbitMQ).

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
            However, you can increase performance of message processors either by increasing the member count or by having multiple message processors. If you increase the member count, it will create multiple child processors of the message processor.
         </td>
      </tr>
      <tr>
         <td>rabbitmq.consumer.tag</td>
         <td>The client­ generated consumer tag to establish context.</td>
      </tr>
      <tr>
         <td>rabbitmq.channel.consumer.qos</td>
         <td>
            The consumer QoS value. You need to specify this parameter only if the <code>rabbitmq.queue.auto.ack</code> parameter is set to <code>false</code>.
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
         <td>rabbitmq.exchange.durable></td>
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
            The content type of the consumer. <b>Note</b>: If the content type is specified in the message, this parameter does not override the specified content type. The default value is <code>text/xml</code>.
         </td>
      </tr>
      <tr>
         <td>rabbitmq.connection.pool.size</td>
         <td>
            You can increase the connection pool size to improve the performance of the RabbitMQ sender and listener. The default connection pool size is 20.
         </td>
      </tr>
   </tbody>
</table>

### Connection Recovery Parameters (Optional)

In case of a network failure or broker shutdown, the Micro Integrator will try to recreate the connection.

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>rabbitmq.connection.retry.interval</td>
    <td>
      The retry interval specifies how frequently (time interval) the Micro Integrator should retry to recreate a lost connection. The default value is <code>30000</code> ms. That is, the Micro Integrator retries to connect every 30000 miliseconds.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.retry.count</td>
    <td>
      The retry count specifies the number of times the Micro Integrator will try to recreate a lost connection. The default retry count is <code>3</code>. That is, the Micro Integrator retries only 3 times.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.server.retry.interval</td>
    <td>
      This parameter is <b>optional</b>.</br>
      The parameters specified above sets the retry interval with which the RabbitMQ client tries to reconnect. Generally having this value less than the value specified as <code>rabbitmq.connection.retry.interval</code> will help synchronize the reconnection of the Micro Integrator and the RabbitMQ client.
    </td>
  </tr>
</table>

### SSL Parameters (Optional)

To enable SSL support in RabbitMQ, you need to configure the following parameters.

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.enabled</td>
    <td>
       Specifies whether SSL is enabled for the connection.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.version</td>
    <td>
       When SSL is enabled, you can specify the SSL protocols that are supported.
    </td>
  </tr>
</table>

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
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.keystore.location</td>
    <td>
       The location of the keystore that is used.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.keystore.type</td>
    <td>
       The type of keystore.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.keystore.password</td>
    <td>
       The keystore password.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.truststore.location</td>
    <td>
       The location of the truststore.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.truststore.type</td>
    <td>
       The type of the truststore.
    </td>
  </tr>
  <tr>
    <td>rabbitmq.connection.ssl.truststore.password</td>
    <td>
       The password of the keystore.
    </td>
  </tr>
</table>


## Service-Level Parameters (Sending Messages)

In your integration solution, the following RabbitMQ send parameters can be specified in the **Address URL** that you specify in your [Endpoint artifact]({{base_path}}/integrate/develop/creating-artifacts/creating-endpoints).

**Example**:

-   Design view of an address endpoint in WSO2 Integration Studio:

    Double-click the **Address Endpoint** artifact to open the **Properties** tab and enter the address URL with RabbitMQ parameters.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/address-endpoint-url.png" width="800">

-   Source view of an address endpoint:

    ```xml
    <endpoint>
       <address uri="rabbitmq:/AMQPProducerSample?rabbitmq.server.host.name=localhost&amp;rabbitmq.server.port=5672&amp;rabbitmq.queue.name=queue&amp;rabbitmq.queue.route.key=route&amp;rabbitmq.exchange.name=exchange">
       </address>
    </endpoint>
    ```

### Required Parameters

<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>rabbitmq.server.host.name</td>
    <td>Host name of the server.</td>
  </tr>
  <tr>
    <td>rabbitmq.server.port</td>
    <td>Port number of the server.</td>
  </tr>
</table>


### Optional Parameters

<table>
   <tr>
    <th>Parameter</th>
    <th>Description</th>
   </tr>
   <tbody>
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
         <td>The name of the call back­ queue. Specify this parameter if you expect a response.</td>
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
         <td>
          rabbitmq.message.id
         </td>
         <td>Every message has its own unique message ID.</td>
      </tr>
      <tr>
        <td>CachedRabbitMQConnectionFactory</td>
        <td>
           This parameter increases the performance and provides higher throughput in message delivery.
        </td>
      </tr>
      <tr>
         <td>rabbitmq.connection.pool.size</td>
         <td>
            You can increase the connection pool size to improve the performance of the RabbitMQ sender and listener. The default connection pool size is 20.
         </td>
      </tr>
   </tbody>
</table>

### Mediator Properties

In addition to the parameters described above, you can define RabbitMQ properties using the [Property mediator]({{base_path}}/reference/mediators/property-mediator.md) and the [Property Group mediator]({{base_path}}/reference/mediators/property-group-mediator.md).
