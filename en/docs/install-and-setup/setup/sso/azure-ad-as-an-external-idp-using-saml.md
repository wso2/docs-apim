# Using Azure AD as an External IDP with SAML

Follow the instructions below to connect Azure Active Directory (Azure AD) as a third-party Identity Provider to WSO2 API Manager using SAML 2.0.

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

2. Go to **Azure Active Directory** > **Enterprise applications**.

3. Click **New application** > **Create your own application**.

4. Enter the application name as `WSO2-API-Manager-SAML` and select **Integrate any other application you don't find in the gallery (Non-gallery)**.

5. Click **Create**.

6. Once the application is created, navigate to **Single sign-on** from the left menu.

7. Select **SAML** as the single sign-on method.

8. Configure the **Basic SAML Configuration**:

    <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Identifier (Entity ID)</td>
      <td><code>apim_publisher</code> (for Publisher portal)<br/>
          <code>apim_devportal</code> (for DevPortal)</td>
      </tr>
      <tr>
      <td>Reply URL (Assertion Consumer Service URL)</td>
      <td><code>https://localhost:9443/commonauth</code></td>
      </tr>
      <tr>
      <td>Sign on URL (optional)</td>
      <td><code>https://localhost:9443/publisher</code> (for Publisher)<br/>
          <code>https://localhost:9443/devportal</code> (for DevPortal)</td>
      </tr>
      <tr>
      <td>Logout URL (optional)</td>
      <td><code>https://localhost:9443/commonauth</code></td>
      </tr>
    </table>

    !!! note
        If you need to configure both Publisher and DevPortal, you may need to create separate applications in Azure AD for each, or use a single application with multiple entity IDs.

9. Configure **User Attributes & Claims**:

    Ensure the following claims are configured:

    <table>
      <tr>
      <th><b>Claim Name</b></th>
      <th><b>Source Attribute</b></th>
      </tr>
      <tr>
      <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name</td>
      <td>user.mail</td>
      </tr>
      <tr>
      <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress</td>
      <td>user.mail</td>
      </tr>
      <tr>
      <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname</td>
      <td>user.givenname</td>
      </tr>
      <tr>
      <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname</td>
      <td>user.surname</td>
      </tr>
    </table>

10. Download the **Certificate (Base64)** and note down the **Login URL** from the **Set up WSO2-API-Manager-SAML** section.

11. Assign users or groups to the application:
    1. Navigate to **Users and groups**.
    2. Click **Add user/group**.
    3. Select the users or groups that should have access to WSO2 API Manager.

## Step 2 - Configure API Manager

1. Sign in to the WSO2 API-M Management Console.

     `https://localhost:9443/carbon`.

2. Create a role that needs to be assigned to users that will be provisioned from Azure AD. 

    1. Click **Main**, **Identity**, and then click **Add** under **Users and Roles**.
    
    2. Click **Add New Role**.

         [![Add role for Azure AD in API-M]({{base_path}}/assets/img/learn/azure-ad-apim-add-role.png)]({{base_path}}/assets/img/learn/azure-ad-apim-add-role.png)
   
    3. Add a new role based on the following details and click **Finish**.

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
     
    4. Enter `azure_ad_role` as the role name and click **Next**.

    5. Go to **Select permissions**, click **Custom permissions**, and start assigning the permissions as shown below. 
    
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

    6. Click **Save** to save your changes.

4. Upload the Azure AD certificate to the WSO2 API Manager keystore.

    1. Copy the Base64 certificate downloaded from Azure AD.
    2. Save it as a `.pem` file (e.g., `azure-ad-cert.pem`).
    3. Convert it to a format that can be imported into the keystore:

        ```bash
        keytool -import -alias azure-ad -file azure-ad-cert.pem -keystore <API-M_HOME>/repository/resources/security/wso2carbon.jks -storepass wso2carbon
        ```

