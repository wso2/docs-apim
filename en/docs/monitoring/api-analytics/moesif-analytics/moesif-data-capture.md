# Capturing Request and Response Data

By default, a Moesif analytics event describes an API invocation without carrying its content: you get the
API, the operation, the response code, the latencies and the identity fields, but not the headers or the
message bodies.

WSO2 API Manager can publish both, and each is a separate opt-in. This page covers what is captured, what
is never captured, and how to configure each option.

!!! note "Analytics must be enabled first"
    Both options require analytics itself to be enabled and pointed at Moesif. See
    [Moesif Analytics Integration]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-integration-guide/) for the base configuration.

## Capturing Request and Response Headers

By default, request and response headers are **not** sent to Moesif. To include them, set
`send_headers` to `true`:

```toml
[apim.analytics.properties]
send_headers = true
```

Headers are then published as the `requestHeaders` and `responseHeaders` fields of the analytics
event, and appear on the request and response in Moesif.

### Headers That Are Never Published

Regardless of your configuration, the following headers are excluded from the analytics event, in
both the request and the response direction. You do not need to configure anything to protect them:

| **Header** | **Why it is excluded** |
|------------|------------------------|
| `Authorization` | Carries the bearer token or basic credentials used to invoke the API |
| `apikey` | Carries the API key used to invoke the API |
| `Cookie` | Carries client session state |
| `Set-Cookie` | Carries session state issued to the client |

!!! note "This affects analytics only, not your API traffic"
    These headers are dropped from the copy of the headers that is published to Moesif. The messages
    themselves are not modified: the backend still receives all the request headers your client sent, and the client still receives all the response headers your backend
    returned.

Header names are matched **case-insensitively**, so `authorization`, `Authorization` and
`AUTHORIZATION` are all excluded. This also means headers sent by HTTP/2 clients, which lowercase all
header names, are captured and matched correctly.

!!! warning "Custom authorization headers are not removed automatically"
    If an API is configured to accept its credentials in a **custom** header name rather than the
    default `Authorization` or `apikey`, that header is not recognised at this layer and is **not**
    removed automatically. Mask it explicitly using
    [`[apim.analytics.mask]`]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-masking/).

To hide the value of any other header without removing the header itself, see
[Privacy and Data Masking]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-masking/).

## Capturing Request and Response Bodies

WSO2 API Manager can also publish the request and response **bodies** to Moesif, where they appear on
the request and response of each event and can be searched, filtered and inspected alongside the
rest of your analytics data.

This is an opt-in feature. It is disabled by default because it publishes the full content of your
API traffic to Moesif and requires the gateway to hold each message in memory.

### Enabling Body Capture

Add the following to your `deployment.toml` file and restart the server:

```toml
[apim.analytics.properties]
send_payloads = true
payload_size_limit = 100000
capture_payloads_without_content_length = false
```

Body capture also requires analytics itself to be enabled (`[apim.analytics] enable = true`). When analytics is disabled, no body is captured and no message is built, even if `send_payloads` is `true`.

### Body Capture Configuration Reference

| **Name** | **Description** | **Default Value** | **Possible Data Types** | **Optional** |
|----------|-----------------|-------------------|-------------------------|--------------|
| send_payloads | Enables request and response body capture. | false | Boolean | Yes |
| payload_size_limit | Maximum size, in bytes, of a single captured body. A body larger than this is dropped from analytics; it is not truncated. The limit is applied separately to both the request body and the response body. | 100000 | Integer | Yes |
| capture_payloads_<wbr>without_<wbr>content_length | Whether to capture a body that does not declare a `Content-Length` header, for example a chunked response. | false | Boolean | Yes |

If `payload_size_limit` is set to a value that is not a positive integer, the default of `100000` is
used instead and a warning is logged once.

### What Is Captured

The body is captured according to its content type:

| **Payload** | **How it is published** |
|-------------|-------------------------|
| JSON | Parsed and published as a structured, searchable object. Because it is parsed rather than forwarded verbatim, whitespace and key formatting are not preserved |
| Plain text | Base64-encoded, and flagged to Moesif with a transfer encoding of `base64` |
| XML and SOAP | Serialized from the message body, then Base64-encoded and flagged with a transfer encoding of `base64` |
| Binary | Base64-encoded, and flagged to Moesif with a transfer encoding of `base64` |

A body is treated as JSON when its content type contains `json`, or when the body itself begins with `{`
or `[`. A body that is declared as JSON but fails to parse is Base64-encoded instead, as is anything else.
Moesif decodes Base64 bodies for display, so this affects how the body is transported rather than whether
you can read it in the Moesif UI.

The `Content-Type` of the captured body is published alongside it, so Moesif can label and parse the
body correctly even when `send_headers` is set to `false`.

### What Is Not Captured

A body is skipped in each of the following cases. In every one of them the full message is still
forwarded to the backend or the client; only the analytics copy is omitted.

- **Requests with no body**, such as `GET` and `DELETE`.
- **Server-sent events** (`text/event-stream`), **multipart payloads** (`multipart/*`, including
  file uploads), and **form submissions** (`application/x-www-form-urlencoded`).
