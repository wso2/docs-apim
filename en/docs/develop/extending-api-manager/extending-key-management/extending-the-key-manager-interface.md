# Extending the Key Manager Interface

In a typical WSO2 API Manager (WSO2 API-M) deployment, different components talk to the **KeyManager** interface to achieve different tasks. 

For instance, after creating an application in the Developer Portal, subscribers would click on the `Generate Keys` button to register an application. 

[![Generate Keys]({{base_path}}/assets/img/learn/extensions/key-manager-interface/generate-keys-button.png)]({{base_path}}/assets/img/learn/extensions/key-manager-interface/generate-keys-button.png)

-   At this point, the Developer Portal talks to the **KeyManager** interface to create an *OAuth client* and get the *Consumer Key/Secret* and the *Application Access token*.

-   When the Gateway receives a request, it talks to the **KeyManager** interface and gets the token validated. The **KeyManager** interface checks if the token is active and whether the token can be used to invoke the resource that is being accessed. If the token is valid, the Gateway uses additional details about the token (i.e., the Throttling Tier for the subscription and Consumer key) to determine if the request should be passed to the backend or not.

Therefore, the **KeyManager** interface acts as the bridge between the OAuth Provider and WSO2 API Manager (WSO2 API-M).

## Extending the Key Manager Interface

When you need to write your own implementation to plug an external OAuth2 Authorization Server that will act as the Key Manager, you should implement a third-party Key Manager Connector as explain in 
[Configure a Custom Key Manger]({{base_path}}/administer/key-managers/configure-custom-connector/)


The following are the methods that the `KeyManager` interface uses to carry out operations.

<table>
<colgroup>
<col width="30%" />
<col width="70%" />
</colgroup>
<thead>
<tr class="header">
<th><b>Method</b></th>
<th><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>createApplication</strong></td>
<td>Creates a new OAuth application in the Authorization Server.</td>
</tr>
<tr class="even">
<td><strong>updateApplication</strong></td>
<td>Updates an OAuth application.</td>
</tr>
<tr class="odd">
<td><strong>retrieveApplication</strong></td>
<td>Retrieves an OAuth application.</td>
</tr>
<tr class="even">
<td><strong>getNewApplicationAccessToken</strong></td>
<td>The Developer Portal calls this method to get a new application Access Token. This method is called when getting the token for the first time and when the Developer Portal needs to refresh the existing token.</td>
</tr>
<tr class="odd">
<td><strong>getTokenMetaData</strong></td>
<td>Gets details about the access token.</td>
</tr>
<tr class="even">
<td><strong>getKeyManagerConfiguration</strong></td>
<td>Gets the Key Manager implementation details from the <code>deployment.toml</code> file.</td>
</tr>
<tr class="odd">
<td><strong>buildAccessTokenRequestFromJSON</strong></td>
<td>This method will pass the JSON input and will add those additional values to the Access Token Request. If it is needed to pass any parameters in addition to those specified in the <code>AccessTokenRequest</code>, those parameters can be provided in the JSON input.</td>
</tr>
<tr class="even">
<td><strong>mapOAuthApplication</strong></td>
<td><p>You need to use this method when creating an OAuth application in semi-manual mode when you have a consumer key and secret already generated from a Key Manager and you need to map the key and secret with the existing API-M application.</p></td>
</tr>
<tr class="odd">
<td><strong>buildAccessTokenRequestFromOAuthApp</strong></td>
<td>This method creates an Access Token Request using the OAuth Application information. If the token request is null, this method creates a new object, else it modifies the provided Access Token request.</td>
</tr>
<tr class="even">
<td><strong>loadConfiguration</strong></td>
<td>This method is used to read the Key Manager configuration.</td>
</tr>
<tr class="odd">
<td><strong>registerNewResource</strong></td>
<td>This method talks to the <code>APIResource</code> registration endpoint of the Authorization Server and creates a new resource.</td>
</tr>
<tr class="even">
<td><strong>getResourceByApiId</strong></td>
<td>This method retrieves the registered resource by the given API ID.</td>
</tr>
<tr class="odd">
<td><strong>updateRegisteredResource</strong></td>
<td>This method contains information about all the API resources by its <code>resourceId</code>.</td>
</tr>
<tr class="even">
<td><strong>deleteRegisteredResourceByAPIId</strong></td>
<td>Deletes the registered resource based on the API ID.</td>
</tr>
<tr class="odd">
<td><strong>deleteMappedApplication</strong></td>
<td>Deletes mapping records of OAuth applications.</td>
</tr>
<tr class="even">
<td><strong>getActiveTokensByConsumerKey</strong></td>
<td>Provides all the Active tokens issued against the provided Consumer Key.</td>
</tr>
<tr class="odd">
<td><strong>getAccessTokenByConsumerKey</strong></td>
<td>Provides details of the Access Token that is displayed on the Developer Portal.</td>
</tr>
<tr class="odd">
<td><strong>updateApplicationOwner</strong></td>
<td>Provides the capability to update the application owner of OAuth Application.</td>
</tr>
<tr class="odd">
<td><strong>deleteApplication</strong></td>
<td>Provides the capability to remove an OAuth Application based on the consumer key.</td>
</tr>
<tr class="odd">
<td><strong>buildFromJSON</strong></td>
<td>Provides the capability to build a Model object for the OAuth application creation.</td>
</tr>
<tr class="odd">
<td><strong>registerScope</strong></td>
<td>Provides the capability to register the scope in the OAuth server.</td>
</tr>
<tr class="odd">
<td><strong>getScopeByName</strong></td>
<td>Provides the capability to get the scope by name from the OAuth server.</td>
</tr>
<tr class="odd">
<td><strong>attachResourceScopes</strong></td>
<td>Provides the capability to attach the scope to resources in the Resource server.</td>
</tr>
<tr class="odd">
<td><strong>updateResourceScopes</strong></td>
<td>Provides the capability to update resources that correspond to scope mapping in the OAuth server.</td>
</tr>
<tr class="odd">
<td><strong>detachResourceScopes</strong></td>
<td>Provides the capability to delete resources that correspond to scope mapping in the OAuth server.</td>
</tr>
<tr class="odd">
<td><strong>deleteScope</strong></td>
<td>Provides the capability to delete scope by name in the OAuth server.</td>
</tr>
<tr class="odd">
<td><strong>updateScope</strong></td>
<td>Provides the capability to update the scope in the OAuth server.</td>
</tr>
<tr class="odd">
<td><strong>isScopeExists</strong></td>
<td>Provides the capability to check the existence of scope.</td>
</tr>
<tr class="odd">
<td><strong>validateScopes</strong></td>
<td>Provides the capability to validate scopes from the OAuth server.</td>
</tr>
<tr class="odd">
<td><strong>getUserClaims</strong></td>
<td>Provide the capability to retrieve user claims from the OAuth server that corresponds to thee access token or user.</td>
</tr>
</tbody>
</table>
