#API Microgateway Overview

WSO2 API Microgateway (WSO2 MGW) is an API Gateway for micro services, which is cloud-native, decentralized and developer centric.

The WSO2 API Microgateway is a lightweight message processor for APIs. The API Microgateway is used for message security, transport security, routing, and other common API Management related quality of services.

[![]({{base_path}}/assets/img/deploy/mgw/mgw_overview.png)]({{base_path}}/assets/img/deploy/mgw/mgw_overview.png)

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

## Micorgateway with API Manager as Control Plane.
Microgateway can connect to API Manager running on cloud or on-premise as its control plane. Microgateway can be configured to connect with
APIM control plane, so the user actions like API deploying, application creation, key generation, subscription creation and etc are received by the
microgateway seamlessly.

### Deploying API from Publisher portal
Following steps explains how API is getting deployed in microgateway upon API deploying action triggered in the publisher portal 


1. Configure microgateway `[controlPlane]` section to point to the API Manager
2. User creates a revision of the API
3. Select the microgateway as the gateway environment and deploys the API.
4. Adapter component of microgateway receives the event of API deploying from the APIM event hub component.
5. Adapter pulls the API object from the event hub upon receiving the API deploy event.
6. API is passed to the router and enforcer by the adapter

## Micorgateway as a Standalone gateway.
Microgateway can be used as a standalone gateway without the API Manager as the control plane. APIs can be deployed via 
APICTL. APICTL can be used to create projects by including the open API definitions. Projects can be directly pushed to adapter 
and adapter will deploy the API in the enforcer and the router.

When use as a standalone gateway, microgateway can be used with an external Secure Token Service(STS) 
which will provide signed JWTs, and microgateway will validate those JWTs in the incoming requests. When used as a standalone gateway microgateway
will not apply the subscription validation as the control plane is not available.