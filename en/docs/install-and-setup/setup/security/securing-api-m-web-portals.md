# Securing Web portals

The WSO2 API Manager runtime contains the following web portals/applications: **Management Console**, **API Publisher**, and the **Developer Portal**. See the topics given below to configure these portals for better security before you use them.

## Update SSL certificates

The Web portals of API-M are based on the HTTPS protocol, which is a combination of HTTP and SSL protocols. This protocol is generally used to encrypt the traffic from the client to the server for security reasons. 

The default SSL certificate of these web portals is used for encryption only and does not prove the server identity. Therefore, when you try to access these portals, a warning of an untrusted connection is usually displayed. To access the portals using this default certificate, you should first "accept" the certificate. 

If you are using the Mozilla Firefox browser, you are usually required to accept the certificate on the first instance, after which the certificate is stored in the browser database and marked as trusted. With other browsers, the insecure connection warning might be displayed every time you access the server.
    
You can use the default certificate for testing purposes or for running the web portals on your company's internal networks. If you want to make these portals available to external users, your organization should obtain a certificate signed by a well-known certificate authority, which verifies that the server has the name it is accessed by and that this server belongs to the given organization. 

See [Creating new keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores) to learn more about using certificates.

## Configuring session time-out

If you leave the management console unattended for a defined time, the sign-in session will time out. The default timeout value is 15 minutes, but you can change this by adding the following configurations in the `deployment.toml` (stored in the `<APIM-M_HOME>/repository/conf/` folder):

```toml
[tomcat.management_console]
session_timeout = "30m"
```

You can configure a session timeout for the other web portals (**Publisher** and **Developer Portal**) by changing the following configuration in the `deployment.toml` (stored in the `<APIM-M_HOME>/repository/conf/` folder):

```toml
[tomcat.global]
session_timeout = "30m"
```

## Restricting access to web portals

You can restrict access to the management console of the API-M runtime by binding the management console with selected IP addresses. Note that you can either restrict access to the management console only, or you can restrict access to all web portals as explained below.

-   To control access only to the management console, add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file:

    ```toml
    [admin_console.control_access]
    enable = true
    allow = ["IP1", "IP2", "IP3"]
    ```

    This adds a `RemoteAddrValve` Tomcat valve in the `<API-M_HOME>/repository/conf/tomcat/carbon/META-INF/context.xml` file and it will only apply to the Carbon management console, and thereby all outside requests to the management console will be blocked.

-   To control access to all web applications deployed in your server, add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file:

    ```toml
    [web_app.control_access]
    enable = true
    allow =  ["IP1", "IP2", "IP3"]
    ```

    This will add a `RemoteAddrValve` Tomcat valve in the `<API-M_HOME>/repository/conf/tomcat/context.xml` file and it will apply to each web application hosted on the Carbon server. Therefore, all outside requests to any web application will be blocked.

-   You can also restrict access to particular servlets in a web application by adding the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file:

    ```toml
    [[servlet_access_control_filter]]
    filter_name = "Remote Address Filter"
    allow_ip_regex = "127.0.0.1"
    url_pattern = "/carbon/admin/login.jsp"
    ```

    This will add Remote Address Filter to the web.xml file (stored in the `<APIM-M_HOME>/repository/conf/tomcat/` directory) by mapping that filter to the servlet URL. In the Remote Address Filter that you add, you can specify the IP addresses that should be allowed to access the servlet.

The above example deployment.toml configuration illustrates how access to the management page (/carbon/admin/login.jsp) is granted only to one IP address.

## Bypass Client Credentials by making PKCE Mandatory

You can bypass the `Client Secret` in the Devportal and the Publisher web portals in WSO2 API Manager.  Follow the steps below:

- Bypass Client Secret for the web portal
- Make PKCE mandatory for the web portal

1. First, go to the Management Console (carbon/admin) and log in as the admin.

2. On the left side, select `Service Providers` and `List`.

    <html>
        <div class="admonition note">
            <p class="admonition-title">Note</p>
            <p>When you attempt to log in to Devportal or Publisher, a service provider will be created for that portal. You can view those service providers in the above `list`. For example, apim_devportal for Devportal.</p>
        </div>
    </html>

3. Edit the service provider you need to change (Devportal or Publisher) and select `Inbound Authentication Configuration`.

4. Select `OAuth/OpenID Connect Configuration`. You will be able to view OAuth Client Key and Secret.

5. Then, select `Edit`. This will redirect you to the `Update application settings` form.

6. Select `PKCE Mandatory` and `Allow authentication without the client secret` from the form.

    <html>
        <div class="admonition note">
            <p class="admonition-title">Note</p>
            <p>Make sure to select both options. It's not recommended to bypass Client Secret without making PKCE mandatory, otherwise it will not work.</p>
        </div>
    </html>

7. Click `Update`.

After completing the steps above, the respective web portal will no longer use the Client Secret for authentication.

## What's Next?

[Start the API-M runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m) and access the web portals.
