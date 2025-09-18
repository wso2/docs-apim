# Using Azure AD as an external IDP with OIDC

Follow the instructions below to connect Azure Active Directory as a third-party Identity Provider to WSO2 API Manager using OpenID Connect (OIDC).

## Prerequisites

Before you begin, make sure you do the following:

1. Create an Azure AD account with appropriate permissions to register applications.
2. Download the WSO2 API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
3. Enable the email domain on WSO2 API Manager.

     You need to enable this because Azure AD uses the email as the username by default. As the email domain is not enabled by default, you have to enable it to use the email as the username in WSO2 API Manager. Once enabled, you can use your email or a normal username as your username.

     Follow the instructions below:

     1. Unzip the WSO2 API Manager distribution.
     2. Open the `deployment.toml` file, which is located in the `<API-M_HOME>/repository/conf/` directory.
     3. Add the following configuration:

        ```
        [tenant_mgt]
        enable_email_domain= true
        ```

4. Start the WSO2 API Manager server.

## Step 1 - Configure Azure AD

!!! note
    For more information on working with the Azure portal, see the official Microsoft Azure documentation.

1. Navigate to the Azure portal and sign in with your Azure AD credentials.

2. Create a new Azure AD application registration.

     1. Go to **Azure Active Directory** > **App registrations**.
     2. Click **New registration**.
     3. Configure the application with the following settings:

    <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Name</td>
      <td><code>WSO2-API-Manager-OIDC</code></td>
      </tr>
      <tr>
      <td>Supported account types</td>
      <td>Accounts in this organizational directory only</td>
      </tr>
      <tr>
      <td>Redirect URI (optional)</td>
      <td>Web: <code>https://localhost:9443/commonauth</code></td>
      </tr>
    </table>

3. Configure authentication settings.

     1. Go to **Authentication** in the left navigation.
     2. Add the following redirect URIs if not already added:
        - `https://localhost:9443/commonauth`
     3. Under **Advanced settings**, enable **ID tokens** checkbox.

4. Generate client secret.

     1. Go to **Certificates & secrets** in the left navigation.
     2. Click **New client secret**.
     3. Add a description and select an expiration period.
     4. Copy and save the client secret value immediately (it will not be shown again).

5. Configure API permissions.

     1. Go to **API permissions** in the left navigation.
     2. Ensure **Microsoft Graph** > **User.Read** permission is granted.
     3. Click **Grant admin consent** if required.

6. Note down the following information from the **Overview** page:
   - **Application (client) ID**
   - **Directory (tenant) ID**

## Step 2 - Configure optional claims (for role mapping)

1. Go to **Token configuration** in the left navigation.

2. Add optional claims for ID tokens:
   
     1. Click **Add optional claim**.
     2. Select **ID** token type.
     3. Add the following claims:
        - `email`
        - `family_name`
        - `given_name`
        - `upn`

3. Configure roles (if using Azure AD roles):

     1. Go to **App roles** in the left navigation.
     2. Click **Create app role**.
     3. Create roles as needed for your organization (for example, `API_Manager_User`, `API_Manager_Admin`).

## Step 3 - Configure WSO2 API Manager

1. Sign in to the WSO2 API-M Management Console.

     `https://localhost:9443/carbon`

2. Create a role that needs to be assigned to users that will be provisioned from Azure AD.

    1. Click **Main**, **Identity**, and then click **Add** under **Users and Roles**.
    2. Click **Add New Role**.
    3. Add a new role based on the following details and click **Finish**:

         <table>
         <tr>
         <th><b>Field</b></th>
         <th><b>Value</b></th>
         </tr>
         <tr>
         <td>Role Name</td>
         <td><code>azuread_role</code></td>
         </tr>
         </table>

    4. Assign the necessary permissions to this role.

3. Create an identity provider.

    1. Click **Main** and then click **Add** under **Identity Providers**.
    2. Enter the **Identity Provider Name** as `AzureAD-OIDC`.
    3. Go to **Federated Authenticators** > **OAuth2/OpenIDConnect Configuration** and configure the following:

         <table>
         <tr>
         <th><b>Field</b></th>
         <th><b>Value</b></th>
         </tr>
         <tr>
         <td>Enable OAuth2/OpenIDConnect</td>
         <td>True</td>
         </tr>
         <tr>
         <td>Client Id</td>
         <td>Enter the Application (client) ID from Azure AD</td>
         </tr>
         <tr>
         <td>Client Secret</td>
         <td>Enter the client secret from Azure AD</td>
         </tr>
         <tr>
         <td>Authorization Endpoint URL</td>
         <td><code>https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/authorize</code></td>
         </tr>
         <tr>
         <td>Token Endpoint URL</td>
         <td><code>https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/token</code></td>
         </tr>
         <tr>
         <td>Callback URL</td>
         <td><code>https://localhost:9443/commonauth</code></td>
         </tr>
         <tr>
         <td>Userinfo Endpoint URL</td>
         <td><code>https://graph.microsoft.com/oidc/userinfo</code></td>
         </tr>
         <tr>
         <td>Logout Endpoint URL</td>
         <td><code>https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/logout</code></td>
         </tr>
         <tr>
         <td>Additional Query Parameters</td>
         <td><code>scope=openid email profile</code></td>
         </tr>
         </table>

    4. Click **Register**.

