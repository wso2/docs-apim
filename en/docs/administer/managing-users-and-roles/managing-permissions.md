# Role-based Permissions

The **User Management** module in WSO2 products enables role-based access. As a result, the permissions enabled for a particular role determines what that user can do using the management console of a WSO2 product. Permissions can be granted to a role at two levels:

-   **Super tenant level:** A role with super tenant permissions is used for managing all the tenants in the system and also for managing the key features in the system, which are applicable to all the tenants.
-   **Tenant level:** A role with tenant level permissions is only applicable to individual tenant spaces.

The permissions navigator that you use to enable permissions for a role is divided into these two categories (**Super Admin** permissions and **Admin** permissions) as shown below.

![Admin permissions tree]({{base_path}}/assets/img/administer/admin-permissions-tree.png)

You can access the permissions navigator for a particular role by clicking **Permissions** as shown below.

![Change permissions of role]({{base_path}}/assets/img/administer/change-permissions-of-role.png)

By default, every WSO2 product comes with the following Users, Roles and Permissions configured:

**Users:**

- **Admin** - Has all the permissions in the system enabled by default. Therefore, this is a super tenant, with all permissions enabled. By default, the admin user is assigned to both the **admin** and the **everyone** roles.

!!! info

    -   The **admin** user and **admin** role are defined and linked to each other in the `user-mgt.xml` file, stored in the `<PRODUCT_HOME>/repository/conf/` directory as shown below.

        ``` java
        <AddAdmin>true</AddAdmin>
        <AdminRole>admin</AdminRole>
        <AdminUser>
            <UserName>admin</UserName>
            <Password>admin</Password>
        </AdminUser>
        ```
        These properties can be customized by configuring the `<PRODUCT_HOME>/repository/conf/deployment.toml` file. For more information, see [Change the super admin credentials]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/maintaining-logins-and-passwords/#change-the-super-admin-credentials). 

    -   The **admin** role has all the permissions in the system enabled by default. Therefore, this is a super tenant, with all permissions enabled.

**Roles:**

By default, all WSO2 products have the following roles configured: 

-   **admin** - Provides full access to all features and controls. By default, the admin user is assigned to both the admin and the `Internal/everyone` roles.
-   **Internal/everyone** - This is a pre-defined role that is used to group all the users (across the user stores) together. When you create a new user, automatically the user belongs to the `Internal/everyone` role. It does not include any permissions. This role can be used to identify all logged-in users.
-   **Internal/system** - This is another pre-defined role that does not include any permissions. Unlike the `Internal/everyone` role, this role is **not assigned** to a user by default.
-   **Internal/analytics** - This role can be assigned to users who do not have the publisher or subscriber roles assigned but need permission to view the analytics dashboards.

In addition to the above, the following roles exist by default.

-  Internal/creator
-  Internal/publisher
-  Internal/subscriber

For more information about managing roles, see [Managing User Roles]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-roles)

