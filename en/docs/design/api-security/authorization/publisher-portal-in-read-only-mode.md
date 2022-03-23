# Publisher Portal in Read-only Mode
A user who has the view/read only permissions can only view the API, API Product and Service details in the Publisher
portal and also he/she can review all the analytics related details.

#### Read Only User
The user should have the scopes `apim:api_view` and `apim:publisher_settings`.
WSO2 APIM provides a pre-defined role called **internal/observer**, which is used to group all the read-only users.

Let's create a read only user and experience the Publisher portal in read only mode.

Follow the instructions below to create a Read only user:

1. Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as the admin (default credentials are admin/admin).

2. Create a user (Chris) and assign the **observer** default role.

      ![read-only-user-creation]({base_path}}/assets/img/learn/api-security/assign-role-to-user.png)

3. Click **Finish**.

If a read-only user (Chris) is logged in to the Publisher, Chris can view the Publisher portal as shown below.

Example: API detail view

   ![read-only-api-details]({{base_path}}/assets/img/learn/api-security/read-only-api-details.png)
