# Setting up Cloud-Native Observability on a VM

Follow the instructions given below to set up a cloud-native observability solution for your Micro Integrator deployment in a VM environment. 

You need to start with the [minimum deployment](#setting-up-the-minimum-deployment), which enables metric monitoring. Once you have set up the minimum deployment, you can add [log processing](#integrating-the-log-processing-add-on) and [message tracing](#integrating-the-message-tracing-add-on) capabilities to your solution.

## Setting up the minimum deployment

The minimum cloud-native observability deployment requires <b>Prometheus</b> and <b>Grafana</b>. The Micro Integrator uses Prometheus to expose its statistics to Grafana. Grafana is used to visualize the statistics.

### Setting up Prometheus

To set up the Prometheus server:

1. Download Prometheus from the [Prometheus site](https://prometheus.io/download/).

    !!! tip
        Select the appropriate operating system and the architecture based on your operating system and requirements.

2. Extract the downloaded file and navigate to that directory.

    !!! info
        This directory is referred to as `<PROMETHEUS_HOME>` from hereon.
        
3. Open the `<PROMETHEUS_HOME>/prometheus.yml` file, and in the `scrape_configs` section, add a configuration as follows:

    ```yaml
    global:
      scrape_interval:     15s 
      evaluation_interval: 15s 
    
    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
        - targets: ['localhost:9090']
      - job_name: esb_stats
        metrics_path: /metric-service/metrics
        static_configs:
         - targets: ['localhost:9201']
    ```
   
    !!! note
        - Do not add or remove spaces when you copy the above configuration to the `prometheus.ymal` file.
        - In the `targets`section, you need to add your IP address and the port in which you are running the Micro Integrator server.
        
4. To start the Prometheus server, open a terminal, navigate to `<PROMETHEUS_HOME>`, and execute the following command:

    `./prometheus`
    
    When the Prometheus server is successfully started, you will see the following log:
    
    *Server is ready to receive web requests.*

### Setting up Grafana

To set up the Grafana server:

1.  Download and install [Grafana](https://grafana.com/grafana/download/7.1.1). 

    !!! Info
        Following the instructions (for your operating system) on the Grafana web site.

2. Start you Grafana server.

    !!! Tip
        The procedure to start Grafana depends on your operating system and the installation process. For example, If your operating system is Mac OS and you have installed Grafana via Homebrew, you start Grafana by issuing the `brew services start grafana` command.

3.  Access the Grafana UI from the `localhost:3000` URL. 
4.  Sign in using `admin` as both the user name and the password.

### Importing dashboards to Grafana

The Micro Integrator provides pre-configured Grafana dashboards in which you can visualize EI statistics.

You can directly import the required dashboards to Grafana using the <b>dashboard ID</b>:

1.  Go to [Grafana labs](https://grafana.com/orgs/wso2/dashboards).
2.  Select the required dashboard and copy the dashboard ID.
3.  Provde this ID to Grafana and import the dashboard.
4.  Repeat the above steps to import all other Micro Integrator dashboards.

These dashboards are provided as JSON files that can be manually imported to Grafana. To import the dashboards as JSON files:

1.  Go to [Grafana labs](https://grafana.com/orgs/wso2/dashboards), select the required dashboard and download the JSON file.
2.  Sigh in to Grafana, click the **+** icon in the left pane, and then click **Import**.

    The **Import** dialog box opens as follows.
    
    ![Import Dashboards dialog box]({{base_path}}/assets/img/integrate/monitoring-dashboard/grafana-import-dialog-box.png)
    
3. Click **Upload.json file**. Then browse for one of the dashboards that you downloaded as a JSON file.

4. Repeat the above two steps to import all the required dashboards that you downloaded and saved.

<!--
## Scaling the minimum deployment

### Scaling Prometheus

In a [clustered deployment]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei), you can add the IP address and the port of each server in the respective `prometheus.yml` file.

### Scaling Grafana

In a clustered deployment, you can view the list of Micro Integrator instances in your Micro Integrator cluster under **MI Nodes** in the **WSO2 Node Metrics** dashboard.
-->

### Setting up the Micro Integrator

To enable observability for the Micro Integrator servers, add the following Synapse handler to the `deployment.toml` file (stored in the `<MI_HOME>/conf/` folder).

```toml
[[synapse_handlers]]
name="CustomObservabilityHandler"
class="org.wso2.micro.integrator.observability.metric.handler.MetricHandler"
```
After applying the above change, you can start the Micro Integrator with the following JVM property: 
```
-DenablePrometheusApi=true
```

## Integrating the Log Processing add-on

Once you have successfully set up the [minimum deployment](#setting-up-the-minimum-deployment), you need to set up the log processing add-on to process logs. To achieve this, you can use Grafana Loki-based logging stack.

A Loki-based logging stack consists of three components:

- **fluentBit** is the agent that gathers logs and sends them to Loki.
- **loki** is the main server that stores logs and processes queries.
- **Grafana** queries and displays the logs.

To set up Fluent Bit and Grafana Loki, follow the topics below.

### Setting up Fluent Bit

To set up Fluent Bit:

1. Download [Fluent Bit](https://fluentbit.io/download/).

2. Extract the downloaded file. 

    !!! Tip
        The directory is referred to as `<FluentBit_Home>` from hereon.

3. Create the following files and save them with the given extension in a preferred location. You can use any text editor of your choice.

    !!! info
        In this example, the files are saved in the `<HOME_DIRECTORY>/conf` directory.

    - **`labelmap.json`** file
    
        ```
        {
            "instance": "instance",
            "log_level": "log_level",
            "service": "service"
         }
        ```
    
    - **`parsers.conf`** file

        ```
        [PARSER]
                Name        observability
                Format      json
                Time_Key    time
                Time_Format %Y-%m-%dT%H:%M:%S.%L
        [PARSER]
                Name        wso2
                Format      regex
                Regex       \[(?<date>\d{2,4}\-\d{2,4}\-\d{2,4} \d{2,4}\:\d{2,4}\:\d{2,4}\,\d{1,6})\]  (?<log_level>[^\s]+) \{(?<class>[\s\S]*)\} ([-]) (?<service>\{[\s\S]*\})?(?<message>.*)
                Time_Key    date
                    Time_Format %Y-%m-%d %H:%M:%S,%L
        ```
    
    - **`fluentBit.conf`** file
    
        ```
        [SERVICE]
            Flush        1
            Daemon       Off
            Log_Level    info
            Parsers_File <Location/parsers.conf>
        
        [INPUT]
            Name tail
            Path <MI_HOME>/repository/logs/*.log
            Mem_Buf_Limit  500MB
            Parser wso2
        
        [OUTPUT]
            Name loki
            Match *
            Url http://localhost:3100/loki/api/v1/push
            BatchWait 1
            BatchSize 30720
            Labels {job="fluent-bit"}
            LineFormat json
            LabelMapPath <Location/labelmap.json>
        ```
      
4. To build the Fluent Bit output plugin before starting Fluent Bit, follow the procedure below.

    1. Clone the [grafana/loki git repository](https://github.com/grafana/loki).
    2. To build the Fluent Bit plugin, execute the following command.
    
        `make fluent-bit-plugin`
        
        For more details, see [Fluent Bit Output Plugin readme file](https://github.com/grafana/loki/blob/master/cmd/fluent-bit/README.md#fluent-bit-output-plugin).
        
    3. Copy and save the path of the `out_loki.so` file. 
   
5. Open a new terminal and navigate to the `<FluentBit_Home>` directory. 
6.  Execute the following command:

    !!! tip
        Replace `<location of out_loki.so file>` with the path that you copied and saved in the previous step.

     `fluent-bit -e <location of out_loki.so file> -c <fluentbit.conf file path>`
     
When Fluent Bit is successfully installed, you will see a log message.
    
### Setting up the Loki server

After successfully setting up Fluent Bit, you need to set up Grafana Loki. Grafana Loki aggregates and processes the logs from Fluent Bit. 

To set up Grafana Loki:

1. Download Loki v1.6.1 from the [`grafana/loki` Git repository](https://github.com/grafana/loki/blob/v1.5.0/docs/installation/local.md).

    !!! tip
        Be sure to select the appropriate OS version before downloading.
        
2. Create a configuration file named `loki-local-config.yaml` for Loki similar to the sample given below, and save it in a preferred location.

    !!! tip
        - You can use a text editor of your choice for this purpose.
        - You can change the given parameter values based on your requirement.
        
    ```
    auth_enabled: false
    
    server:
      http_listen_port: 3100
    
    ingester:
      lifecycler:
        address: 127.0.0.1
        ring:
          kvstore:
            store: inmemory
          replication_factor: 1
        final_sleep: 0s
      chunk_idle_period: 5m
      chunk_retain_period: 30s
      max_transfer_retries: 0
    
    schema_config:
      configs:
        - from: 2018-04-15
          store: boltdb
          object_store: filesystem
          schema: v11
          index:
            prefix: index_
            period: 168h
    
    storage_config:
      boltdb:
        directory: /tmp/loki/index
    
      filesystem:
        directory: /tmp/loki/chunks
    
    limits_config:
      enforce_metric_name: false
      reject_old_samples: true
      reject_old_samples_max_age: 168h
    
    chunk_store_config:
      max_look_back_period: 0s
    
    table_manager:
      retention_deletes_enabled: false
      retention_period: 0s
    ```
   
 3. Unzip the file you downloaded in step 1. The directory that is created as a result is referred to as `<GrafanaLoki_Home>` from hereon.
 
 4. Open a new terminal and navigate to `<GrafanaLoki_Home>`. 
 5. Execute the following command:
 
    `./loki-darwin-amd64 -config.file=./loki-local-config.yaml`

### Configuring Grafana to visualize logs

In order to configure Grafana to display logs, you need to add Loki as a datasource in Grafana. 

Follow the steps given below.

1. Start you Grafana server.

    !!! Tip
        The procedure to start Grafana depends on your operating system and the installation process. For example, If your operating system is Mac OS and you have installed Grafana via Homebrew, you start Grafana by issuing the `brew services start grafana` command.
        
2. Access Grafana via `http://localhost:3000/`.

3. In the **Data Sources** section, click **Add your first data source**. In the **Add data source** page that appears, click **Select** for **Loki**.

    ![Select Loki as Data Source]({{base_path}}/assets/img/integrate/monitoring-dashboard/grafana-select-datasource.png)

4. In the **Add data source** page -> **Settings** tab, update the configurations for Loki.
    
5. Click **Save & Test**. If the datasource is successfully configured, it is indicated via a message.

## Integrating the Message Tracing add-on

Once you have successfully set up the [minimum deployment](#setting-up-the-minimum-deployment), you need to set up the message tracing add-on using Jaeger.

### Setting up Jaeger

Download and install [Jaeger](https://www.jaegertracing.io/download/).

!!! Note

    - There are some limitations in the Jaeger client, which by default uses a UDP sender as mentioned in [the Jaeger documentation](https://www.jaegertracing.io/docs/1.22/client-libraries/). If the payload size exceeds 65 KB, spans might get lost in the Jaeger console. 
    - Jaeger [sampler types](https://www.jaegertracing.io/docs/1.22/sampling/) can also play a major role in tracing. Depending on the TPS, the sampler type should be carefully chosen.
    - In general, before including tracing in production deployments it is essential to look into performance tests and scaling requirements. Refer the [Jaeger performance tuning guide](https://www.jaegertracing.io/docs/1.22/performance-tuning/) for details on how to achieve better performance. 

### Setting up the Micro Integrator

To configure the Micro Integrator to publish tracing information, follow steps given below:

1. Add the following configurations to the `deployment.toml` file (stored in the `<MI_HOME>/conf/`).

    ```toml
    [mediation]
    flow.statistics.capture_all= true
    stat.tracer.collect_payloads= true
    stat.tracer.collect_mediation_properties= true
    
    [opentracing]
    enable = true
    logs = true
    manager_host = "localhost"
    agent_host = "localhost”
    ```

2. Add the following entries to the `<MI_HOME>/repository/resources/conf/keyMappings.json` file.

    ```json
    "opentracing.enable": "synapse_properties.'opentracing.enable'",
    "opentracing.logs": "synapse_properties.'jaeger.reporter.log.spans'",
    "opentracing.manager_host": "synapse_properties.'jaeger.sampler.manager.host'",
    "opentracing.agent_host": "synapse_properties.'jaeger.sender.agent.host'"
    ```
!!! note
    The service name used to initialize the JaegerTracer can be configured using the environment variable `SERVICE_NAME`
    as shown below.
    ```
    export SERVICE_NAME=customServiceName
    ```
    `SERVICE_NAME` is set to `WSO2-SYNAPSE` by default.

### Configuring Grafana to visualize tracing data

In order to configure Grafana to display tracing information, follow the steps given below.

1. Add Jaeger as a datasource:

    1. Access Grafana via `localhost:3000` and sign in.
    
    2. Click the **Configuration** icon in the left menu and then click **Data Sources**.
    
        ![Open Data sources]({{base_path}}/assets/img/integrate/monitoring-dashboard/open-datasources.png)
        
    3. Click **Add data source** to open the **Add data source** page where all the available data source types are displayed. Here, click **Jaeger**.
    
        ![Select Jaeger]({{base_path}}/assets/img/integrate/monitoring-dashboard/select-jaeger.png)
        
        This opens the **Data Sources/Jaeger** dialog box. 
        
    4. In the **Data Sources/Jaeger** dialog box, enter the URL of the Jaeger query component in the **URL** field in the `http://host:port` format as shown below.
    
        ![Enter Basic Jaeger Information]({{base_path}}/assets/img/integrate/monitoring-dashboard/enter-basic-jaeger-information.png)
        
    5. Click **Save and Test**. If the data source is successfully configured, it is indicated via a message.
  

2. Set up drill-down links  to the Jaeger UI in service-level dashboards.

    1. Navigate to the settings section of the service-level dashboard by clicking the cog wheel icon in the upper-right corner.
    
    2. Click **Variable**. This opens the following view.
    
        ![Variables view]({{base_path}}/assets/img/integrate/monitoring-dashboard/variables.png)
        
    3. Edit the JaegerHost variable and provide your Jaeger query component hostname and port in the `host:port` syntax as shown below.
    
        ![constant options]({{base_path}}/assets/img/integrate/monitoring-dashboard/constant-options.png)
        
    4. Click **Save**
    
    You need to perform the above steps for all the service-level dashboards (i.e., Proxy Service dashboard, API Service Dashboard, and Inbound Endpoint dashboard).
    
Once Grafana is successfully configured to visualize statistics, you should be correctly redirected to the Jaeger UI from the Response Time widget of each service-level dashboard as shown below.
    
![jaeger ui]({{base_path}}/assets/img/integrate/-dashboard/jaeger-ui.png)

## What's Next?

If you have successfully set up your anlaytics deployment, see the instructions on [using the Grafana dashboards]({{base_path}}/observe/mi-observe/cloud-native-observability-dashboards).