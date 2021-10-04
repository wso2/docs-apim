# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It allows API developers to design, publish, and manage the lifecycle of APIs and API product managers to create API products from one or more APIs. APIs can be built by integrating different types of APIs such as traditional request-response style APIs and Event-driven APIs using a low-code/no-code development experience, and the APIs can be exposed to consumers through its API Gateway. 

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

The **WSO2 API Manager 4.1.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.0.0**. It contains the following components, which have new features and enhancements:

## **API Manager**

The API Manager component addresses all aspects of API management in the platform. It consists of an API Gateway, API Publisher, Developer Portal, Key Manager, and Traffic Manager.

It is now available to download from [here](https://wso2.com/api-management/#).

### New features

- **[Exposing an Integration SOAP Service as a Managed API]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial-for-proxy-services.md)**

  WSO2 API Manager includes a Service Catalog where developers can register their backend services as Managed APIs. Through the Service Catalog, now SOAP integration services are made discoverable to the API Management layer so that SOAP PassThrough API proxies can directly be created using them.

### Deprecated features and functionalities

The support for these features will be removed from subsequent versions starting from WSO2 API Manager 4.1.0.

### Removed features and functionalities

These features are unsupported and removed from WSO2 API Manager 4.1.0 onwards.

### Key changes


## **Micro Integrator**

The Micro Integrator is a cloud-native, standards-based messaging engine and an integration framework with a configuration-based runtime environment for integrating APIs, services, data, SaaS, proprietary, and legacy systems. This is a newly added component to WSO2 API Manager 4.0.0.

This serves the integration needs for the data plane of the API Manager platform.

It is now available to download from [here](https://wso2.com/api-management/#).

### New features

- **[Audit Log support]({{base_path}}/observe/micro-integrator/classic-observability-logs/monitoring-mi-audit-logs)**

  The Audit Log capability allows you to add logging for the Micro Integrator Management API. Maintaining Audit Logs allows you to identify the changes that took place in the Micro Integrator instance and also to identify as to who made those changes.

## **Streaming Integrator**

Streaming Integrator serves the streaming-based integrations and acts as the event stream provider for Streaming APIs in the data plane of the API Manager platform. This is a newly added component into WSO2 API Manager 4.0.0.

It is now available to download from [here](https://github.com/wso2/streaming-integrator/releases/download/v4.0.0/wso2si-4.0.0.zip).

### New features


## **API Controller (apictl)**

WSO2 API Controller (apictl) is a command-line tool providing the capability to move APIs, API Products, and Applications across environments and to perform CI/CD operations. It can also be used to perform these same tasks on a Kubernetes deployment. In addition, apictl can be used as a developer CLI tool for Choreo Connect. Furthermore, it can perform Micro Integrator server-specific operations such as monitoring Synapse artifacts and performing MI management/administrative tasks from the command line.

It is now available to download from [here](https://wso2.com/api-management/tooling/).

### New features


## **WSO2 Integration Studio**

WSO2 Integration Studio is an open-source development environment used to design and develop integration scenarios for WSO2 Micro Integrator.

It is now available to download from [here](https://wso2.com/integration/integration-studio/).

### New features

- **[Generate data service definitions using a given datasource]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services/#generate-data-service-from-a-datasource)**

  This feature allows you to generate dataservice definitions by pointing to an existing datasource in the workspace without creating that from scratch.

## **Micro Integrator Dashboard**

The Micro Integrator dashboard can connect to multiple Micro Integrator server instances and monitor artifacts and logs from a selected cluster or group of server nodes.

It is now available to download from [here](https://github.com/wso2/micro-integrator/releases/).

### New features


## **Streaming Integrator Tooling**

The Streaming Integrator Tooling is a developer tool to develop Siddhi applications and simulate events for testing purposes.

It is now available to download from [here](https://github.com/wso2/streaming-integrator-tooling/releases/).

### New features


## Choreo Connect

The Choreo Connect is a lightweight gateway for APIs. It is used for message security, transport security, routing, and other common API Management related quality of services. It can collect information required for usage metering and throttling capabilities. The Choreo Connect natively supports scaling in highly decentralized environments including microservice architecture.

#### New features


## **Kubernetes API Operator**

Microservices are increasingly being deployed on Kubernetes. As a result, it is important to expose these microservices as well documented, easy to consume, managed APIs so that they can be used to develop great applications. The API operator for Kubernetes makes APIs a first-class citizen in the Kubernetes ecosystem. Similar to deploying microservices, you can now use this operator to deploy APIs for individual microservices or compose several microservices into individual APIs. With this, users can expose their microservice as managed APIs in the Kubernetes environment without any additional work.

The API operator for Kubernetes provides first-class support for Micro Integrator deployments in the Kubernetes ecosystem. It uses the Integration custom resource (`integration_cr.yaml` file) that is available in the Kubernetes project (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

It is now available to download from [here](https://github.com/wso2/k8s-api-operator/releases/).
K8s API Operator v2.0.0 is compatible with API Manager v4.0.0.

### New features


## **Compatible WSO2 product versions**

WSO2 API Manager 4.1.0 is based on WSO2 Carbon 4.6.1 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version. If you encounter any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

<hr style="border:8px solid gray"> </hr>

## **Fixed and known issues**

**API Manager**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release]().

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.1.0 are reported [here]().

**Micro Integrator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release]().

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.1.0 are reported [here]().

**Streaming Integrator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release]().

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.1.0 are reported [here]().

**API Controller**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release]().

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.1.0 are reported [here]().

**Integration Studio**

- Fixed Issues - See [details of all the changes including new features, improvements, and bug fixes in this milestone release]().

- Known Issues - All the open issues pertaining to WSO2 Integration Studio are reported [here]().

**Micro Integrator Dashboard**

- Fixed Issues - See [details of all the changes including new features, improvements, and bug fixes in this release]().

- Known Issues - All the open issues pertaining to WSO2 Integration Studio are reported [here]().

**Streaming Integrator Tooling**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release]().

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.1.0 are reported [here]().

**Choreo Connect**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release]()
- Known Issues - All the open issues are reported [here]().

**Kubernetes API Operator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release]().

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.1.0 are reported [here]().
