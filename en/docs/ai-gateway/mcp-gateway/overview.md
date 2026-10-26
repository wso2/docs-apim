# Getting Started with MCP Gateway

WSO2 API Manager provides a unified platform for managing MCP Servers, enabling you to transform APIs into AI-ready tools and govern their lifecycle. With a centralized control plane, you can create, discover, and manage MCP Servers efficiently—streamlining workflows for both API developers and AI agent builders.

  [![API Manager MCP Architecture]({{base_path}}/assets/img/mcp-gateway/mcp-architecture.png)]({{base_path}}/assets/img/mcp-gateway/mcp-architecture.png)


!!! note
    This guide walks you from defining tools to deploying and publishing a MCP Server in WSO2 API Manager.

## Quick Start (at a glance)

1. **Choose a creation path** (see below).
2. **Define/confirm tool schemas** (inputs/outputs, descriptions).
3. **Attach policies** (auth, rate limiting).
5. **Publish & test** (run discovery, call tools, review analytics).

!!! tip
    Keep input schemas minimal and strongly typed; LLMs perform better with concise, unambiguous contracts.

## Next Step → MCP Server Creation Options

WSO2 API Manager offers three ways to create a MCP Server:

1. **[Create a MCP Server by Importing an OpenAPI Definition](./create-from-openapi.md)** – Generate tools and configuration from an existing OpenAPI.
2. **[Create a MCP Server Using an Existing API](./create-from-api.md)** – Select an API already in APIM and convert operations into MCP tools.
3. **[Proxy an Existing MCP Server](./create-from-mcp-server.md)** – Wrap an external MCP server for governance, security, and analytics.

!!! warning "Scaling Considerations"
    Direct API-to-MCP conversion works well for small deployments but does not scale effectively. Exposing every API resource as a separate tool quickly consumes the LLM's context window and increases hallucination rates.
    
    **Best Practice:** Design MCP servers around specific workflows rather than exposing all API operations. Use the gateway to proxy your curated MCP servers while enforcing security, rate limiting, and QoS policies. You can either use tools such as [Arazzo MCP Gen CLI](https://wso2.com/api-platform/docs/tools/arazzo-mcp-gen-cli/quick-start-guide/) to accelerate development from your service architecture, or write your MCP server from scratch based on your specific workflow requirements. 
