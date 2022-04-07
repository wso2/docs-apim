# Create a Custom Choreo Connect Policies

Choreo Connect supports the following operations and the policies supporting these operations are shipped with the WSO2 API Manager by default. The following table contains the action name and parameters of the operations that are supported in Choreo Connect.


<table>
 <tr>
    <th>Action Name</th>
    <th>Parameters</th>
    <th>Applicable Flows</th>
    <th>Description</th>
 </tr>
 <tr>
    <td>SET_HEADER</td>
    <td>
        <ul>
            <li>headerName</li>
            <li>headerValue</li>
        </ul></td>
    <td>Request</td>
    <td>Set a header in the request flow.</td>
 </tr>
 <tr>
    <td>REMOVE_HEADER</td>
    <td>headerName</td>
    <td>Request</td>
    <td>Remove a header in the request flow.</td>
 </tr>
 <tr>
    <td>ADD_QUERY</td>
    <td>
        <ul>
            <li>queryParamName</li>
            <li>queryParamValue</li>
        <ul></td>
    <td>Request</td>
    <td>Add a query param in the request flow.</td>
 </tr>
 <tr>
    <td>REWRITE_RESOURCE_METHOD</td>
    <td>
        <ul>
            <li>currentMethod</li>
            <li>updatedMethod</li>
        </ul></td>
    <td>Request</td>
    <td>Change the HTTP method of a resource in the request flow.</td>
 </tr>
 <tr>
    <td>REWRITE_RESOURCE_PATH</td>
    <td>
        <ul>
            <li>resourcePath</li>
            <li>includeQueryParams</li>
        </ul></td>
    <td>Request</td>
    <td>Rewrite the resource path in the request flow.</td>
 </tr>
 <tr>
    <td>CALL_INTERCEPTOR_SERVICE</td>
    <td>
        <ul>
            <li>interceptorServiceURL</li>
            <li>includes (this require a comma separated string, which describes what should be included in the request body of the interceptor service)</li>
        </ul></td>
    <td>Request Response</td>
    <td>Call an interceptor service in request or response flow. For more information, visit <a href="{{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/message-transformation-overview">Message Mediation</a>.</td>
 </tr>
 <tr>
    <td>OPA</td>
    <td>
        <ul>
            <li>requestGenerator</li>
            <li>serverURL</li>
            <li>accessKey</li>
            <li>policy</li>
            <li>rule</li>
            <li>sendAccessToken</li>
            <li>additionalProperties</li>
            <li>maxOpenConnections</li>
            <li>maxPerRoute</li>
            <li>connectionTimeout</li>
        </ul></td>
    <td>Request</td>
    <td>Validate the request against Open Policy Agent server.</td>
 </tr>
</table>

Custom Choreo Connect policies can use these actions and template or specific value in parameters.

