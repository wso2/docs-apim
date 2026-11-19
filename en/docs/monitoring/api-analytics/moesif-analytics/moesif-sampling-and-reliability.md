# Sampling and Reliability

This page covers two independent features that control **how much** analytics data reaches Moesif and **what
happens when Moesif cannot be reached**:

- **Dynamic sampling** publishes only a percentage of your API invocations, so you can keep analytics on
  across high-traffic APIs without publishing every single call. It is disabled by default.
- **The retry queue** holds events in memory while publishing to Moesif fails with a retryable error, and
  sends them once Moesif recovers, instead of discarding them. It is **enabled by default**.

!!! note "Analytics must be enabled first"
    Both features require analytics itself to be enabled and pointed at Moesif. See
    [Moesif Analytics Integration]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-integration-guide/)
    for the base configuration.

## Dynamic Sampling

With dynamic sampling enabled, the gateway publishes only a share of the analytics events it builds. Each
published event carries a **weight**, so Moesif can extrapolate counts and metrics back to your full
traffic volume rather than under-reporting it.

!!! note "Sample rates are defined in Moesif, not in deployment.toml"
    WSO2 API Manager does not decide the sample rate. It **opts in** to sampling and supplies a fallback
    rate; the rates themselves come from your Moesif application configuration, where you define a global
    sample rate and, optionally, per-user rates and sampling rules. Changing a rate in Moesif takes effect on
    the gateway within `sampling_refresh_interval_ms` and does **not** require a restart.

### Enabling Dynamic Sampling

Add the following to your `deployment.toml` file and restart the server:

```toml
[apim.analytics.properties]
sampling_enabled = true
sampling_refresh_interval_ms = 60000
sampling_fallback_rate = 100
```

### Sampling Configuration Reference

| **Name** | **Description** | **Default Value** | **Possible Data Types** | **Optional** |
|----------|-----------------|-------------------|-------------------------|--------------|
| sampling_enabled | Enables dynamic sampling when set to `true` (case-insensitive). Any other value leaves sampling disabled, and every event is published. | false | Boolean | Yes |
| sampling_refresh_<wbr>interval_ms | How often, in milliseconds, the gateway re-fetches the sampling configuration from Moesif. Must be a positive integer. | 60000 | Integer | Yes |
| sampling_fallback_rate | Percentage of events to publish until the sampling configuration has first been fetched from Moesif. `100` publishes everything. A value outside 0-100 is clamped to that range. | 100 | Integer (0-100) | Yes |

If a numeric property is set to a value that cannot be parsed as a number, the default is used instead and
a warning is logged. Values are not otherwise validated: `sampling_refresh_interval_ms` must be a positive
integer, and a value of `0` or below is not supported and can stop analytics events from being published.

### How the Sample Rate Is Chosen

For each event, the rate is chosen from your Moesif application configuration as follows:

1. If the event's user has a **per-user** rate defined in Moesif, that rate is a candidate.
2. If one of your Moesif **sampling rules** matches the event, the rate of the first matching rule is also
   a candidate.
3. If there is at least one candidate, the **lowest** candidate rate applies. Otherwise, the **global**
   sample rate applies.

Per-company rates have no effect, because WSO2 API Manager does not send a company ID with its events, so
no event can match one. Until the sampling configuration has first been fetched, `sampling_fallback_rate`
takes the place of the whole configuration, see
[When the Sampling Configuration Cannot Be Fetched](#when-the-sampling-configuration-cannot-be-fetched).

The resulting rate is clamped to the range 0-100 and applied as follows:

| **Rate** | **Behavior** |
|----------|---------------|
| 100 or above | Every event is published |
| 1 to 99 | Each event is published with that probability, decided independently per event |
| 0 or below | No event is published |

The decision is made per event, not per batch. When every event in a batch is sampled out, the gateway
publishes nothing for that batch and makes no event-publish call to Moesif. The periodic configuration
refresh described below still runs on its own schedule.

### Defining Per-User Rates and Sampling Rules

When you define rates in Moesif, keep in mind which values WSO2 API Manager sends with each event:

- **Per-user rates** are matched against the event's user ID. This is the username of the user who invoked
  the API, with the `@carbon.super` suffix removed for super tenant users. Invocations without a username
  are sent with the user ID `UNKNOWN`.
- **Sampling rules** are evaluated against the request method, the response status, the client IP address
  and the request route. WSO2 API Manager does not send an absolute request URL, so the route is always `/`
  and cannot be used to tell APIs apart. Conditions on any other field, including the request body, are
  ignored, and a rule made up only of such conditions never matches.
- **Faulty events** do not carry a client IP address, so a rule that matches on the IP address only ever
  applies to successful invocations.

### Sampling Weights and Metric Accuracy

Each published event is stamped with a weight of `100 / rate`, rounded down. At a 10% sample rate, for
example, each published event carries a weight of 10, and Moesif multiplies it out so that request counts
and aggregate metrics approximate your full traffic. When sampling is disabled, events are sent without a
sampling weight, so each event counts once.

This means sampled metrics remain broadly accurate while individual invocations do not. Do not use a
sampled deployment to look for one specific API call, because that call has most likely not been published.

### When the Sampling Configuration Cannot Be Fetched

When no sampling configuration is available, `sampling_fallback_rate` decides what happens rather than the
event being dropped silently:

- Before the first successful fetch, `sampling_fallback_rate` applies. At its default of `100`, everything
  is published until Moesif's configuration arrives. Note that this rate is applied like any other, so
  setting it to `0` **discards** every event until the configuration has been fetched.
- If a later refresh fails, or returns a configuration that cannot be parsed, the gateway logs it and
  **keeps the previously fetched configuration** rather than falling back.

### Dynamic Sampling and Body Capture

Sampling is applied to the event **after** it has been built, which has two consequences when
[body capture]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-capture/) is also
enabled:

