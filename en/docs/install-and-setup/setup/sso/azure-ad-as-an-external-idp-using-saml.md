# Using Azure AD as an external IdP with SAML 2.0

Follow the instructions below to connect Azure Active Directory (Azure AD) as a third-party Identity Provider to WSO2 API Manager using SAML 2.0.

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

2. Navigate to **Azure Active Directory** > **Enterprise applications**.

3. Select **New application** > **Create your own application**.

4. Enter a name for your application (e.g., `WSO2-API-Manager-SAML`) and select **Integrate any other application you don't find in the gallery**.

5. After creating the application, navigate to **Single sign-on** and select **SAML**.

6. Configure the basic SAML settings:

    | Field | Value |
    |-------|-------|
    | Identifier (Entity ID) | `https://localhost:9443/samlsso` |
    | Reply URL (Assertion Consumer Service URL) | `https://localhost:9443/commonauth` |
    | Sign on URL | `https://localhost:9443/publisher` |

    !!! note
        Replace `localhost:9443` with your actual WSO2 API Manager host and port if you are not running it locally.

7. Configure user attributes and claims:
   - Azure AD automatically includes standard claims like email, given name, and surname
   - Optionally add custom claims if needed:
     - Name: `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`
     - Source: `user.mail`

8. Download the federation metadata XML or note the following from the **SAML Signing Certificate** section:
   - **App Federation Metadata Url**
   - **Certificate (Base64)** (download the certificate)

9. Configure Azure AD groups (optional, for role mapping):
   - Navigate to **User attributes & claims**
   - Add a group claim:
     - Name: `groups`
     - Source: `Groups assigned to the application`
     - Namespace: Leave empty

## Step 2 - Configure WSO2 API Manager

1. Open the `deployment.toml` file in the `<API-M_HOME>/repository/conf/` directory.

2. Add the following configuration to enable Azure AD as a SAML identity provider:

    ```toml
    [authentication.authenticator.saml]
    name = "SAMLSSOAuthenticator"
    enable = true

    [authentication.authenticator.saml.parameters]
    IdPEntityId = "https://sts.windows.net/<TENANT_ID>/"
    SPEntityId = "https://localhost:9443/samlsso"
    SSOUrl = "https://login.microsoftonline.com/<TENANT_ID>/saml2"
    IsAuthnReqSigned = false
    IsLogoutEnabled = true
    LogoutReqUrl = "https://login.microsoftonline.com/<TENANT_ID>/saml2"
    IsLogoutReqSigned = false
    IsAuthnRespSigned = true
    IsAssertionSigned = false
    IsAssertionEncrypted = false
    IncludeNameIDPolicy = true
    NameIDPolicyFormat = "urn:oasis:names:tc:SAML:2.0:nameid-format:emailAddress"
    IsUserIdInClaims = true
    IsAssertionSigningEnabled = false
    IsAuthnReqSigningEnabled = false
    ```

    Replace `<TENANT_ID>` with your Azure AD tenant ID.

3. Configure the Azure AD certificate for SAML signature validation:

    a. Download the certificate from Azure AD (Base64 format).

    b. Copy the certificate to `<API-M_HOME>/repository/resources/security/`.

    c. Import the certificate to the WSO2 truststore:

    ```bash
    keytool -import -alias azuread -file <path-to-certificate.cer> -keystore client-truststore.jks -storepass wso2carbon
    ```

4. Configure user attribute mapping:

    ```toml
    [authentication.authenticator.saml.parameters]
    userIdClaim = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
    RolesClaim = "groups"
    ```

5. Add the following configuration for Just-in-Time (JIT) user provisioning:

    ```toml
    [authentication.authenticator.saml.parameters]
    commonAuthQueryParams = "isJITEnabled=true"
    IsProvisioningEnabled = true
    ProvisioningUserStore = "PRIMARY"
    ```

6. Configure claim mappings:

    ```toml
    [[authentication.authenticator.saml.claim_mappings]]
    remote_claim = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
    local_claim = "http://wso2.org/claims/givenname"

    [[authentication.authenticator.saml.claim_mappings]]
    remote_claim = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
    local_claim = "http://wso2.org/claims/lastname"

    [[authentication.authenticator.saml.claim_mappings]]
    remote_claim = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
    local_claim = "http://wso2.org/claims/emailaddress"
    ```

7. Restart the WSO2 API Manager server.

## Step 3 - Configure role mapping (Optional)

If you want to map Azure AD groups to WSO2 API Manager roles:

1. Ensure groups are included in the SAML response from Azure AD (configured in Step 1).

