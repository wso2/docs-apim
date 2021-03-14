# Using the Kafka Inbound Endpoint

## Example use case

This sample demonstrates how one way message bridging from Kafka to HTTP can be done using the inbound kafka endpoint.

### Synapse configuration

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Inbound Endpoint'
<?xml version="1.0" encoding="UTF-8"?>
<inboundEndpoint name="KAFKAListenerEP" sequence="kafka_process_seq" onError="fault" class="org.wso2.carbon.inbound.kafka.KafkaMessageConsumer" suspend="false" 
    xmlns="http://ws.apache.org/ns/synapse">
    <parameters>
        <parameter name="sequential">true</parameter>
        <parameter name="interval">10</parameter>
        <parameter name="coordination">true</parameter>
        <parameter name="inbound.behavior">polling</parameter>
        <parameter name="value.deserializer">org.apache.kafka.common.serialization.StringDeserializer</parameter>
        <parameter name="topic.name">test</parameter>
        <parameter name="poll.timeout">100</parameter>
        <parameter name="bootstrap.servers">localhost:9092</parameter>
        <parameter name="group.id">hello</parameter>
        <parameter name="contentType">application/json</parameter>
        <parameter name="key.deserializer">org.apache.kafka.common.serialization.StringDeserializer</parameter>
    </parameters>
</inboundEndpoint>
```

```xml tab='Sequence'
<?xml version="1.0" encoding="ISO-8859-1"?>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="kafka_process_seq">
   <log level="full"/>
   <log level="custom">
      <property xmlns:ns="http://org.apache.synapse/xsd" name="partitionNo" expression="get-property('partitionNo')"/>
   </log>
   <log level="custom">
      <property xmlns:ns="http://org.apache.synapse/xsd" name="messageValue" expression="get-property('messageValue')"/>
   </log>
   <log level="custom">
      <property xmlns:ns="http://org.apache.synapse/xsd" name="offset" expression="get-property('offset')"/>
   </log>
</sequence>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create a [mediation sequence]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) and [inbound endpoint]({{base_path}}/integrate/develop/creating-an-inbound-endpoint) with configurations given in the above example.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the back-end service.

-   Apache Kafka inbound endpoint should be configured. The recommended version for the customized kafka inbound endpoint is `kafka_2.12-2.2.1`. See [Configuring Kafka](../../../../setup/feature_configs/configuring-kafka) for more information. 

-   Go to the [WSO2 Connector Store](https://store.wso2.com/store/assets/esbconnector/details/b15e9612-5144-4c97-a3f0-179ea583be88) and click **Download Inbound Endpoint** to download the inbound JAR file. Add the downloaded JAR file to the <MI_HOME>/dropins directory.

Run the following commands in the <KAFKA_HOME> directory to invoke the service.
    
-   Run the following on the Kafka command line to create a topic named `test` with a single partition and only one
    replica:

    ```bash
    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
    ```

-   Run the following on the Kafka command line to send a message to the Kafka brokers. You can also use the **WSO2 ESB Kafka producer** connector to send the message to the Kafka brokers.

    ```bash
    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
    ```
    
-   Executing the above command will open up the console producer. Send the following message using the console:
    
    ```json
    {"test":"wso2"}
    ```

You can see the following Message content in the Micro Integrator:

```bash
[2020-02-19 12:39:59,331]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - To: , MessageID: d130fb8f-5d77-43f8-b6e0-85b98bf0f8c1, Direction: request, Payload: {"test":"wso2"}
[2020-02-19 12:39:59,335]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - partitionNo = 0
[2020-02-19 12:39:59,336]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - messageValue = {"test":"wso2"}
[2020-02-19 12:39:59,336]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - offset = 6
```

The Kafka inbound gets the messages from the Kafka brokers and logs the messages in the Micro Integrator.

## Using specific topics/topic patterns

You may consume messages in two ways: Using **specific topics** or using a **topic pattern**.

```xml tab='Using Specific Topics'
<parameter name="topic.names">test,sampletest</parameter>
```

```xml tab='Using a Topic Pattern'
<parameter name="topic.pattern">.*test</parameter>
```
