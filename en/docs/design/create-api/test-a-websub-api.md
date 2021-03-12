# Test a WebSub Streaming API

**Testing a WebSub Streaming API** is trying out a WebSub API at the developer portal and making sure whether the functionalities and behaviours are correctly met.

!!! Prerequisites
     1. The WebSub API should have been published.

     2. The WebSub API topic should have been registered with your webhook provider. For more details, see [Create a WebSub API]({{base_path}}/design/create-api/create-streaming-api/create-a-websub-streaming-api).

The examples here use the `RepoWatcher` WebSub API, which was created in [Create a WebSub API]({{base_path}}/design/create-api/create-streaming-api/create-a-websub-streaming-api).

1. Sign in to the Develepor Portal `https://<hostname>:9443/devportal` (eg., `https://localhost:9443/devportal`).

2. Click on the WebSub API. The API overview appears.

3. Click **Try Out** and go to the Try Out section.

4. Generate the access token.

     1. Select **OAuth** as the **Security Type** and select **DefaultApplication** as the **Application**.
     
     2. Select **Production** as the **Key Type**, and click **GET TEST KEY**. The access token will be generated.

5. Create a callback URL. 

     1. Go to [https://webhook.site](https://webhook.site).

     2. Click **New**. Leave the default values, and click **Create**. A unique URL will be created for you. 

          [![Create Callback URL]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-create-callback-url.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-create-callback-url.png)

     3. Click **Copy to clipboard** which is next to **Your unique URL**.

          [![Copy Callback URL]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-copy-callback-url.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-copy-callback-url.png)

     4. URL-encode the URL, which you have copied.

6. Generate the cURL command to subscribe to the topic.

     1. Go back to the Developer Portal. Expand the **/issues** topic.

     2. Select **Subscribe**.

     3. Provide the encoded callback URL which you have obtained in the previous step, as the **Callback URL**.

     4. Click **GENERATE CURL**. The cURL command will be generated.

     5. Copy the generated cURL command, paste it in a terminal and execute it.

7. Go to the **Subscriptions** page of your application in the Developer Portal. Clicking the Websub API's subscription entry will list down the subscription you just made.

     You have now registered the given callback URL with the **/issues** topic. Triggering your webhook will send an event to the callback URL.

8. Generate the cURL command to unsubscribe from the topic.

     1. Expand the **/issues** topic in the Developer Portal.

     2. Select **Unsubscribe**.

     3. Provide the encoded callback URL which you have obtained previously, as the **Callback URL**.

     4. Click **GENERATE CURL**. The cURL command will be generated.

     5. Copy the generated cURL command, paste it in a terminal and execute it.

9. Go to the **Subscriptions** page of your application in the Developer Portal again. Clicking the Websub API's subscription entry will not list down the subscription you made previously anymore.

     You have now unsubscribed the given callback URL from the **/issues** topic.
