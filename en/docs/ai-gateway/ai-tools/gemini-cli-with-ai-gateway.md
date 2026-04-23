# Configuring Google Gemini CLI with AI Gateway

It is possible to proxy Google Gemini API calls through WSO2 API Manager using the AI Gateway, enabling tools such as Gemini CLI to access Google Gemini services through the AI Gateway.

By routing requests through the AI Gateway instead of invoking Google Gemini directly, you can apply security, traffic control, and governance policies such as guardrails, rate limiting, and monitoring. The Gateway acts as an intermediary, forwarding requests from Google Gemini CLI to Google Gemini while enforcing these controls.

This section provides step-by-step instructions for proxying Google Gemini API calls through WSO2 API Manager.

---

## Step 0: Prerequisites

Before continuing with the setup, make sure you have the following: 

- [Google Gemini CLI](https://geminicli.com/docs/get-started/installation/) installed  
- A [Gemini API key](https://aistudio.google.com/app/api-keys)

---

## Step 1: Deploy the Google AI API in WSO2 API Manager

1. **Log in to the Publisher Portal**.  
    Navigate to the WSO2 API Manager Publisher portal:  
    `https://<APIM-HOST>:<APIM-PORT>/publisher`

2. **Create a New AI API**.  
    Create a new AI API by selecting **Gemini** as the AI service provider.  
    Configure the remaining settings as required.

3. **Configure the Endpoint**.  
    1. Navigate to **Develop → API Configurations → Endpoints**.
    2. Create a new endpoint or edit the existing production endpoint.
    3. Ensure the following configurations are set:
        - **Endpoint URL**: `https://generativelanguage.googleapis.com`  
        - **API Key**: `<GEMINI API KEY>`

4. **Configure the x-goog-api-key Header**.  
    Gemini CLI sends the API key using the `x-goog-api-key` header. Instead of introducing a custom `ApiKey` header expected by APIM, configure the gateway to accept this existing header:  
      
    1. Navigate to **Develop → API Configurations → Runtime**.
    2. Under **Application Level Security**, set the **ApiKey Header** to:

        ```
        x-goog-api-key
        ```

5. **Deploy and Publish**.  
    Deploy and publish the Google AI API.

---

## Step 2: Obtain an API Key from WSO2 API Manager

1. **Log in to the Developer Portal**.  
    Navigate to the WSO2 API Manager Developer portal:  
    `https://<APIM-HOST>:<APIM-PORT>/devportal`

2. **Select the API**.  
    Select the Google AI API you just published.

3. **Subscribe to the API**.  
    Subscribe to the API using an application of your choice.

4. **Generate and Note the API Key**.  
    Generate an API Key for the application and make sure to save it for later use.

---

## Step 4: Configure Gemini to Use the AI Gateway

Gemini relies entirely on environment variables for configuration.

1. **Open a Terminal**.  
    Open a new terminal session.

2. **Set Environment Variables**.  
    Run the following commands, replacing placeholders with your values:

    ```bash
    export GOOGLE_GEMINI_BASE_URL="<GEMINI AI API EXPOSED URL>"
    export GEMINI_API_KEY="<WSO2 API KEY>"
    ```

    !!! note
        These environment variables must be set in the same session where the Gemini CLI is executed. Alternatively, they can be configured as permanent environment variables.

### Apply Temporary SSL Fix (For Testing Only)

To bypass SSL certificate validation during testing, run:

```bash
export NODE_TLS_REJECT_UNAUTHORIZED=0
```

!!! warning
    This should only be used in development environments.

---

## Step 4: Run the Gemini CLI Client

Execute the Gemini CLI.  

```bash
gemini
```

Requests will now be routed through the WSO2 API Manager AI Gateway.

## Usecase Examples

### View API Analytics and Insights

By routing Gemini CLI requests through the WSO2 API Manager AI Gateway, you automatically gain access to built-in analytics and reporting capabilities.

WSO2 provides integrated analytics, powered by Moesif, and also supports integration with external tools such as the ELK stack (**Elasticsearch**, **Logstash**, **Kibana**) and Choreo Analytics.

The example below shows how Moesif can be used to view analytics on the usage of Google Gemini API

[![gemini cli analytics example]({{base_path}}/assets/img/llm-gateway/gemini-cli-analytics-example.png)]({{base_path}}/assets/img/llm-gateway/gemini-cli-analytics-example.png)

For more information on Analytics, refer to the official [WSO2 API Manager Documentation](https://apim.docs.wso2.com/en/latest/monitoring/api-analytics/analytics-overview/)

---

### Implement WSO2 AI Gateway Guardrails for Enhanced Control

WSO2 API Manager AI Gateway guardrails enable granular control over the data exchanged between Gemini CLI and the Google Gemini API.

By applying guardrails, you can enforce security and compliance policies such as:

- Input validation to ensure prompt integrity  
- Output filtering to prevent leakage of sensitive data  
- Rate limiting to control API usage and avoid cost overruns  

For example, a **Regex Validation Guardrail** can be configured in the request flow to mitigate prompt injection attacks and prevent sensitive data extraction. If a user submits a malicious prompt, the guardrail evaluates the request against defined patterns and blocks it before it reaches the Google Gemini API.

[![gemini cli guardrail example]({{base_path}}/assets/img/llm-gateway/gemini-cli-guardrail-intervened-example.png)]({{base_path}}/assets/img/llm-gateway/gemini-cli-guardrail-intervened-example.png)

For more information on AI Guardrails, refer to the official [WSO2 API Manager Documentation](https://apim.docs.wso2.com/en/latest/ai-gateway/ai-guardrails/overview/)

---

### Rate limiting at AI Gateway

WSO2 API Manager AI Gateway supports request-based and token-based rate limiting for AI APIs. This allows you to control Gemini CLI usage when requests are routed through the Gateway.

For example, you can create an AI subscription policy with a limited request count or total token count, and apply it when subscribing to the Anthropic AI API. Once Gemini CLI invokes the API through that subscription, the Gateway enforces the selected quota automatically. If the configured limit is exceeded, subsequent requests are throttled until the quota resets.

This helps control token consumption and avoid unexpected costs.

The following screenshot illustrates Gemini CLI operating under a minute-level token limit, where requests are delayed until the quota is refreshed.

[![gemini cli rate limit example]({{base_path}}/assets/img/llm-gateway/gemini-cli-rate-limit-example.png)]({{base_path}}/assets/img/llm-gateway/gemini-cli-rate-limit.png)

For more information on Rate Limiting, refer to the official [WSO2 API Manager documentation](https://apim.docs.wso2.com/en/latest/ai-gateway/rate-limiting/)

---

### Multi-Model Routing

WSO2 API Manager AI Gateway supports multi-model routing, allowing you to dynamically route requests to different AI models based on defined conditions or strategies.  

This is useful when working with Gemini CLI in scenarios such as fallback handling, load balancing, or cost optimization. Instead of sending all requests to a single model, the Gateway can intelligently distribute or reroute requests across multiple endpoints.

For example, the following screenshot illustrates Gemini CLI being proxied through WSO2 API Manager AI Gateway, where the user explicitly requests the `gemini-3.1-pro-preview` model. Since this model has exceeded its usage limits, the request fails.

[![gemini cli multi model routing example 1]({{base_path}}/assets/img/llm-gateway/gemini-cli-multi-model-routing-example-1.png)]({{base_path}}/assets/img/llm-gateway/gemini-cli-multi-model-routing-example-1.png)

With Multi-Model Routing configured using a Round Robin strategy across `gemini-2.5-flash-lite` and `gemini-2.5-flash`, the behavior changes. Even though Gemini CLI continues to request the `gemini-3.1-pro-preview` model, the AI Gateway dynamically routes the request to one of the available configured models.
As a result, the request is successfully processed without requiring any changes on the client side.

[![gemini cli multi model routing example 2]({{base_path}}/assets/img/llm-gateway/gemini-cli-multi-model-routing-example-2.png)]({{base_path}}/assets/img/llm-gateway/gemini-cli-multi-model-routing-example-2.png)

For more information on Multi-Model Routing, refer to the official [WSO2 API Manager documentation](https://apim.docs.wso2.com/en/4.7.0/ai-gateway/multi-model-routing/overview/)

---

### Prompt Decorator

WSO2 API Manager AI Gateway supports Prompt Decorators, which allow you to modify or enrich prompts before they are sent to the backend AI provider. This is useful for enforcing consistent instructions, adding system-level context, or guiding model behavior without requiring changes in the client application.

As a simple example, you can configure a Prompt Decorator in the request flow to prepend a system instruction to all incoming prompts:

"You are operating behind an enterprise AI gateway. Follow these rules:\n1. Be concise and direct.\n2. Never output secrets, tokens, or credentials.\n3. When editing code, explain the change briefly.\n4. When unsure, state the assumption explicitly.\n5. At the end of every response, add the text: 'Routed through WSO2 AI Gateway'.\n\n"

Once configured, every request sent from Gemini CLI is automatically modified by the Gateway to include this instruction before being forwarded to the AI provider.

[![gemini cli multi model routing example 2]({{base_path}}/assets/img/llm-gateway/gemini-cli-prompt-decorator-example.png)]({{base_path}}/assets/img/llm-gateway/gemini-cli-prompt-decorator-example.png)

For more information on Prompt Management, refer to the official [WSO2 API Manager documentation](https://apim.docs.wso2.com/en/latest/ai-gateway/prompt-management/overview/)