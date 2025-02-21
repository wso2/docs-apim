# AI Powered API Design Assistant Getting Started Guide

Designing APIs is a crucial part of the API development lifecycle. With API Manager, you can easily create APIs using natural language through the API Design Assistant. This AI-powered tool requires no prior coding or API knowledge, allowing you to design REST, GraphQL, and Async APIs effortlessly by transforming your requirements into API specifications.

[![API Design Assistant Landing Page]({{base_path}}/assets/img/design/create-api-with-ai/welcome-page.png)]({{base_path}}/assets/img/design/create-api-with-ai/welcome-page.png)

!!! info
    This feature is currently in the **experimental** stage and is exclusively for REST APIs, GraphQL APIs and Async (WebSub, WebSocket, SSE) APIs. If you require SOAP APIs or AI APIs, regrettably, this feature is not available for use at this moment.

Follow the steps below to get started with the API Design Assistant:

!!! tip
    If you've previously registered your environment for the [API Chat]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/test-apis-with-apichat) or [Marketplace Assistant]({{base_path}}/consume/discover-apis/marketplace-assistant), you can skip Step 1 and 2 by utilizing the same credentials for the API Design Assistant. Otherwise, complete Step 1 to register your on-premise environment.

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

## Step 4 - Engage with the API Design Assistant

Now that your environment is configured, you're ready to interact with the API Design Assistant. Utilize its capabilities to design your APIs.

1.  Sign in to the WSO2 Publisher Portal (`https://<hostname>:9443/publisher`)

2.  On the landing page, click on the ‘Create API with AI’ Button at the top of the page 

    [![Landing Page]({{base_path}}/assets/img/design/create-api-with-ai/landing-page.png)]({{base_path}}/assets/img/design/create-api-with-ai/landing-page.png)
    
    or if you have already created an API, click the ‘Create API with AI’ Button on the top left to navigate to API Design Assistant.

    [![API Design Assistant Button]({{base_path}}/assets/img/design/create-api-with-ai/api-design-assistant-button.png)]({{base_path}}/assets/img/design/create-api-with-ai/api-design-assistant-button.png)

3. Send a query to the Assistant to create a specific API of your choice, such as **"Create an API for a university."** Also it is possible to enter additional queries to modify the generated specification further. You can use queries such as the following. 
- Include courses as well
- Extend /GET courses to also return the total number of students (only for REST APIs)
- Why do we need these resources?

    [![API Design Assistant Send Query]({{base_path}}/assets/img/design/create-api-with-ai/send-query.png)]({{base_path}}/assets/img/design/create-api-with-ai/send-query.png)

4. View the resources via the Swagger UI. When the generated specification is an OpenAPI spec, the Swagger UI will be displayed by default, visualizing the REST API’s resources. You can select a resource path to view its details.

    !!! Note
    If the generated specification is not an OpenAPI spec, the Swagger UI will not be visible.

    [![API Design Assistant View Swagger]({{base_path}}/assets/img/design/create-api-with-ai/view-swagger.png)]({{base_path}}/assets/img/design/create-api-with-ai/view-swagger.png)

5. View the generated specification by toggling "View Source" located in the top-right corner.

    !!! Note
    For non-OpenAPI specifications, the generated spec will be displayed by default.

    [![API Design Assistant View Source]({{base_path}}/assets/img/design/create-api-with-ai/view-source.png)]({{base_path}}/assets/img/design/create-api-with-ai/view-source.png)

6. Change existing resources by typing ‘/’ in the input field and selecting the resource you want to modify from the dropdown menu. After generating the updated OpenAPI spec, users can navigate to the modified resource in the Swagger UI to view the changes.

    !!! Note
    For non-OpenAPI specs, typing ‘/’ will result in a “No resources” message in the dropdown menu.

    [![API Design Assistant Add Resource Modification]({{base_path}}/assets/img/design/create-api-with-ai/add-resource-modification.png)]({{base_path}}/assets/img/design/create-api-with-ai/add-resource-modification.png)

7. Use the API Design Assistant to refine your API, make modifications, or ask API-related questions to learn more about its details.

    [![API Design Assistant Add General Modification]({{base_path}}/assets/img/design/create-api-with-ai/add-general-modification.png)]({{base_path}}/assets/img/design/create-api-with-ai/add-general-modification.png)

8. Click the 'Create API' button in the bottom right corner to open the wizard, where you can refine key metadata details such as name, version, and context before finalizing. Once satisfied, click 'Create' to create the API in the Publisher Portal.

    [![API Design Assistant Create API Wizard]({{base_path}}/assets/img/design/create-api-with-ai/create-api-wizard.png)]({{base_path}}/assets/img/design/create-api-with-ai/create-api-wizard.png)

## FAQ

**1. Why is this an experimental feature?**

The API Design Assistant is labeled as an experimental feature because it represents innovative technology that is still under development. AI technology is rapidly evolving with significant enhancements in large language models and the introduction of increasingly efficient chips, and we are integrating the latest advancements to enhance our capabilities. Rolling out new features as experimental underscores our commitment to innovation, and as we continue to refine them, we are focused on enhancing their performance and reliability based on user input and ongoing development efforts.

**2. What types of APIs are supported?**

The platform supports REST, GraphQL and Async (WebSub, WebSocket, SSE) APIs, allowing users to design and modify these API types efficiently. However, it does not support AI APIs or SOAP APIs.

**3. Why did I lose my chat history after I logged out or exited API Design Assistant?**

Your chat history will be lost after logging out or after a period of inactivity of 15 minutes, as per the design of the application. For security and privacy reasons ensure that your conversations are not accessible to other users. Additionally, you have the option to reset your chat history to address any potential privacy concerns.

**4. I am getting this error response: Apologies for the inconvenience. `It appears that your token is invalid or expired. Please provide a valid token or upgrade your subscription plan `**

This message suggests that your on-prem key is not valid or it is expired. You can request an extended trial period or you can upgrade your subscription plan so that you can seamlessly use API Design Assistant.

**5. I am getting this error response: `It is taking longer than expected. Please try again. `**

This message signifies that an unexpected error has occurred. It could be due to various reasons such as server issues, network problems, etc. Kindly resend the same query and try again or reach out to the administrator for assistance in resolving the problem.
