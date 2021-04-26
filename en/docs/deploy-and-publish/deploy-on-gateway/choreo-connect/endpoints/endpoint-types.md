# Endpoint Types

An Endpoint is a specific destination for a message such as an address, WSDL, a failover group, a load-balance group
 etc. Choreo Connect supports a range of different endpoint types, allowing the it to connect with
  advanced types of back-ends.

|Type                     |Description                                                                                                                                                                                                                                                                                                                                                                                                       |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTP/ REST Endpoint     | A REST service endpoint based on a URI template.                                                                                                                                                                                                                                                                                                                                                         |
| gRPC Endpoint           | A high performance RPC framework to implement services
| HTTP/ SOAP Endpoint      | The direct URL of the SOAP web service.                                                                                                                                                                                                                                                                                                                                                                             |
| Failover Group Endpoint | The endpoints that the service tries to connect to in case of a failure. Selecting the endpoint when the primary endpoint fails, happens in a round-robin manner. Failover Group is a group of leaf endpoints (i.e., address endpoint, HTTP endpoint, and WSDL endpoint). When a failure occurs in the current endpoint (while sending a message), the failover group endpoint will try to send the message to another endpoint. The failover group ensures that the message is delivered as long as there is at least one active endpoint among the listed endpoints.                              |
| Load Balance Endpoint   | The endpoints where the incoming requests are directed to in a round-robin manner. They automatically handle fail-over as well.                                                                                                                                                                                                                                                                            |
| Prototype Endpoint   | Prototype endpoint is a type of HTTP Endpoint which can be used when Prototyping an API (for promoting and testing). For instructions, see [Deploy and Test Mock APIs]({{base_path}}/design/prototype-api/deploy-and-test-mock-apis/).                                                                                                                                                                                                                                                                              |


!!! note
    - **Prototype Endpoints** will be available only for the APIs which are in **PROTOTYPED** state.






