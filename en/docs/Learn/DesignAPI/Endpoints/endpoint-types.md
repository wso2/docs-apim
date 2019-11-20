# Endpoint Types

An Endpoint is a specific destination for a message such as an address, WSDL, a failover group, a load-balance group
 etc. WSO2 API Manager supports a range of different endpoint types, allowing the API Gateway to connect with
  advanced types of back-ends.

|Type                     |Description                                                                                                                                                                                                                                                                                                                                                                                                       |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTP/ REST Endpoint     | A REST service endpoint based on a URI template.                                                                                                                                                                                                                                                                                                                                                           |
| HTTP/ SOAP Endpoint     | The direct URL of the soap web service.                                                                                                                                                                                                                                                                                                                                                                             |
| Failover Group Endpoint | The endpoints that the service tries to connect to in case of a failure. Selecting the endpoint when the primary endpoint get failed happens in a round robin manner. Failover Group is a group of leaf endpoints(i.e, address endpoint, HTTP endpoint and WSDL endpoint). The failover group endpoint try to send the message to another endpoint when failure occur in current endpoint (while sending a message). Failover group ensures that a message is delivered as long as there is at least one active endpoint among the listed endpoints.                              |
| Load Balance Endpoint   | The endpoints where the incoming requests are directed to in a round robin manner. They automatically handle fail-over as well.                                                                                                                                                                                                                                                                            |
| Dynamic Endpoint        | Using dynamic endpoint type, the requests can be dynamically routed to an address, based on a specific condition (ex: request parameters, payload etc). When using this endpoint type, a mediation sequence should be applied to the message ***IN Flow*** of the API. For more details of configuring APIs to change the default mediation flow, see [Adding Mediation Extensions](../../Extensions/adding-mediation-extensions.md) . |
| Prototype Endpoint      | Prototype endpoint is a type of HTTP Endpoint which can be used when Prototyping an API (for promoting and testing). Please refer [Deploy and Test Mock APIs](../MockAPI/deploy-and-test-mock-apis.md) for instructions. |
| Prototype Implementation      | ***Prototype implementation*** in WSO2 API Manager uses the built in Javascript engine of Synapse to mock the responses and can be used per HTTP resource of the API. For more information on Prototype Implementation, please refer [Create a Mock API with an Inline Script](../MockAPI/create-a-mock-api-with-an-inline-script.md) for more information. |

!!!note
    - ***Prototype Endpoints*** and ***Prototype Implementation*** will be available only for the APIs which are in 
    ***CREATED*** or ***PROTOTYPED*** state.

***Note the following:***

-   You can expose both REST and SOAP services to consumers through APIs.
-   You cannot call backend services secured with OAuth through APIs created in the API Publisher. At the moment, you
 can call only services secured with username/password (Basic Auth/ Digest Auth).
-   The system reads gateway endpoints from the `<API-M_HOME>/repository/conf/deployment.toml` file. When there are
 multiple gateway environments defined, it picks the gateway endpoint of the production environment. You can define both HTTP and HTTPS gateway endpoints as follows:

```toml
    [[apim.gateway.environment]]
    name = "Production Environment"
    type = "production"
    ...
    http_endpoint = "http://localhost:${http.nio.port}"
    https_endpoint = "https://localhost:${https.nio.port}"
```

If both types of endpoints are defined, the HTTPS endpoint will be picked as the server endpoint.

!!! tip
    When you define secure (HTTPS) endpoints, set the `HostnameVerifier` parameter to `AllowAll` in
     the `<API-M_HOME>/repository/conf/deployment.toml` file's HTTPS transport sender configuration.
     ```toml
         [transport.passthru_https.sender.parameters]
         HostnameVerifier = "AllowAll"
     ```
    If not, **the server throws an exception** .


