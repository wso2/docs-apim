# Create a Streaming API

**Streaming APIs** are used in event driven architecture. Creating a streaming api is the process of linking an 
existing streaming backend API implementation to the [API Publisher]({{base_path}}/getting-started/overview/#api-publisher), so that you can manage and monitor the [API's lifecycle]({{base_path}}/learn/design-api/lifecycle-management/api-lifecycle/), documentation, security, community, and subscriptions. Alternatively, you can provide the API implementation in-line in the [API Publisher]({{base_path}}/getting-started/overview/#api-publisher) itself.

Streaming API support is provided via three main protocol in APIM.

1. Server Sent Events (SSE)
2. WebSub (WebHooks)
3. Websocket

## Server Sent Event API

Follow the instructions below to create a Server Sent Event API using the basic flow.

1. Sign in to the WSO2 API Publisher.

    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

2.  Go to **CREATE API** and Click **Design New Streaming API**.

    [![]({{base_path}}/assets/img/learn/create-a-server-sent-event-api.jpg)]({{base_path}}/assets/img/learn/create-a-server-sent-event-api.jpg)

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
                 <td class="confluenceTd">ServerSentEvent</td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Version</td>
                 <td colspan="1" class="confluenceTd">1.0.0</td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Context</td>
                 <td class="confluenceTd">
                     <div class="content-wrapper">
                         <p>
                             <code>/event</code>
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
          adding the <code>{version}</code> into the context. For example, <code>{version}/event</code>. The API Manager 
          assigns the actual version of the API to the <code>{version}</code> parameter internally. For example, 
                                         <code>https://localhost:8243/1.0.0/event</code>. Note that the version appears before the context, allowing you to 
          group your APIs based on the versions.</p>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Protocol</td>
                 <td colspan="1" class="confluenceTd">
                     <p>SSE</p>
                 </td>
             </tr>
             <tr>
                 <td colspan="2" class="confluenceTd">Endpoint</td>
                 <td colspan="1" class="confluenceTd">
                     <p>
                         https://localhost:8080/sse
                     </p>
                     <p>The endpoint that you add is 
          automatically added as the production and sandbox endpoints.</p>
                     <p>You need to have a server sent event server running for this purpose locally</p>
                 </td>
             </tr>
         </tbody>
     </table>
             
      [![Create an API page]({{base_path}}/assets/img/learn/create-server-sent-api-form.jpg)]({{base_path}}/assets/img/learn/create-server-sent-api-form.jpg)

4.  Click **CREATE** or **CREATE & PUBLISH** to create the API.

     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The <b>CREATE & PUBLISH</b> option will only appear when a user who has <code>publisher</code> permission adds the details for the <b>Endpoint</b> and <b>Business plan(s)</b>, which are optional fields.</p>
     </div>
     </html>

    The overview page of the newly created API appears. 
    
    [![API overview page]({{base_path}}/assets/img/learn/overviewpage-server-sent-api.jpg)]({{base_path}}/assets/img/learn/overviewpage-server-sent-api.jpg)

5. Configure the runtime configurations.

     1. Click **Runtime Configuration**. 

         Transport Level Security  defines the transport protocol on which the API is exposed.  

         [![Transport-level security]({{base_path}}/assets/img/learn/transport-level-security-sse.jpg)]({{base_path}}/assets/img/learn/transport-level-security-sse.jpg)

       2. If you wish to limit the API availability to only one transport (e.g., HTTPS), uncheck the **Transport Level Security** checkbox.
           
           Both HTTP and HTTPS transports are selected by default.

6. Configure the topics.

     Topics are used in async world to represent different channels. By default, the API will have a topic with name 
     `/*`.

     1. Click **Show More** to navigate **Topics** page.

         [![Overview page topics section]({{base_path}}/assets/img/learn/overview-page-topics-section.jpg)]
         ({{base_path}}/assets/img/learn/overview-page-topics-section.jpg)

      2. Modify the topics as follows and click **SAVE** to update them.

          1. Click delete, as shown below, to an existing topic.

              [![Delete topic]({{base_path}}/assets/img/learn/delete-topic-sse.jpg)]
              ({{base_path}}/assets/img/learn/delete-topic-sse.jpg)

          2. Click **Add Topic** to add a new topic.
         
             [![Add new topics]({{base_path}}/assets/img/learn/add-new-topic.jpg)]
             ({{base_path}}/assets/img/learn/add-new-topic.jpg)
      
             The newly added topic is displayed as follows.
         
             [![Newly added topic]({{base_path}}/assets/img/learn/newly-added-topic.jpg)]
             ({{base_path}}/assets/img/learn/newly-added-topic.jpg)

8. Optionally view the API definition.

     Click **API Definition**. The Async Specification of API appears.

     [![Async API definition]({{base_path}}/assets/img/learn/api-definiton-sse.jpg)]
     ({{base_path}}/assets/img/learn/api-definiton-sse.jpg)

Now, you have successfully created and configured a Streaming API. Next, let's [Publish your API]
({{base_path}}/learn/design-api/publish-api/publish-an-api/).

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



