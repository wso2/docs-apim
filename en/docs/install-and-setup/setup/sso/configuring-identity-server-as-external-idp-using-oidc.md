# Configuring Identity Server as External IDP using OIDC

WSO2 API Manager uses the OIDC Single Sign-On feature by default. This document explains how to connect WSO2 Identity Server 7.x as a third party Identity provider to API-Manager.

!!! info
    This document provides instructions on configuring **WSO2 Identity Server 7.x** as an external IDP. If you are using an older version of WSO2 Identity Server, the configuration steps may differ as older versions use the Management Console instead of the Console application.

## Prerequisites

-   Download the API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
-   Download the WSO2 Identity Server 7.x distribution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For **testing purposes** if you want to run both the WSO2 API Manager and WSO2 Identity Server on the same server, go to the `<IS_HOME>/repository/conf/deployment.toml` file and offset the port by 1 as by adding following configuration:

        ``` toml
        [server]
        offset=1
        ```

-   Start the APIM server using the following command:

    === "On Windows"
        ```
        api-manager.bat --run
        ```

    === "On Linux/Mac OS"
        ```
        sh api-manager.sh
        ```

-   Start the IS server using the following command:

    === "On Windows"
        ```
        wso2server.bat --run
        ```

    === "On Linux/Mac OS"
        ```
        sh wso2server.sh
        ```

## Configure the Identity Server

### Step 1 - Configure the application

1.  Sign in to the WSO2 IS Console by browsing the following URL:  

    ```
    https://{is-ip}:9444/console
    ```

2.  Navigate to **Applications** and click **New Application**.

3.  Select **Traditional Web Application** and complete the required information.

4.  Set the **Authorized redirect URLs** to `https://{apim-ip}:9443/commonauth` (for example, `https://localhost:9443/commonauth`).

5.  Click **Register** to create the application.

6.  After the application is created, navigate to the **Protocol** tab and note down the **Client ID** and **Client Secret** for later use.

7.  Navigate to the **User Attributes** tab:

    1.  Under the **Roles** section, click **Add** and select the **roles** attribute.

    2.  Under the **Subject** section, select **Assign alternate subject identifier** and choose **Username** from the dropdown.

8.  If you want to enable sharing with organizations, navigate to the **Advanced** tab and select the **Allow sharing with organizations** option.

    !!! Info "In multi-tenanted environments"
        To allow users from all tenants to log in to the API Manager web applications in a multi-tenanted environment, you need to enable application sharing across organizations. This is similar to the SaaS Application option in older IS versions.

        If you do not enable organization sharing, only users in the current tenant domain will be allowed to log in to the portals. You will need to register separate applications for portals from each tenant.

### Step 2 - Create users and roles

1. In the WSO2 IS Console, navigate to **User Management** > **Users** and create the required users. For example:
   - `api_publisher`
   - `api_user`

2. Navigate to **User Management** > **Roles** and create application roles. For example:
   - `publisher_role`
   - `user_role`

3. Assign the created roles to the respective users by selecting each role and navigating to the **Users** tab.

    <table>
        <thead>
            <tr>
                <th>User</th>
                <th>Role</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>api_publisher</td>
                <td>publisher_role</td>
            </tr>
            <tr>
                <td>api_user</td>
                <td>user_role</td>
            </tr>
        </tbody>
    </table>

### Step 3 - Configure OIDC scopes

!!! Note
    In WSO2 Identity Server 7.x, the `roles` attribute is automatically included in the OIDC response when configured in the **User Attributes** tab of the application (as done in Step 1). Therefore, no additional OIDC scope configuration is required for the `roles` claim.

## Configure the API Manager

### Step 1 - Configure the Identity Provider

1.  Sign in to the Management Console of API Manager by browsing the following URL: 


    ```
    https://{apim-ip}:9443/carbon
    ```

