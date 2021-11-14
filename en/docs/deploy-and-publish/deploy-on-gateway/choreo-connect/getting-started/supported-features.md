# Choreo Connect Supported Features

Choreo Connect's most recent version v1.0.0 does not support all of the API Manager's functionalities. In contrast to default API gateway, Choreo Connect (the API Microgateway) only offers a fraction of the API Manager product's functionality. The following is a list of Choreo Connect's important features.


- API Manager as Control Plane
    - Deploy and manage APIs (REST, Websocket)
    - Deploy APIs with prototype endpoints
    - Test APIs with internal test keys from publisher portal
    - Subscription blocking/unblocking from publisher portal
    - Applying CORS configuration from publisher portal
    - Key managers can be added from API Manager admin portal
    - Websocket APIs (JWT authentication and throttling supported)
    - Support virtual hosts(Vhosts) to expose the APIs
    - Support publishing APIs to multiple gateway environments


- Security
    - JWT based OAuth2 authentication
    - JWT revocation
    - Define multiple key managers from the configurations
    - Subscription validation with API Manager
    - Subscription validation with self-contained tokens
    - Scope validation for JWT OAuth2 bearer tokens
    - Backend JWT generation (Passing end user details to the backend services)
    - API keys support

- Rate Limiting
    - API/Resource, application and subscription level throttling 
    - Advance throttling, custom policies and the blocking conditions

- Mediation and Message transformation
    - Request/Response Interceptors for APIs

- Service Discovery
    - Integrate with Consul for service discovery
    - Integrate with Consul Service Mesh

- Endpoints
    - Dynamic endpoint support
    - Advance endpoint configurations
        - Retry and Timeouts
        - Circuit breaker
        - Load balance endpoints
        - Failover endpoints
    - Support basic auth protected endpoints
    - Mutual transport level security for gateway to backend

- API Insights and Observability
    - Publish analytics to the Choreo Cloud
    - Open Tracing support: Jager, Zipkin and Azure App Insights 

- Troubleshooting 
    - Enforcer REST API for troubleshooting purposes

- Configurations
    - Environment variable support for configurations

- Other
    - Immutable API artifact deploy support
    - Custom filter support at Enforcer
    - Deploy/undeploy APIs using the command line tool APICTL

The Choreo Connect currently does not support the following major functionalities. However, they will be implemented in future iterations.

- Streaming APIs like SSE, web sub and etc
- Create streaming APIs from Async API specifications
- Analytics for the web socket APIs
- GraphQL APIs
- Grpc APIs
- API Products
- Mutual SSL authentication for APIs
- Basic Authentication for APIs
- Bandwidth based throttling
  

