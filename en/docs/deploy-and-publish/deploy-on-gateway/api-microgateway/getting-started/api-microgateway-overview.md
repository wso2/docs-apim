#API Microgateway Overview

WSO2 API Microgateway (WSO2 MGW) is an API Gateway for micro services, which is cloud-native, decentralized and developer centric.

The WSO2 API Microgateway is a lightweight message processor for APIs. The API Microgateway is used for message security, transport security, routing, and other common API Management related quality of services.

[![]({{base_path}}/assets/img/deploy/mgw/mgw_basic.png)]({{base_path}}/assets/img/deploy/mgw/mgw_basic.png)

## Micorgateway Components
Microgateway has three basic components. Each component does a vital part during request processing, and single unit of 
microgateway is a collection of all three components.

### 1. Router
Router is the component that is responsible for routing the traffic from different clients to the desired destination(service). 
Microgateway uses the [Envoy Proxy](https://www.envoyproxy.io/) as the core component which does the traffic routing. 
The APIs are exposed to the external clients using the router. 

### 2. Enforcer
Enforcer is the component which applies the API management capabilities like security, rate limiting, analytics, validation and etc. 
When a request is received by the router , that request is forwarded to the enforcer in order to perform the additional QoS factors like security and etc. 
Once the enforcer replied back to the router with an allowed response or a denied response then the router will either 
forward the request to the actual backend or reply back to the client with an error message respectively.

### 3. Adapter
Router and Enforcer have a data plane API that can be used to dynamically configure them. 
When an API needs to be deployed on the microgateway we need to translate that API definition to the format understood by the Router(convert the API into routes) and Enforcer. 
The adapter is the component that is responsible for that. Adapter will pass the data to the both the router and the enforcer. 
There are two different ways API can be received by the adapter.


1. Adapter can receive an API from APIM control plane(publisher) 
2. Adapter can receive APIs via pushing the API project from the command line tool [APICTL]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller.md)

Microgateway can be used mainly in the follwoing two modes.

1. [Micorgateway with API Manager as control plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/concepts/apim-as-control-plane)
2. [Microgateway As a standalone gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/concepts/as-a-standalone-gateway)

## Microgateway Request Flow

[![]({{base_path}}/assets/img/deploy/mgw/mgw_request_flow.png)]({{base_path}}/assets/img/deploy/mgw/mgw_request_flow.png)