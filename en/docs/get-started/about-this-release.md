# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.1.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.0.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

The API Manager component addresses all aspects of API management in the platform. It consists of an API Gateway, API Publisher, Developer Portal, Key Manager, and Traffic Manager.

<table>
<tr>
<td>API Manager 4.1.0</td>
<td><a href="https://github.com/wso2/product-apim/releases/download/v4.1.0-beta/wso2am-4.1.0-beta.zip">download</a></td>
</tr>
<tr>
<td>Micro Integrator 4.1.0</td> 
<td><a href="https://github.com/wso2/micro-integrator/releases/download/v4.1.0-beta/wso2mi-4.1.0-beta.zip">download</a></td>
</tr>
<tr>
<td>Streaming Integrator 4.1.0</td> 
<td><a href="https://github.com/wso2/streaming-integrator/releases/download/v4.1.0-beta/wso2si-4.1.0-beta.zip">download</a></td> 
</tr>
<tr>
<td>API Controller 4.1.0</td>
<td><a href="https://github.com/wso2/product-apim-tooling/releases/tag/v4.1.0-beta">download</a></td>
</tr>
<tr>
<td>Integration Studio  8.1.0</td>
<td><a href="https://github.com/wso2/integration-studio/releases/tag/v8.1.0-beta">download</a></td>
</tr>
<tr>
<td>Micro Integrator Tooling  4.1.0</td>
<td><a href="https://github.com/wso2/micro-integrator/releases/download/v4.1.0-beta/wso2mi-dashboard-4.1.0-beta.zip">download</a></td>
</tr>
<tr>
<td>Streaming Integrator Tooling  4.1.0</td>
<td><a href="https://github.com/wso2/streaming-integrator-tooling/releases/download/v4.1.0-beta/wso2si-tooling-4.1.0-beta.zip">download</a></td>
</tr>
</table>


## New features

- **[Operation level policy support for APIs]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/message-mediation/specifying-mediation-flow-based-on-policy/)**

     With the API Manager 4.1.0 release, we introduce fine-grained and easy to manage policies for operations. We move away from the concept of attaching a policy at the API level (i.e., API level mediation policies) and now can attach multiple policies at the operation level itself.

- **[Support for GraphQL subscription operations]({{base_path}}/tutorials/create-and-publish-a-graphql-api/#5.2)**

      WSO2 API Manager 4.1.0 supports GraphQL subscription operations, which extends GraphQL APIs for push-based solutions. In GraphQL subscriptions, clients send long-lasting GraphQL read operations and get updated results whenever a particular server-side event occurs. Commonly, updated results are pushed from the server to the subscribing clients via WebSockets, where the server holds a steady connection with the client.

- **[Management of real-time APIs on Solace]({{base_path}}/tutorials/integrating-with-solace/)**

     WSO2 API Manager 4.1.0 now supports integrating external third-party Gateways and Brokers. Solace is an advanced event broker that is efficiently streaming events and information across cloud, on-premises, and IoT environments.

- **[API consumer authorization with Open Policy Agent (OPA)]({{base_path}}/design/api-security/opa-validation/overview/)**

     You can now offload some of the decision-making responsibilities to OPA on whether to authorize a consumer or not when they invoke APIs based on policies attached to APIs.

- **[Develop an integration from a managed API]({{base_path}}/tutorials/develop-an-integration-with-a-managed-api/)**

    With the API Manager 4.1.0 release, you can create an integration using a managed API and configure the integration service endpoint to the managed API. This is the top-down approach in API first integration.

- **[Publishing third-party APIs on the Developer Portal]({{base_path}}/deploy-and-publish/publish-on-dev-portal/third-party-api-support/)**

     WSO2 API Manager provides the capability to publish APIs that are deployed in an external Gateway. Since these APIs are not deployed in the WSO2 API Gateway, the API will not be proxied through the Gateway.

- **[WSDL to REST conversion support in Integration Studio]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api/)**

     With API Manager 4.1.0, you now have a hybrid environment where some system APIs exist as SOAP-based web services that can also have a REST interface defined.

