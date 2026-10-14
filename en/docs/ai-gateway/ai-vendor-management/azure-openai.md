# Azure OpenAI

Azure OpenAI is a **default AI Service Provider** in WSO2 API Manager that provides access to OpenAI's language models through Azure's infrastructure. For more information about Azure OpenAI, see the [Azure OpenAI Documentation](https://learn.microsoft.com/en-us/azure/ai-services/openai/).

## Supported Versions

WSO2 API Manager provides two versions of the Azure OpenAI AI Service Provider. Each version targets a different Azure OpenAI API. Select the version that matches the API your application uses when you create an AI API.

<table>
    <thead>
        <tr>
            <th style="width: 20%">Version</th>
            <th style="width: 30%">Azure OpenAI API</th>
            <th style="width: 50%">Endpoint</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>1.0.0</code></td>
            <td>Chat Completions API</td>
            <td><code>/chat/completions</code></td>
        </tr>
        <tr>
            <td><code>2.0.0</code></td>
            <td>Responses API</td>
            <td><code>/responses</code></td>
        </tr>
    </tbody>
</table>

!!! note
    If your application uses both the Chat Completions API and the Responses API, create a separate AI API for each version.

## Configuring Azure OpenAI

### Step 1: Access Configuration

1. Login to the Admin Portal (`https://<hostname>:9443/admin`)
2. Navigate to **AI Service Providers** → **AzureOpenAI**, and select the version you want to configure (`1.0.0` for Chat Completions or `2.0.0` for Responses). See [Supported Versions](#supported-versions).

[![Azure OpenAI Configuration]({{base_path}}/assets/img/learn/ai-gateway/azure-openai-config.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/azure-openai-config.png)

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
            <td><strong>Connector Type for AI Service Provider</strong></td>
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
- To add available models supported by Azure OpenAI, type the model name and press enter. 
- This enables model-based load balancing and failover capabilities. For more details, see [Multi-Model Routing Overview]({{base_path}}/ai-gateway/multi-model-routing/overview/).

### Step 3: Save Configuration

Click **Update** to apply your changes.

Once you have saved your changes, the updated AzureOpenAI configuration will be applied and made available for use in your AI APIs, enabling seamless integration with the selected models.
