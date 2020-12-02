# Try out using Postman

You can download a Postman collection for either an **Open API** or a **GraphQL Schema** using WSO2 API Manager, and try out the API using Postman.

!!! note "Try out using the integrated console"
    If required, instead of using Postman you can try out your APIs using the WSO2 API Manager integrated consoles that correspond to your API as mentioned below.

    - REST API - [Integrated API Console]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console.md)
    - GraphQL API - [Integrated GraphQL Console]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console.md)

For example, let's download an OpenAPI as a Postman collection and try it out using Postman.

## Step 1 - Download a Postman collection for the API

Follow the instructions below to download an OpenAPI as a Postman collection:

1.  Sign in to the WSO2 Developer Portal.

     `https://<hostname>:9443/devportal`

2. Click an API (e.g., `Pizza`) to go to the API overview.

    [![API overview]({{base_path}}/assets/img/learn/postman_api_overview.png)]({{base_path}}/assets/img/learn/postman_api_overview.png)

2.  Click **Try Out** to go to the Try out section.

    [![Postman try out]({{base_path}}/assets/img/learn/postman_try_out.png)]({{base_path}}/assets/img/learn/postman_try_out.png)

3.  [Subscribe to an API]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api) if you have not done so already.

4. Select the application name and click **Postman collection**.
     
     This downloads the Postman collection.

    [![Collection download]({{base_path}}/assets/img/learn/postman_download_collection.png)]({{base_path}}/assets/img/learn/postman_download_collection.png)
    
## Step 2 - Try out the collection in Postman

Follow the instructions below to try out the Postman collection that contains the Open API.

1. Get the authentication code.
     
     This is required because the Postman collection is secured.

     1. Click **Subscriptions**.

     2. Click the **PROD KEYS** to generate an Access Token.

         [![Subscriptions]({{base_path}}/assets/img/learn/postman_subscriptions.png)]({{base_path}}/assets/img/learn/postman_subscriptions.png)

     3. Click **Generate Access Token** to generate a new token. 

         [![Generate token]({{base_path}}/assets/img/learn/postman_generate_token.png)]({{base_path}}/assets/img/learn/postman_generate_token.png)
    
     4. Click **Generate**.

         [![Generate dialog]({{base_path}}/assets/img/learn/postman_generate_dialog.png)]({{base_path}}/assets/img/learn/postman_generate_dialog.png)
    
     5. **Copy** the access token you generated.

2. Open the Postman application and click **Import** to import the Postman collection file that you downloaded.

     [![Import Postman]({{base_path}}/assets/img/learn/postman_import.png)]({{base_path}}/assets/img/learn/postman_import.png)

3. Select a resource from the Postman collection to test.

4. Click on the **Authorization** tab and select **Bearer Token** as the token type.

     [![Token type]({{base_path}}/assets/img/learn/postman_token_type.png)]({{base_path}}/assets/img/learn/postman_token_type.png)

5. Paste the copied token.

6. Click **Send** to proceed.

     [![Put token]({{base_path}}/assets/img/learn/postman_put_token.png)]({{base_path}}/assets/img/learn/postman_put_token.png)

     You can now see the result under the **Body** tab.

     [![Postman result]({{base_path}}/assets/img/learn/postman_result.png)]({{base_path}}/assets/img/learn/postman_result.png)
