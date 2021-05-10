# Publish unacked messages to Dead Letter Exchange

This sample demonstrates how WSO2 Micro Integrator can ensure guaranteed delivery of messages by using the <b>Dead Letter Exchange (DLX)</b> of RabbitMQ.

As shown below, a proxy service in the Micro Integrator consumes messages from the RabbitMQ broker and sends it to the endpoint. If the message delivery fails, the Micro Integrator will route the message to the dead letter exchange of RabbitMQ.

<img src="{{base_path}}/assets/img/integrate/rabbitmq/rabbitmq-dead-letter-exchange.png">

## Synapse configurations

See the instructions on how to [build and run](#build-and-run) this example.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
    name="OrdersService"
    startOnLoad="true"
    statistics="disable"
    trace="disable"
    transports="rabbitmq">
   <target>
    <inSequence>
      <log level="custom">
          <property expression="$body" name="Message Received"/>
      </log>
      <call blocking="true">
          <endpoint>
            <http uri-template="http://localhost:8280/orders"/>
          </endpoint>
      </call>
      <log level="custom">
          <property name="Status" value="The message process successfully"/>
      </log>
    </inSequence>
    <faultSequence>
      <log level="custom">
          <property name="Status" value="Could not process the message"/>
      </log>
      <property name="SET_ROLLBACK_ONLY" scope="axis2" value="true"/>
    </faultSequence>
   </target>
   <parameter name="rabbitmq.queue.autodeclare">false</parameter>
   <parameter name="rabbitmq.exchange.name">orders-exchange</parameter>
   <parameter name="rabbitmq.queue.auto.ack">false</parameter>
   <parameter name="rabbitmq.queue.name">orders</parameter>
   <parameter name="rabbitmq.connection.factory">AMQPConnectionFactory</parameter>
   <description/>
</proxy>
```

## Build and run

1. Make sure you have a RabbitMQ broker instance running.
2. Create an exchange with the name `orders-exchange`.
3. Create another exchange `orders-error-exchange` with a queue bound to it (`orders-error`).
4. Create queue `orders` (bound by `orders-exchange` with routing key `orders` ) and configure a
dead letter exchange for it (`orders-error-exchange`).
5. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
6. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
7. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
8. Enable the RabbitMQ sender and receiver in the Micro-Integrator from the deployment.toml. Refer the 
 [configuring RabbitMQ documentation]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitmq.md) for more information.
9. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.
10. Make the `http://localhost:8280/orders` endpoint unavailable temporarily. 
11. Publish a message to the orders queue.
12. You will see that the failed message has been moved to the dead-letter-exchange.
