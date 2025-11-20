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
3. **[Proxy a Existing MCP Server](./create-from-mcp-server.md)** – Wrap an external MCP server for governance, security, and analytics.
