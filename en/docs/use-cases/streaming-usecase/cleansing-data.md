# Cleansing Data

When you receive input data via the Streaming Integrator, it may consist of data that is not required to generate the required output, null values for certain attributes, etc. Cleansing data refers to refining the input data received by assigning values where there are missing values (if there are applicable values), filtering out the data that is not required, etc.

## Filtering data based on conditions

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

### Try it out

To try out the query used in the above example, let's include it in a Siddhi Application and run it.

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
3. Open the event simulator and simulate three events for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application/#simulating-a-single-event).

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
   
5. Open the event simulator and simulate three events for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application/#simulating-a-single-event).

    | **Event** | **deviceID**  | **roomNo** | **temp** |
    |-----------|---------------|------------|----------|
    | 1         | `SOU5438B765` | `183`      | `30`     |
    | 2         | `WES1827A876` | `136`      | `42`     |
    | 3         | `NOR1633B231` | `899`      | `41`     |
    
    Only the second event is logged because only that event matched both the criteria. The event is logged as follows:
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - FilteredResult : Event{timestamp=1604557083556, data=[WES1827A876, 136, 42.0], isExpired=false}
    ```

## Modifying, removing, and replacing attributes

The input data may include attributes that are not required in order to generate the required output, attributes with values that need to be updated or replaced before further processing.

Assume that in the previous example, you do not need the device ID for further processing, and you need to present the room numbers as string values instead of integer values. To do this, follow the procedure below:

```
@info(name = 'CleaningData')
from FilteredResultsStream
select cast(roomNo string) as roomNo, temp
insert into CleansedDataStream;
```
Here, the `cast()` function presents the value for the `roomNo` attribute as a string value although it is received as an integer value. The `select` clause excludes the `deviceID` attribute.

### Try it out

To try out the above example, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
   
3. Open the event simulator and simulate an event for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application/#simulating-a-single-event).

    | **deviceID**  | **roomNo** | **temp** |
    |---------------|------------|----------|
    | `SOU5438B765` | `183`      | `30`     |
    
    The output is logged as follows:
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - CleanedData : Event{timestamp=1604578130314, data=[183, 30.0], isExpired=false}
    ```


## Handling attributes with null values

In the example of processing temperature readings, assume that some events arrive with null values for the `deviceID` attribute, and you want to assign the value `unknown` in such scenarios. This can be achieved by writing a query as follows:

```
@info(name = 'AddingMissingValues')
from FilteredResultsStream
select ifThenElse(deviceID is null, "UNKNOWN", deviceID) as deviceID, roomNo, temp
insert into CleansedDataStream
```
### Try it out.

To try out the above example, follow the steps below:

1. [Start and Access Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

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
   
3. Open the event simulator and simulate an event for the `TempStream` input stream of the `TemperatureApp` Siddhi application with the values for the attributes as given below. For instructions to simulate single events, see [Testing Siddhi Applications - Simulating a single event]({{base_path}}/develop/streaming-apps/testing-a-siddhi-application/#simulating-a-single-event).

    | **deviceID**                                        | **roomNo** | **temp** |
    |-----------------------------------------------------|------------|----------|
    | Select the **Is Null** check box for this sttribute | `183`      | `30`     |
    
    The output is logged as follows:
    
    ```text
    INFO {io.siddhi.core.stream.output.sink.LogSink} - Cleansed Data : Event{timestamp=1604581209943, data=[UNKNOWN, 183, 30.0], isExpired=false}
    ```