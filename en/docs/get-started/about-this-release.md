# About this Release

The WSO2 API Manager is a platform for building and managing APIs. It helps developers implement APIs by integrating different types of systems and APIs and to manage them using its API governance and lifecycle management capabilities. APIs could be built by integrating different types of APIs such as traditional request-response style APIs and event-driven APIs using a low-code/no-code development experience and expose to consumers through its API Gateway. 

For more information on WSO2 API Manager, see the [overview in the WSO2 API Manager 4.0.0 documentation]({{base_path}}/getting-started/overview/).

## What is new in this release

The **WSO2 API Manager 4.0.0-Alpha** is the **latest** **WSO2 API Manager release** and is the successor of **WSO2 API Manager 3.2.0**. It contains the following components, which have new features and enhancements:

---

### API Manager 

The API Manager component addresses all aspects of API management in the platform. It consists of an API Gateway, API Publisher, Developer Portal, Key Manager and Traffic Manager.

It is now available to download from [here](https://github.com/wso2/product-apim/releases/download/v4.0.0-alpha/wso2am-4.0.0-alpha.zip).

#### New features

- **[New Service Catalog that lists registered services]({{base_path}}/integrate/develop/working-with-service-catalog/)**
    WSO2 API Manager includes a Service Catalog where developers can register their services in a RESTful manner. Service Catalog is one of the main attributes that enable the API-first Integration in WSO2 API Manager. Through the Service Catalog, integration services are made discoverable to the API Management layer so that API proxies can directly be created using them.

- **[API and API Product Revision Support]({{base_path}}/design/create-api/create-api-revisions/)**
    If you are an API Publisher, there can be a situation where you need to keep track of the different deployments of your API. For this purpose, a new concept named **Revisions** has been introduced. The revisions of your API can be **deployed** to specific Gateway Environment(s) as needed. These revisions cannot be edited and you can even **restore** your API to a specific revision if you want to discard the latest changes.

- **[Swagger/GraphqL to Postman Collection]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console/)**
    [GraphQL](https://github.com/graphql/graphiql) is the graphical, interactive, web-based GraphQL integrated development environment (IDE) for GraphQL query and it has a reference implementation from the GraphQL Foundation. If required, instead of using the integrated GraphQL console you can try out your GraphQL API by downloading your GraphQL Schema as a Postman collection and trying it out on Postman. For more information, see [Try out using Postman]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/try-out-using-postman.md).

- **[Support for Forgerock Key Manager]({{base_path}}/administer/key-managers/configure-forgerock-connector/)** 
    WSO2 API Manager can connect to ForgeRock out-of-the-box using the [WSO2 API-M ForgeRock Connector](https://github.com/wso2-extensions/apim-km-forgerock). WSO2 API Manager has the capability to support multiple Key Managers at the same time. So with the use of connectors, it is capable of supporting any authorization server as a Key Manager, and in this case, it supports a connection to Forgerock as a third-party Key Manager.

- **[Support for Ping Key Manager]({{base_path}}/administer/key-managers/configure-pingfederate-connector/)** 
    WSO2 API Manager supports multiple Key Managers at the same time. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager, and with the use of connectors, it is capable of supporting any authorization server as a Key Manager. WSO2 API Manager can connect PingFederate out-of-the-box using the [WSO2 API-M PingFederate Connector](https://github.com/wso2-extensions/apim-km-pingfederate).

- **[Support for auth0 Key Manager]({{base_path}}/administer/key-managers/configure-auth0-connector/)** 
    It is possible to integrate the WSO2 API Manager with an external Identity and Access Management server (IAM) using the Auth0 OAuth Authorization Server to manage the OAuth clients and tokens that are required by WSO2 API Manager. WSO2 API Manager has inbuilt support to consume APIs exposed by Auth0 OAuth.

- **Support for Server-Sent Event Messaging Protocol in API Gateway**
    Server Sent Event is one of the protocols that support the asynchronous message flow. Server Sent Event API enables you to expose and manage the Server Sent Event (SSE) backend via a Streaming API in API Manager.
<!--
- WebSocket Support with Async APIs

- Webhook Support For API Gateway

- Changes to Publisher API/UI to support Streaming APIs

- Changes to Dev Portal REST API/UI to support Streaming APIs

- Generating AsyncAPI spec for existing services

- VHost feature

- Improved Commenting Feature (Nested commenting, publisher view)

- Defaulting code and configs to do with event based
-->

#### Fixed Issues

See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/product-apim/milestone/92?closed=1).

#### Known Issues

All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/product-apim/issues?q=is%3Aopen+is%3Aissue+label%3A%22API-M+4.0.0%22).

---

### Micro Integrator

The Micro Integrator is a cloud-native, standards-based messaging engine and an integration framework with a configuration based runtime environment for integrating APIs, services, data, SaaS, proprietary, and legacy systems.

This serves the integration needs for the data plane of the API Manager platform.

It is now available to download from [here](https://github.com/wso2/micro-integrator/releases/download/v4.0.0-m8/wso2mi-4.0.0-m8.zip).

#### New features

- **[New and improved File Connector]({{base_path}}/reference/connectors/file-connector/file-connector-overview/)**
    The File Connector allows you to connect to different file systems and perform various operations. The File Connector uses the [Apache Commons VFS](https://commons.apache.org/proper/commons-vfs/) I/O functionalities to execute operations. For more information, see **[File Connector Example]({{base_path}}/reference/connectors/file-connector/file-connector-example/)** and **[File Connector Reference]({{base_path}}/reference/connectors/file-connector/file-connector-config/)**.

- **[Hashicorp Secure Vault]({{base_path}}/install-and-setup/setup/mi-setup/security/using-hashicorp-secrets/)**
    By default, the Micro Integrator is configured to use WSO2 secure vault for encrypting secrets. However, you may encounter certain limitations with WSO2 secure vault if you use secrets with a large number of characters. You can overcome this issue by using HashiCorp secrets.

- **[JSON evaluation support for property mediator]({{base_path}}/reference/mediators/property-mediator/)**
    Enhanced JSON evaluation support was added for the property mediator.

- **[FreeMarker support PayloadFactory mediator]({{base_path}}reference/mediators/payloadfactory-mediator/)**
    You can now use the **FreeMarker** template to write the payload. This is particularly useful when defining complex JSON payloads.

- **[OAuth endpoint](reference/synapse-properties/endpoint-properties/)**
    A message exit point or an endpoint defines an external destination for a message. Typically, this is the address of a proxy service that acts as the front end to the actual service. You can configure the endpoint artifacts with any attributes or semantics needed for communicating with that service. An endpoint could represent a URL, a mailbox, a JMS queue, a TCP socket, etc. along with the settings needed for the connection.

- **[Call mediator improvement]({{base_path}}/reference/mediators/call-mediator/)**
    Improvements have been made to the call mediator so that it can now store the response to a property.

- **[Generating service catalog entry (open API definition)]({{base_path}}/integrate/develop/working-with-service-catalog/)**
    WSO2 API Manager includes a Service Catalog where developers can register their services in a RESTful manner. Integration services can be created when deploying your project as a C-App. These integration services are made discoverable to the API Management layer via the Service Catalog so that API proxies can directly be created using them.

#### Fixed Issues

See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/micro-integrator/milestone/23?closed=1).

#### Known Issues

All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/micro-integrator/issues).

---

### Streaming Integrator

Streaming Integrator serves the streaming based integrations and acts as the event stream provider for Streaming APIs in the data plane of the API Manager platform.

It is now available to download from [here](https://github.com/wso2/streaming-integrator/releases/download/v4.0.0-m8/wso2si-4.0.0-m8.zip).

#### New features

- Deploy Async API definitions to the APIM Service Catalogue
- Add support to capture multiple operations from single cdc source
- Make regex matching dynamic in copy function
- Add SSE source functionality

#### Fixed Issues

See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/streaming-integrator/milestone/13?closed=1).

#### Known Issues

All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/streaming-integrator/issues).

