# Scope Mapping

Internal REST API scopes and their role mappings are stored in the `tenant-conf.json` file. In earlier versions of WSO2 API Manager, users had to manually update the `tenant-conf.json` file in order to modify the scope to role mappings. You can easily achieve the latter mentioned task via the Admin Portal.

## Modify an Existing Scope Mapping

1. Sign in to the Admin Portal.

   (`https://<HostName>:9443/admin`)

2. Click to Settings --> Scope Mapping. 

    The list of the existing REST API scopes along with their current role bindings appear.

3. Update the `apim_scope` role binding.
    
   For example, if you have a role named 'manager' and you need to allow 'manager' users to access the REST API resources protected by the `apim_publish` scope, then you need to update the `apim_scope` role binding as follows:

   ```
   apim_publish : admin,Internal/publisher,manager
   ```
4. Locate apim_publish scope in the table and click **Edit**. 

5. Enter the modified role list and click **Save**.

## Role Mapping

If you need to rename the `admin` role in your environment as `manager`, you would generally have to replace `admin` to `manager` in all the scope mappings in the scope mapping table, which is a tedious task.

However, when using scope mapping in WSO2 API-M, you can simply map the role names by adding a row in the role mapping table with instructs to map the `admin` role to the `manager` role as explained below:

1. Enter `admin` as the original role name.

2. Enter `manager` as the mapped role(s) list.

3. Click **Add**.
