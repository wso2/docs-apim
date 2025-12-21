# AI Backend Security

Configure backend security for your AI APIs to ensure secure communication with AI service providers. You can skip this step if the AI Service Provider you use does not require authentication.

### Step 1: Get API Key from AI Service Provider

First, get an API Key from the AI Service Provider you selected while creating the AI API. This key is required to authenticate requests and securely connect to the service.

You can do so for OpenAI by following the steps mentioned below:

1. Login in to OpenAI Dashboard <a href='https://platform.openai.com/api-keys'></a>
2. Navigate to the API Keys section from the left menu. Click Create new secret key, provide a name, and click Create secret key.

    [![Get OpenAI API Key]({{base_path}}/assets/img/learn/ai-gateway/openai-api-key-generation.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/openai-api-key-generation.png)


### Step 2: Configure obtained API Key with your AI API

1. Navigate to **API Configurations** --> **Endpoints**.
2. Notice the **API Key Required** warning against the `Default Production Endpoint` and `Default Sandbox Endpoint`. Click on **Edit** icon and fill in the API Key value which you obtained from Step 1 above and click on **Update** to save the changes.

    !!! Note
            API Manager supports below AI Service Providers by default. The authorization approach of each is mentioned below: 
        - **Anthropic**: `x-api-key` header
        - **AWSBedrock**: Requires both an AWS Access Key and AWS Secret Key for authentication.
        - **AzureAIFoundry**: `api-key` header
        - **AzureOpenAI**: `api-key` header
        - **Gemini**: `X-goog-api-key` header
        - **MistralAI**: `Authorization` header
        - **OpenAI**: `Authorization` header

  For MistralAI and OpenAI, "Bearer " is automatically prepended to the value you provide, as these providers expect an Authorization header.

    [![API Key Configuration]({{base_path}}/assets/img/learn/ai-gateway/ai-api-configure-backend-security.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-api-configure-backend-security.png)
