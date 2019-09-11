# Publisher APIs


-   [Login](#PublisherAPIs-Login)
-   [Logout](#PublisherAPIs-Logout)
-   [Add API](#PublisherAPIs-AddAPI)
-   [Add API with Path Parameter](#PublisherAPIs-AddAPIwithPathParameter)
-   [Update API](#PublisherAPIs-UpdateAPI)
-   [Publishing an API to external Store](#PublisherAPIs-PublishinganAPItoexternalStore)
-   [Get All APIs](#PublisherAPIs-GetAllAPIs)
-   [Get an API](#PublisherAPIs-GetanAPI)
-   [Remove an API](#PublisherAPIs-RemoveanAPI)
-   [Copy an API](#PublisherAPIs-CopyanAPI)
-   [Check Older Version](#PublisherAPIs-CheckOlderVersion)
-   [Change API Status](#PublisherAPIs-ChangeAPIStatus)
-   [Add/Update an API Document](#PublisherAPIs-Add/UpdateanAPIDocument)
-   [Remove an API Document](#PublisherAPIs-RemoveanAPIDocument)
-   [Get all Throttling Tiers](#PublisherAPIs-GetallThrottlingTiers)
-   [Check if API Exists](#PublisherAPIs-CheckifAPIExists)
-   [Validate Roles](#PublisherAPIs-ValidateRoles)
-   [Upload a Certificate](#PublisherAPIs-UploadaCertificate)
-   [Remove a Certificate](#PublisherAPIs-RemoveaCertificate)
-   [Analytics related APIs](#PublisherAPIs-AnalyticsrelatedAPIs)

!!! note
**Note** : When you access any API other than the login and logout APIs through an external REST client such as cURL, first invoke the login API to ensure that user is authenticated. When the login API is invoked, the system stores the generated session cookie in a file, which we use in the next API invocations. The response is a JSON message.


#### Login

|                |                                                                                                                                                   |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Log in to API Publisher web application.                                                                                                          |
| URI            | <http://localhost:9763/publisher/site/blocks/user/login/ajax/login> [.jag](http://localhost:9763/publisher/site/blocks/user/login/ajax/login.jag) |
| URI Parameters | action=login&username=xxx&password=xxx                                                                                                            |
| HTTP Methods   | POST                                                                                                                                              |
| Example        | curl -X POST -c cookies <http://localhost:9763/publisher/site/blocks/user/login/ajax/login.jag> -d 'action=login&username=admin&password=admin'   |

#### Logout

|                |                                                                                                                                                   |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Log out from API Publisher web application.                                                                                                       |
| URI            | <http://localhost:9763/publisher/site/blocks/user/login/ajax/login> [.jag](http://localhost:9763/publisher/site/blocks/user/login/ajax/login.jag) |
| URI Parameters | ?action=logout                                                                                                                                    |
| HTTP Methods   | GET                                                                                                                                               |
| Example        | curl -b cookies <http://localhost:9763/publisher/site/blocks/user/login/ajax/login.jag?action=logout>                                             |

#### Add API

<table>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Add a new API.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag" class="uri">http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><div class="content-wrapper">
<p>Given below are the parameters that you can pass with an Add-API call. Mandatory ones are marked with a *.</p>
<div class="table-wrap">
<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter name</th>
<th>Syntax</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Action*</td>
<td><br />
</td>
</tr>
<tr class="even">
<td>Name*</td>
<td>name=xxx</td>
</tr>
<tr class="odd">
<td>Context*</td>
<td>context=/xxx</td>
</tr>
<tr class="even">
<td>Version*</td>
<td>version=x.x.x</td>
</tr>
<tr class="odd">
<td>API visibility*</td>
<td><p>visibility=&lt;public|private|restricted&gt;</p>
<p>The default is public. If you select <code>                    restricted                   </code> , mention to which roles as follows: <code>                    visibility=restricted&amp;roles=role1,role2,role3                   </code> .</p>
<p>You can read more about <strong>API visibility</strong> from <a href="https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-APIvisibility">here</a> .</p></td>
</tr>
<tr class="even">
<td>Thumbnail image</td>
<td><ul>
<li>To add a thumbnail image as a file object, create the object and pass it with the <strong><code style="line-height: 1.4285715;">                      apiThumb                     </code></strong> parameter. See sample in this <code style="line-height: 1.4285715;">                                           getMultipartEntity()                                         </code> method.</li>
<li>To add a thumbnail image as a URL of the image, pass the URL with the <code>                                           thumbUrl                                         </code> parameter as thumbUrl=&lt;URL of the image&gt;</li>
</ul></td>
</tr>
<tr class="odd">
<td>Description</td>
<td>description=xxx</td>
</tr>
<tr class="even">
<td>Tags</td>
<td>tags=x,y,z</td>
</tr>
<tr class="odd">
<td>Resources*</td>
<td><p>resourceCount=0&amp;resourceMethod-0=GET&amp;resourceMethodAuthType-0=Application&amp;resourceMethodThrottlingTier-0=Unlimited</p>
<ul>
<li><strong><code>                      resourceMethod                     </code></strong> can take any one of the following values: GET, POST, DELETE, PUT, OPTIONS</li>
<li><strong><code>                      resourceMethodAuthType                     </code></strong> can take any one of the following values: Application, Application User, Application and Application User, None</li>
<li><strong><code>                      resourceMethodThrottlingTier                     </code></strong> can take any one of the following default values: Unlimited, Gold, Silver, Bronze. You can change the default values or have additional tiers defined in the <strong><code>                      /_system/governance/apimgt/applicationdata/tiers.xml                     </code></strong> registry location.</li>
</ul></td>
</tr>
<tr class="even">
<td>Resources as Swagger</td>
<td><div class="content-wrapper">
<p>Instead of adding resources directly as above, you can add resources, including scopes, as a Swagger payload. Here's an example of adding an API with its Swagger definition:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>swagger={&quot;paths&quot; : {&quot;/CheckPhoneNumber&quot; : {&quot;post&quot; : {&quot;x-auth-type&quot; : &quot;Application%20%26%20Application%20User&quot;, &quot;x-scope&quot; : &quot;read_number&quot;, &quot;x-throttling-tier&quot; : &quot;Unlimited&quot;, &quot;responses&quot; : {&quot;200&quot; : {}}}, &quot;get&quot; : {&quot;x-auth-type&quot; : &quot;Application%20%26%20Application%20User&quot;, &quot;x-throttling-tier&quot; : &quot;Unlimited&quot;, &quot;responses&quot; : {&quot;200&quot; : {}}, &quot;parameters&quot; : [{&quot;name&quot; : &quot;PhoneNumber&quot;, &quot;paramType&quot; : &quot;query&quot;, &quot;required&quot; : false, &quot;type&quot; : &quot;string&quot;, &quot;description&quot; : &quot;Phone Number&quot;, &quot;in&quot; : &quot;query&quot;}, {&quot;name&quot; : &quot;LicenseKey&quot;, &quot;paramType&quot; : &quot;query&quot;, &quot;required&quot; : false, &quot;type&quot; : &quot;string&quot;, &quot;description&quot; : &quot;License Key&quot;, &quot;in&quot; : &quot;query&quot;}]}}, &quot;/&quot; : {&quot;put&quot; : {&quot;responses&quot; : {&quot;200&quot; : {}}}, &quot;get&quot; : {&quot;responses&quot; : {&quot;200&quot; : {}}}}}, &quot;swagger&quot; : &quot;2.0&quot;, &quot;x-wso2-security&quot; : {&quot;apim&quot; : {&quot;x-wso2-scopes&quot; : [{&quot;description&quot; : &quot;&quot;, &quot;name&quot; : &quot;read_number&quot;, &quot;roles&quot; : &quot;admin&quot;, &quot;key&quot; : &quot;read_number&quot;}]}}, &quot;info&quot; : {&quot;title&quot; : &quot;PhoneVerification&quot;, &quot;version&quot; : &quot;1.0.0&quot;}}</code></pre>
</div>
</div>
<p>In the above code, note that you have one resource path defined with the URL pattern <code>                     /CheckPhoneNumber                    </code> under the <code>                     paths                    </code> object. This is followed by the HTTP methods of the resource (e.g., GET, POST, PUT etc.) You can have multiple similar resource paths to a single API and multiple HTTP methods to each resource path. For each HTTP method, you can define several parameters.</p>
<p>For more information of the Swagger objects used in this example, see the <a href="https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md">Swagger 2.0 specification</a> . Described below are the WSO2-specific ones.</p>
<ul>
<li><strong>x-wso2-scopes</strong> : The list of scope elements that you want to define. Each element has the below fields. See <a href="https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-OAuthscopes">OAuth Scopes</a> .
<ul>
<li><strong>description</strong> : Scope description</li>
<li><strong>roles</strong> : Allowed roles</li>
<li><strong>name</strong> : Scope Name</li>
<li><strong>key</strong> : Scope Key</li>
</ul></li>
<li><strong>x-auth-type</strong> : Authentication type of the method.</li>
<li><strong>x-throttling-tier</strong> : Throttling tier of the method.</li>
<li><strong>x-scope</strong> : OAuth scope of the method. This must be one of the list of element you define in <strong>x-wso2-scopes</strong> .</li>
</ul>
<p>The following image shows the WSO2-specific parameters we describe here. Also see <a href="https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-APIresources">Resources under Key Concepts</a> for more information.</p>
<p><img src="attachments/103335310/103335312.png" width="750" /></p>
</div></td>
</tr>
<tr class="odd">
<td>Endpoints*</td>
<td><p>This example adds an HTTP production endpoint: <code>                    endpoint_config={&quot;production_endpoints&quot;:{&quot;url&quot;:&quot;&lt;URL&gt;&quot;,&quot;config&quot;:                     {&quot;format&quot;:&quot;leave-as-                     is&quot;,&quot;optimize&quot;:&quot;leave-as-is&quot;,&quot;                     actionSelect&quot;:&quot;fault&quot;,&quot;                     actionDuration&quot;:60000}                     },&quot;endpoint_type&quot;:&quot;http&quot;}                   </code></p>
<p>To give advanced endpoint configurations, add the JSON implementation inside &quot;config:{}.&quot; If you don't have any advanced configurations, set it to null as <code>                    &quot;config&quot;:null                   </code> .</p>
<p>You add sandbox endpoints in the same way. The only difference is that instead of <code>                    production_endpoints                   </code> , you give <code>                    sandbox_endpoints                   </code> .</p>
<p>If you want to add other types of endpoints, follow the examples below. <strong>Note</strong> that the <code>                    endpoint_type                   </code> of of both HTTP and HTTPS endpoints should be HTTP.</p>
<ul>
<li><strong>For address endpoints</strong> :<br />
<code>                     endpoint_config={&quot;production_                         endpoints&quot;:{&quot;url&quot;:&quot;                                           http://service.endpoint.com                                          &quot;,&quot;config&quot;                         :null},&quot;endpoint_type&quot;:&quot;                         address&quot;}                    </code></li>
<li><strong>For failover endpoints</strong> :<br />
<code>                     endpoint_config={&quot;production_                         endpoints&quot;:{&quot;url&quot;:&quot;                                           http://service.endpoint.com                                          &quot;,&quot;config&quot;                         :null}, &quot;production_failovers&quot;:{&quot;url&quot;                         :&quot;                                           http://failover1.endpoint.com                                          &quot;,&quot;config&quot;:null}, {&quot;url&quot;:&quot;                                           http://failover2.endpoint.com                                          &quot;,&quot;config&quot;:null}],                         &quot;sandbox_failovers&quot;:[],&quot;                         endpoint_type&quot;:&quot;failover&quot;}                    </code></li>
<li><strong>For load balanced endpoints</strong> :<br />
<code>                     endpoint_config&quot; {&quot;production_endpoints&quot;:[{&quot;                         url&quot;:&quot;                                           http://service.endpoint1.com                                          &quot;,&quot;config&quot;:null},                         {&quot;url&quot;:&quot;                                           http://service.endpoint2.com                                          &quot;,&quot;config&quot;:null}]                         , &quot;algoCombo&quot;:&quot;org.apache.                         synapse.endpoints.algorithms.                         RoundRobin&quot;,&quot;failOver&quot;:&quot;True&quot;, &quot;algoClassName&quot;:&quot;org.apache.                         synapse.endpoints.algorithms.                         RoundRobin&quot;, &quot;sessionManagement&quot;:&quot;                         simpleClientSession&quot;,&quot;                         sessionTimeOut&quot;:30,&quot;endpoint_                         type&quot;:&quot;load_balance&quot;}                    </code></li>
</ul></td>
</tr>
<tr class="even">
<td>Endpoint security scheme</td>
<td><p>endpointType=&lt;secured|nonsecured&gt;</p>
<p>The default is non-secured but if you select 'secured', you must pass the credentials as follows: <code>                    endpointType=secured&amp;endpointAuthType=&lt;basicAuth|digestAuth&gt;&amp;epUsername=&lt;your username&gt;&amp;                     epPassword=&lt;the password&gt;                   </code></p></td>
</tr>
<tr class="odd">
<td>Make default version</td>
<td><p>To mark this version of the API as the <strong>default version</strong> from a group of versions, give <strong><code>                     default_version_checked=default_version                    </code></strong> .</p>
<p>The <strong>Default Version</strong> option means that you make this version the default in a group of different versions of the API. A default API can be invoked without specifying the version number in the URL. For example, if you mark http://host:port/youtube/ 2.0 as the default version when the API has 1.0 and 3.0 versions as well, requests made to <a href="http://hostport/">http://host:port/youtube/</a> get automatically routed to version 2.0.</p>
<p>If you mark any version of an API as the default, you get two API URLs in its <strong>Overview</strong> page in the API Store. One URL is with the version and the other is without. You can invoke a default version using both URLs.</p>
<p>If you mark an unpublished API as the default, the previous default, published API will still be used as the default until the new default API is published (or prototyped).</p></td>
</tr>
<tr class="even">
<td>Tier Availability*</td>
<td>tiersCollection=&lt;Gold,Silver,Bronze,Unlimited&gt;</td>
</tr>
<tr class="odd">
<td>Transports</td>
<td><p>http_checked=http&amp;https_checked=https</p>
<p>Both are selected by default. If you want to set only the HTTP <strong>transport</strong> , leave the <code>                    https_checked                   </code> parameter empty as <code>                    http_checked=http&amp;https_checked=&amp;                   </code> .</p></td>
</tr>
<tr class="even">
<td>Sequences</td>
<td><p>If you want to engage a custom sequence to the API, give <strong><code>                     inSequence=&lt;sequence name&gt;&amp;outSequence=&lt;sequence name&gt;                    </code></strong> . This <a href="https://docs.wso2.com/display/AM260/Change+the+Default+Mediation+Flow+of+API+Requests">tutorial</a> explains how to create sequences and add them to the registry.</p></td>
</tr>
<tr class="odd">
<td>Response caching</td>
<td><p>responseCache=&lt;enabled|disabled&gt;</p>
<p>It is disabled by default but if you enable it, pass the response cache timeout as follows: <code>                    responseCache=enabled&amp;                     cacheTimeout=300                   </code></p>
<p>See <a href="https://docs.wso2.com/display/AM260/Configuring+Caching">Configuring Caching</a> for more information.</p></td>
</tr>
<tr class="even">
<td>Subscriptions</td>
<td><p>By default, subscription is allowed to the current tenant only.</p>
<p>Add the argument <code>                    subscriptions=all_tenants                   </code> to <strong>enable subscriptions</strong> to this API by all tenants. To enable subscription to selected tenants, use <code>                    subscriptions=specific_tennats&amp;tenants=&lt;tenant name&gt;                   </code> . For example, <code>                    &amp;subscriptions=all_tenants                   </code> .</p>
<p>See <a href="https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-APIvisibilityandsubscription">API visibility and subscription</a> for more information.</p></td>
</tr>
<tr class="odd">
<td>Business information</td>
<td><p>Add a section like this: <code>                    bizOwner=&lt;name&gt;&amp;bizOwnerMail=&lt;e-mail address&gt;&amp;techOwner=&lt;name&gt;&amp;techOwnerMail=&lt;e-mail address&gt;                   </code></p></td>
</tr>
</tbody>
</table>
</div>
</div></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p>curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag" class="uri">http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag</a> -d &quot;action=addAPI&amp;name=PhoneVerification&amp;context=/phoneverify&amp;version=1.0.0&amp;visibility=public&amp;thumbUrl=&amp;description=Verify a phone number&amp;tags=phone,mobile,multimedia&amp;endpointType=nonsecured&amp;tiersCollection=Gold,Bronze&amp;http_checked=http&amp;https_checked=https style=&quot;line-height: 1.4285715;&quot;&gt;&amp;resourceCount=0&amp;resourceMethod-0=GET&amp;resourceMethodAuthType-0=Application&amp;resourceMethodThrottlingTier-0=Unlimited&amp;uriTemplate-0=/*&amp;default_version_checked=default_version&amp;bizOwner=xx&amp;bizOwnerMail= <a href="mailto:xx@ee.com">xx@ee.com</a> &amp;techOwner=xx&amp;techOwnerMail= <a href="mailto:ggg@ww.com">ggg@ww.com</a> &quot; -d 'endpoint_config={&quot;production_endpoints&quot;:{&quot;url&quot;:&quot; http://ws.cdyne.com/phoneverify/phoneverify.asmx&quot;,&quot;config&quot;:null},&quot;endpoint_type&quot;:&quot;http &quot;}'</p></td>
</tr>
</tbody>
</table>

#### Add API with Path Parameter

|                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Add a new API with path parameter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| URI            | <http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| URI Parameters | action=addAPI&name=xxx&context=/xxx&version=1.0.0&visibility=xxx&thumbUrl=&description=xxx&tags=xxx&endpointType=xxx&tiersCollection=xxx&http\_checked=http&https\_checked=https" -d 'swagger=xxx                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| HTTP Methods   | POST                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Example        | curl -X POST -b cookies <http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag> -d "action=addAPI&name=SampleApi&context=/sample&version=1.0.0&visibility=public&thumbUrl=&description=Verify a phone number&tags=phone,mobile,multimedia&endpointType=nonsecured&tiersCollection=Gold,Bronze&http\_checked=http&https\_checked=https" -d 'swagger={"paths" : {"/estimate/" : {"get" : {"x-auth-type" : "Application%20%26%20Application%20User", "x-throttling-tier" : "Unlimited", "responses" : {"200" : {}}, "parameters" : \[{"name" : "id", "paramType" : "path", "required" : false, "type" : "string", "description" : "Phone Number", "in" : "path"}\]}}}, "swagger" : "2.0", "x-wso2-security" : {"apim" : {"x-wso2-scopes" : \[{"description" : "", "name" : "read\_number", "roles" : "admin", "key" : "read\_number"}\]}}, "info" : {"title" : "SampleApi", "version" : "1.0.0"}}' -d 'endpoint\_config={"production\_endpoints":{"url":" <http://ws.cdyne.com/phoneverify/phoneverify.asmx%22,%22config%22:null%7D,%22endpoint_type%22:%22http> "}' |

#### Update API

|                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Update an existing API                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| URI            | <http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| URI Parameters | **Parameters are same as in [Add API](#PublisherAPIs-AddAPI)** except that **action =updateAPI** and you can only update the following parameters: visibility, thumbUrl, description, tags, endpointType, endpoint\_config (can change the endpoint URL etc,) http\_checked, https\_checked, tiersCollection, swagger and can also add new resources. See example below.                                                                                                                                                                                                                                                                                                                                                                                                    |
| HTTP Methods   | POST                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Example        | **Update API :** curl -X POST -b cookies <http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag> -d "action= **updateAPI** &name=PhoneVerification&provider=admin&version=1.0.0&visibility=public&description=Youtube Live Feeds&endpointType=nonsecured&http\_checked=http&https\_checked=https&tags=youtube,gdata,multimedia&tier=Silver&thumbUrl=http://www.10bigideas.com.au/www/573/files/pf-thumbnail-youtube\_logo.jpg&context=/youtube&tiersCollection=Gold,silver&resourceCount=0&resourceMethod-0=GET&resourceMethodAuthType-0=Application&resourceMethodThrottlingTier-0=Unlimited&uriTemplate-0=/\*"  -d 'endpoint\_config={"production\_endpoints":{"url":" http://gdata.youtube.com/feeds/api/standardfeeds","config":null},"endpoint\_type":"http "}' |

#### Publishing an API to external Store

<table>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Publish an API to external store</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="http://localhost:9763/publisher/site/blocks/item-external/ajax/external.jag" class="uri">http://localhost:9763/publisher/site/blocks/item-external/ajax/external.jag</a></p></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><div class="content-wrapper">
<p>action=updateExternal&amp;name=xxx&amp;version=xxx&amp;provider=xxx&amp;externalAPIStores=&lt;external-store-1&gt;::&lt;external-store-2&gt;::&lt;external-store-3&gt;</p>
!!! note
<p>:: sign is used to seperate the list of API stores</p>

</div></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><div class="content-wrapper">
<p><strong>updateExternal :</strong> curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/item-external/ajax/external.jag" class="uri">http://localhost:9763/publisher/site/blocks/item-external/ajax/external.jag</a> -d &quot;action=updateExternal&amp;name=PhoneVerification&amp;version=1.0.0&amp;provider=admin&amp;externalAPIStores=exstore2::exstore3</p>
!!! tip
<p>This API can be used to unpublish an API from a given API store as well. If we remove the particular store ID and call the API once again, that API will get unpublished from the external stores which are not mentioned in the request.<br />
For example, if you want to remove the API from exstore2 and keep it published in exstore3, the following is the cURL command you need to use.</p>
<p><br />
</p>
<pre><code>curl -X POST -b cookies http://localhost:9763/publisher/site/blocks/item-external/ajax/external.jag -d 
&quot;action=updateExternal&amp;name=sampleAPI&amp;version=v1&amp;provider=admin@wso2.com&amp;externalAPIStores=exstore3&quot;</code></pre>
<pre><code>                
              </code></pre>
<p>If you want to remove the API from all the stores, provide '::' as the externalAPIStores parameter value.</p>

</div></td>
</tr>
</tbody>
</table>

#### Get All APIs

|                |                                                                                                                                                                                                                                                                                                                                                           |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Lists all the created APIs.                                                                                                                                                                                                                                                                                                                               |
| URI            | <http://localhost:9763/publisher/site/blocks/listing/ajax/item-list.jag>                                                                                                                                                                                                                                                                                  |
| URI Parameters | ?action=getAllAPIs                                                                                                                                                                                                                                                                                                                                        |
| HTTP Methods   | GET                                                                                                                                                                                                                                                                                                                                                       |
| Example        | curl -b cookies [http://localhost:9763/publisher/site/blocks/listing/ajax/item-list](http://localhost:9763/publisher/site/blocks/listing/ajax/item-list.jag) [.jag](http://localhost:9763/publisher/site/blocks/listing/ajax/itemlist.jag) [?action=getAllAPIs](http://localhost:9763/publisher/site/blocks/listing/ajax/item-list.jag?action=getAllAPIs) |

#### Get an API

|                |                                                                                                                                                                         |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Get details of a specific API.                                                                                                                                          |
| URI            | <http://localhost:9763/publisher/site/blocks/listing/ajax/item-list.jag>                                                                                                |
| URI Parameters | action=getAPI&name=xxx&version=xxx&provider=xxx                                                                                                                         |
| HTTP Methods   | POST                                                                                                                                                                    |
| Example        | curl -X POST -b cookies <http://localhost:9763/publisher/site/blocks/listing/ajax/item-list.jag> -d "action=getAPI&name=PhoneVerification&version=1.0.0&provider=admin" |

#### Remove an API

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Remove an API.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/publisher/site/blocks/item-add/ajax/remove.jag" class="uri">http://localhost:9763/publisher/site/blocks/item-add/ajax/remove.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td>action=removeAPI&amp;name=xxx&amp;version=xxx&amp;provider=xxx</td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p>curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/item-add/ajax/remove.jag" class="uri">http://localhost:9763/publisher/site/blocks/item-add/ajax/remove.jag</a> -d &quot;action=removeAPI&amp;name=PhoneVerification&amp;version=1.0.0&amp;provider=admin&quot;</p></td>
</tr>
</tbody>
</table>

#### Copy an API

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Copy an API to a newer version.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/publisher/site/blocks/overview/ajax/overview.jag">http://localhost:9763/publisher/site/blocks/overview/ajax/overvi ew.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p>action=createNewAPI&amp;provider=xxx&amp;apiName=xxx&amp;version=xxx&amp;newVersion=xxx</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p>curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/overview/ajax/overview.jag" class="uri">http://localhost:9763/publisher/site/blocks/overview/ajax/overview.jag</a> -d &quot;action=createNewAPI&amp;provider=admin&amp;apiName=PhoneVerification&amp;version=1.0.0&amp;newVersion=2.0.0&amp;isDefaultVersion=default_version&quot;</p></td>
</tr>
</tbody>
</table>

#### Check Older Version

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Does older version of API exist.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles.jag">http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles .jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p>action=isAPIOlderVersionExist&amp;provider=xxx&amp;name=xxx&amp;version=xxx</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p>curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles.jag" class="uri" title="Follow link">http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles.jag</a> -d &quot;action=isAPIOlderVersionExist&amp;provider=admin&amp;name=PhoneVerification&amp;version=1.0.0&quot;</p></td>
</tr>
</tbody>
</table>

#### Change API Status

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Change the API's status.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles.jag">http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles .jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p>action=updateStatus&amp;name=xxx&amp;version=1.0.0&amp;provider=apiCreateName&amp;status=PUBLISHED&amp;publishToGateway=true&amp;requireResubscription=true</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p>curl -X POST -b cookies ' <a href="http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles.jag" class="uri">http://localhost:9763/publisher/site/blocks/life-cycles/ajax/life-cycles.jag</a> ' -d 'action=updateStatus&amp;name=PhoneVerification&amp;version=1.0.0&amp;provider=admin&amp;status=PUBLISHED&amp;publishToGateway=true&amp;requireResubscription=true'</p></td>
</tr>
</tbody>
</table>

#### Add/Update an API Document

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Add a new API document.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag" class="uri">http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><div class="content-wrapper">
<p><strong>Add Document</strong> :</p>
<p>action=addDocumentation&amp;provider=xxx&amp;apiName=xxx&amp;version=xxx&amp;docName=xxx&amp;summary=xxx&amp;docType=xxx&amp;newType=xxx&amp;sourceType=xxx&amp;docUrl=&amp;docLocation=xxx&amp;docVisibility=owner_only/private</p>
<p>Note that docVisibility is applicable only if you have enabled it. See <a href="https://docs.wso2.com/display/AM1100/Key+Concepts#KeyConcepts-APIdocumentationvisibility">API documentation visibility</a> .</p>
<p><strong>Add Document file</strong> : action=addDocumentation&amp;provider=xxx&amp;apiName=xxx&amp;version=xxx&amp;docName=xxx&amp;summary=xxx&amp;docType=xxx&amp;newType=xxx&amp;sourceType=xxx&amp;docUrl=&amp;docLocation=xxx</p>
<p><strong>Update Document</strong> : action=addDocumentation&amp;mode=xxx&amp;provider=xxx&amp;apiName=xxx&amp;version=xxx&amp;docName=xxx&amp;summary=xxx&amp;docType=xxx&amp;newType=xxx&amp;sourceType=xxx&amp;docUrl=&amp;docLocation=xxx</p>
!!! info
<p>The <code>               docType              </code> parameter can have values such as How To, Samples, Public Forum etc. If the <code>               docType              </code> is specified as &quot;Other&quot;, the <code>               newType              </code> parameter is required to be specified with a non-empty value. The <code>               sourceType              </code> can be inline, file or URL.</p>

</div></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p><strong>Add Document:</strong> curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag" class="uri">http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag</a> -d &quot;action=addDocumentation&amp;provider=xxx&amp;apiName=xxx&amp;version=xxx&amp;docName=xxx&amp;summary=xxx&amp;docType=xxx&amp;newType=xxx&amp;sourceType=xxx&amp;docUrl=&amp;docLocation=&quot;</p>
<p><strong>Add Document file:</strong> curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag" class="uri">http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag</a> -F &quot;action=addDocumentation&quot; -F &quot;provider=admin&quot; -F &quot;apiName=testAPi&quot; -F &quot;version=1.0.0&quot; -F &quot;docName=testDoc2&quot; -F &quot;docType=how to&quot; -F &quot;sourceType=file&quot; -F &quot;docUrl=&quot; -F &quot;summary=testing&quot; -F &quot; <a href="mailto:docLocation=@test.txt">docLocation=@test.txt</a> &quot;</p>
<p><strong>Update Document:</strong> curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag" class="uri">http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag</a> -d &quot;action=addDocumentation&amp;mode=Update&amp;provider=admin&amp;apiName=PizzaShackAPI&amp;version=1.0.0&amp;docName=Sample&amp;summary=sample summary updated&amp;docType=other&amp;newType=primary&amp;sourceType=inline&amp;docUrl=&amp;docLocation=&quot;</p></td>
</tr>
</tbody>
</table>

#### Remove an API Document

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Remove an API document.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag" class="uri">http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag</a></td>
</tr>
<tr class="odd">
<td>URI Parameters</td>
<td><p>action=removeDocumentation&amp;provider=xxx&amp;apiName=xxx&amp;version=xxx&amp;docName=xxx&amp;docType=xxx</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Example</td>
<td><p>curl -X POST -b cookies <a href="http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag" class="uri">http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag</a> -d &quot;action=removeDocumentation&amp;provider=admin&amp;apiName=PizzaShackAPI&amp;version=1.0.0&amp;docName=Sample&amp;docType=HowTo&quot;</p></td>
</tr>
</tbody>
</table>

#### Get all Throttling Tiers

|                |                                                                                                                                                                         |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Get the throttling tiers that can be applied to APIs                                                                                                                    |
| URI            | [http://localhost:9763](http://localhost:9763/publisher/site/blocks/documentation/ajax/docs.jag) /publisher/site/blocks/item-add/ajax/add.jag?                          |
| URI Parameters | action=getTiers                                                                                                                                                         |
| HTTP Methods   | GET                                                                                                                                                                     |
| Example        | curl -b cookies [http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag?](http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag) action=getTiers |

#### Check if API Exists

|                |                                                                                                                                                                                                                                                      |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Check if an API by a given name exists in the API Publisher                                                                                                                                                                                          |
| URI            | [http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag](http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag?action=isAPINameExist&apiName=echoservice)                                                                     |
| URI Parameters | action=isAPINameExist&apiName=&lt;name of the API&gt;                                                                                                                                                                                                |
| HTTP Methods   | GET                                                                                                                                                                                                                                                  |
| Example        | curl -b cookies " [http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag?action=isAPINameExist&apiName=PhoneVerification](http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag?action=isAPINameExist&apiName=echoservice) " |

#### Validate Roles

|                |                                                                                                                                                                         |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Check if the user logged in user is any one in a given list of users                                                                                                    |
| URI            | [http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag](http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag?action=validateRoles&roles=admin) |
| URI Parameters | action=validateRoles&roles=&lt;list of roles&gt;                                                                                                                        |
| HTTP Methods   | GET                                                                                                                                                                     |
| Example        | curl -b cookies " <http://localhost:9763/publisher/site/blocks/item-add/ajax/add.jag?action=validateRoles&roles=admin> "                                                |

#### Upload a Certificate

|                |                                                                                                                                                                                                             |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Upload a certificate to an endpoint                                                                                                                                                                         |
| URI            | <http://localhost:9763/publisher/site/blocks/item-design/ajax/add.jag>                                                                                                                                      |
| URI Parameters | action=addCertificate&alias=&lt;certificate-alias&gt;&ep=&lt;endpoint&gt;&certificate=&lt;certificate-file&gt;                                                                                              |
| HTTP Methods   | POST                                                                                                                                                                                                        |
| Example        | curl -X POST -b cookies " <http://localhost:9763/publisher/site/blocks/item-design/ajax/add.jag> \\                                                                                                         
                                                                                                                                                                                                               
  -H 'content-type: application/x-www-form-urlencoded' \\ -d 'action=addCertificate&alias=wso2&ep=http%3A%2F% [2Fwso2.com](http://2Fwso2.com) &certificate=Q2VydGlmaWNhdGU6CiAgICBEYXRhOgogICAgICAgIFZlcnNpb2  |

#### Remove a Certificate

|                |                                                                                                                                                                                                                                             |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Description    | Remove a certificate to given for a certain endpoint                                                                                                                                                                                        |
| URI            | <http://localhost:9763/publisher/site/blocks/item-design/ajax/add.jag>                                                                                                                                                                      |
| URI Parameters | action=deleteCert&alias=&lt;certificate-alias&gt;&endpoint=&lt;endpoint&gt;                                                                                                                                                                 |
| HTTP Methods   | POST                                                                                                                                                                                                                                        |
| Example        | curl -X POST -b cookies <http://localhost:9763/publisher/site/blocks/item-design/ajax/add.jag> -H 'content-type: application/x-www-form-urlencoded' -d 'action=deleteCert&alias=wso2&endpoint=http%3A%2F% [2Fwso2.com](http://2Fwso2.com) ' |

------------------------------------------------------------------------

#### Analytics related APIs

!!! note
Before using the following analytics related APIs, ensure to configure Analytics for API-M. For more information, see [Configuring APIM Analytics](https://docs.wso2.com/display/AM260/Configuring+APIM+Analytics) .


-   [Get List of API Creators](#PublisherAPIs-GetListofAPICreators)
-   [Get Subscriber Count](#PublisherAPIs-GetSubscriberCount)
-   [Get API Usage By Resource Path](#PublisherAPIs-GetAPIUsageByResourcePath)
-   [Get API Usage By Destination](#PublisherAPIs-GetAPIUsageByDestination)
-   [Get API Usage by Provider](#PublisherAPIs-GetAPIUsagebyProvider)
-   [Get API and Application Throttling Data](#PublisherAPIs-GetAPIandApplicationThrottlingData)
-   [Get API Response Fault Count](#PublisherAPIs-GetAPIResponseFaultCount)

##### Get List of API Creators

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get the list of all the API creators.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage-user/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage-user/ajax/stats.jag</a></p></td>
</tr>
<tr class="odd">
<td>Request Headers</td>
<td><p>&quot;Content-Type&quot; -&gt; &quot;application/x-www-form-urlencoded&quot;<br />
“Cookie” -&gt; “JSESSIONID=29FCD6CF81BED3701B2F0FD00A7D14B6574F6BF4AF4F4A4D3E6DA7CE1DB8AC82882E3CDBE32C2037AF6F6FCB926B0F649E5833EC2D7AA07FC3A56654883CB972C3F6910B6100C5C7DF5386D3CE2F20316B779550BDE58F40160C48BCC8E189EB0EDFAEF671B7787BBC4767E3FDCC8BFB80DC658578A1D157901F3FFF76858C7B; Path=/publisher/; Secure; HttpOnly”</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Payload</td>
<td>action=getAPIUsageByUser&amp;currentLocation=/publisher/site/pages/all-statistics.jag&amp;fromDate=2014-05-10 00:00:00&amp;toDate=2016-12-16 13:41:13&amp;apiFilter=allAPIs</td>
</tr>
<tr class="even">
<td>Example</td>
<td><p>curl -v -b cookies -XPOST -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'action=getAPIUsageByUser&amp;currentLocation=/publisher/site/pages/all-statistics.jag&amp;fromDate=2014-05-10 00:00:00&amp;toDate=2016-12-16 13:41:13&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage-user/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage-user/ajax/stats.jag</a> '</p></td>
</tr>
<tr class="odd">
<td>Sample Response</td>
<td><p>&lt; HTTP/1.1 200 OK<br />
&lt; Server: nginx<br />
&lt; Date: Mon, 09 Jan 2017 05:13:07 GMT<br />
&lt; Content-Type: application/json;charset=UTF-8<br />
&lt; Content-Length: 239<br />
&lt; Connection: keep-alive<br />
&lt; Strict-Transport-Security: max-age=15768000<br />
&lt; X-Frame-Options: DENY<br />
&lt; X-Content-Type-Options: nosniff<br />
&lt; X-XSS-Protection: 1; mode=block<br />
{&quot;error&quot; : false, &quot;usage&quot; : [{&quot;apiName&quot; : &quot;buzzwordapi&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;userID&quot; : &quot; <a href="http://sabra.wso2.com">sabra.wso2.com</a> @sabraorg&quot;, &quot;count&quot; : 14}, {&quot;apiName&quot; : &quot;buzzwordapinew&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;userID&quot; : &quot; <a href="http://sabra.wso2.com">sabra.wso2.com</a> @sabraorg&quot;, &quot;count&quot; : 1}]}</p></td>
</tr>
</tbody>
</table>

##### Get Subscriber Count

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get the number of subscribers.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-subscriptions/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-subscriptions/ajax/stats.jag</a></p></td>
</tr>
<tr class="odd">
<td>Request Headers</td>
<td><p>&quot;Content-Type&quot; -&gt; &quot;application/x-www-form-urlencoded&quot;<br />
“Cookie” -&gt; “JSESSIONID=29FCD6CF81BED3701B2F0FD00A7D14B6574F6BF4AF4F4A4D3E6DA7CE1DB8AC82882E3CDBE32C2037AF6F6FCB926B0F649E5833EC2D7AA07FC3A56654883CB972C3F6910B6100C5C7DF5386D3CE2F20316B779550BDE58F40160C48BCC8E189EB0EDFAEF671B7787BBC4767E3FDCC8BFB80DC658578A1D157901F3FFF76858C7B; Path=/publisher/; Secure; HttpOnly”</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Payload</td>
<td><p>action:getSubscriberCountByAPIs<br />
<a href="http://currentLocation/publisher/site/pages/all-statistics.jag">currentLocation:/publisher/site/pages/all-statistics.jag</a><br />
apiFilter:allAPIs</p></td>
</tr>
<tr class="even">
<td>Example</td>
<td><p>curl  -v -b cookies -XPOST -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'action=getSubscriberCountByAPIs&amp;currentLocation=/publishe/site/pages/all-statistics.jag&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-subscriptions/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-subscriptions/ajax/stats.jag</a> '</p></td>
</tr>
<tr class="odd">
<td>Sample Response</td>
<td><p>&lt; HTTP/1.1 200 OK<br />
&lt; Server: nginx<br />
&lt; Date: Mon, 09 Jan 2017 05:15:49 GMT<br />
&lt; Content-Type: application/json;charset=UTF-8<br />
&lt; Content-Length: 198<br />
&lt; Connection: keep-alive<br />
&lt; Strict-Transport-Security: max-age=15768000<br />
&lt; X-Frame-Options: DENY<br />
&lt; X-Content-Type-Options: nosniff<br />
&lt; X-XSS-Protection: 1; mode=block<br />
{&quot;error&quot; : false, &quot;usage&quot; : [{&quot;apiName&quot; : [&quot;buzzwordapi&quot;, &quot;1.0.0&quot;, &quot; <a href="http://sabra.wso2.com">sabra.wso2.com</a> -AT-sabraorg&quot;], &quot;count&quot; : 2}, {&quot;apiName&quot; : [&quot;buzzwordapinew&quot;, &quot;1.0.0&quot;, &quot; <a href="http://sabra.wso2.com">sabra.wso2.com</a> -AT-sabraorg&quot;], &quot;count&quot; : 2}]}</p></td>
</tr>
</tbody>
</table>

##### Get API Usage By Resource Path

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get the API usage based on the resource path.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage-resource-path/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage-resource-path/ajax/stats.jag</a></p></td>
</tr>
<tr class="odd">
<td>Request Headers</td>
<td><p>&quot;Content-Type&quot; -&gt; &quot;application/x-www-form-urlencoded&quot;<br />
“Cookie” -&gt; “JSESSIONID=29FCD6CF81BED3701B2F0FD00A7D14B6574F6BF4AF4F4A4D3E6DA7CE1DB8AC82882E3CDBE32C2037AF6F6FCB926B0F649E5833EC2D7AA07FC3A56654883CB972C3F6910B6100C5C7DF5386D3CE2F20316B779550BDE58F40160C48BCC8E189EB0EDFAEF671B7787BBC4767E3FDCC8BFB80DC658578A1D157901F3FFF76858C7B; Path=/publisher/; Secure; HttpOnly”</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Payload</td>
<td><p>action:getAPIUsageByResourcePath<br />
<a href="http://currentLocation/publisher/site/pages/all-statistics.jag">currentLocation:/publisher/site/pages/all-statistics.jag</a><br />
fromDate:2014-05-10 00:00:00<br />
toDate:2016-12-16 14:34:33<br />
apiFilter:allAPIs</p></td>
</tr>
<tr class="even">
<td>Example</td>
<td><p>curl -v -b cookies -XPOST -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'action=getAPIUsageByResourcePath&amp;currentLocation=%2Fpublisher%2Fsite%2Fpages%2Fall-statistics.jag&amp;fromDate=2014-05-10+00%3A00%3A00&amp;toDate=2016-12-16+14%3A34%3A33&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage-resource-path/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage-resource-path/ajax/stats.jag</a> '</p></td>
</tr>
<tr class="odd">
<td>Sample Response</td>
<td><p>&lt; HTTP/1.1 200 OK<br />
&lt; Server: nginx<br />
&lt; Date: Mon, 09 Jan 2017 05:16:59 GMT<br />
&lt; Content-Type: application/json;charset=UTF-8<br />
&lt; Content-Length: 1092<br />
&lt; Connection: keep-alive<br />
&lt; Strict-Transport-Security: max-age=15768000<br />
&lt; X-Frame-Options: DENY<br />
&lt; X-Content-Type-Options: nosniff<br />
&lt; X-XSS-Protection: 1; mode=block<br />
&lt;<br />
{&quot;error&quot; : false, &quot;usage&quot; : [{&quot;apiName&quot; : &quot;buzzwordapi&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/sabraorg/buzzwordservice/1.0.0&quot;, &quot;method&quot; : &quot;GET&quot;, &quot;count&quot; : 2, &quot;time&quot; : &quot;2016-04-08 03:22&quot;, &quot;resourcePath&quot; : &quot;/buzzwordservice/1.0.0/all&quot;}, {&quot;apiName&quot; : &quot;buzzwordapi&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/sabraorg/buzzwordservice/1.0.0&quot;, &quot;method&quot; : &quot;GET&quot;, &quot;count&quot; : 8, &quot;time&quot; : &quot;2016-04-25 04:54&quot;, &quot;resourcePath&quot; : &quot;/buzzwordservice/1.0.0/all&quot;}, {&quot;apiName&quot; : &quot;buzzwordapi&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/sabraorg/buzzwordservice/1.0.0&quot;, &quot;method&quot; : &quot;GET&quot;, &quot;count&quot; : 1, &quot;time&quot; : &quot;2016-04-08 03:22&quot;, &quot;resourcePath&quot; : &quot;/buzzwordservice/1.0.0/mostPopular&quot;}, {&quot;apiName&quot; : &quot;buzzwordapi&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/sabraorg/buzzwordservice/1.0.0&quot;, &quot;method&quot; : &quot;GET&quot;, &quot;count&quot; : 3, &quot;time&quot; : &quot;2016-04-25 04:44&quot;, &quot;resourcePath&quot; : &quot;/buzzwordservice/1.0.0/mostPopular&quot;}, {&quot;apiName&quot; : &quot;buzzwordapinew&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/sabraorg/buzzwordservicenew/1.0.0&quot;, &quot;method&quot; : &quot;GET&quot;, &quot;count&quot; : 1, &quot;time&quot; : &quot;2016-05-05<br />
05:29&quot;, &quot;resourcePath&quot; : &quot;/buzzwordservicenew/1.0.0/mostPopular&quot;}]}</p></td>
</tr>
</tbody>
</table>

##### Get API Usage By Destination

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get the API usage based on the destination</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage-destination/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage-destination/ajax/stats.jag</a></p></td>
</tr>
<tr class="odd">
<td>Request Headers</td>
<td><p>&quot;Content-Type&quot; -&gt; &quot;application/x-www-form-urlencoded&quot;<br />
“Cookie” -&gt; “JSESSIONID=29FCD6CF81BED3701B2F0FD00A7D14B6574F6BF4AF4F4A4D3E6DA7CE1DB8AC82882E3CDBE32C2037AF6F6FCB926B0F649E5833EC2D7AA07FC3A56654883CB972C3F6910B6100C5C7DF5386D3CE2F20316B779550BDE58F40160C48BCC8E189EB0EDFAEF671B7787BBC4767E3FDCC8BFB80DC658578A1D157901F3FFF76858C7B; Path=/publisher/; Secure; HttpOnly”</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Payload</td>
<td><p>action:getAPIUsageByDestination<br />
<a href="http://currentLocation/publisher/site/pages/all-statistics.jag">currentLocation:/publisher/site/pages/all-statistics.jag</a><br />
fromDate:2014-05-10 00:00:00<br />
toDate:2016-12-16 14:34:33<br />
apiFilter:allAPIs</p></td>
</tr>
<tr class="even">
<td>Example</td>
<td><p>curl -v -b cookies -XPOST -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'action=getAPIUsageByDestination&amp;currentLocation=%2Fpublisher%2Fsite%2Fpages%2Fall-statistics.jag&amp;fromDate=2014-05-10+00%3A00%3A00&amp;toDate=2016-12-16+14%3A34%3A33&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage-destination/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage-destination/ajax/stats.jag</a> '</p></td>
</tr>
<tr class="odd">
<td>Sample Response</td>
<td><p>&lt; HTTP/1.1 200 OK<br />
&lt; Server: nginx<br />
&lt; Date: Fri, 16 Dec 2016 09:22:43 GMT<br />
&lt; Content-Type: application/json;charset=UTF-8<br />
&lt; Content-Length: 359<br />
&lt; Connection: keep-alive<br />
&lt; Strict-Transport-Security: max-age=15768000<br />
&lt; X-Frame-Options: DENY<br />
&lt; X-Content-Type-Options: nosniff<br />
&lt; X-XSS-Protection: 1; mode=block<br />
{&quot;error&quot; : false, &quot;usage&quot; : [{&quot;apiName&quot; : &quot;Cedum&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/anuruddha/demo/1.0.0&quot;, &quot;destination&quot; : &quot; <a href="http://ceduam.cloudapp.net:3000" class="uri">http://ceduam.cloudapp.net:3000</a> &quot;, &quot;count&quot; : 6}, {&quot;apiName&quot; : &quot;PhoneVerification&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/anuruddha/phoneverify/1.0.0&quot;, &quot;destination&quot; : &quot; <a href="http://ws.cdyne.com/phoneverify/phoneverify.asmx" class="uri">http://ws.cdyne.com/phoneverify/phoneverify.asmx</a> &quot;, &quot;count&quot; : 1}]}</p></td>
</tr>
</tbody>
</table>

##### Get API Usage by Provider

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get API Usage by Provider.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><p><a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage/ajax/stats.jag</a></p></td>
</tr>
<tr class="odd">
<td>Request Headers</td>
<td><p>&quot;Content-Type&quot; -&gt; &quot;application/x-www-form-urlencoded&quot;<br />
“Cookie” -&gt; “JSESSIONID=29FCD6CF81BED3701B2F0FD00A7D14B6574F6BF4AF4F4A4D3E6DA7CE1DB8AC82882E3CDBE32C2037AF6F6FCB926B0F649E5833EC2D7AA07FC3A56654883CB972C3F6910B6100C5C7DF5386D3CE2F20316B779550BDE58F40160C48BCC8E189EB0EDFAEF671B7787BBC4767E3FDCC8BFB80DC658578A1D157901F3FFF76858C7B; Path=/publisher/; Secure; HttpOnly”</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Payload</td>
<td><p>action:getProviderAPIUsage<br />
<a href="http://currentLocation/publisher/site/pages/all-statistics.jag">currentLocation:/publisher/site/pages/all-statistics.jag</a><br />
fromDate:2014-05-10 00:00:00<br />
toDate:2016-12-16 14:34:33<br />
apiFilter:allAPIs</p></td>
</tr>
<tr class="even">
<td>Example</td>
<td><p>curl -v -b cookies -XPOST -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'ac<br />
tion=getProviderAPIUsage&amp;currentLocation=%2Fpublisher%2Fsite%2Fpages%2Fall-statistics.jag&amp;fromDate=2014-05-10+00%3A00%3A00&amp;toDate=2016-12-16+14%3A34%3A33&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-usage/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-usage/ajax/stats.jag</a> '</p></td>
</tr>
<tr class="odd">
<td>Sample Response</td>
<td><p>&lt; HTTP/1.1 200 OK<br />
&lt; Server: nginx<br />
&lt; Date: Fri, 16 Dec 2016 09:30:43 GMT<br />
&lt; Content-Type: application/json;charset=UTF-8<br />
&lt; Content-Length: 219<br />
&lt; Connection: keep-alive<br />
&lt; Strict-Transport-Security: max-age=15768000<br />
&lt; X-Frame-Options: DENY<br />
&lt; X-Content-Type-Options: nosniff<br />
&lt; X-XSS-Protection: 1; mode=block<br />
<br />
{&quot;error&quot; : false, &quot;usage&quot; : [{&quot;apiName&quot; : &quot;[\&quot;Cedum\&quot;,\&quot;1.0.0\&quot;,\&quot; <a href="http://anuruddhal.wso2.com">anuruddhal.wso2.com</a> -AT-anuruddha\&quot;]&quot;, &quot;count&quot; : 8}, {&quot;apiName&quot; : &quot;[\&quot;PhoneVerification\&quot;,\&quot;1.0.0\&quot;,\&quot; <a href="http://anuruddhal.wso2.com">anuruddhal.wso2.com</a> -AT-anuruddha\&quot;]&quot;, &quot;count&quot; : 2}]}</p></td>
</tr>
</tbody>
</table>

##### Get API and Application Throttling Data

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get the throttling related data related to the APIs and applications.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-throttledcounts/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-throttledcounts/ajax/stats.jag</a></td>
</tr>
<tr class="odd">
<td>Request Headers</td>
<td><p>&quot;Content-Type&quot; -&gt; &quot;application/x-www-form-urlencoded&quot;<br />
“Cookie” -&gt; “JSESSIONID=29FCD6CF81BED3701B2F0FD00A7D14B6574F6BF4AF4F4A4D3E6DA7CE1DB8AC82882E3CDBE32C2037AF6F6FCB926B0F649E5833EC2D7AA07FC3A56654883CB972C3F6910B6100C5C7DF5386D3CE2F20316B779550BDE58F40160C48BCC8E189EB0EDFAEF671B7787BBC4767E3FDCC8BFB80DC658578A1D157901F3FFF76858C7B; Path=/publisher/; Secure; HttpOnly”</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Payload</td>
<td><p>action:getThrottleDataOfAPIAndApplication<br />
<a href="http://currentLocation/publisher/site/pages/all-statistics.jag">currentLocation:/publisher/site/pages/all-statistics.jag</a><br />
fromDate:2014-05-10 00:00:00<br />
toDate:2016-12-16 14:34:33<br />
apiFilter:allAPIs<br />
apiName: Cedum<br />
appName:</p></td>
</tr>
<tr class="even">
<td>Example</td>
<td>curl -v -b cookies -XPOST -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'action=getThrottleDataOfAPIAndApplication&amp;currentLocation=%2Fpublisher%2Fsite%2Fpages%2Fall-statistics.jag&amp;apiName=Cedum&amp;appName=&amp;fromDate=2014-05-10+00%3A00%3A00&amp;toDate=2016-12-16+15%3A07%3A00&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-throttledcounts/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-throttledcounts/ajax/stats.jag</a> '</td>
</tr>
<tr class="odd">
<td>Sample Response</td>
<td><p>&lt; HTTP/1.1 200 OK<br />
&lt; Server: nginx<br />
&lt; Date: Fri, 16 Dec 2016 09:43:04 GMT<br />
&lt; Content-Type: application/json;charset=UTF-8<br />
&lt; Content-Length: 17<br />
&lt; Connection: keep-alive<br />
&lt; Strict-Transport-Security: max-age=15768000<br />
&lt; X-Frame-Options: DENY<br />
&lt; X-Content-Type-Options: nosniff<br />
&lt; X-XSS-Protection: 1; mode=block<br />
&lt; Set-Cookie: JSESSIONID=AA2ADAFAD614FDDCE276E1E63EA836BBEBF098FA685A4FE6B8BB9110FC1E4B8688C61824325CB24491A78B66ABF30F38AEBB6ACBBBB7400F85FEB4D4C77A9E34AF04C92523149ED8873E8EB4834260D87D8B846684F72CBD5578BAB3B372D8EB648783C09A9DB750231B5515919A17688D8E5DFC05805FBBA3E5D5AB6B38799D; Path=/publisher/; Secure; HttpOnly<br />
{&quot;error&quot; : false}localhost:bin anuruddha$ curl -XPOST -H 'Cookie: JSESSIONID=AA2ADAFAD614FDDCE276E1E63EA836BBEBF098FA685A4FE6B8BB9110FC1E4B8688C61824325CB24491A78B66ABF30F38AEBB6ACBBBB7400F85FEB4D4C77A9E3873E8EB4834260D87D8B846684F72CBD5578BAB3B372D8EB648783C09A9DB750231B5515919A17688D8E5DFC05805FBBA3E5D5AB6B38799D; Path=/publisher/; Secure; HttpOnly' -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'action=getThrottleDataOfAPIAndApplication&amp;currentLocation=%2Fpublisher%2Fsite%2Fpages%2Fall-statistics.jag&amp;apiName=Cedum&amp;appName=&amp;fromDate=2014-05-10+00%3A00%3A00&amp;toDate=2016-12-16+15%3A07%3A00&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/api-throttledcounts/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/api-throttledcounts/ajax/stats.jag</a> '<br />
{&quot;error&quot; : false, &quot;usage&quot; : {&quot;result&quot; : [{&quot;apiName&quot; : &quot;Cedum&quot;, &quot;apiPublisher&quot; : &quot;__all_providers__@anuruddha&quot;, &quot;successRequestCount&quot; : 2, &quot;throttleOutCount&quot; : 0, &quot;time&quot; : &quot;2016-12-14 00:00:00&quot;}, {&quot;apiName&quot; : &quot;Cedum&quot;, &quot;apiPublisher&quot; : &quot;__all_providers__@anuruddha&quot;, &quot;successRequestCount&quot; : 6, &quot;throttleOutCount&quot; : 0, &quot;time&quot; : &quot;2016-12-15 00:00:00&quot;}], &quot;groupBy&quot; : &quot;day&quot;, &quot;timeUnitMili&quot; : 86400000}}</p></td>
</tr>
</tbody>
</table>

##### Get API Response Fault Count

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>Description</td>
<td>Get the response fault count of APIs.</td>
</tr>
<tr class="even">
<td>URI</td>
<td><a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/faulty-invocations/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/faulty-invocations/ajax/stats.jag</a></td>
</tr>
<tr class="odd">
<td>Request Headers</td>
<td><p>&quot;Content-Type&quot; -&gt; &quot;application/x-www-form-urlencoded&quot;<br />
“Cookie” -&gt; “JSESSIONID=29FCD6CF81BED3701B2F0FD00A7D14B6574F6BF4AF4F4A4D3E6DA7CE1DB8AC82882E3CDBE32C2037AF6F6FCB926B0F649E5833EC2D7AA07FC3A56654883CB972C3F6910B6100C5C7DF5386D3CE2F20316B779550BDE58F40160C48BCC8E189EB0EDFAEF671B7787BBC4767E3FDCC8BFB80DC658578A1D157901F3FFF76858C7B; Path=/publisher/; Secure; HttpOnly”</p></td>
</tr>
<tr class="even">
<td>HTTP Methods</td>
<td>POST</td>
</tr>
<tr class="odd">
<td>Payload</td>
<td><p>action:getThrottleDataOfAPIAndApplication<br />
<a href="http://currentLocation/publisher/site/pages/all-statistics.jag">currentLocation:/publisher/site/pages/all-statistics.jag</a><br />
fromDate:2014-05-10 00:00:00<br />
toDate:2016-12-16 14:34:33<br />
apiFilter:allAPIs</p></td>
</tr>
<tr class="even">
<td>Example</td>
<td>curl -v -b cookies -XPOST -H &quot;Content-type: application/x-www-form-urlencoded&quot; -d 'action=getAPIResponseFaultCount&amp;currentLocation=%2Fpublisher%2Fsite%2Fpages%2Fall-statistics.jag&amp;fromDate=2014-05-10+00%3A00%3A00&amp;toDate=2016-12-16+15%3A07%3A00&amp;apiFilter=allAPIs' ' <a href="https://api.cloud.wso2.com/publisher/site/blocks/stats/faulty-invocations/ajax/stats.jag">http://localhost:9763/publisher/site/blocks/stats/faulty-invocations/ajax/stats.jag</a> '</td>
</tr>
<tr class="odd">
<td>Sample Response</td>
<td><p>&lt; HTTP/1.1 200 OK<br />
&lt; Server: nginx<br />
&lt; Date: Fri, 16 Dec 2016 09:53:17 GMT<br />
&lt; Content-Type: application/json;charset=UTF-8<br />
&lt; Content-Length: 176<br />
&lt; Connection: keep-alive<br />
&lt; Strict-Transport-Security: max-age=15768000<br />
&lt; X-Frame-Options: DENY<br />
&lt; X-Content-Type-Options: nosniff<br />
&lt; X-XSS-Protection: 1; mode=block<br />
{&quot;error&quot; : false, &quot;usage&quot; : [{&quot;apiName&quot; : &quot;Cedum&quot;, &quot;version&quot; : &quot;1.0.0&quot;, &quot;context&quot; : &quot;/t/anuruddha/demo/1.0.0&quot;, &quot;faultPercentage&quot; : 12.5, &quot;count&quot; : 1, &quot;totalRequestCount&quot; : 8}]}</p></td>
</tr>
</tbody>
</table>


