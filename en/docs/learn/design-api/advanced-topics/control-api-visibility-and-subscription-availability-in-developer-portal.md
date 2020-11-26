# Control API Visibility, Subscription Availability and API documentation visibility in the Developer Portal

By default, the APIs created in the API Publisher Portal are visible to anyone (even anonymous users) who visits the Developer Portal. However, API Publishers can control the visibility of APIs using two approaches. API Publishers can select as to which users can view their APIs and which users can subscribe to their APIs.

## Control API visibility in the Developer Portal

Visibility settings prevent certain user roles from viewing and modifying APIs created by another user role. API visibility can be one of the following options:

- **Public:** The API is visible to all users who are registered and anonymous (who use APIs without signing in to the Developer Portal, for example testing and demonstration), and can be advertised in multiple Developer Portals (central and non-WSO2 stores).
- **Restricted by roles:** The API is visible to it's tenant domain and only to the user roles that you specify. You should provide the roles separated by commas in the UI or as a cURL parameter when creating or editing the API. 
- **Visible to my domain:** The API is visible to all users who are registered to the API's tenant domain. This option is available only in a multi-tenanted environment. It's not applicable when there is only one active tenant (super tenant) in the system.

Given below is how visibility levels work for users in different roles:

- The API **Creator** and **Publisher** roles can see all APIs in their tenant Developer Portal even if you restrict access to them. This is because those roles have permission to view and edit all APIs in the API Publisher, and therefore, do not have to be restricted in the Developer Portal.
- Anonymous users can only see APIs that have the visibility set as **Public.**
- Registered users can see,
    - public APIs of all tenant domains. 
    - all APIs in the registered user's tenant domain as long as the API is not restricted to a role that the user is assigned to.

### Control API visibility using the API Publisher

1.  Sign in to the API Publisher as an API creator using the following URL: 
    
     `https://<localhost>:9443/publisher` 

2.  [Create a new API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) or edit an existing API.
3.  Click **Design Configurations**, click **Developer Portal Visibility**, and select the desired visibility option.
    
     [![Developer Portal Visibility]({{base_path}}/assets/img/learn/api-visibility-devportal.png)]({{base_path}}/assets/img/learn/api-visibility-devportal.png)
    
     [![API visibility Developer Portal dropdown]({{base_path}}/assets/img/learn/api-visibility-devportal-dropdown.png)]({{base_path}}/assets/img/learn/api-visibility-devportal-dropdown.png)

4.  Save the API.

### Control API visibility using the REST API
You can use the [existing REST API]({{base_path}}/develop/product-apis/restful-apis/) to control the visibility of the API. Add the following element to the request body, including the relevant visibility,

`"visibility" : "PUBLIC"        `

When using the REST API directly, the visibility options are available as public, private, and restricted.

 <table>
    <thead>
    <tr class="header">
    <th>API visibility level specified in the UI</th>
    <th>API visibility level specified in the REST API</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Public</td>
    <td>public <br>Example: `"visibility": "PUBLIC"`</td>
    </tr>
    <tr class="even">
    <td>Restricted by roles</td>
    <td>restricted <br>Example: `"visibility" :"RESTRICTED" , visibleRoles :["role1","role2", "role3"]`</td>
    </tr>
    <tr class="odd">
    <td>Visible to my domain</td>
    <td>private <br>Example: `"visibility": "PRIVATE"`</td>
    </tr>
    </tbody>
    </table>


## Control Subscription Availability in Developer Portal

Subscription availability can be one of the following options:

- **Available to current Tenant Only:** only users in the current organization/tenant domain can subscribe to the API.
- **Available to All the Tenants:** users of all organizations/tenant domains can subscribe to the API.
- **Available to Specific Tenants:** users of the organizations/tenant domains that you specify, as well as the current tenant domain, can subscribe to the API.

The diagram below depicts the relationship between the API's visibility and subscription availability:
[![]({{base_path}}/assets/img/learn/api-visibility-relationship.png)](/{{base_path}}/assets/img/learn/api-visibility-relationship.png)


### Control subscription availability using the API Publisher

!!! note
    The subscription availability option will only be displayed if there are tenants in your environment.

1.  Sign in to the API Publisher as an API creator using the following URL: 

     `https://<localhost>:9443/publisher`

2.  [Create a new API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) or edit an existing API.

3.  Click **Subscriptions**, click the **Subscription Availability** dropdown, and select the desired subscription availability option.
     
     [ ![Relationship between the API's visibility and subscription availability]({{base_path}}/assets/img/learn/api-subscription-availability.png) ](/{{base_path}}/assets/img/learn/api-subscription-availability.png)

4.  Save the API.

### Control subscription availability using the REST API

You can use the [existing REST API]({{base_path}}/develop/product-apis/restful-apis/) to control the subscription availability of the API. Add the following element to the request body including the relevant subscription availability.

`"subscriptionAvailability" : "ALL_TENANTS"        `

When using the REST API directly, the subscription availability options are available as follows:

 <table>
    <thead>
    <tr class="header">
    <th>Subscription visibility level specified in the UI</th>
    <th>Subscription visibility level specified in the REST API</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Available to current tenant only</td>
    <td>CURRENT_TENANT <br>Example: `"subscriptionAvailability": "CURRENT_TENANT"`</td>
    </tr>
    <tr class="even">
    <td>Available to all the tenants</td>
    <td>ALL_TENANTS <br>Example: `"subscriptionAvailability" :"ALL_TENANTS"` </td>
    </tr>
    <tr class="odd">
    <td>Available to specific tenants</td>
    <td>SPECIFIC_TENANTS <br>Example: `"subscriptionAvailability": "SPECIFIC_TENANTS", subscriptionAvailableTenants : ["tenant1.com","tenant2.com", "tenant3.com"]`</td>
    </tr>
    </tbody>
    </table>
    
    


