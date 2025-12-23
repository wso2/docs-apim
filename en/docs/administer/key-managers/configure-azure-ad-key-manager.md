# Configure a Azure AD as a Key Manager

WSO2 API Manager supports multiple Key Managers. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager and with the use of connectors it is capable of supporting any authorization server as a Key Manager.

Therefore, WSO2 API Manager can connect Azure AD out-of-the-box using the [WSO2 API-M KM Azure AD Connector](https://github.com/wso2-extensions/apim-km-azure-ad/).

Follow the instructions given below to configure AzureAD as a third-party Key Manager. 

!!! info
    For more information, see the [Getting Started Guide, which is under the official Azure Entra ID documentation](https://learn.microsoft.com/en-us/entra/identity/).

## Configure AzureAD

1. Create An Azure account that has an active subscription. [Create an account for free](https://azure.microsoft.com/en-gb/free/?WT.mc_id=A261C142F).
    
2. The Azure account must have permission to manage applications in Azure Active Directory (Azure AD). Any of the following Azure AD roles include the required permissions:

       - Application administrator
       - Application developer
       - Cloud application administrator
  
This will complete the  [Set up a tenant](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-create-new-tenant) quickstart.

### Step 1 - Create Application

1. Visit [Azure Home](https://portal.azure.com/#home).
2. Navigate to [Microsoft Entra ID](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Overview).
3. Navigate to [App Registration](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps).
4. Navigate to New registration, Give a name `(Ex : KeyManger Client)` and Click Register.

### Step 2 - Create secrets

  1. Navigate to `Certificates & secrets`>`Client secrets`>`New client secret`.
  2. Fill the form with relevant information and give `Custom` as the value for Expire.
  3. Make sure to copy the secret, it only shows once.
   
### Step 3 - Configured permissions

  1. Navigate to `API Permissions`.
  2. Click `Add a permission`.
  3. Select `APIs my organization uses`.
  4. Select `Microsoft Graph` from the list.
  5. Click on `Application permissions`.
  6. Expand `Application` and check
      - Application.Read.All
      - Application.ReadWrite.All
      - Application.ReadWrite.OwnedBy
  7. Click `Add permissions`.
  8. Click `Grant admin consent for Default Directory`.

Ensure that the newly added permissions display a green checkmark to indicate successful configuration.

[![Azure AD Permission]({{base_path}}/assets/img/administer/azuread-grant-permission.png){: style="width:90%"}]({{base_path}}/assets/img/administer/azuread-grant-permission.png)

### Step 4 - Copy Application Details
  1. Navigate to [Microsoft Entra ID](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Overview).
  2. Click on 'Endpoints' and Note down
      - OAuth 2.0 token endpoint (v2.0)
      </br>e.g. `https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/token`
      - OpenID Connect metadata document (v2.0)
      </br>e.g. `https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration`
      - Microsoft Graph API endpoint
      </br>e.g. `https://graph.microsoft.com`
  3. Under `Owned applications` click on the newly created application.
  4. Copy the Application (client) ID.

## Configure API manager

Start the API Manager server and log-in to the Admin portal to configure Azure AD as a Key Manager.

### Step 1 - Configure Key Manager

  1. Click on `Key Managers` from the side panel and then click `Add Key Manager`.
  2. Fill the following
    - Name: `AzureAD`
    - Display Name: `Azure AD Key Manager`
    - Description (optional)
  3. Select the Key manager type as `Azure AD` and provide the relevant details in the `Key Manager Endpoints` section.
  <table>
    <thead>
      <tr>
        <th>Configuration</th>
        <th>Instruction</th>
        <th> </th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Well-known URL</td>
        <td>
          Paste the <code>OpenID Connect metadata document (v2.0)</code> URL collected from the endpoints 
          and click on <code>Import</code>
        </td>
      </tr>
      <tr>
        <td>Issuer</td>
        <td>The issuer that consumes or validates access tokens. <br/><b>Example:</b><br/> https://login.microsoftonline.com/{tenent-id}/v2.0</td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Client Registration Endpoint</td>
        <td>Paste the <code>Microsoft Graph API endpoint</code></td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Introspection Endpoint</td>
        <td>
          Paste the OAuth 2.0 token endpoint (v2) URL 
          (token introspection is not supported in Azure AD)
        </td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Token Endpoint</td>
        <td>
          Paste the OAuth 2.0 token endpoint (v2) URL
        </td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Display Token Endpoint</td>
        <td>
          Paste the OAuth 2.0 token endpoint (v2) URL
        </td>
        <td>Optional</td>
      </tr>
      <tr>
        <td>Revoke Endpoint</td>
        <td>
          Paste the OAuth 2.0 token endpoint (v2) URL 
          (token revocation is not supported in Azure AD)
        </td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Display Revoke Endpoint</td>
        <td>
          Paste the OAuth 2.0 token endpoint (v2) URL
        </td>
        <td>Optional</td>
      </tr>
      <tr>
        <td>Userinfo Endpoint</td>
        <td>The endpoint that allows clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user. <br/><b>Example:</b><br/> https://graph.microsoft.com/oidc/userinfo</td></td>
        <td>Mandatory</td>
      </tr>
      <tr class="odd">
        <td>Authorize Endpoint</td>
        <td>The endpoint is used to obtain an authorization grant from the resource owner via the user-agent redirection. <br/><b>Example:</b><br/> https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/authorize</td></td>
        <td>Optional</td>
      </tr>
      <tr class="even">
        <td>Scope Management Endpoint </td>
        <td>The endpoint is used to manage the scopes. <br/><b>Example:</b><br/> https://&lt;host&gt;:9443/oauth2/scope</td>
        <td>Mandatory</td>
      </tr>
    </tbody>
  </table>

 4. Fill the Consumer Key Claim URI: `appid` in the `Claim URIs` section.
 5. Set the Grant Types: `client_credentials` (Only use this grant type).
 6. Provide the relevant details in the `Connector Configurations` section.
  <table>
    <thead>
      <tr>
        <th>Configuration</th>
        <th>Instruction</th>
        <th> </th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Microsoft Graph API Endpoint</td>
        <td>Paste the <code>Microsoft Graph API endpoint</code><br></td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Microsoft Graph API Endpoint Version</td>
        <td>Select the checkbox for `v1.0`</td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Client ID</td>
        <td>Paste the <code>Application (client) ID</code></td>
        <td>Mandatory</td>
      </tr>
      <tr>
        <td>Client Secret</td>
        <td>Paste the client secret value that is generated</td>
        <td>Mandatory</td>
      </tr>
    </tbody>
  </table>
  7. Set the **Permissions**:
    - **Key Manager Permission**: Permission type for role-based Key Manager restriction.  
      e.g., `PUBLIC`, `ALLOW`, `DENY` (Optional)
 8. Click on `Add`.
   
### Step 2 - Create an Application & Generate Keys

   1. Click on `Add New Application`.
   2. Fill the required information and click on `Add`.
   3. Once created, navigate to the `Production Keys` section of that Application.
   4. Select the `Azure AD Key Manager` and click on `Generate Keys`.

!!! note "Troubleshooting Invalid Credentials Error"
    If you encounter the following error message when using a token generated by the Key Manager to invoke an API deployed in APIM:
    ```bash
    {
      "code": "900901",
      "message": "Invalid Credentials",
      "description": "Access failure for API: /exampleapi/1.0.0, version: 1.0.0 status: (900901) - Invalid Credentials. Make sure you have provided the correct security credentials."
    }
    ```
    Please verify that the `iss` (issuer) claim in the token matches the issuer configured in the Key Manager Endpoints section. To obtain the `iss` value from the token, decode the JWT token (you can use tools like [jwt.io](https://jwt.io) or similar JWT decoder) and check the `iss` claim in the payload. If there is a difference, update the issuer in the Key Manager Endpoints section to align with the `iss` value present in the token.

### Post checks
  
  Under [App registration](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps) there should be a newly created application. The value should be
        
         `api://<Application (client) ID>`
        
  We can also get this value by clicking the `set` link right next to the label. Default value is what we will see above.

  Without this in the app, the token will be generate in a version 1 format and will not work with APIM KM due to failed signature.

### Update the client_password

  Update password is not supported by providing new one from the APIM. Whenever the application is updated via APIM a new `client_secret` is set.

  ```Failed to add password. Error detail: Unable to save changes because the credential limit has been reached. Please delete a credential and try again.```

  If you see this message in logs or while updating the application several times, The issue is with limitation with Azure AD `client_secret`. At a given application max number of client_secrets can have is 2. Delete old one from AzureAD console web client.

### Adding existing key with APIM
    
  With the limitation on getting generated `client_secrets` after its generated, it not support to add existing keys from APIM.
  