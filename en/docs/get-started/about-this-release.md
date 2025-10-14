# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.6.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.5.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/get-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New Features

??? note "Gateway Federation"

    WSO2 API Manager 4.6.0 introduces comprehensive Gateway Federation capabilities, enabling seamless integration with external gateway platforms and automatic API discovery across federated environments.
    Administrators can now centrally manage, govern, and analyze APIs deployed in multiple third-party gateways through a unified control plane.

    **Federated API Auto-discovery:**

    - AWS API Gateway
    - Azure API Gateway
    - Kong Gateway: Kubernetes | Standalone
    - Envoy Gateway

    **Federated Gateway Onboarding:**

    - AWS Gateway (Improvements to the already existing support)
    - Azure API Gateway

??? note "Enhanced AI Gateway Capabilities"

    This release significantly expands AI Gateway functionality with unified AI model management, multi-provider support, and advanced AI governance features that simplify enterprise-scale AI integration.

    #### Unified AI Model Management

    - Provides a hierarchical model structure (Service Provider → Model Provider → Model) to unify AI model operations across multiple providers.
    - Supports dynamic model selection based on performance, cost, or compliance, with detailed usage analytics and flexible business plans.

    #### Additional AI/LLM Provider Support

    - AWS Bedrock
    - Azure AI Foundry
    - Gemini
    - Anthropic

    #### Advanced AI Features

    - **AI Guardrails:** Real-time validation and enforcement to ensure AI safety, reliability, and compliance.
    - **Semantic Caching:** Meaning-based response caching for improved performance and reduced latency in AI workloads.

??? note "MCP – Agent Integration Support"

    WSO2 API Manager now supports the Model Context Protocol (MCP), enabling seamless integration between APIs and AI agents.
    This feature allows organizations to transform existing APIs into MCP-compatible services without code changes, exposing tools and data sources to AI agents in a governed, secure manner.

    The control plane can also function as an MCP Hub, enabling centralized discovery and reuse of MCP servers across teams and environments.

    **Key Capabilities:**

    - **API to MCP Conversion:** Automatically convert existing APIs into MCP-compatible services.
    - **MCP Servers from APIs:** Import and expose external APIs as MCP servers.
    - **QoS for MCP Servers:** Apply rate limiting, authentication, and other policies to unprotected MCP endpoints.
    - **MCP Hub Support:** Centralized discovery and federation of MCP servers.

??? note "Enhanced Analytics Capabilities"

    This release introduces expanded analytics options with Moesif integration and OpenSearch support, providing scalable, AI-powered observability across API environments.

    #### APIM Analytics for Moesif

    - Integrates with Moesif to deliver cloud-based API analytics, offering deep insights into usage, user behavior, and revenue metrics.
    - Provides AI-driven anomaly detection, centralized analytics across federated gateways, and quick, cloud-native deployment with minimal operational overhead.

    #### OpenSearch Support for Private Cloud

    - Adds support for OpenSearch as the analytics provider for private cloud and on-premises environments.
    - Delivers real-time, scalable API analytics with full control over data retention, governance, and infrastructure, all within a self-managed, open-source stack.

## Improvements

??? note "Enhanced Platform and Gateway Management Capabilities"

    #### Distributed Throttling for Traffic Manager

    - Introduces distributed throttling powered by external CRDT-based counters (e.g., Redis, Valkey) as the underlying mechanism for API rate limiting in multi-node and multi-cluster environments.
    - All gateways share throttling state through distributed counters, ensuring consistent and accurate rate limiting regardless of which node or cluster processes a request.
    - This model supports billions of API calls per day while maintaining high performance and real-time throttling decisions.

    #### Enhanced Gateway Management

    Adds new observability and monitoring capabilities for gateway operations.

    - **Gateway Health Monitoring:** View real-time gateway availability, status, and performance via the Admin Portal.
    - **API Deployment Monitoring:** Track API deployments and undeployments per gateway instance, with active revision visibility in the Publisher Portal.

    These enhancements improve transparency, troubleshooting efficiency, and operational confidence across distributed environments.

??? note "Scalable Universal Gateway with Database-Free Tenancy"

    - Introduces database dependency removal for the Universal Gateway to improve scalability and deployment flexibility in multi-tenant environments.
    - Gateways now operate independently without shared database access, synchronizing only tenant-specific data with the control plane.
    - This architecture enhances horizontal scalability, fault isolation, and resilience, enabling seamless scaling across distributed and high-traffic deployments.

??? note "IS and API Manager Tenancy Sharing"

    - Reintroduces shared tenancy between WSO2 Identity Server and API Manager, allowing unified tenant management across both platforms.
    - This simplifies identity and API governance, reduces administrative effort, and ensures seamless interoperability in multi-tenant environments.

??? note "Application Management Enhancements"

    Enhances application lifecycle management with workflow-driven updates and fine-grained scope management.

    - **Application Update Workflow:** Adds an approval process for application updates, ensuring governance and compliance before changes are applied. Applications enter an UPDATE PENDING state until updates are reviewed and approved.
    - **Application Scope Support:** Enables fine-grained control over scopes and permissions for better application security and flexibility.

## Key Changes

Before upgrading to WSO2 API Manager 4.6.0, review the following architectural considerations that may affect your deployment setup:

- **Database Dependency Removal:**
With the removal of database dependency in the Universal Gateway and Traffic Manager, users no longer need to share databases with the control plane to support multi-tenancy.
This change improves scalability and simplifies deployment across distributed environments.

- **Tenant Sharing Between API Manager and Identity Server:**
When using WSO2 Identity Server as a Key Manager, tenants are now automatically shared between the two systems.
Users are no longer required to manually create tenants in both servers, streamlining tenant provisioning and synchronization.

## Compatible WSO2 product versions

{!includes/compatibility-matrix.md!}

## Fixed issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue%20is%3Aclosed%20label%3AComponent%2FAPIM%20label%3A4.6.0%2C4.6.0-M1%2C4.6.0-Alpha%2C4.6.0-Alpha2%2C4.6.0-Alpha3%2C4.6.0-Beta)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue%20is%3Aclosed%20label%3AComponent%2FAPICTL%20label%3A4.6.0%2C4.6.0-M1%2C4.6.0-Alpha%2C4.6.0-Alpha2%2C4.6.0-Alpha3%2C4.6.0-Beta)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)
