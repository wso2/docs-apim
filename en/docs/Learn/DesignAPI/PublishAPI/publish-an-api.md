# Publish an API

**API Publishing** is the process of making the API visible in the API Developer Portal and available for subscription. An API in the lifecycle state CREATED will have the  API metadata added to the API Developer Portal, but not deployed to the API Gateway. Therefore, it is not visible to subscribers in the API Developer Portal. When the API is published, it will get deployed on the API Gateway and the API lifecycle state will be changed to **PUBLISHED**. 

Follow the steps below to publish an API from the WSO2 API Manager.

1.  Sign in to the API Publisher (`https://localhost:9443/publisher`). 

2.  Upon signing in, the list of APIs in the API Publisher is listed. If there are no API created, [create an API]({{base_path}}/Learn/DesignAPI/CreateAPI/create-a-rest-api/) before starting.

3.  Click on an API in the **CREATED** state.

    <a href="../../../../assets/img/Learn/select-created-api.png" ><img src="../../../../../assets/img/Learn/select-created-api.png" alt="Select API" title="Select API" width="35%" /></a>


4.  Go to API's Lifecycle tab.

    <a href="../../../../../assets/img/Learn/lifecycle-tab.png" ><img src="../../../../../assets/img/Learn/lifecycle-tab.png" alt="Lifecycle tab" title="Lifecycle tab" width="70%" /></a>
    
5.  In Lifecycle tab, you will find the lifecycle state transition grid. Before publishing an API, following requirements has to be satisfied.

    -   Endpoint provided
    -   Business Plan(s) selected
    
    If any of the requirements are not satisfied, that will be indicated in the lifecycle page and you need to navigate to relevant sections are provide missing information such as endpoint URL and business plans.
  
    <a href="../../../../../assets/img/Learn/publish-api-requirements.png" ><img src="../../../../../assets/img/Learn/publish-api-requirements.png" alt="Lifecycle tab" title="Lifecycle tab" width="70%" /></a>  
    
6.  If the requirements are satisfied, click on **PUBLISH** button to push the API. If required, following options can be selected when publishing the API. 

    -   **Require re-subscription when publish the API** : Invalidates current user subscriptions, forcing users to subscribe again. 
    -   **Deprecate old versions after publish the API** : If selected, any prior versions of the API that are published will be set to the DEPRECATED state automatically.

    <a href="../../../../../assets/img/Learn/publish-api.png" ><img src="../../../../../assets/img/Learn/publish-api.png" alt="Publish API" title="Publish API" width="70%" /></a>  

7.  If the API publish is successful, the lifecycle state will be transferred to **PUBLISHED**. 

    <a href="../../../../../assets/img/Learn/api-state-change-to-publish.png" ><img src="../../../../../assets/img/Learn/api-state-change-to-publish.png" alt="Publish API" title="Publish API" width="70%" /></a>  
    
    Then go to the API Developer Portal ( `https://<hostname>:9443/devportal)` using your browser and note that the API which was published is visible under the **APIs** listing.


