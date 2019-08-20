# System Logs

The **System Logs** page displays information about the log files of the current product. The log files can be retrieved in two ways:

-   If syslog-ng is configured, log files are taken from the remote location where the log files are hosted using the syslog-ng server.
-   If syslog-ng is not configured, log files are taken from the local file system (super-tenant or stand-alone apps).

This page contains the following sections:

-   [Viewing system logs](#SystemLogs-Viewingsystemlogs)
-   [Displaying log mediator logs](#SystemLogs-Displayinglogmediatorlogs)

For more information on logs, see [Logging](_Logging_) .

### Viewing system logs

To view system logs, click **System Logs** on the **Monitor** tab in the Management Console. The log messages displayed on this page are obtained from a memory appender. Therefore, the severity (log level) of the displayed log messages is equal to or higher than the threshold of the memory appender.

-   **File Name -** The name of the file containing logs pertaining to a certain period.
-   **Date -** The date at which the log file was generated.
-   **File Size -** The size of the file in bytes.
-   **Action** - Allows to view and download files.

![](attachments/103333578/103333579.png)

Now, you can download an individual log file, or view it in the Management Console. When viewing a log file, you can choose a category such as ERROR in the **View** list to filter the messages by that category. You can also enter a search term to find a specific log message, and you can use the **Log Head** field to specify how many log lines to display.

![](attachments/103333578/103333580.png)

!!! info
The location of the log files on disk is specified in the `         log4j.configuration        ` file.


### Displaying log mediator logs

When you use the [Log mediator](https://docs.wso2.com/display/ESB490/Log+Mediator) inside sequences and proxy services in WSO2 API Manager, the logs are stored in the `         <PRODUCT_HOME>/repository/logs/wso2carbon.log        ` file by default. To view these logs from the **System Logs** page, open the `         <PRODUCT_HOME>/repository/conf/axis2/axis2.xml        ` file and uncomment the following element:

    <handler class="org.wso2.carbon.utils.logging.handler.TenantDomainSetter" name="TenantDomainSetter"> 

When you restart the server, the logs will be available on the **System Logs** page.
