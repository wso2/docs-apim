# Response Flow Interceptor

Intercept the Response to the client and update headers, trailer and body before reaching the client.

## Request and Response for Interceptor

In this section, you can find the content of the request to/response from the interceptor service.

### 1. Request from the Choreo Connect Router to Interceptor Service

Following is the request received from the Choreo Connect Router when you enable the response interceptor.

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
    "responseCode": <response_code_from_backend>,
    "responseHeaders": {
        "<header1_from_backend>": "<value>",
        "<header2_from_backend>": "<value>"
    },
    "responseTrailers": {
        "<trailer1_from_backend>": "<value>",
        "<trailer2_from_backend>": "<value>"
    },
    "responseBody": "<BASE64_encoded_backend_response_body>",
    "interceptorContext": {
        "<key_1>": "<value_1>",
        "<key_2>": "<value_2>"
    },
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
    "responseCode": 200,
    "responseHeaders": {
       "content-type": "application/xml",
       "content-length": "140"
   },
   "responseTrailers": {},
   "responseBody": "eyJIZWxsbyI6IldvcmxkIn0K44545487faedfasdfasdfasdfasdfasdadasdf",
   "interceptorContext": {
        "foo": "bar"
    },
    "invocationContext": {
        ...
    }
}
```

The fields `requestHeaders`, `requestTrailers` and `requestBody` in the above request to the interceptor service
provides the request headers, trailers and **base64 encoded** request body from the client. The field `invocationContext`
contains additional request details. Refer [Invocation Context]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-context-and-invocation-context/#invocation-context)
for more information. The field `interceptorContext` contains key-value pairs that is set in request flow `interceptorContext`.
Refer [Interceptor Context]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-context-and-invocation-context/#interceptor-context) for more information.

The fields `responseCode`, `responseHeaders`, `responseTrailers` and `responseBody` in the request provides the response code,
headers, trailers and **base64 encoded** response body from the backend.

You can customize what should be included in this request body in the open API definition. Refer [Defining Interceptors in an OpenAPI Definition]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition/)
for more information.

### 2. Response from the Interceptor Service to Choreo Connect Router

The following is the response that interceptor service should respond to the Choreo Connect Router when you enable the response interceptor.

``` json tab="Format"
{
    "responseCode": <HTTP_status_code>,
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
    "body": "<BASE64_encoded_body>"
}
```

``` json tab="Sample"
{
    "responseCode": 200,
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
    "body": "eyJIZWxsbyI6IldvcmxkIn0K"
}
```

Interceptor can instruct the Choreo-Connect Router what should be done with the above response.

| Key in Response JSON         | Description                                                                                                                                                                                                                                                                                                                                           |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| responseCode                 | **Sets** the response code.                                                                                                                                                                                                                                   |
| [headers\|trailers]ToAdd     | **Appends** new value onto an existing headers/trailers, or **adds** the headers/trailers if it does not already exist.                                                                                                                                       |
| [headers\|trailers]ToRemove  | **Deletes** headers/trailers.                                                                                                                                                                                                                                 |
| [headers\|trailers]ToReplace | **Sets** the new value for existing headers/trailers, or **adds** the headers/trailers if it does not already exist.                                                                                                                                          |
| body                         | **Sets** the body with **base64** decoding the provided value. If the value is `null` (i.e. `{"body": null}`) or the key "body" is not defined (i.e. `{}`), body is **not updated**. If the value is empty (i.e. `{"body": ""}`), **sets** the body as empty. |

<!-- The content of the below warning is same as the info notice in the file
deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition.md -->
!!! warning
    If you update the response body before reaching the client, ensure to add `response_body` to the `includes` section
    of the Open API Specification. You may have a scenario like, whatever the response body from the backend, you define
    your own response body (say, based on a header value) to send to the client. Even though you do not read the
    response body, you should do the above inclusion.
