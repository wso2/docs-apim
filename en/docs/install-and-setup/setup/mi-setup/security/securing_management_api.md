# Securing the Management API

The Management API of WSO2 Micro Integrator is the internal REST API.

The [API Controller]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller) and the [Micro Integrator dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) communicates with this service to
obtain administrative information of the server instance and to perform various administration tasks. If required, you can [directly access the management API]({{base_path}}/observe/mi-observe/working-with-management-api) without using the dashboard or CLI.

See the topics given below information on securing the management API.

## Authentication (JWT)

!!! Info
    User authentication in the management API uses the file-based user store by default. If required, you can configure an [LDAP]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-ldap-user-store) or [RDBMS]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-rdbms-user-store) user store.

JWT-based user authentication is enabled for the management API by default. This ensures that users that log in to the management API or log out will be authenticated.

The following resources of the API handles login and logout:

-       `/login`: This resource is used to obtain a JWT token for the provided user name and password and it is protected by basic auth.
-       `/logout`: This resource is used to revoke the JWT token.

When you [access the management API directly]({{base_path}}/observe/mi-observe/working-with-management-api), you must first acquire a JWT token with your valid username and password. To log out of the management API, this token must be revoked. See [securely invoking the management API]({{base_path}}/observe/mi-observe/working-with-management-api/#securely-invoking-the-api) for more information.

When you use the [Micro Integrator Dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) or the [API Controller]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller), JWT token-based authentication is handled internally.

### Disable user authentication

!!! Note
    The [management API]({{base_path}}/observe/mi-observe/working-with-management-api) and related tools (the [CLI]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller) and the [dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) will not be accessible if authentication is disabled.

If security is **not required**, you can simply disable the handler for the Micro Integrator. Open the `deployment.toml` file (stored in the `MI_HOME/conf/` directory) and add the following configuration:

```toml
[management_api.jwt_token_security_handler]
enable = false
```

### Update token store configurations

Add the following configuration section to the `deployment.toml` file and change the default values.

```toml
[management_api.jwt_token_security_handler]
token_store_config.max_size= "200"
token_store_config.clean_up_interval= "600"
token_store_config.remove_oldest_token_on_overflow= "true"
token_config.expiry= "3600"
token_config.size= "2048"
```

<table>
    <tr>
             <th>Parameter</th>
             <th>Description</th>
    </tr>
    <tr>
          <td><code>max_size</code></td>
         <td>Number of tokens stored in the in memory token store. User can increase or decrease this value accordingly.</td>
    </tr>
    <tr>
          <td><code>clean_up_interval</code></td>
         <td>Token cleanup will be handled through a seperate thread and the frequency of the token clean up can be configured from this setting. This will clean all the expired and revoked security tokens. The thread will run only when there are tokens in the store. If it is empty, the cleanup thread will automatically stop. Interval is specified in seconds.</td>
    </tr>
    <tr>
          <td><code>remove_oldest_token_on_overflow</code></td>
         <td>
                  If set to <code>true</code>, this will remove the oldest accessed token when the token store is full. If it is set to <code>false</code>, the user should either wait until other tokens expire or increase the token store max size accordingly.
         </td>
    </tr>
    <tr>
        <td><code>expiry</code></td>
        <td>This configures the expiry time of the token (specified in seconds).</td>
    </tr>
    <tr>
        <td><code>size</code></td>
        <td>Specifies the key size of the token.</td>
    </tr>
</table>

## Authorization

!!! Note
    Authorization does not apply to users in the default file-based user store. Therefore, be sure to configure an [LDAP]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-ldap-user-store) or [RDBMS]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-rdbms-user-store) user store if you want authorization to be effective.

Authorization can be set for resources that only need to be invoked by admin users. The `/management/users` resource is by default secured with authorization, meaning that only users with admin privileges can access this resource.

### Disable authorization

Add the following to the `deployment.toml` file.

```toml
[management_api.authorization_handler]
enable = false
```

### Enable authorization for other resources
If you want to enable authorization for any resources other than `/users`, open the `deployment.toml` file (stored in
the `MI_HOME/conf/` directory) and add the following:

!!! Tip
    Note that the `/users` resource is secured by default. However, you need to redefine the `/users` resource (as shown below) in cases where you need to customize the resources that need authorization. Failing to do so will remove authorization from the `/users` resource.

```toml
[[management_api.authorization_handler.resources]]
path = "/users"

[[management_api.authorization_handler.resources]]
path = "/apis"
```

## Configuring CORS

CORS is enabled for the management API by default. The default configuration allows all origins (denoted by the `*` symbol). The `Authorization` header is also enabled by default to cater to the functionalities of the the Micro Integrator dashboard.

Add the following to the `deployment.toml` file and update the values.

```toml
[management_api.cors]
enabled = true
allowed_origins = "https://127.0.0.1:9743,https://wso2.com:9743"
allowed_headers = "Authorization"
```
