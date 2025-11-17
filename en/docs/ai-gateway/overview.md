# AI Gateway

As AI adoption accelerates, managing AI APIs effectively has become essential for organizations integrating AI into their applications. WSO2 API Manager's **AI Gateway** simplifies this process, providing a seamless way to create, manage, and expose AI APIs with robust security and scalability.

[![AI Gateway]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.webp){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-gateway.webp)

WSO2 API Manager offers built-in support for **Anthropic**, **AWS Bedrock**, **Azure AI Foundry**, **Azure OpenAI**, **Gemini**, **Mistral**, and **OpenAI**, while also allowing the configuration of custom AI Service Providers, enabling flexible AI API creation.

With a comprehensive set of capabilities, the AI Gateway ensures secure and efficient AI integration. Key features include:

- **AI API Creation**: Create AI APIs by selecting an AI Service Provider and version.

- **AI Service Provider Key Configuration**: Securely authenticate AI APIs by configuring API keys obtained from the AI Service Provider.

- **Rate Limiting**: Protect AI backends by enforcing token-based rate limits to manage resource consumption.

- **Multi-Model Routing**: Dynamically route AI API requests across multiple models within a Service Provider for optimized performance.

- **Prompt Management**: Centrally author, version, and reuse prompts and templates; apply decorators to enrich or standardize prompts. Learn more in [Prompt Management]({{base_path}}/ai-gateway/prompt-management/overview/).

- **AI Guardrails**: Enforce safety and policy controls on inputs and outputs using provider-native and custom guardrails (regex, JSON schema, content safety, and more). See [AI Guardrails]({{base_path}}/ai-gateway/ai-guardrails/overview/).

- **Semantic Caching**: Reduce latency and cost by serving semantically similar responses via embedding-based cache with similarity thresholds and TTLs. See [Semantic Caching]({{base_path}}/ai-gateway/semantic-caching/).

- **AI Service Provider Management**: Manage both default and custom AI Service Providers to streamline AI API administration.

- **AI API Observability**: Track AI API usage statistics using [Analytics]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-integration-guide/) solutions.


By leveraging these capabilities, organizations can efficiently integrate, monitor, and scale AI APIs, unlocking the full potential of AI-driven applications.
