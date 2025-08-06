# Configuring Identity Server 7.x as External IDP using OIDC

WSO2 API Manager uses the OIDC Single Sign-On feature by default. This document explains how to connect WSO2 Identity Server (or WSO2 Identity Server as a Keymanager) as a third party Identity provider to API-Manager.

## prerequisites

-   Download the API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
-   Download the Identity Server 7.x distribution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

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

## Configure the Identity Server 7.x

### Step - 1 Configure the Service Provider

1.  Sign in to the Management Console of WSO2 IS by browsing the following URL:  

    ```
    https://{is-ip}:9444/console
    ```

2.  Create a Standard-Based application by navigating to the **Applications** section from the left panel.

    [![]({{base_path}}/assets/img/setup-and-install/create-standard-app-in-is7.png)]({{base_path}}/assets/img/setup-and-install/create-standard-app-in-is7.png)

3.  Edit the created Application:

    1.  In the **Protocol** section do the following and update.

        - Enable code, client credential and password grant types.
        - Add `https://localhost:9444/commonauth` as the Authorized redirect URLs.
        - Add `https://localhost:9444` as Allowed origins.
        - Make Access Token type as JWT.

    2.  In the **User Attributes** section do the following and update.

        - Select Groups and Profile as requested attributes and Update.

        [![]({{base_path}}/assets/img/setup-and-install/set-user-attributes-to-ass-in-is7.png)]({{base_path}}/assets/img/setup-and-install/set-user-attributes-to-ass-in-is7.png)

        - Enable 'Assign alternatice subject identifier', select the Username as Subject attribute and Update.

        [![]({{base_path}}/assets/img/setup-and-install/set-subject-attributes-to-ass-in-is7.png)]({{base_path}}/assets/img/setup-and-install/set-subject-attributes-to-ass-in-is7.png)

### Step - 2 Create groups and users

1. Navigate to User Management → Groups → New Group and create a new group `publisher_group` without assigning users.

    [![Create User Group]({{base_path}}/assets/img/setup-and-install/create-group-in-is7.png)]({{base_path}}/assets/img/setup-and-install/create-group-in-is7.png)

2. Navigate to User Management → Users → Add User and create a user `new_publisher` providing required details.

    [![Create User]({{base_path}}/assets/img/setup-and-install/create-user-in-is7.png)]({{base_path}}/assets/img/setup-and-install/create-user-in-is7.png)

3. Assign `publisher_group` group to the `new_publisher`.

    [![Assign Group to User]({{base_path}}/assets/img/setup-and-install/assign-group-to-user-in-is7.png)]({{base_path}}/assets/img/setup-and-install/assign-group-to-user-in-is7.png)

Repeat the same steps to create a group for Api Users and assign users to it.
Now the following users are created in Identity Server with the given groups.

<table>
    <thead>
        <tr>
            <th>User</th>
            <th>Group</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>new_publisher</td>
            <td>publisher_group</td>
        </tr>
        <tr>
            <td>new_user</td>
            <td>user_group</td>
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
                <th>Identity Server Group</th>
                <th>Roles Mapped in API Manager</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>user_group</td>
                <td>Internal/Subscriber</td>
            </tr>
            <tr>
                <td>publisher_group</td>
                <td>Internal/publisher</td>
            </tr>
        </tbody>
        </table>

        [![]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso-is7.png)]({{base_path}}/assets/img/setup-and-install/role-mapping-for-sso-is7.png)

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

### Step - 2 Configure the Service Provider

1.  Navigate to **Service Providers** section and list the Service Providers. There are two service providers created for Publisher portal and Developer portal named as `apim_publisher` and `apim_devportal`. Edit the `apim_publisher` service provider.

    !!! Attention
        You will have to log into the Developer Portal and Publisher at least once for the two service providers to appear as it is created during first login.

2.  Expand the **Local & Outbound Authentication Configuration** section and select **Federated Authentication** as Authentication Type and select the name of the Identity Provider you created in previous step and update.

    [![]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)]({{base_path}}/assets/img/setup-and-install/local-and-outbound-authentication-configuration-for-sso.png)

3.  Repeat the same step for `apim_devportal` Service Provider as well.

Now you will be able to login to Publisher and Devportal using the users in WSO2 Identity Server.

