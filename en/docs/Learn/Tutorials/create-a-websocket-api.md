# Create And Publish a WebSocket API

WebSocket is a protocol similar to HTTP that is part of the HTML5 specification. It enables simultaneous two-way communication (full-duplex communication) between the client and the server over a single connection. The WebSocket protocol is designed to achieve the following:

-   Reduce unnecessary network traffic and latency
-   Allow streaming through proxies and firewalls while simultaneously supporting upstream and downstream communication
-   Be backward compatible with the pre-WebSocket world by starting up as an HTTP connection before switching to WebSocket frames

A WebSocket API allows an API creator to expose a WebSocket backend as an API to offer services via a WebSocket protocol while providing [OAuth security](https://tools.ietf.org/html/rfc6749) , [throttling](_Rate_Limiting_) , [analytics](_Analytics_) , etc.

In this tutorial, you create and publish an API with a WebSocket backend and then invoke it using a Netty-based WebSocket client. You can use any WebSocket client to invoke the API.

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

Now, the WebSocket API created and configured successfully. Click **PUBLISH** 
   You have now published the WebSocket API to the API developer portal. Let's subscribe to it.

8.  When prompted, choose to open the newly published API in the API Store.
9.  The `EchoWebSocket` API opens. Select an application (e.g., DefaultApplication), the **Gold tier** and subscribe to the API.
    ![]({{base_path}}/assets/attachments/103328746/103328730.png)
10. Click the **View Subscriptions** button when prompted. The **Subscriptions** tab opens.

11. Click the **Production Keys** tab and click **Generate Keys** to create an application access token. If you have already generated keys before, click **Regenerate** .
    ![]({{base_path}}/assets/attachments/103328746/103328729.png)
    You can also add a [Callback URL](_Key_Concepts_) , if you have not added it already when creating the API. You have now subscribed to an API in the API Store and can invoke it using a WebSocket client. In this tutorial, you invoke it using a [Netty-based WebSocket client](https://docs.wso2.com/download/attachments/92520686/sample-ws-client.zip?version=1&modificationDate=1484568275000&api=v2) .

12. In your client application, set the WebSocket API URL as shown in the API Store.
    ![]({{base_path}}/assets/attachments/103328746/103328728.png)

        !!! note
        SDK generation is not supported for WebSocket APIs as they don't have swagger definitions.

13. In this example, make sure that the URL in the `sample-ws-client/src/main/java/io/netty/example/http/websocketx/client/WebSocketClient.java` file matches the one in the API Store.
    ![]({{base_path}}/assets/attachments/103328746/103328739.png)
14. In the same file, copy and paste the Authorization Bearer access token you generated in step 11 as shown below.
    ![]({{base_path}}/assets/attachments/103328746/103328740.png)
15. Save your changes.
16. Open the `sample-ws-client` directory you downloaded in step 11 using an IDE. This tutorial uses IntelliJ Idea 15 CE as the IDE.
17. Run the WebSocket client as shown below.
    ![]({{base_path}}/assets/attachments/103328746/103328738.png)
18. Type a message in the WebSocket client and you will see that it echoes the message as intended by the WebSocket API.
    ![]({{base_path}}/assets/attachments/103328746/103328737.png)

**Related Topics**

-   [Create and Publish an API](_Create_and_Publish_an_API_)
-   [Create and Publish an API from a Swagger definition](_Create_and_Publish_an_API_from_a_Swagger_Definition_)
-   [Create a Prototyped API with an Inline Script](_Create_a_Mock_API_with_an_Inline_Script_)

