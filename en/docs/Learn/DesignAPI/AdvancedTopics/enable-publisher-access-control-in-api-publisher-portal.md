# Enable Publisher Access Control in API Publisher Portal

APIs created in the API Publisher Portal are visible to any user who logs in to the Publisher Portal, by default. However, the API Manager allows API creators to restrict the visibility of their APIs within the Publisher Portal. This feature allows API creators to restrict API view and modify actions to a set of users, based on their roles.

## Instructions to existing users

Re-indexing the artifacts in the registry.

-   Add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file. (Note: If you want to reindex again in future, you can increment the value "1" to "2").
  If what you have is a **distributed API Manager setup** , change the file in the API Publisher node. 

    ``` 
    [indexing]
    re_indexing="1"
    ```

-   Shut down API Manager if you have already started it, backup and delete the `<API-M_HOME>/solr` directory if it exist.
-   Restart the server.

!!! info
    Note that the registry indexing takes some time depending on the number of APIs you have in your store, so the existing APIs may not appear if you are accessing the publisher/store immediately after you start the server.


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
