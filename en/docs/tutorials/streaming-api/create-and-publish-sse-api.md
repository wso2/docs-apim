# Create and Publish a Server Sent Events API

Follow the instructions in this tutorial to design and publish API with an SSE backend, and thereafter invoke it using a cURL command.

This tutorial demonstrates a SSE API which is connected to a backend that observes your system's memory, and gives you the values in a continuous manner.

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>For more information on SSE APIs, see <a href="{{base_path}}/design/create-api/create-streaming-api/create-a-sse-streaming-api">Create a SSE API</a>.</p>
</div> 
</html>

### Step 1 - Design a SSE API

1.  Sign in to the WSO2 API Publisher `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher`).

2.  Go to **CREATE API** and Click **Design New Streaming API**.

    [![Design New Streaming API]({{base_path}}/assets/img/learn/design-api/streaming-api/design-new-streaming-api.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/design-new-streaming-api.png)

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
    </html>

3.  Enter the details of the new SSE API.

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
     <td>Observer</td>
     </tr>
     <tr>
     <td>Context</td>
     <td>/observer</td>
     </tr>
     <tr>
     <td>Version</td>
     <td>1.0.0</td>
     </tr>
     <tr>
     <td>Protocol</td>
     <td>SSE</td>
     </tr>
     <tr>
     <td>Endpoint</td>
     <td>http://localhost:8080</td>
     </tr>
     </tbody>
     </table>

4.  Click **CREATE**. 

     The overview page of the created SSE API appears.

     [![Overview of SSE API]({{base_path}}/assets/img/learn/tutorials/streaming-api/sse/sse-api-overview.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/sse/sse-api-overview.png)

5. Attach business plans to the SSE API.

     1. Click **Subscriptions** and navigate to the Business Plans page.

     2. Select **AsyncGold** and click on **Save**.

     [![Subscriptions of SSE API]({{base_path}}/assets/img/learn/tutorials/streaming-api/sse/sse-api-subscriptions.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/sse/sse-api-subscriptions.png)

Now, you have created and configured the WebSocket API successfully.

### Step 2 - Publish the SSE API

1. Click **Lifecycle** to navigate to the API lifecycle and click **PUBLISH** to publish the API to the API Developer Portal.

2. Click **Deployments** to navigate to the Deployments page and click **Deploy New Revision**. 

3. Select **Production and Sandbox**, choose **localhost** as the VHost, and click on **Deploy**.

     [![Deploy New Revision]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-deploy-new-revision.png)]({{base_path}}/assets/img/learn/tutorials/streaming-api/streaming-api-deploy-new-revision.png)


### Step 3 - Start the SSE Server

1. Download the sample SSE server from [WSO2 APIM Samples - GitHub repository](https://github.com/wso2/samples-apim).

2. Go to the `sse` directory and start it.

     ```sh
     mvn spring-boot:run
     ```


### Step 4 - Invoke the SSE API

1. Sign in to the Develepor Portal `https://<hostname>:9443/devportal` (eg., `https://localhost:9443/devportal`).

2. Click on the SSE API. The API overview appears.

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
     
      1.  Invoke the API with an authorization header by executing the following CURL command.
        
           ``` sh
           curl http://localhost:8280/observer/1.0.0/memory -H "Authorization: Bearer [accesstoken]" 
           ```

      2.  You will receive continuous stream of events showing your memory usage, from the server.
           ``` string
           data:{"heap":67893392,"nonHeap":36260800,"ts":1614803952066,"identifier":"ram_222"}

           data:{"heap":72591160,"nonHeap":37250808,"ts":1614803953067,"identifier":"ram_223"}

           data:{"heap":72591160,"nonHeap":37251544,"ts":1614803954064,"identifier":"ram_224"}
           ```

You have successfully created and published your first SSE API, subscribed to it, obtained an access token for testing, and tested your API with the access token.
