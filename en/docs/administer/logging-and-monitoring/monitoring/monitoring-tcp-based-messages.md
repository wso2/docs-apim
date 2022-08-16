# Monitoring TCP-based Messages

Users can view and monitor the messages passed along a TCP-based conversation using the TCPMon utility. Therefore, this is a convenient tool, particularly useful for debugging when you develop Web services. TCPMon is an Apache project that is distributed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.html).

TCPMon is not dependent on any third-party libraries. Its user interface is based on a swing UI and works on almost all platforms that support Java.

## Starting TCPMon

TCPMon is available in the `<API-M_HOME>/bin` directory of any WSO2 Carbon based product distribution. Alternatively, you can download TCPMon from Apache and run the tool.

### Running TCPMon (from Carbon a product pack)

Ensure that the following prerequisites are fulfilled in order to run TCPMon.

-   [Install JDK]({{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-jdks).
-   Set the `JAVA_HOME` variable. 
     This setting is required only if you are using the TCPMon available in the WSO2 Carbon based product pack.

    !!! info
        For information on how to set the `JAVA_HOME` variable, go to [Installing the Product]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/#setting-up-java_home), select the instructions relevant to your operating system and refer to the 'Setting JAVA\_HOME' section.


Follow the instructions below to run the TCPMon available with your WSO2 Carbon product pack:

1.  Go to `<API-M_HOME>/bin` directory of your product pack.
2.  Execute the following command to run the tool.
    
     ``` java tab="For Windows"
     tcpmon.bat
     ```

     ``` java tab="For Linux"
     ./tcpmon.sh
     ```

### Running TCPMon (downloaded from Apache)

Follow the instructions below to download TCPMon from Apache and run the tool:

1.  Download TCPMon from the following location: <http://archive.apache.org/dist/ws/tcpmon/1.0/tcpmon-1.0-bin.zip>.
2.  Extract `tcpmon-1.0-bin.zip` archive.
3.  Go to the build of the extracted directory to find the execution script.
4.  Execute the following command to run the tool.

     ``` java tab="For Windows"
     tcpmon.bat
     ```

     ``` java tab="For Linux"
     ./tcpmon.sh
     ```

## Other Usages of TCPMon

TCPMon is primarily used for message monitoring. Additionally, TCPMon can also be used for sending requests to web services and as a proxy service.


#### Sending Requests for Web Services

TCPMon can also be used as a request sender for Web services. The request SOAP message can be pasted on the send screen and sent directly to the server.

<a href="{{base_path}}/assets/img/administer/tcpmon_screen4.png"><img src="{{base_path}}/assets/img/administer/tcpmon_screen4.png" alt="TCPMon sending requests" name="TCPMon sending requests" width="520"></a>

#### As a Proxy

TCPMon can act as a proxy. To start it in proxy mode, select the Proxy option. When acting as a proxy, TCPMon only needs the listener port to be configured.

<a href="{{base_path}}/assets/img/administer/tcpmon_screen5.png"><img src="{{base_path}}/assets/img/administer/tcpmon_screen5.png" alt="TCPMon proxy" name="TCPMon proxy" width="280"></a>

#### Advanced Settings

TCPMon can simulate a slow connection, in which case the delay and the bytes to be dropped can be configured. This is useful when testing Web services.

<a href="{{base_path}}/assets/img/administer/tcpmon_screen6.png"><img src="{{base_path}}/assets/img/administer/tcpmon_screen6.png" alt="TCPMon advanced settings" name="TCPMon advanced settings" width="280"></a>

Also, if HTTP proxy support is required, that can also be set on the admin screen.
