# Securing APIs using OAuth2 Opaque Access Tokens

APIs published on the WSO2 API Gateway are secured using OAuth2.0 by default. Any client application invoking a secure published API needs to have a valid subscription to the particular API and present a valid OAuth2.0 Access Token to the API Gateway. Please refer more information on how to subscribe to an API in
[Subscribe to an API](../../../../Learn/ConsumeAPI/ManageSubscription/subscribe-to-an-api/)[](edit_uri/) to understand how you can subscribe an application to an API and get credentials for your application.

Once you have the got the required credentials, namely the consumer key and consumer secret for your application, you (application users) can get access tokens to invoke APIs that are subscribed to the particular application. To understand how you can get tokens for different types of applications, see [OAuth2 Grant Types](../../../../Learn/APISecurity/OAuth2/GrantTypes/password-grant)[](edit_uri/) .

## Authentication

HTTP Authorization header is the most common method of providing authentication information for REST APIs. The application needs to have the access token in an authorization header for the client application to authenticate the API that is being accessed. The format of the header is as follows.

``` bash tab="Format"
Default Format
    Authorization : Bearer <access-token>
        
Format for customized authorization header
    <customized-authorization-header> : Bearer <access-token>
```

``` bash tab="Example"
Example with default authorization header
      Authorization : Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a
        
Example with **customized** authorization header
      SERVER_AUTH : Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a
        
The string `NtBQkXoKElu0H1a1fQ0DWfo6IX4a` is a sample value of the access token that is being sent from the client application.
```


## Customizing the authorization header

If the value of the authorization header needs to be changed due to organizational policies, legacy APIs, or for any other reason, it can be done at three levels in WSO2 API Manager (WSO2 API-M) as described below.

