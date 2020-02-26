# Subscribe to an API

You have to **subscribe** to a published API before using it in your applications. The subscription process fulfills the authentication process and provides you with access tokens that you can use to invoke an API. 

The examples here use the `PizzaShackAPI` REST API, which is [created]({{base_path}}//learn/design-api/create-api/create-a-rest-api) and [published]({{base_path}}/learn/design-api/publish-api/publish-an-api) to Developer Portal in WSO2 API Manager.

The following are the two methods available in the Developer Portal to subscribe an API to an application. 

- Subscribe to an existing application

    You can subscribe to a current API by selecting an existing application. 

- Subscribe to an API using Key Generation Wizard

    You can use the **KEY GENERATION WIZARD** option to start the subscription process from scratch. The **KEY GENERATION WIZARD** guides you through the process of creating and configuring an application, generating application keys and access tokens, and finally navigates you to the try out page.

## Subscribe to an API using Key Generation Wizard

1.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click on the API (e.g., `PizzaShackAPI`) to go to the API overview.

     ![[API overview]({{base_path}}/assets/img/learn/select-api-dev-portal.png)]({{base_path}}/assets/img/learn/select-api-dev-portal.png)
 
2.  Click **KEY GENERATION WIZARD** to start the key generation wizard.

    <a href="{{base_path}}/assets/img/learn/key-gen-wizard.png" ><img src="{{base_path}}/assets/img/learn/key-gen-wizard.png" alt="Key Gen Wizard" title="Key Gen Wizard" width="60%" /></a>

3.  Enter the application details in the **Create application** process and click **Next** to continue.
    
     Note that the default token type is `JWT`. If you want to change the token type to `Oauth`, Select **Oauth** as the **Token Type** and continue.

     [![Create application process in the wizard]({{base_path}}/assets/img/learn/key-gen-wizard-create-app.png)]({{base_path}}/assets/img/learn/key-gen-wizard-create-app.png)

4.  Subscribe the API to the application that you created in above step by selecting the preferred throttling policy. Thereafter, click **Next** to go to next step.
     
     [![Subscribe to new application process]({{base_path}}/assets/img/learn/key-gen-wizard-subscribe.png)]({{base_path}}/assets/img/learn/key-gen-wizard-subscribe.png)
    
5. [Generate application keys]({{base_path}}/learn/consume-api/manage-application/generate-keys/generate-api-keys) (Production or sandbox) by selecting the [grant types]({{base_path}}/learn/api-security/oauth2/grant-types/overview/) which need to be allowed for this application. Thereafter, click **Next** to continue. 

     The application key and secret is generated in this step.

     [![Key generation]({{base_path}}/assets/img/learn/key-gen-wizard-generate-keys.png)]({{base_path}}/assets/img/learn/key-gen-wizard-generate-keys.png)
    
    !!! note
        - By default, the __Client Credentials__ grant type is used to generate the access token. Make sure the Client Credentials grant type is selected when generating keys from the UI. 
        - If you have a supported callback URL that sends a callback to a specific server or program soon after your application request is sent, you can specify it under the **Callback URL** field.
        
    
6.  Select the access token validity period and [scopes]({{base_path}}/learn/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/) to generate an access token to invoke the API, then click **Next** to continue.
    
7.  Copy the generated access token. 

8. Click **Finish** to complete the wizard or click **Test** to navigate to the [API Console]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console) so that you can invoke and try out the API.

    [![Copy access token]({{base_path}}/assets/img/learn/key-gen-wizard-access.png)]({{base_path}}/assets/img/learn/key-gen-wizard-access.png)
    
## Subscribe to an existing application

If you already have an existing application, follow the instructions below to subscribe to the API using that application.

1.  Sign in to the Developer Portal (`https://<hostname>:<port>/devportal`) and click on the API (e.g., `PizzaShackAPI`) to go to the API overview.

     [![API overview]({{base_path}}/assets/img/learn/select-api-dev-portal.png)]({{base_path}}/assets/img/learn/select-api-dev-portal.png)
        
2.  Click **SUBSCRIBE TO AN APPLICATION**.

     <a href="{{base_path}}/assets/img/learn/from-existing-app.png" ><img src="{{base_path}}/assets/img/learn/from-existing-app.png" alt="Subscribe to new app" title="Subscribe to new app" width="60%" /></a>
    
3.  Select the application, the throttling policy, and click **Subscribe**.

     [![Subscribe to new application]({{base_path}}/assets/img/learn/subscribe-to-app.png)]({{base_path}}/assets/img/learn/subscribe-to-app.png)
    
     You can see the subscriptions list in API credentials section.

     [![Subscribe to new app]({{base_path}}/assets/img/learn/subscription-list.png)]({{base_path}}/assets/img/learn/subscription-list.png)
    
## Unsubscribe from an API

Follow the instructions below to delete the API subscription:

1.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click on the API (e.g., `PizzaShackAPI`) for which you need to delete the application subscription.
    
    [![API Overview]({{base_path}}/assets/img/learn/select-api-dev-portal.png)]({{base_path}}/assets/img/learn/select-api-dev-portal.png)
    
2.  Click **Credentials**.

    [![API credentials]({{base_path}}/assets/img/learn/api-credentials.png)]({{base_path}}/assets/img/learn/api-credentials.png)
    
3.  Select the subscription that you need to delete and click **UNSUBSCRIBE**.

    [![]({{base_path}}/assets/img/learn/unsubscribe.png)]({{base_path}}/assets/img/learn/unsubscribe.png)
    


 

