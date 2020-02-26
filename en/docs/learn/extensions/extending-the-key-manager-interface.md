# Extending the Key Manager Interface

### Purpose of the Key Manager

In a typical WSO2 API Manager (WSO2 API-M) deployment, different components talk to the **KeyManager** interface to achieve different tasks. 

For instance,

-   After creating an application in Developer Portal, subscribers would click on the `Generate Keys` button to register an application. 

    ![Generate Keys]({{base_path}}/assets/img/learn/extensions/KeyManagerInterface/generate-keys-button.png)

-   At this point, the Developer Portal talks to the **KeyManager** to create an *OAuth client* and get the *Consumer Key/Secret* and the *Application Access token*.

-   When the Gateway receives a request, it talks to **KeyManager** and get the token validated. The **KeyManager** checks if the token is active, and whether the token is usable to invoke the resource being accessed. If the token is valid, the **KeyManager** sends additional details about the token (i.e., the Throttling Tier for the subscription and Consumer key) to the Gateway in the response. In turn the Gateway uses these details to determine if the request should be passed to the backend or not.

Therefore, the **KeyManager** interface acts as the bridge between the OAuth Provider and WSO2 API Manager (WSO2 API-M).

### Extending the Key Manager Interface

When you need to write your own implementation to plug an external OAuth2 authorization server which will act as the Key Manager, you should implement the [**KeyManager** interface](https://github.com/wso2/carbon-apimgt/blob/master/components/apimgt/org.wso2.carbon.apimgt.api/src/main/java/org/wso2/carbon/apimgt/api/model/KeyManager.java) which is a Java extension point in WSO2 API-M.

For this purpose uncomment and update the API Key Manager details under `[apim.key_manager]` and add the custom class implementation as follows in the `<API-M_Home>/repository/conf/deployment.toml` file.

``` toml
[apim.key_manager]
...
key_manager_client_impl="org.wso2.carbon.mit.OpenIDClientImpl"
```

The following are the methods that the `KeyManager` interface uses to carry out operations.

<table>
<colgroup>
<col width="30%" />
<col width="70%" />
</colgroup>
<thead>
<tr class="header">
<th>Method</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>createApplication</strong></td>
<td><p>Creates a new OAuth application in the Authorization Server.</p></td>
</tr>
<tr class="even">
<td><strong>updateApplication</strong></td>
<td><p>Updates an OAuth application.</p></td>
</tr>
<tr class="odd">
<td><strong>retrieveApplication</strong></td>
<td><p>Retrieves an OAuth application.</p></td>
</tr>
<tr class="even">
<td><strong>getNewApplicationAccessToken</strong></td>
<td><p>The Developer Portal calls this method to get a new application Access Token. This method is called when getting the token for the first time and when the Developer Portal needs to refresh the existing token.
</p></td>
</tr>
<tr class="odd">
<td><strong>getTokenMetaData</strong></td>
<td><p>Gets details about an access token.</p></td>
</tr>
<tr class="even">
<td><strong>getKeyManagerConfiguration</strong></td>
<td><p>Gets Key Manager implementation from <i>deployment.toml</i> file.</p></td>
</tr>
<tr class="odd">
<td><strong>buildAccessTokenRequestFromJSON</strong></td>
<td><p>This method will parse the JSON input and add those additional values to the Access Token Request. If it is needed to pass parameters in addition to those specified in the AccessTokenRequest, those parameters can be provided in the JSON input.</p></td>
</tr>
<tr class="even">
<td><strong>mapOAuthApplication</strong></td>
<td><p>You need to use this method when creating an OAuth application in semi-manual mode when you have a consumer key and secret already generated 
from a Key Manager and you need to map the key and secret with the existing API-M application.</p></td>
</tr>
<tr class="odd">
<td><strong>buildAccessTokenRequestFromOAuthApp</strong></td>
<td><p>This method creates an Access Token Request using the OAuth Application information. If the token request is null, this method creates a new object, else it modifies the provided Access Token request.</p></td>
</tr>
<tr class="even">
<td><strong>loadConfiguration</strong></td>
<td><p>This method is used to read the Key Manager configuration.</p></td>
</tr>
<tr class="odd">
<td><strong>registerNewResource</strong></td>
<td><p>This method talks to the <i>APIResource</i> registration endpoint of the authorization server and creates a new resource.</p></td>
</tr>
<tr class="even">
<td><strong>getResourceByApiId</strong></td>
<td><p>This method retrieves the registered resource by the given API ID.</p></td>
</tr>
<tr class="odd">
<td><strong>updateRegisteredResource</strong></td>
<td><p>This method contains information about all the API resources by its <i>resourceId</i>.</p></td>
</tr>
<tr class="even">
<td><strong>deleteRegisteredResourceByAPIId</strong></td>
<td><p>Deletes the registered resource based on the API ID.</p></td>
</tr>
<tr class="odd">
<td><strong>deleteMappedApplication</strong></td>
<td><p>Deletes mapping records of OAuth applications.</p></td>
</tr>
<tr class="even">
<td><strong>getActiveTokensByConsumerKey</strong></td>
<td><p>Provides all the Active tokens issued against the provided Consumer Key.</p></td>
</tr>
<tr class="odd">
<td><strong>getAccessTokenByConsumerKey</strong></td>
<td><p>Provides details of the Access Token that is displayed on the Developer Portal.</p></td>
</tr>
</tbody>
</table>
