# Viewing Server Statistics

Siddhi Server Statistics Dashboard represents a detailed view of the active server instances. It also includes the JVM metrics related to the active servers.

The information displayed is as follows.

![Servers up/down]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/active_servers_graph.png)

 This indicates the number of active servers against time. When a new server is started, it is indicated by a vertical line. You can move the cursor over this vertical line to check the host and port at which the new active server is running.

**Purpose**
 
 This allows you to identify the following:
 
 - The times at which a specific server started and stopped.
 
 - The duration of time for which a specific server was active.
 
 - The number of servers that were active at a specific time.
 
!!! tip "Recommended action"
    Check the throughput, system load average, memory usage, CPU usage etc., for the time periods during which a specific server/combination of servers was active in order to evaluate server performance.

## Siddhi App Count

![Siddhi app count]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/siddhi_app_count.png)

 This indicates the number of active servers against time. When a new server is started, it is indicated by a vertical line. You can move the cursor over this vertical line to check the host and port at which the new active server is running.

 This indicates the total number of Siddhi applications deployed in the currently active servers.
 
**Purpose**

This allows you to get an overall understanding of the level of activity carried out by the currently active servers.

!!! tip "Recommended action"
    If the Siddhi application count is relatively high, you can check the throughput for each Siddhi application to identify the Siddhi applications that you can remove from your Streaming Integrator deployment to reduce the system overhead. To do this, you can filter statistics for each individual Siddhi application in the following dashboards:<br/><br/>
    - [Siddhi Stream Statistics]({{base_path}}/observe/si-observe/viewing-stream-statistics)<br/>
    - [Siddhi Source Statistics]({{base_path}}/observe/si-observe/viewing-source-statistics)<br/>
    - [Siddhi Sink Statistics]({{base_path}}/observe/si-observe/viewing-sink-statistics)<br/>
    - [Siddhi Query Statistics]({{base_path}}/observe/si-observe/viewing-query-statistics)<br/>
    - [Siddhi Window Statistics]({{base_path}}/observe/si-observe/viewing-window-statistics)<br/>
    - [Siddhi Trigger Statistics]({{base_path}}/observe/si-observe/viewing-trigger-statistics)<br/>
    - [Siddhi Table Statistics]({{base_path}}/observe/si-observe/viewing-table-statistics)<br/>
    - [Siddhi Aggregation Statistics]({{base_path}}/observe/si-observe/viewing-aggregation-statistics)<br/>
    - [Siddhi On Demand Query Statistics]({{base_path}}/observe/si-observe/viewing-on-demand-query-statistics)

## Server Statistics Summary Table

![Server statistics summary]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/server_statistics_summary.png)

 This lists the currently active Streaming Integrator servers and displays the following for each server:
  - The total events received by the server
  - The system load average
  - The total memory used by each server.

**Purpose**

To evaluate the performance of each server as follows:

- By analysing the efficiency of the server by comparing its events received with the overhead it incurs in terms of the system load average and the memory used.
- By comparing the events received, system load average and the memory usage of each server with that of other servers.

!!! tip "Recommended action"
    Once you analyze the performance of each server, you can make changes to your Streaming Integrator deployment to use server resources in a more optimum manner (e.g., by removing low performing servers, adding better performing servers, etc.)
 
## Overall Throughput

![Overall throughput]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/overall_throughput_graph.png)

 This shows the overall throughput of all the servers in your current Streaming Integrator deployment. 

**Purpose**

To monitor the overall throughput and evaluate it against other statistics such as the system load average, memory used, the number of Siddhi applications deployed in the system etc.
 
!!! tip "Recommended action"
    Determine whether the overall throughput of your Streaming Integrator server is sufficient based on the system resources allocated, and identify ways in which you can improve it (e.g., reducing Siddhi elements that are deployed, but do not generate a sufficient throughput, making adjustments to the system resources allocated. etc.)
 
## System Load Average

![System load average]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/system_load_average_graph.png)

 This shows the average system load of your current Streaming Integrator deployment.
 
**Purpose**

To monitor the system load average and compare it with other statistics such as the overall throughput, memory used, the number of Siddhi applications deployed in the system etc. and take appropriate measures to reduce it if it is too high, and to optimize the system better if it is relatively low.
 
!!! tip "Recommended action"
    If the system load average is too high, you can take appropriate measures to reduce it (by adding more system resources or by identifying Siddhi applications/elements generating a low throughput that you can remove). If the system load average is too low, you can find ways to optimise it (e.g., reducing the system resources allocated, etc.)
 
## CPU Usage

![CPU usage]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/cpu_usage_graph.png)

  This shows the CPU usage of your current Streaming Integrator deployment.
  
**Purpose**

To monitor the CPU usage of your current Streaming Integrator deployment and to identify scenarios where you may need to make changes to the CPU resource allocation.

!!! tip "Recommended action"
    If there is a spike in the CPU usage, you can identify whether you need to allocate more CPU resources to your deployment or redeploy some of the Siddhi elements with high throughputs to a different Streaming Integrator deployment. <br/><br/> Similarly, if there is a fall in the CPU usage, you can determine whether some of the CPU resources can be removed from the WSO2 Streaming Integrator deployment.
 
## Memory Usage

![Memory usage]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/memory_usage_graph.png)

 This shows the memory usage of your current Streaming Integrator deployment.

**Purpose**

To monitor the memory usage of your Streaming Integrator deployment and allocate more memory when needed.
 
!!! tip "Recommended action"
    If there is a spike in the memory usage, you can identify whether you need to allocate more memory resources to your deployment or redeploy some of the Siddhi elements with high throughputs to a different Streaming Integrator deployment. <br/><br/> Similarly, if there is a fall in the memory usage, you can determine whether some of the memory resources can be removed from the WSO2 Streaming Integrator deployment.
 

## JVM Physical Memory

![JVM physical memory]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/jvm_physical_memory_usage.png)

The amount of JVM physical memory consumed by your WSO2 Streaming Integrator deployment over time.

**Purpose**

You can use these statistics to profile your JVM.

## JVM Threads

![JVM threads]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/jvm_threads.png)

This shows the number of JVM threads that are currently active.

**Purpose**

You can use these statistics to profile your JVM.

## JVM Class Load

![JVM class load]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/jvm_class_load.png)

**Purpose**

You can use these statistics to profile your JVM.