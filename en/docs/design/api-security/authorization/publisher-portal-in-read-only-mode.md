# Publisher Portal in Read-only Mode
A user who has the view/read only permissions can only view the API, API Product and Service details in the Publisher
portal and also he/she can review all the analytics related details.

#### Read Only User
The user has only the `apim:api_view` permission.

Let's create a read only user and experience the Publisher portal in read only mode.

Follow the instructions below to create a Read only user:

1. Create role (e.g., `read_only`) in admin console.Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) 
   as the admin (default credentials are admin/admin). 
   
2. Click **Main**, and then click **Add** under **Users and Roles**.
        
      [![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3. Click **Add New Role**.

      ![Add new role]({{base_path}}/assets/img/administer/add-new-role.png)

4.  Enter the name of the user role (e.g., `read_only`).

      ![read-only-user-creation]({base_path}}/assets/img/learn/api-security/read_only_role.png)

5. Create a user and assign the read_only role to the user.
   
6. Assign the login permission to login to the Publisher portal via the admin console.
   
7. Log in to the Admin Portal and navigate to **scope management** which is under **Settings**.
   
8. Click **Add Scope Mappings**.
   Enter the Role name as `read_only` (This is the role you assigned to the read only user).
   
9. Click **Next**.
   
10. Select the Custom scope assignments under the select permissions.
   Check the `apim:api_view` permission under the Publisher.

   ![read-only-user-creation]({{base_path}}/assets/img/learn/api-security/read-only-user-creation.png)

11. Save the changes.

If a read-only user (Chris) is logged in to the Publisher, Chris can view the Publisher portal as shown below.
![read-only-user-publisher-view]({{base_path}}/assets/img/learn/api-security/read-only-api-view.png)

Example: API detail view
![read-only-api-details]({{base_path}}/assets/img/learn/api-security/read-only-api-details.png)
