# Managing Users for Admin Portal

A user with an admin role is the API management controller who hosts and manages the gateway, responsible for creating users in the system, assigning roles to them, managing databases and security, etc. That user can access  WSO2 Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) and perform the operations of defining workflow tasks and throttling policies, managing analytics configurations, adding gateway labels, etc.

But there are situations where we need to limit a user to access the admin portal only and restrict that user to perform other tasks that require admin permissions. Thus admin role which has all the admin-related permissions cannot be assigned to a user who needs admin portal access.

In these situations, we need to create a new role permission mapping for a created role and assign it to a user and access the admin portal by that user. Follow the instructions below to configure this:


### Step-1- Create a user role

1. Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as the admin (default credentials are `admin`/`admin`).

2.  Click **Main**, and then click **Add** under **Users and Roles**.
    
    ![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3.  Click **Add New Role**.

    ![Add new role]({{base_path}}/assets/img/administer/add-new-role.png)

4. Enter the name of the user role which we are going to assign admin portal access (e.g : `adminPortalManager`) and click **Next**

    ![Add admin portal role]({{base_path}}/assets/img/administer/add-admin-portal-role.png)

5.  The permissions page opens. click **Finish** without selecting any permissions.

Now we have created a new user role `adminPortalManager` without having any permissions.

### Step-2- Create role permissions

1. Sign in to Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) using `admin`/`admin` and navigate to Settings > Role Permissions in the Admin Portal. 

2. Click **Add role permission**.

    ![Add Role Permission]({{base_path}}/assets/img/administer/add-role-permission.png) 

3. Provide the  role name which is created in step-1. Then click **Next** to proceed.

    ![Add Role Mapping]({{base_path}}/assets/img/administer/add-new-role-mapping.png)
    
4. In **Select permissions** navigate to **Custom Permissions** and select **Permissions** --> **admin** --> **apim:admin** Scope.

### Step-3- Create a user to access Admin Portal

1. Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as the admin (default credentials are `admin`/`admin`).

2.  Click **Main**, and then click **Add** under **Users and Roles**.
    
    ![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3.  Click **Add New user**.

    ![Add new user]({{base_path}}/assets/img/administer/add-new-user.png)

4.  Provide the username and password and click **Next**.

5.  Select `adminPortalManager` and assign it to the user. Click **Finish** to complete.


### Step-4- Login to Admin-Portal

1. Sign in to Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) using `admin`/`admin`. Now you will be able to sign in and perform the opeartions with this user.