You will be able to log in to the management console of the product with the **admin** user defined in the `user-mgt.xml` file. You can then create new users and roles and configure permissions for the roles using the management console. However, note that you cannot modify the permissions of the **admin** role. The possibility of managing users, roles, and permissions is granted by the **User Management** permission. For more information, see [Configuring the User Realm](https://is.docs.wso2.com/en/5.10.0/setup/configuring-the-realm/).

## Description of role-based permissions

!!! note
    Note that the descriptions given in this document only explain how permissions control access to operations available on the [Management Console](``https://localhost:9443/carbon``) (`https://<hostname>:9443/carbon`). In addition, not that all the permissions available in the permission tree are listed here. You can get the information related to them throughout the documentation wherever applicable.

### Log-in permissions

The **Login** permission defined under **Admin** permissions allows users to log in to the management console of the product. Therefore, this is the primary permission required for using the management console.

![Login Permissions]({{base_path}}/assets/img/administer/login-permissions.png)

### Super tenant permissions

The following table describes the permissions at **Super Tenant** level. These are also referred to as **Super Admin** permissions.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th><b>Permission</b></th>
<th><b>Description of UI menus enabled</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Management</strong> permissions: </br>
<img src="{{base_path}}/assets/img/administer/manage-permissions.png" /></td>
<td><p>The <strong>Super Admin/Manage</strong> permissions are used for adding new tenants and monitoring them.</p>
<p><strong>- Modify/Tenants</strong> permission enables the <strong>Add New Tenant</strong> option in the <strong>Configure/Multitenancy</strong> menu of the management console, which allows users to add new tenants.<br />
<strong>- Monitor/Tenants</strong> permission enables the <strong>View Tenants</strong> option in the <strong>Configure/Multitenancy</strong> menu of the management console.</p></td>
</tr>
<tr class="even">
<td><strong>Server Admin</strong> permissions:<br />
<img src="{{base_path}}/assets/img/administer/server-admin-permissions.png" /></td>
<td>Selecting the <strong>Server Admin</strong> permission enables the <strong>Manage/Shutdown/Restart</strong> option in the <strong>Main</strong> menu of the management console.</td>
</tr>
</tbody>
</table>

<!-- -->

### Tenant-level permissions

The following table describes the permissions at **Tenant** level. These are also referred to as **Admin** permissions.

!!! info
        Note that when you select a node in the **Permissions** navigator, all the subordinate permissions that are listed under the selected node are also automatically enabled.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th><b>Permission level</b></th>
<th><b>Description of UI menus enabled</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Admin</td>
<td>When the <strong>Admin</strong> permission node is selected, features including the following menus are enabled in the management console:
<ul><li>
<strong>Identity/User Stores:</strong> This permission allows users to add new user stores and manage them with the management console. Note that only secondary user stores can be added using this option. See the topic on <a href="{{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configuring-secondary-user-stores/">Configuring Secondary User Stores</a> for more details.<br />
</li><li><strong>Identity/Identity Providers:</strong> For more information, see <a href="https://is.docs.wso2.com/en/5.10.0/learn/adding-and-configuring-an-identity-provider"> working with identity providers</a>.
</li><li>
<p>Additionally, all permissions listed under <strong>Admin</strong> in the permissions navigator are selected automatically.</p></li></ul></td>
</tr>
<tr class="even">
<td>Admin/Manage/Identity/User Store Management</td>
<td>This permission enables the <strong>Identity/User Stores</strong> option in the <strong>Main</strong> menu. This option allows users to add new user stores. For more details on User Store Management, see <a href="{{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configuring-secondary-user-stores/">Configuring Secondary User Stores</a></td>
</tr>
<tr class="odd">
<td>Admin/Manage/Identity/Claim</td>
<td>This permission enables the <strong>Identity/Claims</strong> option in the <strong>Main</strong> menu. This option allows users to perform Claim Management. For more details, see <a href="https://is.docs.wso2.com/en/5.10.0/learn/claim-management/">Claim Management.</a></td>
</tr>
<tr class="even">
<td>Admin/Manage/Identity/Key Store Management</td>
<td>This permission enables the <strong>Manage/KeyStores</strong> option in the <strong>Main</strong> menu. This option allows users to add and modify new key stores. For more details on Key Store Management, see <a href="https://is.docs.wso2.com/en/5.10.0/administer/creating-new-keystores/">Creating New Key Stores</a></td>
</tr>
<tr class="odd">
<td>Admin/Manage/Resources/Browse</td>
<td>This permission enables the <strong>Browse</strong> option under the <strong>Registry</strong> menu in the main navigator. This option allows users to browse the resources stored in the registry by using the <strong>Registry</strong> tree navigator.</td>
</tr>
<tr class="even">
<td>Admin/Manage/Search</td>
<td>This permission enables the <strong>Search</strong> option under the <strong>Registry</strong> sub-menu in the <strong>Main</strong> menu. This option allows users to search for specific resources stored in the registry by filling in the search criteria.</td>
</tr>
<tr class="odd">
<td>Admin/Monitor</td>
<td>When the <strong>Admin/Monitor</strong> permission node is selected, system monitoring related features including the following menus are enabled in the management console:

<ul><li><strong>Monitor</strong> menu <strong>/System Statistics:</strong>.</li>
<li>
Additionally, all permissions listed under <strong>Admin/Monitor</strong> in the permissions navigator will be enabled automatically.</li></ul></td>
</tr>
</tbody>
</table>

## Adding API-M specific Scope Assignments

!!! note
    Note that the role-scope assignments mentioned here are related to the internal API-M specific scope assignments 
    which is different from the [role-permission assignments]({{base_path}}/administer/managing-users-and-roles/managing-permissions/#role-based-permissions) done in the management console.

1. Sign in to Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) and navigate to **Settings** > **Scope Assignments** in the Admin Portal. 

2. Click **Add scope mappings**.

    ![Add Scope Mapping]({{base_path}}/assets/img/administer/add-scope-mapping.png) 

3. Provide a role name created in a Carbon console. Then click **Next** to proceed.

    ![Add Role]({{base_path}}/assets/img/administer/add-new-scope-name.png)
 
4. In **Select scope assignments**, you can either select **Role alias** or **Custom scope assignment**.
 
    ##### Role Alias 
    - New roles can be mapped to existing `Internal/*` roles, created roles, and admin. All the scopes associated with the selected existing role will be mapped to the new role automatically.  
    - If you want to map the scopes of `Internal/creator` to the new `creator` role, select `Internal/creator` from the drop-down menu and save. 
    - This will update all scope mappings in the `tenant-conf.json` file with `Internal/creator` as an allowed role resulting in the new `creator` role to be allowed for all scopes allowed for the `Internal/creator` role.
        
        ![Add Role Alias Mapping]({{base_path}}/assets/img/administer/new-role-alias-mapping.png)

    ##### Custom Scope Assignments
    - New roles can be associated with scopes individually. If you create a custom role that has different permissions, add the required scopes for the role based on the functionality or permissions you need to give to a user carrying this role. 
    - For example, if you need to allow the user to create APIs, select the new scope `apim:api_create` under **custom scope assignments**.
        
        ![Add Custom Scope Mapping]({{base_path}}/assets/img/administer/new-custom-scope-mapping.png) 

!!! info 
    The following are the scopes allowed for each default Internal role under the default configurations.
    
    | **Role**                                   | **admin**   | **Internal/publisher**   | **Internal/creator**   | **Internal/subscriber**   | **Internal/analytics**   | **Internal/everyone**   | **Internal/devops**     |
    |-- ------------------------------------ | ------- | -------------------- | ------------------ | --------------------- | -------------------- | ----------------- --| ----------------- --|
    | apim:api_publish                       | &check; | &check;              |                    |                       |                      |                     |  &check;            |
    | apim:api_create                        | &check; |                      | &check;            |                       |                      |                     |  &check;            |
    | apim:api_view                          | &check; | &check;              | &check;            |                       | &check;              |                     |                     |
    | apim:api_delete                        | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:subscribe                         | &check; |                      |                    | &check;               |                      |                     |  &check;            |
    | apim:tier_view                         | &check; | &check;              | &check;            |                       |                      |                     |                     |
    | apim:tier_manage                       | &check; |                      |                    |                       |                      |                     |                     |
    | apim:bl_view                           | &check; |                      |                    |                       |                      |                     |                     |
    | apim:subscription_view                 | &check; | &check;              | &check;            |                       |                      |                     |                     |
    | apim:subscription_block                | &check; | &check;              |                    |                       |                      |                     |                     |
    | apim:mediation_policy_view             | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:mediation_policy_create           | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:api_workflow                      | &check; |                      |                    |                       |                      |                     |                     |
    | apim:app_owner_change                  | &check; |                      |                    |                       |                      |                     |                     |
    | apim:app_import_export                 | &check; |                      |                    |                       |                      |                     |                     |
    | apim:api_import_export                 | &check; |                      |                    |                       |                      |                     |                     |
    | apim:label_manage                      | &check; |                      |                    |                       |                      |                     |                     |
    | apim:label_read                        | &check; |                      |                    |                       |                      |                     |                     |
    | apim:app_update                        | &check; |                      |                    | &check;               |                      |                     |                     |
    | apim:app_manage                        | &check; |                      |                    | &check;               |                      |                     |                     |
    | apim:sub_manage                        | &check; |                      |                    | &check;               |                      |                     |                     |
    | apim:monetization_usage_publish        | &check; | &check;              |                    |                       |                      |                     |                     |
    | apim:document_create                   | &check; | &check;              | &check;            |                       |                      |                     |                     |
    | apim:ep_certificates_update            | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:client_certificates_update        | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:threat_protection_policy_manage   | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:document_manage                   | &check; | &check;              | &check;            |                       |                      |                     |                     |
    | apim:client_certificates_add           | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:publisher_settings                | &check; | &check;              | &check;            |                       |                      |                     |                     |
    | apim:store_settings                    | &check; |                      |                    | &check;               |                      |                     |                     |
    | apim:client_certificates_view          | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:mediation_policy_manage           | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:threat_protection_policy_create   | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:ep_certificates_add               | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:ep_certificates_view              | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:api_key                           | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim_analytics:admin                   | &check; |                      |                    |                       |                      |                     |                     |
    | apim_analytics:product_manager         | &check; | &check;              | &check;            | &check;               |                      |                     |                     |
    | apim_analytics:api_developer           | &check; | &check;              | &check;            |                       |                      |                     |                     |
    | apim_analytics:app_developer           | &check; |                      |                    | &check;               |                      |                     |                     |
    | apim_analytics:devops_engineer         | &check; | &check;              | &check;            | &check;               |                      |                     |                     |
    | apim_analytics:analytics_viewer        | &check; |                      |                    |                       | &check;              |                     |                     |
    | apim_analytics:everyone                |         |                      |                    |                       |                      | &check;             |                     |
    | apim:pub_alert_manage                  | &check; |                      | &check;            |                       |                      |                     |                     |
    | apim:sub_alert_manage                  | &check; |                      |                    | &check;               |                      |                     |                     |
    | apim:tenantInfo                        | &check; |                      |                    |                       |                      |                     |                     |
    | apim:admin_operations                  | &check; |                      |                    |                       |                      |                     |                     |