- **[Authentication support for API invocation using the Token Exchange approach]({{base_path}}/administer/key-managers/configure-custom-connector/)**

     You can now get an API Manager token by invoking the token endpoint of API Manager with the required parameters (i.e., the token obtained from an external Identity Provider) and invoking the API with the exchanged token.

- **[A read-only mode for API Publisher]({{base_path}}/design/api-security/authorization/publisher-portal-in-read-only-mode/)**

     This feature allows a user who has view/read-only permissions to only view the API, API Product, and Service details in the Publisher portal. This user can also review all the analytics-related details.

-  **[Exposing an integration SOAP service as a managed API]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial-for-proxy-services/)**

     WSO2 API Manager includes a Service Catalog where developers can register their backend services as Managed APIs. Through the Service Catalog, now SOAP integration services are made discoverable to the API Management layer so that SOAP PassThrough API proxies can directly be created using them.

- **[Logging messages per API]({{base_path}}/observe/api-manager/monitoring-api-logs/)**

     WSO2 API Manager 4.1.0 enables a simple way to observe requests and responses going through the WSO2 API Gateway by introducing this lightweight feature called API Logs.

- **[Maintaining audit logs for the Micro Integrator Management API]({{base_path}}/observe/micro-integrator/classic-observability-logs/monitoring-mi-audit-logs/)**

  	The audit log capability allows you to add logging for the Micro Integrator Management API. Maintaining audit logs allows you to identify the changes that took place in the Micro Integrator instance and also to identify who made those changes.

- **[Authorization support via secondary user stores in Micro Integrator]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/configuring-secondary-user-stores-mi/#configuring-secondary-user-stores)**

     Users can now deploy secondary user stores in Micro Integrator and use those users and roles in authorization use cases.

- **[Auto-generation support for data services using a given data source in Integration Studio]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services/#generate-data-service-from-a-datasource)**

     This feature allows you to generate data service definitions by pointing to an existing data source in the workspace without creating it from scratch.

- **[Mock API implementation support considering API definition in Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-with-mock-impl/)**

     This Mock API Implementation allows you to generate mock responses based on the examples provided in the OpenAPI specification that will mock the API responses. 

- **[Git integration for Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/git-integration/)**

     This feature allows you to deploy APIs from a Git repository by starting the Choreo Connect pointing to source control systems such as GitHub, Gitlab, and Bitbucket.

## Improvements

- **[Lifecycle support for API Products]({{base_path}}/design/create-api-product/create-api-product/)**

     WSO2 API Manager provides distinct lifecycle states for the API during the API development process. A lifecycle state can now be specified for each API Product you create.

- **[Authentication support for Prototype APIs]({{base_path}}/design/prototype-api/create-a-prototype-api/))**

	 Authentication for Prototype APIs is available by default so that the client apps can also be created using authentication to test out the APIs. If needed you can disable authentication for Prototype APIs at the resource level or API level.

- **[Advanced Configurations section for the Admin Portal]({{base_path}}/administer/advanced-configurations/)**

- **[Single Sign-On support for the monitoring dashboard using OpenID Connect]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi-dashboard/#configuring-single-sign-on-with-openid-connect)**

     Users can use OIDC-based Single Sign-On to log in to the WSO2 Micro Integrator Monitoring Dashboard.

