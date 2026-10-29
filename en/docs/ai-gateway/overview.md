# AI Gateway

<div class="ai-recommendation-banner">
    We recommend the <strong>WSO2 API Platform AI Gateway</strong>, with <strong>WSO2 AI Workspace</strong> as its control plane, for all new AI APIs and MCP Servers. See <a href="https://wso2.com/api-platform/docs/ai-gateway/1.2.0/quick-start-guide/">Get started with WSO2 AI Gateway</a>.
</div>

As AI adoption accelerates, managing AI APIs effectively has become essential for organizations integrating AI into their applications. WSO2 API Manager's **AI Gateway** simplifies this process, providing a seamless way to create, manage, and expose AI APIs with robust security and scalability.

[![AI Gateway]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.png)

WSO2 API Manager offers built-in support for **OpenAI**, **Azure OpenAI**, and **Mistral**, while also allowing the configuration of custom AI vendors, enabling flexible AI API creation.

With a comprehensive set of capabilities, the AI Gateway ensures secure and efficient AI integration. Key features include:

- **AI API Creation**: Create AI APIs by selecting an AI vendor and version.

- **AI Vendor Key Configuration**: Securely authenticate AI APIs by configuring API keys obtained from the AI vendor.

- **Rate Limiting**: Protect AI backends by enforcing token-based rate limits to manage resource consumption.

- **Multi-Model Routing**: Dynamically route AI API requests across multiple models within a vendor for optimized performance.

- **AI Vendor Management**: Manage both default and custom AI vendors to streamline AI API administration.

- **AI API Observability**: Track AI API usage statistics using [Analytics]({{base_path}}/monitoring/api-analytics/choreo-analytics/api-analytics-architecture/) solutions.

By leveraging these capabilities, organizations can efficiently integrate, monitor, and scale AI APIs, unlocking the full potential of AI-driven applications.

## Limitations

Streaming is not supported for AI APIs when using the **WSO2 API Manager Universal Gateway**.
