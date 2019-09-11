# admin\_Configuring Users

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `user-mgt.xml` file found in the `<PRODUCT_HOME>/repository/conf/` directory. The instructions given in this topic explain how you can add and manage users from the management console.

To enable users to log into the management console, you create user accounts and assign them roles, which are sets of permissions. You can add individual users or import users in bulk.

/\*\*/ Adding a new user and assigning roles Importing users Creating a file with users Importing users from the CSV/Excel file Customizing the user's roles and permissions Customizing a user's profile Deleting an existing user

### Adding a new user and assigning roles

!!! note
Add the `GetRoleListOfInternalUserSQL` property within the `<Realm>` section in the `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file as shown below, to avoid case sensitivity issues when creating users.

``` xml
    <Realm>
    <Configuration>
    <Property name="GetRoleListOfInternalUserSQL">SELECT UM_ROLE_NAME FROM UM_HYBRID_USER_ROLE, UM_HYBRID_ROLE WHERE UPPER(UM_USER_NAME)=UPPER ( ? ) AND UM_HYBRID_USER_ROLE.UM_ROLE_ID=UM_HYBRID_ROLE.UM_ID AND UM_HYBRID_USER_ROLE.UM_TENANT_ID=? AND UM_HYBRID_ROLE.UM_TENANT_ID=? AND UM_HYBRID_USER_ROLE.UM_DOMAIN_ID=(SELECT UM_DOMAIN_ID FROM UM_DOMAIN WHERE UM_TENANT_ID=? AND UM_DOMAIN_NAME=?)</Property>
    </Configuration>
    </Realm>
```


Follow the instructions below to add a new user account and configure its role.

1.  On the **Main** tab in the management console, and click **Add** under **Users and Roles** .
2.  Click **Users** . This link is only visible to users with the Admin role.
3.  Click **Add New User** . The following screen will open:
    ![](attachments/126562789/126562790.png)
4.  Do the following:
    1.  In the **Domain** list, specify the user store where you want to create this user account. This list includes the primary user store and any other secondary user stores that are configured for your product. For information on configuring user stores, see [Configuring User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores) .
    2.  Enter a unique username and the password that the person will use to log in. By default, the password must be at least five characters and should have at least one character with a capital letter, characters, numbers and special characters.
    3.  Click **Next** .
5.  Optionally, select the role(s) you want this user to have. If you have many roles in your system, you can search for them by name.
6.  Click **Finish** .

A new user account is created with the specified roles and is listed on the **Users** page.

### Importing users

In addition to creating users manually, user information stored in a CSV or Excel file can be imported in bulk to a user store configured in your WSO2 product. This possibility is only available if you have a [JDBC user store configured for your product](https://docs.wso2.com/display/ADMIN44x/Configuring+a+JDBC+User+Store) .

!!! info
Note the following before you use this feature:

-   The option to import users in bulk is enabled in your product by default. If not, you can enable it by adding the following property to the JDBC user store configured in the `user-mgt.xml` file (stored in the `<PRODUCT_HOME>/repository/conf` directory).

    ``` java
        <Property name="IsBulkImportSupported">true</Property>
    ```

-   It is recommended to upload a maximum of 500,000 users at a time. If you need to upload more users, you can upload them in separate batches of 500,000 each.
-   You can also specify the size of the file that you can upload to the product in the `<PRODUCT_HOME>/repository/conf/carbon.xml` file using the `TotalFileSizeLimit` element as shown below. This value is in MB.

    ``` java
            <TotalFileSizeLimit>100</TotalFileSizeLimit>
    ```


#### Creating a file with users

You must first create a CSV file or an Excel file with the user information. It is possible to import the **username** and **password** directly from the CSV/Excel to the product. You can also assign each user to multiple roles. Here's an example CSV file:

``` java
    UserName,password,roleuser1,password123, role=admin:developer
    user2,password123, role=admin:tester
    user3,password123, role=admin:developer:tester
    user4,password123, role=devops
    user5,password123, role=devops:tester
