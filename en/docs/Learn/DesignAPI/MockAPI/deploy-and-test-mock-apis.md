# Deploy and Test Prototype APIs

## Introduction
An **API prototype** is created for the purpose of early promotion and testing. You can deploy a new API or a new version of an existing API as a prototype. It gives subscribers an early implementation of the API that they can try out without a subscription or monetization, and provide feedback to improve. After a period of time, publishers can make changes that the users request and publish the API.

## Deploy a Created API as a Prototype

!!! note
    The example here uses the API `PizzaShackAPI 2.0.0` , which was created by following the instructions in the
    [create new version of an api](../APIVersioning/create-a-new-api-version.md) tutorial.

1.  Sign in to the WSO2 API Publisher `https://<hostname>:9443/publisher` and select the API (e.g., `PizzaShackAPI 2.0.0` ) that you want to prototype.
[![](../../../assets/img/Learn/prototype-api-PizzaShack-publisher.png)](../../../assets/img/Learn/prototype-api-PizzaShack-publisher.png)

2. Click on ***Endpoints*** from the left navigation menu and select ***Prototype Endpoint*** radio button to select
 the prototype endpoint type.
 [![](../../../assets/img/Learn/prototype-api-select-endpoint-type.png)](../../../assets/img/Learn/prototype-api-select-endpoint-type.png)
    and click on ***PROCEED*** in the ***Change Endpoint Type*** dialog box.
    
    <img src="../../../../assets/img/Learn/prototype-api-change-endpoint-confirmation.png" width="400px" />
 
2.  Enter the prototype endpoint for the API. In this example the same endpoint is used.

    Once the endpoint is added, click on ***SAVE*** button to save the api.
    [![](../../../assets/img/Learn/prototype-api-endpoint-added.png)](../../../assets/img/Learn/prototype-api-endpoint-added.png)
    

3.  Click the **Lifecycle** item from the left navigation panel of the API and click **Deploy as Prototype**.
    [![](../../../assets/img/Learn/prototype-api-deploy-as-prototype.png)](../../../assets/img/Learn/prototype-api-deploy-as-prototype.png)

    !!! note
        After creating a new version, you typically deploy it as a prototype for the purpose of testing and early promotion.
   
    
    !!! tip
        -   Leave the **Requires Re-Subscription** check box cleared if you want all users who are subscribed to the older version of the API to be automatically subscribed to the new version. If not, they need to subscribe to the new version again.
        -   You can choose to deprecate old versions of this API at this stage by selecting the **Deprecate Old Versions** check box.


4.  Sign in to the Developer Portal and click on the newly prototyped API `https://<hostname>:9443/devportal`. (Or
 click on the ***View in Dev Portal*** button in the api publisher.)
 [![](../../../assets/img/Learn/prototype-api-view-in-dev-portal.png)](../../../assets/img/Learn/prototype-api-view-in-dev-portal.png)
    
    !!! note
        It is not necessary to log in to the Developer Portal to invoke prototyped APIs.

    [![](../../../assets/img/Learn/prototype-api-in-dev-portal.png)](../../../assets/img/Learn/prototype-api-in-dev-portal.png)
    
    The APIs **Overview** page opens. Note that the Subscriptions are not allowed for this api.

    [![View overview of PizzaShackAPI 2.0.0](../../../assets/img/Learn/prototype-api-subscriptions-not-allowed.png)](../../../assets/img/Learn/prototype-api-subscriptions-not-allowed.png)

5.  To invoke the Prototyped API, click the **Try Out** on the left navigation menu.
   
    [![](../../../assets/img/Learn/prototype-api-try-out-menu.png)](../../../assets/img/Learn/prototype-api-try-out-menu.png)


6.  In the **API Console** of the prototyped API, expand the `GET /menu` method and click **Try it out**.

    [![](../../../assets/img/Learn/prototype-api-menu-try-it-out.png)](../../../assets/img/Learn/prototype-api-menu-try-it-out.png)


7.  Click **Execute** to invoke the API.
    [![](../../../assets/img/Learn/prototype-api-execute.png)](../../../assets/img/Learn/prototype-api-execute.png)
    Note the response that appears in the console. You do not have to subscribe to the API or pass an authorization key to invoke a prototyped API.
    
    [![](../../../assets/img/Learn/prototype-api-success-response.png)](../../../assets/img/Learn/prototype-api-success-response.png)

## Publish a Prototyped API.

To publishing a prototyped api with proper production/ sandbox endpoints (after testing and promotions), follow the
 instructions below.
 
 Once published the api, users will need to subscribe and generate an access token to invoke the api. 

1. Goto the API Publisher and click on the Prototyped api that is required to Publish.
    
    [![](../../../assets/img/Learn/prototype-api-click-on-api.png)](../../../assets/img/Learn/prototype-api-click-on-api.png)
    
2. Goto the ***Lifecycle*** Page by clicking on the Lifecycle menu item from the left navigation panel and click on
 the ***DEMOTE TO CREATED*** button.

    [![](../../../assets/img/Learn/prototype-api-demote-to-created.png)](../../../assets/img/Learn/prototype-api-demote-to-created.png)

4. Check the Requirements section for Publish. 

    !!! tip
        In the Lifecycle page, the requirements for the next lifecycle state change are listed in the right panel.
        You can click the link button next to each requirement item to navigate to the corresponding page.
        [![](../../../assets/img/Learn/api-lifecycle-requirements.png)](../../../assets/img/Learn/api-lifecycle-requirements.png)
        
        
    !!! note
        In this scenario, the current endpoint is set as a prototype endpoint. In order to publish the api, Production / Sandbox endpoints should be provided.
         
    Go to the Endpoints Page by clicking on the Endpoints menu item (or the link icon next to Endpoints Provided in
     the right panel)
   [![](../../../assets/img/Learn/prototype-api-to-endpoints.png)](../../../assets/img/Learn/prototype-api-to-endpoints.png)
 
5. In the Endpoints page, select the Endpoint type.
   [![](../../../assets/img/Learn/prototype-api-select-http-endpoint.png)](../../../assets/img/Learn/prototype-api-select-http-endpoint.png)

6. Check the Production/ Sandbox check boxes, add the corresponding endpoint and click on ***SAVE*** button to save
 the api.
   [![](../../../assets/img/Learn/prototype-api-to-publish-add-endpoint.png)](../../../assets/img/Learn/prototype-api-to-publish-add-endpoint.png)
   
7. To Publish the API, goto the Lifecycle page and Click on ***PUBLISH*** Button.

    [![](../../../assets/img/Learn/prototype-api-publish.png)](../../../assets/img/Learn/prototype-api-publish.png)
   
