# Publishing Data

This guide covers how WSO2 Streaming Integrator publishes data to destinations and messaging systems.

## Publishing data to destinations

Publishing to destinations involve using transports such as HTTP, TCP, email, etc., where the data is sent to an endpoint that is available to listen to messages and respond. 

![Publishing to destinations]({{base_path}}/assets/img/streaming/publishing-data/publishing-to-destination.png)

To understand this, consider a warehouse that needs to publish each stock update to a specific endpoint so that the stock can be monitored by the warehouse manager. To address this requirement via the WSO2 Streaming Integrator, you can define an output [stream](https://siddhi.io/en/v5.1/docs/query-guide/#stream) and connect a [sink](https://siddhi.io/en/v5.1/docs/query-guide/#sink) to it as shown below. In this example, let's use an HTTP sink.

```
@sink(type = 'http', publisher.url = 'http://stocks.com/stocks',
      @map(type = 'json'))
define stream StockStream (symbol string, price float, volume long);
```

The above sink configuration publishes all the events in the `StockStream` output stream to the `http://stocks.com/stocks` HTTP URL in JSON format.

### Try it out

To try out the above example, follow the steps below:

1. [Start and access WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).
   
2. Open a new file and copy the following Siddhi Application to it.

    ```
    @App:name("PublishStockUpdatesApp")  
   
    define stream InputStream (symbol string, price float, volume long);
    
    @sink(type = 'http', publisher.url = 'http://localhost:5005/stocks',
          @map(type = 'json'))
    define stream StockStream (symbol string, price float, volume long);
    
    from InputStream
    select *
    insert into StockStream;
    ```
   
   Save the Siddhi application.
   
   This Siddhi application publishes stock updates as HTTP events via the `http` sink in the previous example.
   
3. To monitor whether the HTTP events generated via the `PublishStockUpdatesApp` Siddhi application are getting published to the `http://localhost:5005/stocks` URL as specified, create and save another Siddhi Application as follows:

    ```
    @App:name('ListenToStockUpdatesApp')
    
    @source(type = 'http', receiver.url = "http://localhost:5005/stocks",
    	@map(type = 'json'))
    define stream StockStream (symbol string, price float, volume long);
    
    @sink(type = 'log', prefix = "Stock Updates",
    	@map(type = 'passThrough'))
    define stream OutputStream (symbol string, price float, volume long);
    
    @info(name = 'query1')
    from StockStream 
    select * 
    insert into OutputStream;
    ```
   
    This Siddhi application listens for events in the `http://localhost:5005/stocks` endpoint and logs them in the Streaming Integrator Tooling console.
    
4. Start both the Siddhi applications. To do this, open each siddhi application and click the **Play** icon.

    ![Play]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/play.png)
    
5. Simulate an event with the following values for the `InputStream` stream of the `PublishStockUpdatesApp` Siddhi application. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).

    | **Attribute** | **Value** |
    |---------------|-----------|
    | **symbol**    | `ABC`     |
    | **price**     | `100`     |
    | **volume**    | `20`      |
    
    As a result, the `ListenToStockUpdates` Siddhi applications prints the following log in the Streaming Integrator Tooling Console.
    
    ```
    [2020-10-28_10-59-20_463] INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Updates : Event{timestamp=1603862960462, data=[ABC, 100.0, 20], isExpired=false} 
    ```

### Supported transports

WSO2 Streaming Integrator supports the following transport types to send messages to destinations.

