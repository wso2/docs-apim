# Running the Micro Integrator Dashboard as a Windows Service

Follow the instructions given below to run the Micro Integrator Dashboard as a Windows service.

## Prerequisites

- Setup Micro Integrator runtime and Dashboard according to the instructions given [here]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi-dashboard/#before-you-begin).

- Point the `wso2mi_dashboard_home` environment variable to the `MI_DASHBOARD_HOME` directory.

!!! Note
    Be sure to use **lower case** letters when setting the `java_home` and `wso2mi_dashboard_home` in the Windows OS. That is, you must not use `JAVA_HOME` or `WSO2MI_DASHBOARD_HOME`.

## Setting up the YAJSW wrapper

YASJW uses the configurations defined in the `<YAJSW_HOME>/conf/wrapper.conf` file to wrap Java applications. Replace the contents of this file with the configurations that are relevant to the Micro Integrator Dashboard instance that you want to run as a service. Use the **wrapper.conf** file available in `<MI_DASHBOARD_HOME>/bin/yajsw` folder to get the relevant configurations.

!!! Info
    WSO2 recommends Yet Another Java Service Wrapper (YAJSW) version [13.05](https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-13.05/yajsw-stable-13.05.zip/download). If you are running on JDK 11 or JDK 17, previous versions of YAJSW will not be compatible.

!!! tip
    You may encounter the following issue when starting Windows Services when the file "java" or a "dll" used by Java cannot be found by YAJSW.

    ```bash 
    "Error 2: The system cannot find the file specified" 
    ```

    This can be resolved by providing the "complete java path" for the wrapper.java.command as follows.

    ```bash
    wrapper.java.command = ${java_home}/bin/java
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
uninstallServiceService.bat
```
