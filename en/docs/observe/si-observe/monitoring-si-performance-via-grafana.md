# Monitoring Streaming Components

!!! tip "Before you begin:"
    To enable WSO2 Streaming Integrator to publish statistics in Grafana, follow the instructions in [Setting up Grafana to Display WSO2 SI Statistics]({{base_path}}/observe/si-observe/setting-up-grafana-dashboards).<br/><br/>
    To enable a Siddhi application to publish statistics to publish its statistics to Grafana, you need to specify Prometheus as the the statistics reporter via the `@App:statistics` annotation as shown below.<br/><br/>
    `@App:statistics(reporter = 'prometheus')`<br/><br/>
    For the dashboards to display statistics, at least one Siddhi application with the above configuration needs to be deployed in the Streaming Integrator Server.

## Setting Up Grafana to Monitor WSO2 Streaming Integrator

WSO2 Streaming Integrator performs streaming operations via Siddhi applications, which are applications written in the [Siddhi Query Language](https://siddhi.io/en/v5.1/docs/). 

Each Siddhi application contains a combination ofSiddhi components.

For the purpose of monitoring the performance of the Siddhi components used in your WSO2 Streaming Integrator instance, it provides ten pre-configured dashboards. To view them in Grafana, follow the steps below:
 
 1. Download the following dashboards from the [Streaming Integrator Git Repository](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics). To download a specific dashboard, click on the dashboard name given below:
 
    - [Siddhi Overall Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Overall%20Statistics.json)
    
    - [Siddhi Server Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Server%20Statistics.json)
    
    - [Siddhi Stream Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Stream%20Statistics.json)
    
    - [Siddhi Source Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Source%20Statistics.json)
    
    - [Siddhi Sink Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Sink%20Statistics.json)
    
    - [Siddhi Query Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Query%20Statistics.json)
    
    - [Siddhi Window Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Window%20Statistics.json)
    
    - [Siddhi Trigger Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Trigger%20Statistics.json)
    
    - [Siddhi Table Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Table%20Statistics.json)
    
    - [Siddhi Aggregation Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20Aggregation%20Statistics.json)
    
    - [Siddhi On Demand Query Statistics](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics/WSO2%20Streaming%20Integrator%20-%20Siddhi%20On-Demand%20Query%20Statistics.json)
    
 2. Start and access Grafana. Then import the eleven dashboards you downloaded in the previous step. For more information, see [Managing Grafana Dashboards - Importing Dashboards]({{base_path}}/observe/si-observe/managing-grafana-dashboards.md#importing-dashboards).
    
 
## Accessing Grafana Dashboards for Monitoring

To navigate through the Grafana dashboards you set up for monitoring WSO2 Streaming Integrator and to analyze statistics, follow the procedure below:

1. Start Grafana and access it via `http://localhost:3000/`.

2. In the left pane, click the **Dashboards** icon, and then click **Manage** to open the **Dashboards** page. Here, you can click on the following dashboards:

    - **Siddhi Overall Statistics**
        
        This displays the overall statistics related to your Streaming Integrator instance and the Siddhi components of the Siddhi applications that are currently deployed in it.
        
        For a detailed description of the information displayed in this dashboard, see [Viewing Overall Statistics]({{base_path}}/observe/si-observe/viewing-overall-statistics).
    
    - **Siddhi Server Statistics**
    
        This displays statistics related to the Siddhi server. 
        
        For a detailed description of the information displayed in this dashboard, see [Viewing Server Statistics]({{base_path}}/observe/si-observe/viewing-overall-statistics).
    
    - **Siddhi Stream Statistics**
    
        This displays statistics related to [streams](https://siddhi.io/en/v5.1/docs/query-guide/#stream) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
            
        For a detailed description of the information displayed in this dashboard, see [Viewing Stream Statistics]({{base_path}}/observe/si-observe/viewing-stream-statistics).
    
    - **Siddhi Source Statistics**
    
        This displays statistics related to [sources](https://siddhi.io/en/v5.1/docs/query-guide/#source) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
                
        For a detailed description of the information displayed in this dashboard, see [Viewing Source Statistics]({{base_path}}/observe/si-observe/viewing-source-statistics).
    
    - **Siddhi Sink Statistics**
    
        This displays statistics related to [sinks](https://siddhi.io/en/v5.1/docs/query-guide/#sink) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
                    
        For a detailed description of the information displayed in this dashboard, see [Viewing Sink Statistics]({{base_path}}/observe/si-observe/viewing-sink-statistics).
    
    - **Siddhi Query Statistics**
    
        This displays statistics related to [queries](https://siddhi.io/en/v5.1/docs/query-guide/#query) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
            
        For a detailed description of the information displayed in this dashboard, see [Viewing Query Statistics]({{base_path}}/observe/si-observe/viewing-query-statistics).
    
    - **Siddhi Window Statistics**
    
        This displays statistics related to [windows](https://siddhi.io/en/v5.1/docs/query-guide/#named-window) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
            
        For a detailed description of the information displayed in this dashboard, see [Viewing Window Statistics]({{base_path}}/observe/si-observe/viewing-window-statistics).
    
    - **Siddhi Trigger Statistics**
    
        This displays statistics related to [triggers](https://siddhi.io/en/v5.1/docs/query-guide/#trigger) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
            
        For a detailed description of the information displayed in this dashboard, see [Viewing Trigger Statistics]({{base_path}}/observe/si-observe/viewing-trigger-statistics).

    - **Siddhi Table Statistics**
    
        This displays statistics related to [tables](https://siddhi.io/en/v5.1/docs/query-guide/#table) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
            
        For a detailed description of the information displayed in this dashboard, see [Viewing Table Statistics]({{base_path}}/observe/si-observe/viewing-table-statistics).

    - **Siddhi Aggregation Statistics**
    
        This displays statistics related to [aggregations](https://siddhi.io/en/v5.1/docs/query-guide/#named-aggregation) in the Siddhi applications currently deployed in your WSO2 Streaming Integrator server
            
        For a detailed description of the information displayed in this dashboard, see [Viewing Aggregation Statistics]({{base_path}}/observe/si-observe/viewing-aggregation-statistics).
    
    - **Siddhi On Demand Query Statistics**
    
        This displays statistics related to on-demand-queries in your WSO2 Streaming Integrator server
            
        For a detailed description of the information displayed in this dashboard, see [Viewing Server Statistics]({{base_path}}/observe/si-observe/viewing-on-demand-query-statistics).