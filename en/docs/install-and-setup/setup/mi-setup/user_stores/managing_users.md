# Managing Users

See the topics given below to understand **user management** in the Micro Integrator of EI 7.1.0.

## User credentials in the MI

WSO2 Micro Integrator requires <b>user</b> credentials for <i>authentication</i> and <i>authorization</i> purposes:

-	[Authentication]({{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api/#authentication-jwt) for internal APIs

	Users accessing the management API and related tools (Micro Integrator dashboard/Micro Integrator CLI) for administration tasks should be authenticated.

-	Authentication for integration use cases

	Some integration use cases require authentication by <b>dynamic username token</b> and similar <b>[WS-Security]({{base_path}}/reference/mi-security-reference/security-implementation)</b> options. If you already have an external RDBMS or LDAP user store with pre-defined roles, you can have role-based authentication for your WS-Security user cases. 

	 User authentication is also required for [securing REST API artifacts]({{base_path}}/integrate/develop/advanced-development/applying-security-to-an-api).

-	[Authorization]({{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api/#authorization) for internal APIs

	 Certain resources of the management API are protected by <b>authorization</b>. Therefore, users should be granted admin privileges to operate those resources.

### Admin users

Micro Integrator users with admin privileges can manage other users in an [LDAP]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-ldap-user-store) or [RDBMS]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-rdbms-user-store) user store that is connected to the Micro Integrator server. These user management tasks include <b>viewing</b>, <b>adding</b>, and <b>removing</b> users.

!!! Tip
	Admin users can basically access any resource (of the Micro Integrator's management API) that has <b>authorization</b> previliges enabled. By default, only the `users` resource of the management API allows authorization, which allows an admin to perform user management. 

	Read more about about [authorization in the management API]({{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api/#authorization).

If a user with admin privileges does not exist in your user store, the admin credentials will be created when you invoke the Micro Integrator's [management API]({{base_path}}/observe/mi-observe/working-with-management-api) for the first time. That is, when you log in to the Micro Integrator server from the <b>CLI tool</b>/<b>dashboard</b>, or directly invoke the management API, the user credentials you use will get stored in the user store and admin privileges will be assigned.

An existing admin user can log in to the Micro Integrator server from the CLI tool or the dashboard to add new users with admin privileges. An admin user can only be removed by the creator.

### Non-admin users

Users that do not have admin privileges can access the management API, the CLI, and the dashboard to view and monitor integration artifacts and logs.

## Managing users from the CLI

You can use the WSO2 API Controller (APICTL) to view details of users, add new users, and remove users from the user store.

For more information, see [Manage Users]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl/#manage-users)

## Managing users from the Dashboard

See the [Micro Integrator Dashboard documentation]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) to set up the dashboard. Be sure to log in to the Micro Integrator server (from the dashboard) with your admin user name and password.

Select <b>Users</b> in the left-hand navigator to view the list of existing users.

<img src="{{base_path}}/assets/img/integrate/monitoring-dashboard/dashboard-users-1.png">

Click <b>Add User</b> to create new users. Note that you can assign admin privileges during user creation.

<img src="{{base_path}}/assets/img/integrate/monitoring-dashboard/dashboard-users-2.png">
