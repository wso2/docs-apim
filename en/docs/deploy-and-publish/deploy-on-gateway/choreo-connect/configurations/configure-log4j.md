# Configuring Log4j2 Properties

All WSO2 products are shipped with the log4j2 logging capabilities, which generates administrative activities and server side logs. The `log4j2.properties` file, which governs how logging is performed by the enforcer can be found in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory.

There are three main components when configuring log4j2: **Loggers**, **Appenders**, and **Layouts**.

## Setting the log level

The log level can be set specifically for each appender in the `log4j2.properties        ` file by setting the threshold value. If a log level is not specifically given for an appender as explained below, the root log level (INFO) will apply to all appenders by default.

For example, shown below is how the log level is set to DEBUG for the `MGW_LOGFILE` appender:

```bash
appender.MGW_LOGFILE.filter.threshold.level = DEBUG
```

Listed below are the log levels that can be configured:

| Level | Description                                                                                                                                                                                                                                                                     |
|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| OFF   | The highest possible log level. This is intended for disabling logging.                                                                                                                                                                                                         |
| FATAL | Indicates server errors that cause premature termination. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                          |
| ERROR | Indicates other runtime errors or unexpected conditions. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                           |
| WARN  | Indicates the use of deprecated APIs, poor use of API, possible errors, and other runtime situations that are undesirable or unexpected but not necessarily wrong. These logs are expected to be immediately visible on the command line that you used for starting the server. |
| INFO  | Indicates important runtime events, such as server startup/shutdown. These logs are expected to be immediately visible on the command line that you used for starting the server . It is recommended to keep these logs to a minimum.                                           |
| DEBUG | Provides detailed information on the flow through the system. This information is expected to be written to logs only. Generally, most lines logged by your application should be written as DEBUG logs.                                                                        |
| TRACE | Provides additional details on the behavior of events and services. This information is expected to be written to logs only.                                       |

## Setting the Threshold

Filters log entries based on their level. For example, threshold set to 'WARN' will allow the log entry to pass into appender. If its level is 'WARN', 'ERROR' or 'FATAL', other entries will be discarded. This is the minimum log level at which you can log a message. See descriptions of the available log levels.

## Configuring Log4j2 Appenders

This section allows you to configure appenders individually. Log4j2 allows logging requests to print to multiple destinations. These output destinations are called 'Appenders'. You can attach several appenders to one logger.

!!! Note
    If the output destination is in another environment (such as a cloud storage), you need to [use custom log appenders](#using-custom-log-appenders).

-   **MGW_CONSOLE**: Logs to the console when the enforcer is running.
-   **MGW_LOGFILE**: Writes the logs to `MGW_HOME/resources/logs/wso2carbon.log`.                 

## Configuring Log4j2 Loggers

A Logger is an object used to log messages for a specific system or application component. 

The logger element must have a name attribute specified. It may also have a **level** attribute and an **additivity** attribute specified. The level may be configured with one of the following values: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `ALL` or `OFF`. 

-   **Name**: The name of a logger.
-   **Level**: Allows to configure level (threshold). After you specify the level for a certain logger, a log request for that logger will only be enabled if its level is equal or higher to the logger’s level. If a given logger is not assigned a level, then it inherits one from its closest ancestor with an assigned level. Refer to the hierarchy of levels given above. See descriptions of the available log levels .
-   **Additivity**: Allows to inherit all the appenders of the parent Logger if set as 'True'.

1.  Add the logger in the `log4j2.properties` file:

    ```xml
    logger.<Logger_Name>.name = <Component_name>
    logger.<Logger_Name>.type = INFO
    ```

    For example:

    ```xml
    logger.mgw-enforcer.name = org.wso2.micro.gateway.enforcer
    logger.mgw-enforcer.level = INFO
    logger.mgw-enforcer.additivity = false
    logger.mgw-enforcer.appenderRef.rolling.ref = MGW_LOGFILE
    logger.mgw-enforcer.appenderRef.console.ref = MGW_CONSOLE
    ```

2.  Then, add the logger to the list of loggers by referring the logger name:

    ```xml
    loggers = mgw-enforcer, io-swagger-v3, mgw-enforcer-interceptors, 
    ```