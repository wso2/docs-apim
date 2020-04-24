#  Creating Custom Users to Perform API Controller Operations

To perform tasks using the API Controller, a particular user must have required permissions and scopes. By default, a user with `admin` role is allowed perform all the tasks. 

## Steps to Create a Custom User who can Perform API Controller Operations

1. Create a role named `custom_role` with `API Create`, `API Publish` and `API Subscribe` permissions (along with `Login` permission) and assign it to a user.

    !!! tip
        Refer [Managing Users and Roles]({{base_path}}/administer/product-administration/managing-users-and-roles/introduction-to-user-management/) to learn how to create a user role with permissions and assign it to a user.

2.  Assigning the required scopes for the `custom_role` can be done using 2 methods.

    1.  Using API-M management console.

        1. Sign in to the API-M management console (`https://<APIM_Host>:<APIM_Port>/carbon`) as a tenant admin user.

        2. Navigate to **Main > Resources > Browse** 

        3.  Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.

        4.  Update the `RESTAPIScopes` JSON field by adding `custom_role` to the `Roles` field under the corresponding scope `Name` fields as shown below.
            ```bash
            {
                "Name": "apim:api_view",
                "Roles": "admin,Internal/publisher,Internal/creator,Internal/analytics,custom_role"
            },
            {
                "Name": "apim:subscribe",
                "Roles": "admin,Internal/subscriber,custom_role"
            },
            {
                "Name": "apim:app_owner_change",
                "Roles": "admin,custom_role"
            },
                "Name": "apim:app_import_export",
                "Roles": "admin,custom_role"
            },
            {
                "Name": "apim:api_import_export",
                "Roles": "admin,custom_role"
            },
            ``` 

    2.  Using API-M management console.
        
        1. Log in to the Admin portal (`https://<APIM_Host>:<APIM_Port>/admin`).

        2. Navigate to **Settings > Scope Mapping** in Admin portal.

        3.  Add `custom_role` to the `Roles` field under the corresponding scope `Name` fields as shown below.

            [![Admin portal scope mapping]({{base_path}}/assets/img/learn/api-controller/admin-portal-scope-mapping.png)]({{base_path}}/assets/img/learn/api-controller/admin-portal-scope-mapping.png)

            The above screenshot only shows adding the `custom_role` to the scopes `apim:api_view` and `apim:subscribe`. But similarly, you should add `custom_role` to the scopes `apim:app_owner_change`, `apim:app_import_export` and `apim:api_import_export` as well.

3.  Restart the server or wait for 15 mins until the registry cache expires.

## Minimal Permissions and Scopes Required to Perform API Controller Operations

As explained in the above section, you can create any user with a custom role to perform operations using the API Controller. But if you want that user to perform some of the API Controller operations (not all) you can refer the below table and assign the permissions/scopes accordingly for that role.

<table>
<colgroup>
<col width="20%" />
<col width="40%" />
<col width="40%" />
</colgroup>
<thead>
<tr class="header">
<th>Operation</th>
<th>Minimal Permissions</th>
 <th>Minimal Scopes</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>add-env</td>
<td>-</td>
<td>-</td>
</tr>
<tr class="even">
<td>remove-env</td>
<td>-</td>
<td>-</td>
</tr>
<tr class="odd">
<td>list env</td>
<td>-</td>
<td>-</td>
</tr>
<tr class="even">
<td>login</td>
<td><strong>API Create</strong> or <strong>API Publish</strong> or <strong>API Subscribe</strong></td>
<td>-</td>
</tr>
<tr class="odd">
<td>logout</td>
<td><strong>API Create</strong> or <strong>API Publish</strong> or <strong>API Subscribe</strong></td>
<td>-</td>
</tr>
<tr class="even">
<td>list apis</td>
<td><strong>API Create</strong> or <strong>API Publish</strong> or <strong>API Subscribe</strong></td>
<td>-</td>
</tr>
<tr class="odd">
<td>import-api</td>
<td><strong>API Create</strong> to import an API in CREATED state,<br> Both <strong>API Create</strong> and <strong>API Publish</strong> to import an API in PUBLISHED state</td>
<td>apim:api_import_export</td>
</tr>
<tr class="even">
<td>import-api with     --update</td>
<td><strong>API Create</strong> to import an API in CREATED state,<br> Both <strong>API Create</strong> and <strong>API Publish</strong> to import an API in PUBLISHED state</td>
<td>apim:api_import_export,<br>apim:api_view</td>
</tr>
<tr class="odd">
<td>export-api</td>
<td>-</td>
<td>apim:api_import_export</td>
</tr>
<tr class="even">
<td>export-apis</td>
<td>-</td>
<td>apim:api_import_export,<br>apim:api_view</td>
</tr>
<tr class="odd">
<td>list apps</td>
<td>-</td>
<td>apim:app_import_export,<br>apim:app_owner_change</td>
</tr>
<tr class="even">
<td>import-app</td>
<td><strong>API Subscribe</strong></td>
<td>apim:app_import_export</td>
</tr>
<tr class="odd">
<td>export-app</td>
<td>-</td>
<td>apim:app_import_export</td>
</tr>
<tr class="even">
<td>get-keys</td>
<td><strong>API Subscribe</strong></td>     
<td>apim:api_view, <br>apim:subscribe</td>
</tr>
</tbody>
</table>