# Test APIs with API Chat

Testing APIs is an essential step in the API development process. API Manager simplifies the testing task by allowing you to engage with your APIs using natural language through API Chat. It eliminates manual test scenario creation and JSON payload accuracy concerns. It enables easy API communication using human language and requires no coding for handling sequences with multiple resource calls. This makes your API testing efficient and user-friendly.

To begin using the API Chat, you need to register with Choreo. Follow the steps below to get started with the API Chat:

If you've previously registered your environment for the Marketpalce Assistant, you can utilize the same credentials for the API Chat. Otherwise, follow these steps to register your on-premise environment:

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

To enable the API Chat, the API Manager requires configuration. Follow these steps:

### Configure the deployment.toml

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and update the `[apim.ai]` config segment as follows:

   ```toml
   [apim.ai]
   enable = true
   endpoint = "https://e95488c8-8511-4882-967f-ec3ae2a0f86f-dev.e1-us-east-azure.choreoapis.dev/lgpt/interceptor-service/interceptor-service-be2/v1.0"
   token = "<use token that you generated>"
   ```

2. Enter the on-premise token, which you obtained via the Choreo Portal in the **Register your environment** step, as the Token field.
3. Restart the API Manager.

## Step 4 - Test your APIs

Follow the steps below to test an API with API Chat:

The examples here use the `PizzaShack` REST API, which was created in [Create a REST API]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).

1.  Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`) and click an API (e.g., `PizzaShack`).

2.  Subscribe to the API (e.g., `PizzaShackAPI` 1.0.0) using an application and an available throttling policy.

    [![Subscribe to an API]({{base_path}}/assets/img/learn/subscribe-to-api.png)]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3.  Click **Applications** and then click on the application that you used to subscribe to the API. Click **Production Keys** and navigate to **OAuth2 Tokens**.

    [![Navigate to OAuth Tokens]({{base_path}}/assets/img/learn/navigate-to-oauth-tokens-api-console.png)]({{base_path}}/assets/img/learn/navigate-to-oauth-tokens-api-console.png)

4.  Scroll down and generate a production key

    [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

    !!! tip
    **Production and Sandbox Tokens**

            To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip
    **JWT tokens**

            As the application is self-contained (JWT), **copy the generated access token** before proceeding to the next step.

5.  Click **APIs**, and click on the API that you need to test.

6.  Click on the **API Chat** under **Try Out** in API Overview tab.

    [![API console test button]({{base_path}}/assets/img/get_started/api-chat.png)]({{base_path}}/assets/img/get_started/api-chat.png)

    The API Chat UI to test the PizzaShack API appears.

7.  Enter the copied access token in the **Authorization** field or click on **GET TEST KEY**.

    [![Copy Access Token]({{base_path}}/assets/img/get_started/api-chat-configure-key.png)]({{base_path}}/assets/img/get_started/api-chat-configure-key.png)

8.  You can enter your query in natural language and execute it. For example, if you have a resource like "/pet/findByStatus," you can input the query, such as "Get the pets that are available," and execute it to obtain results. The resources are executed sequentially based on your query. Alternatively, you can use the sample queries available to try out API Chat.
