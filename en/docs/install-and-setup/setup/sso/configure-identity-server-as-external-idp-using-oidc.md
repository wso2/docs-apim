# Configure Identity Server as External IDP using OIDC

WSO2 API Manager uses OIDC Single Sign-On feature by default. This document explains how to connect an WSO2 Identity Server (or WSO2 IS-KM) as a third party Identity provider to API-Manager.

## Pre-requisites

-   Download the API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
-   Download the Identity Server distirbution from [https://wso2.com/identity-and-access-management/](https://wso2.com/identity-and-access-management/).

    !!! Tip
        For **testing purposes** if you want to run both the WSO2 API Manager and WSO2 IS server on the same server, then you can go to the <IS_HOME>/repository/conf/deployment.toml file and offset the port by 1 as by adding following configuration:

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

1.  Login to the Management Console of IS server by browsing the following URL:  

    ```
    https://{is-ip}:9444/carbon
    ```

2.  Navigate to the **Service Providers** section under Main → Identity and create new Service Provider with Callback URL - `https://{apim-ip}:9443/commonauth`

3.  Edit the created Service Provider and navigate to Claim Configuration section. Add **http://wso2.org/claims/role** as mandatory claim and update the Service Provider configurations.

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

1.  Login to the Management Console of API Manager by browsing the following URL: 

    ```
    https://{apim-ip}:9443/carbon
    ```

2.  Navigate to the **Identity Providers** section under Main → Identity and create new Identity Provider.

    1.  Expand the **Federated Authenticators** section and add following configurations under **OAuth2/OpenIDConnect Configuration**:

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

        Following image shows the sample values for OAuth2/OpenIDConnect Configurations:

    2.  Enable Just-in-Time Provisioning to provision the users in API Manager: 

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
                    <td>user_role</td>
                    <td>Internal/Subscriber</td>
                </tr>
                <tr>
                    <td>publisher_role</td>
                    <td>Internal/publisher</td>
                </tr>
            </tbody>
        </table>

    !!! Tip
        Instead of using the default internal roles, you can also create new roles in API Manager and map it to the provisioned users.

### Step - 2 Configure the Service Provider

1.  Navigate to **Service Providers** section and list the Service Providers. There are two service providers created for Publisher portal and Developer portal named as `apim_publisher` and `apim_devportal`. Edit the `apim_publisher` service provider.

    !!! Attention
        You will have to log into the Developer Portal and Publisher at least once for the two service providers to appear as it is created during first login.

2.  Expand the **Local & Outbound Authentication Configuration** section and select **Federated Authentication** as Authentication Type and select the name of the Identity Provider you created in Step 5 and update.

3.  Repeat the same step for apim_devportal Service Provider as well.


Now you will be able to login to Publisher and Devportal using the users in WSO2 Identity Server.