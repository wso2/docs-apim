# Request Flow Interceptor

Intercept the request to the backend and update headers, trailer and body before reaching the backend.

## Request and Response for Interceptor

In this section, you can find the content of the request to/response from the interceptor service.

### 1. Request from the Choreo Connect Router to Interceptor Service

Following is the request received from the Choreo Connect Router when you enable the request interceptor.

``` json tab="Format"
{
    "requestHeaders": {
        "<header1_from_client>": "<value>",
        "<header2_from_client>": "<value>"
    },
    "requestTrailers": {
        "<trailer1_from_client>": "<value>",
        "<trailer2_from_client>": "<value>"
    },
    "requestBody": "<BASE64_encoded_client_request_body>",
    "invocationContext": {
        ...
    }
}
```

``` json tab="Sample"
{
    "requestHeaders": {
        "content-type": "application/xml",
        "content-length": "40",
        "header1-from-client": "value1",
        "header2-from-client": "value2"
    },
    "requestTrailers": {
        "trailer1-from-client": "value1",
        "trailer2-from-client": "value2"
    },
    "requestBody": "PGhlbGxvPndvcmxkPC9oZWxsbz4K",
    "invocationContext": {
        ...
    }
}
```

The `requestHeaders`, `requestTrailers` and `requestBody` fields in the above request to the interceptor service
provide the request headers, trailers and **base64 encoded** request body from the client. The `invocationContext`
contains additional request details. For more information, see [Invocation Context]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-context-and-invocation-context/#invocation-context).

You can customize the request body in the open API definition according to your requirements. For more information, see [Defining Interceptors in an OpenAPI Definition]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition/).

### 2. Response from the Interceptor Service to Choreo Connect Router

Following is the response that the interceptor service should respond to the Choreo Connect Router when you enable the request interceptor.

``` json tab="Format"
{
    "directRespond": <true|false>,
    "responseCode": <HTTP_code_for_direct_response>,
    "dynamicEndpoint": {
        "endpointName": "<dynamic_endpoint_name>"
    },
    "headersToAdd": {
        "<header_key_1>": "<value_1>",
        "<header_key_2>": "<value_2>"
    },
    "headersToRemove": [
        "<header_key_1>",
        "<header_key_2>"
    ],
    "headersToReplace": {
        "<header_key_1>": "<value_1>",
        "<header_key_2>": "<value_2>"
    },
    "trailersToAdd": {
        "<trailer_key_1>": "<value_1>",
        "<trailer_key_2>": "<value_2>"
    },
    "trailersToRemove": [
        "<trailer_key_1>",
        "<trailer_key_2>"
    ],
    "trailersToReplace": {
        "<trailer_key_1>": "<value_1>",
        "<trailer_key_2>": "<value_2>"
    },
    "interceptorContext": {
        "<arbitrary_key_1>": "<value_1>",
        "<arbitrary_key_2>": "<value_2>"
    },
    "body": "<BASE64_encoded_body>"
}
```

``` json tab="Sample"
{
    "directRespond": false,
    "responseCode": 200,
    "dynamicEndpoint": {
        "endpointName": "my-dynamic-endpoint"
    },
    "headersToAdd": {
        "content-type": "application/json",
        "new-header": "value"
    },
    "headersToRemove": [
        "invalid-header"
    ],
    "headersToReplace": {
        "outdated-header": "updated value"
    },
    "trailersToAdd": {
        "new-trailer": "value"
    },
    "trailersToRemove": [
        "invalid-trailer"
    ],
    "trailersToReplace": {
        "outdated-trailer": "update value"
    },
    "interceptorContext": {
        "foo": "bar"
    },
    "body": "eyJIZWxsbyI6IldvcmxkIn0K"
}
```

Interceptor can instruct the Choreo-Connect Router what should be done with the above response.

| Key in Response JSON         | Description                                                                                                                                                                                                                                               |
|------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| directRespond, responseCode  | Refer [Direct Respond](#direct-respond) for details.                                                                                                                                                                                             |
| dynamicEndpoint              | Refer [Dynamic Endpoint](#dynamic-endpoint) for details.                                                                                                                                                                                         |
| [headers\|trailers]ToAdd     | **Appends** a new value onto existing headers/trailers, or **adds** the headers/trailers if it does not already exist.                                                                                                                                   |
| [headers\|trailers]ToRemove  | **Deletes** headers/trailers.                                                                                                                                                                                                                             |
| [headers\|trailers]ToReplace | **Sets** the new value for existing headers/trailers, or **adds** the headers/trailers if it does not already exist.                                                                                                                                      |
| interceptorContext           | Refer [Interceptor Context]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-context-and-invocation-context/#interceptor-context) for details.                      |
| body                         | **Sets** the body with **base64** decoding the provided value. If the value is `null` (i.e. `{"body": null}`) or the key "body" is not defined (i.e. `{}`), body is not updated. If the value is empty (i.e. `{"body": ""}`), **sets** the body as empty. |

<!-- The content of the below warning is same as the info notice in the file
deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition.md -->
!!! warning
    If you update the request body before reaching the backend, ensure to add `request_body` to the `includes` section
    of the Open API Specification. Your scenario might be that regardless of the request body from the client,
    you define your own request body (say, based on a header value) to send to the backend.
    Even though you do not read the request body, you should include the above condition.

## Direct Respond

You can directly respond to the client without reaching the backend service. In the response of the interceptor,
you have to set the `directRespond` value to `true`. Following is a sample response of an interceptor service.
Note that the body should be base64 encoded.

``` json
{
    "directRespond": true,
    "responseCode": 400,
    "headersToAdd": {
        "content-type": "application/json",
    },
    "body": "eyJkZXNjcmlwdGlvbiI6ImludmFsaWQgdXNlciB0eXBlIn0K"
}
```

## Dynamic Endpoint

You can select the endpoint (or the backend) that the request should get directed with the logic of your interceptor service.
First, you have to define all the available endpoints defined with the extension `x-wso2-endpoints`.
Refer [Defining Endpoints in an OpenAPI Definition]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/defining-endpoints-in-an-openapi-definition/).
Then, you can include the "Dynamic Endpoint" name in the interceptor response.

!!! warning
    The endpoint URLs that you provide in the `x-wso2-endpoints` should have the same base path as in the `x-wso2-production-endpoints`.
    If you define some other base path, it will not result in the expected behaviour.

    Example:

    ``` yaml tab="Valid endpoints"
    x-wso2-production-endpoints:
        urls:
        - https://abc.com:2380/v2
    x-wso2-endpoints:
    - myEndpoint1:
      urls:
        - https://dev.abc.com:8443/v2
          type: loadbalance
    ```

    ``` yaml tab="Invalid endpoints"
    x-wso2-production-endpoints:
        urls:
        - https://abc.com:2380/v2
    x-wso2-endpoints:
    - myEndpoint1:
      urls:
        - https://dev.abc.com:8443/api-v3 # different base path
          type: loadbalance
    ```

Following is a sample endpoint definition in the Open API Specification.

```yaml
x-wso2-endpoints:
  - myEndpoint1:
      urls:
        - https://localhost:2380/v1
      type: loadbalance
  - myEndpoint2:
      urls:
        - https://localhost:2381/v1
      type: loadbalance
```

Following is a part of a response from the interceptor. You can do the same i.e. modify headers, trailers and body with dynamic endpoints.
```json
{
  "dynamicEndpoint": {
    "endpointName": "myEndpoint1"
  }
}
```
