# Managing Users for Admin Portal

A user with an admin role is the API management controller who hosts and manages the gateway, responsible for creating users in the system, assigning roles to them, managing databases and security, etc. That user can access  WSO2 Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) and perform the operations of defining workflow tasks and throttling policies, managing analytics configurations, adding gateway labels, etc.

However, there are situations where you need to limit a user to access the Admin Portal only and restrict that user to perform other tasks that require admin permissions. Therefore, the admin role which has all the admin-related permissions cannot be assigned to a user who needs Admin Portal access.

In the latter mentioned situations, you need to create a new role permission mapping for a created role, assign it to a user, and access the Admin Portal using the latter mentioned user's credentials as explained below:

<a name="step1"></a>

## Step 1 - Create a user role

1. Sign in to the management console. The admin default credentials are `admin`/`admin`.

    `https://<APIM_host>:<API-M_port>/carbon`

2.  Click **Main**, and then click **Add** under **Users and Roles**.

    [![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3.  Click **Add New Role**.

    [![Add new role]({{base_path}}/assets/img/administer/add-new-role.png)]({{base_path}}/assets/img/administer/add-new-role.png)

4. Enter the name of the user role which you are going to assign Admin Portal access (e.g., `adminPortalManager`) and click **Next**

 The permissions page opens.

   [![Add admin portal role]({{base_path}}/assets/img/administer/add-admin-portal-role.png)]({{base_path}}/assets/img/administer/add-admin-portal-role.png)

5.  Click **Finish** without selecting any permissions.

Now a new user role `adminPortalManager` has been created without any associated permissions.

<a name="step2"></a>

## Step 2 - Create role permissions

1. Sign in to Admin Portal. The admin default credentials are `admin`/`admin`.

     `https://<API-M_host>:<API-M_port>/admin`

2. Navigate to **Settings** > **Role Permissions** in the Admin Portal. 

3. Click **Add role permission**.

    [![Add Role Permission]({{base_path}}/assets/img/administer/add-role-permission.png)]({{base_path}}/assets/img/administer/add-role-permission.png) 

4. Enter the  role name that you created in <a href="#step1">step 1</a>. Then click **Next** to proceed.

    [![Add Role Mapping]({{base_path}}/assets/img/administer/add-new-role-mapping.png)]({{base_path}}/assets/img/administer/add-new-role-mapping.png)

5. In **Select permissions** select **Custom Permissions** and  navigate to  **Permissions** --> **admin**. 
Assign the scopes according to the role of the user.

    - You need to assign the following scopes to any user to login and access a minimum version of Admin Portal. A user with these scopes will get access to manage workflow tasks.  

        - `apim:api_workflow_view`
        - `apim:api_workflow_approve`
        - `apim:admin_settings`
        - `apim:tenantInfo`

    [![Minimum Version of Admin Portal]({{base_path}}/assets/img/administer/minimum-version-admin-portal.png)]({{base_path}}/assets/img/administer/minimum-version-admin-portal.png)

    - To allow a user to perform all Admin Portal functions assign the `apim:admin` scope to the associated role.

## Step 3 - Create a user to access the Admin Portal

1. Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as the admin (default credentials are `admin`/`admin`).

2.  Click **Main**, and then click **Add** under **Users and Roles**.

    [![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3.  Click **Add New user**.

    [![Add admin manager user]({{base_path}}/assets/img/administer/add-manager-user.png)]({{base_path}}/assets/img/administer/add-manager-user.png)

4.  Provide the username and password and click **Next**.

5.  Select `adminPortalManager` and assign it to the user. Click **Finish** to complete.

    [![Assign admin portal user role]({{base_path}}/assets/img/administer/add-admin-manager-role-to-user.png)]({{base_path}}/assets/img/administer/add-admin-manager-role-to-user.png)

Now a user with custom permissions to access and manage Admin Portal has been created.

## Step 4 - Sign in to the Admin Portal

Sign in to Admin Portal (`https://<API-M_host>:<API-M_port>/admin`) as the user that you created in <a href="step2">Step 2</a>, and use `admin`/`admin` as the credentials. 

Now you will be able to sign in and perform specific operations in the Admin Portal with this user.