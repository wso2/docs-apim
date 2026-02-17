# AWS Bedrock

AWS Bedrock is a **default AI Service Provider** in WSO2 API Manager which has **Multi Model Provider** support that allows you to manage multiple AI models from various providers. This guide explains how to configure AWS Bedrock by adding model families (providers) and their associated models within the API Manager. For more information about AWS Bedrock, see the [AWS Bedrock Documentation](https://docs.aws.amazon.com/bedrock/).
## Configuring AWS Bedrock

Follow the steps to set up and customize AWS Bedrock within your API Manager environment.

### Step 1: Access AWS Bedrock Configuration

1. Login to the Admin Portal (`https://<hostname>:9443/admin`)
2. Navigate to the **AI Service Providers** section in the left navigation pane
3. Find **AWSBedrock** in the list of AI Service Providers and click on it to edit the configuration

### Step 2: Configure Model Providers

The **Model Provider(s)** section allows you to add and configure different AI model providers within AWS Bedrock.

[![AWS Bedrock Configuration]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-config.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-config.png)
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
            <td>Name of the AI provider (e.g., Meta, Anthropic, DeepSeek)</td>
        </tr>
        <tr>
            <td><strong>Models</strong></td>
            <td>List of model IDs available from this provider</td>
        </tr>
    </tbody>
</table>

!!! Note "Add Multiplde Model Providers and models"
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
            <td><strong>Meta</strong></td>
            <td><code>us.meta.llama3-3-70b-instruct-v1:0</code>, <code>us.meta.llama4-maverick-17b-instruct-v1:0</code></td>
        </tr>
        <tr>
            <td><strong>DeepSeek</strong></td>
            <td><code>us.deepseek.r1-v1:0</code></td>
        </tr>
        <tr>
            <td><strong>Anthropic</strong></td>
            <td><code>us.anthropic.claude-3-5-sonnet-20240620-v1:0</code>, <code>us.anthropic.claude-sonnet-4-20250514-v1:0</code></td>
        </tr>
    </tbody>
</table>

You can use these as a starting point and add or remove models as needed based on your AWS Bedrock access and requirements.

AWS Bedrock supports multiple model providers. For a complete and up-to-date list of all supported models, see the [AWS Bedrock Supported Models](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html) documentation.

#### Adding Models to a Provider

1. In the provider configuration, you'll see an input field labeled **Type Model name and press Enter**
2. Type the complete model ID (including the region prefix) and press Enter to add it to the provider
3. **You can add multiple models by typing your model name and pressing enter for each one.** This enables model-based load balancing and failover capabilities within the AI Gateway.
4. You can add or remove individual models as needed to match your requirements

!!! Important
    When adding models, make sure to include the region prefix in the model ID. The region prefix should match the AWS region where you have access to that specific model. Always use the prefix for the region in which your model access is granted.

##### Supported Region Prefixes

- **us-east-1 region**: Use `us.` prefix
  - Example: `us.anthropic.claude-3-5-sonnet-20240620-v1:0`
  - Example: `us.meta.llama3-3-70b-instruct-v1:0`
  - Example: `us.deepseek.r1-v1:0`

The complete list of model IDs with their region-specific prefixes can be found in the [AWS Bedrock Supported Models](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html) documentation.

### Step 3: Save Configuration

After configuring your model providers, click **Update** to apply the changes.

Once you have saved your changes, the updated AWS Bedrock configuration will be applied and made available for use in your AI APIs, enabling seamless integration with the selected models.
