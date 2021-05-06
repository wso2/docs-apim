# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It allows API developers to design, publish, and manage the lifecycle of APIs and API product managers to create API products from one or more APIs. APIs can be built by integrating different types of APIs such as traditional request-response style APIs and Event-driven APIs using a low-code/no-code development experience, and the APIs can be exposed to consumers through its API Gateway. 

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

The **WSO2 API Manager 4.0.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 3.2.0** and **WSO2 Enterprise Integrator 7.1.0**. It contains the following components, which have new features and enhancements:

## **API Manager**

The API Manager component addresses all aspects of API management in the platform. It consists of an API Gateway, API Publisher, Developer Portal, Key Manager, and Traffic Manager.

It is now available to download from [here](https://wso2.com/api-management/#).

### New features

- **[New Service Catalog that lists registered services]({{base_path}}/design/create-api/create-an-api-using-a-service/)**
    
	 WSO2 API Manager includes a Service Catalog where developers can register their services in a RESTful manner. Service Catalog is one of the main attributes that enable the API-first Integration in WSO2 API Manager. Through the Service Catalog, integration services are made discoverable to the API Management layer so that API proxies can directly be created using them.

- **[API and API Product revision support]({{base_path}}/design/create-api/create-api-revisions/)**
    
	 If you are an API Publisher, there can be a situation where you need to keep track of the different deployments of your API. For this purpose, a new concept named **Revisions** has been introduced. The revisions of your API can be **deployed** to specific Gateway Environment(s) as needed. You cannot edit the revisions. However, if required, you can **restore** your API to a specific revision if you want to discard the latest changes.

- **[OpenAPI or GraphQL to Postman Collection]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console/)**

    If required, instead of using the integrated GraphQL console or the integrated API Console, you can try out your GraphQL API and REST API respectively by downloading a Postman collection for your API and trying it out on Postman. For more information, see [Try out using Postman]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/try-out-using-postman/).

