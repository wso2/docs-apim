# Publishing HTTP Events via an OAuth-protected Endpoint

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to sending an HTTP event via an OAuth
protected endpoint and catching its response.
## Prerequisites:
1. Replace the Sink configuration values for following options.
    - publisher.url : publisher URL (Ex:- 'https://localhost:8005/abc')
    - consumer.key  : consumer key for the http request (Ex:- 'abcdef')
    - consumer.secret: consumer secret for the http request (Ex:- 'abcdef')
    - token.url     : URL of the token end point (Ex:-'https://localhost:8005/token')
    - method        : method type (Eg:- POST)

    optional (You can fill this if it is different from default values )
    - header (Authorization header)  : access token for the http request (Ex:- 'abcdef') <= by default
    it automatically get the access token using the password/client-credential/refresh grant. Here the 
    grantype depends on the user input.
    - https.truststore.file : API trust store path (Ex:- '/user/../../../client-truststore.jks') <= by default
    it get from product pack (Ex:- ${carbon.home}/resources/security/client-truststore.jks)
    - https.truststore.password :  API trust store password (wso2carbon) <= by default it set as wso2carbon

2. Save this sample. If there is no syntax error, the following message is shown on the console:
    * Siddhi App PublishHttpOAuthRequestResponse successfully deployed.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages are shown on the console:
    * PublishHttpOAuthRequestResponse.siddhi - Started Successfully!
    * 'Http' sink at 'LowProductionAlertStream' stream successfully connected to 'https://localhost:8005/abc'.

## Testing the Sample:
Send events through one or more of the following methods:
* Send events with http server through the event simulator:
    1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
	2. In the Single Simulation tab of the panel, specify the values as follows:
        * Siddhi App Name  : PublishHttpOAuthRequestResponse
        * Stream Name     : SweetProductionStream
    3. In the name and amount fields, enter 'toffees' and '75.6' respectively and then click Send to send the event.
    4. Send some more events as desired.

* Send events to the HTTP endpoint defined by 'publish.url' in the Sink configuration using the curl command:
    1. Open a new terminal and issue the following command:
        * curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishHttpOAuthRequestResponse","data": ['toffees', 75.6]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
    2. If there is no error, the following messages are shown on the terminal:
        *  {"status":"OK","message":"Single Event simulation started successfully"}

* Publish events with Postman:
    1. Install the 'Postman' application from the Chrome web store.
    2. Launch the application.
    3. Make a 'Post' request to the 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to 'text/plain' and set the request body in text as follows:
	{"streamName": "SweetProductionStream", "siddhiAppName": "PublishHttpOAuthRequestResponse","data": ['toffees', 75.6]}
    4. Click 'send'. If there is no error, the following messages are shown on the console:
        *  "status": "OK",
        *  "message": "Single Event simulation started successfully"

## Viewing the Results:
See the output on the terminal:
```
Siddhi App test successfully deployed.
INFO {org.wso2.extension.siddhi.io.http.sink.HttpSink} - Request sent successfully to https://localhost:8005/abc
[java] [org.wso2.si.http.server.HttpServerListener] : Event Name Arrived: {"event":{"name":"toffees","amount":75.6}}
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Names:{"event":{"name":"toffees","amount":75.6}} ,
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Headers key set:[Http_method, Content-type, Content-length]
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Headers value set:[[POST], [application/json], [42]]
```

## Notes:
If you get the message "Error when pushing events to Siddhi debugger engine', it could be due to time out problem, do the following:
1. Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop').
2. Start the application and check whether the expected output appears on the console.

If you get the message "401", it could be due to passing invalid parameter problem, do the following:
1. Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop').
2. Recheck the all parameter you are passing and change the correct parameter
3. Start the application and check whether the expected output appears on the console.

If you get the message "500", it could be due to Internal server error problem, do the following:
1. Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop').
2. Start the application again and check whether the expected output appears on the console.


```sql
@App:name("PublishHttpOAuthRequestResponse")
@App:description("sending an HTTP event via an OAuth protected endpoint and catching its response.")

 define stream SweetProductionStream (name string, amount double);

 @sink(type='http-request', sink.id='abc', publisher.url='https://localhost:8005/abc',
 headers="'Authorization:  Bearer xxxxxxxxxxxxx'", method="xxxxx", consumer.key="xxxxxx",
 consumer.secret="xxxxxxx",token.url='https://localhost:8005/token', @map(type='json'),
 @payload( "{'name': {{name}}, 'amount': {{amount}}}"))
 define stream LowProductionAlertStream (name String, amount double);

 @source(type='http-response' , sink.id='abc', http.status.code='200',
 @map(type='text', regex.A='((.|
)*)', @attributes(message='A[1]')))
 define stream ResponseLowProductionAlertStream(message string);

 @sink(type='log')
 define stream loggerStream(message string);

 @info(name='query1')
 from SweetProductionStream
 select *
 insert into LowProductionAlertStream;

 @info(name='query2')
 from ResponseLowProductionAlertStream
 select *
 insert into loggerStream;
```