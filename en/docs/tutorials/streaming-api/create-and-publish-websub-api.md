# Create and Publish a WebSub/WebHook API

This tutorial will guide you to create a [WebHook API]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/create-a-websub-streaming-api) which will listen to the issues created in GitHub and send you 
a notification upon creation. Follow the instructions in this tutorial to design and publish a WebSub/WebHook API, and 
register a WebHook for it.

The tutorial demonstrates a simple WebSub/WebHook API that monitors your GitHub repository for new issues, and receives events when an issue is created.

### Step 1 - Design a WebSub/WebHook API

1.  {!includes/sign-in-publisher.md!}

2.  Click **CREATE API**, go to **Streaming API**, and Click **WebHook API**.

    [![Design New Streaming API]({{base_path}}/assets/img/design/create-api/streaming-api/design-new-streaming-api.png)]({{base_path}}/assets/img/design/create-api/streaming-api/design-new-streaming-api.png)

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
    </html>

3.  Enter the details of the new WebSub/WebHook API.

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

     The overview page of the created WebSub/WebHook API appears.

     [![Overview of WebSub API]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-overview.png)]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-overview.png)

5. Add a topic to the WebSub/WebHook API.

     1. Click **Topics** and navigate to the Topics page.

     2. Click **Add Topic**, add a topic with the name **/issues**, click **Add**, and finally click **Save**.

           [![Add Topics to WebSub API]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-add-topic.png)]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-add-topic.png)

6. Generate a secret.
     
      1. Expand the **Subscription Configuration** section in the **Topics** page.

           [![WebSub API Runtime Configurations]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-runtime-configurations.png)]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-runtime-configurations.png)

      2. Select **SHA1** as the **Signing Algorithm**.
     
      3. Click **Generate** to generate a secret.

           <a href="{{base_path}}/assets/img/tutorials/streaming-api/websub-api-generate-secret.png"><img src="{{base_path}}/assets/img/tutorials/streaming-api/websub-api-generate-secret.png" width="80%" alt="WebSub API Generate Secret"></a>

      4. Copy the generated secret. 
      
           Let's refer to the generated secret as `[generated_secret]`.

      5. Click **Save**.

7. Attach business plans to the WebSub/WebHook API.

      1. Click **Subscriptions** and navigate to the Business Plans page.

      2. Select **AsyncWHGold** and click on **Save**.

           <a href="{{base_path}}/assets/img/tutorials/streaming-api/websub-api-subscriptions.png"><img src="{{base_path}}/assets/img/tutorials/streaming-api/websub-api-subscriptions.png" width="80%" alt="Subscriptions of Websub API"></a>

Now, you have created and configured the Websub API (WebHook API) successfully.

### Step 2 - Forward a Public URL

A public URL should be forwarded to `localhost:9021`, so that your local server can be accessible to the WebHook provider (GitHub). [ngrock](https://ngrok.com) can be used for this purpose.

1. Download [ngrock](https://ngrok.com/download), and start it. 

      This will forward a public URL to `localhost:9021`.

     ```sh
     ./ngrok http 9021
     ```

2. Copy the HTTP URL that is forwarded to `http://localhost:9021`, as shown in ngrock's terminal. 

      In the following example, it is `http://3b1*******c9.ngrok.io`.

     ``` string
     Forwarding                    http://3b1*******c9.ngrok.io -> http://localhost:9021
     Forwarding                    https://3b1*******c9.ngrok.io -> http://localhost:9021
     ```

### Step 3 - Add a WebHook to your GitHub Repository

<div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>You can use an existing GitHub repository of yours, or create a new one for this purpose.</p>
</div>

1. Go to **Settings** of your GitHub repository.

2. Click **WebHooks**, navigate to the WebHooks page, and click **Add WebHook**.

      [![GitHub Webhooks Page]({{base_path}}/assets/img/tutorials/streaming-api/github-webhooks-page.png)]({{base_path}}/assets/img/tutorials/streaming-api/github-webhooks-page.png)

3. Configure the WebHook.

     1. Go back to the WSO2 API Publisher, click **Topics** to navigate to the Topics page, and expand the **/issues** topic. 
     
     2. Copy the **Callback URL**.

          ```string
          https://{GATEWAY_HOST}:9021/repo-watcher/1.0.0/webhooks_events_receiver_resource?topic=/issues
          ```

     3. Go back to your GitHub repository's **WebHooks** page. 
      
           Provide the following values.

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
          <p>This is the secret you obtained from the <b>Subscription Configuration</b> section of the WebSub/WebHook API's <b>Topics</b>.</p>
          </td>
          </tr>
          <tr>
          <td>Which events would you like to trigger this WebHook?</td>
          <td>
          <p>Select <b>Let me select individual events</b>, and check <b>Issues</b>.</p>
          </td>
          </tr>
          </tbody>
          </table>

          [![GitHub Select Event Type]({{base_path}}/assets/img/tutorials/streaming-api/github-webhooks-select-issues.png)]({{base_path}}/assets/img/tutorials/streaming-api/github-webhooks-select-issues.png)

     3. Click **Add WebHook**.


### Step 4 - Publish the WebSub/WebHook API

1. Go to WSO2 API Publisher. 

2. Click **Lifecycle** to navigate to the API lifecycle.

3. Click **PUBLISH** to publish the API to the API Developer Portal.

4. Click **Deployments** to navigate to the Deployments page.

5. Click **Deploy New Revision**. 

6. Select **Production and Sandbox**, choose **localhost** as the VHost, and click on **Deploy**.

      <a href="{{base_path}}/assets/img/tutorials/streaming-api/streaming-api-deploy-new-revision.png"><img src="{{base_path}}/assets/img/tutorials/streaming-api/streaming-api-deploy-new-revision.png" width="80%" alt="Deploy New Revision"></a>

### Step 5 - Create a Callback URL

1. Go to [https://webhook.site.org](https://webhook.site).

2. Click **New**, leave the default values, and click **Create**. 

      A unique URL will be created for you. 

     [![Create Callback URL]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-create-callback-url.png)]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-create-callback-url.png)

3. Click **Copy to clipboard** which is next to **Your unique URL**.

      [![Copy Callback URL]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-copy-callback-url.png)]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-copy-callback-url.png)

