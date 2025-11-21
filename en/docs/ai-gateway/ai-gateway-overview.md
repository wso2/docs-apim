# WSO2 AI Gateway

Production AI deployments face critical challenges: runaway costs from misconfigured agents, reliability issues from provider outages, and security risks from unmonitored data flows to external models.

**WSO2 AI Gateway** provides enterprise-grade AI infrastructure management within the WSO2 API Manager platform.

As an intelligent intermediary between applications and AI services, it delivers:

- **Cost Control**: Smart routing, quotas, and spending limits prevent runaway expenses
- **Provider Independence**: Multi-provider support with seamless switching and failover
- **Enterprise Security**: Centralized data masking, audit logs, and compliance controls  
- **Reliable Performance**: Intelligent caching, load balancing, and automatic retry mechanisms
- **Complete Observability**: Unified monitoring for usage, latency, and errors across providers
- **Centralized Governance**: Role-based access, content filtering, and policy enforcement

The gateway operates in two complementary modes:

- **LLM Gateway**: Direct AI model interactions and multi-provider management
- **MCP Gateway**: Transform existing APIs into AI-discoverable tools for agent workflows

## Architecture

The AI Gateway operates as a production-grade control plane within WSO2 API Manager, designed for enterprise-scale AI workloads with comprehensive visibility and control over every AI interaction.

// TODO : Add new diagram showing both components of AI Gateway

## LLM Gateway

The **LLM Gateway** specializes in managing Large Language Model interactions for traditional AI API patterns. It provides direct integration with major AI service providers, enabling organizations to build conversational AI applications, content generation systems, and AI-powered services.

[![LLM Gateway]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.webp)]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.webp)

### Use LLM Gateway when you need
- Direct AI model interactions (chat, completion, embeddings)
- Multi-provider AI service management
- Conversational AI applications with prompt engineering
- AI service cost optimization and performance tuning

### LLM Gateway Features

#### Core LLM Operations

- **[AI API Creation]({{base_path}}/ai-gateway/getting-started-with-ai-gateway/)**: Create AI APIs by selecting an AI Service Provider and version
- **[AI Service Provider Management]({{base_path}}/ai-gateway/ai-vendor-management/overview/)**: Manage built-in providers (OpenAI, Azure OpenAI, AWS Bedrock, Anthropic, Google Gemini, Mistral AI, Azure AI Foundry) and integrate custom AI services

#### Traffic Management & Performance
- **[Multi-Model Routing]({{base_path}}/ai-gateway/multi-model-routing/overview/)**: Dynamically route requests across multiple models within a Service Provider for optimized performance
- **[Load Balancing]({{base_path}}/ai-gateway/multi-model-routing/load-balancing/)**: Distribute requests across multiple AI models or providers for optimal performance
- **[Failover]({{base_path}}/ai-gateway/multi-model-routing/failover/)**: Automatically route requests to backup providers when primary services are unavailable
- **[Semantic Caching]({{base_path}}/ai-gateway/semantic-caching/)**: Reduce latency and cost by serving semantically similar responses via embedding-based cache with similarity thresholds and TTLs

#### Security & Governance
- **[AI Backend Security]({{base_path}}/ai-gateway/ai-backend-security/)**: Secure AI service access with OAuth2, API keys, and custom authentication methods
- **[AI Guardrails]({{base_path}}/ai-gateway/ai-guardrails/overview/)**: Enforce safety and policy controls on inputs and outputs using provider-native and custom guardrails (regex, JSON schema, content safety)
- **[Data Privacy Controls]({{base_path}}/ai-gateway/ai-guardrails/regex-pii-masking/)**: Mask sensitive information in prompts and responses

#### Cost Control & Monitoring
- **[Rate Limiting]({{base_path}}/ai-gateway/rate-limiting/)**: Protect AI backends by enforcing token-based rate limits to manage resource consumption
- **[Cost Control]({{base_path}}/ai-gateway/rate-limiting/)**: Monitor and control AI service usage with advanced rate limiting and spending limits
- **[AI API Observability]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-integration-guide/)**: Track AI API usage statistics and performance metrics

#### Development & Management
- **[Prompt Management]({{base_path}}/ai-gateway/prompt-management/overview/)**: Centrally author, version, and reuse prompts and templates with decorators for standardization
- **[AI APIs via SDKs]({{base_path}}/ai-gateway/using-proxy-apis-in-sdks/)**: Generate and manage SDKs for AI API consumption

## MCP Gateway

