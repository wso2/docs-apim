# Configure External IdP using OIDC for Multi-Tenancy

WSO2 API Manager uses OIDC SSO by default. This guide explains how to connect WSO2 Identity Server (or WSO2 IS as Key Manager) as a third-party IdP to API Manager for multi-tenant flows.

!!! Note
    If you do not require multi-tenancy support, refer to [Configure Identity Server as External IdP using OIDC](./configuring-identity-server-as-external-idp-using-oidc.md).

## Prerequisites

-   Download API Manager from [https://wso2.com/api-management/](https://wso2.com/api-management/).
-   Download Identity Server from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For testing, you can run API Manager and Identity Server on the same machine. Open `<IS_HOME>/repository/conf/deployment.toml` and offset the port by 1:

        ``` toml
        [server]
        offset=1
        ```

-   Start servers:

    === "On Windows"
        ```
        wso2server.bat --run
        ```

    === "On Linux/Mac OS"
        ```
        sh wso2server.sh
        ```

## Configure Identity Server

### Step 1 - Create New Organization

1.  Sign in to WSO2 IS Management Console:

    ```
    https://{is-ip}:9444/console
    ```

2.  Click **Root Organization** → **Manage Root Organization**.

    [![IS 7 dashboard]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/is-create-new-org.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/is-create-new-org.png)

3.  Click **New Root Organization** and fill in the form to create a new organization.

    [![IS 7 register new org]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/is-register-new-org.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/is-register-new-org.png)

4.  Log in to the new organization at `https://localhost:9444/t/asd.com/console`.

    !!! Note
        `asd.com` is a sample tenant domain. Replace it with your actual tenant domain.

### Step 2 - Configure Service Provider

1.  Create a service provider:

    a.  Go to **Applications** → **New Application** and select **Traditional Web Application**.

    b.  In the pop-up, fill in the following and click **Create**:

    <table>
        <tbody>
            <tr>
                <td>Protocol</td>
                <td>OpenID Connect</td>
            </tr>
            <tr>
                <td>Authorized Redirect URL</td>
                <td>https://localhost:9443/t/asd.com/commonauth</td>
            </tr>
        </tbody>
     </table>

    [![Create Traditional Web Application]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/create-traditional-web-app-tenant.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/create-traditional-web-app-tenant.png)

    c.  On the configuration page, select **User Attributes** and enable the **Groups** attribute.

    [![Select Groups user attribute]({{base_path}}/assets/img/setup-and-install/select-groups-attribute.png)]({{base_path}}/assets/img/setup-and-install/select-groups-attribute.png)

    d.  On the same tab, under **Subject**, select **Assign alternate subject identifier** and choose **Username** from the dropdown.

    [![Assign alternate subject identifier]({{base_path}}/assets/img/setup-and-install/assign-alternate-subject-identifier.png)]({{base_path}}/assets/img/setup-and-install/assign-alternate-subject-identifier.png)

    e.  Under the **Protocol** tab, copy the **Client ID** and **Client Secret**.

    !!! Info
        Create a new application for each tenant.

### Step 3 - Create Users and Roles

1.  Create the required [users](https://is.docs.wso2.com/en/latest/guides/users/onboard-users/) and [groups](https://is.docs.wso2.com/en/latest/guides/users/manage-groups/) in WSO2 IS. For this guide, assume the following users are created with the given groups:

    <table>
        <thead>
            <tr>
                <th>User</th>
                <th>Groups</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Sam</td>
                <td>publisher</td>
            </tr>
            <tr>
                <td>Karen</td>
                <td>devportal</td>
            </tr>
        </tbody>
    </table>

## Configure API Manager

!!! Note
    To create the IS tenants on the API Manager side, enable tenant synchronization by following the [enable tenant synchronization](../../../administer/multitenancy/tenant-sharing-with-wso2is7.md) guide. This is outside the scope of this document.

### Step 1 - Import IS Certificate to WSO2 API Manager

Import the Key Manager certificate to the API Manager `client-truststore.jks`:

1.  Export the WSO2 IS certificate:

    === "On Mac/Linux"
        ```bash
        echo -n | openssl s_client -connect localhost:9444 -servername wso2is7 | openssl x509 > is7.cert
        ```

    === "On Windows"
        ```bash
        openssl s_client -connect localhost:9444 -servername wso2is7 < NUL | openssl x509 > is7.cert
        ```

2.  Import the certificate to `client-truststore.jks` in `<AM_HOME>/repository/resources/security/`:

    ```bash
    keytool -import -alias wso2is7cert -file is7.cert -keystore client-truststore.jks -storepass wso2carbon
    ```

### Step 2 - `deployment.toml` Changes

```toml
[tenant_context]
enable_tenant_qualified_urls = true
enable_tenanted_sessions = true
skip_tenant_validation_for_oauth_endpoints = true
session_manager= "org.apache.catalina.session.StandardManager"

[event.default_listener.jit_provisioning_handler]
enable = false

[[event_listener]]
id = "org_jit_provisioning_handler"
type="org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
name = "org.wso2.carbon.identity.outbound.organization.auth.OrganizationJITProvisioningHandler"
# Same value as "event.default_listener.jit_provisioning_handler.priority": "20",
order = 20

[[resource.access_control]]
context = "(.*)/select-tenant(.*)"
secure = false
http_method = "all"

```
<table>
    <thead>
        <tr>
            <th>Config</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>tenant_context.enable_tenant_qualified_urls</td>
            <td>Enable tenant-qualified URLs.</td>
        </tr>
        <tr>
            <td>tenant_context.enable_tenanted_sessions</td>
            <td>Enable tenanted sessions.</td>
        </tr>
        <tr>
            <td>tenant_context.skip_tenant_validation_for_oauth_endpoints</td>
            <td>Enable if using resident key manager.</td>
        </tr>
        <tr>
            <td>tenant_context.session_manager</td>
            <td>Skip if using external key manager.</td>
        </tr>
        <tr>
            <td>event.default_listener.jit_provisioning_handler.enable</td>
            <td>Disable default JIT provisioning handler.</td>
        </tr>
        <tr>
            <td>event_listener</td>
            <td>Add custom JIT provisioning handler.</td>
        </tr>
        <tr>
            <td>resource.access_control</td>
            <td>Whitelist tenant selection page.</td>
        </tr>
    </tbody>
</table>

### Step 3 - Configure Federated Authenticators

1.  Configure Super Tenant IdP.

    -   This IdP captures tenant details and proxies tenant-specific users to the correct service providers in their respective tenants. It also handles `carbon.super` tenant users.
    -   Log in to the carbon portal (`https://{apim-ip}:9443/carbon`) as the admin.
    -   In the left navigation panel, expand **Identity Providers** and click **Add**.
    -   Add the following claim mapping under **Claim Configuration**:

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

    -   Add the following role mapping under **Role Configuration**:

        <table>
        <thead>
            <tr>
                <th>Identity Server Roles</th>
                <th>Roles Mapped in API Manager</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>devportal</td>
                <td>Internal/Subscriber</td>
            </tr>
            <tr>
                <td>publisher</td>
                <td>Internal/publisher</td>
            </tr>
        </tbody>
        </table>

        [![Role mapping configuration for SSO]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)

        !!! Tip
            Instead of using the default internal roles, you can also create new roles in API Manager and map them to the provisioned users.

    -   Select **Multi-Tenant Authenticator Configuration** under **Federated Authenticators**:

        <table>
        <thead>
            <tr>
                <th>Configuration</th>
                <th>Value</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Enable</td>
                <td>true</td>
                <td>Set to true to enable the authenticator.</td>
            </tr>
            <tr>
                <td>Tenant Selection Page URL</td>
                <td>`https://{apim-ip}:9443/select-tenant/`</td>
                <td>Customize as needed. The default tenant selection page is available at this URL.</td>
            </tr>
            <tr>
                <td>Common Service Provider Name</td>
                <td>`commonsp`</td>
                <td>Create a service provider with this name in each tenant (including the super tenant).</td>
            </tr>
            <tr>
                <td>Scopes</td>
                <td>openid groups</td>
                <td></td>
            </tr>
        </tbody>
        </table>

        The remaining fields are self-explanatory. Refer to the image below if anything is unclear.

        [![Multi Tenant Authenticator Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-authenticator-configs.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-authenticator-configs.png)

    -   Enable **Just-in-Time Provisioning** to provision users into API Manager:

        [![JIT provisioning configuration for SSO]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)

    -   Click **Register** to save the configuration.

### Step 4 - Configure Common Service Provider

-   In the left navigation panel, expand **Service Providers** and click **Add**.
-   The service provider name must match the **Common Service Provider Name** configured in the super tenant IdP.

    [![Multi Tenant Common SP]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-common-sp.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-common-sp.png)

-   Configure the claim settings to pass user details to the super tenant custom authenticator:
    -   Expand **Claim Configuration** → **Basic Claim Configuration**.
    -   In **Requested Claims**, click **Add Claim URI** and add the following:
        -   `http://wso2.org/claims/username`
        -   `http://wso2.org/claims/roles`
    -   Select `http://wso2.org/claims/username` as **Subject Claim URI**.

    [![Multi Tenant SP Claim Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-claim-configs.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-claim-configs.png)

-   Expand **Inbound Authentication Configurations** → **OAuth/OpenID Connect Configuration** and click **Configure**. Set the **Callback URL** to `https://localhost:9443/commonauth` and click **Update**.

    [![Multi Tenant SP OIDC Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-oidc-config.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-oidc-config.png)

-   Expand **Local & Outbound Authentication Configurations** and select the previously created IdP as the **Federated Authenticator**. Verify the configurations as shown below:

    [![Multi Tenant SP Outbound Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-outbound-configs.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-outbound-configs.png)

### Step 5 - Configure Tenanted IdP

-   Log in to the carbon portal as the tenant admin.
-   Repeat [Step 3](#step-3-configure-federated-authenticators), but this time select **OAuth2/OpenID Connect Configuration** instead of **Multi-Tenant Authenticator Configuration**.

    !!! Info
        When configuring the federated authenticator for the tenant IdP, use the **Client ID** and **Client Secret** of the tenant-specific service provider you created in WSO2 IS in [Step 2 - Configure Service Provider](#step-2-configure-service-provider). This ensures that authentication requests from the tenant are routed to the corresponding tenant application in WSO2 IS.

### Step 6 - Configure Tenanted Common Service Provider

-   Repeat [Step 4](#step-4-configure-common-service-provider).

### Step 7 - Configure IdP for Portals

-   Log in to the carbon portal as the super admin.
-   Navigate to the **Service Providers** section and click **List**. You will see three service providers created for the Developer Portal, Publisher, and Admin Portal named `apim_devportal`, `apim_publisher`, and `apim_admin_portal` respectively.

    !!! Attention
        You will have to log into the Developer Portal, Publisher, and Admin Portal at least once for the service providers to appear, as they are created during first login.

-   Click **Edit** on one of them and expand the **Local & Outbound Authentication Configuration** section.
-   Select **Federated Authentication** as the **Authentication Type** and select the IdP you created (`WSO2_IS7`).
-   Select **Assert identity using mapped local subject identifier**. This is mandatory for role mapping to work.

    [![Portal service provider configuration for SSO]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-portal-sps.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-portal-sps.png)

-   Repeat the same steps for the remaining service providers.

## Verify the Configuration

-   Navigate to the Publisher portal at `https://{apim-ip}:9443/publisher`. The tenant selection page should appear.

    [![Tenant Selection Page]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/tenant-selection-page.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/tenant-selection-page.png)

!!! Tip
    This approach is not limited to WSO2 IS 7.x. You can use the same method to connect any third-party IdP that supports OIDC, such as Keycloak, Okta, Azure AD, or ForgeRock.