- **[Support for ForgeRock Key Manager]({{base_path}}/administer/key-managers/configure-forgerock-connector/)**

    WSO2 API Manager can connect to ForgeRock out-of-the-box using the [WSO2 API-M ForgeRock Connector](https://github.com/wso2-extensions/apim-km-forgerock). WSO2 API Manager has the capability to support multiple Key Managers at the same time. So with the use of connectors, it is capable of supporting any authorization server as a Key Manager, and in this case, it supports a connection to ForgeRock as a third-party Key Manager.

- **[Support for PingFederate Key Manager]({{base_path}}/administer/key-managers/configure-pingfederate-connector/)**

    WSO2 API Manager supports multiple Key Managers at the same time. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager, and with the use of connectors, it is capable of supporting any authorization server as a Key Manager. WSO2 API Manager can connect PingFederate out-of-the-box using the [WSO2 API-M PingFederate Connector](https://github.com/wso2-extensions/apim-km-pingfederate).

- **[Support for Auth0 Key Manager]({{base_path}}/administer/key-managers/configure-auth0-connector/)**

    It is possible to integrate the WSO2 API Manager with an external Identity and Access Management server (IAM) using the Auth0 OAuth Authorization Server to manage the OAuth clients and tokens that WSO2 API Manager requires. WSO2 API Manager has inbuilt support to consume APIs exposed by Auth0 OAuth.

- **[Streaming API support in API Gateway]({{base_path}}/design/create-api/create-streaming-api/streaming-api-overview)**

    Streaming APIs refer to APIs that have AsyncAPI definitions and use the **WebSocket**, **WebSub (WebHook)**, and **Server-Sent Events (SSE)** protocols. Streaming APIs are popular in the Event-driven architecture (EDA). With Streaming APIs, you can expose and manage **WebSocket**, **WebSub (WebHook)**, and **Server-Sent Events** backends in WSO2 API Manager. In WSO2 API Manager, Streaming APIs can be created by importing AsyncAPI definitions, and existing Streaming APIs can be exported as AsyncAPI definitions.

- **[Exposing APIs via Custom Hostnames (Virtual Hosts)]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/exposing-apis-via-custom-hostnames)**

    **Virtual Host** enables you to deploy an API or API Product Revision to a Gateway with a custom hostname. Gateway environments and its virtual hosts can be managed via the Admin Portal, and the API Publisher can choose a host when deploying an API Revision or API Product Revision. 

<!--

- Changes to Publisher API/UI to support Streaming APIs

- Changes to Dev Portal REST API/UI to support Streaming APIs

- Improved Commenting Feature (Nested commenting, publisher view)

- Defaulting code and configs to do with event based
-->

### Removed features and functionalities

- Microgateway Labels

      [Grouping APIs with Microgateway Labels](https://apim.docs.wso2.com/en/3.2.0/learn/api-microgateway/grouping-apis-with-labels/)
      is removed from this release. Instead, you can use [Virtual Hosts (VHosts)]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/exposing-apis-via-custom-hostnames)
      and dynamically manageable Gateway environments to group and expose APIs with custom hostnames.

### Key changes

- The name of the startup script has changed from `wso2server.sh` (Linux/Mac OS) and `wso2server.bat` (Windows) to `api-manager.sh` and `api-manager.bat` respectively. For instructions, see [Running the Product]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

- The endpoints mentioned below previously worked through the Gateway. In API-M 4.0.0, WSO2 has moved them separately as follows:   
    
    | **Until 3.2.0**        | **In 4.0.0**           |
    | :------------- |:-------------|
    | `https://<gateway-host>/token`      | `https://<keymanager-host>/oauth2/token` |
    | `https://<gateway-host>/revoke`      | `https://<keymanager-host>/oauth2/revoke`      |
    | `https://<gateway-host>/authorize`      | `https://<keymanager-host>/oauth2/authorize`      |
    | `https://<gateway-host>/userInfo` | `https://<keymanager-host>/oauth2/userInfo` |

- Distributed setup profiles were refactored to three profiles from APIM-4.0.0 onwards.
      
    | **Profile**        | **Description**           | **Startup Argument**  |
    | :------------- |:-------------| :-----|
    | Control Plane profile      | This profile contains the Publisher, Developer Portal, Key Manager, and Traffic Manager </br>components. </br>If you need to use the Traffic Manager profile separately, you need to disable </br>the Traffic Manager component in the Control Plane profile. </br>For more information, see [API-M 4.0.0 distributed setup documentation]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m). | `-Dprofile=control-plane` |
    | Gateway profile      | The API Gateway profile.      |   `-Dprofile=gateway` |
    | Traffic Manager profile | The Traffic Manager profile.      |    `-Dprofile=traffic-manager` |

