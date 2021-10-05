User management involves defining and managing users, roles, and their access levels in a system. A user management dashboard or console provides system administrators with a high-level view of a system's active user sessions, their login statuses, the privileges of each user, and their activity in the system. It enables system admins to make business-critical, real-time security decisions. A typical user management implementation involves a wide range of functionality such as adding/deleting users, controlling user activity through permissions, managing user roles, defining authentication policies, managing external user stores and manual/automatic logout, and resetting passwords.

Any user management system has the following basic components:

-   **Users:** Users are consumers who interact with your organizational applications, databases, and other systems. A user can be a person, a device, or another application/program within or outside of the organization's network. Because users interact with internal systems and access data, organizations need to define which data and functionality each user can access by assigning permissions.
-   **Permissions:** A **permission** is a delegation of authority or a right that is assigned to a user or a group of users to perform an action on a system. Permissions can be granted to or revoked from a user, user group, or user role automatically or by a system administrator. For example, if a user has the permission to log in to a system, the permission to log out is automatically granted as well.
-   **User roles:** A **user role** is a grouping of permissions. In addition to assigning individual permissions to users, admins can create user roles and assign those roles to users. For example, you might create user roles called VP, Manager, and Employee, each of which has a different set of permissions, and then assign those roles to users based on their position in the company. Then, if you need to modify the permissions of all your managers, you can simply modify the Manager user role, and all the users with that role will have their permissions updated automatically.

Following sections explain how easily you can manage users and roles using inbuilt user management features provided 
within WSO2 API Manager.

[Managing User Roles]({{base_path}}/administer/managing-users-and-roles/managing-user-roles)

[Managing Users]({{base_path}}/administer/managing-users-and-roles/managing-users)

