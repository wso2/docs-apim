# Setting Up ReCaptcha

[reCaptcha](https://developers.google.com/recaptcha/) is a free service
provided by Google that can be used for protection against spam or other
forms of internet abuse by verifying whether a user is a human or a
robot. It comes in the form of a widget. The following section guides
you through setting up reCaptcha with the WSO2 Identity Server and how
to use it in different scenarios.

### How it works

First, you will need to register and create an API key pair for the
required domain. The key pair consists of a site key and secret. The
site key is what is used when a reCaptcha widget is displayed on a page.
After verification, a new parameter called
`g-recaptcha-response` appears on the form that the
user submits. From the server side, you can verify the submitted captcha
response by calling the Google API with the secret key.

Follow the steps provided below to configure this.

### Configuring reCaptcha API keys

1. Go to <https://www.google.com/recaptcha/admin>.

2. You will see the window shown below. Fill in the fields to register
   your API Manager domain and click **Register**. The following
    are sample values:
    -   **Label:** WSO2 API Manager
    -   Select the reCAPTCHA V2 or Invisible reCAPTCHA option.
    -   **Domains:** is.apim.com  

    ![configuring-recaptcha-api-keys]({{base_path}}/assets/img/learn/api-security/recaptcha/configuring-recaptcha-api-keys.png) 
   
3. Take note of the site key and secret that you receive.
    ![note-site-key-secret]({{base_path}}/assets/img/learn/api-security/recaptcha/note-site-key-secret.png)
   
4. Open the `deployment.toml` file located in the `<API-M_HOME>/repository/conf/` directory and add the following configurations.

    ``` toml 
    # Google reCAPTCHA settings

    # Enable Google reCAPTCHA
    [recaptcha] 
    enabled= true

    # reCaptcha API URL
    api_url="https://www.google.com/recaptcha/api.js"

    # reCaptcha verification URL
    verify_url="https://www.google.com/recaptcha/api/siteverify"

    # reCaptcha site key
    site_key="6Lc8THgUAAAAAPekxT991FGFXRrsiPCMNv5PwZHB"

    # reCaptcha secret key
    secret_key="6Lc8THgUAAAAAEu83iOwSin_CSt6gqe97aa7EGFd"
   
    parameters_in_url_enabled = true
    ```

    !!! note
    
        If you have additional authorization endpoints, you need to include
        the `login.do` URL paths of these endpoints. Here,
        url\_path is the URL without the host parameters.
    
        ``` toml
        redirect_urls="url1_path,url2_path"
        ```
    
        An example of how to include the URL paths of additional
        authorization endpoints is given below.
    
        ``` toml
        redirect_urls="/authenticationendpointone/login.do,/authenticationendpointtwo/login.do"
        ```

5. Enable reCAPTCHA from the Carbon console. (**Identity Providers** -> **Resident** -> **Login Attempts Security** -> **reCaptcha for SSO Login** -> **Always prompt reCaptcha)**   ![configuring-recaptcha-from-carbon-console]({{base_path}}/assets/img/learn/api-security/recaptcha/configuring-recaptcha-from-carbon-console.png)

6. Restart the WSO2 API Manager Publisher portal.

You have successfully set up reCaptcha for your site. You can now
configure reCaptcha with any of the following:

-   [Configuring Google reCaptcha for single
    sign-on]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/configuring-recaptcha-for-single-sign-on)
-   [Configuring Google reCaptcha for self
    signup]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/configuring-recaptcha-for-self-signup)
