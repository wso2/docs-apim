# Running Streaming Integrator as a Windows Service

!!! note
    **Before you begin:**

    -   See [our compatibility matrix]({{base_path}}/install-and-setup/ProductCompatibility) to find out if this version of the product is fully tested on your OS.


### Prerequisites

-   Install JDK and set up the `JAVA_HOME` environment variable.
-   Download and install a service wrapper library to use for running WSO2 Streaming Integrator as a Windows service. WSO2 recommends Yet Another Java Service Wrapper ( YAJSW ) version [13.05](https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-13.05/yajsw-stable-13.05.zip/download), and several WSO2 products provide a default `wrapper.conf` file in their `<PRODUCT_HOME>/bin/yajsw/` directory. The instructions below describe how to set up this file.

!!! important
    Use YAJSW 13.05 for both JDK 11 and JDK 17.

### Setting up the YAJSW wrapper configuration file

The configuration file used for wrapping Java Applications by YAJSW is `wrapper.conf` , which is located in the `<YAJSW_HOME>/conf/` directory. Following is the minimal `wrapper.conf` configuration for running a WSO2 Streaming Integrator as a Windows service. Open your `wrapper.conf` file in `<YAJSW_HOME>/conf/` directory, set its properties as follows, and save it.

!!! info
    
    If you want to set additional properties from an external registry at runtime, store sensitive information like usernames and passwords for connecting to the registry in a properties file and secure it with [secure vault]({{base_path}}/administer/product-security/General/logins-and-passwords/admin-carbon-secure-vault-implementation).


!!! tip
    You may encounter the following issue when starting Windows Services when the file "java" or a "dll" used by Java cannot be found by YAJSW. 

    ```bash 
    "Error 2: The system cannot find the file specified" 
    ```

    This can be resolved by providing the "complete java path" for the wrapper.java.command as follows.

    ```bash
    wrapper.java.command = ${JAVA_HOME}/bin/java
    ```

**Minimal wrapper.conf configuration**

