# Enable Publisher Access Control in API Publisher Portal

APIs created in the API Publisher Portal are visible to any user who logs in to the Publisher Portal, by default. However, the API Manager allows API creators to restrict the visibility of their APIs within the Publisher Portal. This feature allows API creators to restrict API view and modify actions to a set of users, based on their roles.

## Using the API Publisher UI

1.  Log in to API Publisher as an API Creator. For more information on User Roles, see [Managing Users and Roles](_Managing_Users_and_Roles_) .
2.  [Create a new API](../../../DesignAPI/CreateAPI/create-a-rest-api/). Go to the **Design Configurations** tab. Select **Restricted by roles** for **Publisher Access Control**.
    <html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/select-restricted-by-role.png" alt="Select restricted by role" title="Select restricted by role" width="800" height="250"/>
     </body>
     </html>
3.  Add the roles that have permission to view or modify this API.
    <html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/enter-role-to-restrict.png" alt="Enter roles to restrict" title="Enter roles to restrict" width="800" height="300"/>
     </body>
     </html>

4.  Save the API.

     <html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/save-api.png" alt="Save API" title="Save API" width="250" height="50"/>
     </body>
     </html>

!!! info
    Ensure that the roles you add are valid. If the current creator is not an APIM admin, there should be at least one role of the current creator.

!!! note
    Users with APIM admin permission are treated differently. Even if an API is restricted to certain set of creators of publishers, it will be visible to all the API creators and publishers with APIM admin role.


## Using the REST API

You can use the [existing REST API](../../../../../../Develop/ProductAPIs/restful-apis/) to add a new API. To create an API with publisher access control restriction, add the two elements shown below in your request body,

``` 
"accessControl" : "RESTRICTED",
"accessControlRoles" : ["admin"]
```

Note that the roles must be valid. If the API creator is not an API-M admin they should at least have one of their roles in the `accessControlRoles` field.

!!! tip
    The publisher role cache is enabled by default in API Manager. This is to avoid sending repeated requests to the Key Manager node in a distributed deployment, to authenticate user roles.

    In order to disable this cache, add the following to the `<API-M_HOME>/repository/conf/deployment.toml`.

    ```
    [apim.cache.publisher_roles]
    enable = false
    ```

    Note that if this is disabled, it results in lowering performance due to repeatedly accessing the Key Manager. Hence, we recommend keeping this enabled.
