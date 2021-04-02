# Create a WebSocket API

This section will guide you through creating a websocket API in which you will expose a websocket backend via WSO2
 API Manager. Once the API is created, you will be able to create independent channels to connect to each topic 
 in the API. These topics can be mapped to different channels in the backend. This way the user will be able to maintain multiple channels with the API to exchange different types of events simultaneously.
 
 
 Follow the instructions below to create a WebSocket API using the basic flow.

### Design a WebSocket API

1.  Sign in to the WSO2 API Manager (WSO2 API-M) Publisher Portal `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher`).

2.  Click **CREATE API**, go to **Streaming API** and Click **WebSocket API**.

    [![Design New Streaming API]({{base_path}}/assets/img/learn/design-api/streaming-api/design-new-streaming-api.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/design-new-streaming-api.png)

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
    </html>
    
3.  Enter API details. 
    
     <table>
        <colgroup>
             <col/>
             <col/>
             <col/>
        </colgroup>
        <tbody>
             <tr>
                 <th colspan="2">Field</th>
                 <th >Sample 
          value</th>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Name</td>
                 <td class="confluenceTd">WebSocket</td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Context</td>
                 <td class="confluenceTd">
                     <div class="content-wrapper">
                         <p>
                             <code>/websocket</code>
                         </p>
                         <div>
                             <div class="confluence-information-macro-body">
                                 <p>The API context is used by the Gateway to identify the API. 
          Therefore, the API context must be unique. This context is the API's root context when invoking the API through 
          the Gateway.</p>
                             </div>
                             <div class="confluence-information-macro confluence-information-macro-tip">
                                 <span class="aui-icon aui-icon-small aui-iconfont-approve confluence-information-macro-icon"></span>
                                 <div class="confluence-information-macro-body">
                                     <p>You can define the API's version as a parameter of its context by 
          adding the <code>{version}</code> into the context. For example, <code>{version}/websocket</code>. The WSO2 API-M
          assigns the actual version of the API to the <code>{version}</code> parameter internally. For example, 
                                         <code>ws://localhost:9099/1.0.0/websocket</code>. Note that the version appears before the context, allowing you to 
          group your APIs based on the versions.</p>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Version</td>
                 <td colspan="1" class="confluenceTd">1.0.0</td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Protocol</td>
                 <td colspan="1" class="confluenceTd">
                     <p>WebSocket</p>
                 </td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Endpoint</td>
                 <td colspan="1" class="confluenceTd">
                    <p>
                    Use one of the following endpoints.
                    <ul>
                        <li>ws://echo.websocket.org:80</li>
                        <li>wss://echo.websocket.org:443</li>
                    </ul>
                 </td>
             </tr>
         </tbody>
     </table>
             
      [![Create WebSocket API Form]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/create-websocket-streaming-api-form.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/create-websocket-streaming-api-form.png)

4.  Click **CREATE** to create the API. The overview page of the newly created API appears. 
    
    [![WebSocket API Overview Page]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-overview-page.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-overview-page.png)


### Configure the Topics

Topics of an WebSocket API are always **Subscribe and Publish**, where the flow of events can be either from the server (backend) to the client, or from the client to the server. By default, the WebSocket API will have a topic with the name `/*`.

1. Click **Topics** and navigate to the **Topics** page.

2. Modify the topics as follows and click **Save** to update them.

    1. Optionally click delete as shown below, to delete an existing topic.

        [![WebSocket API Delete Topic]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-delete-topic.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-delete-topic.png)

    2. Select the **Types**, enter the **Topic Name**, and click **+** as shown below, to add a new topic.
         
        [![WebSocket API Add Topic]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-add-topic.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-add-topic.png)
      
        The newly added topic is displayed as follows.
         
        [![WebSocket API Newly Added Topic]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-newly-added-topic.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-newly-added-topic.png)

    3. Optionally, provide a URL Mapping to the topic.

        The provided URL Mapping will be appended to the WebSocket endpoint URL which was provided when creating the API, and the traffic via this topic will be sent to the resulting URL.
          
        Expand the created topic, provide a URL Mapping and click **Save**.

        [![WebSocket API Topic URL Mapping]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/wesocket-streaming-api-add-topic-url-mapping.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/wesocket-streaming-api-add-topic-url-mapping.png)
            


### View the AsyncAPI Definition

Click **AsyncAPI Definition** under **API Configurations**. The AsyncAPI specification of the API appears.
    
   [![WebSocket API AsyncAPI Definition]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-asyncapi.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/websocket/websocket-streaming-api-asyncapi.png)

Now, you have successfully created and configured a Streaming API. Next, let's [Publish your API]({{base_path}}/learn/design-api/publish-api/publish-an-api).

<div class="admonition note">
<p class="admonition-title">What's Next?</p>
<p>Learn more by trying out the tutorial on <a href="{{base_path}}/tutorials/streaming-api/create-and-publish-websocket-api">Creating and Publishing a WebSocket API</a>.</p>
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
