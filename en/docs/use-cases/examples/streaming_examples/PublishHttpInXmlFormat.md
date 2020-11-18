# Publishing XML Events via HTTP

## Purpose

This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send sweet production events via HTTP transport in XML default format and log the events in LowProductionAlertStream to the output console.

!!!info "Before executing the sample:"
    Save the sample Siddhi application. Is there is no syntax error, the following message appears in the console.<br/>
    `- Siddhi App PublishHTTPInJsonFormatWithCustomMapping successfully deployed.`

## Executing the Sample

1. Start the Siddhi application by clicking **Run** => **Run**.

2. If the Siddhi application starts successfully, the following messages are shown on the console.

    * `PublishHttpInXmlFormat.siddhi - Started Successfully!`

    * `'Http' sink at 'LowProductionAlertStream' stream successfully connected to 'localhost:8080/abc'.`

## Testing the Sample

1. Open a terminal and navigate to `<SI_HOME>/samples/sample-clients/http-server`.  Then run the `ant` command without any arguments.

2. Send events using one or more of the following methods:

    - **Send events with http server through the event simulator:**

        a. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.

	    b. In the **Single Simulation** tab of the panel, specify the values as follows:

            - Siddhi App Name: PublishHttpInXmlFormat
            - Stream Name: SweetProductionStream

        c. In the **name** and **amount** fields, enter `toffees` and `75.6` respectively and then click **Send** to send the event.

        d. Send more events as required.

    - **Send events to the HTTP endpoint defined by `publish.url` in the Sink configuration using the curl command:**

        a. Open a new terminal and issue the following command.

            curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishHttpInXmlFormat","data": ['toffees', 75.6]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'

        b. If there is no error, the following message appears in the terminal.

            {"status":"OK","message":"Single Event simulation started successfully"}
	    
    - **Publish events with Postman:**

        a. Install the 'Postman' application from Chrome web store.

        b. Launch the application.

        c. Make a 'Post' request to the 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to `text/plain` and set the request body in text as follows.

            {"streamName": "SweetProductionStream", "siddhiAppName": "PublishHttpInXmlFormat","data": ['toffees', 75.6]}

        d. Click **Send**. If there is no error, the following messages appear in the console.<br/>
            - `"status": "OK",`<br/>
            - ` "message": "Single Event simulation started successfully"`

## Viewing the Results:

See the output on the terminal.

!!!note
    If the message `LowProductionAlertStream` stream could not connect to `localhost:8080`, it could be because port `8080`
    defined in the Siddhi application is already being used by a different program. To resolve this issue, do the following:<br/>
        1. Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop').<br/>
        2. Change the port from 8080 to an unused port in this Siddhi application's source configuration and in the http-server file.<br/>
        3. Start the application and check whether the expected output appears in the console.

???info "Click here to view the complete sample Siddhi application"
    ```sql
    @App:name("PublishHttpInXmlFormat")

    @App:description('Send events via HTTP transport using XML format')



    define stream SweetProductionStream (name string, amount double);

    @sink(type='http', publisher.url='http://localhost:8080/abc',
    @map(type='xml'))
    define stream LowProductionAlertStream (name string, amount double);

    @info(name='query1')
    from SweetProductionStream
    select *
    insert into LowProductionAlertStream;
    ```