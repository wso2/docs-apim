# Using Azure AD as an External IDP with OIDC

Follow the instructions below to connect Azure Active Directory (Azure AD) as a third-party Identity Provider to WSO2 API Manager.

## Prerequisites

Before you begin, make sure you do the following.

1. Create an account in [Azure Portal](https://portal.azure.com/) with appropriate permissions to manage Azure AD applications.
2. Download the WSO2 API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
3. Enable the email domain on WSO2 API Manager.

     You need to enable this because Azure AD uses the email as the username by default. As the email domain is not enabled by default, you have to enable it to use the email as the username in WSO2 API Manager. Once enabled, you can use your email or a normal username as your username.

     Follow the instructions below:

     1. Unzip the WSO2 API Manager distribution.
     2. Open the `deployment.toml` file, which is located in the `<API-M_HOME>/repository/conf/` directory. 
     3. Add the following configuration.

        ```
        [tenant_mgt]
        enable_email_domain= true
        ```

4. Start the WSO2 API Manager server.

## Step 1 - Configure Azure AD

!!! note
    For more information on working with Azure AD applications, see the official [Azure AD documentation](https://docs.microsoft.com/en-us/azure/active-directory/).

1. Navigate to the Azure Portal and sign in.

2. Go to **Azure Active Directory** > **App registrations**.

3. Click **New registration** to create a new application.

4. Configure the application with the following settings:

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
      <td>Accounts in this organizational directory only (Single tenant)</td>
      </tr>
      <tr>
      <td>Redirect URI (optional)</td>
      <td>Web: <code>https://localhost:9443/commonauth</code></td>
      </tr>
    </table>

5. Click **Register** to create the application.

6. After the application is created, note down the following values from the **Overview** page:
   - **Application (client) ID**
   - **Directory (tenant) ID**

7. Navigate to **Certificates & secrets** and create a new client secret:
   1. Click **New client secret**.
   2. Add a description and set an expiration period.
   3. Click **Add**.
   4. **Important**: Copy the **Value** of the client secret immediately as it won't be displayed again.

8. Navigate to **Authentication** and configure the following:
   1. Under **Redirect URIs**, ensure `https://localhost:9443/commonauth` is added.
   2. Under **Logout URL**, add `https://localhost:9443/commonauth`.
   3. Under **Implicit grant and hybrid flows**, check:
      - **Access tokens**
      - **ID tokens**

9. Navigate to **API permissions**:
   1. Ensure **Microsoft Graph** permissions are granted.
   2. The default **User.Read** permission should be sufficient.
   3. Click **Grant admin consent** if required.

10. Navigate to **Token configuration**:
    1. Click **Add optional claim**.
    2. Select **ID** token type.
    3. Add the following claims:
       - **email**
       - **given_name**
       - **family_name**
    4. Click **Add**.

## Step 2 - Configure API Manager

1. Sign in to the WSO2 API-M Management Console.

     `https://localhost:9443/carbon`.

2. Create a role that needs to be assigned to users that will be provisioned from Azure AD. 

    1. Click **Main**, **Identity**, and then click **Add** under **Users and Roles**.
    
    2. Click **Add New Role**.

         [![Add role for Azure AD in API-M]({{base_path}}/assets/img/learn/azure-ad-apim-add-role.png)]({{base_path}}/assets/img/learn/azure-ad-apim-add-role.png)
   
    3.  Add a new role based on the following details and click **Finish**.

         <table>
         <tr>
         <th><b>Field</b></th>
         <th><b>Value</b></th>
         </tr>
         <tr>
         <td>Domain</td>
         <td><code>Primary</code></td>
         </tr>
         <tr>
         <td>Role Name</td>
         <td><code>azure_ad_role</code></td>
         </tr>
         </table>
         
         <a href="{{base_path}}/assets/img/learn/azure-ad-apim-add-role-name.png"><img src="{{base_path}}/assets/img/learn/azure-ad-apim-add-role-name.png" width="50%"/></a>

3. Add scope mapping via the WSO2 API Manager Admin Portal.

    1. Sign in to the WSO2 API Manager Admin Portal.
    
         `https://localhost:9443/admin`
         
    2. Click **Settings** and then click **Scope Assignments**.

         [![Scope Assignments menu]({{base_path}}/assets/img/learn/scope-assignment-menu.png){:style="width:28%"}]({{base_path}}/assets/img/learn/scope-assignment-menu.png) 

    3. Click **Add Scope Mappings**.
     
         [![Azure AD API-M role permission mapping]({{base_path}}/assets/img/learn/azure-ad-apim-role-pemission-mapping-admin-ui.png)]({{base_path}}/assets/img/learn/azure-ad-apim-role-pemission-mapping-admin-ui.png) 
    
    4. Enter `azure_ad_role` as the role name and click **Next**.

         [![Edit Azure AD API-M role permission mapping]({{base_path}}/assets/img/learn/azure-ad-apim-role-permission-mapping-admin-ui-edit1.png)]({{base_path}}/assets/img/learn/azure-ad-apim-role-permission-mapping-admin-ui-edit1.png) 

    5. Go to **Select permissions**, click  **Custom permissions**, and start assigning the permissions as shown below. 
    
         These permissions will allow a user having the `azure_ad_role` to log in to the Publisher and the Developer Portal.

         <table>
         <tr>
         <th><b>Hierarchy</b></th>
         <th><b>Permissions</b></th>
         </tr>
         <tr>
         <td><b>admin</b></td>
         <td>
         <ul>
         <li>
         Retrieve and publish Monetization related usage records</br>
         <code>apim:monetization_usage_publish</code>
         </li>
         </ul>
         </td>
         </tr>
         <tr>
         <td><b>publisher</b></td>
         <td>
         <ul>
         <li>
         Manage all API related operations</br>
         <code>apim:api_manage</code>
         </li>
         <li>
         View common operation policies</br>
         <code>apim:common_operation_policy_view</code>
         </li>
         <li>
         Manage all Subscription related operations</br>
         <code>apim:subscription_manage</code>
         </li>
         <li>
         View, Retrieve API list</br>
         <code>apim:api_list_view</code>
         </li>
         <li>
         Add, Update and Delete common operation policies</br>
         <code>apim:common_operation_policy_manage</code>
         </li>
         <li>
         Create threat protection policies</br>
         <code>apim:threat_protection_policy_create</code>
         </li>
         <li>
         Update and delete mediation policies</br>
         <code>apim:mediation_policy_manage</code>
         </li>
         <li>
         Update and delete backend endpoint certificates</br>
         <code>apim:ep_certificates_update</code>
         </li>
         <li>
         View backend endpoint certificates</br>
         <code>apim:ep_certificates_view</code>
         </li>
         <li>
         Publish API</br>
         <code>apim:api_publish</code>
         </li>
         <li>
         Update and delete client certificates</br>
         <code>apim:client_certificates_update</code>
         </li>
         <li>
         View, Retrieve API definition</br>
         <code>apim:api_definition_view</code>
         </li>
         <li>
         Generate Internal Key</br>
         <code>apim:api_generate_key</code>
         </li>
         <li>
         View API</br>
         <code>apim:api_view</code>
         </li>
         <li>
         Create mediation policies</br>
         <code>apim:mediation_policy_create</code>
         </li>
         <li>
         Get/ subscribe/ configure publisher alerts</br>
         <code>apim:pub_alert_manage</code>
         </li>
         <li>
         Create, update and delete API documents</br>
         <code>apim:document_manage</code>
         </li>
         <li>
         View, create, update and remove endpoint certificates</br>
         <code>apim:ep_certificates_manage</code>
         </li>
         <li>
         Read permission to comments</br>
         <code>apim:comment_view</code>
         </li>
         <li>
         Write permission to comments</br>
         <code>apim:comment_write</code>
         </li>
         <li>
         View, update and delete throttling policies</br>
         <code>apim:tier_manage</code>
         </li>
         <li>
         Read and Write comments</br>
         <code>apim:comment_manage</code>
         </li>
         <li>
         View throttling policies</br>
         <code>apim:tier_view</code>
         </li>
         <li>
         Create API documents</br>
         <code>apim:document_create</code>
         </li>
         <li>
         Update and delete threat protection policies</br>
         <code>apim:threat_protection_policy_manage</code>
         </li>
         <li>
         View Subscription</br>
         <code>apim:subscription_view</code>
         </li>
         <li>
         Create API</br>
         <code>apim:api_create</code>
         </li>
         <li>
         Add client certificates</br>
         <code>apim:client_certificates_add</code>
         </li>
         <li>
         Delete API</br>
         <code>apim:api_delete</code>
         </li>
         <li>
         View client certificates</br>
         <code>apim:client_certificates_view</code>
         </li>
         <li>
         Retrieve store settings</br>
         <code>apim:publisher_settings</code>
         </li>
         <li>
         Block Subscription</br>
         <code>apim:subscription_block</code>
         </li>
         <li>
         View mediation policies</br>
         <code>apim:mediation_policy_view</code>
         </li>
         <li>
         View, create, update and remove client certificates</br>
         <code>apim:client_certificates_manage</code>
         </li>
         <li>
         Add backend endpoint certificates</br>
         <code>apim:ep_certificates_add</code>
         </li>
         <li>
         View, create, update and remove API specific mediation policies</br>
         <code>apim:api_mediation_policy_manage</code>
         </li>
         </ul>
         </td>
         </tr>
         <tr>
         <td><b>devportal</b></td>
         <td>
         <ul>
         <li>
         Retrieve, Manage and Import, Export applications</br>
         <code>apim:app_manage</code>
         </li>
         <li>
         Retrieve Developer Portal settings</br>
         <code>apim:store_settings</code>
         </li>
         <li>
         Retrieve, subscribe and configure Developer Portal alert types</br>
         <code>apim:sub_alert_manage</code>
         </li>
         <li>
         Generate API Keys</br>
         <code>apim:api_key</code>
         </li>
         <li>
         Retrieve, Manage subscriptions</br>
         <code>apim:sub_manage</code>
         </li>
         <li>
         Subscribe API</br>
         <code>apim:subscribe</code>
         </li>
         </ul>
         </td>
         </tr>
         </table>

        [![Azure AD API-M role permission mapping]({{base_path}}/assets/img/learn/azure-ad-apim-role-permission-mapping-admin-ui-edit2.png)]({{base_path}}/assets/img/learn/azure-ad-apim-role-permission-mapping-admin-ui-edit2.png)

    6. Click **Save** to save your changes.

4. Add an Identity Provider.

     1. Sign in to the WSO2 API-M Management Console.
     
         `https://localhost:9443/carbon`. 
     
     2. Click **Main** and then click **Add** under  **Identity Providers**. 
     
     3. Enter the Identity Provider's Name as `Azure-AD-IDP`.

         [![Add an IDP for Azure AD OIDC]({{base_path}}/assets/img/learn/azure-ad-oidc-add-idp.png)]({{base_path}}/assets/img/learn/azure-ad-oidc-add-idp.png) 

     4. Expand **Federated Authenticators** -> **OAuth2/OpenID Connect Configuration** and add the following details.
        
        [![API-M IDP OIDC details]({{base_path}}/assets/img/learn/azure-ad-apim-idp-oidc-details.png)]({{base_path}}/assets/img/learn/azure-ad-apim-idp-oidc-details.png)

        <table>
        <colgroup>
            <col />
            <col />
            <col />
        </colgroup>
        <tbody>
            <tr>
                <th colspan="2"><b>Field</b></th>
                <th><b>Sample value</b></th>
            </tr>
            <tr>
                <td colspan="2">Enable OAuth2/OpenIDConnect</td>
                <td>True</td>
            </tr>
            <tr>
                <td colspan="2">Client ID</td>
                <td>The Application (client) ID from the Azure AD application</td>
            </tr>
            <tr>
                <td colspan="2">Client Secret</td>
                <td>The client secret value from the Azure AD application</td>
            </tr>
            <tr>
                <td colspan="2">Authorization Endpoint URL</td>
                <td><code>https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/authorize</code></td>
            </tr>
            <tr>
                <td colspan="2">Token Endpoint URL</td>
                <td><code>https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/token</code></td>
            </tr>
            <tr>
                <td colspan="2">Callback URL</td>
                <td>
                    <code>https://localhost:9443/commonauth</code>
                </td>
            </tr>
            <tr>
                <td colspan="2">Userinfo Endpoint URL</td>
                <td>
                    <code>https://graph.microsoft.com/oidc/userinfo</code>
                </td>
            </tr>
            <tr>
                <td colspan="2">Logout Endpoint URL</td>
                <td>
                    <code>https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/logout</code>
                </td>
            </tr>
            <tr>
                <td colspan="2">Additional Query Parameters</td>
                <td>
                    <code>scope=openid profile email</code>
                </td>
            </tr>
        </tbody>
        </table>

        !!! note
            Replace `{tenant-id}` in the URLs above with your Azure AD tenant ID that you noted down earlier.

     5. Expand **Claim Configuration** -> **Basic Claim Configuration**. 
     
         Add the claim configurations as shown in the image below.
         
         [![Azure AD API-M IDP claims details]({{base_path}}/assets/img/learn/azure-ad-apim-idp-claims-details.png)]({{base_path}}/assets/img/learn/azure-ad-apim-idp-claims-details.png) 

        Configure the following claim mappings:

        <table>
        <tr>
        <th><b>Claim URI</b></th>
        <th><b>Local Claim</b></th>
        </tr>
        <tr>
        <td>email</td>
        <td>http://wso2.org/claims/emailaddress</td>
        </tr>
        <tr>
        <td>given_name</td>
        <td>http://wso2.org/claims/givenname</td>
        </tr>
        <tr>
        <td>family_name</td>
        <td>http://wso2.org/claims/lastname</td>
        </tr>
        <tr>
        <td>email</td>
        <td>http://wso2.org/claims/username</td>
        </tr>
        </table>

     6. Expand **Role configuration** and add `azure_ad_role` as shown below. 
     
         Since Azure AD doesn't provide role information by default in basic claims, we'll assign the `azure_ad_role` to all federated users. For more advanced role mapping, you would need to configure custom claims in Azure AD.

        <a href="{{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-role-mapping.png"><img src="{{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-role-mapping.png"/></a>

     7. Enable **Just-in-Time Provisioning** for the user to be saved in the API Manager user store.

         <a href="{{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-jit.png"><img src="{{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-jit.png" width="600"/></a>

    !!! info
        When Just-In-Time Provisioning is enabled, the user details will be saved in the API Manager user store. User profile details will be updated via the federation following each login event. To preserve the user profile details without any changes, you need to enable `SystemRolesRetainedProvisionHandler`.
        
        Add the following to the `<API-M_HOME>/repository/conf/deployment.toml` file and restart the server.

        ```
        [authentication.framework.extensions]
        provisioning_handler = "org.wso2.carbon.identity.application.authentication.framework.handler.provisioning.impl.SystemRolesRetainedProvisionHandler"
        ```

5. Update the Service Providers.

    1. Click **Service Providers** -> **List** in the WSO2 API-M Management Console.
        
        There are two service providers available by default; `apim_publisher` and `apim_devportal`. 
        
    2. Click **Edit** to edit `apim_publisher`.

        !!! warning
            You need to have signed in to the Developer Portal and Publisher at least once for the two service providers to appear, as it is created during the first sign in.

        [![Azure AD API-M role OIDC SP]({{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-sp.png)]({{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-sp.png)

    3. Expand **Local & Outbound Authentication Configuration** under **Federated Authentication** and select the identity provider you created (`Azure-AD-IDP`).

         [![Azure AD API-M role OIDC SP outbound]({{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-sp-outbound.png)]({{base_path}}/assets/img/learn/azure-ad-apim-role-oidc-sp-outbound.png)
    
    4. Repeat the latter mentioned two steps for `apim_devportal`.

         Now you will be able to Sign in to the Publisher and Developer Portal using Azure AD.

         [![Azure AD API-M login]({{base_path}}/assets/img/learn/azure-ad-login.png){: style="width:30%"}]({{base_path}}/assets/img/learn/azure-ad-login.png)

## Advanced Configuration

### Custom Role Mapping

If you need to map specific Azure AD groups or roles to WSO2 API Manager roles, you can configure custom claims in Azure AD:

1. In Azure AD, navigate to **Enterprise applications** > **Your Application** > **Single sign-on**.
2. In the **User Attributes & Claims** section, add a new claim for groups:
   - **Name**: `groups`
   - **Source**: Groups assigned to the user
3. Update the WSO2 API Manager claim configuration to include the groups claim.
4. Configure role mappings based on the group claims received from Azure AD.

### Troubleshooting

1. **Login fails**: Verify that all URLs are correctly configured and accessible.
2. **Claims not received**: Check that optional claims are properly configured in Azure AD.
3. **Role assignment issues**: Ensure that the role mappings are correctly configured in both Azure AD and WSO2 API Manager.

For more detailed troubleshooting, check the WSO2 API Manager logs at `<API-M_HOME>/repository/logs/`.