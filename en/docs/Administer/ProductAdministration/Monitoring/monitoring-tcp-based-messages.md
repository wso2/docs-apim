# admin\_Monitoring TCP-Based Messages

Users can view and monitor the messages passed along a TCP-based conversation using the TCPMon utility. Therefore, this is a convenient tool, particularly useful for debugging when you develop Web services. TCPMon is an Apache project distributed under [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.html) .

TCPMon is not dependent on any third party libraries. Its user interface is based on a swing UI and works on almost all platforms that support Java.

-   [admin\_Starting TCPMon](_admin_Starting_TCPMon_)
-   [admin\_Message Monitoring with TCPMon](_admin_Message_Monitoring_with_TCPMon_)
-   [admin\_Other Usages of TCPMon](_admin_Other_Usages_of_TCPMon_)


# admin\_Starting TCPMon

TCPMon is available in the `<PRODUCT_HOME>/bin` directory of any WSO2 Carbon based product distribution. Alternatively, you can download TCPMon from Apache and run the tool.

-   [Running TCPMon (from Carbon product pack)](#admin_StartingTCPMon-RunningTCPMon(fromCarbonproductpack))
-   [Running TCPMon (downloaded from Apache)](#admin_StartingTCPMon-RunningTCPMon(downloadedfromApache))

### Running TCPMon (from Carbon product pack)

Ensure that the following prerequisites are fulfilled in order to run TCPMon.

-   Install JDK 1.4 or later version.
-   Set the `JAVA_HOME` variable. This setting is required only if you are using the TCPMon available in the WSO2 Carbon based product pack.

        !!! info
    For information on how to set the `JAVA_HOME` variable, go to [Installing the Product](https://docs.wso2.com/display/Carbon440/Installing+the+Product) , select the instructions relevant to your operating system and refer the 'Setting JAVA\_HOME' section.


To run the TCPMon available with your WSO2 Carbon product pack:

1.  Go to `<PRODUCT_HOME>/bin` directory of your product pack.
2.  Execute the following command to run the tool.
    For Windows

    ``` java
        tcpmon.bat
    ```

    For Linux

    ``` java
            ./tcpmon.sh
    ```

### Running TCPMon (downloaded from Apache)

To download TCPMon from Apache and run the tool:

1.  Download TCPMon from the following location: <http://archive.apache.org/dist/ws/tcpmon/1.0/tcpmon-1.0-bin.zip> .
2.  Extract tcpmon-1.0-bin.zip archive.
3.  Go to the build of the extracted directory to find the execution script.
4.  Execute the following command to run the tool.

    For Windows

    ``` java
            tcpmon.bat
    ```

    For Linux

    ``` java
            ./tcpmon.sh
    ```



# admin\_Other Usages of TCPMon

TCPMon is primarily used for message monitoring. Additionally, TCPMon can also be used for sending requests to web services and as a proxy service. Refer [Starting TCPMon](https://docs.wso2.com/display/Carbon440/Starting+TCPMon) for details on how to start the tool.

-   [Sending Requests for Web Services](#admin_OtherUsagesofTCPMon-SendingRequestsforWebServices)
-   [As a Proxy](#admin_OtherUsagesofTCPMon-AsaProxy)
-   [Advanced Settings](#admin_OtherUsagesofTCPMon-AdvancedSettings)

#### Sending Requests for Web Services

TCPMon can also be used as a request sender for Web services. The request SOAP message can be pasted on the send screen and sent directly to the server.

![]({{base_path}}/assets/attachments/45946410/46206514.png)

#### As a Proxy

TCPMon can act as a proxy. To start it in proxy mode, select the Proxy option. When acting as a proxy, TCPMon only needs the listener port to be configured.

![]({{base_path}}/assets/attachments/45946410/46206513.png)

#### Advanced Settings

TCPMon can simulate a slow connection, in which case the delay and the bytes to be dropped can be configured. This is useful when testing Web services.

![]({{base_path}}/assets/attachments/45946410/46206512.png)

Also, if HTTP proxy support is required, that can also be set on the admin screen.

