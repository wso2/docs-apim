# Prometheus Metric Support

With the integration of Prometheus metrics, monitoring the performance and health of Choreo Connect router, adapter, and enforcer components has never been easier. This enhanced observability empowers users to proactively identify and address issues for smoother operations.

!!! attention "Update Level 2"
    This feature is available only as an update, after Update level 1.2.0.2 (released on 13 September 2023) and further. For more information regarding Choreo Connect updates, see [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/update-choreo-connect/).

## Configure Prometheus Metrics

### Adapter
 
1. Add the following configuration. Replace `ADAPTER_METRIC_PORT` with the desired port value to expose metrics to the Prometheus server.

    === "Configuration"
        ```toml
        [adapter.metrics]
            enabled = true
            type = "prometheus"
            port = ADAPTER_METRIC_PORT
        ```

1. Expose the `ADAPTER_METRIC_PORT` to Prometheus and metrics will be available at `:ADAPTER_METRIC_PORT/metrics`.


### Enforcer
1. Create and mount `prometheus-jmx-config.yml` file with following content to enforcer `/home/wso2/conf/prometheus-jmx-config.yml`. For more configuration options click [here](https://github.com/prometheus/jmx_exporter/blob/main/README.md).

    === "Prometheus JMX Config"
        ``` yaml
        lowercaseOutputName: true
        lowercaseOutputLabelNames: true
        rules:
            # WSO2 Choreo Connect related metrics
        - pattern: 'org.wso2.choreo.connect.enforcer<type=ExtAuthMetrics><>total_request_count: (.*)'
            name: org_wso2_choreo_connect_enforcer_request_count_total
            help: "WSO2 choreo connect enforcer total request count."
            attrNameSnakeCase: true
            type: COUNTER
        - pattern: 'org.wso2.choreo.connect.enforcer<type=ExtAuthMetrics><>(average_response_time_millis|max_response_time_millis|min_response_time_millis|request_count_in_last_five_minute_window|request_count_window_start_time_millis): (.*)'
            name: org_wso2_choreo_connect_enforcer_$1
            help: "WSO2 choreo connect enforcer $1."
            attrNameSnakeCase: true
            type: GAUGE
        - pattern: 'org.wso2.choreo.connect.enforcer<type=ThreadPoolConfig><>(\w+): (.*)'
            name: org_wso2_choreo_connect_enforcer_thread_pool_$1
            help: "WSO2 choreo connect enforcer thread pool $1."
            attrNameSnakeCase: true
            type: GAUGE
            # OS related metrics
        - pattern: 'java.lang<type=OperatingSystem><>(\w+): (.*)'
            name: os_$1
            help: Operating System $1
            attrNameSnakeCase: true
            type: GAUGE
        ```

1. Update `JAVA_AGENT` environment variable.

    === "JAVA_AGENT"
        ```toml
        JAVA_AGENT_OPTS=${JAVA_AGENT_OPTS} -Dchoreo.connect.jmx.metrics.enabled=true -javaagent:/home/wso2/lib jmx_prometheus_javaagent-0.18.0.jar=ENFORCER_METRIC_PORT:/home/wso2/conf/prometheus-jmx-config.yml
        ```

1. Expose `ENFORCER_METRIC_PORT` and metrics will be available at `:ENFORCER_METRIC_PORT/metrics`.
   

### Router
1. No special configuration is required as metrics are by default accessible via the router admin port at `stats/prometheus` endpoint.

    !!! note
        Adhere to strict security guidelines to guarantee that only the Prometheus server can access the router's admin port in production.

## Configuring Prometheus Server

1. Incorporate the following job configurations into `prometheus.yml`.
2. Substitute `ROUTER_ADMIN_PORT`,`ENFORCER_METRIC_PORT` and `ADAPTER_METRIC_PORT` with their respective values. 
3. Replace `HOST` with the appropriate host address or addresses.

    === "On Docker"
        ```yaml
        scrape_configs:
        - .....
        - job_name: 'router'
            metrics_path: /stats/prometheus
            static_configs:
            - targets: ['HOST:ROUTER_ADMIN_PORT']
        
        - job_name: 'enforcer'
            static_configs:
            - targets: ['HOST:ENFORCER_METRIC_PORT']

        - job_name: 'adapter'
            static_configs:
            - targets: ['HOST:ADAPTER_METRIC_PORT']
        ```
    
    === "On K8s"
        ```yaml
        scrape_configs:
        - job_name: 'adapter'
            # Use Kubernetes service discovery to find pods
            kubernetes_sd_configs:
            - role: pod

            # Define relabeling configurations for this job
            relabel_configs:
            # Keep pods with container names matching 'choreo-connect-adapter'
            - source_labels: [__meta_kubernetes_pod_container_name]
                action: keep
                regex: choreo-connect-adapter

            # Keep pods with container ports matching 'ADAPTER_METRIC_PORT'
            - source_labels: [__meta_kubernetes_pod_container_port_number]
                regex: '<ADAPTER_METRIC_PORT>' # Replace
                action: keep

            # Set the target label 'job' to 'adapter', several pods can be under 'adapter' job
            - target_label: job
                replacement: adapter

            # Set the target label '__metrics_path__' to path on which metrics are exposed
            - target_label: __metrics_path__
                replacement: /metrics

            # Extract instance information from container ID and port number, different pods of adapter will have different instance names
            - source_labels: [__meta_kubernetes_pod_container_id, __meta_kubernetes_pod_container_port_number]
                regex: '.*://(.+?)/(.+)'
                replacement: '$1/$2'
                target_label: instance
        - ...
        ```

    !!! note
        Configure the prometheus server with proper level of permission on K8s/Docker.



## Using Choreo Connect Grafana Dashboards

1. Download the dashboard json files from [here]({{base_path}}/assets/attachments/cc-grafana-dashboards/choreo-connect-grafana-dashboard-json.zip).
2. Import the dashboards to Grafana.
3. Change Prometheus job name and other dashboard variables as required.

    !!! note
        Image previews of the dashboards are available [here]({{base_path}}/assets/attachments/cc-grafana-dashboards/choreo-connect-grafana-dashboard-images.zip).

## Exposed Metrics


### Adapter Metrics

| Prometheus Metric                           | Description                                                                                                       |
|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| go_info                                    | Metadata about the Go runtime version and environment.                                                            |
| process_start_time_seconds                  | Timestamp when the process started, in seconds since the epoch.                                                    |
| os_available_cpu_total                      | The number of CPUs available to the operating system                                                              |
| os_free_physical_memory_bytes               | The amount of free physical memory in bytes                                                                       |
| os_total_virtual_memory_bytes               | Amount of total virtual memory in bytes.                                                                          |
| os_used_virtual_memory_bytes                | Amount of used virtual memory in bytes.                                                                           |
| os_system_load_average                      | Represents the average number of processes in the system's execution queue over the last minute/5 minutes/15 minutes|
| os_system_cpu_load_percentage               | The percentage of CPU usage by the entire system                                                                  |
| go_memstats_sys_bytes                       | Total memory obtained from the OS by the Go runtime                                                               |
| go_memstats_mspan_inuse_bytes               | Memory used by mspan structures                                                                                   |
| go_memstats_mspan_sys_bytes                 | Memory obtained from the OS for mspan structures                                                                  |
| go_memstats_mcache_inuse_bytes              | Memory used by mcache structures                                                                                  |
| go_memstats_mcache_sys_bytes                | Memory obtained from the OS for mcache structures                                                                 |
| go_memstats_buck_hash_sys_bytes             | Memory used by profiling bucket hash table                                                                        |
| go_memstats_gc_sys_bytes                    | Memory used for garbage collection system metadata                                                                |
| go_memstats_other_sys_bytes                 | Memory used for other system allocations                                                                          |
| go_memstats_heap_alloc_bytes                | Bytes allocated and still in use.                                                                                 |
| go_memstats_heap_sys_bytes                  | Total bytes obtained from the OS for the heap                                                                     |
| go_memstats_heap_idle_bytes                 | Bytes in the heap that are idle                                                                                   |
| go_memstats_heap_inuse_bytes                | Bytes in the heap that are in use                                                                                 |
| go_memstats_heap_released_bytes             | Bytes released to the OS                                                                                          |
| go_memstats_stack_inuse_bytes               | Bytes used by the stack                                                                                           |
| go_memstats_stack_sys_bytes                 | Total bytes obtained from the OS for stack                                                                        |
| go_memstats_alloc_bytes_total               | Total bytes allocated, even if freed                                                                              |
| go_memstats_mallocs_total                   | Total number of allocations                                                                                       |
| go_memstats_frees_total                     | Total number of deallocations                                                                                     |
| go_goroutines                               | Number of currently running goroutines                                                                            |
| go_gc_duration_seconds                      | Duration of the last garbage collection in seconds                                                                |
| process_open_fds                            | Number of open file descriptors by the process                                                                    |

### Enforcer Metrics

| Prometheus Metric                                                       | Description                                                                                                       |
|------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| jvm_info                                                               | Metadata about the JVM, such as version and vendor                                                               |
| process_start_time_seconds                                              | Timestamp when the JVM process started, in seconds since the epoch                                                |
| os_available_processors                                                | Number of available processors the JVM can use                                                                    |
| os_free_physical_memory_size                                           | Amount of free physical memory in bytes                                                                           |
| os_committed_virtual_memory_size                                       | Amount of virtual memory that is guaranteed to be available to the running process                                |
| os_total_physical_memory_size                                          | Total amount of physical memory available on the system                                                           |
| os_system_load_average                                                 | Represents the average number of processes in the system's execution queue over the last minute                   |
| os_system_cpu_load                                                     | Percentage of CPU usage by the entire system                                                                      |
| os_process_cpu_load                                                    | Percentage of CPU usage by the JVM process                                                                        |
| jvm_memory_bytes_used                                                  | Amount of used memory in the JVM heap/non-heap areas, in bytes                                                    |
| jvm_memory_bytes_committed                                             | Amount of memory committed for the JVM heap/non-heap areas, in bytes                                              |
| jvm_threads_current                                                    | Current number of live threads in the JVM                                                                         |
| jvm_threads_daemon                                                     | Number of live daemon threads in the JVM                                                                          |
| jvm_threads_deadlocked                                                 | Number of threads that are currently deadlocked in the JVM                                                        |
| jvm_classes_currently_loaded                                           | Number of classes currently loaded in the JVM                                                                     |
| process_open_fds                                                       | Number of open file descriptors by the JVM process.                                                               |
| jvm_gc_collection_seconds_sum                                          | Total time spent in garbage collection, in seconds                                                                |
| jvm_memory_pool_bytes_used                                             | Amount of used memory from various memory pools in the JVM, in bytes                                              |
| jvm_memory_pool_bytes_committed                                        | Amount of memory committed for various memory pools in the JVM, in bytes.                                         |
| org_wso2_choreo_connect_enforcer_average_response_time_millis          | Average response time of the enforcer in milliseconds                                                             |
| org_wso2_choreo_connect_enforcer_request_count_total                   | Total number of requests processed by the enforcer                                                                |
| org_wso2_choreo_connect_enforcer_request_count_in_last_five_minute_window | Number of requests the enforcer processed in the last five minute window                                          |
| org_wso2_choreo_connect_enforcer_request_count_window_start_time_millis | Start time of the current 5 minute window                                                                         |
| org_wso2_choreo_connect_enforcer_max_response_time_millis              | Longest response time recorded by the enforcer in milliseconds                                                    |
| org_wso2_choreo_connect_enforcer_min_response_time_millis              | Shortest response time recorded by the enforcer in milliseconds                                                   |
| org_wso2_choreo_connect_enforcer_thread_pool_core_size                 | Base number of threads in the enforcer's thread pool                                                              |
| org_wso2_choreo_connect_enforcer_thread_pool_max_size                  | Maximum number of threads allowed in the enforcer's thread pool                                                   |
| org_wso2_choreo_connect_enforcer_thread_pool_queue_size                | Capacity of the enforcer's thread pool queue                                                                      |
| org_wso2_choreo_connect_enforcer_thread_pool_keep_alive_time           | Time a thread can be idle before being terminated in the enforcer's thread pool                                   |


### Router Metrics

| Prometheus Metric                           | Description                                                                                                       |
|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| envoy_server_uptime                        | Duration the Envoy server has been running                                                                        |
| envoy_cluster_membership_healthy           | Number of healthy members in the cluster                                                                          |
| envoy_cluster_membership_total             | Total number of members in the cluster                                                                            |
| envoy_server_memory_allocated              | Memory allocated by the Envoy server                                                                              |
| envoy_server_memory_heap_size              | Total heap size of the Envoy server                                                                               |
| envoy_http_downstream_rq_total             | Number of total downstream requests                                                                               |
| envoy_http_downstream_cx_total             | Number of total downstream connections                                                                            |
| envoy_http_downstream_rq_time_bucket       | Histogram of downstream request times                                                                             |
| envoy_http_downstream_cx_active            | Number of active downstream connections                                                                           |
| envoy_cluster_upstream_rq_total            | Total upstream requests to the cluster                                                                            |
| envoy_cluster_upstream_cx_total            | Total upstream connections to the cluster                                                                         |
| envoy_cluster_upstream_rq_time_bucket      | Histogram of upstream request times                                                                               |
| envoy_cluster_upstream_cx_total            | Total upstream connections                                                                                       |
| envoy_cluster_upstream_cx_active           | Number of active upstream connections                                                                             |
| envoy_cluster_upstream_rq_xx               | Count of upstream requests by HTTP status code class (2xx,3xx,4xx,5xx)                                            |
