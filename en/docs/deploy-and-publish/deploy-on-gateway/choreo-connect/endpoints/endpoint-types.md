# Endpoint Types

Endpoint types supported by Choreo Connect can be categorized based on multiple aspects.

- Based on key type
- Based on behavior
- Based on the service exposed by the endpoint

## Endpoint Types based on Key Type

- Production Endpoints
- Sandbox Endpoints

When an API is invoked using a JWT (access token or API key), the request gets routed depending on the key type defined in the JWT. In standalone mode, Production and Sandbox endpoints can be defined in the OpenAPI definition using [extensions]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/#openapi-extensions). With API Manager, these can be defined via the Endpoints tab in Publisher. If not defined, the request gets sent to the production endpoint. 

## Endpoint Types based on behavior (routing policy)

- [Load Balanced Endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/load-balanced-endpoints/#load-balanced-endpoints)
- [Failover Endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/failover-endpoints/)

By default, a single endpoint or a collection of endpoints is configured as Load Balanced endpoints in Choreo Connect.

## Endpoint Types based on the service exposed by the endpoint

Endpoints gets processed and validated based on the type of API as well. 

|Type                     |Description                                         |
|-------------------------|----------------------------------------------------|
| HTTP/ REST Endpoint     | A REST service endpoint based on a URI template.   |                  
| WebSocket Endpoint    | A HTTP based streaming endpoint implemented based on the WebSocket protocol. Once a connection is  established with the endpoint, a channel that enables two way communication is created providing pub sub capabilities. |                         

