# Realm Configuration

The complete functionality and contents of the User Management module is called a **user realm** . The realm includes the user management classes, configurations and repositories that store information. Therefore, configuring the User Management functionality in a WSO2 product involves setting up the relevant repositories and updating the relevant configuration files.

The following diagram illustrates the required configurations and repositories:
![](/assets/attachments/45941259/46202975.png)

See the following topics for more details:

-   [Configuring the system administrator](#RealmConfiguration-Configuringthesystemadministrator)
-   [Configuring the authorization manager](#RealmConfiguration-Configuringtheauthorizationmanager)

### Configuring the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the primary user store when you start the system for the first time . The documentation on setting up primary user stores will explain how to configure the administrator while configuring the user store. The information under this topic will explain the main configurations that are relevant to setting up the system administrator.

!!! note
If the primary user store is read-only, you will be using a user ID and role that already exists in the user store, for the administrator. If the user store is read/write, you have the option of creating the administrator user in the user store as explained below. By default, the embedded H2 database (with read/write enabled) is used for both these purposes in WSO2 products.


Note the following key facts about the system administrator in your system:

-   The admin user and role is always stored in the primary user store in your system.
-   An administrator is configured for your system by default. This **admin** user is assigned to the **admin** role, which has all permissions enabled.
-   The permissions assigned to the default **admin** role cannot be modified.

#### Updating the administrator

The `<Configuration>` section at the top of the `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file allows you to configure the administrator user in your system as well as the RDBMS that will be used for storing information related to user authentication (i.e. role-based permissions).

``` java
    <Realm>
      <Configuration>
       <AddAdmin>true</AddAdmin>
       <AdminRole>admin</AdminRole>
       <AdminUser>
           <UserName>admin</UserName>
           <Password>admin</Password>
       </AdminUser>
       <EveryOneRoleName>everyone</EveryOneRoleName> <!-- By default users in this role see the registry root -->
       <Property name=""></Property>
       ...............
      </Configuration>
    ...
    </Realm> 
```

Note the following regarding the configuration above.

<table>
<thead>
<tr class="header">
<th>Element</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>              &lt;AddAdmin&gt;             </code></td>
<td>When <code>              true             </code> , this element creates the admin user based on the <code>              AdminUser             </code> element. It also indicates whether to create the specified admin user if it doesn't already exist. When connecting to an external read-only LDAP or Active Directory user store, this property needs to be <code>              false             </code> if an admin user and admin role exist within the user store. If the admin user and admin role do not exist in the user store, this value should be <code>              true             </code> , so that the role is added to the user management database. However, if the admin user is not there in the user store, we must add that user to the user store manually. If the <code>              AddAdmin             </code> value is set to <code>              true             </code> in this case, it will generate an exception.</td>
</tr>
<tr class="even">
<td><code>              &lt;AdminRole&gt;wso2admin&lt;/AdminRole&gt;             </code></td>
<td>This is the role that has all administrative privileges of the WSO2 product, so all users having this role are admins of the product. You can provide any meaningful name for this role. This role is created in the internal H2 database when the product starts. This role has permission to carry out any actions related to the Management Console. If the user store is read-only, this role is added to the system as a special internal role where users are from an external user store.</td>
</tr>
<tr class="odd">
<td><code>              &lt;AdminUser&gt;             </code></td>
<td><p>Configures the default administrator for the WSO2 product. If the user store is read-only, the admin user must exist in the user store or the system will not start. If the external user store is read-only, you must select a user already existing in the external user store and add it as the admin user that is defined in the <code>               &lt;AdminUser&gt;              </code> element. If the external user store is in read/write mode, and you set <code>               &lt;AddAdmin&gt;              </code> to <code>               true              </code> , the user you specify will be automatically created.</p></td>
</tr>
<tr class="even">
<td><code>              &lt;UserName&gt;             </code></td>
<td>This is the username of the default administrator or super tenant of the user store. I f the user store is read-only, the admin user MUST exist in the user store for the process to work.</td>
</tr>
<tr class="odd">
<td><code>              &lt;Password&gt;             </code></td>
<td><div class="content-wrapper">
<p>I f the user store is read-only, this element and its value are ignored after the server starts for the first time. Therefore we can reset this password back to the original value/variable after server starts for the first time. This password is used only if the user store is read-write and the <code>                AddAdmin               </code> value is set to <code>                true               </code> .<br />
</p>
!!! note
<p>Note that the password in the <code>                user-mgt.xml               </code> file is written to the primary user store when the server starts for the first time. Thereafter, the password will be validated from the primary user store and not from the <code>                user-mgt.xml               </code> file. Therefore, if you need to change the admin password stored in the user store, you cannot simply change the value in the <code>                user-mgt.xml               </code> file. To change the admin password, you must use the <strong>Change Password</strong> option from the management console.</p>

</div></td>
</tr>
<tr class="even">
<td><code>              &lt;EveryOneRoleName&gt;             </code></td>
<td>The name of the &quot;everyone&quot; role. All users in the system belong to this role.</td>
</tr>
</tbody>
</table>

### Configuring the authorization manager

According to the default configuration in WSO2 products, the Users, Roles and Permissions are stored in the same repository (i.e., the default, embedded H2 database). However, you can change this configuration in such a way that the Users and Roles are stored in one repository (User Store) and the Permissions are stored in a separate repository. A user store can be a typical RDBMS, an LDAP or an external Active Directory.

The repository that stores Permissions should always be an RDBMS. The Authorization Manager configuration in the `user-mgt.xml` file (stored in the `<PRODUCT_HOME>/repository/conf/` directory) connects the system to this RDBMS.

Follow the steps given below to set up and configure the Authorization Manager.

#### Step 1: Setting up the repository

By default, the embedded H2 database is used for storing permissions. You can change this as follows:

1.  Change the default H2 database or set up another RDBMS for storing permissions.
2.  W hen you set up an RDBMS for your system, it is necessary to create a corresponding datasource, which allows the system to connect to the database.
    -   If you are replacing the default H2 database with a new RDBMS, update the `master-datasource.xml` file (stored in the `<PRODUCT_HOME>/repository/conf/datasources/` directory) with the relevant information.
    -   Alternatively, create a new XML file with the datasource information of your new RDBMS and store it in the same `<PRODUCT_HOME>/repository/conf/datasources/` directory.

Refer the [related topics](#RealmConfiguration-Relatedtopics) for detailed information on setting up databases and configuring datasources.

#### Step 2: Updating the user realm configurations

Once you have set up a new RDBMS and configured the datasource, the `user-mgt.xml` file (user realm configuration) should be updated as explained below.

1.  Set up the database connection by update the datasource information using the `<Property>` element under `<Configuration>` . The jndi name of the datasource should be used to refer to the datasource. In the following example, the jndi name of the default datasource defined in the `<PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file is linked from the `user-mgt.xml` file.

    ``` html/xml
        <Realm>
          <Configuration>
           ..........
           <Property name="dataSource">jdbc/WSO2CarbonDB</Property>
          </Configuration>
        ...
        </Realm> 
    ```

    You can add more configurations using the `<Property>` element:

    <table>
    <colgroup>
    <col width="33%" />
    <col width="33%" />
    <col width="33%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><p>Property Name</p></th>
    <th><p>Description</p></th>
    <th>Mandatory/Optional</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><code>                testOnBorrow               </code></td>
    <td><p>It is recommended to set this property to 'true' so that object connections will be validated before being borrowed from the JDBC pool. For this property to be effective, the <code>                 validationQuery                </code> parameter in the <code>                 &lt;PRODUCT_HOME&gt;/repository/conf/datasources/master-datasources.xml                </code> file should be a non-string value. This setting will avoid connection failures. See the section on performance tuning of WSO2 products for more information.</p></td>
    <td>Optional</td>
    </tr>
    </tbody>
    </table>

2.  The default Authorization Manager section in the `user-mgt.xml` file is shown below. This can be updated accordingly.

    ``` java
            <AuthorizationManager class="org.wso2.carbon.user.core.authorization.JDBCAuthorizationManager">
                    <Property name="AdminRoleManagementPermissions">/permission</Property>
                    <Property name="AuthorizationCacheEnabled">true</Property>
            </AuthorizationManager>
    ```

    -   The `org.wso2.carbon.user.core.authorization.JDBCAuthorizationManager` class enables the Authorization Manager for your product.
    -   The `AdminRoleManagementPermissions` property sets the registry path where the authorization information (role-based permissions) are stored. Note that this links to the repository that you defined in [Step 1](#RealmConfiguration-#Step1Settinguptherepo) .
    -   It is recommended to enable the `GetAllRolesOfUserEnabled` property in the `AuthorizationManager` as follows:

        ``` java
                    <Property name="GetAllRolesOfUserEnabled">true</Property>
        ```

        Although using the user store manager does not depend on this property, you must consider enabling this if there are any performance issues in your production environment. Enabling this property affects the performance when the user logs in. This depends on the users, roles and permission stats.

    -   By default, the rules linked to a permission (role name, action, resource) are not case sensitive. If you want to make them case sensitive, enable the following property:

        ``` java
                    <Property name="CaseSensitiveAuthorizationRules">true</Property>
        ```

### Related topics

1.  See [Maintaining Logins and Passwords](https://docs.wso2.com/display/AM260/Maintaining+Logins+and+Passwords) for information on how to change the super admin credentials.


