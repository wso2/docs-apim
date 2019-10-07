# Setting Up Logging

There are two ways to configure log4j [logging](_Logging_) in WSO2 API Manager. You can manually edit the `log4j.properties` file, or configure logging through the management console. Configuration made through the management console can be persisted in the WSO2 registry so that it is available even after the server restarts. There is also an option to restore the original Log4j configuration from the `log4j.properties` file using the management console. However, if you modify the `log4j.properties` file and restart the server, the earlier log4j configuration persisted in the registry is overwritten.

-   [Configure logging](#SettingUpLogging-Configurelogging)
    -   [Global Log4J configuration](#SettingUpLogging-GlobalLog4Jconfiguration)
    -   [Configure Log4J appenders](#SettingUpLogging-ConfigureLog4Jappenders)
    -   [Configure Log4J loggers](#SettingUpLogging-ConfigureLog4Jloggers)

For information on viewing the contents of the logs, see [Application Logs](_Application_Logs_) and [System Logs](_System_Logs_) .

### Configure logging

Follow the instructions below to set up logging.

1.  Sign in to the [API-M Management Console](https://docs.wso2.com/display/AM210/Running+the+Product#RunningtheProduct-run) .
2.  Click **Configure &gt; Logging** .
    ![](/assets/attachments/103333565/103333572.png)3.  If you want your modifications to be persisted and available even after a server restart, select the **Persist All Configurations Changes** check box.
    ![](/assets/attachments/103333565/103333571.png)4.  Use the options in the following sections to configure the layout and the amount of information about system activity that you want to record.

-   [Global Log4J configuration](#SettingUpLogging-GlobalLog4Jconfiguration)
-   [Configure Log4J appenders](#SettingUpLogging-ConfigureLog4Jappenders)
-   [Configure Log4J loggers](#SettingUpLogging-ConfigureLog4Jloggers)

#### Global Log4J configuration

![](/assets/attachments/103333565/103333570.png)
This section allows you to assign a single log level and log pattern to all loggers.

-   **Log Level** - Reflects a minimum level that this logger cares about. You can view the hierarchy of levels [below](#SettingUpLogging-Hierarchyoflevels) .
-   **Log Pattern** - Defines the output format of the log file.

#### Configure Log4J appenders

![](/assets/attachments/103333565/103333569.png)
`Log4j` allows logging requests to print to multiple destinations. These output destinations are called appenders. You can attach several appenders to one logger.

-   **Name** - The name of an appender. By default, WSO2 API Manager comes with the following log appenders configured:
    -   **CARBON\_CONSOLE** - Logs to the console when the server is running.
    -   **CARBON\_LOGFILE** - Writes the logs to the `<API-M_HOME>/repository/logs/wso2carbon.log` file.
    -   **SERVICE** \_ **APPENDER** - Writes mediation time audit messages to the &lt; `API-M_HOME>/repository/logs/wso2-apigw-service.log` file.
    -   **TRACE** \_ **APPENDER** - Writes mediation time tracing/debug messages to the &lt; `API-M_HOME>/repository/logs/wso2-apigw-trace.log` file for tracing enabled services.
    -   **TRACE** \_ **MEMORYAPPENDER**
    -   **CARBON** \_ **MEMORY**
    -   **CARBON\_SYS\_LOG -** Allows separation of the software that generates messages from the system that stores them and the software that reports and analyzes them.
-   **Log pattern** - Defines the output format of the log file.
-   **Threshold** - Filters log entries based on their level. For example, if the threshold is set to WARN, log entries are allowed to pass into the appender if its level is WARN, ERROR or FATAL, while other entries are discarded.

##### Hierarchy of levels

-   **TRACE** - Designates informational events that are more fine-grained than DEBUG.
-   **DEBUG** - Designates fine-grained informational events that are most useful to debug an application.
-   **INFO** - Designates informational messages that highlight the progress of the application at coarse-grained level.
-   **WARN** - Designates potentially harmful situations.
-   **ERROR** - Designates error events that might still allow the application to continue running.
-   **FATAL** - Designates very severe error events that will presumably lead the application to abort.

#### Configure Log4J loggers

![](/assets/attachments/103333565/103333568.png){height="250"}

This section allows you to browse through all loggers, define a log level, and switch on/off additivity to any of them. You can filter loggers using the first few characters (use the **Starts With** button) or using a combination of characters (use the **Contains** button).

-   **Logger** - The name of a logger.
-   **Parent Logger** - The name of a parent logger.
-   **Level** - Allows to select the level (threshold) from the drop-down menu. After you specify the level for a certain logger, a log request for that logger is enabled only if its level is equal or higher to that of the logger’s. If a given logger is not assigned a level, then it inherits one from its closest ancestor with an assigned level. See [hierarchy of levels](#SettingUpLogging-hierarchy) above.
-   **Additivity** - Allows to inherit all the appenders of the parent Logger if set to True.

##### Example

Use the following procedure to enable logs to view HTTP headers and messages:

1.  In the **Filter Loggers by** field, enter **wire** and then click **Contains** .
    You see `org.apache.synapse.transport.http.wire` displayed under **Logger** .
    ![](/assets/attachments/103333565/103333567.png)2.  Change the level of this logger to **DEBUG** .
3.  Search for the `org.apache.synapse.transport.http.headers` logger and change the level to **DEBUG** .

![](/assets/attachments/103333565/103333566.png)
Alternatively, you can uncomment the entry for the two loggers as follows:

1.  Go to the `<API-M_HOME>/repository/conf` directory and open the `log4j.properties` file with a text editor.
2.  Edit the entries for the two loggers as follows by removing the commented (\#).
`log4j.logger.org.apache.synapse.transport.http.headers=DEBUG`
`log4j.logger.org.apache.synapse.transport.http.wire=DEBUG`
3.  Save the changes.

