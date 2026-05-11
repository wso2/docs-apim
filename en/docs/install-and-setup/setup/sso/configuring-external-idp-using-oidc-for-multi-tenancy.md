# Configure External IdP using OIDC for Multi-Tenancy

WSO2 API Manager use OIDC SSO by default. Doc show how connect WSO2 Identity Server (or WSO2 IS as Key Manager) as third-party IdP to API Manager for multi-tenant flows.

!!! Note
    No multi-tenancy needed? Follow this doc: [Configure Identity Server as External IdP using OIDC](./configuring-identity-server-as-external-idp-using-oidc.md).

## Prerequisites

-   Download API Manager from [https://wso2.com/api-management/](https://wso2.com/api-management/).
-   Download Identity Server from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For **testing**, run APIM + IS on same machine. Open `<IS_HOME>/repository/conf/deployment.toml`, offset port by 1:

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

3.  Click **New Root Organization**. Fill form to create new org.

    [![IS 7 register new org]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/is-register-new-org.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/is-register-new-org.png)

4.  Log into new org: `https://localhost:9444/t/asd.com/console`.

    !!! Note
        `asd.com` is sample tenant domain. Replace with real tenant domain.

### Step 2 - Configure Service Provider

1.  Create Service Provider:

    a.  Go to **Applications** → **New Application** → select **Traditional Web Application**.

    b.  In popup, fill below and click **Create**:

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

    c.  On config page, select **User Attributes**. Enable **Groups** attribute.

    [![Select Groups user attribute]({{base_path}}/assets/img/setup-and-install/select-groups-attribute.png)]({{base_path}}/assets/img/setup-and-install/select-groups-attribute.png)

    d.  Same tab, under **Subject**, select **Assign alternate subject identifier**. Pick **Username** from dropdown.

    [![Assign alternate subject identifier]({{base_path}}/assets/img/setup-and-install/assign-alternate-subject-identifier.png)]({{base_path}}/assets/img/setup-and-install/assign-alternate-subject-identifier.png)

    e.  Under **Protocol** tab, copy **Client ID** + **Client Secret**.

    !!! Info
        Create new application for each tenant.

### Step 3 - Create Users and Roles

1.  Create required [users](https://is.docs.wso2.com/en/latest/guides/users/onboard-users/) and [groups](https://is.docs.wso2.com/en/latest/guides/users/manage-groups/) in IS. Assume below users created with given groups:

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
    Enable tenant synchronization to create IS tenants on APIM side. Follow [enable tenant synchronization](../../../administer/multitenancy/tenant-sharing-with-wso2is7.md). Outside scope of this doc.

### Step 1 - Import IS Certificate to WSO2 API Manager

Import Key Manager certificate to APIM `client-truststore.jks`:

1.  Export WSO2 IS certificate:

    === "On Mac/Linux"
        ```bash
        echo -n | openssl s_client -connect localhost:9444 -servername wso2is7 | openssl x509 > is7.cert
        ```

    === "On Windows"
        ```bash
        openssl s_client -connect localhost:9444 -servername wso2is7 < NUL | openssl x509 > is7.cert
        ```

2.  Import cert to `client-truststore.jks` in `<AM_HOME>/repository/resources/security/`:

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

    -   Purpose: capture tenant details, proxy tenant-specific users to right service providers in their tenants. Also handle `carbon.super` tenant users.
    -   Log in to carbon portal (`https://{apim-ip}:9443/carbon`) as admin.
    -   Left nav → **Identity Providers** → click **Add**.
    -   Add below claim mapping under **Claim Configuration**:

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

        Select **groups** as **Role Claim URI**.

    [![Claim mapping for sso]({{base_path}}/assets/img/setup-and-install/claim-mapping-for-sso.png)]({{base_path}}/assets/img/setup-and-install/claim-mapping-for-sso.png)

    -   Add below role mapping under **Role Configuration**:

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

        [![]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)

        !!! Tip
            Instead of default internal roles, create new roles in API Manager and map to provisioned users.

    -   Select **Multi Tenant Authenticator Configuration** under **Federated Authenticators**:

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
                <td>Set true to enable authenticator.</td>
            </tr>
            <tr>
                <td>Tenant Selection Page URL</td>
                <td>`https://{apim-ip}:9443/select-tenant/`</td>
                <td>Customize as needed. Default page lives at this URL.</td>
            </tr>
            <tr>
                <td>Common Service Provider Name</td>
                <td>`commonsp`</td>
                <td>Create service provider with this name in each tenant (including super tenant).</td>
            </tr>
            <tr>
                <td>Scopes</td>
                <td>openid</td>
                <td></td>
            </tr>
        </tbody>
        </table>

        Other fields self-explanatory. See image below if unclear.

        [![Multi Tenant Authenticator Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-authenticator-configs.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-authenticator-configs.png)

    -   Enable **Just-in-Time Provisioning** to provision users in API Manager:

        [![]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)

    -   Click **Register** to save.

### Step 4 - Configure Common Service Provider

-   Left nav → **Service Providers** → click **Add**.
-   SP name must match **Common Service Provider Name** set in super tenant IdP.

    [![Multi Tenant Common SP]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-common-sp.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-common-sp.png)

-   Configure claim settings to pass user details to super tenant custom authenticator:
    -   Expand **Claim Configuration** → **Basic Claim Configuration**.
    -   In **Requested Claims**, click **Add Claim URI**. Add below:
        -   `http://wso2.org/claims/username`
        -   `http://wso2.org/claims/roles`
    -   Select `http://wso2.org/claims/username` as **Subject Claim URI**.

    [![Multi Tenant SP Claim Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-claim-configs.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-claim-configs.png)

-   Expand **Inbound Authentication Configurations** → **OAuth/OpenID Connect Configuration** → click **Configure**. Set **Callback URL** to `https://localhost:9443/commonauth`. Click **Update**.

    [![Multi Tenant SP OIDC Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-oidc-config.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-oidc-config.png)

-   Expand **Local & Outbound Authentication Configurations**. Select previously created IdP as **Federated Authenticator**. Check below configs:

    [![Multi Tenant SP Outbound Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-outbound-configs.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-sp-outbound-configs.png)

### Step 5 - Configure Tenanted IdP

-   Log in to carbon portal as tenant admin.
-   Repeat [Step 3](#step-3-configure-federated-authenticators). But this time pick **OAuth2/OpenID Connect Configuration** instead of **Multi Tenant Authenticator Configuration**.

    !!! Info
        Connect to IS tenanted application created in [first section](#step-2-configure-service-provider).

### Step 6 - Configure Tenanted Common Service Provider

-   Repeat [Step 4](#step-4-configure-common-service-provider).

### Step 7 - Configure IdP for Portals

-   In carbon portal, log in as super admin again.
-   Click **List** under **Service Providers**.
-   See `apim_devportal`, `apim_publisher`, `apim_admin_portal` service providers.
-   Click **Edit** on one of them. Expand **Local & Outbound Authentication Configuration**.
-   Select **Federated Authentication** under **Authentication Type**. Pick created IdP (`WSO2_IS7`).
-   Tick **Assert identity using mapped local subject identifier**. Mandatory for role mapping to work.

    [![Multi Tenant Portal SPs Configs]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-portal-sps.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/multi-tenant-portal-sps.png)

## Verify the Configuration

-   Go to publisher portal `https://{apim-ip}:9443/publisher`. Tenant selection page show up.

    [![Tenant Selection Page]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/tenant-selection-page.png)]({{base_path}}/assets/img/setup-and-install/multi-tenant-sso/tenant-selection-page.png)

!!! Tip
    This approach is not limited to WSO2 IS 7.x. Connect any third-party IdP that speak OIDC with this method — Keycloak, Okta, Azure AD, ForgeRock, etc.
