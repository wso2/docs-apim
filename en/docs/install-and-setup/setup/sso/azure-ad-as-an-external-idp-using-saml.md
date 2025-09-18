# Using Azure AD as an external IDP with SAML

Follow the instructions below to connect Azure Active Directory as a third-party Identity Provider to WSO2 API Manager using Security Assertion Markup Language (SAML).

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
      <td><code>WSO2-API-Manager-SAML</code></td>
      </tr>
      <tr>
      <td>Supported account types</td>
      <td>Accounts in this organizational directory only</td>
      </tr>
      <tr>
      <td>Redirect URI (optional)</td>
      <td>Leave empty for now</td>
      </tr>
    </table>

3. Configure SAML settings.

     1. Go to **Single sign-on** in the left navigation.
     2. Select **SAML** as the single sign-on method.
     3. Configure the **Basic SAML Configuration**:

    <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Identifier (Entity ID)</td>
      <td><code>AzureAD-SAML</code></td>
      </tr>
      <tr>
      <td>Reply URL (Assertion Consumer Service URL)</td>
      <td><code>https://localhost:9443/commonauth</code></td>
      </tr>
      <tr>
      <td>Sign on URL</td>
      <td><code>https://localhost:9443/publisher</code></td>
      </tr>
      <tr>
      <td>Logout URL</td>
      <td><code>https://localhost:9443/commonauth</code></td>
      </tr>
    </table>

4. Configure user attributes and claims.

     1. In the **User Attributes & Claims** section, configure the following attributes:

    <table>
      <tr>
      <th><b>Name</b></th>
      <th><b>Source attribute</b></th>
      </tr>
      <tr>
      <td>Unique User Identifier</td>
      <td>user.userprincipalname</td>
      </tr>
      <tr>
      <td>emailaddress</td>
      <td>user.mail</td>
      </tr>
      <tr>
      <td>givenname</td>
      <td>user.givenname</td>
      </tr>
      <tr>
      <td>surname</td>
      <td>user.surname</td>
      </tr>
      <tr>
      <td>name</td>
      <td>user.displayname</td>
      </tr>
    </table>

5. Download the federation metadata.

     1. In the **SAML Signing Certificate** section, download the **Federation Metadata XML**.
     2. Save this file for later use in WSO2 API Manager configuration.

6. Assign users to the application.

     1. Go to **Users and groups** in the left navigation.
     2. Click **Add user/group**.
     3. Assign the appropriate users or groups who should have access to WSO2 API Manager.

## Step 2 - Configure optional app roles (for role mapping)

1. Go to **App roles** in the left navigation.

2. Create app roles for different WSO2 API Manager user types:

     Click **Create app role** and create the following roles:

     **Role 1 - API Manager User**
     <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Display name</td>
      <td><code>API Manager User</code></td>
      </tr>
      <tr>
      <td>Allowed member types</td>
      <td>Users/Groups</td>
      </tr>
      <tr>
      <td>Value</td>
      <td><code>api_manager_user</code></td>
      </tr>
      <tr>
      <td>Description</td>
      <td>Regular user role for API Manager</td>
      </tr>
    </table>

     **Role 2 - API Manager Admin**
     <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Display name</td>
      <td><code>API Manager Admin</code></td>
      </tr>
      <tr>
      <td>Allowed member types</td>
      <td>Users/Groups</td>
      </tr>
      <tr>
      <td>Value</td>
      <td><code>api_manager_admin</code></td>
      </tr>
      <tr>
      <td>Description</td>
      <td>Administrator role for API Manager</td>
      </tr>
    </table>

3. Assign roles to users:

     1. Go back to **Users and groups**.
     2. Select a user and click **Edit**.
     3. Assign the appropriate app roles to the user.

## Step 3 - Configure WSO2 API Manager

1. Sign in to the WSO2 API-M Management Console.

     `https://localhost:9443/carbon`

2. Create roles that correspond to Azure AD app roles.

    1. Click **Main**, **Identity**, and then click **Add** under **Users and Roles**.
    2. Click **Add New Role**.
    3. Add new roles based on the following details:

         <table>
         <tr>
         <th><b>Role Name</b></th>
         <th><b>Permissions</b></th>
         </tr>
         <tr>
         <td><code>azuread_user</code></td>
         <td>Basic user permissions</td>
         </tr>
         <tr>
         <td><code>azuread_admin</code></td>
         <td>Administrative permissions</td>
         </tr>
         </table>

3. Create an identity provider.

    1. Click **Main** and then click **Add** under **Identity Providers**.
    2. Enter the **Identity Provider Name** as `AzureAD-SAML`.
    3. Upload the federation metadata XML file downloaded from Azure AD:
       - Click **Choose File** next to **Identity Provider Metadata File**
       - Upload the federation metadata XML file
    
    4. Alternatively, you can manually configure the SAML settings:

         <table>
         <tr>
         <th><b>Field</b></th>
         <th><b>Value</b></th>
         </tr>
         <tr>
         <td>Service Provider Entity Id</td>
         <td><code>AzureAD-SAML</code></td>
         </tr>
         <tr>
         <td>Identity Provider Entity Id</td>
         <td>Entity ID from Azure AD metadata</td>
         </tr>
         <tr>
         <td>SSO URL</td>
         <td>Single Sign-On Service Location from Azure AD</td>
         </tr>
         <tr>
         <td>SLO URL</td>
         <td>Single Logout Service Location from Azure AD</td>
         </tr>
         </table>

    5. Click **Register**.

