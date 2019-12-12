# Managing Users

Users are consumers who interact with your enterprise's applications, databases or any other systems. These users can be persons, devices or applications/programs within or outside of the enterprise's network. Since these users interact with internal systems and access data, the need to define which user is allowed to do what, is critical. This is called user management.

Follow the steps below to create users and assign them to roles via the Management console. Also, if you want to authenticate users via **e-mail** , **social media** , **multiple user store attributes** , see [Maintaining Logins and Passwords](../../../../Administer/ProductSecurity/General/LoginsAndPasswords/maintaining-logins-and-passwords).

## Adding a new User

1.  Log in to the Management Console ( `https://<hostname>:9443/carbon` ) and click **Add** under **Users and Roles** in the **Main** menu.

    ![Add users and roles](../../../assets/img/Administer/add-users-and-roles.png)
    
2.  Click **Add New User**.

    ![Add new user](../../../assets/img/Administer/add-new-user.png)

3.  The **Add New User** page opens. Provide the username and password and click **Next**.

    ![Add new user page](../../../assets/img/Administer/add-new-user-page.png)

    !!! tip
            The **Domain** drop-down list contains all user stores configured in the system. By default, you only have the PRIMARY user store. To configure secondary user stores, see [Configuring Secondary User Stores](../../../../Administer/ProductAdministration/ManagingUsersAndRoles/ManagingUserStores/configuring-secondary-user-stores/).


4.  Select the roles you want to assign to the user. In this example, we assign the `creator` role defined in the [previous section](managing-user-roles.md).

    ![Add roles to user](../../../assets/img/Administer/add-roles-to-user.png)

    !!! info
        By default, all WSO2 products have the following roles configured: 

        -   **admin** - Provides full access to all features and controls. By default, the admin user is assigned to both the admin and the Internal/everyone roles.
        -   **Internal/everyone** - Every new user is assigned to this role by default. It does not include any permissions.
        -   **Internal/system** - This is a default role which does not include any permissions.
        -   **Internal/analytics** - This role can be assigned to users who do not have the publisher or subscriber roles assigned but need permission to view the analytics dashboards.

        In addition to the above, the following roles exist by default.

        1.  Internal/creator
        2.  Internal/publisher
        3.  Internal/subscriber

        Note that there may be more roles configured by default depending on the type of features installed in your product.

5.  Click **Finish** to complete.
    The new user appears in the **Users** list. You can change the user's password, assign it different roles or delete it.

    ![Change user details](../../../assets/img/Administer/change-user-details.png)

    !!! note
        You cannot change the user name of an existing user.

## Accessing the Admin Dashboard

The Admin Dashboard ( `https://<hostname>:9443/admin`) is intended to be used by API Manager admins. The admin user has special permissions specified under `All Permissions > Admin Permissions > Manage > API-M Admin` attached to the `admin` role. If a new user needs to access the admin dashboard, follow the steps below:

1.  Create a user.
2.  Create a new role. For more information, see [Managing User Roles](managing-user-roles.md) .
3.  Assign the following permissions to the new role you just created: `All Permissions > Admin Permissions > Manage > API-M Admin` and `All Permissions > Admin Permissions > Configure > Login`.
4.  Assign the role created in step 2, to the user created in step 1.

Now this user is able to login and perform administrative tasks using the Admin Dashboard.

For more details on User Management refer [Configuring Users.](https://is.docs.wso2.com/en/5.9.0/learn/configuring-users/)
