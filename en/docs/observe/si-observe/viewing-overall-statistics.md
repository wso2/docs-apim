# Viewing Overall Statistics

This dashboard displays the overall Siddhi statistics of the Siddhi applications currently deployed in your WSO2 Streaming Integrator instance.

There are nine other dashboards linked to the Siddhi overall statistics dashboard which represent the Siddhi components and their statistics. The Siddhi Grafana Dashboard represents the memory, latency and throughput statistics for the Siddhi components as follows.

<table>
<thead>
<tr class="header">
<th>No.</th>
<th>Element</th>
<th>Memory</th>
<th>Latency</th>
<th>Throughput</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>               01              </td>
<td>               Stream              </td>
<td>               -              </td>
<td>               -              </td>
<td>               ✔️              </td>
</tr>
<tr class="even">
<td>               02              </td>
<td>               Query              </td>
<td>               ✔️              </td>
<td>               ✔️              </td>
<td>               -              </td>
</tr>
<tr class="odd">
<td>               03              </td>
<td>               Source              </td>
<td>               -              </td>
<td>               -              </td>
<td>               ✔️              </td>
</tr>
<tr class="even">
<td>               04              </td>
<td>               Sink              </td>
<td>               -              </td>
<td>               -              </td>
<td>               ✔️              </td>
</tr>
<tr class="odd">
<td>               05              </td>
<td>               Source Mapper              </td>
<td>               -              </td>
<td>               ✔️              </td>
<td>               -              </td>
</tr>
<tr class="even">
<td>               06              </td>
<td>               Sink Mapper              </td>
<td>               -              </td>
<td>               ✔️              </td>
<td>               -              </td>
</tr>
<tr class="odd">
<td>               07              </td>
<td>               Table              </td>
<td>               -              </td>
<td>               ✔️              </td>
<td>               ✔️              </td>
</tr>
<tr class="even">
<td>               08              </td>
<td>               Window              </td>
<td>               ✔️              </td>
<td>               ✔️              </td>
<td>               ✔️              </td>
</tr>
<tr class="odd">
<td>               09              </td>
<td>               Aggregation              </td>
<td>               ✔️              </td>
<td>               ✔️              </td>
<td>               ✔️              </td>
</tr>
<tr class="even">
<td>               10              </td>
<td>               Trigger              </td>
<td>               -              </td>
<td>               -              </td>
<td>               ✔️              </td>
</tr>
<tr class="odd">
<td>               11              </td>
<td>               On-Demand Query              </td>
<td>               -              </td>
<td>               ✔️              </td>
<td>               -              </td>
</tr>
</tbody>
</table>
 
The following information is displayed in this dashboard.
 
## Servers Up/Down
 
 ![Servers up/down]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/active_servers_graph.png)
 
 This indicates the number of active servers against time. When a new server is started, it is indicated by a vertical line. You can move the cursor over this vertical line to check the host and port at which the new active server is running.
 
 This also provides a link to the **Siddhi Server Statistics** dashboard to [view server statistics]({{base_path}}/observe/si-observe/viewing-server-statistics).
 
**Purpose**
 
 This allows you to identify the following:
 
 - The times at which a specific server started and stopped.
 
 - The duration of time for which a specific server was active.
 
 - The number of servers that were active at a specific time.
 
!!! tip "Recommended action"
    Check the throughput, system load average, memory usage, CPU usage etc., for the time periods during which a specific server/combination of servers was active in order to evaluate server performance.
 
## Siddhi App Count
 
 ![Siddhi app count]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/siddhi_app_count.png)
 
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
 
 This shows the overall throughput of your current Streaming Integrator deployment. 
 
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
 
 This shows the memory usage of your current Streaming Integrator deployment and to identify scenarios where you may need to make changes to the memory allocation.
  
**Purpose**

To monitor the memory usage of your Streaming Integrator deployment and allocate more memory when needed.
 