The **Model Context Protocol (MCP) Gateway** transforms existing APIs into AI-ready tools that AI agents can discover and invoke. Built on the JSON-RPC–based [Model Context Protocol specification](https://modelcontextprotocol.io/docs/getting-started/intro), it standardizes how applications interact with LLMs by exposing callable tools that AI agents can invoke in workflows, complete with machine-readable schemas for discovery and validation.

The MCP Gateway implements a three-tier architecture:
 
- **Host** : Runtime where the MCP client operates, such as an AI agent or gateway
- **Client** : Mediates communication with MCP servers
- **Servers** : Publish tools, schemas, and metadata for discovery and invocation

This standardized approach enables structured AI workflows where AI agents can seamlessly call your business logic as tools.

[![API Manager MCP Architecture]({{base_path}}/assets/img/mcp-gateway/mcp-architecture.png)]({{base_path}}/assets/img/mcp-gateway/mcp-architecture.png)

### Use MCP Gateway when you need
- Transform existing APIs into AI-callable tools
- Enable AI agents to interact with your business systems
- Structured AI workflows with tool orchestration
- Standardized tool discovery for AI applications

### MCP Gateway Features  

#### Tool Management & Discovery
- **[API-to-Tool Transformation]({{base_path}}/mcp-gateway/create-from-api/)**: Transform existing APIs into AI-ready tools with machine-readable schemas
- **[MCP Server Creation]({{base_path}}/mcp-gateway/create-from-openapi/)**: Create MCP servers from OpenAPI definitions, existing APIs, or by proxying existing MCP servers
- **[Tool Discovery]({{base_path}}/mcp-gateway/create-from-mcp-server/)**: Standardized tool discovery and schema retrieval for AI agents
- **[Versioned Tool Changes]({{base_path}}/mcp-gateway/update-and-deploy-mcp-server/)**: Ship tool updates with minimal disruption to AI workflows

#### Execution & Testing
- **[Tool Invocation]({{base_path}}/mcp-gateway/subscribe-to-a-mcp-server/)**: JSON-RPC based tool execution through subscriptions and access tokens
- **[MCP Playground]({{base_path}}/mcp-gateway/invoke-a-mcp-server-using-playground/)**: Interactive testing environment for MCP servers and tools
#### Security & Analytics
- **[API Security]({{base_path}}/api-design-manage/design/api-security/api-authentication/secure-apis-using-oauth2-tokens/)**: Leverage platform security policies including OAuth2, JWT, and mutual SSL for tool access
- **[API Analytics]({{base_path}}/monitoring/api-analytics/analytics-overview/)**: Track tool usage patterns and performance metrics through platform analytics
- **[Rate Limiting]({{base_path}}/api-design-manage/design/rate-limiting/setting-throttling-limits/)**: Control tool usage with platform throttling policies and quotas

## Platform Capabilities

Both gateway modes share WSO2 API Manager's enterprise platform capabilities:

- **[Multi-Tenancy]({{base_path}}/administer/multitenancy/introduction-to-multitenancy/)**: Tenant isolation, usage billing, and custom policies per tenant
- **[Enterprise Governance]({{base_path}}/api-design-manage/design/api-policies/overview/)**: Apply governance policies to AI service consumption and tool access
- **[Compliance Monitoring]({{base_path}}/monitoring/api-analytics/analytics-overview/)**: Comprehensive audit logging for regulatory compliance
- **Cloud-Native Operations**: Kubernetes integration, automatic scaling, and rolling updates

## Getting Started

### Choose Your Implementation Path

**New to AI in Production:**
Start with the essentials - deploy the gateway and gain immediate cost visibility.

1. Deploy [LLM Gateway]({{base_path}}/ai-gateway/getting-started-with-ai-gateway/) for centralized AI access
2. Set up basic cost controls and monitoring

**Migrating Existing Applications:**
Route your current AI traffic through the gateway without disruption.

1. Assess current costs and reliability issues 
2. Gradually migrate traffic through the gateway
3. Add security and governance policies as needed

**Enterprise Scale Deployment:**
Build comprehensive infrastructure for production AI operations.

1. Configure multiple AI providers for resilience
2. Implement advanced security and compliance controls
3. Enable AI agent workflows with [API-to-tool]({{base_path}}/mcp-gateway/create-from-api/) transformation

## Best Practices

### Start with Security and Cost Control
Always implement [AI Guardrails]({{base_path}}/ai-gateway/ai-guardrails/overview/) and cost controls before production deployment. Set conservative usage quotas initially and gradually increase based on actual needs. This prevents unexpected costs and security incidents from day one.

### Avoid Vendor Lock-in Early
Configure [multiple AI providers]({{base_path}}/ai-gateway/ai-vendor-management/overview/) even if you initially use only one. This provides immediate failover capability and negotiating leverage. Test failover scenarios regularly to ensure seamless switching when needed.

### Optimize Costs with Caching
Enable [semantic caching]({{base_path}}/ai-gateway/semantic-caching/) to reduce API calls by 40-60%. Start with conservative similarity thresholds (0.95) and adjust based on your application's tolerance for cached responses. Monitor cache hit rates and cost savings regularly.

### Plan for AI Agent Workflows
If building AI agents that need to interact with your business systems, implement [MCP Gateway]({{base_path}}/mcp-gateway/overview/) to standardize tool access. Start by exposing read-only APIs as tools, then gradually add write operations with appropriate access controls.
### Use Smart Routing for Production
Implement [smart routing]({{base_path}}/ai-gateway/multi-model-routing/overview/) to balance cost and performance. Route simple queries to cost-effective models and complex reasoning tasks to premium models. Set up automated failover between providers to maintain availability.

## Next Steps

Choose your path based on your use case:

- **[Getting Started with LLM Gateway]({{base_path}}/ai-gateway/getting-started-with-ai-gateway/)** - For direct AI model integration (chat, completion, content generation)
- **[Getting Started with MCP Gateway]({{base_path}}/mcp-gateway/overview/)** - For transforming APIs into AI-callable tools