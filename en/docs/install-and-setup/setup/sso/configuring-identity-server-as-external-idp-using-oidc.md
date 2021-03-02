# Configuring Identity Server as External IDP using OIDC

WSO2 API Manager uses the OIDC Single Sign-On feature by default. This document explains how to connect WSO2 Identity Server (or WSO2 Identity Server as a Keymanager) as a third party Identity provider to API-Manager.

## Pre-requisites

-   Download the API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
-   Download the Identity Server distirbution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For **testing purposes** if you want to run both the WSO2 API Manager and WSO2 Identity Server on the same server, go to the `<IS_HOME>/repository/conf/deployment.toml` file and offset the port by 1 as by adding following configuration:

        ``` toml
        [server]
        offset=1
        ```

-   Start the servers using the following commands:

    ``` tab="On Windows"
    wso2server.bat --run
    ```

    ``` tab="On Linux/Mac OS"
    sh wso2server.sh
    ```

## Configure the Identity Server

### Step - 1 Configure the Service Provider

1.  Sign in to the Management Console of WSO2 IS by browsing the following URL:  

    ```
    https://{is-ip}:9444/carbon
    ```

2.  Navigate to the **Service Providers** section under Main → Identity and create new Service Provider.

3.  Edit the created Service Provider:

    1.  Expand the **Claim Configuration** section. Add **http://wso2.org/claims/role** as mandatory claim.

        [![]({{base_path}}/assets/img/setup-and-install/claim-configuration-in-service-provider.png)]({{base_path}}/assets/img/setup-and-install/claim-configuration-in-service-provider.png)

    2.  Expand the **Inbound Authentication Configuration** secition and configure **OAuth/OpenID Connect Configuration** with callback URL - `https://{apim-ip}:9443/commonauth`

        !!! Info "Enable a tenant-specific SSO for the Publisher and Developer Portal"

            To enable a tenant-specific SSO with IS 5.10.0 for Publisher and the Developer Portal, enable the **Use tenant domain in local subject identifier** option under the **Local & Outbound Authentication Configuration** section.

            [![enable-tenant-domain-in-local-sub-identifier]({{base_path}}/assets/img/setup-and-install/local-outbound-config.png)]({{base_path}}/assets/img/setup-and-install/local-outbound-config.png)

        !!! Note "Options available for **Local & Outbound Authentication Configuration** "
            
            -   **Assert identity using mapped local subject identifier** :
                Select this to use the local subject identifier when asserting the identity.
                Note that it is **mandatory** to enable the above option to authorize scopes for provisioned federated users. 
            -   **Always send back the authenticated list of identity providers** : Select this to send back the list of  identity providers that the current user is authenticated by.
            -   **Use tenant domain in local subject identifier** : Select this to append the tenant domain to the local subject identifier.
            -   **Use user store domain in local subject identifier** : Select this to append the user store domain that the user resides to the local subject identifier.
            -   **Use user store domain in roles** : This is selected by default, and appends the userstore domain name to user roles. If you do not want to append the userstore domain name to user roles, clear the check box.

                If a user role is not mapped to a service provider role, and you clear the **Use user store domain in roles** check box, the userstore domain name will be removed from the role claim value unless the userstore domain name is APPLICATION, INTERNAL, or WORKFLOW.

    3. Update the Service Provider configurations.

    !!! Info "In Mutl-tenanted environments"
        Carry out the instruction given below for all the tenants to be able to login to the API-M Web applications in a multi-tenanted environment.

        1.  Click the **SaaS Application** option that appears after registering the service provider.

        [![saas-configuration-in-service-provider]({{base_path}}/assets/img/setup-and-install/saas.png)]({{base_path}}/assets/img/setup-and-install/saas.png) 

        If you do not select the **SaaS Application** option, only users in the current tenant domain will be allowed to login to the portals. You will need to register separate service providers for portals from each tenant.

### Step - 2 Create users and roles

1. Create the required users and roles in Identity Server. Assume, following users are created in Identity Servers with the given roles.

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

## Configure the API Manager

### Step - 1 Configure the Identity Provider

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

### Step - 2 Configure the Service Provider

1.  Navigate to **Service Providers** section and list the Service Providers. There are two service providers created for Publisher portal and Developer portal named as `apim_publisher` and `apim_devportal`. Edit the `apim_publisher` service provider.

    !!! Attention
        You will have to log into the Developer Portal and Publisher at least once for the two service providers to appear as it is created during first login.

2.  Expand the **Local & Outbound Authentication Configuration** section and select **Federated Authentication** as Authentication Type and select the name of the Identity Provider you created in previous step and update.

    [![]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)

3.  Repeat the same step for `apim_devportal` Service Provider as well.

Now you will be able to login to Publisher and Devportal using the users in WSO2 Identity Server.

!!! Tip "Troubleshooting"
    When using Identity Server as external IdP, following error can be observed in API Manager, when logging in to Portals.

    ``` code
        invalid_request, The client MUST NOT use more than one authentication method in each
    ```

    This is because the MutualTLS authenticator is enabled by default in the Identity Server, from version 5.8.0 onwards. Since the OIDC specification does not allow to use more than one authentication, the login fails with the above error. To resolve this issue, add following the configuration in the `deployment.toml` file in the `<IS-Home>/repository/conf` directory to disable the MutualTLS authenticator in the Identity Server.

    ``` toml
    [[event_listener]]
    id = "mutual_tls_authenticator"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.carbon.identity.oauth2.token.handler.clientauth.mutualtls.MutualTLSClientAuthenticator"
    order = "158"
    enable = false
    ```
