# A topic used to broadcast a message to all consumers

This sample demonstrates how WSO2 Micro Integrator can be used to implement a publisher-subscriber messaging scenario using RabbitMQ topics. That is, a message publisher can broadcast a message to multiple consumers through the RabbitMQ topic.

As shown below, the publisher proxy in the Micro Integrator will publish messages to a RabbitMQ topic, which multiple subscriber proxies (defined in the Micro Integrator) will consume.

<img src="{{base_path}}/assets/img/integrate/rabbitmq/rabbitmq-pub-sub.png">

## Synapse configurations

See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='RabbitMQ Subscriber 1'
<?xml version="1.0" encoding="UTF-8"?><proxy xmlns="http://ws.apache.org/ns/synapse" name="TopicSubscriber1" transports="rabbitmq" startOnLoad="true">
  <description/>
  <target>
      <inSequence>
          <log level="custom">
              <property name="Message Received" expression="//Message"/>
          </log>
          <call>
              <endpoint>
                  <http uri-template="http://localhost:8280/employees" method="post"/>
              </endpoint>
          </call>
      </inSequence>
  </target>
  <parameter name="rabbitmq.queue.routing.key">topic1</parameter>
  <parameter name="rabbitmq.exchange.name">amq.topic</parameter>
  <parameter name="rabbitmq.queue.name">queue2</parameter>
  <parameter name="rabbitmq.connection.factory">AMQPConnectionFactory</parameter>
</proxy>

```

```xml tab='RabbitMQ Subscriber 2'
<?xml version="1.0" encoding="UTF-8"?><proxy xmlns="http://ws.apache.org/ns/synapse" name="TopicSubscriber2" transports="rabbitmq" startOnLoad="true">
  <description/>
  <target>
      <inSequence>
          <log level="custom">
              <property name="Message Received" expression="//Message"/>
          </log>
          <call>
              <endpoint>
                  <http uri-template="http://localhost:8280/employees" method="post"/>
              </endpoint>
          </call>
      </inSequence>
  </target>
  <parameter name="rabbitmq.queue.routing.key">topic1</parameter>
  <parameter name="rabbitmq.exchange.name">amq.topic</parameter>
  <parameter name="rabbitmq.queue.name">queue3/parameter>
  <parameter name="rabbitmq.connection.factory">AMQPConnectionFactory</parameter>
</proxy>
```

```xml tab='RabbitMQ Publisher'
<?xml version="1.0" encoding="UTF-8"?><proxy xmlns="http://ws.apache.org/ns/synapse" name="TopicPublisher" transports="http https" startOnLoad="true">
  <description/>
  <target>
      <inSequence>
          <property name="OUT_ONLY" value="true"/>
          <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
          <send>
              <endpoint>
                  <address uri="rabbitmq:/topic1?rabbitmq.server.host.name=localhost&amp;rabbitmq.server.port=5672&amp;rabbitmq.server.user.name=guest&amp;rabbitmq.server.password=guest&amp;rabbitmq.exchange.name=amq.topic"/>
              </endpoint>
          </send>
      </inSequence></target></proxy>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. Enable the RabbitMQ sender and receiver in the Micro-Integrator from the deployment.toml. Refer the 
 [configuring RabbitMQ documentation](../../../setup/brokers/configure-with-rabbitMQ.md) for more information.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.
6. Make sure you have a RabbitMQ broker instance running.
7. Create queue1 and queue2 and add bind them in the `amq.topic` exchange with the routing key `topic1`.
8. Publish the following payload to the topic using the publisher proxy (TopicPublisher).

    ```xml
    <Message>
    <Name>John Doe</Name>
    <Age>27</Age>
    </Message>
    ```
