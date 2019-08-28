# admin\_Configuring Roles

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `         user-mgt.xml        ` file found in the `         <PRODUCT_HOME>/repository/conf/        ` directory. The instructions given in this topic explain how you can add and manager user roles from the management console.

Roles contain permissions for users to manage the server. You can create different roles with various combinations of permissions and assign them to a user or a group of users. Through the Management Console, you can also edit and delete an existing user role.

WSO2 supports the role-based authentication model where privileges of a user are based on the role to which it is attached. By default, WSO2 products come with the following roles:

-   **Admin** - Provides full access to all features and controls. By default, the admin user is assigned to both the Admin and the Everyone roles.
-   **Everyone** - Every new user is assigned to this role by default. It does not include any permissions by default.
-   **System** - This role is not visible in the Management Console.

If a user has several assigned roles, their permissions are added together.

-   [Adding a user role](#admin_ConfiguringRoles-Addingauserrole)
-   [Editing or deleting a role](#admin_ConfiguringRoles-Editingordeletingarole)
-   [Updating role names](#admin_ConfiguringRoles-Updatingrolenames)

#### Adding a user role

Follow the instructions below to add a user role.

1.  On the **Main** tab in the management console, click **Add** under **Users and Roles** .
2.  Click **Roles** . This link is only visible to users with **Security** level permissions role. By default, the admin user has this permission enabled. For more information on permissions, see [Role-based Permissions](https://docs.wso2.com/display/ADMIN44x/Role-based+Permissions) .
3.  Click **Add New Role** . The following screen appears:
    ![](attachments/126562787/126562788.png)
4.  Do the following:
    1.  In the **Domain** list, specify the user store where you want to create this role. This list includes the primary user store and any other secondary user stores that are configured for your product. For information on ow user stores (which are repositories storing information about users and roles) are set up and configured, see [Configuring User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores) .
    2.  Enter a unique name for this role.
    3.  Click **Next** .
5.  Select the permissions that you want users with this role to have. For more information on permissions, see [Role-based Permissions](https://docs.wso2.com/display/ADMIN44x/Role-based+Permissions) .
    Note that when you assign this role to a user, you can override the role's permissions and customize them for the user.
6.  Select the existing users to whom this role should be assigned. You can also assign this role to users later, but if you are creating this role in an external user store that does not allow empty roles, you must assign it to at least one user. You can search for a user by name, or view all users by entering `          *         ` in the search field.
7.  Click **Finish** .

The role is created and is listed on the **Roles** page. You can now edit the role as needed.

#### Editing or deleting a role

If you need to do modifications to a role, select the domain (user store) where the role resides, and then use the relevant links in the **Actions** column on the **Roles** screen:

-   Rename the role
-   Change the default permissions associated with this role
-   Assign this role to users
-   View the users who are assigned this role
-   Delete the role if you no longer need it

!!! info
If the role is in an external user store to which you are connected in read-only mode, you will be able to view the existing roles but not edit or delete them. However, you can still create new editable roles.


#### Updating role names

If you need to do modifications to the role names, you need to do one of the following:

-   [Update before the first startup (recommended)](#admin_ConfiguringRoles-UpdateRole1Updatebeforethefirststartup(recommended))
-   [Update after the product is used for some time](#admin_ConfiguringRoles-Updateaftertheproductisusedforsometime)

##### Update before the first startup (recommended)

The default role names ( `         admin        ` and `         everyone        ` ) can be changed before starting the WSO2 product by editing `         <PRODUCT_HOME>/repository/conf/user-mgt.xml        ` . For more information on configuring the system administrator, see [Configuring the System Administrator](https://docs.wso2.com/display/ADMIN44x/Configuring+the+System+Administrator) .

``` html/xml
    <Configuration> 
        <AdminRole>admin</AdminRole> 
        <AdminUser> 
            <UserName>admin</UserName> 
            <Password>admin</Password> 
        </AdminUser> 
        <EveryOneRoleName>everyone</EveryOneRoleName> <!-- By default users in this role sees the registry root --> 
        <Property name="dataSource">jdbc/WSO2CarbonDB</Property> 
        <Property name="MultiTenantRealmConfigBuilder">org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder</Property> 
    </Configuration>
```

The following are the changes that need to be made in the configurations above:

-   Change `          <AdminRole>admin</AdminRole>         ` to `          <AdminRole>administrator</AdminRole>         ` .
-   Change `          <EveryOneRoleName>everyone</EveryOneRoleName>         ` to `          <EveryOneRoleName>Your role</EveryOneRoleName>         ` .

##### Update after the product is used for some time

You do not have to do this when updating before the first startup. The following steps guide you through updating the role names:

1.  Do the configuration changes indicated in [the above section](#admin_ConfiguringRoles-UpdateRole1) .
2.  You need to do the following user store level changes for existing users if you have changed the role names as mentioned earlier.
    -   If you are connected to `             JDBCUserStoreManager            ` you need to update the `             UM_USER_ROLE            ` table with the existing users after changing the `             admin            ` and `             everyone            ` role names. Also if you have changed the permission of `             everyone            ` role, the `             UM_ROLE_PERMISSION            ` has to be updated with the permissions to the new role.

                !!! info
        The schema can be located by referring to the data source defined in the user-mgt.xml file. The data source definition can be found under `             <PRODUCT_HOME>            ` / `             repository/conf/datasources/master-datasources.xml            ` .


    -   If you are connected to `            ReadWriteLdapUserStoreManager           ` , you need to populate the members of the previous admin role to the new role under the Groups. For more information, see [Configuring User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores) .

3.  After the changes, restart the server.

