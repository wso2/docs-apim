# Using Okta as an External IDP with OIDC

Follow the instructions below to connect Okta as a third-party Identity Provider to WSO2 API Manager.

## Prerequisites

Before you begin, make sure you do the following.

1. Create an account in [https://developer.okta.com/](https://developer.okta.com/)
2. Download the WSO2 API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/).
3. Enable the email domain on WSO2 API Manager.

     You need to enable this because Okta uses the email as the username by default. As the email domain is not enabled by default, you have to enable it to  use the email as the username in WSO2 API Manager. Once enabled, you can use your email or a normal username as your username.

     Follow the instructions below:

     1. Unzip the WSO2 API Manager distribution.
     2. Open the `deployment.toml` file, which is located in the `<API-M_HOME>/repository/conf/` directory. 
     3. Add the following configuration.

        ```
        [tenant_mgt]
        enable_email_domain= true
        ```

4. Start the WSO2 API Manager server.

## Step 1 - Configure Okta

!!! note
    For more information on working with the Okta Admin Portal, see the official Okta documentation.

1. Navigate to the Okta Admin Portal.

2. Add an application in Okta.
   
     Select **Web** as the platform type of the application and create an application based on the following application settings.

    <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Name</td>
      <td><code>oidc_app</code></td>
      </tr>
      <tr>
      <td>Base URIs</td>
      <td>Let's not add a new base URI</td>
      </tr>
      <tr>
      <td>Login Redirect URIs</td>
      <td><code>https://localhost:9443/commonauth</code></td>
      </tr>
      <tr>
      <td>Logout Redirect URIs</td>
      <td><code>https://localhost:9443/commonauth</code></td>
      </tr>
      <tr>
      <td>Group Assignments</td>
      <td><code>Everyone</code></td>
      </tr>
      <tr>
      <td>Grant type allowed</td>
      <td><code>Authorization Code</code></td>
      </tr>
    </table>

3. Add an attribute to the default user profile.

     Add a new attribute, with the following details, to the default user profile of Okta to represent the user role.

    <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Data Type</td>
      <td><code>String</code></td>
      </tr>
      <tr>
      <td>Display Name</td>
      <td>Role</td>
      </tr>
      <tr>
      <td>Variable Name</td>
      <td><code>role</code></td>
      </tr>
      <tr>
      <td>Description</td>
      <td></td>
      </tr>
      <tr>
      <td>Attribute Length</td>
      <td><code>Between</code></td>
      </tr>
      <tr>
      <td>min</td>
      <td></td>
      </tr>
      <tr>
      <td>max</td>
      <td></td>
      </tr>
    </table>

4. Add the claims that need to be returned from the ID Token in Okta. 

     These claims will be used to map the user details with WSO2 API Manager for authentication and authorization purposes.

     Let's add two claims that have the following details.

     **Claim 1**

     <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Name</td>
      <td><code>wso2user</code></td>
      </tr>
      <tr>
      <td>Include in token type</td>
      <td>
      <code>ID Token</code></br>
      <code>Always</code>
      </td>
      </tr>
      <tr>
      <td>Value Type</td>
      <td><code>Expression</code></td>
      </tr>
      <tr>
      <td>Value</td>
      <td><code>user.login</code></td>
      </tr>
      <tr>
      <td>Include in</td>
      <td><code>The following scopes:</code></br><code>openid</code></td>
      </tr>
    </table>

    **Claim 2**

     <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
      <td>Name</td>
      <td><code>roles</code></td>
      </tr>
      <tr>
      <td>Include in token type</td>
      <td>
      <code>ID Token</code></br>
      <code>Always</code>
      </td>
      </tr>
      <tr>
      <td>Value Type</td>
      <td><code>Expression</code></td>
      </tr>
      <tr>
      <td>Value</td>
      <td><code>user.login</code></td>
      </tr>
      <tr>
      <td>Include in</td>
      <td><code>The following scopes:</code></br><code>openid</code></td>
      </tr>
    </table>

5. Add a role to the provisioned user in Okta.

     This will enable WSO2 API Manager to map an internal role to the provisioned user. Edit the provisioned user's profile and add `any` as the Role.

## Step 2 - Configure API Manager

1. Sign in to the WSO2 API-M Management Console.

     `https://localhost:9443/carbon`.

2. Create a role that needs to be assigned to users that will be provisioned from Okta. 

    1. Click **Main**, **Identity**, and then click **Add** under **Users and Roles**.
    
    2. Click **Add New Role**.

         [![Add role for Okta in API-M]({{base_path}}/assets/img/learn/okta-apim-add-role.png)]({{base_path}}/assets/img/learn/okta-apim-add-role.png)
   
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
         <td><code>okta_role</code></td>
         </tr>
         </table>
         
         <a href="{{base_path}}/assets/img/learn/okta-apim-add-role-name.png"><img src="{{base_path}}/assets/img/learn/okta-apim-add-role-name.png" width="50%"/></a>

