# Running API Manager as a Windows Service

!!! note
    **Before you begin:**

    -   See [our compatibility matrix]({{base_path}}/install-and-setup/ProductCompatibility) to find out if this version of the product is fully tested on your OS.


### Prerequisites

-   Install JDK and set up the `JAVA_HOME` environment variable.
-   Download and install a service wrapper library to use for running WSO2 API Manager as a Windows service. WSO2 recommends Yet Another Java Service Wrapper ( YAJSW ) version [13.05](https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-13.05/yajsw-stable-13.05.zip/download) and several WSO2 products provide a default `wrapper.conf` file in their `<PRODUCT_HOME>/bin/yajsw/` directory. The instructions below describe how to set up this file.

!!! important
    Use YAJSW 13.05 for both JDK 11 and JDK 17.

### Setting up the YAJSW wrapper configuration file

The configuration file used for wrapping Java Applications by YAJSW is `wrapper.conf` , which is located in the `<YAJSW_HOME>/conf/` directory. The configuration file in `<PRODUCT_HOME>/bin/yajsw/` directory of many WSO2 products can be used as a reference for this. Following is the minimal `wrapper.conf` configuration for running a WSO2 product as a Windows service. Open your `wrapper.conf` file in `<YAJSW_HOME>/conf/` directory, set its properties as follows, and save it.

!!! info
    
    If you want to set additional properties from an external registry at runtime, store sensitive information like usernames and passwords for connecting to the registry in a properties file and secure it with [secure vault]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/carbon-secure-vault-implementation).

