# AI Gateway Overview

As AI adoption accelerates, managing AI APIs effectively has become essential for organizations integrating AI into their applications. WSO2 API Manager's **AI Gateway** simplifies this process, providing a seamless way to create, manage, and expose AI APIs with robust security and scalability.

[![AI Gateway]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.webp){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.webp)

## Introduction

The AI Gateway acts as an intelligent proxy layer between your applications and AI service providers, offering centralized management of AI API calls, enhanced security, and comprehensive monitoring. It supports both traditional AI APIs through the **LLM Gateway** and AI tool integration through the **Model Context Protocol (MCP) Gateway**.

WSO2 API Manager offers built-in support for **Anthropic**, **AWS Bedrock**, **Azure AI Foundry**, **Azure OpenAI**, **Gemini**, **Mistral**, and **OpenAI**, while also allowing the configuration of custom AI Service Providers, enabling flexible AI API creation.

### Key Benefits

- **Unified AI Service Management**: Centrally manage multiple AI service providers through a single gateway
- **Enhanced Security**: Apply consistent security policies across all AI service interactions
- **Cost Control**: Monitor and control AI service usage with advanced rate limiting and throttling
- **Multi-Provider Support**: Seamlessly integrate with major AI providers and custom AI services
- **Intelligent Routing**: Implement load balancing and failover mechanisms across multiple AI models
- **AI Tool Integration**: Transform existing APIs into AI-ready tools with standardized schemas
- **Governance**: Apply enterprise governance policies to AI service consumption

## AI Gateway Architecture

The AI Gateway operates as part of WSO2 API Manager's data plane, processing AI-specific requests with specialized capabilities:

```
Client Applications
        ↓
   AI Gateway (WSO2 APIM)
   ├── Authentication & Authorization
   ├── AI Guardrails & Validation
   ├── Rate Limiting & Throttling
   ├── Multi-Model Routing
   ├── Prompt Management
   └── Semantic Caching
        ↓
   AI Service Providers
   ├── OpenAI
   ├── Azure OpenAI
   ├── AWS Bedrock
   ├── Anthropic
   ├── Google Gemini
   └── Custom AI Services
```

## AI Gateway Capabilities

The AI Gateway provides a comprehensive set of features for managing AI services and integrations:

### LLM Gateway Features
- **AI API Creation**: Create AI APIs by selecting an AI Service Provider and version
- **AI Service Provider Key Configuration**: Securely authenticate AI APIs by configuring API keys from providers
- **Multi-Model Routing**: Dynamically route AI API requests across multiple models within a Service Provider for optimized performance
- **Load Balancing**: Distribute requests across multiple AI models or providers for optimal performance  
- **Failover**: Automatically route requests to backup providers when primary services are unavailable
- **Rate Limiting**: Protect AI backends by enforcing token-based rate limits to manage resource consumption
- **Prompt Management**: Centrally author, version, and reuse prompts and templates; apply decorators to enrich or standardize prompts
- **AI Guardrails**: Enforce safety and policy controls on inputs and outputs using provider-native and custom guardrails (regex, JSON schema, content safety)
- **Semantic Caching**: Reduce latency and cost by serving semantically similar responses via embedding-based cache with similarity thresholds and TTLs
- **AI Backend Security**: Secure AI service access with OAuth2, API keys, and custom authentication methods
- **AI APIs via SDKs**: Generate and manage SDKs for AI API consumption
- **AI Service Provider Management**: Manage both default and custom AI Service Providers to streamline administration

### MCP Gateway Features  
- **API-to-Tool Transformation**: Transform existing APIs into AI-ready tools with machine-readable schemas
- **MCP Server Creation**: Create MCP servers from OpenAPI definitions, existing APIs, or by proxying existing MCP servers
- **Tool Discovery**: Standardized tool discovery and schema retrieval for AI agents
- **Tool Invocation**: JSON-RPC based tool execution with structured input/output validation
- **MCP Playground**: Interactive testing environment for MCP servers and tools
- **Schema Management**: Define and manage tool schemas with input/output specifications
- **Versioned Tool Changes**: Ship tool updates with minimal disruption to AI workflows
- **Tool Usage Analytics**: Track tool usage patterns for capacity planning and optimization

### Shared AI Gateway Features
- **Multi-Provider Support**: Built-in support for OpenAI, Azure OpenAI, AWS Bedrock, Anthropic, Google Gemini, Mistral AI, and Azure AI Foundry
- **Custom AI Service Integration**: Framework for integrating proprietary or specialized AI services
- **Enterprise Security**: Consistent security policies across all AI service interactions
- **Data Privacy Controls**: Mask sensitive information in prompts and responses  
- **Compliance Monitoring**: Track and audit AI service usage for regulatory compliance
- **Cost Control**: Monitor and control AI service usage with advanced rate limiting and spending limits
- **Performance Optimization**: Response streaming, connection pooling, and request optimization
- **AI API Observability**: Track AI API usage statistics and performance metrics
- **Multi-Tenant Support**: Tenant isolation, usage billing, and custom policies per tenant
- **Governance**: Apply enterprise governance policies to AI service consumption

## AI Gateway Components

### LLM Gateway

