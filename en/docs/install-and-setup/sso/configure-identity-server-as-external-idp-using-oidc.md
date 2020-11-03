# Configure Identity Server as External IDP using OIDC

WSO2 API Manager uses the OpenID Connect Single Sign-On (OIDC SSO) feature by default. This document explains how to connect WSO2 Identity Server (or WSO2 IS-KM) as a third party Identity Provider to API-Manager.

## Prerequisites

1. Download the API Manager 3.0.0 distribution.
     1. Access the [previous WSO2 API Manager related releases](https://wso2.com/api-management/previous-releases/).
     2. Select version 3.0.0.
     3. Download the API Manager.

2. Download the Identity Server 5.9.0 distribution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For **testing purposes** if you want to run both the WSO2 API Manager and WSO2 Identity Server on the same server, then you can go to the `<IS_HOME>/repository/conf/deployment.toml` file and offset the port by 1 by adding the following configuration:

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

## Step 1 - Configure the Identity Server

### Step 1.1 - Configure the Service Provider

1.  Sign in to the Management Console of IS server by browsing the following URL:  

    ```
    https://{is-ip}:9444/carbon
    ```

2.  Navigate to the **Service Providers** section under **Main** → **Identity** and create a new Service Provider.

3.  Edit the created Service Provider:

    1. Expand the **Claim Configuration** section and add **http://wso2.org/claims/role** as a mandatory claim.

        [![Claim Configuration in Service Provider]({{base_path}}/assets/img/setup-and-install/claim-configuration-in-service-provider.png)]({{base_path}}/assets/img/setup-and-install/claim-configuration-in-service-provider.png)

    2. Expand the **Inbound Authentication Configuration** section and configure the **OAuth/OpenID Connect Configuration** with the callback URL - `https://{apim-ip}:9443/commonauth`

    3. Update the Service Provider configurations.

### Step 1.2 - Create users and roles

1. Create the required users and roles in Identity Server. Assume that the following users are created in the Identity Servers with the given roles.

    <table>
        <thead>
            <tr>
                <th><b>User</b></th>
                <th><b>Role</b></th>
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

## Step 2 - Configure the API Manager

<a name="step21"></a>

### Step 2.1 - Configure the Identity Provider

1.  Sign in to the Management Console of API Manager. 

    ```
    https://{apim-ip}:9443/carbon
    ```

2.  Navigate to the **Identity Providers** section under **Main** → **Identity** and create a new Identity Provider.

    1. Expand the **Federated Authenticators** section and add the following configurations under the **OAuth2/OpenIDConnect Configuration** section:

        <table>
            <tbody>
                <tr>
                    <td>Enable OAuth2/OpenIDConnect</td>
                    <td>True</td>
                </tr>
                <tr>
                    <td>Client Id</td>
                    <td>Client ID of the Service Provider created in the Identity Server.</td>
                </tr>
                <tr>
                    <td>Client Secret</td>
                    <td>Client Secret of the Service Provider created in the Identity Server.</td>
                </tr>
                <tr>
                    <td>Authorization Endpoint URL</td>
                    <td><code>https://is.wso2.com:9444/oauth2/authorize</code></td>
                </tr>
                <tr>
                    <td>Token Endpoint URL</td>
                    <td><code>https://is.wso2.com:9444/oauth2/token</code></td>
                </tr>
                <tr>
                    <td>Callback Url</td>
                    <td><code>https://apim.wso2.com:9443/commonauth</code></td>
                </tr>
                <tr>
                    <td>Userinfo Endpoint URL</td>
                    <td><code>https://is.wso2.com:9444/oauth2/userinfo</code></td>
                </tr>
                <tr>
                    <td>Logout Endpoint URL</td>
                    <td><code>https://is.wso2.com:9444/oidc/logout</code></td>
                </tr>
            </tbody>
        </table>

         The following image shows the sample values for the OAuth2/OpenIDConnect Configurations:

         [![Identity Provider Configuration for SSO]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-sso.png)

    2.  Enable Just-in-Time Provisioning to provision the users in API Manager: 

        [![JIT provisioning for SSO]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)

    3.  Add the following role mapping under the **Role Configuration** section:
        <table>
        <thead>
            <tr>
                <th><b>Identity Server Roles</b></th>
                <th><b>Roles Mapped in API Manager</b></th>
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

         [![Role mapping for SSO]({{base_path}}/assets/img/setup-and-install/role-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/role-configuration-for-sso.png)

        !!! Tip
            Instead of using the default internal roles, you can also create new roles in API Manager and map it to the provisioned users. 

### Step 2.2 - Configure the Service Provider

1.  Navigate to the **Service Providers** section and list the Service Providers. 

     There are two Service Providers created for the Publisher Portal and Developer Portal that are named as `apim_publisher` and `apim_devportal`. Edit the `apim_publisher` Service Provider.

    !!! Attention
        You need to sign in to the Developer Portal and Publisher at least once for the two Service Providers to appear because it is created during the first login.

2.  Expand the **Local & Outbound Authentication Configuration** section, select **Federated Authentication** as Authentication Type, select the name of the Identity Provider you created in <a href="#step21">Step 2.1</a>, and click **Update**. 

    [![Local and outbound authentication configuration for SSO]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration.png)]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration.png)

3.  Repeat the same step for the `apim_devportal` Service Provider as well.

Now you will be able to sign in to Publisher and Developer Portal using the users in WSO2 Identity Server.

!!! Tip "Troubleshooting"
    When using the Identity Server as an external IdP, the following error can be observed in API Manager, when signing in to the Portals. 

    ``` code
    invalid_request, The client MUST NOT use more than one authentication method in each
    ```

    This is because the MutualTLS authenticator is enabled by default from IS 5.8.0 onwards. As the OIDC specification does not allow the use of more than one authentication, the login fails with the above error. In order to resolve this issue, add the following configuration in the `deployment.toml` resides in `<IS_HOME>/repository/conf` directory to disable the MutualTLS authenticator in IS.
    
    ``` toml
    [[event_listener]]
    id = "mutual_tls_authenticator"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.carbon.identity.oauth2.token.handler.clientauth.mutualtls.MutualTLSClientAuthenticator"
    order = "158"
    enable = false
    ```
