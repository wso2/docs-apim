# Publishing HTTP Events to to an OAuth-protected Endpoint

## Purpose

This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send HTTP events to an OAuth-protected endpoint.

!!! tip "Before you begin!"
    1. Replace the Sink configuration values for following options.<br/><br/>    
        | **Parameter**     | **Description**                                                                              |
        |-------------------|----------------------------------------------------------------------------------------------|
        | `publisher.url`   | The publisher URL (e.g., `https://localhost:8005/abc`).                                      |
        | `consumer.key`    | The consumer key for the http request (e.g., `abcdef`).                                      |
        | `consumer.secret` | The consumer secret for the http request (e.g., `abcdef`).                                   |
        | `token.url`       | The URL of the token end point (e.g., `https://localhost:8005/token`).                       |
        | `method`          | The method type (e.g., POST). This is an optional parameter. You can specify a value if you want to use a method different to the default method. |
        | `header` (Authorization header) | The access token for the API endpoint request (e.g., `abcdef` is the default value.). It automatically gets the access token using the password/client-credential/refresh grant. Here, the grant type depends on the user input. |
        | `https.truststore.file` | The API trust store path (e.g., `/user/../../../client-truststore.jks` is the default value. It is a file in the product pack (e.g., `<SI_HOME>/resources/security/client-truststore.jks`). |
        | `https.truststore.password` | The API trust store password. This is `wso2carbon` by default. |
        <br/><br/>
    2. Save this sample. If there is no syntax error, the Streaming Integrator logs the following message in the terminal.
	 
## Prerequisites

1. Replace the Sink configuration values for following options.

    | **Parameter**     | **Description**                                                                              |
    |-------------------|----------------------------------------------------------------------------------------------|
    | `publisher.url`   | The publisher URL (e.g., `https://localhost:8005/abc`).                                      |
    | `consumer.key`    | The consumer key for the http request (e.g., `abcdef`).                                      |
    | `consumer.secret` | The consumer secret for the http request (e.g., `abcdef`).                                   |
    | `token.url`       | The URL of the token end point (e.g., `https://localhost:8005/token`).                       |
    | `method`          | The method type (e.g., POST). This is an optional parameter. You can specify a value if you want to use a method different to the default method. |
    | `header` (Authorization header) | The access token for the API endpoint request (e.g., `abcdef` is the default value.). It automatically gets the access token using the password/client-credential/refresh grant. Here, the grant type depends on the user input. |
    | `https.truststore.file` | The API trust store path (e.g., `/user/../../../client-truststore.jks` is the default value. It is a file in the product pack (e.g., `<SI_HOME>/resources/security/client-truststore.jks`). |
    | `https.truststore.password` | The API trust store password. This is `wso2carbon` by default. |


2. Save this sample. If there is no syntax error, the Streaming Integrator logs the following message in the terminal.

    `Siddhi App PublishHttpOAuthRequest successfully deployed.`

## Executing the Sample

To execute the sample open the saved Siddhi application in Streaming Integrator Tooling, and start it by clicking the **Start** button (shown below) or by clicking **Run** -> **Run**.

![Start button]({{base_path}}/assets/img/streaming/amazon-s3-sink-sample/start.png)

If the Siddhi application starts successfully, the Streaming Integrator logs the following messages in the terminal.

```
PublishHttpOAuthRequest.siddhi - Started Successfully!
```

```
'Http' sink at LowProductionAlertStream stream successfully connected to 'https://localhost:8005/abc'.
```

## Executing and testing the Sample

Send events via one or more of the following methods:

* Send events via the HTTP server through the event simulator:

    1. To open the Event Simulator, click the **Event Simulator** icon.
       
        ![Event Simulator Icon]({{base_path}}/assets/img/streaming/testing-siddhi-applications/event-simulation-icon.png)
       
        This opens the event simulation panel.
        
	2. In the **Single Simulation** tab of the panel, specify the values for the fields as follows:
	
	    | **Field Name**      | **Value**                 |
	    |---------------------|---------------------------|
	    | **Siddhi App Name** | `PublishHttpOAuthRequest` |
	    | **Stream Name**     | `SweetProductionStream`   |

    3. In the **name** and **amount** fields, enter `toffees` and `75.6` respectively and then click **Send** to send the event.
    
    4. Repeat the steps above to create as many events as required.

* Send events to the HTTP endpoint defined via the `publish.url` parameter in the Sink configuration by issuing CURL commands. The following is a sample CURL command:
    
    ```
    curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishHttpOAuthRequest","data": ['toffees', 75.6]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
    ```
       
    If no error occurs, the Streaming Integrator logs the following in the terminal.

    ```
    {"status":"OK","message":"Single Event simulation started successfully"}
    ```

* Publish events with Postman:

    1. Install the Postman application from the Chrome web store.
    
    2. Launch the application.
    
    3. Make a `Post` request to the `http://localhost:9390/simulation/single` endpoint. Set the Content-Type to `text/plain` and set the request body in text as follows:
    
        ```
        {"streamName": "SweetProductionStream", "siddhiAppName": "PublishHttpOAuthRequest","data": ['toffees', 75.6]}
        ```
       
    4. Click **Send**. If there is no error, the following messages are logged in the terminal.
    
        ```
        "status": "OK",
        ```
       
        ```
        "message": "Single Event simulation started successfully"
        ```

## Viewing the Results

The following is logged in ther terminal.

```
Siddhi App test successfully deployed.
INFO {org.wso2.extension.siddhi.io.http.sink.HttpSink} - Request sent successfully to https://localhost:8005/abc
[java] [org.wso2.si.http.server.HttpServerListener] : Event Name Arrived: {"event":{"name":"toffees","amount":75.6}}
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Names:{"event":{"name":"toffees","amount":75.6}} ,
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Headers key set:[Http_method, Content-type, Content-length]
[java] [org.wso2.si.http.server.HttpServerMain] : Received Event Headers value set:[[POST], [application/json], [42]]
```

## Notes

- If the termianl logs `Error when pushing events to Siddhi debugger engine`, it could be due to a timeout issue. To address it, follow the steps below:

    1. Stop the Siddhi application by clicking the **Stop** icon.
    
    2. Start the application and check whether the expected output appears in the terminal.

- If the terminal logs `401`, it could be due to passing an invalid parameter. To address this, follow the steps below:

    1. Stop the Siddhi application by clicking the **Stop** icon.
    
    2. Recheck the all the parameters you are passing to identify the invalid parameter, and then correct it as relevant.
    
    3. Start the application and check whether the expected output appears on the terminal.

- If the terminal logs `500`, it could be due to internal server error issues. To address this, follow the steps below:

    1. Stop the Siddhi application by clicking the **Stop** icon.
    
    2. Start the application and check whether the expected output appears in the terminal.

??? info "Click here to view the sample Siddhi application."
    ```sql
    @App:name("PublishHttpOAuthRequest")
    @App:description("Send HTTP events to an OAuth-protected endpoint")
       
    define stream SweetProductionStream (name string, amount double);
    
    @sink(type='http', method="xxxxx", publisher.url='https://localhost:8005/abc',
    headers="'Authorization:  Bearer xxxxxxxxx'", consumer.key="xxxxxxxxxx", consumer.secret="xxxxxxxxxxx",
    token.url='https://localhost:8005/token',@map(type='json', @payload( "{'name': {{name}}, 'amount': {{amount}}}")))
    define stream LowProductionAlertStream (name string, amount double);
    
    @info(name='query1')
    from SweetProductionStream
    select *
    insert into LowProductionAlertStream;
    ```