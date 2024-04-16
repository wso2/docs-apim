# Test APIs with API Chat

Testing APIs is an essential step in the API development lifecycle. API Manager simplifies the testing task by allowing you to engage with your APIs using natural language through API Chat. It eliminates manual test scenario creation, payload mocking, etc. It enables easy API communication using human language and requires no coding for handling sequences with multiple resource calls. This makes your API testing efficient and user-friendly.

!!! info
    This feature is currently in the **experimental** stage and is exclusively accessible for REST APIs with OpenAPI V3.0.x definitions. If your APIs are defined using Swagger or OpenAPI V3.1.x specifications, regrettably, this feature is not available for use at this moment.

Follow the steps below to test your API with API Chat:

!!! tip
    If you've previously registered your environment for the [Marketplace Assistant]({{base_path}}/consume/discover-apis/marketplace-assistant), you can skip Step 1 by utilizing the same credentials for the API Chat. Otherwise, complete Step 1 to register your on-premise environment.

## Step 1 - Sign in to Choreo

1. Navigate to Choreo using the URL: <a href="https://console.choreo.dev">https://console.choreo.dev</a>.

2. Sign in to Choreo.

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

1. The following configuration change must be done in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the `[apim.ai]` config by providing the on-premise token obtained from Step 2. Also, be sure to update the endpoint field as below.

      ```toml
      [apim.ai]
      enable = true
      endpoint = "https://e95488c8-8511-4882-967f-ec3ae2a0f86f-prod.e1-us-east-azure.choreoapis.dev/lgpt/interceptor-service/interceptor-service-be2/v1.0"
      token = "<use token that you generated>"
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
