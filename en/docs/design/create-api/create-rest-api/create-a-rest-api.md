# Create a REST API

**API creation** is the process of linking an existing backend API implementation to the [API Publisher]({{base_path}}/getting-started/overview/#api-publisher), so that you can manage and monitor the [API's lifecycle]({{base_path}}/design/lifecycle-management/api-lifecycle/), documentation, security, community, and subscriptions. Alternatively, you can provide the API implementation in-line in the [API Publisher]({{base_path}}/getting-started/overview/#api-publisher) itself.

Follow the instructions below to create a REST API using the basic flow.

1. Sign in to the WSO2 API Publisher.

    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    <html><div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The <b>CREATE</b> button will only appear for a user who has the <code>creator</code> role permission.</p>
      </div>
    </html>

2. Select **REST API** from the options available.

    [![]({{base_path}}/assets/img/learn/select-rest-api.png)]({{base_path}}/assets/img/learn/select-rest-api.png)

3.  Click **Start from Scratch**.

    [![]({{base_path}}/assets/img/learn/create-a-rest-api.png)]({{base_path}}/assets/img/learn/create-a-rest-api.png)

4.  Enter API details. 
    
     <table><colgroup> <col/> <col/> <col/> </colgroup><tbody><tr><th colspan="2" >Field</th><th >Sample value</th></tr><tr><td colspan="2" class="confluenceTd">Name</td><td class="confluenceTd">PizzaShack</td></tr><tr><td colspan="2" class="confluenceTd">Version</td><td colspan="1" class="confluenceTd">1.0.0</td></tr><tr><td colspan="2" class="confluenceTd">Context</td><td class="confluenceTd"><div class="content-wrapper"><p><code>/pizzashack</code></p><div><div class="confluence-information-macro-body"><p>The API context is used by the Gateway to identify the API. Therefore, the API context must be unique. This context is the API's root context when invoking the API through the Gateway.</p></div><div class="confluence-information-macro confluence-information-macro-tip"><span class="aui-icon aui-icon-small aui-iconfont-approve confluence-information-macro-icon"></span><div class="confluence-information-macro-body"><p>You can define the API's version as a parameter of its context by adding the <code>{version}</code> into the context. For example, <code>{version}/pizzashack</code>. The API Manager assigns the actual version of the API to the <code>{version}</code> parameter internally. For example, <code>https://localhost:8243/1.0.0/pizzashack</code>. Note that the version appears before the context, allowing you to group your APIs based on the versions.</p></div></div></div></div></td></tr><tr><td colspan="2" class="confluenceTd">Endpoint</td><td colspan="1" class="confluenceTd"><p><a class="external-link" href="http://ws.cdyne.com/phoneverify/phoneverify.asmx" rel="nofollow">https://localhost:9443/am/sample/pizzashack/v1/api/</a></p><p>The endpoint that you add is automatically added as the production and sandbox endpoints.</p></td></tr></tbody></table>
        
     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>The <b>CREATE & PUBLISH</b> option will only appear when a user who has <code>publisher</code> permission adds the details for the <b>Endpoint</b> and <b>Business plan(s)</b>, which are optional fields.</p>
     </div>
     </html>
     
      [![Create an API page]({{base_path}}/assets/img/learn/create-rest-api-form.png)]({{base_path}}/assets/img/learn/create-rest-api-form.png)

5.  Click **CREATE** or **CREATE & PUBLISH** to create the API.

    The overview page of the newly created API appears. 
    
    [![API overview page]({{base_path}}/assets/img/learn/overviewpage-rest-api.png)]({{base_path}}/assets/img/learn/overviewpage-rest-api.png)

6. Go to **Develop** -> **Portal Configurations** and click **Basic Info** on the left-hand panel.

    <html>
     <img src="{{base_path}}/assets/img/learn/click-basic-info.png" width="200">
    </html>
     

     1. Configure the API design configurations.

        [![Design configurations]({{base_path}}/assets/img/learn/design-configuration.png)]({{base_path}}/assets/img/learn/design-configuration.png)

         <html><div class="admonition note">
         <p class="admonition-title">Note</p>
         <p>By default, **All** users who have `creator` permission are allowed **<a href='{{base_path}}/advanced-topics/enable-publisher-access-control-in-api-publisher-portal'>Publisher Access Control</a>** and public **<a href='{{base_path}}/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/'> 
         Developer Portal visibility</a>**.</p>
         <p>
         </div>
         </html>

     2. Add a tag and press enter.
   
         Let's add a tag named **pizza**.

         <html>
         <div class="admonition info">
         <p class="admonition-title">Info</p>
         <p>Tags can be used to filter out APIs matching specific search criteria. It is a good practice to add tags that explain the functionality and purpose of the API so that subscribers can search for APIs based on the tags.</p>
         </div>
         </html>

     3. Optionally, select **Yes** as the **Make this the Default Version** option.
   
         When an API is the default version -

         -  The API will be available in the Gateway without a version specified in the production and sandbox URLs.  
         -  You to create a new version of this API and set it as the default version. Thereafter, the same resources can be invoked in the client applications without changing the API gateway URL. 
         -  You can create new versions of an API with changes, while at the same time allowing the existing client applications to be invoked without the client having to change the URLs.

     4. Click **Save**.

7. Configure the runtime configurations.

     1. Go to **API Configurations**. Click **Runtime**. 

         Transport Level Security  defines the transport protocol on which the API is exposed.  

         [![Transport-level security]({{base_path}}/assets/img/learn/runtime-configs.png)]({{base_path}}/assets/img/learn/runtime-configs.png)

       2. If you wish to limit the API availability to only one transport (e.g., HTTPS), uncheck the **Transport Level Security** checkbox.
           
           Both HTTP and HTTPS transports are selected by default.

8. Configure the resources.

     By default, the API will have five resources with `/*` as the URL pattern.

     1. Go to **API Configurations** and click **Resources** page.
        
        [![Resources overview page]({{base_path}}/assets/img/learn/resources-overview-page.png)]({{base_path}}/assets/img/learn/resources-overview-page.png)

     2. Modify the resources as follows and click **SAVE** to update the resources.

          1. Click delete, as shown below, to remove all the existing resources.

              [![Delete all existing resources]({{base_path}}/assets/img/learn/delete-all-existing-resources.png)]({{base_path}}/assets/img/learn/delete-all-existing-resources.png)

          2. Click **(+)** to add a new resource.
         
             [![Add new resource]({{base_path}}/assets/img/learn/add-new-resource.png)]({{base_path}}/assets/img/learn/add-new-resource.png)
      
             The newly added resource is displayed as follows.
         
             [![Newly added resource]({{base_path}}/assets/img/learn/newly-added-resource.png)]({{base_path}}/assets/img/learn/newly-added-resource.png)

          3. Expand the created **GET** operation to add **Summary and Description** and **Operation governance**.
             
             1. Add a summary and a description of the resource.
             2. Turn the **Security** setting **Off** if you want to **make a certain operation of the API non secured** and accessible without passing an access token. To make the **whole API non secured**, and fully accessible without an access token, turn  the security setting **off** in **all the operations** of the API.
             
                [![Invoke API without Access Token]({{base_path}}/assets/img/learn/invoke-api-without-access-token.png)]({{base_path}}/assets/img/learn/invoke-api-without-access-token.png)
             
             3. In addition, you can add the resource **Parameters** using the **Parameters** section.

                [![]({{base_path}}/assets/img/learn/adding-params-to-resources.png)]({{base_path}}/assets/img/learn/adding-params-to-resources.png)

                You can define the following parameter types based on the resource parameters that you add.

                | Parameter Type                          | Description                                                                                                                                                                                     |
                |-----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
                | `query`| Contains the fields added as part of the invocation URL that contains the data to be used to call the backend service.                                                                             |
                | `header`| Contains the case-sensitive names followed by a colon (:) and then by its value that carries additional information with the request, which defines the operating parameters of the transaction. |
                | `cookie` | Operations can also pass parameters in the Cookie header, as `Cookie: name=value`. Multiple cookie parameters are sent in the same header, separated by a semicolon and space.                                                                                            |
                | `body`| An arbitrary amount of data of any type is sent with a POST message.                                                                                                                                |

9. Optionally view the API definition.

     Click **API Definition**. The OpenAPI Specification (a.k.a Swagger definition) for the PizzaShack API appears.

     [![REST API definition]({{base_path}}/assets/img/learn/api-definiton-rest.png)]({{base_path}}/assets/img/learn/api-definiton-rest.png)

Now, you have successfully created and configured a REST API. Next, let's [Publish your API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api/).

## See Also

Learn more on the concepts that you need to know when creating a REST API:

-   [Endpoints]({{base_path}}/design/endpoints/endpoint-types/)
-   [API Security]({{base_path}}/design/api-security/api-authentication/secure-apis-using-oauth2-tokens/)
-   [Rate Limiting]({{base_path}}/design/rate-limiting/introducing-throttling-use-cases/)
-   [Life Cycle Management]({{base_path}}/design/lifecycle-management/api-lifecycle/)
-   [API Monetization]({{base_path}}/design/api-monetization/monetizing-an-api/)
-   [API Visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/)
-   [API Documentation]({{base_path}}/design/api-documentation/add-api-documentation/)
-   [Custom Properties]({{base_path}}/design/create-api/adding-custom-properties-to-apis/)