The **LLM Gateway** specializes in managing Large Language Model interactions for traditional AI API patterns. It provides direct integration with major AI service providers, enabling organizations to build conversational AI applications, content generation systems, and AI-powered services.

**Use LLM Gateway when you need:**
- Direct AI model interactions (chat, completion, embeddings)
- Multi-provider AI service management
- Conversational AI applications with prompt engineering
- AI service cost optimization and performance tuning

### MCP Gateway

The **Model Context Protocol (MCP) Gateway** transforms existing APIs into AI-ready tools that AI agents can discover and invoke. Based on the [Model Context Protocol specification](https://modelcontextprotocol.io/docs/getting-started/intro), it enables structured AI workflows where AI agents can call your business logic as tools.

**What is Model Context Protocol?**
MCP is a JSON-RPC–based protocol that standardizes how applications interact with LLMs. It lets applications expose callable tools that AI agents can invoke in workflows, with machine-readable schemas for discovery and validation.

**MCP Architecture (host–client–server):**
* **Host** – Runtime where the MCP client lives (e.g., AI agent or gateway)
* **Client** – Mediates communication with one or more MCP servers  
* **Server** – Publishes tools, schemas, and metadata for discovery and invocation

**Use MCP Gateway when you need:**
- Transform existing APIs into AI-callable tools
- Enable AI agents to interact with your business systems
- Structured AI workflows with tool orchestration
- Standardized tool discovery for AI applications

[![API Manager MCP Architecture]({{base_path}}/assets/img/mcp/mcp-architecture.png)]({{base_path}}/assets/img/mcp/mcp-architecture.png)

## AI Service Provider Ecosystem

The AI Gateway provides pre-built connectors for major AI service providers:

### Supported Providers

- **OpenAI**: GPT-3.5, GPT-4, and newer models with full feature support
- **Azure OpenAI**: Enterprise-grade OpenAI services through Microsoft Azure
- **AWS Bedrock**: Access to multiple AI models through Amazon's managed service
- **Anthropic**: Claude models with specialized conversation capabilities  
- **Google Gemini**: Google's advanced AI models with multimodal support
- **Mistral AI**: High-performance language models optimized for efficiency
- **Azure AI Foundry**: Microsoft's comprehensive AI development platform

### Custom AI Service Integration

For organizations with proprietary or specialized AI services:

- **Custom Connector Framework**: Build custom connectors for any AI service
- **Plugin Architecture**: Extend AI Gateway functionality with custom plugins
- **Protocol Adapters**: Support for various AI service protocols and interfaces
- **Configuration Templates**: Simplified setup for common custom AI service patterns

## Use Cases and Applications

### Enterprise AI Integration

- **Customer Service Automation**: Integrate chatbots and virtual assistants
- **Content Generation**: Manage content creation workflows across multiple AI providers
- **Document Processing**: Route document analysis requests to specialized AI services
- **Code Generation**: Provide secure access to AI-powered development tools

### Multi-Tenant AI Services

- **Tenant Isolation**: Ensure secure separation of AI service usage across tenants
- **Usage Billing**: Track and bill AI service consumption per tenant
- **Custom Policies**: Apply tenant-specific governance and security policies
- **Resource Quotas**: Manage AI service quotas and limits per tenant

### AI Service Optimization

- **Cost Optimization**: Route requests to cost-effective AI providers based on requirements
- **Performance Tuning**: Optimize response times through intelligent caching and routing
- **Quality Assurance**: Ensure consistent AI service quality through guardrails and validation
- **Experimentation**: A/B test different AI models and providers

## Getting Started

To begin using the AI Gateway:

1. **Explore LLM Gateway**: Start with the [LLM Gateway Getting Started Guide](getting-started-with-ai-gateway.md) to set up your first AI service integration
2. **Try MCP Gateway**: Explore [MCP Gateway Getting Started](../mcp/overview.md) for advanced AI integration patterns
3. **Configure AI Providers**: Learn about [AI Service Provider Management](ai-vendor-management/) to connect your preferred AI services
4. **Implement Security**: Set up [AI Guardrails](ai-guardrails/) to ensure safe and compliant AI service usage
5. **Optimize Performance**: Configure [Semantic Caching](semantic-caching.md) and [Multi-Model Routing](multi-model-routing/) for optimal performance

## Best Practices

### Security Considerations

- Always implement appropriate AI guardrails for production deployments
- Use secure authentication methods for AI service provider access
- Regularly audit AI service usage and access patterns
- Implement data privacy controls for sensitive information

### Performance Optimization

- Configure semantic caching for frequently used AI service patterns
- Implement appropriate rate limiting to balance performance and costs
- Use multi-model routing to distribute load and improve availability
- Monitor AI service performance and costs regularly

### Governance and Compliance

- Establish clear policies for AI service usage within your organization
- Implement comprehensive logging and auditing for AI service interactions
- Regularly review and update AI guardrails based on evolving requirements
- Ensure compliance with relevant data protection and AI governance regulations

---

The AI Gateway provides a comprehensive foundation for enterprise AI service management. Whether you're building customer-facing AI applications or internal AI-powered tools, the AI Gateway ensures your AI services are secure, performant, and well-governed.