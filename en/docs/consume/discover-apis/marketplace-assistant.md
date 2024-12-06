# Marketplace Assistant Getting Started Guide

The Marketplace Assistant is a powerful tool provided by API Manager, utilizing AI to chat with your APIs and offer recommendations, moving beyond traditional keyword searches. Using this you can access role-restricted APIs in addition to the public APIs defined according to the [developer portal visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/#control-api-visibility-in-the-developer-portal).

[![Marketplace Assistant Landing Page]({{base_path}}/assets/img/get_started/marketplace-assistant.png)]({{base_path}}/assets/img/get_started/marketplace-assistant.png)

Follow the steps below to get started with the Marketplace Assistant:

!!! tip
    If you've previously registered your environment for the [API Chat]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/test-apis-with-apichat), you can skip Step 1 and 2 by utilizing the same credentials for the Marketplace Assistant. Otherwise, complete Step 1 to register your on-premise environment.

## Step 1 - Sign in to AI Subscription Portal

!!! warning
        Information in the AI Subscription Portal will be stored in the United States.

1. Navigate to the AI Subscription Portal using the following URL: <a href="https://ai-subscriptions.wso2.com">https://ai-subscriptions.wso2.com</a>.

2. Register for an Account.

   [![AI Subscription Portal]({{base_path}}/assets/img/observe/ai-subscription-portal.png)]({{base_path}}/assets/img/observe/ai-subscription-portal.png)

   - Click **Register**.
   - Enter a valid email address and click **Register**.
   - Check your email inbox and click **Complete Account Creation**.
   - Provide an organization name (make a note of this, as it will be required for every login) and create a secure password.

3. Login to the AI Subscription Portal.

   - Click **Sign In** and enter your organization name.
   - Enter your email address and password.

## Step 2 - Create a key by subscribing

1. On the main landing page, click **New Subscription**.

      [![AI Subscription Portal Initial Dashboard]({{base_path}}/assets/img/observe/ai-subscription-portal-2.png)]({{base_path}}/assets/img/observe/ai-subscription-portal-2.png)

2. Select **wso2am** as the product, enter an appropriate name, and create the subscription.

    !!! info
        Users can create multiple subscriptions for different on-premises environments and manage them through the portal.

    !!! warning
        Do not use the same key for different environments or products. Each key is used to differentiate environments when accessing AI services.

    [![AI Subscription Portal Dashboard]({{base_path}}/assets/img/observe/ai-subscription-portal-3.png)]({{base_path}}/assets/img/observe/ai-subscription-portal-3.png)

    !!! warning
        Users can revoke and regenerate keys for any subscription, as well as delete subscriptions. Please perform these actions with caution, as they will immediately invalidate any existing keys in use.

## Step 3 - Configure API Manager

1. The following configuration change must be done in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the `[apim.ai]` config by providing the on-premise token obtained from Step 2. Also, be sure to update the endpoint field as below.

      ```toml
      [apim.ai]
      enable = true
      endpoint = "https://dev-tools.wso2.com/apim-ai-service/v2"
      key = "<use key that you generated>"
      token_endpoint = "https://api.asgardeo.io/t/wso2devtools/oauth2/token"
      ```

2. Restart the API Manager.

## Step 4 (optional) - Sync vector database with current APIs and API Products

To ensure that the Marketplace Assistant is aware of all published APIs and to update the vector database with the current APIs, you have to upload all APIs and API Products.

For more information, see [AI related operations with apictl]({{base_path}}/install-and-setup/setup/api-controller/ai-related-operations-with-apictl/)

## Step 5 - Engage with the Marketplace Assistant

Now that your environment is configured, you're ready to interact with the Marketplace Assistant. Utilize its capabilities to chat with your APIs and receive tailored recommendations.

## What's Next?

Explore the features and functionalities of the Marketplace Assistant to streamline your API management experience further.

## FAQ

**1. Why is this an experimental feature?**

The Marketplace Assistant is labeled as an experimental feature because it represents innovative technology that is still under development. AI technology is rapidly evolving with significant enhancements in large language models and the introduction of increasingly efficient chips, and we are integrating the latest advancements to enhance our capabilities. Rolling out new features as experimental underscores our commitment to innovation, and as we continue to refine them, we are focused on enhancing their performance and reliability based on user input and ongoing development efforts.

**2. What are the usage limits?**

During the trial period, users are subject to the following usage limits:

- Access to up to 1000 APIs to the vectorDB.
- Limited chat functionality based on the number of tokens used by the language model.

**3. Why did I lose my chat history after I logged out?**

Your chat history will be lost after logging out or after a period of inactivity of 1 hour, as per the design of the application. For security and privacy reasons ensure that your conversations are not accessible to other users. Additionally, you have the option to reset your chat history to address any potential privacy concerns.

**4. Why does the chat not have the context of the initial interactions?**

The language model operates by considering only the last 5 interactions to respond. Therefore, if your conversation extends beyond 5 interactions, the model may not retain the earlier parts of the chat

**5. Why can't I list a large number of APIs as recommendations?**

This is because the assistant is designed to identify the most suitable APIs rather than listing a large number of options. To enhance the recommendation process, we limit the number of APIs provided to the language model as context. This ensures that the assistant suggests more relevant APIs instead of overwhelming the user with every possible option.

**6. I'm receiving the message "I am not aware of such API" despite the API being listed on the developer portal.**

There are a few potential reasons for this

1. Assistant uses only public APIs to provide answers.

    The marketplace assistant is only using public APIs to answer questions. If there is an API, not a public API, the assistant wouldn't be aware of it.

2. You may have configured the marketplace assistant after publishing those APIs.

    APIs are only published to the vector database if the Al features are enabled and the token is configured. If you published the API before configuring the assistant, it might not be in the database, and the assistant wouldn't be aware of it. Re-publishing the API and trying again could resolve this. If you have numerous APIs, there's an option to upload them using the WSO2 API Controller

3. If you've published the API and are still receiving the above response, there could be two reasons:

    - The API details may have failed to upload to the vector database due to reasons like network issues.
    - The language model may not be responding correctly. Even if the APL is in the database, there's a chance the language model can't understand and answer properly. Trying different prompts may help clarify the issue.

**7. I am getting this error response: `Apologies for the inconvenience. It appears that the token limit has been exceeded`**

This message indicates that the request you made has exceeded the allowed token limit usage. During the trial period, token usage is limited, You have the option to upgrade your subscription plan to access Marketplace Assistant without interruption.

**8. I am getting this error response: Apologies for the inconvenience. `It appears that your token is invalid or expired. Please provide a valid token or upgrade your subscription plan `**

This message suggests that your on-prem key is not valid or it is expired. You can request an extended trial period or you can upgrade your subscription plan so that you can seamlessly use Marketplace Assistant

**9. I am getting this error response: Apologies for the inconvenience. `It seems that something went wrong with the Marketplace Assistant. Please try again later `**

This message signifies that an unexpected error has occurred. It could be due to various reasons such as server issues, network problems, etc. Kindly reach out to the administrator for assistance in resolving the problem,

**10. What type of questions I can ask from Marketplace Assistant:**

You can ask the Marketplace Assistant various questions related to APIs and their functionalities. Some examples include:

- Searching for specific APIs by name or category.
- Requesting recommendations for APIs based on specific use cases or requirements.
- Inquiring about API, endpoints, or usage guidelines.
- Comparing two APIs with their usage and functionalities.

For instance, you can ask questions like:

- I am trying to develop an application where `<Use case description>`. What are APIs you can recommend for me to use?
- What are the APIs you know about `<Topic>`?
- What are the differences between `<API1>` and `<API2>`.

Feel free to ask any questions related to APIs or the functionality of APIs, and the assistant will do its best to provide helpful responses,
if you encounter any issues or have further questions, go to the Issues tab of this GitHub repo [API Manager](https://github.com/wso2/api-manager/issues) and click the New issue button to file a bug report or ask questions.

**11. This error message is prompted in the terminal when I use the apictl to upload my APIs: `context deadline exceeded (Client.Timeout exceeded while awaiting headers)`.**

The dafault HTTP request timeout for apictl is 10s. Due to network connnectivity or some other issues, the uploading might exceed this limit. If you encounter this issue you can simply set the timeout to a higher value.

you can modify the `main_config.yaml` file, which you can find in the `APICTL_CONFIG_DIR` and increase the `http_request_timeout` value (Note that the value should be given in milli seconds, e.g: `http_request_timeout: 20000`).
