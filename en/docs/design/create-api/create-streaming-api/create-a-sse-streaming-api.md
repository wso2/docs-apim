# Create a Server Sent Events API

Follow the instructions below to create a Server Sent Events (SSE) API using the basic flow.


### Design a Server Sent Events API

1.  Sign in to the WSO2 API Manager (WSO2 API-M) Publisher Portal `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher`).

2.  Go to **CREATE API** and Click **Design New Streaming API**.

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
                 <td class="confluenceTd">ServerSentEvent</td>
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
                 <td colspan="2" class="confluenceTd">Version</td>
                 <td colspan="1" class="confluenceTd">1.0.0</td>
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
                     <code>https://localhost:8080</code>
                     <p>You need to have a Server Sent Events server running for this purpose locally</p>
                 </td>
             </tr>
         </tbody>
     </table>
             
      [![SSE Create API Page]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/create-sse-api-form.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/create-sse-api-form.png)

4.  Click **CREATE** or **CREATE & PUBLISH** to create the API.

     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The <b>CREATE & PUBLISH</b> option will only appear when a user who has <code>publisher</code> permission adds the details for the <b>Endpoint</b> and <b>Business plan(s)</b>, which are optional fields.</p>
     </div>
     </html>

    The overview page of the newly created API appears. 
    
    [![SSE API overview page]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-overview-page.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-overview-page.png)


### Configure the Topics

Topics of an SSE API are always **Subscribe only**, where the flow of events will be from the server (backend) to the client. By default, an SSE API will have a topic with the name `/*`.

1. Click **Show More** to navigate to the **Topics** page.

    [![SSE API Topics]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-topics-show-more.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-topics-show-more.png)

2. Modify the topics as follows and click **SAVE** to update them.

    1. Optionally click delete as shown below, to delete an existing topic.

        [![SSE API Delete Existing Topic]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-delete-default-topic.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-delete-default-topic.png)

    2. Click **Add Topic** to add a new topic.
            
       [![SSE API Add Topic]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-create-new-topic.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-create-new-topic.png)
        
       The newly added topic is displayed as follows.
            
       [![SSE API Newly Added Topic]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-newly-added-topic.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-newly-added-topic.png)


### View the AsyncAPI Definition

Click **API Definition**. The Async Specification of API appears.


### Configure the Runtime Configurations

1. Click **Runtime Configuration**. 

    Transport Level Security  defines the transport protocol on which the API is exposed.  

    [![SSE API Runtime Configurations Page]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-runtime-configurations-page.png)]({{base_path}}/assets/img/learn/design-api/streaming-api/sse/sse-api-runtime-configurations-page.png)

2. If you wish to limit the API availability to only one transport (e.g., HTTPS), uncheck the **Transport Level Security** checkbox.

    Both HTTP and HTTPS transports are selected by default.


Now, you have successfully created and configured a Streaming API. Next, let's [Publish your API]({{base_path}}/learn/design-api/publish-api/publish-an-api).

<div class="admonition note">
<p class="admonition-title">What's Next?</p>
<p>Learn more by trying out the tutorial on <a href="{{base_path}}/tutorials/streaming-api/create-and-publish-sse-api">Creating and Publishing a SSE API</a>.</p>
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
