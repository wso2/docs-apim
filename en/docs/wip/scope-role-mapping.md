##Scope Mapping

Internal REST API scopes and their role mappings are stored in tenant-conf.json file. And in earlier versions, users had to manually update
`tenant-conf.json` file in order to modify scope to role mappings. From API Manager 3.1.0
onwards we are offering an option in admin portal to achieve this task easily.

#### Modify an Existing Scope Mapping

1. Go to admin dashboard and navigate to Settings > Scope Mapping. This will list down the existing REST API scopes
along with their current role bindings.

2. Suppose you have a role 'manager' and you want to allow 'manager' users to access REST API resources protected with
apim_publish scope. To get this done apim_scope's role binding has to be updated as below.

```
apim_publish : admin,Internal/publisher,manager
```
3. Locate apim_publish scope in the table and click on the edit button. Enter the modified role list and save.

####Role Mapping

Now suppose a scenario where the admin role in your environment is renamed to 'manager'. In a situation like this
you would have to replace 'admin' to 'manager' in  all scope mappings in the scope mapping table. Obviously this is a tedious task.
And that is why we are offering you a feature to map role names. So all you have to do is to add a row in rolw mapping table 
instructing to map admin role to manager role.

1. Give 'admin' as the original role name.
2. Give 'manager' as the mapped role(s) list.
3. Click on add icon.
