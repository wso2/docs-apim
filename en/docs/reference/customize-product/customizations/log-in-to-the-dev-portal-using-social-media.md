# Log in to the Developer Portal using Social Media

You can integrate WSO2 Identity Server with WSO2 API Manager and use your social media credentials to log in to the Developer Portal and Publisher. This tutorial shows you how to integrate Facebook authentication and log in to the Developer Portal. Before following these steps, [configure WSO2 Identity Server as a Key Manager with API Manager]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/configuring-wso2-identity-server-as-a-key-manager/).

!!! note
        Note that the Facebook application development UI might be slightly different from the demonstrated UIs in this tutorial due to the frequent updates in the Facebook Developer Portal.

### Create a Facebook application

1.  Go to [https://developers.facebook.com/](https://developers.facebook.com/) and log in using your Facebook credentials.
2.  Select **My Apps** in the navigation and create a new app by clicking **Create App** .
3.  Enter the name of your app and your email address. Click **Create App ID** .

    ![Create new facebook app]({{base_path}}/assets/img/learn/create-facebook-app.png)

4.  Click **Set Up** to create a **Facebook Login** product.

    ![Setup facebook login product]({{base_path}}/assets/img/learn/setup-facebook-login-app.png)

5.  Select **Web** to work with this sample. You can select any other platform you wish to use.

    ![Setup facebook login product]({{base_path}}/assets/img/learn/web-facebook-login-app.png)

6.  Add the `serverURL` of WSO2 Identity Server (which is configured with `offset` = 1) <https://localhost:9444/> and click **Save** and **Continue** .

    !!! info
        If you have changed the hostname of identity server use that instead of `localhost`.

        For example, if the host name is **identity.com**, then the server URL is `https://identity.com:9444/`

    ![Add facebook Identity Server URL]({{base_path}}/assets/img/learn/add-facebook-is-server-url.png)

7.  Go to **Set Up the Facebook SDK for JavaScript** and click **Next** until the steps are complete.
8.  Click **Settings** and select **Basic**. You can find your `App ID` and the `App Secret` as shown in the image below.

    ![Facebook App Id]({{base_path}}/assets/img/learn/appId-facebook.png)

9.  Select a **Category** for you application.

    ![Facebook App Category]({{base_path}}/assets/img/learn/facebook-app-category.png)

    Add the correct **Site URL** as shown below and click **Save Changes** .

    ![Facebook Site URL]({{base_path}}/assets/img/learn/facebook-site-url.png)
    
10. Click on the new **Facebook Login** product you have added and configure it as follows.

    ![Facebook Login App Settings]({{base_path}}/assets/img/learn/facebook-login-app-settings.png)

    | Parameter                 | Value                                                                                           |
    |---------------------------|-------------------------------------------------------------------------------------------------|
    | Client OAuth Login        | `Yes`|
    | Web OAuth Login           | `Yes`|
    | Valid OAuth Redirect URLs | `https://localhost:9444/commonauth` |

    !!! info
            After the user authorizes the application, the authorization server redirects the user back to the application with access token or the authorization code in the URL. Since the redirected URL contains sensitive information, it is required to assure that the service does not redirect to arbitrary locations. The best way to ensure that the user is directed to the appropriate location is to define an **OAuth Redirect URL** as shown above.


Now you have configured Facebook as your Identity Provider.

### Configure Facebook login with Identity Server

Let's see how to configure WSO2 Identity Server to work with Facebook for user authentication, so that when you try to login to the Publisher or Developer Portal, WSO2 Identity Server will redirect to Facebook to do the authentication. For this purpose you have to configure WSO2 Identity Server by [adding a new identity provider](https://is.docs.wso2.com/en/5.10.0/learn/adding-and-configuring-an-identity-provider/)

1.  Log in to the [Management Console](https://is.docs.wso2.com/en/5.10.0/setup/running-the-product/#accessing-the-management-console) of WSO2 Identity Server as the admin user.
2.  Go to the **Identity** section under the **Main** tab. Click **Add** under **Identity Providers** and enter following details.

    | Identity provider Name | Alias                                 |
    |------------------------|---------------------------------------|
    | facebook               | <https://localhost:9444/oauth2/token> |

    !!! note
        To authenticate the user with **Facebook** which is an external system, we have to configure the federated authenticator. For more details, see [Federated Authetication](https://is.docs.wso2.com/en/5.10.0/get-started/quick-start-guide/#federated-authentication).

3.  Go to **Facebook Configuration** under **Federated Authenticators**.

    ![Configure a Federated Authenticator for Facebook Login]({{base_path}}/assets/img/learn/configure-federated-authenticator-for-facebook.png)

4.  Enter the **Client ID** and **Client Secret** from the values obtained from Facebook app created in the previous section.

5.  Select **Enable Facebook Authenticator** and select **Default** to make it the default authentication method.

6.  Enter the User information fields you want to retrieve separated by commas under **User Information fields**.

7.  Click **Update**.

    !!! note
            The **Scope** defines the permission to access particular information from a Facebook profile. See the [Permissions Reference](https://developers.facebook.com/docs/facebook-login/permissions) for a list of the different permission groups in Facebook APIs.

### Configuring requested claims for user authentication in Facebook Identity Provider

We need to acquire the identity information by configuring claims to use Authentication in facebook. Let's see how you can configure Identity Server with Facebook by mapping the claims. For more information on claim Mapping refer [Claim Management](https://is.docs.wso2.com/en/5.10.0/learn/claim-management/) .

1.  Go to the **Identity** section under the **Main** tab. Select **List** under **Identity Providers**.

2.  Click **Edit** to edit the facebook identity provider you created.

3.  Go to **Basic Claim Configuration** under **Claim Configuration**.

4.  Select the **Define Custom Claim Dialect** option under **Select Claim mapping Dialect** and click **Add Claim Mapping** to add custom claim mappings as follows.

    | Identity Provider Claim URI | Local Claim URI                     |
    |-----------------------------|-------------------------------------|
    | email                       | http://wso2.org/claims/emailaddress |
    | name_format                 | http://wso2.org/claims/roles        |

    Select **User ID Claim URL** as **email** from dropdown.

    ![Claim configuration for Facebook Login]({{base_path}}/assets/img/learn/claim-configuration-facebook.png)

    If you prefer to use the User ID as your first name of Facebook account, configure `first_name` claim as above. You need to select the same claim as **UserID Claim URI**.
    
5. Add **Identitity Provide Roles** under **Role Configurations** as follows.

    | Identity Provider Role      | Local Role                          |
    |-----------------------------|-------------------------------------|
    | {first}{last}               | Internal/subscriber                 |

6.  The following are some common attribute names. You can map these names to any suitable **Local Claim URI**. (Local Claim is a set of standard claim values which are local to the WSO2 Identity Server)
    - `id`
    - `email`
    - `name`
    - `first_name`
    - `last_name`
    - `link`
    - `gender`
    - `locale`
    - `age_range`

For more information, see [Permissions Reference - Facebook Login.](https://developers.facebook.com/docs/facebook-login/permissions)

### Configure service providers to the Publisher and Developer Portal with the Facebook Identity Provider

To federate logging in to the Publisher and Developer Portal with Facebook, you need to configure the service provider with the Facebook Identity Provider.

!!! note
        You have to allow the usage of email addresses as usernames, to use email addresses. For instructions, see [Setting up an e-mail login](/administer/product-security/General/logins-and-passwords/maintaining-logins-and-passwords/#setting-up-an-e-mail-login).


1.  Go to the **Management Console** of WSO2 Identity Server (`https://localhost:9444/carbon`) and click on **Service Providers**.

2.  Click **Edit** to edit the `admin_admin_publisher`.

    ![Service Providers List]({{base_path}}/assets/img/learn/service-providers-list-facebook-auth.png)

3.  Go to the **Local & Outbound Authentication Configuration** section. Select the Identity Provider you created from the dropdown list under **Federated Authentication**.

4.  Make sure that **Federated Authentication** is selected. Click **Update** to save the changes.

    ![Set Facebook Auth for Service Providers]({{base_path}}/assets/img/learn/set-facebook-auth-for-service-providers.png)

5.  Repeat steps 1 to 4 and configure the `admin_admin_store` service provider.

### Test Facebook authentication

!!! warning
        Make sure to copy the **org.wso2.carbon.identity.application.authenticator.facebook-5.1.14.jar** found in `<IS_HOME>/repository/components/dropins` directory to `<API-M_HOME>/repository/components/dropins` directory. Then **restart** the API-M server before testing Facebook Authentication.

1.  Access the Publisher via `https://localhost:9443/publisher` . Observe the request redirect to the WSO2 IS login page and then Facebook login page.

2.  Enter the username and password of your facebook account.

    ![Login to facebook]({{base_path}}/assets/img/learn/login-with-facebook.png)

3.  After successfully authenticating the log in, you will be logged into Publisher. Your username will be the first name of your Facebook account. This is because you have already configured the first name as the **UserID Claim URI**.

    If you configure your **UserID Claim URI** with the `last_name` , your username will be the last name of your Facebook account.

### Configure the associated social login in Identity Server dashboard

Identity Server has a dashboard which offers multiple options for users to maintain user accounts. Associating a social login for their account is one of the options provided in this dashboard. It can be accessed with the following URL : `https://<IS_HOST>:<IS_PORT>/dashboard.` By associating the social login you have the option to use local claims. Instead of showing the logged in name as facebook username you can show the username in the local user store.

!!! note
        Make sure that you have enabled user account association for federated users by setting `enable_for_federated_users` property to `true` as explained in [Associating User Accounts.](https://is.docs.wso2.com/en/5.10.0/learn/associating-user-accounts)

1.  Login to the dashboard with Developer Portal user account.

2.  Click **View Details** in the **Associated Accounts** gadget.

    ![Associated Accounts Gadget]({{base_path}}/assets/img/learn/is-login-dashboard.png)

3.  Click **Add Association** to give your facebook account details.

    ![Add association]({{base_path}}/assets/img/learn/add-association-facebook-login.png)

4.  Select Account Type as `Federated`, enter your Identity Provider Id (facebook) and your username (as configured in **Subject Claim URI** ) and click **Associate**.

    ![Add IDP]({{base_path}}/assets/img/learn/associate-idp.png)

5.  Select **Local & Outbound Configuration** and check **Assert identity using mapped local subject identifier**.

    ![Select mapped local subject identifier]({{base_path}}/assets/img/learn/assert-identity-using-mapped-local-subject-id.png)

After logging in to Publisher, you will see the configured local claim appearing as your username.

You have now successfully logged in to the Publisher using your facebook credentials.
