# Enforcer Log Configurations

As the Enforcer component is implemented in Java, we are using the `log4j2` framework for logging. Hence, this section will contain most of the configurations related to `log4j2`.

## Configuring Log4j2 Properties

All WSO2 products are shipped with the `log4j2` logging capabilities, which generates administrative activities and server side logs. The `log4j2` file governs how logging is performed by the Enforcer. You can configure the Log4j2 properties via the `log4j2.properties` file, which is available in [these directories]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-overview/#log4j2_properties) based on your Choreo Connect deployment.

The following are the three main components that you can configure via log4j2:

- **Loggers**
- **Appenders**
- **Layouts**

### Setting the log level

The log level can be set specifically for each appender in the `log4j2.properties` or `log4j2-configmap.yaml` file, [based on your Choreo Connect deployment]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-overview/#log4j2_properties), by setting the threshold value. If a log level is not specifically given for an appender as explained below, the root log level (INFO) will apply to all appenders by default.

For example, shown below is how the log level is set to DEBUG for the `ENFORCER_LOGFILE` appender:

```bash
appender.ENFORCER_LOGFILE.filter.threshold.level = DEBUG
```

Listed below are the log levels that can be configured:

| **Level** | **Description**                                                                                                                                                                                                                                                                     |
|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| OFF   | The highest possible log level. This is intended for disabling logging.                                                                                                                                                                                                         |
| FATAL | Indicates server errors that cause premature termination. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                          |
| ERROR | Indicates other runtime errors or unexpected conditions. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                           |
| WARN  | Indicates the use of deprecated APIs, poor use of API, possible errors, and other runtime situations that are undesirable or unexpected but not necessarily wrong. These logs are expected to be immediately visible on the command line that you used for starting the server. |
| INFO  | Indicates important runtime events, such as server startup/shutdown. These logs are expected to be immediately visible on the command line that you used for starting the server . It is recommended to keep these logs to a minimum.                                           |
| DEBUG | Provides detailed information on the flow through the system. This information is expected to be written to logs only. Generally, most lines logged by your application should be written as DEBUG logs.                                                                        |
| TRACE | Provides additional details on the behavior of events and services. This information is expected to be written to logs only.                                       |

### Setting the Threshold

Filters log entries based on their level. For example, threshold set to 'WARN' will allow the log entry to pass into appender. If its level is `WARN`, `ERROR` or `FATAL`, other entries will be discarded. This is the minimum log level at which you can log a message. See descriptions of the available log levels.

!!! Note
    The log level set up at `appender` might be overridden with the properties defined at logger. For example, if we set the threshold at the `appender` level as `DEBUG` and logger level as `ERROR`, it will only show the logs up to the `ERROR` level.

    Configurations example:
    ```properties
    appender.ENFORCER_CONSOLE.filter.threshold.level = DEBUG
    ...
    logger.enforcer.name = org.wso2.choreo.connect.enforcer
    logger.enforcer.level = ERROR
    logger.enforcer.additivity = false
    logger.enforcer.appenderRef.rolling.ref = ENFORCER_LOGFILE
    logger.enforcer.appenderRef.console.ref = ENFORCER_CONSOLE
    ```
    With this configuration, the `ENFORCER_CONSOLE` will only show logs up to the `ERROR` level.

### Configuring Log4j2 Appenders

This section shows you how to configure appenders individually. Log4j2 allows logging requests to print to multiple destinations. These output destinations are called `Appenders`. You can attach several appenders to one of the loggers. The following are the appenders used in the Enforcer.

-   **ENFORCER_CONSOLE**: Logs to the console when the enforcer is running.
-   **ENFORCER_LOGFILE**: Writes the logs to `/home/wso2/logs/enforcer.log` file inside the container.   
-   **ENFORCER_ACCESS_LOG**: Writes the access logs to `/home/wso2/logs/enforcer_access.log` file inside the container. 

