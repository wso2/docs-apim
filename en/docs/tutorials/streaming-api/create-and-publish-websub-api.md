# Create and Publish a WebSub/Webhook API

Follow the instructions in this tutorial to design and publish a WebSub/Webhook API, and register a webhook to it.

The tutorial demonstrates a simple WebSub/Webhook API that monitors your GitHub repository for new issues, and receives events when an issue is created.

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>For more information on WebSub/Webhook APIs, see <a href="{{base_path}}/design/create-api/create-streaming-api/create-a-websub-streaming-api">Create a WebSub/Webhook API</a>.</p>
</div> 
</html>

### Step 1 - Design a WebSub/Webhook API

1.  Sign in to the WSO2 API Manager (WSO2 API-M) Publisher Portal `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher`).

2.  Click **CREATE API**, go to **Streaming API** and Click **Webhook API**.

    [![Design New Streaming API]({{base_path}}/assets/img/learn/design-api/streaming-api/design-new-streaming-api.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/design-new-streaming-api.png)

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
    </html>

3.  Enter the details of the new WebSub/Webhook API.

     <table>
     <thead>
     <tr>
     <th><b>Field</b></th>
     <th><b>Sample value</b></th>
     </tr>
     </thead>
     <tbody>
     <tr>
     <td>Name</td>
     <td>RepoWatcher</td>
     </tr>
     <tr>
     <td>Context</td>
     <td>/repo-watcher</td>
     </tr>
     <tr>
     <td>Version</td>
     <td>1.0.0</td>
     </tr>
     <tr>
     <td>Protocol</td>
     <td>WebSub</td>
     </tr>
     </tbody>
     </table>


4.  Click **CREATE**. 

     The overview page of the created WebSub/Webhook API appears.

     [![Overview of WebSub API]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-overview.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-overview.png)

5. Add a topic to the WebSub/Webhook API.

     1. Click **Topics** and navigate to the Topics page.

     2. Click **Add Topic**. Add a topic with the name **/issues**, click **Add**, and finally click **Save**.

          [![Add Topics to WebSub API]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-add-topic.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-add-topic.png)

6. Generate a secret.
     
     1. Expand the **Subscription Configuration** section in the **Topics** page.

          [![WebSub API Runtime Configurations]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-runtime-configurations.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-runtime-configurations.png)

     2. Select **SHA1** as the **Signing Algorithm**.
     
     3. Click **Generate**, which will generate a secret. Copy the generated secret. Let's call this `[generated_secret]`.

          [![WebSub API Generate Secret]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-generate-secret.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-generate-secret.png)


     4. Click **Save**.

7. Attach business plans to the WebSub/Webhook API.

     1. Click **Subscriptions** and navigate to the Business Plans page.

     2. Select **AsyncWHGold** and click on **Save**.

     [![Subscriptions of Websub API]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-subscriptions.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-subscriptions.png)

Now, you have created and configured the Websub API successfully.


### Step 2 - Forward a Public URL

A public URL should be forwarded to `localhost:9021`, so that your local server can be accessible to the webhook provider (GitHub). [ngrock](https://ngrok.com) can be used for this purpose.

1. Download [ngrock](https://ngrok.com/download), and start it. This will forward a public URL to `localhost:9021`.

     ```sh
     ./ngrok http 9021
     ```

2. Copy the HTTP URL that is forwarded to `http://localhost:9021`, as shown in ngrock's terminal. In the following example, it is `http://3b1*******c9.ngrok.io`.

     ``` string
     Forwarding                    http://3b1*******c9.ngrok.io -> http://localhost:9021
     Forwarding                    https://3b1*******c9.ngrok.io -> http://localhost:9021
     ```


### Step 3 - Add a Webhook to your GitHub Repository

<div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>You can use an existing GitHub repository of yours, or create a new one for this purpose.</p>
</div>

1. Go to **Settings** of your GitHub repository.

2. Click **Webhooks**, navigate to the Webhooks page, and click **Add webhook**.

     [![GitHub Webhooks Page]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/github-webhooks-page.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/github-webhooks-page.png)

3. Configure the webhook.

     1. Go back to the WSO2 API Publisher, navigate to the Topics page, and expand the **/issues** topic. Copy the **Callback URL**.

          ```string
          https://{GATEWAY_HOST}:9021/repo-watcher/1.0.0/webhooks_events_receiver_resource?topic=/issues
          ```

     2. Go back to your GitHub repository's **Webhooks** page. Provide the following values.

          <table>
          <thead>
          <tr>
          <th><b>Field</b></th>
          <th><b>Value</b></th>
          </tr>
          </thead>
          <tbody>
          <tr>
          <td>Payload URL</td>
          <td>
          <code>http://3b1*******c9.ngrok.io/repo-watcher/1.0.0/webhooks_events_receiver_resource?topic=/issues</code>
          <p>This is obtained by replacing <code>https://{GATEWAY_HOST}:9021</code> part of the **/issues** topic's <b>Callback URL</b>, with the forwarding HTTP URL from ngrock (For example, <code>http://3b1*******c9.ngrok.io</code>). </p>
          </td>
          </tr>
          <tr>
          <td>Content type</td>
          <td>application/json</td>
          </tr>
          <tr>
          <td>Secret</td>
          <td>
          <code>`[generated_secret]`</code>
          <p>This is the secret you obtained from the <b>Subscription Configuration</b> section of the WebSub/Webhook API's <b>Topics</b>.</p>
          </td>
          </tr>
          <tr>
          <td>Which events would you like to trigger this webhook?</td>
          <td>
          <p>Select <b>Let me select individual events</b>, and check <b>Issues</b>.</p>
          </td>
          </tr>
          </tbody>
          </table>

          [![GitHub Select Event Type]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/github-webhooks-select-issues.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/github-webhooks-select-issues.png)

     3. Click **Add webhook**.


### Step 4 - Publish the WebSub/Webhook API

1. Go to WSO2 API Publisher. 

2. Click **Lifecycle** to navigate to the API lifecycle and click **PUBLISH** to publish the API to the API Developer Portal.

3. Click **Deployments** to navigate to the Deployments page and click **Deploy New Revision**. 

4. Select **Production and Sandbox**, choose **localhost** as the VHost, and click on **Deploy**.

     [![Deploy New Revision]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-deploy-new-revision.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-deploy-new-revision.png)


### Step 5 - Create a Callback URL

1. Go to [https://webhook.site.org](https://webhook.site).

2. Click **New**. Leave the default values, and click **Create**. A unique URL will be created for you. 

     [![Create Callback URL]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-create-callback-url.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-create-callback-url.png)

3. Click **Copy to clipboard** which is next to **Your unique URL**. Let's call this as: `[callack_url]`.

     [![Copy Callback URL]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-copy-callback-url.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-copy-callback-url.png)

4. TODO REMOVE URL-encode the unique URL, which you have copied. Let's call this `[encoded_hub_callback]`.

5. Leave the webpage open. You will need to come back again.


### Step 6 - Invoke the WebSub/Webhook API

1. Sign in to the Develepor Portal `https://<hostname>:9443/devportal` (e.g., `https://localhost:9443/devportal`).

2. Click on the WebSub/Webhook API. The API overview appears.

3. Subscribe to the API.

    1. Go to the **Subscriptions** page and click **SUBSCRIPTION & KEY GENERATION WIZARD**.
    
         This wizard takes you through the steps of creating a new application, subscribing, generating keys, and generating an access token to invoke the API. 

         <div class="admonition note">
         <p class="admonition-title">Note</p>
         <p> 
         You can use any application (e.g., JWT or OAuth) to subscribe to the API.
         </p>
         </div>

         [![Key Generation Wizard]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-key-generation-wizard.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-key-generation-wizard.png)

    2. Copy the authorization token that appears, and click **FINISH**.

         [![Authorization Token]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-subscription-token.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-subscription-token.png)

4. Try out the operations.

     1. Subscribe the callback URL with the **/issues** topic by executing the following cURL command. Replace `[encoded_hub_callback]` and `accesstoken` with the values you have obtained.

          ``` bash
          curl -X POST 'http://localhost:8280/repo-watcher/1.0.0?hub.callback=[encoded_hub_callback]&hub.mode=subscribe&hub.secret=newValue&hub.lease_seconds=50000000&hub.topic=/issues' -H "Authorization: Bearer [accesstoken]"
          ```
     
     2. Go to the **Subscriptions** page of your application in the Developer Portal. Clicking the Websub API's subscription entry will list down the subscription you just made.
     
     3. Go to your GitHub repo and create a new issue. This will trigger the GitHub webhook you have created.
     
     4. Go back to the webpage at [https://webhook.site.org](https://webhook.site), where you created the callback URL. A new request which denotes the issue creation would have appeared.

          [![Received Event]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-received-event.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/websub/websub-api-received-event.png)

     5. Unsubscribe the callback URL from the **/issues** topic by executing the following cURL command. Replace `[encoded_hub_callback]` and `accesstoken` with the values you have obtained.

          ``` bash
          curl -X POST 'http://localhost:8280/repo-watcher/1.0.0?hub.callback=[encoded_hub_callback]&hub.mode=unsubscribe&hub.secret=newValue&hub.lease_seconds=50000000&hub.topic=/issues' -H "Authorization: Bearer [accesstoken]"
          ```


You have successfully created and published your first WebSub/Webhook API, subscribed to it, obtained an access token for testing, created a subscription to a webhook, and tested your API with the access token.
