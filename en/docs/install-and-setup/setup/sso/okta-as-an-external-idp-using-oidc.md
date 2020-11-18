This section explains how to connect OKTA as a third-party Identity provier to WSO2 API Manager.

### Pre-requisites

Before you begin, make sure you do the following.

1. Create an account in [https://developer.okta.com/](https://developer.okta.com/)
2. Download the latest API Manager distribution from [https://wso2.com/api-management/](https://wso2.com/api-management/)
3. Unzip the distribution and open the `deployment.toml` file located in `<APIM_HOME>/repository/conf/` folder. Add the following configuration
    ```
    [tenant_mgt]
    enable_email_domain= true
    ```
    You need to enable this because OKTA uses the email as a username by default. To  use the email as the username in WSO2 API Manager you have to enable it, since it not enabled by default. Once enabled, you can use your email or a normal username as your username.
4. Start the Server.

### Setup OKTA

1. Go to the OKTA admin portal and navigate to **Applications** and click **Add Application**.
[![]({{base_path}}/assets/img/learn/okta-add-new-application.png)]({{base_path}}/assets/img/learn/okta-add-new-application.png)

2. Select type web and use the following details

    [![]({{base_path}}/assets/img/learn/okta-add-new-application-web.png)]({{base_path}}/assets/img/learn/okta-add-new-application-web.png)

    [![]({{base_path}}/assets/img/learn/okta-add-new-application-details.png)]({{base_path}}/assets/img/learn/okta-add-new-application-details.png)

3. Add a new attribute to the default user profile of OKTA to represent the user role. Navigate to **Users** -> **Profile Editor**. Click **Profile** to edit the default profile.

    [![]({{base_path}}/assets/img/learn/okta-add-new-attribute.png)]({{base_path}}/assets/img/learn/okta-add-new-attribute.png)

    You will be able to see the user attributes in the Profile Editor. Click **Add Attribute** to add new user attributes.

    [![]({{base_path}}/assets/img/learn/okta-add-new-attribute-add.png)]({{base_path}}/assets/img/learn/okta-add-new-attribute-add.png) 

4. Enter the user role details and click **Save**.

    [![]({{base_path}}/assets/img/learn/okta-add-new-attribute-details.png)]({{base_path}}/assets/img/learn/okta-add-new-attribute-details.png) 

5. You need to add the claims that needs to be returned from the ID Token in Okta. These claims we will be used to map the user details with WSO2 API Manager. Navigate to **API** -> **Authorization Servers** and select the default server.

    [![]({{base_path}}/assets/img/learn/okta-add-new-claims.png)]({{base_path}}/assets/img/learn/okta-add-new-claims.png) 

6. Add the following two claims as shown in the images below.

    [![]({{base_path}}/assets/img/learn/okta-add-new-claims-user.png)]({{base_path}}/assets/img/learn/okta-add-new-claims-user.png) 

    [![]({{base_path}}/assets/img/learn/okta-add-new-claims-role.png)]({{base_path}}/assets/img/learn/okta-add-new-claims-role.png) 

7. Go to **Users** -> **People** and click on your profile name.

    <img src="{{base_path}}/assets/img/learn/okta-profile-edit.png" />
    <br/>

    Navigate to the profile edit page as shown below
    <img src="{{base_path}}/assets/img/learn/okta-profile-edit2.png" width="600" height="400"/>
    <br/>
    <br/>

    Add **any** as the role value as shown below. This will be used by API Manager to map an internal role to a provisioned user.
    <img src="{{base_path}}/assets/img/learn/okta-profile-edit3.png"/>


### Setup API Manager

1. Log in to `https://localhost:9443/carbon`.

2. Create a role that needs to be assinged to users that will be provisioned from Okta. Go to **Users and Roles** and click **Add** to add a new role.
    <img src="{{base_path}}/assets/img/learn/okta-apim-add-role.png" width="400" height="200"/>

    <img src="{{base_path}}/assets/img/learn/okta-apim-add-role-name.png" width="400" height="200"/>

    Assign the following permissions to the role and save

    <img src="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions3.png" width="300" height="300"/>
    <br/>
    <br/>
    <img src="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions2.png" width="300" height="350"/>
    <br/>
    <br/>
    <img src="{{base_path}}/assets/img/learn/okta-apim-add-role-permissions1.png" width="300" height="300"/>

3. Log in to `https://localhost:9443/admin` and navigate to **Role Permissions** section under the **Settings** tab in the left menu bar.

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui.png) 

    Click **Add role permission**, a popup dialog will be opened as shown below. Enter `okta_role` in the **Provide role name** field and click **Next**.

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit1.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit1.png) 

    Go to **Select permissions**, click  **Custom permissions** and start assigning the permissions as shown below. These permissions will allow a user having the `okta_role` to login to Publisher and Developer Portals.

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit2.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit2.png)

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit3.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit3.png)

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit4.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit4.png)

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit5.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit5.png)

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit6.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit6.png)

    [![]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit7.png)]({{base_path}}/assets/img/learn/okta-apim-role-pemission-mapping-admin-ui-edit7.png)

    Click **Save** to save your changes.

    !!! note
        If you want your user to perform analytics-based tasks, you should add the `okta_role` to the required analytics scopes according to your preference. The steps below are given as an example.

        -   Login to `https://localhost:9443/carbon`. 
        -   Navigate to **Main > Resources > Browse**. 
        -   Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.
        -   Update the `RESTAPIScopes` JSON field by adding `okta_role` to the `Roles` field under the corresponding `Name` fields as shown below for the analytics related scopes.
            ```bash
            {
                "Name": "apim_analytics:api_analytics:view",
                "Roles": "admin,Internal/creator,Internal/publisher,okta_role"
            },
            {
                "Name": "apim_analytics:application_analytics:view",
                "Roles": "admin,Internal/subscriber,okta_role"
            },
            ```
        - Click on **Save Content** button.

