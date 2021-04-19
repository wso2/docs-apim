# Error Handling

When errors/exceptions occur in the system, the API Manager throws
XML-based error responses to the client by default. To change the format
of these error responses, you change the relevant XML file in the
`<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences        `
directory. The directory includes multiple XML files, named after the
type of errors that occur. You must select the correct file.

For example, to change the message type of authorization errors, open
the
`<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/_auth_failure_handler_.xml`
file and change `application/xml` to something like
**`application/json`** .

``` xml
    <sequence name="_auth_failure_handler_" xmlns="http://ws.apache.org/ns/synapse">
     <property name="error_message_type" value="application/json"/>
     <sequence key="_cors_request_handler_"/>
    </sequence>
```

Similarly, to change the error messages of throttling errors (e.g.,
quota exceeding), change the
`_throttle_out_handler_.xml` file, for resource mismatch
errors, the `_resource_mismatch_handler_.xml` file etc.

-   [API handlers error codes](#api-handlers-error-codes)
-   [Sequences error codes](#sequences-error-codes)
-   [Transport error codes](#transport-error-codes)
-   [Custom error messages](#custom-error-messages)

Given below are some error codes and their meanings.

### API handlers error codes

<table>
<thead>
<tr class="header">
<th>Error code</th>
<th>Error Message</th>
<th>Description</th>
<th>Example</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>700700</code></td>
<td>API blocked</td>
<td>This API has been blocked temporarily. Please try again later or contact the system administrators.</td>
<td>Invoke an API which is in the <strong>BLOCKED</strong> lifecycle state</td>
</tr>
<tr class="even">
<td><code>900422</code></td>
<td>Invalid GraphQL query</td>
<td>Syntax of the provided GraphQL query is invalid</td>
<td>Invoking a GraphQL api which has a invalid query</td>
</tr>
<tr class="odd">
<td> <code>900800</code> </td>
<td>Message throttled out</td>
<td><p>The maximum number of requests that can be made to the API within a designated time period is reached and the API is throttled for the user.</p></td>
<td>Invoke an API exceeding the tier limit</td>
</tr>
<tr class="even">
<td> <code>900801</code> </td>
<td>Hard limit exceeded</td>
<td>Hard throttle limit has been reached</td>
<td>Invoke an API exceeding the hard throttle limit</td>
</tr>
<tr class="odd">
<td><code>900802</code></td>
<td>Resource level throttle out</td>
<td>Message is throttled out because resource level has exceeded</td>
<td>Sending/Receiving messages beyond authorized resource level</td>
</tr>
<tr class="even">
<td><code>900803</code></td>
<td>Application level throttle out</td>
<td>Message is throttled out because application level is exceeded</td>
<td><p>Sending/Receiving messages beyond authorized application level</p></td>
</tr>
<tr class="odd">
<td><code>900804</code></td>
<td>Subscription level throttled out</td>
<td>Message throttled out due to subscription level throttling limit reached.</td>
<td>Sending/Receiving messages beyond configured throttling limit of subscription level policy.</td>
</tr>
<tr class="even">
<td><code>900805</code></td>
<td>Message blocked</td>
<td>Accessing an API which is blocked on user, IP, application, or API Context.</td>
<td>An admin user can block API invocations in real time by user, IP, application, or API context. The API invocation meets the blocked condition.</td>
</tr>
<tr class="odd">
<td><code>900806</code></td>
<td>Custom policy throttled out</td>
<td>Message throttled out due to exceeding the limit configured through the custom throttling policy rules.</td>
<td>The API invocations meet custom throttle policy rules, exceeding the limits of the configured custom policy.</td>
</tr>
<tr class="even">
<td><code>900807</code></td>
<td>Message throttled out</td>
<td>Messaged throttled out because of exceeding the burst control/rate limit (requests per second) in the subscription level policy.</td>
<td>Sending/Receiving messages exceeding the configured burst control/rate limit within second.</td>
</tr>
<tr class="odd">
<td> <code>900900</code> </td>
<td><p>Unclassified authentication failure</p></td>
<td>An unspecified error has occurred</td>
<td>Backend service for key validation is not accessible when trying to invoke an API</td>
</tr>
<tr class="even">
<td><code>900901</code></td>
<td><p>Invalid credentials</p></td>
<td><div class="content-wrapper">
<p>Invalid authentication information provided.</p>

<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The error code <code>900904</code> (Access token inactive) is deprecated from API Manager 1.9.0 onwards. Alternatively, error code <code>900901</code> will be sent when the token is inactive.</p>

</div>
</div></td>
<td>When the access token is invalid, inactive or expired.</td>
</tr>
<tr class="odd">
<td><code>900902</code> </td>
<td><p>Missing credentials</p></td>
<td>No authentication information provided</td>
<td>Accessing an API without <strong>Authorization: Bearer</strong> header</td>
</tr>
<tr class="even">
<td><code>900905</code></td>
<td><p>Incorrect access token type is provided</p></td>
<td><p>The access token type used is not supported when invoking the API. The supported access token types are application and user accesses tokens. See <a href="https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-Accesstokens">Access Tokens</a> .</p></td>
<td>Invoke an API with application token, where the resource only allows application user tokens</td>
</tr>
<tr class="odd">
<td><code>900906</code> </td>
<td><p>No matching resource found in the API for the given request</p></td>
<td>A resource with the name in the request can not be found in the API.</td>
<td>Invoke an API resource that is not available</td>
</tr>
<tr class="even">
<td> <code>900907</code> </td>
<td><p>The requested API is temporarily blocked</p></td>
<td>Happens when the API user is blocked.</td>
<td>Invoke API resource with a subscription that has been blocked by the API publisher</td>
</tr>
<tr class="odd">
<td><code>900908</code> </td>
<td><p>Resource forbidden</p></td>
<td>The user invoking the API has not been granted access to the required resource.</td>
<td>Invoke an unsubscribed API</td>
</tr>
<tr class="even">
<td><code>900909</code></td>
<td><p>The subscription to the API is inactive</p></td>
<td>The status of the API has changed to an inaccessible/unavailable state.</td>
<td>Invoke an API resource with a subscription that has not yet been approved by the administrator.</td>
</tr>
<tr class="odd">
<td><code>900910</code></td>
<td><p>The access token does not allow you to access the requested resource</p></td>
<td><p>Can not access the required resource with the provided access token. Check the valid resources that can be accessed with this token.</p></td>
<td>Invoke API resource with an access token that is not generated to be used with the resource's scope.</td>
</tr>
<tr class="even">
<td><code>102511</code></td>
<td>Incomplete payload</td>
<td>The payload sent with the request is too large and the client is unable to keep the connection alive until the payload is completely transferred to the API Gateway</td>
<td>Sending a large PDF file with the POST request</td>
</tr>
</tbody>
</table>

###  Sequences error codes

<table>
<thead>
<tr class="header">
<th>Error code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td> <code>900901</code> </td>
<td>Production/sandbox key offered to the API with no production/sandbox endpoint</td>
</tr>
<tr class="even">
<td> <code>400</code> </td>
<td>Server cannot process the request due to an error in the request sent by the client</td>
</tr>
<tr class="odd">
<td> <code>403</code> </td>
<td>No matching resource found in the API for the given request</td>
</tr>
</tbody>
</table>

In addition to the above error codes, we have engaged Synapse-level
error codes to the default fault sequence and custom fault sequences
(e.g., `_token_fault_.xml` ) of the API Manager. For
information, see [Error
Handling](https://ei.docs.wso2.com/en/latest/micro-integrator/references/error_handling/) in WSO2
Enterprise Integrator (WSO2 EI) documentation.

!!! info

    The HTTP Status Codes and the corresponding error codes from the error responses are given below.

    | HTTP Status Code | Error Code                                             |
    |------------------|--------------------------------------------------------|
    | 400              | 102511                                                 |
    | 401              | 900901, 900902, 900905, 900907, 900909, 900911                 |
    | 403              | 900906, 900908, 900910                                 |
    | 422              | 900422                                |
    | 429              | 900800, 900802, 900803, 900804, 900805, 900806, 900807 |
    | 500              | 900900                                                 |
    | 503              | 700700, 900801                                         |


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

If the HTTP PassThrough transport is used, and a connection-level error
occurs, the error code is calculated using the following equation:

`Error code = Base error code + Protocol State`

There is a state machine in the transport sender side, where the
protocol state changes according to the phase of the message.

Following are the possible protocol states and the description for each:

<table>
<thead>
<tr class="header">
<th><div>
<div>
Protocol State
</div>
</div></th>
<th><div>
<div>
Description
</div>
</div></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>REQUEST_READY (0)</td>
<td>Connection is at the initial stage ready to send a request</td>
</tr>
<tr class="even">
<td>REQUEST_HEAD(1)</td>
<td>Sending the request headers through the connection</td>
</tr>
<tr class="odd">
<td>REQUEST_BODY(2)</td>
<td>Sending the request body</td>
</tr>
<tr class="even">
<td>REQUEST_DONE(3)</td>
<td>Request is completely sent</td>
</tr>
<tr class="odd">
<td>RESPONSE_HEAD(4)</td>
<td>The connection is reading the response headers</td>
</tr>
<tr class="even">
<td>RESPONSE_BODY(5)</td>
<td>The connection is reading the response body</td>
</tr>
<tr class="odd">
<td>RESPONSE_DONE(6)</td>
<td>The response is completed</td>
</tr>
<tr class="even">
<td>CLOSING(7)</td>
<td>The connection is closing</td>
</tr>
<tr class="odd">
<td>CLOSED(8)</td>
<td>The connection is closed</td>
</tr>
</tbody>
</table>

Since there are several possible protocol states in which a request can
time out, you can calculate the error code accordingly using the values
in the table above. For example, in a scenario where you send a request
and the request is completely sent to the backend, but a timeout happens
before the response headers are received, the error code is calculated
as follows:

In this scenario, the base error code is
`CONNECTION_TIMEOUT(101504)` and the protocol state is
`REQUEST_DONE(3).        `

Therefore,

Error code = 101504 + 3 = 101507

These Transport error codes are used in [Advanced Configurations of
Endpoints](/../../../../learn/design-api/endpoints/endpoint-types/)
.

### Custom error messages

To send a custom message with a custom HTTP status code, you execute an
additional sequence that can generate a new error message. You then
override the message body, HTTP status code and other values.

The following steps demonstrate how to override a throttled-out
message's HTTP status code as a custom error message:

1.  Start the WSO2 API Manager.

2.  Go to `<API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences`
    directory and create the file `convert.xml` as follows.

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

        Alternatively, you can use the **Source View** of the API-M Management Console as follows to edit the synapse configuration:

          1. Sign in to the Management Console.(https://<Server Host\>:9443/carbon).
          2. Go to **Manager** and then **Source View**.
          3. Copy the content of the sequence in convert.xml, paste it as a new sequence in the source view and update it.
    

3.  Check the terminal logs to see whether there are issues in the
    deployment.  
    If the deployment is successful, you see a message similar to the
    following in the system logs:

    ``` java
     INFO - DependencyTracker Sequence : convert was added to the Synapse configuration successfully
     INFO - SequenceDeployer Sequence named 'convert' has been deployed from file : <API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/convert.xml
    ```

4.  Include the sequence that you just deployed in a sequence of your choice.
    For this example, let's add this custom sequence in the `_auth_failure_handler_` sequence.

    ``` java
     <sequence name="_auth_failure_handler_" xmlns="http://ws.apache.org/ns/synapse">
         ...
         <sequence key="convert"/>
         <drop/>
     </sequence>
    ```

5.  Check the terminal and see whether there are any errors with the
`_auth_failure_handler_` sequence deployment.  
    If the deployment is successful, you see a message similar to the
    following in the system logs:

    ``` java
      INFO - DependencyTracker Sequence : _auth_failure_handler_ was added to the Synapse configuration successfully
      INFO - SequenceDeployer Sequence: _auth_failure_handler_ has been updated from the file: <API-M_HOME>/repository/deployment/server/synapse-configs/default/sequences/_auth_failure_handler_.xml
    ```

6.  Invoke the API with the respective criteria in order to trigger the
    sequence.  
    In this example, let's view the menu on the PizzaShack API and
    invoke the API with an incorrect token.
    
    ```tab="Format"
     curl -v -H "Authorization: Bearer <Access_Token>" http://localhost:8280/<API_name>/<version>/<context>     
    ```
    
    ```tab="Example"
     curl -k -v -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer fb119e84-9542-3194-93dc-1ddddaaa1111"     
    ```
    
    ```tab="Sample Response"
      > GET /pizzashack/1.0.0/menu HTTP/1.1
      > Host: localhost:8243
      > User-Agent: curl/7.54.0
      > accept: application/json
      > Authorization: Bearer fb119e84-9542-3194-93dc-1ddddaaa1111
      > 
      < HTTP/1.1 555 
      < Access-Control-Allow-Origin: *
      < Access-Control-Allow-Methods: GET
      < Access-Control-Allow-Headers: authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction
      < Content-Type: application/json; charset=UTF-8
      < Date: Fri, 04 Jan 2019 09:53:56 GMT
      < Transfer-Encoding: chunked
      < 
      {"fault":{"code":900901,"type":"Status report","message":"Runtime Error","description":"Invalid Credentials"}}   
    ```

WSO2 API Manager has the following default fault sequences located in
`<API-M_HOME>        `
`/repository/deployment/server/synapse-configs/default/sequences        `
directory.

| Fault Sequence                                            | Description                                                                                                                                                                                                                                                   |
|-----------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `fault.xml`| This is the primary fault sequence that gets invoked when an error occurs during the execution of an API resources                                                                                                                                            |
| `main.xml`| This sequence is called when the endpoint being called does not exist                                                                                                                                                                                         |
| `_auth_failure_handler_.xml`| This sequence is called when an API authentication error is encountered                                                                                                                                                                                       |
| `_production_key_error_.xml`| This sequence is called when a Production key is used to invoke an API that does not have a Production endpoint defined                                                                                                                                       |
| `_sandbox_key_error_.xml`| This sequence is called when a Sandbox key is used to invoke an API that does not have a Sandbox endpoint defined                                                                                                                                             |
| `_throttle_out_handler_.xml`| This sequence is called when a given request to an API gets throttled out                                                                                                                                                                                     |
| `_token_fault_.xml`| This sequence is called when there is an error in invoking the token API                                                                                                                                                                                      |
| `_resource_mismatch_handler_.xml` | This sequence is called when a matching resource cannot be found by the gateway to the corresponding resource being invoked                                                                                                                                   |
| `_cors_request_handler_.xml`| This sequence enables sending CORS specific headers when the CORS specific configuration ( `CORSConfiguration` ) is enabled in WSO2 API Manager in the `<API-M_HOME>/repository/conf/deployment.toml` file. |
| `_threat_fault_.xml`| This sequence is called to send error messages with regard to threat detection.                                                                                                                                                                               |
| `dispatchSeq.xml`| This sequence is defined as a default handler for any inbound WebSocket calls.                                                                                                                                                                                |
| `outDispatchSeq.xml`| This sequence is defined to handle any outbound WebSocket calls.                                                                                                                                                                                              |

!!! info

    The default sequences can also be customized as shown in the section above. 
