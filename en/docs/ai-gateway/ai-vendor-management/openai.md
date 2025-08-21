# OpenAI

OpenAI is a **default AI Service Provider** in WSO2 API Manager that allows you to integrate with OpenAI's advanced language models. For more information about OpenAI, see the [OpenAI API Documentation](https://platform.openai.com/docs).

## Configuring OpenAI

### Step 1: Access Configuration

1. Login to the Admin Portal (`https://<hostname>:9443/admin`)
2. Navigate to **AI Service Providers** → **OpenAI**

[![Anthropic Configuration]({{base_path}}/assets/img/learn/ai-gateway/openai-config.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/openai-config.png)

### Step 2: Configure Models

#### Read-Only Configurations

The following configurations are **read-only** and cannot be modified:

<table>
    <thead>
        <tr>
            <th style="width: 30%">Category</th>
            <th style="width: 70%">Fields</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>General Details</strong></td>
            <td>
                • Name<br>
                • API Version<br>
                • Description
            </td>
        </tr>
        <tr>
            <td><strong>LLM Configurations</strong></td>
            <td>
                • Request Model<br>
                • Response Model<br>
                • Prompt Token Count<br>
                • Completion Token Count<br>
                • Total Token Count<br>
                • Remaining Token Count
            </td>
        </tr>
        <tr>
            <td><strong>LLM Provider Auth Configurations</strong></td>
            <td>
                • Auth Type: Header, Query Parameter or Unsecured<br>
                • Auth Type Identifier: Header/Query Parameter Identifier
            </td>
        </tr>
        <tr>
            <td><strong>Connector Type for AI/LLM Service Provider</strong></td>
            <td>
                • Connector Type
            </td>
        </tr>
    </tbody>
</table>

#### Editable Configurations

The following configurations can be updated:

<table>
    <thead>
        <tr>
            <th style="width: 30%">Category</th>
            <th style="width: 70%">Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>API Definition</strong></td>
            <td>AI service provider exposed API definition file</td>
        </tr>
        <tr>
            <td><strong>Model List</strong></td>
            <td>Add the list of models supported by the AI service provider. This list enables you to configure routing strategies within your AI APIs.</td>
        </tr>
    </tbody>
</table>

- By default, the following models are included: `gpt-4o`, `gpt-4o-mini`, and `o3-mini`.
- To add available models supported by OpenAI, type the model name and press enter. 
- This enables model-based load balancing and failover capabilities. For more details, see [Multi-Model Routing Overview]({{base_path}}/ai-gateway/multi-model-routing/overview/).

### Step 3: Save Configuration

Click **Update** to apply your changes.

Once you have saved your changes, the updated OpenAI configuration will be applied and made available for use in your AI APIs, enabling seamless integration with the selected models.
