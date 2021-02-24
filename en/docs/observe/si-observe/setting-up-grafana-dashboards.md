# Setting up Dashboards to Display WSO2 SI Statistics

This section explains how WSO2 Streaming Integrator servers can be configured to publish data to Prometheus and display statistics in Grafana dashboards.

!!! tip "Before you begin:"
    - Download and install Prometheus. For instructions, see [the Prometheus Getting Started Guide](https://prometheus.io/docs/prometheus/latest/getting_started/). <br/>
    - Download Grafana from [Grafana Labs - Download Grafana](https://grafana.com/grafana/download).

## Configuring Servers

In order to configure a Grafana dashboard, follow the steps below:

1. **Configure Prometheus reporter in Streaming Integrator**

    Enable statistics for the Prometheus reporter as follows.
   
    - To enable statistics for the Prometheus reporter, open the `<SI_HOME>/conf/server/deployment.yaml` file and set the `enabled` parameter in the `wso2.metrics` section to `true`, and update the other parameters in the section as shown below. You also need to add the `metrics.prometheus:` as shown.
    
    ```yaml
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
    - To enable statistics for the Prometheus reporter at Siddhi application level, use the `@App:statistics` annotation in the required Siddhi applications to set the `reporter` parameter as shown in the example below.
    
      ```
        @App:name('TestMetrics')
        @App:statistics(reporter = 'prometheus')
        define stream TestStream (message string);
      ```

2. **Start Streaming Integrator server**

    To start the Streaming runtime, navigate to the `<SI_HOME>/bin` directory and issue the appropriate command based on your operating system.
    
    - **For Windows**: `server.bat --run`<br/>
    - **For Linux/MacOS**: `./server.sh`

3. **Start the Prometheus server**

    Start and run the Prometheus server by following the procedure below.
    
    1. Open the `<PROMETHEUS_HOME>/prometheus.yml` file and add the following configuration in the `scrape_configs:` section.
    
        ```yaml
         scrape_configs:
           - job_name: 'prometheus'
             static_configs:
             - targets: ['localhost:9005']
        ```
    2. Start the Prometheus server by issuing the following command in the terminal.
    
        `./prometheus`

4. **Start and configure the Grafana server**

    To start and configure the Grafana server, follow the procedure below:
    
    2. Start Grafana
    
        !!! info
            The procedure to start Grafana depends on your operating system and the installation process. e.g., If your operating system is Mac OS and you have installed Grafana via Homebrew, you start Grafana by issuing the `brew services start grafana` command.
            
    3. Access Grafana via `http://localhost:3000/`.
   
    4. In the **Data Sources** section, click **Add your first data source**. In the **Add data source** page that appears, click **Select** for **Prometheus**.
    
    5. In the **Add data source** page -> **Settings** tab, update the configurations for Prometheus as follows.
    
        ![prometheus configuration]({{base_path}}/develop/streaming-apps/cdc-monitoring/prometheus-configurations.png)
    
        1. Click **Default** to make Prometheus the default data source.
        
        2. Under **HTTP**, enter `http://localhost:9090` as the URL.
        
        3. Click **Save & Test**. If the data source is successfully configured, it is indicated via a message.
        
            ![Save and Test]({{base_path}}/develop/streaming-apps/cdc-monitoring/save-and-test.png)

5. **Load dashboards into Grafana**

    WSO2 Streaming Integrator offers pre-built dashboards for monitoring streaming data flows and server statistics. To load them, follow the procedure below:
    
    1. Download the required JSON file (i.e., based on the statistics you need to view) from [here](https://github.com/wso2/streaming-integrator/tree/master/modules/distribution/carbon-home/resources/dashboards).
    
    2. Start Grafana and access it via `http://localhost:3000/`.
    
    3. To load a new dashboard, click the plus icon (**+**) in the side panel. Then click **Import**.
    
    4. In the **Import** page, click **Upload .json file**. Then browse and select the .json file of the preconfigured dashboard that you downloaded (i.e., in step 5, substep 1).
    
    5. If required, change the unique identifier displayed in the **Unique Identifier (uid)**.
    
    6. Click **Import**.
    

    

    



  
