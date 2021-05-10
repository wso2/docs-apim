# Running the API Manager Runtime

To run WSO2 products, you start the product server at the command line. You can then run the Management Console to configure and manage the product.

### Starting the API Manager server

Follow the instructions below to start your WSO2 product based on the operating system you use.

#### On Windows/Linux/Mac OS

To start the server, run `<PRODUCT_HOME>\bin\api-manager.bat` (on Windows) or `<PRODUCT_HOME>/bin/api-manager.sh` (on Linux/Mac OS) from the command prompt as described below. Alternatively, you can install and run the server as a Windows or Linux service (see the related topics section at the end of this page).

1. Open a command prompt by following the instructions below.

    -   On Windows: Click **Start &gt;Run,** type `cmd` at the prompt, and then press **Enter** .
    -   On Linux/Mac OS: Establish an SSH connection to the server, log on to the text Linux console, or open a terminal window.

2. Navigate to the `<PRODUCT_HOME>/bin/` directory using the command prompt.

3. Execute one of the following commands:

    -   To start the server in a typical environment:
        -   On Windows: `api-manager.bat --run`
        -   On Linux/Mac OS: `sh api-manager.sh`

    -   To start the server in the background mode of Linux: `sh api-manager.sh start`
        To stop the server from running in this mode, you will enter: `sh api-manager.sh stop`

    -   To provide access to the production environment without allowing any user group (including admin) to log in to the Management Console:

        -   On Windows: `api-manager.bat --run -DworkerNode`
        -   On Linux/Mac OS: `sh api-manager.sh -DworkerNode`

    -   To check for additional options you can use with the startup commands, type `-help` after the command, such as:
    `sh api-manager.sh -help` (see the related topics section at the end of this page).

4. The operation log appears in the command window. When the product server has started successfully, the log displays the message "WSO2 Carbon started in 'n' seconds".

!!! note
     * If you are on a Windows environment, the HTTPS listener would have started on a host address of 0:0:0:0:0:0:0:0. You can verify that from the Carbon logs. In that case, you need to define 0:0:0:0:0:0:0:0 as the bindAddress in `<APIM_HOME>/repository/resources/security/listenerprofiles.xml` to avoid errors during SSL reloads.
     * If you are on Mac OS, you may encounter the following startup error with similar logs.
        ```bash
        [2021-04-16 08:48:27,655] ERROR - InboundEndpoint Error initializing inbound endpoint SecureWebhookServer
        [2021-04-16 08:48:27,655] ERROR - InboundEndpointDeployer Inbound Endpoint deployment from the file : /Users/sanjeewa/Downloads/wso2am-4.0.0/repository/deployment/server/synapse-configs/default/inbound-endpoints/SecureWebhookServer.xml : Failed.
        org.apache.synapse.SynapseException: Error initializing inbound endpoint SecureWebhookServer at org.apache.synapse.inbound.InboundEndpoint.init(InboundEndpoint.java:83) ~[synapse-core_2.1.7.wso2v227.jar:2.1.7-wso2v227]
        ```
        This may occur due to a native `launchd` service `com.apple.ftp-proxy.plist` living at `/System/Library/LaunchDaemons/com.apple.ftp-proxy.plist` that fires `/usr/libexec/ftp-proxy`. To fix this issue, change the default port that the webhooks HTTPS inbound endpoint is listening in all the Gateway nodes in `<APIM_HOME>/repository/deployment/server/synapse-configs/default/inbound-endpoints/SecureWebhookServer.xml`. Change 8021 to a different port.
        ```xml
        <p:parameter  name="inbound.http.port">8021</p:parameter>

        ```
        For publisher nodes, you need to change the `deployment.toml` file.
        ```toml
        [[apim.gateway.environment]]
        ######## other properties ########
        websub_event_receiver_https_endpoint = "https://localhost:8021"
        ```
        

#### On Solaris

To start the server, run `<PRODUCT_HOME>/bin/api-manager.sh` from the command prompt as described below.

!!! note

    Following instructions are tested on an Oracle Solaris 10 8/11 x86 environment.

1.  Click **Launch &gt;Run Applications,** type `dtterm` at the prompt, and then press **Enter** to open a command prompt.
2.  Navigate to the `<PRODUCT_HOME>/bin/` directory using the command prompt.
3.  Execute the following command: `bash` api-manager.sh
4.  The operation log appears in the command window. When the product server has started successfully, the log displays the message "WSO2 Carbon started in 'n' seconds".

