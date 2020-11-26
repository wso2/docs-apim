# Create and Publish a WebSocket API

Follow the instructions in this tutorial to design and publish API with a WebSocket backend, and thereafter invoke it using the **wscat** WebSocket client.

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>For more information on WebSocket APIs, see <a href="{{base_path}}/learn/design-api/create-api/create-a-websocket-api">Create a WebSocket API</a>.</p>
</div> 
</html>

## Step 1 - Design a WebSocket API

1. Sign in to the API Publisher.
   
    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    Let's use `admin` as your username and password to sign in.

2.  Click **CREATE API** and then click **Design a New WebSocket API**.

     <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
     </html>
    
     [![Create WebSocket API menu]({{base_path}}/assets/img/learn/create-websocket-api.jpg)]({{base_path}}/assets/img/learn/create-websocket-api.jpg)

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
    <td>EchoWebSocket</td>
    </tr>
    <tr>
    <td>Context</td>
    <td>/echowebsocket</td>
    </tr>
    <tr>
    <td>Version</td>
    <td>1.0.0</td>
    </tr>
    <tr>
    <td>Endpoint</td>
    <td><p>
    Use one of the following endpoints.
    <ul>
    <li>ws://echo.websocket.org:80</li>
    <li>wss://echo.websocket.org:443</li>
    </ul></td>
    </tr>
    <tr>
    <td>Business Plan</td>
    <td>Gold, Silver</td>
    </tr>
    </tbody>
    </table>
    
    [![Create a WebSocket API menu]({{base_path}}/assets/img/learn/create-web-socket-api.jpg)]({{base_path}}/assets/img/learn/create-web-socket-api.jpg)

    <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The **CREATE & PUBLISH** option will appear only if the optional fields **Endpoint** and **Business plan(s)** are provided by a user who has <code>publisher</code> permission. You need to add a Name, Context, Version, and a valid Endpoint (For non-secured WebSockets enter the protocol as <code>ws://</code>  or for secured WebSockets enter the protocol as <code>wss://</code>) to create the API.</p>
     </div>
     </html>

4.  Click **CREATE** or **CREATE & PUBLISH**. 

     The overview page of the created WebSocket API appears.

     [![Overview of WebSocket API]({{base_path}}/assets/img/learn/overview-websocket-api.jpg)]({{base_path}}/assets/img/learn/overview-websocket-api.jpg)

5.  Optionally, enter the endpoint configurations.

     1. Click **Endpoint**.
     
     2. Click the **Endpoint Advanced Configurations** link as shown below and update the endpoint related configurations as required.
     
         For more information, see the following sections on endpoint related configurations.

         - [Endpoint Timeouts]({{base_path}}/learn/design-api/endpoints/resiliency/endpoint-timeouts)
         - [Endpoint Suspension]({{base_path}}/learn/design-api/endpoints/resiliency/endpoint-suspension)
         - [Prevent API Suspension]({{base_path}}/learn/design-api/endpoints/resiliency/prevent-api-suspension)

     [![View endpoint details]({{base_path}}/assets/img/learn/endpoint-view-of-websocket-api.jpg)]({{base_path}}/assets/img/learn/endpoint-view-of-websocket-api.jpg)

Now, you have created and configured the WebSocket API successfully.

## Step 2 - Publish the WebSocket API

Click **LIFECYCLE** to navigate to the API lifecycle and click **PUBLISH** to publish the API to the API Developer Portal.

## Step 3 - Invoke a WebSocket API

1. Sign in to the Develepor Portal.
   
     `https://<hostname>:9443/devportal` 
   
      Example: `https://localhost:9443/devportal`

2. Click on the WebSocket API.
   
     The API overview appears.

3. Subscribe to the API.

    1. Click **KEY GENERATION WIZARD**.
    
         This wizard takes you through the steps of creating a new application, subscribing, generating keys, and generating an access token to invoke the API. 

         <div class="admonition note">
         <p class="admonition-title">Note</p>
         <p> 
         You can use any application (e.g., JWT or OAuth) to subscribe to the API.
         </p>
         </div>

         [![Key generation wizard]({{base_path}}/assets/img/learn/websocket-api-credential-page.jpg)]({{base_path}}/assets/img/learn/websocket-api-credential-page.jpg)

    2. Copy the authorization token that appears.

         [![Authorization token]({{base_path}}/assets/img/learn/websocket-api-key-generation-wizard.jpg)]({{base_path}}/assets/img/learn/websocket-api-key-generation-wizard.jpg)

4. Try out the operations.
     
      1.  Install wscat client. 

           `npm install -g wscat`

      2.  Invoke the API by using an authorization header by executing the following command.
        
           ``` java tab="WS"
           wscat -c ws://localhost:9099/echowebsocket/1.0 -H "Authorization: Bearer [accesstoken]" 
           ```

           ``` java tab="WSS"
           wscat -n -c wss://localhost:8099/echowebsocket/1.0 -H "Authorization: Bearer [accesstoken]"
           ```

          <html>
          <div class="admonition note">
          <p class="admonition-title">Note</p>
          <p>
              There are clients (especially browsers) that do not allow to add headers to the WebSocket handshake. In such cases, you can send the access token for the WebSocket API invocation as a query parameter named `access_token` by using the command below:</p>

           ``` java tab="WS"
           wscat -c "ws://localhost:9099/echowebsocket/1.0?access_token=[accesstoken]" 
           ```
  
           ``` java tab="WSS"
           wscat -n -c "wss://localhost:8099/echowebsocket/1.0?access_token=[accesstoken]"
           ```

      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p><b>BasicAuth</b> and <b>API Key</b> do not work for the security of WebSocket APIs.</p>
      </div> 
      </html>

You have successfully created and published your first WebSocket API, subscribed to it, obtained an access token for testing, and tested your API with the access token.
