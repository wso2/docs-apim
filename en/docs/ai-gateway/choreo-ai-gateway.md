# Choreo AI Gateway

We recommend the **Choreo AI Gateway**, managed through the **Choreo Agent Control Plane**, for all new AI APIs and MCP Servers.

This page explains what the new AI Gateway is, how it fits with the Agent Control Plane, and how to move existing AI APIs and MCP Servers from the WSO2 API Manager AI Gateway.

## How the two AI Gateways compare

| Aspect | API Manager AI Gateway | Choreo AI Gateway |
|---|---|---|
| Gateway runtime | Synapse based | Envoy based, with policies written in Go |
| Managed from | API Manager Publisher Portal | Agent Control Plane |
| Custom logic | Synapse sequences and Java class mediators | Go policies, plus built-in policies from the Policy Hub |
| Recommended for | Existing deployments | All new AI APIs and MCP Servers |

## The AI Gateway

The Choreo AI Gateway sits between your applications and AI services. It handles traffic for two kinds of workloads.

| Workload | What it does |
|---|---|
| AI APIs (LLM traffic) | Route requests to one or more AI service providers through a single, governed API. |
| MCP Servers | Expose existing APIs as MCP tools for AI agents, or proxy external MCP Servers. |

Key capabilities:

- **Cost control:** Token based rate limits and quotas to stop runaway spend.
- **Provider independence:** Multi provider routing with failover, so you are not locked into one model vendor.
- **Security and guardrails:** Authentication, data masking, and content guardrails on prompts and responses.
- **Observability:** Usage, latency, and error metrics across providers.
- **Extensibility:** Built-in policies from the Policy Hub, and custom policies written in Go.

## The Agent Control Plane

The Choreo Agent Control Plane is where you manage the AI Gateway. You use it to:

- Create and configure AI APIs and MCP Servers
- Connect AI service providers and manage their credentials
- Attach policies and guardrails
- Deploy to one or more AI Gateways and monitor them

## Get started

| Step | Link |
|---|---|
| Set up the AI Gateway and create your first AI API | [Quick start guide](https://wso2.com/api-platform/docs/ai-gateway/1.2.0/quick-start-guide/) |
| Set up the Agent Control Plane | [Agent Control Plane guide](https://wso2.com/api-platform/docs/ai-workspace/1.0.0/getting-started/) |
| Migrate Synapse policies with Agent Skills | Coming soon |

## FAQ

**Is the WSO2 API Manager AI Gateway still supported?**
Yes. It continues to be supported for existing deployments. We recommend the Choreo AI Gateway for new AI APIs and MCP Servers.

**Do I have to migrate?**
No. Migration is optional and has no deadline.

**Can I run both gateways at the same time?**
Yes. You can run both gateways side by side, keeping existing AI APIs on the API Manager AI Gateway while you build new ones on the Choreo AI Gateway. This also lets you test a migrated API before switching traffic to it.
