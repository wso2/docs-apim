# Application Logs

Application logs are events that are recorded when they are invoked by an application or a program running in a system. Similarly, the application logs of a running Carbon instance display the log events of its deployed web applications and web services. The **Application Logs** page has been introduced as a fine-grained view of [system logs](_System_Logs_) . While system logs display log events of the entire system holistically, the application logs page allows the user to select a particular application and view only those logs.

!!! info
The application logs show logs from the proxy service, not from any logs inside its sequences. To view logs from the log mediator, see [System Logs](_System_Logs_) .


The log files can be retrieved in two ways:

-   If syslog-ng is configured, log files are taken from the remote location where the log files are hosted using the syslog-ng server.
-   If syslog-ng is not configured, log files are taken from the local file system (super-tenant or Stand-alone apps).

For more information on logs and how to change log properties according to your preferences, see [Logging](_Logging_) . Follow the instructions below to access statistics on application logs.

1.  Log in to the product's Management Console and click **Monitor &gt; Application Logs** .
    ![](attachments/103333559/103333560.png)2.  The **Application Logs** page appears. This page displays logs of a selected application in a bottom-up manner. For example,
    ![](attachments/38472324/38766337.png)

        !!! info
    Note

    The log messages displayed on this page are obtained from a memory appender. Therefore, the severity (log level) of the displayed log messages is equal to or higher than the threshold of the memory appender. For more information on appenders, loggers, their log levels and logging, see [Apache Log4j 2](http://logging.apache.org/log4j/) in the Apache documentation.


3.  Use the drop-down list shown below to select a deployed web service or web application to view its log files.
    ![](attachments/103333559/103333562.png)
4.  In the **View** list, select the category of logs you want to view. The available categories are:

    -   TRACE - Trace messages
    -   DEBUG - Debug messages
    -   INFO - Information messages
    -   WARN - Warning messages
    -   ERROR - Error messages
    -   FATAL - Fatal error messages
    -   ALL - Displays all categories of logs

    For example,

    ![](attachments/103333559/103333563.png)

5.  You can also search for a specific log using the search function. Enter a keyword (or part of a keyword) and click **Search.** When a search criteria is given, the **View** field is displayed as **Custom.**

    For example,

    ![](attachments/103333559/103333564.png)

        !!! info
    Note

    The location of the log files on disk is specified in the `log4j.configuration` file.



