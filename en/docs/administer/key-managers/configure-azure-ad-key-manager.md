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
4. Navigate to New registration, Give a name `(Ex : KeyManger Client)` and Click Register

### Step 2 - Create secrets

  1. Navigate to `Certificates & secrets`>`Client secrets`>`New client secret`
  2. Fill the form with relevant information and give custom as the value for Expire.
  3. Make sure to copy the secret,it only shows once.
   
### Step 3 - Configured permissions

  1. Navigate to `API Permissions`
  2. Click `Add a permissions`
  3. Select `APIs my organization uses`
  4. Select `Microsoft Graph` fromt the list
  5. Click on `Application permissions`
  6. Expand `Application` and check
      - Application.Read.All
      - Application.ReadWrite.All
      - Application.ReadWrite.OwnedBy
  7. Click `Add permissions`

### Step 4 - Copy Application Details
  1. Navigate to [Microsoft Entra ID](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Overview).
  2. Click on 'Endpoints' and Note down
      - OAuth 2.0 token endpoint (v2) (NOT OAuth 2.0 token endpoint (v1))
      - OpenID Connect metadata document
      - Microsoft Graph API endpoint
  3. Under 'Owned applications' click on the newly created application
  4. Copy the Application (client) ID

## Configure API manager

Start the API Manager server and log-in to the Admin portal to configure Azure AD as a Key Manager.

### Step 1 - Configure Key Manager

1. Click on Key Managers from the side panel and then click Add Key Manager
2. Fill the following
    - Name: `AzureAD`
    - Display Name: `Azure AD Key Manager`
    - Description(optional)
    - Key Manager Type: `Azure AD`
    - Grant Types: `client_credentials` (Only Use this grant type)
  
 3. Fill these Connector Configurations

  <table>
<thead>
  <tr>
    <th>Configuration</th>
    <th>Instruction</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Microsoft Graph API Endpoint</td>
    <td>Paste the `Microsoft Graph API endpoint`<br></td>
  </tr>
  <tr>
    <td>Client ID</td>
    <td>Paste the `Application (client) ID`</td>
  </tr>
  <tr>
    <td>Client Secret </td>
    <td>Paste the client secret value that is generated</td>
  </tr>
  <tr>
    <td>Well-known URL</td>
    <td>Paste the ``OpenID Connect metadata document` URL collected from the endpoints and click on `Import`</td>
  </tr>
  <tr>
    <td>Client Registration Endpoint</td>
    <td>Paste the `Microsoft Graph API endpoint`</td>
  </tr>
  <tr>
    <td>Introspection Endpoint</td>
    <td>Paste the OAuth 2.0 token endpoint (v2) URL (token introspection is not supported in Azure AD)</td>
  </tr>
  <tr>
    <td>Revoke Endpoint</td>
    <td>Paste the OAuth 2.0 token endpoint (v2) URL (token revocation is not supported in Azure AD)</td>
  </tr>
</tbody>
</table>

 4. Click on `Add`.
   
### Step 2 - Create an Application & Generate Keys

   1. Click on Add New Application
   2. Fill the required information and click on Add
   3. Once created, navigate to the Production Keys section of that Application
   4. Select the Azure AD Key Manager and click on Generate Keys
   
### Post checks
  
  Under [App registration](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps) there should be newly created application. The value should be
        
         `api://<Application (client) ID>`
        
  We can also get this value by clicking the `set` link right next to the label. Default value is what we will see above.

  Without this in the app,the token will be generate in a version 1 format and will not work with APIM KM due to failed signature.

### Update the client_password

  Update password is not supported by providing new one from the APIM. When ever the application is updated via APIM a new client_secret is set.

  ```Failed to add password. Error detail: Unable to save changes because the credential limit has been reached. Please delete a credential and try again.```

  If you see this message in logs or while updating the application several times, The issue is with limitation with Azure AD client_secret. At a given application max number of client_secrets can have is 2. Delete old one from AzureAD console web client.

### Adding existing key with APIM
    
  With the limitation on getting generated client_secrets after its generated, it not support to add existing keys from APIM.