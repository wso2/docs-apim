# Marketplace Assistant Getting Started Guide

The Marketplace Assistant is a powerful tool provided by API Manager, utilizing AI to chat with your APIs and offer recommendations, moving beyond traditional keyword searches.

[![Marketplace Assistant Landing Page]({{base_path}}/assets/img/get_started/marketplace-assistant.png)]({{base_path}}/assets/img/get_started/marketplace-assistant.png)

Follow the steps below to get started with the Marketplace Assistant:

!!! tip
    If you've previously registered your environment for the [API Chat]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/test-apis-with-apichat), you can skip Step 1 by utilizing the same credentials for the Marketplace Assistant. Otherwise, complete Step 1 to register your on-premise environment.

## Step 1 - Sign in to Choreo

1. Navigate to Choreo using the URL: <a href="https://console.choreo.dev">https://console.choreo.dev</a>.

2. Sign-in to Choreo.

   [![Choreo sign-in options]({{base_path}}/assets/img/observe/sign-in-choreo.png)]({{base_path}}/assets/img/observe/sign-in-choreo.png)

## Step 2 - Register your environment

Follow the instructions below to register your on-premise environment:

1. Click the **Settings** on the bottom left corner.

      [![Settings Menu]({{base_path}}/assets/img/observe/settings-menu.png)]({{base_path}}/assets/img/observe/settings-menu.png)

2. If you are a member of multiple organizations, select the appropriate organization from the top left-hand corner.

3. Select the **On-prem Keys** tab and click **Generate Key**.

      [![On-prem Key]({{base_path}}/assets/img/observe/on-prem-key.png)]({{base_path}}/assets/img/observe/on-prem-key.png)

4. Enter a suitable name for your environment (e.g., dev).

5. Click **Generate**.
6. Copy the key that was generated before closing the dialog box.

## Step 3 - Configure API Manager

To enable the Marketplace Assistant and populate the vector database, the API Manager requires configuration. Follow these steps:

### Configure the deployment.toml

1. The following configuration change must be done in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the `[apim.ai]` config by providing the on-premise token obtained from Step 2. Also, be sure to update the endpoint field as below.

      ```toml
      [apim.ai]
      enable = true
      endpoint = "https://e95488c8-8511-4882-967f-ec3ae2a0f86f-prod.e1-us-east-azure.choreoapis.dev/lgpt/interceptor-service/interceptor-service-be2/v1.0"
      token = "<use token that you generated>"
      ```

2. Restart the API Manager.

## Step 4 - Engage with the Marketplace Assistant

Now that your environment is configured, you're ready to interact with the Marketplace Assistant. Utilize its capabilities to chat with your APIs and receive tailored recommendations.

## What's Next?

Explore the features and functionalities of the Marketplace Assistant to streamline your API management experience further.

## FAQ

### Why is this an experimental feature?

The Marketplace Assistant is considered an experimental feature due to its innovative nature and ongoing development. As with any new technology, there may be unforeseen. challenges or limitations that need to be addressed. By labeling it as experimental, we aim to gather feedback from users, refine the functionality, and improve the overall user experience.

### What are the usage limits?

During the trial period, users are subject to the following usage limits:

- Access to up to 1000 APIs to the vectorDB.
- Limited chat functionality based on the number of tokens used by the language model.

### Why did I lose my chat history after I logged out?

Your chat history will be lost after logging out or after a period of inactivity of 1 hour, as per the design of the application. For security and privacy reasons ensure that your conversations are not accessible to other users. Additionally, you have the option to reset your chat history to address any potential privacy concerns.

### Why does the chat not have the context of the initial interactions?

The language model operates by considering only the last 5 interactions to respond. Therefore, if your conversation extends beyond 5 interactions, the model may not retain the earlier parts of the chat

### Why can't I list a large number of APIs as recommendations?

This is because the assistant is designed to identify the most suitable APIs rather than listing a large number of options. To enhance the recommendation process, we limit the number of APIs provided to the language model as context. This ensures that the assistant suggests more relevant APIs instead of overwhelming the user with every possible option.

### I'm receiving the message "I am not aware of such API" despite the API being listed on the developer portal.

There are a few potential reasons for this

#### Assistant uses only public APIs to provide answers.

- The marketplace assistant is only using public APIs to answer questions. If there is an API, not a public API, the assistant wouldn't be aware of it.

#### You may have configured the marketplace assistant after publishing those APIs.

- APIs are only published to the vector database if the Al features are enabled and the token is configured. If you published the API before configuring the assistant, it might not be in the database, and the assistant wouldn't be aware of it. Re-publishing the API and trying again could resolve this. If you have numerous APIs, there's an option to upload them using the WSO2 API Controller

#### If you've published the API and are still receiving the above response, there could be two reasons:

- The API details may have failed to upload to the vector database due to reasons like network issues.
- The language model may not be responding correctly. Even if the APL is in the database, there's a chance the language model can't understand and answer properly. Trying different prompts may help clarify the issue.

### I am getting this error response: `Apologies for the inconvenience. It appears that the token limit has been exceeded`

This message indicates that the request you made has exceeded the allowed token limit usage. During the trial period, token usage is limited, You have the option to upgrade your subscription plan to access Marketplace Assistant without interruption.

### I am getting this error response: Apologies for the inconvenience. `It appears that your token is invalid or expired. Please provide a valid token or upgrade your subscription plan `

This message suggests that your on-prem key is not valid or it is expired. You can request an extended trial period or you can upgrade your subscription plan so that you can seamlessly use Marketplace Assistant

### I am getting this error response: Apologies for the inconvenience. `It seems that something went wrong with the Marketplace Assistant. Please try again later `

This message signifies that an unexpected error has occurred. It could be due to various reasons such as server issues, network problems, etc. Kindly reach out to the administrator for assistance in resolving the problem,

### What type of questions I can ask from Marketplace Assistant:

You can ask the Marketplace Assistant various questions related to APIs and their functionalities. Some examples include:

- Searching for specific APIs by name or category.
- Requesting recommendations for APIs based on specific use cases or requirements.
- Inquiring about API, endpoints, or usage guidelines.
- Comparing two APIs with their usage and functionalities.

For instance, you can ask questions like:

- I am trying to develop an application where `<Use case description>`. What are APIs you can recommend for me to use?
- What are the APIs you know about `<Topic>`?
- What are the differences between `<APII>` and `<API2>`.

Feel free to ask any questions related to APIs or the functionality of APIs, and the assistant will do its best to provide helpful responses,
if you encounter any issues or have further questions, go to the Issues tab of this GitHub repo [API Manager](https://github.com/wso2/api-manager/issues) and click the New issue button to file a bug report or ask questions.
