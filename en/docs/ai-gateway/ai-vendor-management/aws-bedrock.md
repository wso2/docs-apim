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
    When adding models, use the model ID exactly as Amazon Bedrock lists it, including any geographic prefix. Such a prefix is part of the identifier of a cross-Region inference profile. It does not name an AWS region, and it does not have to match the region that you invoke Bedrock from.

##### Geographic Inference Profile Prefixes

Model IDs that begin with `us.`, `eu.`, or `apac.` identify [cross-Region inference profiles](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) for the US, EU, and Asia Pacific geographies. Such a profile is invoked from one of its supported source regions and may route the request to any destination region within that geography. For example, `us.` denotes the US geography, not the `us-east-1` region.

- Example: `us.anthropic.claude-3-5-sonnet-20240620-v1:0`
- Example: `us.meta.llama3-3-70b-instruct-v1:0`
- Example: `us.deepseek.r1-v1:0`

Choose a region that AWS lists as a supported source region for the model or inference profile that you intend to use, and configure that same region on the AI API endpoint. For the complete list of identifiers, see [Supported foundation models in Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html) and [Supported Regions and models for inference profiles](https://docs.aws.amazon.com/bedrock/latest/userguide/inference-profiles-support.html).

### Step 3: Save Configuration

After configuring your model providers, click **Update** to apply the changes.

Once you have saved your changes, the updated AWS Bedrock configuration will be applied and made available for use in your AI APIs, enabling seamless integration with the selected models.

## Authentication

Unlike the other default AI service providers, AWS Bedrock is not accessed with a simple API key. Every request to the Bedrock runtime must be signed with [AWS Signature Version 4 (SigV4)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_sigv.html). The Gateway signs each outbound request on your behalf, using the credentials that you configure on the endpoints of your AI API.

Two aspects are configured independently:

- **Credential source** – where the Gateway obtains its base AWS credentials from. This is either **Stored credentials** (an access key and secret key saved with the endpoint) or **Environment credentials**, in which no keys are stored in API Manager and the Gateway resolves them at runtime through the AWS SDK default credential provider chain.
- **STS AssumeRole** – optionally, whether the Gateway exchanges those base credentials for the temporary credentials of an IAM role before signing the request. This can be enabled on top of either credential source.

The following combinations are therefore supported:

<table>
    <thead>
        <tr>
            <th style="width: 25%">Credential Source</th>
            <th style="width: 15%">AssumeRole</th>
            <th style="width: 60%">Behavior</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Stored credentials</strong></td>
            <td>Off</td>
            <td>Requests are signed directly with the stored access key and secret key. This is the default and matches the behavior of earlier releases.</td>
        </tr>
        <tr>
            <td><strong>Stored credentials</strong></td>
            <td>On</td>
            <td>The stored keys are used only to call AWS STS <code>AssumeRole</code>. Requests are signed with the temporary credentials of the assumed role. This suits a base IAM user that holds nothing but <code>sts:AssumeRole</code> permission.</td>
        </tr>
        <tr>
            <td><strong>Environment credentials</strong></td>
            <td>Off</td>
            <td>No keys are stored. The Gateway resolves credentials at runtime through the AWS SDK default credential provider chain, as described in the note below, and signs requests with them.</td>
        </tr>
        <tr>
            <td><strong>Environment credentials</strong></td>
            <td>On</td>
            <td>No keys are stored. The runtime identity is used to call AWS STS <code>AssumeRole</code>, and requests are signed with the temporary credentials of the assumed role.</td>
        </tr>
    </tbody>
</table>

!!! Note "How environment credentials are resolved"
    In environment-credentials mode the Gateway does not read any credentials from the endpoint configuration. It delegates to the [default credential provider chain](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/credentials-chain.html) of the AWS SDK for Java 2.x, which checks the following sources in order and uses the first one that supplies credentials:

    1. **Java system properties** – `aws.accessKeyId`, `aws.secretAccessKey`, and `aws.sessionToken`.
    2. **Environment variables** – `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_SESSION_TOKEN`.
    3. **Web identity token and IAM role ARN** – the token file and role ARN given by `AWS_WEB_IDENTITY_TOKEN_FILE` and `AWS_ROLE_ARN`, which the SDK exchanges for temporary credentials through `sts:AssumeRoleWithWebIdentity`. This is how EKS IAM Roles for Service Accounts (IRSA) supplies credentials.
    4. **The shared `credentials` and `config` files** – `~/.aws/credentials` and `~/.aws/config`, using the profile named by `AWS_PROFILE` when it is set. In a containerized deployment these files must be mounted into the Gateway container to be picked up.
    5. **Amazon ECS container credentials**.
    6. **Amazon EC2 instance metadata** – the instance profile attached to the Gateway node.

    The resolved credentials are cached and refreshed automatically by the SDK, so no credential lookup is performed per request.

!!! Note
    Existing AWS Bedrock endpoints are unaffected by this feature. When no credential source is recorded and no role is configured, the endpoint continues to use its stored access key and secret key exactly as before.

### Step 1: Grant Amazon Bedrock Permissions in AWS

Whichever approach you choose, the identity that ultimately signs the request must be permitted to invoke the models that you configured above.

1. Log in to the [AWS Management Console](https://console.aws.amazon.com/) and navigate to the **IAM** service.
2. Attach a policy granting the required Amazon Bedrock permissions, such as `bedrock:InvokeModel` and `bedrock:InvokeModelWithResponseStream`, to the identity that will invoke Bedrock. For more information, see [Identity and access management for Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/security-iam.html).

   - **Stored credentials** – create (or select) an IAM user, attach the policy to it, create an access key, and note down the **Access Key ID** and **Secret Access Key**.
   - **Environment credentials** – attach the policy to the identity that the Gateway's runtime resolves from the provider chain, for example the EC2 instance profile, the EKS service account role (IRSA), or the IAM user behind the shared profile.
   - **STS AssumeRole** – attach the Amazon Bedrock policy to the role that is going to be assumed. The base identity does not need Bedrock permissions of its own, but assuming the role requires permissions on both sides. The base identity needs an **identity policy** that allows `sts:AssumeRole` on the target role ARN, and the target role needs a **trust policy** that lists the base identity as a trusted principal. The base identity is the IAM user of the stored keys in stored-credentials mode, or the identity resolved from the provider chain in environment-credentials mode. If you intend to use an external ID, the trust policy must also require the same value that you configure on the endpoint. Both sides are mandatory when the target role belongs to a different AWS account; within the same account the trust policy alone is sufficient if it names the base identity explicitly, but granting `sts:AssumeRole` on the base identity as well keeps the configuration valid in either case. For more information, see [Using an IAM role to grant permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html).
3. Note down the **AWS region** from which the Gateway will invoke Bedrock (for example, `us-east-1`). It must be a region that supports the models or inference profiles that you configured, and the same region must be used in both the endpoint URL and the **AWS Region** field, because that is the region the request signature is computed for.

!!! Important
    - Make sure that access has been requested and granted for each of the models that you configured under the model providers. For more information, see [Access Amazon Bedrock foundation models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html).
    - A model ID that begins with a geographic prefix such as `us.`, `eu.`, or `apac.` identifies a [cross-Region inference profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html), not a literal AWS region. For example, `us.` does not mean `us-east-1`. Such a profile is invoked from one of its supported source regions and may route the request to any of its destination regions, so select a supported source region for the model or profile and verify its destination regions. For more information, see [Supported Regions and models for inference profiles](https://docs.aws.amazon.com/bedrock/latest/userguide/inference-profiles-support.html).
    - Invoking through an inference profile needs broader permissions than invoking a single model. The identity that signs the request must be allowed to call `bedrock:InvokeModel` on both the inference profile resource (`arn:aws:bedrock:*:*:inference-profile/*`) and the underlying foundation models (`arn:aws:bedrock:*::foundation-model/*`), in the source region and in every destination region that the profile can route to. If your organization applies service control policies (SCPs) or region restrictions, they must allow all of the profile's destination regions, otherwise a routed request is denied even though the source region is permitted. For more information, see [Prerequisites for inference profiles](https://docs.aws.amazon.com/bedrock/latest/userguide/inference-profiles-prereq.html).

### Step 2: Configure Authentication on the AI API Endpoints

1. Sign in to the Publisher Portal (`https://<hostname>:9443/publisher`) and open the AI API that uses **AWSBedrock** as its AI service provider.
2. Navigate to **API Configurations** --> **Endpoints**.
3. Click the **Edit** icon of the endpoint that you want to configure, and make sure the **Endpoint URL** points at the Bedrock runtime, replacing the `{region}` placeholder in `https://bedrock-runtime.{region}.amazonaws.com` with your AWS region.
4. Select the **Credential Source** and fill in the corresponding fields:

   <table>
        <thead>
            <tr>
                <th style="width: 30%">Field</th>
                <th style="width: 70%">Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Stored credentials</strong></td>
                <td>Select this to sign requests with an access key and secret key saved against the endpoint. The <strong>AWS Access Key</strong> and <strong>AWS Secret Key</strong> fields are displayed and are both mandatory.</td>
            </tr>
            <tr>
                <td><strong>Environment credentials</strong></td>
                <td>Select this to resolve credentials from the Gateway's runtime instead of storing any keys. The <strong>AWS Access Key</strong> and <strong>AWS Secret Key</strong> fields are hidden and are not required.</td>
            </tr>
            <tr>
                <td><strong>AWS Region</strong></td>
                <td>The AWS region in which your Amazon Bedrock model access is granted (for example, <code>us-east-1</code>). This is mandatory for every credential source.</td>
            </tr>
        </tbody>
    </table>

   [![AWS Bedrock Stored Credentials]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-stored-credentials.png){: style="width:100%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-stored-credentials.png)

   [![AWS Bedrock Environment Credentials]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-environment-credentials.png){: style="width:100%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-environment-credentials.png)
5. Optionally, select **Enable STS AssumeRole** to sign requests with the temporary credentials of an IAM role, and provide the following:

   <table>
        <thead>
            <tr>
                <th style="width: 30%">Field</th>
                <th style="width: 70%">Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>Role ARN</strong></td>
                <td>The ARN of the IAM role to assume, for example <code>arn:aws:iam::123456789012:role/bedrock-invoke-role</code>. Mandatory when AssumeRole is enabled.</td>
            </tr>
            <tr>
                <td><strong>Role Region</strong></td>
                <td>The region of the AWS STS endpoint used to assume the role, selected from the list of AWS regions. Mandatory when AssumeRole is enabled.</td>
            </tr>
            <tr>
                <td><strong>External ID</strong></td>
                <td>Optional. The external ID expected by the role's trust policy. Provide this only if the trust policy requires it.</td>
            </tr>
        </tbody>
    </table>

   [![AWS Bedrock STS AssumeRole]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-assume-role.png){: style="width:100%"}]({{base_path}}/assets/img/learn/ai-gateway/aws-bedrock-assume-role.png)
6. Click **Update** to save the changes.
7. Repeat the above steps for the other endpoint (production or sandbox) as required, and then **Save and re-deploy the API** for the changes to take effect.

!!! Note
    - In environment-credentials mode the **AWS Access Key** and **AWS Secret Key** are not persisted with the endpoint, and any previously stored secret key is removed from the endpoint configuration when you save.
    - When AssumeRole is enabled, the **Role ARN**, **Role Region**, and **External ID** are stored in the endpoint configuration as plain text, and are returned to the Publisher when you reopen the endpoint. Unlike the AWS Secret Key, the External ID is neither encrypted nor masked in the UI. Its protection comes from the target role's trust policy requiring the value, not from keeping the value confidential. For more information, see [How to use an external ID](https://docs.aws.amazon.com/IAM/latest/UserGuide/confused-deputy.html).

For more information on securing the backend of AI APIs, see [AI Backend Security]({{base_path}}/ai-gateway/ai-backend-security/).
