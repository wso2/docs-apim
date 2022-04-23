# Setting up Dashboards for SI Statistics - Getting Started Guide

This section explains how WSO2 Streaming Integrator servers can be configured to publish data to Prometheus and display WSO2 Streaming Integrator (WSO2 SI) statistics in Grafana dashboards.

!!! note "Before you begin:"
    - Download and install Prometheus. For instructions, see [the Prometheus Getting Started Guide](https://prometheus.io/docs/prometheus/latest/getting_started/). <br/>
    - Download Grafana from [Grafana Labs](https://grafana.com/grafana/download).

## Step 1 - Configure the Servers

Follow the instructions below to configure a Grafana dashboard:

### Step 1.1 - Configure the Prometheus reporter

Configure the Prometheus reporter in the Streaming Integrator in order to enable statistics for the Prometheus reporter as follows:

1. Open the `<SI_HOME>/conf/server/deployment.yaml` file.
2. Set the `enabled` parameter in the `wso2.metrics` section to `true`, and update the other parameters in the section as shown below. You also need to add the `metrics.prometheus:` as shown.

     ```
     wso2.metrics:
       # Enable Metrics
       enabled: true
       reporting:
         console:
           - # The name for the Console Reporter
             name: Console
    
             # Enable Console Reporter
             enabled: false
    
             # Polling Period in seconds.
             # This is the period for polling metrics from the metric registry and printing in the console
             pollingPeriod: 2
    
     metrics.prometheus:
     reporting:
       prometheus:
         - name: prometheus
           enabled: true
           serverURL: "http://localhost:9005"
     ```

3. Enable statistics for the Prometheus reporter at the Siddhi application level.
   
     To enable a Siddhi application to publish its statistics to Grafana, you need to specify Prometheus as the statistics reporter via the `@App:statistics` annotation by setting the `reporter` parameter as shown in the example below.

     ```
     @App:name('TestMetrics')
     @App:statistics(reporter = 'prometheus')
     define stream TestStream (message string);
     ```

     For the dashboards to display statistics, at least one Siddhi application with the above configuration needs to be deployed in the Streaming Integrator Server.

### Step 1.2 - Start the Streaming Integrator server

1. Navigate to the `<SI_HOME>/bin` directory.

2. Issue the appropriate command based on your operating system to start the Streaming runtime.
 
     - **For Windows**: `server.bat --run`<br/>
     - **For Linux/MacOS**: `./server.sh`

### Step 1.3 - Start the Prometheus server

1. Open the `<PROMETHEUS_HOME>/prometheus.yml` file and add the following configuration in the `scrape_configs:` section.

     ```
     scrape_configs:
       - job_name: 'prometheus'
         static_configs:
         - targets: ['localhost:9005']
     ```

2. Navigate to the <PROMETHEUS_HOME> directory and start the Prometheus server.

     ```
     ./prometheus
     ```

### Step 1.4 - Start and configure the Grafana server

Follow the instructions below to start and configure the Grafana server:

1. Start Grafana

    !!! info
        The procedure to start Grafana depends on your operating system and the installation process. e.g., If your operating system is Mac OS and you have installed Grafana via Homebrew, you start Grafana by issuing the `brew services start grafana` command.
      
2. Access Grafana via `http://localhost:3000/`.

3. In the **Data Sources** section, click **Add your first data source**. In the **Add data source** page that appears, click **Select** for **Prometheus**.

4. In the **Add data source** page **Settings** tab, update the configurations for Prometheus as follows:

     [![prometheus configuration]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/prometheus-configurations.png)]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/prometheus-configurations.png)

     1. Click **Default** to make Prometheus the default data source.
  
     2. Under **HTTP**, enter `http://localhost:9090` as the URL.
  
     3. Click **Save & Test**. 
     
       If the data source is successfully configured, it is indicated via a message.
  
       [![Save and Test]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/save-and-test.png){: style="width:80%"}]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/save-and-test.png)

### Step 1.5 - Load dashboards into Grafana

WSO2 Streaming Integrator offers pre-built dashboards for monitoring streaming data flows and server statistics. Follow the instructions below to import the Grafana dashboards:

1. Download the required JSON file based on the statistics you need to view from [here](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards).

      <table>
      <thead>
        <tr>
          <th><b>Statistics Type</b></th>
          <th><b>Directory</b></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>General Statistics</td>
          <td><a href="https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/general-statistics" target="_blank" rel="noopener noreferrer">general-statistics</a></td>
        </tr>
        <tr>
          <td rowspan="6">EFL Flow Statistics</td>
          <td><a href="https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/cdc-statistics" target="_blank" rel="noopener noreferrer">cdc-statistics</a></td>
        </tr>
        <tr>
          <td><a href="https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/file-statistics" target="_blank" rel="noopener noreferrer">file-statistics</a></td>
        </tr>
        <tr>
          <td><a href="https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/http-statistics" target="_blank" rel="noopener noreferrer">http-statistics</a></td>
        </tr>
        <tr>
          <td><a href="https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/kafka-statistics" target="_blank" rel="noopener noreferrer">kafka-statistics</a></td>
        </tr>
        <tr>
          <td><a href="https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/overview-statistics" target="_blank" rel="noopener noreferrer">overview-statistics</a></td>
        </tr>
        <tr>
          <td><a href="https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards/rdbms-statistics" target="_blank" rel="noopener noreferrer">rdbms-statistics</a></td>
        </tr>
      </tbody>
      </table>

2. Start Grafana and access it via `http://localhost:3000/`.

3. Import a new dashboard.
   
   1. Click on the plus icon (**+**) in the side panel. 
   2. Then click **Import**.
   3. In the **Import** page, click **Upload .json file**. 
   4. Then browse and select the `.json` file of the preconfigured dashboard that you downloaded in step 1.5 - (1.).
   5. If required, change the unique identifier displayed in the **Unique Identifier (uid)**.
   6. Click **Import**.

!!! note
    Optionally, you can **[organize the dashboards in folders and delete the dashboards]({{base_path}}/observe/streaming-integrator/managing-dashboards)** if required.

## Step 2 - View dashboards

Follow the instructions below to view a dashboard:

1. In the left pane, click on the **Dashboards** icon, and then click **Manage** to open the **Dashboards** page. 

2. To expand the folder that contains the dashboard you want to view, click on it.

     [![Expand Folder]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/expand-folder.png){: style="width:80%"}]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/expand-folder.png)
 
3. Click on the specific dashboard that you want to view.

     [![View Dashboard]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/view-dashboard.png){: style="width:80%"}]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/view-dashboard.png)

4. Once the dashboard opens, click on the bar shown below to expand it and specify the time range for which you want to view statistics.

     [![Select Time Range]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/view-dashboard.png){: style="width:80%"}]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/view-dashboard.png)
    
     Once you expand the time range bar, you can select the required time interval or specify a custom time interval.
    
     [![Select or Specify Time Range]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/select-or-specify-time-range.png){: style="width:50%"}]({{base_path}}/assets/img/streaming/managing-grafana-dashboard/select-or-specify-time-range.png)
