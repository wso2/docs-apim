# Endpoint Types

An endpoint is a specific destination for a message such as an address, WSDL, a failover group, a load-balance group etc. WSO2 API Manager supports a range of different endpoint types, allowing the API Gateway to connect with advanced types of backends.

|Type                     |Description                                                                                                                                                                                                                                                                                                                                                                                                       |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTP endpoint           | A REST service endpoint based on a URI template.                                                                                                                                                                                                                                                                                                                                                           |
| Address endpoint        | The direct URL of the service.                                                                                                                                                                                                                                                                                                                                                                             |
| Failover Group endpoint | The endpoints that the service tries to connect to in case of a failure. Selecting the endpoint when the primary endpoint get failed happens in a round robin manner. Failover Group is a group of leaf endpoints(i.e, address endpoint, HTTP endpoint and WSDL endpoint). The failover group endpoint try to send the message to another endpoint when failure occur in current endpoint (while sending a message). Failover group ensures that a message is delivered as long as there is at least one active endpoint among the listed endpoints.                              |
| Load Balance endpoint   | The endpoints where the incoming requests are directed to in a round robin manner. They automatically handle fail-over as well.                                                                                                                                                                                                                                                                            |
| Dynamic endpoint        | The dynamic endpoint sends the message to the address specified in the **To** header. You can configure dynamic endpoints by setting mediation extensions with a set of conditions to dynamically change the **To** header. For details of configuring endpoints to change the default mediation flow, see [Adding Mediation Extensions](../../Extensions/adding-mediation-extensions.md) . |

Note the following:

-   You can expose both REST and SOAP services to consumers through APIs.
-   You cannot call backend services secured with OAuth through APIs created in the API Publisher. At the moment, you can call only services secured with username/password.
-   The system reads gateway endpoints from the `<APIM_HOME>/repository/conf/api-manager.xml` file. When there are multiple gateway environments defined, it picks the gateway endpoint of the production environment. You can define both HTTP and HTTPS gateway endpoints as follows:

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <tbody>
    <tr class="odd">
    <td><div class="container" title="Hint: double-click to select code">
    <div class="line number1 index0 alt2">
    <code class="xml plain">                   &lt;                  </code> <code class="xml keyword">                   GatewayEndpoint                  </code> <code class="xml plain">                   &gt;                                       http://${carbon.local.ip}:${http.nio.port},https://${carbon.local.ip}:${https.nio.port}                                      &lt;/                  </code> <code class="xml keyword">                   GatewayEndpoint                  </code> <code class="xml plain">                   &gt;                  </code>
    </div>
    </div></td>
    </tr>
    </tbody>
    </table>

If both types of endpoints are defined, the HTTPS endpoint will be picked as the server endpoint.

!!! tip
**Tip** : When you define secure (HTTPS) endpoints, set the `<parameter name="HostnameVerifier">` element to `AllowAll` in the `<APIM_HOME>/repository/conf/axis2/axis2.xml` file's HTTPS transport sender configuration:

`<parameter name="HostnameVerifier">AllowAll</parameter>        `

If not, **the server throws an exception** .


