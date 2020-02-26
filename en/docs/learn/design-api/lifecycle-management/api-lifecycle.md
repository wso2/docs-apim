# API Lifecycle

The API lifecycle is one of the key factors in API management. An API lifecycle has predefined states. These states represent the stages that an API has in the process of starting to develop an API until it's retirement. WSO2 API Manager related APIs has a lifecycle that contains six stages which allows you to identify in which state that the API is currently in.

## API lifecycle states

The following API lifecycle states are available in the default API lifecycle.

|   **API Lifecycle State** |   **Use Case** |   **Action**  |
|-----------------------|------------|-----------|
|   **CREATED**         | The API has been created, but it is not available for usage.| API metadata is added to the Developer Portal, but it is not deployed in the API Gateway and therefore, it is not visible to subscribers in the Developer Portal.|
|   **PROTOTYPED**      | An API prototype is created for the purpose of early promotion and testing. You can deploy a new API or a new version of an existing API as a prototype. It gives subscribers an early implementation of the API that they can try out without a subscription.|The API is deployed and published in the Developer Portal as a prototype. A prototyped API is usually a mock implementation made public in order to get feedback on its usability. Users can invoke the API without a subscription.|
|   **PUBLISHED**       | The API is ready to be used by users in the Developer Portal.| The API is visible in the Developer Portal and available for subscription.|
|   **BLOCKED**         | The API is temporarily blocked from being used. A publisher can publish the API from the BLOCKED state.| Access to the API is temporarily blocked. Runtime calls are blocked and the API is not shown in the Developer Portal anymore.|
|   **DEPRECATED**      | The old version of the API is DEPRECATED when a newer version of the API is created and PUBLISHED.| When an API is deprecated, new subscriptions are disabled. However, the API is still deployed in the Gateway and is available at runtime to existing subscribers. Existing subscribers can continue to use it as usual until the API is retired.|
|   **RETIRED**         | The API is no longer in use and has been moved to the RETIRED state.| The API is unpublished from the API Gateway and deleted from the Developer Portal.|

## Manage API lifecycle

The lifecycle of an API can be managed by API Publisher users, using API Publisher in WSO2 API Manager. 

Follow the instructions below to manage the API lifecycle appropriately:

1.  Sign in to API Publisher.
    
     `https://localhost:9443/publisher/`

2.  Click on the API for which you need to change its lifecycle state.

     <a href="{{base_path}}/assets/img/learn/select-created-api.png" ><img src="{{base_path}}/assets/img/learn/select-created-api.png" alt="Select API" title="Select API" width="35%" /></a>

3.  Click **Lifecycle**.

     <a href="{{base_path}}/assets/img/learn/lifecycle-tab.png" ><img src="{{base_path}}/assets/img/learn/lifecycle-tab.png" alt="Lifecycle tab" title="Lifecycle tab" width="70%" /></a>
    
     The lifecycle state transition grid and the lifecycle change history appears. The current lifecycle state and the next possible lifecycle transitions are available in lifecycle state grid. The lifecycle history contains the data such as the lifecycle transition action, the user who performed the transition and the timestamp of the state change. 

4. Click on the lifecycle state change buttons to change the lifecycle state.

     [![]({{base_path}}/assets/img/learn/lifecycle-transition-grid.png")]({{base_path}}/assets/img/learn/lifecycle-transition-grid.png")
    