``` bash
    #********************************************************************
    # working directory
    #********************************************************************
    wrapper.working.dir=${carbon_home}/
    # Java Main class.
    # YAJSW: default is "org.rzo.yajsw.app.WrapperJVMMain"
    # DO NOT SET THIS PROPERTY UNLESS YOU HAVE YOUR OWN IMPLEMENTATION
    # wrapper.java.mainclass=
    #********************************************************************
    # tmp folder
    # yajsw creates temporary files named in_.. out_.. err_.. jna..
    # per default these are placed in jna.tmpdir.
    # jna.tmpdir is set in setenv batch file to <yajsw>/tmp
    #********************************************************************
    wrapper.tmp.path = ${jna_tmpdir}
    #********************************************************************
    # Application main class or native executable
    # One of the following properties MUST be defined
    #********************************************************************
    # Java Application main class
    wrapper.java.app.mainclass=org.wso2.carbon.launcher.Main
    # Log Level for console output.  (See docs for log levels)
    wrapper.console.loglevel=INFO
    # Log file to use for wrapper output logging.
    wrapper.logfile=${wrapper_home}\/log\/wrapper.log
    # Format of output for the log file.  (See docs for formats)
    #wrapper.logfile.format=LPTM
    # Log Level for log file output.  (See docs for log levels)
    #wrapper.logfile.loglevel=INFO
    # Maximum size that the log file will be allowed to grow to before
    #  the log is rolled. Size is specified in bytes.  The default value
    #  of 0, disables log rolling by size.  May abbreviate with the 'k' (kB) or
    #  'm' (mB) suffix.  For example: 10m = 10 megabytes.
    # If wrapper.logfile does not contain the string ROLLNUM it will be automatically added as suffix of the file name
    wrapper.logfile.maxsize=10m
    # Maximum number of rolled log files which will be allowed before old
    #  files are deleted.  The default value of 0 implies no limit.
    wrapper.logfile.maxfiles=10
    # Title to use when running as a console
    wrapper.console.title="WSO2 Streaming Integrator"
    #********************************************************************
    # Wrapper Windows Service and Posix Daemon Properties
    #********************************************************************
    # Name of the service
    wrapper.ntservice.name=WSO2SI
    # Display name of the service
    wrapper.ntservice.displayname=WSO2 Streaming Integrator 4.2.0
    # Description of the service
    wrapper.ntservice.description=Provides the ability to run WSO2 Streaming Integrator 4.2.0 as a Windows Service
    #********************************************************************
    # Wrapper System Tray Properties
    #********************************************************************
    # enable system tray
    wrapper.tray = true
    # TCP/IP port. If none is defined multicast discovery is used to find the port
    # Set the port in case multicast is not possible.
    wrapper.tray.port = 15002
    #********************************************************************
    # Exit Code Properties
    # Restart on non zero exit code
    #********************************************************************
    wrapper.on_exit.0=SHUTDOWN
    wrapper.on_exit.default=RESTART
    #********************************************************************
    # Trigger actions on console output
    #********************************************************************
    # On Exception show message in system tray
    wrapper.filter.trigger.0=Exception
    wrapper.filter.script.0=${wrapper_home}/scripts/trayMessage.gv
    wrapper.filter.script.0.args=Exception
    #********************************************************************
    # genConfig: further Properties generated by genConfig
    #********************************************************************
    placeHolderSoGenPropsComeHere=
    wrapper.java.command = java
    wrapper.java.classpath.1 = ${carbon_home}/bin/bootstrap/*.jar
    wrapper.app.parameter.1 = RUN
    wrapper.app.parameter.2 = --run
    wrapper.java.additional.1 = -Xbootclasspath/a:
    wrapper.java.additional.2 = -Xms256m
    wrapper.java.additional.3 = -Xmx1024m
    wrapper.java.additional.4 = -XX:+HeapDumpOnOutOfMemoryError
    wrapper.java.additional.5 = -XX:HeapDumpPath=${carbon_home}/logs/heap-dump.hprof
    wrapper.java.additional.6 = -Dcom.sun.management.jmxremote
    wrapper.java.additional.7 = -Dcarbon.home=${carbon_home}
    wrapper.java.additional.8 = -Dcarbon.config.dir.path=${carbon_home}/conf
    wrapper.java.additional.9 = -Dwso2.runtime.path=${carbon_home}\wso2\server
    wrapper.java.additional.10 = -Dwso2.runtime=server
    wrapper.java.additional.11 = -Djava.command= java
    wrapper.java.additional.12 = -Djava.io.tmpdir=${carbon_home}/tmp
    wrapper.java.additional.13 = -Djava.util.logging.config.file=${carbon_home}/conf/server/etc/pax-logging.properties
```

### Setting up CARBON\_HOME

Extract WSO2 Streaming Integrator that you want to run as a Windows service, and then set the Windows environment variable `carbon_home` to the extracted product directory location which is for example wso2si-4.2.0 here.



### Running the product in console mode

You will now verify that YAJSW is configured correctly for running the WSO2 Streaming Integrator as a Windows service.

1.  Open a Windows command prompt with administrative privileges and go to the `<YAJSW_HOME>/bat/` directory. For example:

    ``` java
    cd C:\Documents and Settings\yajsw_home\bat
    ```

2.  Start the wrapper in console mode using the following command:

    ``` java
    runConsole.bat
    ```

### Working with the WSO2SI service

To install the Carbon-based product WSO2 Streaming Integrator as a Windows service, execute the following command in a comand prompt with administrative privileges in the `<YAJSW_HOME>/bat/` directory:

``` java
installService.bat
```


To start the service, execute the following command in the same console window:

``` java
startService.bat
```


To stop the service, execute the following command in the same console window:

``` java
stopService.bat
```


To uninstall the service, execute the following command in the same console window:

``` java
uninstallService.bat
```
