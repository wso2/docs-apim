# Viewing ETL Flow Statistics

!!! note "Before you begin:"
    - Follow the instructions in the [getting started guide]({{base_path}}/observe/streaming-integrator/setting-up-si-statistics-dashboards) to enable the WSO2 Streaming Integrator to publish statistics in the Grafana dashboard.
    - [Organize the dashboards in folders]({{base_path}}/observe/streaming-integrator/managing-dashboards).

Follow the instructions below to navigate through the Grafana dashboards, which you set up for monitoring the ETL flows in WSO2 Streaming Integrator and to analyze statistics:

1. In the left pane, click the **Dashboards** icon, and then click **Manage** to open the **Dashboards** page.

2. Click **WSO2 Streaming Integrator Overall Statistics** in the **Dashboards** page.

     [![Open Overall Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/open-overall-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/open-overall-statistics-dashboard.png)
    
     The overall statistics are displayed as shown in the following example.
    
     [![Overall Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/overall-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/overall-statistics.png)
    
     This provides an overview of the overall performance of the WSO2 Streaming Integrator instance by displaying the total number of input events consumed and the total number of output events. It also provides the breakdown of the total inputs and outputs by Siddhi application. The **(Consume/Publish)/Sec** graph indicates the rate at which the consumed input events are published per second.
    
3. To view the statistics specific to a Siddhi application, click on the relevant Siddhi application.
 
     [![Select Siddhi Application]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-siddhi-applocation.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-siddhi-applocation.png)
    
     The **WSO2 Streaming Integrator App Statistics** dashboard opens. This allows you to access any statistics relating to change data capture, file processing and data store integration activities carried out via the selected Siddhi application.
    
     [![Application Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/siddhi-application-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/siddhi-application-statistics.png)
    
## Viewing CDC statistics
    
The CDC related statistics are displayed in the **Sources** section of the **WSO2 Streaming Integrator App Statistics** dashboard. To view the detailed statistics for a specific table, click on that table.

As a result, the **CDC Statistics** dashboard opens with change data statistics specific to that table.

[![CDC Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-statistics.png)

If you click on a table for which change data is captured in a streaming manner (i.e., a table in the **CDC Streaming Statistics** section), the **CDC Streaming Statistics** dashboard opens with change data related statistics specific to the selected table, as shown in the example below.

[![CDC Streaming Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-streaming-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-streaming-statistics.png)

If you click on a table for which change data is captured in a scheduled manner by polling the table (i.e., a table in the **CDC Scheduled Statistics** section), the **CDC Scheduled Statistics** dashboard opens with change data related statistics specific to the selected table as shown in the example below.

[![CDC Scheduled Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-scheduled-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-scheduled-statistics.png)
    
## Viewing File statistics
    
- When the content of a file is used as input data, the file is displayed in the **Sources** section as shown in the example below.

  [![File Source Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/source-file-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/source-file-statistics.png)

 To view statistics for a specific file, click on it. As a result, the **WSO2 Streaming Integrator - File Statistics** dashboard opens as shown in the example below.
 
  [![File Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-statistics-dashboard.png)
  
 When you click on the same file again, the **WSO2 Streaming Integrator - File Source Statistics** dashboard opens with more detailed information about this source file as shown in the example below. 
 
  [![File Source Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-source-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-source-statistics-dashboard.png)               
  
- When the content of a file is generated as an output of the Siddhi application, the file is displayed in the **Destinations** section as shown in the example below.

  [![File Sink Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-sink-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-sink-statistics.png)

 To view statistics for a specific file, click on it. As a result, the **WSO2 Streaming Integrator - File Statistics** dashboard opens as shown in the example below.
         
 [![File Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-statistics-dashboard.png)

 When you click on the same file again, the **WSO2 Streaming Integrator - File Sink Statistics** dashboard opens with more detailed information about this sink file as shown in the example below. 
 
 [![File Sink Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-sink-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-sink-statistics-dashboard.png)
        
## Viewing RDBMS statistics
    
When the records of an RDBMS database are used as input data by the selected Siddhi application, the database is displayed in the **Sources** section. When any output generated by the selected Siddhi application is saved in a database, that database is displayed under **Destinations**.

In each section, all the databases of the relevant category is listed in a table as shown in the example below.

[![RDBMS Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/rdbms-statistics.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/rdbms-statistics.png)

To view detailed statistics of a specific database, click on that database.

[![Select RDBMS]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-rdbms.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-rdbms.png)

The **RDBMS Statistics** dashboard opens with RDBMS statistics specific to the selected database.

[![Database Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/database-statistics.jpg)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/database-statistics.jpg)

To view statistics relating to a specific table, click on the relevant table name in the **RDBMS Table** table.

[![Select RDBMS Table]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-rdbms-table.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-rdbms-table.png)

The **RDBMS Table Statistics** dashboard opens with statistics specific to the selected table.

[![RDBMS Table Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/rdbms-table-statistics.jpg)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/rdbms-table-statistics.jpg)
        
## Viewing Kafka statistics
    
Kafka related statistics are displayed in the **Sources** and **Destinations** sections of the **WSO2 Streaming Integrator App Statistics** dashboard. 

<!-- [![Kafka Sources Table]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-sources-table.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-sources-table.png)

[![Kafka Sinks Table]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-destinations-table.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-destinations-table.png) -->

To view the details on the overall Kafka Statistics for a specific app, click on any stream link on the table. As a result, the **WSO2 Streaming Integrator Kafka Statistics** dashboard appears.

<!-- [![Kafka Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-statistics-dashboard.png) -->

This page has two sections: **Source** and **Sink**. 

- The **Source** section shows the overall Kafka Source metrics such as total reads, input event rate etc. It also contains a table that lists all the streams that are associated with a Kafka source. If you click on a stream, it will take you to **WSO2 Streaming Integrator Kafka Source Statistics** dashboard.

      <!-- [![Kafka Source Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-source-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-source-statistics-dashboard.png) -->

      This dashboard shows the Kafka Source statistics related to the selected stream. A stream is associated with one or more topics. Furthermore, each topic is associated with a partition. You can use this dashboard to view statistics for each separate Topic-Partition combination to which the selected stream is subscribed.

- The **Sink** section shows the overall Kafka Sink metrics such as total writes, output event rate, etc. It also contains a table that lists all the streams that are associated with a Kafka source. If you click on a stream, it will take you to **WSO2 Streaming Integrator Kafka Sink Statistics** dashboard.

      <!-- [![Kafka Sink Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-sink-statistics-dashboard.png)]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-sink-statistics-dashboard.png) -->

      This dashboard shows the Kafka Sink statistics related to the selected stream. Here, a stream publishes to a specific Kafka Topic and to one or more partitions. You can use this dashboard to view statistics for each separate Topic-Partition combination to which the selected stream publishes messages.
