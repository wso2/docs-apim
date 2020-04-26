# Enable Publisher Access Control

The APIs created in the API Publisher are visible to any user who signs in to the API Publisher, by default. However, WSO2 API Manager allows API creators to restrict the visibility of their APIs within the API Publisher if required. API creators can set the Publisher Access control option to restrict API view and modify actions to a set of users, based on their roles. You can enable Publisher Access Control in API Publisher using one of the following methods:

- [Using the API Publisher]({{base_path}}/learn/design-api/advanced-topics/enable-publisher-access-control-in-api-publisher-portal/#using-the-api-publisher)
- [Using the REST API]({{base_path}}/learn/design-api/advanced-topics/enable-publisher-access-control-in-api-publisher-portal/#using-the-rest-api)

## Using the API Publisher

1.  Sign in to API Publisher as an API Creator. 

     For more information on User Roles, see [Managing Users and Roles]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-roles/).

2.  [Create a new API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/). 

3. Click **Design Configurations**. 

4. Select **Restricted by roles** as the value for **Publisher Access Control**.

    [![Design configuration page]({{base_path}}/assets/img/learn/select-restricted-by-role.png)]({{base_path}}/assets/img/learn/select-restricted-by-role.png)
    
3.  Add the roles that have permission to view or modify this API.

     [![Enter role to restrict]({{base_path}}/assets/img/learn/enter-role-to-restrict.png)]({{base_path}}/assets/img/learn/enter-role-to-restrict.png)

4.  Save the API.

     <html>
     <head>
     </head>
     <body>
     <img src="{{base_path}}/assets/img/learn/save-api.png" alt="Save API" title="Save API" width="250" height="50"/>
     </body>
     </html>

!!! info
    Ensure that the roles you add are valid. If the current creator is not an APIM admin, there should be at least one role of the current creator.

!!! note
    Users with API-M Admin permission or admin role are treated differently. Even if an API is restricted to a certain set of publishers, it will be visible to all the API creators and publishers with API-M Admin permission or admin role.


## Using the REST API

Use the [existing REST API]({{base_path}}/develop/product-apis/restful-apis/) to add an API. Make sure to add the following two elements in your request body to create an API with publisher access control restriction.

``` 
"accessControl" : "RESTRICTED",
"accessControlRoles" : ["admin"]
```

Note that the roles must be valid. If the API creator is not an API-M admin they should at least have one of their roles in the `accessControlRoles` field.

!!! tip
    The publisher role cache is enabled by default in API Manager. This is to avoid sending repeated requests to the Key Manager node in a distributed deployment, to authenticate user roles.

    In order to disable this cache, add the following to the `<API-M_HOME>/repository/conf/deployment.toml` file.

    ```
    [apim.cache.publisher_roles]
    enable = false
    ```

    Note that if this is disabled, it results in lowering performance due to repeatedly accessing the Key Manager. Therefore, WSO2 recommends that you keep it enabled.
