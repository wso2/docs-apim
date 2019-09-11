# Store APIs


-   [Login](#StoreAPIs-Login)
-   [Logout](#StoreAPIs-Logout)
-   [User Signup](#StoreAPIs-UserSignup)
-   [Search APIs](#StoreAPIs-SearchAPIs)
-   [Get all Paginated Published APIs](#StoreAPIs-GetallPaginatedPublishedAPIs)
-   [Add an Application](#StoreAPIs-AddanApplication)
-   [Update an Application](#StoreAPIs-UpdateanApplication)
-   [Get Applications](#StoreAPIs-GetApplications)
-   [Get an Application by Name](#StoreAPIs-GetanApplicationbyName)
-   [Remove an Application](#StoreAPIs-RemoveanApplication)
-   [Generate an Application Key](#StoreAPIs-GenerateanApplicationKey)
-   [Update an Application Key](#StoreAPIs-UpdateanApplicationKey)
-   [Add a Subscription](#StoreAPIs-AddaSubscription)
-   [List Subscriptions](#StoreAPIs-ListSubscriptions)
-   [List Subscriptions by Application](#StoreAPIs-ListSubscriptionsbyApplication)
-   [List Subscriptions by API](#StoreAPIs-ListSubscriptionsbyAPI)
-   [Remove a Subscription](#StoreAPIs-RemoveaSubscription)
-   [Delete an OAuth Application](#StoreAPIs-DeleteanOAuthApplication)
-   [Provision an Out-of-Band OAuth Client](#StoreAPIs-ProvisionanOut-of-BandOAuthClient)
-   [Clean Partially Created Keys](#StoreAPIs-CleanPartiallyCreatedKeys)
-   [Get all Documentation](#StoreAPIs-GetallDocumentation)
-   [Get the Contents of a File Document](#StoreAPIs-GettheContentsofaFileDocument)
-   [Add an API Comment](#StoreAPIs-AddanAPIComment)
-   [Get all Endpoint URLs](#StoreAPIs-GetallEndpointURLs)
-   [Get all Available Tiers](#StoreAPIs-GetallAvailableTiers)
-   [Update Grant Types](#StoreAPIs-UpdateGrantTypes)

!!! note
**Note** : When you access any API other than the login and logout APIs through an external REST client such as cURL, first invoke the login API to ensure that user is authenticated. When the login API is invoked, the system stores the generated session cookie in a file, which we use in the next API invocations.

The responses is a JSON message.


#### Login

|                |                                                                                                                                                                      |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Log in to API Store.                                                                                                                                                 |
| URI            | <http://localhost:9763/store/site/blocks/user/login/ajax/login.jag>                                                                                                  |
| URI Parameters | `action=login&username=<username>&password=<password>`|
| HTTP Methods   | POST                                                                                                                                                                 |
| Example        | `curl -X POST -c cookies http://localhost:9763/store/site/blocks/user/login/ajax/login.jag -d 'action=login&username=admin&password=admin'` |

#### Logout

|                |                                                                                                                                                                        |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Log out from API Store.                                                                                                                                                |
| URI            | [http://localhost:9763/store/site/blocks/user/login/ajax/login.jag?action=logout](http://localhost:9763/publisher/site/blocks/user/login/ajax/login.jag?action=logout) |
| URI Parameters | `?action=logout`|
| HTTP Methods   | GET                                                                                                                                                                    |
| Example        | `curl -b cookies http://localhost:9763/store/site/blocks/user/login/ajax/login.jag?action=logout`|

#### User Signup

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Add a new API Consumer.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/user/sign-up/ajax/user-add.jag" class="uri">http://localhost:9763/store/site/blocks/user/sign-up/ajax/user-add.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><code>             action=addUser&amp;username=&lt;username&gt;&amp;password=&lt;password&gt;&amp;allFieldsValues=&lt;first_name&gt;|&lt;last_name&gt;|&lt;organization&gt;|&lt;address&gt;|&lt;country&gt;|&lt;email&gt;|&lt;land&gt;|&lt;mobile&gt;|&lt;IM&gt;|&lt;url&gt;            </code></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl '                             http://localhost:9763/store/site/blocks/user/sign-up/ajax/user-add.jag'                            -H 'Accept: application/json --data 'action=addUser&amp;kimhill=username&amp;password=kimhill1234&amp;allFieldsValues=Kim|Hill|ABC Network|30 Palm Road ,Pasadena,California|USA|kim@abcnetwork.com|0016269934122|0016269934134|kimhill|www.abcNsounds.org/'             </code></p></td>
</tr>
</tbody>
</table>

#### Search APIs

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Search for APIs using a given query.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="http://localhost:9763/store/site/blocks/search/api-search/ajax/search.jag" class="uri">http://localhost:9763/store/site/blocks/search/api-search/ajax/search.jag</a></p></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=searchAPIs&amp;query=&lt;query&gt;&amp;start=&lt;number&gt;&amp;end=&lt;number&gt;             </code></p>
<p>The <strong><code>               start              </code></strong> and <strong><code>               end              </code></strong> parameters determine the range of APIs you want to retrieve. For example, if start=1 and end=3, the first 3 APIs that appear in the search results will be returned. <strong>Note</strong> that both 0 and 1 represent the first API in the search results, so start=0 and start=1 both means the same.</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -X POST -b cookies &quot;http://localhost:9763/store/site/blocks/search/api-search/ajax/search.jag&quot; -d &quot;action=searchAPIs&amp;query=test&amp;start=0&amp;end=3&quot;             </code></p></td>
</tr>
</tbody>
</table>

#### Get all Paginated Published APIs

|                |                                                                                                                                                                                                                                               |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Get a list of all published APIs in paginated form so that browsing is easier.                                                                                                                                                                |
| URI            | <http://localhost:9763/store/site/blocks/api/listing/ajax/list.jag>                                                                                                                                                                           |
| URI Parameters | action= *getAllPaginatedPublishedAPIs* , tenant, start, end, returnAPITags (optional)                                                                                                                                                         
                                                                                                                                                                                                                                                 
  The `start` and `end` parameters determine the range of APIs you want to retrieve. For example, if start=1 and end=10, the first 10 APIs that appear in the API Store will be returned.  
                                                                                                                                                                                                                                                 
  The `returnAPITags` parameter is optional. If `returnAPITags=true` , the system makes a call to the registry and returns the tags of each API in the response.                           |
| HTTP Methods   | GET                                                                                                                                                                                                                                           |
| Example        | To get the first 100 APIs in the API Store:                                                                                                                                                                                                   
                                                                                                                                                                                                                                                 
`curl -b cookies "http://localhost:9763/store/site/blocks/api/listing/ajax/list.jag?action=getAllPaginatedPublishedAPIs&tenant=carbon.super&start=1&end=100"`|

!!! note
Please note that the `getAllPublishedAPIs` API is now deprecated. You can get the same functionality from `getAllPaginatedPublishedAPIs` .


#### Add an Application

|                |                                                                                                                                                                                                                              |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Add a new application.                                                                                                                                                                                                       |
| URI            | <http://localhost:9763/store/site/blocks/application/application-add/ajax/application-add.jag>                                                                                                                               |
| URI Parameters | `action=addApplication&application=xxx&tier=xxx&description=xxx`|
| HTTP Methods   | POST                                                                                                                                                                                                                         |
| Example        | `curl -X POST -b cookies http://localhost:9763/store/site/blocks/application/application-add/ajax/application-add.jag -d 'action=addApplication&application=NewApp1&tier=Unlimited&description='` |

#### Update an Application

|                |                                                                                                                                                                                                                                                                                   |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Update an existing application.                                                                                                                                                                                                                                                   |
| URI            | <http://localhost:9763/store/site/blocks/application/application-update/ajax/application-update.jag>                                                                                                                                                                              |
| URI Parameters | `action=updateApplication&applicationOld=<application_name>&applicationNew=<application_name>&callbackUrlNew=xxx&descriptionNew=xxx&tier=<tier_name>`|
| HTTP Methods   | POST                                                                                                                                                                                                                                                                              |
| Example        | `curl -X POST -b cookies http://localhost:9763/store/site/blocks/application/application-update/ajax/application-update.jag -d 'action=updateApplication&applicationOld=NewApp1&applicationNew=NewApp2&tier=Unlimited&descriptionNew=&callbackUrlNew'` |

#### Get Applications

|                |                                                                                                                                                                  |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Get list of applications.                                                                                                                                        |
| URI            | <http://localhost:9763/store/site/blocks/application/application-list/ajax/application-list.jag>                                                                 |
| URI Parameters | `?action=getApplications`|
| HTTP Methods   | GET                                                                                                                                                              |
| Example        | `curl -b cookies http://localhost:9763/store/site/blocks/application/application-list/ajax/application-list.jag?action=getApplications` |

#### Get an Application by Name

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get details of a single application by name.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="http://localhost:9763/store/site/blocks/application/application-list/ajax/application-list.jag" class="uri">http://localhost:9763/store/site/blocks/application/application-list/ajax/application-list.jag</a></p></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><code>             ?action=getApplicationByName&amp;applicationName=$APP_NAME            </code></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>GET</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -b cookies 'http://localhost:9763/store/site/blocks/application/application-list/ajax/application-list.jag?action=getApplicationByName&amp;applicationName=$APP_NAME'             </code></p></td>
</tr>
</tbody>
</table>

#### Remove an Application

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Remove an existing application.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/application/application-remove/ajax/application-remove.jag" class="uri">http://localhost:9763/store/site/blocks/application/application-remove/ajax/application-remove.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=removeApplication&amp;application=&lt;application_name&gt;             </code></p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -X POST -b cookies http://localhost:9763/store/site/blocks/application/application-remove/ajax/application-remove.jag -d &quot;action=removeApplication&amp;application=NewApp2&quot;             </code></p></td>
</tr>
</tbody>
</table>

#### Generate an Application Key

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Generate the key and secret values for a new application.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag</a></p></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=generateApplicationKey&amp;application=&lt;app_name&gt;&amp;keytype=&lt;PRODUCTION|SANDBOX&gt;&amp;callbackUrl=&lt;URL&gt;&amp;authorizedDomains=&lt;The domains from which requests are allowed to the APIs&gt;&amp;validityTime=&lt;time duration in seconds&gt;&amp;tokenScope                           </code> <code>              tokenScope             </code> is given in the request when your API has Auth scopes defined. See <a href="https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-OAuthscopes">OAuth scopes</a> .</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Examples</td>
<td><ol>
<li><code>               curl -X POST -b cookies http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=generateApplicationKey&amp;application=NewApp1&amp;keytype=PRODUCTION&amp;callbackUrl=&amp;authorizedDomains=ALL&amp;validityTime=360000'              </code></li>
<li><code>               curl -X POST -b cookies http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=generateApplicationKey&amp;application=NewApp1&amp;keytype=SANDBOX&amp;callbackUrl=&amp;authorizedDomains=ALL&amp;validityTime=360000&amp;                               tokenScope=scope1                              '              </code></li>
</ol></td>
</tr>
</tbody>
</table>

#### Update an Application Key

|                |                                                                                                                                                                                                                                                                                      |
|----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Update the key and secret values for an application.                                                                                                                                                                                                                                 |
| URI            | <http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag>                                                                                                                                                                                    |
| URI Parameters | action=updateClientApplication& application=&lt;app\_name&gt;&keytype=&lt;PRODUCTION|SANDBOX&gt; &callbackUrl=&lt;URL&gt;& authorizedDomains=&lt;The domains from which requests are allowed to the APIs&gt;& validityTime=&lt;time duration in seconds&gt;&tokenScope               
                                                                                                                                                                                                                                                                                        
  **`tokenScope`** is given in the request when your API has Auth scopes defined. See [OAuth scopes](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-OAuthscopes) .                                                                           |
| HTTP Methods   | POST                                                                                                                                                                                                                                                                                 |
| Examples       | 1.  curl -X POST -b cookies <http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag> -d 'action=updateClientApplication&application=NewApp1&keytype=PRODUCTION &callbackUrl=& authorizedDomains=ALL&validityTime=360000'                    
  2.  curl -X POST -b cookies <http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag> -d 'action=updateClientApplication&application=NewApp1&keytype=SANDBOX&callbackUrl=&authorizedDomains=ALL&validityTime=360000& **tokenScope=scope1** '  |

#### Add a Subscription

<table>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Add a new API subscription.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><ul>
<li><strong>By application name</strong> : <code>               action=addAPISubscription&amp;name=xxx&amp;version=xxx&amp;provider=xxx&amp;tier=xxx&amp;                               applicationName                              =xxx              </code> <strong><br />
</strong></li>
<li><strong>By application ID</strong> : <code>               action=addSubscription&amp;name=xxx&amp;version=xxx&amp;provider=xxx&amp;tier=xxx&amp;                               applicationId                              =xxx              </code></li>
</ul></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><ul>
<li><strong>By application name</strong> : <code>               curl -X POST -b cookies http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=addAPISubscription&amp;name=TestAPI&amp;version=1.0.0&amp;provider=admin&amp;tier=Gold&amp;                               applicationName                              =DefaultApplication'              </code> <strong><br />
</strong></li>
<li><strong>By application ID</strong> : <code>               curl -X POST -b cookies                              http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=addSubscription&amp;name=TestAPI&amp;version=1.0.0&amp;provider=admin&amp;tier=Gold&amp;                               applicationId                              =1'              </code></li>
</ul></td>
</tr>
</tbody>
</table>

#### List Subscriptions

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>List all applications with active subscriptions, along with the access key information of each application.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p>action=getAllSubscriptions, selectedApp (optional)</p>
<p>You can give an application's name in the <strong>s</strong> <strong><code>               electedApp              </code></strong> parameter. The API then returns the given application's s ubscribed APIs and access key information. If you do not specify this parameter, only the first application in the retrieved application list will contain subscribed API details, in addition to the access key information.</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>GET</td>
</tr>
<tr class="odd">
<td>Examples</td>
<td><ol>
<li><code>               curl -b cookies http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag?action=getAllSubscriptions              </code></li>
<li><code>               curl -b cookies 'http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag                               ?action=getAllSubscriptions                                              &amp;selectedApp=NewApp1                              '              </code></li>
</ol></td>
</tr>
</tbody>
</table>

#### List Subscriptions by Application

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>List all API subscriptions of a given application.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=getSubscriptionByApplication&amp;app=&lt;application_name&gt;             </code></p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>GET</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -b cookies 'http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag?action=getSubscriptionByApplication&amp;app=DefaultApplication           '             </code></p></td>
</tr>
</tbody>
</table>

#### List Subscriptions by API

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>List all subscriptions of a given API.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag</a></p></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=getSubscriptionByAPI&amp;apiName=xxx&amp;apiVersion=xxx&amp;provider=xxx             </code></p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>GET</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -b cookies 'http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag?action=getSubscriptionByAPI&amp;apiName=MyAPI&amp;apiVersion=1.0.0&amp;provider=admin'             </code></p></td>
</tr>
</tbody>
</table>

#### Remove a Subscription

<table>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Remove an API subscription.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/subscription/subscription-remove/ajax/subscription-remove.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-remove/ajax/subscription-remove.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><ul>
<li><strong>By application name</strong> : <code>               action=removeSubscription&amp;name=xxx&amp;version=xxx&amp;provider=xxx&amp;                               applicationName                              =xxx              </code></li>
<li><strong>By application Id</strong> : <code>               action=removeSubscription&amp;name=xxx&amp;version=xxx&amp;provider=xxx&amp;                               applicationId                              =xxx              </code></li>
</ul></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><ul>
<li><strong>By application Name</strong> : <code>               curl -X POST -b cookies                              http://localhost:9763/store/site/blocks/subscription/subscription-remove/ajax/subscription-remove.jag -d 'action=removeSubscription&amp;name=PhoneVerification&amp;version=1.0.0&amp;provider=admin&amp;                               applicationName                              =DefaultApplication'              </code> <strong><br />
</strong></li>
<li><strong>By application Id</strong> : <code>               curl -X POST -b cookies                              http://localhost:9763/store/site/blocks/subscription/subscription-remove/ajax/subscription-remove.jag -d 'action=removeSubscription&amp;name=PhoneVerification&amp;version=1.0.0&amp;provider=admin&amp;                               applicationId                              =1'              </code></li>
</ul></td>
</tr>
</tbody>
</table>

#### Delete an OAuth Application

|                |                                                                                                                                                                                                                                                                           |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Deletes an OAuth application in a [third-party Authorization Server](https://docs.wso2.com/display/AM260/Configuring+a+Third-Party+Key+Manager) . If you delete it through the API Store UI, only the mapping that is maintained in the API Manager side will be deleted. |
| URI            | <http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag>                                                                                                                                                                         |
| URI Parameters | `action=deleteAuthApplication&consumerKey=<application_key>`|
| HTTP Methods   | POST                                                                                                                                                                                                                                                                      |
| Example        | `curl -k -X POST -b cookies http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=deleteAuthApplication&consumerKey=4lHddsxCtpFa2zJE1EbBpJy_NIQa'`|

#### Provision an Out-of-Band OAuth Client

<table>
<tbody>
<tr class="odd">
<td>Description</td>
<td><a href="https://docs.wso2.com/display/AM260/Provisioning+Out-of-Band+OAuth+Clients">Provisions an OAuth client</a> that was created out-of-band.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=                             mapExistingOauthClient                            &amp;application=              &lt;APPLICATION NAME&gt;              &amp;keytype=PRODUCTION/SANDBOX&amp;callbackUrl=&lt;URL&gt;&amp;authorizedDomains=&lt;authorized_domains&gt;&amp;             </code> <code>              validityTime=&lt;time duration in seconds&gt;&amp;client_id=&lt;client-ID&gt;             </code><br />
<code>              &lt;authorized_domains&gt;             </code> =  The domains from which requests are allowed to the APIs.</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -X POST -b cookies                             http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag                            -d 'action=mapExistingOauthClient&amp;application=              NewApp1              &amp;keytype=PRODUCTION&amp;callbackUrl=google.com&amp;authorizedDomains=ALL&amp;validityTime=3600&amp;client_id=mPbgvinvpEk1QcSrw962TLICriUa&amp; jsonParams={&quot;username&quot;:&quot;admin&quot;,&quot;key_type&quot;:&quot;PRODUCTION&quot;,&quot;client_secret&quot;:&quot;ynEI1ugq1_RCTJ9bM8jtD9RCsdoa&quot;,&quot;validityPeriod&quot;:&quot;3600&quot;,&quot;client_id&quot;:&quot;mPbgvinvpEk1QcSrw962TLICriUa&quot;}'             </code></p></td>
</tr>
</tbody>
</table>

#### Clean Partially Created Keys

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Cleans any partially created keys from the API Manager database, before adding a new subscription. Partially created keys can remain in the API Manager databases when an OAuth application of a <a href="https://docs.wso2.com/display/AM260/Configuring+a+Third-Party+Key+Manager">third-party authorization server</a> gets deleted using the API Store UI. It only deletes the mapping that is maintained in the API Manager side.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag" class="uri">http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=                             cleanUpApplicationRegistration                            &amp;applicationName=xxx&amp;keyType=PRODUCTION/SANDBOX'             </code></p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -X POST -b cookies http://localhost:9763/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=cleanUpApplicationRegistration&amp;applicationName=DefaultApplication&amp;keyType=PRODUCTION'             </code></p></td>
</tr>
</tbody>
</table>

#### Get all Documentation

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get all documents create for a given API</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/subscription/subscription-list/ajax/subscription-list.jag">http://localhost:9763</a> /store/site/blocks/api/listing/ajax/list.jag</td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=getAllDocumentationOfApi&amp;name=&lt;API_name&gt;&amp;version=x.x.x&amp;provider=&lt;API_provider_name&gt;&quot;             </code></p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>GET</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -b cookies &quot;http://localhost:9763                             /store/site/blocks/api/listing/ajax/list.jag?action=getAllDocumentationOfApi&amp;name=PhoneVerification&amp;version=1.0.0&amp;provider=admin                            &quot;             </code></p></td>
</tr>
</tbody>
</table>

#### Get the Contents of a File Document

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get the contents of a file that is attached to API documentation of type 'File'</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/store/site/blocks/api/documentation/view/ajax/file-docs.jag" class="uri">http://localhost:9763/store/site/blocks/api/documentation/view/ajax/file-docs.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p><code>              action=getFileDocumentByFilePath&amp;filePath=&lt;file_path&gt;                                                          &lt;file_path&gt;              </code> - Get the file path using <code>                             getAllDocumentationOfApi                           </code></p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>GET</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><code>              curl -b cookies &quot;http://localhost:9763/store/site/blocks/api/documentation/view/ajax/file-docs.jag?action=getFileDocumentByFilePath&amp;filePath=/registry/resource/_system/governance/apimgt/applicationdata/provider/admin/host/1.0.0/documentation/files/test.txt''             </code></p></td>
</tr>
</tbody>
</table>

#### Add an API Comment

|                |                                                                                                                                                                                                                                                                                        |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Add a comment to an API.                                                                                                                                                                                                                                                               |
| URI            | <http://localhost:9763/store/site/blocks/comment/comment-add/ajax/comment-add.jag>                                                                                                                                                                                                     |
| URI Parameters | `action=addComment&name=xxx&version=xxx&provider=xxx&comment=xxx`|
| HTTP Methods   | POST                                                                                                                                                                                                                                                                                   |
| Example        | `curl -X POST -b cookies                             http://localhost:9763/store/site/blocks/comment/comment-add/ajax/comment-add.jag                            -d 'action=addComment&name=CalculatorAPI&version=1.0&provider=admin&comment=test comment'` |

#### Get all Endpoint URLs

|                |                                                                                                                                                                                                                                                                 |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Get all the endpoint URLs of the API Gateway environments configured for an API.                                                                                                                                                                                |
| URI            | <http://localhost:9763/store/site/blocks/api/api-info/ajax/api-info.jag>                                                                                                                                                                                        |
| URI Parameters | `action=getAPIEndpointURLs&name=xxx&version=x.x.x&provider=xxx`|
| HTTP Methods   | POST                                                                                                                                                                                                                                                            |
| Example        | `curl -X POST -b cookies                             http://localhost:9763/store/site/blocks/api/api-info/ajax/api-info.jag                            -d 'action=getAPIEndpointURLs&name=CalculatorAPI&version=1.0&provider=admin'` |

#### Get all Available Tiers

|                |                                                                                                                            |
|----------------|----------------------------------------------------------------------------------------------------------------------------|
| Description    | Get all the tiers available in the deployment.                                                                             |
| URI            | <http://localhost:9763/store/site/blocks/item-add/ajax/add.jag>                                                            |
| URI Parameters | `action=getTiers`|
| HTTP Methods   | GET                                                                                                                        |
| Example        | `curl -b cookies http://localhost:9763/store/site/blocks/item-add/ajax/add.jag?action=getTiers` |

#### Update Grant Types

<table>
<tbody>
<tr class="odd">
<td><p>Description</p></td>
<td><p>Edit default grant types and add new grant types</p></td>
</tr>
<tr class="even">
<td><p>URI</p></td>
<td><p><a href="https://localhost:9443/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag" class="uri">https://localhost:9443/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag</a></p></td>
</tr>
<tr class="odd">
<td><p>URI Parameters</p></td>
<td><p>action=updateClientApplication&amp;application=&lt;Application_Name&gt;&amp;keytype=&lt;Type of the key&gt;&amp;jsonParams=&lt;URL encoded JSON&gt;&amp;callbackUrl=&lt;callBackURL&gt;<br />
<br />
<br />
</p></td>
</tr>
<tr class="even">
<td><p>HTTP Methods</p></td>
<td><p>GET</p></td>
</tr>
<tr class="odd">
<td><p>Example</p></td>
<td><div class="content-wrapper">
<p><code>               curl '                               https://localhost:9443/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag                              ' -H 'Content-Type: application/x-www-form-urlencoded' -d 'action=updateClientApplication&amp;application=DefaultApplication&amp;keytype=PRODUCTION&amp;jsonParams=%7B%22grant_types%22%3A%22refresh_token%2Curn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Asaml2-bearer%2Cpassword%2Ciwa%3Antlm%2Cclient_credentials%22%7D&amp;callbackUrl=' -k -b cookies                                                           </code></p>
!!! note
<p>To create a list of the grant types to be encoded</p>
<ol>
<li><p>Write a JSON string with the required grant types.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>{&quot;grant_types&quot;:&quot;refresh_token,urn:ietf:params:oauth:grant-type:saml2-bearer,password,iwa:ntlm,client_credentials&quot;}</code></pre>
</div>
</div></li>
<li>Encode them with a <a href="https://www.urlencoder.org/">URL encoder</a> .</li>
<li>Use the encoded value for the <code>                jsonParams               </code> parameter as shown in the sample cURL command given above.</li>
</ol>

</div></td>
</tr>
</tbody>
</table>

!!! info
You can also invoke these APIs using mutual SSL authentication. Follow the instructions below to enable this:

1.  Go to `<APIM_HOME>/repository/conf/tomcat/catalina-server.xml` and set the clientAuth attribute to want.

    ``` java
        <Connector  protocol="org.apache.coyote.http11.Http11NioProtocol"
            port="9443"
            ...
            clientAuth="want"
            ...
        />
    ```

2.  For each Store API, attach the `X509Certificate` and pass the `MutualAuthUserName` parameter in the header.
3.  Ensure that both client and the server have each other's certificates in the trust store.


