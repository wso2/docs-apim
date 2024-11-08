# Utilizing the WSO2 Runtime Diagnostic Tool

WSO2 Runtime Diagnostic Tool is a lightweight and easy-to-use tool for generating diagnostic details. It simplifies the data collection process to minimize user involvement. The tool is capable of preemptive data collection for certain types of issues, such as OOM errors. It also captures significant changes in Passthrough metrics for better insight into specific issues. The tool is supported for WSO2 API Manager and WSO2 Micro Integrator.

The tool can be configured using the [Configuration Guide](#configuration-guide) provided below. The output of the tool can be analyzed using the [Analysis Guide](#analysing-runtime-issues-with-the-wso2-runtime-diagnostic-tool) provided below.

## Components

There are four main components in the tool:

- **Memory Watcher**: Monitors the memory usage of the server and executes the configured Action Executors when the memory usage exceeds the threshold.
- **CPU Watcher**: Monitors the CPU usage of the server and executes the configured Action Executors when the CPU usage exceeds the threshold.
- **Traffic Analyzer**: Monitors the traffic of the server and generates logs when the traffic pattern suddenly changes significantly.
- **Log Watcher**: Monitors the error logs of the server and executes the configured Action Executors when the log pattern matches the configured pattern.


## Configuration Guide

The tool is packaged inside the product distribution with default configurations. The configurations can be customized based on user requirements. 

### Server Configurations

The table given below describes the server configurations.

| Configuration | Description                                         |
| --- |-----------------------------------------------------|
| `deployment_toml_path` | Path to the deployment.toml file in the WSO2 server |
| `logs_directory` | Path to the logs directory.                         |
| `updates_config_path` | Path to the updates config file.                    |
| `diagnostic_log_file_path` | Path to write the diagnostic log file.              |
| `carbon_log_file_path` | Path to the carbon error log (wso2error.log) file.  |
| `process_id_path` | Path to the process id file (wso2carbon.pid).       |
| `server_name` | Name of the WSO2 server.                            |
| `server_version` | Version of the WSO2 server.                         |

Given below is a sample configuration for the WSO2 API Manager.

```toml
[server_configuration]
deployment_toml_path = "../conf/deployment.toml"
logs_directory = "../repository/logs"
updates_config_path = "../updates/config.json"
diagnostic_log_file_path = "logs/diagnostics.log"
carbon_log_file_path = "../repository/logs/wso2error.log"
process_id_path = "../wso2carbon.pid"
server_name = "WSO2 API Manager"
server_version = "#.#.#"
```

### Action Executor Configurations

Currently, the tool supports the following action executors.

| Action Executor | Description                                                             |
| --- |-------------------------------------------------------------------------------------|
| `ThreadDumper` | Runs the jstack tool to take thread dump and writes the output to a file.     |
| `MemoryDumper` | Takes a heap dump                                                          |
| `OpenFileFinder` | Finds the open files by the server process and writes the output to a file. |
| `Netstat` | Dumps the network statistics of the server to a file.                           |
| `ServerInfo` | Dumps the server information such as name, version, etc.                     |
| `MetricsSnapshot` | Takes a current snapshot of the Passthrough transport metrics in synapse|

#### ThreadDumper

| Configuration | Description                                         |
| --- |-----------------------------------------------------|
| `count` | Number of thread dumps to be taken.                 |
| `delay` | Delay between each thread dump in milliseconds.     |

Given below is a sample configuration for the `ThreadDumper` action executor.

```toml
[[action_executor_configuration]]
executor = "ThreadDumper"
count = "5"
delay = "2000"
```

#### MemoryDumper

Given below is a sample configuration for the `MemoryDumper` action executor.

```toml
[[action_executor_configuration]]
executor = "MemoryDumper"
```

#### OpenFileFinder

Given below is a sample configuration for the `OpenFileFinder` action executor.

```toml
[[action_executor_configuration]]
executor = "OpenFileFinder"
```

#### Netstat

Given below is a sample configuration for the `Netstat` action executor.

```toml
[[action_executor_configuration]]
executor = "Netstat"
command = "netstat -lt"
```

#### ServerInfo

Given below is a sample configuration for the `ServerInfo` action executor.

```toml
[[action_executor_configuration]]
executor = "ServerInfo"
```

#### MetricsSnapshot

Given below is a sample configuration for the `MetricsSnapshot` action executor.

```toml
[[action_executor_configuration]]
executor = "MetricsSnapshot"
```

### Watcher Configurations

Currently, the tool supports the following watchers.

| Watcher | Description                                                                |
| --- |----------------------------------------------------------------------------|
| `cpu_watcher` | Watches the CPU usage of the server.                                       |
| `memory_watcher` | Watches the memory usage of the server.                                    |
| `log_watcher` | Watches the logs for specific error patterns and triggers actions.         |
| `traffic_analyzer` | Analyzes the Passthrough server traffic and records in the diagnostic log file. |

#### cpu_watcher

| Configuration | Description                                                                            |
| --- |----------------------------------------------------------------------------------------|
| `enabled` | Whether the watcher is enabled or not.                                                 |
| `threshold` | The threshold value for the CPU usage.                                                 |
| `attempts` | The number of attempts before triggering the action executors (This resets every hour). |
| `interval` | The interval between each check in seconds.                                            |
| `action_executors` | The action executors to be triggered when the threshold is reached. (Comma separated)  |

Given below is a sample configuration for `cpu_watcher`.

```toml
[cpu_watcher]
enabled = "true"
threshold = "20"
attempts = "2"
interval = "5"
action_executors = "ThreadDumper,MetricsSnapshot,ServerInfo"
```

#### memory_watcher

| Configuration    | Description                                                                           |
|------------------|---------------------------------------------------------------------------------------|
| `enabled`          | Whether the watcher is enabled or not.                                                |
| `threshold`        | The threshold value for the memory usage.                                             |
| `attempts`         | The number of attempts before triggering the action executors (This resets every hour).|
| `interval`         | The interval between each check in seconds.                                           |
| `action_executors` | The action executors to be triggered when the threshold is reached. (Comma separated) |

Given below is a sample configuration for `memory_watcher`.

```toml
[memory_watcher]
enabled = "true"
threshold = "30"
attempts = "2"
interval = "5"
action_executors = "ThreadDumper,MetricsSnapshot,ServerInfo"
```

#### log_watcher

| Configuration | Description                                                                           |
| --- |---------------------------------------------------------------------------------------|
| enabled | Whether the watcher is enabled or not.                                                |
| interval | The interval between each check in seconds.                                           |

Given below is a sample configuration for `log_watcher`.

```toml
[log_watcher]
enabled = "true"
interval = "0.1" 
```

### Log error patterns

| Configuration | Description                                                                                                                                                                                                                                                                         |
| --- |-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `regex` | Directory to store the zip files                                                                                                                                                                                                                                                    |
| `executors` | The action executors to be triggered when the threshold is reached. (Comma separated)                                                                                                                                                                                               |
| `reload_time` | Continuous error logs that match the regex pattern won't be processed repeatedly unless the `reload_time` has elapsed. An error log which matches a certain regex pattern will only be processed after the reload time interval whereas a similar error log was processed before. |

Given below is a sample configuration.

```toml
[[log_pattern]]
regex = "(.*)org.apache.synapse.transport.passthru(.*)"
executors = "MetricsSnapshot,Netstat,OpenFileFinder,ThreadDumper,ServerInfo"
reload_time = "30"
```

### Traffic Analyzer Configurations

| Configuration | Description                                                                           |
| --- |---------------------------------------------------------------------------------------|
| `last_second_requests_enabled` | Whether the last second requests watcher is enabled or not.                           |
| `last_second_requests_windows_size` | The window size for the last second requests watcher.                                  |
| `last_second_requests_delay` | The delay for the last second requests watcher.                                        |
| `last_second_requests_interval` | The interval for the last second requests watcher.                                     |
| `last_fifteen_seconds_requests_enabled` | Whether the last fifteen seconds requests watcher is enabled or not.                 |
| `last_fifteen_seconds_requests_window_size` | The window size for the last fifteen seconds requests watcher.                        |
| `last_fifteen_seconds_requests_delay` | The delay for the last fifteen seconds requests watcher.                              |
| `last_fifteen_seconds_requests_interval` | The interval for the last fifteen seconds requests watcher.                           |
| `last_minutes_requests_enabled` | Whether the last minutes requests watcher is enabled or not.                           |
| `last_minutes_requests_window_size` | The window size for the last minutes requests watcher.                                  |
| `last_minutes_requests_delay` | The delay for the last minutes requests watcher.                                        |
| `last_minutes_requests_interval` | The interval for the last minutes requests watcher.                                     |
| `notify_interval` | The interval for the traffic analyzer to notify the user.                               |

Given below is a sample configuration for the traffic analyzer.

```toml
[traffic_analyzer]
last_second_requests_enabled = "false"
last_second_requests_windows_size = "300"
last_second_requests_delay = "60"
last_second_requests_interval = "1"
last_fifteen_seconds_requests_enabled = "true"
last_fifteen_seconds_requests_window_size = "100"
last_fifteen_seconds_requests_delay = "4"
last_fifteen_seconds_requests_interval = "15"
last_minutes_requests_enabled = "true"
last_minutes_requests_window_size = "100"
last_minutes_requests_delay = "1"
last_minutes_requests_interval = "60"
notify_interval = "300"
```

### Post Action Executors

#### Zip File Configurations

| Configuration | Description                                                                                       |
| --- |---------------------------------------------------------------------------------------------------|
| `output_directory` | Directory to store the zip files                                                                  |
| `max_count` | Maximum number of zip files to maintain. When the count exceeds, the older files will be deleted. |

Given below is a sample configuration.

```toml
[zip_file_configuration]
output_directory = "data"
max_count = "50"
```

#### FTP Configurations

| Configuration | Description                                                                                       |
| --- |---------------------------------------------------------------------------------------------------|
| `enabled` | Whether the FTP is enabled or not.                                                                |
| `host` | The FTP host.                                                                                     |
| `port` | The FTP port.                                                                                     |
| `username` | The FTP username.                                                                                 |
| `password` | The FTP password.                                                                                 |
| `directory` | The FTP directory.                                                                                |

Given below is a sample configuration.

```toml
[ftp_configuration]
enabled = "true"
host = "ftp.example.com"
port = "21"
username = "user"
password = "password"
directory = "diagnostics"
```

#### SFTP Configurations

| Configuration | Description                                                                                       |
| --- |---------------------------------------------------------------------------------------------------|
| `enabled` | Whether the SFTP is enabled or not.                                                               |
| `host` | The SFTP host.                                                                                    |
| `port` | The SFTP port.                                                                                    |
| `username` | The SFTP username.                                                                                |
| `password` | The SFTP password.                                                                                |
| `directory` | The SFTP directory.                                                                               |

Given below is a sample configuration.

```toml
[sftp_configuration]
enabled = "true"
host = "sftp.example.com"
port = "22"
username = "user"
password = "password"
directory = "diagnostics"
```

### Log4j2 Configurations

The `log4j2.properties` file can be used to configure the logging level of the tool. The default log level is set to INFO. The `log4j2.properties` file can be found in the `conf` directory.

## Analysing Runtime Issues with the WSO2 Runtime Diagnostic Tool

### Data

The zip files are generated in the `<WSO2_HOME>/diagnostics-tool/data` directory. The zip file is named as `<processId>-<timestamp>.zip`. The zip file contains the following files:

- **deployment.toml**: The `deployment.toml` file of the server which contains the configurations.
- **diagnostics.log**: The log file of the diagnostics tool which contains logs related to traffic pattern to the server. The logs are explained in the [Diagnostics Log](#diagnostics-log) section.
- **log.txt**: The log line that triggered the Action Executors.
- **logs.zip**: The log directory of the server in zip format. This may contain the heap dump file if it is generated.
- **lsof-output.txt** [Optional]: The output of the lsof command which contains the open files by the server process during the error time.
- **netstat-output.txt** [Optional]: The output of the netstat command which contains the network statistics of the server during the error time.
- **server-info.txt**: The server information such as name, version etc.
- **thread-dump-<no>-<timestamp>.txt**: The thread dump of the server taken during different time intervals during the error time.
- **metrics-snapshot.txt**: The current snapshot of the Passthrough transport metrics in synapse runtime.

### Diagnostics Log

The diagnostics log contains the following logs:

#### Memory Watcher
The memory watcher logs are prefixed with `[MemoryWatcher]`.

For example: `MemoryWatcher Heap usage is above threshold. Heap usage: 87, Retry count: " + count`.

Here, the log indicates that the heap usage is above the threshold and the heap usage is 87%. The MemoryWatcher retries a couple of times before executing the Action Executors.

#### CPU Watcher
The CPU watcher logs are prefixed with `[CPUWatcher]`.

For example: `CPUWatcher CPU usage is above threshold. CPU usage: 91, Retry count: " + count`.

Here, the log indicates that the CPU usage is above the threshold and the CPU usage is 91%. The CPUWatcher retries a couple of times before executing the Action Executors.

#### Traffic Analyzer
The traffic analyzer logs are prefixed with `[TrafficAnalyzer]`.

For example: `TrafficAnalyzer Attribute Last15SecondRequests of type http-listener increased more than the threshold, old value: 2, new value: 227, threshold: 115.22752880979914`.

Here, the log indicates that the Last15SecondRequests attribute of type http-listener increased more than the threshold. The old value is 2, the new value is 227 and the threshold is 115.22752880979914. The threshold is calculated based on the standard deviation of a Simple Moving Average window.

#### Log Watcher

Following are examples of log watcher logs:

```
[Interpreter] Executing the action executors for the log line matching the regex pattern (.*)org.apache.synapse.transport.passthru(.*)
ServerInfo [INFO] ServerInfo executed successfully.
OpenFileFinder [INFO] OpenFileFinder executed successfully.
Netstat [INFO] Netstat executed successfully
ZipFileExecutor [INFO] Zipping the folder at /Users/user/wso2am-4.3.0/diagnostics-tool/temp/2024-03-01_14:21:06.743
ZipFileExecutor [INFO] Diagnosis Dumped in :/Users/user/wso2am-4.3.0/diagnostics-tool/data/96970_2024-03-01_14:21:06.743.zip
ThreadDumper [INFO] Thread dump execution is completed for 96970, thread dump count: 5, delay: 2000ms
MetricsSnapshot [INFO] MetricsSnapshot executed successfully.
ZipFileExecutor [INFO] Zipping the folder at /Users/user/wso2am-4.3.0/diagnostics-tool/temp/2024-03-01_14:21:06.838
ZipFileExecutor [INFO] Diagnosis Dumped in :/Users/user/wso2am-4.3.0/diagnostics-tool/data/96970_2024-03-01_14:21:06.838.zip
```

Here, the log indicates that the log line matching the regex pattern `(.*)org.apache.synapse.transport.passthru(.*)` is found. The `ServerInfo`, `OpenFileFinder`, `Netstat`, `MetricsSnapshot`, and `ThreadDumper` Action Executors are executed. The executors are executed in parallel and the zip file is generated with the output at the end.