- **Content types with no registered message builder.** The gateway consults the message builders
  registered in `<APIM-HOME>/repository/conf/axis2/axis2.xml` and skips any content type it does not
  recognise, rather than risk corrupting a payload it cannot safely interpret. If you need a custom
  content type captured, register a message builder for it in `axis2.xml`.
- **WebSocket APIs.**
- **Asynchronous and streaming APIs**, such as SSE and webhook APIs.
- **Bodies larger than `payload_size_limit`** - see [Size Limits](#size-limits).
- **Bodies with no `Content-Length` header**, unless `capture_payloads_without_content_length` is
  enabled - see [Payloads Without a Content-Length](#payloads-without-a-content-length).

### Size Limits

`payload_size_limit` is measured in **bytes**, and is applied separately to the request body and the
response body.

A body that exceeds the limit is **dropped in its entirety, not truncated**. This is deliberate:
Moesif only ever receives a whole, valid body or no body at all, so a partial payload can never be
mistaken for the real one.

Where the payload declares its size through a `Content-Length` header, the check is applied *before*
the message is read into memory, so an oversized body is never buffered and the message is passed
straight through. A payload whose size only becomes known once it has been read is dropped after the
fact, so it is still subject to the re-serialization behaviour described in
[Impact on Request Forwarding](#impact-on-request-forwarding).

### Payloads Without a Content-Length

A body sent with chunked transfer encoding does not declare a `Content-Length`, so its size cannot be
checked before it is read. By default, such bodies are skipped, which keeps the default configuration
memory-safe.

Set `capture_payloads_without_content_length = true` to capture them anyway.

!!! warning "Memory impact"
    With this setting enabled, a chunked body is read into memory in full and only then discarded if
    it turns out to exceed `payload_size_limit`. A large chunked payload under load can therefore
    exhaust the gateway's heap. Enable it only if you need these bodies and have verified you have
    the memory headroom for them.

### Bodies Are Never Masked

!!! warning "Captured bodies are published in full"
    The masking options under `[apim.analytics.mask]` apply to identity fields and to named headers.
    They do **not** apply to request or response bodies. When `send_payloads` is enabled, every
    captured body is published to Moesif exactly as it appeared, including any personal data,
    credentials, payment details or other sensitive content it contains.

    There is no field-level redaction and no per-API opt-out, the setting is on or off for the
    entire gateway. Before enabling it in production, confirm that publishing the full content of
    your API traffic to Moesif is compatible with your organisation's data protection policies.

### Impact on Request Forwarding

!!! warning "Bodies are re-serialized when capture is enabled"
    Capturing a body requires the gateway to build the message, which means the message is
    re-serialized when it is forwarded. The forwarded body remains semantically equivalent, but it
    is **not guaranteed to be byte-identical** to what the client sent. Whitespace, attribute and
    namespace ordering, JSON key formatting and chunking may all differ.

    As a result, a signature computed over the raw bytes of the body (such as a JWS, an
    HMAC-signed request body or a WS-Security signature) may fail to verify at the backend while
    `send_payloads` is enabled. If any of your APIs rely on body signatures, do not enable body
    capture for that gateway.

### Performance and Memory Considerations

Enabling `send_payloads` is more costly than the rest of the analytics pipeline:

- Each captured message is held in memory in full and re-serialized when forwarded, rather than
  being streamed straight through.
- Event sizes grow with your payload sizes, increasing the volume published to Moesif.

Keep `payload_size_limit` no larger than you actually need, leave
`capture_payloads_without_content_length` disabled unless required, and validate the configuration
under representative load before rolling it out to production.

### Troubleshooting Body Capture

When a body is missing from Moesif, the gateway records the reason at debug level. Enable debug
logging for the capture utility by adding the following to
`<APIM-HOME>/repository/conf/log4j2.properties`:

```properties
logger.analytics-payload.name = org.wso2.carbon.apimgt.gateway.handlers.analytics.AnalyticsPayloadUtil
logger.analytics-payload.level = DEBUG
```

Add `analytics-payload` to the comma-separated `loggers` list at the top of the same file, then
invoke the API again and check `<APIM-HOME>/repository/logs/wso2carbon.log`. Each skipped or dropped
body is logged with the reason and the direction, for example:

```
Dropping response body from analytics: 250000 bytes exceeds payload_size_limit of 100000. Increase payload_size_limit to capture it.
```

## Troubleshooting Missing Bodies

If events reach Moesif but the bodies are missing:

1. **Verify the Configuration**: Confirm that `send_payloads = true` is set under
   `[apim.analytics.properties]` and that the server has been restarted since the change
2. **Check the Exclusions**: Confirm the payload is not one of the types that are never captured,
   such as a multipart upload, a form submission or a server-sent event stream, see
   [What Is Not Captured](#what-is-not-captured)
3. **Check the Size Limit**: A body larger than `payload_size_limit` is dropped rather than
   truncated. Raise the limit if you need larger bodies captured
4. **Check for a Missing Content-Length**: A chunked payload is skipped unless
   `capture_payloads_without_content_length` is enabled
5. **Enable Debug Logging**: The gateway logs the exact reason each body was skipped, see
   [Troubleshooting Body Capture](#troubleshooting-body-capture)