- An event that is sampled out is discarded together with its captured request and response bodies.
- An event that is sampled in keeps its bodies in full, and additionally carries the sampling weight.

Sampling therefore reduces how much payload data reaches Moesif, but it does **not** reduce the gateway's
memory cost of capturing that data in the first place. Every message is still read and held in memory
before the sampling decision is made.

!!! warning "Dynamic sampling applies to the standard gateway configuration only"
    Sampling is wired into the direct-key publishing path, which is the one you get when you set
    `type = "moesif"` and a `moesifKey` in `deployment.toml`. Deployments that resolve Moesif keys
    per organization through the Moesif microservice path do not apply sampling. The retry queue described
    below applies to both.

### Verifying Dynamic Sampling

On startup, confirm the following line in `<APIM-HOME>/repository/logs/wso2carbon.log`:

```
Moesif dynamic sampling enabled (refresh=60000ms, fallbackRate=100)
```

This line confirms that sampling is configured, not that it is being applied. It is also logged on the
Moesif microservice path, which does not apply sampling, and when `moesifKey` is empty.

If a configuration refresh fails, the gateway logs a warning and keeps the previous configuration. The
reason is either the HTTP status Moesif returned, followed by the start of its response body, or the
connection error:

```
Moesif app config fetch failed: HTTP Response [401] Not OK: <response body> — keeping previous config
```

If Moesif returns a configuration that cannot be parsed, the gateway logs
`Failed to parse Moesif app config response` as an error and also keeps the previous configuration.

## Reliability: The Retry Queue

When a publish fails with a retryable error, for example because Moesif cannot be reached or returns a 5xx
response, the gateway holds the affected analytics events in memory and publishes them once Moesif recovers,
rather than discarding them.

!!! info "This replaces the previous retry behavior and is enabled by default"
    Earlier releases retried a failed publish after a 10-second wait, blocking the publishing thread while
    waiting, made only a small fixed number of attempts, and then dropped the events. That has been
    replaced by the asynchronous retry queue described here, which is **on by default**. No configuration
    change is needed to get it. Disabling the retry queue does not bring back the previous retries: events
    are then dropped as soon as a publish fails.

### Retry Queue Configuration Reference

| **Name** | **Description** | **Default Value** | **Possible Data Types** | **Optional** |
|----------|-----------------|-------------------|-------------------------|--------------|
| retry_buffer_enabled | Enables the retry queue when set to `true` (case-insensitive), which is also the default when the property is not set. Any other value disables it, and events are dropped as soon as a publish fails. | true | Boolean | Yes |
| retry_buffer_size | Maximum number of **events** held for retry, counted **per Moesif API key**. Set it to at least `50`. | 10000 | Integer | Yes |
| retry_interval_seconds | How often, in seconds, the gateway probes Moesif and sends queued events. | 5 | Integer | Yes |
| retry_log_multiplier | Controls how often the repeated "still unreachable" error is logged. The interval is `retry_interval_seconds` × `retry_log_multiplier`, so 50 seconds by default. | 10 | Integer | Yes |
| retry_drain_burst_size | Controls the catch-up once Moesif becomes reachable again. At `2` or above, queued batches are sent in quick succession, `retry_drain_batch_delay_ms` apart. At `1`, a single catch-up batch is sent. At `0`, there is no catch-up. In every case, batches still queued once the catch-up ends are sent at the normal `retry_interval_seconds` cadence. | 5 | Integer | Yes |
| retry_drain_batch_<wbr>delay_ms | Delay, in milliseconds, between catch-up batches. | 100 | Integer | Yes |

As with the sampling properties, a value that cannot be parsed as a number falls back to the default with a
warning. Values are not otherwise validated, so keep each property within its supported range. Values
outside these ranges are not supported and can cause analytics events to be lost or stop analytics from
being published:

| **Name** | **Supported values** |
|----------|----------------------|
| retry_buffer_size | `50` or more. The gateway publishes events in batches of up to 50, so a smaller queue cannot hold a full batch |
| retry_interval_seconds | Positive integer |
| retry_log_multiplier | Positive integer |
| retry_drain_burst_size | `0` or a positive integer |
| retry_drain_batch_<wbr>delay_ms | Positive integer |

### How the Retry Queue Works

The queue behaves like a circuit breaker, one per Moesif API key:

