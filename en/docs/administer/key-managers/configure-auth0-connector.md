# Configure Auth0 as a Key Manager

WSO2 API Manager supports multiple Key Managers. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager and with the use of connectors it is capable of supporting any authorization server as a Key Manager.

Therefore, WSO2 API Manager can connect Auth0 out-of-the-box using the [WSO2 API-M Auth0 Connector](https://github.com/wso2-extensions/apim-km-auth0).

Follow the instructions given below to configure Auth0 as a third-party Key Manager. 

!!! info
    For more information, see the [Getting Started Guide, which is under the official Auth0 documentation](https://auth0.com/docs/get-started).

## Configure Auth0

### Step 1 : Prerequisites

_Please note that this is supported only from the API Manager 3.2.0 onward_.

1.  Create an Auth0 account. Get the URL for the tenant and then sign in to the dashboard.

   [![auth0 dashboard]({{base_path}}/assets/img/administer/auth0-dashboard.png)]({{base_path}}/assets/img/administer/auth0-dashboard.png)

2.  The you need to create an application to use the management API. Then need's to allow that application to use the management API.

    [![auth0 management api]({{base_path}}/assets/img/administer/auth0-management-api.png)]({{base_path}}/assets/img/administer/auth0-management-api.png)

    [![auth0 new application]({{base_path}}/assets/img/administer/auth0-new-application.png)]({{base_path}}/assets/img/administer/auth0-new-application.png)
    
    [![auth0 permission to use app]({{base_path}}/assets/img/administer/auth0-permission-to-use-app.png)]({{base_path}}/assets/img/administer/auth0-permission-to-use-app.png)
   
   Make sure you have granted all the permissions to Create, Manage Apps and Resource servers.    

### Step 2: Configure WSO2 API Manager

1.  Log into the admin portal of the API Manager and add a new Key Manager.
    
    [![auth0 add app admin]({{base_path}}/assets/img/administer/auth0-add-app-admin.png)]({{base_path}}/assets/img/administer/auth0-add-app-admin.png)
    
2.  Then select the Key manager type as Auth0 and provide the relevant fields accordingly.

    [![auth0 km type]({{base_path}}/assets/img/administer/auth0-km-type.png)]({{base_path}}/assets/img/administer/auth0-km-type.png)
 
    **List of well know address could be found in advance section of the Auth0 Application settings**    
    
        Eg. https://my-tenant.us.auth0.com/.well-known/openid-configuration
    
    [![auth0 endpoints]({{base_path}}/assets/img/administer/auth0-endpoints.png)]({{base_path}}/assets/img/administer/auth0-endpoints.png)    
    
    The introspection endpoint will not be populated since it is not exposed in Auth0. Therefore, 
    set its value as <code>none</code>. Select the token validation method as <code>Self validate JWT</code> like below.
    
    [![auth0 token validation]({{base_path}}/assets/img/administer/auth0-token-validation.png)]({{base_path}}/assets/img/administer/auth0-token-validation.png)    

3.  Set the grant types which are allowed in Auth0 as below. The format of the grant types can be found in 
<a href="https://auth0.com/docs/applications/application-grant-types">this link</a>.
    
    [![auth0 grant types]({{base_path}}/assets/img/administer/auth0-grant-types.png)]({{base_path}}/assets/img/administer/auth0-grant-types.png)        
    
4.  The client ID, Client secret of the application created to invoke Manage API should be provided for the settings. You can get to the audience 
value from Manage API.

    [![auth0 connector configs]({{base_path}}/assets/img/administer/auth0-connector-configs.png)]({{base_path}}/assets/img/administer/auth0-connector-configs.png)    
    
5.  Finally, you can save the configs.

### Step 3 : Create new application and generate keys

1.  Create new application from the developer portal.

    [![auth0 dev app create]({{base_path}}/assets/img/administer/auth0-dev-app-create.png)]({{base_path}}/assets/img/administer/auth0-dev-app-create.png)    

2.  Then click either production or sandbox, Select Auth0 fill the relevant fields accordingly.

    [![auth0 app creation form]({{base_path}}/assets/img/administer/auth0-app-creation-form.png)]({{base_path}}/assets/img/administer/auth0-app-creation-form.png)    
    
    *Please note that Audience of the API field is mandatory to generate an access token for Auth0. Therefore, please provide it when the application keys generating.*
    
    You can get the audience of the api by checking the API.
    
    [![auth0 resource api]({{base_path}}/assets/img/administer/auth0-resource-api.png)]({{base_path}}/assets/img/administer/auth0-resource-api.png)    

3.  Once the keys generated, It will reflect in the UI.
    
    [![auth0 created app]({{base_path}}/assets/img/administer/auth0-created-app.png)]({{base_path}}/assets/img/administer/auth0-created-app.png)        
    
5. Finally, token will be generated successfully.

    [![auth0 success]({{base_path}}/assets/img/administer/auth0-success.png)]({{base_path}}/assets/img/administer/auth0-success.png)        
