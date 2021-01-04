# Managing User Roles

Roles contain permissions for users to manage the server. They can be reused and they eliminate the overhead of granting permissions to users individually.

The following roles that are typically used in many enterprises are used throughout this documentation. You can also define different user roles depending on your requirements.

-   <a name="admin-role">**admin:**</a> The API management provider who hosts and manages the [API Gateway]({{base_path}}/getting-started/overview/#api-gateway) and is responsible for creating users in the system, assigning them roles, managing databases, security, etc. The Admin role is also used to access the WSO2 Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`), where you can define workflow tasks, throttling policies, analytics configurations, etc. The Admin role is available by default with the credentials admin/admin. By default, this role contains all the permissions (including super admin permissions) in the permission tree.
-   <a name="creator-role">**creator:**</a> A creator is typically a person in a technical role who understands the technical aspects of the API (interfaces, documentation, versions, etc.) and uses the [API publisher]({{base_path}}/getting-started/overview/#api-publisher) to provision APIs into the Developer Portal. The creator uses the Developer Portal to consult ratings and feedback provided by API users. The creator can add APIs to the Developer Portal but cannot manage their lifecycle. Governance permission gives a creator permission to govern, manage, and configure the API artifacts.
-   <a name="publisher-role">**publisher:**</a> A person in a managerial role and overlooks a set of APIs across the enterprise and controls the API lifecycle, subscriptions, and monetization aspects. The publisher is also interested in usage patterns for APIs and has access to all API statistics.
-   <a name="subscriber-role">**subscriber:**</a> Users or Application Developers who search the [Developer Portal]({{base_path}}/getting-started/overview/#developer-portal) to discover APIs and use them. They read the documentation and forums, rates/comments on the APIs, subscribes to APIs, obtain access tokens, and invokes the APIs.

Follow the instructions below to create the `creator`, `publisher`, and `subscriber` roles in the API Manager for sample purposes.

## Create user roles

1.  Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as the admin (default credentials are admin/admin).
2.  Click **Main**, and then click **Add** under **Users and Roles**.

     [![Add users and roles]({{base_path}}/assets/img/administer/add-users-and-roles.png)]({{base_path}}/assets/img/administer/add-users-and-roles.png)

3.  Click **Add New Role**.

    ![Add new role]({{base_path}}/assets/img/administer/add-new-role.png)

4.  Enter the name of the user role (e.g., `creator`).

    ![Enter role details]({{base_path}}/assets/img/administer/enter-role-details.png)
    
    In the Domain list, specify the user store where you want to create this role. This list includes the primary user store and any other secondary user stores that are configured for your product. For information on how user stores (which are repositories storing information about users and roles) are set up and configured, see [Configuring User Stores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/introduction-to-userstores). Enter a unique name for this role (`creator`) and click **Next**.

    !!! tip
            The **Domain** drop-down list contains all user stores configured in the system. By default, only the PRIMARY user store is configured. To configure secondary user stores, see [Configuring Secondary User Stores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configuring-secondary-user-stores/).

5.  The permissions page opens. 

    ![Select role permissions]({{base_path}}/assets/img/administer/permissions.png)

    Select the permissions according to the role that you create. The table below lists the permissions of the `creator`, `publisher`, and `subscriber` roles which are available by default. 
    
    As you have created the `creator` role here, assign the permissions listed under the creator role as given in the table below.

    <table>
    <thead>
    <tr class="header">
    <th><b>Roles</b></th>
    <th><b>Permissions</b></th>
    <th><b>UI</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>creator</td>
    <td><ul>
    <li>Configure &gt; Governance and all underlying permissions.</li>
    <li>Login</li>
    <li>Manage &gt; API &gt; Create</li>
    <li>Manage &gt; Resources &gt; Govern and all underlying permissions</li>
    </ul></td>
    <td><div class="content-wrapper">
    <img src="{{base_path}}/assets/img/administer/creator-role-permissions.png" />
    </div></td>
    </tr>
    <tr class="even">
    <td>publisher</td>
    <td><ul>
    <li>Login</li>
    <li>Manage &gt; API &gt; Publish</li>
    </ul></td>
    <td><div class="content-wrapper">
    <img src="{{base_path}}/assets/img/administer/publisher-role-permissions.png" />
    </div></td>
    </tr>
    <tr class="odd">
    <td><p>subscriber<br />
    </p></td>
    <td><ul>
    <li>Login</li>
    <li>Manage &gt; API &gt; Subscribe</li>
    </ul>
    <br />
    </td>
    <td><div class="content-wrapper">
    <img src="{{base_path}}/assets/img/administer/subscriber-role-permissions.png" />
    </div></td>
    </tr>
    </tbody>
    </table>

6.  Click **Finish** once you are done adding permissions.

    !!! warning

            In WSO2 API Manager 3.2.0, Developer Portal and Publisher Web Application UIs are populated by API-M REST APIs and all the authentication and authorization to access the different components in the UI solely depend on the scope role mapping defined in `/_system/config/apimgt/applicationdata/tenant-conf.json` that can be accessed through the [Management Console](`https://localhost:9443/carbon`) from **Resources** > **Browse**.

            By default, the scope-role mapping contains `Internal/creator`, `Internal/publisher`, `Internal/subscriber`, `Internal/analytics`, and `Internal/devops` as the default roles. If there are custom roles defined with API creator, API publisher, admin and API subscriber permissions, those roles have to be configured in the `tenant-conf.json` file under the relevant scopes.

!!! info
     For more information on **role mapping** or **scope mapping**, see [Adding role permissions]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-permissions/#adding-role-based-permissions)

!!! info "Application Roles"
    When a user creates an application and generates application keys, a role is created automatically in the following format.

    ``` java
    "Application/<username>_<applicationName>_PRODUCTION"
    ```

    This is a special case of the `internal` role that is created for a particular service provider application. Only users who are assigned the application role permission can manage the corresponding service provider application.

    These roles do not have any permissions assigned to it, but it is used to manage the visibility of the corresponding service provider that is created in the format of `'<username>_<applicationName>_PRODUCTION'` within the Key Manager. The created service provider is only visible to users with the latter mentioned role that has been generated automatically. Only if a user with admin privileges assigns the latter mentioned role to a user, will that user be able to view the details of the service provider that is created per application.

!!! warning
    As a limitation, when you delete a user and create another with the same username, applications of the previous user will be visible on the Dev portal applications listing page.
    However the new user will not be able to access the details of the application as the service provider is already deleted.

## Adding Role Mappings

In the above example, you mapped the new `creator` role to allow all operations allowed for `Internal/creator`. There you had to update every entry that contained the `Internal/creator` role. This can be a tedious task when there are multiple scope mapping entries to be updated. Instead of using the latter mentioned method, you can use role mapping to enable users to easily map new roles to existing scopes.

1. Sign in to the Admin Portal (`https://<APIM_Host>:<APIM_Port>/admin`) if you have not done so already.

2. Navigate to **Settings > Role Permissions** in Admin Portal and click on **Add Role Permission**.
    [![View Role Permission]({{base_path}}/assets/img/administer/view-role-permissions.png)]({{base_path}}/assets/img/administer/view-role-permissions.png)

3. Provide the name of the newly created role.

    [![Add Role Name]({{base_path}}/assets/img/administer/add-role-permissions.png)]({{base_path}}/assets/img/administer/add-role-permissions.png)

4. The newly created role can be mapped to an existing internal or admin role if required.

    [![Map Role Name]({{base_path}}/assets/img/administer/map-existing-role.png)]({{base_path}}/assets/img/administer/map-existing-role.png)

5. Select the required existing scopes for the newly created role and save the changes.

    [![Scope mapping]({{base_path}}/assets/img/administer/add-scope-to-role-mapping.png)]({{base_path}}/assets/img/administer/add-scope-to-role-mapping.png)
This will update all the scope mappings in the `tenant-conf.json` file with the `Internal/creator` role as an allowed role. As a result, the new creator role will also be allowed for all scopes that are allowed for the `Internal/creator` role.

!!! info 
    The following are the scopes that are allowed for each default Internal role under the default configurations section.
    
    | **Scope**                                         | **admin**   | **Internal/publisher**   | **Internal/creator**   | **Internal/subscriber**   | **Internal/analytics**   | **Internal/everyone**   |
    | --------------------------------------------- | ------- | -------------------- | ------------------ | --------------------- | -------------------- | ----------------- --|
    | apim:api_publish                              | &check; | &check;              |                    |                       |                      |                     |
    | apim:api_create                               | &check; |                      | &check;            |                       |                      |                     |
    | apim:api_view                                 | &check; | &check;              | &check;            |                       | &check;              |                     |
    | apim:api_delete                               | &check; |                      | &check;            |                       |                      |                     |
    | apim:subscribe                                | &check; |                      |                    | &check;               |                      |                     |
    | apim:tier_view                                | &check; | &check;              | &check;            |                       |                      |                     |
    | apim:tier_manage                              | &check; |                      |                    |                       |                      |                     |
    | apim:bl_view                                  | &check; |                      |                    |                       |                      |                     |
    | apim:subscription_view                        | &check; | &check;              | &check;            |                       |                      |                     |
    | apim:subscription_block                       | &check; | &check;              |                    |                       |                      |                     |
    | apim:mediation_policy_view                    | &check; |                      | &check;            |                       |                      |                     |
    | apim:mediation_policy_create                  | &check; |                      | &check;            |                       |                      |                     |
    | apim:api_workflow                             | &check; |                      |                    |                       |                      |                     |
    | apim:app_owner_change                         | &check; |                      |                    |                       |                      |                     |
    | apim:app_import_export                        | &check; |                      |                    |                       |                      |                     |
    | apim:api_import_export                        | &check; |                      |                    |                       |                      |                     |
    | apim:label_manage                             | &check; |                      |                    |                       |                      |                     |
    | apim:label_read                               | &check; |                      |                    |                       |                      |                     |
    | apim:app_update                               | &check; |                      |                    | &check;               |                      |                     |
    | apim:app_manage                               | &check; |                      |                    | &check;               |                      |                     |
    | apim:sub_manage                               | &check; |                      |                    | &check;               |                      |                     |
    | apim:monetization_usage_publish               | &check; | &check;              |                    |                       |                      |                     |
    | apim:document_create                          | &check; | &check;              | &check;            |                       |                      |                     |
    | apim:ep_certificates_update                   | &check; |                      | &check;            |                       |                      |                     |
    | apim:client_certificates_update               | &check; |                      | &check;            |                       |                      |                     |
    | apim:threat_protection_policy_manage          | &check; |                      | &check;            |                       |                      |                     |
    | apim:document_manage                          | &check; | &check;              | &check;            |                       |                      |                     |
    | apim:client_certificates_add                  | &check; |                      | &check;            |                       |                      |                     |
    | apim:publisher_settings                       | &check; | &check;              | &check;            |                       |                      |                     |
    | apim:store_settings                           | &check; |                      |                    | &check;               |                      |                     |
    | apim:client_certificates_view                 | &check; |                      | &check;            |                       |                      |                     |
    | apim:mediation_policy_manage                  | &check; |                      | &check;            |                       |                      |                     |
    | apim:threat_protection_policy_create          | &check; |                      | &check;            |                       |                      |                     |
    | apim:ep_certificates_add                      | &check; |                      | &check;            |                       |                      |                     |
    | apim:ep_certificates_view                     | &check; |                      | &check;            |                       |                      |                     |
    | apim:api_key                                  | &check; |                      | &check;            |                       |                      |                     |
    | apim_analytics:admin                          | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:api_analytics:own              | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:api_analytics:edit             | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:api_analytics:view             | &check; | &check;              | &check;            |                       |                      |                     |
    | apim_analytics:application_analytics:own      | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:application_analytics:edit     | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:application_analytics:view     | &check; |                      |                    | &check;               |                      |                     |
    | apim_analytics:monitoring_dashboard:own       | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:monitoring_dashboard:edit      | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:monitoring_dashboard:view      | &check; |                      |                    |                       | &check;              |                     |
    | apim_analytics:business_analytics:own         | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:business_analytics:edit        | &check; |                      |                    |                       |                      |                     |
    | apim_analytics:business_analytics:view        | &check; |                      |                    |                       | &check;              |                     |
    | apim:pub_alert_manage                         | &check; |                      | &check;            |                       |                      |                     |
    | apim:sub_alert_manage                         | &check; |                      |                    | &check;               |                      |                     |
    | apim:tenantInfo                               | &check; |                      |                    |                       |                      |                     |
    | apim:admin_operations                         | &check; |                      |                    |                       |                      |                     |
    | apim:shared_scope_manage                      | &check; |                      |                    |                       |                      |                     |    

## Editing or deleting a role

1. Sign in to the management console (`https://<APIM_Host>:<APIM_Port>/carbon`) if you have not done so already.

2. In the **Main** menu, click **List** under **Users and Roles**.

    [![List users and roles]({{base_path}}/assets/img/administer/list-users-and-roles.png)]({{base_path}}/assets/img/administer/list-users-and-roles.png)

3. Click **Roles**.

    [![List roles]({{base_path}}/assets/img/administer/list-roles.png)]({{base_path}}/assets/img/administer/list-roles.png)

4. If you need to modify to a role, select the domain (user store) under **Search Roles** > **Select Domain** where the role resides.

    [![Select User Store Domains]({{base_path}}/assets/img/administer/select-user-store-domains.png)]({{base_path}}/assets/img/administer/select-user-store-domains.png)

    Then use the relevant links in the **Actions** column that corresponds to the role listing to perform the following:

    [![Edit or Delete roles]({{base_path}}/assets/img/administer/edit-or-delete-roles.png)]({{base_path}}/assets/img/administer/edit-or-delete-roles.png)

    -   Rename the role
    -   Change the default permissions associated with this role
    -   Assign this role to users
    -   View the users who are assigned this role
    -   Delete the role if you no longer need it

!!! info
        If the role is in an external user store to which you are connected in read-only mode, you will be able to view the existing roles but not edit or delete them. However, you can still create new editable roles.

### Update before the first startup (recommended)

The default role name of the Administrator, (`admin`) can be changed before starting WSO2 API Manager by editing `<API-M_HOME>/repository/conf/deployment.toml` file. For more information, see [Change the super admin credentials]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/maintaining-logins-and-passwords/#change-the-super-admin-credentials).

Configure the property `admin_role` with your custom role (`administrator`) in the `deployment.toml` file as follows and start the server.

```
[super_admin]
admin_role = "administrator"
username = "admin"
password = "admin"
create_admin_account = true
```

### Update after the product is used for some time (advanced configuration)

!!! tip
    These steps are not necessary if you have already updated the role names before the first startup of the product. 

The following steps guide you through updating the role names after you have used the product for some time.

1.  Make the configuration changes indicated in [the above section]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-roles/#update-before-the-first-startup-recommended).

2.  Do the following user store level changes for existing users:

    If you are connected to the `JDBCUserStoreManager`, update the `UM_ROLE` table with the new role name that you defined in place of the `admin` role.

    !!! info
            The schema can be located by referring to the data source `[database.shared_db]` defined in the `deployment.toml` file. The data source definition can also be found in the same file.

    -   If you are connected to the `ReadWriteLdapUserStoreManager`, populate the members of the previous `admin` role to the new role under **Groups**. For more information, see [Configuring User Stores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/introduction-to-userstores).

3.  Restart the server.
