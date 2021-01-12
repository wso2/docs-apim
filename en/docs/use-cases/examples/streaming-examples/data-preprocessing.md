# Pre-processing Data Received via TCP

## Purpose

This example demonstrates how to receive events via the TCP transport and carry out data pre-processing with numerous Siddhi extensions (e.g., string extension, time extension). In this sample, a composite ID is obtained using string concatenation and the time format of the incoming event is changed from `yyyy/MM/dd HH:mm:ss` to `dd-MM-yyyy HH:mm:ss`.

For more information about Siddhi extensions, see [Siddhi Extensions](https://wso2.github.io/siddhi/extensions/).

!!!info "Before you begin:"
    Save the sample Siddhi application in Streaming Integrator Tooling.

## Executing the Sample

To execute the sample open the saved Siddhi application in Streaming Integrator Tooling, and start it by clicking the **Start** button (shown below) or by clicking **Run** => **Run**.

![Start button]({{base_path}}/assets/img/streaming/amazon-s3-sink-sample/start.png)

If the Siddhi application starts successfully, the following messages appear in the console.

* `Tcp Server started in 0.0.0.0:9892`

* `DataPreprocessing.siddhi - Started Successfully!`

!!!note
    If you want to edit the Siddhi application after you have started it, stop it first, make your edits, save it and then start it again.

## Testing the Sample

To test this Siddhi application, navigate to the `<SI_TOOLING_HOME>/samples/sample-clients/tcp-client` directory and run the `ant` command as follows.

`ant -Dtype=json -DfilePath={WSO2SIHome}/samples/artifacts/DataPreprocessing/data_preprocessing_events.txt
-DeventDefinition='{"event":{"id":"{0}","value":{1},"property":{2},"plugId":{3},"householdId":{4},"houseId":{5},"currentTime":"{6}"}}' -Durl=tcp://localhost:9892/SmartHomeStream`

## Viewing the Results

Once the `DataProcessing` Siddhi application receives events from the TCP client, the following messages are displayed in the Streaming Integrator Tooling console:

INFO {io.siddhi.core.stream.output.sink.LogSink} - DataPreprocessing : ProcessedStream : Event{timestamp=1513621173211, data=[HouseholdID:1::UniqueID:0001, 12.12, 13-08-2001 23:49:33], isExpired=false}<br/><br/>
INFO {io.siddhi.core.stream.output.sink.LogSink} - DataPreprocessing : ProcessedStream : Event{timestamp=1513621174202, data=[HouseholdID:2::UniqueID:0002, 13.12, 13-08-2004 23:49:34], isExpired=false}<br/><br/>
INFO {io.siddhi.core.stream.output.sink.LogSink} - DataPreprocessing : ProcessedStream : Event{timestamp=1513621175208, data=[HouseholdID:3::UniqueID:0003, 13.12, 13-08-2006 23:49:35], isExpired=false}<br/><br/>
INFO {io.siddhi.core.stream.output.sink.LogSink} - DataPreprocessing : ProcessedStream : Event{timestamp=1513621176214, data=[HouseholdID:4::UniqueID:0004, 14.12, 13-08-2008 23:49:36], isExpired=false}<br/><br/>

???info "Click here to view the sample Siddhi application."

    ```sql
    @App:name("DataPreprocessing")

    @App:description('Collect data via TCP transport and pre-process')


    @Source(type = 'tcp',
            context='SmartHomeStream',
            @map(type='json'))
    define stream SmartHomeStream (id string, value float, property bool, plugId int, householdId int, houseId int, currentTime string);

    @sink(type='log')
    define stream ProcessedStream (compositeID string, value float, formattedTime string);

    --Process smart home data by concatenating the IDs and formatting the time
    @info(name='query1')
    from SmartHomeStream
    select str:concat("HouseholdID:", convert(householdId, "string"), "::", "UniqueID:", id) as compositeID, value, str:concat(currentTime, " ", time:currentTime()) as formattedTime
    insert into ProcessedStream;
    ```