- **[Support for admin privileges in the file-based user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#file-based-user-store-default)**

     The default user store of the Micro Integrator is file-based. This enables users to grant admin privileges to a user in the file-based user store.

- **[Monitoring deployed data sources in Micro Integrator runtimes]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard/#step-6-monitor-mi-artifacts-and-logs)**

     Users can identify the data sources that are deployed in Micro Integrator Runtimes directly from the dashboard.

- **[PKCE support when generating application keys]({{base_path}}/consume/manage-application/generate-keys/generate-api-keys/#generating-application-keys-with-pkce-enabled/)**
  
     WSO2 API Manager supports Proof Key for Code Exchange (PKCE) when generating application keys. This is a security measure to secure the applications that are executing in the same domain.

- **[Ability to configure Rate Limiting for an API Gateway Cluster]({{base_path}}/design/rate-limiting/advanced-topics/configuring-rate-limiting-api-gateway-cluster/)**

     Ability to configure Rate Limiting for an API Gateway Cluster via the Redis server so that the request counters maintained for burst control and backend rate limiting will be replicated across the API Gateway cluster when working with multiple API Gateway nodes.

- **[Tenant configurations migration from the registry to the database]({{base_path}}/administer/advanced-configurations/)**

     You can now perform more advanced configurations for tenant configuration migration from the registry to the database.

- **[File Inbound Endpoint subdirectory processing capability]({{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/file-inbound-endpoint-properties/)**

     VFS Inbound Endpoints are capable of handling files inside subdirectories of the specified URL. This enables users to process files recursively inside a directory.

- **[Improve Service Catalog to work with Hot Deployments]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial/)**

     You can now publish services to Service Catalog for hot deployments and include metadata files of the selected artifacts.

- **[Support to change lifecycle state of API Products using apictl]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/managing-apis-and-api-products/#change-status-of-an-api-or-api-product-in-an-environment)**

     You can now change the status of an API or API Product in an environment using apictl.

- **[Exposing proxy services via Service Catalog for WSO2 APIM]({{base_path}}/integrate/develop/generate-service-catalog-metadata/)**

     This feature generates metadata artifacts for the APIs and Proxy services that have been created inside older Integration Studio workspaces.

- **[Support for SMB and WebDAV protocols](https://siddhi-io.github.io/siddhi-io-file/)**

     This feature adds support to read from or write to files opened via SMB and WebDAV protocols.

- **[Support Protobuf map-type for Kafka](https://siddhi-io.github.io/siddhi-io-kafka/api/latest/)**

     This improvement adds support to decode Protobuf messages via a schema registry with Kafka.

## Removed features and functionalities

These features are unsupported and removed from WSO2 API Manager 4.1.0 onwards.

- **DAS Message Tracer**

     The message tracer feature for WSO2 DAS is no longer supported and removed from the product.


## Compatible WSO2 product versions

- WSO2 API Manager 4.1.0 is compatible with WSO2 Identity Server 5.11.0.
- WSO2 API Manager 4.1.0 is compatible with Choreo Connect 1.1.0.

## Fixed issues

- [API Manager](https://github.com/wso2/product-apim/issues?q=is%3Aissue+is%3Aclosed+closed%3A2021-10-30..2022-03-05+)
- [Micro Integrator](https://github.com/wso2/micro-integrator/issues?q=is%3Aissue+is%3Aclosed+closed%3A2021-05-01..2022-03-05+label%3A4.1.0+)
- [Streaming Integrator](https://github.com/wso2/streaming-integrator/issues?q=is%3Aissue+is%3Aclosed+label%3A4.1.0+)
- [API Controller](https://github.com/wso2/product-apim-tooling/milestone/17?closed=1)
- [Integration Studio](https://github.com/wso2/integration-studio/milestone/14?closed=1)
- [Micro Integrator Dashboard](https://github.com/wso2/product-mi-tooling/milestone/1?closed=1)
- [Streaming Integrator Tooling](https://github.com/wso2/streaming-integrator/milestone/17?closed=1)
- [Choreo Connect](https://github.com/wso2/product-microgateway/issues?q=is%3Aissue+is%3Aclosed+closed%3A2022-01-01..2022-04-04+)

## Known issues

- [API Manager](https://github.com/wso2/product-apim/issues?q=is%3Aopen+is%3Aissue+label%3A4.x.x)
- [Micro Integrator](https://github.com/wso2/micro-integrator/issues)
- [Streaming Integrator](https://github.com/wso2/streaming-integrator/issues?q=is%3Aissue+is%3Aopen+label%3A4.1.0)
- [API Controller](https://github.com/wso2/product-apim-tooling/issues?q=is%3Aopen+is%3Aissue)
- [Integration Studio](https://github.com/wso2/integration-studio/issues)
- [Micro Integrator Dashboard](https://github.com/wso2/product-mi-tooling/issues?q=is%3Aopen+is%3Aissue)
- [Streaming Integrator Tooling](https://github.com/wso2/streaming-integrator-tooling/issues?q=is%3Aopen+is%3Aissue)
- [Choreo Connect](https://github.com/wso2/product-microgateway/issues)

