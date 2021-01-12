# Enabling Logs for a Component

Follow the instructions given below to enable logs for a specific component in the Micro Integrator.

## Enabling Logs

There are two ways to enable logs for a component: using the Micro Integrator [dashboard](#using-the-dashboard) or using the [CLI](#using-the-cli).

!!! Info
    Alternatively, you can directly update the [log configurations](../configuring_log4j_properties) in the `log4j2.properties` file (stored in the `<MI_HOME>/conf` directory).

### Using the Dashboard

1.  Sign in to the [Micro Integrator dashboard](../../../administer-and-observe/working-with-monitoring-dashboard).
2.  Click <b>Log Configs</b> on the left-hand navigator to open the <b>Logging Management</b> window.
3.  Go to the <b>Add Loggers</b> tab and define the new logger.

    <img alt="add new loggers using dashboard" src="../../../assets/img/monitoring-dashboard/add-logger.png">

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
                Specify the <a href="../configuring_log4j_properties/#updating-the-log4j2-log-level">log level</a>.
            </td>
        </tr>
    </table>
 
### Using the CLI

1.  Download and set up the [Micro Integrator CLI](../../../administer-and-observe/using-the-command-line-interface/#installing-the-cli).
2.  Use the [mi log-level](../../../administer-and-observe/using-the-command-line-interface/#mi-log-level) option in the CLI with the required commands as shown in the following examples:

    ```bash
    # Add a new logger
    mi log-level update synapse-api org.apache.synapse.rest.API DEBUG
    ```

## Printing Logs

By default, when you enable logs for a component, the logs get printed to the server console and the <b>carbon log file</b>. When there are error logs, these are also printed to the <b>error log file</b>. These log files are stored in the `MI_HOME/repository/logs/` directory.

By default, all loggers print logs to the destinations configured for the [root logger](../configuring_log4j_properties/#root-logs). If you want to print logs to new destinations, you can define new [appenders](../configuring_log4j_properties/#log4j2-appenders). 

For example, you will define new appenders when you want to have [per-service log files](../../../develop/enabling-logs-for-services/) or [per-api log files](../../../develop/enabling-logs-for-api/).

## What's Next?

Once you have defined the new logger:

-   Start [using the logs](../../../administer-and-observe/logs/monitoring_logs).
-   [Configure the log properties](../configuring_log4j_properties)