4. Configure claim configuration.

    1. Go to **Claim Configuration** under the identity provider you just created.
    2. Configure **Local Claim Dialect** and add the following claim mappings:

         <table>
         <tr>
         <th><b>Identity Provider Claim URI</b></th>
         <th><b>Local Claim URI</b></th>
         </tr>
         <tr>
         <td><code>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress</code></td>
         <td><code>http://wso2.org/claims/emailaddress</code></td>
         </tr>
         <tr>
         <td><code>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname</code></td>
         <td><code>http://wso2.org/claims/givenname</code></td>
         </tr>
         <tr>
         <td><code>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname</code></td>
         <td><code>http://wso2.org/claims/lastname</code></td>
         </tr>
         <tr>
         <td><code>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name</code></td>
         <td><code>http://wso2.org/claims/username</code></td>
         </tr>
         </table>

5. Configure role mappings.

     1. Go to **Role Configuration** under the identity provider configuration.
     2. Add the following role mappings:

     <table>
     <tr>
     <th><b>Identity Provider Role</b></th>
     <th><b>Local Role</b></th>
     </tr>
     <tr>
     <td><code>api_manager_user</code></td>
     <td><code>azuread_user</code></td>
     </tr>
     <tr>
     <td><code>api_manager_admin</code></td>
     <td><code>azuread_admin</code></td>
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
    3. Go to **Inbound Authentication Configuration** > **SAML2 Web SSO Configuration**.
    4. Click **Configure** and add the following configuration:

         <table>
         <tr>
         <th><b>Field</b></th>
         <th><b>Value</b></th>
         </tr>
         <tr>
         <td>Issuer</td>
         <td><code>apim_publisher</code></td>
         </tr>
         <tr>
         <td>Assertion Consumer URL</td>
         <td><code>https://localhost:9443/publisher/samlsso</code></td>
         </tr>
         <tr>
         <td>Default Authentication Context</td>
         <td><code>urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport</code></td>
         </tr>
         </table>

    5. Go to **Local & Outbound Authentication Configuration**.
    6. Select **Federated Authentication** as the **Authentication Type**.
    7. Select the `AzureAD-SAML` identity provider from the dropdown.
    8. Click **Update**.

2. Create service provider for the Developer Portal.

    1. Click **Main** > **Service Providers** > **Add**.
    2. Enter the **Service Provider Name** as `apim_devportal` and click **Register**.
    3. Go to **Inbound Authentication Configuration** > **SAML2 Web SSO Configuration**.
    4. Click **Configure** and add the following configuration:

         <table>
         <tr>
         <th><b>Field</b></th>
         <th><b>Value</b></th>
         </tr>
         <tr>
         <td>Issuer</td>
         <td><code>apim_devportal</code></td>
         </tr>
         <tr>
         <td>Assertion Consumer URL</td>
         <td><code>https://localhost:9443/devportal/samlsso</code></td>
         </tr>
         <tr>
         <td>Default Authentication Context</td>
         <td><code>urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport</code></td>
         </tr>
         </table>

    5. Go to **Local & Outbound Authentication Configuration**.
    6. Select **Federated Authentication** as the **Authentication Type**.
    7. Select the `AzureAD-SAML` identity provider from the dropdown.
    8. Click **Update**.

## Step 5 - Test the configuration

1. Access the WSO2 API Manager Publisher portal.

     `https://localhost:9443/publisher`

2. Click **Sign In** and you should be redirected to the Azure AD login page.

3. Enter your Azure AD credentials to authenticate.

4. Upon successful authentication, you should be redirected back to the Publisher portal and logged in.

5. Repeat the same steps for the Developer Portal at `https://localhost:9443/devportal`.

## Troubleshooting

If you encounter issues during the configuration:

1. **Certificate validation**: Ensure that the SAML signing certificate from Azure AD is properly configured.

2. **Entity ID mismatch**: Verify that the Entity ID configured in Azure AD matches the Service Provider Entity ID in WSO2 API Manager.

3. **Assertion Consumer Service URL**: Ensure the ACS URLs are correctly configured in both Azure AD and WSO2 API Manager.

4. **Clock synchronization**: Ensure that the clocks on both Azure AD and WSO2 API Manager are synchronized to prevent token validation issues.

5. **Review logs**: Check the WSO2 API Manager logs located in `<API-M_HOME>/repository/logs/` for any SAML-related errors.

6. **User assignment**: Verify that users are properly assigned to the Azure AD application.

## Advanced configuration

For production environments, consider the following advanced configurations:

1. **Certificate management**: Use proper certificate management practices for SAML signing and encryption.

2. **Attribute encryption**: Configure attribute encryption for sensitive user information.

3. **Single logout**: Implement proper single logout (SLO) configuration for better security.

4. **Conditional access**: Implement Azure AD conditional access policies for enhanced security.

5. **Multi-tenant support**: Configure multi-tenant support if your organization uses multiple Azure AD tenants.