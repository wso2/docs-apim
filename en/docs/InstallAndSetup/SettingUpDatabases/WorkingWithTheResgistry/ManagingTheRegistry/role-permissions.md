# Role Permissions

When you select a collection in the registry, the **Permissions** panel opens with the defined role permissions available. It allows you to specify which role has access to perform which operations on a registry resource or a collection.

#### Adding new role permissions

1.  In the **New Role Permissions** section, select a role from the drop-down list. This list is populated by all user roles configured in the system.
    ![]({{base_path}}/assets/attachments/126562645/126562646.png)

        !!! info
    The `wso2.anonymous.role` is a special role that represents a user who is not logged in to the management console. Granting `Read` access to this role means that you do not require authentication to access resources using the respective Permalinks.

    The **`everyone`** role is a special role that represents a user who is logged into the management console. Granting `Read` access to this role means that any user who has logged into the management console with sufficient permissions to access the Resource Browser can read the respective resource. Granting `Write` or `Delete` access means that any user who is logged in to the management console with sufficient permissions to access the Resource Browser can make changes to the respective resource.


2.  Select one of the following actions:

    -   **Read**
    -   **Write**
    -   **Delete**
    -   **Authorize** - A special permission that gives a role the ability to grant and revoke permissions to/from others

3.  Select whether to allow the action or deny and click **Add Permission** . For example
    ![]({{base_path}}/assets/attachments/126562645/126562647.png)

        !!! info
`Deny` permissions have higher priority over `Allow.` That is, a `Deny` permission always overrides an `Allow` permission assigned to a role.

`Deny` permission must be given at the collection level. For example, to deny the write/delete action on a given policy file, set Write/Delete actions for the role to `Deny` in `/trunk/policies` . If you set the `Deny` permission beyond the collection level (e.g., / or /\_system etc.) it will not be applied for the user's role.


4.  The new permission appears in the list.
    ![]({{base_path}}/assets/attachments/126562645/126562648.png) From here, you can edit the permissions by selecting and clearing the check boxes. After editing the permissions, click **Apply All Permissions** to save the alterations.

