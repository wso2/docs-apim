# Exporting Logs to Moesif

WSO2 APIM can export logs to [Moesif](https://www.moesif.com/) using the OpenTelemetry Collector, enabling you to view and analyze APIM logs in Moesif's Live Event Log.

<!-- !!! note
    To correlate logs with traces using trace IDs and span IDs, see [Exporting Logs with OpenTelemetry]({{base_path}}/monitoring/observability/monitoring-with-opentelementry/). -->

## Prerequisites

- WSO2 APIM
- Docker (for running the OpenTelemetry Collector)

## Step 1 - Create a Moesif account and obtain an Application ID

1. Create a [Moesif account](https://www.moesif.com/signup) if you don't already have one.

2. Once logged in, obtain your **Collector Application ID** by navigating to:

    ```
    Account → API Keys → Collector Application Id
    ```

    <a href="{{base_path}}/assets/img/analytics/moesif/moesif-application-id.png" >
        <img src="{{base_path}}/assets/img/analytics/moesif/moesif-application-id.png" alt="Moesif application id"/>
    </a>


    You'll need this Application ID to configure the OpenTelemetry Collector exporter.

## Step 2 - Configure the OpenTelemetry Collector

The OpenTelemetry Collector reads the APIM log file (wso2carbon.log) and forwards the logs to Moesif's OTLP endpoint.

Create a file named `otel-collector-config.yaml` with the following content:

```yaml
receivers:
  filelog:
    include: [ /var/log/wso2apim/wso2carbon.log ]
    start_at: end
    storage: file_storage

processors:
  resource:
    attributes:
    - key: service.name
      value: "WSO2-APIM"
      action: upsert

exporters:
  otlphttp/logs:
    logs_endpoint: https://api.moesif.net/v1/logs
    headers:
      X-Moesif-Application-Id: '<YOUR_MOESIF_APPLICATION_ID>'

extensions:
  file_storage:
    directory: /etc/otelcol-contrib/.data
    create_directory: true

service:
  extensions: [ file_storage ]
  pipelines:
    logs:
      receivers: [ filelog ]
      processors: [ resource ]
      exporters: [ otlphttp/logs ]
```

Replace `<YOUR_MOESIF_APPLICATION_ID>` with the Collector Application ID you obtained in [Step 1](#step-1-create-a-moesif-account-and-obtain-an-application-id).

- The `filelog` receiver tails the `wso2carbon.log` file.
- The `resource` processor tags each log record with the service name `WSO2-APIM`.
- The `otlphttp/logs` exporter sends logs to Moesif's OTLP HTTP endpoint with your Application ID for authentication.

For more details on Moesif's OpenTelemetry integration, see the [Moesif OpenTelemetry Integration Guide](https://www.moesif.com/docs/server-integration/open-telemetry/).

## Step 3 - Start services and verify

1. Start the OpenTelemetry Collector:

    ```bash
    docker run --rm \
      -v $(pwd)/otel-collector-config.yaml:/etc/otelcol-contrib/config.yaml \
      -v <APIM_HOME>/repository/logs:/var/log/wso2apim \
      -v $(pwd)/.data:/etc/otelcol-contrib/.data \
      otel/opentelemetry-collector-contrib:latest \
      --config /etc/otelcol-contrib/config.yaml
    ```

    Replace `<APIM_HOME>` with the path to your WSO2 APIM installation directory.

2. Start the WSO2 APIM server.

3. Make some API requests to generate log entries.

!!! note
    - Make sure the Collector has **read access** to the `wso2carbon.log` file.
    - The `file_storage` extension persists the read offset so that the Collector resumes from where it left off if restarted.

## Viewing logs in Moesif

Once both the WSO2 APIM server and the OpenTelemetry Collector are running, logs will begin appearing in Moesif.

1. Log in to the [Moesif Portal](https://www.moesif.com/wrap).

2. Navigate to **Live Event Log** to see the captured log data. For more information, see the [Moesif Live Event Log documentation](https://www.moesif.com/docs/api-analytics/event-stream/).

    <a href="{{base_path}}/assets/img/analytics/moesif/moesif-live-log-events.png" >
        <img src="{{base_path}}/assets/img/analytics/moesif/moesif-live-log-events.png" alt="Moesif live logs"/>
    </a>

!!! tip "See also"
    - For more details on Moesif's OpenTelemetry integration, see the [Moesif OpenTelemetry Server Integration documentation](https://www.moesif.com/docs/server-integration/open-telemetry/).
    <!-- - For metrics observability with Moesif, see [Moesif Based Metrics]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-integration-guide/). -->
    - For a complete end-to-end observability setup using OpenTelemetry with other backends, see [OpenTelemetry Based Logs]({{base_path}}/monitoring/observability/monitoring-with-opentelementry/).