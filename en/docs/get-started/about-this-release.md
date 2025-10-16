# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.6.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.5.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/get-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New Features

??? note "MCP Gateway"

    WSO2 API Manager now supports the Model Context Protocol (MCP), enabling seamless integration between APIs and AI agents. Organizations can transform existing APIs into MCP-compatible services, import and expose external APIs as MCP servers, or proxy remote MCP servers through API Manager for centralized governance.

    Key Capabilities:

    - **Existing API to MCP conversion:** Automatically convert existing APIs into MCP-compatible services.
    - **MCP Servers from external APIs:** Import and expose external APIs as MCP Servers.
    - **Managing remote MCP Servers:** Import an external MCP Server and proxy via WSO2 API Manager.
    - **QoS for MCP Servers:** Apply rate limiting, authentication, and other policies.

    **[Learn more]({{base_path}}/mcp/overview/)**

??? note "MCP Hub"

    The control plane can now function as a MCP Hub, enabling centralized discovery and reuse of MCP Servers across teams and environments.

    **[Learn more]({{base_path}}/mcp/overview/)**

??? note "Multi-Model AI Service Provider Support"

    This release introduces support for configuring multi-model AI Service Providers, extending beyond the single provider support available previously. Organizations can now onboard AI Service Providers to gain unified AI model management capabilities across multiple providers.

    - Provides a hierarchical model structure (Service Provider → Model Provider → Model) to unify AI model operations across multiple providers.
    - Supports dynamic model selection based on performance, cost, or compliance, with detailed usage analytics and flexible business plans.

    Onboarded AI service providers:

    - [AWS Bedrock]({{base_path}}/ai-gateway/ai-vendor-management/aws-bedrock/)
    - [Azure AI Foundry]({{base_path}}/ai-gateway/ai-vendor-management/azure-ai-foundry/)

??? note "AI Guardrails and Semantic Caching for AI Gateway"

    AI Gateway is now equipped with AI Guardrails and Semantic Caching.

    - **AI Guardrails:** Real-time validation and enforcement to ensure AI safety, reliability, and compliance. **[Learn more]({{base_path}}/ai-gateway/ai-guardrails/overview/)**
    - **Semantic Caching:** Meaning-based response caching for improved performance and reduced latency in AI workloads. **[Learn more]({{base_path}}/ai-gateway/semantic-caching/)**

??? note "API Discovery support for Federated Gateways"

    WSO2 API Manager 4.6.0 release introduces the API discovery support for Federated Gateways. The allows organizations to manage APIs deployed in multiple third-party gateways through a unified control plane. Gateways supported in this release include:

    - [AWS API Gateway]({{base_path}}/manage-apis/deploy-and-publish/federated-gateways/aws/discover-apis-on-aws-api-gateway/)
    - [Azure API Gateway]({{base_path}}/deploy-and-publish/federated-gateways/azure/discover-apis-on-azure-api-gateway/)
    - Kong Gateway: [Kubernetes]({{base_path}}/manage-apis/deploy-and-publish/federated-gateways/kong/kong-kubernetes/discover-apis-on-kong-gateway-in-kubernetes/) | [Standalone]({{base_path}}/manage-apis/deploy-and-publish/federated-gateways/kong/kong-standalone/discover-apis-on-kong-gateway/)
    - [Envoy Gateway]({{base_path}}/manage-apis/deploy-and-publish/federated-gateways/envoygateway/eg-k8s/discover-apis-on-eg-gateway-in-kubernetes/)

    **[Learn more]({{base_path}}/manage-apis/deploy-and-publish/deploy-on-gateway/federated-gateways/overview/)**

??? note "Application update workflow"

    Enhances application lifecycle management by introducing workflow-driven updates with an approval process. This ensures governance and compliance before changes are applied, as applications enter an UPDATE PENDING state until updates are reviewed and approved.

     **[Learn more]({{base_path}}/consume/manage-application/advanced-topics/adding-an-application-update-workflow/)**

??? note "Application level scopes"

    Application scopes provide fine-grained control over permissions at the application level, enhancing security and flexibility. These scopes are configured as allowed scopes for specific applications and can only be selected from the subscribed scopes (scopes available from all subscribed APIs).

     **[Learn more]({{base_path}}/administer/key-managers/application-scopes/)** 

??? note "API Analytics with Moesif"

    Moesif-powered WSO2 Analytics for enhanced insights and observability.

    This integration enables you to collect and publish API analytics data to the Moesif dashboard, providing insights into API usage, traffic trends, and error tracking in near real-time.

     **[Learn more]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-integration-guide/)**

## Improvements

??? note "Support for long term  API traffic quota management"

    - Introduces distributed throttling powered by external CRDT-based counters (e.g., Redis, Valkey) as the underlying mechanism for API rate limiting in multi-node and multi-cluster environments.
    - All gateways share throttling state through distributed counters, ensuring consistent and accurate rate limiting regardless of which node or cluster processes a request.
    - This model supports billions of API calls per day while maintaining high performance and real-time throttling decisions.

     **[Learn more]({{base_path}}/manage-apis/design/rate-limiting/advanced-topics/distributed-throttling/)**

