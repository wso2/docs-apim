# Create a REST API

**API creation** is the process of linking an existing backend API implementation to the [API Publisher](/GettingStarted/overview/#api-publisher) so that you can manage and monitor the [API's lifecycle](/Learn/DesignAPI/LifecycleManagement/api-lifecycle/) , documentation, security, community, and subscriptions. Alternatively, you can provide the API implementation in-line in the [API Publisher](/GettingStarted/overview/#api-publisher) itself.

Follow the instruction below to create a REST API.
## Create an API using basic flow
1. Sign in to the WSO2 API Publisher providing username and password `https://<hostname>:9443/publisher` (e.g., `https://localhost:9443/publisher` ).
    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>CREATE button will only appear for user who has creator role permission.</p>
      </div>
    </html>

2.  Go to **CREATE API** and Click **Design a New REST API**.

    ![](../../../assets/img/Learn/create-a-rest-api.jpg)

3.  Enter the information provided in the table below and click **CREATE** or **CREATE & PUBLISH** to create the API.

     <table><colgroup> <col/> <col/> <col/> </colgroup><tbody><tr><th colspan="2" >Field</th><th >Sample value</th></tr><tr><td colspan="2" class="confluenceTd">Name</td><td class="confluenceTd">PizzaShack</td></tr><tr><td colspan="2" class="confluenceTd">Version</td><td colspan="1" class="confluenceTd">1.0.0</td></tr><tr><td colspan="2" class="confluenceTd">Context</td><td class="confluenceTd"><div class="content-wrapper"><p><code>/pizzashack</code></p><div><p><br/></p><div class="confluence-information-macro confluence-information-macro-information"><span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span><div class="confluence-information-macro-body"><p>The API context is used by the Gateway to identify the API. Therefore, the API context must be unique. This context is the API's root context when invoking the API through the Gateway.</p></div></div><div class="confluence-information-macro confluence-information-macro-tip"><span class="aui-icon aui-icon-small aui-iconfont-approve confluence-information-macro-icon"></span><div class="confluence-information-macro-body"><p>You can define the API's version as a parameter of its context by adding the <code>{version}</code> into the context. For example, <code>{version}/pizzashack</code>. The API Manager assigns the actual version of the API to the <code>{version}</code> parameter internally. For example, <code>https://localhost:8243/1.0.0/pizzashack</code>. Note that the version appears before the context, allowing you to group your APIs based on the versions.</p></div></div></div></div></td></tr><tr><td colspan="2" class="confluenceTd">Endpoint</td><td colspan="1" class="confluenceTd"><p><a class="external-link" href="http://ws.cdyne.com/phoneverify/phoneverify.asmx" rel="nofollow">https://localhost:9443/am/sample/pizzashack/v1/api/</a></p><p>The endpoint that you add is automatically added as the production and sandbox endpoints.</p></td></tr></tbody></table>
        
     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The **CREATE & PUBLISH** option will appear only if the optional fields **Endpoint** and **Business plan(s)** are provided by a user who has publisher permission.</p>
     </div>
     </html>
     
      ![](../../../assets/img/Learn/create-rest-api-form.jpg)

4.  When click **CREATE** or **CREATE & PUBLISH**, page will be redirected to the overview page of the newly created API. [![](../../../assets/img/Learn/overviewpage-rest-api.jpg)](../../../assets/img/Learn/overviewpage-rest-api.jpg)

## Design Configuration
  Navigate to **Design Configurations** page and add tag as **pizza**.
        <html><div class="admonition info">
        <p class="admonition-title">Info</p>
        <p>Tags can be used to filter out APIs matching certain search criteria. It is recommended that you add tags that explain the functionality and purpose of the API as subscribers can search for APIs based on the tags.</p>
        </div>
        </html>

  <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>By default **Publisher Access control** allowed for **All** and **Developer Portal visibility** available for **Public**.</p>
      </div>
    </html>
    
![](../../../assets/img/Learn/design-configuration.jpg)

## Runtime Configuration
  Navigate to **Runtime Configuration** page. 

  Transport Level Security  defines the transport protocol on which the API is exposed.  
   ![](../../../assets/img/Learn/transportLevel-security.jpg)

  <html><div class="admonition note">
     <p class="admonition-title">Note</p>
     <p> Both HTTP and HTTPS transports are selected by default.It is able to limit the API availability to only one transport (e.g., HTTPS), clear the checkbox of the other transport.</p>
     </div>
     </html>

## Resources
1. By default, the api will have five resources with /* URL Pattern.
   Click **Show More** option to navigate **Resource** page.
   ![](../../../assets/img/Learn/overview-page-resource-section.jpg)

2. Modify the resources as follows and click **SAVE** to update the resources.
      1. Click following button to remove all resources.
      [![](../../../assets/img/Learn/delete-all-existing-resources.jpg)](../../../assets/img/Learn/delete-all-existing-resources.jpg)

      2. Click + to add new resouce.
          [![](../../../assets/img/Learn/add-new-resource.jpg)](../../../assets/img/Learn/add-new-resource.jpg)
      
      3. Newly added resource is displayed as follows and Click **SAVE**.
         
         [![](../../../assets/img/Learn/newly-added-resource.jpg)](../../../assets/img/Learn/newly-added-resource.jpg)

3. Expand the created **GET** operation to add **Summary and Description** and **Operation governance**.
   Also, resource **Parameters** can be added using **Parameters** section.

      [![](../../../assets/img/Learn/adding-params-to-resources.jpg)](../../../assets/img/Learn/adding-params-to-resources.jpg)

## API Definition
   Navigate to **API Definition** page, then it will display the swagger definition of the phoneVerification API.
   [![](../../../assets/img/Learn/api-definiton-rest.jpg)](../../../assets/img/Learn/api-definiton-rest.jpg)

Now, a REST API has been created and configured successfully. Refer [Publish API](../../../../Learn/DesignAPI/PublishAPI/publish-an-api/) 
to know details of publishing API.

!!! More
        Click the following topics for a description of the concepts that you need to know when creating an API:
       -   [API visibility]()
       -   [Endpoints](../../../../Learn/DesignAPI/Endpoints/endpoint-types/)
       -   [Throttling tiers](../../../../Learn/RateLimiting/introducing-throttling-use-cases/)
       -   [Sequences]()
       -   [Response caching]()



