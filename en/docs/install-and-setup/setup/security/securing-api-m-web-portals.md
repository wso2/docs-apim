# Securing Web portals

The WSO2 API Manager runtime contains the following web portals/applications: **Management Console**, **API Publisher**, and the **Developer Portal**. See the topics given below to configure these portals for better security before you use them.

## Update SSL certifacates

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

-   To control access only to the management console, add the IP addresses to the `<APIM-M_HOME>/repository/conf/tomcat/carbon/META-INF/context.xml` file as follows:

    ```xml
    <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="<IP-address-01>|<IP-address-02>|<IP-address-03>"/>
    ```

    The `RemoteAddrValve` Tomcat valve defined in this file will only apply to the Carbon management console, and thereby all outside requests to the management console will be blocked.

-   To control access to all web applications deployed in your server, add the IP addresses to the `<APIM-M_HOME>/repository/conf/context.xml` file as follows:

    ```xml
    <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="<IP-address-01>|<IP-address-02>|<IP-address-03>"/>
    ```

    The `RemoteAddrValve` Tomcat valve defined in this file will apply to each web application hosted on the Carbon server. Therefore, all outside requests to any web application will be blocked.

-   You can also restrict access to particular servlets in a web application by adding a Remote Address Filter to the `web.xml` file (stored in the `<APIM-M_HOME>/repository/conf/tomcat/` directory) and by mapping that filter to the servlet URL. In the Remote Address Filter that you add, you can specify the IP addresses that should be allowed to access the servlet.

    The following example from a `web.xml` file illustrates how access to the management page (`/carbon/admin/login.jsp`) is granted only to one IP address:

    ```xml
    <filter> 
        <filter-name>Remote Address Filter</filter-name> 
        <filter-class>org.apache.catalina.filters.RemoteAddrFilter</filter-class> 
        <init-param> 
            <param-name>allow</param-name> 
            <param-value>127.0.01</param-value> 
        </init-param> 
    </filter> 
    <filter-mapping> 
        <filter-name>Remote Address Filter</filter-name> 
        <url-pattern>/carbon/admin/login.jsp</url-pattern> 
    </filter-mapping>
    ```

    !!! Info
        Any configurations (including valves defined in the `<APIM-M_HOME>/repository/conf/tomcat/catalina-server.xml` file) apply to all web applications and are available globally across the server, regardless of the host or cluster. For more information on using remote host filters, see the [Apache Tomcat documentation](http://tomcat.apache.org/tomcat-7.0-doc/config/valve.html#Remote_Host_Filter).

## What's Next?

[Start the API-M runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m) and access the web portals.