-   [Server wide customization](#SecuringAPIsusingOAuth2AccessTokens-Serverwidecustomization)
-   [Tenant wide customization](#SecuringAPIsusingOAuth2AccessTokens-Tenantwidecustomization)
-   [Per API customization](#SecuringAPIsusingOAuth2AccessTokens-PerAPIcustomization)

### Server wide customization

Follow the instructions below to change the value of the authorization header at the server level configurations:

1.  Navigate to the `<API-M_HOME>/repository/conf/doployment.toml` file and make the following changes.
    1.  Uncomment the `auth_header` under `[apim.oauth_config]` section and add the customized authorization header.
        You need to make this change on all the profiles of WSO2 API Manager.

        ``` bash tab="Format"
            auth_header = "{authorization-header}"
        ```
        
        ``` bash tab="Example"
            auth_header = "SERVER_AUTH"
        ```

    2.  Add the custom authorization header to the list of allowed headers defined in the `allow_headers` under the `[apim.cors]` section.

        ``` bash tab="Format"
            allow_headers = {authorization-header}
        ```

        ``` bash tab="Example"
            allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction","SERVER_AUTH"]
        ```

2.  Restart the WSO2 API Manager server to reload the changes.

3.  If you have already published APIs, Sign in to the WSO2 API Publisher ( `https://<hostname>:9443/publisher` ) and republish those APIs.

### Tenant wide customization

Each tenant can define their own name for the authorization header by following the instructions below:

!!! note
    The tenant wide authorization header customizations take precedence over the server wide authorization header customizations .


1.  Sign in to the [WSO2 API Manager Management Console](Running-the-Product_103334417.html#RunningtheProduct-AccessingtheManagementConsole) with your tenant credentials.
`https://<server-host>:9443/carbon`

!!! tip
    For information on creating a tenant, see [Managing Tenants](https://docs.wso2.com/display/ADMIN44x/Working+with+Multiple+Tenants) .


2.  Click **Main** , then click **Browse** which is under **Resources** .
    ![]({{base_path}}/assets/attachments/103334899/103334897.png)
3.  Enter / `_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to access the `tenant-conf.json` file that is in the WSO2 Registry.
4.  Click **Edit as text** to be able to edit the JSON file.
5.  Add the following configuration with the customized authorization header to the JSON file and save the file.

``` bash tab="Format"
    "AuthorizationHeader" : "<tenant-authorization-header>"
```

``` bash tab="Example"
    "AuthorizationHeader" : "TENANT_AUTH"
```

``` bash tab="Sample JSON"
            {  
               "EnableMonetization":false,
               "IsUnlimitedTierPaid":false,
               "ExtensionHandlerPosition":"bottom",
               "RESTAPIScopes":{  
                  "Scope":[  
                     {  
                        "Name":"apim:api_publish",
                        "Roles":"admin,Internal/publisher"
                     },
                     {  
                        "Name":"apim:api_create",
                        "Roles":"admin,Internal/creator"
                     },
                     {  
                        "Name":"apim:api_view",
                        "Roles":"admin,Internal/publisher,Internal/creator"
                     },
                     {  
                        "Name":"apim:subscribe",
                        "Roles":"admin,Internal/subscriber"
                     },
                     {  
                        "Name":"apim:tier_view",
                        "Roles":"admin,Internal/publisher,Internal/creator"
                     },
                     {  
                        "Name":"apim:tier_manage",
                        "Roles":"admin"
                     },
                     {  
                        "Name":"apim:bl_view",
                        "Roles":"admin"
                     },
                     {  
                        "Name":"apim:bl_manage",
                        "Roles":"admin"
                     },
                     {  
                        "Name":"apim:subscription_view",
                        "Roles":"admin,Internal/creator"
                     },
                     {  
                        "Name":"apim:subscription_block",
                        "Roles":"admin,Internal/creator"
                     },
                     {  
                        "Name":"apim:mediation_policy_view",
                        "Roles":"admin"
                     },
                     {  
                        "Name":"apim:mediation_policy_create",
                        "Roles":"admin"
                     },
                     {  
                        "Name":"apim:api_workflow",
                        "Roles":"admin"
                     }
                  ]
               },
               "NotificationsEnabled":"false",
               "Notifications":[  
                  {  
                     "Type":"new_api_version",
                     "Notifiers":[  
                        {  
                           "Class":"org.wso2.carbon.apimgt.impl.notification.NewAPIVersionEmailNotifier",
                           "ClaimsRetrieverImplClass":"org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever",
                           "Title":"Version $2 of $1 Released",
                           "Template":" <html> <body> <h3 style=\"color:Black;\">We’re happy to announce the arrival of the next major version $2 of $1 API which is now available in Our API Store.</h3><a href=\"https://localhost:9443/store\">Click here to Visit WSO2 API Store</a></body></html>"
                        }
                     ]
                  }
               ],
               "DefaultRoles":{  
                  "PublisherRole":{  
                     "CreateOnTenantLoad":true,
                     "RoleName":"Internal/publisher"
                  },
                  "CreatorRole":{  
                     "CreateOnTenantLoad":true,
                     "RoleName":"Internal/creator"
                  },
                  "SubscriberRole":{  
                     "CreateOnTenantLoad":true
                  }
               },
               "AuthorizationHeader":"TENANT_AUTH"
            }
```

6.  If you have already published APIs, [sign in to the API Publisher](Running-the-Product_103334417.html#RunningtheProduct-AccessingtheAPIPublisher) using your tenant credentials and republish those APIs.

### Per API customization

The API Publisher application allows an API Developer or Product Manager to specify the name of the authorization header when creating or modifying an API.

!!! note
The customized authorization header defined per API takes precedence over the customized authorization headers that are defined server and tenant wide.


Follow the instructions below to add a customized authorization header for an API:

1.  [Sign in to the Publisher](Running-the-Product_103334417.html#RunningtheProduct-AccessingtheAPIPublisher) .
`https://<server-host>:9443/publisher         `
2.  When [creating](_Create_and_Publish_an_API_) or updating an API, define the customized authorization header in the **Runtime Configurations** tab.

    [ ![](../../../assets/img/Learn/custom-auth-header-publisher.png) ](../../../assets/img/Learn//custom-auth-header-publisher.png)

3.  Save and Publish the API.

##Try out the customized authorization header
  
Before you start , sign in to the API Publisher and deploy the sample API ( `PizzaShackAPI` ) if you haven't done so already, as the following example is based on that API.

``` bash tab="Sample cURL Request"
    curl -H "<customized-authorization-header>: Bearer <access-token>" -H "accept: application/json" "https://<server-IP>:<port>/pizzashack/1.0.0/menu" -k -v
```

``` bash tab="cURL Request Format"
    curl -H "SERVER_AUTH: Bearer 3c536e3f-397c-3df9-a89c-9c40efedfa9e" -H "accept: application/json" "https://10.100.0.112:8243/pizzashack/1.0.0/menu" -k -v
```

``` bash tab="Sample Response"
    > GET /pizzashack/1.0.0/menu HTTP/1.1
    > Host: 10.100.0.112:8243
    > User-Agent: curl/7.54.0
    > accept: application/json
    > SERVER_AUTH: Bearer 3c536e3f-397c-3df9-a89c-9c40efedfa9e
    > 
    < HTTP/1.1 200 OK
    < Access-Control-Allow-Origin: *
    < Access-Control-Allow-Methods: GET
    < Access-Control-Allow-Headers: authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction,SERVER_AUTH
    < Content-Type: application/json
    < Date: Fri, 19 Jan 2018 06:02:29 GMT
    < Transfer-Encoding: chunked
    < 
    [{"name":"BBQ Chicken Bacon","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions in barbeque sauce","price":"22.99","icon":"/images/6.png"},{"name":"Chicken Parmesan","description":"Grilled chicken, fresh tomatoes, feta and mozzarella cheese","price":"21.99","icon":"/images/1.png"},{"name":"Chilly Chicken Cordon Bleu","description":"Spinash Alfredo sauce topped with grilled chicken, ham, onions and mozzarella","price":"28.99","icon":"/images/10.png"},{"name":"Double Bacon 6Cheese","description":"Hickory-smoked bacon, Julienne cut Canadian bacon, Parmesan, mozzarella, Romano, Asiago and and Fontina cheese","price":"25.99","icon":"/images/9.png"},{"name":"Garden Fresh","description":"Slices onions and green peppers, gourmet mushrooms, black olives and ripe Roma tomatoes","price":"14.99","icon":"/images/3.png"},{"name":"Grilled Chicken Club","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions topped with Roma tomatoes","price":"15.99","icon":"/images/8.png"},{"name":"Hawaiian BBQ Chicken","description":"Grilled white chicken, hickory-smoked bacon, barbeque sauce topped with sweet pine-apple","price":"19.99","icon":"/images/7.png"},{"name":"Spicy Italian","description":"Pepperoni and a double portion of spicy Italian sausage","price":"14.99","icon":"/images/2.png"},{"name":"Spinach Alfredo","description":"Rich and creamy blend of spinach and garlic Parmesan with Alfredo sauce","price":"20.99","icon":"/images/5.png"},{"name":"Tuscan Six Cheese","description":"Six cheese blend of mozzarella, Parmesan, Romano, Asiago and Fontina","price":"22.99","icon":"/images/4.png"}]
```

Note that the customized authorization header appears in the Store UI as well.

[ ![](../../../assets/img/Learn//auth_header.png) ](../../../assets/img/Learn//auth_header.png)