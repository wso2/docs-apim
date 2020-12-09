# Monitoring ETL Flows with Grafana

!!! tip "Before you begin:"
    To enable WSO2 Streaming Integrator to publish statistics in Grafana, follow the instructions in [Setting up Grafana to Display WSO2 SI Statistics](../admin/setting-up-grafana-dashboards.md).

## Setting Up Grafana to Monitor WSO2 Streaming Integrator

For the purpose of monitoring ETL (Extract, Transform, Load) statistics WSO2 provides nine pre-configured dashboards. To view them in Grafana, follow the steps below:
 
 1. Download the following dashboards (i.e., the JSON file with the dashboard configuration) from [here](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards).
 
    |**Directory**        |**Dashboard**                                          |
    |---------------------|-------------------------------------------------------|
    |`overview-statistics`|- [WSO2 Streaming Integrator - Overall Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/overview-statistics/WSO2%20Streaming%20Integrator%20-%20Overall%20Statistics.json) <br/> - [WSO2 Streaming Integrator - App Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/overview-statistics/WSO2%20Streaming%20Integrator%20-%20App%20Statistics.json)|
    |`file-statistics`    |- [WSO2 Streaming Integrator - File Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/file-statistics/WSO2%20Streaming%20Integrator%20-%20File%20Statistics.json) <br/> - [WSO2 Streaming Integrator - File Source Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/file-statistics/WSO2%20Streaming%20Integrator%20-%20File%20Source%20Statistics.json) <br/> - [WSO2 Streaming Integrator - File Sink Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/file-statistics/WSO2%20Streaming%20Integrator%20-%20File%20Sink%20Statistics.json)|
    |`rdbms-statistics`   |- [WSO2 Streaming Integration - RDBMS Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/rdbms-statistics/WSO2%20Streaming%20Integration%20-%20RDBMS%20Statistics.json) <br/> - [WSO2 Streaming Integration - RDBMS Table Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/rdbms-statistics/WSO2%20Streaming%20Integration%20-%20RDBMS%20Table%20Statistics.json)|
    |`cdc-statistics`     |- [WSO2 Streaming Integrator - CDC Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/cdc-statistics/WSO2%20Streaming%20Integrator%20-%20CDC%20Statistics.json) <br/> - [WSO2 Streaming Integrator - CDC Streaming Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/cdc-statistics/WSO2%20Streaming%20Integrator%20-%20CDC%20Streaming%20Statistics.json) <br/> - [WSO2 Streaming Integrator - CDC Scheduled Statistics.json](https://github.com/wso2/streaming-integrator/blob/master/modules/distribution/carbon-home/resources/dashboards/cdc-statistics/WSO2%20Streaming%20Integrator%20-%20CDC%20Scheduled%20Statistics.json)|
    
 2. Start and access Grafana. Then import the nine dashboards you downloaded in the previous step. For more information, see [Managing Grafana Dashboards - Importing Dashboards](managing-grafana-dashboards.md#importing-dashboards).
    
 3. In the **Dashboards**/**Manage** tab, create four new folders named `overview-statistics`, `file-statistics`, `rdbms-statistics`, and `cdc-statistics` . Then organize the dashboards you imported in the new folders you created as shown in the image below. For instructions, see [Managing Grafana Dashboards - Organizing Dashboards in Folders](managing-grafana-dashboards.md#organizing-dashboards-in-folders).
 
    !!! info
        The following is a suggested method to organize your dashboards, and the following instructions are provided based on this structure.
 
    ![Organize Dashboards](../images/managing-wso2-dashboards/organized-dashboards.png)
    
 
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

    ![Open Overall Statistics](../images/managing-wso2-dashboards/open-overall-statistics-dashboard.png)
    
    The overall statistics are displayed as shown in the following example.
    
    ![Overall Statistics](../images/managing-wso2-dashboards/overall-statistics.png)
    
    This provides an overview on the overall performance of the WSO2 Streaming Integrator instance by displaying the total number of input events consumed and the total number of output events. It also provides the breakdown of the total inputs and outputs by Siddhi application. The **(Consume/Publish)/Sec** graph indicates the rate at which the consumed input events are published per second.
    
4. To view the statistics specific to a Siddhi application, click on the relevant Siddhi application.
 
    ![Select Siddhi Application](../images/managing-wso2-dashboards/select-siddhi-applocation.png)
    
    The **WSO2 Streaming Integrator App Statistics** dashboard opens. This allows you to access any statistics relating to change data capture, file processing and data store integration activities carried out via the selected Siddhi application.
    
    ![Application Statistics](../images/managing-wso2-dashboards/siddhi-application-statistics.png)
    
    - **Viewing CDC statistics**
    
        CDC related statistics are displayed in the **Sources** section of the **WSO2 Streaming Integrator App Statistics** dashboard. To view the detailed statistics for a specific table, click on that table.
        
        As a result, the **CDC Statistics** dashboard opens with change data statistice specific to that table.
        
        ![CDC Statistics Dashboard](../images/managing-wso2-dashboards/cdc-statistics.png)
        
        If you click on a table for which change data is captured in a streaming manner (i.e., a table in the **CDC Streaming Statistics** section), the **CDC Streaming Statistics** dashboard opens with change data related statistics specific to the selected table as shown in the example below.
        
        ![CDC Streaming Statistics Dashboard](../images/managing-wso2-dashboards/cdc-streaming-statistics.png)
        
        If you click on a table for which change data is captured in a scheduled manner by polling the table (i.e., a table in the **CDC Scheduled Statistics** section), the **CDC Scheduled Statistics** dashboard opens with change data related statistics specific to the selected table as shown in the example below.
        
        ![CDC Scheduled Statistics Dashboard](../images/managing-wso2-dashboards/cdc-scheduled-statistics.png)
    
    - **Viewing File statistics**
    
       - When the content of a file is used as input data, the file is displayed in the **Sources** section as shown in the example below.
        
          ![File Source Statistics](../images/managing-wso2-dashboards/source-file-statistics.png)
        
         To view statistics for a specific file, click on it. As a result, the **WSO2 Streaming Integrator - File Statistics** dashboard opens as shown in the example below.
         
          ![File Statistics Dashboard](../images/managing-wso2-dashboards/file-statistics-dashboard.png)
          
         When you click on the same file again, the **WSO2 Streaming Integrator - File Source Statistics** dashboard opens with more detailed information about this source file as shown in the example below. 
         
          ![File Source Statistics Dashboard](../images/managing-wso2-dashboards/file-source-statistics-dashboard.png)                 
          
       - When the content of a file is generated as an output of the Siddhi application, the file is displayed in the **Destinations** section as shown in the example below.
    
          ![File Sink Statistics](../images/managing-wso2-dashboards/file-sink-statistics.png)       
        
         To view statistics for a specific file, click on it. As a result, the **WSO2 Streaming Integrator - File Statistics** dashboard opens as shown in the example below.
                 
         ![File Statistics Dashboard](../images/managing-wso2-dashboards/file-statistics-dashboard.png)
        
         When you click on the same file again, the **WSO2 Streaming Integrator - File Sink Statistics** dashboard opens with more detailed information about this sink file as shown in the example below. 
         
         ![File Sink Statistics Dashboard](../images/managing-wso2-dashboards/file-sink-statistics-dashboard.png) 
        
    - **Viewing RDBMS statistics**
    
        When the records of an RDBMS database is used as input data by the selected Siddhi application, the database is displayed in the **Sources** section. When any output generated by the selected Siddhi application is saved in a database, that database is displayed under **Destinations**.
       
        In each section, all the databases of the relevant category is listed in a table as shown in the example below.
        
        ![RDBMS Statistics](../images/managing-wso2-dashboards/rdbms-statistics.png)
        
        To view detailed statistics of a specific database, click on that database.
        
        ![Select RDBMS](../images/managing-wso2-dashboards/select-rdbms.png)
        
        The **RDBMS Statistics** dashboard opens with RDBMS statistics specific to the selected database.
        
        ![Database Statistics](../images/managing-wso2-dashboards/database-statistics.png)
        
        To view statistics relating to a specific table, click on the relevant table name in the **RDBMS Table** table.
        
        ![Select RDBMS Table](../images/managing-wso2-dashboards/select-rdbms-table.png)
        
        The **RDBMS Table Statistics** dashboard opens with statistics specific to the selected table.
        
        ![RDBMS Table Statistics](../images/managing-wso2-dashboards/rdbms-table-statistics.png)