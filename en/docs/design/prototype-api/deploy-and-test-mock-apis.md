# Deploy and Test Prototype APIs

You would need to create an API prototype for the purpose of early promotion and testing. You can deploy a new API or a new version of an existing API as a prototype. It gives subscribers an early implementation of the API that they can try out without a subscription or monetization, and in-turn the subscribers can provide feedback to improve the API. After a period of time, the publishers can make changes that the users request and publish the API.

## Step 1 - Deploy a created API as a Prototype

!!! note

    The example described in the following steps uses the `PizzaShackAPI 1.0.0` API. For more information on creating this API, see 
    [Create a New API Version]({{base_path}}/design/api-versioning/create-a-new-api-version/).

1.  Sign in to the WSO2 API Publisher `https://<hostname>:9443/publisher` and click on the API (e.g., `PizzaShackAPI 1.0.0`) that you want to prototype.
     
     [![PizzaShack API in the Publisher]({{base_path}}/assets/img/learn/prototype-api-pizza-shack-publisher.png)]({{base_path}}/assets/img/learn/prototype-api-pizza-shack-publisher.png)

2. Click **Endpoints** and select **HTTP/REST Endpoint** to configure the endpoints. Let's use the endpoint `https://localhost:9443/am/sample/pizzashack/v1/api/` in this example.

     [![Select endpoint]({{base_path}}/assets/img/learn/prototype-api/prototype-api-select-endpoint-type.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-select-endpoint-type.png)

3.  Click **SAVE** after the endpoint is added.

    !!! note
        By default, security is enabled for all the resources of the prototype API. follow the [Configure security for the prototype API]({{base_path}}/design/prototype-api/create-a-mock-api-with-an-inline-script/#step-2-configure-security-for-the-prototype-api) guide to disable security.

4.  Click **Lifecycle** and click **Prototype**.

     [![Deploy API as a prototype in the lifecycle]({{base_path}}/assets/img/learn/prototype-api/prototype-api-deploy-as-prototype.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-deploy-as-prototype.png)

    !!! note
        After creating a new version, you typically deploy it as a prototype for the purpose of testing and early promotion.

5.  Click **View in Developer Portal** in the API Publisher to navigate to the Developer Portal.

     [![View in Dev Portal]({{base_path}}/assets/img/learn/prototype-api-view-in-dev-portal.png)]({{base_path}}/assets/img/learn/prototype-api-view-in-dev-portal.png)
    
    !!! note
        If you have enabled security for the prototype API, follow the [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/) guide to subscribe and obtain an access token to invoke the prototype API.
    
    The **Overview** page of the API appears.

    [![View overview of PizzaShackAPI 1.0.0]({{base_path}}/assets/img/learn/prototype-api-subscriptions-not-allowed.png)]({{base_path}}/assets/img/learn/prototype-api-subscriptions-not-allowed.png)

6.  Click **Try Out** to navigate to the API Console. If you have enabled security, you can either use the access token got from the above step or use the **GET TEST KEY** option. Otherwise, leave the Access Token field empty.
   
     [![Try-out menu of prototyped API]({{base_path}}/assets/img/learn/prototype-api/prototype-api-try-out-menu.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-try-out-menu.png)


6.  Expand the `GET /menu` method and click **Try it out** in the **API Console** of the prototyped API.

     [![Try-out menu of prototyped API]({{base_path}}/assets/img/learn/prototype-api/prototype-api-menu-try-it-out.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-menu-try-it-out.png)


7.  Click **Execute** to invoke the API.

     [![Invoke the API]({{base_path}}/assets/img/learn/prototype-api/prototype-api-execute.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-execute.png)

    Note the response that appears in the console. You do not have to subscribe to the API or pass an authorization key to invoke a prototyped API.
    
    [![]({{base_path}}/assets/img/learn/prototype-api/prototype-api-success-response.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-success-response.png)

## Step 2 - Publish a Prototyped API

After the API is published, the users need to subscribe and generate an access token to invoke the API.

Follow the instructions below to publish a prototyped API with proper production/sandbox endpoints (after testing and promotions): 

1. Navigate to the API Publisher and click on the Prototyped API that you need to Publish.
    
     [![]({{base_path}}/assets/img/learn/prototype-api-click-on-api.png)]({{base_path}}/assets/img/learn/prototype-api-click-on-api.png)

2. Click **Lifecycle** and check on the **Requirements** section, which lists out the requirements that need to be completed in order to Publish an API. 

    !!! tip
        The requirements for the next lifecycle state change are listed in the Requirements section.
        If there are any requirements that you have not fulfilled, you can click on the link next to each item in the Requirement section to navigate to the corresponding page where you will be able to add the required details.
        [![]({{base_path}}/assets/img/learn/prototype-api/api-lifecycle-requirements.png)]({{base_path}}/assets/img/learn/prototype-api/api-lifecycle-requirements.png)
   
3. If you have configured the all the requirements for the next lifecycle state click **PUBLISH** to Publish the API.   
