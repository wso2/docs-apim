# Marketplace Assistant Getting Started Guide

The Marketplace Assistant is a powerful tool provided by API Manager, utilizing AI to chat with your APIs and offer recommendations, moving beyond traditional keyword searches. Using this you can access role-restricted APIs in addition to the public APIs defined according to the [developer portal visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/#control-api-visibility-in-the-developer-portal).

[![Marketplace Assistant Landing Page]({{base_path}}/assets/img/get_started/marketplace-assistant.png)]({{base_path}}/assets/img/get_started/marketplace-assistant.png)

Follow the steps below to get started with the Marketplace Assistant:

!!! tip
    If you've previously registered your environment for the [API Chat]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/test-apis-with-apichat), you can skip Step 1 and 2 by utilizing the same credentials for the Marketplace Assistant. Otherwise, complete Step 1 to register your on-premise environment.

## Step 1 - Sign In to AI Subscription Portal

!!! warning
        Information in the AI Subscription Portal will be stored in the United States.

1. Navigate to the AI Subscription Portal using the following URL: <a href="https://ai-subscriptions.wso2.com">https://ai-subscriptions.wso2.com</a>.

2. Register for an Account.

   [![AI Subscription Portal]({{base_path}}/assets/img/observe/ai-subscription-portal.png)]({{base_path}}/assets/img/observe/ai-subscription-portal.png)

   - Click **Register**.
   - Enter a valid email address and click **Register**.
   - Check your email inbox and click **Complete Account Creation**.
   - Provide an organization name (make a note of this, as it will be required for every login) and create a secure password.

3. Log In to the AI Subscription Portal.

   - Click **Sign In** and enter your organization name.
   - Enter your email address and password.

## Step 2 - Create a Key by Subscribing

1. On the main landing page, click **New Subscription**.

      [![AI Subscription Portal Initial Dashboard]({{base_path}}/assets/img/observe/ai-subscription-portal-2.png)]({{base_path}}/assets/img/observe/ai-subscription-portal-2.png)

2. Select **wso2am** as the product, enter an appropriate name, and create the subscription.

    !!! info
        Users can create multiple subscriptions for different on-premises environments and manage them through the portal.

    !!! warning
        Do not use the same key for different environments or products. Each key is used to differentiate environments when accessing AI services.

    [![AI Subscription Portal Dashboard]({{base_path}}/assets/img/observe/ai-subscription-portal-3.png)]({{base_path}}/assets/img/observe/ai-subscription-portal-3.png)

    !!! info
        Users can revoke and regenerate keys for any subscription, as well as delete subscriptions. Please perform these actions with caution, as they will immediately invalidate any existing keys in use.

## Step 3 - Configure API Manager

To enable the Marketplace Assistant and populate the vector database, the API Manager requires configuration. Follow these steps:

### Configure the deployment.toml

1. The following configuration change must be done in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the `[apim.ai]` config by providing the on-premise token obtained from Step 2. Also, be sure to update the endpoint field as below.

      ```toml
      [apim.ai]
      enable = true
      endpoint = "https://dev-tools.wso2.com/apim-ai-service/v2"
      key = "<use key that you generated>"
      token_endpoint = "https://api.asgardeo.io/t/wso2devtools/oauth2/token"
      ```

2. Restart the API Manager.

## Step 4 - Engage with the Marketplace Assistant

Now that your environment is configured, you're ready to interact with the Marketplace Assistant. Utilize its capabilities to chat with your APIs and receive tailored recommendations.

## What's Next?

Explore the features and functionalities of the Marketplace Assistant to streamline your API management experience further.
