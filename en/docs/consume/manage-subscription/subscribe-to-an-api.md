# Subscribe to an API

You have to **subscribe** to a published API before using it in your applications. The subscription process fulfills the authentication process and provides you with access tokens that you can use to invoke an API. 

The examples here use the `PizzaShackAPI` REST API, which is [created]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api) and [published]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api) to Developer Portal in WSO2 API Manager.

The following are the two methods available in the Developer Portal to subscribe an API to an application. 

- Subscribe to an existing application

    You can subscribe to a current API by selecting an existing application. 

- Subscribe to an API using Key Generation Wizard

    You can use the **SUBSCRIPTION & KEY GENERATION WIZARD** option to start the subscription process from scratch. It guides you through the process of creating and configuring an application, generating application keys and access tokens, and finally navigates you to the try out page.

## Subscribe to an API using Key Generation Wizard

1.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click on the API (e.g., `PizzaShackAPI`) to go to the API overview.

     ![[API overview]({{base_path}}/assets/img/learn/select-api-dev-portal.png)]({{base_path}}/assets/img/learn/select-api-dev-portal.png)
 
2.  Click **SUBSCRIPTION & KEY GENERATION WIZARD** to start the key generation wizard.

    <a href="{{base_path}}/assets/img/learn/key-generation-wizard.png" ><img src="{{base_path}}/assets/img/learn/key-generation-wizard.png" alt="Key Gen Wizard" title="Key Gen Wizard" /></a>

3.  Enter the application details in the **Create application** process and click **Next** to continue.

    [![Create application process in the wizard]({{base_path}}/assets/img/learn/key-gen-wizard-create-app.png)]({{base_path}}/assets/img/learn/key-gen-wizard-create-app.png)

4.  Subscribe the API to the application that you created in the above step by selecting the preferred throttling policy. Thereafter, click **Next** to go to the next step.
     
     [![Subscribe to new application process]({{base_path}}/assets/img/learn/key-gen-wizard-subscribe.png)]({{base_path}}/assets/img/learn/key-gen-wizard-subscribe.png)
    
5. [Generate application keys]({{base_path}}/consume/manage-application/generate-keys/generate-api-keys) (Production or sandbox) by clicking on the **Next** button. 

     The application keys are generated in this step.

     [![Key generation]({{base_path}}/assets/img/learn/key-gen-wizard-generate-keys.png)]({{base_path}}/assets/img/learn/key-gen-wizard-generate-keys.png)
    
    !!! note
        - By default, the __Client Credentials__ grant type is used to generate the access token in Developer Portal.
        - If you want to select different grant types for this application, you can select the required grant types from the application listing page as shown in the following image:

        [![Edit grant types]({{base_path}}/assets/img/learn/edit-application-grant-types.png)]({{base_path}}/assets/img/learn/edit-application-grant-types.png)
        
    
6.  Select the access token validity period and [scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/) to generate an access token to invoke the API, then click **Next** to continue.
    
7.  Copy the generated access token. 

8. Click **Finish** to complete the wizard or click **Test** to navigate to the [API Console]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console) so that you can invoke and try out the API.

    [![Copy access token]({{base_path}}/assets/img/learn/key-gen-wizard-access.png)]({{base_path}}/assets/img/learn/key-gen-wizard-access.png)
    
## Subscribe to an existing application

If you already have an existing application, follow the instructions below to subscribe to the API using that application.

1.  Sign in to the Developer Portal (`https://<hostname>:<port>/devportal`) and click on the API (e.g., `PizzaShackAPI`) to go to the API overview.

     [![API overview]({{base_path}}/assets/img/learn/select-api-dev-portal.png)]({{base_path}}/assets/img/learn/select-api-dev-portal.png)
        
2.  Click **SUBSCRIBE TO AN APPLICATION**.

     <a href="{{base_path}}/assets/img/learn/from-existing-app.png" ><img src="{{base_path}}/assets/img/learn/from-existing-app.png" alt="Subscribe to new app" title="Subscribe to new app" /></a>
    
3.  Select the application, the throttling policy, and click **Subscribe**.

     [![Subscribe to new application]({{base_path}}/assets/img/learn/subscribe-to-app.png)]({{base_path}}/assets/img/learn/subscribe-to-app.png)
    
     You can see the subscriptions list in the **Subscriptions** section.
     
     [![Subscribe to new app]({{base_path}}/assets/img/learn/subscription-list.png)]({{base_path}}/assets/img/learn/subscription-list.png)

## Update the subscription tier

1.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`). Click on **Applications** and select the relevant application. 

    [![applications overview_tab]({{base_path}}/assets/img/learn/application-overview.png)]({{base_path}}/assets/img/learn/application-overview.png)

2.  Click **Subscriptions** to list the subscriptions of the application.

    ![Subscriptions overview_tab]({{base_path}}/assets/img/learn/subscriptions-overview-tab.png)
 
3.  Click the **EDIT** icon  of the subscription whose tier needs to be changed, to open the subscription update popup.

    ![Subscriptions update_popup]({{base_path}}/assets/img/learn/subscription-update-popup-start.png)

4.  Select the throttling tier that needs to be updated and click **Update**. This will update the existing subscription with the newly selected throttling tier.
    
    ![Subscription_update_completed]({{base_path}}/assets/img/learn/subscription-update-completed.png)

Follow the steps mentioned in [Adding an API Subscription Update Workflow]({{base_path}}/consume/manage-subscription/advanced-topics/adding-an-api-subscription-tier-update-workflow) if you need to configure an approval process to update the subscription tier. 

## Unsubscribe from an API

Follow the instructions below to delete the API subscription:

1.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click on the API (e.g., `PizzaShackAPI`) for which you need to delete the application subscription.
    
    [![API Overview]({{base_path}}/assets/img/learn/select-api-dev-portal.png)]({{base_path}}/assets/img/learn/select-api-dev-portal.png)
    
2.  Click **Subscriptions**.

    [![API credentials]({{base_path}}/assets/img/learn/api-credentials.png)]({{base_path}}/assets/img/learn/api-credentials.png)
    
3.  Select the subscription that you need to delete and click **UNSUBSCRIBE**.

    [![]({{base_path}}/assets/img/learn/unsubscribe.png)]({{base_path}}/assets/img/learn/unsubscribe.png)
    
