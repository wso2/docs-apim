# Processing Data

Processing data involves making changes to data to generate a required output. WSO2 Streaming Integrator allows you to carry out a wide range of operations to process streaming data. These operations are supported via [Siddhi Extensions](https://siddhi.io/en/v5.1/docs/extensions/). These operations can be broadly categorized into five categories as follows:

- Cleansing
- Transforming
- Enriching
- Aggregating
- Correlating

## Cleansing data

When you receive input data via the Streaming Integrator, it may consist of data that is not required to generate the required output, null values for certain attributes, etc. Cleansing data refers to refining the input data received by assigning values where there are missing values (if there are applicable values), filtering out the data that is not required, etc.

### Filtering data based on conditions

You can filter data based on the exact match of attribute, based on a regex pattern or based on multiple criteria

To understand this, consider a scenario where you receive the temperature of multiple rooms in a streaming manner. 

- **Filtering based on exact match of attribute:**

    If you want the temperature readings only for a specific room, you can add a query with a filter as follows.
    
    ```
    from TempStream [roomNo=='2233']
    select *
    insert into RoomAnalysisStream;
    ```
    With the `roomNo=='2233'` filter, you are filtering the temperature readings for the room number `2233`. These readings are then inserted into a separate stream named `RoomAnalysisStream`.
    
- **Filtering based on regex pattern**

    In the example of processing temperature readings, assume that you need to filter the temperature readings for a specific range of devices located in the Southern wing and used for purpose B. Also assume that this can be derived from the device ID because the first three characters of the device ID represent the wing, and the eighth character represents the purpose. e.g., in device ID `SOU5438B765`, the first three characters `SOU` represent the Southern wing, and the eighth character `B` represents purpose B.
    
    You can achieve this by adding a filter with a regex pattern as follows:
    
    ```
    @info(name = 'FilteredRoomRange')
    from TempStream
    select regex.find(SOU*B*) as deviceID, roomNo, temp
    insert into FilteredResultsStream;
    ```
   The `regex.find(SOU*B*)` function filters room IDs that start with the three characters `SOU` and has the character `B` with one or more characters before it as well as after it. 

- **Filtering based on multiple criteria**

    In the example of processing temperature readings, assume that you need to filter the readings for a range of rooms (e.g., rooms 100-210) where the temperature is greater than 40. For this, you can add a filter as follows.
    
     ```
     from TempStream [(roomNo >= 100 and roomNo < 210) and temp > 40]
     select *
     insert into RoomAnalysisStream;
     ```   

#### Try it out

To try out the query used in the above example, let's include it in a Siddhi Application and run it.

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file. Then add and save the following Siddhi application.

    ```
    @App:name('TemperatureApp')
    
    define stream TempStream (deviceID string, roomNo int, temp double);
    
    @sink(type = 'log', prefix = "FilteredResult",
        @map(type = 'passThrough'))
    define stream RoomAnalysisStream (deviceID string, roomNo int, temp double);
    
    @info(name = 'Filtering2233')
    from TempStream[roomNo == '2233'] 
    select * 
    insert into RoomAnalysisStream;
    ```
3. Open the event simulator and simulate three events for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event](testing-a-Siddhi-Application/#simulating-a-single-event).

    | **Event** | **deviceID**  | **roomNo** | **temp** |
    |-----------|---------------|------------|----------|
    | 1         | `SOU5438B765` | `2233`     | `30`     |
    | 2         | `WES1827A876` | `1121`     | `27`     |
    | 3         | `NOR1633B231` | `0899`     | `28`     |
    
    Only the first event is logged in the terminal as follows. This is because only the first event has `2233` as the value for the `roomNo` attribute.
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - FilteredResult : Event{timestamp=1604494352744, data=[SOU5438B765, 2233, 30.0], isExpired=false} 
    ``` 
4. Now remove the `Filtering2233` query and replace it with the following query that filters based on multiple criteria.

    ```
    from TempStream [(roomNo >= 100 and roomNo < 210) and temp > 40]
    select *
    insert into RoomAnalysisStream;
    ``` 
   The complete Siddhi application is as follows:
   
   ```
    @App:name('TemperatureApp')
    
    define stream TempStream (deviceID string, roomNo int, temp double);
    
    @sink(type = 'log', prefix = "FilteredResult",
        @map(type = 'passThrough'))
    define stream RoomAnalysisStream (deviceID string, roomNo int, temp double);
    
    from TempStream [(roomNo >= 100 and roomNo < 210) and temp > 40]
    select *
    insert into RoomAnalysisStream;
   ```
   
5. Open the event simulator and simulate three events for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event](testing-a-Siddhi-Application/#simulating-a-single-event).

    | **Event** | **deviceID**  | **roomNo** | **temp** |
    |-----------|---------------|------------|----------|
    | 1         | `SOU5438B765` | `183`      | `30`     |
    | 2         | `WES1827A876` | `136`      | `42`     |
    | 3         | `NOR1633B231` | `899`      | `41`     |
    
    Only the second event is logged because only that event matched both the criteria. The event is logged as follows:
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - FilteredResult : Event{timestamp=1604557083556, data=[WES1827A876, 136, 42.0], isExpired=false}
    ```

### Modifying, removing, and replacing attributes

The input data may include attributes that are not required in order to generate the required output, attributes with values that need to be updated or replaced before further processing.

Assume that in the previous example, you do not need the device ID for further processing, and you need to present the room numbers as string values instead of integer values. To do this, follow the procedure below:

```
@info(name = 'CleaningData')
from FilteredResultsStream
select cast(roomNo string) as roomNo, temp
insert into CleansedDataStream;
```
Here, the `cast()` function presents the value for the `roomNo` attribute as a string value although it is received as an integer value. The `select` clause excludes the `deviceID` attribute.

#### Try it out

To try out the above example, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file. Then add and save the following Siddhi application.

    ```
    @App:name('TemperatureApp')
    
    define stream TempStream (deviceID string, roomNo int, temp double);
    
    @sink(type = 'log', prefix = "CleanedData",
        @map(type = 'passThrough'))
    define stream CleansedDataStream (roomNo string, temp double);
    
    @info(name = 'CleaningData')
    from TempStream
    select cast(roomNo, "string") as roomNo, temp
    insert into CleansedDataStream;
    ```
   In this Siddhi application, the `Temp Stream` has an attribute named `deviceID`, but it is not selected to be included in the output events. The `roomNo`attribute is cast as an string value via `cast(roomNo, "string")`. This means although the value for this attribute is received as an integer, it is presented as a string value in the output.
   
3. Open the event simulator and simulate an event for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event](testing-a-Siddhi-Application/#simulating-a-single-event).

    | **deviceID**  | **roomNo** | **temp** |
    |---------------|------------|----------|
    | `SOU5438B765` | `183`      | `30`     |
    
    The output is logged as follows:
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CleanedData : Event{timestamp=1604578130314, data=[183, 30.0], isExpired=false}
    ```


### Handling attributes with null values

In the example of processing temperature readings, assume that some events arrive with null values for the `deviceID` attribute, and you want to assign the value `unknown` in such scenarios. This can be achieved by writing a query as follows:

```
@info(name = 'AddingMissingValues')
from FilteredResultsStream
select ifThenElse(deviceID is null, "UNKNOWN", deviceID) as deviceID, roomNo, temp
insert into CleansedDataStream
```
#### Try it out.

To try out the above example, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file. Then add and save the following Siddhi application.

    ```
    @App:name("TemperatureApp")
    @App:description("Description of the plan")
    
    define stream TempStream (deviceID string, roomNo string, temp double);
    
    @sink(type = 'log', prefix = "Cleansed Data",
    	@map(type = 'passThrough'))
    define stream CleansedDataStream (deviceID string, roomNo string, temp double);
    
    @info(name = 'AddingMissingValues')
    from TempStream
    select ifThenElse(deviceID is null, "UNKNOWN", deviceID) as deviceID, roomNo, temp
    insert into CleansedDataStream;
    ```
   In this Siddhi application, the `Temp Stream` has an attribute named `deviceID`, but it is not selected to be included in the output events. The `roomNo`attribute is cast as an string value via `cast(roomNo, "string")`. This means although the value for this attribute is received as an integer, it is presented as a string value in the output.
   
3. Open the event simulator and simulate an event for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event](testing-a-Siddhi-Application/#simulating-a-single-event).

    | **deviceID**                                        | **roomNo** | **temp** |
    |-----------------------------------------------------|------------|----------|
    | Select the **Is Null** check box for this sttribute | `183`      | `30`     |
    
    The output is logged as follows:
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Cleansed Data : Event{timestamp=1604581209943, data=[UNKNOWN, 183, 30.0], isExpired=false}
    ```


## Transforming data

The Streaming Integrator allows you to perform a wide range of transformations to the input data received. A main type of transformation supported is transforming a message from one format to another. In addition, you can perform a range of mathematical, regex, string, unit conversion, map, json, etc., transformations via [Siddhi Extensions](https://siddhi.io/en/v5.1/docs/extensions/). You can also write a custom script to perform an required transofrmation of data.

### Transforming message formats

WSO2 Streaming Integrator can transform message formats when it consumes data as well as when it publishes data.

#### Transforming the message format when consuming data

Data publishers, databases, files, and messaging systems send data to WSO2 Streaming Integrator in different data formats. Therefore, WSO2 Streaming Integrator has the capability to consume data in a range of formats. Once it receives the data in a specific format, it can convert it to a different format for processing purposes.

The Streaming Integrator can consume events in the default format in which they are sent/extracted or make changes to it to match the event schema as defined via the input stream.

- **Consuming messages in a default format**

    Consuming messages via WSO2 Streaming Integrator by configuring Siddhi sources is explained in [Extracting Data From Static Sources in Real Time](extracting-data-from-static-sources-in-real-time.md) and [Receiving Data in Trasit](receiving-data-in-transit.md).
    
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

#### Transforming the message format when publishing data

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

### Transforming with inline operators

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

### Transforming with supported Siddhi extensions

When you want to perform more advanced transformations that are not supported by the inline operators of the WSO2 Streaming Integrator, you can use one or more of the Siddhi extensions from the [Siddhi Store](https://store.wso2.com/store/assets/analyticsextension/list).

Some of these extensions are shipped with the WSO2 Streaming Integrator by default. If you want to use a Siddhi extension that is not shipped by default, you need to download and install it following the instructions in [Downloading and Installing Siddhi Extensions](../admin/downloading-and-Installing-Siddhi-Extensions.md).

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

### Writing a custom script to transform data

To write a custom script to transform data, you can use the [siddhi-script-js](https://siddhi-io.github.io/siddhi-script-js/) Siddhi extension.

For example, if the Sweet Factory wants to check whether the production amount reported in a production run is greater than the average production up to that production run, you can write a custom function shown in the following sample query.

```
from ProductionTotalsStream 
select name, amount, total, average, js:eval("amount > average", 'bool') as exceedsAverage
group by name 
insert into MonitorProductionTrendStream;
```

Here, `js:eval("amount > average", 'bool') as exceedsAverage` is a custom function where an attribute named `exceedsAverage` returns the value `true` or `false` depending on whether the value for the `amount` attribute exceeds the value for the `average` attribute.

### Try it out

To try out the transformations described above with some of the given examples, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

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
    
## Summarizing data

Summarizing data refers to obtaining aggregates in an incremental manner for a specified set of time periods.

### Performing clock-time based summarization

Performing clock time-based summarizations involve two steps:

1. Calculating the aggregations for the selected time granularities and storing the results.

2. Retrieving previously calculated aggregations for selected time granularities.

#### Calculating the aggregations for the selected time granularities and storing the results

To understand this, consider a scenario where the production statistics generated by the Sweet Production Factory processed. The results need to be summarized for different time granularities and saved so that they can be later retrieved for periodical production analysis. To do this, you can create a Siddhi application as shown below.

```
@App:name('ProductionAggregatesApp')

define stream ProductionStream (name string, amount double, timestamp long);

@store(type='rdbms', jdbc.url="jdbc:mysql://localhost:3306/Production", username="root", password="root" , jdbc.driver.name="com.mysql.jdbc.Driver")
define aggregation ProductionAggregation
from ProductionStream
select name, amount, sum(amount) as total, avg(amount) as average 
group by name 
aggregate by timestamp every sec ... year;
```
Observe the following in the above Siddhi application:

- The stream

    In addition to the `name` and `amount` attributes to capture the name of the product and the amount produced, the stream has an attribute named `timestamp` to capture the time at which the production run takes place. he aggregations are executed based on this time. This attribute's value could either be a long value (reflecting the Unix timestamp in milliseconds), or a string value adhering to one of the following formats:
    
    - `<YYYY>-<MM>-<dd> <HH>:<mm>:<ss> <Z>`: This format can be used if the timezone needs to be specified explicitly. Here the ISO 8601 UTC offset must be provided. e.g., +05:30 reflects the India Time Zone. If time is not in GMT, this value must be provided.
    
    - `<yyyy>-<MM>-<dd> <HH>:<mm>:<ss>`: This format can be used if the timezone is in GMT.
    
- The aggregation

    You are defining the `ProductionAggregation` aggregation to store the aggregated values. 
    
    A store is connected to it via the `@store` annotation. If the store definition is not provided, the data is stored in-memory. The aggregations stored in-memory can be lost when the Siddhi application is stopped.
    
- Siddhi query

    The Siddhi query gets the production events from the `ProductionStream` stream, calculates the total and the average, and aggregates them every `sec...year`. This means the production total and the average is calculated per second, per minute, per hour, per day, per month, and per year.

#### Retrieving previously calculated aggregations for selected time granularities

To retrieve the aggregates stored via the Siddhi application in the previous section, you need to create a new stream for data retrieval and join it with the aggregation that you previously created. In this example, let's assume that you need to production statistics for the period 12th October 2020 to 16th October 2020.

For this, you can update the `ProductionAggregatesApp` Siddhi application that you previously created as follows:

1. Define a stream in which you want to generate the event (request) to retrieve data as follows.

    ```
    define stream ProductionSummaryRetrievalStream (name string);
    ```

2. Define a query that specifies the criteria for retrieving data as follows.

    ```
    @info(name = 'RetrievingAggregates') 
    from ProductionSummaryRetrievalStream as b join ProductionAggregation as a
    on a.name == b.name 
    within "2020-10-12 00:00:00 +00:00", "2020-10-17 00:00:00 +00:00" 
    per "days" 
    select a.name, a.total, a.average 
    insert into ProductionSummaryStream;
    ```
    Observe the following in the above Siddhi query:
    
    - The join
    
        The above query joins the `ProductionsSummaryRetyrievalStream` stream and the `ProductionAggregation` aggregation. The `ProductionsSummaryRetyrievalStream` stream is assigned `b` as the short name, and the aggregation is assigned `a`. Therefore, `a.name == b.name` specifies that a matching event is identified when the value for the `name` attribute is the same. 

        For more information about how to perform joins, see [Enriching Data](#enriching-data).
        
    - `within` clause 
    
        This specifies the time interval for which the aggregates should be retrieved. You are requesting data for the period between 00.00 AM of 12th October 2020 and 00.00 AM of 17th October 2020 so that the days 12th, 13th, 14th, 15th, and the 16th of October are covered.
        
    - `per` clause
    
        This specifies that the aggregates should be summarized per day.
        
    - `select` clause
    
        This selects the `name`, `total` and `average` attributes to be selected from the aggregate to be included in the output event.
        
    The output event is inserted into the `ProductionSummaryStream` stream.
    
    
#### Try it out

To try out the example given above, follow the procedure below:

1. Download and install MySQL. Then start the MySQL server and create a new database in it by issuing the following command:

    `CREATE SCHEMA production;`
    
    Then open the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file and add the following datasource configuration under `datasources`.
    
    ```
      - name: Production_DB
        description: The datasource used for Production Statistics
        jndiConfig:
          name: jdbc/production
        definition:
          type: RDBMS
          configuration:
            jdbcUrl: 'jdbc:mysql://localhost:3306/production?useSSL=false'
            username: root
            password: root
            driverClassName: com.mysql.jdbc.Driver
            minIdle: 5
            maxPoolSize: 50
            idleTimeout: 60000
            connectionTestQuery: SELECT 1
            validationTimeout: 30000
            isAutoCommit: false
    ```
    
2. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

3. Open a new file in Streaming Integrator Tooling. Then add and save the following Siddhi application.

    ```
    @App:name('ProductionAggregatesApp')
    @App:description('Description of the plan')
    
    define stream ProductionStream (name string, amount double, timestamp long);
    
    define stream ProductionSummaryRetrievalStream (name string);
    
    @sink(type = 'log', prefix = "Production Summary",
    	@map(type = 'text'))
    define stream ProductionSummaryStream (name string, total double, average double);
    
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/production?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    define aggregation ProductionAggregation
    from ProductionStream
    select name, amount, sum(amount) as total, avg(amount) as average
    	aggregate by timestamp every seconds...years;
    
    @info(name = 'RetrievingAggregates')
    from ProductionSummaryRetrievalStream as b 
    join ProductionAggregation as a 
    	on a.name == b.name
    within "2020-10-12 00:00:00 +00:00", "2020-10-17 00:00:00 +00:00"
    per "days" 
    select a.name as name, a.total as total, a.average as average 
    insert into ProductionSummaryStream;
    ```
   
   This is the complete `ProductionAggregatesApp` Siddhi application with the queries given in the examples to store and retrieve aggregates. You are annotating a sink of the `log` type to the `ProductionSummaryStream` stream to which the retrieved aggregates are sent so that you can view the retrieved information in the terminal logs.
   
4. To store aggregates, simulate five events with the following values for the `ProductionStream` stream via the Event Simulator tool. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    | **name**  | **amount** | **timestamp**   |
    |-----------|------------|-----------------|
    | `brownie` | `90`      | `1602489419000` |
    | `brownie` | `90`       | `1602488519000` |
    | `eclairs` | `95`       | `1602661319000` |
    | `brownie` | `100`      | `1602747719000` |
    | `brownie` | `120`      | `1602834119000` |
    
    The above events are stored in the `production` database that you previously defined.
    
    
5. To retrieve the information you stored, simulate an event for the `ProductionSummaryRetrievalStream` stream with `brownie` as the value for `name'. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    The Streaming Integrator Tooling terminal displays the following logs.
    
    ![Aggregate Logs](../images/processing-data/aggregate-logs.png)

### Performing short term summarizations

This section explains how to apply Siddhi logic to process a subset of events received to a stream based on time or the number of events. This is achieved via [Siddi Windows]().
The window can apply to a batch of events or in a sliding manner. 

The following are a few examples of how short time summarizations can be performed based on time or the number of events.

- **Performing a time-based summarization in a sliding manner**

    This involves selecting a subset of events based on a specified duration of time in a sliding manner as illustrated via an example in the diagram below.
    
    ![Time Sliding Window](../images/processing-data/time-sliding-window.png)
    
    For example, consider that the factory foreman of a sweet factory wants to calculate the production total and average per product every four minutes in a sliding manner. To address this, you can write a query as follows.

    ```
    from ProductionStream#window.time(4 min)
    select name, sum(amount) as pastFourMinTotal, avg(amount) as pastFourMinAvg
    group by name
    insert into TimeSlidingOutputStream;
    ```  
    Here, `#window.time(4 min)` represents a sliding time window of four minutes. Based on this, the total for the last four minutes is calculated and presented as `pastFourMinTotal`, and the average for the last four minutes is calculated and presented as `pastFourMinAvg`.

- **Performing a time-based summarization in a tumbling manner**

    This involves selecting a subset of events based on a specified duration of time in a tumbling manner as illustrated via an example in the diagram below.
    
    ![Time Batch Window](../images/processing-data/time-batch-window.png)
    
    For example, consider that the factory foreman of a sweet factory wants to calculate the production total and average per product every four minutes in a tumbling manner. To address this, you can write a query as follows.

    ```
    from ProductionStream#window.timeBatch(4 min)
    select name, sum(amount) as pastFourMinTotal, avg(amount) as pastFourMinAvg
    group by name
    insert into TimeBatchOutputStream;
    ```
    Here, `#window.timeBatch(4 min)` represents a tumbling time window of four minutes. Based on this, the total for the last four minutes is calculated and presented as `pastFourMinTotal`, and the average for the last four minutes is calculated and presented as `pastFourMinAvg`.

- **Performing a length-based summarization in a sliding manner**

    This involves selecting a batch of events based on the number of events specified in a sliding manner as illustrated via an example in the diagram below.
    
    ![Length Sliding Window](../images/processing-data/length-sliding-window.png)
    
    For example, consider that the factory foreman of a sweet factory wants to calculate the production total and average per product for every three events in a sliding manner. To address this, you can write a query as follows.

    ```
    from ProductionStream#window.length(3)
    select name, sum(amount) as lastBatchTotal, avg(amount) as lastBatchAvg
    group by name
    insert into LengthSlidingOutputStream;
    ```
    Here, `#window.length(3)` represents a sliding length window of 3 events. Based on this, the total for the last three events is calculated and presented as `lastBatchTotal`, and the average for the last three events is calculated and presented as `lastBatchAvg`.

- **Performing a length-based summarization to a batch of events** 

    This involves selecting a batch of events based on the number of events specified in a sliding manner as illustrated via an example in the diagram below.
    
    ![Length Batch Window](../images/processing-data/length-batch-window.png)
    
    For example, consider that the factory foreman of a sweet factory wants to calculate the production total and average per product for every three events in a sliding manner. To address this, you can write a query as follows.

    ```
    from ProductionStream#window.lengthBatch(3)
    select name, sum(amount) as lastBatchTotal, avg(amount) as lastBatchAvg
    group by name
    insert into LengthBatchOutputStream;
    ```
    Here, `#window.lengthBatch(3)` represents a sliding length window of 3 events. Based on this, the total for the last three events is calculated and presented as `lastBatchTotal`, and the average for the last three events is calculated and presented as `lastBatchAvg`.
    
#### Try it out

To try out the four sample queries given above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file. Then add and save the following Siddhi application.

    ```
    @App:name('ProductionSummaryApp')
    
    
    @sink(type = 'log', prefix = "Four Minute Summary",
    	@map(type = 'text'))
    define stream TimeSlidingOutputStream (name string, pastFourMinTotal double, pastFourMinAvg double);
    
    @sink(type = 'log', prefix = "Three Production Run Summary",
    	@map(type = 'passThrough'))
    define stream LengthSlidingOutputStream (name string, lastBatchTotal double, lastBatchAvg double);
    
    define stream ProductionStream (name string, amount double, timestamp long);
    
    @sink(type = 'log', prefix = "Four Minute Summary - Batch",
    	@map(type = 'text'))
    define stream TimeBatchOutputStream (name string, pastFourMinTotal double, pastFourMinAvg double);
    
    @sink(type = 'log', prefix = "Three Production Run Summary - Batch",
    	@map(type = 'passThrough'))
    define stream LengthBatchOutputStream (name string, lastBatchTotal double, lastBatchAvg double);
    
    @info(name = 'query1')
    from ProductionStream#window.time(4 min) 
    select name, sum(amount) as pastFourMinTotal, avg(amount) as pastFourMinAvg 
    	group by name 
    insert into TimeSlidingOutputStream;
    
    @info(name = 'query2')
    from ProductionStream#window.timeBatch(4 min) 
    select name, sum(amount) as pastFourMinTotal, avg(amount) as pastFourMinAvg 
    	group by name 
    insert into TimeBatchOutputStream;
    
    @info(name = 'query3')
    from ProductionStream#window.length(3) 
    select name, sum(amount) as lastBatchTotal, avg(amount) as lastBatchAvg 
    	group by name 
    insert into LengthSlidingOutputStream;
    
    @info(name = 'query4')
    from ProductionStream#window.lengthBatch(3) 
    select name, sum(amount) as lastBatchTotal, avg(amount) as lastBatchAvg 
    	group by name 
    insert into LengthBatchOutputStream;
    ```
   
   The above Siddhi application has all four sample queries used as examples in this section. Those queries insert their output into four different output streams connected to log sinks to log the output of each query.
   
3. Simulate eight events for the `ProductionStream` input stream of the above Siddhi application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    | **name**    | **amount** | **timestamp**   |
    |-------------|------------|-----------------|
    | `doughnuts` | `10`       | `1602486060000` |
    | `doughnuts` | `10`       | `1602486120000` |
    | `doughnuts` | `10`       | `1602486180000` |
    | `doughnuts` | `10`       | `1602486240000` |
    | `doughnuts` | `20`       | `1602486300000` |
    | `doughnuts` | `20`       | `1602486360000` |
    | `doughnuts` | `20`       | `1602486420000` |
    | `doughnuts` | `30`       | `1602486480000` |
    
    The above simulation results in the following logs.
    
    ![Summarization Logs](../images/processing-data/summary-logs.png)
    
#### Supported methods of summarization

WSO2 Streaming Integrator supports the following methods of summarization via Siddhi extensions. For more information about a summarization method, click on the relevant Siddhi link.      
    
## Enriching data

Enriching data involves integrated the data received into a streaming integration flow with data from other medium such as a data store, another data stream, or an external service to derive an expected result.

### Integrating data streams and static data

This involves enriching a data stream by joining it with a data store.

For example, consider a scenario where a sweet factory reports its production data in a streaming manner after each run. To update the stock with the latest amount produced, you need to add the latest production amounts to the stock amounts saved in a database.

To address this, you can write a query as follows.

```
from ProductionStream as p 
join StocksTable as s 
	on p.name == s.name 
select p.name as name, sum(p.amount) + s.amount as amount 
	group by p.name 
insert into UpdateStockwithProductionStream;
```

Here, the `ProductionStream` stream that has the production amounts for sweets after each production run is assigned the short name `p`. The `StocksTable` that has the current stock for each product before the latest production runs is given the short name `s`. This allows you to uniquely identify the attributes in each. The matching condition is `p.name == s.name `, which means that a match is identified when an event in the `ProductionStream` stream has the same value for the `name` attribute as a record in the `StockTable` table. 
`sum(p.amount)` calculates the total production per product. This total production amount for a product is then added to the stock amount of the product (i.e., `s.amount`). The resulting output is inserted into the `UpdateStockwithProductionStream` stream.

### Integrating multiple data streams

This involves enriching a data stream by joining it with another data stream.

To understand this, consider the example you used in the previous [Integrating data streams and static data section](#integrating-data-streams-and-static-data) where you directed the stock amounts updated with the latest production amounts into a stream. Assume another stream reports the sale of stock in a streaming manner. To further update the stock by deducting the amounts sold, you need to join the data stream that has the latest stock amounts with the data stream that has the sales amounts.

To address the above requirement, you can write a query as follows.

```text
from UpdateStockwithProductionStream as u 
join SalesStream as s 
	on u.name == s.name 
select u.name as name, sum(u.amount) - sum(s.amount) as amount 
insert into LatestStockStream;
```

Here, `u` is the short name for the `UpdateStockwithProductionStream` stream that has the total stock amounts for each product updated with the latest production amounts. `s` is the short name for the `SalesStream` stream that reports the sales for all the products in a streaming manner. Matching events are the events with the same value for the `name` attribute.
To calculate the latest stock amount for each product, the total sales amount is deducted from the total stock amount updated with production amounts. The resulting output is inserted into the `LatestStockStream`.

### Integrating data streams with external services

This involves enriching a data stream by incorporating information received from an external service to it.

To understand this, consider that in order to value the stock, a Sweet Factory obtains the value of one unit of a product from an external application named `StockValuingApp`. When you submit the name of the product, it returns the unit value. To value the stock based on this information, you can create a Siddhi application as follows:

```
@App:name("StockValuingApp")

@sink(type='http-request',publisher.url='http://localhost:5005/CheckProductValueEP',method='POST', headers="'Content-Type:application/x-www-form-urlencoded'",
sink.id="unitvalueSink",
@map(type='keyvalue', @payload(Sweet='{{name}}')))
define stream CheckUnitValueStream (name string);

@source(type='http-response' ,sink.id='unitvalueSink',    
@map(type='xml', namespaces = "xmlns=http://localhost:5005/CheckProductValueEP/",    
@attributes(name = 'trp:name',unitValue = ".")))        
define stream StoreUnitValueStream (name string,unitValue double);

from StoreUnitValueStream
select *
update or insert into ProductValueTable;
```

In the above application, events in the `CheckUnitValueStream` stream are published to the `http://localhost:5005/CheckProductValueEP` URL via the connected `http-request` sink to invoke a service that returns the unit value for the name of the product sent. WSO2 Streaming Integrator captures this response (i.e., unit value) in the `StoreUnitValueStream` stream via the `http-response` source connected to the stream. In orcder to allow WSO2 Streaming Integrator to identify the response as the result of the request it previously sent, the same value is specified for the `sink.id` parameter in both the source configuration and the sink configuration.
To store the unit values obtained for further processing, all the events in the `StoreUnitValueStream` stream are inserted into a table named `ProductValueTable`.

### Enriching data with built-in extensions

The following is a list of Siddhi extensions with which you can enrich data.

 - [Siddhi-execution-streamingml](https://siddhi-io.github.io/siddhi-execution-streamingml/)
 - [Siddhi-execution-env](https://wso2-extensions.github.io/siddhi-execution-env/)
 - [Siddhi-execution-math](https://wso2-extensions.github.io/siddhi-execution-math/)
 - [Siddhi-execution-string](https://siddhi-io.github.io/siddhi-execution-string/)
 - [Siddhi-execution-time](https://siddhi-io.github.io/siddhi-execution-time/)
 - [Siddhi-execution-json](https://siddhi-io.github.io/siddhi-execution-json/)

### Try it out

To try out the examples given above, follow the steps below.

1. Set up your database as follows:

    1. Download and install MySQL. Then start the MySQL server and create a new database in it by issuing the following command:
    
        `CREATE SCHEMA stock;`
        
    2. Create a table in the `stock` database you created by issuing the following two commands.
    
        `use stock;`
        
        `CREATE TABLE StockTable (name VARCHAR(20),amount double(10,2));`
    
    3. Insert two records into the `StockTable` you created by issuing the following commands.
    
        `insert into StockTable values('gingerbread',8.0);`
        
        `insert into StockTable values('coffee cake',6.0);`   
    
    4. Then open the `<SI_TOOLING_HOME>/conf/server/deployment.yaml` file and add the following data source configuration under `datasources`.
    
        ```
          - name: Stock_DB
            description: The datasource used for Stock Valuation
            jndiConfig:
              name: jdbc/stock
            definition:
              type: RDBMS
              configuration:
                jdbcUrl: 'jdbc:mysql://localhost:3306/stock?useSSL=false'
                username: root
                password: root
                driverClassName: com.mysql.jdbc.Driver
                minIdle: 5
                maxPoolSize: 50
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false
        ```
    
2. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

3. Open a new file in Streaming Integrator Tooling. Then add and save the following Siddhi application.

    ```
    @App:name('StockValuingApp')
    @App:description('Description of the plan')
    
    define stream ProductionStream (name string, amount double);
    
    @source(type = 'http-response', sink.id = "unitvalueSink",
    	@map(type = 'xml', namespaces = "xmlns=http://localhost:5005/CheckProductValueEP/",
    		@attributes(name = "trp:name", unitValue = ".")))
    define stream GetUnitValueStream (name string, unitValue double);
    
    @sink(type = 'log', prefix = "Stock Update After Production",
    	@map(type = 'text'))
    
    define stream UpdateStockwithProductionStream (name string, amount double);
    
    define stream SalesStream (name string, amount double);
    
    @sink(type = 'http-request', publisher.url = "http://localhost:5005/CheckProductValueEP", method = "POST", headers = "'Content-Type:application/x-www-form-urlencoded'", sink.id = "unitvalueSink",
    	@map(type = 'keyvalue'))
    define stream CheckUnitValueStream (name string);
    
    @sink(type = 'log', prefix = "Latest Stock",
    	@map(type = 'text'))
    define stream LatestStockStream (name string, amount double);
    
    @sink(type = 'log', prefix = "Stock Value",
    	@map(type = 'text'))
    define stream StockValueStream (name string, value double);
    
    @store(type = 'rdbms', jdbc.url = "jdbc:mysql://localhost:3306/stock?useSSL=false", username = "root", password = "root", jdbc.driver.name = "com.mysql.jdbc.Driver")
    @primaryKey("name")
    define table StockTable (name string, amount double);
    
    @info(name = 'UpdateStockwithProduction')
    from ProductionStream as p 
    join StockTable as s 
    	on p.name == s.name 
    select p.name as name, sum(p.amount) + s.amount as amount 
    	group by p.name 
    insert into UpdateStockwithProductionStream;
    
    @info(name='UpdateStockwithSales') 
    from UpdateStockwithProductionStream#window.time(5 min) as u 
    join SalesStream as s 
    	on u.name == s.name 
    select u.name as name, sum(u.amount) - sum(s.amount) as amount 
    insert into LatestStockStream;
    
    
    @info(name='CalculateStockValue') 
    from LatestStockStream as l 
    join GetUnitValueStream as g 
    	on l.name == g.name 
    select l.name as name, g.unitValue * l.amount as value 
    insert into StockValueStream;  
    ```
   
   The above Siddhi application does the following:
   
   1. Updates the stock amount for each product by adding the total production amount to the stock amount. This is done by joining the `StockTable` table with the `ProductionStream` stream. Then it logs the result with the `Stock Update After Production` prefix.
   
   2. Calculates the latest stock by deducting the total sales for a product from the updated stock derived by adding the total production amount with the current stock amount. This is done by joining the `UpdateStockwithProductionStream` stream with the `SalesStream` stream. The result is logged with the `Latest Stock` prefix.
   
   3. Sends requests with the product name to an external service with the `http://localhost:5005/CheckProductValueEP` endpoint and receives the unit value of the submitted product name as a response. This response is captured in the `GetUnitValueStream` stream.
   
   4. Calculates the stock value by multiplying the latest stock with the unit value obtained from the external service. This is done by joining the `GetUnitValueStream` stream with the `LatestStockStream` stream. The result is then logges with the `Stock Value` prefix.
   
4. In Streaming Integrator Tooling, create a new Siddhi application as follows, save it, and then start it.

    ```
    @App:name('ReturnUnitValueApp')
    
    @source(type='http-service' , source.id='unitValue', receiver.url='http://localhost:5005/CheckProductValueEP/',
        @map(type = 'json')) 
    define stream RequestStream (name string);
    
    @sink(type='http-service-response', source.id='unitValue',
          message.id='{{name}}', @map(type = 'json'))
    define stream ResultStream (name string, unitValue double);
    
    from RequestStream
    select name, ifThenElse(name == 'gingerbread', 10.0, 20.0) as unitValue
    insert into ResultStream;
    ```
    This application functions as the external service for testing purposes.
    
5. Simulate events for the `StockValuingApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    1. First, simulate two events for the `ProductionStream` stream with the following values.
    
        | **Name**      | **Amount** |
        |---------------|------------|
        | `gingerbread` | `10`       |
        | `coffee cake` | `10`       |
        
        As a result, the following logs appear in the terminal.
        
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Update After Production : name:"gingerbread",
        amount:18.0 (Encoded) 
        ```
       
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Update After Production : name:"coffee cake",
        amount:16.0 (Encoded) 
        ```
       
       Here, the `StockUpdateAfterProduction` value is calculated by adding the production value to the stock value saved in the database.
       
    2. Now simulate the following two events to the `SalesStream` stream.
    
        | **Name**      | **Amount** |
        |---------------|------------|
        | `gingerbread` | `12`       |
        | `coffee cake` | `13`       |
        
        As a result, the following logs appear in the terminal.
        
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Latest Stock : name:"gingerbread",
        amount:6.0 (Encoded) 
        ```
       
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Latest Stock : name:"coffee cake",
        amount:3.0 (Encoded) 
        ```
       
    3. Now simulate two events to the `CheckUnitValueStream` stream. Enter `gingerbread` and `coffee cake` as the `name` for the first and the second event respectively.
    
        As a result, the following logs appear in the terminal.
                
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Value : name:"gingerbread",
        value:60.0 (Encoded) 
        ```
       
        ```
        INFO {io.siddhi.core.stream.output.sink.LogSink} - Stock Value : name:"coffee cake",
        value:60.0 (Encoded) 
        ```

## Correlating data

The streaming integrator can correlate data in order to detect patterns and trends in streaming data. Correlating can be done via patterns as well as sequences.

![patterns-sequences-matrix](../images/correlating-events/patterns-sequences-matrix.png)

The difference between patterns and sequence is that sequences require all the matching events to arrive consecutively to
 match the sequence condition, whereas patterns identify events that match the pattern condition irrespective of the order in which they arrive.

### Identifying patterns

A pattern identifies a correlation between two events that may or may not arrive in a specific sequence. 

#### Combine several patterns logically and match events

Logical patterns involve  combining several patterns logically and matching events. 

To understand this type of pattern, consider an example where you need to calculate the average shelf life of a production batch by calculating the amount of time it takes to sell the total amount in a batch. For this purpose, let's assume that the products are sold on a FIFO (First In First Out) basis.

The above requirement can be addressed by the following Siddhi application.

```
@App:name('ShelfLifeApp')

define stream ProductionStream (timestamp long, name string, amount double);

define stream SalesStream (timestamp long, name string, amount double);

@sink(type = 'log', prefix = "Shelf Life",
	@map(type = 'json'))
define stream ShelfLifeStream (name string, days long);

@info(name = 'Calculate Sales Total')
from SalesStream 
select timestamp, name, sum(amount) as total 
insert into SalesTotalsStream;

@info(name = 'Calculate Shelf Life')
from every e1 = ProductionStream -> e2 = SalesTotalsStream[name == e1.name and total >= e1.amount] 
select e1.name as name, time:dateDiff(e1.timestamp, e2.timestamp) as days 
insert into ShelfLifeStream;
```
First, the `Calculate Sales Total` query calculates the total sales from the sales stream that reports each sales transaction, and inserts the total into the `SalesTotalsStream` stream. 

In the `Calculate Shelf Life` query, `every e1 = ProductionStream -> e2 = SalesTotalsStream[name == e1.name and total >= e1.amount]` means every event in the `ProductionStream` stream is compared with the first subsequent event in the `SalesTotalsStream` stream, of which the value for the `total` attribute is greater than or equal to that of the `amount` attribute of the `ProductionStream` stream. When such an event exists in the `SalesTotalsStream` stream, the `time:dateDiff()` function is applied to calculate the time difference between the two events. The result is inserted into the `ShelfLifeStream` stream, and logged with the `Shelf Life` prefix via the log sink connected to this stream.

##### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file, add the following content to it and save.

    ```
    @App:name('ShelfLifeApp')
    
    define stream ProductionStream (timestamp long, name string, amount double);
    
    define stream SalesStream (timestamp long, name string, amount double);
    
    @sink(type = 'log', prefix = "Shelf Life",
        @map(type = 'json'))
    define stream ShelfLifeStream (name string, days long);
    
    @info(name = 'Calculate Sales Total')
    from SalesStream 
    select timestamp, name, sum(amount) as total 
    insert into SalesTotalsStream;
    
    @info(name = 'Calculate Shelf Life')
    from every e1 = ProductionStream -> e2 = SalesTotalsStream[name == e1.name and total >= e1.amount] 
    select e1.name as name, time:dateDiff(e1.timestamp, e2.timestamp) as days 
    insert into ShelfLifeStream;
    ```
   
3. Simulate events for the `ShelfLifeApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    - For the `ProductionStream` stream
    
        | **timestamp**   | **name** | **amount** |
        |-----------------|----------|------------|
        | `1602323450000` |`cake`    | 10         |
    
    - For the `SalesStream` stream
    
        | **timestamp**   | **name** | **amount** |
        |-----------------|----------|------------|
        | `1602327050000` | `cake`   | `5`        |
        | `1602413450000` | `cake`   | `6`        |
        
    As a result, the following is logged in the terminal.
    
    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Shelf Life : {"event":{"name":"cake","days":-1}} (Encoded) 
    ```

#### Count and match multiple events for a given pattern condition

Counting patterns involve counting and matching multiple events for a given pattern condition. 

To understand this type of patterns, consider an example where the manager of a Sweet Factory needs to count the number of times number of items sold within a time period one hour exceeds 90% of the latest stock amount during that same period.

The above requirement can be addressed by the following Siddhi application.

```
@App:name('DetectLowStockApp')

define stream LatestStockStream (timestamp long, name string, amount double);

define stream SalesStream (timestamp long, name string, amount double);

@sink(type = 'log', prefix = "Low Stock Alert!",
	@map(type = 'json'))
define stream LowStockLevelAlertStream (name string);

from e1=LatestStockStream -> e2=SalesStream[e1.name == e2.name and e2.amount > e1.amount]<3:> within 1 hour
select e1.name as name
insert into LowStockLevelAlertStream;
```
##### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file, add the following content to it and save.

    ```
    @App:name('DetectLowStockApp')
    
    define stream LatestStockStream (timestamp long, name string, amount double);
    
    define stream SalesStream (timestamp long, name string, amount double);
    
    @sink(type = 'log', prefix = "Low Stock Alert!",
        @map(type = 'json'))
    define stream LowStockLevelAlertStream (name string);
    
    from e1=LatestStockStream -> e2=SalesStream[e1.name == e2.name and e2.amount > e1.amount]<3:> within 1 hour
    select e1.name as name
    insert into LowStockLevelAlertStream;
    ```
   
3. Simulate events for the `DetectingLowStockApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    - For the `LatestStockStream` stream
    
        | **timestamp**   | **name**  | **amount** |
        |-----------------|-----------|------------|
        | `1602410450000` | `eclairs` | `10`       |
        | `1602411290000` | `eclairs` | `18`       |
        | `1602412310000` | `eclairs` | `20`       |
    
    - For the `SalesStream` stream
    
        | **timestamp**   | **name**  | **amount** |
        |-----------------|-----------|------------|
        | `1602410570000` | `eclairs` | `10`       |
        | `1602411350000` | `eclairs` | `17`       |
        | `1602412850000` | `eclairs` | `19`       |
        
    As a result, the following is logged in the terminal.
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Low Stock Alert! : {"event":{"name":"eclairs"}} (Encoded) 
    ```

#### Find non-occurrence of events

To understand how to detect the non occurrence of events, consider a scenario where the production manager of sa sweet factory needs to count the number of times a wastage occurred due to some of the items in a production batch not being sold within three days since it was produced and having to be scrapped as a result.  For this purpose, let's assume that the products are sold on a FIFO (First In First Out) basis.

The above requirement can be addressed by the following Siddhi application.

```
@App:name('DetectWastageApp')

define stream ProductionStream (name string, amount double);

@sink(type = 'log', prefix = "WastageAlert!",
	@map(type = 'json'))
define stream WastageAlertStream (name string);

define stream SalesStream (name string, amount double);

@info(name = 'Calculate Sales Total')
from SalesStream 
select name, sum(amount) as total 
insert into SalesTotalsStream;

@info(name = 'Detect Wastage')
from e1 = ProductionStream -> not SalesTotalsStream[name == e1.name and total >= e1.amount] for 3 days 
select e1.name as name 
insert into WastageAlertStream;
```
First, the `Calculate Sales Total` query calculates the total sales from the sales stream that reports each sales transaction, and inserts the total into the `SalesTotalsStream` stream. 

In the `Detect Wastage` query, the `from` clause detects a pattern where the sales total for a specific product has not equalled or exceeded the amount of the last production batch reported for that product within a time period of 3 days. When this pattern condition is met, the resulting output is inserted into the `WastageAlertStream;` and logged in the terminal via the connected log sink.

##### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file, add the following content to it and save.

    ```
    @App:name('DetectWastageApp')
    
    define stream ProductionStream (name string, amount double);
    
    @sink(type = 'log', prefix = "WastageAlert!",
        @map(type = 'json'))
    define stream WastageAlertStream (name string);
    
    define stream SalesStream (name string, amount double);
    
    @info(name = 'Calculate Sales Total')
    from SalesStream 
    select name, sum(amount) as total 
    insert into SalesTotalsStream;
    
    @info(name = 'Detect Wastage')
    from e1 = ProductionStream -> not SalesTotalsStream[name == e1.name and total >= e1.amount] for 3 seconds 
    select e1.name as name 
    insert into WastageAlertStream;
    ```
   For testing purposes, the above Siddhi application detects thye non occurrence of a matching event within three seconds instead of three days.
   
3. Simulate events for the `ProductionStream` stream of the `DetectWastageApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    | **name**  | **amount** |
    |-----------|------------|
    | `eclairs` | `100`      |
    
    The following is logged after three seconds.
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - WastageAlert! : {"event":{"name":"eclairs"}} (Encoded) 
    ```

### Correlating events to find a trend(sequence)

Sequences are identified by observing trends in events that occur consecutively.

#### Combine several trends logically and match events

Logical sequences are trends observed when consecutively occurring events match a given condition.

To understand logical sequences, consider a production manager identifying a decreasing trend in production when he/she observes a continuous decrease within three consecutive production batches.

The above requirement can be addressed by the following Siddhi application.

```
@App:name('DecreasingProductionAlertApp')

define stream ProductionStream (name string, amount double);

@sink(type = 'log', prefix = "Decreasing Production Alert",
	@map(type = 'json'))
define stream DecreasingProductionAlertStream (name string);

@info(name = 'query')
from every e1 = ProductionStream , e2 = ProductionStream[e1.name == name and e1.amount > amount] , e3 = ProductionStream[e2.name == name and e2.amount > amount] 
select e1.name as name 
insert into DecreasingProductionAlertStream;
```

The above Siddhi application compares  three events (i.e., e1, e2 and e3) that occur consecutively in the `ProductionStream`. If the second event reports a lower production amount than the first event, and then the third event reports a lower production amount than the second event, an output event is inserted into the `DecreasingProductionTrendAlertStream` stream. This output event is then logged via the log sink connected to the `DecreasingProductionTrendAlertStream` stream.

##### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file, add the following content to it and save.

    ```
    @App:name('DecreasingProductionAlertApp')
    
    define stream ProductionStream (name string, amount double);
    
    @sink(type = 'log', prefix = "Decreasing Production Alert",
        @map(type = 'json'))
    define stream DecreasingProductionAlertStream (name string);
    
    @info(name = 'query')
    from every e1 = ProductionStream , e2 = ProductionStream[e1.name == name and e1.amount > amount] , e3 = ProductionStream[e2.name == name and e2.amount > amount] 
    select e1.name as name 
    insert into DecreasingProductionAlertStream;
    ```
   
3. Simulate three events for the `ProductionStream` stream of the `DecreasingProductionAlertApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    | **name**      | **amount** |
    |---------------|------------|
    | `gingerbread` | `100`      |
    | `gingerbread` | `90`       |
    | `gingerbread` | `80`       |
    
    As a result, the following is logged in the terminal.
    
    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Decreasing Production Alert : {"event":{"name":"gingerbread"}} (Encoded) 
    ```

#### Count and match multiple events for a given trend

Counting sequences involves counting and matching multiple consecutively occurring events that match a given condition.

To understand this, consider a scenario where the productivity of a production bot changes since it is started. To use them in an optimum way, the production manager wants to identify the peaks and slumps in the production by observing every six production runs.

The above requirement can be addressed by the following Siddhi application.

```
@App:name('ObserveProductionTrendsApp')

define stream ProductionStream (name string, amount double);

@sink(type = 'log', prefix = "Production Peaks",
	@map(type = 'json'))
define stream DecreasingProductionAlertStream (initialAmount double, peakAmount double, firstReducedAmount double);

@info(name = 'query')
from every e1 = ProductionStream , e2 = ProductionStream[ifThenElse(e2[last].amount is null, e1.amount <= amount, e2[last].amount <= amount)] + , e3 = ProductionStream[e2[last].amount > amount] 
select e1.amount as initialAmount, e2[last].amount as peakAmount, e3.amount as firstReducedAmount 
insert into DecreasingProductionAlertStream;
```
The above Siddhi application matches every event in the `ProductionStream` stream. It first checks whether the value for the `amount` attribute of the second event is greater than that of the first event. Then for every event, it checks whetherv the value for the `amount` attribute is greater or equal to that of the previous event (i.e., via `e2[last].temp`). If an event occurs with a value for the `amount` attribute that is less than that of the preceding event, an output event is generated in the `DecreasingProductionAlertStream`.

##### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling](../develop/streaming-integrator-studio-overview.md/#starting-streaming-integrator-tooling).

2. Open a new file, add the following content to it and save.

    ```
    @App:name('ObserveProductionTrendsApp')
    
    define stream ProductionStream (name string, amount double);
    
    @sink(type = 'log', prefix = "Production Peaks",
        @map(type = 'json'))
    define stream DecreasingProductionAlertStream (initialAmount double, peakAmount double, firstReducedAmount double);
    
    @info(name = 'query')
    from every e1 = ProductionStream , e2 = ProductionStream[ifThenElse(e2[last].amount is null, e1.amount <= amount, e2[last].amount <= amount)] + , e3 = ProductionStream[e2[last].amount > amount] 
    select e1.amount as initialAmount, e2[last].amount as peakAmount, e3.amount as firstReducedAmount 
    insert into DecreasingProductionAlertStream;
    ```
   
3. Simulate events for the `ProductionStream` steeam of the `ObserveProductionTrendsApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events](../develop/testing-a-Siddhi-Application.md).

    | **name**      | **amount** |
    |---------------|------------|
    | `gingerbread` | `100`      |
    | `gingerbread` | `105`      |
    | `gingerbread` | `117`      |
    | `gingerbread` | `121`      |
    | `gingerbread` | `115`      |
    
    As a result, the following is logged in the terminal.
    
    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Production Peaks : {"event":{"initialAmount":100.0,"peakAmount":121.0,"firstReducedAmount":115.0}} (Encoded) 
    ```
    
    