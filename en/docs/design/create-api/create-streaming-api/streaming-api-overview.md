# Streaming APIs Overview

**Streaming APIs** are used in event driven architecture. Creating a Streaming API is the process of linking an 
existing streaming backend API implementation to the [API Publisher]({{base_path}}/getting-started/overview/#api-publisher), so that you can manage and monitor the [API's lifecycle]({{base_path}}/design/lifecycle-management/api-lifecycle/), documentation, security, community, and subscriptions. Alternatively, you can provide the API implementation in-line in the [API Publisher]({{base_path}}/getting-started/overview/#api-publisher) itself.

Streaming API support is provided via three main protocols in the WSO2 API Manager (WSO2 API-M).

1. [WebSocket]({{base_path}}/design/create-api/create-streaming-api/create-a-websocket-streaming-api)
2. [WebSub (WebHook)]({{base_path}}/design/create-api/create-streaming-api/create-a-websub-streaming-api)
3. [Server Sent Events (SSE)]({{base_path}}/design/create-api/create-streaming-api/create-a-sse-streaming-api)

## Topics

Streaming API Topics are used to represent different channels. These can be compared to REST API resources. A topic can be of types **Subscribe** and/or **Publish**. 

- **Subscribe** - A topic of this type allows traffic from the server (backend) to the client. 
- **Publish** - A topic of this type allows traffic from the client to the server.

#### Authorization for Streaming API Topics
A scope acts as a limiting factor on what Streaming API topics can be accessed using an access token, and thereby defines the authorization aspect for Streaming API requests.

- **Authorization for a single topic**

    When a query has a single topic, the access token should include the scope that is attached to that specific topic to be able to invoke the API.

- **Authorization for multiple topics**
 
    When a query has multiple topics, the access token should include all the scopes that are attached to the topics that correspond to that specific API to be able to invoke the API.
