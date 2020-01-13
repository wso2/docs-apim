# Log in to the Developer Portal using Social Media

You can integrate WSO2 Identity Server with WSO2 API Manager and use your social media credentials to log in to the Developer Portal and API Publisher. This tutorial shows you how to integrate Facebook authentication and log in to the Developer Portal. Before following these steps, configure WSO2 Identity Server to provide Single Sign On for WSO2 API Manager by following [Configuring External IDP through Identity Server for SSO](https://docs.wso2.com/display/AM250/Configuring+External+IDP+through+Identity+Server+for+SSO) .

-   [Create a Facebook application](#LogintotheAPIStoreusingSocialMedia-CreateaFacebookapplication)
-   [Configure Facebook login with Identity Server](#LogintotheAPIStoreusingSocialMedia-ConfigureFacebookloginwithIdentityServer)
-   [Configuring requested claims for user authentication in Facebook Identity Provider](#LogintotheAPIStoreusingSocialMedia-ConfiguringrequestedclaimsforuserauthenticationinFacebookIdentityProvider)
-   [Configure service providers to the Publisher and Store with the Facebook Identity Provider](#LogintotheAPIStoreusingSocialMedia-ConfigureserviceproviderstothePublisherandStorewiththeFacebookIdentityProvider)
-   [Test Facebook authentication](#LogintotheAPIStoreusingSocialMedia-TestFacebookauthentication)
-   [Configure the associated social login in IS dashboard](#LogintotheAPIStoreusingSocialMedia-ConfiguretheassociatedsociallogininISdashboard)

!!! note
Note that the Facebook application development UI might be slightly different from the demonstrated UIs in this tutorial due to the frequent updates in the Facebook Developer Portal.


### Create a Facebook application

1.  Go to [https://developers.facebook.com/](https://www.google.com/url?q=https://developers.facebook.com/&sa=D&ust=1501139786736000&usg=AFQjCNF1-qcHMirbzk6x-9xMLM8I85SwnQ) and log in using your Facebook credentials.
2.  Select **My Apps** in the navigation and create a new app by clicking **Add a New App** .
3.  Enter the name of your app and your email address. Click **Create App ID** .
4.  Click **Set Up** to create a **Facebook Login** product.
    ![]({{base_path}}/assets/attachments/103333132/103333133.png)5.  Select **Web** to work with this sample. You can select any other platform you wish to use.
    ![]({{base_path}}/assets/attachments/103333132/103333134.png)
        !!! note
    Change the port offset to 1 by modifying the `<Offset>` element value in `<IAM_HOME>/repository/conf/carbon.xml` as following.

        <Offset>1</Offset>


6.  Add the `serverURL` of WSO2 Identity Server (which is configured with offset=1) <https://localhost:9444/> and click **Save** and **Continue** .

        !!! info
    If you have changed the hostname of identity server use that instead of `localhost` .

    For example, if the host name is [identity.com](http://identity.com/) , then the server URL is [https://identity.com:9444/](https://localhost:9444/)


    ![]({{base_path}}/assets/attachments/103333132/103333135.png)
7.  Go to **Set Up the Facebook SDK for JavaScript** . Click **Next**
8.  Click **Settings** and select **Basic** . You can find your App ID and the App Secret as shown in the image below.
    ![]({{base_path}}/assets/attachments/103333132/103333136.png)9.  Select a **Category** for you application.
    ![]({{base_path}}/assets/attachments/103333132/103333137.png){height="250"} Add the correct **Site URL** as shown below and click **Save Changes** .
    ![]({{base_path}}/assets/attachments/103333132/103333138.png)10. Click on the new **Facebook Login** product you have added and configure it as follows.
    ![]({{base_path}}/assets/attachments/103333132/103333139.png)
    | Parameter                 | Value                                                                                           |
    |---------------------------|-------------------------------------------------------------------------------------------------|
    | Client OAuth Login        | `Yes`|
    | Web OAuth Login           | `Yes`|
    | Valid OAuth Redirect URLs | `https://localhost:9444/commonauth` |

        !!! info
    After the user authorizes the application, the authorization server redirects the user back to the application with access token or the authorization code in the URL. Since the redirected URL contains sensitive information, it is required to assure that the service does not redirect to arbitrary locations. The best way to ensure that the user is directed to the appropriate location is to define an **OAuth Redirect URL** as shown above.


Now you have configured Facebook as your Identity Provider

### Configure Facebook login with Identity Server

Let's see how to configure WSO2 Identity Server to work with Facebook for user authentication, so that when you try to login to the API Publisher or Store, WSO2 Identity Server will redirect to Facebook to do the authentication. As a prerequisite, you have to configure WSO2 Identity Server by [adding a new identity provider](https://docs.wso2.com/display/IS560/Adding+and+Configuring+an+Identity+Provider) [.](https://www.google.com/url?q=https://docs.wso2.com/display/IS510/Configuring%2Ban%2BIdentity%2BProvider&sa=D&ust=1501139786741000&usg=AFQjCNF915u-JBkmBg_29seNjQ8dQTTudg){.c6}

1.  Download the WSO2 Identity Server 5.5.0 [here](https://wso2.com/identity-and-access-management#download) .
2.  [Configure Single Sign On with WSO2 API Manager 2.5.0](https://docs.wso2.com/display/AM250/Configuring+Identity+Server+as+IDP+for+SSO) .
3.  Log in to the [Management Console](https://docs.wso2.com/display/IS550/Getting+Started+with+the+Management+Console) of WSO2 Identity Server as an administrator.
4.  Go to the **Identity** section under the Main tab. Click **Add** under **Identity Providers** and enter following details.

    | Identity provider Name | Alias                                 |
    |------------------------|---------------------------------------|
    | facebook               | <https://localhost:9444/oauth2/token> |

        !!! note
    To authenticate the user with Facebook (External System) we have to configure the federated authenticator. For more details, see [Federated Authetication](https://docs.wso2.com/display/IS560/Federated+Authentication) .


5.  Go to **Facebook Configuration** under **Federated Authenticators** .

6.  Enter the **Client ID** and **Client Secret** values obtained from the Facebook app created in the previous section .
7.  Select **Enable Facebook Authenticator** and select **Default** to make it the default authentication method.
8.  Enter the User information fields you want to retrieve separated by commas under **User Information fields** .
9.  Click **Register** .

        !!! note
    The **Scope** defines the permission to access particular information from a Facebook profile. See the [Permissions Reference](https://developers.facebook.com/docs/facebook-login/permissions) for a list of the different permission groups in Facebook APIs.


    ![]({{base_path}}/assets/attachments/103333132/103333140.png)
### Configuring requested claims for user authentication in Facebook Identity Provider

We need to acquire the identity information by configuring claims for use Authentication in facebook. Let's see how you can configure Identity Server with Facebook by mapping the claims. For more information on claim Mapping refer [Claim Management](https://docs.wso2.com/display/IS560/Claim+Management) .

1.  Go to the **Identity** section under the **Main** tab. Select **List** under **Identity Providers** .
2.  Click **Edit** to edit the facebook identity provider you created.
3.  Go to **Basic Claim Configuration** under **Claim Configuration**
4.  Select the **Define Custom Claim Dialect** option under **Select Claim mapping Dialect** . Click **Add Claim Mapping** to add custom claim mappings as follows.
    ![]({{base_path}}/assets/attachments/103333132/103333146.png)    If you prefer to use the User ID as your first name of Facebook account, configure `first_name` claim as above. You need to select the same claim as **UserID Claim URI** .
5.  The following are some common attribute names. You can map these names to any suitable **Local Claim URI** . (Local Claim is a set of standard claim values which are local to the WSO2 Identity Server)
    -`id           `
    -`email           `
    -`name           `
    -`first_name           `
    -`last_name           `
    -`link           `
    -`gender           `
    -`locale           `
    -`age_range           `

For more information, see [Permissions Reference - Facebook Login.](https://developers.facebook.com/docs/facebook-login/permissions/v2.0)

### Configure service providers to the Publisher and Store with the Facebook Identity Provider

To federate logging in to the Publisher and Store with Facebook, you need to configure the service provider with the Facebook Identity Provider.

!!! note
You have to allow the usage of email addresses as usernames, to use email addresses. For instructions, [Setting up an e-mail login](https://docs.wso2.com/display/AM250/Maintaining+Logins+and+Passwords#MaintainingLoginsandPasswords-emaillogin) .


1.  Go to the Management console of WSO2 Identity Server ( `https://localhost:9444/carbon` ) and click on **Service Providers** .
2.  Click **Edit** to edit the `API_PUBLISHER` .
    ![]({{base_path}}/assets/attachments/103333132/103333147.png)3.  Go to the **Local and Outbound Authentication Configuration** section.  Select the Identity Provider you created from the dropdown list under **Federated Authentication** .
4.  Make sure that **Federated Authentication** is selected. Click **Update** to save the changes.
    ![]({{base_path}}/assets/attachments/103333132/103333148.png)5.  Repeat steps 1 to 4 and configure the `API_STORE` service provider.

### Test Facebook authentication

1.  Access the API Publisher via https://localhost:/publisher . Observe the request redirect to the WSO2 IS SAML2.0 based SSO login page and then Facebook login page.
2.  Enter the username and password of you facebook account.
    ![]({{base_path}}/assets/attachments/103333132/103333149.png)3.  After successfully authenticating the log in, you will be logged into the API Publisher. Your username will be the first name of your Facebook account. This is because you have already configured the first name as the **UserID Claim URI** .
    If you configure your **UserID Claim URI** with the `last_name` , your username will be the last name of your Facebook account.

### Configure the associated social login in IS dashboard

Identity Server has a dashboard which offers multiple options for users to maintain user accounts. Associating a social login for their account is a one of the options provided in this dashboard.This dashboard can be accessed in the following URL : `https://<IS_HOST>:<IS_PORT>/dashboard.` By association the social login you have the option to use local claims, instead of showing the logged name as facebook username you can use logged users as the username in user local user store

1.  Login to the dashboard with Developer Portal user account.
2.  Click **View Details** in the **Social Login** gadget.
    ![]({{base_path}}/assets/attachments/103333132/103333150.png)3.  Click **Associate Social Login** to give your facebook account details.
    ![]({{base_path}}/assets/attachments/103333132/103333151.png)4.  Enter your IDP ID (facebook) and your username (as configured in **Subject Claim URI** ) and click **Register** .
    ![]({{base_path}}/assets/attachments/103333132/103333152.png)5.  Select **Local & Outbound Configuration** and check **Assert identity using mapped local subject identifier.
    ** ![]({{base_path}}/assets/attachments/103333132/103333153.png)
After logging in to API Publisher, you will see the configured local claim appearing as your username.

You have now successfully logged in to the API Publisher using your facebook credentials.
