# Transforming Data

The Streaming Integrator allows you to perform a wide range of transformations to the input data received. A main type of transformation supported is transforming a message from one format to another. In addition, you can perform a range of mathematical, regex, string, unit conversion, map, json, etc., transformations via [Siddhi Extensions](https://siddhi.io/en/v5.1/docs/extensions/). You can also write a custom script to perform an required transformation of data.

## Transforming message formats

WSO2 Streaming Integrator can transform message formats when it consumes data as well as when it publishes data.

### Transforming the message format when consuming data

Data publishers, databases, files, and messaging systems send data to WSO2 Streaming Integrator in different data formats. Therefore, WSO2 Streaming Integrator has the capability to consume data in a range of formats. Once it receives the data in a specific format, it can convert it to a different format for processing purposes.

The Streaming Integrator can consume events in the default format in which they are sent/extracted or make changes to it to match the event schema as defined via the input stream.

- **Consuming messages in a default format**

    Consuming messages via WSO2 Streaming Integrator by configuring Siddhi sources is explained in [Extracting Data From Static Sources in Real Time]({{base_path}}/use-cases/streaming-usecase/extracting-data-from-static-sources-in-real-time) and [Receiving Data in Trasit]({{base_path}}/use-cases/streaming-usecase/receiving-data-in-transit).
    
    To receive data in a specific format, you need to annotate a mapper to the source configuration via the @map annotation. For more information, see [Siddhi Query Guide - Source Mapper](https://siddhi.io/en/v5.1/docs/query-guide/#source-mapper).
    
    To understand how to do this, consider factory where production bots publish the production amounts in a file. The the file contains rows in the CSV format. Therefore, WSO2 Streaming Integrator needs to consume the records in that format. Therefore, the source and the mapper can be configured as shown below.
    
    ```
    @source(type='file', mode='LINE',
        file.uri='file:/Users/foo/productions.csv',
        tailing='true',
        @map(type='csv'))
    define stream SweetProductionStream (name string, amount double);
    ```
    Here, in the `@map` annotation, `csv` is specified as the mapping type.
    
- **Consuming messages in a custom format**

    Custom mapping is performed when the schema of the event received needs to be updated to match the schema of the input stream.
    
    For this scenario, let's consider an example where the production bots are publishing messages via an HTTP sender in the JSON format, and as shown in the following example.
    
    ```json    
    {
      "sweet": "Jaffa Cake",
      "batch": {
        "batch id": "batch1",
        "count": 10
      }
    }
    ```
  
    The event stream is as follows:
    
    `define stream SweetProductionStream (name string, amount double);`
    
    In the given JSON event, the value for the `name` attribute is received with the `sweet` label, and the value for the `amount` attribute is published with the `count` label that is nested under `batch`. 
    
    In this example, you can use custom mapping to derive the required data from the JSON event using JSON expressions.
    
    | **Stream Attribute Name** | **JSON Event Attribute Name** | **JSON Path Expression** |
    |---------------------------|-------------------------------|--------------------------|
    | `name`                    | `sweet`                       | `$.sweet`                |
    | `amount`                  | `count`                       | `$.batch.count`          |
    
    Now you can include an attribute configuration within the mapping configuration based on the JSON path expressions you identified as shown below.
    
    ```
    @source(type='http', 
        receiver.url='http://localhost:5005/SweetProductionEP', 
        @map(type = 'json', 
            @attributes(name = '$.sweet', amount = '$.batch.count')))
    define stream SweetProductionStream (name string, amount double);
    ```
    The attributes configuration is annotated via the `@attributes` annotation within the `@map` annotation.

### Transforming the message format when publishing data

The different destinations to which you need to publish data via WSO2 Streaming Integrator accept data in different formats. Therefore, WSO2 Streaming Integrator supports publishing in a range of formats.

WSO2 Streaming Integrator can publish messages in the default format or in a custom format. 

- **Publishing messages in default format**

    To understand this, consider a scenario where you receive production information in the JSON format, but you need to publish that information in a file in the XML format.
    
    To do this, you can define your output [stream](https://siddhi.io/en/v5.1/docs/query-guide/#stream) and connect a [sink](https://siddhi.io/en/v5.1/docs/query-guide/#sink) to it with a [mapper](https://siddhi.io/en/v5.1/docs/query-guide/#sink-mapper) of the `xml` type. as shown below.
    
    ```
    @sink(type = 'file', 
        file.uri = "file:/Users/foo/productions.csv",
        @map(type = 'xml'))
    define stream OutputStream (name string, amount double);
    ```
    Here, you have included the `@map` annotation within the `@sink` annotation and specified the mapping type as `xml` so that the WSO2 Streaming Integrator can publish the output in XML format.
    
- **Publishing messages in custom format**

    The schema of the event accepted by the destination to which you are sending your output can be different to the schema of your input event or the schema of the event at the time you were processing it. Therefore, WSO2 Streaming Integrator allows you to perform custom mapings when you publish the output. The custom mapping needs to be annotated to the mapping configuration via the `@payload` annotation.
    
    To understand this, consider the example of a sweet factory that needs to send it's production report to the factory manager. The output stream in which the output is generated after processing can be as follows:
    
    ```
    define stream SweetProductionStream (name string, amount double);
    ```
    A sample JSON event that is published from the above schema without any custom mapping is as shown in the example below:
    
    ```json
    {
        "event":{
            "name":gingerbread,
            "amount":100
        }
    }
    ```
  
    However, the head office system expects to receive the event in the following format.
    
    ```json
    {"Product":{
        "ProductionData":{
            "Name":gingerbread,
            "Quantity":100
          }
      }
    }
    ```
  
    To achieve this, the sink connected to the output event stream needs to have a mapping configuration defined within it as shown below.
    
    ```
    @sink(type='inMemory', 
        topic='{{production}}', 
        @map(type='json', 
            enclosing.element='$.Product', 
            validate.json='true', 
            @payload( """{"ProductionData":{"Name":"{{name}}","Quantity":{{amount}}}}""")))
    define stream SweetProductionStream (name string, amount double);
    ```
  
    In the above example, the mapping type the JSON. The `@payload` annotation encloses a JSON string that defines the custom mapping. The values for `name` and `amount` attributes in the stream are presented as `Name` and `Quantity` respectively. These are nested under `ProductionData` which is turn is enclosed in the `Product` enclosing element as per the required format.

## Transforming with inline operators

WSO2 Streaming Integrator is shipped with inline operators that allow you to do certain transformations to streaming data without downloading additional Siddhi extensions from the Siddhi store.

For example, assume that instead of the amount produced during the specific production run, you need to present the total amount produced for the given product with each production run as well as the average. For this, you can write a query as follows:

```
define stream SweetProductionStream (name string, amount double);

@info(name = 'Calculate Total and Average')
from SweetProductionStream 
select name, amount, sum(amount) as total, avg(amount) as average 
group by name
insert into ProductionTotalsStream;
```

In this example, the input event that reports only the name of the product and the amount produced is transformed into an output event that reports the product name, amount produced, the total produced for the given product, and the average produced per production run for the given product. The `group by` clause ensures that the calculations are done per product name. The `sum()` and `avg()` inline operators calculate the total and the average recpectively.

## Transforming with supported Siddhi extensions

When you want to perform more advanced transformations that are not supported by the inline operators of the WSO2 Streaming Integrator, you can use one or more of the Siddhi extensions from the [Siddhi Store](https://store.wso2.com/store/assets/analyticsextension/list).

Some of these extensions are shipped with the WSO2 Streaming Integrator by default. If you want to use a Siddhi extension that is not shipped by default, you need to download and install it following the instructions in [Downloading and Installing Siddhi Extensions]({{base_path}}/streaming/connectors/downloading-and-installing-siddhi-extensions).

The following table describes the complete list of extensions that provide data transformation functionality.

| **Extension** | **Description** |
|----------------------------------|---------------------------------------------------------------------------|
| [Siddhi-execution-math](https://siddhi-io.github.io/siddhi-execution-math/) | Transforms data by performing mathematical operations. |
| [Siddhi-execution-unitconversion](https://siddhi-io.github.io/siddhi-execution-unitconversion/) | Performs unit conversions ranging from length, weight, volume, etc. |
| [Siddhi-execution-string](https://siddhi-io.github.io/siddhi-execution-string/) | Performs string manipulations. |
| [Siddhi-execution-time](https://siddhi-io.github.io/siddhi-execution-time/)| Performs time-based transformations such as converting time zones. |
| [Siddhi-execution-map](https://siddhi-io.github.io/siddhi-execution-map/)| Converts events into maps and performs transformations such as concatenating and removing attributes. |
| [Siddhi-execution-reorder](https://siddhi-io.github.io/siddhi-execution-reorder/) | Rearranges the order of the incoming event flow. |
| [Siddhi-execution-json](https://siddhi-io.github.io/siddhi-execution-json/) | Performs manipulations to JSON strings. |

## Writing a custom script to transform data

To write a custom script to transform data, you can use the [siddhi-script-js](https://siddhi-io.github.io/siddhi-script-js/) Siddhi extension.

For example, if the Sweet Factory wants to check whether the production amount reported in a production run is greater than the average production up to that production run, you can write a custom function shown in the following sample query.

```
from ProductionTotalsStream 
select name, amount, total, average, js:eval("amount > average", 'bool') as exceedsAverage
group by name 
insert into MonitorProductionTrendStream;
```

Here, `js:eval("amount > average", 'bool') as exceedsAverage` is a custom function where an attribute named `exceedsAverage` returns the value `true` or `false` depending on whether the value for the `amount` attribute exceeds the value for the `average` attribute.

## Try it out

To try out the transformations described above with some of the given examples, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

2. Open a new file. Then add and save the following Siddhi application.

    ```
    @App:name('ProductionTotalsApp')
    @App:description('Transform Production Statistics')
    
    @source(type = 'http', receiver.url = "http://localhost:5005/SweetProductionEP",
        @map(type = 'json',
            @attributes(amount = "$.batch.count", name = "$.sweet")))
    define stream SweetProductionStream (name string, amount double);
    
    @sink(type = 'file', file.uri = "file:/Users/foo/productions.json",
        @map(type = 'json', validate.json = "false", enclosing.element = "$.Product",
            @payload("""{"ProductionData":{"Name":"{{name}}","Quantity":"{{amount}}","Total":{{total}},"Average":{{average}}}}""")))
    define stream ProductionTotalsStream (name string, amount double, total double, average double);
    
    @sink(type = 'log', prefix = "Exceeds Average",
        @map(type = 'text'))
    define stream MonitorProductionTrendStream (name string, exceedsAverage bool);
    
    @info(name = 'Calculate Total and Average')
    from SweetProductionStream 
    select name, amount, sum(amount) as total, avg(amount) as average 
        group by name 
    insert into ProductionTotalsStream;
    
    @info(name = 'Compare with Average')
    from ProductionTotalsStream 
    select name, js:eval("('amount' > 'average')", 'bool') as exceedsAverage
    group by name 
    insert into MonitorProductionTrendStream;
    ```
   
   This Siddhi application does the following transformations:
   
   - Derives the values for `name` and `amount` attributes representing the name of the product and the amount produced. This is derived from input events sent is a custom format where the two required values are provided under the `Sweet` and `count` attributes, and the `count` attribute is nested under another attribute named `batch`.
   
   - Publishes the production statistics in a custom format. `name` and `amount` attributes are presented as `Name` and `Quantity`, and nested under `ProductionData` in the `Product` enclosing element. These events are published in the `Users/foo/productions.json` file.
   
        !!! tip
            You can save the `productions.json` file mentioned above in a different location of your choice if required.
   
   - Calculates the total production amount and the average production amount per sweet, and presents them as values for the `total` and `average` attributes in the output event published in the `productions.json` file.
   
   - Uses a custom script to check whether the amount produced of a sweet in the production run is greater than the average production for that sweets, and logs `true` or `false` in the terminal in the text format.
   
3. To simulate events for this Siddhi application, issue the following six CURL commands.

    ```
    curl -X POST \
      http://localhost:5005/SweetProductionEP \
      -H 'content-type: application/json' \
      -d '{
      "sweet": "Jaffa Cake",
      "batch": {
        "batch id": "batch1",
        "count": 10
      }
    }'
    ``` 
   
    ```
    curl -X POST \
    http://localhost:5005/SweetProductionEP \
    -H 'content-type: application/json' \
    -d '{
    "sweet": "Gingerbread",
    "batch": {
     "batch id": "batch1",
     "count": 65
    }
    }'
    ``` 
     
    ```
    curl -X POST \
     http://localhost:5005/SweetProductionEP \
     -H 'content-type: application/json' \
     -d '{
     "sweet": "Jaffa Cake",
     "batch": {
       "batch id": "batch1",
       "count": 15
     }
    }'
    ``` 
   
    ```
    curl -X POST \
    http://localhost:5005/SweetProductionEP \
    -H 'content-type: application/json' \
    -d '{
    "sweet": "Gingerbread",
    "batch": {
     "batch id": "batch1",
     "count": 55
    }
    }'
    ``` 
      
    ```
    curl -X POST \
    http://localhost:5005/SweetProductionEP \
    -H 'content-type: application/json' \
    -d '{
    "sweet": "Jaffa Cake",
    "batch": {
      "batch id": "batch1",
      "count": 25
    }
    }'
    ``` 
   
    ```
    curl -X POST \
    http://localhost:5005/SweetProductionEP \
    -H 'content-type: application/json' \
    -d '{
    "sweet": "Gingerbread",
    "batch": {
      "batch id": "batch1",
      "count": 45
    }
    }'
    ``` 
    
4. Open the `Users/foo/productions.json` file. The following content is available in it.

    ```json
    {"Product":{"ProductionData":{"Name":"Jaffa Cake","Quantity":"10.0","Total":10.0,"Average":10.0}
    {"Product":{"ProductionData":{"Name":"Gingerbread","Quantity":"65.0","Total":65.0,"Average":65.0}
    {"Product":{"ProductionData":{"Name":"Jaffa Cake","Quantity":"15.0","Total":25.0,"Average":12.5}
    {"Product":{"ProductionData":{"Name":"Gingerbread","Quantity":"55.0","Total":120.0,"Average":60.0}
    {"Product":{"ProductionData":{"Name":"Jaffa Cake","Quantity":"25.0","Total":50.0,"Average":16.666666666666668}
    {"Product":{"ProductionData":{"Name":"Gingerbread","Quantity":"45.0","Total":165.0,"Average":55.0}
    ```

5. Check the Streaming Integrator Tooling terminal. The following is logged in it.

    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Exceeds Average : name:"Jaffa Cake",
    exceedsAverage:false
    ```
   
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Exceeds Average : name:"Gingerbread",
    exceedsAverage:false
    ```
   
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Exceeds Average : name:"Jaffa Cake",
    exceedsAverage:true
    ```
   
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Exceeds Average : name:"Gingerbread",
    exceedsAverage:false
    ```
   
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Exceeds Average : name:"Jaffa Cake",
    exceedsAverage:true
    ```
   
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Exceeds Average : name:"Gingerbread",
    exceedsAverage:false
    ```