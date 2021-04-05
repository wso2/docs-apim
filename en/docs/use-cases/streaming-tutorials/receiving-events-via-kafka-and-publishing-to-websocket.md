# Recieving XML events via Kafka and Publishing to WebSocket

## Introduction

The Streaming Integrator can consume events from a Kafka topic and publish those events to a WebSocket in a streaming manner.

## Purpose

This application demonstrates how to configure WSO2 Streaming Integrator Tooling to receive events to the `SweetProductionStream` via Kafka transport in XML format and send sweet production events via WebSocket transport in XML format and log the events in `LowProductionAlertStream` to the output console.


## Prerequisites

Prepare the server to consume from  Kafka, follow the steps below:

1. Download the Kafka broker from [the Apache site](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.3.0/kafka_2.12-2.3.0.tgz) and extract it. 
From here onwards, this directory is referred to as `<KAFKA_HOME>`.

2. Create a directory named `Source` in a preferred location in your machine and copy the following JARs to the `Source` directory from the `<KAFKA_HOME>/libs` directory.

    - `kafka_2.12-2.3.0.jar`
   
    - `kafka-clients-2.3.0.jar`
    
    - `metrics-core-2.2.0.jar`
    
    - `scala-library-2.12.8.jar`
    
    - `zkclient-0.11.jar`
   
    - `zookeeper-3.4.14.jar`
  
3. Create another directory named `Destination` in a preferred location in your machine.

4. To convert the Kafka JARS you copied to the `Source` directory, issue the following command:

            * For Windows:
                ```
                {WSO2SIHome}/bin/jartobundle.bat <{Source} Directory Path> <{Destination} Directory Path>
                ```
            * For Linux:
                ```
                sh {WSO2SIHome}/bin/jartobundle.sh <{Source} Directory Path> <{Destination} Directory Path>
                ```
                
5. Add the OSGI converted Kafka libs from the `Destination` directory to the `<SI_HOME>/lib` directory.

6. Add the original Kafka libs from `Source` to `<SIHome>/samples/sample-clients/lib`.

## Consuming data from Kafka

### Step 1: Start Kafka

1. Navigate to the `<KAFKA_HOME>` directory and start a Zookeeper node by issuing the following command.

    `sh bin/zookeeper-server-start.sh config/zookeeper.properties`

2. Navigate to the `<KAFKA_HOME>` directory and start the Kafka server node by issuing the following command.

    `sh bin/kafka-server-start.sh config/server.properties`


### Step 2: Start the Streaming Integrator

Navigate to the `<SI_HOME>/bin` directory and issue the following command. 

`sh server.sh`

The following log appears on the SI console when the server is started successfully.

```
INFO {org.wso2.carbon.kernel.internal.CarbonStartupHandler} - WSO2 Streaming Integrator started in 4.240 sec
```

### Step 3: Consume from a Kafka topic and Publish to WebSocket

####
1. Let's create a basic Siddhi application to consume messages from a Kafka topic and publish to WebSocket in XML format.

```
@App:name("RecieveKafkaPublishWebSocket")
@App:description("Description of the plan")

@source(type='kafka',
        topic.list='kafka_sample_topic',
        partition.no.list='0',
        threading.option='single.thread',
        group.id='group',
        bootstrap.servers='localhost:9092',
@map(type='xml'))
define stream SweetProductionStream(name string, amount double);

@sink(type='websocket', 
      url='ws://localhost:8025/abc',
@map(type='xml'))
define stream LowProductionAlertStream (name string, amount double);

@info(name='query1')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```

2. Save the sample. If there is no syntax error in the Siddhi Application, the following message is shown on the console:

```
Siddhi App RecieveKafkaPublishWebSocket.siddhi successfully deployed. 
```

#### Executing the Sample:

1. Open a terminal and navigate to `<SIHome>/samples/sample-clients/kafka-producer` and run "ant" command as follows:
```
ant -Dtype=xml -DtopicName=kafka_sample_topic
```

You can limit the number of events as follows as well,
```
ant -Dtype=xml -DnoOfEventsToSend=5 -DtopicName=kafka_sample_topic
```

2. Open a terminal and navigate to the `<SIHome>/samples/sample-clients/websocket-receiver` directory and run the ant command.

    If you use the default host 'localhost' and port '8025' in your program use `ant` command without any arguments.
    However, if you use different host or port, run the ant command with appropriate arguments. 
    e.g., `ant -Dport=9025`
 

3. Start the Siddhi application by clicking on 'Run'.

4. If the Siddhi application starts successfully, the following messages would be shown on the console.
        ```
        * RecieveKafkaPublishWebSocket.siddhi -  Started Successfully!
        ```

#### Notes:

If you edit this application while it's running, stop the application -> Save -> Start.

## Viewing the Results:

Check the output in the terminal of <SIHome>/samples/sample-clients/websocket-receiver. You will see output similar to the following: 
```
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341745974, data=[Jelly Bean, 6559.3817149644165], isExpired=false}
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341746974, data=[KitKat, 292.1776931457968], isExpired=false}
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341739972, data=[Cream Sandwich, 9850.605768948268], isExpired=false}
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341737970, data=[Éclair, 2183.9079927424236], isExpired=false}
```

## Note:
* Stop this Siddhi application, once you are done with the execution.
* Stop Kafka server and Zookeeper server individually by executing Ctrl+C.


