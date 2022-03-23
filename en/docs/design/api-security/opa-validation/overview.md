# Validate Request with Open Policy Agent (OPA)

The [Open Policy Agent (OPA)](https://openpolicyagent.org/) is an open source, general-purpose policy engine that unifies policy enforcement. 
With the ability to define complex policies as a code, OPA provides the much needed flexibility over standard static access control mechanisms such as role based or attribute based access control.

You can offload some responsibility of making the decision to authorize or not when a consumer invokes APIs based on policies attached to APIs. Both WSO2 API Manager regular Gateway and Choreo Connect supports Open Policy Agent based request validation. Open Policy Agent comprises of a policy engine that allows users (or systems) to query policies for decisions. 
A policy for Open Policy Agent can be though as a set of rules and policy engine evaluate these rules based on the input it receives.

WSO2 API Manager uses this unique policy engine to evaluate the requests that the Gateway receives and decides the fate of the request.

<a href="{{base_path}}/assets/img/design/security/opa/opa-policy-architecture.png">
    <img src="{{base_path}}/assets/img/design/security/opa/opa-policy-architecture.png" alt="OPA Architecture"/>
</a>

## How to use OPA for request validation?

In oder to evaluate requests with OPA, first you need to deploy OPA as a host-level daemon or a sidecar container. Once a Gateway receives a request,
it extracts a predefined set of meta-data from the request and query OPA via HTTP/HTTPS. The OPA Policy engine evaluates the request meta-data against the configured policy and returns its validation response.
The Gateway allows or blocks the request based on the response.

!!! note
    The Gateway node should be able to communicate with this OPA server. It can be either HTTP or HTTPS, and if HTTPS is used, make sure that you upload the certificates of the OPA server to the client trust store of the Gateway.
    You can add a certificate to the trust store via the following command.  
    ``` keytool -importcert -file <opa_endpoint_cert>.cer -keystore <APIM_HOME>/repository/resources/security/client-truststore.jks -alias "OPA server endpoint" ```

### Attaching OPA Policy
Once OPA engine is deployed, you have to attach the policy to the operations that you want to enforce OPA validation.

1. In the Publisher Portal, select the API that you want to configure the OPA policy and navigate to **Develop -> API Configurations -> Policies**.
2. Select the Gateway that the API is required to be deployed in the upper right corner of the page.
3. For this functionality, there is a policy that you can invoke for the request flow named **Validate Request with OPA Policy**. Drag and drop this policy to the request flow of your required operations. 
4. If you want to apply this to all the operations, select the **Apply to all resources** option from the left bar.
5. Fill the configurations as per your deployment and save the page.
6. Create a new revision from these changes and deploy it to the Gateway.

<a href="{{base_path}}/assets/img/design/security/opa/opa-policy-selection.png">
    <img src="{{base_path}}/assets/img/design/security/opa/opa-policy-selection.png" alt="Select the OPA Policy"/>
</a>

Configurations for the policy is as follows.

| Name                  | Description                                                                                                                                                                                                                                                            | Sample                                 |
|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| Server URL            | URL of the OPA Server.                                                                                                                                                                                                                                                 | `http://localhost:8181/v1/data`        |
| Access Token          | **Optional** access token for OPA server authentication.                                                                                                                                                                                                               | `my-secret-token`                      |
| Policy                | Name of the policy.                                                                                                                                                                                                                                                    | `my-policy`                            |
| Rule                  | Name of the rule to be evaluated in the policy. By default `allow` rule will be evaluated.                                                                                                                                                                             | `allow`                                |
| Send Access Token     | Whether to send the request access token to the OPA server or not.                                                                                                                                                                                                     | `false`                                |
| Additional Properties | **Optional** Additional message context (request context) properties to be included in the OPA input. Provided property names will be added to the OPA input payload with the value obtained from the message context. Add these properties in a comma separated list. | `Scopes,TRANSPORT_IN_NAME,AM_KEY_TYPE` |
| Max Open Connections  | **Optional** Maximum number of open HTTP connections between the gateway and OPA server.                                                                                                                                                                               | `500`                                  |
| Connection Timeout    | **Optional** Connection timeout in seconds.                                                                                                                                                                                                                            | `30`                                   |

<a href="{{base_path}}/assets/img/design/security/opa/configure-opa-policy.png">
    <img src="{{base_path}}/assets/img/design/security/opa/configure-opa-policy.png" alt="Configure OPA policy"/>
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

By default, each Gateway uses a default Request Generator to generate the request payload to the OPA server. You can configure your policies in OPA server based on the following request format.

!!! Info
    You can have your own **Request Generator Implementation** - you can do so by implementing the interface **OPARequestGenerator**. [Custom OPA Policy with Custom Request Generator](#custom-opa-policy-with-custom-request-generator) in this document describes this in more detail.

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

```json tab='Synapse payload'
{
    "input": {
        "path": "/pizzashack/1.0.0/menu",
        "method": "GET",
        "requestOrigin": "127.0.0.1",
        "apiContext": {
            "apiName": "PizzaShackAPI",
            "subscriber": "admin",
            "applicationUUID": "60cf16eb-f73c-4677-8440-167b2be6f831",
            "apiPublisher": "admin",
            "isAuthenticated": true,
            "keyType": "PRODUCTION",
            "consumerKey": "GRfjDbo8yJqXUGbFaOtNo_5Npyka",
            "accessToken": "JWT Access Token",
            "issuer": "https://localhost:9443/oauth2/token",
            "applicationName": "DefaultApplication",
            "subscriberOrganization": "carbon.super",
            "username": "admin@carbon.super"
        },
        "transportHeaders": {
            "Origin": "https://localhost:9443",
            "Connection": "keep-alive",
            "Referer": "https://localhost:9443/",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Safari/537.36",
            "Host": "localhost:8243",
            "Accept-Encoding": "gzip, deflate, br",
            "accept": "application/json",
            "Accept-Language": "en-GB,en-US;q=0.9,en;q=0.8"
        } 
    }
}
```

```json tab='Choreo Connect payload'
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

Similar to the request generation, the default request generator class validates the response from OPA. When using the default implementation, you have to write your OPA policies using the following response format when queried with the `allow` policy.

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

### Customize the OPA request payload and response validation

If you need to customize the OPA input JSON or OPA response validation, you can do so by writing your own custom OPA policies with custom Request Generators. Both regular Gateway and Choreo Connect support this extension.

- [Custom OPA Policy for Regular Gateway](custom-opa-policy-for-regular-gateway.md)
- [Custom OPA Policy for Choreo Connect](custom-opa-policy-for-choreo-connect.md)
