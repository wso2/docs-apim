# Monitoring with Prometheus

Prometheus is an open source toolkit that can monitor systems and produce useful information such as graphs and alerts. It collects statistical data exposed over an HTTP endpoint in the form of multi dimensional time series data, which can be then be visualized and queried. See the [Prometheus documentation](https://prometheus.io/docs/introduction/overview/) for more information.

## Overview

WSO2 API Manager exposes its statistical data through JMX as MBeans. To monitor these metrics using Prometheus, the [Prometheus JMX Exporter](https://github.com/prometheus/jmx_exporter) is configured as a Java agent during APIM startup. This exporter reads the JMX MBeans and converts them to the **Prometheus** format. The converted metrics are then exposed through an HTTP endpoint, which is used by Prometheus to scrape the statistical data. 

## Configuring the Prometheus server

1.  [Download and install](https://prometheus.io/download/) Prometheus.
2.  Open the `PROMETHEUS_HOME/prometheus.yml` file. 
    Add a **scrape config** with a preferred job name (ex: apim_stats) to this file as shown below. The port number and the endpoint name should be as specified below.

    ``` xml
    scrape_configs:
         - job_name: "prometheus"
           static_configs:
             - targets: ['localhost:9090']

               labels:
               app: "prometheus"

         - job_name: "apim_stats"
           static_configs:
             - targets: ['localhost:1234']
    ```

3.  Save the configuration file.

## Starting the Prometheus server

To start the Prometheus server, navigate to the `PROMETHEUS_HOME` and execute the start-up script located there. For Linux distributions the command is as follows.

```bash
./prometheus --config.file=prometheus.yml
```

## Configuring the API-Manager

1.  To use Prometheus, you need to create a YAML file (e.g. wso2config.yaml) with the following content and save it. The path to the file will be used
    in the configurations as described in the later steps.

    ```
    startDelaySeconds: 30
    ssl: false
    lowercaseOutputName: true
    username: admin
    password: admin
    ```

2.  Download the JMX exporter’s JAR
    [`jmx_prometheus_javaagent-1.3.0.jar`](https://github.com/prometheus/jmx_exporter/releases/download/1.3.0/jmx_prometheus_javaagent-1.3.0.jar).

3.  Add the following line under $JAVA_VER_BASED_OPTS of the `<APIM_HOME>/bin/api-manager.sh` file. Please note the port given below (1234) which will
    be used to expose the JMX Mbeans via the Prometheus server as the /metrics endpoint.

    ```
    -javaagent:<Path-to-the-exporter-JAR-file>/jmx_prometheus_javaagent-1.3.0.jar=1234:<Path-to-the-YAML-config-file>/wso2config.yaml
    ```

4.  Start the WSO2 API-Manager server as usual.

Once the above steps are completed you would be able to observe the above targets through the Prometheus console (http://localhost:9090/targets) as follows and the /metrics endpoint (http://localhost:1234/metrics) will also be accessible.

[![Prometheus Targets]({{base_path}}/assets/img/observe/prometheus-targets.png)]({{base_path}}/assets/img/observe/prometheus-targets.png)

[![Prometheus Metrics]({{base_path}}/assets/img/observe/prometheus-metrics.png)]({{base_path}}/assets/img/observe/prometheus-metrics.png)

## Viewing statistics

You may also visit the following url in Prometheus server to plot the graphs.

```bash
http://localhost:9090/graph
```

[![Prometheus Graph1]({{base_path}}/assets/img/observe/prometheus-graph1.png)]({{base_path}}/assets/img/observe/prometheus-graph1.png)
[![Prometheus Graph2]({{base_path}}/assets/img/observe/prometheus-graph2.png)]({{base_path}}/assets/img/observe/prometheus-graph2.png)
