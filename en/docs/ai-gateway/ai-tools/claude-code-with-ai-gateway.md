# Configuring Claude Code with AI Gateway

It is possible to proxy Anthropic AI API calls through WSO2 API Manager using the AI Gateway, enabling tools such as Claude Code to access Anthropic services through the AI Gateway.

By routing requests through the AI Gateway instead of invoking Anthropic directly, you can apply security, traffic control, and governance policies such as guardrails, rate limiting, and monitoring. The Gateway acts as an intermediary, forwarding requests from Claude Code to Anthropic while enforcing these controls.

This document provides step-by-step instructions for proxying Anthropic AI API calls through WSO2 API Manager.

## Step 0: Prerequisites

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

4. **Deploy and Publish**.  
    Deploy and publish the Anthropic AI API.

---

## Step 2: Obtain an API Key from WSO2 API Manager

1. **Log in to the Developer Portal.** 
    Navigate to the WSO2 API Manager Developer portal:  
    `https://<APIM-HOST>:<APIM-PORT>/devportal`

2. **Select the API.**  
    Select the Anthropic AI API you just published.

3. **Subscribe to the API.**. 
    Subscribe to the API using an application of your choice.

4. **Generate and Note the API Key.**  
    Generate an API Key for the application and make sure to save it for later use.

---

## Step 3: Configure Claude Code to Use the AI Gateway

1. **Open a Terminal.**  
    Open a new terminal (preferably in your working directory).

2. **Set Environment Variables.**  
    Run the following commands, replacing placeholders with your values:

    ```bash
    export ANTHROPIC_BASE_URL="<ANTHROPIC AI API EXPOSED URL>"
    export ANTHROPIC_AUTH_TOKEN="dummy-value"
    export ANTHROPIC_CUSTOM_HEADERS="ApiKey: <WSO2 API KEY>"
    ```

    !!! Note
        These environment variables apply only to the current terminal session.

    !!! Note "Persistant Configuration"
        
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

        For more information, see [Claude Code's official documentiation](https://code.claude.com/docs/en/settings)

### Apply Temporary SSL Fix (For Testing Only)

To bypass SSL certificate validation during testing, run:

```bash
export NODE_TLS_REJECT_UNAUTHORIZED=0
```

!!! warning
    This should only be used in development environments.

---

## Run Claude Code

Start Claude Code:

```bash
claude
```

Requests will now be routed through the WSO2 API Manager AI Gateway.

---

## View API Analytics and Insights

By routing Claude Code requests through the WSO2 API Manager AI Gateway, you automatically gain access to built-in analytics and reporting capabilities.

WSO2 provides integrated analytics, powered by Moesif, and also supports integration with external tools such as the ELK stack (**Elasticsearch**, **Logstash**, **Kibana**) and Choreo Analytics.

> *(Insert analytics dashboard screenshot here)*

---

## Implement WSO2 AI Gateway Guardrails for Enhanced Control

WSO2 API Manager AI Gateway guardrails enable granular control over the data exchanged between Claude Code and the Anthropic API.

By applying guardrails, you can enforce security and compliance policies such as:

- Input validation to ensure prompt integrity  
- Output filtering to prevent leakage of sensitive data  
- Rate limiting to control API usage and avoid cost overruns  

For example, a **Regex Validation Guardrail** can be configured in the request flow to mitigate prompt injection attacks and prevent sensitive data extraction. If a user submits a malicious prompt, the guardrail evaluates the request against defined patterns and blocks it before it reaches the Anthropic API.

[![claude code guardrail example]({{base_path}}/assets/img/llm-gateway/claude-code-guardrail-intervened-example.png)]({{base_path}}/assets/img/llm-gateway/claude-code-guardrail-intervened-example.png)

For more information on AI Guardrails, refer to:  
https://apim.docs.wso2.com/en/latest/ai-gateway/ai-guardrails/overview/
