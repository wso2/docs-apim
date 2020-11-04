# Managing Users for Admin Portal

A user with an admin role is the API management controller who hosts and manages the gateway, responsible for creating users in the system, assigning roles to them, managing databases and security, etc. That user can access  WSO2 Admin Portal (https://<APIM_Host>:<APIM_Port>/admin) and perform the operations of defining workflow tasks and throttling policies, managing analytics configurations, adding gateway labels, etc.

But there are situations where we need to limit a user to access the admin portal only and restrict that user to perform other tasks that require admin permissions. Thus admin role which has all the admin-related permissions cannot be assigned to a user who needs admin portal access.

In these situations, we need to create a new role permission mapping for a created role and assign it to a user and access the admin portal by that user. Follow the instructions below to configure this:


### Step-1- Create a user role

1. Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as the admin (default credentials are `admin`/`admin`).

2.  Click **Main**, and then click **Add** under **Users and Roles**.
    
    ![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3.  Click **Add New Role**.

    ![Add new role]({{base_path}}/assets/img/administer/add-new-role.png)

4. Enter the name of the user role which we are going to assign admin portal access (e.g : `adminPortalManager`).

5.  The permissions page opens. Don't select anything and click **Finish**.

### Step-2- Create role permissions