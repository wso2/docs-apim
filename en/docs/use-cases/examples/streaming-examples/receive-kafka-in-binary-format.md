# Receiving Binary Events via Kafka

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to receive events to the SweetProductionStream via Kafka transport in Binary Format and log the events in LowProductionAlertStream to the output console.

## Prerequisites:
1. The following steps must be executed to enable WSO2 SI to receive events via the Kafka transport. Since you need to shut down the server to execute these steps, get a copy of these instructions prior to proceeding.
    1. Download the Kafka broker from here: https://archive.apache.org/dist/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz.
    2. Convert and copy the Kafka client jars from the `{KafkaHome}/libs` directory to the `{WSO2SIHome}/libs` directory as follows.
        1. Create a directory named `{Source}` in a preferred location in your machine and copy the following JARs to it from the `{KafkaHome}/libs` directory.
            * kafka_2.11-0.10.0.0.jar
            * kafka-clients-0.10.0.0.jar
            * metrics-core-2.2.0.jar
            * scala-library-2.11.8.jar
            * zkclient-0.8.jar
            * zookeeper-3.4.6.jar
        2. Create another directory named `{Destination}` in a preferred location in your machine.
        3. To convert all the Kafka jars you copied into the `{Source}` directory, issue the following command,
            * For Windows:
                ```
                {WSO2SIHome}/bin/jartobundle.bat <{Source} Directory Path> <{Destination} Directory Path>
                ```
            * For Linux:
                ```
                sh {WSO2SIHome}/bin/jartobundle.sh <{Source} Directory Path> <{Destination} Directory Path>
                ```
        4. Add the OSGI converted kafka libs from `{Destination}` directory to `{WSO2SIHome}/lib`.
        5. Add the original Kafka libs from `{Source}` to `{WSO2SIHome}/samples/sample-clients/lib`.
        6. Navigate to `{KafkaHome}` and start zookeeper node using following command.
            ```
            sh bin/zookeeper-server-start.sh config/zookeeper.properties
            ```
        7. Navigate to `{KafkaHome}` and start Kafka server node using following command.
        ```
        sh bin/kafka-server-start.sh config/server.properties
        ```
2. Save this sample.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages would be shown on the console.
        ```
        * ReceiveKafkaInBinaryFormat.siddhi - Started Successfully!
        ```

## Notes:
If you edit this application while it's running, stop the application -> Save -> Start.

## Testing the Sample:
Navigate to `{WSO2SIHome}/samples/sample-clients/kafka-producer` and run "ant" command as follows:
```
ant -DnoOfEventsToSend=5 -DtopicName=kafka_sample_topic -DisBinaryMessage=true
```

## Viewing the Results:
Messages similar to the following would be shown on the console.
```
INFO {io.siddhi.core.stream.output.sink.LogSink} - ReceiveKafkaInBinaryFormat : LowProductionAlertStream : Event{timestamp=1513282182570, data=["Cupcake", 1665.0], isExpired=false}
```

## Note:
* Stop this Siddhi application, once you are done with the execution.
* Stop Kafka server and Zookeeper server individually by executing Ctrl+C.

```sql
@App:name("ReceiveKafkaInBinaryFormat")
@App:description('Receive events via Kafka transport in Binary format and view the output on the console')


@source(type='kafka',
        topic.list='kafka_sample_topic',
        partition.no.list='0',
        threading.option='single.thread',
        group.id='group',
        is.binary.message='true',
        bootstrap.servers='localhost:9092',
 @map(type='binary'))
define stream SweetProductionStream(id string, amount double);

@sink(type='log')
define stream LowProductionAlertStream(id string, amount double);

@info(name='query1')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```