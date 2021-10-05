# Streaming APIs Overview

Event Driven Architecture (EDA) allows changes to data and state, and interesting business events to be pushed to applications immediately without requiring the applications to poll for the updates. Organizations try to embrace EDA to modernize their applications with rich, interactive, and immediate user experience (e.g., immediately seeing the changes in the stock prices). In addition to EDA, you also need to manage streaming APIs in scenarios when an organization needs to expose their event-streams in a managed way, to generate money based on streaming data, or to only allow authorized clients to access certain APIs. However, organizations face multiple challenges, as listed below, when attempting to implement an event driven architecture or introduce eventing.

- Integrating existing applications with the event backbone.
- Exposing event streams to web applications and external users.
- New applications need to be modified to deal with the transport level concerns.
- Integrating persistent data stores in a streaming manner.
- Processing event streams.

To overcome the latter mentioned challenges WSO2 API Manager provides the capability of working with Streaming APIs.

??? info "Understanding the challenges faced when managing streaming endpoints"

    - **Integrating existing applications with the event backbone**

         It might not be possible to modify the existing applications to integrate with event backbone. For example, to integrate with Kafka, you will need to modify the application to use the Kafka client API. Often such applications use protocols such as HTTP. 

    - **Exposing event streams to web applications and external users**

         Messaging protocols such as Kafka, MQTT, AMQP, JMS use their protocols, which are not web-friendly. Therefore, the organizations will have to take additional steps to disseminate the streams via streaming protocols such as WebSocket (WS) and Server Sent Events (SSE), or use WebHooks to push updates asynchronously in order to push events to the Web/Mobile application of the system or to the third-party receivers that can receive events over HTTP.

    - **New applications need to be modified to deal with the transport level concerns**

         When developing new applications, the application will have to use the Client APIs provided to connect to the event backbone (e.g., Kafka client API, AMQP). This demands the application developers to have knowledge about the broker and to deal with transport level concerns (e.g., what should be the batch size for receiving events?) when writing the applications. Instead, it will be easier to build their applications based on well-known protocols such as HTTPs.

    - **Integrating persistent data stores in a streaming manner**

         Organizations will inevitably have software that will write data to static data stores such as databases (DBs) and files. In an EDA such data has to be integrated immediately. A DB table can be exposed as an immediate event stream with techniques, such as change data capture, so that the consumers can simply listen to a topic instead of polling the DB for the event format, referring to the documentation etc.

     - **Processing event streams**

         It is not uncommon for the events streams to be verbose, generating a large number of granular events. However, it might be sufficient for end-user applications to have a summarized, aggregated, and filtered view of the event stream. Stream processing is needed to convert raw event streams into value-added event streams.

## How does it work?

A **Streaming API** is a logical collection of related topics through which clients can publish and receive events in a well-defined format. The topics in the Streaming APIs represent the different channels. The topics in Streaming APIs can be compared to the resources in REST APIs. 

The actions a **topic** allows you to do are "Subscribe" and/or "Publish".

- **Subscribe** - A topic of this type allows traffic from the server (backend) to the client. 
- **Publish** - A topic of this type allows traffic from the client to the server.

The [Streaming Integrator component](../../../../streaming/streaming-overview/) in WSO2 API Manager (WSO2 API-M) supports Streaming APIs via the following main protocols, which are compatible with HTTP.

- **[WebSocket](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-websocket-streaming-api)**
- **[WebSub (WebHook)](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-websub-streaming-api)**
- **[Server Sent Events (SSE)](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-sse-streaming-api)**

The WebSocket and SSE Streaming APIs require a persistent connection between the client and the API Gateway. This enables the server to stream events continually, with idle times in the middle if required, through a single connection, thereby eliminating the overhead of creating new connections. Thereby, the WebSocket and SSE protocols allow publishers to maintain persistent communication channels with receivers. However, WebSub Streaming APIs do not require to have a persistent connection. Instead, the WebSub APIs make an HTTP call when required.

When you create a WebSocket API, WebSub API/ WebHook API, or SSE API, it links an existing streaming backend API implementation to the <a href="../../../../get-started/architecture/#api-publisher">API Publisher,</a> so that you can manage and monitor your [API's lifecycle](../../../../design/lifecycle-management/api-lifecycle), documentation, security, community, and subscriptions. 

You can define Streaming APIs using [AsyncAPI](https://www.asyncapi.com/) definitions. Therefore, alternatively, you can also **[create a Streaming API, which supports any one of the above protocols, using an AsyncAPI definition.](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-streaming-api-from-an-asyncapi-definition)**

## Authorization for Streaming API Topics

A scope acts as a limiting factor on what Streaming API topics can be accessed using an access token, and it defines the authorization aspect for Streaming API events.

- **Authorization for a single topic**

    When a query has a single topic, the access token should include the scope, which is attached to that specific topic, to be able to invoke the API.

- **Authorization for multiple topics**
 
    When a query has multiple topics, the access token should include all the scopes, which are attached to the topics that correspond to that specific API, to be able to invoke the API.

## What's Next?

- Create a Streaming API:
     - [Create a WebSocket API](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-websocket-streaming-api)
     - [WebSub (WebHook)](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-websub-streaming-api)
     - [Server Sent Events (SSE)](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-sse-streaming-api)
     - [Create a Streaming API from an AsyncAPI Definition](../../../../use-cases/streaming-usecase/create-streaming-api/create-a-streaming-api-from-an-asyncapi-definition)
- [Test a WebSub/WebHook API](../../../../use-cases/streaming-usecase/create-streaming-api/test-a-websub-api)
- [Learn how to expose a stream as a managed API](../../../../use-cases/streaming-usecase/exposing-stream-as-managed-api-in-service-catalog/).
- [Learn how you can use a third-party Streaming Provider as opposed to WSO2 Streaming Integrator, which is used by default, to create a Streaming API](../../../../get-started/quick-start-guide/streaming-qsg).
