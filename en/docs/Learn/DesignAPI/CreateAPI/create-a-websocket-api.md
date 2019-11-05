# Create a WebSocket API

WebSocket is a protocol similar to HTTP that is part of the HTML5 specification. It enables simultaneous two-way communication (full-duplex communication) between the client and the server over a single connection. The WebSocket protocol is designed to achieve the following:

-   Reduce unnecessary network traffic and latency
-   Allow streaming through proxies and firewalls while simultaneously supporting upstream and downstream communication
-   Be backward compatible with the pre-WebSocket world by starting up as an HTTP connection before switching to WebSocket frames

A WebSocket API allows an API creator to expose a WebSocket backend as an API to offer services via a WebSocket protocol while providing 
[OAuth security](../../../../Learn/APISecurity/Authentication/securing-apis-using-oauth2-access-tokens/), [Throttling](../../../../Learn/RateLimiting/introducing-throttling-use-cases/), [analytics](../../../../Learn/Analytics/overview-of-api-analytics/) , etc.

Follow the instructions below to design a WebSocket API.

Follow the instructions below to design a WebSocket API.

1. Sign in to the WSO2 API Publisher providing username and password `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher` ).
    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>CREATE button will only appear for user who has creator role permission.</p>
      </div>
    </html>

2.  Go to **CREATE API** and Click **Design a New Websocket API**.
    ![](../../../../assets/img/Learn/create-websocket-api.jpg)

3.  Provide the information in the table below and click **CREATE** or **CREATE & PUBLISH**.

    | Field   | Sample value   |
    |---------|----------------|
    | Name    | EchoWebSocket  |
    | Context | /echowebsocket |
    | Version | 1.0            |
    | Endpoint| ws://echo.websocket.org:80|
    | Business Paln | Gold,Silver|
    
    ![](../../../../assets/img/Learn/create-web-socket-api.jpg)

    <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The **CREATE & PUBLISH** option will appear only if the optional fields **Endpoint** and **Business plan(s)** are provided by a user who has publisher permission.</p>
     </div>
     </html>

5.  When click **CREATE** or **CREATE & PUBLISH**, page will be redirected to the overview page of the created WebSocket API.
    ![](../../../../assets/img/Learn/overview-websocket-api.jpg)

6.  Navigate to Endpoint page, check the endpoints and click following to add details if needed.
    ![](../../../../assets/img/Learn/endpoint-view-of-websocket-api.jpg)

7. Now, the WebSocket API created and configured successfully. Refer [Publish API](../../../../Learn/DesignAPI/PublishAPI/publish-an-api/) 
to know details of publishing API.

Refer [Tutorial on create and publish websocket API](../../../../Learn/Tutorials/create-a-websocket-api/) to learn more about websocket APIs.

