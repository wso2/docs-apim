# Running the Micro Integrator as a Windows Service

Follow the instructions given below to run the Micro Integrator as a Windows service.

## Prerequisites

-	Go to the [product page](https://wso2.com/integration/micro-integrator/#), click **Download**, and then click **Zip Archive** to download the product distribution as a ZIP file.

-	Extract the downloaded ZIP file to a location on your computer. The <b>micro-integrator</b> folder inside the extracted ZIP file will be your <b>MI_HOME</b> directory.

-	Set up a [JDK that is compatible with the Micro Integrator]({{base_path}}/install-and-setup/install/installation-prerequisites/#environment-compatibility) and point the `java_home` variable to your JDK instance. 
 
-	Point the `wso2mi_home` environment variable to the `MI_HOME` directory.

!!! Note 
    Be sure to use **lower case** letters when setting the `wso2mi_home` in the Windows OS. That is, you must not use `WSO2MI_HOME`.
  
## Setting up the YAJSW wrapper 

YASJW uses the configurations defined in the `<YAJSW_HOME>/conf/wrapper.conf` file to wrap Java applications. Replace the contents of this file with the configurations that are relevant to the Micro Integrator instance that you want to run as a service. Use the **wrapper.conf** file available in `<MI_HOME>/bin/yajsw` folder to get the relevant configurations.

!!! Info
    WSO2 recommends Yet Another Java Service Wrapper (YAJSW) version 13.05. If you are running on JDK 11 or JDK 17, previous versions of YAJSW will not be compatible.

!!! tip
    You may encounter the following issue when starting Windows Services when the file "java" or a "dll" used by Java cannot be found by YAJSW. 

    ```bash 
    "Error 2: The system cannot find the file specified" 
    ```

    This can be resolved by providing the "complete java path" for the wrapper.java.command as follows.

    ```bash
    wrapper.java.command = ${JAVA_HOME}/bin/java
    ```

## Installing the service

Navigate to the `<YAJSW_HOME>/bat/` directory in the Windows command prompt with administrative privileges, and execute the following command: 

```bash
installService.bat
```

## Starting the service

Navigate to the `<YAJSW_HOME>/bat/` directory in the Windows command prompt with administrative privileges, and execute the following command: 

```bash
startService.bat
```

## Stopping the service

Navigate to the `<YAJSW_HOME>/bat/` directory in the Windows command prompt with administrative privileges, and execute the following command: 

```bash
stopService.bat
```

## Uninstalling the service

To uninstall the service, navigate to the `<YAJSW_HOME>/bat/` directory in the Windows command prompt with administrative privileges, and execute the following command: 
 
```bash
uninstallService.bat
```
