# Test APIs with API Chat

Testing APIs is an essential step in the API development lifecycle. API Manager simplifies the testing task by allowing you to engage with your APIs using natural language through API Chat. It eliminates manual test scenario creation, payload mocking, etc. It enables easy API communication using human language and requires no coding for handling sequences with multiple resource calls. This makes your API testing efficient and user-friendly.

!!! info
    This feature is currently in the **experimental** stage and is exclusively accessible for REST APIs with OpenAPI V3.0.x definitions. If your APIs are defined using Swagger or OpenAPI V3.1.x specifications, regrettably, this feature is not available for use at this moment.

Follow the steps below to test your API with API Chat:

!!! tip
    If you've previously registered your environment for the [Marketplace Assistant]({{base_path}}/consume/discover-apis/marketplace-assistant), you can skip Step 1 and 2 by utilizing the same credentials for the API Chat. Otherwise, complete Step 1 and 2 to generate the credentials.

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

1. The following configuration change must be done in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the `[apim.ai]` config by providing the on-premise token obtained from Step 2. Also, be sure to update the endpoint field as below.

      ```toml
      [apim.ai]
      enable = true
      endpoint = "https://dev-tools.wso2.com/apim-ai-service/v2"
      key = "<use key that you generated>"
      token_endpoint = "https://api.asgardeo.io/t/wso2devtools/oauth2/token"
      ```

2. Restart the API Manager.

## Step 4 - Test your APIs

Now we can begin testing APIs. Note that this guide covers the API Chat capabilties using the `PizzaShack` REST API, which was created in [Create a REST API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).

1.  Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`) and click on the API that you need to test (e.g., `PizzaShack`).

2.  Subscribe to the API (e.g., `PizzaShackAPI` 1.0.0) using an application and an available throttling policy.

    [![Subscribe to an API]({{base_path}}/assets/img/learn/subscribe-to-api.png)]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3. Next, generate either a production key or a sandbox key using one of the following actions. You have to scroll down and click **Generate Keys**.

    [![Generate production keys]({{base_path}}/assets/img/learn/generate-application-keys.png)]({{base_path}}/assets/img/learn/generate-application-keys.png)

4. Optionally, click on **Generate Access Token** and copy the generated token.

5.  Now visit the **API Chat** tab under the **Try Out** section. Since the API Chat will test your API based on your natural language query, it needs access to the API. As per the warning shown below, we need to provide an API access token. Either click on the link given in the banner or click **CONFIGURE KEY** to generate one.

    [![API Chat Landing Page]({{base_path}}/assets/img/get_started/api-chat.png)]({{base_path}}/assets/img/get_started/api-chat.png)

6.  Enter the copied access token in the **Authorization** field or click on **GET TEST KEY**.

    [![Add Access Token]({{base_path}}/assets/img/get_started/api-chat-access-token.png)]({{base_path}}/assets/img/get_started/api-chat-access-token.png)

    !!! tip

         TEST KEY will be generated with default scopes. If you need to generate a token with specific scopes, go to the application view and generate a token.

7. Now you can enter your query in natural language and execute it.
    
     Note that we provide some samples that you can try. They cover the following 3 scenarios:

      I. Invoke all resources of the API

      II. Invoke a single resource of the API
      
      III. Invoke an action involving multiple resources
   
    Let's provide our own query for this guide: _First get me the menu. Then, create a new Order with customerName 'John Smith', pizzaType 'Pepperoni', and quantity 2. Then update the same Order and change the pizzaType to 'Margherita'._

    [![API Chat Query]({{base_path}}/assets/img/get_started/api-chat-query.png)]({{base_path}}/assets/img/get_started/api-chat-query.png)

8. Let's analyse the result from API Chat. As shown below, 3 resources were invoked sequentially. Namely:

    GET &rarr; Retrieval of the menu

    POST &rarr; Placing a new order

    PUT &rarr; Updating the order

    [![API Chat Response]({{base_path}}/assets/img/get_started/api-chat-response.png)]({{base_path}}/assets/img/get_started/api-chat-response.png)
