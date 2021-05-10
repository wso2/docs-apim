# Create and Publish a Server Sent Events API

This tutorial will guide you to create a [SSE Streaming API]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/create-a-sse-streaming-api) which is connected to a backend that observes your system's memory, and gives you the values in a continuous manner. Follow the instructions in this tutorial to design and publish an API with an SSE backend, and thereafter invoke it using a cURL command.

## Step 1 - Design a SSE API

1.  {!includes/sign-in-publisher.md!}

2.  Click **CREATE API**, go to **Streaming API**, and click **WebSocket API**.

    [![Design New Streaming API]({{base_path}}/assets/img/design/create-api/streaming-api/design-new-streaming-api.png)]({{base_path}}/assets/img/design/create-api/streaming-api/design-new-streaming-api.png)

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

     [![Overview of SSE API]({{base_path}}/assets/img/tutorials/streaming-api/sse-api-overview.png)]({{base_path}}/assets/img/tutorials/streaming-api/sse-api-overview.png)

5. Attach business plans to the SSE API.

      1. Click **Subscriptions** and navigate to the Business Plans page.

      2. Select **AsyncGold** and click **Save**.

           [![Subscriptions of SSE API]({{base_path}}/assets/img/tutorials/streaming-api/sse-api-subscriptions.png)]({{base_path}}/assets/img/tutorials/streaming-api/sse-api-subscriptions.png)

Now, you have created and configured the SSE API successfully.

## Step 2 - Publish the SSE API

1. Click **Lifecycle** to navigate to the API lifecycle page.

2. Click **Publish** to publish the API to the API Developer Portal.

2. Click **Deployments** to navigate to the Deployments page and click **Deploy New Revision**. 

3. Select **Production and Sandbox**, choose **localhost** as the VHost, and click on **Deploy**.

      <a href="{{base_path}}/assets/img/tutorials/streaming-api/streaming-api-deploy-new-revision.png"><img src="{{base_path}}/assets/img/tutorials/streaming-api/streaming-api-deploy-new-revision.png" width="80%" alt="Deploy New Revision"></a>

## Step 3 - Start the SSE Server

1. Download the sample SSE server from [WSO2 APIM Samples - GitHub repository](https://github.com/wso2/samples-apim/raw/master/streaming-api-backends/sse/target/sse-server-1.0.0.jar).

2. Go to the directory where you downloaded the SSE server and run the following command.

     ```sh
     java -jar sse-server-1.0.0.jar --time=5000 --interval=1000
     ```

## Step 4 - Invoke the SSE API

1. {!includes/sign-in-devportal.md!}

2. Click on the SSE API. 

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
     
      Invoke the API with an authorization header by executing the following cURL command.
        
     ``` sh
     curl http://localhost:8280/observer/1.0.0/memory -H "Authorization: Bearer [accesstoken]" 
     ```

      You will receive continuous stream of events showing your memory usage, from the server.

     ``` string
     data:{"heap":67893392,"nonHeap":36260800,"ts":1614803952066,"identifier":"ram_222"}

     data:{"heap":72591160,"nonHeap":37250808,"ts":1614803953067,"identifier":"ram_223"}

     data:{"heap":72591160,"nonHeap":37251544,"ts":1614803954064,"identifier":"ram_224"}
     ```

You have successfully created and published your first SSE API, subscribed to it, obtained an access token for testing, and tested your API with an access token.
