# Avro Message with Kafka Connector Example

Given below is a sample scenario that demonstrates how to send Apache Avro messages to a Kafka broker via Kafka topics. The `publishMessages` operation allows you to publish messages to the Kafka brokers via Kafka topics.

## What you'll build

Given below is a sample API that illustrates how you can connect to a Kafka broker with the `init` operation and then use the `publishMessages` operation to publish messages via the topic. It exposes Kafka functionalities as a RESTful service. Users can invoke the API using HTTP/HTTPS with the required information.

API has the `/publishMessages` context. It publishes messages via the topic to the Kafka server.

## Set up Kafka

Before you begin, set up Kafka by following the instructions in [Setting up Kafka](setting-up-kafka.md).

## Configure the connector in WSO2 Integration Studio

Follow these steps to set up the Integration Project and the Connector Exporter Project.

{!reference/connectors/importing-connector-to-integration-studio.md!}

1. Right-click the created Integration Project and select **New** -> **Rest API** to create the REST API.

2. Specify the API name as `KafkaTransport` and API context as `/publishMessages`. You can go to the source view of the XML configuration file of the API and copy the following configuration (source view).

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <api context="/publishMessages" name="KafkaTransport" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="POST">
            <inSequence>
                <property name="valueSchema"
                        expression="json-eval($.test)"
                        scope="default"
                        type="STRING"/>
                <property name="value"
                        expression="json-eval($.value)"
                        scope="default"
                        type="STRING"/>
                <property name="key"
                        expression="json-eval($.key)"
                        scope="default"
                        type="STRING"/>
                <property name="topic"
                        expression="json-eval($.topic)"
                        scope="default"
                        type="STRING"/>
                <kafkaTransport.init>
                     <name>Sample_Kafka</name>
                     <bootstrapServers>localhost:9092</bootstrapServers>
                     <keySerializerClass>io.confluent.kafka.serializers.KafkaAvroSerializer</keySerializerClass>            
                     <valueSerializerClass>io.confluent.kafka.serializers.KafkaAvroSerializer</valueSerializerClass>
                     <schemaRegistryUrl>http://localhost:8081</schemaRegistryUrl>
                     <maxPoolSize>100</maxPoolSize>
                </kafkaTransport.init>
                <kafkaTransport.publishMessages>
                     <topic>{$ctx:topic}</topic>
                     <key>{$ctx:key}</key>
                     <value>{$ctx:value}</value>
                     <valueSchema>{$ctx:valueSchema}</valueSchema>
                </kafkaTransport.publishMessages>
            </inSequence>
            <outSequence/>
            <faultSequence/>
        </resource>
    </api>
    ```
Now we can export the imported connector and the API into a single CAR application. The CAR application needs to be deployed during server runtime. 

{!reference/connectors/exporting-artifacts.md!}

## Deployment

Follow these steps to deploy the exported CApp in the Enterprise Integrator Runtime. 

{!reference/connectors/deploy-capp.md!}
    
## Testing

Invoke the API (http://localhost:8290/publishMessages) with the following payload,

````json
{
   "test": {
       "type": "record",
       "name": "myrecord",
       "fields": [
           {
               "name": "f1",
               "type": ["string", "int"]
           }
       ]
   },
   "value": {
       "f1": "sampleValue"
   },
   "key": "sampleKey",
   "topic": "myTopic"
}
````

**Expected Response**: 
   
Run the following command to verify the messages:
````bash
[confluent_home]/bin/kafka-avro-console-consumer.sh --topic myTopic --bootstrap-server localhost:9092 --property print.key=true --from-beginning
````
See the following message content:
````json
{"f1":{"string":"sampleValue"}}
````  
Sample API configuration when the Confluent Schema Registry is secured with basic auth,

```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/publishMessages" name="KafkaTransport" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST">
        <inSequence>
            <property name="valueSchema"
                      expression="json-eval($.test)"
                      scope="default"
                      type="STRING"/>
            <property name="value"
                      expression="json-eval($.value)"
                      scope="default"
                      type="STRING"/>
            <property name="key"
                      expression="json-eval($.key)"
                      scope="default"
                      type="STRING"/>
            <property name="topic"
                      expression="json-eval($.topic)"
                      scope="default"
                      type="STRING"/>
            <kafkaTransport.init>
               <name>Sample_Kafka</name>
               <bootstrapServers>localhost:9092</bootstrapServers>
               <keySerializerClass>io.confluent.kafka.serializers.KafkaAvroSerializer</keySerializerClass>
               <valueSerializerClass>io.confluent.kafka.serializers.KafkaAvroSerializer</valueSerializerClass>
               <schemaRegistryUrl>http://localhost:8081</schemaRegistryUrl>
               <maxPoolSize>100</maxPoolSize>
               <basicAuthCredentialsSource>USER_INFO</basicAuthCredentialsSource>
               <basicAuthUserInfo>admin:admin</basicAuthUserInfo>
            </kafkaTransport.init>
            <kafkaTransport.publishMessages>
               <topic>{$ctx:topic}</topic>
               <key>{$ctx:key}</key>
               <value>{$ctx:value}</value>
               <valueSchema>{$ctx:valueSchema}</valueSchema>
            </kafkaTransport.publishMessages>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>
```
In the above example, the <b>basicAuthCredentialsSource</b> parameter is configured as <b>USER_INFO</b>. For example, consider a scenario where the <b>basicAuthCredentialsSource</b> parameter is set to <b>URL</b> as follows:

````xml 
<basicAuthCredentialsSource>URL</basicAuthCredentialsSource>
````

Then, the <b>schemaRegistryUrl</b> parameter should be configured as shown below.

````xml 
<schemaRegistryUrl>http://admin:admin@localhost:8081</schemaRegistryUrl>
````
Refer the [confluent documentation](https://docs.confluent.io/platform/current/schema-registry/serdes-develop/serdes-avro.html) for more details.

This demonstrates how the Kafka connector publishes Avro messages to Kafka brokers.
   
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers](../../../../setup/installation/run_in_containers).
* To customize this example for your own scenario, see [kafka Connector Configuration](kafka-connector-config.md) documentation.
