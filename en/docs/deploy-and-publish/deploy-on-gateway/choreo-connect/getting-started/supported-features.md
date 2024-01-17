# Choreo Connect Supported Features

Choreo Connect's most recent version (v1.2.0) does not support all of WSO2 API Manager's (WSO2 API-M) functionalities. In contrast to the default API Gateway, Choreo Connect (the API Microgateway) only offers a fraction of WSO2 API Manager product functionalities. 

## Supported Features

The following is a list of Choreo Connect's important features.

- API Manager as a Control Plane
    - Deploying and managing APIs (REST, SOAP, WebSocket)
    - Testing APIs with internal test keys via the WSO2 API Manager Publisher Portal
    - Subscription blocking/unblocking via the WSO2 API Manager Publisher Portal
    - Applying CORS configuration via the WSO2 API Manager Publisher Portal
    - Adding Key Managers via the WSO2 API Manager Admin Portal
    - WebSocket APIs
    - SOAP APIs
    - GraphQL APIs
    - Support for virtual hosts (Vhosts) to expose the APIs
    - Publishing APIs to multiple Gateway environments
    - Default API version
    - API Policies
    - Endpoints with mock implementation

- Security
    - JWT based OAuth2 authentication
    - JWT revocation
    - Defining multiple Key Managers via the configurations
    - Subscription validation with WSO2 API Manager
    - Subscription validation with self-contained tokens
    - Scope validation for JWT OAuth2 bearer tokens
    - Backend JWT generation (Passing end user details to the backend services, JWKS endpoint to validate backend JWT)
    - Support for API keys
    - Open Policy Agent(OPA) support
    - Mutual SSL authentication for APIs

- Rate Limiting
    - API/Resource, application, and subscription level rate limiting 
    - Advanced rate limiting, custom policies, and the blocking conditions

- Mediation and Message transformation
    - Request/Response Interceptors for APIs

- Service Discovery
    - Integrate with Consul for service discovery
    - Integrate with Consul Service Mesh

- Endpoints
    - Dynamic endpoint support
    - Advanced endpoint configurations
        - Retry and Timeouts
        - Circuit breaker
        - Load balance endpoints
        - Failover endpoints
    - Support Basic Auth protected endpoints
    - Mutual transport level security for Gateway to backend

- API Insights and Observability
    - Publish analytics to the Choreo Cloud
    - Open Tracing support: Jaeger, Zipkin, Azure App Insights and OpenTelemetry 

- Troubleshooting 
    - Enforcer REST API for troubleshooting purposes

- Configurations
    - Environment variable support for configurations

- Other
    - Immutable API artifact deploy support
    - Custom filter support at Enforcer
    - Deploy/undeploy APIs using the command line tool (APICTL)
    - Git Integration for Choreo Connect
    - HTTP2 support
    - Data compression: Gzip

## Unsupported Features

The Choreo Connect currently does not support the following major functionalities. However, they will be implemented in future iterations.

- Streaming APIs, namely SSE and WebSub/WebHook
- Subscription operation for GraphQL APIs
- gRPC APIs
- API Products
- Basic Authentication for APIs
- Bandwidth-based rate limiting for REST APIs
  