2. Update the WSO2 API Manager configuration in `deployment.toml`:

    ```toml
    [authentication.authenticator.saml.parameters]
    RolesClaim = "groups"

    [[authentication.authenticator.saml.claim_mappings]]
    remote_claim = "groups"
    local_claim = "http://wso2.org/claims/role"
    ```

3. Create a role mapping configuration:

    ```toml
    [authentication.role_mapping]
    enable = true

    [[authentication.role_mapping.mappings]]
    remote_role = "<AZURE_AD_GROUP_ID_1>"
    local_roles = ["Internal/publisher"]

    [[authentication.role_mapping.mappings]]
    remote_role = "<AZURE_AD_GROUP_ID_2>"
    local_roles = ["Internal/subscriber"]
    ```

## Step 4 - Configure WSO2 API Manager metadata

1. Access the SAML metadata endpoint: `https://localhost:9443/identity/metadata/saml2`

2. In Azure AD, you can also import the WSO2 metadata:
   - In the Azure application, go to **Single sign-on** > **Basic SAML Configuration**
   - Select **Upload metadata file** and upload the XML from the WSO2 metadata endpoint

## Step 5 - Test the configuration

1. Access the WSO2 API Manager Publisher portal at `https://localhost:9443/publisher`.

2. Click **Sign In** and you should see the Azure AD SAML login option.

3. Select **Azure AD SAML** and you will be redirected to the Azure AD login page.

4. Enter your Azure AD credentials and complete the authentication.

5. Upon successful authentication, you should be redirected back to the Publisher portal.

## Troubleshooting

### Common issues and solutions

**Issue 1: SAML response validation fails**
- **Error**: `SAML response validation failed`
- **Solution**: Ensure the Azure AD certificate is properly imported to the WSO2 truststore and the IdP entity ID matches

**Issue 2: NameID format mismatch**
- **Error**: `Invalid NameID format in SAML response`
- **Solution**: Verify the NameIDPolicyFormat in WSO2 matches the format sent by Azure AD

**Issue 3: Clock skew issues**
- **Error**: `SAML assertion is not valid due to time restrictions`
- **Solution**: Ensure system clocks are synchronized between Azure AD and WSO2 API Manager

**Issue 4: Assertion Consumer Service URL mismatch**
- **Error**: `Invalid Assertion Consumer Service URL`
- **Solution**: Verify the Reply URL in Azure AD matches the commonauth endpoint in WSO2

### Enable debug logs

To troubleshoot SAML authentication issues, enable debug logs by adding the following to `<API-M_HOME>/repository/conf/log4j2.properties`:

```properties
logger.org-wso2-carbon-identity-application-authenticator-samlsso.name = org.wso2.carbon.identity.application.authenticator.samlsso
logger.org-wso2-carbon-identity-application-authenticator-samlsso.level = DEBUG
logger.org-wso2-carbon-identity-application-authenticator-samlsso.additivity = false
logger.org-wso2-carbon-identity-application-authenticator-samlsso.appenderRef.CARBON_CONSOLE.ref = CARBON_CONSOLE
```

## Advanced configuration

### Configure SAML request signing

To sign SAML requests (recommended for production):

1. Generate a keystore for WSO2 API Manager:

    ```bash
    keytool -genkey -alias wso2apim -keyalg RSA -keystore wso2apim.jks -storepass wso2carbon -keypass wso2carbon
    ```

2. Update the WSO2 configuration:

    ```toml
    [authentication.authenticator.saml.parameters]
    IsAuthnReqSigned = true
    KeyStoreFilePath = "<API-M_HOME>/repository/resources/security/wso2apim.jks"
    KeyStorePassword = "wso2carbon"
    CertAlias = "wso2apim"
    ```

3. Export the public certificate and upload it to Azure AD:

    ```bash
    keytool -export -alias wso2apim -file wso2apim.crt -keystore wso2apim.jks -storepass wso2carbon
    ```

### Configure assertion encryption

To encrypt SAML assertions:

1. Upload the WSO2 public certificate to Azure AD in the **SAML Signing Certificate** section.

2. Update the WSO2 configuration:

    ```toml
    [authentication.authenticator.saml.parameters]
    IsAssertionEncrypted = true
    ```

### Configure logout

To enable SAML logout:

1. Configure logout URL in Azure AD under **Basic SAML Configuration**:
   - Logout Url: `https://localhost:9443/commonauth`

2. Update the WSO2 configuration:

    ```toml
    [authentication.authenticator.saml.parameters]
    IsLogoutEnabled = true
    LogoutReqUrl = "https://login.microsoftonline.com/<TENANT_ID>/saml2"
    IsLogoutReqSigned = false
    ```

This completes the Azure AD SAML 2.0 integration with WSO2 API Manager. Users can now authenticate using their Azure AD credentials to access the Publisher and Developer Portal.