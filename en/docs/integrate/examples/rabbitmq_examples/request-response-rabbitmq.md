# Synchronous messaging with request-reply pattern

This sample demonstrates how you can implement the <b>request-reply</b> messaging scenario (dual-channel scenario) using the RabbitMQ broker and WSO2 Micro Integrator. 

As shown below, the `OrderRequest` proxy service in the Micro Integrator receives an HTTP
request, which it publishes to a RabbitMQ queue. This message is consumed and processed by the `OrderProcessing` proxy service in the Micro Integrator, and the response is sent back to the client over HTTP.

<img src="{{base_path}}/assets/img/integrate/rabbitmq/rabbitmq-request-response.png">

## Synapse configurations

See the instructions on how to [build and run](#build-and-run) this example. 

```xml tab='Order Request Proxy Service'
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
    name="OrderRequestService"
    transports="http https"
    startOnLoad="true">
   <description/>
   <target>
    <inSequence>
      <property name="rabbitmq.message.content.type"
                value="Content-Type"
                scope="axis2"/>
      <property name="TRANSPORT_HEADERS" scope="axis2" action="remove"/>
      <send>
          <endpoint>
            <address uri="rabbitmq:/order-request?rabbitmq.server.host.name=localhost&amp;rabbitmq.server.port=5672&amp;rabbitmq.server.user.name=guest&amp;rabbitmq.server.password=guest"/>
          </endpoint>
      </send>
    </inSequence>
   </target>
</proxy>
```

```xml tab='Order Processing Proxy Service'
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
    name="OrderProcessingService"
    transports="rabbitmq"
    startOnLoad="true">
   <description/>
   <target>
    <inSequence>
      <call>
          <endpoint>
            <http uri-template="http://localhost:8280/orders"/>
          </endpoint>
      </call>
      <log level="custom">
          <property name="Info" value="Your order has been placed successfully."/>
      </log>
      <respond/>
    </inSequence>
    <faultSequence>
      <payloadFactory media-type="xml">
          <format>
            <Error>$1</Error>
          </format>
          <args>
            <arg evaluator="xml" expression="get-property('ERROR_MESSAGE')"/>
          </args>
      </payloadFactory>
      <respond/>
    </faultSequence>
   </target>
   <parameter name="rabbitmq.queue.name">order-request</parameter>
   <parameter name="rabbitmq.connection.factory">AMQPConnectionFactory</parameter>
</proxy>
```

## Build and run

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. Enable the RabbitMQ sender and receiver in the Micro-Integrator from the deployment.toml. Refer the 
 [configuring RabbitMQ documentation]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitmq.md) for more information.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.
6. Make sure you have a RabbitMQ broker instance running.
7. Send a message to the `Order Request Proxy Service` with the following payload. 

	```json
	{   "orderId": "1242",
	"orderQty": 43,
	"orderDate": "2020/07/22"
	}
	```
