# Analytics Event Reference

WSO2 API Manager generates two types of analytics events that are sent to Moesif. This page lists the
parameters carried by each.

!!! note
    Captured request and response bodies are not published as custom event metadata. They are mapped
    onto Moesif's native request and response body fields, so they appear on the request and response
    themselves in the Moesif UI and can be searched and filtered like any other Moesif payload. The
    accompanying `requestContentType` and `responseContentType` values remain available as event
    metadata.

## apim_event_response

This event is triggered for each successful API invocation. Even when an API-associated backend returns an error response, it will be logged through this event (as the gateway successfully processed the request).

**Event Parameters:**

| **Parameter** | **Type** | **Description** |
|---------------|----------|-----------------|
| apiCreator | String | Username of the API creator |
| apiCreatorTenantDomain | String | Tenant domain under which the API was created |
| apiId | String (UUID) | Unique identifier of the API |
| apiMethod | String | HTTP method used in the request (e.g., GET, POST) |
| apiName | String | Name of the API being invoked |
| apiResourceTemplate | String | Resource path template for the API |
| apiType | String | Type of the API (e.g., HTTP, SOAP, GRAPHQL) |
| apiVersion | String | Version of the API |
| applicationId | String (UUID) | Unique identifier of the invoking application |
| applicationName | String | Name of the invoking application |
| applicationOwner | String | Owner of the invoking application |
| backendLatency | Number | Time taken by the backend service to respond (in ms) |
| correlationId | String (UUID) | Unique identifier used to trace the request across components |
| destination | String | Backend endpoint URL to which the request was sent |
| eventType | String | Type of event (e.g., request, response) |
| gatewayType | String | Type of API Gateway handling the request (e.g., SYNAPSE, CHOREO) |
| keyType | String | Key type used for invoking the API (e.g., SANDBOX, PRODUCTION) |
| userName | String | Authenticated username of the API invoker |
| proxyResponseCode | Number | HTTP response code returned by the gateway |
| regionId | String | Identifier of the gateway region where the API was invoked |
| requestMediationLatency | Number | Latency introduced by mediation at the request flow (in ms) |
| requestTimestamp | String (ISO 8601) | Timestamp when the API request was initiated |
| responseCacheHit | Boolean | Indicates whether the response was served from cache |
| responseLatency | Number | Total latency for the response (in ms) |
| responseMediationLatency | Number | Latency introduced by mediation at the response flow (in ms) |
| targetResponseCode | Number | HTTP response code received from the backend service |
| userAgent | String | User agent string of the client (e.g., Chrome) |
| userIp | String | IP address of the client invoking the API |
| commonName | String | Common name extracted from certificate (if applicable) |
| responseContentType | String | Content type of the API response |
| subType | String | Subtype of the API event (e.g., DEFAULT) |
| isEgress | Boolean | Indicates whether the event occurred on the egress path |
| apiContext | String | Context path of the API |
| responseSize | Number | Size of the API response payload (in bytes) |
| requestHeaders | Object | Map of request headers sent to the backend. Present only when `send_headers` is enabled |
| responseHeaders | Object | Map of response headers received from the backend. Present only when `send_headers` is enabled |
| requestContentType | String | Content type of the API request. Present only when a request body was captured |
| requestBody | String | Captured request body. Present only when `send_payloads` is enabled and the body was captured |
| responseBody | String | Captured response body. Present only when `send_payloads` is enabled and the body was captured |
| requestBodyTransferEncoding | String | Set to `base64` when the request body is a Base64-encoded binary payload. Omitted otherwise |
| responseBodyTransferEncoding | String | Set to `base64` when the response body is a Base64-encoded binary payload. Omitted otherwise |
| vendorName | String | Name of the AI vendor (e.g., OpenAI) |
| vendorVersion | String | Version of the AI vendor API |
| model | String | Model identifier used (e.g., gpt-3.5-turbo) |
| promptTokens | Number | Number of tokens used for the input prompt |
| completionTokens | Number | Number of tokens used for the AI's generated response |
| totalTokens | Number | Total tokens consumed in the request |
| hour | String | Hour of the request, for usage tracking or analytics |

## apim_event_faulty

This event is triggered for each **failed** or **throttled** API invocation. This includes requests that failed due to authentication errors, authorization failures, rate limiting, or backend connectivity issues.

Faulty events carry the same header and body fields as `apim_event_response`, where those were
captured. Note that a request rejected before it reaches the backend (for example, an authentication failure or a
throttled request) has no captured request body, because the request body is captured
immediately before the backend call. In that case the response body, if captured, is the error
response generated by the gateway rather than a backend response.

**Event Parameters:**

| **Parameter** | **Type** | **Description** |
|---------------|----------|-----------------|
| apiCreator | String | The creator of the API |
| apiCreatorTenantDomain | String | The tenant domain of the API creator |
| apiId | String | Unique identifier of the API |
| apiMethod | String | The HTTP method used by the API (e.g., GET, POST) |
| apiName | String | The name of the API |
| apiResourceTemplate | String | The template of the API resource accessed |
| apiType | String | The type of the API (e.g., HTTP, REST) |
| apiVersion | String | The version of the API |
| applicationId | String | Unique identifier of the application that makes the API call |
| applicationName | String | Name of the application that makes the API call |
| applicationOwner | String | Owner of the application that makes the API call |
| backendLatency | Long | The time taken by the backend to process the request |
| correlationId | String | Unique identifier for tracking API calls |
| destination | String | The backend URL to which the API call was redirected |
| eventType | String | The type of event |
| gatewayType | String | The type of the API gateway |
| keyType | String | Indicates whether the API key used was for SANDBOX or PRODUCTION |
| platform | String | Operating system used to access the API |
| properties | Object | Properties of the event |
| apiContext | String | The context of the API call |
| userName | String | The username of the individual who made the API call |
| proxyResponseCode | Int | The HTTP response code returned by the API gateway |
| regionId | String | The region identifier for the API call |
| requestMediationLatency | Int | Time taken for request mediation |
| requestTimestamp | Long | Timestamp when the request was made |
| responseCacheHit | Bool | Indicates if the response was served from cache |
| responseLatency | Long | Total time taken to respond to the request |
| responseMediationLatency | Long | Time taken for response mediation |
| targetResponseCode | Int | The HTTP response code received from the backend target |
| userAgent | String | The user agent of the client making the API call |
| userIp | String | The IP address of the user making the API call |
| errorCode | Int | The error code generated in a fault |
| errorMessage | String | The error message associated with the fault |
| errorType | String | The type of error (e.g., THROTTLED, AUTH_FAILURE, BACKEND_ERROR) |
| responseContentType | String | Content type of the API response |
| requestHeaders | Object | Map of request headers sent to the backend. Present only when `send_headers` is enabled |
| responseHeaders | Object | Map of response headers received from the backend. Present only when `send_headers` is enabled |
| requestContentType | String | Content type of the API request. Present only when a request body was captured |
| requestBody | String | Captured request body. Present only when `send_payloads` is enabled and the body was captured. A request rejected before it reaches the backend has no captured request body |
| responseBody | String | Captured response body. Present only when `send_payloads` is enabled and the body was captured. For a request rejected at the gateway, this is the gateway's error response |
| requestBodyTransferEncoding | String | Set to `base64` when the request body is a Base64-encoded binary payload. Omitted otherwise |
| responseBodyTransferEncoding | String | Set to `base64` when the response body is a Base64-encoded binary payload. Omitted otherwise |

