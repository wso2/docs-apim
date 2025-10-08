# Marketplace Assistant Getting Started Guide

The Marketplace Assistant is a powerful tool provided by API Manager, utilizing AI to chat with your APIs and offer recommendations, moving beyond traditional keyword searches. Using this you can access public APIs defined according to the [developer portal visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/#control-api-visibility-in-the-developer-portal).

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
      endpoint = "https://dev-tools.wso2.com/apim-ai-service"
      token = "<use token that you generated>"
      ```

2. Restart the API Manager.

## Step 4 (optional) - Sync vector database with your current APIs and API Products

To ensure that the Marketplace Assistant is aware of all published APIs and to update the vector database with the current APIs, you have to upload all APIs and API Products.

For more information, see [AI Related Operations with apictl]({{base_path}}/install-and-setup/setup/api-controller/ai-related-operations-with-apictl/)

## Step 4 - Engage with the Marketplace Assistant

Now that your environment is configured, you're ready to interact with the Marketplace Assistant. Utilize its capabilities to chat with your APIs and receive tailored recommendations.

## What's Next?

Explore the features and functionalities of the Marketplace Assistant to streamline your API management experience further.

## FAQ

### Why is this an experimental feature?

The Marketplace Assistant is labeled as an experimental feature because it represents innovative technology that is still under development. AI technology is rapidly evolving with significant enhancements in large language models and the introduction of increasingly efficient chips, and we are integrating the latest advancements to enhance our capabilities. Rolling out new features as experimental underscores our commitment to innovation, and as we continue to refine them, we are focused on enhancing their performance and reliability based on user input and ongoing development efforts.

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

### This error message is prompted in the terminal when I use the apictl to upload my APIs: `context deadline exceeded (Client.Timeout exceeded while awaiting headers)`.

The default HTTP request timeout for apictl is 10s. Due to network connectivity or some other issues, the uploading might exceed this limit. If you encounter this issue you can simply set the timeout to a higher value.

you can modify the `main_config.yaml` file, which you can find in the `APICTL_CONFIG_DIR` and increase the `http_request_timeout` value (Note that the value should be given in milli seconds, e.g: `http_request_timeout: 20000`).
