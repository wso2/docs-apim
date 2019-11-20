# Extending the Key Manager Interface

In a typical WSO2 API Manager (WSO2 API-M) deployment, different components talk to the ***KeyManager*** interface to
 achieve different tasks. For instance -

-   After creating an application in API store, subscribers would click on the generate button to register an application. At this point, the API store talks to the ***KeyManager*** to create an OAuth client and get the Consumer Key/Secret and the Application Access token.
-   When the Gateway receives a request, it talks to ***KeyManager*** and get the token validated. The ***KeyManager*** checks if the token is active, and whether the token is usable to invoke the resource being accessed. If the token is valid, the ***KeyManager*** sends additional details about the token (i.e., the Throttling Tier for the subscription and Consumer key) to the Gateway in the response. In turn the Gateway uses these details to determine if the request should be passed to the backend or not.

Therefore, the ***KeyManager*** interface acts as the bridge between the OAuth Provider and WSO2 API Manager (WSO2 API-M).

Implement the ***KeyManager*** interface, which is a Java extension point in WSO2 API-M, when you are writing your own implementation to plug an external OAuth2 authorization server, which will act as the Key Manager. 
For this purpose uncomment and update the API Key Manager details under `[apim.key_manager]` and specify
 the custom class implementation as follows in the `<API-M_Home>/repository/conf/deployment.toml` file.

``` toml
    [apim.key_manager]
    ...
    key_manager_client_impl="org.wso2.carbon.mit.OpenIDClientImpl"
```

The following are the methods that the `KeyManager` interface uses to carry out operations.

- `createApplication` - Creates a new OAuth application in the Authorization Server.

- `updateApplication` - Updates an OAuth application.

- `retrieveApplication` - Retrieves an OAuth application.

- `getNewApplicationAccessToken` - The Store calls this method to get a new application Access Token. This method is
 called when getting the token for the first time and when the Store needs to refresh the existing token.

- `getTokenMetaData` - Gets details about an access token.

- `getKeyManagerConfiguration` - Gets Key Manager implementation from `deployment.toml` file.

- `buildAccessTokenRequestFromJSON` - This method will parse the JSON input and add those additional values to the
 Access Token Request. If it is needed to pass parameters in addition to those specified in the AccessTokenRequest, those parameters can be provided in the JSON input.          `

- `mapOAuthApplication` - You need to use this method when creating an OAuth application in semi-manual mode when you
 have a consumer key and secret already generated from a Key Manager and you need to map the key and secret with the existing API-M application.

- `buildAccessTokenRequestFromOAuthApp` - This method creates an Access Token Request using the OAuth Application
 information. If the token request is null, this method creates a new object, else it modifies the provided Access Token request.

- `loadConfiguration`

- `registerNewResource` - This method talks to the `APIResource` registration endpoint of the authorization server
 and creates a new resource.

- `getResourceByApiId` - This method retrieves the registered resource by the given API ID.

- `updateRegisteredResource` - This method contains information about all the API resource by its `resourceId` .

- `deleteRegisteredResourceByAPIId` - Deletes the registered resource based on the API ID.

- `deleteMappedApplication` - Deletes mapping records of oAuth applications.

- `getActiveTokensByConsumerKey` - Provides all the Active tokens issued against the provided Consumer Key.

- `getAccessTokenByConsumerKey` - Provides details of the Access Token that is displayed on the Store.