!!! tip "Recommended action"
    If there is a spike in the memory usage, you can identify whether you need to allocate more memory resources to your deployment or redeploy some of the Siddhi elements with high throughputs to a different Streaming Integrator deployment. <br/><br/> Similarly, if there is a fall in the memory usage, you can determine whether some of the memory resources can be removed from the WSO2 Streaming Integrator deployment.
 
## Thread Count

![Thread Count]({{base_path}}/assets/img/streaming/viewing-overall-statistics/thread-count.png)

This shows the number of JVM (Java Virtual Machine) threads that are currently active.

**Purpose**

You can use these statistics to profile your JVM.

## Threads Blocked

![Threads Blocked]({{base_path}}/assets/img/streaming/viewing-overall-statistics/blocked-threads.png)

This shows the number of JVM threads that are currently blocked.

**Purpose**

You can use these statistics to profile your JVM.

## Memory Heap Used

![Memory Heap Used]({{base_path}}/assets/img/streaming/viewing-overall-statistics/memory-heap-used.png)

This shows the JVM memory heap that is currently consumed by your Streaming Integrator deployment.

**Purpose**

You can evaluate the performance of your Streaming Integrator servers based on the memory heap usage.


## File Descriptors Open

The number of JVM file descriptors that are currently open.

![File Descriptors Open]({{base_path}}/assets/img/streaming/viewing-overall-statistics/file-descriptors.png)

## Stream Statistics

![Stream Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/stream-statistics.png)

This indicates the following:

- The complete list of streams in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The throughput of each stream listed.

- The total stream count.

The **Stream Statistics** widget also provides a link to open the **Siddhi Stream Statistics** dashboard where you can [view stream statistics]({{base_path}}/observe/si-observe/viewing-stream-statistics).

**Purpose**

This allows you to monitor each stream in your Streaming Integrator deployment and identify the streams that generate a lot of activity.

!!! tip "Recommended action"
    Filter stream statistics for each Siddhi application to identify active Siddhi applications. You can also identify streams that are duplicated in different Siddhi applications and merge such Siddhi applications if possible to reduce system overhead.

## Query Statistics

![Query Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/query-statistics.png)

This indicates the following:

- The complete list of queries in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The latency of each query listed.

- The total query count.

The **Query Statistics** widget also provides a link to the **Siddhi Query Statistics** dashboard where you can [view query statistics]({{base_path}}/observe/si-observe/viewing-query-statistics).

**Purpose**

This allows you to monitor each query in your WSO2 Streaming Integrator deployment and identify the main queries to be reviewed in order to reduce the overall latency.

!!! tip "Recommended action"
    Identify queries with high latency and review them to use the Siddhi logic in a more efficient manner. You can also identify queries that are duplicated in different Siddhi applications and merge such Siddhi applications if possible to reduce system overhead

## Source and Source Mapper Statistics

![Source and Source Mapper Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/source-statistics.png)

This indicates the following:

- The complete list of sources in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The throughput of each source listed.

- The total source count in all the Siddhi applications you have selected to monitor.

The **Source and Source Mapper Statistics** widget also provides a link to the **Siddhi Source Statistics** dashboard where you can [view source statistics]({{base_path}}/observe/si-observe/viewing-source-statistics).

**Purpose**

To observe the performance of each source in terms of throughput and latency, and understand its impact on the overall performance of your Siddhi application deployment.

!!! tip "Recommended action"
    - Identify sources with high latency and take corrective action to reduce the latency (e.g., if it is a Kafka source, check whether the Kafka server is functioning properly).<br/><br/> 
    - Observe the throughput of each source and allocate resources in an optimum manner. e.g., If an HTTP source receives a high volume of events, make sure that sufficient memory and CPU resources are allocated to the relevant server.

## Sink Statistics

![Sink Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/sink-statistics.png)

This indicates the following:

- The complete list of sinks in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The throughput of each sink listed.

- The total sink count in all the Siddhi applications you have selected to monitor.

