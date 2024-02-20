# Defining Interceptors in an OpenAPI Definition

You can define interceptors on an API level (per API) and on a resource/HTTP-operation level (per resource/HTTP-operation).
If you define a request/response interceptor on API level, resource level, **and** HTTP-operation level, the API level interceptor will be
overridden by the resource level interceptor for that resource and the resource level interceptor will be overridden by the HTTP-operation level interceptor.

For an API, you can define:

- one of the request or response interceptors
- or both of the request and response interceptors

based on your requirement for the mediation.


## Request flow Interceptor

You can define the request flow interceptor as follows in the OpenAPI Definition with the extension `x-wso2-request-interceptor`.
For a detailed description of the keys, see [Description of Keys of Interceptor OpenAPI Extension](#description-of-keys-of-interceptor-open-api-extension).
Also, for a detailed example, see the [detailed sample OpenAPI definition with request flow interceptor](https://github.com/wso2/product-microgateway/blob/main/samples/openAPI-definitions/interceptors_sample.yaml).

``` yaml tab="Format"
x-wso2-request-interceptor:
  serviceURL: [http|https]://<host>[:<port>]
  includes: # any of following
    - request_headers
    - request_body
    - request_trailers
    - invocation_context
  requestTimeout: OPTIONAL <request timeout in seconds>
  clusterTimeout: OPTIONAL <override interceptor cluster timeout in seconds>
```

``` yaml tab="Example API Level"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls:
    - https://localhost:2380/v2
x-wso2-request-interceptor:
  serviceURL: http://host.request.interceptor:9081
  includes:
    - request_headers
    - invocation_context
.
.
```

``` yaml tab="Example Resource Level"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls:
    - https://localhost:2380/v2
paths:
    /pet/findByStatus:
        x-wso2-production-endpoints:
            urls:
            -  https://localhost:2380/v1
        x-wso2-request-interceptor:
            serviceURL: http://host.request.interceptor:9081
            includes:
            - request_body
        get:
            tags:
            - pets
            summary: Finds Pets by status
            description: Multiple status values can be provided with comma separated strings
            operationId: findPetsByStatus
            parameters:
            - name: status
              in: query
              description: Status values that need to be considered for filter
        .
        .
    /pet/{petId}:
        get:
.
.
```

``` yaml tab="Example HTTP Operation Level"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls:
    - https://localhost:2380/v2
paths:
    /pet/findByStatus:
        get:
            x-wso2-production-endpoints:
                urls:
                -  https://localhost:2380/v1
            x-wso2-request-interceptor:
                serviceURL: http://host.request.interceptor:9081
                includes:
                - request_body
            tags:
            - pets
            summary: Finds Pets by status
            description: Multiple status values can be provided with comma separated strings
            operationId: findPetsByStatus
            parameters:
            - name: status
              in: query
              description: Status values that need to be considered for filter
        .
        .
    /pet/{petId}:
        get:
.
.
```

<!-- The content of the below warning is same as the info notice in the file
deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/request-flow-interceptor.md -->
!!! info
    If you update the request body before reaching the backend, ensure to add `request_body` to the `includes` section
    of the OpenAPI Specification. Your scenario might be that regardless of the request body from the client,
    you define your own request body (say, based on a header value) to send to the backend.
    Even though you do not read the request body, you should include the above condition.

## Response flow Interceptor

You can use the extension `x-wso2-response-interceptor` to define the interceptor for the response flow.
It is the same as the request flow, but additionally the following values are supported in the `includes` section of the extension.

```yaml
includes:
 - response_headers
 - response_body
 - response_trailers
```

``` yaml tab="Format"
x-wso2-response-interceptor:
  serviceURL: [http|https]://<host>[:<port>]
  includes: # any of following
    - request_headers
    - request_body
    - request_trailers
    - response_headers
    - response_body
    - response_trailers
    - invocation_context
  requestTimeout: OPTIONAL <request timeout in seconds>
  clusterTimeout: OPTIONAL <override interceptor cluster timeout in seconds>
```

``` yaml tab="Example API Level"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls:
    - https://localhost:2380/v2
x-wso2-response-interceptor:
  serviceURL: http://host.response.interceptor:9081
  includes:
    - request_headers
    - request_body
    - response_headers
.
.
```

``` yaml tab="Example Resource Level"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls:
    - https://localhost:2380/v2
paths:
    /pet/findByStatus:
        x-wso2-production-endpoints:
            urls:
            -  https://localhost:2380/v1
        x-wso2-response-interceptor:
            serviceURL: http://host.response.interceptor:9081
            includes:
            - request_body
            - invocation_context
        get:
            tags:
            - pets
            summary: Finds Pets by status
            description: Multiple status values can be provided with comma separated strings
            operationId: findPetsByStatus
            parameters:
            - name: status
              in: query
              description: Status values that need to be considered for filter
        .
        .
    /pet/{petId}:
        get:
.
.
```

``` yaml tab="Example HTTP Operation Level"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls:
    - https://localhost:2380/v2
paths:
    /pet/findByStatus:
        get:
            x-wso2-production-endpoints:
                urls:
                -  https://localhost:2380/v1
            x-wso2-response-interceptor:
                serviceURL: http://host.response.interceptor:9081
                includes:
                - request_body
                - invocation_context
            tags:
            - pets
            summary: Finds Pets by status
            description: Multiple status values can be provided with comma separated strings
            operationId: findPetsByStatus
            parameters:
            - name: status
              in: query
              description: Status values that need to be considered for filter
        .
        .
    /pet/{petId}:
        get:
.
.
```

<!-- The content of the below warning is same as the info notice in the file
deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/response-flow-interceptor.md -->
!!! info
    If you update the response body before reaching the client, make sure to add `response_body` to the `includes` section
    of the OpenAPI Specification. You may have a scenario like, what ever the response body from the backend, based on a header value
    you define your own response body to be sent to the client. Even though you do not read the response body, the above inclusion
    should be done to update the response body.

## Description of Keys of Interceptor OpenAPI Extension

Following is the description of each key in the extension.

| OpenAPI Extension Key | Description                                                                                                            |
|------------------------|------------------------------------------------------------------------------------------------------------------------|
| serviceURL             | Service URL of the interceptor service                                                                                 |
| includes               | Defines what should be included in the request body to interceptor service.                                            |
| requestTimeout         | Optional. Timeout in seconds to connect to interceptor service.                                                        |
| clusterTimeout         | Optional. Override the interceptor cluster timeout (in seconds) value, default to cluster timeout value in config.toml |

### Inclusions in Request from Choreo Connect Router to Interceptor Service

Based on the `includes` defined in the extension, the request from Choreo Connect Router to Interceptor Service includes only the specified information from **client request** or **backend response**.
For example, with this configuration you can instruct the Choreo Connect Router to not include request body from
the client and stop buffering the client request body and save the size of the request payload to interceptor service.
In the same way you can use only required inclusions based on you requirement and tune the interception flow.

Following are the possible values for the `includes` in the extension. More information on ***Invocation Context*** is can be found in
[Interceptor Context and Invocation Context]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-context-and-invocation-context/#invocation-context)

- Inclusions in **request** flow interception.

    | Inclusion Key      | Description                                   |
    |--------------------|-----------------------------------------------|
    | request_headers    | Includes the request headers from the client  |
    | request_body       | Includes the request body from the client     |
    | request_trailers   | Includes the request trailers from the client |
    | invocation_context | Includes detailed information of the request  |  

- Inclusions in **response** flow interception.

    | Inclusion Key      | Description                                     |
    |--------------------|-------------------------------------------------|
    | request_headers    | Includes the request headers from the client    |
    | request_body       | Includes the request body from the client       |
    | request_trailers   | Includes the request trailers from the client   |
    | response_headers   | Includes the response headers from the backend  |
    | response_body      | Includes the response body from the backend     |
    | response_trailers  | Includes the response trailers from the backend |
    | invocation_context | Includes detailed information of the request    |

