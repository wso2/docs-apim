# Subscribe to an API

You have to **subscribe** to a published API before using it in your applications. Subscription enables you to receive access tokens and be authenticated to invoke the API.

The examples here use the `PizzaShackAPI` REST API, which is created in [Create a REST API ]({{base_path}}//Learn/DesignAPI/CreateAPI/create-a-rest-api) and [published]({{base_path}}/Learn/DesignAPI/PublishAPI/publish-an-api) to API Developer portal.

In the API dev portal,  you will have two methods to subscribe an API to an application. You can subscribe to current API choosing an existing application or you can follow **KEY GENERATION WIZARD** to start from the scratch. The **KEY GENERATION WIZARD** guides you through the process of creating and configure application, generate application keys and access token, and finally navigate to try out page.

##Subscribe to an API using Key Generation Wizard

1.  Sign in to the WSO2 API Developer Portal ( `https://<hostname>:<port>/devportal` ) and click on the API (e.g., `PizzaShackAPI` ) to go to API overview.

    <a href="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" ><img src="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" alt="API Overview" title="API Overview" width="70%" /></a>
 
2.  Click on **KEY GENERATION WIZARD** under **API Credentials** section to start the key generation wizard.

    <a href="{{base_path}}/assets/img/Learn/key-gen-wizard.png" ><img src="{{base_path}}/assets/img/Learn/key-gen-wizard.png" alt="Key Gen Wizard" title="Key Gen Wizard" width="50%" /></a>

3.  In the first step, which is  **Create application**, provide the application details and click **Next** button to continue. Note that ,Default token type is JWT. If you want to change the token type to Oauth, Select **Oauth** from the **Token Type** dropdown and continue.

    <a href="{{base_path}}/assets/img/Learn/key-gen-wizard-create-app.png" ><img src="{{base_path}}/assets/img/Learn/key-gen-wizard-create-app.png" alt="Create App" title="Create App" width="70%" /></a>


4.  In **Subscribe to new application**, you need to subscribe the API to the application which was created in above step. For that, select the preferred throttling policy from the dropdown and click **Next** button to go to next step.

    <a href="{{base_path}}/assets/img/Learn/key-gen-wizard-subscribe.png" ><img src="{{base_path}}/assets/img/Learn/key-gen-wizard-subscribe.png" alt="Subscribe App" title="Subscribe App" width="70%" /></a>
    
5. In **Generate keys** step is to [generate application keys]({{base_path}}/Learn/ConsumeAPI/ManageApplication/GenerateKeys/generate-api-keys)(Production or sandbox). You can choose [grant types]({{base_path}}/Learn/APISecurity/OAuth2/GrantTypes/overview/) which need to be allowed for this application and click **Next** button to continue. Application key and secret will be generated in this step.

    <a href="{{base_path}}/assets/img/Learn/key-gen-wizard-generate-keys.png" ><img src="{{base_path}}/assets/img/Learn/key-gen-wizard-generate-keys.png" alt="Key Gen" title="Key Gen" width="70%" /></a>
    
    !!! note
        - By default, the __Client Credentials__ grant type is used to generate the access token. Make sure the Client Credentials grant type is selected when generating keys from the UI. 
        - If you have a supported callback URL that sends a callback to a specific server or program soon after your application request is sent, you can specify it under the **Callback URL** field.
        
    
6.  In **Generate Access Token** step, an Access token can be generated to invoke the API. The access token validity period and [scopes]({{base_path}}/Learn/APISecurity/OAuth2/OAuth2Scopes/fine-grained-access-control-with-oauth-scopes/) can be selected from the dropdown if required, then click **Next** to continue.


    
7.  In the last step, copy the generated access token. Once it is copied, you can **Finish** the flow or click on **Test** button and navigate to [API Console]({{base_path}}/Learn/ConsumeAPI/InvokeApis/InvokeApisUsingTools/invoke-an-api-using-the-integrated-api-console) to try it out.

    <a href="{{base_path}}/assets/img/Learn/key-gen-wizard-access.png" ><img src="{{base_path}}/assets/img/Learn/key-gen-wizard-access.png" alt="Copy access token" title="Copy access token" width="70%" /></a>
    
##Subscribe to an existing application

If you already have an existing application, follow the steps given below to subscribe to the API using that application.

1.  Sign in to the WSO2 API Developer Portal ( `https://<hostname>:<port>/devportal` ) and click on the API (e.g., `PizzaShackAPI` ) to go to API overview.
    
    <a href="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" ><img src="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" alt="API Overview" title="API Overview" width="70%" /></a>
        
2.  Click on **SUBSCRIBE TO AN APPLICATION** button.

    <a href="{{base_path}}/assets/img/Learn/from-existing-app.png" ><img src="{{base_path}}/assets/img/Learn/from-existing-app.png" alt="Subscribe to new app" title="Subscribe to new app" width="50%" /></a>
    
3.  Select the application from the application dropdown, the throttling policy from the Throttling policy dropdown and click **Subscribe**.

    <a href="{{base_path}}/assets/img/Learn/subscribe-to-app.png" ><img src="{{base_path}}/assets/img/Learn/subscribe-to-app.png" alt="Subscribe to new app" title="Subscribe to new app" width="70%" /></a>
    
4.  You can see the subscriptions list in API credentials section.

    <a href="{{base_path}}/assets/img/Learn/subscription-list.png" ><img src="{{base_path}}/assets/img/Learn/subscription-list.png" alt="Subscribe to new app" title="Subscribe to new app" width="70%" /></a>
    
##Unsubscribe from an API

You can delete the API subscription as follows.

1.  Sign in to the WSO2 API Developer Portal ( `https://<hostname>:<port>/devportal` ) and click on the API (e.g., `PizzaShackAPI` ) that you need to delete an application subscription.
    
    <a href="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" ><img src="{{base_path}}/assets/img/Learn/select-api-dev-portal.png" alt="API Overview" title="API Overview" width="70%" /></a>
    
2.  Go to **Credentials** tab.

    <a href="{{base_path}}/assets/img/Learn/api-credentials.png" ><img src="{{base_path}}/assets/img/Learn/api-credentials.png" alt="API Credentials" title="API Credentials" width="70%" /></a>
    
3.  Select the subscription that you need to delete and click **UNSUBSCRIBE**.

    <a href="{{base_path}}/assets/img/Learn/unsubscribe.png" ><img src="{{base_path}}/assets/img/Learn/unsubscribe.png" alt="Unsubscribe" title="Unsubscribe" width="70%" /></a>


 

