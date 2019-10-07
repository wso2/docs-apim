# Adding Users

Users are consumers who interact with your enterprise's applications, databases or any other systems. These users can be persons, devices or applications/programs within or outside of the enterprise's network. Since these users interact with internal systems and access data, the need to define which user is allowed to do what, is critical. This is called user management.

Follow the steps below to create users and assign them to roles via the Management console. Also, if you want to authenticate users via **e-mail** , **social media** , **multiple user store attributes** , see [Maintaining Logins and Passwords](https://docs.wso2.com/display/AM260/Maintaining+Logins+and+Passwords) .

1.  Log in to the Management Console ( `https://<hostname>:9443/carbon` ) and click **Add** under **Users and Roles** in the **Main** menu.
    ![](/assets/attachments/103333608/103333613.png)

2.  Click **Add New User** .
    ![](/assets/attachments/103333608/103333612.png)

3.  The **Add User** page opens. Provide the username and password and click **Next** .

    ![](/assets/attachments/103333608/103333611.png)

        !!! info
    **Tip** : The **Domain** drop-down list contains all user stores configured in the system. By default, you only have the PRIMARY user store. To configure secondary user stores, see [Configuring Secondary User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+Secondary+User+Stores) .


4.  Select the roles you want to assign to the user. In this example, we assign the `creator` role defined in the previous section.

    ![](/assets/attachments/103333608/103333610.png)

        !!! info
    By default, all WSO2 products have the following roles configured:

    -   **Admin** - Provides full access to all features and controls. By default, the admin user is assigned to both the **Admin** and the **Everyone** roles.
    -   **Internal/Everyone** - Every new user is assigned to this role by default. It does not include any permissions.
    -   **Internal/System** - This role is not visible in the Management Console.

    In addition to the above, the following roles exist by default.

    1.  Internal/creator
    2.  Internal/publisher
    3.  Internal/subscriber

    Note that there may be more roles configured by default depending on the type of features installed in your product.


5.  Click **Finish** to complete.
    The new user appears in the **Users** list. You can change the user's password, assign it different roles or delete it.

        !!! note
    You cannot change the user name of an existing user.


    ![](/assets/attachments/103333608/103333609.png)

### Accessing the Admin Dashboard

The Admin Dashboard is intended to be used by API Manager admins. The admin user has special permissions specified in the `/permission/admin/manage/apim_admin` directory. If a new user needs to access the admin dashboard, follow the steps below:

1.  Create a user.
2.  Create a new role. For more information, see [Adding User Roles](_Adding_User_Roles_) .
3.  Assign the following permissions to the new role you just created: `/permission/admin/manage/apim_admin` and `/permission/admin/configure/login` . ****
4.  Assign the role created in step 2, to the user created in step 1.

Now this user is able to login and perform administrative tasks using the Admin Dashboard.