4. Configure claim configuration.

    1. Go to **Claim Configuration** under the identity provider you just created.
    2. Click **Add Claim Mapping** and add the following claim mappings:

         <table>
         <tr>
         <th><b>Identity Provider Claim URI</b></th>
         <th><b>Local Claim URI</b></th>
         </tr>
         <tr>
         <td><code>email</code></td>
         <td><code>http://wso2.org/claims/emailaddress</code></td>
         </tr>
         <tr>
         <td><code>given_name</code></td>
         <td><code>http://wso2.org/claims/givenname</code></td>
         </tr>
         <tr>
         <td><code>family_name</code></td>
         <td><code>http://wso2.org/claims/lastname</code></td>
         </tr>
         <tr>
         <td><code>upn</code></td>
         <td><code>http://wso2.org/claims/username</code></td>
         </tr>
         </table>

5. Configure role mappings (optional).

     If you are using Azure AD roles, add role mappings under **Role Configuration**:
     
     <table>
     <tr>
     <th><b>Identity Provider Role</b></th>
     <th><b>Local Role</b></th>
     </tr>
     <tr>
     <td><code>API_Manager_User</code></td>
     <td><code>azuread_role</code></td>
     </tr>
     </table>

6. Enable Just-In-Time (JIT) provisioning.

     1. Go to **Just-In-Time Provisioning** under the identity provider configuration.
     2. Enable **Always provision to User Store Domain**.
     3. Select the user store domain where users should be provisioned.

## Step 4 - Configure service providers

1. Create service provider for the Publisher portal.

    1. Click **Main** > **Service Providers** > **Add**.
    2. Enter the **Service Provider Name** as `apim_publisher` and click **Register**.
    3. Go to **Local & Outbound Authentication Configuration**.
    4. Select **Federated Authentication** as the **Authentication Type**.
    5. Select the `AzureAD-OIDC` identity provider from the dropdown.
    6. Click **Update**.

2. Create service provider for the Developer Portal.

    1. Click **Main** > **Service Providers** > **Add**.
    2. Enter the **Service Provider Name** as `apim_devportal` and click **Register**.
    3. Go to **Local & Outbound Authentication Configuration**.
    4. Select **Federated Authentication** as the **Authentication Type**.
    5. Select the `AzureAD-OIDC` identity provider from the dropdown.
    6. Click **Update**.

## Step 5 - Test the configuration

1. Access the WSO2 API Manager Publisher portal.

     `https://localhost:9443/publisher`

2. Click **Sign In** and you should be redirected to the Azure AD login page.

3. Enter your Azure AD credentials to authenticate.

4. Upon successful authentication, you should be redirected back to the Publisher portal and logged in.

5. Repeat the same steps for the Developer Portal at `https://localhost:9443/devportal`.

## Troubleshooting

If you encounter issues during the configuration:

1. **Verify redirect URIs**: Ensure all redirect URIs in Azure AD match exactly with the configured URLs in WSO2 API Manager.

2. **Check client secret**: Ensure the client secret is copied correctly and has not expired.

3. **Review logs**: Check the WSO2 API Manager logs located in `<API-M_HOME>/repository/logs/` for any authentication errors.

4. **Test endpoints**: Verify that the Azure AD endpoints are accessible from your WSO2 API Manager instance.

5. **Claim mappings**: Ensure proper claim mappings are configured for user attributes.

## Advanced configuration

For production environments, consider the following advanced configurations:

1. **Custom claim configurations**: Configure additional custom claims based on your organizational requirements.

2. **Conditional access policies**: Implement Azure AD conditional access policies for enhanced security.

3. **Multi-tenant support**: Configure multi-tenant support if your organization uses multiple Azure AD tenants.

4. **Certificate-based authentication**: Use certificates instead of client secrets for enhanced security.