# Configuring Identity Server as External IDP using SAML

The Single Sign-On with SAML 2.0 feature in the API Manager is implemented according to the SAML 2.0 browser-based SSO support that is facilitated by WSO2 Identity Server. This feature is available in any WSO2 IS version from 4.1.0 onwards. WSO2 IS 5.9.0 is used in this guide. WSO2 Identity Server acts as an identity Service Provider of systems enabled with single sign-on, while the Web applications act as SSO Service Providers. Using this feature, you can configure SSO with SAML 2.0 across the API Publisher and Developer Portal. After configuring, you can access the Developer Portal or API Publisher in a single authentication attempt.

## Prerequisites

1. Download the API Manager 3.0.0 distribution.
     1. Access the [previous WSO2 API Manager related releases](https://wso2.com/api-management/previous-releases/).
     2. Select version 3.0.0.
     3. Download the API Manager.

2. Download the Identity Server 5.9.0 distribution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Info
        To use WSO2 IS as the Key Manager, download the **WSO2 Identity Server 5.9.0 as a Key Manager** pack, with pre-packaged Key Manager features as follows:

        1. Access the [previous WSO2 API Manager related releases](https://wso2.com/api-management/previous-releases/).
        2. Select version 3.0.0.
        3. Click on the **Identity Server as a Key Manager** download option.

    !!! Tip
        For **testing purposes** if you want to run both the WSO2 API Manager and WSO2 Identity Server on the same server, then you can go to the `<IS_HOME>/repository/conf/deployment.toml` file and offset the port by 1 by adding the following configuration:

        ``` toml
        [server]
        offset=1
        ```

3.  Start the servers using the following commands:

    ``` tab="On Windows"
    wso2server.bat --run
    ```

    ``` tab="On Linux/Mac OS"
    sh wso2server.sh
    ```

## Step 1 - Configure WSO2 Identity Server

### Step 1.1 - Configure the Service Provider

1.  Sign in to the Management Console of IS server.  

    ```
    https://{is-ip}:9444/carbon
    ```

2.  Navigate to the **Service Providers** section under **Main** → **Identity** and create a new Service Provider.

3.  Edit the created Service Provider:

    1.  Expand the **Inbound Authentication Configuration** section and configure the **SAML2 Web SSO Configuration** by providing the following information:

        <table>
        <tbody>
            <tr>
                <td>Issuer</td>
                <td>Specify the Issuer</td>
            </tr>
            <tr>
                <td>Assertion Consumer URLs</td>
                <td>`https://{apim-ip}:9443/commonauth`</td>
            </tr>
            <tr>
                <td>Response Signing Algorithm</td>
                <td>`http://www.w3.org/2001/04/xmldsig-more#rsa-sha256`</td>
            </tr>
            <tr>
                <td>Enable Response Signing</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Signature Validation in Authentication Requests and Logout Requests</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Single Logout</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Attribute Profile</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Include Attributes in the Response Always</td>
                <td>true</td>
            </tr>
        </tbody>
        </table>

        The following image shows the sample values for SAML2 Web SSO configuration:

        [![SAML configuration in Service Provider]({{base_path}}/assets/img/setup-and-install/saml-configuration-in-service-provider.png)]({{base_path}}/assets/img/setup-and-install/saml-configuration-in-service-provider.png)

        ??? Info "Enable a tenant-specific SSO for the Publisher and Developer Portal"

            To enable a tenant-specific SSO with IS 5.9.0 for Publisher and the Developer Portal, enable the **Use tenant domain in local subject identifier** option under the **Local & Outbound Authentication Configuration** section.

            [![saml-configuration-in-service-provider]({{base_path}}/assets/img/setup-and-install/enable-tenant-domain-in-local-sub-identifier.png)]({{base_path}}/assets/img/setup-and-install/enable-tenant-domain-in-local-sub-identifier.png)

    2.  Expand the **Claim Configuration** section and add **http://wso2.org/claims/role** as a mandatory claim.

        [![Claim configuration in Service Provider for SAML2 SSO]({{base_path}}/assets/img/setup-and-install/claim-configuration-in-service-provider-for-saml2-sso.png)]({{base_path}}/assets/img/setup-and-install/claim-configuration-in-service-provider-for-saml2-sso.png)

    3.  Update the Service Provider configurations.

        !!! Info "In multi-tenanted environments"
            Carry out the instruction given below for all the tenants to be able to sign in to the API-M Web applications in a multi-tenanted environment.

            1. Click the **SaaS Application** option that appears after registering the Service Provider.

               [![saas-configuration-in-service-provider]({{base_path}}/assets/img/setup-and-install/saas.png)]({{base_path}}/assets/img/setup-and-install/saas.png)            

            If you do not select the **SaaS Application** option, only users in the current tenant domain will be allowed to sign in to the portals. You will need to register separate Service Providers for portals from each tenant.

4.  Upload the public certificate of the API Manager by selecting **Select SP Certificate Type**.

    [![Upload certificate in SP for SAML2 SSO]({{base_path}}/assets/img/setup-and-install/upload-certificate-in-sp-for-saml2-sso.png)]({{base_path}}/assets/img/setup-and-install/upload-certificate-in-sp-for-saml2-sso.png)

### Step 1.2 - Create users and roles

1. Create the required users and roles in Identity Server. Let's assume that the following users are created in Identity Servers with the given roles.

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

## Step 2 - Configure WSO2 API Manager

### Step 2.1 - Configure the Identity Provider

1.  Sign in to the Management Console of WSO2 API Manager.

    ```
    https://{apim-ip}:9443/carbon
    ```

2.  Navigate to the **Identity Providers** section under **Main** → **Identity** and create a new Identity Provider.

    1.  Upload the public certificate of Identity Server under the **Upload IDP certificate**.

    2.  Expand the **Federated Authenticators** section and add the following configurations under **SAML2 Web SSO Configurations**:

        <table>
        <tbody>
            <tr>
                <td>Enable SAML2 Web SSO</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Service Provider Entity ID</td>
                <td>It depends on the Issuer value defined in the Service Provider configured in Identity Server above</td>
            </tr>
            <tr>
                <td>Identity Provider Entity ID</td>
                <td>localhost</td>
            </tr>
            <tr>
                <td>SSO URL</td>
                <td>https://{is-ip}:9444/samlsso</td>
            </tr>
            <tr>
                <td>Signature Algorithm</td>
                <td>RSA with SHA256</td>
            </tr>
            <tr>
                <td>Enable Authentication Request Signing</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Authentication Response Signing</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Logout Request Signing</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Enable Logout</td>
                <td>true</td>
            </tr>
        </tbody>
        </table>

        The following image shows the sample values for SAML2 Web SSO configurations:

        [![SAML configuration in Identity Provider]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-saml-sso.png)]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-saml-sso.png)

        !!! Note
            Make sure your Service Provider configurations in the Identity Server and the Identity Provider configurations in API Manager reflect each other.

            Example:

            -   If the **Response Signing Algorithm** in Identity Server is **rsa-sha256**, then the Signature Algorithm in API Manager should be **RSA with SHA256**.
            -   If you enabled **Enable Single Logout** in the Service Provider created in the Identity Server, then enable **Single Logout Profile** in the Identity Provider created in API Manager.

    3.  Enable Just-in-Time Provisioning to provision the users in API Manager.

        [![JIT provisioning for SSO]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)

    4.  Add the following role mapping under the **Role Configuration** section.

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

        [![Role mapping for SSO]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso.png)

        !!! Tip
            Instead of using the default internal roles, you can also create new roles in API Manager and map it to the provisioned users. 


    ### Step 2.2 - Configure the Service Provider

    1.  Navigate to the **Service Providers** section and list the Service Providers. 

         There are two Service Providers created for the Publisher portal and Developer portal named as `apim_publisher` and `apim_devportal`. Edit the `apim_publisher` Service Provider.

        !!! Attention
            You will have to log into the Developer Portal and Publisher at least once for the two Service Providers to appear as it is created during the first login.

    2.  Expand the **Local & Outbound Authentication Configuration** section, select **Federated Authentication** as Authentication Type, and select the name of the Identity Provider you created and update. 

        [![Local and outbound authentication configuration for SSO]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)

    3.  Repeat the same step for the `apim_devportal` Service Provider as well.

    Now you will be able to sign in to Publisher and Developer Portal using the users in WSO2 Identity Server.

    !!! Info
        To learn more about Single Sign-On with WSO2 Identity Server, see [SAML 2.0 Web SSO](https://is.docs.wso2.com/en/5.9.0/learn/saml-2.0-web-sso/) in the WSO2 Identity Server documentation.
