# Identity Management for the API Developer Portal

Identity management for the API developer portal includes the following features.

-   [Password Recovery]({{base_path}}/administer/product-security/identity-management-for-the-api-dev-portal/#password-recovery)
-   [Account locking]({{base_path}}/administer/product-security/identity-management-for-the-api-dev-portal/#account-locking)
-   [Password policies]({{base_path}}/administer/product-security/identity-management-for-the-api-dev-portal/#Password-policies)

Apart from the above main features, there is another feature to [Disable the Anonymous Access to the Developer Portal]({{base_path}}/administer/product-security/identity-management-for-the-api-dev-portal/#disabling-anonymous-access-to-the-developer-portal).

### Password Recovery

Password recovery feature does not work by default because an email server is not configured to send the password recovery email. Follow the steps below to enable password recovery feature for the API Developer Portal.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file and add a mail server configuration as shown below. See [Configuring the Email Sending Module](https://is.docs.wso2.com/en/5.9.0/setup/configuring-email-sending/) for more information.

    ``` java
     [output_adapter.email]
     from_address = "abcd@gmail.com"
     username = "abcd@gmail.com"
     password = "xxxxxx"
     hostname = "smtp.gmail.com"
     port = "587"
     enable_start_tls = true
     enable_authentication = true
    ```

2.  After the mail server is configured, the user can click on the **Forgot Password** link on the Sign In page of the API Developer Portal and request a password change.
    
    ![signin-forgot-password-link]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/forgot-password.png)

3.  Enter the username you are trying to recover the password of and click **Submit**.
   
    ![password-recovery-page]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/password-recovery-form.png )

4.  You will receive an email with instructions to reset your password. Note that this is email is sent to the email address stored during user sign up.

    !!! note
        You can change the the template of this email (E.g., email link, message body, etc.). To edit the mail template, open the `<API-M_HOME>/repository/conf/email/email-admin-config.xml` file and make the changes.

### Account locking

You can lock user accounts with the Account recovery and credential management feature, pre-installed in WSO2 API Manager.

-   [Account locking by failed login attempts]({{base_path}}/administer/product-security/identity-management-for-the-api-dev-portal/#account-locking-by-failed-login-attempts)
-   [Account locking by an administrative user]({{base_path}}/administer/product-security/identity-management-for-the-api-dev-portal/#account-locking-by-an-administrative-user)

#### Account locking by failed login attempts

The following steps show how to enable account locking. See [Account Locking by Failed Login Attempts](https://is.docs.wso2.com/en/5.9.0/learn/account-locking-by-failed-login-attempts/) for more information. 

1.  Log into the Management Console( `https://<API-M_HOST>:<API-M_PORT>/carbon` ) using admin credentials..

2.  Click **Resident** under **Identity Providers** found in the **Main** tab.

3.  Expand the **Login Policies** tab.

4.  Expand the **Account Locking** tab and tick the **Account Lock Enabled** checkbox. Click **Update** to save changes.

    ![enable-account-lock]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-config.png)

!!! info
    An error message similar to the following will be logged in wso2carbon.log when the account is locked.
    
    ``` java
        ERROR - Account is locked for user alex in user store PRIMARY in tenant carbon.super. Cannot login until the account is unlocked.
    ```


#### Account locking by an administrative user

An administrative user can lock and unlock a particular user's account through the management console. See [Locking a Specific User Account](https://is.docs.wso2.com/en/5.9.0/learn/locking-a-specific-user-account/) for more information. 

1.  Log in to the Management Console( `https://<API-M_HOST>:<API-M_PORT>/carbon` ) using admin credentials.

2.  Go to **Claims &gt; List** on the **Main** tab and select the `http://wso2.org/claims` claim dialect.

3.  Expand the **Account Locked** claim and click **Edit** .
   
    ![account-lock-claim]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-claim-edit.png)

4.  Tick the **Supported by Default** checkbox and click **Update**. This is done to make the **Account Locked** status appear in the user's profile.
   
    ![edit-account-lock-claim]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-claim-update.png)

5.  Go to **Users and Roles &gt; List &gt; Users** on the **Main** menu and click on **User Profile** of the user you want to lock.

6.  Tick the checkbox in front of the **Account Locked** field to lock the account for the user and click **Update** .
   
    ![profile-account-lock]({{base_path}}/assets/img/administer/product-security/identity-management-for-the-api-dev-portal/account-lock-checkbox.png)

### Password policies

You can define custom password policies for API developer portal user signup. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and add the password policy configuration based on your preference as shown below. See [Writing a Custom Password Validator](https://is.docs.wso2.com/en/5.9.0/develop/writing-a-custom-password-validator/) for more information.

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

### Disabling anonymous access to the Developer Portal

!!! warning
    This feature is supported by default only from WSO2 API Manager 3.2.0 onwards. It is 
    available for WSO2 APIM 3.0.0 only as a **WUM** update and is effective from 29th January 2021 (2021-01-29). For more 
    information on how to update using WUM, see the documentation [Using WSO2 Update Manager](https://docs.wso2.com/display/updates100/Using+WSO2+Update+Manager).

By default, anonymous access to the Developer Portal is enabled. Therefore, users do not need to authenticate themselves by way of signing in when accessing the Developer Portal in WSO2 API Manager. However, if required, you can disable anonymous access to the Developer Portal to prevent anonymous users from accessing the Developer Portal. When anonymous access is disabled, users will not be allowed to access the Developer Portal UI without appropriate login details or an access token.

Follow the instructions below to disable anonymous access to the Developer Portal for a particular tenant:

1. Sign in to the WSO2 API-M Management Console as a tenant admin user.

    `https://<API-M_host>:<API-M_port>/carbon`

2. Navigate to **Main > Resources > Browse** 

3. Enter `/_system/config/apimgt/applicationdata/tenant-conf.json` as the location and click **Go** to browse the registry and locate the required resource.

4. Add the field named `EnableAnonymous` with the value `false` to the `tenant-conf.json` as shown below.

    [![Disabling Developer Portal Anonymous Mode]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)]({{base_path}}/assets/img/administer/disable-developer-portal-anonymous-mode.png)

5. Restart the server or wait for 15 mins until the registry cache expires.

6. Navigate to the Developer Portal.

     `https://<API-M_host>:<API-M_port>/devportal` 

     You will be automatically redirected to the Sign In page if you have not previously authenticated yourself by signing in to the Developer Portal.

    !!! info
        If you have a multi-tenant environment, when you navigate to `https://<API-M_host>:<API-M_port>/devportal`, it will ask you to select the tenant first. When you select a tenant, if the anonymous mode is disabled for that tenant (by following the above steps), you will be redirected to the Sign In page if you have not previously authenticated yourself by signing in to the Developer Portal.