5. Add an Identity Provider.

     1. Sign in to the WSO2 API-M Management Console.
     
         `https://localhost:9443/carbon`. 
     
     2. Click **Main** and then click **Add** under **Identity Providers**. 
     
     3. Enter the Identity Provider's Name as `Azure-AD-SAML-IDP`.

         [![Add an IDP for Azure AD SAML]({{base_path}}/assets/img/learn/azure-ad-saml-add-idp.png)]({{base_path}}/assets/img/learn/azure-ad-saml-add-idp.png) 

     4. Expand **Federated Authenticators** -> **SAML2 Web SSO Configuration** and add the following details.
        
        [![API-M IDP SAML details]({{base_path}}/assets/img/learn/azure-ad-apim-idp-saml-details.png)]({{base_path}}/assets/img/learn/azure-ad-apim-idp-saml-details.png)

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
                <td colspan="2">Enable SAML2 Web SSO</td>
                <td>True</td>
            </tr>
            <tr>
                <td colspan="2">Service Provider Entity Id</td>
                <td><code>apim_publisher</code> (or <code>apim_devportal</code>)</td>
            </tr>
            <tr>
                <td colspan="2">Identity Provider Entity Id</td>
                <td>The Identifier from Azure AD (usually starts with <code>https://sts.windows.net/</code>)</td>
            </tr>
            <tr>
                <td colspan="2">SSO URL</td>
                <td>The Login URL from Azure AD</td>
            </tr>
            <tr>
                <td colspan="2">Logout URL</td>
                <td>The Logout URL from Azure AD</td>
            </tr>
            <tr>
                <td colspan="2">NameID Format</td>
                <td><code>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</code></td>
            </tr>
            <tr>
                <td colspan="2">Certificate Alias</td>
                <td><code>azure-ad</code></td>
            </tr>
            <tr>
                <td colspan="2">Response Signing Algorithm</td>
                <td><code>http://www.w3.org/2001/04/xmldsig-more#rsa-sha256</code></td>
            </tr>
            <tr>
                <td colspan="2">Response Digest Algorithm</td>
                <td><code>http://www.w3.org/2001/04/xmlenc#sha256</code></td>
            </tr>
        </tbody>
        </table>

     5. Expand **Claim Configuration** -> **Basic Claim Configuration**. 
     
         Add the claim configurations as shown in the image below.
         
         Configure the following claim mappings:

        <table>
        <tr>
        <th><b>Claim URI</b></th>
        <th><b>Local Claim</b></th>
        </tr>
        <tr>
        <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress</td>
        <td>http://wso2.org/claims/emailaddress</td>
        </tr>
        <tr>
        <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname</td>
        <td>http://wso2.org/claims/givenname</td>
        </tr>
        <tr>
        <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname</td>
        <td>http://wso2.org/claims/lastname</td>
        </tr>
        <tr>
        <td>http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name</td>
        <td>http://wso2.org/claims/username</td>
        </tr>
        </table>

     6. Expand **Role configuration** and add `azure_ad_role` as shown below. 
     
         Since Azure AD doesn't provide role information by default in basic SAML claims, we'll assign the `azure_ad_role` to all federated users. For more advanced role mapping, you would need to configure custom claims in Azure AD.

        <a href="{{base_path}}/assets/img/learn/azure-ad-apim-role-saml-role-mapping.png"><img src="{{base_path}}/assets/img/learn/azure-ad-apim-role-saml-role-mapping.png"/></a>

     7. Enable **Just-in-Time Provisioning** for the user to be saved in the API Manager user store.

         <a href="{{base_path}}/assets/img/learn/azure-ad-apim-role-saml-jit.png"><img src="{{base_path}}/assets/img/learn/azure-ad-apim-role-saml-jit.png" width="600"/></a>

    !!! info
        When Just-In-Time Provisioning is enabled, the user details will be saved in the API Manager user store. User profile details will be updated via the federation following each login event. To preserve the user profile details without any changes, you need to enable `SystemRolesRetainedProvisionHandler`.
        
        Add the following to the `<API-M_HOME>/repository/conf/deployment.toml` file and restart the server.

        ```
        [authentication.framework.extensions]
        provisioning_handler = "org.wso2.carbon.identity.application.authentication.framework.handler.provisioning.impl.SystemRolesRetainedProvisionHandler"
        ```

6. Update the Service Providers.

    1. Click **Service Providers** -> **List** in the WSO2 API-M Management Console.
        
        There are two service providers available by default; `apim_publisher` and `apim_devportal`. 
        
    2. Click **Edit** to edit `apim_publisher`.

        !!! warning
            You need to have signed in to the Developer Portal and Publisher at least once for the two service providers to appear, as it is created during the first sign in.

    3. Expand **Local & Outbound Authentication Configuration** under **Federated Authentication** and select the identity provider you created (`Azure-AD-SAML-IDP`).
    
    4. Repeat the latter mentioned two steps for `apim_devportal`.

         Now you will be able to Sign in to the Publisher and Developer Portal using Azure AD SAML.

         [![Azure AD API-M SAML login]({{base_path}}/assets/img/learn/azure-ad-saml-login.png){: style="width:30%"}]({{base_path}}/assets/img/learn/azure-ad-saml-login.png)

## Advanced Configuration

### Custom Role Mapping with Azure AD Groups

To map Azure AD groups to WSO2 API Manager roles:

1. In Azure AD, configure group claims:
   1. Navigate to **Enterprise applications** > **Your Application** > **Single sign-on**.
   2. In **User Attributes & Claims**, click **Add a group claim**.
   3. Select **Groups assigned to the application**.
   4. Choose **Group ID** as the source attribute.

2. Update WSO2 API Manager configuration:
   1. Add group claim mapping in the Identity Provider configuration.
   2. Configure role mappings based on Azure AD group IDs.

### Troubleshooting

1. **SAML Response issues**: 
   - Verify that the certificate is correctly imported.
   - Check the SAML response format and claims.
   - Ensure Entity IDs match between Azure AD and WSO2 API Manager.

2. **Certificate problems**: 
   - Verify the certificate alias in the keystore.
   - Ensure the certificate is valid and not expired.

3. **Claim mapping issues**: 
   - Check that the claim URIs match between Azure AD and WSO2 API Manager.
   - Verify that the required claims are being sent by Azure AD.

For more detailed troubleshooting, check the WSO2 API Manager logs at `<API-M_HOME>/repository/logs/`.