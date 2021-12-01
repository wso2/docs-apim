# API Management in Istio Microservices Using Choreo Connect

Choreo Connect can be integrated with the Istio service mesh to provide API management for Istio microservices. Microservices can be deployed in Istio and exposed as APIs via Choreo Connect. This enables a variety of API management quality of services (QoS) for the API, such as message security rate-limiting, observability, and message mediation. You can productize the APIs and provide them to application developers via the WSO2 Developer Portal using WSO2 API Manager.

Choreo Connect can be integrated with Istio service mesh using the methods listed below.

### MTLS Mode

[![MTLS Mode]({{base_path}}/assets/img/deploy/istio-mtls.png)]({{base_path}}/assets/img/deploy/istio-mtls.png)

Microservices can be deployed in the Istio service mesh and made available using the Istio ingress gateway. Choreo Connect is deployed as the edge gateway in this method, where API Management for Istio microservices is applied. Requests come at the Choreo Connect, which validates them before sending them on to the Istio Ingress gateway, which sends them to the relevant microservice, as indicated in the diagram.

Istio MTLS sample can be found in [Github](https://github.com/wso2/product-microgateway/tree/main/samples/istio/mtls-mode).

### Sidecar Mode

[![Sidecar Mode]({{base_path}}/assets/img/deploy/istio-sidecar.png)]({{base_path}}/assets/img/deploy/istio-sidecar.png)

Microservices can be deployed in the Istio service mesh and made available using the Choreo Connect gateway. Choreo Connect is deployed in the Istio service mesh as a separate service where it applies API Management for the microservices. Requests arrive at the Istio ingress gateway and are routed to Choreo Connect. Once the Choreo Connect validates the request, it routes to the relevant microservices. 


Istio Sidecar sample can be found in [Github](https://github.com/wso2/product-microgateway/tree/main/samples/istio/sidecar-mode).
