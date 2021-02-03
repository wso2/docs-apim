# Sending Custom JSON Events via HTTP

## Purpose

This application demonstrates how to configure the Streaming Integrator to send sweet production events via HTTP transport in JSON format using custom mapping.

!!!info "Before executing the sample:"
    Save the sample Siddhi application. Is there is no syntax error, the following message appears in the console.<br/>
    `- Siddhi App PublishHTTPInJsonFormatWithCustomMapping successfully deployed.`


## Executing the Sample

1. Start the Siddhi application by clicking **Run** => **Run**.

2. If the Siddhi application starts successfully, the following messages are shown on the console.

    * `PublishHTTPInJsonFormatWithCustomMapping.siddhi - Started Successfully!`

    * `'http' sink at 'LowProductionAlertStream' has successfully connected to http://localhost:8080/abc`

## Testing the Sample

1. Open a terminal and navigate to `<SI_HOME>/samples/sample-clients/http-server`.  Then run the `ant` command without any arguments.

2. To send events, follow one or more of the following methods.

    * **Send events with http server through the event simulator:**

        a. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.

	    b. In the **Single Simulation** tab of the panel, specify the values as follows.

	        - Siddhi App Name`: `PublishHttpInJsonFormatWithCustomMapping
            - Stream Name`: `SweetProductionStream

        c. In the **id** and **amount** fields, enter `toffees` and `123.5` respectively and then click **Send** to send the event.

        d.  Send more events as required.

    * **Send events to the http endpoint defined by 'publish.url' in the Sink configuration through the curl command:**

        a. Open a new terminal and issue the following command

            curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishHTTPInJsonFormatWithCustomMapping","data": ['toffees', 123.5]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'

        b. If there is no error, the following message appears in the terminal.

            {"status":"OK","message":"Single Event simulation started successfully"}
	    
    * **Publish events with Postman:**

        a. Install the 'Postman' application from Chrome web store.

        b. Launch the application.

        c. Make a 'Post' request to the 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to 'text/plain' and set the request body in text as follows.

	        {"streamName": "SweetProductionStream", "siddhiAppName": "PublishHTTPInJsonFormatWithCustomMapping","data": ['toffees', 75.6]}

        d. Click **Send**. If there is no error, the following messages appear in the terminal.

            * "status": "OK"

            * "message": "Single Event simulation started successfully"


## Viewing the Results

**See the output on the terminal:**

```
[java] [org.wso2.si.http.server.HttpServerListener] : Event Name Arrived: {"event":{"id":"toffees","amount":123.5}}
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Names:{"event":{"id":"toffees","amount":123.5}} ,
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Headers key set:[Http_method, Content-type, Content-length]
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Headers value set:[[POST], [application/json], [43]]
```

!!!note
    If the message "'HTTP' sink at 'LowProductionAlertStream' has successfully connected to http://localhost:8080/abc" does not appear, it could be due to port 8080 defined in the Siddhi application is already being used by a different program. To resolve this issue, do the following:<br/>
        1. Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop').<br/>
        2. In this Siddhi application's source configuration, change the port from 8080 to an unused port.<br/>
        3. Start the application and check whether the specified messages appear on the console.

???info "Click here to view the complete sample Siddhi application"
    ```sql
    @App:name("PublishHTTPInJsonFormatWithCustomMapping")

    @App:description('Send events via HTTP transport in JSON format with custom mapping.')


    define stream SweetProductionStream (id string, amount double);

    @sink(type='http', publisher.url='http://localhost:8080/abc',
    @map(type='json' , @payload( "{'name': {{id}}, 'amount': {{amount}}}")))
    define stream LowProductionAlertStream (id string, amount double);

    @info(name='query1')
    from SweetProductionStream
    select *
    insert into LowProductionAlertStream;
    ```