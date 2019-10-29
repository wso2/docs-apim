# Enabling Access Control Support for API Publisher

Visibility settings prevent certain user roles from viewing and modifying APIs created by another user role. This feature allows you to restrict the ability to view and modify APIs for a set of users.

-   [Instructions to existing users](#EnablingAccessControlSupportforAPIPublisher-InstructionsToExistingUsers)
-   [Using the API Publisher UI](#EnablingAccessControlSupportforAPIPublisher-UsingtheAPIPublisherUI)
-   [Using the REST API](#EnablingAccessControlSupportforAPIPublisher-UsingtheRESTAPI)

### Instructions to existing users

!!! note

Re-indexing the artifacts in the registry.

-   Add the following configuration in the `<API-M_HOME>` / `repository/conf/deployment.toml` file. If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node. This will change the value `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path in the `<API-M_HOME>` / `repository/conf/registry.xml` to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime_1`

    ``` java
        [indexing]
        re_indexing="1"
    ```

-   Shut down API Manager if you have already started it, backup and delete the &lt;API-M\_HOME&gt;/solr directory if it exist

!!! info
    Note that the registry indexing takes some time depending on the number of APIs you have in your store, so the existing APIs may not appear if you are accessing the publisher/store immediately after you start the server.


Restart the server after doing these changes.

### Using the API Publisher UI

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


### Using the REST API

You can use the [existing REST API](../../../../../../Develop/ProductAPIs/restful-apis/) to add a new API. To create an API with publisher access control restriction, add the two elements shown below in your request body,

``` java
    "accessControl" : "RESTRICTED",
    "accessControlRoles" : ["admin"]
```

Note that the roles should be valid. If the API creator is not an API-M admin he/she should at least have one of his/her roles in the `accessControlRoles` field.

!!! tip
    The publisher role cache is enabled by default in API Manager. This is to avoid sending repeated requests to the Key Manager node in a distributed deployment, to authenticate user roles.

    In order to disable this feature, add the following to the `<API-M_HOME>` / `repository/conf/deployment.toml`.

    ``` java
        [apim.cache.publisher_roles]
        enable = false
    ```

    Note that if disabled it results in lowering performance due to repeatedly accessing the Key Manager. Hence, we recommend to keep this enabled.


