# Sampling and Reliability

Two independent features that control **how much** analytics data reaches Moesif and **what happens when Moesif
cannot be reached**:

- **Dynamic sampling** publishes only a percentage of your API invocations, so you can keep analytics on
  across high-traffic APIs without publishing every single call. It is disabled by default.
- **The retry queue** holds events in memory while Moesif is unreachable and sends them once it recovers,
  instead of discarding them. It is **enabled by default**.

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
    sample rate and, optionally, per-user and per-company rates. Changing a rate in Moesif takes effect on
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
| sampling_enabled | Enables dynamic sampling. Any value other than `true` leaves sampling disabled, and every event is published. | false | Boolean | Yes |
| sampling_refresh_<wbr>interval_ms | How often, in milliseconds, the gateway re-fetches the sampling configuration from Moesif. Must be a positive integer. | 60000 | Integer | Yes |
| sampling_fallback_rate | Percentage of events to publish when no sampling configuration has been fetched from Moesif yet, or when the fetched configuration carries no rate. `100` publishes everything. | 100 | Integer (0-100) | Yes |

If a numeric property is set to a value that cannot be parsed as a number, the default is used instead and
a warning is logged. Note that `sampling_refresh_interval_ms` is **not** range-checked: a value of `0` or
below is rejected by the scheduler and prevents the publisher from starting, so always set a positive
value.

### How the Sample Rate Is Chosen

For each event, the gateway applies the **most specific** rate that matches it:

1. The **per-user** rate, if the event's user has one defined in Moesif.
2. Otherwise the **per-company** rate, if the event's company has one.
3. Otherwise the **global** sample rate from your Moesif application configuration.
4. Otherwise `sampling_fallback_rate`.

The resulting rate is clamped to the range 0-100 and applied as follows:

| **Rate** | **Behaviour** |
|----------|---------------|
| 100 or above | Every event is published |
| 1 to 99 | Each event is published with that probability, decided independently per event |
| 0 or below | No event is published |

The decision is made per event, not per batch. When every event in a batch is sampled out, the gateway
publishes nothing for that batch and makes no event-publish call to Moesif. The periodic configuration
refresh described below still runs on its own schedule.

### Sampling Weights and Metric Accuracy

Each published event is stamped with a weight of approximately `100 / rate`. At a 10% sample rate, for
example, each published event carries a weight of 10, and Moesif multiplies it out so that request counts
and aggregate metrics still reflect your full traffic. When sampling is disabled, every event carries a
weight of 1.

This means sampled metrics remain broadly accurate while individual invocations do not. Do not use a
sampled deployment to look for one specific API call, because that call has most likely not been published.

### When the Sampling Configuration Cannot Be Fetched

When no sampling configuration is available, `sampling_fallback_rate` decides what happens rather than the
event being dropped silently:

- Before the first successful fetch, `sampling_fallback_rate` applies. At its default of `100`, everything
  is published until Moesif's configuration arrives. Note that this rate is applied like any other, so
  setting it to `0` **discards** every event until the configuration has been fetched.
- If a refresh fails or returns a non-successful status, the gateway logs a warning and **keeps the
  previously fetched configuration** rather than falling back.
- Sampling begins only once the publisher has started tracking your Moesif key, which it does as it
  publishes its first events after startup. Events handled before that point are published.

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

If a configuration refresh fails, you will see the fetched status and a note that the previous
configuration is being retained:

```
Moesif app config fetch returned status 401 - keeping previous config
```

## Reliability: The Retry Queue

When Moesif cannot be reached, the gateway holds the affected analytics events in memory and publishes them
once Moesif recovers, rather than discarding them.

!!! info "This replaces the previous retry behaviour and is enabled by default"
    Earlier releases retried a failed publish up to three times, ten seconds apart, on the publishing
    thread, and then dropped the events. That has been replaced by the asynchronous retry queue described
    here, which is **on by default**. No configuration change is needed to get it. To restore the previous
    drop-on-failure behaviour, set `retry_buffer_enabled = false`.

### Retry Queue Configuration Reference

| **Name** | **Description** | **Default Value** | **Possible Data Types** | **Optional** |
|----------|-----------------|-------------------|-------------------------|--------------|
| retry_buffer_enabled | Enables the retry queue. Any value other than `true` disables it, and events are dropped when a publish fails. | true | Boolean | Yes |
| retry_buffer_size | Maximum number of **events** held for retry, counted **per Moesif API key**. | 10000 | Integer | Yes |
| retry_interval_seconds | How often, in seconds, the gateway probes Moesif and drains queued events. Must be a positive integer. | 5 | Integer | Yes |
| retry_log_multiplier | Controls how often the repeated "still unreachable" error is logged. The interval is `retry_interval_seconds` x `retry_log_multiplier`, so 50 seconds by default. | 10 | Integer | Yes |
| retry_drain_burst_size | Maximum number of catch-up batches sent in quick succession once Moesif becomes reachable again. | 5 | Integer | Yes |
| retry_drain_batch_<wbr>delay_ms | Delay, in milliseconds, between those catch-up batches. | 100 | Integer | Yes |

