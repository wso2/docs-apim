# Getting Started with MCP

The **Model Context Protocol (MCP)** in WSO2 API Manager provides a standardized way to expose *tool-style* capabilities as first-class APIs for AI, automation, and structured integrations. An MCP Server **describes its capabilities as tools** with machine-readable schemas and discovery.

## What is Model Context Protocol?

**MCP is a JSON-RPC–based protocol** that standardizes how applications interact with LLMs. It lets applications both share context (files, databases, APIs) with LLMs and **expose callable tools** that agents can invoke in workflows.

### Architecture (host–client–server)

* **Host** – Runtime where the MCP client lives (e.g., agent or gateway).
* **Client** – Mediates communication with one or more MCP servers.
* **Server** – Publishes tools, schemas, and metadata for discovery and invocation.

> For full protocol details, see the [official MCP specification](https://modelcontextprotocol.io/docs/getting-started/intro).

## MCP Core Concepts

* **Server** – The MCP API you manage, can expose one or more tools.
* **Tool** – A callable capability (e.g., `echo`, `summarize`, `getOrderStatus`) defined by input/output schemas.
* **Discovery** – Clients list tools, read metadata, and fetch schemas before invocation.

## Why MCP in APIM is Valuable

* Enforce **consistent security** across AI/automation endpoints.
* Provide **standardized metadata** for zero-guesswork client integration.
* Track **tool usage analytics** for capacity and optimization.
* Ship **versioned tool changes** with minimal disruption.

## Manage MCP Servers with WSO2 API Manager

WSO2 API Manager provides a unified platform for managing MCP Servers, enabling you to transform APIs into AI-ready tools and govern their lifecycle. With a centralized control plane, you can create, discover, and manage MCP Servers efficiently—streamlining workflows for both API developers and AI agent builders.

   [![API Manager MCP Architecture]({{base_path}}/assets/img/mcp/mcp-architecture.png)]({{base_path}}/assets/img/mcp/mcp-architecture.png)


!!! note
    This guide walks you from defining tools to deploying and publishing an MCP Server in WSO2 API Manager.

## Quick Start (at a glance)

1. **Choose a creation path** (see below).
2. **Define/confirm tool schemas** (inputs/outputs, descriptions).
3. **Attach policies** (auth, rate limiting).
5. **Publish & test** (run discovery, call tools, review analytics).

!!! tip
    Keep input schemas minimal and strongly typed; LLMs perform better with concise, unambiguous contracts.

## Next Step → MCP Server Creation Options

WSO2 API Manager offers three ways to create an MCP Server:

1. **[Create an MCP Server by Importing an OpenAPI Definition](./create-from-openapi.md)** – Generate tools and configuration from an existing OpenAPI.
2. **[Create an MCP Server Using an Existing API](./create-from-api.md)** – Select an API already in APIM and convert operations into MCP tools.
3. **[Proxy an Existing MCP Server](./create-from-mcp-server.md)** – Wrap an external MCP server for governance, security, and analytics.