!!! note
    
    **Manual Configurations in `wrapper.conf` file**
    
    Add the following class path manually to avoid errors in the WSO2 API Manager Management Console:
    
    ``` bash
    wrapper.java.classpath.4 = ${carbon_home}/repository/components/plugins/commons-lang_2.6.0.wso2v1.jar 
    ```

    Add the below line to prevent wso2carbon log file getting overridden at each service startup.

    ``` bash
    wrapper.java.additional.29 = -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
    ```
    
    
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
    wrapper.java.app.mainclass=org.wso2.carbon.bootstrap.Bootstrap
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
    wrapper.console.title=WSO2 Carbon
    #********************************************************************
    # Wrapper Windows Service and Posix Daemon Properties
    #********************************************************************
    # Name of the service
    wrapper.ntservice.name=WSO2CARBON
    # Display name of the service
    wrapper.ntservice.displayname=WSO2 Carbon
    # Description of the service
    wrapper.ntservice.description=Carbon Kernel
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
    wrapper.java.classpath.1 = ${carbon_home}/bin/*.jar
    wrapper.java.classpath.2 = ${carbon_home}/lib/commons-lang-*.jar
    wrapper.java.classpath.3 = ${carbon_home}/lib/*.jar
    wrapper.app.parameter.1 = org.wso2.carbon.bootstrap.Bootstrap
    wrapper.app.parameter.2 = RUN
    wrapper.java.additional.1 = -Xbootclasspath/a:${carbon_home}/lib/xboot/*.jar
    wrapper.java.additional.2 = -Xms256m
    wrapper.java.additional.3 = -Xmx1024m
    wrapper.java.additional.4 = -XX:+HeapDumpOnOutOfMemoryError
    wrapper.java.additional.5 = -XX:HeapDumpPath=${carbon_home}/repository/logs/heap-dump.hprof
    wrapper.java.additional.6 = -Dcom.sun.management.jmxremote
    wrapper.java.additional.7 = -Dcarbon.registry.root=\/
    wrapper.java.additional.8 = -Dcarbon.home=${carbon_home}
    wrapper.java.additional.9 = -Dwso2.server.standalone=true
    wrapper.java.additional.10 = -Djava.command=${java_home}/bin/java
    wrapper.java.additional.11 = -Djava.io.tmpdir=${carbon_home}/tmp
    wrapper.java.additional.12 = -Dcatalina.base=${carbon_home}/lib/tomcat
    wrapper.java.additional.13 = -Djava.util.logging.config.file=${carbon_home}/repository/conf/etc/logging-bridge.properties
    wrapper.java.additional.14 = -Dcarbon.config.dir.path=${carbon_home}/repository/conf
    wrapper.java.additional.15 = -Dcarbon.logs.path=${carbon_home}/repository/logs
    wrapper.java.additional.16 = -Dcomponents.repo=${carbon_home}/repository/components/plugins
    wrapper.java.additional.17 = -Dconf.location=${carbon_home}/repository/conf
    wrapper.java.additional.18 = -Dcom.atomikos.icatch.file=${carbon_home}/lib/transactions.properties
    wrapper.java.additional.19 = -Dcom.atomikos.icatch.hide_init_file_path=true
    wrapper.java.additional.20 = -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true
    wrapper.java.additional.21 = -Dcom.sun.jndi.ldap.connect.pool.authentication=simple
    wrapper.java.additional.22 = -Dcom.sun.jndi.ldap.connect.pool.timeout=3000
    wrapper.java.additional.23 = -Dorg.terracotta.quartz.skipUpdateCheck=true
    wrapper.java.additional.24 = -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false
    wrapper.java.additional.25 = -Dfile.encoding=UTF8
    wrapper.java.additional.26 = -DworkerNode=false
    wrapper.java.additional.27 = -Dhttpclient.hostnameVerifier=DefaultAndLocalhost
    wrapper.java.additional.28 = -Dcarbon.new.config.dir.path=${carbon_home}/repository/resources/conf
    wrapper.java.additional.29 = -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
```

### Setting up carbon\_home

Extract WSO2 API Manager that you want to run as a Windows service, and then set the Windows environment variable `carbon_home` to the extracted product directory location.

### Running the product in console mode

You will now verify that YAJSW is configured correctly for running the WSO2 API Manager as a Windows service.

1.  Open a Windows command prompt with administrative privileges and go to the `<YAJSW_HOME>/bat/` directory. For example:

    ``` java
    cd C:\Documents and Settings\yajsw_home\bat
    ```

2.  Start the wrapper in console mode using the following command:

    ``` java
    runConsole.bat
    ```

    For example:

    ![]({{base_path}}/assets/attachments/28717183/29364287.png)

If the configurations are set properly for YAJSW, you will see console output similar to the following and can now access the WSO2 management console from your web browser via <https://localhost:9443/carbon>.

![]({{base_path}}/assets/attachments/28717183/29364286.png)

### Working with the WSO2CARBON service

To install the Carbon-based product WSO2 API Manager as a Windows service, execute the following command in a console with administrative privileges, in the `<YAJSW_HOME>/bat/` directory:

``` java
installService.bat
```

The console will display a message confirming that the WSO2CARBON service was installed.

![]({{base_path}}/assets/attachments/28717183/29364285.png)

To start the service, execute the following command in the same console window:

``` java
startService.bat
```

The console will display a message confirming that the WSO2CARBON service was started.

![]({{base_path}}/assets/attachments/28717183/29364288.png)

To stop the service, execute the following command in the same console window:

``` java
stopService.bat
```

The console will display a message confirming that the WSO2CARBON service has stopped.

![]({{base_path}}/assets/attachments/28717183/29364290.png)

To uninstall the service, execute the following command in the same console window:

``` java
uninstallService.bat
```

The console will display a message confirming that the WSO2CARBON service was removed.

![]({{base_path}}/assets/attachments/28717183/29364291.png)

## Troubleshooting

This section provides solutions for common issues you might encounter when installing and running WSO2 API Manager as a Windows service.

### Common Installation Issues

#### Insufficient Privileges Error

**Problem:** Installation fails with permission errors even when using an administrative command prompt.

**Solutions:**

1. **Run Command Prompt as Administrator:** Right-click on Command Prompt and select "Run as administrator" rather than opening a regular command prompt.

2. **Check User Account Control (UAC):** If you have limited elevation privileges:
   - Go to **Control Panel** → **User Accounts** → **Change User Account Control settings**
   - Temporarily lower UAC settings during installation
   - Restore UAC settings after successful installation

3. **Use Built-in Administrator Account:** If your current account has limited privileges:
   - Enable the built-in Administrator account: `net user administrator /active:yes`
   - Login as Administrator and perform the installation
   - Disable the account after installation: `net user administrator /active:no`

#### Path-related Issues

**Problem:** "Error 2: The system cannot find the file specified" when starting the service.

**Solutions:**

1. **Verify Environment Variables:** Ensure the following environment variables are properly set:
   - `JAVA_HOME`: Points to your JDK installation directory
   - `carbon_home`: Points to your WSO2 API Manager installation directory

2. **Use Absolute Paths:** In the `wrapper.conf` file, use absolute paths instead of relative paths:
   ```bash
   wrapper.java.command = C:/Program Files/Java/jdk-11.0.x/bin/java
   wrapper.working.dir = C:/path/to/wso2am-4.x.x/
   ```

3. **Path with Spaces:** If your installation path contains spaces, ensure paths are properly quoted in the configuration.

#### Service Installation Failures

**Problem:** Service installation command completes but service is not visible in Windows Services.

**Solutions:**

1. **Refresh Services Console:** Press F5 in the Windows Services console to refresh the list.

2. **Check Windows Event Logs:** 
   - Open Event Viewer (eventvwr.msc)
   - Navigate to **Windows Logs** → **Application** or **System**
   - Look for error messages related to WSO2CARBON service

3. **Verify YAJSW Configuration:** Ensure the `wrapper.conf` file has the correct service name settings:
   ```bash
   wrapper.ntservice.name=WSO2CARBON
   wrapper.ntservice.displayname=WSO2 Carbon
   ```

### Service Runtime Issues

#### Service Starts but Stops Immediately

**Problem:** The WSO2CARBON service starts but stops within seconds.

**Solutions:**

1. **Check Log Files:** Review the following log files for error details:
   - `<YAJSW_HOME>/log/wrapper.log`
   - `<CARBON_HOME>/repository/logs/wso2carbon.log`

2. **Memory Configuration:** Verify memory settings in `wrapper.conf`:
   ```bash
   wrapper.java.additional.2 = -Xms256m
   wrapper.java.additional.3 = -Xmx1024m
   ```
   Increase memory allocation if needed based on your system resources.

3. **Port Conflicts:** Ensure default ports (9443, 9763, 8280, 8243) are not in use by other applications:
   ```cmd
   netstat -an | findstr :9443
   netstat -an | findstr :9763
   ```

#### Cannot Access Management Console

**Problem:** Service is running but the management console is not accessible.

**Solutions:**

1. **Verify Service Status:** Ensure the WSO2CARBON service is running in Windows Services console.

2. **Check Firewall Settings:** Configure Windows Firewall to allow traffic on WSO2 API Manager ports:
   - Management Console: 9443
   - HTTP API Traffic: 8280  
   - HTTPS API Traffic: 8243

3. **Browser Configuration:** Try accessing the console using:
   - Different browsers
   - Incognito/private mode
   - Local IP address instead of localhost: `https://[your-ip]:9443/carbon`

### Getting Additional Help

If you continue to experience issues:

1. **Enable Debug Logging:** Add the following to `wrapper.conf` for detailed logging:
   ```bash
   wrapper.console.loglevel=DEBUG
   wrapper.logfile.loglevel=DEBUG
   ```

2. **Community Support:** Visit the [WSO2 Community](https://wso2.org/community/) for additional support.

3. **Documentation:** Refer to the [WSO2 API Manager documentation]({{base_path}}) for comprehensive configuration details.
