# Connecting to RabbitMQ

This section describes how to configure WSO2 Micro Integrator to connect with RabbitMQ.

!!! Tip
	See the complete list of server-level configurations for the [RabbitMQ Listener]({{base_path}}/reference/config-catalog-mi/#rabbitmq-listener) and [RabbitMQ Sender]({{base_path}}/reference/config-catalog-mi/#rabbitmq-sender) in the `deployment.toml` file (stored in the `MI_HOME/conf` directory).

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

Optionally, you can configure the following parameter in your proxy service when you define your mediation sequence:

```xml
<parameter name="rabbitmq.server.retry.interval" locked="false">10000</parameter> 
```

The parameter specified above sets the retry interval with which the RabbitMQ client tries to reconnect. Generally having this value less than the value specified as `rabbitmq.connection.retry.interval` will help synchronize the reconnection of the Micro Integrator and the RabbitMQ client.

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
