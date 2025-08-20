# AWS Bedrock

AWS Bedrock is a **default Multi Model AI Service Provider** in WSO2 API Manager that allows you to manage multiple AI models from various providers. This guide explains how to configure AWS Bedrock by adding model families (providers) and their associated models within the API Manager. For more information about AWS Bedrock, see the [AWS Bedrock Documentation](https://docs.aws.amazon.com/bedrock/).

## Configuring AWS Bedrock

Follow the steps to set up and customize AWS Bedrock within your API Manager environment.

### Prerequisites

Before configuring AWS Bedrock model families, ensure you have:

1. **AWS Account**: An active AWS account with access to AWS Bedrock
2. **AWS Credentials**: Access key ID and secret access key with Bedrock permissions
3. **AWS Region**: Determine which AWS region you'll use for Bedrock
4. **Model Access**: Request access to the specific models you want to use from each provider

### Step 1: Access AWS Bedrock Configuration

1. Login to the Admin Portal (`https://<hostname>:9443/admin`).
2. Navigate to the **AI Service Providers** section in the left navigation pane.
3. Find **AWSBedrock** in the list of AI Service Providers and click on it to edit the configuration.

### Step 2: Configure Model Providers

The **Model Provider(s)** section allows you to add and configure different AI model providers within AWS Bedrock.

[![AWS Bedrock Configuration]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-config.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-config.png)

#### Adding Model Providers

1. Click the **"+ Add Model Provider"** button to add a new provider family.
2. Configure each provider with the following details:

##### Provider Configuration Fields

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
            <td colspan="2">Provider Name</td>
            <td>Name of the AI provider (e.g., Meta, Anthropic, DeepSeek)</td>
        </tr>
        <tr>
            <td colspan="2">Models</td>
            <td>List of model IDs available from this provider</td>
        </tr>
    </tbody>
</table>

##### Example Provider Configurations

The following are example provider configurations that illustrate how to group models by their provider (model family) and specify the available models for each.

| Provider Name | Example Models                                                                                 |
|---------------|-----------------------------------------------------------------------------------------------|
| Meta          | `us.meta.llama3-3-70b-instruct-v1:0`, `us.meta.llama4-maverick-17b-instruct-v1:0`             |
| DeepSeek      | `us.deepseek.r1-v1:0`                                                                         |
| Anthropic     | `us.anthropic.claude-3-5-sonnet-20240620-v1:0`, `us.anthropic.claude-sonnet-4-20250514-v1:0`  |

You can use these as a starting point and add or remove models as needed based on your AWS Bedrock access and requirements.

AWS Bedrock supports multiple model providers. For a complete and up-to-date list of all supported models, see the [AWS Bedrock Supported Models](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html) documentation.

#### Adding Models to a Provider

1. In the provider configuration, you'll see an input field labeled **Type Model name and press Enter**
2. Type the complete model ID (including the region prefix) and press Enter to add it to the provider
3. You can add or remove individual models as needed to match your requirements.

**Important**: When adding models, make sure to include the region prefix in the model ID. The region prefix should match the AWS region where you have access to that specific model. Always use the prefix for the region in which your model access is granted.

- **us-east-1 region**: Use `us.` prefix
  - Example: `us.anthropic.claude-3-5-sonnet-20240620-v1:0`
  - Example: `us.meta.llama3-3-70b-instruct-v1:0`
  - Example: `us.deepseek.r1-v1:0`

The complete list of model IDs with their region-specific prefixes can be found in the [AWS Bedrock Supported Models](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html) documentation.

### Step 3: Save Configuration

After configuring your model providers:

1. Review all your configurations
2. Click **Update** to apply the changes
3. The AWS Bedrock configuration will be updated for use in AI APIs


## Creating AI API with AWS Bedrock

Once you have configured AWS Bedrock with your model providers in the Admin Portal, you can create AI APIs that utilize these models. This section explains how to create an AI API and configure the AWS Bedrock endpoint.

### Prerequisites

- AWS Bedrock must be configured in the Admin Portal (see [Configuring AWS Bedrock](#configuring-aws-bedrock) above)
- AWS credentials with Bedrock permissions
- Access to the Publisher Portal

### Step 1: Create AI API

For detailed instructions on creating AI APIs with AWS Bedrock, see the [Getting Started with AI Gateway]({{base_path}}/ai-gateway/getting-started-with-ai-gateway/) guide.

### Step 2: Configure AWS Bedrock Endpoint

When creating your AI API, you'll need to configure the AWS Bedrock endpoint with your AWS credentials and region settings.

#### Endpoint Configuration

1. **Navigate to Endpoints**: In your AI API configuration, go to the **Endpoints** section
2. **Select Endpoint Type**: Choose either "Production" or "Sandbox" environment
3. **Configure Endpoint Details**:

[![AWS Bedrock Endpoint Configuration]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-edit-endpoint.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-edit-endpoint.png)


##### Required Endpoint Fields

<table>
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
            <td colspan="2">Endpoint Name</td>
            <td>Name for your endpoint (e.g., "Default Production Endpoint")</td>
        </tr>
        <tr>
            <td colspan="2">Endpoint URL</td>
            <td>AWS Bedrock runtime URL: <code>https://bedrock-runtime.{region}.amazonaws.com</code><br/>Replace <code>{region}</code> with your AWS region</td>
        </tr>
        <tr>
            <td colspan="2">AWS Access Key</td>
            <td>Your AWS access key ID with Bedrock permissions</td>
        </tr>
        <tr>
            <td colspan="2">AWS Secret Key</td>
            <td>Your AWS secret access key with Bedrock permissions</td>
        </tr>
        <tr>
            <td colspan="2">AWS Region</td>
            <td>The AWS region of your Bedrock endpoint (e.g., us-east-1)</td>
        </tr>
    </tbody>
</table>

#### Example Endpoint Configuration

Based on the interface shown in the image, here's how to configure your AWS Bedrock endpoint:

1. **Endpoint Name**: `Default Production Endpoint`
2. **Endpoint URL**: `https://bedrock-runtime.{region}.amazonaws.com`
    - Replace `{region}` with your actual AWS region (e.g., `us-east-1`)
    - Example: `https://bedrock-runtime.us-east-1.amazonaws.com`
    - For detailed information on Amazon Bedrock runtime APIs, refer to the [Amazon Bedrock Runtime API documentation](https://docs.aws.amazon.com/general/latest/gr/bedrock.html).
3. **AWS Access Key**: Enter your AWS access key ID
4. **AWS Secret Key**: Enter your AWS secret access key
5. **AWS Region**: Enter your AWS region (e.g., `us-east-1`)

### Important Notes

- **Region Consistency**: Ensure the region in your endpoint URL matches the region where your AWS Bedrock models are available
- **Model Access**: The region must be one where you have access to the specific models you configured in the Admin Portal
- **Credentials**: Your AWS credentials must have the necessary permissions to access AWS Bedrock services
