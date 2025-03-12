# AI Backend Security

To ensure secure communication with AI service providers, WSO2 API Manager allows you to configure backend security for AI APIs. This involves obtaining an **API Key** from the AI vendor and configuring it within the API Manager's Endpoints page.

### Step 1: Get API Key from AI Vendor

The first step is to obtain an **API Key** from the AI vendor you selected while creating the AI API. This key is required to authenticate requests and securely connect to the AI service.

You can do so for Mistral AI by following the steps mentioned below:

1. Login to **Mistral AI** and go to **<a href='https://console.mistral.ai/'>Mistral AI Console.</a>**
2. Navigate to **API Keys** section from the left menu. Then, click on **Create new key**.

    [![Get Mistral API Key]({{base_path}}/assets/img/learn/mistral-api-key.png){: style="width:90%"}]({{base_path}}/assets/img/learn/mistral-api-key.png)


### Step 2: Configure API Key

1. Navigate to **API Configurations**, and click **Endpoints**.
2. Notice the **API Key Required** warning against the `Default Production Endpoint` and `Default Sandbox Endpoint`. Click on **Edit** icon and fill in the API Key value which you obtained from Step 1 above and click on **Update** to save the changes.

    [![API Key Configuration]({{base_path}}/assets/img/learn/ai-gateway/ai-api-configure-backend-security.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-api-condifure-backend-security.png)

    !!! Note
            API Manager supports three AI/LLM vendors by default. The authorization approach of each is mentioned below: 
        - **MistralAI**: `Authorization` header
        - **AzureOpenAI**: `api-key` header
        - **OpenAI**: `Authorization` header

        Note that we prepend "Bearer " to the header value that you provide when it comes to MistralAI and OpenAI since they are expecting an Authorization header.
