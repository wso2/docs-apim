# Configuring the System Administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the primary user store when you start the system for the first time . The documentation on setting up primary user stores will explain how to configure the administrator while configuring the user store. The information under this topic will explain the main configurations that are relevant to setting up the system administrator.

!!! note
If the primary user store is read-only, you will be using a user ID and role that already exists in the user store, for the administrator. If the user store is read/write, you have the option of creating the administrator user in the user store as explained below. By default, the embedded H2 database (with read/write enabled) is used for both these purposes in WSO2 products.


Note the following key facts about the system administrator in your system:

-   The admin user and role is always stored in the primary user store in your system.
-   An administrator is configured for your system by default. This **admin** user is assigned to the **admin** role, which has all permissions enabled.
-   The permissions assigned to the default **admin** role cannot be modified.

### Before you begin **:**

Ensure that you have a primary user store (for storing users and roles) and an RDBMS (for storing information related to permissions). See the following documentation for instructions on how to set up these repositories.

-   [Configuring the Primary User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+the+Primary+User+Store) : This topic explains how the primary user store is set up and configured for your product.
-   [Configuring the Authorization Manager](https://docs.wso2.com/display/ADMIN44x/Configuring+the+Authorization+Manager) : This topic explains how the repository (RDBMS) for storing authorization information (role-based permissions) is configured for your product.
-   [Changing a Password](https://docs.wso2.com/display/ADMIN44x/Changing+a+Password) : This topic explains how you can change the admin password using the management console of the product.

### Updating the administrator

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
<td><code>             &lt;AddAdmin&gt;            </code></td>
<td>When <code>             true            </code> , this element creates the admin user based on the <code>             AdminUser            </code> element. It also indicates whether to create the specified admin user if it doesn't already exist. When connecting to an external read-only LDAP or Active Directory user store, this property needs to be <code>             false            </code> if an admin user and admin role exist within the user store. If the admin user and admin role do not exist in the user store, this value should be <code>             true            </code> , so that the role is added to the user management database. However, if the admin user is not there in the user store, we must add that user to the user store manually. If the <code>             AddAdmin            </code> value is set to <code>             true            </code> in this case, it will generate an exception.</td>
</tr>
<tr class="even">
<td><code>             &lt;AdminRole&gt;wso2admin&lt;/AdminRole&gt;            </code></td>
<td>This is the role that has all administrative privileges of the WSO2 product, so all users having this role are admins of the product. You can provide any meaningful name for this role. This role is created in the internal H2 database when the product starts. This role has permission to carry out any actions related to the Management Console. If the user store is read-only, this role is added to the system as a special internal role where users are from an external user store.</td>
</tr>
<tr class="odd">
<td><code>             &lt;AdminUser&gt;            </code></td>
<td><p>Configures the default administrator for the WSO2 product. If the user store is read-only, the admin user must exist in the user store or the system will not start. If the external user store is read-only, you must select a user already existing in the external user store and add it as the admin user that is defined in the <code>              &lt;AdminUser&gt;             </code> element. If the external user store is in read/write mode, and you set <code>              &lt;AddAdmin&gt;             </code> to <code>              true             </code> , the user you specify will be automatically created.</p></td>
</tr>
<tr class="even">
<td><code>             &lt;UserName&gt;            </code></td>
<td>This is the username of the default administrator or super tenant of the user store. I f the user store is read-only, the admin user MUST exist in the user store for the process to work.</td>
</tr>
<tr class="odd">
<td><code>             &lt;Password&gt;            </code></td>
<td><div class="content-wrapper">
<p>Do NOT put the password here but leave the default value. I f the user store is read-only, this element and its value are ignored. This password is used only if the user store is read-write and the <code>               AddAdmin              </code> value is set to <code>               true              </code> .<br />
</p>
!!! note
<p>Note that the password in the <code>               user-mgt.xml              </code> file is written to the primary user store when the server starts for the first time. Thereafter, the password will be validated from the primary user store and not from the <code>               user-mgt.xml              </code> file. Therefore, if you need to change the admin password stored in the user store, you cannot simply change the value in the <code>               user-mgt.xml              </code> file. To change the admin password, you must use the <strong>Change Password</strong> option from the management console as explained <a href="https://docs.wso2.com/display/ADMIN44x/Changing+a+Password">here</a> .</p>

</div></td>
</tr>
<tr class="even">
<td><code>             &lt;EveryOneRoleName&gt;            </code></td>
<td>The name of the &quot;everyone&quot; role. All users in the system belong to this role.</td>
</tr>
</tbody>
</table>


