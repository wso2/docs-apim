# Configuring Identity Server as External IDP using OIDC

WSO2 API Manager uses the OIDC Single Sign-On feature by default. This document explains how to connect WSO2 Identity Server (or WSO2 Identity Server as a Keymanager) as a third party Identity provider to API-Manager.

## prerequisites

-   Download the API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
-   Download the Identity Server distribution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For **testing purposes** if you want to run both the WSO2 API Manager and WSO2 Identity Server on the same server, go to the `<IS_HOME>/repository/conf/deployment.toml` file and offset the port by 1 as by adding following configuration:

        ``` toml
        [server]
        offset=1
        ```

-   Start the servers using the following commands:

    === "On Windows"
        ```
        wso2server.bat --run
        ```

    === "On Linux/Mac OS"
        ```
        sh wso2server.sh
        ```

## Configure the Identity Server

### Step - 1 Configure the Service Provider

1.  Sign in to the Management Console of WSO2 IS by browsing the following URL:  

    ```
    https://{is-ip}:9444/console
    ```

2.  Create a Service Provider:

    a.  Go to **Applications** → **New Application** and select **Traditional Web Application**.

    b.  In the popup, provide the following details and click **Create**:

    <table>
        <tbody>
            <tr>
                <td>Protocol</td>
                <td>OpenID Connect</td>
            </tr>
            <tr>
                <td>Authorized Redirect URL</td>
                <td>https://localhost:9443/commonauth</td>
            </tr>
        </tbody>
     </table>

    [![Create Traditional Web Application]({{base_path}}/assets/img/setup-and-install/create-traditional-web-app.png)]({{base_path}}/assets/img/setup-and-install/create-traditional-web-app.png)

    c.  In the configuration page, select **User Attributes** and enable the **Groups** attribute.

    [![Select Groups user attribute]({{base_path}}/assets/img/setup-and-install/select-groups-attribute.png)]({{base_path}}/assets/img/setup-and-install/select-groups-attribute.png)

    d.  In the same tab, under the **Subject** section, select **Assign alternate subject identifier** and from the dropdown list select **Username**.

    [![Assign alternate subject identifier]({{base_path}}/assets/img/setup-and-install/assign-alternate-subject-identifier.png)]({{base_path}}/assets/img/setup-and-install/assign-alternate-subject-identifier.png)

    e.  Under the **Protocol** tab, copy the **Client ID** and **Client Secret**.

### Step - 2 Create users and roles

1. Create the required [users](https://is.docs.wso2.com/en/latest/guides/users/onboard-users/) and [groups](https://is.docs.wso2.com/en/latest/guides/users/manage-groups/) in Identity Server. Assume, following users are created in Identity Servers with the given groups.

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

## Configure the API Manager

### Step - 1 Import the Identity Server Certificate to WSO2 API Manager

Import the Keymanager certificate to the WSO2 API Manager `client-truststore.jks` using the following steps.

1.  Export the WSO2 IS certificate.

    === "On Mac/Linux"
        ```bash
        echo -n | openssl s_client -connect localhost:9444 -servername wso2is7 | openssl x509 > is7.cert
        ```

    === "On Windows"
        ```bash
        openssl s_client -connect localhost:9444 -servername wso2is7 < NUL | openssl x509 > is7.cert
        ```

2.  Import this certificate to the `client-truststore.jks` located in `<AM_HOME>/repository/resources/security/`.

    ```bash
    keytool -import -alias wso2is7cert -file is7.cert -keystore client-truststore.jks -storepass wso2carbon
    ```

### Step - 2 Configure the Identity Provider

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
                <tr>
                    <td>Scopes</td>
                    <td>openid groups</td>
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

### Step - 3 Configure the Service Provider

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
