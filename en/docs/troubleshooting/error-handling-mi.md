# Error codes in Micro Integrator

This section describes error codes and their meanings.

## Transport Error Codes

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

``` java
Error code = Base error code + Protocol State
```

The sender side of the transport matches the protocol state, which
changes according to the phase of the message.

Following are the possible protocol states and the description for each:

| Protocol State     | Description                                                |
|--------------------|------------------------------------------------------------|
| REQUEST_READY (0) | Connection is at the initial stage ready to send a request |
| REQUEST_HEAD(1)   | Sending the request headers through the connection         |
| REQUEST_BODY(2)   | Sending the request body                                   |
| REQUEST_DONE(3)   | Request is completely sent                                 |
| RESPONSE_HEAD(4)  | The connection is reading the response headers             |
| RESPONSE_BODY(5)  | The connection is reading the response body                |
| RESPONSE_DONE(6)  | The response is completed                                  |
| CLOSING(7)         | The connection is closing                                  |
| CLOSED(8)          | The connection is closed                                   |

Since there are several possible protocol states in which a request can
time out, you can calculate the error code accordingly using the values
in the table above. For example, in a scenario where you send a request
and the request is completely sent to the backend, but a timeout happens
before the response headers are received, the error code is calculated
as follows:

In this scenario, the base error code is
`         CONNECTION_TIMEOUT(101504)        ` and the protocol state is
`         REQUEST_DONE(3).        `

Therefore, Error code = 101504 + 3 = 101507

## Endpoint Error Codes

This section describes the error codes for endpoint failures. For more information on handling endpoint errors, see [Endpoint Error Handling]({{base_path}}/reference/synapse-properties/endpoint-properties/#endpoint-error-handling-properties).

### General errors

| **Error Code** | **Detail**                                    |
|----------------|-----------------------------------------------|
| 303000         | Load Balance endpoint is not ready to connect |
| 303000         | Recipient List Endpoint is not ready          |
| 303000         | Failover endpoint is not ready to connect     |
| 303001         | Address Endpoint is not ready to connect      |
| 303002         | WSDL Address is not ready to connect          |

### Failure on endpoint in the session

| **Error Code** | **Detail**                                                    |
|----------------|---------------------------------------------------------------|
| 309001         | Session aware load balance endpoint, No ready child endpoints |
| 309002         | Session aware load balance endpoint, Invalid reference        |
| 309003         | Session aware load balance endpoint, Failed session           |

### Non-fatal warnings

| **Error Code** | **Detail**                                     |
|----------------|------------------------------------------------|
| 303100         | A failover occurred in a Load balance endpoint |
| 304100         | A failover occurred in a Failover endpoint     |

### Referring real endpoint is null

| **Error Code** | **Detail**                  |
|----------------|-----------------------------|
| 305100         | Indirect endpoint not ready |

### Callout operation failed

| **Error Code** |   **Detail**                                                                     |
|----------------|-------------------------------------------------------------------------------------------------|
| 401000         | Callout operation failed (from the Callout mediator)                                            |
| 401001         | Blocking call operation failed (from the Call mediator when you have enabled blocking in it).   |
| 401002         | Blocking sender operation failed (from the Call mediator when you have enabled blocking in it). |

## Custom Error Codes

| **Error Code** |   **Detail**                                                                                    |
|----------------|-------------------------------------------------------------------------------------------------|
| 500000         | Endpoint Custom Error - This error is triggered when the endpoint is prefixed by `<property>name="FORCE_ERROR_ON_SOAP_FAULT" value="true"/>`, which enhances the failover logic by marking an endpoint as suspended when the response is a SOAP fault. |