| **Transport** | **Supporting Siddhi Extension**                                       |
|---------------|-----------------------------------------------------------------------|
| `http`        | [http](https://siddhi-io.github.io/siddhi-io-http/api/latest/#sink)   |
| `tcp`         | [tcp](https://siddhi-io.github.io/siddhi-io-tcp/api/latest/#sink)     |
| `email`       | [email](https://siddhi-io.github.io/siddhi-io-email/api/latest/#sink) |
| `grpc`        | [grpc](https://siddhi-io.github.io/siddhi-io-grpc/api/latest/#sink)   |
| `Thrift`      |                                                                       |

### Supported mappers

Mappers determine the format in which the event is published. For information about transforming events by changing the format in which the data is published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data#transforming-the-message-format-when-publishing-data).

The following are the supported mappers when you publish data to destinations.

| **Transport** | **Supporting Siddhi Extension**                                                        |
|---------------|----------------------------------------------------------------------------------------|
| `json`        | [json](https://siddhi-io.github.io/siddhi-map-json/api/latest/#sinkmapper)             |
| `xml`         | [xml](https://siddhi-io.github.io/siddhi-map-xml/api/latest/#sinkmapper)               |
| `text`        | [text](https://siddhi-io.github.io/siddhi-map-text/api/latest/#sinkmapper)             |
| `avro`        | [avro](https://siddhi-io.github.io/siddhi-map-avro/api/latest/#sinkmapper)             |
| `binary`      | [binary](https://siddhi-io.github.io/siddhi-map-binary/api/latest/#binary-sink-mapper) |                                                                   |
    
## Publishing data to messaging systems

WSO2 Streaming Integrator allows you to publish data to messaging systems such as Kafka, JMS, NATS, GooglePubSub, etc. so that you can expose streaming data to applications that cannot read streaming data, but are able to subscribe for data in messaging systems.

![Publishing to messaging systems]({{base_path}}/assets/img/streaming/publishing-data/publishing-to-message-broker.png)

To understand this, consider a scenario where temperature readings from a sensor are published into a Kafka topic so that other devices that need to consume that data can subscribe for it. You can address this requirement via WSO2 Streaming Integrator by defining an output [stream](https://siddhi.io/en/v5.1/docs/query-guide/#stream) and then connecting a [sink](https://siddhi.io/en/v5.1/docs/query-guide/#sink) to it as shown in the example below.

```
@sink(type = 'kafka', bootstrap.servers = "localhost:9092", topic = "temperature",
	@map(type = 'json'))
define stream PublishTemperatureStream (temperature int);
```

The above sink configuration of the `kafka` type publishes all the events in the `PublishTemperatureStream` stream to a Kafka topic named `temperature` running in the `localhost:9092` server. The messages are published in `json` format.

### Try it out

To try out the example in the previous subtopic, follow the steps below:

1. Download the Kafka broker from [the Apache site](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.3.0/kafka_2.12-2.3.0.tgz) and extract it.
   This directory is referred to as `<KAFKA_HOME>` from here on.
   
2. Start Kafka as follows:

    1. First, start a zoo keeper node. To do this, navigate to the `<KAFKA_HOME>` directory and issue the following command.
    
        `sh bin/zookeeper-server-start.sh config/zookeeper.properties`
    
    2. Next, start a Kafka server node. To do this, issue the following command from the same directory.
    
        `sh bin/kafka-server-start.sh config/server.properties`
        
    3. To create a Kafka topic named `temperature`, issue the following command from the same directory.
    
        `bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic temperature`
        
3. Prepare WSO2 Streaming Integrator Tooling to publish data to a Kafka topic as follows:

    1. Start and access [WSO2 Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview). 
    
    2. Download and install the Kafka extension to it. For instructions, see [Installing Siddhi Extensions]({{base_path}}/develop/streaming-apps/installing-siddhi-extensions).
    
    3. Open a new file and add the following Siddhi application to it.

        ```
        @App:name('TemperaturePublishingApp')
        
        @sink(type = 'kafka', bootstrap.servers = "localhost:9092", topic = "temperature",
            @map(type = 'json'))
        define stream PublishTemperatureStream (temperature int);
        
        define stream TemperatureStream (temperature int);
        
        from TemperatureStream 
        select * 
        insert into PublishTemperatureStream;
        ```
       Save the Siddhi application.
       
       The above Siddhi application includes the sink configuration from the previous example. The Siddhi query takes all the input events in the `TemperatureStream` stream and inserts them into the `PublishTemperatureStream` stream so that they can be published to the `temperature` Kafka topic via the connected source.
       
    4. Start the Siddhi application by clicking the **Play** icon in the top panel for it.
    
        ![Play]({{base_path}}/assets/img/streaming/extracting-data-from-static-sources/play.png)
        
    5. Simulate an event for the `TemperatureStream` stream of the `TemperaturePublishingApp` Siddhi application. In this example, let's enter `30` as the value for the `temperature` attribute.

        For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).
        
    6. To retrieve the events published to the Kafka topic, issue the following command from `<KAFKA_HOME>`
    
        ```
        bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic temperature --from-beginning
        ```
              
        You can see the following in the Kafka consumer log.
        
        ![Kafka Log]({{base_path}}/assets/img/streaming/publishing-data/kafka-log.png)
        
### Supported messaging systems

WSO2 Streaming Integrator allows you to publish messages to the following messaging system via Siddhi extentions.

| **Transport**    | **Supporting Siddhi Extension**                                                       |
|------------------|---------------------------------------------------------------------------------------|
| `kafka`          | [kafka](https://siddhi-io.github.io/siddhi-io-kafka/api/latest/#sink)                 |
| `NATS`           | [NATS](https://siddhi-io.github.io/siddhi-io-nats/api/latest/#sink)                   |
| `Google Pub/Sub` | [Google Pub/Sub](https://siddhi-io.github.io/siddhi-io-googlepubsub/api/latest/#sink) |
| `rabbitmq`       | [rabbitmq](https://siddhi-io.github.io/siddhi-io-rabbitmq/api/latest/#sink)           |
| `jms`            | [jms](https://siddhi-io.github.io/siddhi-io-jms/api/latest/#sink)                     |
| `mqtt`           | [mqtt](https://siddhi-io.github.io/siddhi-io-mqtt/api/latest/#sink)                   |
| `sqs`            | [sqs](https://siddhi-io.github.io/siddhi-io-sqs/api/latest/#sink)                     |

### Supported mappers

Mappers determine the format in which the event is published. For information about transforming events by changing the format in which the data is published, see [Transforming Data]({{base_path}}/use-cases/streaming-usecase/transforming-data#transforming-the-message-format-when-publishing-data).

The following are the supported mappers when you publish data to destinations.

| **Transport** | **Supporting Siddhi Extension**                                                        |
|---------------|----------------------------------------------------------------------------------------|
| `json`        | [json](https://siddhi-io.github.io/siddhi-map-json/api/latest/#sinkmapper)             |
| `xml`         | [xml](https://siddhi-io.github.io/siddhi-map-xml/api/latest/#sinkmapper)               |
| `text`        | [text](https://siddhi-io.github.io/siddhi-map-text/api/latest/#sinkmapper)             |
| `avro`        | [avro](https://siddhi-io.github.io/siddhi-map-avro/api/latest/#sinkmapper)             |
| `binary`      | [binary](https://siddhi-io.github.io/siddhi-map-binary/api/latest/#binary-sink-mapper) |   
        
        
