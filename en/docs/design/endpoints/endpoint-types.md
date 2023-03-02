# Endpoint Types

An Endpoint is a specific destination for a message such as an address, WSDL, a failover group, a load-balance group etc. WSO2 API Manager supports a range of different endpoint types, allowing the API Gateway to connect with advanced types of backends.

<table>
<tr>
<th><b>Type</b></th>
<th><b>Description</b></th>
</tr>
<tr>
<td>HTTP/ REST Endpoint</td>
<td>A REST service endpoint based on a URI template. </td>
</tr>
<tr>
<td>HTTP/ SOAP Endpoint</td>
<td>The direct URL of the SOAP web service.</td>
</tr>
<tr><td>Service Endpoint</td><td>A REST service endpoint of a service entry which is available in the service catalog.</td>
</tr>
<tr><td>Failover Group Endpoint</td>
<td>The endpoints that the service tries to connect to in case of a failure. Selecting the endpoint when the primary endpoint fails, happens in a round-robin manner. Failover Group is a group of leaf endpoints (i.e., address endpoint, HTTP endpoint, and WSDL endpoint). When a failure occurs in the current endpoint (while sending a message), the failover group endpoint will try to send the message to another endpoint. The failover group ensures that the message is delivered as long as there is at least one active endpoint among the listed endpoints.</td>
</tr>
<tr>
<td>Load Balance Endpoint</td>
<td>The endpoints where the incoming requests are directed to in a round-robin manner. They automatically handle fail-over as well.</td>
</tr>
<tr><td>Dynamic Endpoint</td>
<td>Using a dynamic endpoint, the requests can be dynamically routed to an address based on a specific condition (e.g., request parameters, payload etc.). When using this endpoint type, a mediation sequence should be applied to the message <b>IN Flow</b> of the API. For more information, see <a href="{{base_path}}/design/api-policies/regular-gateway-policies/adding-dynamic-endpoints/">Adding Dynamic Endpoints</a>.</td>
</tr>
<tr><td>Mock Implementation</td>
<td>
<ul>
<li><a href="{{base_path}}/design/prototype-api/create-mocked-js-api/">Mock implementation with API Gateway</a> - The Mock Implementation uses the built-in JavaScript engine of Synapse to mock the responses and can be used per HTTP resource of the API.</br>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The <b>Mock Implementation</b> will be only available for APIs that are in the <b>CREATED</b> or <b>PRE-RELEASED</b> state.</p>
</div></li>
<li>
<a href="{{base_path}}/design/prototype-api/create-mocked-oas-api/">Mock implementation with Choreo Connect</a> - When using the Mock Implementation in Choreo Connect, you can generate mock responses based on the examples provided in the OpenAPI specification and directly get the response. For non-default cases, the exact response can be requested using the <code>Prefer</code> and <code>Accept</code> headers.
</li>
</td>
</tr>
<tr><td>AWS Lambda</td><td>An AWS Lambda endpoint can be used to invoke AWS Lambda functions through WSO2 API Gateway. For more information on creating APIs with AWS Lambda endpoint, see <a href="{{base_path}}/tutorials/create-and-publish-awslambda-api/">Create and Publish an AWS Lambda API</a>.</td>
</tr>
</table>

**Note the following:**

-   You can expose both REST and SOAP services to consumers through APIs.
-   You can call backend services secured with OAuth 2.0, username/password (Basic Auth or Digest Auth) through APIs created in the API Publisher.
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