1. **Open.** A retryable publish failure marks that key's queue unhealthy and stores the batch.
2. **Stash.** While unhealthy, subsequent batches are queued directly, with no HTTP call attempted. This
   avoids hammering an endpoint that is known to be down.
3. **Probe.** Every `retry_interval_seconds`, the gateway attempts to send the oldest queued batch. Only
   one queued batch is ever in flight per key. A failed probe puts the batch back at the front of the queue.
4. **Drain.** When a probe succeeds, the queue is marked healthy and new events are sent directly again.
   The gateway then catches up by sending queued batches in quick succession, `retry_drain_batch_delay_ms`
   apart, as configured by `retry_drain_burst_size`. Batches still queued once the catch-up ends are sent
   one per `retry_interval_seconds` until the queue is empty. Because new events are no longer queued,
   they can reach Moesif before older queued ones.

### Which Failures Are Retried

| **Outcome** | **Handling** |
|-------------|--------------|
| 5xx server errors | Retried |
| 408 Request Timeout, 429 Too Many Requests | Retried |
| Connection, timeout and other transport failures | Retried |
| Any other 4xx, such as 401 Unauthorized or 400 Bad Request | **Not retried.** Logged as an error and dropped |
| Any other status, such as a 3xx redirect | **Not retried.** Logged as an error |

This applies both to a regular publish and to batches already waiting in the queue. A queued batch that
Moesif rejects with a non-retryable status is dropped, and the gateway carries on sending the remaining
queued batches.

A 4xx other than 408 or 429 indicates a problem the gateway cannot resolve by waiting, most commonly an
invalid `moesifKey`, so those events are discarded rather than queued indefinitely. If events are
disappearing with an authorization error, correct the key rather than tuning the queue.

### When the Queue Is Full

`retry_buffer_size` is a cap on events, applied per Moesif API key. When a new batch does not fit, the
**oldest** queued batches are evicted until it does, so the queue always favors recent data. Batches are
evicted whole, so after an eviction the queue can hold fewer than `retry_buffer_size` events. A single
batch larger than `retry_buffer_size` cannot be stored at all and is dropped whole, with a warning. Because
the gateway publishes events in batches of up to 50, this only happens when `retry_buffer_size` is set
below the supported minimum of `50`.

Evicted events are counted and reported in the periodic error log, so a sustained outage tells you how much
data was lost. The count is cumulative since the server started.

### Memory and Sizing Considerations

The queue is held **in heap**, so `retry_buffer_size` is effectively a memory budget. Size it against your
event size rather than picking a large number: with body capture enabled, each event can carry a request
body and a response body of up to `payload_size_limit` each, plus headers and metadata, so 10,000 queued
events is a far larger footprint than it is with the default
configuration. Remember the cap is per Moesif API key, so a deployment using several keys can hold a
multiple of it.

!!! warning "Queued events are not persisted"
    The queue exists only in memory. Events still waiting for retry when the server stops are lost, and a
    restart during a Moesif outage discards everything queued up to that point. The queue protects against
    a Moesif or network outage, not against a gateway restart.

### Disabling the Retry Queue

To drop events as soon as a publish fails, with no retry, add the following and restart the server:

```toml
[apim.analytics.properties]
retry_buffer_enabled = false
```

This is worth doing if you would rather lose analytics data than spend heap on it, for example on a
memory-constrained gateway.

### Verifying and Troubleshooting the Retry Queue

On startup, confirm the queue is active:

```
Moesif retry queue enabled (capacity=10000 events per Moesif key, check interval=5s, log every 10 checks, catch-up burst=5 sends with 100ms delay between sends)
```

The `catch-up burst` value is the configured `retry_drain_burst_size`. It is not a count of catch-up
sends, see the [configuration reference](#retry-queue-configuration-reference) for what it controls.

During an outage, the gateway logs the first failure, then throttles the repeat to once every
`retry_interval_seconds` × `retry_log_multiplier`. The Moesif key is masked to its last four characters:

```
Cannot reach Moesif (key ...abcd). Queueing analytics events for retry (0/10000 events queued).
Moesif (key ...abcd) still unreachable after 50000 ms. Queued: 500/10000 events, dropped 0 events so far, retry attempts: 11
```

Recovery is logged with how long the outage lasted and how much is being flushed:

```
Moesif (key ...abcd) is reachable again after 65000 ms and 13 attempts. Sending 650 queued analytics events.
```

Some further pointers:

- **Events queued but never sent.** Check outbound connectivity to `moesif_base_url` from the gateway. The
  queue keeps probing indefinitely, so a queue that only grows means Moesif is still unreachable.
- **Events dropped with a status code.** A non-retryable response is logged as
  `... publishing failed. Moesif returned 401 due to error: ...` for a regular publish (on the Moesif
  microservice path, `... publishing failed for org <organization>. Moesif returned 401 due to error: ...`),
  and as `Moesif rejected ... these events will not be retried` for events that were already queued.
  Verify `moesifKey`, or on the microservice path, the Moesif key configured for that organization.
- **Events dropped with the retry queue disabled.** With `retry_buffer_enabled = false`, each failed publish
  is logged as `... (status ...); retry queue disabled, events will be dropped`.
