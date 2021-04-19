#  Creating Custom Users to Perform apictl Operations

To perform tasks using the **WSO2 API Controller (apictl)**, a particular user must have required permissions and scopes. From WSO2 API Manager (WSO2 API-M) 3.2.0 onwards, a new role named `Internal/devops` has been introduced who has the ability to perform all the apictl related operations. You just need to create a new user (Refer [Adding a new User]({{base_path}}/administer/managing-users-and-roles/managing-users/#adding-a-new-user) to learn about adding new users), assign the role `Internal/devops` and use that user to perform the apictl operations.

## Minimal permissions and scopes required to perform apictl operations

Further, you can create your own custom user with a custom role to perform specific set of apictl operations. Refer the below table to learn about the required permissions and scopes that are needed for each of the apictl operation.

!!! info
    **Steps to create a custom user with a custom role for your need** 

    - As shown in [Create user roles]({{base_path}}/administer/managing-users-and-roles/managing-user-roles/#create-user-roles) section, you can create your own custom user role by assigning permissions and scopes that are required to perform a particular set of apictl operations by referring the table below.
    - Then, create a user as explained in [Adding a new User]({{base_path}}/administer/managing-users-and-roles/managing-users/#adding-a-new-user), by assigning the custom role that you created in the above step, to that user.
    - Now you can login to apictl (using `apictl login <env-name>` command) and perform the particular set of operations as per your need.

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
<td>add env</td>
<td>-</td>
<td>-</td>
</tr>
<tr class="even">
<td>remove env</td>
<td>-</td>
<td>-</td>
</tr>
<tr class="odd">
<td>get envs</td>
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
<td>get apis</td>
<td><strong>API Create</strong> or <strong>API Publish</strong> or <strong>API Subscribe</strong></td>
<td>apim:api_import_export</td>
</tr>
<tr class="odd">
<td>delete api</td>
<td><strong>API Create</strong></td>
<td>apim:api_import_export</td>
</tr>
<tr class="even">
<td>change-status api</td>
<td><strong>API Publish</strong></td>
<td>apim:api_import_export</td>
</tr>
<tr class="odd">
<td>import api</td>
<td><strong>API Create</strong> to import an API in CREATED state,<br> Both <strong>API Create</strong> and <strong>API Publish</strong> to import an API in PUBLISHED state</td>
<td>apim:api_import_export</td>
</tr>
<tr class="odd">
<td>export api</td>
<td>-</td>
<td>apim:api_import_export</td>
</tr>
<tr class="even">
<td>export-apis</td>
<td>-</td>
<td>apim:api_import_export</td>
</tr>
<tr class="odd">
<td>get api-products</td>
<td>-</td>
<td>apim:api_product_import_export</td>
</tr>
<tr class="even">
<td>delete api-product</td>
<td><strong>API Publish</strong></td>
<td>apim:api_product_import_export</td>
</tr>
<tr class="odd">
<td>import api-product</td>
<td><strong>API Publish</strong></td>
<td>apim:api_product_import_export</td>
</tr>
<tr class="odd">
<td>export api-product</td>
<td>-</td>
<td>apim:api_product_import_export,<br>apim:api_import_export</td>
</tr>
<tr class="even">
<td>list apps</td>
<td>-</td>
<td>apim:app_import_export</td>
</tr>
<tr class="odd">
<td>delete app</td>
<td><strong>API Subscribe</strong></td>
<td>apim:app_import_export</td>
</tr>
<tr class="even">
<td>import app</td>
<td><strong>API Subscribe</strong></td>
<td>apim:app_import_export</td>
</tr>
<tr class="odd">
<td>export app</td>
<td>-</td>
<td>apim:app_import_export</td>
</tr>
<tr class="even">
<td>get keys</td>
<td><strong>API Subscribe</strong></td>     
<td>apim:app_manage, <br>apim:sub_manage, <br>apim:api_product_import_export
<br><br>or<br>apim:app_manage, <br>apim:sub_manage, <br>apim:api_import_export
<br><br>or<br>apim:app_manage, <br>apim:sub_manage, <br>apim:api_view</td>
</tr>
</tbody>
</table>
