# AI-Assisted mock server

!!! tip
    If you've previously registered your environment for the [API Chat]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/test-apis-with-apichat), [Marketplace Assistant]({{base_path}}/consume/discover-apis/marketplace-assistant) or [Design Assistant]({{base_path}}/manage-apis/design/create-api/create-api-with-ai/), you can [skip]({{base_path}}/design/prototype-api/ai-mocked-js-api#step-4-choose-the-ai-assisted-mock-server-as-the-endpoint) step 2, 3 and 4 by utilizing the same credentials for the AI-assisted mock server. Otherwise, complete Step 1 to register your on-premise environment.

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

## Step 4 - Choose the AI-assisted mock server as the endpoint

1. Follow the steps 1 and 2 in [Mock Implementation with API Gateway]({{base_path}}/design/prototype-api/create-mocked-js-api) to implement the API using mock implementation

2. Click on AI-assisted mock server
   
     [![Select AI-assisted mock server]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-ai-choose-behaviour.png)]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-ai-choose-behaviour.png)

3. Wait until the generation is completed.

!!! info
    This feature is currently in the **experimental** stage and is exclusively for REST APIs. If you require any other type of API, regrettably, this feature is not available for use at this moment.

## Step 5 - Add Specific Instructions and Modify the Mock Server

!!! tip
    Previously generated scripts will also be taken into account when modifying scripts with new custom instructions.

1. Add the instructions that need to be provided to the AI when modifying the scripts and click modify.

     [![Add instructions to modify AI-assisted mock scripts of api]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-ai-add-instructions.png)]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-ai-add-instructions.png.png)

2. Wait until the modification is completed.

## Step 6 - Modify Inline Scripts in a specific resource

1. Add instructions to modify the current script of the resource, then click the **Modify** button.

     [![Add instructions to modify AI-assisted mock scripts of resource]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-ai-add-instructions-resource.png)]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-ai-add-instructions-resource.png.png)

2. Wait until the modification is completed.
   
    !!! tip
        To configure latency and error simulations refer part 6 in step 2 of [Create Mock Implementation]({{base_path}}/design/
        prototype-api/create-mocked-js-api#step-2-implement-the-api)
