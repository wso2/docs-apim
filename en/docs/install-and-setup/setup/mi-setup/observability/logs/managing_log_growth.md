# Managing log growth

See the following content on managing the growth of **Carbon logs** and
**Audit logs** :

## Managing the growth of Carbon logs

Log growth in [Carbon logs]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/monitoring_logs/#carbon-logs) can be managed by the following configurations in the `MI_HOME/conf/log4j2.properties` file.

-   **Configurable log rotation**: By default, log rotation is on a daily
    basis.
-   **Log rotation based on time as opposed to size**: This helps to inspect the events that occurred during a specific time.
-   Log files are archived to maximise the use of space.

The log4j2-based logging mechanism uses appenders to
append all the log messages into a file. That is, at the end of the log
rotation period, a new file will be created with the appended logs and
archived. The name of the archived log file will always contain the date
on which the file is archived.

## Limiting the size of Carbon log files

You can limit the size of the `MI_HOME/repository/logs/wso2carbon.log` file by following the steps given below. This is useful if you want to
archive the logs and get backups periodically.

Configure the following two properties for `CARBON_LOGFILE` appender:

-   `appender.CARBON_LOGFILE.policies.size.size=10MB`
-   `appender.CARBON_LOGFILE.strategy.max = 20`

!!! Info
    If the size of the log file is exceeding the value defined in the `appender.CARBON_LOGFILE.policies.size.size` property, the content is copied to a backup file and the logs are continued to be added to a new empty log file. The `appender.CARBON_LOGFILE.strategy.max` property makes the Log4j2 maintain a maximum number of backup files for the logs.

## Limiting the size of audit log files

In WSO2 servers, audit logs are enabled by default. We can limit the audit log files with the following configuration:

Add the following two properties for `AUDIT_LOGFILE`:

-   `appender.AUDIT_LOGFILE.policies.size.size=10MB`
-   `appender.AUDIT_LOGFILE.strategy.max=20`
