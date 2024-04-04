# Marketplace Assistant Getting Started Guide

The Marketplace Assistant is a powerful tool provided by API Manager, utilizing AI to chat with your APIs and offer recommendations, moving beyond traditional keyword searches.

[![Choreo sign-in options]({{base_path}}/assets/img/get_started/marketplace-assistant.png)]({{base_path}}/assets/img/get_started/marketplace-assistant.png)

To begin using the Assistant, you need to register with Choreo. Follow the steps below to get started with the Marketplace Assistant:

If you've previously registered your environment for the API-Chat, you can utilize the same credentials for the Marketplace Assistant. Otherwise, follow these steps to register your on-premise environment:

## Step 1 - Sign in to Choreo

1. Navigate to Choreo using the following URL.

   <a href="https://console.choreo.dev/?apianalytics=true?utm_source=apim_docs">https://console.choreo.dev</a>.

2. Sign-in to Choreo.

   [![Choreo sign-in options]({{base_path}}/assets/img/observe/sign-in-choreo.png)]({{base_path}}/assets/img/observe/sign-in-choreo.png)

## Step 2 - Register your environment

Follow the instructions below to register your on-premise environment:

1. Click the **Settings** on the bottom left corner.

   [![Settings Menu]({{base_path}}/assets/img/observe/settings-menu.png)]({{base_path}}/assets/img/observe/settings-menu.png)

2. If you are a member of multiple organizations, select the appropriate organization from the top left-hand corner.

   [![Org Selector]({{base_path}}/assets/img/observe/organization-selector.png)]({{base_path}}/assets/img/observe/organization-selector.png)

3. Select the **On-prem Keys** tab and click **Generate Key**.

   [![On-prem Key]({{base_path}}/assets/img/observe/on-prem-key.png)]({{base_path}}/assets/img/observe/on-prem-key.png)

4. Enter a suitable name for your environment (e.g., customer1-dev).

5. Click **Generate**.
6. Copy the key that was generated before closing the dialog box.

## Step 3 - Configure API Manager

To enable the Marketplace Assistant and populate the vector database, the API Manager requires configuration. Follow these steps:

### Configure the deployment.toml

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and update the `[apim.ai]` config segment as follows:

   ```toml
   [apim.ai]
   enable = true
   endpoint = "https://e95488c8-8511-4882-967f-ec3ae2a0f86f-prod.e1-us-east-azure.choreoapis.dev/lgpt/interceptor-service/interceptor-service-be2/v1.0"
   token = "<use token that you generated>"
   ```

2. Enter the on-premise token, which you obtained via the Choreo Portal in the **Register your environment** step, as the Token field.
3. Restart the API Manager.

## Step 4 - Engage with the Marketplace Assistant

Now that your environment is configured, you're ready to interact with the Marketplace Assistant. Utilize its capabilities to chat with your APIs and receive tailored recommendations.

## What's Next?

Explore the features and functionalities of the Marketplace Assistant to streamline your API management experience further.
