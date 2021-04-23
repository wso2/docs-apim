# Create and Publish a WebSocket API

This tutorial will guide you to implement a WebSocket based chat application using the WSO2 API Manager.
Follow the instructions in this tutorial to design and publish API via a WebSocket backend, and thereafter 
invoke the [WebSocket API]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/create-a-websocket-streaming-api) using the **wscat** WebSocket client.

This will demonstrate a simple command line based chat room which has two channels: **rooms**, and **notifications**.

!!! note
    When you create a WebSocket Streaming API it's exposed via both <code>ws</code> and <code>wss</code> protocols. By default, the <code>ws</code> transport uses port 9099, and the <code>wss</code> transport uses port 8099.

### Step 1 - Design a WebSocket API

1.  {!includes/sign-in-publisher.md!}

2.  Click **CREATE API**, go to **Streaming API**, and click **WebSocket API**.

     <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
     </html>

    [![Design New Streaming API]({{base_path}}/assets/img/design/create-api/streaming-api/design-new-streaming-api.png)]({{base_path}}/assets/img/design/create-api/streaming-api/design-new-streaming-api.png)

3.  Enter the details of the new WebSocket API.

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
     <td>Chats</td>
     </tr>
     <tr>
     <td>Context</td>
     <td>/chats</td>
     </tr>
     <tr>
     <td>Version</td>
     <td>1.0.0</td>
     </tr>
     <tr>
     <td>Protocol</td>
     <td>WebSocket</td>
     </tr>
     <tr>
     <td>Endpoint</td>
     <td>ws://localhost:8080</td>
     </tr>
     </tbody>
     </table>

    <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <ul>
     <li>When you create a WebSocket Streaming API it's exposed via both ws and wss protocols. By default, ws transport uses port 9099, and wss transport uses port 8099.
     </li>
     <li><p>For non-secured WebSockets enter the protocol as <code>ws://</code> in the endpoint, or for secured WebSockets enter the protocol as <code>wss://</code></p></li>
     </ul>
     </div>
     </html>

4.  Click **CREATE**. 

     The overview page of the created WebSocket API appears.

     [![Overview of WebSocket API]({{base_path}}/assets/img/tutorials/streaming-api/websocket-api-overview.png)]({{base_path}}/assets/img/tutorials/streaming-api/websocket-api-overview.png)

5. Add topics to the WebSocket API.

     1. Click **Topics** and navigate to the Topics page.

     2. Delete the existing default topic, which has the name `/*`.

     3. Add the following topics one by one. 
     
           Select **pub** and **sub** as the **Types**, enter the **Topic Name**, and click **+** to add each topic.

          - /notifications
          - /rooms/{roomID}

          <img src="{{base_path}}/assets/img/tutorials/streaming-api/websocket-api-add-topics.png" width="80%" alt="Add Topics to WebSocket API">
          
     4. Expand each topic, provide URL Mappings as follows, and click **Save**.

          | **Topic** | **URL Mapping** |
          |-----------|-----------------|
          | /notifications | /notifications |
          | /rooms/{roomID} | /rooms?room={uri.var.roomID} |

          URL Mapping provided for a topic will be appended to the WebSocket endpoint URL, which was provided when creating the API, and the traffic via the topic will be sent to & received from the resulting URL.

          [![Add URL Mappings to WebSocket API Topics]({{base_path}}/assets/img/tutorials/streaming-api/websocket-api-topic-url-mapping.png)]({{base_path}}/assets/img/tutorials/streaming-api/websocket-api-topic-url-mapping.png)


6. Attach business plans to your WebSocket API.

     1. Click **Subscriptions** and navigate to the Business Plans page.

     2. Select **AsyncGold** and click on **Save**.

           [![Subscriptions of WebSocket API]({{base_path}}/assets/img/tutorials/streaming-api/websocket-api-subscriptions.png)]({{base_path}}/assets/img/tutorials/streaming-api/websocket-api-subscriptions.png)

Now, you have created and configured the WebSocket API successfully.

### Step 2 - Publish the WebSocket API

1. Click **Lifecycle** to navigate to the API lifecycle, and click **Publish** to publish the API to the API Developer Portal.

