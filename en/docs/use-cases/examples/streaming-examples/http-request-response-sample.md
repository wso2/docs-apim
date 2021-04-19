# Publishing HTTP Requests and Processing the Responses

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send sweet production events via HTTP transport in JSON default format, Receive response from the http server and process the response using siddhi.

## Prerequisites:
* Save this sample. If there is no syntax error, the following message is shown on the console:
    - Siddhi App HttpRequestResponseSample successfully deployed.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages are shown on the console:
* HttpRequestResponseSample.siddhi - Started Successfully!
* 'Http' sink at 'LowProductionAlertStream' stream successfully connected to 'localhost:8080/abc'.

## Testing the Sample:
1. Open a terminal and navigate to {WSO2SIHome}/samples/sample-clients/http-server and run "ant" command without any arguments.
2. Send events using one or more of the following methods.
    * Send events with http server through the event simulator:
        1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
	    2. In the Single Simulation tab of the panel, specifiy the values as follows:
            * Siddhi App Name  : HttpRequestResponseSample
            * Stream Name     : SweetProductionStream
        3. In the name and amount fields, enter 'toffees' and '75.6' respectively and then click Send to send the event.
        4. Send more events as desired.

    * Send events to the HTTP endpoint defined by 'publish.url' in the Sink configuration using the curl command:
        1. Open a new terminal and issue the following command:
            * curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "HttpRequestResponseSample","data": ['toffees', 75.6]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
        2. If there is no error, the following messages are shown on the terminal:
            *  {"status":"OK","message":"Single Event simulation started successfully"}

    * Publish events with Postman:
        1. Install the 'Postman' application from Chrome web store.
        2. Launch the application.
        3. Make a 'Post' request to the 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to 'text/plain' and set the request body in text as follows:
	{"streamName": "SweetProductionStream", "siddhiAppName": "HttpRequestResponseSample","data": ['toffees', 75.6]}
        4. Click 'send'. If there is no error, the following messages are shown on the console:
            *  "status": "OK",
            *  "message": "Single Event simulation started successfully"
3. When publishing the events,
http-request sink will send the request to the http server and the server will echo the received request as the response with a 200 http status code.
Then,
- That successful response will be received by the defined http-response source which has the relevant http status code.
- Received response will be converted to a siddhi event using using json default mapping and pushed to the ResponseStream.

## Viewing the Results:
The received responses will be logged in the terminal/editor console as following.

* INFO {io.siddhi.core.stream.output.sink.LogSink} - RequestResponse : responseStream : Event{timestamp=1555358941592, data=[toffees, 75.6], isExpired=false}

## Notes:
If the message "LowProductionAlertStream' stream could not connect to 'localhost:8080", it could be due to port 8080
defined in the Siddhi application is already being used by a different program. To resolve this issue, do the following:
1. Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop').
2. Change the port from 8080 to an unused port in this Siddhi application's source configuration and in the http-server file.
3. Start the application and check whether the expected output appears on the console.

```sql
@App:name("HttpRequestResponseSample")
@App:description("Publish http requests, receive their responses and process them")


define stream SweetProductionStream (name string, amount double);

@sink(type='http-request', sink.id='production-request', publisher.url='http://localhost:8080/abc',
@map(type='json'))
define stream LowProductionAlertStream (name string, amount double);

@sink(type='log')
@source(type='http-response' , sink.id='production-request', http.status.code='200',
@map(type='json'))
define stream ResponseStream(name string, amount double);

@info(name='query1')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```