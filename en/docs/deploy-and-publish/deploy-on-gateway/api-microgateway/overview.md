# Overview

### Introduction

The WSO2 API Microgateway is a lightweight message processor for APIs. It is used for message security, transport security, routing, and other common API Management related quality of services. It can process incoming and outgoing messages while collecting information required for usage metering and throttling capabilities. The API Microgateway natively supports scaling in highly decentralized environments including microservice architecture. An immutable, ephemeral Microgateway fits well with the microservice architecture. The API Microgateway is also capable of operating in lockdown environments such as IoT devices since connectivity from the API Microgateway to the API Management system is not mandatory.

Setting up API Microgateways close to your backend servers and on-premise deployments not only reduces network latency but also adds additional security as you can run it in a fully controlled environment with a selected set of APIs. You can run the API Microgateway in a regional data center, in the same server instance as your service implementation, or even in your local workstation.

In summary, the API Microgateway is a simplified lightweight version of the API Gateway. However, the API Microgateway only supports a subset of the capabilities of the API Gateway.

### How the API Microgateway works

![API Microgateway overview]({{base_path}}/assets/img/api-mg-overview.png)

WSO2 API Microgateway comes with a toolkit that is responsible for API Microgateway related development tasks. This command line tool helps devlopers to create  API Microgateway projects, which are used later to build the executable for API Microgateway runtime component.

After setting up the API Mircogateway CLI, the user can initiate the API Microgateway project and can add any number of open APIs definitions (with WSO2 specific custom open API extensions) to the project, which are exposed via the runtime after the API Microgateway distribution is built using the CLI tool.

When you issue a build command, the project build is triggered and an executable is created with API definitions. You can directly run this executable on the Cloud, on-premise, or on a local workstation as required using the API Microgateway runtime component.

For details on how analytics works with API Microgateway and how to configure Analytics, see [Analytics for API Microgateway]({{base_path}}/observe/api-manager-analytics/configuring-analytics-for-microgateway.md) .


!!! info
    What's Next?
    [Microgateway Quick Start Guide]({{base_path}}/deploy/api-microgateway/getting-started/quick-start-guide/quick-start-guide-overview.md)


