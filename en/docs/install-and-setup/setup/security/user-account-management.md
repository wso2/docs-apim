# User Account Management

The following sections explain how to manage Developer Portal, Publisher, and the Admin Portal related user accounts.

## Enable password recovery

The password recovery feature does not work out-of-the-box because an email server needs to be configured to be able to send the password recovery email. 

Follow the steps below to enable the password recovery feature for the Developer Portal, Publisher, and the Admin Portal:

1. Shut down the server if it is running.

2. Open the `<API-M_HOME>/repository/conf/deployment.toml` file.

3. Add the following properties to configure the a e-mail server. 

     For more information, see [Configuring the Email Sending Module](https://is.docs.wso2.com/en/5.10.0/setup/configuring-email-sending/).

    ``` java
    [output_adapter.email]
    from_address = "wso2am@gmail.com"
    username = "wso2amtest"
    password = "Wso2@am70"
    signature = "do not reply"
    hostname = "smtp.gmail.com"
    port = "587"
    enable_start_tls = true
    enable_authentication = true
    ```
   
    | Property               | Description                                                                                                               |
    |------------------------|---------------------------------------------------------------------------------------------------------------------------|
    | from_address           | The email address you use to send emails.                                                                                  |
    | username               | The email address used to authenticate the mail server. This can be the same email address as the `from_address`. |
    | password               | Password used to authenticate the mail server.
    | signature              | Signature of the sender account. |

4. Re-start the server.

## Account locking

You can lock user accounts with the Account recovery and credential management feature, pre-installed in WSO2 API Manager. Account locking is applicable to the user accounts related to the Developer Portal, Publisher, and the Admin Portal.

-   [Account locking by failed login attempts](#account-locking-by-failed-login-attempts)
-   [Account locking by an administrative user](#account-locking-by-an-administrative-user)

### Account locking by failed login attempts

The following steps show how to enable account locking. See [Account Locking by Failed Login Attempts](https://is.docs.wso2.com/en/5.10.0/learn/account-locking-by-failed-login-attempts/) for more information. 

1.  Sign in to the Management Console (`https://<API-M_HOST>:<API-M_PORT>/carbon`) using admin credentials.

2.  Click **Resident** under **Identity Providers** found in the **Main** tab.

3.  Expand the **Login Policies** tab.

4.  Expand the **Account Locking** tab and tick the **Account Lock Enabled** checkbox. Click **Update** to save changes.

    ![enable-account-lock]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-config.png)

!!! info
    - If you have configured the email sending module as mentioned in [Configuring the Email Sending Module](https://is.docs.wso2.com/en/5.10.0/setup/configuring-email-sending/) and if the particular locked user's email address is correct in his profile, he/she will receive an email stating that the account is locked.
    - Again another email will be sent when the account is unlocked.

### Account locking by an administrative user

An administrative user can lock and unlock a particular user's account through the management console. See [Locking a Specific User Account](https://is.docs.wso2.com/en/5.10.0/learn/locking-a-specific-user-account/) for more information. 

1.  Sign in to the Management Console (`https://<API-M_HOST>:<API-M_PORT>/carbon`) using admin credentials.

2.  Go to **Claims &gt; List** on the **Main** tab and select the `http://wso2.org/claims` claim dialect.

3.  Expand the **Account Locked** claim and click **Edit**.
   
    ![account-lock-claim]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-claim-edit.png)

4.  Tick the **Supported by Default** checkbox and click **Update**. This is done to make the **Account Locked** status appear in the user's profile.
   
    ![edit-account-lock-claim]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-claim-update.png)

5.  Go to **Users and Roles &gt; List &gt; Users** on the **Main** menu and click on **User Profile** of the user you want to lock.

6.  Tick the checkbox in front of the **Account Locked** field to lock the account for the user and click **Update**.
   
    ![profile-account-lock]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-checkbox.png)

## Password policies

### Change the password policy

You can define your custom password policy for the Developer Portal, Publisher and Admin Portal by defining one or both of the followings.
    
#### User store password RegEx

For more information, see [Configuring a JDBC User Store]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store/#configuring-a-jdbc-user-store)  

Example:

```toml
[user_store]
type = "database_unique_id"

[user_store.properties]
PasswordJavaRegEx = "^[\\S]{6,30}$"
```

#### Identity management password policies

You can define custom password policies for the Developer portal, Publisher user signup. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and add the password policy configuration based on your preference as shown below. See [Writing a Custom Password Validator](https://is.docs.wso2.com/en/5.10.0/develop/writing-a-custom-password-validator/) for more information.

``` java
[identity_mgt.events.schemes]
passwordPolicy.properties.enable = true
passwordPolicy.properties.'min.length' = 4
passwordPolicy.properties.'max.length' = 10
passwordPolicy.properties.pattern = "^((?=.*\\\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*])).{0,100}$"
passwordPolicy.properties.errorMsg = "Password pattern policy violated. Password should contain a digit[0-9], a lower case letter[a-z], an upper case letter[A-Z], one of !@#$%&* characters"
passwordPolicy.properties.'class.PasswordLengthPolicy' = "org.wso2.carbon.identity.mgt.policy.password.DefaultPasswordLengthPolicy"
passwordPolicy.properties.'class.PasswordNamePolicy' = "org.wso2.carbon.identity.mgt.policy.password.DefaultPasswordNamePolicy"
passwordPolicy.properties.'class.PasswordPatternPolicy' = "org.wso2.carbon.identity.mgt.policy.password.DefaultPasswordPatternPolicy"
```

<html>    
<div class="admonition note">    
<p class="admonition-title">Note</p>    
<p>
<ul><li><p>
The password policy set by the identity management password policies via the configuration file can be overridden using the Management Console for each tenant.
</p></li>
<li>
<p>
When changing the password, the new password will be validated against the user store password RegEx and conditions enforced by the Identity Management password policy. Therefore, you will not be able to change your password, if these conditions/RegEx patterns are set in a way that they conflict with each other.
</p>
</li>
</ul></p>
</div>
</html>

### Display password policy guidelines in the Developer Portal
  
You can display a list of policy guidelines in the change password page that appears in the Developer Portal.  
  
<img src="{{base_path}}/assets/img/learn/change-devportal-password-policy-guideline-display.png" alt="Displaying Developer Portal password policy guidelines" width="700"/>
  
1. Enable password changing guidelines in the `settings.js` file.  

     1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/settings.js` file.  
     
     2. Edit the configuration as follows:  
   
        ```javascript
         const Settings = {
            ...
            passwordChange: {
                guidelinesEnabled: true,
                ...
            },
         };
        ```

2. List your custom guidelines under `policyList`.

    ```javascript
     const Settings = {
        ...
        passwordChange: {
            guidelinesEnabled: true,
            policyList: [
                'Policy 1',
                'Policy 2',
                'Policy 3',
            ],
        },
     };
    ```

    <html>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>If the guideline list is empty, the change password UI will not show the Password Policy guidelines section.</p>
    </div>
    </html>

## Disabling anonymous access to the Developer Portal

By default, anonymous access to the Developer Portal is enabled. Therefore, users do not need to authenticate themselves by way of signing in when accessing the Developer Portal in WSO2 API Manager. However, if required, you can disable anonymous access to the Developer Portal to prevent anonymous users from accessing the Developer Portal. When anonymous access is disabled, users will not be allowed to access the Developer Portal UI without appropriate login details or an access token.

Follow the instructions below to disable anonymous access to the Developer Portal for a particular tenant:

1. Sign in to the WSO2 API-M Management Console as a tenant admin user.

    `https://<API-M_host>:<API-M_port>/carbon`

2. Navigate to **Main > Resources > Browse** 

3. Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.

4. Add the field named `EnableAnonymous` with the value `false` to the `tenant-conf.json` as shown below.

    [![Disabling Developer Portal Anonymous Mode]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)

    !!! note
        To disable anonymous access globally, add the following to the `<API-M_HOME>/repository/conf/deployment.toml` file.
        ```toml
        [apim.devportal]
        enable_anonymous_mode=false

5. Restart the server or wait for 15 mins until the registry cache expires.

6. Navigate to the Developer Portal.

     `https://<API-M_host>:<API-M_port>/devportal` 

     You will be automatically redirected to the Sign In page if you have not previously authenticated yourself by signing in to the Developer Portal.

    !!! info
        If you have a multi-tenant environment, when you navigate to `https://<API-M_host>:<API-M_port>/devportal`, it will ask you to select the tenant first. When you select a tenant, if the anonymous mode is disabled for that tenant (by following the above steps), you will be redirected to the Sign In page if you have not previously authenticated yourself by signing in to the Developer Portal.
