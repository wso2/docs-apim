# Publisher Portal in Read-only Mode
A user who has the view/read only permissions can only view the API, API Product and Service details in the publisher
portal and also he/she can review all the analytics related details.

#### Read Only User:
The user has only the apim:api_view permission.

Let's create a read only user and experience the publisher portal in read only mode.

Steps to create a Read only user:
1. Create role ex: read_only in admin console
2. Create a user and assign the read_only role to the user.
3. Assign the login permission to login to the publisher portal via the admin console.
4. Login to the admin portal and navigate to scope management under the Settings subheading.
5. Click on the add scope mappings.
   Under the Role name please give the Role as read_only(the role you assigned to the read only user).
6. Click on the Next button.
7. Please select the Custom scope assignments under the select permissions.
   Check apim:api_view permission under the publisher.

   ![read-only-user-creation]({{base_path}}/assets/img/learn/api-security/read-only-user-creation.png)

8. Save the changes.

If a read-only user (jane) is logged in to the publisher,she can see the publisher portal as in below.
![read-only-user-publisher-view]({{base_path}}/assets/img/learn/api-security/read-only-api-view.png)

ex: API detail view
![read-only-api-details]({{base_path}}/assets/img/learn/api-security/read-only-api-details.png)
