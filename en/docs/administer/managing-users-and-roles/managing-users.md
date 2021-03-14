# Managing Users

Users are consumers who interact with your enterprise's applications, databases or any other systems. These users can be persons, devices or applications/programs within or outside of the enterprise's network. Since these users interact with internal systems and access data, the need to define which user is allowed to do what, is critical. This is called user management.

Follow the steps below to create users and assign them to roles via the Management console. Also, if you want to authenticate users via **e-mail** , **social media** , **multiple user store attributes** , see [Maintaining Logins and Passwords]({{base_path}}/administer/product-security/General/logins-and-passwords/maintaining-logins-and-passwords).

## Adding a new User

1.  Sign in to the Management Console ( `https://<hostname>:9443/carbon` ) and click **Add** under **Users and Roles** in the **Main** menu.

    [![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)]({{base_path}}/assets/img/administer/add-users-and-roles.png)   
    
2.  Click **Add New User**.

    [![Add new user]({{base_path}}/assets/img/administer/add-new-user.png)]({{base_path}}/assets/img/administer/add-new-user.png)

3.  Provide the username and password and click **Next**.

    [![Add new user page]({{base_path}}/assets/img/administer/add-new-user-page.png)]({{base_path}}/assets/img/administer/add-new-user-page.png)

    !!! tip
            The **Domain** drop-down list contains all user stores configured in the system. By default, only the PRIMARY user store is configured. To configure secondary user stores, see [Configuring Secondary User Stores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configuring-secondary-user-stores/).

4.  Select the roles you want to assign to the user. In this example, we assign the `creator` role defined in the [previous section](managing-user-roles.md). For details on adding roles, see [Create user roles.]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-roles/#create-user-roles)

    [![Add roles to user]({{base_path}}/assets/img/administer/add-roles-to-user.png)]({{base_path}}/assets/img/administer/add-roles-to-user.png)

5.  Click **Finish** to complete.
    The new user appears in the **Users** list. You can change the user's password, assign it different roles or delete it.

    [![Change user details]({{base_path}}/assets/img/administer/change-user-details.png)]({{base_path}}/assets/img/administer/change-user-details.png)

    !!! warning
        You cannot change the user name of an existing user.

## Accessing the Admin Dashboard

The Admin Dashboard ( `https://<hostname>:9443/admin`) is intended to be used by API Manager admins. The admin user has special permissions specified under `All Permissions > Admin Permissions > Manage > API-M Admin` attached to the `admin` role. If a new user needs to access the admin dashboard, follow the steps below:

1.  Create a user.
2.  Create a new role. For more information, see [Create User Roles]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-roles/#create-user-roles).
3.  Assign the following permissions to the new role you just created: `All Permissions > Admin Permissions > Manage > API-M Admin` and `All Permissions > Admin Permissions > Configure > Login`.
4.  Assign the role created in step 2, to the user created in step 1.

Now this user is able to login and perform administrative tasks using the Admin Dashboard.

For more details on User Management refer [Configuring Users.](https://is.docs.wso2.com/en/5.10.0/learn/configuring-users/)

## Changing a password

If you are a user with admin privileges, you can change your own password or reset another user's password using the management console as explained below.

To change a user's password:

1. Log in to the management console of your product.
2. On the **Main** tab, click **List** under **Users and Roles**.

    [![List user roles]({{base_path}}/assets/img/administer/list-user-roles.png)]({{base_path}}/assets/img/administer/list-user-roles.png)

3. To change your own password, click **Change My Password**, enter your current password and new password, and click **Change**.

    [![Change password]({{base_path}}/assets/img/administer/change-password.png)]({{base_path}}/assets/img/administer/change-password.png)

4. If you are an admin user and need to  change another user's password (such as if they have forgotten their current password and need you to reset it), do the following:
    1. Click **Users**.
    2. Find the user's account on the **Users** screen and click **Change Password** in the **Actions** column.
    3. Enter a new temporary password and click **Change**.
    4. Inform the user of their new temporary password and instruct them to log in and change it as soon as possible.
