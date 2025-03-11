# Getting Started with AI Gateway

The AI Gateway in WSO2 API Manager simplifies the integration of AI services into applications by providing a seamless way to manage and expose AI APIs. With built-in support for leading AI vendors such as **OpenAI**, **Mistral**, and **Azure OpenAI**, as well as the flexibility to configure custom AI providers, AI Gateway enables organizations to adopt AI securely and efficiently.

AI Gateway gives you the ability to create AI APIs, which serve as a bridge between your application and AI service providers. These AI APIs allow you to interact with AI models, send requests, and retrieve AI-generated responses.

The following steps guide you through creating an AI API using WSO2 API Manager:

### Step 1: Create an AI API

1. Login to the Publisher Portal (`https://<hostname>:9443/publisher`).

2. Create an **AI/LLM API** by clicking on **Create AI/LLM API**.

    [![Select AI API]({{base_path}}/assets/img/learn/ai-gateway/select-ai-api.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/select-ai-api.png)

3. Select the desired provider and version. Then, click Next.

    [![Select AI Service Provider and Version]({{base_path}}/assets/img/learn/ai-gateway/select-service-provider.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/select-service-provider.png)

    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>The available AI service providers and versions will appear on relevant dropdowns. In addition to the built-in AI service vendors, you can also <a href='{{base_path}}/ai-gateway/ai-vendor-management/custom-ai-vendors/custom-connector'>configure custom AI service vendors</a>.</p>
    </div>

4. Configure AI API details. 
    
    <table><colgroup> <col/> <col/> <col/> </colgroup><tbody><tr><th colspan="2" >Field</th><th >Sample value</th></tr><tr><td colspan="2" class="confluenceTd">Name</td><td class="confluenceTd">MistralAIAPI</td></tr><tr><td colspan="2" class="confluenceTd">Context</td><td class="confluenceTd"><div class="content-wrapper"><p><code>mistralaiapi</code></p><div><div class="confluence-information-macro-body"><p>The API context is used by the Gateway to identify the API. Therefore, the API context must be unique. This context is the API's root context when invoking the API through the Gateway.</p></div><div class="confluence-information-macro confluence-information-macro-tip"><span class="aui-icon aui-icon-small aui-iconfont-approve confluence-information-macro-icon"></span><div class="confluence-information-macro-body"><p>You can define the API's version as a parameter of its context by adding the <code>{version}</code> into the context. For example, <code>{version}/mistralaiapi</code>. The API Manager assigns the actual version of the API to the <code>{version}</code> parameter internally. For example, <code>https://localhost:8243/0.0.2/mistralaiapi</code>. Note that the version appears before the context, allowing you to group your APIs based on the versions.</p></div></div></div></div></td></tr><tr><td colspan="2" class="confluenceTd">Version</td><td colspan="1" class="confluenceTd">0.0.2</td></tr></tr></tbody></table>

5. Click **Create** to create the API.

    The overview page of the newly created API appears. 

### Step 2: Configure Backend Security

Now that the AI API is successfully created, next step is to configure the backend security to ensure AI provider accessibility. You need to attach the **API Key** obtained from the relevant AI provider to the production and sandbox endpoints by navigating to the Endpoints page. For detailed steps, see [AI Backend Security]({{base_path}}/ai-gateway/ai-backend-security/).

### Step 3: Deploy, Test and Publish your AI API

Following the successful AI API creation and backend security configuration, you can proceed to [deploy]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/), [test]({{base_path}}/design/create-api/create-rest-api/test-a-rest-api/), and [publish]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api) the AI API.

### Step 4: Invoke Mistral AI API

1. Login to the Developer Portal (`https://<hostname>:9443/devportal`) and click on the **MistralAIAPI** that you just published.
2. Click **Try Out** in API Overview tab.
3. Click on **Get Test Key** to generate a test key.
4. Expand the `/v1/chat/completions` POST method and click on **Try it out** button.
5. Replace the request body with the following:

    ```json
    {
        "model": "mistral-small-latest",
        "messages": [{"role": "user", "content": "Who is the most renowned French painter?"}]
    }
    ```

6. Note the successful response for the API invocation.

    [![AI API Invocation Success]({{base_path}}/assets/img/learn/ai-gateway/ai-api-invocation-success.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-api-invocation-success.png)

You have now successfully created, deployed, published and invoked an AI API.
