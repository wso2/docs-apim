# Deploy and Test Prototype APIs

You would need to create an API prototype for the purpose of early promotion and testing. You can deploy a new API or a new version of an existing API as a prototype. It gives subscribers an early implementation of the API that they can try out without a subscription or monetization, and in-turn the subscribers can provide feedback to improve the API. After a period of time, the publishers can make changes that the users request and publish the API.

## Step 1 - Deploy a created API as a Prototype

!!! note

    The example described in the following steps uses the `PizzaShackAPI 2.0.0` API. For more information on creating this API, see 
    [Create a New API Version]({{base_path}}/learn/design-api/api-versioning/create-a-new-api-version/).

1.  Sign in to the WSO2 API Publisher `https://<hostname>:9443/publisher` and click on the API (e.g., `PizzaShackAPI 2.0.0`) that you want to prototype.
     
     [![PizzaShack API in the Publisher]({{base_path}}/assets/img/learn/prototype-api-pizza-shack-publisher.png)]({{base_path}}/assets/img/learn/prototype-api-pizza-shack-publisher.png)

2. Click **Endpoints** and select **Prototype Endpoint** to select the prototype endpoint type.

     [![Select endpoint]({{base_path}}/assets/img/learn/prototype-api-select-endpoint-type.png)]({{base_path}}/assets/img/learn/prototype-api-select-endpoint-type.png)

3. Click **PROCEED**.
    
     <img src="{{base_path}}/assets/img/learn/prototype-api-change-endpoint-confirmation.png" width="400px" />
 
4.  Enter the prototype endpoint for the API. 

     Let's use the same endpoint in this example.

     
5. Click **SAVE**, after the endpoint is added, to save the API.

     [![Add endpoint]({{base_path}}/assets/img/learn/prototype-api-endpoint-added.png)]({{base_path}}/assets/img/learn/prototype-api-endpoint-added.png)
    

6.  Click **Lifecycle** and click **Deploy as Prototype**.

     [![Deploy API as a prototype in the lifecycle]({{base_path}}/assets/img/learn/prototype-api-deploy-as-prototype.png)]({{base_path}}/assets/img/learn/prototype-api-deploy-as-prototype.png)

    !!! note
        After creating a new version, you typically deploy it as a prototype for the purpose of testing and early promotion.
   
    
    !!! tip
        -   Leave the **Requires Re-Subscription** check box cleared if you want all users who are subscribed to the older version of the API to be automatically subscribed to the new version. If not, they need to subscribe to the new version again.
        -   You can choose to deprecate old versions of this API at this stage by selecting the **Deprecate Old Versions** check box.


4.  Click **View in Dev Portal** in the API Publisher to navigate to the Developer Portal.

     [![View in Dev Portal]({{base_path}}/assets/img/learn/prototype-api-view-in-dev-portal.png)]({{base_path}}/assets/img/learn/prototype-api-view-in-dev-portal.png)
    
    !!! note
        It is not necessary to sign in to the Developer Portal to invoke prototyped APIs.

    [![Prototyped API in Developer Portal]({{base_path}}/assets/img/learn/prototype-api-in-dev-portal.png)]({{base_path}}/assets/img/learn/prototype-api-in-dev-portal.png)
    
    The **Overview** page of the API appears. Note that the Subscriptions are not allowed for this API.

    [![View overview of PizzaShackAPI 2.0.0]({{base_path}}/assets/img/learn/prototype-api-subscriptions-not-allowed.png)]({{base_path}}/assets/img/learn/prototype-api-subscriptions-not-allowed.png)

5.  Click **Try Out** to invoke the Prototyped API. 
   
     [![Try-out menu of prototyped API]({{base_path}}/assets/img/learn/prototype-api-try-out-menu.png)]({{base_path}}/assets/img/learn/prototype-api-try-out-menu.png)


6.  Expand the `GET /menu` method and click **Try it out** in the **API Console** of the prototyped API.

     [![Try-out menu of prototyped API]({{base_path}}/assets/img/learn/prototype-api-menu-try-it-out.png)]({{base_path}}/assets/img/learn/prototype-api-menu-try-it-out.png)


7.  Click **Execute** to invoke the API.

     [![Invoke the API]({{base_path}}/assets/img/learn/prototype-api-execute.png)]({{base_path}}/assets/img/learn/prototype-api-execute.png)

    Note the response that appears in the console. You do not have to subscribe to the API or pass an authorization key to invoke a prototyped API.
    
    [![]({{base_path}}/assets/img/learn/prototype-api-success-response.png)]({{base_path}}/assets/img/learn/prototype-api-success-response.png)

## Step 2 - Publish a Prototyped API

After the API is published, the users need to subscribe and generate an access token to invoke the API.

Follow the instructions below to publish a prototyped API with proper production/sandbox endpoints (after testing and promotions): 

1. Navigate to the API Publisher and click on the Prototyped API that you need to Publish.
    
     [![]({{base_path}}/assets/img/learn/prototype-api-click-on-api.png)]({{base_path}}/assets/img/learn/prototype-api-click-on-api.png)
    
2. Click **Lifecycle** and click **DEMOTE TO CREATED**.

     [![]({{base_path}}/assets/img/learn/prototype-api-demote-to-created.png)]({{base_path}}/assets/img/learn/prototype-api-demote-to-created.png)

3. Check on the **Requirements** section, which lists out the requirements that need to be completed in order to Publish an API. 

    !!! tip
        The requirements for the next lifecycle state change are listed in the Requirements section.
        If there are any requirements that you have not fulfilled, you can click on the link next to each item in the Requirement section to navigate to the corresponding page where you will be able to add the required details.
        [![]({{base_path}}/assets/img/learn/api-lifecycle-requirements.png)]({{base_path}}/assets/img/learn/api-lifecycle-requirements.png)
        
        
    !!! note
        In this scenario, the current endpoint is set as a prototype endpoint. Enter the Production/Sandbox endpoints to publish the API.
         
4. Click **Endpoints**.

     [![]({{base_path}}/assets/img/learn/prototype-api-to-endpoints.png)]({{base_path}}/assets/img/learn/prototype-api-to-endpoints.png)
 
5. Select the Endpoint type.

     [![]({{base_path}}/assets/img/learn/prototype-api-select-http-endpoint.png)]({{base_path}}/assets/img/learn/prototype-api-select-http-endpoint.png)

6. Check the Production/Sandbox check boxes, add the corresponding endpoint, and click **SAVE** to save the API.

     [![]({{base_path}}/assets/img/learn/prototype-api-to-publish-add-endpoint.png)]({{base_path}}/assets/img/learn/prototype-api-to-publish-add-endpoint.png)
   
7. Click **Lifecycle** and click **PUBLISH** to Publish the API.

     [![]({{base_path}}/assets/img/learn/prototype-api-publish.png)]({{base_path}}/assets/img/learn/prototype-api-publish.png)
   
