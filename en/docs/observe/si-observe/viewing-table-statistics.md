# Viewing Table Statistics

![Table statistics dashboard]({{base_path}}/assets/img/streaming/streaming-integrator-grafana-dashboard/table_statistics_dashboard.png)

This dashboard displays the following information for your Streaming Integrator deployment:

## Table Statistics Summary Table

![Table Statistics Summary]({{base_path}}/assets/img/streaming/table-statistics/table-statistics-summary.png)

This lists all the table operations defined in all the Siddhi applications in your Streaming Integrator server. The table displays the following for each operation:

!!! info
    When multiple operations are performed on the same table, each operation appears as a separate entry.
   
   - The Siddhi application in which the table is included
   
   - The name of the table
   
   - The operation that was performed on the table
   
   - Latency of events in the table
   
   - The throughput of events to/from the table
   
## Latency

![Table Latency]({{base_path}}/assets/img/streaming/table-statistics/table-latency.png)

This shows the latency of each table operation in your Streaming Integrator server.

## Throughput

![Table Throughput]({{base_path}}/assets/img/streaming/table-statistics/table-throughput.png)

This shows the throughput of each table operation in your Streaming Integrator server.