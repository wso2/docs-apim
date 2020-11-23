# Monitoring with Prometheus

Prometheus is an open source toolkit that can monitor systems and produce useful information such as graphs and alerts. It collects statistical data exposed over an HTTP endpoint in the form of multi dimensional time series data, which can be then be visualized and queried. See the [Prometheus documentation](https://prometheus.io/docs/introduction/overview/) for more information.

## Overview

WSO2 Micro Integrator exposes its statistical data through JMX as
MBeans. The Prometheus publisher in the Micro Integrator scrapes these bean data and
converts them to the **Prometheus** format. The converted metrics are then
exposed through an HTTP endpoint, which is used by Prometheus to scrape
the statistical data. 

## Configuring the Prometheus server

1.  [Download and install](https://prometheus.io/download/) Prometheus.
2.  Open the `           PROMETHEUS_HOME/prometheus.yml          `
    file. Add a **scrape config** as to this file as shown below. The
    port number and the endpoint name should be as specified below.

    ``` xml
    scrape_configs:
         - job_name: "esb_stats"
           static_configs:
             - targets: ['localhost:9201']
           metrics_path: "metric-service/metrics"
    ```

3.  Save the configuration file.

## Starting the Prometheus server

To start the **Prometheus** server, navigate to the `PROMETHEUS_HOME` and execute the start-up script located there.

## Starting the Micro Integrator

To use Prometheus, you need to first start the WSO2 Micro Integrator instance by passing the 'enablePrometheusApi' system property. This system property will connect the Micro Integrator to Prometheus, and enable the Micro Integrator to publish statistics to Prometheus.

- If your Micro Integrator is running on Docker, start your Docker container by passing the 'enablePrometheusApi' system property:

    ```bash
    docker run -p 8290:8290 -e JAVA_OPTS="-DenablePrometheusApi=true" <Docker_Image_Name>
    ```

- If your Micro Integrator is running on a **VM** with Prometheus enabled, navigate to the `MI_HOME/bin        ` directory and issue one of the following commands.

    -   On **Windows**: `          micro-integrator.bat -DenablePrometheusApi         `
    -   For **Linux/MacOS/CentOS** : `          ./micro-integrator.sh -DenablePrometheusApi         `

## Viewing statistics

You may also visit following url in Prometheus server to plot the
graphs.

```bash
http://localhost:9090/graph
```
