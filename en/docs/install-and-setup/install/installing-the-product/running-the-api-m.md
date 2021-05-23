# Running the API Manager Runtime

Follow the steps given below to run the WSO2 API Manager runtime and access its web portals: **Management Console**, **API Publisher**, and the **Developer Portal**.

## Before you begin

[Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime) the API Manager server.

## Starting the API-M server

Follow the steps given below to start the server.

1.  Open a command prompt as explained below.

    <table>
        <tr>
            <th>On <b>Linux/Mac OS</b></td>
            <td>Establish an SSH connection to the server, log on to the text Linux console, or open a terminal window.</td>
        </tr>
        <tr>
            <th>On <b>Windows</b></td>
            <td>Click <b>Start &gt;Run</b>, type <b>cmd</b> at the prompt, and then press <b>Enter</b>.</td>
        </tr>
        <tr>
            <th>On <b>Solaris</b></td>
            <td>Click <b>Launch &gt;Run Applications</b>, type <b>dtterm</b> at the prompt, and then press <b>Enter</b>.</td>
        </tr>
    </table>     

2.  Navigate to the `<API-M_HOME>/bin` folder from your command line.
3.  Execute one of the commands given below.

    -   To start the server:

        ```bash tab="On MacOS/Linux/Solaris"
        sh api-manager.sh
        ```

        ```bash tab="On Windows"
        api-manager.bat --run
        ```

    -   To start the server in background mode:

        ```bash tab="On macOS/Linux/Solaris"
        sh api-manager.sh start
        ```

        ```bash tab="On Windows"
        api-manager.bat --start
        ```

    !!! Info
        If you are starting the product in service/nohup mode in Solaris, do the following:

        1. Update the `<API-M_HOME>/bin/api-manager.sh` file as follows:

            1.  Search for the following occurrences: 
                    
                    ```bash
                    nohup sh "$CARBON_HOME"/bin/api-manager.sh $args > /dev/null 2>&1 &
                    ```

            2.  Replace those occurrences with the following: 
                
                    ```bash
                    nohup bash "$CARBON_HOME"/bin/api-manager.sh $args > /dev/null 2>&1 &
                    ```

                !!! Tip
                    The only change is replacing `sh` with `bash`.

        2. Update your **PATH** variable to have `/usr/xpg4/bin/sh` as the first element. This is because `/usr/xpg4/bin/sh` contains an **sh** shell that is newer than the default **sh** shell. You can set this variable as a system property in the `api-manager.sh` script or you can run the following command from the command line:

             ```bash
             export PATH=/usr/xpg4/bin/sh:$PATH
             ```

        3. Start the server.

When the server starts successfully, the following log is printed: `"WSO2 Carbon started in 'n' seconds"`

## Accessing the Web Portals

When you start the API-M runtime, all of its web portals are started. You will see the URLs of each portal printed in the server-startup log as shown below.

![API-M server startup log]({{base_path}}/assets/img/setup-and-install/running-product-mgt-console-url.png)

You can use these URLs to access the web portals on this computer from any other computer connected to the LAN. When accessing the portals from the same server where it is installed, you can type `localhost` instead of the IP address.

!!! Info  
    The server is running on `localhost` by default. To change the default hostname and default port see the following topics:

    - [Changing the API-M hostname]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m)
    - [Changing the default API-M ports]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#changing-the-default-api-m-ports)

To sign in to each web portal:

1.  Copy the web portal's URL to your browser.

    !!! Tip
        The web browser typically displays an "insecure connection" message, which requires your confirmation before you can continue.

2.  Enter your username and password to sign in.

    !!! Tip
        The default username and password is `admin`.

## Stopping the API-M server

-   To stop the API-M server standalone application, go to the terminal and press <i>Ctrl+C</i>.
-   To stop the API-M server in background mode:

    ```bash tab="On macOS/Linux/Solaris"
    sh api-manager.sh stop
    ```

    ```bash tab="On Windows"
    api-manager.bat stop
    ```

!!! Tip
    For additional options, you can use with the startup commands, add `-help` after the start-up command as shown below.

    ```bash
    sh api-manager.sh -help
    ```

## Troubleshooting server startup errors

-   If you are in a Windows environment, the HTTPS listener would have started on a host address of 0:0:0:0:0:0:0:0. You can verify that from the Carbon logs. In that case, you need to define 0:0:0:0:0:0:0:0 as the bind address in `<API-M_HOME>/repository/resources/security/listenerprofiles.xml` to avoid errors during SSL reloads.
-   If you are on a Mac OS, you may encounter the following startup error with similar logs.

    ```bash
    [2021-04-16 08:48:27,655] ERROR - InboundEndpoint Error initializing inbound endpoint SecureWebhookServer
    [2021-04-16 08:48:27,655] ERROR - InboundEndpointDeployer Inbound Endpoint deployment from the file : /Users/sanjeewa/Downloads/wso2am-4.0.0/repository/deployment/server/synapse-configs/default/inbound-endpoints/SecureWebhookServer.xml : Failed.
    org.apache.synapse.SynapseException: Error initializing inbound endpoint SecureWebhookServer at org.apache.synapse.inbound.InboundEndpoint.init(InboundEndpoint.java:83) ~[synapse-core_2.1.7.wso2v227.jar:2.1.7-wso2v227]
    ```

    This may occur due to a native `launchd` service `com.apple.ftp-proxy.plist` living at `/System/Library/LaunchDaemons/com.apple.ftp-proxy.plist` that fires `/usr/libexec/ftp-proxy`. To fix this issue, change the default port that the webhooks HTTPS inbound endpoint is listening in all the Gateway nodes in `<API-M_HOME>/repository/deployment/server/synapse-configs/default/inbound-endpoints/SecureWebhookServer.xml`. Change 8021 to a different port.

    ```xml
    <p:parameter  name="inbound.http.port">8021</p:parameter>
    ```

    For the Control Plane nodes (with the Publisher), change the `deployment.toml` file as follows:

    ```toml
    [[apim.gateway.environment]]
    ######## other properties ########
    websub_event_receiver_https_endpoint = "https://localhost:8021"
    ```

## See Also

-   [Installing as a Windows Service]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-as-a-windows-service/)
-   [Installing as a Linux Service]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-as-a-linux-service/)