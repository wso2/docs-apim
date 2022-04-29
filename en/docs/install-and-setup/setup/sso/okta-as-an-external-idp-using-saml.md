# Using Okta as an External IDP with SAML 

Follow the instructions below to connect Okta as a third party Identity Provider to WSO2 API Manager.

## Prerequisites

Before you begin, make sure you do the following.

1. Create an account in [https://developer.okta.com/](https://developer.okta.com/)
2. Download WSO2 API Manager 4.1.0 distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/)
3. Unzip the distribution and open the `deployment.toml` file located in `<APIM_HOME>/repository/conf/`. Add the following configuration
    ```
    [tenant_mgt]
    enable_email_domain= true
    ```
    You need to enable this because Okta uses the email as the username by default. To  use the email as the username in WSO2 API Manager you have to enable it as it is not enabled by default. Once enabled, you can use your email or a normal username as your username.
4. Start the WSO2 API Manager server.

## Step 1 - Configure Okta

1.  Login to the Okta developer console and switch to the classic UI. 
    [![]({{base_path}}/assets/img/learn/okta-classic-ui.png)]({{base_path}}/assets/img/learn/okta-classic-ui.png)

2.  Go to **Applications** -> **Add Application**.
    [![Add new Okta SAML application]({{base_path}}/assets/img/learn/okta-saml-add-app.png)]({{base_path}}/assets/img/learn/okta-saml-add-app.png)

3.  Click **Create New Application**.
    [![Create new Okta SAML application]({{base_path}}/assets/img/learn/okta-saml-create-new-app.png)]({{base_path}}/assets/img/learn/okta-saml-create-new-app.png)

4.  Select **Web** as the **Platform**. Select **SAML 2.0** as the sign-on method.
    [![Create a new application integration]({{base_path}}/assets/img/learn/okta-saml-create-saml-app.png)]({{base_path}}/assets/img/learn/okta-saml-create-saml-app.png)

5.  Enter the **General Settings** as shown in the images below.
    [![Enter application name]({{base_path}}/assets/img/learn/okta-saml-create-saml-app-name.png)]({{base_path}}/assets/img/learn/okta-saml-create-saml-app-name.png)
    
    [![Enter application details]({{base_path}}/assets/img/learn/okta-saml-create-saml-app-details.png)]({{base_path}}/assets/img/learn/okta-saml-create-saml-app-details.png)

    !!!warning
        **Audience URI** should be same as the Identity Provider entity id name that is created in WSO2 API Manager.

6.  Inside the SAML app you created go to **Sign On** and click **View Setup Instructions**.

    [![View Setup Instructions]({{base_path}}/assets/img/learn/okta-saml-create-new-app-config1.png)]({{base_path}}/assets/img/learn/okta-saml-create-new-app-config1.png)

    1.  Scroll up to the **Provide the following IDP metadata to your SP provider** section. Copy and save the details given to a XML file.

        [![Copy and save xml]({{base_path}}/assets/img/learn/okta-saml-create-new-app-config2.png)]({{base_path}}/assets/img/learn/okta-saml-create-new-app-config2.png)

    2.  Go to **Assignments** -> **Assign**. Click **Assign to People** and assign your current user.

        [![Assign your current user]({{base_path}}/assets/img/learn/okta-saml-create-new-app-assign.png)]({{base_path}}/assets/img/learn/okta-saml-create-new-app-assign.png)
    
7.  Switch back to the Developer Console shown in step 1.

8.  Follow these steps to add a new attribute to the default user profile of Okta to represent the user role. 

    1.  Navigate to **Users** -> **Profile Editor** and click the pencil icon to edit the default profile.

        [![Edit the default profile in the Profile Editor]({{base_path}}/assets/img/learn/okta-add-new-attribute.png)]({{base_path}}/assets/img/learn/okta-add-new-attribute.png)

    2.  Click **Add Attribute** to add new user attributes.
    
        [![Add new attribute]({{base_path}}/assets/img/learn/okta-add-new-attribute-add.png)]({{base_path}}/assets/img/learn/okta-add-new-attribute-add.png) 

9.  Enter the user attributes shown in the image below. Click **Save**.

    [![Add new attributes]({{base_path}}/assets/img/learn/okta-add-new-attribute-details.png)]({{base_path}}/assets/img/learn/okta-add-new-attribute-details.png) 

10.   Follow the steps below to edit the user profile.

    1.  Go to **Users** -> **People** and click on your profile name.
        
        <a href="{{base_path}}/assets/img/learn/okta-profile-edit.png"><img src="{{base_path}}/assets/img/learn/okta-profile-edit.png"/></a>
    
    2.  Click **Edit** to change the profile details.
        
        <a href="{{base_path}}/assets/img/learn/okta-profile-edit2.png"><img src="{{base_path}}/assets/img/learn/okta-profile-edit2.png" width="600" height="400"/></a>

    3.  Add the **Role**. This will be used in the API Manager to map an internal role to the provisioned user.
        
        <a href="{{base_path}}/assets/img/learn/okta-profile-edit3.png"><img src="{{base_path}}/assets/img/learn/okta-profile-edit3.png"/></a>

## Step 2 - Setup API-Manager

1. Log in in to `https://localhost:9443/carbon`. 

