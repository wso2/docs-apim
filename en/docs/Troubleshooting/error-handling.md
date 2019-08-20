# Error Handling

When errors/exceptions occur in the system, the API Manager throws XML-based error responses to the client by default. To change the format of these error responses, you change the relevant XML file in the `         <         APIM_HOME         >/repository/deployment/server/synapse-configs/default/sequences        ` directory. The directory includes multiple XML files, named after the type of errors that occur. You must select the correct file.

For example, to change the message type of authorization errors, open the `         <APIM_HOME>/repository/deployment/server/synapse-configs/default/sequences/                   _auth_failure_handler.xml                 ` file and change `         application/xml        ` to something like **`          application/json         `** .

``` xml
    <sequence name="_auth_failure_handler_" xmlns="http://ws.apache.org/ns/synapse">
     <property name="error_message_type" value="application/json"/>
     <sequence key="_cors_request_handler_"/>
    </sequence>
```

Similarly, to change the error messages of throttling errors (e.g., quota exceeding), change the `         _throttle_out_handler_.xml        ` file; resource mismatch errors, the `         _resource_mismatch_handler_.xml        ` file, etc.

-   [API handlers error codes](#ErrorHandling-APIhandlerserrorcodes)
-   [Sequences error codes](#ErrorHandling-Sequenceserrorcodes)
-   [Transport error codes](#ErrorHandling-Transporterrorcodes)
-   [Custom error messages](#ErrorHandling-Customerrormessages)

Given below are some error codes and their meanings.

### API handlers error codes

| Error code                        | Error Message                                                        | Description                                                                                                                                                                                                                                    | Example                                                                                                                                        |
|-----------------------------------|----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| 700700                            | API blocked                                                          | This API has been blocked temporarily. Please try again later or contact the system administrators.                                                                                                                                            | Invoke an API which is in the **BLOCKED** lifecycle state                                                                                      |
| 900800                            | Message throttled out                                                | The maximum number of requests that can be made to the API within a designated time period is reached and the API is throttled for the user.                                                                                                   | Invoke an API exceeding the tier limit                                                                                                         |
| 900801                            | Hard limit exceeded                                                  | Hard throttle limit has been reached                                                                                                                                                                                                           | Invoke an API exceeding the hard throttle limit                                                                                                |
| `             900802            ` | Resource level throttle out                                          | Message is throttled out because resource level has exceeded                                                                                                                                                                                   | Sending/Receiving messages beyond authorized resource level                                                                                    |
| `             900803            ` | Application level throttle out                                       | Message is throttled out because application level is exceeded                                                                                                                                                                                 | Sending/Receiving messages beyond authorized application level                                                                                 |
| `             900804            ` | Subscription level throttled out                                     | Message throttled out due to subscription level throttling limit reached.                                                                                                                                                                      | Sending/Receiving messages beyond configured throttling limit of subscription level policy.                                                    |
| `             900805            ` | Message blocked                                                      | Accessing an API which is blocked on user, IP, application, or API Context.                                                                                                                                                                    | An admin user can block API invocations in real time by user, IP, application, or API context. The API invocation meets the blocked condition. |
| `             900806            ` | Custom policy throttled out                                          | Message throttled out due to exceeding the limit configured through the custom throttling policy rules.                                                                                                                                        | The API invocations meet custom throttle policy rules, exceeding the limits of the configured custom policy.                                   |
| `             900807            ` | Message throttled out                                                | Messaged throttled out because of exceeding the burst control/rate limit (requests per second) in the subscription level policy.                                                                                                               | Sending/Receiving messages exceeding the configured burst control/rate limit within second.                                                    |
| 900900                            | Unclassified authentication failure                                  | An unspecified error has occurred                                                                                                                                                                                                              | Backend service for key validation is not accessible when trying to invoke an API                                                              |
| 900901                            | Invalid credentials                                                  | Invalid authentication information provided                                                                                                                                                                                                    | Using an older access token after an access token has been renewed.                                                                            |
| 900902                            | Missing credentials                                                  | No authentication information provided                                                                                                                                                                                                         | Accessing an API without **Authorization: Bearer** header                                                                                      |
| 900905                            | Incorrect access token type is provided                              | The access token type used is not supported when invoking the API. The supported access token types are application and user accesses tokens. See [Access Tokens](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-Accesstokens) . | Invoke an API with application token, where the resource only allows application user tokens                                                   |
| 900906                            | No matching resource found in the API for the given request          | A resource with the name in the request can not be found in the API.                                                                                                                                                                           | Invoke an API resource that is not available                                                                                                   |
| 900907                            | The requested API is temporarily blocked                             | Happens when the API user is blocked.                                                                                                                                                                                                          | Invoke API resource with a subscription that has been blocked by the API publisher                                                             |
| 900908                            | Resource forbidden                                                   | The user invoking the API has not been granted access to the required resource.                                                                                                                                                                | Invoke an unsubscribed API                                                                                                                     |
| 900909                            | The subscription to the API is inactive                              | The status of the API has changed to an inaccessible/unavailable state.                                                                                                                                                                        | Invoke an API resource with a subscription that has not yet been approved by the administrator.                                                |
| 900910                            | The access token does not allow you to access the requested resource | Can not access the required resource with the provided access token. Check the valid resources that can be accessed with this token.                                                                                                           | Invoke API resource with an access token that is not generated to be used with the resource's scope.                                           |
| `             102511            ` | Incomplete payload                                                   | The payload sent with the request is too large and the client is unable to keep the connection alive until the payload is completely transferred to the API Gateway                                                                            | Sending a large PDF file with the POST request                                                                                                 |

!!! note
The error codes `         900903        ` (Access token expired) and `         900904        ` (Access token inactive) are deprecated from API Manager 1.9.0 onwards. Alternatively, error code `         900901        ` will be sent when the token is invalid or inactive.


### Sequences error codes

| Error code | Description                                                                         |
|------------|-------------------------------------------------------------------------------------|
| 900901     | Production/sandbox key offered to the API with no production/sandbox endpoint       |
| 400        | Server cannot process the request due to an error in the request sent by the client |
| 403        | No matching resource found in the API for the given request                         |

In addition to the above error codes, we have engaged Synapse-level error codes to the default fault sequence and custom fault sequences (e.g., `         _token_fault_.xml        ` ) of the API Manager. For information, see [Error Handling](https://docs.wso2.com/display/ESB500/Error+Handling) in WSO2 ESB documentation.

!!! info
The HTTP Status Codes and the corresponding error codes from the error responses are given below.

| HTTP Status Code | Error Code                             |
|------------------|----------------------------------------|
| 401              | 900901, 900902, 900905, 900907, 900909 |
| 403              | 900906, 900908, 900910                 |
| 429              | 900800                                 |
| 500              | 900900                                 |
| 503              | 700700, 900801                         |


### Transport error codes

| **Error Code** | **Detail**                                                                                            |
|----------------|-------------------------------------------------------------------------------------------------------|
| 101000         | Receiver input/output error sending                                                                   |
| 101001         | Receiver input/output error receiving                                                                 |
| 101500         | Sender input/output error sending                                                                     |
| 101501         | Sender input/output error receiving                                                                   |
| 101503         | Connection failed                                                                                     |
| 101504         | Connection timed out (no input was detected on this connection over the maximum period of inactivity) |
| 101505         | Connection closed                                                                                     |
| 101506         | NHTTP protocol violation                                                                              |
| 101507         | Connection canceled                                                                                   |
| 101508         | Request to establish new connection timed out                                                         |
| 101509         | Send abort                                                                                            |
| 101510         | Response processing failed                                                                            |

If the HTTP PassThrough transport is used, and a connection-level error occurs, the error code is calculated using the following equation:

|                                                                                  |
|----------------------------------------------------------------------------------|
| `                 Error code = Base error code + Protocol State                ` |

There is a state machine in the transport sender side, where the protocol state changes according to the phase of the message.

Following are the possible protocol states and the description for each:

| Protocol State     | Description                                                |
|--------------------|------------------------------------------------------------|
| REQUEST\_READY (0) | Connection is at the initial stage ready to send a request |
| REQUEST\_HEAD(1)   | Sending the request headers through the connection         |
| REQUEST\_BODY(2)   | Sending the request body                                   |
| REQUEST\_DONE(3)   | Request is completely sent                                 |
| RESPONSE\_HEAD(4)  | The connection is reading the response headers             |
| RESPONSE\_BODY(5)  | The connection is reading the response body                |
| RESPONSE\_DONE(6)  | The response is completed                                  |
| CLOSING(7)         | The connection is closing                                  |
| CLOSED(8)          | The connection is closed                                   |

Since there are several possible protocol states in which a request can time out, you can calculate the error code accordingly using the values in the table above. For example, in a scenario where you send a request and the request is completely sent to the backend, but a timeout happens before the response headers are received, the error code is calculated as follows:

In this scenario, the base error code is `         CONNECTION_TIMEOUT(101504)        ` and the protocol state is `         REQUEST_DONE(3).        `

Therefore,

Error code = 101504 + 3 = 101507

These Transport error codes are used in [Advanced Configurations of Endpoints](https://docs.wso2.com/display/AM2xx/Working+with+Endpoints#WorkingwithEndpoints-advanced) .

### Custom error messages

To send a custom message with a custom HTTP status code, you execute an additional sequence that can generate a new error message. You then override the message body, HTTP status code and other values.

The following steps demonstrate how to override a throttled-out message's HTTP status code as a custom error message:

1.  Go to `           <APIM_HOME>          ` `           /repository/deployment/server/synapse-configs/default/sequences          ` directory and create the file `           convert.xml          ` as follows.

    ``` xml
        <sequence xmlns="http://ws.apache.org/ns/synapse" name="convert">
            <payloadFactory media-type="xml">
                <format>
                    <am:fault xmlns:am="http://wso2.org/apimanager">
                        <am:code>$1</am:code>
                        <am:type>Status report</am:type>
                        <am:message>Runtime Error</am:message>
                        <am:description>$2</am:description>
                    </am:fault>
                </format>
                <args>
                    <arg evaluator="xml" expression="$ctx:ERROR_CODE"/>
                    <arg evaluator="xml" expression="$ctx:ERROR_MESSAGE"/>
                </args>
            </payloadFactory>
            <property name="RESPONSE" value="true"/>
            <header name="To" action="remove"/>
            <property name="HTTP_SC" value="555" scope="axis2"/>
            <property name="NO_ENTITY_BODY" scope="axis2" action="remove"/>
            <property name="ContentType" scope="axis2" action="remove"/>
            <property name="Authorization" scope="transport" action="remove"/>
            <property name="Access-Control-Allow-Origin" value="*" scope="transport"/>
            <property name="Host" scope="transport" action="remove"/>
            <property name="Accept" scope="transport" action="remove"/>
            <property name="X-JWT-Assertion" scope="transport" action="remove"/>
            <property name="messageType" value="application/json" scope="axis2"/>
            <send/>
        </sequence>
    ```

        !!! tip
    Alternatively, you can use the **Source View** of the APIm Management Console as follows to edit the synapse configuration:

    -   Start the API Manager and log in to the Management Console. ( `            https://<Server Host>:9443/carbon           ` ).
    -   Go to **Manager -&gt; Source View** .
    -   Copy the content of the sequence in `            convert.xml           ` , paste it as a new sequence in the source view and update it.


2.  Check the logs to see whether there are issues in the deployment.  If the deployment is successful, you see a message like the following in the system logs:

    \[2015-04-13 09:17:38,885\]  INFO - SequenceDeployer Sequence named 'convert' has been deployed from file : `           <APIM_HOME>/repository/deployment/server/synapse-configs/default/sequences/convert.xml          `

3.  Invoke the API until the throttling limit exceeds and the new requests get throttled out.

    ``` java
        curl -v -H "Authorization: Bearer <Access_Token>" http://localhost:8280/<API_name>/<context>/<version>
    ```

4.  Note that you get following response:

    ``` xml
            * About to connect() to 127.0.0.1 port 8280 (#0)
            *   Trying 127.0.0.1...
            * Adding handle: conn: 0x17a2db0
            * Adding handle: send: 0
            * Adding handle: recv: 0
            * Curl_addHandleToPipeline: length: 1
            * - Conn 0 (0x17a2db0) send_pipe: 1, recv_pipe: 0
            * Connected to 127.0.0.1 (127.0.0.1) port 8280 (#0)
            > GET /testam/sanjeewa/1.0.0 HTTP/1.1
            > User-Agent: curl/7.32.0
            > Host: 127.0.0.1:8280
            > Accept: */*
            > Authorization: Bearer 7f855a7d70aed820a78367c362385c86
            > 
            < HTTP/1.1 555 
            < Access-Control-Allow-Origin: *
            < Content-Type: application/json
            < Date: Mon, 13 Apr 2015 05:30:12 GMT
            * Server WSO2-PassThrough-HTTP is not blacklisted
            < Server: WSO2-PassThrough-HTTP
            < Transfer-Encoding: chunked
            < 
            * Connection #0 to host 127.0.0.1 left intact
            {"fault":{"code":"900800","type":"Status report","message":"Runtime Error","description":"Message throttled out"}}
    ```

WSO2 API Manager has the following default fault sequences located in `         <APIM_HOME>        ` `         /repository/deployment/server/synapse-configs/default/sequences        ` directory.

| Fault Sequence                                           | Description                                                                                                                 |
|----------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| `             fault.xml            `                     | This is the primary fault sequence that gets invoked when an error occurs during the execution of an API resources          |
| `             main.xml            `                      | This sequence is called when the endpoint being called does not exist                                                       |
| `             auth_failure_handler.xml            `      | This sequence is called when an API authentication error is encountered                                                     |
| `             production_key_error.xml            `      | This sequence is called when a Production key is used to invoke an API that does not have a Production endpoint defined     |
| `             sandbox_key_error.xml            `         | This sequence is called when a Sandbox key is used to invoke an API that does not have a Sandbox endpoint defined           |
| `             throttle_out_handler.xml            `      | This sequence is called when a given request to an API gets throttled out                                                   |
| `             token_fault.xml            `               | This sequence is called when there is an error in invoking the token API                                                    |
| `             resource_mismatch_handler.xml            ` | This sequence is called when a matching resource cannot be found by the gateway to the corresponding resource being invoked |

!!! info
The default sequences can also be customized as shown in the section above.


