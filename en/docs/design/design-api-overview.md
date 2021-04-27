# Designing an API

Designing an API spans through a few phases of an API Lifecycle. A correct tool can help design an API seamlessly and efficiently. WSO2 API Manager supports the designing of an API via the API Publisher Portal. 
  
<img src="{{base_path}}/assets/img/learn/design-api/design-api-lifecycle.png" height="400" />

The following are the various aspects associated with the designing phase of the API lifecycle.

## Create an API

API creation is the process of linking an existing backend API implementation to the API Publisher so that you can manage and monitor the API's lifecycle, documentation, security, community, and subscriptions. Alternatively, you can provide the API implementation in-line in the API Publisher itself.

There are multiple options available to API designers to create an API in WSO2 API Manager.

**Create a REST API**

You have two options to create a REST API via the API Publisher in WSO2 API Manager.

- [Create a REST API through the API Publisher]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api) - You can directly create your API in the API Publisher by linking your existing backend API implementation.
- [Create a REST API from an Open API Definition]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api-from-an-openapi-definition) - An OpenAPI definition is a format that describes REST APIs. You can create a REST API based on this definition.

Additionally, you can also convert existing SOAP services or backends to REST APIs. Refer to [Expose a SOAP Service as a REST API]({{base_path}}/design/create-api/create-rest-api/expose-a-soap-service-as-a-rest-api) or [Generate REST API from SOAP Backend]({{base_path}}/design/create-api/create-rest-api/generate-rest-api-from-soap-backend) for more information.

**Create an API based on a Service**

You can create services and publish it to WSO2 API Manager, such as you can create an integration service using WSO2 Integration Studio or a streaming integration service using the Streaming Integration Tooling. Refer to the [documentation on Creating an API Using a Service]({{base_path}}/design/create-api/create-an-api-using-a-service).

**Create a GraphQL API**

GraphQL, which has been developed by Facebook, is a data query language for APIs. When using GraphQL, users can explicitly specify what data they need from an API. GraphQL APIs are an alternative to REST-based APIs. Refer to the [documentation on how to create a GraphQL API]({{base_path}}/design/create-api/create-a-graphql-api) for more information.

**Create a Streaming API**

A Streaming API is a logical collection of related topics through which clients can publish and receive events in a well-defined format. There are four options available for creating APIs of this nature.

- [Create a WebSocket API]({{base_path}}/design/create-api/create-streaming-api/create-a-websocket-streaming-api) - A WebSocket API is a streaming API in WSO2 API Manager that is implemented based on the WebSocket protocol specification, which is compatible with HTTP. You can create a WebSocket API from scratch in WSO2 API-M and export the WebSocket APIs that are created within WSO2 API-M as AsyncAPI definitions.
- [Create a WebSub/WebHook API]({{base_path}}/design/create-api/create-streaming-api/create-a-websub-streaming-api) - A WebSub API, also known as a WebHook API, is a streaming API in WSO2 API Manager that is implemented based on the WebSub protocol specification. You can create a WebSub API from scratch in WSO2 API-M and export the WebSub APIs that are created within WSO2 API-M as AsyncAPI definitions.
- [Create a Server Sent Events (SSE) API]({{base_path}}/design/create-api/create-streaming-api/create-a-sse-streaming-api) - A Server-Sent Events (SSE) API is a streaming API in WSO2 API Manager (WSO2 API-M) that is implemented based on the SSE specification. You can create an SSE API from scratch in WSO2 API-M and export the SSE APIs that are created within WSO2 API-M as AsyncAPI definitions.
- [Create a Streaming API from an AsyncAPI Definition]({{base_path}}/design/create-api/create-streaming-api/create-a-streaming-api-from-an-asyncapi-definition) - AsyncAPI specification is a format that describes streaming APIs. An API Creator can import an existing AsyncAPI definition to WSO2 API Manager to create a streaming API using any one of the above protocols.

## Secure APIs

Many enterprises need to implement API management solutions that provide mechanisms such as authentication, authorization, and rate limiting. These are must-have capabilities for controlling who access APIs across an API ecosystem — and how often.

**Rate Limiting**

Rate Limiting allows you to limit the number of successful hits to an API during a given period. Refer to [documentation on Rate Limiting]({{base_path}}/design/rate-limiting/introducing-throttling-use-cases/) for more information.

**Authentication**

API authentication is a way of protecting API access from unidentified or anonymous access. It ensures that the API is secured and accessible only by the consumers who proves their identity and whose identities are found within the API Management Platform. Please refer to [an overview of Authentication]({{base_path}}/design/api-security/api-authentication/api-authentication-overview) for more information.

**Authorization**

Due to the expanding consumer base, the application developers have to focus on limiting the API access in order to make sure that only the authorized parties have access to respective resources/services. Please refer to [an overview of Authorization in API Manager]({{base_path}}/design/api-security/authorization/api-authorization) for more information.

**Threat Protection**

There are Bot Detection tools and various threat protectors like Gateway Threat Protectors, Regular Expression Threat Protection, JSON Threat Protection, and XML Threat Protection for more specific security options.

## Document APIs

API documentation helps API subscribers to understand the functionality of the API and API publishers to market their APIs better and sustain competition. Using the API Publisher, you can add different types of documentation from various sources. Refer to [documentation on documenting APIs]({{base_path}}/design/api-documentation/add-api-documentation) for more information.

## Test APIs

You can test APIs directly in the API Publisher itself. Refer to [documentation on testing REST APIs]({{base_path}}/design/create-api/test-a-rest-api) for more information.

## API Revisions

API Revisions can be used when an API Publisher needs to keep track of different deployments of the API. Refer to [documentation on API Revisions]({{base_path}}/design/create-api/create-api-revisions) for more information.