4. URL-encode the unique URL that you copied. 

      Let's refer to the URL-encode unique URL as `[encoded_hub_callback]`.

5. Leave the webpage open as you will need to come back to it again.

### Step 6 - Invoke the WebSub/WebHook API

1. {!includes/sign-in-devportal.md!}

2. Click on the WebSub/WebHook API. 

      The API overview appears.

3. Subscribe to the API.

    1. Click **Subscriptions** to go to the Subscriptions page and click **SUBSCRIPTION & KEY GENERATION WIZARD**.
    
           This wizard takes you through the steps of creating a new application, subscribing, generating keys, and generating an access token to invoke the API. 

           <div class="admonition note">
           <p class="admonition-title">Note</p>
           <p> 
           You can use any application (e.g., JWT or OAuth) to subscribe to the API.
           </p>
           </div>

           [![Key Generation Wizard]({{base_path}}/assets/img/tutorials/streaming-api/streaming-api-key-generation-wizard.png)]({{base_path}}/assets/img/tutorials/streaming-api/streaming-api-key-generation-wizard.png)

    2. Copy the authorization token that appears, and click **FINISH**.

         [![Authorization Token]({{base_path}}/assets/img/tutorials/streaming-api/streaming-api-subscription-token.png)]({{base_path}}/assets/img/tutorials/streaming-api/streaming-api-subscription-token.png)

4. Try out the operations.

     1. Subscribe to the **/issues** topic.

          1. Subscribe the callback URL with the **/issues** topic by executing the following cURL command. 
     
                Replace `[encoded_hub_callback]` and `accesstoken` with the values you have obtained.

               ``` bash
               curl -X POST 'http://localhost:8280/repo-watcher/1.0.0?hub.callback=[encoded_hub_callback]&hub.mode=subscribe&hub.secret=newValue&hub.lease_seconds=50000000&hub.topic=/issues' -H "Authorization: Bearer [accesstoken]"
               ```
     
           2. Click **Subscriptions** to go to the Subscriptions page of your application in the Developer Portal. 
     
           3. Click the WebSub API's subscription entry.
           
                This will list down the subscription that you just made.
     
           4. Go to your GitHub repo and create a new issue. 
               
                This will trigger the GitHub WebHook you have created.
     
           5. Go back to the webpage at [https://webhook.site.org](https://webhook.site), where you created the callback URL. 
     
                A new request which denotes the issue creation would have appeared.

               [![Received Event]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-received-event.png)]({{base_path}}/assets/img/tutorials/streaming-api/websub-api-received-event.png)
     
     2. Unsubscribe from the **/issues** topic.

           Unsubscribe the callback URL from the **/issues** topic by executing the following cURL command. 
           
           Replace `[encoded_hub_callback]` and `accesstoken` with the values you have obtained.

          ``` bash
          curl -X POST 'http://localhost:8280/repo-watcher/1.0.0?hub.callback=[encoded_hub_callback]&hub.mode=unsubscribe&hub.secret=newValue&hub.lease_seconds=50000000&hub.topic=/issues' -H "Authorization: Bearer [accesstoken]"
          ```

You have successfully created and published your first WebSub/WebHook API, subscribed to it, obtained an access token for testing, created a subscription to a WebHook, and tested your API with the access token.
