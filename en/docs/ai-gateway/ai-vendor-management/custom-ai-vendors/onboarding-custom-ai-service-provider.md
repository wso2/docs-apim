# Creating Custom AI Service Providers

This guide explains how to integrate WSO2 API Manager with custom AI service providers, allowing you to access various AI APIs via API Manager's AI Gateway. It provides step-by-step instructions for configuring any AI service provider to effectively manage and track AI API interactions.

## Prerequisites

Before creating a custom AI service provider, ensure you have:

- Access to the Admin Portal
- The API definition (OpenAPI/Swagger specification) for your AI service provider
- Authentication credentials (API key, bearer token, etc.) for the AI service
- Understanding of the AI service's request/response structure

## Steps to Create a Custom AI Service Provider

1. **Login to the Admin Portal**
2. **Navigate to the AI Service Providers section** and click on **Add AI Service Provider**.

    [![Add AI Vendor]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-ai-vendor.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-ai-vendor.png)

3. **Fill in the general details** for the AI Service Provider as shown below.
    
    <table>
    <colgroup>
    <col />
    <col />
    <col />
    </colgroup>
    <tbody>
    <tr>
    <th colspan="2">Field</th>
    <th>Description</th>
    </tr>
    <tr>
    <td colspan="2">Name</td>
    <td>Enter a descriptive name for your AI service provider (e.g., "Custom AI Provider", "My AI Service")</td>
    </tr>
    <tr>
    <td colspan="2">API Version</td>
    <td>Specify the version of your AI service API (e.g., "1.0.0", "v2")</td>
    </tr>
    <tr>
    <td colspan="2">Description</td>
    <td>Provide a brief description of the AI service and its capabilities</td>
    </tr>
    </tbody>
    </table>

4. **Configure Model Provider Type** - Choose between Single Model Provider and Multi Model Provider options:

    - **Single Model Provider**: Use this option when you want to configure a single model for the provider
    - **Multi Model Provider**: Use this option when you want to configure an AI Service with multiple service providers like AWS Bedrock.

    [![Custom AI Vendor Select Provider Type]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/custom-ai-vendor-select-provider-type.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/custom-ai-vendor-select-provider-type.png)


5. **Add Available Models** - Enter the model names supported by your AI service provider. You can add multiple models by typing your model name and pressing enter. This enables model-based load balancing and failover capabilities.

    **For Single Model Provider:**
    - Add the models provided by your AI service provider

    **For Multi Model Provider:**
    - You can add multiple model providers and their associated models

    [![Custom AI Vendor Add Provider Name]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/costom-ai-vendor-add-provider-name.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/costom-ai-vendor-add-provider-name.png)

    > **Important**: Ensure you use the exact model names/IDs as expected by your AI service provider. The model names should match exactly what the provider's API documentation specifies.

5. **Configure LLM configurations** by mapping the AI service's request and response fields. You'll need to specify JSONPath expressions to extract relevant information from the API responses.

    <table>
    <colgroup>
    <col />
    <col />
    <col />
    </colgroup>
    <tbody>
    <tr>
    <th colspan="2">Attribute Name</th>
    <th colspan="2">Input Source </th>
    <th colspan="2">Attribute Identifier (JSONPath)</th>
    </tr>
    <tr>
    <td colspan="2">Request Model</td>
    <td colspan="2">payload</td>
    <td colspan="2">JSONPath to extract model name from request (e.g., `$.model`, `$.parameters.model`)</td>
    </tr>
    <tr>
    <td colspan="2">Response Model</td>
    <td colspan="2">payload</td>
    <td colspan="2">JSONPath to extract model name from response (e.g., `$.model`, `$.model_info.name`)</td>
    </tr>
    <tr>
    <td colspan="2">Prompt Token Count</td>
    <td colspan="2">payload</td>
    <td colspan="2">JSONPath to extract input/prompt token count (e.g., `$.usage.input_tokens`, `$.usage.prompt_tokens`)</td>
    </tr>
    <tr>
    <td colspan="2">Completion Token Count</td>
    <td colspan="2">payload</td>
    <td colspan="2">JSONPath to extract output/completion token count (e.g., `$.usage.output_tokens`, `$.usage.completion_tokens`)</td>
    </tr>
    <tr>
    <td colspan="2">Total Token Count</td>
    <td colspan="2">payload</td>
    <td colspan="2">JSONPath to extract total token count (e.g., `$.usage.total_tokens`, `$.usage.total_tokens`)</td>
    </tr>
    <tr>
    <td colspan="2">Remaining Token Count</td>
    <td colspan="2">header</td>
    <td colspan="2">Header name for remaining tokens (e.g., `x-ratelimit-remaining`, `x-tokens-remaining`)</td>
    </tr>
    </tbody>
    </table>

    !!! tip "JSONPath Examples"
        - `$.model` - Extracts the model field from the root of the JSON
        - `$.usage.input_tokens` - Extracts input tokens from a nested usage object
        - `$.choices[0].message.content` - Extracts content from the first choice in an array
        - `$.data.model` - Extracts model from a nested data object

6. **Upload the API Definition** - Provide the OpenAPI/Swagger specification for your AI service provider. This should be in YAML or JSON format and describe the endpoints, request/response schemas, and authentication methods.

    !!! note
         Ensure your API definition accurately reflects the current version of your AI service provider's API. You may need to create or modify the OpenAPI specification if one is not publicly available.

7. **Configure Authentication** - Set up the authentication method required by your AI service provider:

    **For API Key Authentication:**
    - Type: `authHeader`
    - Identifier: Header name (e.g., `x-api-key`, `authorization`, `api-key`)

    **For Bearer Token Authentication:**
    - Type: `authHeader`
    - Identifier: `authorization`

    **For Custom Authentication:**
    - Type: `authHeader`
    - Identifier: Your custom header name

    [![Custom AI Vendor Auth Header]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/auth-header.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/auth-header.png)

8. **Choose the connector type** as `default`.


9. **Click Add** to integrate your custom AI service provider.

## Next Steps

Once your custom AI service provider is configured:

1. **Create AI APIs** using the configured provider - See [Getting Started with AI Gateway]({{base_path}}/ai-gateway/getting-started-with-ai-gateway/)
2. **Set up rate limiting** and **policies** specific to your AI service - See [Rate Limiting]({{base_path}}/ai-gateway/rate-limiting/) and [API Policies]({{base_path}}/design/api-policies/overview/)
3. **Configure monitoring** and **analytics** to track usage - See [API Analytics]({{base_path}}/api-analytics/choreo-analytics/api-analytics-architecture/)
4. **Test the integration** with sample requests - See [AI Gateway Overview]({{base_path}}/ai-gateway/overview/)
5. **Deploy to production** and manage access through the API Gateway - See [Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/)
