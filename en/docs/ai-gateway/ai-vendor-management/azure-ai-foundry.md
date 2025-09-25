# Azure AI Foundry

Azure AI Foundry is a **default AI Service Provider** in WSO2 API Manager which has **Multi Model Provider** support that allows you to manage multiple AI models from various providers. This guide explains how to configure Azure AI Foundry by adding model families (providers) and their associated models within the API Manager. For more information about Azure AI Foundry, see the [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/).

## Configuring Azure AI Foundry

Follow the steps to set up and customize Azure AI Foundry within your API Manager environment.

### Step 1: Access Azure AI Foundry Configuration

1. Login to the Admin Portal (`https://<hostname>:9443/admin`)
2. Navigate to the **AI Service Providers** section in the left navigation pane
3. Find **AzureAIFoundry** in the list of AI Service Providers and click on it to edit the configuration

### Step 2: Configure Model Providers

The **Model Provider(s)** section allows you to add and configure different AI model providers within Azure AI Foundry.

[![Azure AI Foundry Configuration]({{base_path}}/assets/img/learn/ai-gateway/azure-ai-foundry-config.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/azure-ai-foundry-config.png)
#### Adding Model Providers

1. Click the **"+ Add Model Provider"** button to add a new provider family
2. Configure each provider with the following details:

##### Provider Configuration Fields

<table>
    <thead>
        <tr>
            <th style="width: 30%">Field</th>
            <th style="width: 70%">Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Provider Name</strong></td>
            <td>Name of the AI provider (e.g., Azure OpenAI, Cohere, xAI)</td>
        </tr>
        <tr>
            <td><strong>Models</strong></td>
            <td>List of model deployment names available from this provider</td>
        </tr>
    </tbody>
</table>

!!! Note "Add Multiple Model Providers and models"
    Adding multiple models under a provider allows you to use advanced routing strategies such as failover, load balancing, and other traffic management options. You can configure these routing policies when creating AI APIs to control how requests are distributed among the available models. For more details, see [Multi-Model Routing Overview]({{base_path}}/ai-gateway/multi-model-routing/overview/).

##### Example Provider Configurations

The following are example provider configurations that illustrate how to group models by their provider (model family) and specify the available models for each.

<table>
    <thead>
        <tr>
            <th style="width: 30%">Provider Name</th>
            <th style="width: 70%">Example Models</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Azure OpenAI</strong></td>
            <td><code>gpt-4o</code>, <code>gpt-4o-mini</code>, <code>o3-mini</code></td>
        </tr>
        <tr>
            <td><strong>Cohere</strong></td>
            <td><code>cohere-command-a</code></td>
        </tr>
        <tr>
            <td><strong>xAI</strong></td>
            <td><code>grok-3</code>, <code>grok-3-mini</code></td>
        </tr>
    </tbody>
</table>

You can use these as a starting point and add or remove models as needed based on your Azure AI Foundry access and requirements.

Azure AI Foundry supports multiple model providers. For a complete and up-to-date list of all supported models, see the [Azure AI Foundry Supported Models](https://ai.azure.com/catalog/models) documentation.

#### Adding Models to a Provider

1. In the provider configuration, you'll see an input field labeled **Type Model name and press Enter**
2. Type the complete model name and press Enter to add it to the provider
3. **You can add multiple models by typing your model name and pressing enter for each one.** This enables model-based load balancing and failover capabilities within the AI Gateway.
4. You can add or remove individual models as needed to match your requirements

### Step 3: Save Configuration

After configuring your model providers, click **Update** to apply the changes.

Once you have saved your changes, the updated Azure AI Foundry configuration will be applied and made available for use in your AI APIs, enabling seamless integration with the selected models.
