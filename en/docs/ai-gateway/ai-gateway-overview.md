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

- **[AI API Creation](getting-started-with-ai-gateway.md)**: Create AI APIs by selecting an AI Service Provider and version
- **[AI Service Provider Management](ai-vendor-management/overview.md)**: Manage built-in providers (OpenAI, Azure OpenAI, AWS Bedrock, Anthropic, Google Gemini, Mistral AI, Azure AI Foundry) and integrate custom AI services

#### Traffic Management & Performance
- **[Multi-Model Routing](multi-model-routing/overview.md)**: Dynamically route requests across multiple models within a Service Provider for optimized performance
- **[Load Balancing](multi-model-routing/load-balancing.md)**: Distribute requests across multiple AI models or providers for optimal performance
- **[Failover](multi-model-routing/failover.md)**: Automatically route requests to backup providers when primary services are unavailable
- **[Semantic Caching](semantic-caching.md)**: Reduce latency and cost by serving semantically similar responses via embedding-based cache with similarity thresholds and TTLs

#### Security & Governance
- **[AI Backend Security](ai-backend-security.md)**: Secure AI service access with OAuth2, API keys, and custom authentication methods
- **[AI Guardrails](ai-guardrails/overview.md)**: Enforce safety and policy controls on inputs and outputs using provider-native and custom guardrails (regex, JSON schema, content safety)
- **[Data Privacy Controls](ai-guardrails/regex-pii-masking.md)**: Mask sensitive information in prompts and responses

#### Cost Control & Monitoring
- **[Rate Limiting](rate-limiting.md)**: Protect AI backends by enforcing token-based rate limits to manage resource consumption
- **[Cost Control](rate-limiting.md)**: Monitor and control AI service usage with advanced rate limiting and spending limits
- **[AI API Observability](../monitoring/api-analytics/moesif-analytics/moesif-integration-guide.md)**: Track AI API usage statistics and performance metrics

#### Development & Management
- **[Prompt Management](prompt-management/overview.md)**: Centrally author, version, and reuse prompts and templates with decorators for standardization
- **[AI APIs via SDKs](using-proxy-apis-in-sdks.md)**: Generate and manage SDKs for AI API consumption

## MCP Gateway

