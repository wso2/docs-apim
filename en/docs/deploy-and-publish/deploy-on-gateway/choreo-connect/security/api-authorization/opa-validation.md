# Open Policy Agent (OPA) Validation

The [Open Policy Agent (OPA)](https://openpolicyagent.org/) is an open source, general-purpose policy engine that unifies policy enforcement. In Choreo Connect, you can use OPA to enforce request to the API resources. Choreo Connect uses OPA’s policy evaluation REST API interface to communicate with OPA. Following diagram describes the request/response of OPA validation.

!!! tip
    You can deploy OPA server as a sidecar with Choreo Connect Runtime (Enforcer and Router) in a Kubernetes deployment, if you want to improve communication between Enforcer and OPA server.

<img src="{{base_path}}/assets/img/deploy/mgw/choreo-connect-opa-overview.png" alt="Choreo Connect OPA request flow" width="700px"/>

| Numbers | Description                                                                                                                            |
|---------|----------------------------------------------------------------------------------------------------------------------------------------|
| 1       | Client request                                                                                                                         |
| 2       | Request to validate (i.e. authentication, rate-limiting, OPA validation and other validations) the client request through Enforcer     |
| 3       | Enforcer calling the OPA server with the JSON payload described in [Request to the OPA server](#request-to-the-opa-server)             |
| 4       | Response from OPA server after validating the request as described in [Response from the OPA server](#response-from-the-opa-server)   |
| 5       | Respond the validation status to the Router                                                                                            | 
| 6,7     | Response from the backend                                                                                                              |
| 8       | Response to the client                                                                                                                 |

## Attaching OPA Policy to an API Resource

By attaching an OPA policy to the API Resource you can enforce OPA validation to that API resource with providing the following values in the policy. Enforcer uses the OPA server defined in the policy and queries the policy result

<!-- // TODO: (renuka) link configuring OPA from APIM (still not in 410-alpha) when APIM docs available -->

| Name              | Description                                                   | Sample                          |
|-------------------|---------------------------------------------------------------|---------------------------------|
| Server URL        | URL of the OPA Server                                         | `http://localhost:8181/v1/data` |
| Policy            | Name of the policy                                            | `abc-policy`                    |
| Rule              | Name of the rule                                              | `xyz-rule`                      |
| Request Generator | **Optional** fully qualified name of the implementation class | Empty string for Default class  |
| Access Token      | **Optional** access token for OPA server authentication       | `my-secret-token`               |



## Defining Policies in the OPA Server


Following is a sample policy definition to check the header value `x-abcd` should exists and should be `ABCD` and HTTP method should be `PUT`.

```rego tab='Sample'
package abc.authz

# Only owner can update the pet's information
# Ownership information is provided as part of OPA's input
default allow = false
allow {
    input.method == "PUT"
    input.transportHeaders.x-abcd == "ABCD"
}
```

### Request to the OPA server

By default Choreo Connect uses the class **OPADefaultRequestGenerator** to generate the request payload to the OPA server. You can configure your policies in OPA server based on the following request format.

!!! Info
    You can have your own **Request Generator Implementation**, you can do so by implementing the interface **OPARequestGenerator**.

// TODO: link java src for interface and default class.

```json tab='Format'
{
    "input": {
        "path": "<full_path>",
        "vhost": "<VIRTUAL_HOST>",
        "apiName": "<API_name>",
        "apiVersion": "<API_version>",
        "httpVersion": "<HTTP_version>",
        "transportHeaders": {"<HeaderKey>":"<HeaderValue>"},
        "method": "<HTTP_method>",
        "authenticationContext": {
            "tokenType": "<one of [API Key|JWT|Internal Key]>",
            "keyType": "one of [PRODUCTION|SANDBOX]",
            "token": "<raw_auth_token>"
        },
        "requestOrigin": "<client_IP>",
        "pathTemplate": "<resource_template_in_OAS_definition",
        "prodClusterName": "<production_endpoint_cluster_name>",
        "orgId": "<organization_ID>"
    }
}
```

```json tab='Sample'
{
    "input": {
        "path": "/t/foo.com/v2/1.0.5/foo?hello=world",
        "vhost": "localhost",
        "apiName": "SwaggerPetstore",
        "apiVersion": "1.0.5",
        "httpVersion": "HTTP/1.1",
        "transportHeaders": {
            "authorization": "Bearer eyJ0eXAiOiJKV1QiLC...",
            "x-request-id": "bc1fd847-0a33-45ab-9911-fcdd3f2f77ec",
            "content-length": "17",
            ":method": "POST",
            "x-forwarded-proto": "https",
            ":scheme": "https",
            "foo": "bar",
            ":path": "/t/foo.com/v2/1.0.5/foo?hello=world",
            "content-type": "application/x-www-form-urlencoded",
            ":authority": "localhost:9095",
            "user-agent": "curl/7.77.0",
            "accept": "application/json"
        },
        "method": "POST",
        "authenticationContext": {
            "tokenType": "JWT",
            "keyType": "PRODUCTION",
            "token": "eyJ0eXAiOiJKV1QiLC..."
        },
        "requestOrigin": "172.19.0.1",
        "pathTemplate": "/foo",
        "prodClusterName": "carbon.super_clusterProd_localhost_SwaggerPetstore1.0.5",
        "orgId": "carbon.super"
    }
}
```

### Response from the OPA server

Same as request generation Choreo Connect uses the class **OPADefaultRequestGenerator** to validate the response from OPA. So for the default implementation, you have to write your OPA policies with the following response format.

!!! Info
    You can have your own **Response Valiation Implementation**, you can do so by implementing the interface **OPARequestGenerator**.

```json tab='Format'
{
    "result": <BOOLEAN_POLICY_RESULT>
}
```

```json tab='Sample'
{
    "result": true
}
```