2. Click **Deployments** to navigate to the Deployments page and click **Deploy New Revision**. 

3. Select **Production and Sandbox**, choose **localhost** as the VHost, and click on **Deploy**.

      <a href="{{base_path}}/assets/img/tutorials/streaming-api/streaming-api-deploy-new-revision.png"><img src="{{base_path}}/assets/img/tutorials/streaming-api/streaming-api-deploy-new-revision.png" width="80%" alt="Deploy New Revision"></a>

### Step 3 - Start the WebSocket Server

1. Download the sample WebSocket server from [WSO2 APIM Samples - GitHub repository](https://github.com/wso2/samples-apim/tree/master/streaming-api-backends/websocket-backend).

2. Go to the `streaming-api-backends/websocket-backend` directory, and install the required dependencies.

     ```sh
     npm install
     ```

3. Start the server.

     ```sh
     npm start
     ```

### Step 4 - Invoke the WebSocket API

1. {!includes/sign-in-devportal.md!}

2. Click on the WebSocket API. 

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
     
      1.  Install **wscat** client. 

           ```sh
           npm install -g wscat
           ```

      2.  Invoke the API's `/notifications` topic with an authorization header by executing the following command.
        
           ``` bash tab="WS"
           wscat -c ws://localhost:9099/chats/1.0.0/notifications -H "Authorization: Bearer [accesstoken]" 
           ```

           ``` bash tab="WSS"
           wscat -n -c wss://localhost:8099/chats/1.0.0/notifications -H "Authorization: Bearer [accesstoken]"
           ```
          
          When the connection is successful, the WebSocket server will send: 
           ```bash
           Subscribed to notifications!
           ```

      3.  In a separate terminal, invoke the API's `/rooms/{roomID}` topic with an authorization header by executing the following command.

           ``` bash tab="WS"
           wscat -c ws://localhost:9099/chats/1.0.0/rooms/room1 -H "Authorization: Bearer [accesstoken]" 
           ```

           ``` bash tab="WSS"
           wscat -n -c wss://localhost:8099/chats/1.0.0/rooms/room1 -H "Authorization: Bearer [accesstoken]"
           ```

          When the connection is successful, the WebSocket server will send:
           ```bash
           You joined room1!
           ```
          This denotes that the first user has connected to `room1`.

          Additionally, the following message will be shown in the terminal where you invoked the `/notifications` topic. This denotes the notification for the above event.
           ```bash
           Someone joined room1!
           ```
          
      4.  In another terminal, invoke the API's `/rooms/{roomID}` topic again. This denotes the second user, who will be connecting to `room1`.
      
           ``` bash tab="WS"
           wscat -c ws://localhost:9099/chats/1.0.0/rooms/room1 -H "Authorization: Bearer [accesstoken]" 
           ```

           ``` bash tab="WSS"
           wscat -n -c wss://localhost:8099/chats/1.0.0/rooms/room1 -H "Authorization: Bearer [accesstoken]"
           ```
          
          You will receive the message: `You joined room1!` in this terminal, along with the corresponding notification in the `notifications` terminal.
          
          As there are two users connected to `room1`, both of them can send and receive chats via `room1`. Try sending messages from both of these terminals back and forth.

          <html>
          <div class="admonition note">
          <p class="admonition-title">Note</p>
          <p>
              There are clients (especially browsers) that do not allow you to add headers to the WebSocket handshake. In such cases, you can send the access token for the WebSocket API invocation as a query parameter named `access_token` by using the command below:
          </p>
          </html>

           ``` bash tab="WS"
           wscat -c "ws://localhost:9099/chats/1.0.0/notifications?access_token=[accesstoken]" 
           ```
  
           ``` bash tab="WSS"
           wscat -n -c "wss://localhost:8099/chats/1.0.0/notifications?access_token=[accesstoken]"
           ```

          </div>

          <html>
          <div class="admonition note">
          <p class="admonition-title">Note</p>
          <p>
          `BasicAuth` and `API Key` do not work for the security of WebSocket APIs.</p>
          </div></html>

You have successfully created and published your first WebSocket API, subscribed to it, obtained an access token for testing, and tested your API with the access token.