2. Create a role that needs to be assigned to users that will be provisioned from Okta.

    <a href="{{base_path}}/assets/img/learn/okta-apim-add-role.png"><img src="{{base_path}}/assets/img/learn/okta-apim-add-role.png" width=90%/></a>

    1. Go to **Users and Roles**.

         <a href="{{base_path}}/assets/img/learn/okta-apim-add-role-name.png"><img src="{{base_path}}/assets/img/learn/okta-apim-add-role-name.png" width=50%/></a>

    2. Add a new role.

    3. Assign the following permissions to the role and save the role.

        <a href="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions3.png"><img src="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions3.png" width=25%/></a>
        <br/>
        <br/>
        <a href="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions2.png"><img src="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions2.png" width=25%/></a>
        <br/>
        <br/>
        <a href="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions1.png"><img src="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions1.png" width=25%/></a>

3. Log in to `https://localhost:9443/admin`. 

    1. Expand **Settings** and click **Scope Mapping**.

        <a href="{{base_path}}/assets/img/learn/okta-apim-role-scope-mapping.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-scope-mapping.png" width=25%/></a>

    2. Update the following scopes with the `okta_role`.

        [![]({{base_path}}/assets/img/learn/okta-apim-role-scope-mapping-edit1.png)]({{base_path}}/assets/img/learn/okta-apim-role-scope-mapping-edit1.png)
        <br/>
        <br/>
        [![]({{base_path}}/assets/img/learn/okta-apim-role-scope-mapping-edit2.png)]({{base_path}}/assets/img/learn/okta-apim-role-scope-mapping-edit2.png)
        <br/>
        <br/>
        [![]({{base_path}}/assets/img/learn/okta-apim-role-scope-mapping-edit3.png)]({{base_path}}/assets/img/learn/okta-apim-role-scope-mapping-edit3.png)

        These permissions will allow a user having the `okta_role` to log in to Publisher and Developer Portals.

4. Add an Identity Provider.

    1. Sign in to the WSO2 API-M Management Console.
        `https://localhost:9443/carbon`
        
    2. Click **Main** and then click **Add** under **Identity Providers**. 
    
    3. Enter the Identity Provider's Name. 

        [![]({{base_path}}/assets/img/learn/okta-saml-add-idp.png)]({{base_path}}/assets/img/learn/okta-saml-add-idp.png) 
        <br/>
        <br/>
    
    4. Expand **Federated authenticators** -> **SAML2 Web SSO Configuration** section. Under **Select Mode**, select **Metadata File Configuration**. Update the XML file obtained during the Okta setup process Step 1 - 6(a).
        [![]({{base_path}}/assets/img/learn/okta-saml-apim-idp.png)]({{base_path}}/assets/img/learn/okta-saml-apim-idp.png) 

    <table>
        <colgroup>
            <col />
            <col />
            <col />
        </colgroup>
        <tbody>
            <tr>
                <th colspan="2">Field</th>
                <th>Sample value</th>
            </tr>
            <tr>
                <td colspan="2" class="confluenceTd">Specifies if <b>SAML2 Web SSO</b> is enabled for this Identity Provider</td>
                <td class="confluenceTd">True</td>
            </tr>
            <tr>
                <td colspan="2" class="confluenceTd">Service Provider Entity ID</td>
                <td class="confluenceTd">Entity ID specified when creating SAML app (e.g., <code>oktasaml</code>)</td>
            </tr>
        </tbody>
    </table>

5. Expand **Claim Configuration** -> **Basic Claim Configuration**. Add the claim configurations as shown in the image below. The `role` drop-down menu contains the roles you configured in Okta (Step 1). Select the `Identity Provider Claim URIs` according to the configurations in the Okta Developer Console in **Step 1**.

    [![]({{base_path}}/assets/img/learn/okta-saml-apim-idp-claim.png)]({{base_path}}/assets/img/learn/okta-saml-apim-idp-claim.png) 

6. Expand **Role configuration** and add `okta_role` as shown below. 
     
    You can check if the user logged in has the role `any` and assign the local `okta_role`.

    <a href="{{base_path}}/assets/img/learn/okta-apim-role-oidc-role-mapping.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-role-mapping.png" width=90%/></a>

7. Enable **Just-in-Time Provisioning** for the user to be saved in the API Manager user store.

    <a href="{{base_path}}/assets/img/learn/okta-apim-role-oidc-jit.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-jit.png" width=70%/></a>

8. Select a Service Provider.

    1. Navigate to **Service Providers** -> **List**.

        <a href="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp-select.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp-select.png" width=20%/></a>
    
    2. There are two service providers created `apim_publisher` and `apim_devportal`. Click **Edit** for `apim_publisher`.

        !!!warning
            You need to have signed in to the Developer Portal and Publisher at least once for the two service providers to appear, as it is created during the first sign in.

        <a href="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp.png" width=90%/></a>

    3. Expand **Local & Outbound Authentication Configuration**. Select **Federated Authentication** and select the name of the Identity Provider you created from the corresponding drop-down menu.

        <a href="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp-outbound.png"><img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp-outbound.png" width=90%/></a>
    
    Repeat this step for `apim_devportal` as a Service Provider.

Now you will be able to Sign in to the Publisher and Developer Portal using Okta.