!!! Info
    These appenders are configured by default to use for destinations mentined above. If you want to modify any of the configurations related to that, you can modify them according to log configurations defined in [log4j2 documentation](https://logging.apache.org/log4j/2.x/manual/appenders.html#).

!!! Note
    If the output destination is in another environment (such as a cloud storage), you need to [use custom log appenders](#https://logging.apache.org/log4j/2.x/manual/appenders.html).

### Configuring Log4j2 Loggers

A Logger is an object used to log messages for a specific system or application component. You can specify loggers as below.

```properties
loggers = enforcer, io-swagger-v3, enforcer-interceptors, carbon-apimgt, <your_logger_name>
```

These loggers can be referred to (in order to set their properties) using `logger.<logger_name>`.

The logger element must have a **name** attribute specified. It may also have a **level** attribute and an **additivity** attribute specified. The level may be configured with one of the following values: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `ALL` or `OFF`. 

-   **name**: The name of a logger.
-   **level**: Allows to configure level (threshold). After you specify the level for a certain logger, a log request for that logger will only be enabled if its level is equal or higher to the logger’s level. If a given logger is not assigned a level, then it inherits one from its closest ancestor with an assigned level. Refer to the hierarchy of levels given above. See descriptions of the available log levels .
-   **additivity**: Allows to inherit all the appenders of the parent Logger if set as `true`.

In summary, in following steps yu can specify a logger.

1. Add the logger in the `log4j2.properties` or `log4j2-configmap.yaml` file, [based on your Choreo Connect deployment](#filepaths) to the list of loggers by referring the logger name:

    ```properties
    loggers = mgw-enforcer, io-swagger-v3, mgw-enforcer-interceptors, <your_logger_name>, 
    ```

2. Add the logger in the `log4j2.properties` or `log4j2-configmap.yaml` file, [based on your Choreo Connect deployment](#filepaths) as you need:

    ```properties
    logger.<your_logger_name>.name = <Component_name>
    logger.<your_logger_name>.type = INFO
    ```

    For example:

    ```properties
    logger.enforcer.name = org.wso2.micro.gateway.enforcer
    logger.enforcer.level = INFO
    logger.enforcer.additivity = false
    logger.enforcer.appenderRef.rolling.ref = ENFORCER_LOGFILE
    logger.enforcer.appenderRef.console.ref = ENFORCER_CONSOLE
    ```

!!! Note
    You can find more details on log4j2 appenders, loggers, and its attributes from the official documentation of [log4j2](#https://logging.apache.org/log4j/2.x/). 

## Enforcer Access Logs

Choreo Connect is capable of enabling access logs to drill down on errors that occurred during the API invocations. To enable Enforcer access logs, you need to set the appender `ENFORCER_ACCESS_LOG`'s log level as `DEBUG`. The following steps will guide you through enabling access logs in the Enforcer.

1. Make sure the log level is set to `DEBUG` in the appender.
    ```properties
    appender.ENFORCER_ACCESS_LOG.filter.threshold.level = DEBUG
    ```

2. Change the log level as `DEBUG` from the logger, which the above appender is using. In this case, it would be the `rootLogger`
    ```properties
    rootLogger.level = ERROR
    rootLogger.appenderRef.ENFORCER_CONSOLE.ref = ENFORCER_CONSOLE
    rootLogger.appenderRef.ENFORCER_LOGFILE.ref = ENFORCER_LOGFILE
    rootLogger.appenderRef.ENFORCER_ACCESS_LOG.ref = ENFORCER_ACCESS_LOG
    ```

    !!! Note
        Here we are setting the threshold for the appender's log level as `DEBUG`. For more information on this, please refer [here](#setting-the-threshold).

## Setting the log format

### Plain Text format

By default, the Enforcer is enabled with the plain text formatted logs. The plain text format is enabled with the `log4j2`'s `PatternLayout`. The following configuration under `appender` will specify that.

```properties
appender.appender_name.layout.type = PatternLayout
```

Then the pattern of the text formatted log will be specified by the following config.

```properties
appender.<appender_name>.layout.pattern = [%d{DEFAULT}][%X{traceId}]%x %5p - {\%c} - %m [%errorDetails]%n
```

!!! Note
    More details on this pattern specification can be find in the official [log4j2 documentation](https://logging.apache.org/log4j/2.x/manual/layouts.html#PatternLayout).

### JSON format

The Enforcer can be configured to output logs in JSON format by setting the layout as `CustomJsonLayout` which is a customized implementation of log4j2's [AbstractStringLayout](https://logging.apache.org/log4j/2.x/log4j-core/apidocs/org/apache/logging/log4j/core/layout/AbstractStringLayout.html). You can set it using the following configuration.


```properties
appender.<appender_name>.layout.type = CustomJsonLayout
```

!!! Note
    The following configuration is not required here, as the pattern of a `CustomJsonLayout` layout cannot be specified.
    ```properties
    appender.<appender_name>.layout.pattern = <pattern_string>
    ```

!!! Note
    Currently, the JSON formatted logs will not be supported with access logs (`ENFORCER_ACCESS_LOG`).