4. Log in to `https://localhost:9443/carbon`. Go to  **Identity Providers**. Click on **Add** to enter Identity Provider Name.  

    [![]({{base_path}}/assets/img/learn/okta-saml-add-idp.png)]({{base_path}}/assets/img/learn/okta-saml-add-idp.png) 
    <br/>
    <br/>

    Expand **Federated authenticators** -> **OAuth2/OpenID Connect Configuration**. Add the following details.
    [![]({{base_path}}/assets/img/learn/okta-apim-idp-odic-details.png)]({{base_path}}/assets/img/learn/okta-apim-idp-odic-details.png) 
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
            <td colspan="2" class="confluenceTd">Enable OAuth2/OpenIDConnect</td>
            <td class="confluenceTd">True</td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">Client id</td>
            <td class="confluenceTd">Can be found in the okta application you created</td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">Client secret</td>
            <td class="confluenceTd">Can be found in the okta application you created</td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">Authorization Endpoint URL</td>
            <td class="confluenceTd">https://your_okta_url/oauth2/default/v1/authorize</td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">Token Endpoint URL</td>
            <td colspan="1" class="confluenceTd">https://your_okta_url/oauth2/default/v1/token</td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">callback url</td>
            <td class="confluenceTd">
                https://localhost:9443/commonauth
            </td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">Userinfo Endpoint URL</td>
            <td colspan="1" class="confluenceTd">
                https://your_okta_url/oauth2/default/v1/userinfo
            </td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">Logout Endpoint URL</td>
            <td colspan="1" class="confluenceTd">
                https://your_okta_url/oauth2/default/v1/logout
            </td>
        </tr>
        <tr>
            <td colspan="2" class="confluenceTd">Additional Query Parameters</td>
            <td colspan="1" class="confluenceTd">
                scope=openid%20profile
            </td>
        </tr>
    </tbody>
</table>

5. Expand **Claim Configuration** -> **Basic Claim Configuration**. Add the claim configurations as shown in the image below.
    [![]({{base_path}}/assets/img/learn/okta-apim-idp-claims-details.png)]({{base_path}}/assets/img/learn/okta-apim-idp-claims-details.png) 

6. Expand **Role configuration** and add `okta_role` as shown below. You can check if the user logged in has the role `any` and assign the local `okta_role`.

    <img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-role-mapping.png"/>

7. Enable **Just-in-Time Provisioning** for the user to be saved in the API Manager user store.

    <img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-jit.png"/>

8. Go to **Service Providers** -> **List**. There are two service providers available by default; `apim_publisher` and `apim_devportal`. Click **Edit** to edit `apim_publisher`.

    !!!warning
        You need to be logged into the Developer Portal and Publisher at least once for the two service providers to appear, as it is created during first login.

    <img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp.png"/>

    Expand **Local & Outbound Authentication Configuration**. Under **Federated Authentication** select the identity provider you created.

    <img src="{{base_path}}/assets/img/learn/okta-apim-role-oidc-sp-outbound.png"/>
    
    Repeat this step for `apim_devportal`.

Now you will be able to login to the Publisher & Developer Portal using OKTA.