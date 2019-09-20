# Enabling Access Control Support for API Publisher

Visibility settings prevent certain user roles from viewing and modifying APIs created by another user role. This feature allows you to restrict the ability to view and modify APIs for a set of users.

-   [Enabling Access Control](#EnablingAccessControlSupportforAPIPublisher-EnablingAccessControl)
-   [Using the API Publisher UI](#EnablingAccessControlSupportforAPIPublisher-UsingtheAPIPublisherUI)
-   [Using the REST API](#EnablingAccessControlSupportforAPIPublisher-UsingtheRESTAPI)

### Enabling Access Control

To enable this feature, open the `<API-M_HOME>/repository/conf/api-manager.xml` file. Add the code given below under &lt; `APIPublisher>` .

``` java
    <APIPublisher>
        ...
        <EnableAccessControl>true</EnableAccessControl>
    </APIPublisher>
```

!!! note
Instructions to existing users

Re-indexing the artifacts in the registry.

-   Rename the `<lastAccessTimeLocation>` element in the `<API-M_HOME>` / `repository/conf/registry.xml` file. If you use a **clustered/distributed API Manager setup** , change the file in the API Publisher node. For example, change the `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstime` registry path to `/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstimexyz                         .                       `

    ``` java
        <lastAccessTimeLocation>/_system/local/repository/components/org.wso2.carbon.registry/indexing/lastaccesstimexyz
        </lastAccessTimeLocation>
    ```

-   Shut down API Manager if you have already started it, backup and delete the &lt;API-M\_HOME&gt;/solr directory if it exist

!!! info
Note that the registry indexing takes some time depending on the number of APIs you have in your store, so the existing APIs may not appear if you are accessing the publisher/store immediately after you start the server.


Restart the server after doing these changes.

### Using the API Publisher UI

1.  Log in to API Publisher as an API Creator. For more information on User Roles, see [Managing Users and Roles](_Managing_Users_and_Roles_) .
2.  Create an API. Select **Restricted by roles** for **Access Control** in the **Design** tab.
    ![](/assets/attachments/103333516/103333518.png)3.  Add the roles that have permission to view or modify this API.
    ![](/assets/attachments/103333516/103333517.png){height="250"}

        !!! info
    Ensure that the roles you add are valid. If the current creator is not an APIM admin, there should be at least one role of the current creator.


!!! note
Users with APIM admin permission are treated differently. Even if an API is restricted to certain set of creators of publishers, it will be visible to all the API creators and publishers with APIM admin role.


### Using the REST API

You can use the [existing REST API](https://docs.wso2.com/display/AM210/apidocs/publisher/#!/operations#APICollection#apisPost) to add a new API. To create an API with publisher access control restriction, add the two elements shown below in your request body,

``` java
    "accessControl" : "RESTRICTED",
    "accessControlRoles" : ["admin"]
```

Note that the roles should be valid. If the API creator is not an API-M admin he/she should at least have one of his/her roles in the `accessControlRoles` field.

!!! tip
The publisher role cache is enabled by default in API Manager. This is to avoid sending repeated requests to the Key Manager node in a distributed deployment, to authenticate user roles.

This WUM update allows you to disable the feature by disabling `<EnablePublisherRoleCache>` under `<CacheConfigurations>` . We recommend enabling the elements shown in the example below.

``` java
    <CacheConfigurations>
        <EnablePublisherRoleCache>true</EnablePublisherRoleCache>
    ...
```

Note that if disabled it results in lowering performance due to repeatedly accessing the Key Manager.


