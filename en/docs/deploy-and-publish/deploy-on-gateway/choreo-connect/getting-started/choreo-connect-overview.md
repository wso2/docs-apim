# Choreo Connect Overview

Choreo Connect (the API Microgateway) is an API Gateway for microservices, which is cloud-native, decentralized, and developer-centric.

WSO2 Choreo Connect is a lightweight message processor for APIs. You would need to use WSO2 Choreo Connect for message security, transport security, routing, and other common API Management related quality of services (QoS).

[![Choreo Connect Basic Architecture]({{base_path}}/assets/img/deploy/mgw/mgw_basic.png){: style="width:90%" }]({{base_path}}/assets/img/deploy/mgw/mgw_basic.png)

## Choreo Connect Components

Choreo Connect consists of the following three components.

- [Router](#router)
- [Enforcer](#enforcer)
- [Adapter](#adapter)

### Router

The Router is the component that is responsible for routing the traffic from different clients to the desired destination (service).
Choreo Connect uses the [Envoy Proxy](https://www.envoyproxy.io/) as the core component which does the traffic routing.
Choreo Connect exposes the APIs to external clients using the Router.

### Enforcer

The Enforcer is the component that enforces the API management capabilities such as security, rate limiting, analytics, validation and etc. When the Router within Choreo Connect receives a request, it forwards that request to the Enforcer in order to perform the additional QoS factors such as security, etc. Thereafter, the Enforcer will send a response to the Router. If the latter mentioned response is an allowed response, the Router will forward the request to the actual backend; else if the response is a denied response, then the Router will send a reply back to the client with an error message.

### Adapter

The Router and Enforcer have a Data Plane API that can be used to configure them dynamically. When an API needs to be deployed in Choreo Connect, the API definition needs to be translated into the format understood by the Router (convert the API into routes) and the Enforcer. The Adapter is the component that is responsible for the latter mentioned API definition translation. After the API definition is translated, the Adapter will pass the data to both the Router and the Enforcer.

The Adapter, within Choreo Connect, can receive the APIs via the following methods:

- From the WSO2 API Manager Control Plane (Publisher).
- By pushing the API project via the command line tool [APICTL]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller).

## Choreo Connect Modes

You can use Choreo Connect mainly in the following two modes.

- [Choreo Connect with API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane)
- [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway)

## Choreo Connect Request Flow

The request flow within Choreo Connect is depicted in the following diagram.

[![Choreo Connect Request Flow]({{base_path}}/assets/img/deploy/mgw/mgw_request_flow.png)]({{base_path}}/assets/img/deploy/mgw/mgw_request_flow.png)
