# admin\_Starting TCPMon

TCPMon is available in the `         <PRODUCT_HOME>/bin        ` directory of any WSO2 Carbon based product distribution. Alternatively, you can download TCPMon from Apache and run the tool.

-   [Running TCPMon (from Carbon product pack)](#admin_StartingTCPMon-RunningTCPMon(fromCarbonproductpack))
-   [Running TCPMon (downloaded from Apache)](#admin_StartingTCPMon-RunningTCPMon(downloadedfromApache))

### Running TCPMon (from Carbon product pack)

Ensure that the following prerequisites are fulfilled in order to run TCPMon.

-   Install JDK 1.4 or later version.
-   Set the `           JAVA_HOME          ` variable. This setting is required only if you are using the TCPMon available in the WSO2 Carbon based product pack.

        !!! info
    For information on how to set the `           JAVA_HOME          ` variable, go to [Installing the Product](https://docs.wso2.com/display/Carbon440/Installing+the+Product) , select the instructions relevant to your operating system and refer the 'Setting JAVA\_HOME' section.


To run the TCPMon available with your WSO2 Carbon product pack:

1.  Go to `          <PRODUCT_HOME>/bin         ` directory of your product pack.
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