---

### API Controller

WSO2 API Controller is a command-line tool providing the capability to move APIs, API Products, and Applications across environments and to perform CI/CD operations. It can also be used to perform these same tasks on a Kubernetes deployment. In addition, API Controller can be used as a developer CLI tool for API Microgateway. Furthermore, it can perform Micro Integrator server specific operations such as monitoring Synapse artifacts and performing MI management/administrative tasks from the command line. 

It is now available to download from [here](https://github.com/wso2/product-apim-tooling/releases/tag/v4.0.0-alpha).

#### New features

- **[API Controller as a developer CLI tool for Microgateway]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/)**
    This includes the following features and improvements:
    - Merge Micro Integrator cli commands with APICTL
    - Support import/export revisioning of APIs- Adding proxy environment variables support for APICTL
    - Alias for APICTL commands ([)APICTL)
    - Resolve parameters at server side while importing an API project
    - Defining schemas for API Controller API/API Product project artifacts (A part of migrating data via apictl)
    - Defining schemas for API Controller Application project artifacts (A part of migrating data via apictl)
    - Support to override subscription policies of an API using the api_params.yaml
    - Support TLS renegotiation configuration
    - Support APICTL bundle command (archives an API Project) 

#### Fixed Issues

See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aissue+is%3Aclosed+label%3A4.0.0).

#### Known Issues

All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aopen+is%3Aissue).

---

### WSO2 Integration Studio

WSO2 Integration Studio is an open-source development environment used to design and develop integration scenarios for WSO2 Micro Integrator.

It is now available to download from [here](https://github.com/wso2/integration-studio/releases/tag/v8.0.0-m8).

#### New features

- Added Cassandra data source support for DSS
- Added Registry Resource Properties support

#### Fixed Issues

See [details of all the changes including new features, improvements, and bug fixes in this milestone release](https://github.com/wso2/integration-studio/milestone/7?closed=1).

#### Known Issues

All the open issues pertaining to WSO2 Integration Studio are reported [here](https://github.com/wso2/integration-studio/issues).

---

### Streaming Integrator tooling

The Streaming Integrator Tooling is a developer tool to develop Siddhi applications and simulate events for testing purposes.

It is now available to download from [here](https://github.com/wso2/streaming-integrator-tooling/releases/download/v4.0.0-m8/wso2si-tooling-4.0.0-m8.zip).

#### New features

- Add support to capture multiple operations from single cdc source
- Make regex matching dynamic in copy function
- Add SSE source functionality

#### Fixed Issues

See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/streaming-integrator-tooling/milestone/12?closed=1).

#### Known Issues

All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/streaming-integrator-tooling/issues).

---

### Kubernetes API operator

The API operator for Kubernetes makes managed APIs for microservices and integrations in the Kubernetes ecosystem. 

It is now available to download from [here](https://github.com/wso2/k8s-api-operator/releases/tag/v2.0.0-alpha). K8s API Operator M3 is compatible with API Manager M4.

#### New features

- Deploy APIs to Microgateway
- Deploy APIs to API Manager

#### Fixed Issues

See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/k8s-api-operator/issues?q=is%3Aissue+milestone%3Av2.0.0-alpha+is%3Aclosed).

#### Known Issues

All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/k8s-api-operator/issues?q=is%3Aopen+is%3Aissue+label%3A2.0.0).

---

## Compatible WSO2 product versions

WSO2 API Manager 4.0.0-Alpha is based on WSO2 Carbon 4.6.1 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version. If you encounter any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).
