# Publishing Data

## Introduction
Once information is processed by the Streaming Integrator, the output is presented as events in a streaming manner. 
This output can be published to databases, files, cloud-based applications or other streaming applications.

For the Streaming Integrator to publish events, the following is required.

* A message schema: The messages selected to be published by a streaming integration flow are identified by their 
schemas. This schema is defined via an output stream definition. 

* A sink: The output can be published to different interfaces including streaming applications, cloud-based applications,
 databases, and files. There are different sink types to support the different interfaces. The output can also be published in a range of formats. In order to select the required interface and format for a specific streaming integration flow, you need to configure a sink in the relevant Siddhi application via the `@sink` annotation.
 
   ![Publishing events](../images/publishing-messages/Publish-Messages-Flow.png)
 
 As shown in the image above, a sink configuration consists of three parts.
 
      |**Annotation**       |**Description**                                                                                  |
      |---------------------|-------------------------------------------------------------------------------------------------|
      |**`@sink`**          |This annotation defines the sink type via which the data is published, and allows you to configure the sink parameters (which change depending on the sink type). For the complete list of supported sink types, see [Siddhi Query Guide - Sink](https://siddhi.io/en/v4.x/docs/query-guide/#sink).|
      |**`@map`**           |This annotation specifies the format in which the data is published, and allows you to configure the mapping parameters (which change based of the mapping type/format selected). For the complete list of supported mapping types, see [Siddhi Query Guide - Sink Mapper](https://siddhi.io/en/v4.x/docs/query-guide/#sink-mapper).|
      |**`@attributes`**    |This annotation specifies a custom mapping based on which events in the streaming integration flow that need to be published are identified. This is useful when the attributes of the output messages you want the Streaming Integrator to publish are different to the corresponding attribute name in the stream definition. e.g., In a scenario where the Streaming Integrator is publishing the average temperature per second, the temperature can be referred to as  `avgTemp` in the output stream definition in your Siddhi application. However, you want to publish it with the `Temperature` to the streaming application to which you are publishing. In this instance, you need a custom mapping to indicate that `Temperature` is the same as `avgTemp`.|
   

## Publishing data using an event sink
This section explains how to configure a basic sink without mapping. A Siddhi application can contain a sink configuration inline, or refer to a sink configuration that is defined externally in a configuration file.


#### Defining event sink inline in the Siddhi application

To create a Siddhi application with the sink configuration defined inline, follow the steps below.

1. Open the Streaming Integrator Tooling and start creating a new Siddhi application. For more information, see [Creating a Siddhi Application](../develop/creating-a-Siddhi-Application.md).

2. Enter a name for the Siddhi application as shown below.<br/>
   `@App:name("<Siddhi_Application_Name>)`<br/>e.g., `@App:name("SalesTotalsApp")`<br/>
   
3. Define the output stream based on the schema in which you want to publish data. The format is as follows. <br/>
   `define stream <Stream_Name>(attribute1_name attribute1_type, attribute2_name attribute2_type, ...);`
   
   e.g., 
   `define stream PublishSalesTotalsStream (transNo int, product string, price int, quantity int, salesValue long);`
   
4. Connect a sink to the stream definition you added as follows.
    ```
    @sink(type='<SINK_TYPE>')
    define stream <Stream_Name>(attribute1_name attribute1_type, attribute2_name attribute2_type, ...);
    ```
    
    Here, the sink type needs to be selected based on the interface to which you want to publish the output. For more information, see [Supported sink types](#supported-event-sink-types).
    
    e.g., If you want to publish the output as logs in the console, you can add a sink with `log` as the type.
    ```
    @sink(type='log')
    define stream PublishSalesTotalsStream (transNo int, product string, price int, quantity int, salesValue long);
    ```
    
5. Add and configure parameters related to the sink type you selected as shown below.
    ```
    @sink(type='<SINK_TYPE>', <PARAMETER1_NAME>='<PARAMETER1_VALUE>', ...)
    define stream <Stream_Name>(attribute1_name attribute1_type, attribute2_name attribute2_type, ...);
    ```
    
    e.g., By adding a parameter named `prefix` to the log sink used as an example in the previous step, you can specify a prefix with which you want to see the output logs printed.
    ```
    @sink(type='log', prefix='Sales Totals:')
    define stream PublishSalesTotalsStream (transNo int, product string, price int, quantity int, salesValue long);
    ```
    
6. Now let's complete adding the required Siddhi constructs to receive and process the input data.

    1. Add an input stream with a connected source configuration as shown below. For more information, see the [Consuming Data guide](consuming-messages.md).

        e.g., Assuming that the schema of the input events are same as that of the output events, and that they are received via HTTP, you can add the input stream definition
       ```
       @source(type='http', receiver.url='http://localhost:5005/SweetProductionEP')
       define stream ConsumeSalesTotalsStream (transNo int, product string, price int, quantity int, salesValue long);
       ```
       
    2. Add a query to get the received events from the input stream and direct them to the output stream as follows.
    
        ```
        from <INPUT_STREAM_NAME>
        select <ATTRIBUTE1_Name>, <ATTRIBUTE2_NAME>, ... 
        group by <ATTRIBUTE_NAME>
        insert into <OUTPUT_STREAM_NAME>;
        ```
        
        e.g., Assuming that you are publishing the events with the existing values as logs in the output console without any further processing, you can define the query as follows.
        
        ```
        from ConsumeSalesTotalsStream
        select *
        group by product
        insert into PublishSalesTotalsStream;
        ``` 
   
7. Save the Siddhi Application.


#### Defining event sink externally in the configuration file
If you want to use the same sin k configuration in multiple Siddhi applications, you  can define it externally in the 
`<SI_HOME>/conf/server/deployment.yaml` file and then refer to it from Siddhi applications. To understand how to do this, 
follow the procedure below.

1. Open the `<SI_HOME>/conf/server/deployment.yaml` file.

2. Add a section named `siddi`, and then add a subsection named `refs:` as shown below.
    ```   
    siddhi:  
     refs:
      -
    ```
    
3. In the `refs` subsection, enter a parameter named `name` and enter a name for the sink.
    ```   
    siddhi:  
     refs:
      -
       name:`<SINK_NAME>`
    ```
    
4. To specify the sink type, add another parameter named `type` and enter the relevant sink type.
    ```
    siddhi:  
     refs:
      -
       name:'<SINK_NAME>'
       type: '<SINK_TYPE>'
    ```
    
5. To configure other parameters for the sink (based on the sink type), add a subsection named `properties` as shown below.
    ```
    siddhi:  
     refs:
      -
       name:'SINK_NAME'
       type: '<SINK_TYPE>'
       properties
           <PROPERTY1_NAME>:'<PROPERTY1_VALUE>'
           <PROPERTY2_NAME>:'<PROPERTY2_VALUE>'
           ...
    ```
    
6. Save the configuration file.

e.g., The log sink used as the example in the previous section can be defined externally as follows:
```
    siddhi:  
     refs:
      -
       name:'LogSink'
       type: 'log'
       properties
           prefix:'Sales Totals'
```

## Supported event sink types

The supported event sink types are as follows:

|**Source Category**        |**Supported Extensions**           |
|---------------------------|-----------------------------------|
|Streaming Messaging Systems| - [io-nats](https://siddhi-io.github.io/siddhi-io-nats/)<br/> - [io-kafka](https://siddhi-io.github.io/siddhi-io-kafka/)<br/> - [io-tcp](https://siddhi-io.github.io/siddhi-io-tcp/)<br/> - [io-jms](https://siddhi-io.github.io/siddhi-io-jms/)<br/> - [io-rabbitmq](https://siddhi-io.github.io/siddhi-io-rabbitmq/)<br/> - [io-mqtt](https://siddhi-io.github.io/siddhi-io-mqtt/)<br/> - [io-sqs](https://siddhi-io.github.io/siddhi-io-sqs/)<br/> - [io-grpc](https://siddhi-io.github.io/siddhi-io-grpc/)|
|Software and Sensors       | - [io-http](https://siddhi-io.github.io/siddhi-io-http/)<br/> - [io-email](https://siddhi-io.github.io/siddhi-io-email/)<br/> - [io-grpc](https://siddhi-io.github.io/siddhi-io-grpc/)|
|Cloud                      | - [io-googlepubsub](https://siddhi-io.github.io/siddhi-io-googlepubsub/)<br/> - [io-s3](https://siddhi-io.github.io/siddhi-io-s3/)<br/> - [io-gcs](https://siddhi-io.github.io/siddhi-io-gcs/api/latest/)|
|Databases                  | - [io-prometheus](https://siddhi-io.github.io/siddhi-io-prometheus/)<br/>|
|Files                      | - [io-file](https://siddhi-io.github.io/siddhi-io-file/)|

## Supported event formats

You can publish messages in any of the following formats via the relevant Siddhi extensions. Click on the format for more details about the Siddhi extension.

- [JSON](https://siddhi-io.github.io/siddhi-map-json/)
- [XML](https://siddhi-io.github.io/siddhi-map-xml/)
- [Text](https://siddhi-io.github.io/siddhi-map-text/)
- [Avro](https://siddhi-io.github.io/siddhi-map-avro/)
- [KeyValue](https://siddhi-io.github.io/siddhi-map-keyvalue/)
- [CSV](https://siddhi-io.github.io/siddhi-map-csv/)
- [Binary](https://siddhi-io.github.io/siddhi-map-binary/)
- [Protocol Buffers](https://siddhi-io.github.io/siddhi-map-protobuf/)

#### Publishing data in default format

SI publishes events in default format when it does not make any changes to the attribute names in the output stream 
before publishing. To understand how this is done, follow the procedure below:

1. Create a Siddhi application with a sink configuration following the instructions in the [Defining event sink inline in the Siddhi application](#defining-event-sink-inline-in-the-siddhi-application) section.

2. Add an `@map` annotation with the mapping type to the sink configuration as shown below.
    ```
    @sink(type='<SINK_TYPE>', @map(type='MAP_TYPE'))
    define stream <Stream_Name>(attribute1_name attribute1_type, attribute2_name attribute2_type, ...);
    ```
    
    The map type specifies the format in which the events are published. e.g., In the example that you used, you can 
    specify the output logs to be printed in the text format by specifying `text` as the mapping type.
    
    ```
    @sink(type='log', prefix='Sales Totals:', @map(type=text))
    define stream PublishSalesTotalsStream (transNo int, product string, price int, quantity int, salesValue long);
    ```
    
3. Save the Siddhi application. If you save the Siddhi application that was created using the example configurations, 
the completed Siddhi application is as follows.
    ```
    @App:name("SalesTotalsApp")
    @App:description("Description of the plan")
    
    @source(type='http', receiver.url='http://localhost:5005/SalesTotalsEP', @map(type='json'))
    define stream ConsumerSalesTotalsStream(transNo int, product string, price int, quantity int, salesValue long);
    
    @sink(type='log', prefix='Sales Totals:', @map(type=text))
    define stream PublishSalesTotalsStream (transNo int, product string, price int, quantity int, salesValue long);
    
    from ConsumerSalesTotalsStream
    select transNo, product, price, quantity, salesValue
    group by product
    insert into PublishSalesTotalsStream;
    ```


#### Publishing data in custom format

SI publishes data in the custom format when it makes changes to the attribute names in the output stream before 
publishing. To understand how this is done, follow the procedure below:

!!!info
    In this section, you can update the same Siddhi application that you saved in the [Publishing data in default format](#publishing-a-message-in-default-format) section.
    
1. Open your Siddhi application with a sink configuration.

2. Within the `@map` annotation of the sink configuration, add an `@payload` annotation. There are two ways to configure this as follows:

    + Some mappers such as `xml`, `json`, and `text` accept only one output payload using the following format: 
        `@payload( '<PAYLOAD>' )`
        
     e.g., In the example, the mapping type is `text`. Therefore, you can add a message to be printed with the output by configuring the `@payload` annotation as follows.
     
     ```
    @payload( 'This is a test message from {{user}}.' )
     ```
     
    + Some mappers such as `key-value` accept series of mapping values defined as follows: 
        `@payload( key1='mapping_1', 'key2'='user : {{user}}') `
        
3. Save the Siddhi application.