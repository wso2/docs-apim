# Getting Started with MCP

The **Model Context Protocol (MCP)** in WSO2 API Manager provides a framework for exposing *tool-style* capabilities as first-class APIs—purpose-built for AI, automation, and structured integrations.

Rather than manually designing and wiring up multiple REST endpoints, an MCP Server **describes its capabilities as “tools”**—each with:

* **Input schemas** – The exact structure and data types the tool accepts.
* **Output schemas** – The precise format and structure of the tool’s responses.
* **Discovery mechanisms** – How clients automatically find, understand, and integrate available tools without manual schema interpretation.

This approach makes it easier to **standardize**, **secure**, and **govern** the capabilities of backends consumed by AI models, RPA bots, and other automated systems.

## Key Benefits of Using MCP in APIM

By leveraging MCP in API Manager, you can:

* **Create MCP Servers** – Define tools from scratch or map them directly to backend API operations.
* **Proxy External MCP Servers** – Wrap and expose third-party MCP Servers through APIM to apply authentication, throttling, caching, and analytics without modifying the original service.
* **Bootstrap from APIs/OpenAPI** – Instantly generate MCP Servers from existing REST APIs, preserving each operation as an MCP tool.

## MCP Core Concepts

* **Server** – The MCP API you manage in APIM. It can expose one or more tools to clients.
* **Tool** – A callable, well-defined capability (e.g., `echo`, `summarize`, `getOrderStatus`) that includes a machine-readable input/output schema.
* **Discovery** – A standardized process where clients retrieve the list of tools, their metadata, and schema definitions before invocation.
* **Governance** – The application of APIM’s policies—authentication, scopes, throttling, logging, and analytics—to MCP tools, just like with any other API.

## Why MCP in APIM is Valuable

Combining MCP’s structured tooling model with APIM’s lifecycle and governance features allows you to:

* Enforce **consistent security** policies across AI and automation-focused endpoints.
* Provide **standardized metadata** so clients can integrate without manual schema inspection.
* Monitor and analyze **tool usage patterns** to support capacity planning or improve model fine-tuning.
* Introduce **versioned changes** to tools with minimal disruption to consumers.

!!! note
This Getting Started guide will walk you through the end-to-end process of creating an MCP Server in WSO2 API Manager—from defining tools, to deploying and publishing them for use.

### Next Step → MCP Server Creation Options

WSO2 API Manager offers three ways to create an MCP Server, depending on your starting point and integration needs:

1. **[Create an MCP Server by Importing an OpenAPI Definition](./create-from-openapi.md)** – Use an existing OpenAPI definition to auto-generate tools and server configuration.
2. **[Create an MCP Server Using an Existing API](./create-from-api.md)** – Select an already-deployed API in APIM and convert its operations into MCP tools.
3. **[Proxy an Existing MCP Server](./create-from-mcp-server.md)** – Wrap an external MCP Server behind APIM for governance, security, and analytics.