??? note "Gateway health and API deployment monitoring support"

    Adds new observability and monitoring capabilities for gateway operations.

    - **Gateway health monitoring:** View real-time gateway availability, status, and performance via the Admin Portal.
    - **API deployment monitoring:** Track API deployments and undeployments per gateway instance, with active revision visibility in the Publisher Portal.

    These enhancements improve transparency, troubleshooting efficiency, and operational confidence across distributed environments.

??? note "Removing database dependency of multi-tenant API gateways"

    - Introduces database dependency removal for the Universal Gateway to improve scalability and deployment flexibility in multi-tenant environments.
    - Gateways now operate independently without shared database access, synchronizing only tenant-specific data with the control plane.
    - This architecture enhances horizontal scalability, fault isolation, and resilience, enabling seamless scaling across distributed and high-traffic deployments.

     **[Learn more]({{base_path}}/manage-apis/deploy-and-publish/deploy-on-gateway/api-gateway/maintain-seperate-gateways-per-tenants/)**

??? note "Newly onboarded AI Service Providers"

    With this release, we have onboarded the following AI Service Providers that are ready for use out of the box.

    - [Gemini]({{base_path}}/ai-gateway/ai-vendor-management/gemini/)
    - [Anthropic]({{base_path}}/ai-gateway/ai-vendor-management/anthropic/)

    Also, we have shipped version 2.0.0 for the following AI Service Providers:

    - OpenAI
    - AzureOpenAI

??? note "API Analytics with OpenSearch"

    WSO2 API Manager now supports OpenSearch as the analytics provider for private cloud and on-premises environments. This solution publishes analytics data into log files, which are then processed through a deployment architecture consisting of Fluent Bit, OpenSearch, and OpenSearch Dashboards.

     **[Learn more]({{base_path}}/monitoring/api-analytics/on-prem/opensearch-installation-guide/)**

## Key Changes

Before upgrading to WSO2 API Manager 4.6.0, review the following architectural considerations that may affect your deployment setup:

- **Database Dependency Removal:**
With the removal of database dependency in the Universal Gateway and Traffic Manager, users no longer need to share databases with the control plane to support multi-tenancy.
This change improves scalability and simplifies deployment across distributed environments.

- **Disabled Admin Services**

## Compatible WSO2 product versions

{!includes/compatibility-matrix.md!}

## Deprecated Features

The following admin services will be deprecated from APIM 4.6.0 onwards:

??? note "Deprecated admin services"
    - APIGatewayAdmin
    - APIKeyMgtRemoteUserStoreMgtService
    - APILocalEntryAdmin
    - AuthenticationAdmin
    - AuthenticationAdmin/login
    - ChallengeQuestionManagementAdminService/getChallengeQuestionsForLocale
    - ChallengeQuestionManagementAdminService/getChallengeQuestionsForUser
    - ChallengeQuestionManagementAdminService/getChallengeQuestionsOfTenant
    - ChallengeQuestionManagementAdminService/getUserChallengeAnswers
    - ChallengeQuestionManagementAdminService/setUserChallengeAnswers
    - CommandMediatorAdmin
    - CustomMeteringService
    - EmailVerificationService
    - FileDownloadService
    - FileUploadService
    - IdentityApplicationManagementService/getAllIdentityProviders
    - IdentityProviderAdminService
    - IdentityProviderMgtService/getAllIdPs
    - IdentityProviderMgtService/getAllIdPsSearch
    - LoggedUserInfoAdmin
    - LoginStatisticsAdmin
    - LogViewer
    - ManageGenericArtifactService/canChange
    - ManageGenericArtifactService/getArtifactUIConfiguration
    - ManageGenericArtifactService/getAvailableAspects
    - MultipleCredentialsUserAdmin/getAllUserClaimValues
    - OAuthAdminService/getAppsAuthorizedByUser
    - OAuthAdminService/revokeAuthzForAppsByResoureOwner
    - PackageInfoService
    - QpidAdminService
    - RedirectorServletService
    - RegistryAdminService
    - RegistryCacheInvalidationService
    - SAML2SSOAuthenticationService
    - ServerAdmin/getServerData
    - SessionManagementService/removeMySession
    - TierCacheService
    - UserAdmin/getRolesOfCurrentUser
    - UserAdmin/getUserRealmInfo
    - UserAdmin/hasMultipleUserStores
    - UserIdentityManagementAdminService/changeUserPassword
    - UserIdentityManagementAdminService/getAllChallengeQuestions
    - UserIdentityManagementAdminService/getAllUserIdentityClaims
    - UserIdentityManagementAdminService/getChallengeQuestionsOfUser
    - UserIdentityManagementAdminService/setChallengeQuestionsOfUser
    - UserIdentityManagementAdminService/updateUserIdentityClaims
    - UserInformationRecoveryService
    - UserRegistrationAdminService

## Fixed issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue%20is%3Aclosed%20label%3AComponent%2FAPIM%20label%3A4.6.0%2C4.6.0-M1%2C4.6.0-Alpha%2C4.6.0-Alpha2%2C4.6.0-Alpha3%2C4.6.0-Beta)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue%20is%3Aclosed%20label%3AComponent%2FAPICTL%20label%3A4.6.0%2C4.6.0-M1%2C4.6.0-Alpha%2C4.6.0-Alpha2%2C4.6.0-Alpha3%2C4.6.0-Beta)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)