!!! info

    If you are starting the product in service/nohup mode in Solaris, do the following:

    1.  Update the `<PRODUCT_HOME>/bin/api-manager.sh` file as follows:
        1.  Search for the following occurrences: `nohup sh "$CARBON_HOME"/bin/api-manager.sh $args > /dev/null 2>&1 &                         `

        2.  Replace those occurrences with the following: **`nohup                             bash                            "$CARBON_HOME"/bin/api-manager.sh $args > /dev/null 2>&1 &             `
            **

            !!! tip

                The only change is replacing `sh` with `bash` . This is required only for Solaris.


    2.  Update your **PATH** variable to have `/usr/xpg4/bin/sh` as the first element. This is because `/usr/xpg4/bin/sh` contains an **sh** shell that is newer than the default **sh** shell. You can set this variable as a system property in the `api-manager.sh` script or you can run the following command on a terminal:

        ``` java
        export PATH=/usr/xpg4/bin/sh:$PATH
        ```

    3.  Start the product by following the [above instructions](#on-solaris).

### Accessing the API Manager Web Portals

WSO2 API Manager has several web portals such as the Management Console, the API Publisher, and the Developer Portal. You can refer to the topics listed below and learn about accessing web portals.

-   [Accessing the Management Console](#accessing-the-management-console)
-   [Accessing the API Publisher](#accessing-the-api-publisher)
-   [Accessing the Developer Portal](#accessing-the-developer-portal)

 When signing in to the web portals, the web browser typically displays an "insecure connection" message, which requires your confirmation before you can continue.

!!! info
    Web portals are based on the HTTPS protocol, which is a combination of HTTP and SSL protocols. This protocol is generally used to encrypt the traffic from the client to the server for security reasons. The certificate it works with is used for encryption only and does not prove the server identity. Therefore, when you try to access these portals, a warning of an untrusted connection is usually displayed. To continue working with this certificate, some steps should be taken to "accept" the certificate before access to the site is permitted. If you are using the Mozilla Firefox browser, this usually occurs only on the first access to the server, after which the certificate is stored in the browser database and marked as trusted. With other browsers, the insecure connection warning might be displayed every time you access the server.

   This scenario is suitable for testing purposes or for running the program on the company's internal networks. If you want to make the above portals available to external users, your organization should obtain a certificate signed by a well-known certificate authority, which verifies that the server actually has the name it is accessed by and that this server actually belongs to the given organization. Refer [Creating new keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores) to learn more about the information on configuring the keystores using certificates.

### Accessing the API Manager's Management Console

Once the server has started, you can run the Management Console by typing its URL in a web browser. The following sections provide more information about running the Management Console:

-   [Working with the URL](#working-with-the-url)
-   [Signing in](#signing-in)
-   [Getting help](#getting-help)
-   [Configuring the session time-out](#configuring-the-session-time-out)

##### Working with the URL

The URL appears next to `Mgt Console URL` in the start script log that is displayed in the command window. For example:

![]({{base_path}}/assets/img/setup-and-install/running-product-mgt-console-url.png)

The URL should be in the following format: `https://<Server Host>:9443/carbon`

You can use this URL to access the Management Console on this computer from any other computer connected to the Internet or LAN. When accessing the Management Console from the same server where it is installed, you can type `localhost` instead of the IP address as follows: `https://localhost:9443/carbon`

!!! note
    You can change the Management Console URL by modifying the value of the `hostname` property in the `<PRODUCT_HOME>/repository/conf/deployment.toml` file. When the host is internal or not resolved by a DNS, map the hostname alias to its IP address in the `/etc/hosts` file of your system, and then enter that alias as the value of the `hostname` property in `deployment.toml` . For example:

    ``` java
    In /etc/hosts:
    127.0.0.1       localhost

    In deployment.toml:
    [server]
    hostname = "localhost"
    ```

##### Signing in

At the sign-in screen, you can sign in to the Management Console using **admin** as both the username and password.

##### Getting help

The tabs and menu items in the navigation pane on the left may vary depending on the features you have installed. To view information about a particular page, click the **Help** link at the top right corner of that page, or click the **Docs** link to open the documentation for full information on managing the product.

##### Configuring the session time-out

If you leave the Management Console unattended for a defined time, its login session will time out. The default timeout value is 15 minutes, but you can change this by adding the configurations in the `<APIM-M_HOME>/repository/conf/deployment.toml` file as follows.

``` java
[tomcat.management_console]
session_timeout = "30m"
```

!!! tip

    In products like WSO2 API Manager where web applications such as API Publisher/Developer Portal exist, you can configure a session timeout for those web apps by changing the `<APIM-M_HOME>/repository/conf/deployment.toml` file by adding the configurations as follows:

    ``` java
    [tomcat.global]
    session_timeout = "30m"
    ```

### Accessing the API Publisher

Once the server has started, you can run the API Publisher by typing its URL in a web browser. The following sections provide more information about running the API Publisher:

-   [Working with the URL](#working-with-the-url_1)
-   [Signing in](#signing-in_1)

##### Working with the URL

The URL appears next to `API Publisher Default Context` in the start script log that is displayed in the command window. For example:

![]({{base_path}}/assets/img/setup-and-install/running-product-publisher-url.png)

The URL should be in the following format: `https://<Server Host>:9443/publisher        `

You can use this URL to access the API Publisher on this computer from any other computer connected to the Internet or LAN. When accessing the API Publisher from the same server where it is installed, you can type `localhost` instead of the IP address as follows: `https://localhost:9443/publisher`

##### Signing in

At the sign-in screen, you can sign in to the API Publisher using **admin** as both the username and password.

### Accessing the Developer Portal

Once the server has started, you can run the Developer Portal by typing its URL in a web browser. The following sections provide more information about running the Developer Portal:

-   [Working with the URL](#working-with-the-url_2)
-   [Signing in](#signing-in_2)

##### Working with the URL

The URL appears next to `Developer Portal Default Context` in the start script log that is displayed in the command window. For example:

![]({{base_path}}/assets/img/setup-and-install/running-product-dev-portal-url.png)

The URL should be in the following format: `https://<Server Host>:9443/devportal        `

You can use this URL to access the Developer Portal on this computer from any other computer connected to the Internet or LAN. When accessing the Developer Portal from the same server where it is installed, you can type `localhost` instead of the IP address as follows: `https://localhost:9443/devportal                                  `

##### Signing in

At the Developer Portal home page, you can click the sign-in link at the top right corner to sign in to the API Publisher using **admin** as both the username and password.

### Stopping the server

To stop the server, press **Ctrl+C** in the command window, or click the **Shutdown/Restart** link in the navigation pane in the Management Console. If you started the server in background mode in Linux, enter the following command instead:

`sh <PRODUCT_HOME>/bin/api-manager.sh stop        `

### Restricting access to the Management Console and web applications

You can restrict access to the management console of your product by binding the management console with selected IP addresses. Note that you can either restrict access to the management console only, or you can restrict access to all web applications in your server as explained below.

-   To control access only to the management console, add the IP addresses to the `<PRODUCT_HOME>/repository/conf/tomcat/carbon/META-INF/context.xml` file as follows:

    ``` java
    <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="<IP-address-01>|<IP-address-02>|<IP-address-03>"/>
    ```

    The `RemoteAddrValve` Tomcat valve defined in this file will only apply to the Carbon management console, and thereby all outside requests to the management console will be blocked.

<!-- -->

-   To control access to all web applications deployed in your server, add the IP addresses to the `<PRODUCT_HOME>/repository/conf/context.xml` file as follows:

    ``` java
    <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="<IP-address-01>|<IP-address-02>|<IP-address-03>"/>
    ```

    The `RemoteAddrValve` Tomcat valve defined in this file will apply to each web application hosted on the Carbon server. Therefore, all outside requests to any web application will be blocked.

<!-- -->

-   You can also restrict access to particular servlets in a web application by adding a Remote Address Filter to the `web.xml` file (stored in the `<PRODUCT_HOME>/repository/conf/tomcat/` directory), and by mapping that filter to the servlet URL. In the Remote Address Filter that you add, you can specify the IP addresses that should be allowed to access the servlet.

    The following example from a `web.xml` file illustrates how access to the management page ( `/carbon/admin/login.jsp` ) is granted only to one IP address:
    ``` java
    <filter> <filter-name>Remote Address Filter</filter-name> <filter-class>org.apache.catalina.filters.RemoteAddrFilter</filter-class> <init-param> <param-name>allow</param-name> <param-value>127.0.01</param-value> </init-param> </filter> <filter-mapping> <filter-name>Remote Address Filter</filter-name> <url-pattern>/carbon/admin/login.jsp</url-pattern> </filter-mapping>
    ```
!!! info

    Any configurations (including valves defined in the <PRODUCT_HOME>/repository/conf/tomcat/catalina-server.xml file) apply to all web applications and are available globally across the server, regardless of the host or cluster. For more information on using remote host filters, see the [Apache Tomcat documentation](http://tomcat.apache.org/tomcat-7.0-doc/config/valve.html#Remote_Host_Filter).

**Related Topics**

-   [Installing as a Windows Service]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-as-a-windows-service/)
-   [Installing as a Linux Service]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-as-a-linux-service/)
