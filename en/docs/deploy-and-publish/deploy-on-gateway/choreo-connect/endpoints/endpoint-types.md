# Endpoint Types

Choreo Connect supports a range of different endpoint types, allowing the it to connect with
  advanced types of backends.

|Type                     |Description                                                                                                                                                                                                                                                                                                                                                                                                       |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTP/ REST Endpoint     | A REST service endpoint based on a URI template.   |                  
| WebSocket Endpoint    | A HTTP based streaming endpoint implemented based on the WebSocket protocol. Once a connection is  established with the endpoint, a channel that enables two way communication is created providing pub sub capabilities. |                                                                                                                 
| Prototype Endpoint   | Prototype endpoint is a type of HTTP Endpoint which can be used when Prototyping an API (for promoting and testing). For instructions, see [Deploy and Test Mock APIs]({{base_path}}/design/prototype-api/deploy-and-test-mock-apis/).                                                                                                                                                                                                                                                                              |


!!! note
    - **Prototype Endpoints** will be available only for the APIs which are in **PROTOTYPED** state.