As with the sampling properties, a value that cannot be parsed as a number falls back to the default with a
warning. None of these properties is range-checked, so set each within its supported range:

| **Name** | **Supported values** | **If set outside that range** |
|----------|----------------------|-------------------------------|
| retry_buffer_size | Positive integer | `0` or below means no batch ever fits, so every event is dropped instead of queued |
| retry_interval_seconds | Positive integer | `0` or below is rejected by the scheduler and prevents the publisher from starting |
| retry_log_multiplier | Positive integer | `0` or below removes the throttle, so every failed probe is logged |
| retry_drain_burst_size | Positive integer | `0` or below disables the catch-up burst; the queue still drains at the normal probe cadence |
| retry_drain_batch_<wbr>delay_ms | `0` or a positive integer | A negative value is treated as `0`, so catch-up batches are sent with no delay between them |

### How the Retry Queue Works

The queue behaves like a circuit breaker, one per Moesif API key:

1. **Open.** A retryable publish failure marks that key's queue unhealthy and stores the batch.
2. **Stash.** While unhealthy, subsequent batches are queued directly, with no HTTP call attempted. This
   avoids hammering an endpoint that is known to be down.
3. **Probe.** Every `retry_interval_seconds`, the gateway attempts to send the oldest queued batch. Only
   one probe is ever in flight. A failed probe puts the batch back at the front of the queue.
4. **Drain.** When a probe succeeds, the queue is marked healthy and catches up by sending up to
   `retry_drain_burst_size` batches spaced `retry_drain_batch_delay_ms` apart, then returns to the normal
   cadence until it is empty.

All retry queues share a single two-thread scheduler, so the number of Moesif keys in play does not change
the thread count.

### Which Failures Are Retried

| **Outcome** | **Handling** |
|-------------|--------------|
| 5xx server errors | Retried |
| 408 Request Timeout, 429 Too Many Requests | Retried |
| Connection, timeout and other transport failures | Retried |
| Any other 4xx, such as 401 Unauthorized or 400 Bad Request | **Not retried.** Logged as an error and dropped |

A 4xx other than 408 or 429 indicates a problem the gateway cannot resolve by waiting, most commonly an
invalid `moesifKey`, so those events are discarded rather than queued indefinitely. If events are
disappearing with an authorization error, correct the key rather than tuning the queue.

### When the Queue Is Full

`retry_buffer_size` is a cap on events, applied per Moesif API key. When a new batch does not fit, the
**oldest** queued batches are evicted until it does, so the queue always favours recent data. A single
batch larger than `retry_buffer_size` cannot be stored at all and is dropped whole, with a warning:

```
Cannot queue 20000 analytics events at once (max 10000 per Moesif key); these events are dropped
```

Evicted events are counted and reported in the periodic error log, so a sustained outage tells you how much
data was lost.

### Memory and Sizing Considerations

The queue is held **in heap**, so `retry_buffer_size` is effectively a memory budget. Size it against your
event size rather than picking a large number: with body capture enabled, each event can approach
`payload_size_limit` in size, so 10,000 queued events is a far larger footprint than it is with the default
configuration. Remember the cap is per Moesif API key, so a deployment using several keys can hold a
multiple of it.

!!! warning "Queued events are not persisted"
    The queue exists only in memory. Events still waiting for retry when the server stops are lost, and a
    restart during a Moesif outage discards everything queued up to that point. The queue protects against
    a Moesif or network outage, not against a gateway restart.

### Disabling the Retry Queue

To go back to dropping events when a publish fails, add the following and restart the server:

```toml
[apim.analytics.properties]
retry_buffer_enabled = false
```

This is worth doing if you would rather lose analytics data than spend heap on it, for example on a
memory-constrained gateway.

### Verifying and Troubleshooting the Retry Queue

On startup, confirm the queue is active:

```
Moesif retry queue enabled (capacity=10000 events per Moesif key, check interval=5s, ...)
```

During an outage, the gateway logs the first failure, then throttles the repeat to once every
`retry_interval_seconds` x `retry_log_multiplier`. The Moesif key is masked to its last four characters:

```
Cannot reach Moesif (key ...abcd). Queueing analytics events for retry (50/10000 events queued).
Moesif (key ...abcd) still unreachable after 50000 ms. Queued: 500/10000 events, dropped 0 events so far, retry attempts: 10
```

Recovery is logged with how long the outage lasted and how much is being flushed:

```
Moesif (key ...abcd) is reachable again after 65000 ms and 13 attempts. Sending 650 queued analytics events.
```

Some further pointers:

- **Events queued but never sent.** Check outbound connectivity to `moesif_base_url` from the gateway. The
  queue keeps probing indefinitely, so a queue that only grows means Moesif is still unreachable.
- **Events dropped with a status code.** A `Moesif rejected ... these events will not be retried` message
  means a non-retryable response. Verify `moesifKey`.
- **Analytics threads failing.** Uncaught errors in the analytics publisher threads are now logged as
  `Uncaught error in analytics publisher thread <name>`. These indicate a publisher-side problem worth
  reporting, not a configuration issue.
