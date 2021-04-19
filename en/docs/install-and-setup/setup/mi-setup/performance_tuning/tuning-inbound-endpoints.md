# Tuning Inbound Endpoints

See the following topics to tune the HTTP and Kafka inbound endpoints.

## Tuning the HTTP Inbound

By default inbound endpoints share the PassThrough transport worker pool to handle incoming requests. If you need a separate worker pool for the inbound endpoint to increase the performance, you need to configure the [HTTP worker pool parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/http-inbound-endpoint-properties/#worker-pool-configuration-properties) when <b>creating the inbound endpoint</b>.

## Tuning the Kafka inbound

Open the deployment.toml file, and change the inbound thread pool size based on your use case. Recommended values are specified below.

```toml
[[mediation]]
inbound.core_threads = 200 
inbound.max_threads = 1000   
```
See the [descriptions of the parameters]({{base_path}}/reference/config-catalog-mi/#message-mediation).

When you **create your inbound endpoint**, set the [sequential]({{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/kafka-inbound-endpoint-properties) parameter to `false` for better performance.