3. Add scope mapping via the WSO2 API Manager Admin Portal.

    1. Sign in to the WSO2 API Manager Admin Portal.
    
         `https://localhost:9443/admin`
         
    2. Click **Settings** and then click **Scope Assignments**.

         [![Scope Assignments menu]({{base_path}}/assets/img/learn/scope-assignment-menu.png){:style="width:28%"}]({{base_path}}/assets/img/learn/scope-assignment-menu.png) 

    3. Click **Add Scope Mappings**.
     
         [![Okta API-M role permission mapping]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui.png) 
    
    4. Enter `okta_role` as the role name and click **Next**.

         [![Edit Okta API-M role permission mapping]({{base_path}}/assets/img/learn/okta-apim-role-permission-mapping-admin-ui-edit1.png)]({{base_path}}/assets/img/learn/okta-apim-role-permission-mapping-admin-ui-edit1.png) 

    5. Go to **Select permissions**, click  **Custom permissions**, and start assigning the permissions as shown below. 
    
         These permissions will allow a user having the `okta_role` to log in to the Publisher and the Developer Portal.

         <table>
         <tr>
         <th><b>Hiererchy</b></th>
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
         <code>apim:subscription_manage</code></code>
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
         <code>apim:comment_view</code></code>
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

        [![Okta API-M role permission mapping]({{base_path}}/assets/img/learn/okta-apim-role-permission-mapping-admin-ui-edit2.png)]({{base_path}}/assets/img/learn/okta-apim-role-permission-mapping-admin-ui-edit2.png)

    6. Click **Save** to save your changes.

4. Add an Identity Provider.

     1. Sign in to the WSO2 API-M Management Console.
     
         `https://localhost:9443/carbon`. 
     
     2. Click **Main** and then click **Add** under  **Identity Providers**. 
     
     3. Enter the Identity Provider's Name.  

         [![Add an IDP for Okta SAML]({{base_path}}/assets/img/learn/okta-saml-add-idp.png)]({{base_path}}/assets/img/learn/okta-saml-add-idp.png) 

     4. Expand **Federated Authenticators** -> **OAuth2/OpenID Connect Configuration** and add the following details.
        
        [![API-M IDP OIDC details]({{base_path}}/assets/img/learn/okta-apim-idp-odic-details.png)]({{base_path}}/assets/img/learn/okta-apim-idp-odic-details.png)

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
                <td>You can find this value from the Okta application that you created.</td>
            </tr>
            <tr>
                <td colspan="2">Client Secret</td>
                <td>You can find this value from the Okta application that you created.</td>
            </tr>
            <tr>
                <td colspan="2">Authorization Endpoint URL</td>
                <td><code>https://your_okta_url/oauth2/default/v1/authorize</code></td>
            </tr>
            <tr>
                <td colspan="2">Token Endpoint URL</td>
                <td colspan="1"><code>https://your_okta_url/oauth2/default/v1/token</code></td>
            </tr>
            <tr>
                <td colspan="2">Callback URL</td>
                <td>
                    <code>https://localhost:9443/commonauth</code>
                </td>
            </tr>
            <tr>
                <td colspan="2">Userinfo Endpoint URL</td>
                <td colspan="1">
                    <code>https://your_okta_url/oauth2/default/v1/userinfo</code>
                </td>
            </tr>
            <tr>
                <td colspan="2">Logout Endpoint URL</td>
                <td colspan="1">
                    <code>https://your_okta_url/oauth2/default/v1/logout</<code>code>
                </td>
            </tr>
            <tr>
                <td colspan="2">Additional Query Parameters</td>
                <td colspan="1">
                    <code>scope=openid profile</code>
                </td>
            </tr>
        </tbody>
        </table>

     5. Expand **Claim Configuration** -> **Basic Claim Configuration**. 
     
         Add the claim configurations as shown in the image below.
         
         [![Okta API-M IDP claims details]({{base_path}}/assets/img/learn/okta-apim-idp-claims-details.png)]({{base_path}}/assets/img/learn/okta-apim-idp-claims-details.png) 

     6. Expand **Role configuration** and add `okta_role` as shown below. 
     
         You can check if the user logged in has the role `any` and assign the local `okta_role`.

        <a href="{{base_path}}/assets/img/learn/okta-apim-role-oidc-role-mapping.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-role-mapping.png"/></a>

     7. Enable **Just-in-Time Provisioning** for the user to be saved in the API Manager user store.

         <a href="{{base_path}}/assets/img/learn/okta-apim-role-oidc-jit.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-jit.png" width="600"/></a>

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

        [![Okta API-M role OIDC SP]({{base_path}}/assets/img/learn/okta-apim-role-oidc-sp.png)]({{base_path}}/assets/img/learn/okta-apim-role-oidc-sp.png)

    3. Expand **Local & Outbound Authentication Configuration** under **Federated Authentication** and select the identity provider you created.

         [![Okta API-M role OIDC SP outbound]({{base_path}}/assets/img/learn/okta-apim-role-oidc-sp-outbound.png)]({{base_path}}/assets/img/learn/okta-apim-role-oidc-sp-outbound.png)
    
    4. Repeat the latter mentioned two steps for `apim_devportal`.

         Now you will be able to Sign in to the Publisher and Developer Portal using Okta.

         [![Okta API-M login]({{base_path}}/assets/img/learn/okta-login.png){: style="width:30%"}]({{base_path}}/assets/img/learn/okta-login.png)