2.  Navigate to the **Identity Providers** section under Main → Identity and create a new Identity Provider.

    1.  Expand the **Federated Authenticators** section and add the following configurations under **OAuth2/OpenIDConnect Configuration**:

        <table>
            <tbody>
                <tr>
                    <td>Enable OAuth2/OpenIDConnect</td>
                    <td>True</td>
                </tr>
                <tr>
                    <td>Client Id</td>
                    <td>Client Id of the Service Provider created in Identity Server</td>
                </tr>
                <tr>
                    <td>Client Secret</td>
                    <td>Client Secret of the Service Provider created in Identity Server</td>
                </tr>
                <tr>
                    <td>Authorization Endpoint URL</td>
                    <td>https://is.wso2.com:9444/oauth2/authorize</td>
                </tr>
                <tr>
                    <td>Token Endpoint URL</td>
                    <td>https://is.wso2.com:9444/oauth2/token</td>
                </tr>
                <tr>
                    <td>Callback Url</td>
                    <td>https://apim.wso2.com:9443/commonauth</td>
                </tr>
                <tr>
                    <td>Userinfo Endpoint URL</td>
                    <td>https://is.wso2.com:9444/oauth2/userinfo</td>
                </tr>
                <tr>
                    <td>Logout Endpoint URL</td>
                    <td>https://is.wso2.com:9444/oidc/logout</td>
                </tr>
            </tbody>
        </table>

        The following image shows the sample values for OAuth2/OpenIDConnect Configurations:

        [![sp]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-sso.png)

    2.  Enable Just-in-Time Provisioning to provision the users in API Manager:

        [![]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)

    3.  Add the following role mapping under the **Role Configuration** section:
    
        <table>
        <thead>
            <tr>
                <th>Identity Server Roles</th>
                <th>Roles Mapped in API Manager</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>user_role</td>
                <td>Internal/Subscriber</td>
            </tr>
            <tr>
                <td>publisher_role</td>
                <td>Internal/publisher</td>
            </tr>
        </tbody>
        </table>

        [![]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)

        !!! Tip
            Instead of using the default internal roles, you can also create new roles in API Manager and map it to the provisioned users. 

    4. Add the following claim mapping under the **Claim Configuration** section.
        <table>
        <thead>
            <tr>
                <th>Identity Provider Claim URI</th>
                <th>Local Claim URI</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>groups</td>
                <td>http://wso2.org/claims/role</td>
            </tr>
        </tbody>
        </table>
    
        Also select **groups** as the **Role Claim URI**.

    [![Claim mapping for sso]({{base_path}}/assets/img/setup-and-install/claim-mapping-for-sso.png)]({{base_path}}/assets/img/setup-and-install/claim-mapping-for-sso.png)

### Step 2 - Configure the Service Provider

1.  Navigate to **Service Providers** section and list the Service Providers. There are two service providers created for Publisher portal and Developer portal named as `apim_publisher` and `apim_devportal`. Edit the `apim_publisher` service provider.

    !!! Attention
        You will have to log into the Developer Portal and Publisher at least once for the two service providers to appear as it is created during first login.

2.  Expand the **Local & Outbound Authentication Configuration** section and select **Federated Authentication** as Authentication Type and select the name of the Identity Provider you created in previous step and update.

    [![]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)

3.  Repeat the same step for `apim_devportal` Service Provider as well.

Now you will be able to login to Publisher and Devportal using the users in WSO2 Identity Server.

!!! Tip "Troubleshooting"
    When using WSO2 Identity Server 7.x as an external IdP, you might observe the following error in API Manager when logging in to the portals:

    ``` code
        invalid_request, The client MUST NOT use more than one authentication method in each
    ```

    This error occurs because the MutualTLS authenticator may be enabled by default in Identity Server 7.x. Since the OIDC specification does not allow using more than one authentication method, the login fails with this error. 
    
    To resolve this issue, add the following configuration to the `deployment.toml` file in the `<IS7_HOME>/repository/conf` directory to disable the MutualTLS authenticator:

    ``` toml
    [[event_listener]]
    id = "mutual_tls_authenticator"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.carbon.identity.oauth2.token.handler.clientauth.mutualtls.MutualTLSClientAuthenticator"
    order = "158"
    enable = false
    ```
