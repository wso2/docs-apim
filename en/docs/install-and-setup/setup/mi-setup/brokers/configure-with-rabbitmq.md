# Connecting to RabbitMQ

This section describes how to configure WSO2 Micro Integrator to connect with RabbitMQ.

!!! Tip
    - See the complete list of server-level configurations for the [RabbitMQ Listener]({{base_path}}/reference/config-catalog-mi/#rabbitmq-listener) and [RabbitMQ Sender]({{base_path}}/reference/config-catalog-mi/#rabbitmq-sender) in the `deployment.toml` file (stored in the `MI_HOME/conf` directory).
    - Refer to [Tuning the RabbitMQ Transport]({{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/rabbitmq_transport_tuning/) for guidance on optimizing RabbitMQ performance.

## Setting up RabbitMQ

Please refer [RabbitMQ Deployment]({{base_path}}/install-and-setup/setup/mi-setup/brokers/deploy-rabbitmq) 

## Enabling the RabbitMQ Listener

Uncomment the following parameters in the `deployment.toml` file to configure the RabbitMQ listener.

```toml
[[transport.rabbitmq.listener]]
name = "AMQPConnectionFactory"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
```

## Enabling the RabbitMQ Sender

Uncomment the following parameters in the `deployment.toml` file to enable the RabbitMQ sender.

```toml
[transport.rabbitmq]
sender_enable = true
```

## Enabling SSL

Add the following parameters to enable SSL for the RabbitMQ listener.

!!! Tip
	  Note that keystore information is not required for an SSL connection if the <code>fail_if_no_peer_cert</code> parameter is set to 'false' in the RabbitMQ broker. You only need to enable SSL in the Micro Integrator (using the `parameter.ssl_enable` parameter shown below).

    However, if the <code>fail_if_no_peer_cert</code> parameter is set to 'true' in RabbitMQ, the keystore configurations (given below) are also required for the Micro Integrator.

    Shown below is an example of the config file where `fail_if_no_peer_cert` is set to `false`:
    ```
    ssl_options.cacertfile = /path/to/ca_certificate.pem
    ssl_options.certfile   = /path/to/server_certificate.pem
    ssl_options.keyfile    = /path/to/server_key.pem
    ssl_options.verify     = verify_peer
    ssl_options.fail_if_no_peer_cert = false
    ```

```toml
[[transport.rabbitmq.listener]]
parameter.ssl_enable = true
parameter.ssl_version = "SSL"
parameter.keystore_location ="repository/resources/security/wso2carbon.jks"
parameter.keystore_type = "JKS"
parameter.keystore_password = "wso2carbon"
parameter.truststore_location ="repository/resources/security/client-truststore.jks"
parameter.truststore_type = "JKS"
parameter.truststore_password = "wso2carbon"
```

## Configuring connection recovery

Add the following parameters under the RabbitMQ to the deployment.toml file (stored in the `MI_HOME/conf` directory).

```toml
[[transport.rabbitmq.listener]]
parameter.retry_interval = "10"
parameter.retry_count = 5  
```

In case of a network failure or broker shutdown, WSO2 Micro Integrator will try to recreate the connection. The following parameters need to be configured in the transport listener to enable connection recovery in RabbitMQ.

If the parameters specified above are set, the Micro Integrator will retry 5 times with 10000 ms time intervals to reconnect when the connection is lost. If reconnecting also fails, the Micro Integrator will terminate the connection. If you do not specify values for the above parameters, the Micro Integrator uses 30000ms as the default retry interval and 3 as the default retry count.

## Configuring high throughput of message delivery

For increased performance and higher throughput in message delivery, configure the transport sender as shown below.

Add the following parameters under the RabbitMQ to the deployment.toml file (stored in the `MI_HOME/conf` directory).

```toml
[[transport.rabbitmq.sender]]
name = "CachedRabbitMQConnectionFactory"
parameter.hostname = "localhost"
parameter.port = 5672
parameter.username = "guest"
parameter.password = "guest"
```
When configuring the proxy service, be sure to add the following connection factory parameter in the address URI: `rabbitmq.connection.factory=CachedRabbitMQConnectionFactory`.


## Configure proxy-level throttling

!!! Note
    Proxy-level throttling is available from U2 level 4.1.0.111.

To enable throttling for the RabbitMQ proxy service listener, you can add the following configuration to the proxy service:

```toml
    <parameter name="rabbitmq.proxy.throttle.enabled">true</parameter>
    <parameter name="rabbitmq.proxy.throttle.mode">fixed_interval</parameter>
    <parameter name="rabbitmq.proxy.throttle.timeUnit">minute</parameter>
    <parameter name="rabbitmq.proxy.throttle.count">60</parameter>
```

!!! Note
    Allowed parameters for `rabbitmq.proxy.throttle.mode` : fixed_interval, batch

    Allowed parameters for `rabbitmq.proxy.throttle.timeUnit` : minute, hour, day

When enabling throttling for the RabbitMQ proxy service listener, to ensure that the message consumer retrieves only one message at a time from the RabbitMQ queue, you can add the following properties to the proxy service. This will avoid potential data loss if the server is restarted.
```toml
    <parameter name="rabbitmq.channel.consumer.qos">1</parameter>
    <parameter name="rabbitmq.queue.auto.ack">false</parameter>
```

The following table provides information on the proxy-level throttling parameters:

<table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
            <th>Possible Values</th>
        </tr>
        <tr>
            <td><code>rabbitmq.proxy.throttle.enabled</code></td>
            <td>
                Use this parameter to enable JMS message throttling at the proxy service level.
                When enabled, the default throttle limit (<code>rabbitmq.proxy.throttle.count</code>) is 60 messages per minute and the default throttle mode (<code>jms.proxy.throttle.mode</code>) is <code>fixed_interval</code>.
                That is, a maximum of 60 messages can be consumed per minute at a fixed rate of one message per second.
            </td>
            <td>No</td>
            <td><code>true</code>,<code>false</code></td>
        </tr>
        <tr>
            <td><code>rabbitmq.proxy.throttle.timeUnit</code></td>
            <td>
                The time unit refers to the time period over which the allowed number of messages (throttling count) is measured. It defines the interval during which the rate of requests from a client is controlled.
                For example, if you set the throttling count to 1000 and the time unit to minute, it will count the number of requests in each minute. If the messages received from RabbitMQ exceed 1000 within that minute, no more messages will be received until the next minute starts. The default time unit is <code>MINUTE</code>.
            </td>
            <td>No</td>
            <td>
                    <code>minute</code>,<code>hour</code>,<code>day</code>
            </td>
        </tr>
        <tr>
            <td><code>rabbitmq.proxy.throttle.count</code></td>
            <td>
                The throttle count specifies the maximum number of messages that can be consumed per minute by the proxy service.
                The default throttle count is 60 when throttling is enabled.
                Note that the actual throttle limit will be equal to or less than the value specified by the throttle limit parameter depending on the time taken for message mediation.
                For example, if the throttle limit is 60 and if each message takes more than one second for mediation, the total number of messages that can be consumed during the one-minute window will always be less than 60.
            </td>
            <td>No</td>
            <td>Any positive integer</td>
        </tr>
        <tr>
            <td><code>rabbitmq.proxy.throttle.mode</code></td>
            <td>
                The throttle mode specifies whether or not messages should be consumed at a fixed rate during configured <code>timeUnit</code>.
                The default throttle mode is <code>fixed_interval</code> when throttling is enabled.
            </td>
            <td>No</td>
            <td>
                <ul>
                    <li><code>fixed_interval</code>: Messages are consumed at a fixed rate during the configured time unit. The rate is calculated by dividing the length of the throttle window (If the <code>timeunit</code> is set as minute, it will be 60 seconds) by the throttle count (maximum number of messages per the configured time unit).
For example, if the throttle count is 30, the fixed interval is two seconds (60/30).</li>
                    <li><code>batch</code>: Messages are consumed as quickly as possible until the 60 seconds expire or until the throttle count is reached.
For example, if the throttle count is 30 and if the proxy service is capable of mediating all 30 messages within 30 seconds, the messages will be immediately consumed. The integrator will then wait till the throttle window expires before accepting more messages.
</li>
                </ul>
            </td>
        </tr>
</table>
