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

Now a new user role `adminPortalManager` has been created without any associated permissions.

### Step-2- Create role permissions

1. Sign in to Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) using `admin`/`admin` and navigate to Settings > Role Permissions in the Admin Portal. 

2. Click **Add role permission**.

    ![Add Role Permission]({{base_path}}/assets/img/administer/add-role-permission.png) 

3. Provide the  role name which is created in step-1. Then click **Next** to proceed.

    ![Add Role Mapping]({{base_path}}/assets/img/administer/add-new-role-mapping.png)
    
4. In **Select permissions** select **Custom Permissions** and  navigate to  **Permissions** --> **admin**. 
Assign the scopes listed in the table below according to the role of the user.

    !!! note
            You need to assign `apim:api_workflow_view`, `apim:api_workflow_approve`, `apim:admin_settings`, `apim:tenantInfo` to any user to login and access a minimum version of admin portal.
             ![Minimum Version of Admin Portal]({{base_path}}/assets/img/administer/minimum-version-admin-portal.png)
             
            A user with these scopes will get access to manage workflow tasks.  To perform other functions, relevant scopes need to be assigned on top of these 4 scopes. For example, if you want to restrict an Admin Portal user to manage **deny policies** then assign `apim:bl_view` and `apim:bl_manage` scopes with the above scopes mentioned.
    
    Assign the Scopes according to the role of the user as given in the table below:
    
    <table>
    <thead>
    <tr class="header">
    <th><b>Workflow</b></th>
    <th><b>Associated Scopes</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Manage workflow requests</td>
    <td><ul>
    <li>apim:api_workflow_view</li>
    <li>apim:api_workflow_approve</li>
    <li>apim:admin_settings</li>
    <li>apim:tenantInfo</li>
    </ul></td>
    </tr>
    <tr class="even">
    <td>Manage Deny Policies</td>
    <td><ul>
    <li>apim:bl_view</li>
    <li>apim:bl_manage</li>
    </ul></td>
    </tr>
    <tr class="odd">
    <td>Manage Gateway Labels</td>
    <td><ul>
    <li>apim:label_read</li>
    <li>apim:label_manage</li>
    </ul></td>
    </tr>
    <tr class="even">
    <td>Retrieve Bot detection Data</td>
    <td><ul>
    <li>apim:bot_data</li>
    </ul></td>
    </tr>
    <tr class="odd">
    <td>Manage API categories and Key Managers related operations</td>
    <td><ul>
    <li>apim:admin_operations</li>
    </ul></td>
    </tr>
    <tr class="even">
    <td>Manage applications</td>
    <td><ul>
    <li>apim:app_owner_change</li>
    </ul></td>
    </tr>
    <tr class="odd">
    <td>Manage Throttling Policies</td>
    <td><ul>
    <li>apim:tier_view</li>
    <li>apim:tier_manage</li>
    </ul></td>
    </tr>
    <tr class="odd">
    <td>Manage role permissions</td>
    <td><ul>
    <li>apim:scope_manage</li>
    </ul></td>
    </tr>
    </tbody>
    </table>

    !!! tip
           To allow a user to perform all Admin Portal functions assign `apim:admin` scope to the associated role.


### Step-3- Create a user to access Admin Portal

1. Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as the admin (default credentials are `admin`/`admin`).

2.  Click **Main**, and then click **Add** under **Users and Roles**.
    
    ![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3.  Click **Add New user**.

    ![Add admin manager user]({{base_path}}/assets/img/administer/add-manager-user.png)

4.  Provide the username and password and click **Next**.

5.  Select `adminPortalManager` and assign it to the user. Click **Finish** to complete.

    ![Assign admin portal user role]({{base_path}}/assets/img/administer/add-admin-manager-role-to-user.png)

Now a user with custom permissions to access and manage Admin portal has been created.

### Step-4- Login to Admin-Portal

1. Sign in to Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) using `admin`/`admin` by the user created in Step-2. Now you will be able to sign in and perform specific opeartions in the admin portal with this user.

