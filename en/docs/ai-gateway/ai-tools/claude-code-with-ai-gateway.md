# Configuring Claude Code with AI Gateway

It is possible to proxy Anthropic AI API calls through WSO2 API Manager using the AI Gateway, enabling tools such as Claude Code to access Anthropic services through the AI Gateway.

By routing requests through the AI Gateway instead of invoking Anthropic directly, you can apply security, traffic control, and governance policies such as guardrails, rate limiting, and monitoring. The Gateway acts as an intermediary, forwarding requests from Claude Code to Anthropic while enforcing these controls.

This document provides step-by-step instructions for proxying Anthropic AI API calls through WSO2 API Manager.

## Prerequisites

Before continuing with the setup, make sure you have the following: 

- [Claude Code](https://code.claude.com/docs/en/overview) installed.  
- An [Anthropic API Key](https://platform.claude.com/settings/keys) with sufficient funds.

---

## Step 1: Deploy the Anthropic AI API in WSO2 API Manager

1. **Log in to the Publisher Portal.**  
    Navigate to the WSO2 API Manager Publisher portal:  
    `https://<APIM-HOST>:<APIM-PORT>/publisher`

2. **Create a New AI API.**  
    Create a new AI API by selecting Anthropic as the AI service provider.  
    Configure the remaining settings as required.

3. **Configure the Endpoint**
    1. Navigate to **Develop → API Configurations → Endpoints**.
    2. Create a new endpoint or edit the existing production endpoint.
    3. Ensure the following configurations are set:
        - **Endpoint URL**: `https://api.anthropic.com`  
        - **API Key**: `<CLAUDE API KEY>`

4. Deploy and publish the Anthropic AI API.

---

## Step 2: Obtain an API Key from WSO2 API Manager

1. **Log in to the Developer Portal.** 
    Navigate to the WSO2 API Manager Developer portal:  
    `https://<APIM-HOST>:<APIM-PORT>/devportal`

2. Select the Anthropic AI API you just published.

3. Subscribe to the API using an application of your choice.

4. Generate an API Key for the application and make sure to save it for later use.

---

## Step 3: Configure Claude Code to Use the AI Gateway

1. Open a new terminal (preferably in your working directory).

2. Run the following commands, replacing placeholders with your values:

    ```bash
    export ANTHROPIC_BASE_URL="<ANTHROPIC AI API EXPOSED URL>"
    export ANTHROPIC_AUTH_TOKEN="dummy-value"
    export ANTHROPIC_CUSTOM_HEADERS="ApiKey: <WSO2 API KEY>"
    ```

    !!! Note
        These environment variables apply only to the current terminal session.

    !!! Note "Persistent Configuration"
        
        To make the configuration permanent, add the following to Claude Code’s `settings.json` file:

        - **Location**: `~/.claude/settings.json`  
        - Create the file if it does not exist.

        ```json
        {
            "env": {
                "ANTHROPIC_BASE_URL": "<ANTHROPIC AI API EXPOSED URL>",
                "ANTHROPIC_AUTH_TOKEN": "dummy-value",
                "ANTHROPIC_CUSTOM_HEADERS": "ApiKey: <WSO2 API KEY>"
            }
        }
        ```

        For more information, see [Claude Code's official documentation](https://code.claude.com/docs/en/settings)

### Configure SSL Certificate Trust

When using a local AI Gateway over HTTPS, Claude Code must be able to trust the certificate presented by the Gateway.

!!! note
    If the AI Gateway uses a valid CA-signed certificate, no additional certificate configuration is required.

If the Gateway uses a self-signed certificate, Claude Code may fail to connect due to certificate verification errors. In such cases, add the Gateway certificate to the certificate trust store used by Claude Code before running the client. 

For more information, visit the [Claude Code Official Documentation](https://code.claude.com/docs/en/troubleshoot-install#tls-or-ssl-connection-errors)

!!! note
    This is commonly required when testing with a locally running WSO2 API Manager Gateway.

To bypass SSL certificate validation during testing, run:

```bash
export NODE_TLS_REJECT_UNAUTHORIZED=0
```

---

## Step 4: Run Claude Code

Start Claude Code:

```bash
claude
```

Requests will now be routed through the WSO2 API Manager AI Gateway.

---

## Use case examples

### View API Analytics and Insights

By routing Claude Code requests through the WSO2 API Manager AI Gateway, you automatically gain access to built-in analytics and reporting capabilities.

WSO2 provides integrated analytics, powered by Moesif, and also supports integration with external tools such as the ELK stack (**Elasticsearch**, **Logstash**, **Kibana**) and Choreo Analytics.

For example, an admin could view the token usage by users and applications to identify overuse of the AI Agents.

[![analytics token usage example]({{base_path}}/assets/img/llm-gateway/analytics-token-usage-example.png)]({{base_path}}/assets/img/llm-gateway/analytics-token-usage-example.png)

For more information on Analytics, refer to the official [WSO2 API Manager Documentation](https://apim.docs.wso2.com/en/latest/monitoring/api-analytics/analytics-overview/)

---

### Implement WSO2 AI Gateway Guardrails for Enhanced Control

WSO2 API Manager AI Gateway guardrails enable granular control over the data exchanged between Claude Code and the Anthropic API.

By applying guardrails, you can enforce security and compliance policies such as:

- Input validation to ensure prompt integrity  
- Output filtering to prevent leakage of sensitive data  
- Rate limiting to control API usage and avoid cost overruns  

For example, a **PII Masking Regex Guardrail** can be configured in the request flow to prevent Personally Identifiable Information (PII) from reaching Anthropic API. If a user submits a prompt containing PII, the guardrail evaluates the request against defined patterns and redacts them before they reach Anthropic API.

[![claude code guardrail example]({{base_path}}/assets/img/llm-gateway/claude-code-guardrail-redacted-example.png)]({{base_path}}/assets/img/llm-gateway/claude-code-guardrail-redacted-example.png)

For more information on AI Guardrails, refer to the official [WSO2 API Manager Documentation](https://apim.docs.wso2.com/en/latest/ai-gateway/ai-guardrails/overview/)

---

### Rate limiting at AI Gateway

WSO2 API Manager AI Gateway supports request-based and token-based rate limiting for AI APIs. This allows you to control Claude Code usage when requests are routed through the Gateway.

For example, you can create an AI subscription policy with a limited request count or total token count, and apply it when subscribing to the Anthropic AI API. Once Claude Code invokes the API through that subscription, the Gateway enforces the selected quota automatically. If the configured limit is exceeded, subsequent requests are throttled until the quota resets.

This helps control token consumption and avoid unexpected costs.

[![claude code rate limit example]({{base_path}}/assets/img/llm-gateway/claude-code-rate-limit-example.png)]({{base_path}}/assets/img/llm-gateway/claude-code-rate-limit.png)

For more information on Rate Limiting, refer to the official [WSO2 API Manager documentation](https://apim.docs.wso2.com/en/latest/ai-gateway/rate-limiting/)

### Prompt Decorator

WSO2 API Manager AI Gateway supports Prompt Decorators, which allow you to modify or enrich prompts before they are sent to the backend AI provider. This is useful for enforcing consistent instructions, adding system-level context, or guiding model behavior without requiring changes in the client application.

As a simple example, you can configure a Prompt Decorator in the request flow to prepend a system instruction to all incoming prompts.

The following screenshot shows Claude Code responding to a simple prompt with no Prompt Decorator.

[![claude code prompt decorator example]({{base_path}}/assets/img/llm-gateway/claude-code-prompt-decorator-example.png)]({{base_path}}/assets/img/llm-gateway/claude-code-prompt-decorator-example.png)

The following screenshot shows Claude Code responding to that same prompt with a Prompt Decorator configured to append the following decoration: "Be very concise. Use as little words as possible when answering."

[![claude code prompt decorator example]({{base_path}}/assets/img/llm-gateway/claude-code-prompt-decorator-example-2.png)]({{base_path}}/assets/img/llm-gateway/claude-code-prompt-decorator-example-2.png)


For more information on Prompt Management, refer to the official [WSO2 API Manager documentation](https://apim.docs.wso2.com/en/latest/ai-gateway/prompt-management/overview/)
