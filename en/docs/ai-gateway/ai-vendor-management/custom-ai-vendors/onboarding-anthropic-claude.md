# Onboarding Anthropic's Claude

This guide explains how to integrate WSO2 API Manager with **Claude**, allowing you to access Claude's APIs via API Manager's AI Gateway. It provides step-by-step instructions for configuring Claude as a custom AI Service Provider to effectively manage and track AI API interactions.

1. Login to the Admin Portal
2. Navigate to the **AI/LLM Service Providers** section and click on **Add AI/LLM Service Provider**.

    <div style="text-align: center;">
        <a href="{{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-anthropic-claude/add-ai-vendor.png">
            <img src="{{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-anthropic-claude/add-ai-vendor.png" width="600" />
        </a>
    </div>

3. Fill in the general details for the AI Service Provider as shown below.
    
    <table>
    <colgroup>
    <col />
    <col />
    <col />
    </colgroup>
    <tbody>
    <tr>
    <th colspan="2">Field</th>
    <th>Sample value</th>
    </tr>
    <tr>
    <td colspan="2">Name</td>
    <td>Anthropic Claude</td>
    </tr>
    <tr>
    <td colspan="2">API Version</td>
    <td>1.0.0</td>
    </tr>
    <tr>
    <td colspan="2">Description</td>
    <td>Anthropic Claude LLM Service</td>
    </tr>
    </tbody>
    </table>


4. Enter the LLM configurations as outlined below.

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
    <th colspan="2">Attribute Identifier </th>
    </tr>
    <tr>
    <td colspan="2">Request Model</td>
    <td colspan="2">payload</td>
    <td colspan="2">`$.model`</td>
    </tr>
    <tr>
    <td colspan="2">Response Model</td>
    <td colspan="2">payload</td>
    <td colspan="2">`$.model`</td>
    </tr>
    <tr>
    <td colspan="2">Prompt Token Count</td>
    <td colspan="2">payload</td>
    <td colspan="2">`$.usage.input_tokens`</td>
    </tr>
    <tr>
    <td colspan="2">Completion Token Count</td>
    <td colspan="2">payload</td>
    <td colspan="2">`$.usage.output_tokens`</td>
    </tr>
    <tr>
    <td colspan="2">Total Token Count</td>
    <td colspan="2">payload</td>
    <td colspan="2">`N/A`</td>
    </tr>
    <tr>
    <td colspan="2">Remaining Token Count</td>
    <td colspan="2">header</td>
    <td colspan="2">`anthropic-ratelimit-tokens-remaining`</td>
    </tr>
    </tbody>
    </table>

    Refer the image below for the LLM configuration.

    <div style="text-align: center;">
        <a href="{{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-anthropic-claude/llm-configurations.png">
            <img src="{{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-anthropic-claude/llm-configurations.png" width="500" />
        </a>
    </div>

5. Download the API definition for Anthropic Claude from [Anthropic Claude API Definition]({{base_path}}/assets/attachments/admin/custom-ai-vendors/add-anthropic-claude/claude-api.yaml) and upload it as the API Definition.

    !!! note
         The Anthropic Claude API definition provided above is an unofficial OpenAPI 3.0.0 schema created and shared by the community. Please be aware that this schema may not cover all features of the official API.

6. Configure the authentication configurations by setting the type to `authHeader` and the identifier to `x-api-key`.

    <div style="text-align: center;">
        <a href="{{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-anthropic-claude/auth-header.png">
            <img src="{{base_path}}/assets/img/learn/ai-gateway/custom-ai-vendor/add-anthropic-claude/auth-header.png" width="400" />
        </a>
    </div>

7. Choose the connector type as `default`.

8. Next, you can add any models you prefer. For instance, add `claude-3-5-sonnet-20241022` and press enter. You can always add more models later. This enables you to set up model-based load balancing and failover using Claude's APIs.

9. Finally, click **Add** to integrate Anthropic Claude as an AI Service Provider.

Once added, you'll be able to create and manage AI APIs for Anthropic Claude, allowing you to leverage its capabilities within your applications.
