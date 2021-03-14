# Receiving Data in Transit

Data in transit, also known as data in flight refers to data that is in the process of being moved and therefore not permanently stored in a location where they can be in a static state. Streaming data, messages in a queue or a topic in a messaging system, and requests sent to a HTTP listening port are a few examples.

The sources from which data in transit/flight are received can be classified into two categories as follows:

- **Data publishers**: You can receive data from these sources without subscribing to receive it. (e.g., HTTP, HTTPS, TCP, email, etc.)

- **Messaging Systems**: You need to subscribe to receive data from the source. (e.g., messaging systems such as Kafka, JMS, MQTT, etc.)

## Receiving data from data publishers

Data publishers are transports from which WSO2 SI can receive messages without subscribing for them. In a typical scenario, you are required to open a port in the WSO2 Streaming Integrator that is dedicated to listen to messages from the data publisher.

![receiving data from a data publisher]({{base_path}}/assets/img/streaming/receiving-data-in-transit/push-data-sources.png)

To receive data from a data publisher, define an input [stream](https://siddhi.io/en/v5.1/docs/query-guide/#stream) and connect a [source] annotation of a type that receives data from a data publisher as shown in the example below.

```siddhi
@source(type='http', 
    receiver.url='http://localhost:5005/StudentRegistrationEP', 
    @map(type = 'json'))

define stream StudentRegistrationStream (name string, course string);
```
In this example, an online student registration results in an HTTP request in JSON format being sent to the endpoint named `StudentRegistrationEP` to the `5005` port of the localhost. The source generates an event in the `StudentRegistrationStream` stream for each of these requests.

### Try it out

To try out the example given above, let's include the source configuration in a Siddhi application and simulate an event to it.

1. Open and access Streaming Integrator Tooling. For instructions, see [Streaming Integrator Tooling Overview - Starting Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

2. Open a new file and add the following Siddhi application to it.

    ```siddhi
    @App:name('StudentRegistrationApp')
     
    @source(type = 'http', receiver.url = "http://localhost:5005/StudentRegistrationEP",
        @map(type = 'json'))
    define stream StudentRegistrationStream (name string, course string);
    
    @sink(type = 'log', prefix = "New Student",
        @map(type = 'passThrough'))
    define stream StudentLogStream (name string, course string, total long);
    
     
    @info(name = 'TotalStudentsQuery')
    from StudentRegistrationStream 
    select name, course, count() as total 
    insert into StudentLogStream;
    ```

    Save the Siddhi application.
    
    This Siddhi application contains the `http` source of the previously used example. The `TotalStudentsQuery` query selects all the student registrations captured as HTTP requests and directs them to the `StudentLogStream` output stream. A log sink connected to this output stream logs these registrations in the terminal. Before logging the events the Siddhi application also counts the number of registrations via the `count()` function. This count is presented as `total` in the logs.
    
3. Start the Siddhi application by clicking on the play icon in the top panel.

    ![Play]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/play.png)
    
4. To simulate an event, issue the following two CURL commands.

    ```text    
    curl -X POST \
      http://localhost:5005/StudentRegistrationEP \
      -H 'content-type: application/json' \
      -d '{
      "event": {
        "name": "John Doe",
        "course": "Graphic Design"
      }
    }'
    ```
   
    ```text    
    curl -X POST \
     http://localhost:5005/StudentRegistrationEP \
     -H 'content-type: application/json' \
     -d '{
     "event": {
       "name": "Michelle Cole",
       "course": "Graphic Design"
     }
    }'
    ```
   
   The following is logged in the terminal.
   
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - New Student : Event{timestamp=1603185021250, data=[John Doe, Graphic Design, 1], isExpired=false}

    INFO {io.siddhi.core.stream.output.sink.LogSink} - New Student : Event{timestamp=1603185486763, data=[Michelle Cole, Graphic Design, 2], isExpired=false}
    ```
    
### Supported transports

The following are the supported transports to capture data in transit from data publishers.

| **Transport** | **Siddhi Extension**                                                          |
|---------------|-------------------------------------------------------------------------------|
| HTTP          | [http](https://siddhi-io.github.io/siddhi-io-http/api/latest/#source)         |
| TCP           | [tcp](https://siddhi-io.github.io/siddhi-io-tcp/api/latest/#source)           |
| Email         | [email](https://siddhi-io.github.io/siddhi-io-email/api/latest/#email-source) |
| `grpc`        | [grpc](https://siddhi-io.github.io/siddhi-io-grpc/api/latest/#source)         |
| `Thrift`      |                                                                               |

### Supported mappers

Mappers determine the format in which the event is received. For information about transforming events by changing the format in which the data is received/published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data#transforming-message-formats).

The following are the supported mappers when you receive data from data publishers.

| **Mapper** | **Supporting Siddhi Extension**                                                        |
|---------------|----------------------------------------------------------------------------------------|
| `json`        | [json](https://siddhi-io.github.io/siddhi-map-json/api/latest/#sinkmapper)             |
| `xml`         | [xml](https://siddhi-io.github.io/siddhi-map-xml/api/latest/#sinkmapper)               |
| `text`        | [text](https://siddhi-io.github.io/siddhi-map-text/api/latest/#sinkmapper)             |
| `avro`        | [avro](https://siddhi-io.github.io/siddhi-map-avro/api/latest/#sinkmapper)             |
| `binary`      | [binary](https://siddhi-io.github.io/siddhi-map-binary/api/latest/#binary-sink-mapper) |  

## Receiving data from messaging systems

This section explains how to receive input data from messaging systems where WSO2 Streaming Integrator needs to subscribe to specific queues/topics in order to receive the required data.

![receiving data from a messaging system]({{base_path}}/assets/img/streaming/receiving-data-in-transit/pull-data-sources.png)

To receive data from a messaging system, define an input [stream](https://siddhi.io/en/v5.1/docs/query-guide/#stream) and connect a [source] annotation of a type that receives data from a messaging system.

For example, consider a weather broadcasting application that publishes the temperature and humidity for each region is monitors in a separate Kafka topic. The local weather broadcasting firm of Houston wants to subscribe to receive weather broadcasts for Houston.

```
@source(type='kafka',
        topic.list='houston',
        threading.option='single.thread',
        group.id="group1",
        bootstrap.servers='localhost:9092',
        @map(type='json'))
define stream TemperatureHumidityStream (temperature int, humidity int);
```

The above Kafka source listens at bootstrap server `localhost:9092` for messages in the kafka topic named `houston` sent in JSON format. For each message, it generates an event in the `TemperatureHumidityStream` stream.

### Try it out

To try the above example, follow the steps below.

1. Download the Kafka broker from [the Apache site](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.3.0/kafka_2.12-2.3.0.tgz) and extract it.
   This directory is referred to as `<KAFKA_HOME>` from here on.
   
2. Start Kafka as follows:

    1. First, start a zoo keeper node. To do this, navigate to the `<KAFKA_HOME>` directory and issue the following command.
    
        `sh bin/zookeeper-server-start.sh config/zookeeper.properties`
    
    2. Next, start a Kafka server node. To do this, issue the following command from the same directory.
    
        `sh bin/kafka-server-start.sh config/server.properties`
        
    3. To create a Kafka topic named `houston`, issue the following command from the same directory.
    
        `bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic houston`
        
3. Prepare WSO2 Streaming Integrator Tooling to consume Kafka messages as follows:

    1. Start and access [WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview). 
    
    2. Download and install the Kafka extension to it. For instructions, see [Installing Siddhi Extensions]({{base_path}}/develop/streaming-apps/installing-siddhi-extensions).
    
    3. Open a new file and add the following Siddhi application to it.

        ```
        @App:name('TemperatureReportingApp')
       
        @source(type = 'kafka', topic.list = "houston", threading.option = "single.thread", group.id = "group1", bootstrap.servers = "localhost:9092",
        @map(type = 'json'))
        define stream TemperatureHumidityStream (temperature int, humidity int);
        
        @sink(type = 'log', prefix = "Temperature Update",
        	@map(type = 'passThrough'))
        
        define stream OutputStream (temperature int, humidity int);
                
        @info(name = 'query1')
        from TemperatureHumidityStream 
        select * 
        insert into OutputStream;
        ```
       
       This Siddhi application includes the Kafka source that subscribes to the `houston` kafka source and generates an event in the `TemperatureHumidityStream` stream for each message in the topic (as described in the example inj the previous section). `query1` query gets all these messages from the `TemperatureHumidityStream` stream and inserts them into the `OutputStream` stream so that they can be logged via the log sink connected to the latter.
       
       Save the Siddhi application.
       
    4. Start the `TemperatureReportingApp` Siddhi application that you created and saved.
        
4. To generate a message in the `houston` Kafka topic, follow the steps below:

    1. To run the Kafka command line client, issue the following command from the `<KAFKA_HOME>` directory.
    
        `bin/kafka-console-producer.sh --broker-list localhost:9092 --topic houston`
        
    2. When you are prompted to type messages in the console. Type the following in the command prompt.
    
        `{"event":{ "temperature":23, "humidity":99}}`
        
        This pushes a message to the Kafka Server. Then, the Siddhi application you deployed in the Streaming Integrator consumes this message. As a result, the Streaming Integrator log displays the following:
        
5. Check the logs of Streaming Integrator Tooling. The Kafka message you generated is logged as follows:

    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Temperature Update : Event{timestamp=1603339705244, data=[23, 99], isExpired=false}
    ```

### Supported transports

The following are the supported transports to capture data in transit from messaging systems.

| **Transport** | **Siddhi Extension**                                                                               |
|---------------|----------------------------------------------------------------------------------------------------|
| NATS          | [nats](https://siddhi-io.github.io/siddhi-io-nats/api/latest/#nats-source)                         |
| Kafka         | [kafka](https://siddhi-io.github.io/siddhi-io-kafka/api/latest/#kafka-source)                      |
| googlepubsub  | [googlepubsub](https://siddhi-io.github.io/siddhi-io-googlepubsub/api/latest/#googlepubsub-source) |
| RabbitMQ      | [rabbitmq](https://siddhi-io.github.io/siddhi-io-rabbitmq/api/latest/#rabbitmq-source)             |
| JMS           | [JMS](https://siddhi-io.github.io/siddhi-io-jms/api/latest/#jms-source)                            |
| MQTT          | [MQTT](https://siddhi-io.github.io/siddhi-io-mqtt/api/3.0.0/#mqtt-source)                          |
| SQS           | [sqs](https://siddhi-io.github.io/siddhi-io-sqs/api/latest/#source)                                |

### Supported mappers

Mappers determine the format in which the event is received. For information about transforming events by changing the format in which the data is received/published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data#transforming-message-formats).

The following are the supported mappers when you receive data from messaging systems.

| **Mapper** | **Supporting Siddhi Extension**                                                        |
|---------------|----------------------------------------------------------------------------------------|
| `json`        | [json](https://siddhi-io.github.io/siddhi-map-json/api/latest/#sinkmapper)             |
| `xml`         | [xml](https://siddhi-io.github.io/siddhi-map-xml/api/latest/#sinkmapper)               |
| `text`        | [text](https://siddhi-io.github.io/siddhi-map-text/api/latest/#sinkmapper)             |
| `avro`        | [avro](https://siddhi-io.github.io/siddhi-map-avro/api/latest/#sinkmapper)             |
| `binary`      | [binary](https://siddhi-io.github.io/siddhi-map-binary/api/latest/#binary-sink-mapper) | 