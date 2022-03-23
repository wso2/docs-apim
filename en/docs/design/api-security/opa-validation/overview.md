# Validate Request with Open Policy Agent (OPA)

The [Open Policy Agent (OPA)](https://openpolicyagent.org/) is an open source, general-purpose policy engine that unifies policy enforcement. In Choreo Connect, you can offload some responsibility of making the decision to authorize or not when a consumer invokes APIs based on policies attached to APIs. Both WSO2 API Manager and Choreo Connect supports Open Policy Agent based request validation.

## Attaching OPA Policy

You can attach an OPA policy to the API that you want to enforce OPA validation. In the publisher portal, select the API that you want to configure the OPA policy and navigate to **Develop -> API Configurations -> Policies**.

Select the gateway that the API required to be deployed in the upper right corner of the page.

<a href="{{base_path}}/assets/img/design/security/opa-gateway-selection.png">
    <img src="{{base_path}}/assets/img/design/security/opa-gateway-selection.png" alt="Select gateway for OPA Policy"/>
</a>

Configurations for the policy is as follows.

| Name                  | Description                                               | Sample                          |
|-----------------------|-----------------------------------------------------------|---------------------------------|
| Server URL            | URL of the OPA Server                                     | `http://localhost:8181/v1/data` |
| Access Token          | **Optional** access token for OPA server authentication   | `my-secret-token`               |
| Policy                | Name of the policy                                        | `myPolicy`                     |
| Rule                  | Name of the rule                                          | `allow`                         |
| Send Access Token     | Whether to send or not the access token to the OPA server | `false`                         |
| Additional Properties | **Optional** Additional message context (request context) properties to be included in the OPA input. Add these properties in a comma seperated list. |                                 |
| Max Open Connections  | **Optional** Maximum number of open HTTP connections      | `500`                           |
| Max Per Route         | **Optional** Maximum connections per a route              | `200`                           |
| Connection Timeout    | **Optional** Connection timeout in seconds                | `30`                            |

<a href="{{base_path}}/assets/img/deploy/mgw/configure-opa-policy.png">
    <img src="{{base_path}}/assets/img/deploy/mgw/configure-opa-policy.png" alt="Configure OPA policy"/>
</a>

## Defining Policies in the OPA Server

You can define your own policy enforcement logic in OPA by using the values provided by the gateway. The following is a sample policy definition in **Rego** to check the header value. `x-abcd` should be `ABCD` when HTTP method is `PUT`, otherwise HTTP method can be `POST`.

```rego tab='Sample'
package myPolicy

default allow = false
allow {
    input.method == "PUT"
    input.transportHeaders["x-abcd"] == "ABCD"
}
allow {
    input.method == "POST"
}
```

### Request Payload to the OPA server

#### Choreo Connect

    By default Choreo Connect uses the class **OPADefaultRequestGenerator** to generate the request payload to the OPA server. You can configure your policies in OPA server based on the following request format.

    !!! Info
        You can have your own **Request Generator Implementation**, you can do so by implementing the interface **OPARequestGenerator**. [Custom OPA Policy with Custom Request Generator](#custom-opa-policy-with-custom-request-generator) in this document describes it in more details.

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
        "sandClusterName": "<sandbox_endpoint_cluster_name>",
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

### Response Payload from the OPA server

#### Choreo Connect

Similar to the request generation Choreo Connect uses the **OPADefaultRequestGenerator**  class to validate the response from OPA. When using the default implementation, you have to write your OPA policies using the following response format.

!!! note
    If required, you can have your own **Response Valiation Implementation** by implementing the interface **OPARequestGenerator**. For more information, see [Custom OPA Policy with Custom Request Generator](#custom-opa-policy-with-custom-request-generator).

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

### Custom OPA Policy

You can create your own custom OPA policies with custom Request Generators. Both WSO2 API Manager and Choreo Connect supports this extension.

- [Custom OPA Policy for Choreo Connect](custom-opa-policy-for-choreo-connect.md)
