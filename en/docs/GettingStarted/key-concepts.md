# Key Concepts

Let's take a look at some concepts and terminology that you need to know in order to follow the use cases.

\[ [Main usecase](#KeyConcepts-Mainusecase) \] \[ [API Manager components - Overview](#KeyConcepts-APIManagercomponents-Overview) \] \[ [Terminology & Concepts](#KeyConcepts-Terminology&Concepts) \]

### Main usecase

The WSO2 API Manager is used to design, publish and manage API's. A typical scenario utilizing the main features of the product is as follows.

A **creator** designs or imports an **API** on the WSO2 API publisher portal. A **publisher** will log onto the WSO2 API Publisher portal and publish the created API(s). This will make the API appear on the store.

A **subscriber** logs into the WSO2 API Developer portal and creates an **application** . An application is a logical collection of APIs & may consist of any number of APIs. The subscriber will then proceed to add API's to relevant applications. In order to invoke the API's the subscriber will  generate tokens for the applications.  Using the token created for the application, the resources of the API can be invoked. The invocations to the API(s) will be subjected to any throttling policies applied.

### API Manager components - Overview

The WSO2 API Manager consists of the following component

![](attachments/103328852/119142745.jpg){width="900"}

### Terminology & Concepts

<table>
<thead>
<tr class="header">
<th>Concept / Terminology</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Admin</td>
<td><p>The API management provider who hosts and manages the API Gateway . S/he is responsible for creating user roles in the system, assign them roles, managing databases, security etc. The Admin role is available by default with the credentials admin/admin. The API Manager offers four distinct community roles that are applicable to most enterprises. Admon role is one of them.</p></td>
</tr>
<tr class="even">
<td><p>API</p></td>
<td><p>An API is the fundamental building block of the WSO2 API Manager.  It basically defines how a backend service exposed by that API, can be correctly invoked. WSO2 API Manager provides the capability to design or import REST/SOAP APIs. It allows the creation of websocket APIs. REST or SOAP API's created on the WSO2 API Manager can have resources defined. These resources are a dirrect mapping to the services provided by its backend. Scopes can be added per resource in order to add more fine grained access restrictions to the API.  APIs created on the WSO2 API Manager can be version controlled providing good governance. Moreover, access to the API and visiblity of the API is also configurable. The WSO2 API Publisher portal provides the facilitity to configure the endpoint of the backend service in the API definition as well as attach mediation policies. APIs can also be configured to support HTTP or  HTTPS. The subscription level throttling tiers needs to be defined when creating an API as the tiers will be avilable for selecting when subscribing the API to an Application.</p></td>
</tr>
<tr class="odd">
<td><p>API Resource</p></td>
<td><div class="content-wrapper">
<p>An API is made up of one or more resources, each of which handles a particular type of request. A resource has a set of methods that operate on it. The methods is analogous to a method or a function, and a resource is analogous to an object instance or a class in an object-oriented programming language. There are a few standard methods defined for a resource (corresponding to the standard HTTP GET, POST, PUT and DELETE methods.)</p>
<p>When you add resources to an API, you define a URL pattern and <a href="#KeyConcepts-HTTPmethods">HTTP methods</a> . A resource can also have a list of <a href="#KeyConcepts-OAuthscopes">OAuth scopes</a> .</p>
</div></td>
</tr>
<tr class="even">
<td><p>Application</p></td>
<td><p>An application is a logical collection of APIs. An application is primarily used to decouple the consumer from the APIs. It allows you to:</p>
<ul>
<li>Generate and use a single key for multiple APIs</li>
<li>Subscribe multiple times to a single API with different tiers/Service Level Agreement (SLA) levels</li>
</ul>
<p>You subscribe to APIs through an application. Applications are available at different SLA levels and have application-level throttling tiers engaged in them. A throttling tier determines the maximum number of calls you can make to an API during a given period of time.</p>
<p>The API Manager comes with a pre-created default application, which allows unlimited access by default. You can also <a href="https://docs.wso2.com/display/SHAN/Subscribe+to+an+API">create</a> your own applications.</p></td>
</tr>
<tr class="odd">
<td><p>API lifecycle</p></td>
<td><div class="content-wrapper">
<p>An API is the published interface, while the service is the implementation running in the backend. APIs have their own lifecycles that are independent to the backend services they rely on. This lifecycle is exposed in the API publisher web interface and is managed by the API publisher role.</p>
<p>The following stages are available in the default API lifecycle:</p>
<ul>
<li><strong>CREATED:</strong> API metadata is added to the API Store, but it is not deployed in the API Gateway and therefore, is not visible to subscribers in the API Store.</li>
<li><strong>PROTOTYPED:</strong> The API is deployed and published in the API Store as a prototype. A prototyped API is usually a mock implementation made public in order to get feedback about its usability. Users can invoke the API without a subscription.</li>
<li><strong>PUBLISHED</strong> : The API is visible in the API Store and available for subscription.</li>
<li><strong>DEPRECATED:</strong> When an API is deprecated, new subscriptions are disabled. But the API is still deployed in the Gateway and is available at runtime to existing subscribers. Existing subscribers can continue to use it as usual until the API is retired.</li>
<li><strong>RETIRED</strong> : The API is unpublished from the API Gateway and deleted from the store.</li>
<li><div>
<strong>BLOCKED:</strong> Access to the API is temporarily blocked. Runtime calls are blocked and the API is not shown in the API Store anymore.
</div></li>
</ul>
</div></td>
</tr>
<tr class="even">
<td><p>Access tokens</p></td>
<td><p>An <strong>access token</strong> is a simple string that is passed as an HTTP header of a request. For example, &quot; <code>              Authorization: Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a             </code> .&quot; Access tokens authenticate API users and applications, and ensure better security (e.g., prevent certain types of <strong>DoS attacks.</strong> Note that DoS attacks made to the key manager with random access tokens can not be prevented. DoS attacks with the same fake acess token can affect the Gateway as well <strong></strong> ). If a token that is passed with a request is invalid, the request is discarded at the first stage of processing. Access tokens work equally well for SOAP and REST calls.</p>
<p>For more information on different types of access tokens and how to generate them, see <a href="https://docs.wso2.com/display/SHAN/Working+with+Access+Tokens">Working with Access Tokens</a> .</p></td>
</tr>
<tr class="odd">
<td><p>API visibility</p></td>
<td><div class="content-wrapper">
<p>Visibility settings prevent certain user roles from viewing and modifying APIs created by another user role.</p>
<ul>
<li><strong>Public:</strong> The API is visible to all users who are registered and anonymous (who use APIs without login to the store, for example testing and demonstration), and can be advertised in multiple stores (central and non-WSO2 stores).</li>
<li><p><strong>Restricted by Roles:</strong> The API is visible to it's tenant domain and only to the user roles that you specify. You should provide the roles separated by commas in the UI or as a cURL parameter when creating or editing the API.</p></li>
<li><p><strong>Visible to my domain:</strong> The API is visible to all users who are registered to the API's tenant domain. This option is <strong>available only in a <a href="https://docs.wso2.com/display/SHAN/Configuring+Multiple+Tenants">multi-tenanted environment</a></strong> . It's not applicable when there is only one active tenant (super tenant) in the system.</p></li>
</ul>
<p>Given below is how visibility levels work for users in different roles:</p>
<ul>
<li>The API <strong>Creator</strong> and <strong>Publisher</strong> roles can see all APIs in their tenant store even if you restrict access to them. This is because those roles have permission to view and edit all APIs in the API Publisher, and therefore, does not have to be restricted in the Store.</li>
<li>Anonymous users can only see APIs that have the visibility set as <strong>Public.</strong></li>
<li>Registered users can see
<ul>
<li>public APIs of all tenant domains.</li>
<li>all APIs in the registered user's tenant domain as long as the API is not restricted to a role that the user is assigned to.</li>
</ul></li>
</ul>
<p>By default, an API has public visibility. You can set the API visibility in the <strong>Design</strong> tab of the API Publisher at the time the API is created or updated.</p>
<p>When using the REST API directly, these visibility options are available as <strong>public, private and restricted</strong> .</p>
<div class="table-wrap">
<table>
<thead>
<tr class="header">
<th>API visiblity level specified in the UI</th>
<th>API visiblity level specified in the REST API</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Public</td>
<td>public i.e. &quot;visibility&quot;: &quot;PUBLIC&quot;</td>
</tr>
<tr class="even">
<td>Visible to my domain</td>
<td>private i.e. &quot;visibility&quot;: &quot;PRIVATE&quot;</td>
</tr>
<tr class="odd">
<td>Restricted by roles</td>
<td>restricted i.e. &quot;visibility&quot; :&quot;RESTRICTED&quot; , visibleRoles :[&quot;role1&quot;,&quot;role2&quot;, &quot;role3&quot;]</td>
</tr>
</tbody>
</table>
</div>
</div></td>
</tr>
<tr class="even">
<td><p>API templates</p></td>
<td><p>An API template is its XML representation, which is saved in <code>              &lt;APIM_HOME&gt;/repository/resources/api_templates/              velocity_template.xml             </code> file. This file comes with the API Manager by default. You can edit this default template to change the synapse configuration of all APIs that are created.</p>
<p>If you are using a distributed API Manager setup (i.e., Publisher, Store, Gateway and Key Manager components are running on separate JVMs), edit the template in the Publisher node.</p></td>
</tr>
<tr class="odd">
<td>Creator</td>
<td>A creator is a person in a technical role who understands the technical aspects of the API (interfaces, documentation, versions etc.) and uses the API publisher to provision APIs into the API store. The creator uses the API Store to consult ratings and feedback provided by API users. Creator can add APIs to the store but cannot manage their lifecycle.</td>
</tr>
<tr class="even">
<td><p>Endpoints</p></td>
<td><p>An endpoint is a specific destination for a message such as an address, WSDL, a failover group, a load-balance group etc.</p>
<p>WSO2 API Manager has support for a range of different endpoint types, allowing the API Gateway to connect with advanced types of backends. It supports <a href="https://docs.wso2.com/display/EI611/HTTP+Endpoint">HTTP endpoints</a> , <a href="https://docs.wso2.com/display/EI611/Address+Endpoint">URL endpoints</a> (also termed as address endpoint), <a href="https://docs.wso2.com/display/EI611/WSDL+Endpoint">WSDL endpoints</a> , <a href="https://docs.wso2.com/display/EI611/Failover+Group">Failover endpoints</a> , <a href="https://docs.wso2.com/display/EI611/Load-balance+Group">Load-balanced endpoints</a> . For more information about endpoints, see <a href="https://docs.wso2.com/display/SHAN/Endpoints">Working with Endpoints</a> .</p></td>
</tr>
<tr class="odd">
<td><p>HTTP methods</p></td>
<td><div class="content-wrapper">
<p>HTTP methods specify the desired action to be performed on an <a href="#KeyConcepts-APIresources">API's resource</a> . You can select multiple methods from <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET">GET</a> , <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/POST">POST</a> , <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT">PUT</a> , <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE">DELETE</a> , <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH">PATCH</a> , <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/HEAD">HEAD</a> and <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/OPTIONS">OPTIONS</a> . A method has attributes such as an OAuth scope, authentication type, response content type, parameters etc.</p>
<p>The main attributes of a method are described below:</p>
</div>
<div class="table-wrap">
<table>
<tbody>
<tr class="odd">
<td>OAuth scopes</td>
<td><p>You can define a list of <a href="#KeyConcepts-OAuthscopes">OAuth scopes</a> to an API's resource and assign one of them to each HTTP method.</p></td>
</tr>
<tr class="even">
<td>Authentication type</td>
<td><p>The authentication type can be one of the following:</p>
<ul>
<li><strong>None:</strong> No authentication is applied and the API Gateway skips the authentication process.</li>
<li><strong>Application:</strong> Authentication is done by the application. The resource accepts application access tokens.</li>
<li><strong>Application User:</strong> Authentication is done by the application user. The resource accepts user access tokens.</li>
<li><strong>Application and Application User:</strong> Both application and application user level authentication is applied. Note that if you select this option in the UI, it appears as <strong>Any</strong> in the API Manager's internal data storage and data representation, and <strong>Any</strong> will appear in the response messages as well.</li>
</ul>
<p><strong>Note</strong> that for the resources that have HTTP verbs (GET, POST etc.) requiring authentication (i.e., Auth Type is not NONE), set <strong>None</strong> as the Auth type of <strong>OPTIONS</strong> . This is to support <a href="#KeyConcepts-Cross-originresourcesharing">CORS</a> (Cross Origin Resource Sharing) between the API Store and Gateway. (The above screenshot shows this).</p>
<p>The auth type is cached in the API Manager for better performance. If you change the auth type through the UI, it takes about 15 minutes to refresh the cache. During that time, the server returns the old auth type from the cache. If you want the changes to be reflected immediately, please restart the server after changing the auth type.</p></td>
</tr>
<tr class="odd">
<td>Response content type</td>
<td>You can use this attribute to document in what type the backend sends the response back to the API Manager. <strong>Note that this attribute doesn't do any message type conversion</strong> , but used simply as a way of letting the user know what type the response will be.</td>
</tr>
<tr class="even">
<td>Parameters</td>
<td>Parameters of an HTTP method are analogous to arguments of a function in an object-oriented programming language. A resource's parameters are cached in the <a href="https://docs.wso2.com/display/SHAN/Configuring+Caching">resource cache</a> at the API Gateway.</td>
</tr>
</tbody>
</table>
</div></td>
</tr>
<tr class="even">
<td><p>O Auth scopes</p></td>
<td><div class="content-wrapper">
<p>Scopes enable fine-grained access control to API resources based on user roles. You define scopes to an API's resources. When a user invokes the API, his/her OAuth 2 bearer token cannot grant access to any API resource beyond its associated scopes.</p>
!!! info
<p>OAuth provides a method for clients to access a protected resource on behalf of a resource owner. OAuth 2 bearer token is a security token that any party in possession of it can use the token for authentication. Refer <a href="https://tools.ietf.org/html/rfc6750">OAuth 2.0 Specification of Bearer Token Usage</a> for more information.</p>

</div></td>
</tr>
<tr class="odd">
<td>Publisher</td>
<td>A publisher manages a set of APIs across the enterprise or business unit and controls the API lifecycle, subscriptions and monetization aspects. The publisher is also interested in usage patterns for APIs and has access to all API statistics.</td>
</tr>
<tr class="even">
<td>Subscriber</td>
<td><p>A subscriber uses the API store to discover APIs, read the documentation and forums, rate/comment on the APIs, subscribes to APIs, obtain access tokens and invoke the APIs.</p></td>
</tr>
<tr class="odd">
<td><p>Subscription availability</p></td>
<td><div class="content-wrapper">
<p>The subscription availability option has three values as follows. You can set subscription availability to an API through the API Publisher's <strong>Manage</strong> tab.</p>
<ul>
<li><strong>Available to current tenant only:</strong> only users in the current organization/tenant domain can subscribe to the API.</li>
<li><strong>Available to all the tenants:</strong> users of all organizations/tenant domains can subscribe to the API.</li>
<li><strong>Available to specific tenants:</strong> users of the organizations/tenant domains that you specify, as well as the current tenant domain, can subscribe to the API.</li>
</ul>
<p>Subscription is only available to the current tenant in the following instances:</p>
<ul>
<li>When there is only one tenant in your system.</li>
<li>Even if there are multiple tenants in your system, when you select <strong>Visible to my domain</strong> or <strong>Restricted by roles</strong> as the API's visibility in the previous step.</li>
</ul>
<p>The diagram below depicts the relationship between the API's visibility and subscription availability:</p>
<img src="attachments/103328852/103328838.png" width="700" />
<p>Refer the article <a href="https://wso2.com/library/articles/2016/08/article-multi-tenant-api-management-with-wso2-api-manager/">Multi Tenant API Management with WSO2 API Manager</a> for examples and real world usage of the above concepts.</p>
</div></td>
</tr>
<tr class="even">
<td><p>Sequences</p></td>
<td><p>The API Manager has a default mediation flow that is executed in each API invocation. There are 3 default sequences engaged as <code>              in             </code> , <code>              out             </code> and <code>              fault             </code> which perform following.</p>
<div class="table-wrap">
<table>
<thead>
<tr class="header">
<th>Sequence</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>in</td>
<td>In-sequence is the first place that will be mediated through, once a request is dispatched to a resource of an API. At the end of the in-sequence the request can be forwarded to a back-end application for further processing.</td>
</tr>
<tr class="even">
<td>out</td>
<td>Any responses coming from the back-end system are mediated through the out-sequence of the resource of the API.</td>
</tr>
<tr class="odd">
<td>fault</td>
<td><p>Fault sequence is there to handle any errors that may occur while mediating a message through a resource.</p>
<div>
When the sequence or the proxy service encounters an error during mediation or while forwarding a message, the message that triggered the error is delegated to the specified fault sequence. Using the available mediators it is possible to log the erroneous message, forward it to a special error-tracking service, and send a SOAP fault back to the client indicating the error. We need to configure the fault sequence with the correct error handling instead of simply dropping messages. For more information, see <a href="https://docs.wso2.com/display/SHAN/Error+Handling">Error Handling</a> .
</div></td>
</tr>
</tbody>
</table>
</div></td>
</tr>
<tr class="odd">
<td><p>T hrottling tiers</p></td>
<td><div class="content-wrapper">
<p>Throttling allows you to limit the number of successful hits to an API during a given period of time, typically in cases such as the following:</p>
<ul>
<li>To protect your APIs from common types of security attacks such as certain types of D enial of Service (DoS) attacks</li>
<li>To regulate traffic according to infrastructure availability</li>
<li>To make an API, application, or a resource available to a consumer at different levels of service, usually for monetization purposes</li>
</ul>
<p>You can define throttling at the API, application, and resource levels. The final request limit granted to a given user on a given API is ultimately defined by the consolidated output of all throttling tiers together. For more information about throttling, see <a href="https://docs.wso2.com/display/SHAN/Setting+Throttling+Limits">Setting Throttling Limits</a> .</p>
</div></td>
</tr>
<tr class="even">
<td><p><br />
</p>
Multi tenanted API management</td>
<td><p>A tenant in WSO2 API Manager is a separate business level entity, such as an organizational unit or a department. Muli tenancy enables such organizational units/departments to share the same API Manager deployment and the respective resources, but function individually with an isolated view of the deployment. A tenant does not need to be aware of the other tenants in the system as by design the Multitenancy creates an isolated space for each tenant, although they are sharing the same deployment.</p>
<p>See the section <a href="https://docs.wso2.com/display/SHAN/Configuring+Multiple+Tenants">Configuring Multiple Tenants</a> for information on how to create tenants.</p>
<p>In WSO2 API Manager deployment, API Visibility and Subscription Availability are the two main applications of tenancy.</p>
<h6 id="KeyConcepts-APIvisibility"><strong>API visibility</strong></h6>
<p>API Manager allows users to control API visibility and subscription availability. API visibility can be one of the following options:</p>
<ul>
<li>Public</li>
<li>Restricted by roles</li>
<li>Visible to my domain</li>
</ul>
<h6 id="KeyConcepts-Subscriptionavailability">Subscription availability</h6>
<p>Subscription availability has three options. Those options are as follows:</p>
<ul>
<li>Available to current Tenant Only</li>
<li>Available to All the Tenants</li>
<li>Available to Specific Tenants</li>
</ul>
<p>See the section on <a href="#KeyConcepts-APIvisibilityandsubscription">API Visibility and Subscription</a> for more details on each category.</p>
<p>Additionally, its possible to configure a secondary userstore per tenant as well. For more information, see <a href="https://docs.wso2.com/display/ADMIN44x/Configuring+Secondary+User+Stores">Configuring Secondary Userstores</a> .<br />
</p></td>
</tr>
</tbody>
</table>


