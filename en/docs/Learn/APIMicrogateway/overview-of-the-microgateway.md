# Overview of the Microgateway

-   [Introduction](#OverviewoftheMicrogateway-Introduction)
-   [Capabilities of the Microgateway](#OverviewoftheMicrogateway-CapabilitiesoftheMicrogateway)
-   [When to use the Microgateway](#OverviewoftheMicrogateway-WhentousetheMicrogateway)
-   [When to use the API Gateway](#OverviewoftheMicrogateway-WhentousetheAPIGateway)
-   [How the Microgateway works](#OverviewoftheMicrogateway-HowtheMicrogatewayworks)

### Introduction

The WSO2 API Microgateway is a lightweight message processor for APIs. The Microgateway is used for message security, transport security, routing, and other common API Management related quality of services. It can process incoming and outgoing messages while collecting information required for usage metering and throttling capabilities. The Microgateway natively supports scaling in highly decentralized environments including microservice architecture. An immutable, ephemeral Microgateway fits well with the microservice architecture. The Microgateway is also capable of operating in lockdown environments such as IoT devices, since connectivity from the Microgateway to the API Management system is not mandatory.

Setting up Microgateways close to your backend servers and on-premise deployments not only reduces network latency, but also adds additional security as you can run it in a fully controlled environment with a selected set of APIs. You can run the Microgateway in a regional data center, in the same server instance as your service implementation, or even in your local workstation.

In summary, the Microgateway is a simplified lightweight version of the API Gateway. However, the Microgateway only supports a subset of the capabilities of the API Gateway.

### Capabilities of the Microgateway

-   **Fits the microservice architecture -** Since the Microgateway has only a small startup delay and consumes less resources, it natively supports container-based deployments. When there is a requirement to scale the Microgateway, it can be done easily because of its design. Immutable, ephemeral gateways help to build cloud-native API Management solutions and simple and infinitely repeatable deployments that use continuous integration/delivery would be much easier with the Microgateway. Due to these capabilities, server and node failures do not result in your service going down.

<!-- -->

-   **Accelerates rapid development -** Unlike in the typical complete API Gateway, users can easily run a set of selected APIs in a controlled environment within seconds in the Microgateway. For example, if you need to do a quick debug on an API invocation flow, you can simply setup the Microgateway in a local workstation without doing a full-blown deployment.

<!-- -->

-   **Low resource consumption and efficiency -** The Microgateway is capable of running on very low memory and CPU consumption. Its lightweight design allows the Microgateway to load just the minimum required components to process API calls. The following are the recommended system requirements.
    |        |        |
    |--------|--------|
    | CPU    | 2 Core |
    | Memory | 256MB  |

<!-- -->

-   **Reduces network latency -** You can deploy the Microgateway close to backend services depending on the requirement. If necessary, the Microgateway can be deployed in regional datacenters or within the same subnet where your services reside. Therefore, you do not need to route your API calls through the internet or different network segments.

<!-- -->

-   **Dev-ops friendly -** No programming is needed to set up and manage the Microgateway and it can be done only using configurations or environment variables that can override configurations. If needed, you can easily integrate the Microgateway management with a container management system and automate the deployment process.

<!-- -->

-   **Enhanced security -** If your API consumer and producer both reside within the same network or in close proximity, there is no point in routing that traffic through a Cloud Gateway. You can simply route that traffic through a Microgateway residing within the same network. This helps to reduce network latency. Routing traffic within the same network boundaries also helps to address security concerns and compliance with certain regulations.

### When to use the Microgateway

-   To run a Gateway in a lockdown environment or offline mode with no connection to the API Management system.

-   To run a set of selected APIs in a controlled environment such as in private jet gateway mode, particularly when you see unusual traffic patterns on an API and need to scale it by itself.

-   To scale only a set of selected APIs according to traffic patterns. An independently scalable set of APIs can be run using the Microgateway.

-   In internal or on-premise API Gateway deployments where consumers (delivery channels) and service instances reside within the same network. In such cases, having the Microgateway within close proximity to a backend server reduces latency.

-   When there is a requirement to run a Gateway in sidecar mode along with an application server within the same runtime (or same pod in Kubernetes).

### When to use the API Gateway

-   When there is requirement to throttle API calls based on counters across all Gateway nodes.

-   To run an API Gateway as  acentralized Gateway that can handle requests for many different APIs and different backend servers.

-   When using traditional SOAP architecture requiring the Gateway to perform mediations and orchestrations.

### How the Microgateway works

![](/assets/attachments/103333747/103333748.png)
API Manager comes with a Microgateway that is responsible for Microgateway related management tasks. This command line tool accepts issued commands and you are able to communicate with the API Management core runtime (API Publisher) and build the Microgateway runtime. The API Microgateway communicates with the API Publisher to retrieve the API metadata required to create the Microgateway runtime.

Upon API Gateway CLI setup, users provide the label name (logical group of APIs), the API Management core base URL, the username and password. With this information, the CLI communicates with APIs exposed from the API core and creates a Gateway runtime project for the given label where all APIs are included under a given label. All throttling policies required for runtime are also created.

When you issue a build command, the project build is triggered and a single distribution is created with API definitions. You can directly run this on the Cloud, a premise deployment, or a local workstation, as required.

For details on how analytics works with Microgateway and how to configure it, see [Analytics for Microgateway](https://docs.wso2.com/display/AM250/Analytics+for+Microgateway) .

!!! info
What's Next?

[Microgateway Quick Start](https://docs.wso2.com/display/AM250/Microgateway+Quick+Start)


