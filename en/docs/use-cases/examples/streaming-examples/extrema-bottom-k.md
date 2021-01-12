# Counting the Frequency of Values with BottomK

## Purpose:
This application demonstrates how to use the `siddhi-execution-extrema` extension with the `bottomK` function.

!!!info "Before you begin:"
    Save the sample Siddhi application in Streaming Integrator Tooling.

## Executing the Sample

To execute the sample open the saved Siddhi application in Streaming Integrator Tooling, and start it by clicking the **Start** button (shown below) or by clicking **Run** => **Run**.

![Start button]({{base_path}}/assets/img/streaming/amazon-s3-sink-sample/start.png)

If the Siddhi application starts successfully, the following message appears in the console.

`ExtremaBottomK.siddhi - Started Successfully!`

## Testing the Sample

The `ExtremaBottomK` Siddhi application can be tested in three ways as follows.

### Option 1: Publish events via CURL

You can publish events in the `JSON` format to the HTTP endpoint via CURL commands. The CURL commands should be in the format of the example given below. The values for `name` and `amount` parameters can change.

`curl -X POST -d "{\"event\": {\"name\":\"sugar\",\"amount\": 20}}"  http://localhost:8006/productionStream --header "Content-Type:application/json"`

### Option2: Publish events with Postman

1. Install the `Postman` application from Chrome web store.

2. Launch the application.

3. Make a `POST` request to the `http://localhost:8006/productionStream` endpoint. Set the `Content-Type` to `application/json` and set the request body in `JSON` format as follows.

    ```
        {
           "event":{
              "name":"sugar",
              "amount":20
           }
        }
    ```

4. Send some more events in the same format, with different values for the `name` and `amount` parameters.

### Option3: Publish events with http sample client

Navigate to the `<WSO2SIHome>/samples/sample-clients/http-client` directory and run the following command.

`ant -Dtype=json -DfilePath={WSO2SIHome}/samples/artifacts/ExtreamBottomK/ExtremaBottomKEvents.txt -DeventDefinition='{"event":{"name":"{0}","amount":{1}}}' -Durl=http://localhost:8006/productionStream`

## Viewing the Results

The output is logged in the Streaming Integrator Tooling console as follows.

```
INFO {io.siddhi.core.stream.output.sink.LogSink} - ExtremaBottomK : outputStream : [Event{timestamp=1529498254202, data=[sugar, 20, sugar, 1, null, null, null, null], isExpired=false}, Event{timestamp=1529498254202, data=[cake, 10, cake, 1, sugar, 1, null, null], isExpired=false}]<br/><br/>
INFO {io.siddhi.core.stream.output.sink.LogSink} - ExtremaBottomK : outputStream : [Event{timestamp=1529498262769, data=[cake, 10, cake, 1, sugar, 1, null, null], isExpired=false}, Event{timestamp=1529498262769, data=[toffee, 65, toffee, 1, cake, 1, sugar, 1], isExpired=false}]<br/><br/>
INFO {io.siddhi.core.stream.output.sink.LogSink} - ExtremaBottomK : outputStream : [Event{timestamp=1529498270897, data=[toffee, 65, toffee, 1, cake, 1, sugar, 1], isExpired=false}, Event{timestamp=1529498270897, data=[cake, 74, toffee, 1, sugar, 1, cake, 2], isExpired=false}]<br/><br/>
INFO {io.siddhi.core.stream.output.sink.LogSink} - ExtremaBottomK : outputStream : [Event{timestamp=1529498278304, data=[cake, 74, toffee, 1, sugar, 1, cake, 2], isExpired=false}, Event{timestamp=1529498278304, data=[toffee, 25, sugar, 1, toffee, 2, cake, 2], isExpired=false}]
```

???info "Click here to view the sample Siddhi application."

    ```sql
    @App:name("ExtremaBottomK")
    @App:Description('Demonstrates how to use the siddhi-execution-extrema with bottomK function')


    @Source(type = 'http', receiver.url='http://localhost:8006/productionStream', basic.auth.enabled='false',
        @map(type='json'))
    define stream inputStream (name string, amount long);

    @sink(type='log')
    define stream outputStream(name string, amount long, bottom1Element string, bottom1Frequency long, bottom2Element string, bottom2Frequency long, bottom3Element string, bottom3Frequency long);

    from inputStream#extrema:bottomK(name, 3)
    insert all events into outputStream;
    ```