# Monitoring Traces with Moesif

[Moesif](https://www.moesif.com/) supports OpenTelemetry trace ingestion over OTLP/HTTP. WSO2 API Manager can export its gateway spans to Moesif, so you can inspect each API invocation, follow a request across the gateway and the backend, and see where latency and failures originate.

## How Trace Data Reaches Moesif

The gateway creates an OpenTelemetry trace for each sampled API invocation and exports its spans to Moesif using the OTLP/HTTP protocol. Moesif groups the spans by trace ID and maps each HTTP span to an API event, which you can inspect in the **Trace Explorer** or the **Live Event Log**.

<div style="text-align:center;">
  <a href="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png">
    <img src="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png" alt="Moesif integration data flow">
  </a>
</div>

The gateway propagates the W3C `traceparent` header to the backend. If the backend is also instrumented with OpenTelemetry, its spans join the same trace. Spans from the gateway also carry a `span.activity.id` attribute, which corresponds to the WSO2 API Manager correlation ID and can be searched in the gateway logs.

## Prerequisites

Before you begin, ensure you have:

- WSO2 API Manager 4.7.0 or later
- A Moesif account and a Moesif Collector Application ID
- Outbound HTTPS (port 443) access from the gateway to `https://api.moesif.net` (or `https://eu.api.moesif.net` for an EU organization)
- (Optional) A backend service that is instrumented with OpenTelemetry and accepts the W3C `traceparent` header, if you want end-to-end traces across the gateway and the backend

## Step 1: Create a Moesif Account and Obtain the Application ID

1. Create a [Moesif account](https://www.moesif.com/signup) if you don't already have one.

2. Once logged in, obtain your **Collector Application ID** by navigating to:

    ```
    Account → API Keys → Collector Application Id
    ```

    <a href="{{base_path}}/assets/img/analytics/moesif/moesif-application-id.png">
        <img src="{{base_path}}/assets/img/analytics/moesif/moesif-application-id.png" alt="Moesif application id"/>
    </a>


## Step 2: Enable OTLP Trace Export to Moesif

1. Navigate to the `<APIM-HOME>/repository/conf` directory and open `deployment.toml`.
2. Add the following configuration:

    ```toml
    [apim.open_telemetry]
    remote_tracer.enable = true
    remote_tracer.name = "otlp"
    remote_tracer.protocol = "http"
    remote_tracer.url = "https://api.moesif.net/v1/traces"

    [[apim.open_telemetry.remote_tracer.properties]]
    name = "X-Moesif-Application-Id"
    value = "YOUR_MOESIF_APPLICATION_ID"
    ```

3. Replace `YOUR_MOESIF_APPLICATION_ID` with the Application ID obtained in step 1.

!!! important "Configuration placement"
    When adding configurations that start with `apim.` (such as `[apim.open_telemetry]`) to `deployment.toml`, ensure that you place them after any existing `apim` configuration blocks in the file. Alternatively, you can add these configurations at the end of the file. Placing `apim.` configurations before the existing `apim` block may cause the product startup to fail.

!!! note
    - `remote_tracer.protocol` must be `"http"`. Moesif accepts OTLP over HTTP only, and the OpenTelemetry exporter defaults to gRPC when the protocol is not set.
    - `remote_tracer.url` must be the full OTLP/HTTP endpoint, including the `/v1/traces` path.
    - Only one authentication header is supported. If multiple entries are added under `[[apim.open_telemetry.remote_tracer.properties]]`, only the first one is used.
    - Only one remote tracer can be enabled at a time.
    - For a Moesif organization in the EU region, use `https://eu.api.moesif.net/v1/traces`. An Application ID from one region is rejected by the other region.

Moesif maps the exported span attributes to its API event fields. For the complete mapping, see the [Moesif OpenTelemetry integration guide](https://www.moesif.com/docs/server-integration/open-telemetry/).

### Optional: Distinguish Gateways with Resource Attributes

You can tag every exported span with the gateway name and the deployment environment, which is useful when you run multiple gateways or environments:

```toml
[[apim.open_telemetry.resource_attributes]]
name = "service.name"
value = "API:Gateway"

[[apim.open_telemetry.resource_attributes]]
name = "deployment.environment"
value = "Production"
```

When `service.name` is not configured, it defaults to `API:Gateway`.

## Step 3: Restart the Server

Restart WSO2 API Manager for the changes to take effect:

```bash
cd <APIM-HOME>/bin
./api-manager.sh stop
./api-manager.sh start
```

## Step 4: View Traces in Moesif

1. Log in to the [Moesif Portal](https://www.moesif.com/wrap).

2. Select **+ Create New** and then select **Trace Explorer** from the **API Observability** section. For more information, see the [Moesif Trace Explorer documentation](https://www.moesif.com/docs/api-analytics/otel-trace-explorer/).

    <a href="{{base_path}}/assets/img/analytics/moesif/moesif-traces.png">
        <img src="{{base_path}}/assets/img/analytics/moesif/moesif-traces.png" alt="Moesif Trace Explorer showing WSO2 API Manager spans"/>
    </a>

3. Invoke an API and search for its trace, or open the **Live Event Log** to see the individual spans as events.

    <a href="{{base_path}}/assets/img/analytics/moesif/moesif-live-eventlog-traces.png">
        <img src="{{base_path}}/assets/img/analytics/moesif/moesif-live-eventlog-traces.png" alt="Moesif Live Event Log with traces"/>
    </a>

Spans are exported in batches, so allow a few seconds for a trace to appear.

## Span Attributes Exported by WSO2 API Manager

The gateway exports the following attributes. Attribute names follow the [OpenTelemetry HTTP semantic conventions](https://opentelemetry.io/docs/specs/semconv/http/http-spans/).

| **Attribute** | **What it tells you** | **Present on** |
|---------------|-----------------------|----------------|
| `http.request.method` | HTTP method of the request, such as `GET` or `POST` | SERVER, CLIENT, and INTERNAL spans that record HTTP attributes |
| `url.scheme` | Protocol used, such as `https` | SERVER, CLIENT, and INTERNAL spans that record HTTP attributes |
| `url.path` | Request path as received by the gateway, without the query string, for example `/pizzashack/1.0.0/menu` | SERVER and INTERNAL spans |
| `url.full` | Full backend URL that was invoked, without the query string, for example `https://localhost:9443/am/sample/pizzashack/v1/api/menu` | CLIENT span only |
| `server.address` | Host that handled the request. On the SERVER span it is derived from the `Host` header; on the CLIENT span it is the backend host | SERVER and CLIENT spans (also INTERNAL spans that record HTTP attributes) |
| `server.port` | Port of the host above. | SERVER and CLIENT spans (also INTERNAL spans that record HTTP attributes) |
| `http.route` | Matched route template, including the API context and, when the version is part of the URL, the API version, such as `/pizzashack/1.0.0/menu` or `/pizzashack/1.0.0/order/{orderId}` | SERVER span only |
| `http.response.status_code` | HTTP status code returned to the client, or by the backend on the CLIENT span, such as `200`, `401`, or `500` | SERVER, CLIENT, resource, and response-phase INTERNAL spans |
| `error.type` | Status code as a string, set only when the span status is `ERROR` | SERVER span on 5xx; CLIENT span on 4xx and 5xx |
| `span.endpoint` | Backend endpoint configured for the API, such as `https://localhost:9443/am/sample/pizzashack/v1/api/` | CLIENT span only |
| `span.activity.id` | Correlation ID of the request, which can be searched in the gateway logs | SERVER span only |
| `span.api.name`, `span.api.version`, `span.resource`, `span.consumerkey` | API name, API version, matched resource template without the API context, and the consumer key of the calling application | SERVER span |

!!! note
    - The query string is intentionally excluded from both `url.path` and `url.full`, so query parameters are never exported.
    - WSO2-specific attributes such as `span.activity.id`, `span.api.name`, and `span.consumerkey` do not have dedicated Moesif fields. Moesif stores them in the event `metadata`, where you can filter on them.
    - `http.route` includes the API context and, when URL-based versioning is used, the API version. `span.resource` remains the bare resource template. For example, a request to the `/menu` resource of the `/pizzashack` API records `http.route` as `/pizzashack/1.0.0/menu` and `span.resource` as `/menu`. Use `http.route` to group traffic from different APIs and `span.resource` to group resources within an API.
    - `error.type` and `http.route` are also stored in `metadata` rather than in first-class Moesif fields. `http.response.status_code` is mapped to the event response status.

## Analyzing Traces

### Latency Breakdown

Use the span durations to find where time is spent:

- A large `API:Backend_Latency` span points to the backend service.
- A large `API:Request_Mediation_Latency` or `API:Response_Mediation_Latency` span points to the gateway's mediation logic.
- The SERVER span shows the total gateway handling time, and its child spans account for the individual phases.

## Privacy and Sensitive Data

The trace exporter sends only the span attributes listed above. It does not export request or response headers or bodies.

- Query strings are removed from `url.path` and `url.full`, so query parameters never reach Moesif.
- Path parameters are not masked. A request to `/order/12345` is exported as `/order/12345`. If path segments contain sensitive identifiers, review the API's resource paths before enabling trace export.
- `server.address` exposes the host names used by the gateway and the backend. On the SERVER span it comes from the `Host` header, so behind a proxy or load balancer it is the address the gateway sees.
- The gateway does not export client IP addresses, user agents, or end-user IDs by default. If you need them in Moesif, add the corresponding OpenTelemetry attributes in your mediation flow.
- `span.consumerkey` identifies the calling application. Treat it as sensitive and restrict access to Moesif accordingly.

!!! warning "Do not embed credentials in endpoint URLs"
    A URL can carry a user name and password in its userinfo component, for example `https://wso2:password@www.wso2.com`. When an API's backend endpoint is configured this way, the gateway exports the endpoint URL verbatim in the `url.full` and `span.endpoint` attributes of the CLIENT span. The credentials are then stored in Moesif and are visible to anyone who can access that Moesif organization.

    The `user:password` format in the userinfo component is deprecated. [RFC 3986, Section 3.2.1](https://www.rfc-editor.org/rfc/rfc3986#section-3.2.1) deprecates its use for any purpose other than transmitting credentials to the server and states that applications should not render the data after the colon in clear text. For HTTP, [RFC 9110, Section 4.2.4](https://www.rfc-editor.org/rfc/rfc9110#section-4.2.4) deprecates userinfo in `http` and `https` URIs entirely.

    - Do not put credentials in endpoint URLs, API definitions, or any other URL that the gateway exports.
    - Configure authentication on the endpoint definition instead, such as Basic Auth or OAuth, or store the credentials in a secure vault and reference them from the endpoint configuration.
    - If credentials have already been exported, rotate them. Removing the URL from the configuration does not remove the spans that Moesif has already stored.

## Troubleshooting

### No Traces Appear in Moesif

1. Verify that `remote_tracer.enable = true` and `remote_tracer.name = "otlp"` are set under `[apim.open_telemetry]`.
2. Verify that `remote_tracer.protocol = "http"` is set. Without it, the exporter uses gRPC, which Moesif does not accept.
3. Verify that `remote_tracer.url` ends with `/v1/traces`.
4. Verify that the `X-Moesif-Application-Id` header value matches the Collector Application ID in your Moesif account.
5. Confirm that the gateway can reach the Moesif endpoint over HTTPS on port 443.
6. Confirm that the server was restarted after the configuration change.
7. Confirm that no other remote tracer is enabled at the same time.

### Moesif Returns 403

The Application ID does not match the region of the endpoint. Use `https://api.moesif.net/v1/traces` for a global organization and `https://eu.api.moesif.net/v1/traces` for an EU organization.

### A Trace Cannot Be Found by Its Trace ID

- Allow a few seconds for the batch exporter to publish the spans.
- Confirm that the request carried a sampled `traceparent` header. With the default parent-based sampler, a parent context with the sampled flag turned off produces no spans.
- Confirm that you are searching in the region that matches your organization.

## Additional Resources

- [Moesif OpenTelemetry integration](https://www.moesif.com/docs/server-integration/open-telemetry/) - how span attributes are mapped to Moesif fields
- [Moesif Trace Explorer](https://www.moesif.com/docs/api-analytics/otel-trace-explorer/) - viewing traces and spans in Moesif
- [Correlation Logs]({{base_path}}/monitoring/observability/monitoring-correlation-logs/) - correlating requests with gateway logs
- [Moesif Analytics Integration Guide]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-integration-guide/) - request and response level analytics events, including headers, bodies, and masking
