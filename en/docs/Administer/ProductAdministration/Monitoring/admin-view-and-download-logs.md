# admin\_View and Download Logs

It is possible to monitor system logs and application logs in your server using the management console, if the [Logging Management feature](https://docs.wso2.com/display/ADMIN44x/Monitoring+Logs+using+Management+Console) is installed . Further, when you monitor system logs, you can also download the archived log files using the management console. See [Configuring Log4j Properties](https://docs.wso2.com/display/ADMIN44x/Configuring+Log4j+Properties) and [Configuring Log Providers](https://docs.wso2.com/display/ADMIN44x/Configuring+the+Log+Provider) for details on how the server can be configured for log monitoring.

The log files can be retrieved in two ways:

-   If syslog-ng is configured, log files are taken from the remote location where the log files are hosted using syslog-ng server.
-   If syslog-ng is not configured, log files are taken from the local file system (super-tenant or Stand-alone apps).

!!! info
The location of the log files on disk is specified in the `log4j.configuration` file.

!!! info
The log messages displayed on this page are obtained from a memory appender. Therefore, the severity (log level) of the displayed log messages are equal to or higher than the threshold of the memory appender. For more information on appenders, loggers, their log levels and logging, go to [http://logging.apache.org/log4j](http://logging.apache.org/log4j/) .


See the following topics on system logs and application logs:

-   [View and download system logs](#admin_ViewandDownloadLogs-Viewanddownloadsystemlogs)
-   [View application logs](#admin_ViewandDownloadLogs-Viewapplicationlogs)

### View and download system logs

The **System Logs** page on the management console displays all events of a running Carbon instance. Further, it facilitates downloading and viewing log files according to user preferences. Follow the instructions below to access statistics on system logs:

1.  Log on to the product's management console and select **Monitor -&gt; System Logs** . The **System Logs** page appears and displays logs in a bottom-up manner.

2.  To view old archived logs, click **Show archived logs** tab at the bottom of the **System Logs** page.

    ![](/assets/attachments/32351462/32525350.png)

    The **Download** link can be used to download the log files. For example, if the server is configured to use the [default log provider](https://docs.wso2.com/display/ADMIN44x/Configuring+the+Log+Provider) , the "wso2carbon.log" file stored in the `<PRODUCT_HOME>/repository/logs/` directory can be downloaded.

3.  In the **View** list, select the category of logs you want to view. The available categories are:

    -   **TRACE** - Trace messages.
    -   **DEBUG** - Debug messages.
    -   **INFO** - Information messages.
    -   **WARN** - Warning messages.
    -   **ERROR** - Error messages.
    -   **FATAL** - Fatal error messages.

    ![](/assets/attachments/32351462/32525349.png)

4.  You can also find a specific log using the search function. Enter a keyword (or part of a keyword) and click **Search** .

    ![](/assets/attachments/32351462/32525348.png)

### View application logs

Events invoked by an application or a program running in a system are recorded as application logs. Similarly, the a pplication logs of a running Carbon instance displays the log events of its deployed web applications and web services. The **Application Logs** page has been introduced as a fine-grained view of System Logs . While system logs display log events of the entire system holistically, the application logs page allows you to view the logs relevant to a particular application.

Follow the instructions given below to access statistics on application logs:

1.  Log on to the product's management console and select **Monitor -&gt; Application Logs** .
2.  The "Application Logs" page appears. This page displays logs of a selected application in a bottom-up manner.

3.  You can see a drop-down list from which a deployed web services or a web applications can be selected to view its log files.
    ![](/assets/attachments/12421402/12747658.png)
4.  In the **View** list, select the category of logs you want to view. The available categories are:

    -   **TRACE** - Trace messages.
    -   **DEBUG** - Debug messages.
    -   **INFO** - Information messages.
    -   **WARN** - Warning messages.
    -   **ERROR** - Error messages.
    -   **FATAL** - Fatal error messages.
    -   **ALL** - Displays all categories of logs.

    For Example,

    ![](/assets/attachments/12421402/12747656.png)

5.  You can also find a certain log using the search function. Enter a keyword (or part of a keyword) and click **Search** . When a search criterion is given, the value in the **View** field is displayed as **Custom** . For example,
    ![](/assets/attachments/12421402/12747655.png)

