# Monitoring ETL Flows with Grafana

!!! tip "Before you begin:"
    To enable WSO2 Streaming Integrator to publish statistics in Grafana, follow the instructions in [Setting up Grafana to Display WSO2 SI Statistics]({{base_path}}/observe/si-observe/setting-up-grafana-dashboards.md).

## Setting Up Grafana to Monitor WSO2 Streaming Integrator

For the purpose of monitoring ETL (Extract, Transform, Load) statistics WSO2 provides nine pre-configured dashboards. To view them in Grafana, follow the steps below:
 
 1. Download the following dashboards (i.e., the JSON file with the dashboard configuration) from [here](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards).
 
    |**Directory**        |**Dashboard**                                          |
    |---------------------|-------------------------------------------------------|
    |`overview-statistics`|- [WSO2 Streaming Integrator - Overall Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/overview-statistics/WSO2%20Streaming%20Integrator%20-%20Overall%20Statistics.json) <br/> - [WSO2 Streaming Integrator - App Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/overview-statistics/WSO2%20Streaming%20Integrator%20-%20App%20Statistics.json)|
    |`file-statistics`    |- [WSO2 Streaming Integrator - File Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/file-statistics/WSO2%20Streaming%20Integrator%20-%20File%20Statistics.json) <br/> - [WSO2 Streaming Integrator - File Source Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/file-statistics/WSO2%20Streaming%20Integrator%20-%20File%20Source%20Statistics.json) <br/> - [WSO2 Streaming Integrator - File Sink Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/file-statistics/WSO2%20Streaming%20Integrator%20-%20File%20Sink%20Statistics.json)|
    |`rdbms-statistics`   |- [WSO2 Streaming Integration - RDBMS Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/rdbms-statistics/WSO2%20Streaming%20Integration%20-%20RDBMS%20Statistics.json) <br/> - [WSO2 Streaming Integration - RDBMS Table Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/rdbms-statistics/WSO2%20Streaming%20Integration%20-%20RDBMS%20Table%20Statistics.json)|
    |`cdc-statistics`     |- [WSO2 Streaming Integrator - CDC Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/cdc-statistics/WSO2%20Streaming%20Integrator%20-%20CDC%20Statistics.json) <br/> - [WSO2 Streaming Integrator - CDC Streaming Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/cdc-statistics/WSO2%20Streaming%20Integrator%20-%20CDC%20Streaming%20Statistics.json) <br/> - [WSO2 Streaming Integrator - CDC Scheduled Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/cdc-statistics/WSO2%20Streaming%20Integrator%20-%20CDC%20Scheduled%20Statistics.json)|
    |`kafka-statistics`     |- [WSO2 Streaming Integrator - Kafka Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/kafka-statistics/WSO2%20Streaming%20Integrator%20-%20Kafka%20Statistics.json) <br/> - [WSO2 Streaming Integrator - Kafka Source Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/kafka-statistics/WSO2%20Streaming%20Integrator%20-%20Kafka%20Source%20Statistics.json) <br/> - [WSO2 Streaming Integrator - Kafka Sink Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/kafka-statistics/WSO2%20Streaming%20Integrator%20-%20Kafka%20Sink%20Statistics.json)|
    
 2. Start and access Grafana. Then import the nine dashboards you downloaded in the previous step. For more information, see [Managing Grafana Dashboards - Importing Dashboards]({{base_path}}/observe/si-observe/managing-grafana-dashboards.md#importing-dashboards).
    
 3. In the **Dashboards**/**Manage** tab, create four new folders named `overview-statistics`, `file-statistics`, `rdbms-statistics`, `cdc-statistics`, and `kafka-statistics` . Then organize the dashboards you imported in the new folders you created as shown in the image below. For instructions, see [Managing Grafana Dashboards - Organizing Dashboards in Folders]({{base_path}}/observe/si-observe/managing-grafana-dashboards.md#organizing-dashboards-in-folders).
 
    !!! info
        The following is a suggested method to organize your dashboards, and the following instructions are provided based on this structure.
 
    ![Organize Dashboards]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/organized-dashboards.png)
    
 
## Accessing Grafana Dashboards for Monitoring

To navigate through the Grafana dashboards you set up for monitoring WSO2 Streaming Integrator and to analyze statistics, follow the procedure below:

1. To start and access the dashboards in Grafana, follow the steps below:

    1. Start the Prometheus server by issung the following command from the `<PROMETHEUS_HOME>` directory.
    
        `./prometheus`
        
    2. Start Grafana.
    
        !!! info
            The procedure to start Grafana depends on your operating system and the installation process. e.g., If your operating system is Mac OS and you have installed Grafana via Homebrew, you start Grafana by issuing the `brew services start grafana` command.
            
    3. Start the WSO2 Streaming Integrator server by navigating to the `<SI_HOME>/bin`directory, and issuing the appropriate command out of the following based on your operating system.
           
        - For Linux: `./server.sh`
        - For Windows: `server.bat`

    Access Grafana via `http://localhost:3000/`.

2. In the left pane, click the **Dashboards** icon, and then click **Manage** to open the **Dashboards** page.

3. In the **Dashboards** page, click **WSO2 Streaming Integrator Overall Statistics**.

    ![Open Overall Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/open-overall-statistics-dashboard.png)
    
    The overall statistics are displayed as shown in the following example.
    
    ![Overall Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/overall-statistics.png)
    
    This provides an overview on the overall performance of the WSO2 Streaming Integrator instance by displaying the total number of input events consumed and the total number of output events. It also provides the breakdown of the total inputs and outputs by Siddhi application. The **(Consume/Publish)/Sec** graph indicates the rate at which the consumed input events are published per second.
    
4. To view the statistics specific to a Siddhi application, click on the relevant Siddhi application.
 
    ![Select Siddhi Application]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-siddhi-applocation.png)
    
    The **WSO2 Streaming Integrator App Statistics** dashboard opens. This allows you to access any statistics relating to change data capture, file processing and data store integration activities carried out via the selected Siddhi application.
    
    ![Application Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/siddhi-application-statistics.png)
    
### Viewing CDC statistics**
    
CDC related statistics are displayed in the **Sources** section of the **WSO2 Streaming Integrator App Statistics** dashboard. To view the detailed statistics for a specific table, click on that table.

As a result, the **CDC Statistics** dashboard opens with change data statistice specific to that table.

![CDC Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-statistics.png)

If you click on a table for which change data is captured in a streaming manner (i.e., a table in the **CDC Streaming Statistics** section), the **CDC Streaming Statistics** dashboard opens with change data related statistics specific to the selected table as shown in the example below.

![CDC Streaming Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-streaming-statistics.png)

If you click on a table for which change data is captured in a scheduled manner by polling the table (i.e., a table in the **CDC Scheduled Statistics** section), the **CDC Scheduled Statistics** dashboard opens with change data related statistics specific to the selected table as shown in the example below.

![CDC Scheduled Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/cdc-scheduled-statistics.png)
    
### Viewing File statistics**
    
- When the content of a file is used as input data, the file is displayed in the **Sources** section as shown in the example below.

  ![File Source Statistics]({{base_path}}/develop/streaming-apps/managing-wso2-dashboards/source-file-statistics.png)

 To view statistics for a specific file, click on it. As a result, the **WSO2 Streaming Integrator - File Statistics** dashboard opens as shown in the example below.
 
  ![File Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-statistics-dashboard.png)
  
 When you click on the same file again, the **WSO2 Streaming Integrator - File Source Statistics** dashboard opens with more detailed information about this source file as shown in the example below. 
 
  ![File Source Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-source-statistics-dashboard.png)                 
  
- When the content of a file is generated as an output of the Siddhi application, the file is displayed in the **Destinations** section as shown in the example below.

  ![File Sink Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-sink-statistics.png)       

 To view statistics for a specific file, click on it. As a result, the **WSO2 Streaming Integrator - File Statistics** dashboard opens as shown in the example below.
         
 ![File Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-statistics-dashboard.png)

 When you click on the same file again, the **WSO2 Streaming Integrator - File Sink Statistics** dashboard opens with more detailed information about this sink file as shown in the example below. 
 
 ![File Sink Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/file-sink-statistics-dashboard.png) 
        
### Viewing RDBMS statistics**
    
When the records of an RDBMS database is used as input data by the selected Siddhi application, the database is displayed in the **Sources** section. When any output generated by the selected Siddhi application is saved in a database, that database is displayed under **Destinations**.

In each section, all the databases of the relevant category is listed in a table as shown in the example below.

![RDBMS Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/rdbms-statistics.png)

To view detailed statistics of a specific database, click on that database.

![Select RDBMS]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-rdbms.png)

The **RDBMS Statistics** dashboard opens with RDBMS statistics specific to the selected database.

![Database Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/database-statistics.png)

To view statistics relating to a specific table, click on the relevant table name in the **RDBMS Table** table.

![Select RDBMS Table]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/select-rdbms-table.png)

The **RDBMS Table Statistics** dashboard opens with statistics specific to the selected table.

![RDBMS Table Statistics]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/rdbms-table-statistics.png)
        
### Viewing Kafka statistics
    
Kafka related statistics are displayed in the **Sources** and **Destinations** sections of the **WSO2 Streaming Integrator App Statistics** dashboard. 

![Kafka Sources Table]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-sources-table.png)

![Kafka Sinks Table]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-destinations-table.png)

To view the detailed overall Kafka Statistics for a specific app, click on any stream link on the table. As a result, you will be taken to **WSO2 Streaming Integrator Kafka Statistics** dashboard.

![Kafka Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-statistics-dashboard.png)

This page has two sections: **Source** and **Sink**. 

- The **Source** section shows the overall Kafka Source metrics such as total reads, input event rate etc. It also contains a table that lists all the streams that are associated to a Kafka source. If you click on a stream, it will take you to **WSO2 Streaming Integrator Kafka Source Statistics** dashboard.

![Kafka Source Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-source-statistics-dashboard.png)

This dashboard shows the Kafka Source statistics related to the selected stream. A stream is associated to one or more topics. Furthermore, each topic is associated to a partition. This dashboard views statistics for each separate Topic-Partition combination to which the selected stream is subscribed.

- The **Sink** section shows the overall Kafka Sink metrics such as total writes, output event rate etc. It also contains a table that lists all the streams that are associated to a Kafka source. If you click on a stream, it will take you to **WSO2 Streaming Integrator Kafka Sink Statistics** dashboard.

![Kafka Sink Statistics Dashboard]({{base_path}}/assets/img/streaming/managing-wso2-dashboards/kafka-sink-statistics-dashboard.png)

This dashboard shows the Kafka Sink statistics related to the selected stream. Here, a stream publishes to a specific Kafka Topic and to one or more partitions. This dashboard views statistics for each separate Topic-Partition combination to which the selected stream publishes messages.




        
        