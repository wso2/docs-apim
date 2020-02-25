# Create a WebSocket API

WebSocket is a protocol similar to HTTP that is part of the HTML5 specification. It enables simultaneous two-way communication (full-duplex communication) between the client and the server over a single connection. 

The WebSocket protocol is designed to achieve the following:

-   Reduce unnecessary network traffic and latency.
-   Allow streaming through proxies and firewalls while simultaneously supporting upstream and downstream communication.
-   Be backward compatible with the pre-WebSocket world by starting up as an HTTP connection before switching to WebSocket frames.

A WebSocket API allows an API creator to expose a WebSocket backend as an API to offer services via a WebSocket protocol while providing 
[OAuth security]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-oauth2-tokens), [Throttling]({{base_path}}/learn/rate-limiting/introducing-throttling-use-cases/), [Analytics]({{base_path}}/learn/analytics/overview-of-api-analytics/), etc.

Follow the instructions below to design a WebSocket API.

1. Sign in to the API Publisher Portal.
   
    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    Use your username and password to sign in.

2.  Click **CREATE API** and then click **Design a New WebSocket API**.

     <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
     </html>
    
     [![Create WebSocket API menu]({{base_path}}/assets/img/learn/create-websocket-api.jpg)]({{base_path}}/assets/img/learn/create-websocket-api.jpg)

3.  Enter the detials of the new WebSocket API.

    <table>
    <thead>
    <tr>
    <th>Field</th>
    <th>Sample value</th>
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
    <td>1.0</td>
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
     
     2. Click on the cogwheel icon, which is inline with the endpoint that you need to configure, and update the endpoint related configurations as required. 
     
         For more information, see the following sections on endpoint related configurations.

         - [Endpoint Timeouts]({{base_path}}/learn/design-api/endpoints/resiliency/endpoint-timeouts)
         - [Endpoint Suspension]({{base_path}}/learn/design-api/endpoints/resiliency/endpoint-suspension)
         - [Prevent API Suspension]({{base_path}}/learn/design-api/endpoints/resiliency/prevent-api-suspension)

    [![View endpoint details]({{base_path}}/assets/img/learn/endpoint-view-of-websocket-api.jpg)]({{base_path}}/assets/img/learn/endpoint-view-of-websocket-api.jpg)

Now, you have successfully created and configured a WebSocket API. Next, let's [Publish your API]({{base_path}}/learn/design-api/publish-api/publish-an-api).

<div class="admonition note">
<p class="admonition-title">What's Next?</p>

<p>Learn more by trying out the tutorial on <a href="{{base_path}}/learn/tutorials/create-and-publish-websocket-api">Creating and Publishing a WebSocket API</a>.</p>
</div>

