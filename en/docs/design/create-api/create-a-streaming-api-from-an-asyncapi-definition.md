# Create a Streaming API from an AsyncAPI Definition

An [AsyncAPI](https://www.asyncapi.com/) definition is a format that describes asynchronous APIs. 

The following types of Streaming APIs can be created using an existing AsyncAPI definition:

1. [WebSocket]({{base_path}}/design/create-api/create-streaming-api/create-a-websocket-streaming-api)
2. [WebSub (WebHooks)]({{base_path}}/design/create-api/create-streaming-api/create-a-websub-streaming-api)
3. [Server Sent Events (SSE)]({{base_path}}/design/create-api/create-streaming-api/create-a-sse-streaming-api)

Follow the instructions below to create a Streaming API in this manner.


1. Sign in to the WSO2 API Manager (WSO2 API-M) Publisher Portal `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher`).

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE API</b> button will only appear if the user who has signed in has the creator role permission.</p>
      </div>
    </html>

2. Click **CREATE API** and then click **Import AsyncAPI Definition**.

    [![]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/import-asyncapi-definition.png)]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/import-asyncapi-definition.png)

3. Select one of the following options:

	* **AsyncAPI URL** - If you select this option, you need to provide a URL.
	* **AsyncAPI File** - If you select this option, click **Browse File to Upload** and upload a file which contains an AsyncAPI definition.

4.  Select **AsyncAPI URL**, provide the following URL, and click **Next**. 

     ```sh
     https://raw.githubusercontent.com/asyncapi/asyncapi/master/examples/2.0.0/streetlights.yml
     ```

     [![]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-url-import.png)]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-url-import.png)

5.  Edit the information as given below and click **Create**.

     | **Field**   | **Sample value** |
     |-------------|------------------|
     | Name | StreetlightsAPI |
     | Context | /streetlights |
     | Version | 1.0.0 |
     | Protocol | WebSocket (or any other type of Streaming API) |
     | Endpoint | ws://localhost:8080 |
 
     [![]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-configure-values.png)]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-configure-values.png)

     Now, the **StreetlightsAPI API** overview page will appear.

     [![]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-overview.png)]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-overview.png)

### Topics
   
Click **Topics** to navigate to the topics page.

[![]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-topics.png)]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-topics.png)

You will notice that the topics have been created automatically, from the AsyncAPI definition specified in the provided URL.


## Subscriptions

1. Click **Subscriptions**.

2. Select **AsyncGold** and **AsyncSilver** as the Business plans. If you have chosen WebSub as the Streaming API type, choose **AsyncWHGold** and **AsyncWHSilver**.

     [![]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-subscriptions.png)]({{base_path}}/assets/img/learn/design-api/streaming-api-from-asyncapi/websocket/websocket-streaming-api-from-asyncapi-subscriptions.png)

     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p> The Streaming API can be available at different levels of the service. They allow you to limit the number of events via the Streaming API during a given period of time.</p>
     </div>
     </html>

3. Click **Save**.

Now, a Streaming API has been created successfully from an Async API Definition. 

Next, publish the API, for more information, see [Publish an API]({{base_path}}/learn/design-api/publish-api/publish-an-api).


<div class="admonition note">
<p class="admonition-title">What's Next?</p>
<p>Learn more by trying out the following tutorials: 
<ul>
<li><a href="{{base_path}}/tutorials/streaming-api/create-and-publish-websocket-api">Create and Publish a WebSocket API</a></li>
<li><a href="{{base_path}}/tutorials/streaming-api/create-and-publish-websub-api">Create and Publish a WebSub API</a></li>
<li><a href="{{base_path}}/tutorials/streaming-api/create-and-publish-sse-api">Create and Publish a Server Sent Events API</a></li>
</ul>
</p>
</div>


!!! More

        Click the following topics to learn more on the concepts that you need to know when creating an API:
       -   [Creating A Streaming Backend]({{base_path}}/get-started/quick-start-guide/streaming-qsg)
       -   [API Visibility]({{base_path}}/learn/design-api/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/)
       -   [Endpoints]({{base_path}}/learn/design-api/endpoints/endpoint-types/)
       -   [Throttling Tiers]({{base_path}}/learn/rate-limiting/introducing-throttling-use-cases/)
       -   [Custom Properties]({{base_path}}/learn/design-api/create-api/adding-custom-properties-to-apis/)
       -   [API Security]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-oauth2-tokens)
       -   [Life Cycle Management]({{base_path}}/learn/design-api/lifecycle-management/api-lifecycle/)
       -   [API Documentation]({{base_path}}/learn/design-api/api-documentation/add-api-documentation/)
       -   [API Monetization]({{base_path}}/learn/api-monetization/monetizing-an-api/)
