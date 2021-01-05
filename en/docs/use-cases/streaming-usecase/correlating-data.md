# Correlating Data

The streaming integrator can correlate data in order to detect patterns and trends in streaming data. Correlating can be done via patterns as well as sequences.

![patterns-sequences-matrix]({{base_path}}/assets/img/streaming//correlating-events/patterns-sequences-matrix.png)

The difference between patterns and sequence is that sequences require all the matching events to arrive consecutively to
 match the sequence condition, whereas patterns identify events that match the pattern condition irrespective of the order in which they arrive.

## Identifying patterns

A pattern identifies a correlation between two events that may or may not arrive in a specific sequence. 

### Combine several patterns logically and match events

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

#### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
   
3. Simulate events for the `ShelfLifeApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).

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

### Count and match multiple events for a given pattern condition

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
#### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
   
3. Simulate events for the `DetectingLowStockApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).

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

### Find non-occurrence of events

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

#### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
   
3. Simulate events for the `ProductionStream` stream of the `DetectWastageApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).

    | **name**  | **amount** |
    |-----------|------------|
    | `eclairs` | `100`      |
    
    The following is logged after three seconds.
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - WastageAlert! : {"event":{"name":"eclairs"}} (Encoded) 
    ```

## Correlating events to find a trend(sequence)

Sequences are identified by observing trends in events that occur consecutively.

### Combine several trends logically and match events

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

#### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
   
3. Simulate three events for the `ProductionStream` stream of the `DecreasingProductionAlertApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).

    | **name**      | **amount** |
    |---------------|------------|
    | `gingerbread` | `100`      |
    | `gingerbread` | `90`       |
    | `gingerbread` | `80`       |
    
    As a result, the following is logged in the terminal.
    
    ```
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Decreasing Production Alert : {"event":{"name":"gingerbread"}} (Encoded) 
    ```

### Count and match multiple events for a given trend

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

#### Try it out

To try out the Siddhi application given in the sample above, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
   
3. Simulate events for the `ProductionStream` steeam of the `ObserveProductionTrendsApp` application as follows. For instructions to simulate events, see [Testing Siddhi Applications - Simulating Events]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application).

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
    
    