- API-related Synapse artifacts were moved from the file system to the in-memory. Therefore, there will not be any Synapse artifacts stored in the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/api` directory. These Synapse artifacts are stored in the database and loaded to memory when the server starts up and when a new API revision is deployed and published.

- With the inclusion of API revisioning it is required to have an API revision deployed in a Gateway to be able to publish an API.

<hr style="border:8px solid gray"> </hr>

## **Micro Integrator**

The Micro Integrator is a cloud-native, standards-based messaging engine and an integration framework with a configuration-based runtime environment for integrating APIs, services, data, SaaS, proprietary, and legacy systems. This is a newly added component to WSO2 API Manager 4.0.0.

This serves the integration needs for the data plane of the API Manager platform.

It is now available to download from [here](https://wso2.com/api-management/#).

### New features

- **[New and improved File Connector]({{base_path}}/reference/connectors/file-connector/file-connector-overview/)**
    
	The File Connector allows you to connect to different file systems and perform various operations. The File Connector uses the [Apache Commons VFS](https://commons.apache.org/proper/commons-vfs/) I/O functionalities to execute operations. For more information, see **[File Connector Example]({{base_path}}/reference/connectors/file-connector/file-connector-example/)** and **[File Connector Reference]({{base_path}}/reference/connectors/file-connector/file-connector-config/)**.

- **[HashiCorp Secure Vault]({{base_path}}/install-and-setup/setup/mi-setup/security/using-hashicorp-secrets/)**
    
	By default, the Micro Integrator is configured to use WSO2 secure vault for encrypting secrets. However, you may encounter certain limitations with WSO2 secure vault if you use secrets with a large number of characters. You can overcome this issue by using HashiCorp secrets.

- **[JSON evaluation support for property mediator]({{base_path}}/reference/mediators/property-mediator/)**
    
	Enhanced JSON evaluation support was added for the property mediator.

- **[FreeMarker support PayloadFactory mediator]({{base_path}}/reference/mediators/payloadfactory-mediator/)**
    
	You can now use the **FreeMarker** template to write the payload. This is particularly useful when defining complex JSON payloads.

- **[OAuth endpoint](reference/synapse-properties/endpoint-properties/)**
    
	A message exit point or an endpoint defines an external destination for a message. Typically, this is the address of a proxy service that acts as the front-end to the actual service. You can configure the endpoint artifacts with any attributes or semantics needed for communicating with that service. An endpoint could represent a URL, a mailbox, a JMS queue, a TCP socket, etc., along with the settings needed for the connection.

- **[Call mediator improvement]({{base_path}}/reference/mediators/call-mediator/)**
    
	Improvements have been made to the call mediator so that it can now store the response to a property.

- **[Generating service catalog entry (open API definition)]({{base_path}}/integrate/develop/working-with-service-catalog/)**
    
	WSO2 API Manager includes a Service Catalog where developers can register their services in a RESTful manner. Integration services can be created when deploying your project as a C-App. These integration services are made discoverable to the API Management layer via the Service Catalog so that API proxies can directly be created using them.

- **[Data Service Call Mediator]({{base_path}}/reference/mediators/dss-mediator/)**

    Data Service Call mediator allows you to invoke data service operations from a mediation sequence without introducing an HTTP call (using the Call or Send mediators) 
    to access the data service.  This improves the server performance because the data service is accessed directly without going through the HTTP transport.

### Compare this release with the Micro Integrator of WSO2 EI 7.x

The Micro Integrator is the integration runtime of WSO2 API-M 4.0.0 as well WSO2 EI 7.x versions.

The **new features** introduced with the Micro Integrator of API-M 4.0.0 are listed above. In addition, note the following significant changes:

- The CLI tool of EI 7.x is replaced with the [API Controller (CLI)]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl) of API-M 4.0.0.
- The EI Kubernetes Operator of EI 7.x is merged with the [API Operator]({{base_path}}/reference/k8s-operators/k8s-api-operator/) of API-M 4.0.0.



### Compare this release with previous ESBs

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
		<th><b>WSO2 ESB Runtime</b></th>
		<th><b>Micro Integrator Runtime</b></th>
	</tr>
	<tr>
		<td>
			Startup time
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
			Distribution size
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
			Mediation (ESB) features
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
			Data Integration features
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
			Task coordination 
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
			Management Console
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

**Removed Features**

The following features, which are available in ESB runtimes, are removed from the Micro Integrator of API-M 4.0.0 because they are not frequently used.

<table>
	<tr>
		<th>
			<b>Feature</b>
		</th>
		<th>
			<b>Description</b>
		</th>
		<th>
			<b>Alternative</b>
		</th>
	</tr>
	<tr>
		<td>
			Management Console
		</td>
		<td>
			<a href="{{base_path}}/integrate/develop/wso2-integration-studio">WSO2 Integration Studio</a> is the recommended tool for developing integration solutions. The monitoring capabilities available in the management console (of the ESB profile) are available through the new <a href="{{base_path}}/observe/mi-observe/working-with-monitoring-dashboard">Micro Integrator dashboard</a>.
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
			SVN-based DepSync
		</td>
		<td>
			This is not a widely used feature in the ESB profile, and is not recommended for use.
		</td>
		<td>
			Third-party offering like <b>Rsync</b>
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

<hr style="border:8px solid gray"> </hr>

## **Streaming Integrator**

Streaming Integrator serves the streaming-based integrations and acts as the event stream provider for Streaming APIs in the data plane of the API Manager platform. This is a newly added component into WSO2 API Manager 4.0.0.

It is now available to download from [here](https://github.com/wso2/streaming-integrator/releases/download/v4.0.0/wso2si-4.0.0.zip).

### New features

- **[Deploy AsyncAPI definitions to WSO2 API-M Services]({{base_path}}/use-cases/streaming-usecase/exposing-stream-as-managed-api-in-service-catalog/)**
    
	 WSO2 Streaming Integrator has the inbuilt capability to directly deploy siddhi applications with Async API definitions to WSO2 API Manager services. These services can then be used to create an API and deploy in the API Manager runtime.

- **SSE Sink / Source support over HTTP**
    
	 SSE is an HTTP-based protocol that allows one-way communication (similar to WebHooks) from the server to the client. For more information, see [SSE Server Sink](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#sse-server-sink) and [SSE Source](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#sse-source).
	 
- **WebSub Sink / Source support over HTTP**
    
	 Above Source and Sink implementation are based on the [WebSub](https://www.w3.org/TR/websub/) protocol specification.WebSubs only allows one-way communication, from a caller web app to a callee web app. For more information , see [WebSub Sink](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#websubhub-sink) , [WebSub Source](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#websubhub-source).

- **Improved MongoDB Store**
    
	 Several improvements are done, such as making the encryption protocol configurable, Object_ID support when searching specific values in the store, and other bug fixes. For more information, see [Mongo DB Store](https://siddhi-io.github.io/siddhi-store-mongodb/api/2.1.2/#mongodb-store).
	 
- **Improved IO CDC Source**
    
	 CDC(Change Data Capture) can be used to capture insert /update/delete actions from databases. With the new improvements, you can handle all three actions using a single CDC configuration. For more information, see [CDC Source](https://siddhi-io.github.io/siddhi-io-cdc/api/2.0.10/).
	 
- **Synchronous publishing support for IO Kafka**
    
	 IO Kafka allows seamless connection with the Kafka broker and retrieves the events into the Streaming Integrator. This release includes synchronous publishing of events, which allows more controlled event publishing and other bug fixes. For more information, see [IO-Kafka](https://github.com/siddhi-io/siddhi-io-kafka).
	 
- **Improved JSON Mapper to support null values**
    
	 JSON mapper provides capability to retrieve or publish events in JSON format. Release contains improvement where when null values arrives into the system they are treated as null values if needed. For more information , see [Map-JSON](https://github.com/siddhi-io/siddhi-map-json).
	 
- **Improved KeyValue Mapper to support force casting**
    
	 The KeyValue mapper allows the Streaming Integrator to get events and publish events as a key-value pair. For more information, see [Map-KeyValue](https://siddhi-io.github.io/siddhi-map-keyvalue/api/2.1.1/).
	 
- **Improved IO File Sink and Source**
    
	 IO File sink/source is used to read or write into a file. With the new improvements, the Streaming Integrator supports EOF(End Of File) in other modes, file trailers, file-writing mechanisms, and SFTP. For more information, see [IO-File](https://siddhi-io.github.io/siddhi-io-file/api/2.0.16/).
	 
- **Improved Store RDBMS support**
    
	 Store RDBMS can be used to connect with any RDBMS type. With the new versions, it supports adding null values to RDBMS tables and includes improved metrics support. For more information, see [Store RDBMS](https://github.com/siddhi-io/siddhi-store-rdbms).
	 
- **Kafka and HTTP metrics monitoring**
    
	 This release provides Kafka and HTTP metrics monitoring capability. In the previous release, this was only available for File, RDBMS and CDC(Change Data Capture). The metrics can be published to a pre-configured [Prometheus](https://prometheus.io/) server and then you can either create your own [Grafana](https://grafana.com/) dashboard or use the ETL dashboard which is already created by us. For more information on how to configure metrics, refer to [Monitoring ETL Flows](https://apim.docs.wso2.com/en/4.0.0/observe/si-observe/viewing-dashboards/) documentation page.
	 

<hr style="border:8px solid gray"> </hr>

## **API Controller (apictl)**

WSO2 API Controller (apictl) is a command-line tool providing the capability to move APIs, API Products, and Applications across environments and to perform CI/CD operations. It can also be used to perform these same tasks on a Kubernetes deployment. In addition, apictl can be used as a developer CLI tool for Choreo Connect. Furthermore, it can perform Micro Integrator server-specific operations such as monitoring Synapse artifacts and performing MI management/administrative tasks from the command line.

It is now available to download from [here](https://wso2.com/api-management/tooling/).

### New features

- [API Controller as a developer CLI tool for Choreo Connect]({{base_path}}/install-and-setup/setup/api-controller/managing-choreo-connect/managing-choreo-connect-with-ctl/)
- [Merge Micro Integrator (MI) CLI commands with apictl]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl/)
- Support import/export revisioning of APIs and API Products
- [Adding proxy environment variables support for apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#set-proxy-environment-variables-for-apictl)
- Resolve parameters at server-side while importing an API/API Product project
- [Params file support for API Products]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#defining-the-params-file-for-an-api-product)
- Introducing new schemas for apictl API/API Product/Application project artifacts
- [Support to override subscription policies of an API using the params file]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#defining-the-params-file-for-an-api)
- [Support TLS renegotiation configuration]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#set-tls-renegotiation-mode)
- [Support apictl bundle command (archives an API Project)]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#bundling-the-generated-directory-before-import)
- [Introducing a structure for deployment and source repositories]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters/#generating-the-deployment-directory)
- Support endpoint security separately for Production and Sandbox endpoints via params file
- VCS support for both the deployment and source repositories
- Support for import/export of Streaming APIs
- [Ability to extract APIs from the AWS API-Gateway and to initialize an apictl API project]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-aws-apis-in-the-dev-portal)
	 
	 The `apictl aws init` command was introduced for this purpose.

- Standardized the apictl flags with a common convention
- Introduced new improved commands while deprecating some old apictl commands 
    <table>
        <tr class="odd">
            <th><b>Deprecated Command</b></th>
            <th><b>New Command</b></th>
        </tr>
        <tr class="even">
            <td><code>apictl import-api [flags]</code></td>
            <td><code>apictl import api [flags]</code></td>
        </tr>
        <tr class="odd">
            <td><code>apictl import-app [flags]</code></td>
            <td><code>apictl import app [flags]</code></td>
        </tr>
        <tr class="even">
            <td><code>apictl export-api [flags]</code></td>
            <td><code>apictl export api [flags]</code></td>
        </tr>
        <tr class="odd">
            <td><code>apictl export-apis [flags]</code></td>
            <td><code>apictl export apis [flags]</code></td>
        </tr>
        <tr class="even">
            <td><code>apictl export-app [flags]</code></td>
            <td><code>apictl export app [flags]</code></td>
        </tr>
        <tr class="odd">
            <td><code>apictl list apis [flags]</code></td>
            <td><code>apictl get apis [flags]</code></td>
        </tr>
        <tr class="even">
            <td><code>apictl list api-products [flags]</code></td>
            <td><code>apictl get api-products [flags]</code></td>
        </tr>
        <tr class="odd">
            <td><code>apictl list apps [flags]</code></td>
            <td><code>apictl get apps [flags]</code></td>
        </tr>
        <tr class="even">
            <td><code>apictl list envs [flags]</code></td>
            <td><code>apictl get envs [flags]</code></td>
        </tr>
        <tr class="odd">
            <td><code>apictl get-keys [flags]</code></td>
            <td><code>apictl get keys [flags]</code></td>
        </tr>
        <tr class="even">
            <td><code>apictl delete api [flags]</code></td>
            <td><code>apictl delete api [flags] <br> apictl k8s delete api [flags]</code></td>
        </tr>
        <tr class="odd">
            <td><code>apictl add api [flags]</code></td>
            <td><code>apictl k8s add api [flags]</code></td>
        </tr>
        <tr class="even">
            <td><code>apictl update api [flags]</code></td>
            <td><code>apictl k8s update api [flags]</code></td>
        </tr>
        <tr class="odd">
            <td><code>apictl add-env [flags]</code></td>
            <td><code>apictl k8s update api [flags]</code></td>
        </tr>
    </table>

<hr style="border:8px solid gray"> </hr>

## **WSO2 Integration Studio**

WSO2 Integration Studio is an open-source development environment used to design and develop integration scenarios for WSO2 Micro Integrator.

It is now available to download from [here](https://wso2.com/integration/integration-studio/).

### New features

- PayloadFactory mediator supports FreeMarker templates
- Enrich mediator improvements
- OAuth feature for HTTP endpoints
- Dynamic endpoint support for mock services in synapse unit testing
- Call mediator improvements
- Parent maven details included in the children POM by default
- Kubernetes exporter project is enhanced to support a pure Kubernetes deployment
- Apply software updates to the embedded Micro Integrator runtime
- OpenAPI specification 3.0 support
- Publish integrations to the API-M runtime during deployment
- Cassandra datasource support for data services
- Adding Registry Resource Properties

### Key changes

- The folder structure of the ESB Configs modules is changed to include the Swagger-related metadata in the `/resources` directory.
- WSO2 Integration Studio now supports OpenAPI specification 3.0 by default.
- Use a new workspace for WSO2 Integration Studio 8.0.0 and import any existing projects (created using older Integration Studio versions) into this new workspace.
  

<hr style="border:8px solid gray"> </hr>

## **Micro Integrator Dashboard**

The Micro Integrator dashboard can connect to multiple Micro Integrator server instances and monitor artifacts and logs from a selected cluster or group of server nodes.

It is now available to download from [here](https://github.com/wso2/micro-integrator/releases/).

### New features

- Revamped dashboard, which can monitor multiple Micro Integrator instances grouped together

<hr style="border:8px solid gray"> </hr>

## **Streaming Integrator Tooling**

The Streaming Integrator Tooling is a developer tool to develop Siddhi applications and simulate events for testing purposes.

It is now available to download from [here](https://github.com/wso2/streaming-integrator-tooling/releases/).

### New features

- **Async API View**
    
	 This release introduces a new 'Async API' view in addition to the existing 'Source/Design' views and 'Wizard' view. 
	 
	 Using the Async API View, you can generate an [Async API](https://www.asyncapi.com/) specification for a given Siddhi app. 
	 
	 The following sinks/sources can be exposed as an Async API : [websocket-server (sink)](https://siddhi-io.github.io/siddhi-io-websocket/api/3.0.2/#websocket-server-sink),  [web socket-server (source)](https://siddhi-io.github.io/siddhi-io-websocket/api/3.0.2/#websocket-server-source), [websocket (source)](https://siddhi-io.github.io/siddhi-io-websocket/api/3.0.2/#websocket-source), [sse-server (sink)](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#sse-server-sink), [websubhub (source)](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#websubhub-source)
     
      See the [example use case](https://apim.docs.wso2.com/en/4.0.0/use-cases/streaming-usecase/exposing-stream-as-managed-api-in-service-catalog/).

- **Tooling support for webhubsub Source and webhubsub Sink**
    
	 Tooling support is added for the newly introduced [webhubsub source](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#websubhub-source) and [webhubsub sink](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#websubhub-sink). For details, see the **Streaming Integrator - New Features** section above.

- **Tooling support for SSE Source and SSE-server Sink**

	 Tooling support is added for the newly introduced [SSE Source](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#sse-source) and [SSE-server Sink](https://siddhi-io.github.io/siddhi-io-http/api/2.3.3/#sse-server-sink). For details, see the **Streaming Integrator - New Features** section above.
	 
- **Siddhi Error Replay for 'Store' type errors**

	 This release enables **error replay** for database connection errors. Errors that occur during ADD, DELETE, UPDATE, ADDORUPDATE operations can be replayed from the Error Store explorer. 
	 
	 See the tutorial on [handling store-type errors](https://apim.docs.wso2.com/en/4.0.0/use-cases/streaming-tutorials/handling-requests-with-errors/#step-7-handle-events-that-fail-at-database-level).

<hr style="border:8px solid gray"> </hr>

## **Kubernetes API Operator**

Microservices are increasingly being deployed on Kubernetes. As a result, it is important to expose these microservices as well documented, easy to consume, managed APIs so that they can be used to develop great applications. The API operator for Kubernetes makes APIs a first-class citizen in the Kubernetes ecosystem. Similar to deploying microservices, you can now use this operator to deploy APIs for individual microservices or compose several microservices into individual APIs. With this, users can expose their microservice as managed APIs in the Kubernetes environment without any additional work.

The API operator for Kubernetes provides first-class support for Micro Integrator deployments in the Kubernetes ecosystem. It uses the Integration custom resource (`integration_cr.yaml` file) that is available in the Kubernetes project (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

It is now available to download from [here](https://github.com/wso2/k8s-api-operator/releases/).
K8s API Operator v2.0.0 is compatible with API Manager v4.0.0.

### New features

- Deploy APIs to Choreo Connect (API Microgateway)
- Deploy APIs to API Manager
- Deploy Integrations with Micro Integrator

<hr style="border:8px solid gray"> </hr>

## **Compatible WSO2 product versions**

WSO2 API Manager 4.0.0 is based on WSO2 Carbon 4.6.1 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version. If you encounter any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

<hr style="border:8px solid gray"> </hr>

## **Fixed and known issues**

**API Manager**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/product-apim/issues?q=is%3Aissue+closed%3A2020-07-20..2021-04-20+label%3A%22API-M+4.0.0%22).

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.0.0 are reported [here](https://github.com/wso2/product-apim/issues?q=is%3Aissue+closed%3A2020-07-20..2021-04-20+label%3A%22API-M+4.0.0%22).

**Micro Integrator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/micro-integrator/issues?q=is%3Aissue+closed%3A2020-07-20..2021-04-20).

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.0.0 are reported [here](https://github.com/wso2/micro-integrator/issues).

**Streaming Integrator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/streaming-integrator/milestone/16?closed=1).

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.0.0 are reported [here](https://github.com/wso2/streaming-integrator/issues).

**API Controller**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aissue+is%3Aclosed+label%3A4.0.0).

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.0.0 are reported [here](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aopen+is%3Aissue).

**Integration Studio**

- Fixed Issues - See [details of all the changes including new features, improvements, and bug fixes in this milestone release](https://github.com/wso2/integration-studio/issues?q=is%3Aissue+closed%3A2020-12-23..2021-04-16).

- Known Issues - All the open issues pertaining to WSO2 Integration Studio are reported [here](https://github.com/wso2/integration-studio/issues).

**Micro Integrator Dashboard**

- Fixed Issues - See [details of all the changes including new features, improvements, and bug fixes in this release](https://github.com/wso2/micro-integrator/issues?page=1&q=label%3AMonitoring-Dashboard+is%3Aclosed+label%3A4.0.0).

- Known Issues - All the open issues pertaining to WSO2 Integration Studio are reported [here](https://github.com/wso2/micro-integrator/issues).

**Streaming Integrator Tooling**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/streaming-integrator-tooling/milestone/15?closed=1).

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.0.0 are reported [here](https://github.com/wso2/streaming-integrator-tooling/issues).

**Kubernetes API Operator**

- Fixed Issues - See [details of all the changes including improvements, and bug fixes in this release](https://github.com/wso2/k8s-api-operator/issues?q=is%3Aissue+milestone%3Av2.0.0+is%3Aclosed).

- Known Issues - All the open issues pertaining to WSO2 API Manager 4.0.0 are reported [here](https://github.com/wso2/k8s-api-operator/issues?q=is%3Aopen+is%3Aissue+label%3A2.0.0).
