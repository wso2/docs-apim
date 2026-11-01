# Exporting Logs with OpenTelemetry

WSO2 API Manager can export logs over the [OpenTelemetry Protocol (OTLP)](https://opentelemetry.io/docs/specs/otlp/), which lets you send structured log data to any compatible observability backend.

## Prerequisites

- WSO2 APIM
- Docker (for running the OpenTelemetry Collector)

## Step 1 - Configure the OpenTelemetry Collector

The OpenTelemetry Collector reads the APIM log file and forwards the logs to your observability backend.

Create a file named `otel-collector-config.yaml` with the following content:

```yaml
receivers:
  filelog:
    include: [ /var/log/wso2apim/wso2carbon.log ]
    start_at: end
    storage: file_storage
    multiline:
     line_start_pattern: '^TID:\s*\['


processors:
  batch:
    send_batch_size: 1000
    timeout: 1s
  resource:
    attributes:
    - key: service.name
      value: "WSO2-APIM"
      action: upsert

exporters:
  otlp:
    endpoint: "<backend-host>:4317"
    tls:
      insecure: true

extensions:
  file_storage:
    directory: /etc/otelcol-contrib/.data
    create_directory: true

service:
  extensions: [ file_storage ]
  pipelines:
    logs:
      receivers: [ filelog ]
      processors: [ batch, resource ]
      exporters: [ otlp ]
```

Replace `<backend-host>` with the hostname of your observability backend's OTLP receiver. If your backend requires TLS or authentication, update the `exporters.otlp` section accordingly - refer to your backend's documentation for the exact configuration.

- The `filelog` receiver tails the `wso2carbon.log` file.
- The `batch` processor groups log records into batches before they are exported, reducing the number of requests sent to the backend.
- The `resource` processor tags each log record with the service name `WSO2-APIM`.
- The `otlp` exporter sends the logs to your backend over gRPC.




## Step 2 - Start services and verify

Once the configuration file is ready, start the OpenTelemetry Collector Contrib by pointing it to the `otel-collector-config.yaml` file you created.

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
    - Make sure the Collector has **read access** to the `wso2carbon.log` file specified in the `filelog` receiver.
    - The `file_storage` extension persists the read offset so that the Collector resumes from where it left off if restarted.

Once both the WSO2 APIM server and the OpenTelemetry Collector are running, the Collector will begin tailing the log file and forwarding structured log records to your backend automatically.


