# Endpoint Types

Endpoint types supported by Choreo Connect can be categorized based on multiple aspects.

- Based on the key type
- Based on the behavior
- Based on the backend service type

## Endpoint Types based on the Key Type

- Production Endpoints
- Sandbox Endpoints

When an API is invoked using a JWT (access token or API key), the request gets routed depending on the key type defined in the JWT. In standalone mode, Production and Sandbox endpoints can be defined in the OpenAPI definition using [extensions]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/#openapi-extensions). With API Manager, these can be defined via the Endpoints tab in Publisher. If not defined, the request gets sent to the production endpoint. 

## Endpoint Types based on the behavior (routing policy)

- [Load Balanced Endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/load-balanced-endpoints/#load-balanced-endpoints)
- [Failover Endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/failover-endpoints/)

By default, a single endpoint or a collection of endpoints is configured as Load Balanced endpoints in Choreo Connect.

## Endpoint Types based on the backend service type

The endpoint type and the URL components are processed and validated based on the type of the API during the time of deployment. 

|Type                     |Description                                         |
|-------------------------|----------------------------------------------------|
| HTTP/ REST Endpoint     | A REST service endpoint based on a URI template. The steps to expose a REST service can be found in [Deploying a REST API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/). |                  
| WebSocket Endpoint    | A HTTP based streaming endpoint implemented based on the WebSocket protocol. Once a connection is  established with the endpoint, a channel that enables two way communication is created providing pub sub capabilities. The steps to expose a WebSocket endpoint can be found in [Deploying a WebSocket API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-websocket-api-in-choreo-connect/).| 
| SOAP Endpoint           | A WSDL based SOAP endpoint that uses XML as the message format. You can expose [SOAP endpoints as pass-though APIs]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-soap-api-passthrough/) for the existing service, or [expose as REST APIs with the mediation of WSO2 Micro Integrator]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-to-soap-api/) that would perform the SOAP to REST transformation. |                        

!!! tip

    Choreo Connect also has an Endpoint type named **Mock Implementation**, in which the Gateway itself behaves as a backend returning sample payloads. Refer to [Mock Implementation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-with-mock-impl/) to learn more.

## See also
- [Passing End User Attributes to the Backend - Backend JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/passing-enduser-attributes-to-the-backend-via-choreo-connect/)
- [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately)
- [Backend Certificates]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/backend-certificates/)
- [Mutual TLS Between Choreo Connect and Backend]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/tls/mutual-tls-between-gateway-and-backend/)
- [Defining a Backend Security Scheme]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/defining-a-backend-security-scheme/)
