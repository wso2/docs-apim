# Working with the Microgateway in a Windows Environment

You can work with the WSO2 API Manager Microgateway in a Microsoft Windows environment as follows:

-   [Running the Microgateway on a Windows operation system](#WorkingwiththeMicrogatewayinaWindowsEnvironment-RunningtheMicrogatewayonaWindowsoperationsystem)
-   [Run the Microgateway as a Windows service](#WorkingwiththeMicrogatewayinaWindowsEnvironment-RuntheMicrogatewayasaWindowsservice)
-   [Testing the Microgateway](#WorkingwiththeMicrogatewayinaWindowsEnvironment-TestingtheMicrogateway)
-   [Resetting the Microgateway CLI tool](#WorkingwiththeMicrogatewayinaWindowsEnvironment-ResettingtheMicrogatewayCLItool)

!!! note
Before you begin

Make sure to have the following prerequisites in place to initialize a Microgateway instance,

-   Oracle Java 1.8
-   WSO2 API Manager (WSO2 API-M) 2.5.0 or later.
    This is required to bootstrap the Microgateway.
-   WSO2 Microgateway CLI tool
-   [NSSM (the Non-Sucking Service Manager)](http://nssm.cc/usage)
    This is required if you need to run the Microgateway as a Windows service.


### Running the Microgateway on a Windows operation system

Follow the steps below run a WSO2 API Manager Microgateway instance in a Windows environment.

-   [Step 1 - Set up JAVA\_HOME](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step1-SetupJAVA_HOME)
-   [Step 2 - Set up a Microgateway project](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step2-SetupaMicrogatewayproject)
-   [Step 3 - Build the Microgateway](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step3-BuildtheMicrogateway)
-   [Step 4 - Run the Microgateway](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step4-RuntheMicrogateway)

#### Step 1 - Set up JAVA\_HOME

You need to set up `JAVA_HOME` in order to run the Microgateway CLI tool.

1.  Install the Oracle Java 1.8 or higher version.
2.  Set the `JAVA_HOME` environment variable as a user variable via the edit system properties UI.
    ![](/assets/attachments/103333781/103333794.png)
#### Step 2 - Set up a Microgateway project

1.  Start the WSO2 API Manager server.
2.  [Create a new API](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) in the API Publisher and publish it.
    If you have not created any APIs so far, you can deploy the sample Pizzashack API.
3.  Create a Microgateway label to assign it to the newly created API.
    For more information, see [Generating a Microgateway distribution for a label](Grouping-APIs-with-Labels_103333763.html#GroupingAPIswithLabels-GeneratingaMicrogatewaydistributionforalabel) .

        !!! note
    It is not mandatory to create a Microgateway label because you can deploy a Microgateway in either one of the following instances based on your requirement.

    -   Deploy a Microgateway for an API in order to deploy it for a single API.
    -   Deploy a Microgateway for a Microgateway label in order to deploy the Microgateway for a group of APIs.


4.  Set up the Microgateway CLI tool.
    Add the Microgateway executable location to the path variable.
    1.  [Download the Microgateway](https://wso2.com/api-management/api-microgateway/) ( `wso2am-micro-gw-toolkit-x.x.x.zip` ).
    2.  Unzip the downloaded ZIP file to a location of your choice (e.g., `C:\Program Files\wso2\micro gateway cli\` ).
    3.  Copy the path to the Microgateway `bin` folder ( `<path-to-wso2am-micro-gw-toolkit>\bin` ).
    4.  Click **Edit the system preferences** .
        ![](/assets/attachments/103333781/103333782.png)    5.  Navigate to the **Advanced** tab and click **Environment Variables** .
        ![](/assets/attachments/103333781/103333783.png)    6.  Navigate to the path system variable and click **Edit** .
        ![](/assets/attachments/103333781/103333785.png)    7.  Click **New,** add the path to the Microgateway `bin` folder that you copied previously and click **OK** three times to save the newly added system variable.
        ![](/assets/attachments/103333781/103333786.png)
                !!! info
        As you have added the Microgateway `\bin` directory path to the system variables, you can invoke the Microgateway command from any directory in the system.


5.  Initialize the Microgateway project.
    1.  Open the Microsoft command line ( `cmd.exe` ).
    2.  Change the location to where you want to set up the Microgateway project.

        ``` java
                cd <directory-location-to-set-up-microgateway-project>
        ```

    3.  Run the following command to bootstrap a Microgateway instance.
        In this guide, as we have assigned a label to the API, you only need to run the first command.

        -   If you want to set up a Microgateway for a Microgateway label, use the following command.

            ``` java
                        micro-gw setup <project-name> -l <label-name>
            ```

        -   If you want to set up a Microgateway project for a single API, use the following command.

            ``` java
                            micro-gw setup <project-name> -a <API-name> -v <API-version>
            ```

            This will create a project for that particular API name and version.

        The remainder of the process is the same for a label-based project and a private jet API project.

    4.  Enter your username and password when prompted.

                !!! info
        If you have run the Microgateway CLI tool before, you are not prompted to enter your username again unless you have [reset the Microgateway CLI tool](#WorkingwiththeMicrogatewayinaWindowsEnvironment-ResettingtheMicrogatewayCLItool) .


    5.  Press **Enter** for all the other questions when prompted so that it picks up the default values.

                !!! info
        If you have run the Microgateway CLI tool before, you are not prompted to enter the following details unless you have [reset the Microgateway CLI tool](#WorkingwiththeMicrogatewayinaWindowsEnvironment-ResettingtheMicrogatewayCLItool) .


        ![](/assets/attachments/103333781/103333787.png)        After this process is complete, a directory is created with the given project name. The structure of the project is similar to the following:
        ![](/assets/attachments/103333781/103333788.png)
#### Step 3 - Build the Microgateway

1.  Navigate to the Microgateway project root directory.
    If you have not changed the directory after [step 5](#WorkingwiththeMicrogatewayinaWindowsEnvironment-step5) when setting up the Microgateway project, this is the same directory where you ran the set up command.

2.  Run the following command to build the project.
    Use the same project name that you defined when setting up the Microgateway project.

    ``` java
        micro-gw build <project-name>
    ```

    After running the build command, you can find the Microgateway distribution ( `micro-gw-<project-name>.zip` ) specifically designed for the given Microgateway label or the respective API version in the `<project-name>\target` directory.

#### Step 4 - Run the Microgateway

1.  Copy the &lt; `micro-gw-project-name>.zip` file from the `<project-name>\target` directory and extract the files to where you want to run the Microgateway.
2.  Navigate to the &lt; `micro-gw-project-name>/bin` directory.

    ``` java
            cd <micro-gw-project-name>/bin
    ```

3.  Run the Microgateway.
    This runs the Microgateway instance in the foreground.

    ``` java
            .\gateway.bat
    ```

### Run the Microgateway as a Windows service

-   [Step 1 - Set up JAVA\_HOME](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step1-SetupJAVA_HOME.1)
-   [Step 2 - Set up a Microgateway project](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step2-SetupaMicrogatewayproject.1)
-   [Step 3 - Build the Microgateway](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step3-BuildtheMicrogateway.1)
-   [Step 4 - Install the Gateway script as a Windows service](#WorkingwiththeMicrogatewayinaWindowsEnvironment-Step4-InstalltheGatewayscriptasaWindowsservice)

#### Step 1 - Set up JAVA\_HOME

You need to set up Java in order to run the Microgateway CLI tool.

1.  Install Oracle Java 1.8 or later.
2.  Set the `JAVA_HOME` environment variable as a server variable via the edit system properties UI.
    ![](/assets/attachments/103333781/103333795.png)
#### Step 2 - Set up a Microgateway project

1.  Start the WSO2 API Manager server.
2.  [Create a new API](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) in the API Publisher and publish it.
    If you have not created any APIs so far, you can deploy the sample Pizzashack API.
3.  Create a Microgateway label to assign it to the newly created API.
    For more information, see [Generating a Microgateway distribution for a label](https://docs.wso2.com/display/SHAN/Grouping+APIs+with+Labels#GroupingAPIswithLabels-GeneratingaMicrogatewaydistributionforalabel) .

        !!! note
    It is not mandatory to create a Microgateway label because you can deploy a Microgateway in either one of the following instances based on your requirement.

    -   Deploy a Microgateway for an API in order to deploy it for a single API.
    -   Deploy a Microgateway for a Microgateway label in order to deploy the Microgateway for a group of APIs.


4.  Set up the Microgateway CLI tool.
    Add the Microgateway executable location to the path variable.
    1.  [Download the Microgateway](https://wso2.com/api-management/api-microgateway/) ( `wso2am-micro-gw-toolkit-x.x.x.zip` ).
    2.  Unzip the downloaded ZIP file to a location of your choice (e.g., `C:\Program Files\wso2\micro gateway cli\` ).
    3.  Copy the path to the Microgateway `bin` folder ( `<path-to-wso2am-micro-gw-toolkit>\bin` ).
    4.  Click **Edit the system preferences** .
        ![](/assets/attachments/103333781/103333782.png)    5.  Navigate to the **Advanced** tab and click **Environment Variables** .
        ![](/assets/attachments/103333781/103333783.png)    6.  Navigate to the path system variable and click **Edit** .
        ![](/assets/attachments/103333781/103333785.png)    7.  Click **New,** add the path to the Microgateway `bin` folder that you copied previously and click **OK** three times to save the newly added system variable.
        ![](/assets/attachments/103333781/103333786.png)
                !!! info
        As you have added the Microgateway `\bin` directory path to the system variables, you can invoke the Microgateway command from any directory in the system.


5.  Initialize the Microgateway project.
    1.  Open the Microsoft command line ( `cmd.exe` ).
    2.  Change the location to where you want to set up the Microgateway project.

        ``` java
                cd <directory-location-to-set-up-microgateway-project>
        ```

    3.  Run the following command to bootstrap a Microgateway instance.
        In this guide, as we have assigned a label to the API, you only need to run the first command.

        -   If you want to set up a Microgateway for a Microgateway label, use the following command.

            ``` java
                        micro-gw setup <project-name> -l <label-name>
            ```

        -   If you want to set up a Microgateway project for a single API, use the following command.

            ``` java
                            micro-gw setup <project-name> -a <API-name> -v <API-version>
            ```

            This will create a project for that particular API name and version.

        The remainder of the process is the same for a label-based project and a private jet API project.

    4.  Enter your username and password when prompted.

                !!! info
        If you have run the Microgateway CLI tool before, you are not prompted to enter your username again unless you have [reset the Microgateway CLI tool](#WorkingwiththeMicrogatewayinaWindowsEnvironment-ResettingtheMicrogatewayCLItool) .


    5.  Press **Enter** for all the other questions when prompted so that it picks up the default values.

                !!! info
        If you have run the Microgateway CLI tool before, you are not prompted to enter the following details unless you have [reset the Microgateway CLI tool](#WorkingwiththeMicrogatewayinaWindowsEnvironment-ResettingtheMicrogatewayCLItool) .


        ![](/assets/attachments/103333781/103333787.png)        After this process is complete, a directory is created with the given project name. The structure of the project is similar to the following:
        ![](/assets/attachments/103333781/103333788.png)
#### Step 3 - Build the Microgateway

1.  Navigate to the Microgateway project root directory.
    If you have not changed the directory after [step 5](#WorkingwiththeMicrogatewayinaWindowsEnvironment-step5) when setting up the Microgateway project, this is the same directory where you ran the set up command.

2.  Run the following command to build the project.
    Use the same project name that you defined when setting up the Microgateway project.

    ``` java
        micro-gw build <project-name>
    ```

    After running the build command, you can find the Microgateway distribution ( `micro-gw-<project-name>.zip` ) specifically designed for the given Microgateway label or the respective API version in the `<project-name>\target` directory.

#### Step 4 - Install the Gateway script as a Windows service

1.  Download the [NSSM (Non-Sucking Service Manager) tool](http://nssm.cc/usage) and extract the ZIP file.
2.  Copy the extracted ZIP file to the location where you want to run the Microgateway.
3.  Install the `gateway.bat` script as a Windows service.
    1.  Navigate to the `win64` folder, which is inside the new location of the extracted NSSM tool.

        ``` java
                cd apim_2_5_microgateway_bat\nssm-2.24\win64
        ```

    2.  Run the following command to install the `gateway.bat` script as a Windows service.

        ``` java
                    nssm.exe install microgw
        ```

    3.  Click **Yes** when the following User Account Control message appears.
        You need to do this in order to allow the NSSM tool to make changes to your Microgateway distribution.
        ![](/assets/attachments/103333781/103333789.png)    4.  Click \[...\] and select the location of the `gateway.bat` file, which is in the `\bin` folder of your unzipped Microgateway distribution.
        ![](/assets/attachments/103333781/103333791.png){height="250"}
    5.  Click **Details** , and enter the details of the Microgateway service.
        ![](/assets/attachments/103333781/103333792.png){height="250"}
    6.  Click **Install service** .
        A confirmation message appears.
        ![](/assets/attachments/103333781/103333793.png)
### Testing the Microgateway

You can invoke the API through the Microgateway using the following cURL command in order to test the Microgateway. By default, the Microgateway serves the HTTPS/WSS request via the 9095 port.

-   [**Format**](#test-format)
-   [**Example**](#test-example)

``` java
    curl -v -k https://<hostname-of-server-running-the-Microgateway>:9095/<API-name>/<API-version>/<API-resource-path> -H "Authorization: Bearer <base64-encoded-client-id-and-secret>"
```

``` java
    curl -v -k https://mg.knnect.com:9095/wolaa/1.1.1/getmeall -H "Authorization: Bearer 104cd62f-a8ab-3089-bc12-f7cc36e73e77"
```

### Resetting the Microgateway CLI tool

When you run the Microgateway CLI tool for the first time, it preserves all the information (i.e., your username, APIM base URL, TrustStore location and the TrustStore password) with the exception of your password, for later use. If you want to reset the Microgateway CLI tool in order to clear all the data that has been preserved by the Microgateway CLI tool, you can use the `–reset` argument as follows. Note that you can invoke the Microgateway CLI tool reset command from any directory in the system.

``` java
    micro-gw reset
```
