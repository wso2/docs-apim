# Enabling Logs for a Component

Follow the instructions given below to enable logs for a specific component in the Micro Integrator.

## Enabling Logs

There are two ways to enable logs for a component: using the Micro Integrator [dashboard](#using-the-dashboard) or using the [CLI](#using-the-cli).

!!! Info
    Alternatively, you can directly update the [log configurations]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties) in the `log4j2.properties` file (stored in the `<MI_HOME>/conf` directory).

### Using the Dashboard

1.  Sign in to the [Micro Integrator dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard).
2.  Click <b>Log Configs</b> on the left-hand navigator to open the <b>Logging Management</b> window.
3.  Go to the <b>Add Loggers</b> tab and define the new logger.

    <img alt="add new loggers using dashboard" src="{{base_path}}assets/img/integrate/monitoring-dashboard/add-logger.png">

    <table>
        <tr>
            <th>
                Logger Name
            </th>
            <td>
                Give a name for the logger.
            </td>
        </tr>
        <tr>
            <th>
                Class
            </th>
            <td>
                Specify the class implementation of the component for which the logger is defined.
            </td>
        </tr>
        <tr>
            <th>
                Log Level
            </th>
            <td>
                Specify the <a href="{{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties/#updating-the-log4j2-log-level">log level</a>.
            </td>
        </tr>
    </table>
 
### Using the CLI

1.  Download and set up the [API Controller]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller).

2.  Use the commands for [adding a new logger]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl/#add-a-new-logger) to the Micro Integrator.

## Printing Logs

By default, when you enable logs for a component, the logs get printed to the server console and the <b>carbon log file</b>. When there are error logs, these are also printed to the <b>error log file</b>. These log files are stored in the `<MI_HOME/repository/logs/` directory.

By default, all loggers print logs to the destinations configured for the [root logger]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties/#root-logs). If you want to print logs to new destinations, you can define new [appenders]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties/#log4j2-appenders). 

For example, you will define new appenders when you want to have [per-service log files]({{base_path}}/integrate/develop/enabling-logs-for-services/) or [per-api log files]({{base_path}}/integrate/develop/enabling-logs-for-api/).

## What's Next?

Once you have defined the new logger:

-   Start [using the logs]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/monitoring_logs).
-   [Configure the log properties]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties)
