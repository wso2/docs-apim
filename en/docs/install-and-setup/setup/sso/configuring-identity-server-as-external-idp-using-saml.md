# Configuring Identity Server as External IDP using SAML

The Single Sign-On with the SAML 2.0 feature in WSO2 API Manager is implemented according to the SAML 2.0 browser-based SSO support facilitated by WSO2 Identity Server(WSO2 IS). This feature is available in all WSO2 IS packs from 4.1.0 onwards. The version used in this guide is WSO2 IS 7.x

WSO2 Identity Server acts as an identity service provider of systems enabled with single sign-on, while the Web applications act as SSO service providers. Using this feature, you can configure SSO with SAML 2.0 across the API Publisher and Developer Portal. After configuring, you can access the Developer Portal or the API Publisher with a single authentication attempt.

## prerequisites

-   Download the API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).

-   Download the Identity Server distribution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For testing purposes, if you want to run both the WSO2 API Manager and WSO2 IS server on the same server, go to the `<IS-Home>/repository/conf/deployment.toml` file and offset the port by 1 to Identity Server, by adding following configuration:

        ``` toml
        [server]
        offset=1
        ```

-  Start the servers using the following commands:

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

1.  Login to the Management Console of the Identity server by accessing the following URL:  

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
                <td>SAML</td>
            </tr>
            <tr>
                <td>Issuer</td>
                <td>apim</td>
            </tr>
            <tr>
                <td>Assertion consumer service</td>
                <td>https://localhost:9443/commonauth</td>
            </tr>
        </tbody>
     </table>

    [![Create Traditional Web Application]({{base_path}}/assets/img/setup-and-install/create-traditional-web-app-saml.png)]({{base_path}}/assets/img/setup-and-install/create-traditional-web-app-saml.png)

    c.  Under the **Protocol** tab, go to **Response Signing**, select **Sign SAML Responses**, and click **Update**.

    [![Enable Response Signing]({{base_path}}/assets/img/setup-and-install/enable-response-signing.png)]({{base_path}}/assets/img/setup-and-install/enable-response-signing.png)

    d.  Go to the **User Attribute Selection** section in **User Attributes** tab, click **Add user attributes**, and add the **Username** and **Groups** attributes.

    e.  Under the **Subject** section, select **Username** as the subject attribute.

    [![Add user attributes and subject]({{base_path}}/assets/img/setup-and-install/add-user-attributes-saml.png)]({{base_path}}/assets/img/setup-and-install/add-user-attributes-saml.png)

    f.  Go to the **Info** tab and download the IdP Metadata file using the **Download IdP Metadata** option.

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

1.  Login to the Management Console of API Manager by browsing the following URL: 

    ```
    https://{apim-ip}:9443/carbon
    ```

2.  Navigate to the **Identity Providers** section under Main → Identity and create new Identity Provider.

    1.  Expand the **Federated Authenticators** section and add following configurations under **SAML2 Web SSO Configurations**:

        <table>
        <tbody>
            <tr>
                <td>Enable SAML2 Web SSO</td>
                <td>true</td>
            </tr>
            <tr>
                <td>Service Provider Entity ID</td>
                <td>It depends on the Issuer value defined in the Service Provider configured in Identity Server above. (Ex: apim)</td>
            </tr>
            <tr>
                <td>Select Mode</td>
                <td>`Metadata File Configuration` option and upload the IdP Metadata file.</td>
            </tr>
        </tbody>
        </table>

        Following image shows the sample values for SAML2 Web SSO Configurations:

        [![saml-configuration-in-identity-provider]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-saml-sso.png)]({{base_path}}/assets/img/setup-and-install/identity-provider-configuration-for-saml-sso.png)

        !!! Note
            If you configure manually, make sure your service provider configurations in the Identity Server and the identity provider configurations in API Manager are similarly reflected to each other.

            Example:

            -   If the **Response Signing Algorithm** in Identity Server is **rsa-sha256**, then the Signature Algorithm in API Manager should be **RSA with SHA256**.
            -   If you have enabled **Enable Single Logout** in the Service Provider created in the Identity Server, then you have to enable **Single Logout Profile** in the Identity Provider created in API Manager.

    2.  Enable Just-in-Time Provisioning to provision the users in API Manager.

        [![]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)]({{base_path}}/assets/img/setup-and-install/jit-provisioning-for-sso.png)

    3.  Add the following role mapping under **Role Configuration** section:

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
                <td>http://wso2.org/claims/groups</td>
                <td>http://wso2.org/claims/role</td>
            </tr>
        </tbody>
        </table>
    
        Also select **groups** as the **Role Claim URI**.

    [![Claim mapping for sso]({{base_path}}/assets/img/setup-and-install/claim-mapping-for-sso.png)]({{base_path}}/assets/img/setup-and-install/claim-mapping-for-sso.png)

### Step - 3 Configure the Service Provider


1.  Navigate to the **Service Providers** section and list the Service Providers. There are two service providers created for Publisher portal and Developer portal named as `apim_publisher` and `apim_devportal`. Edit the `apim_publisher` service provider.

    !!! Attention
        The service providers are created during the first login. Therefore, you will have to log into the Developer Portal and Publisher at least once for the two service providers to appear.

2.  Expand the **Local & Outbound Authentication Configuration** section and select **Federated Authentication** as the **Authentication Type** and select the name of the Identity Provider you created. Update the configurations with your selection.

    [![]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)

3.  Repeat the same step for the apim_devportal Service Provider as well.

    Now you will be able to login to Publisher and Devportal using the users in WSO2 Identity Server.

    !!! Info
        To learn more about Single Sign-On with WSO2 Identity Server, see [SAML 2.0 Web SSO](https://is.docs.wso2.com/en/latest/guides/authentication/saml/) in the WSO2 Identity Server documentation.
