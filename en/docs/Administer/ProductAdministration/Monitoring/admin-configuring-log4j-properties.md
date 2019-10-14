# admin\_Configuring Log4j Properties

All WSO2 products are shipped with the [log4j logging capabilities](https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs) , which generates administrative activities and server side logs. The `log4j.properties` file, which governs how logging is performed by the server can be found in the `<PRODUCT_HOME>/repository/conf` directory. If the [Logging Management feature is installed](https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs) , log4j properties can be configured using the management console.

There are three main components when configuring log4j. They are Loggers, Appenders, and Layouts. Using the management console allows you to change these parameters globally as well as individually at run time. First, the server stores new values in the database and then changes the appropriate components in the logging framework, enabling the logging properties to be updated immediately.

!!! note
In most systems, logging properties should be specified before the server starts and cannot be changed while it is running. However, as shown here, the logging properties of a running Carbon instance can be changed through its management console, while the server is up and running.


To configure logging properties of the system and application logs of a Carbon server at run time:

1.  Log in to the management console of your product and go to **Configure** -&gt; **Logging** in the navigator. The **Logging Configuration** window appears as shown below.
    ![](/assets/attachments/28705820/28870019.png)
2.  If you select the **Persist All Configuration Changes** check box, all the modifications will persist and they will be available even after the server restarts.
3.  The **Logging Configuration** window consists of three sections, which you can use to configure the layout and the amount of information you want to receive about system activity. The following topics describes each of these settings:

    -   [Global Log4J Configuration](#admin_ConfiguringLog4jProperties-GlobalLog4JConfiguration)
    -   [Configure Log4J Appenders](#admin_ConfiguringLog4jProperties-ConfigureLog4JAppenders)
    -   [Configure Log4J Loggers](#admin_ConfiguringLog4jProperties-ConfigureLog4JLoggers)

#### Global Log4J Configuration

![](/assets/attachments/28705820/28870018.png)

This section allows you to assign a single log level and log pattern to all loggers.

-   **Log Level** - Severity of the message. Reflects a minimum level that the logger requires. See descriptions of the [available log levels](https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs#MonitoringLogs-log4j_levels) .
-   **Log Pattern** - Defines the output format of the log file. This is the layout pattern which describes the log message format

If you click **Restore Defaults** , the Registry will be overwritten by logging configurations specified in the `log4j.properties` file .

#### Configure Log4J Appenders

![](/assets/attachments/28705820/28870017.png)

This section allows you to configure appenders individually. Log4j allows logging requests to print to multiple destinations. These output destinations are called 'Appenders'. You can attach several appenders to one logger.

-   **Name** -The name of an appender. By default, a WSO2 product server is entered in this field with the following log appenders configured;
    -   **CARBON\_CONSOLE** - Logs to the console when the server is running.
    -   **CARBON\_LOGFILE** - Writes the logs to `<PRODUCT_HOME>/repository/logs/wso2carbon.log` .

                !!! info
        Some WSO2 products do not ship t he following appenders by default.

        -   **SERVICE** \_ **APPENDER** - Writes service invocations to &lt; `PRODUCT_HOME>/repository/logs/wso2-<PRODUCT_NAME>-service.log.`
        -   **ERROR\_LOGFILE -** Writes warning/error messages to &lt; `ESB_HOME>/repository/logs/wso2-<PRODUCT_NAME>-service.log`


    -   **TRACE** \_ **APPENDER** - Writes tracing/debug messages to the &lt; `PRODUCT_HOME>/repository/logs/wso2-<PRODUCT_NAME>-trace.log` for tracing enabled services.

    -   **CARBON\_ MEMORY**
    -   **CARBON\_SYS\_LOG -** Allows separating the software that generates messages, from the system that stores them and the software that reports and analyzes them.
    -   **CARBON\_TRACE\_LOGFILE**

<!-- -->

-   **Log pattern** - Defines the output format of the log file. From Carbon 4.4.3 onwards, t he conversion character 'K' can be used in the pattern layout to log a UUID . For example, the log pattern can be \[%K\] \[%T\] \[%S\] \[%d\] %P%5p {{c}} - %x %m {{c}}n, where \[%K\] is the UUID.

        !!! info
    **Note** that the following capability was introduced by the Carbon 4.4.3 release. Therefore, it is only applicable to products that a based on Carbon 4.4.3 or later versions.

    From Carbon 4.4.3 onwards, the UUID can be used for identifying forged messages in the log. By default, the UUID will be generated every time the server starts . If required, you can configure the UUID regeneration period by manually adding the following property to the `log4j.properties` file (stored in the `<PRODUCT_HOME>/repository/conf` directory) :

    ``` java
        log4j.appender.CARBON_LOGFILE.layout.LogUUIDUpdateInterval=<number_of_hours>
    ```


-   **Sys Log Host** - The IP address of the system log server. The syslog server is a dedicated log server for many applications. It runs in a particular TCP port in a separate machine, which can be identified by an IP address.
-   **Facility** - The log message type sent to the system log server.
-   **Threshold** - Filters log entries based on their level. For example, threshold set to 'WARN' will allow the log entry to pass into appender. If its level is 'WARN', 'ERROR' or 'FATAL', other entries will be discarded. This is the minimum log level at which you can log a message. See descriptions of the [available log levels](https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs#MonitoringLogs-log4j_levels) .

#### Configure Log4J Loggers

![](/assets/attachments/28705820/28870022.png)

A Logger is an object used to log messages for a specific system or application component. Loggers are normally named using a hierarchical dot-separated namespace and have a 'child-parent' relationship. For example, the logger named 'root.sv' is a parent of the logger named 'root.sv.sf' and a child of 'root'.

When the server starts for the first time, all the loggers initially listed in the `log4j.properties` file appear on the logger name list. This section allows you to browse through all these loggers, define a log level and switch on/off additivity to any of them. After editing, the logging properties are read only from the database.

-   **Logger** - The name of a logger.
-   **Parent Logger** - The name of a parent logger.
-   **Level** - Allows to select level (threshold) from the drop-down menu. After you specify the level for a certain logger, a log request for that logger will only be enabled if its level is equal or higher to the logger’s level. If a given logger is not assigned a level, then it inherits one from its closest ancestor with an assigned level. Refer to the hierarchy of levels given above. See descriptions of the [available log levels](https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs#MonitoringLogs-log4j_levels) .
-   **Additivity** - Allows to inherit all the appenders of the parent Logger if set as 'True'.

!!! info
In this section, loggers can be filtered by the first characters (use the **Starts With** button) of by a combination of characters (use the **Contains** button).


