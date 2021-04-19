# Endpoint Types

An Endpoint is a specific destination for a message such as an address, WSDL, a failover group, a load-balance group
 etc. WSO2 API Manager supports a range of different endpoint types, allowing the API Gateway to connect with
  advanced types of back-ends.

|Type                     |Description                                                                                                                                                                                                                                                                                                                                                                                                       |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTP/ REST Endpoint     | A REST service endpoint based on a URI template.                                                                                                                                                                                                                                                                                                                                                           |
| HTTP/ SOAP Endpoint     | The direct URL of the SOAP web service.                                                                                                                                                                                                                                                                                                                                                                             |
| Failover Group Endpoint | The endpoints that the service tries to connect to in case of a failure. Selecting the endpoint when the primary endpoint fails, happens in a round-robin manner. Failover Group is a group of leaf endpoints (i.e., address endpoint, HTTP endpoint, and WSDL endpoint). When a failure occurs in the current endpoint (while sending a message), the failover group endpoint will try to send the message to another endpoint. The failover group ensures that the message is delivered as long as there is at least one active endpoint among the listed endpoints.                              |
| Load Balance Endpoint   | The endpoints where the incoming requests are directed to in a round-robin manner. They automatically handle fail-over as well.                                                                                                                                                                                                                                                                            |
| Dynamic Endpoint        | Using a dynamic endpoint, the requests can be dynamically routed to an address based on a specific condition (e.g., request parameters, payload etc.). When using this endpoint type, a mediation sequence should be applied to the message **IN Flow** of the API. For more details of configuring APIs to change the default mediation flow, see [Changing the Default Mediation Flow of API Requests]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/message-mediation/changing-the-default-mediation-flow-of-api-requests/). |
| Prototype Endpoint      | Prototype endpoint is a type of HTTP Endpoint which can be used when Prototyping an API (for promoting and testing). For instructions, see [Deploy and Test Mock APIs]({{base_path}}/design/prototype-api/deploy-and-test-mock-apis/). |
| Prototype Implementation      | **Prototype implementation** in WSO2 API Manager uses the built-in Javascript engine of Synapse to mock the responses and can be used per HTTP resource of the API. For more information on Prototype Implementation, see [Create a Mock API with an Inline Script]({{base_path}}/design/prototype-api/create-a-mock-api-with-an-inline-script/) for more information. |
| AWS Lambda      | An AWS Lambda endpoint can be used to invoke AWS Lambda functions through WSO2 API Gateway. For more information on creating APIs with AWS Lambda endpoint, please refer [Create and Publish an AWS Lambda API]({{base_path}}/wip/create-and-publish-awslambda-api). |

!!! note
    - **Prototype Endpoints** and **Prototype Implementation** will be available only for the APIs which are in **CREATED** or **PROTOTYPED** state.

**Note the following:**

-   You can expose both REST and SOAP services to consumers through APIs.
-   You can call backend services secured with OAuth 2.0, username/password (Basic Auth/ Digest Auth) through APIs created in the API Publisher.
-   The system reads Gateway endpoints from the `<API-M_HOME>/repository/conf/deployment.toml` file. When there are
 multiple gateway environments defined, it picks the Gateway endpoint of the production environment. You can define both HTTP and HTTPS gateway endpoints as follows:

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
    When you define secured (HTTPS) endpoints, set the `HostnameVerifier` parameter to `AllowAll` in the `<API-M_HOME>/repository/conf/deployment.toml` file's HTTPS transport sender configuration.
     ```toml
         [transport.passthru_https.sender.parameters]
         HostnameVerifier = "AllowAll"
     ```
    If not, **the server throws an exception**.


