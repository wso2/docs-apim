# Configuring reCaptcha for Self Sign-up

Self Sign-up is an important feature when it comes to commercial
applications. This feature gives the users the privilege of being a
part of your community without you having to go through the hassle of
adding them.

This topic guides you through configuring reCaptcha for the self
registration flow. By configuring reCaptcha, you can mitigate or block
brute force attacks.

!!! info 
    -   For more information on setting up self registration, see
        [Self-Sign-Up]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/enabling-or-disabling-self-signup/).
    -   For more information on brute force attacks, see [Mitigating Brute
        Force Attacks](https://is.docs.wso2.com/en/latest/administer/mitigating-brute-force-attacks/).

You can either configure the recaptcha for a tenant, or configure it globally. 

## Configuring self-registration with reCaptcha for a specific tenant

1.  Set up reCaptcha with the WSO2 API Manager. For instructions on
    how to do this and more information about reCaptcha, see [Setting Up
    ReCaptcha]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/setting-up-recaptcha).
2.  Start the WSO2 API Manager and log in to the management console.
3.  Click on **List** under **Identity Providers** on the **Main** tab.
4.  Click **Resident Identity Provider**.
5.  Expand the **Account Management Policies** tab and then expand the
    **User Self Registration** tab.
6.  Select the **Enable reCaptcha** checkbox to enable reCaptcha for the
    self registration flow.  
    ![self-registration-enable-recaptcha]({{base_path}}/assets/img/learn/api-security/recaptcha/self-registration-enable-recaptcha.png)
7.  You have now successfully configured reCaptcha for the self
    registration flow. Start the WSO2 API Manager and log in to the
    **My Account** using the following link:
    <https://localhost:9443/myaccount>

    !!! tip
        If you have changed the port offset or modified the hostname, change the port or
        hostname accordingly.
    
8.  Click the **Create Account** link.  
    ![register-now]({{base_path}}/assets/img/learn/api-security/recaptcha/register-now-option.png)
9.  At the end of the registration, the following reCaptcha window
    appears.  
    ![recaptcha-window]({{base_path}}/assets/img/learn/api-security/recaptcha/recaptcha-window.png) 

---
