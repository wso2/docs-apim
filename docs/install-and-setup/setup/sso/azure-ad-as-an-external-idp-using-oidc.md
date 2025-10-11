# Using Azure AD as an external IdP with OIDC

Follow the instructions below to connect Azure Active Directory (Azure AD) as a third-party Identity Provider to WSO2 API Manager using OpenID Connect (OIDC).

## Prerequisites

Before you begin, make sure you do the following:

1. Create an Azure account and have access to Azure Active Directory.
2. Download the WSO2 API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
3. Enable the email domain on WSO2 API Manager.

     You need to enable this because Azure AD uses the email as the username by default. As the email domain is not enabled by default, you have to enable it to use the email as the username in WSO2 API Manager. Once enabled, you can use your email or a normal username as your username.

     Follow the instructions below:

     1. Unzip the WSO2 API Manager distribution.
     2. Open the `deployment.toml` file, which is located in the `<API-M_HOME>/repository/conf/` directory.
     3. Add the following configuration:

        ```toml
        [tenant_mgt]
        enable_email_domain= true
        ```

4. Start the WSO2 API Manager server.

## Step 1 - Configure Azure AD

!!! note
    For more information on working with Azure Active Directory, see the [official Azure AD documentation](https://docs.microsoft.com/en-us/azure/active-directory/).

1. Sign in to the [Azure portal](https://portal.azure.com/).

2. Navigate to **Azure Active Directory** > **App registrations**.

3. Select **New registration** and create an application with the following settings:

    | Field | Value |
    |-------|-------|
    | Name | `WSO2-API-Manager-OIDC` |
    | Supported account types | **Accounts in this organizational directory only** |
    | Redirect URI | `https://localhost:9443/commonauth` |

    !!! note
        Replace `localhost:9443` with your actual WSO2 API Manager host and port if you are not running it locally.

4. After creating the application, note down the following values from the **Overview** page:
   - **Application (client) ID**
   - **Directory (tenant) ID**

5. Navigate to **Certificates & secrets** and create a new client secret:
   - Select **New client secret**
   - Add a description (e.g., `WSO2 APIM Secret`)
   - Set expiration as required
   - Copy the secret **Value** (not the Secret ID)

6. Configure API permissions:
   - Navigate to **API permissions**
   - Select **Add a permission** > **Microsoft Graph** > **Delegated permissions**
   - Add the following permissions:
     - `openid`
     - `profile`
     - `email`
   - Select **Grant admin consent** if you have admin privileges

7. Configure authentication settings:
   - Navigate to **Authentication**
   - Under **Implicit grant and hybrid flows**, enable:
     - **ID tokens (used for implicit and hybrid flows)**
   - Ensure the redirect URI is correctly set to: `https://localhost:9443/commonauth`

## Step 2 - Configure WSO2 API Manager

1. Open the `deployment.toml` file in the `<API-M_HOME>/repository/conf/` directory.

2. Add the following configuration to enable Azure AD as an identity provider:

    ```toml
    [[authentication.authenticator.oidc]]
    name = "OpenIDConnectAuthenticator"
    enable = true

    [authentication.authenticator.oidc.parameters]
    ClientId = "<APPLICATION_CLIENT_ID>"
    ClientSecret = "<APPLICATION_CLIENT_SECRET>"
    AuthorizationEndpointURL = "https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/authorize"
    TokenEndpointURL = "https://login.microsoftonline.com/<TENANT_ID>/oauth2/v2.0/token"
    UserInfoEndpointURL = "https://graph.microsoft.com/oidc/userinfo"
    callbackUrl = "https://localhost:9443/commonauth"
    Scope = "openid email profile"
    IsUserIdInClaims = true
    ```

    Replace the following placeholders:
    - `<APPLICATION_CLIENT_ID>`: Application (client) ID from Azure AD
    - `<APPLICATION_CLIENT_SECRET>`: Client secret value from Azure AD
    - `<TENANT_ID>`: Directory (tenant) ID from Azure AD

3. Configure user attribute mapping by adding the following section:

    ```toml
    [authentication.authenticator.oidc.parameters]
    IsUserIdInClaims = true
    userIdClaim = "email"
    RolesClaim = "groups"
    ```

4. Add the following configuration for Just-in-Time (JIT) user provisioning:

    ```toml
    [authentication.authenticator.oidc.parameters]
    IsProvisioningEnabled = true
    ProvisioningUserStore = "PRIMARY"
    ```

5. Restart the WSO2 API Manager server.

## Step 3 - Configure role mapping (Optional)

If you want to map Azure AD groups to WSO2 API Manager roles:

1. In Azure AD, navigate to your application > **Token configuration**.

2. Select **Add groups claim** and configure:
   - **Group types**: Security groups
   - **ID**: Group ID
   - **Access**: Group ID
   - **Source attribute**: Group ID

3. Update the WSO2 API Manager configuration in `deployment.toml`:

    ```toml
    [authentication.authenticator.oidc.parameters]
    RolesClaim = "groups"

    [[authentication.authenticator.oidc.claim_mappings]]
    remote_claim = "groups"
    local_claim = "http://wso2.org/claims/role"
    ```

4. Create a role mapping file at `<API-M_HOME>/repository/conf/role-mapping.properties`:

    ```properties
    # Map Azure AD group IDs to WSO2 roles
    <AZURE_AD_GROUP_ID_1>=Internal/publisher
    <AZURE_AD_GROUP_ID_2>=Internal/subscriber
    <AZURE_AD_GROUP_ID_3>=admin
    ```

## Step 4 - Test the configuration

1. Access the WSO2 API Manager Publisher portal at `https://localhost:9443/publisher`.

2. Click **Sign In** and you should see the Azure AD login option.

3. Select **Azure AD** and you will be redirected to the Azure AD login page.

4. Enter your Azure AD credentials and complete the authentication.

5. Upon successful authentication, you should be redirected back to the Publisher portal.

## Troubleshooting

### Common issues and solutions

**Issue 1: Redirect URI mismatch**
- **Error**: `AADSTS50011: The reply URL specified in the request does not match the reply URLs configured for the application`
- **Solution**: Ensure the redirect URI in Azure AD matches exactly with the one configured in WSO2 API Manager

**Issue 2: Invalid client secret**
- **Error**: `AADSTS7000215: Invalid client secret is provided`
- **Solution**: Verify that the client secret is copied correctly and has not expired

**Issue 3: Insufficient permissions**
- **Error**: `AADSTS65001: The user or administrator has not consented to use the application`
- **Solution**: Grant admin consent for the required API permissions in Azure AD

**Issue 4: User provisioning fails**
- **Error**: Users are authenticated but not provisioned in WSO2 API Manager
- **Solution**: Ensure JIT provisioning is enabled and the user store is properly configured

### Enable debug logs

To troubleshoot authentication issues, enable debug logs by adding the following to `<API-M_HOME>/repository/conf/log4j2.properties`:

```properties
logger.org-wso2-carbon-identity-application-authenticator-oidc.name = org.wso2.carbon.identity.application.authenticator.oidc
logger.org-wso2-carbon-identity-application-authenticator-oidc.level = DEBUG
logger.org-wso2-carbon-identity-application-authenticator-oidc.additivity = false
logger.org-wso2-carbon-identity-application-authenticator-oidc.appenderRef.CARBON_CONSOLE.ref = CARBON_CONSOLE
```

## Advanced configuration

### Custom claim mappings

You can customize how Azure AD claims are mapped to WSO2 API Manager claims:

```toml
[[authentication.authenticator.oidc.claim_mappings]]
remote_claim = "given_name"
local_claim = "http://wso2.org/claims/givenname"

[[authentication.authenticator.oidc.claim_mappings]]
remote_claim = "family_name"
local_claim = "http://wso2.org/claims/lastname"

[[authentication.authenticator.oidc.claim_mappings]]
remote_claim = "upn"
local_claim = "http://wso2.org/claims/username"
```

### Configure multi-tenancy

For multi-tenant scenarios, configure tenant-specific identity providers:

```toml
[[authentication.authenticator.oidc]]
name = "AzureAD-Tenant1"
enable = true

[authentication.authenticator.oidc.parameters]
# Tenant-specific configuration
```

This completes the Azure AD OIDC integration with WSO2 API Manager. Users can now authenticate using their Azure AD credentials to access the Publisher and Developer Portal.