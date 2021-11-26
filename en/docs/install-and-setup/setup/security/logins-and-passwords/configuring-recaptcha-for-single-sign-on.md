# Configuring reCaptcha for Single Sign On

This topic guides you through configuring reCaptcha for the single sign
on flow. By configuring reCaptcha, you can mitigate or block brute force
attacks.

!!! Info 
    -   For more information on configuring single sign on, see [Configuring
    Single Sign-On With SAML2]({{base_path}}/reference/customize-product/extending-api-manager/saml2-sso/configuring-single-sign-on-with-saml2).
    -   For more information on brute force attacks, see [Mitigating Brute
    Force Attacks](https://is.docs.wso2.com/en/latest/administer/mitigating-brute-force-attacks/).

1.  Set up reCaptcha with the WSO2 API Manager. For instructions on
    how to do this and more information about reCaptcha, see [Setting Up
    ReCaptcha]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/setting-up-recaptcha).
2.  Start the API Manager and login to the management console.
3.  Click **List** under **Identity Providers** found in the **Main**
    tab.
4.  Click **Resident Identity Provider** and expand the **Login Attempts Security** tab. Then, expand the **reCaptcha for SSO Login** tab.
5.  Select the relevant option according to your requirement:

    - **Always prompt reCaptcha:** 

        Select this option to prompt users for reCaptcha with every SSO login attempt. 

    - **Prompt reCaptcha after max failed attempts:** 
    
        Select this option to prompt reCaptcha only after the number of max failed attempts has been exceeded. 
    
        If this option is selected, enter a value for the **Max failed attempts for reCaptcha** field as well. For example, if you enter 3, reCaptcha will be re-enabled after 3 failed attempts.  
        ![configure-captcha-for-sso]({{base_path}}/assets/img/learn/api-security/recaptcha/recaptcha-sso.png)
        
        Note the following when selecting this option:
        
        - Account locking must be enabled to enable **Prompt reCaptcha after max failed attempts**.

        - The **Max failed attempts for reCaptcha** value must be lower than the **Maximum failed login attempts** value configured under the **Account Lock** tab.
    
            ![configure-account-locking]({{base_path}}/assets/img/learn/api-security/recaptcha/configure-account-locking.png)
    

6.  You have now successfully configured reCaptcha for the single sign
    on flow. If the number of failed attempts reaches the maximum
    configured value, the following reCaptcha window appears.  

    ![captcha-login-failed]({{base_path}}/assets/img/learn/api-security/recaptcha/captcha-login-failed.png)
