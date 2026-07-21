# Backstage Plugin for WSO2 API Platform

The Backstage Plugin for WSO2 API Platform is an open-source plugin suite that integrates [WSO2 API Platform](https://wso2.com/api-manager/) with [Backstage](https://backstage.io).

It automatically synchronizes your WSO2 API Platform content directly into the Backstage Software Catalog. It discovers your wso2 APIs, API products, MCP servers, Services on a customizable schedule, providing a unified portal for API discovery.

## Why use this plugin?

Organizations that use WSO2 API Platform for API management and Backstage as their internal developer portal often have to context-switch between:

- **Backstage** — for service catalog, documentation, ownership, and developer tooling.
- **WSO2 API Platform Publisher and Developer portals** — for API discovery and management tasks.

This same friction applies to organizations using **OpenChoreo** — developers working across API Platform and their developer portal have to navigate separate interfaces to access API information.

Additionally, self-hosted gateways managed through WSO2 API Platform SaaS are not visible from within developer portals, making it harder to discover and understand the full API landscape.

This plugin addresses all of this: it lets developers view selected WSO2 API Platform information from within Backstage or OpenChoreo, and provides discoverability of self-hosted gateways registered in WSO2 API Platform SaaS.

## Plugin Suite Overview

The plugin suite is available as three installable packages.

| Package                                                   | Role                                                                                                                      |
| -----------------------------------------------------------| ---------------------------------------------------------------------------------------------------------------------------|
| `@wso2/backstage-plugin-wso2-api-manager`                 | Frontend plugin — the UI, pages, and entity cards                                                                         |
| `@wso2/backstage-plugin-wso2-api-manager-backend`         | Backend plugin — handles communication with WSO2 API Platform                                                             |
| `@wso2/backstage-plugin-catalog-backend-module-wso2-apim` | Catalog module — discovers and ingests WSO2 APIs, products, MCP Servers, and services into the Backstage software catalog |

## Capabilities

| Capability              | What users can do                                                                     |
| -------------------------| ---------------------------------------------------------------------------------------|
| API catalog viewing     | View all APIs, API Products, MCP Servers, and services from WSO2 API Platform on-prem |
| Gateway discoverability | Discover self-hosted gateways configured in WSO2 API Platform SaaS                    |
| API definition viewing  | View OpenAPI, GraphQL, WebSocket, SOAP, async, and SSE definitions                    |
| WSO2 API metadata       | View lifecycle, context, version, provider, endpoints, and gateway details            |
| API documents           | View and download API documents for all API types                                     |
| WSDL download           | Download WSDL content for SOAP APIs that expose it                                    |
| API key generation      | Generate API keys for invocation where supported (see limitations)                    |
| Policy viewer           | View API-level and operation-level policies for all API types                         |
| Service Catalog         | View WSO2 services and download service definitions                                   |
| MCP Server tools        | View MCP Server tool metadata                                                         |
| API Product resources   | View API Product resource operations and documents                                    |


## Supported Entities


| API Type               | Definition View            | Try It Out / Console     | Documents | Policy Viewer | API Key Generation |
| ------------------------| ----------------------------| --------------------------| -----------| ---------------| --------------------|
| HTTP / REST API        | OpenAPI / Swagger          | Swagger Console          | Yes       | Yes           | Yes (if eligible)  |
| SOAP API               | API Definition + WSDL      | Swagger Console          | Yes       | Yes           | Yes (if eligible)  |
| GraphQL API            | GraphQL schema             | GraphQL Console          | Yes       | Yes           | Yes (if eligible)  |
| WebSocket API          | Async/WebSocket schema     | WebSocket Console        | Yes       | Yes           | Yes (if eligible)  |
| WebSub API             | Async schema               | WebSub Console           | Yes       | Yes           | Yes (if eligible)  |
| SSE API                | Async schema               | SSE Console              | Yes       | Yes           | Yes (if eligible)  |
| MCP Server             | Tools view                 | Not supported            | Yes       | —             | —                  |
| API Product            | API Definition + Resources | Swagger Console          | Yes       | Yes           | —                  |
| Discovered Gateway API | No                         | Platform Gateway Console | No        | Yes           | —                  |

!!! info "Try It Out availability"
    Interactive consoles are available for all API types. However, **API key generation for invocation is supported only for subscriptionless, deployed, API key-bound, non-discovered APIs**. For other API types, you can use the console manually with your own credentials.

## Limitations

- API Platform changes are reflected in Backstage only after a catalog sync is completed.
- API key generation for invocation is supported only for API key-enabled, deployed, subscriptionless, non-discovered APIs.
- Self-hosted gateways configured from WSO2 API Platform SaaS do not support document viewing or API key generation. Users can access the WSO2 API Platform console for these operations.
- This plugin provides discoverability and visibility only. Creating, modifying, or deleting APIs must be done directly from WSO2 API Platform.