```

!!! note
Make sure you have the roles that you assign to the users available in the system. If not, the server will throw an error. See [Configuring Roles](https://docs.wso2.com/display/ADMIN44x/Configuring+Roles) for information on adding user roles to the server.


In addition to importing users with their passwords and roles, you can import other user attributes such as **email address** , **full name** , **last name, mobile** , **given name etc.** using **** [claim URls that are defined for attributes](https://docs.wso2.com/display/ADMIN44x/Managing+User+Attributes) . Here's an example of claim URls that you can defined for your product:

``` java
    http://wso2.org/claims/givenname
    http://wso2.org/claims/lastname
    http://wso2.org/claims/mobile
    http://wso2.org/claims/role
```

To import users with username, password, roles, and other attributes (as claim URls), create a CSV file as shown in the example below:

``` java
    UserName,password,Claims
    user1, password123,http://wso2.org/claims/givenname=myname1,http://wso2.org/claims/lastname=mylastname1,http://wso2.org/claims/mobile=077777777,http://wso2.org/claims/role=admin:developer
    user2, password123,http://wso2.org/claims/givenname= myname2,http://wso2.org/claims/lastname=mylastname2,http://wso2.org/claims/mobile=077777777,http://wso2.org/claims/role=admin:devops
    user3, password123,http://wso2.org/claims/givenname= myname3,http://wso2.org/claims/lastname=mylastname3,http://wso2.org/claims/mobile=077777777,http://wso2.org/claims/role=developer:devops
```

!!! note
If you are using **WSO2 Identity Server** , you can choose to leave the password empty as shown by the third line in the below sample. To use this option, you need to first enable the [Ask Password option](https://docs.wso2.com/display/IS530/Creating+Users+Using+the+Ask+Password+Option) for the server.

![](attachments/126562789/126562794.png)

#### Importing users from the CSV/Excel file

To import users in bulk:

1.  Log in to the management console of your WSO2 product.
2.  In the **Configure** menu, Under **Users and Roles** , click **Add.**
3.  Click **Bulk Import Users** .
4.  The user stores configured for your product will be listed in the **Domain** field. Select the user store to which you want to import the users from the list, upload the CSV or excel sheet, and click Finish. ![](attachments/126562789/126562800.png){height="250"}

!!! info
The default password of the imported users is valid only for 24 hours. As the system administrator, you can resolve issues of expired passwords by logging in as the Admin and changing the user's password from the **User Management -&gt;Users** page. The 'Everyone' role will be assigned to the users by default.


### Customizing the user's roles and permissions

Each role specifies a set of permissions that the user will have when assigned to that role. After creating a user, you can assign and remove roles for that user by clicking **Assign Roles** in the **Actions** column. To see which users a role is already assigned to, click **View Users** next to the role.

You can also customize which permissions apply to this user by clicking **View Roles** in the **Actions** column of the **Users** screen and then selecting the permissions from each role that you want this user to have. For information on permissions, see [Role-based Permissions](https://docs.wso2.com/display/Carbon443/Role-based+Permissions) .

### Customizing a user's profile

Each individual user has a profile that can be updated to include various details. To do this, click **User Profile** on the **Users** screen. Make the changes required and click **Update** . You can also add multiple profiles for a user.

!!! note
**Note** : You can only add new profiles if you are connected to a JDBC user store. You also need to have administrator privileges.


Do the following in order to add new profiles.

1.  On the **Main** tab in the Management Console, click **List** under **Users and Roles** .
2.  Click **Users** . This link is only visible to users with the Admin role.
3.  Click the **User Profile** link.
4.  You can add multiple profiles using the **Add New Profile** link and create any number of profiles for your user as long as the user is located in a JDBC user store.

### Deleting an existing user

Follow the instructions below to delete a user.

!!! info
Deleting a user cannot be undone.


1.  On the **Main** tab in the management console click **List** under **Users and Roles** .
2.  Click **Users** . This link is only visible to users with **User Management** level permissions. For information on permissions, see [Role-based Permissions](https://docs.wso2.com/display/Carbon443/Role-based+Permissions) .
3.  In the **Users** list, click **Delete** next to the user you want to delete, and then click **Yes** to confirm the operation.

!!! tip
Once a user is deleted, you can remove all references to the deleted user's identity via the [Identity Anonymization tool](https://github.com/wso2/identity-anonymization-tool) . For information on building and running the tool, see [Removing References to Deleted User Identities in WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Removing+References+to+Deleted+User+Identities+in+WSO2+Products) .



