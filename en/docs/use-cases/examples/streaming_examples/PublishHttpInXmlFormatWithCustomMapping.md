# Publishing Custom XML Events via HTTP

## Purpose

This application demonstrates how to configure WSO2 Streaming Integrator to send sweet production events via HTTP transport in XML format using custom mapping. Map the input events($.item.id) to stream events(name) and log the events in the `LowProducitonAlertStream` stream on the output console.

!!!info "Before executing the sample:"
    Save the sample Siddhi application. Is there is no syntax error, the following message appears in the console.<br/>
    `- Siddhi App PublishHTTPInJsonFormatWithCustomMapping successfully deployed.`

## Executing the Sample

1. Start the Siddhi application by clicking **Run** => **Run**.

2. If the Siddhi application starts successfully, the following message appears in the console.

    `PublishHttpInXmlFormatWithCustomMapping.siddhi - Started Successfully!`

!!!note
    If you edit this application while it's running, save the application and then click **Run** => **Run**.<br/>
    If the `PublishHttpInXmlFormatWithCustomMapping.siddhi - Started Successfully!` message does not appear, it could be due to port 8080 which is defined in the Siddhi application already being used by a different program. To resolve this issue, do the following:<br/>
        * Stop this Siddhi application (click 'Run' on the menu bar -> 'Stop')..<br/>
        * Change the port 8080 to an unused port in this Siddhi application's source configuration..<br/>
        * Start the application and check whether the specified messages appear on the console.


## Testing the Sample

1. Open a terminal and navigate to `<SI_HOME>/samples/sample-clients/http-server`.  Then run the `ant` command without any arguments.

2. Send events using one or more of the following methods:

    - **Send events with the HTTP server through the event simulator:**

        a. Open event simulator by clicking on the second icon or press Ctrl+Shift+I.

        b. In the **Single Simulation** tab of the panel, select values as follows:<br/>
            - **Siddhi App Name**: `PublishHttpInXmlFormatWithCustomMapping`<br/>
            - **Stream Name**: `SweetProductionStream`

        c. In the name **field** and **amount** fields, enter `toffee` and `50.0` respectively. Then click **Send** to send the event.

        d. Send more events.

    - **Send events to the HTTP endpoint defined via the `publish.url` in the Sink configuration by issuing the following CURL command:

        `curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishHttpInXmlFormatWithCustomMapping","data": ['toffee', 67.43]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'`

        If there is no error, the following message appears in the terminal:

        `{"status":"OK","message":"Single Event simulation started successfully"}`

## Viewing the Results

* If you send events through the event simulator, the following output is logged.
[java] [org.wso2.si.http.server.HttpServerListener]: `Event Name Arrived: <events><event><name>toffee</name><amount>50.0</amount></event></events>`
[java] [org.wso2.si.http.server.HttpServerMain]: `Received Event Names:<events><event><name>toffee</name><amount>50.0</amount></event></events> ,`
[java] [org.wso2.si.http.server.HttpServerMain]: `Received Event Headers key set:[Http_method, Transfer-encoding, Content-type]`
[java] [org.wso2.si.http.server.HttpServerMain]: `Received Event Headers value set:[[POST], [chunked], [application/xml]]`


* If you send events through event CURL commands, the following output is logged:
[java] [org.wso2.si.http.server.HttpServerListener]: `Event Name Arrived: <events><event><name>toffee</name><amount>67.43</amount></event></events>`
[java] [org.wso2.si.http.server.HttpServerMain]: `Received Event Names:<events><event><name>toffee</name><amount>67.43</amount></event></events> ,`
[java] [org.wso2.si.http.server.HttpServerMain]: `Received Event Headers key set:[Http_method, Transfer-encoding, Content-type]`
[java] [org.wso2.si.http.server.HttpServerMain]: `Received Event Headers value set:[[POST], [chunked], [application/xml]]`

!!!note
    Stop this Siddhi application once you are done with the execution.

???info "Click here to view the complete sample Siddhi application"
    ```sql
    @App:name("PublishHttpInXmlFormatWithCustomMapping")
    @App:description('Send events via HTTP transport using xml formatwith custom mapping')



    define stream SweetProductionStream (name string, amount double);

    @sink(type='http', publisher.url='http://localhost:8080/abc',
    @map(type='xml', @payload( "<StockData><Symbol>{{name}}</Symbol><Price>{{amount}}</Price></StockData>")))
    define stream LowProductionAlertStream (name string, amount double);


    from SweetProductionStream
    select *
    insert into LowProductionAlertStream;
    ```