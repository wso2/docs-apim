# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.1.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.0.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

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

#### API Governance

??? note "Management of real-time APIs on Solace"

    WSO2 API Manager 4.1.0 now supports integrating external third-party Gateways and Brokers. Solace is an advanced event broker that is efficiently streaming events and information across cloud, on-premises, and IoT environments.

    **[Learn more]({{base_path}}/tutorials/integrating-with-solace/)**

??? note "Develop an integration from a managed API"

    With the API Manager 4.1.0 release, you can create an integration using a managed API and configure the integration service endpoint to the managed API. This is the top-down approach in API first integration.

    **[Learn more]({{base_path}}/tutorials/develop-an-integration-with-a-managed-api/)**

??? note "Publishing third-party APIs on the Developer Portal"

    WSO2 API Manager provides the capability to publish APIs that are deployed in an external Gateway. Since these APIs are not deployed in the WSO2 API Gateway, the API will not be proxied through the Gateway.

    **[Learn more]({{base_path}}/deploy-and-publish/publish-on-dev-portal/third-party-api-support/)**

??? note "A read-only mode for API Publisher"

    This feature allows a user who has view/read-only permissions to only view the API, API Product, and Service details in the Publisher portal. This user can also review all the analytics-related details.

    **[Learn more]({{base_path}}/design/api-security/authorization/publisher-portal-in-read-only-mode/)**

??? note "Mock API implementation support considering API definition in Choreo Connect"

    This Mock API Implementation allows you to generate mock responses based on the examples provided in the OpenAPI specification that will mock the API responses.

    **[Learn more]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-with-mock-impl/)**

#### API Security

??? note "API consumer authorization with Open Policy Agent (OPA)"

    You can now offload some of the decision-making responsibilities to OPA on whether to authorize a consumer or not when they invoke APIs based on policies attached to APIs.

    **[Learn more]({{base_path}}/design/api-security/opa-validation/overview/)**

??? note "Authentication support for API invocation using the Token Exchange approach"

    You can now get an API Manager token by invoking the token endpoint of API Manager with the required parameters (i.e., the token obtained from an external Identity Provider) and invoking the API with the exchanged token.

    **[Learn more]({{base_path}}/administer/key-managers/configure-custom-connector/)**

#### API Policies

??? note "Operation level policy support for APIs"

    With the API Manager 4.1.0 release, we introduce fine-grained and easy to manage policies for operations. We move away from the concept of attaching a policy at the API level (i.e., API level mediation policies) and now can attach multiple policies at the operation level itself.

    **[Learn more]({{base_path}}/design/api-policies/overview/)**

#### Integration

??? note "WSDL to REST conversion support in Integration Studio"

    With API Manager 4.1.0, you now have a hybrid environment where some system APIs exist as SOAP-based web services that can also have a REST interface defined.

    **[Learn more]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api/)**

??? note "Exposing an integration SOAP service as a managed API"

    WSO2 API Manager includes a Service Catalog where developers can register their backend services as Managed APIs. Through the Service Catalog, now SOAP integration services are made discoverable to the API Management layer so that SOAP PassThrough API proxies can directly be created using them.

    **[Learn more]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial-for-proxy-services/)**

??? note "Authorization support via secondary user stores in Micro Integrator"

    Users can now deploy secondary user stores in Micro Integrator and use those users and roles in authorization use cases.

    **[Learn more]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/configuring-secondary-user-stores-mi/#configuring-secondary-user-stores)**

??? note "Auto-generation support for data services using a given data source in Integration Studio"

    This feature allows you to generate data service definitions by pointing to an existing data source in the workspace without creating it from scratch.

    **[Learn more]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services/#generate-data-service-from-a-datasource)**

#### Event Driven Architecture

??? note "Support for GraphQL subscription operations"

    WSO2 API Manager 4.1.0 supports GraphQL subscription operations, which extends GraphQL APIs for push-based solutions. In GraphQL subscriptions, clients send long-lasting GraphQL read operations and get updated results whenever a particular server-side event occurs. Commonly, updated results are pushed from the server to the subscribing clients via WebSockets, where the server holds a steady connection with the client.

    **[Learn more]({{base_path}}/tutorials/create-and-publish-a-graphql-api/#5.2)**

#### API Analytics

??? note "Publishing analytics events to external systems"

    Instead of publishing analytics events to the cloud, it is now possible to log the same events and publish them to external systems like ELK. You can create a sample, configure the created sample with API Manager or Choreo Connect, and publish it to the external system.

    **[Learn more]({{base_path}}api-analytics/samples/publishing-analytics-events-to-external-systems/)**

#### Monitoring

??? note "Logging messages per API"

    WSO2 API Manager 4.1.0 enables a simple way to observe requests and responses going through the WSO2 API Gateway by introducing this lightweight feature called API Logs.

    **[Learn more]({{base_path}}/observe/api-manager/monitoring-api-logs/)**

??? note "Maintaining audit logs for the Micro Integrator Management API"

    The audit log capability allows you to add logging for the Micro Integrator Management API. Maintaining audit logs allows you to identify the changes that took place in the Micro Integrator instance and also to identify who made those changes.

    **[Learn more]({{base_path}}/observe/micro-integrator/classic-observability-logs/monitoring-mi-audit-logs/)**

#### Other

??? note "GitHub integration for Choreo Connect"

    This feature allows you to deploy APIs from a GitHub repository by starting Choreo Connect and pointing to source control systems such as GitHub, Gitlab, and Bitbucket.

    **[Learn more]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/git-integration/)**

