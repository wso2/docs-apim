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
    "invocationContext": {
        ...
    }
}
```

### 2. Response from the Interceptor Service to Choreo Connect Router

Following is the response that interceptor service should respond to the Choreo Connect Router when you enable the response interceptor.

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
        "<trialer_key_1>": "<value_1>",
        "<trialer_key_2>": "<value_2>"
    },
    "trailersToRemove": [
        "<trialer_key_1>",
        "<trialer_key_2>"
    ],
    "trailersToReplace": {
        "<trialer_key_1>": "<value_1>",
        "<trialer_key_2>": "<value_2>"
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

<!-- The content of the below warning is same as the info notice in the file
deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition.md -->
!!! warning
    If you update the response body before reaching the client, ensure to add `response_body` to the `includes` section
    of the Open API Specification. You may have a scenario like, whatever the response body from the backend, you define
    your own response body (say, based on a header value) to send to the client. Even though you do not read the
    response body, you should do the above inclusion.
