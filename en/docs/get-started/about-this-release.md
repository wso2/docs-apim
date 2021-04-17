# About this Release

The WSO2 API Manager is a platform for building and managing APIs. It helps developers implement APIs by integrating different types of systems and APIs and to manage them using its API governance and lifecycle management capabilities. APIs could be built by integrating different types of APIs such as traditional request-response style APIs and event-driven APIs using a low-code/no-code development experience and expose to consumers through its API Gateway. 

For more information on WSO2 API Manager, see the [overview in the WSO2 API Manager 4.0.0 documentation]({{base_path}}/getting-started/overview/).

The **WSO2 API Manager 4.0.0** is the **latest** **WSO2 API Manager release** and is the successor of **WSO2 API Manager 3.2.0** and **WSO2 Enterprise Integrator 7.1.0**. It contains the following components, which have new features and enhancements:

---

## API Manager 

The API Manager component addresses all aspects of API management in the platform. It consists of an API Gateway, API Publisher, Developer Portal, Key Manager and Traffic Manager.

It is now available to download from [here](https://github.com/wso2/product-apim/releases/).

#### New features

- **[New Service Catalog that lists registered services]({{base_path}}/integrate/develop/working-with-service-catalog/)**
    WSO2 API Manager includes a Service Catalog where developers can register their services in a RESTful manner. Service Catalog is one of the main attributes that enable the API-first Integration in WSO2 API Manager. Through the Service Catalog, integration services are made discoverable to the API Management layer so that API proxies can directly be created using them.

- **[API and API Product Revision Support]({{base_path}}/design/create-api/create-api-revisions/)**
    If you are an API Publisher, there can be a situation where you need to keep track of the different deployments of your API. For this purpose, a new concept named **Revisions** has been introduced. The revisions of your API can be **deployed** to specific Gateway Environment(s) as needed. These revisions cannot be edited and you can even **restore** your API to a specific revision if you want to discard the latest changes.

- **[Swagger/GraphqL to Postman Collection]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console/)**
    [GraphQL](https://github.com/graphql/graphiql) is the graphical, interactive, web-based GraphQL integrated development environment (IDE) for GraphQL query and it has a reference implementation from the GraphQL Foundation. If required, instead of using the integrated GraphQL console you can try out your GraphQL API by downloading your GraphQL Schema as a Postman collection and trying it out on Postman. For more information, see [Try out using Postman]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/try-out-using-postman.md).

- **[Support for Forgerock Key Manager]({{base_path}}/administer/key-managers/configure-forgerock-connector/)** 
    WSO2 API Manager can connect to ForgeRock out-of-the-box using the [WSO2 API-M ForgeRock Connector](https://github.com/wso2-extensions/apim-km-forgerock). WSO2 API Manager has the capability to support multiple Key Managers at the same time. So with the use of connectors, it is capable of supporting any authorization server as a Key Manager, and in this case, it supports a connection to Forgerock as a third-party Key Manager.

- **[Support for Ping Key Manager]({{base_path}}/administer/key-managers/configure-pingfederate-connector/)** 
    WSO2 API Manager supports multiple Key Managers at the same time. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager, and with the use of connectors, it is capable of supporting any authorization server as a Key Manager. WSO2 API Manager can connect PingFederate out-of-the-box using the [WSO2 API-M PingFederate Connector](https://github.com/wso2-extensions/apim-km-pingfederate).

- **[Support for auth0 Key Manager]({{base_path}}/administer/key-managers/configure-auth0-connector/)** 
    It is possible to integrate the WSO2 API Manager with an external Identity and Access Management server (IAM) using the Auth0 OAuth Authorization Server to manage the OAuth clients and tokens that are required by WSO2 API Manager. WSO2 API Manager has inbuilt support to consume APIs exposed by Auth0 OAuth.

- **[Streaming API support in API Gateway]({{base_path}}/design/create-api/create-streaming-api/streaming-api-overview)**
    Streaming APIs are asynchronous APIs that support asynchronous message flows. Asynchronous message flows are popular in the event driven architecture. With Streaming APIs, you can expose and manage **WebSocket**, **WebSub (Webhook)** and **Server Sent Events (SSE)** backends in WSO2 API Manager.

- **[AsyncAPI Definitions for Streaming APIs]({{base_path}}/design/create-api/create-a-streaming-api-from-an-asyncapi-definition)**
    [AsyncAPI](https://www.asyncapi.com/) is used to define asynchronous APIs. In WSO2 API Manager, [Streaming APIs]({{base_path}}/design/create-api/create-streaming-api/streaming-api-overview) can be created by importing AsyncAPI definitions, and existing Streaming APIs can be exported as AsyncAPI definitions.

- **[Exposing APIs via Custom Hostnames (Virtual Hosts)]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/exposing-apis-via-custom-hostnames)**
    **Virtual Host** enables you to deploy an API or API Product Revision to a Gateway with a custom hostname. Gateway environments and its virtual hosts can be managed via Admin Portal, and the API Publisher can choose a host when deploying an API Revision or API Product Revision. 

<!--

- Changes to Publisher API/UI to support Streaming APIs

- Changes to Dev Portal REST API/UI to support Streaming APIs

- Improved Commenting Feature (Nested commenting, publisher view)

- Defaulting code and configs to do with event based
-->

#### Removed features and functionalities

- Microgateway Labels

      [Grouping APIs with Microgateway Labels](https://apim.docs.wso2.com/en/3.2.0/learn/api-microgateway/grouping-apis-with-labels/)
      is removed from this release. Instead, you can use [Virtual Hosts (VHosts)]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/exposing-apis-via-custom-hostnames)
      and dynamically manageable Gateway environments to group and expose APIs with custom hostnames.

---

## Micro Integrator

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

#### Compare this release with previous ESBs

Given below is a comparison of the Micro Integrator of API-M 4.0.0 and the previous WSO2 ESB runtimes. Note that the Micro Integrator of API-M 4.0.0 is the latest, most improved version of the WSO2 ESB runtime.

If you are migrating from a previous ESB, this comparison will help you understand the important changes in the Micro Integrator that will impact your migration.

!!! Note
	The following comparison is applicable to the following versions of the WSO2 ESB runtime:
	
	-	[WSO2 ESB 5.0](https://docs.wso2.com/display/ESB500/WSO2+Enterprise+Service+Bus+Documentation)
	-	[ESB profile of WSO2 EI 6.x.x series](https://docs.wso2.com/display/EI660/WSO2+Enterprise+Integrator+Documentation)

**Feature comparison**

The following table explains the availability of the most critical features in the ESB runtime and Micro Integrator runtime of API-M 4.0.0. In addition to the following list, the Micro Integrator runtime also contains [new and improved features](#micro-integrator) listed above.

<table>
	<tr>
		<th></th>
		<th>WSO2 ESB Runtime</th>
		<th>Micro Integrator Runtime</th>
	</tr>
	<tr>
		<td>
			Startup Time
		</td>
		<td>
			40s
		</td>
		<td>
			5s
		</td>
	</tr>
	<tr>
		<td>
			Distribution Size
		</td>
		<td>
			~600 MB
		</td>
		<td>
			~150 MB
		</td>
	</tr>
	<tr>
		<td>
			Product configuration model
		</td>
		<td>
			XML-based configurations
		</td>
		<td>
			<a href="{{base_path}}/reference/config-catalog-mi">TOML-based configurations</a>
		</td>
	</tr>
	<tr>
		<td>
			Mediation (ESB) Features
		</td>
		<td>
			Available
		</td>
		<td>
			Available
		</td>
	</tr>
	<tr>
		<td>
			Data Integration Features
		</td>
		<td>
			Available
		</td>
		<td>
			Available
		</td>
	</tr>
	<tr>
		<td>
			Task Coordination 
		</td>
		<td>
			Hazelcast based
		</td>
		<td>
			RDBMS based 
		</td>
	</tr>
	<tr>
		<td>
			Tooling
		</td>
		<td>
			<a href="{{base_path}}/integrate/develop/wso2-integration-studio">WSO2 Integration Studio</a>
		</td>
		<td>
			<a href="{{base_path}}/integrate/develop/wso2-integration-studio">WSO2 Integration Studio</a>
		</td>
	</tr>
	<tr>
		<td>
			Runtime monitoring and management
		</td>
		<td>
			Managemement Console
		</td>
		<td>
			<a href="{{base_path}}/observe/mi-observe/working-with-monitoring-dashboard">Micro Integrator Dashboard</a></br>
			<a href="{{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl">API Controller (CLI)</a>
		</td>
	</tr>
	<tr>
		<td>
			CAR Deployment
		</td>
		<td>
			Available
		</td>
		<td>
			Available
		</td>
	</tr>
	<tr>
		<td>
			Registry
		</td>
		<td>
			RDBMS-based Registry
		</td>
		<td>
			<a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry">File system based Registry</a>
		</td>
	</tr>
	<tr>
		<td>
			Hot deployment
		</td>
		<td>
			Available
		</td>
		<td>
			Available
		</td>
	</tr>
</table>

**Features removed**

The following features, which are available in ESB runtimes, are removed from the Micro Integrator of API-M 4.0.0 because they are not frequently used.

<table>
	<tr>
		<th>
			Feature
		</th>
		<th>
			Description
		</th>
		<th>
			Alternative
		</th>
	</tr>
	<tr>
		<td>
			Management Console
		</td>
		<td>
			<a href="{{base_path}}/integrate/develop/wso2-integration-studio">WSO2 Integration Studio</a> is the recommended tool for developing integration solutions. The monitoring capabilities available in the management console (of the ESB profile) are available through the new <a href="{{base_path}}/administer-and-observe/working-with-monitoring-dashboard">Micro Integrator dashboard</a>.
		</td>
		<td>
			<a href="{{base_path}}/observe/mi-observe/working-with-monitoring-dashboard">Micro Integrator Dashboard</a>
		</td>
	</tr>
	<tr>
		<td>
			Multitenancy
		</td>
		<td>
			This is not a widely used feature in the ESB profile. Multitenancy does not suit the world of microservices or micro integrations.
		</td>
		<td>
			-
		</td>
	</tr>
	<tr>
		<td>
			Svn based Dep-sync
		</td>
		<td>
			This is not a widely used feature in the ESB profile, and is not recommended for use.
		</td>
		<td>
			Third-party offering like <b>rsync</b>
		</td>
	</tr>
	<tr>
		<td>
			RDBMS-based Registry
		</td>
		<td>
			-
		</td>
		<td>
			<a href="{{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry">File system based Registry</a>
		</td>
	</tr>
	<tr>
		<td>
			Rule Mediator
		</td>
		<td>
			The rule mediator has been removed as it is not widely used.
		</td>
		<td>
			-
		</td>
	</tr>
	<tr>
		<td>
			HL7 Message Store
		</td>
		<td>
			In previous ESBs, an HL7 Message Store could be configured using the custom message store implementation. Due to limited capabilities and tight coupling with the Hl7 console (which was previously available in the management console), this functionality is not available in API-M 4.0.0. 
		</td>
		<td>
			-
		</td>
	</tr>
</table>

**Mediators and artifacts removed (After ESB 5.0.0)**

The following mediators and artifacts are removed from the ESB runtime in all versions after ESB 5.0.0. If you are migrating from ESB 5.0.0 to the Micro Integrator of API-M 4.0.0, note that these artifacts are no longer supported.

-	Priority Executors
-	Enqueue Mediator
-	Bean Mediator
-	POJO Command Mediator
-	Spring Mediator
-	Conditional Router Mediator
-	In, Out Mediators
-	Event Mediator
-	In memory Topics
-	Router Mediator
-	Publish Event Mediator

---

## Streaming Integrator

Streaming Integrator serves the streaming based integrations and acts as the event stream provider for Streaming APIs in the data plane of the API Manager platform.

It is now available to download from [here](https://github.com/wso2/streaming-integrator/releases/download/v4.0.0-m8/wso2si-4.0.0-m8.zip).

#### New features

- Deploy Async API definitions to the APIM Service Catalogue
- Add support to capture multiple operations from single cdc source
- Make regex matching dynamic in copy function
- Add SSE source functionality

---

## API Controller

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
    - Support to override subscription policies of an API using the params file
    - Support TLS renegotiation configuration
    - Support APICTL bundle command (archives an API Project) 

---

## WSO2 Integration Studio

WSO2 Integration Studio is an open-source development environment used to design and develop integration scenarios for WSO2 Micro Integrator.

It is now available to download from [here](https://github.com/wso2/integration-studio/releases/tag/v8.0.0-m8).

#### New features

- Added Cassandra data source support for DSS
- Added Registry Resource Properties support

---

## Streaming Integrator tooling

The Streaming Integrator Tooling is a developer tool to develop Siddhi applications and simulate events for testing purposes.

It is now available to download from [here](https://github.com/wso2/streaming-integrator-tooling/releases/download/v4.0.0-m8/wso2si-tooling-4.0.0-m8.zip).

#### New features

- Add support to capture multiple operations from single cdc source
- Make regex matching dynamic in copy function
- Add SSE source functionality

---

## Kubernetes API operator

The API operator for Kubernetes makes managed APIs for microservices and integrations in the Kubernetes ecosystem. 

It is now available to download from [here](https://github.com/wso2/k8s-api-operator/releases/tag/v2.0.0-alpha). K8s API Operator M3 is compatible with API Manager M4.

#### New features

- Deploy APIs to Microgateway
- Deploy APIs to API Manager

---

## Compatible WSO2 product versions

WSO2 API Manager 4.0.0 is based on WSO2 Carbon 4.6.1 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version. If you encounter any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

---

## Fixed and known issues

**API Manager**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/product-apim/milestone/92?closed=1).

- Known Issues - All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/product-apim/issues?q=is%3Aopen+is%3Aissue+label%3A%22API-M+4.0.0%22).

**Micro Integrator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/micro-integrator/milestone/23?closed=1).

- Known Issues - All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/micro-integrator/issues).

**Streaming Integrator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/streaming-integrator/milestone/13?closed=1).

- Known Issues - All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/streaming-integrator/issues).

**API Controller**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aissue+is%3Aclosed+label%3A4.0.0).

- Known Issues - All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aopen+is%3Aissue).

**Integration Studio**

- Fixed Issues - See [details of all the changes including new features, improvements, and bug fixes in this milestone release](https://github.com/wso2/integration-studio/milestone/7?closed=1).

- Known Issues - All the open issues pertaining to WSO2 Integration Studio are reported [here](https://github.com/wso2/integration-studio/issues).

**Streaming Integrator Tooling**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/streaming-integrator-tooling/milestone/12?closed=1).

- Known Issues - All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/streaming-integrator-tooling/issues).

**Kubernetes API Operator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/k8s-api-operator/issues?q=is%3Aissue+milestone%3Av2.0.0-alpha+is%3Aclosed).

- Known Issues - All the open issues pertaining to WSO2 API Manager-4.0.0-Alpha are reported [here](https://github.com/wso2/k8s-api-operator/issues?q=is%3Aopen+is%3Aissue+label%3A2.0.0).