## Improvements

??? note "Lifecycle support for API Products"

    WSO2 API Manager provides distinct lifecycle states for the API during the API development process. A lifecycle state can now be specified for each API Product you create.

    **[Learn more]({{base_path}}/design/create-api-product/create-api-product/)**

??? note "Authentication support for Prototype APIs"

    Authentication for Prototype APIs is available by default so that the client apps can also be created using authentication to test out the APIs. If needed you can disable authentication for Prototype APIs at the resource level or API level.

    **[Learn more]({{base_path}}/design/prototype-api/create-a-prototype-api/)**

??? note "Single Sign-On support for the monitoring dashboard using OpenID Connect"

    Users can use OIDC-based Single Sign-On to log in to the WSO2 Micro Integrator Monitoring Dashboard.
    
    **[Learn more]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi-dashboard/#configuring-single-sign-on-with-openid-connect)**

??? note "Support for admin privileges in the file-based user store"

    The default user store of the Micro Integrator is file-based. This enables users to grant admin privileges to a user in the file-based user store.

    **[Learn more]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#file-based-user-store-default)**

??? note "Monitoring deployed data sources in Micro Integrator runtimes"

    Users can identify the data sources that are deployed in Micro Integrator Runtimes directly from the dashboard.

    **[Learn more]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard/#step-6-monitor-mi-artifacts-and-logs)**

??? note "PKCE support when generating application keys"

    WSO2 API Manager supports Proof Key for Code Exchange (PKCE) when generating application keys. This is a security measure to secure the applications that are executing in the same domain.

    **[Learn more]({{base_path}}/consume/manage-application/generate-keys/generate-api-keys/#generating-application-keys-with-pkce-enabled)**

??? note "Ability to configure Rate Limiting for an API Gateway cluster"

    Ability to configure Rate Limiting for an API Gateway Cluster via the Redis server so that the request counters maintained for burst control and backend rate limiting will be replicated across the API Gateway cluster when working with multiple API Gateway nodes.

    **[Learn more]({{base_path}}/design/rate-limiting/advanced-topics/configuring-rate-limiting-api-gateway-cluster/)**

??? note "Tenant configurations migration from the registry to the database"

    You can now perform more advanced configurations for tenant configuration migration from the registry to the database.

    **[Learn more]({{base_path}}/administer/advanced-configurations/)**

??? note "File Inbound Endpoint subdirectory processing capability"

    VFS Inbound Endpoints are capable of handling files inside subdirectories of the specified URL. This enables users to process files recursively inside a directory.

    **[Learn more]({{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/file-inbound-endpoint-properties/)**

??? note "Improve Service Catalog to work with Hot Deployments"

    You can now publish services to Service Catalog for hot deployments and include metadata files of the selected artifacts.

    **[Learn more]({{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial/)**

??? note "Support to change lifecycle state of API Products using apictl"

    You can now change the status of an API or API Product in an environment using apictl.

    **[Learn more]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/managing-apis-and-api-products/#change-status-of-an-api-or-api-product-in-an-environment)**

??? note "Exposing proxy services via the Service Catalog"

    This feature generates metadata artifacts for the APIs and Proxy services that have been created inside older Integration Studio workspaces.

    **[Learn more]({{base_path}}/integrate/develop/generate-service-catalog-metadata/)**

??? note "Support for SMB and WebDAV protocols"

    This feature adds support to read from or write to files opened via SMB and WebDAV protocols.

    **[Learn more](https://siddhi-io.github.io/siddhi-io-file/)**

??? note "Support Protobuf map-type for Kafka"

    This improvement adds support to decode Protobuf messages via a schema registry with Kafka.

    **[Learn more](https://siddhi-io.github.io/siddhi-io-kafka/api/latest/)**


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