The **Model Context Protocol (MCP) Gateway** transforms existing APIs into AI-ready tools that AI agents can discover and invoke. Built on the JSON-RPC–based [Model Context Protocol specification](https://modelcontextprotocol.io/docs/getting-started/intro), it standardizes how applications interact with LLMs by exposing callable tools that AI agents can invoke in workflows, complete with machine-readable schemas for discovery and validation.

The MCP Gateway implements a three-tier architecture:
 
- **Host** : Runtime where the MCP client operates, such as an AI agent or gateway
- **Client** : Mediates communication with MCP servers
- **Servers** : Publish tools, schemas, and metadata for discovery and invocation

This standardized approach enables structured AI workflows where AI agents can seamlessly call your business logic as tools.

[![API Manager MCP Architecture]({{base_path}}/assets/img/mcp/mcp-architecture.png)]({{base_path}}/assets/img/mcp/mcp-architecture.png)

### Use MCP Gateway when you need
- Transform existing APIs into AI-callable tools
- Enable AI agents to interact with your business systems
- Structured AI workflows with tool orchestration
- Standardized tool discovery for AI applications

### MCP Gateway Features  

#### Tool Management & Discovery
- **[API-to-Tool Transformation](../mcp/create-from-api.md)**: Transform existing APIs into AI-ready tools with machine-readable schemas
- **[MCP Server Creation](../mcp/create-from-openapi.md)**: Create MCP servers from OpenAPI definitions, existing APIs, or by proxying existing MCP servers
- **[Tool Discovery](../mcp/overview.md)**: Standardized tool discovery and schema retrieval for AI agents
- **[Schema Management](../mcp/create-from-openapi.md)**: Define and manage tool schemas with input/output specifications
- **[Versioned Tool Changes](../mcp/update-and-deploy-mcp-server.md)**: Ship tool updates with minimal disruption to AI workflows

#### Execution & Validation
- **[Tool Invocation](../mcp/subscribe-to-a-mcp-server.md)**: JSON-RPC based tool execution with structured input/output validation
- **[MCP Playground](../mcp/invoke-a-mcp-server-using-playground.md)**: Interactive testing environment for MCP servers and tools

#### Security & Analytics
- **[Enterprise Security](../mcp/overview.md)**: Consistent security policies and data privacy controls across tool interactions  
- **[Tool Usage Analytics](../mcp/overview.md)**: Track usage patterns and audit tool invocations for compliance
- **[Rate Limiting](../mcp/overview.md)**: Control tool usage with quotas and usage limits

## Platform Capabilities

Both gateway modes share WSO2 API Manager's enterprise platform capabilities:

- **[Multi-Tenancy](../administer/multitenancy/introduction-to-multitenancy.md)**: Tenant isolation, usage billing, and custom policies per tenant
- **[Enterprise Governance](../../api-design-manage/design/api-policies/overview/)**: Apply governance policies to AI service consumption and tool access
- **[Compliance Monitoring](../monitoring/)**: Comprehensive audit logging for regulatory compliance
- **Cloud-Native Operations**: Kubernetes integration, automatic scaling, and rolling updates

## Getting Started

### Choose Your Implementation Path

**New to AI in Production:**
Start with basic gateway deployment for immediate cost control and monitoring.

1. Deploy [LLM Gateway](getting-started-with-ai-gateway.md) for centralized AI access
2. Configure usage quotas and spending limits
3. Enable monitoring dashboards for usage and costs

**Migrating Existing AI Applications:**
Route current AI traffic through the gateway without disrupting operations.

1. Assess current costs, reliability issues, and integration complexity
2. Gradually migrate traffic through the gateway
3. Add [AI Guardrails](ai-guardrails/) and governance incrementally

**Planning Enterprise Scale:**
Build comprehensive infrastructure for autonomous agents and complex workflows.

1. Configure [Multi-Provider Support](ai-vendor-management/) for resilience
2. Deploy [MCP Gateway](../mcp/overview.md) for AI agent capabilities
3. Enable [Semantic Caching](semantic-caching.md) and [Multi-Model Routing](multi-model-routing/)

## Best Practices

### Implementation Strategy

- **Phase 1: Establish Basic AI Gateway**
Deploy an AI gateway to centralize LLM access, track usage, and enforce rate limits. Focus on cost control and observability to prevent runaway token consumption. Even with a single provider, this foundation enables reliable AI operations and provides actionable insights into traffic patterns.

- **Phase 2: Add Agent Capabilities**
Identify enterprise tools and data sources that agents require. Start with read-only resources (databases, documentation), then gradually add executable tools (calculations, notifications, workflow triggers). This phase enables agents to perform meaningful actions while maintaining security and observability.

- **Phase 3: Introduce Advanced Governance**
As usage grows, add centralized governance: rate limiting per agent/team/tool, analytics for usage patterns, fine-grained access control, and comprehensive audit logging for compliance. This ensures your AI infrastructure scales safely.

- **Phase 4: Multi-Provider Optimization**
Add support for multiple LLM providers to increase resilience and optimize cost/quality balance. Implement intelligent routing based on workload type and cache frequent queries to reduce redundant computation.

### Security & Compliance

- **[AI Guardrails](ai-guardrails/)**: Prompt injection protection and content filtering
- **Data Privacy**: PII/PHI masking and geographic routing for data residency  
- **Access Control**: Scoped permissions and usage quotas at organization, team, and user levels
- **Monitoring**: Anomaly detection, audit trails, and circuit breaking for compliance

### Performance & Cost Optimization

- **Smart Routing**: Route by complexity, latency requirements, and content type for optimal cost/performance balance  
- **[Semantic Caching](semantic-caching.md)**: Reduce API calls by 40-60% with intelligent response caching
- **Efficiency**: Response deduplication, connection pooling, and streaming for enhanced performance