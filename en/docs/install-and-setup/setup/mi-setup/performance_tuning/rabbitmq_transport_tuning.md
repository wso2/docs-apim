# Tuning the RabbitMQ Transport

See the following topics to tune the RabbitMQ transport:

## Increase the connection pool size

You can increase the connection pool size to improve the performance of the RabbitMQ sender. The default connection pool size is 100. To change this, specify a required value for the `connection_pool_size` parameter in the RabbitMQ transport sender configurations in the deployment.toml file (stored in the `MI_HOME/conf` directory).

```toml
[[transport.rabbitmq.sender]]
name = "rabbitMQSender"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
parameter.connection_pool_size = 25
```

## Increase the member count

If you set the following parameter to `false` in the deployment.toml file (stored in the `MI_HOME/conf` directory), it sets the configuration to handle the acknowledgement in the application level: 

```toml
[[transport.rabbitmq.listener]]
parameter.queue_auto_ack= false
```

Thus, it sends back the acknowledgement once it sends the request to the back-end. That is, it does not wait for the response. However, in a message store/processor implementation, it waits for the response to send the acknowledgment back to provide guaranteed message delivery. Therefore, there might be a delay in processing messages using message processors than using a message producer/consumer implementation.

However, you can increase performance of message processors either by increasing the member count or by having multiple message processors. If you increase the member count, it will create multiple child processors of the message processor.

## Disable queue and exchange declaration

Setting `rabbitmq.queue.autodeclare` and `rabbitmq.exchange.autodeclare` parameters in the publish URL to false can improve the RabbitMQ transport performance. When these parameters are set to `false`, RabbitMQ does not try to create queues or exchanges if queues or exchanges are not present. However, you should set these parameters if and only if queues and exchanges are declared prior on the broker.

## Reuse connection factory in publisher

In the publisher URL, set the connection factory name instead of the connection parameters as specified below in the `rabbitmq.connection.factory` parameter . This reuses the connection factories and thereby improves performance.

``` xml
<address uri="rabbitmq://?rabbitmq.connection.factory=RabbitMQConnectionFactory&amp;rabbitmq.queue.name=queue1&amp;rabbitmq.queue.routing.key=queue1&amp;rabbitmq.replyto.name=replyqueue&amp;rabbitmq.exchange.name=ex1&amp;rabbitmq.queue.autodeclare=false&amp;rabbitmq.exchange.autodeclare=false&amp;rabbitmq.replyto.name=response_queue"/>
```
