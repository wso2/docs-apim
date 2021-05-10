# Kafka Connector Example

Given below is a sample scenario that demonstrates how to send messages to a Kafka broker via Kafka topics. The publishMessages operation allows you to publish messages to the Kafka brokers via Kafka topics.

## What you'll build

Given below is a sample API that illustrates how you can connect to a Kakfa broker with the `init` operation and then use the `publishMessages` operation to publish messages via the topic. It exposes Kakfa functionalities as a RESTful service. Users can invoke the API using HTTP/HTTPs with the required information.

API has the context `/publishMessages`. It will publish messages via the topic to the Kafka server.

The following diagram illustrates all the required functionality of the Kafka service that you are going to build.

<img src="{{base_path}}/assets/img/integrate/connectors/kafkaconnectorpublishmessage.png" title="KafkaConnector" width="800" alt="KafkaConnector"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Set up Kafka

Before you begin, set up Kafka by following the instructions in [Setting up Kafka]({{base_path}}/reference/connectors/ksfka-connector/setting-up-kafka/).

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and the Connector Exporter Project.

{!reference/connectors/importing-connector-to-integration-studio.md!}

1. Right click on the created Integration Project and select **New** -> **Rest API** to create the REST API.

2. Specify the API name as `KafkaTransport` and API context as `/publishMessages`. You can go to the source view of the XML configuration file of the API and copy the following configuration (source view).

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <api context="/publishMessages" name="KafkaTransport" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="POST">
            <inSequence>
                <kafkaTransport.init>
                    <name>Sample_Kafka</name>
                    <bootstrapServers>localhost:9092</bootstrapServers>
                    <keySerializerClass>org.apache.kafka.common.serialization.StringSerializer</keySerializerClass>
                    <valueSerializerClass>org.apache.kafka.common.serialization.StringSerializer</valueSerializerClass>
                    <maxPoolSize>100</maxPoolSize>
                </kafkaTransport.init>
                <kafkaTransport.publishMessages>
                    <topic>test</topic>
                </kafkaTransport.publishMessages>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
    </api>
    ```
Now we can export the imported connector and the API into a single CAR application. The CAR application needs to be deployed during server runtime. 

{!reference/connectors/exporting-artifacts.md!}

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/kafka-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!reference/connectors/deploy-capp.md!}
    
## Testing

**Create a topic**:

Let’s create a topic named “test” with a single partition and only one replica.
Navigate to the <KAFKA_HOME> and run following command.
   
```bash
bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test     
```

**Sample Request**:
   
Send a message to the Kafka broker using a CURL command or sample client.

```bash
curl -X POST -d '{"name":"sample"}' "http://localhost:8290/publishMessages" -H "Content-Type:application/json" -v
```

**Expected Response**: 
   
Navigate to the <KAFKA_HOME> and run the following command to verify the messages:

```bash
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
```

See the following message content:

```bash
{"name":"sample"}
```   

This demonstrates how the Kafka connector publishes messages to the Kafka brokers.
   
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers/).
* To customize this example for your own scenario, see [kafka Connector Configuration]({{base_path}}/reference/connectors/kafka-connector/kafka-connector-config/) documentation.