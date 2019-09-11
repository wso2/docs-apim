# admin\_Managing Users, Roles and Permissions

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `user-mgt.xml` file found in the `<PRODUCT_HOME>/repository/conf/` directory. The following documentation explains how users, roles and permissions can be managed using the management console of WSO2 products.

WSO2 products support the role-based authentication model where privileges of a user are based on the role attached.  Each role is configured with zero or more permissions. Therefore, the set of permissions owned by a user is determined by the roles assigned to that user. If a user has several roles assigned, their permissions are added togethe r.

By default, all WSO2 products have the following roles configured:

-   **Admin** - Provides full access to all features and controls. By default, the admin user is assigned to both the **Admin** and the **Everyone** roles.
-   **Internal/Everyone** - Every new user is assigned to this role by default. It does not include any permissions.
-   **Internal/System** - This role is not visible in the Management Console.

More roles may be configured by default, depending on the type of features installed in your product. For example, in WSO2 Storage Server (which has the Cassandra feature and RSS Manager feature installed), the following roles will also be defined by default: **Internal/Cassandra** and **Internal/RSSManager** .

!!! info
Permissions assigned to the Admin role cannot be modified.


Before you begin your configurations, note the following:

-   Only system administrators or other users with **Security** level permissions can add, modify and remove users and roles. For more information on permissions, see [Role-based Permissions](https://docs.wso2.com/display/ADMIN44x/Role-based+Permissions) .
-   Your product has a primary user store where the users/roles that you create using the management console are stored by default. The default `RegEx` configurations for this user store are as follows. `RegEx` configurations ensure that parameters like the length of a user name/password meet the requirements of the user store.

    ``` java
        PasswordJavaRegEx-------- ^[\S]{5,30}$
        PasswordJavaScriptRegEx-- ^[\S]{5,30}$
        UsernameJavaRegEx-------- ^~!#$;%*+={}\\{3,30}$
        UsernameJavaScriptRegEx-- ^[\S]{3,30}$
        RolenameJavaRegEx-------- ^~!#$;%*+={}\\{3,30}$
        RolenameJavaScriptRegEx-- ^[\S]{3,30}$
    ```

    When creating users/roles, if you enter a username, password etc. that does not conform to the `RegEx` configurations, the system throws an exception. You can either change the `RegEx` configuration or enter values that conform to the `RegEx` . If you change the default user store or set up a secondary user store, configure the `RegEx` accordingly under the user store manager configurations in `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file.

-   The permission model of WSO2 products is hierarchical. Permissions can be assigned to a role in a fine-grained or a coarse-grained manner.

See the following topics for instructions:


