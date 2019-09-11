# Identity Management for the API Store

-   [Password Recovery](#IdentityManagementfortheAPIStore-PasswordRecovery)
-   [Account locking](#IdentityManagementfortheAPIStore-Accountlocking)
-   [Paasword policies](#IdentityManagementfortheAPIStore-Paaswordpolicies)

### Password Recovery

Password recovery for a store user can be done by enabling the password recovery feature. This feature will not work by default as an email server is not configured. Follow the steps below to configure it in the API Store.

1.  Open the `<API-M_HOME>repository/conf/axis2/axis2.xml` file and uncomment the following tag to configure a mail server. Change the default values with details of your mail server. See [MailTo Transport](https://docs.wso2.com/display/Carbon440/MailTo+Transport) for more information.

    ``` java
        <transportSender name="mailto" class="org.apache.axis2.transport.mail.MailTransportSender">
                <parameter name="mail.smtp.host">smtp.gmail.com</parameter>
                <parameter name="mail.smtp.port">587</parameter>
                <parameter name="mail.smtp.starttls.enable">true</parameter>
                <parameter name="mail.smtp.auth">true</parameter>
                <parameter name="mail.smtp.user">synapse.demo.0</parameter>
                <parameter name="mail.smtp.password">mailpassword</parameter>
                <parameter name="mail.smtp.from">synapse.demo.0@gmail.com</parameter>
         </transportSender>
    ```

2.  After you configure the mail server, the user can click on the **Forgot Password** link on the Sign In page of the API Store and request a password change.
    ![](attachments/103334928/103334920.png)
3.  You need to have a user account with an email configured for this feature to work. Click the **Forgot Password** link. You will be directed to the Password Reset page. Enter the username you are trying to recover the password of.
    ![](attachments/103334928/103334921.png)
4.  After you add the username, click **Request Password Change.**
    ![](attachments/103334928/103334922.png)
    You will receive a notification that the password recovery instructions have been sent to your email address. Note that this is the email address stored during user sign up.
    ![](attachments/103334928/103334923.png)
5.  You will receive an email with the following information. A sample is shown below. Click on the link given in the email.

    ``` java
            Hi Ashley
                We received a request to change the password on the Ashley account associated with this e-mail address.
                If you made this request, please click the link below to securely change your password:

                https://localhost:9443/store/site/pages/reset.jag?confirmation=0939093c-cc42-4742-9915-aba5289059b2&userstoredomain=PRIMARY&id=Ashley&tenantdomain=carbon.super

                If clicking the link doesn't seem to work, you can copy and paste the link into your browser's address
                window.

                If you did not request to have your Ashley password reset, simply disregard this email and no changes
                to your account will be made.



                Best Regards,
                WSO2 Carbon Team
                http://www.wso2.com
    ```
        !!! note
    You can change the the template of this email (E.g., email link, message body, etc.). To edit the mail template, open the `<API-M_HOME>/repository/conf/email/email-admin-config.xml` file and make the changes.


6.  You will be redirected to the page shown below to change your password.
    ![](attachments/103334928/103334924.png)

### Account locking

You can lock user accounts with the Account recovery and credential management feature, pre-installed in WSO2 API Manager.

-   [Account locking by failed login attempts](#IdentityManagementfortheAPIStore-Accountlockingbyfailedloginattempts)
-   [Account locking by an administrative user](#IdentityManagementfortheAPIStore-Accountlockingbyanadministrativeuser)

#### Account locking by failed login attempts

The following steps show how to enable account locking.

1.  Open the the `<API-M_HOME>/repository/conf/identity/identity.xml` file. Ensure that the `IdentityMgtEventListener` with the orderId=50 is set to true.

    ``` java
        <EventListener enable="true"
                    name="org.wso2.carbon.identity.mgt.IdentityMgtEventListener"
                    orderId="50" 
        type="org.wso2.carbon.user.core.listener.UserOperationEventListener"/>
    ```

2.  Open the `<API-M_HOME>/repository/conf/identity/identity-mgt.properties` file. Set the `Authentication.Policy.Enable` property to true.

    ``` java
            Authentication.Policy.Enable=true
    ```

    Change the following properties according to your preference.

    ``` java
            Authentication.Policy.Account.Lock.Time=5
            Authentication.Policy.Account.Lock.On.Failure=true
            Authentication.Policy.Account.Lock.On.Failure.Max.Attempts=3
    ```

    The description for the properties are given in the table below

    | Parameter                                                      | Description                                                                       |
    |----------------------------------------------------------------|-----------------------------------------------------------------------------------|
    | Authentication.Policy.Account.Lock.Time                        | Locks the account for the specified time period.                                  |
    | Authentication.Policy.Account.Lock.On.Failure                  | Enables the account lock policy.                                                  |
    | Authentication.Policy.Account.Lock.On.Failure.Max.Attempts     | Specifies the maximum number of unsuccessful attempts before locking the account. |

3.  Restart the server for the changes to be applied.

!!! info
An error message similar to the following will be logged in wso2carbon.log when the account is locked.

``` java
    ERROR - AuthenticationAdmin System error while Authenticating/Authorizing User : 17003 User account is locked for user : testUser. cannot login until the account is unlocked
```


#### 
Account locking by an administrative user

An administrative user can lock a user account by editing the user’s profile in the management console.

1.  Log in to the Management Console( `https://<host>:<port>/carbon` ) using admin credentials.

2.  Go to **Claims &gt; List** on the **Configure** menu and select the `http://wso2.org/claims` claim dialect.
3.  Select the **Account Locked** claim and click **Edit** .
    ![](attachments/103334928/103334925.png)
4.  Select the **Supported by Default** checkbox and click **Update** . This is done to make the **Account Locked** status appear in the user's profile.
    ![](attachments/103334928/103334926.png)
5.  Go to **Users and Roles &gt; List &gt; Users** on the **Main** menu and click on **User Profile** of the user you want to lock.

6.  Tick the checkbox in front of the Account Locked field to lock the account for the user and click **Update** .
    ![](attachments/103334928/103334927.png)

### Paasword policies

You can define custom password policies for store user signup as follows.

1.  Open the identity.xml file in the &lt;API-M\_HOME&gt;/repository/conf/identity/ folder and set the org.wso2.carbon.identity.mgt.IdentityMgtEventListener under the &lt;EventListeners&gt; tag to enable="true".

    ``` java
        <EventListener enable="true"
                    name="org.wso2.carbon.identity.mgt.IdentityMgtEventListener"
                    orderId="50" type="org.wso2.carbon.user.core.listener.UserOperationEventListener"/>
    ```

2.  Uncomment and edit the following entries in identity-mgt.properties file in &lt;API-M\_HOME&gt;/repository/conf/identity folder based on your preference.

    ``` java
            # Define password policy enforce extensions
    Password.policy.extensions.1=org.wso2.carbon.identity.mgt.policy.password.DefaultPasswordLengthPolicy
    Password.policy.extensions.1.min.length=6
    Password.policy.extensions.1.max.length=12
    Password.policy.extensions.2=org.wso2.carbon.identity.mgt.policy.password.DefaultPasswordNamePolicy
    Password.policy.extensions.3=org.wso2.carbon.identity.mgt.policy.password.DefaultPasswordPatternPolicy
    Password.policy.extensions.3.pattern=^((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*])).{0,100}$
    Password.policy.extensions.3.errorMsg='Password pattern policy violated. Password should contain a digit[0-9], a lower case letter[a-z], an upper case letter[A-Z], one of !@#$%&* characters'
    ```
For more information, see [Writing a Custom Password Validator](https://docs.wso2.com/display/IS550/Writing+a+Custom+Password+Validator) .

#### Customizing signup validation in the API Store

API Store self signup UI page input password field validation is based on the default password policy. You can change it to match with your custom policy by extending the self signup page with your custom html changes via a [sub theme](_Adding_a_New_API_Store_Theme_) .
