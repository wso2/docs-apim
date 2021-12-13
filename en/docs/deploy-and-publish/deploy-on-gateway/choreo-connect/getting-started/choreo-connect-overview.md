# Choreo Connect Overview

Choreo Connect (the API Microgateway) is an API Gateway for microservices, which is cloud-native, decentralized, and developer-centric.

WSO2 Choreo Connect is a lightweight message processor for APIs. You would need to use WSO2 Choreo Connect for message security, transport security, routing, and other common API Management related quality of services (QoS).

The following diagram illustrates the basic architecture of Choreo Connect and showcases its main components.

[![Choreo Connect Basic Architecture]({{base_path}}/assets/img/deploy/mgw/choreo-connect-basic-architecture.png){: style="width:70%"}]({{base_path}}/assets/img/deploy/mgw/choreo-connect-basic-architecture.png)

## Choreo Connect Components

Choreo Connect consists of the following three components.

- [Router](#router)
- [Enforcer](#enforcer)
- [Adapter](#adapter)

### Router

The Router is the component that is responsible for routing the traffic from different clients to the desired destination (service). Choreo Connect uses the [Envoy Proxy](https://www.envoyproxy.io/) as the core component that does the traffic routing. Choreo Connect exposes the APIs to external clients using the Router.

### Enforcer

The Enforcer is the component that enforces the API management capabilities such as security, Rate Limiting, analytics, validation and etc. When the Router within Choreo Connect receives a request, it forwards that request to the Enforcer in order to perform the additional QoS factors such as security, etc. Thereafter, the Enforcer will send a response to the Router. If the latter mentioned response is an allowed response, the Router will forward the request to the actual backend; else if the response is a denied response, then the Router will send a reply back to the client with an error message.

### Adapter

The Router and Enforcer have a Data Plane API that can be used to configure them dynamically. When an API needs to be deployed in Choreo Connect, the API definition needs to be translated into the format understood by the Router (convert the API into routes) and the Enforcer. The Adapter is the component that is responsible for the latter mentioned API definition translation. After the API definition is translated, the Adapter will pass the data to both the Router and the Enforcer.

The Adapter, within Choreo Connect, can receive the APIs via the following methods:

- From the WSO2 API Manager Control Plane (Publisher).
- By pushing the API project via the command line tool [APICTL]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller).

## Communication Between the Components

Communication between internal components of Choreo Connect (Adapter, Enforcer, Router, and API-M Control Plane) are secured via Mutual SSL.

Each component has its private-public key pair and truststore. In the case of the Adapter, it is configured in the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/config.toml` file as indicated below.

??? note "Click here to see the file path of the configuration file for all Choreo Connect deployments."
    Navigate to the correct folder path and open the `config.toml` or `config-toml-configmap.yaml` file based on your Choreo Connect deployment.

    | **Deployment** | **File name** | **Directory** |
    |------------|-----------|-----------|
    | Docker with WSO2 API Controller | `config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/` |
    | Docker with WSO2 API Manager as the Control Plane | `config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/` |
    | Kubernetes with WSO2 API Controller | `config-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/` |
    | Kubernetes with WSO2 API Manager as the Control Plane | `config-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/config-toml-configmap.yaml` |

```toml
[adapter.keystore] 
certPath = "/home/wso2/security/keystore/mg.pem"
keyPath = "/home/wso2/security/keystore/mg.key"

[adapter.truststore]
location = "/home/wso2/security/truststore"
```

## Choreo Connect Modes

You can use Choreo Connect mainly in the following two modes.

- [Choreo Connect with API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane)
- [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway)

## Choreo Connect Request Flow

The request flow within Choreo Connect is depicted in the following diagram.

[![Choreo Connect Request Flow]({{base_path}}/assets/img/deploy/mgw/choreo-connect-request-flow.png)]({{base_path}}/assets/img/deploy/mgw/choreo-connect-request-flow.png)

When a client makes an API request, it is sent to the Router. The Router then forwards the request to the Enforcer. The Enforcer performs validations such as JWT access token validation, rate limiting, and other other validations. Once the API request has been validated, the Router forwards it to the backend service. The Router will respond to the client when the backend service responds. In addition, the Router sends stats about APIs to the Enforcer, and the Enforcer sends final analytics data to the Analytics Server.