The **Sink Statistics** widget also provides a link to the **Siddhi Sink Statistics** dashboard where you can [view sink statistics]({{base_path}}/observe/si-observe/viewing-sink-statistics).

**Purpose**

To monitor the amount of data published by your WSO2 Streaming Integrator deployment to different destinations, brokers, files, databases and cloud storages.

!!! tip "Recommended action"
    - Optimize the allocation of resources based on the throughput of each sink. e.g., If a high volume of output events saved in files via file sinks, allocate sufficient memory in the CPU where the files are saved.<br/><br/>
    - If a sink has a high latency at specific time intervals, identify the possible reason (e.g., server unavailability during specific times). If the latency of a sink is consistently low, optimize the resource allocation (e.g., allocate more CPU cores to the relevant server).

## Table Statistics

![Table Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/table-statistics.png)

This indicates the following:

- The complete list of tables in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The throughput of each table listed.

- The total table count in all the Siddhi applications you have selected to monitor.

The **Table Statistics** widget also provides a link to the **Siddhi Table Statistics** dashboard where you can [view table statistics]({{base_path}}/observe/si-observe/viewing-table-statistics).

**Purpose**

To monitor the tables defined in your WSO2 Streaming Integrator deployment and assessing the extent to which each table is used.

!!! tip "Recommended action"
    - Ensure that system resources are allocated in an optimum manner. e.g., Allocate more memory to servers in which the databases with tables that have a high throughput are run.<br/><br/>
    - When tables have a high throughput, take action to secure them better to ensure that the data is protected.

## Window Statistics

![Window Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/window-statistics.png)

This indicates the following:

- The complete list of windows in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The throughput of each window listed.

- The total window count in all the Siddhi applications you have selected to monitor.

The **Window Statistics** widget also provides a link to the **Siddhi Window Statistics** dashboard where you can [view window statistics]({{base_path}}/observe/si-observe/viewing-window-statistics).

**Purpose**

To monitor the windows defined in your WSO2 Streaming Integrator deployment and assessing the extent to which each window is used.


## Aggregation Statistics

![Aggregation Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/aggregation-statistics.png)

This indicates the following:

- The complete list of aggregations in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The throughput of each aggregation listed.

- The total aggregation count in all the Siddhi applications you have selected to monitor.

The **Aggregation Statistics** widget also provides a link to the **Siddhi Aggregation Statistics** dashboard where you can [view aggregation statistics]({{base_path}}/observe/si-observe/viewing-aggregation-statistics).

**Purpose**

To monitor the aggregations defined in your WSO2 Streaming Integrator deployment and assessing the extent to which each aggregation is used.


## Trigger Statistics

![Trigger Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/trigger-statistics.png)

This indicates the following:

- The complete list of triggers in all the Siddhi applications that you are monitoring in your Streaming Integrator deployment.

- The throughput of each trigger listed.

- The total trigger count in all the Siddhi applications you have selected to monitor.

The **Trigger Statistics** widget also provides a link to the **Siddhi Trigger Statistics** dashboard where you can [view trigger statistics]({{base_path}}/observe/si-observe/viewing-trigger-statistics).

**Purpose**

To monitor the triggers defined in your WSO2 Streaming Integrator deployment and assessing the extent to which each trigger is used.


## On Demand Query Statistics

![On Demand Query Statistics]({{base_path}}/assets/img/streaming/viewing-overall-statistics/on-demand-query-statistics.png)

This indicates the following:

- The complete list of on demand queries you have carried out via REST API for the Siddhi applications you have selected to monitor.

- The throughput of each on-demand query listed.

- The total on-demand query count.

The **On-Demand Query Statistics** widget also provides a link to the **Siddhi On-Demand Query Statistics** dashboard where you can [view on-demand query statistics]({{base_path}}/observe/si-observe/viewing-on-demand-query-statistics).

**Purpose**

To monitor the on-demand queries defined in your WSO2 Streaming Integrator deployment and assessing the extent to which each on-demand query is used.