!!! note
	Choreo Connect policy definitions are in the .gotmpl file extension. Its content type is YAML, templated with [go templates](https://pkg.go.dev/text/template).

## Sample 1 - Custom Call Interceptor Policy

Lets create a new policy using the action CALL_INTERCEPTOR_SERVICE. Following is the content of the default call interceptor policy definition which ships with the distribution. You can download the default call interceptor service policy from the publisher portal.

```yaml tab='ccAddHeader.gotmpl'
definition:
 action: CALL_INTERCEPTOR_SERVICE
 parameters:
   interceptorServiceURL: {{'{{ .interceptorServiceURL }}'}}
   includes: {{'{{ .includes }}'}}
```

Lets say you have an interceptor service that converts XML payload to JSON with the server URL https://xml-to-json-interceptor:8443 and lets create a policy named “XML to JSON Call Interceptor”. Learn more about Choreo Connect interceptors on Message Transformation. Since we only need request and response payload, we can specify includes as “request_body,response_body”. Following the the definition.

Lets create the policy definition xmlToJsonCallInterceptor.gotmpl with the following content.

```yaml tab='xmlToJsonCallInterceptor.gotmpl'
definition:
 action: CALL_INTERCEPTOR_SERVICE
 parameters:
   interceptorServiceURL: https://xml-to-json-interceptor:8443
   includes: request_body,response_body
```

We can create the policy specification for this policy as follows. Since there are no templated attributes in the policy definition we can keep policyAttributes in the spec as an empty array.

[![Custom call interceptor]({{base_path}}/assets/img/design/api-policies/custom-call.png){: style="width:90%"}]({{base_path}}/assets/img/design/api-policies/custom-call.png)

## Sample 2 - Custom OPA Policy

Lets create a new policy with the action OPA. Following is the content of the default OPA policy definition which ships with the destribution opaPolicy.gotmpl.

```yaml tab='opaPolicy.gotmpl'
definition:
  action: OPA
  parameters:
    requestGenerator: ""
    serverURL: {{'{{ .serverUrl }}'}}
    {{'{{- if .accessKey }}'}}
    accessKey: {{'{{ .accessKey }}'}}
    {{'{{- end }}'}}
    policy: {{'{{ .policy }}'}}
    rule: {{'{{ .rule }}'}}
    {{'{{- if .sendAccessToken }}'}}
    sendAccessToken: {{'{{ .sendAccessToken }}'}}
    {{'{{- end }}'}}
    {{'{{- if .additionalProperties }}'}}
    additionalProperties: {{'{{ .additionalProperties }}'}}
    {{'{{- end }}'}}
    {{'{{- if .maxOpenConnections }}'}}
    maxOpenConnections: {{'{{ .maxOpenConnections }}'}}
    {{'{{- end }}'}}
    {{'{{- if .maxPerRoute }}'}}
    maxPerRoute: {{'{{ .maxPerRoute }}'}}
    {{'{{- end }}'}}
    {{'{{- if .connectionTimeout }}'}}
    connectionTimeout: {{'{{ .connectionTimeout }}'}}
    {{'{{- end }}'}}
```

!!! note
    You can create a custom request generator and define it in the parameter “requestGenerator”. For detailed description on creating custom request generator visit Custom OPA Policy for Choreo Connect.

Lets say we want to validate requests with a OPA server that is used to validate a set of APIs centrally. Lets create a custom policy with name “centralOpaPolicy”

Lets create the definition file. We can have default values added to the parameters of the action “OPA”.

```yaml tab='centralOpaPolicy.gotmpl'
definition:
  action: OPA
  parameters:
    requestGenerator: ""
    serverURL: https://central-opa:8181
    accessKey: ""
    policy: {{'{{ .myPolicy }}'}}
    rule: {{'{{ .myRule }}'}}
    sendAccessToken: true
    additionalProperties: ""
    maxOpenConnections: 10
    maxPerRoute: 5
    connectionTimeout: 30
```

You can now define the policy spec and since you have templed myPolicy and myRule, we should include those in the policy spec. Following is the sample spec for the above policy definition.

```json tab='centralOpaPolicy.json'
{
 "category": "Security",
 "name": "opaPolicy",
 "displayName": "Validate Request With OPA Policy",
 "description": "With this policy, user can validate requests based on the OPA policy engine",
 "policyAttributes": [
   {
     "name": "myPolicy",
     "displayName": "Policy",
     "description": "Policy to be validated",
     "type": "String",
     "required": true
   },
   {
     "name": "myRule",
     "displayName": "Rule",
     "description": "Rule to validate",
     "type": "String",
     "defaultValue": "allow",
     "required": true
   }
 ],
 "applicableFlows": [
   "request"
 ],
 "supportedGateways": [
   "Synapse",
   "ChoreoConnect"
 ],
 "supportedApiTypes": [
   "HTTP"
 ]
}
```

You can upload the created custom policy from the WSO2 API Manager Publisher Portal as a custom or API-specific policy and attach it to an API resource.
