# Managing Users

See the topics given below to understand **user management** in the Micro Integrator of EI 7.1.0.

## User credentials in the MI

WSO2 Micro Integrator requires <b>user</b> credentials for <i>authentication</i> and <i>authorization</i> purposes:

-	[Authentication](../../../setup/security/securing_management_api/#authentication-jwt) for internal APIs

	Users accessing the management API and related tools (Micro Integrator dashboard/Micro Integrator CLI) for administration tasks should be authenticated.

-	Authentication for integration use cases

	Some integration use cases require authentication by <b>dynamic username token</b> and similar <b>[WS-Security](../../../references/security/security-implementation)</b> options. If you already have an external RDBMS or LDAP user store with pre-defined roles, you can have role-based authentication for your WS-Security user cases. 

	 User authentication is also required for [securing REST API artifacts](../../../develop/advanced-development/applying-security-to-an-api).

-	[Authorization](../../../setup/security/securing_management_api/#authorization) for internal APIs

	 Certain resources of the management API are protected by <b>authorization</b>. Therefore, users should be granted admin privileges to operate those resources.

### Admin users

Micro Integrator users with admin privileges can manage other users in an [LDAP](../setting_up_a_userstore/#configuring-an-ldap-user-store) or [RDBMS](../setting_up_a_userstore/#configuring-an-rdbms-user-store) user store that is connected to the Micro Integrator server. These user management tasks include <b>viewing</b>, <b>adding</b>, and <b>removing</b> users.

!!! Tip
	Admin users can basically access any resource (of the Micro Integrator's management API) that has <b>authorization</b> previliges enabled. By default, only the `users` resource of the management API allows authorization, which allows an admin to perform user management. 

	Read more about about [authorization in the management API](../../../setup/security/securing_management_api/#authorization).

If a user with admin privileges does not exist in your user store, the admin credentials will be created when you invoke the Micro Integrator's [management API](../../../administer-and-observe/working-with-management-api) for the first time. That is, when you log in to the Micro Integrator server from the <b>CLI tool</b>/<b>dashboard</b>, or directly invoke the management API, the user credentials you use will get stored in the user store and admin privileges will be assigned.

An existing admin user can log in to the Micro Integrator server from the CLI tool or the dashboard to add new users with admin privileges. An admin user can only be removed by the creator.

### Non-admin users

Users that do not have admin privileges can access the management API, the CLI, and the dashboard to view and monitor integration artifacts and logs.

## Managing users from the CLI

See the [Micro Integrator CLI documentation](../../../administer-and-observe/using-the-command-line-interface) to set up the tool. Be sure to log in to the Micro Integrator server (from the CLI) with your admin user name and password.

Use the [mi user](../../../administer-and-observe/using-the-command-line-interface/#mi-user) option in the CLI with the required commands as shown in the following examples:

```bash
# To add a new user.
mi user add [new user-id] [password] [is-admin]

# To remove a user
mi user remove [user-id]

# To list all the users
mi user show

# To list user by user ID
mi user show [user ID]

# To list users by user role
mi user show -r [role name]

# To list users matching a user name regex pattern
mi user show -p [user name regex pattern]
```

## Managing users from the Dashboard

See the [Micro Integrator Dashboard documentation](../../../administer-and-observe/working-with-monitoring-dashboard) to set up the dashboard. Be sure to log in to the Micro Integrator server (from the dashboard) with your admin user name and password.

Select <b>Users</b> in the left-hand navigator and use the <b>Users</b> tab to view the list of existing users. You can also delete other users (non-admin users and admin users created by you). 

<img src="../../../assets/img/monitoring-dashboard/dashboard-users-1.png" width="700">

Go to the <b>Add User</b> tab to create new users. Note that you can assign admin privileges during the creation.

<img src="../../../assets/img/monitoring-dashboard/dashboard-users-2.png" width="700">
