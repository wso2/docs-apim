# Create an AI API

AI APIs enable seamless integration of AI services into applications through the WSO2 API Manager. By using the AI API feature, users can select specific AI vendors that best suit their needs. WSO2 API Manager provides built-in support for leading AI vendors like **OpenAI**, **Azure OpenAI**, and **Mistral**, while also allowing configuration of custom AI vendors to create AI APIs.

This guide will get you started with AI API creation using WSO2 API Manager. Thus created AI API wil be deployed into the AI Gateway. Refer to [AI Gateway]({{base_path}}/ai-gateway/overview/) to get a deeper understanding on API Manager's AI Gateway capabilities.

Follow the instructions below to create an AI API using the basic flow:

### Step 1: Create an AI API

1. Login to the Publisher Portal (`https://<hostname>:9443/publisher`).

2. Create an **AI/LLM API** by clicking on **Create AI/LLM API**.

    [![Select AI API]({{base_path}}/assets/img/learn/ai-gateway/select-ai-api.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/select-ai-api.png)

3. Select the desired provider and version. Then, click Next.

    [![Select AI Service Provider and Version]({{base_path}}/assets/img/learn/ai-gateway/select-service-provider.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/select-service-provider.png)

    <div class="admonition tip">
        <p class="admonition-title">Tip</p>
        <p>The built-in AI service providers and versions will appear on relevant dropdowns. In addition to the default vendors, you can add custom AI vendors by following the <a href='{{base_path}}/ai-gateway/ai-vendor-management/custom-ai-vendors/overview'>custom AI vendor integration</a> documentation.</p>
    </div>

4. Fill in the AI API details and click **Create**.
    
    <table>
        <colgroup>
            <col/>
            <col/>
            <col/>
        </colgroup>
        <tbody>
            <tr>
                <th colspan="2">Field</th>
                <th>Sample value</th>
            </tr>
            <tr>
                <td colspan="2" class="confluenceTd">Name</td>
                <td class="confluenceTd">OpenAIAPI</td>
            </tr>
            <tr>
                <td colspan="2" class="confluenceTd">Context</td>
                <td class="confluenceTd">
                    <div class="content-wrapper">
                        <p><code>openaiapi</code></p>
                        <div>
                            <div class="confluence-information-macro-body">
                                <p>
                                    The API context is used by the Gateway to identify the API. 
                                    Therefore, the API context must be unique. This context is the 
                                    API's root context when invoking the API through the Gateway.
                                </p>
                            </div>
                            <div class="confluence-information-macro confluence-information-macro-tip">
                                <span class="aui-icon aui-icon-small aui-iconfont-approve confluence-information-macro-icon"></span>
                                <div class="confluence-information-macro-body">
                                    <p>
                                        You can define the API's version as a parameter of its context 
                                        by adding the <code>{version}</code> into the context. 
                                        For example, <code>{version}/openaiapi</code>. 
                                        The API Manager assigns the actual version of the API to the 
                                        <code>{version}</code> parameter internally. 
                                        For example, <code>https://localhost:8243/2.3.0/openaiapi</code>. 
                                        Note that the version appears before the context, allowing you 
                                        to group your APIs based on the versions.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="confluenceTd">Version</td>
                <td class="confluenceTd">2.3.0</td>
            </tr>
        </tbody>
    </table>

    [![Create OpenAI API]({{base_path}}/assets/img/learn/ai-gateway/create-openai-api.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/create-openai-api.png)

    The overview page of the newly created API appears.

### Step 2: Obtain API Key from AI Service Vendor

1. Login to OpenAI and go to <a href='https://platform.openai.com/api-keys'>OpenAI Dashboard.</a>
2. Navigate to **API keys** section from the left menu. Then, click on **Create new secret key**. Provide a name for the key and click on **Create secret key**.

    [![Get OpenAI API Key]({{base_path}}/assets/img/learn/ai-gateway/openai-api-key-generation.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/openai-api-key-generation.png)

### Step 3: Configure Sandbox and Production Endpoint

1. Navigate to **API Configurations** --> **Endpoints**.
2. Notice the **API Key Required** warning against the `Default Production Endpoint` and `Default Sandbox Endpoint`. Click on **Edit** icon and fill in the API Key value which you obtained from Step 1 above and click on **Update** to save the changes.

    !!! Note
            API Manager supports three AI/LLM vendors by default. The authorization approach of each is mentioned below: 
        - **MistralAI**: `Authorization` header
        - **AzureOpenAI**: `api-key` header
        - **OpenAI**: `Authorization` header

        Note that we prepend "Bearer " to the header value that you provide when it comes to MistralAI and OpenAI since they are expecting an Authorization header.

    [![API Key Configuration]({{base_path}}/assets/img/learn/ai-gateway/ai-api-configure-backend-security.png){: style="width:90%"}]({{base_path}}/assets/img/learn/ai-gateway/ai-api-configure-backend-security.png)

Now, you have successfully created an AI API. Next, [deploy the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/), [test the API]({{base_path}}/design/create-api/create-rest-api/test-a-rest-api/), and finally [publish the API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api).

## See Also

Learn more on the concepts that you need to know when creating a REST API:

-   [API Security]({{base_path}}/design/api-security/api-authentication/secure-apis-using-oauth2-tokens/)
-   [Rate Limiting for AI APIs]({{base_path}}/ai-gateway/rate-limiting/)
-   [Multi-Model Routing]({{base_path}}/ai-gateway/multi-model-routing/overview/)
-   [Life Cycle Management]({{base_path}}/design/lifecycle-management/api-lifecycle/)
-   [API Visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/)
-   [API Documentation]({{base_path}}/design/api-documentation/add-api-documentation/)
-   [Custom Properties]({{base_path}}/design/create-api/adding-custom-properties-to-apis/)
