# Moesif Analytics Integration

Moesif-powered WSO2 Analytics replaces Choreo Analytics for enhanced insights and observability.

## Overview

This guide outlines the steps required to integrate **Moesif Analytics** with **WSO2 API Manager**. The integration enables you to collect and publish API analytics data to the **Moesif dashboard**, providing insights into API usage, traffic trends, and error tracking in near real-time.

### Prerequisites

Before you begin, ensure you have:

- WSO2 API Manager 4.7.0
- Administrative access to WSO2 APIM configuration files
- A valid email address for Moesif account creation
- Estimated setup time: 5-10 minutes

### Analytics Data Flow

The Moesif integration captures both **successful** and **failed** API invocations in WSO2 API Manager and publishes them to your Moesif dashboard in near real-time. This allows for powerful analytics and monitoring capabilities.

<div style="text-align:center;">
  <a href="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png">
    <img src="{{base_path}}/assets/img/analytics/moesif/moesif-data-flow.png" alt="Moesif integration diagram">
  </a>
</div>

### In This Section

This page covers the base setup. The rest of the Moesif documentation is organized as follows:

| **Page** | **Covers** |
|----------|------------|
| [Capturing Request and Response Data]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-capture/) | Publishing HTTP headers and message bodies |
| [Sampling and Reliability]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-sampling-and-reliability/) | Publishing only a share of invocations, and holding events for retry when Moesif is unreachable |
| [Privacy and Data Masking]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-masking/) | Masking IP addresses, usernames and sensitive headers before they reach Moesif |
| [Analytics Event Reference]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-event-reference/) | Every parameter carried by the response and faulty event types |
| [Analytics Dashboards]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-analytics-dashboards/) | Reading the dashboards Moesif provides for WSO2 API Manager |

## Step 1: Set Up Your Moesif Account

### 1.1 Create an Account and Log In

1. Go to [Moesif's official website for WSO2 API Manager](https://www.moesif.com/wrap/basic?onboard=true)
2. Sign up for a new account or log in to your existing account
3. Follow the onboarding wizard to get the Moesif Key
4. Copy the **Moesif API Key** from the **API Keys** section (you will need this in Step 2)

!!! note
    For more detailed instructions and advanced configuration options, refer to the official
    [Moesif Documentation](https://www.moesif.com/docs).

## Step 2: Configure WSO2 API Manager

To enable Moesif analytics in WSO2 APIM, you need to update the `deployment.toml` configuration file.

### 2.1 Configure the deployment.toml File

1. Navigate to the `<APIM-HOME>/repository/conf` directory
2. Open the `deployment.toml` file in a text editor
3. Add or update the `apim.analytics` configuration with the following:

```toml
[apim.analytics]
enable = true
type = "moesif"

[apim.analytics.properties]
moesifKey = "YOUR_MOESIF_API_KEY_HERE"
moesif_base_url = "https://api.moesif.net"
send_headers = false
send_payloads = false
payload_size_limit = 100000
capture_payloads_without_content_length = false
```

Replace `YOUR_MOESIF_API_KEY_HERE` with the actual API key you copied from Step 1.4.

### Configuration Parameters

| **Name** | **Description** | **Default Value** | **Possible Data Types** | **Optional** |
|----------|-----------------|-------------------|-------------------------|--------------|
| enable | Enable/Disable Analytics. Analytics is off unless you set this to `true`. | false | Boolean | Yes |
| type | Type of Analytics platform. Set this to `moesif` to publish to Moesif. | - | String | No |
| moesifKey | Moesif API Key | - | String | No |
| moesif_base_url | Base URL of Moesif API | https://api.moesif.net | String | Yes |
| send_headers | Whether to send request and response headers to Moesif. See [Capturing Request and Response Headers]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-capture/#capturing-request-and-response-headers). | false | Boolean | Yes |
| send_payloads | Whether to send request and response bodies to Moesif. See [Capturing Request and Response Bodies]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-capture/#capturing-request-and-response-bodies). | false | Boolean | Yes |
| payload_size_limit | Maximum size, in bytes, of a single request or response body captured for analytics. Applies only when `send_payloads` is `true`. | 100000 | Integer | Yes |
| capture_payloads_<wbr>without_<wbr>content_length | Whether to capture bodies that do not declare a `Content-Length` header, such as chunked responses. Applies only when `send_payloads` is `true`. | false | Boolean | Yes |
| sampling_enabled | Whether to publish only a sampled share of API invocations. Sample rates come from Moesif, not from this file. See [Dynamic Sampling]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-sampling-and-reliability/#dynamic-sampling). | false | Boolean | Yes |
| sampling_refresh_<wbr>interval_ms | How often, in milliseconds, the sampling configuration is re-fetched from Moesif. Applies only when `sampling_enabled` is `true`. | 60000 | Integer | Yes |
| sampling_fallback_rate | Percentage of events to publish when no sampling configuration has been fetched from Moesif yet. Applies only when `sampling_enabled` is `true`. | 100 | Integer (0-100) | Yes |
| retry_buffer_enabled | Whether to hold analytics events in memory while Moesif is unreachable and publish them on recovery. Enabled unless you set this to `false`. See [Reliability: The Retry Queue]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-sampling-and-reliability/#reliability-the-retry-queue). | true | Boolean | Yes |
| retry_buffer_size | Maximum number of events held for retry, per Moesif API key. | 10000 | Integer | Yes |
| retry_interval_seconds | How often, in seconds, Moesif is probed and queued events are drained. | 5 | Integer | Yes |
| retry_log_multiplier | Multiplier applied to `retry_interval_seconds` to decide how often the repeated "still unreachable" error is logged. | 10 | Integer | Yes |
| retry_drain_burst_size | Maximum number of catch-up batches sent in quick succession once Moesif is reachable again. | 5 | Integer | Yes |
| retry_drain_batch_<wbr>delay_ms | Delay, in milliseconds, between those catch-up batches. | 100 | Integer | Yes |

Only `enable`, `type` and `moesifKey` are needed to get started. Every other property is optional and is
explained on the page it belongs to, linked from the table above.

All of these properties are node-level: they apply to every API deployed on the gateway, and changing any
of them requires a restart. There is no per-API or per-resource override. The one exception is the
**sampling rates** themselves, which are defined in Moesif rather than here: those take effect within
`sampling_refresh_interval_ms` and need no restart.

### 2.2 Restart WSO2 API Manager

After saving the configuration changes, restart WSO2 API Manager for the changes to take effect:

```bash
cd <APIM-HOME>/bin
./api-manager.sh stop
./api-manager.sh start
```

## Troubleshooting

### Analytics Data Not Appearing in Moesif

If you don't see data in your Moesif dashboard after configuration:

1. **Verify the API Key**: Ensure the `moesifKey` in `deployment.toml` matches the key from your Moesif account
2. **Check WSO2 Logs**: Review `<APIM-HOME>/repository/logs/wso2carbon.log` for analytics-related errors
3. **Confirm Restart**: Ensure you restarted WSO2 APIM after making configuration changes
4. **Test API Invocation**: Make a test API call and wait 2-3 minutes for data to appear in Moesif
5. **Network Connectivity**: Verify that your WSO2 APIM server can reach `https://api.moesif.net`

### Fewer Events in Moesif Than API Calls

If Moesif shows fewer events than you invoked, check whether dynamic sampling is enabled:

1. **Check `sampling_enabled`**: if it is `true`, only a share of invocations is published by design
2. **Check the rates in Moesif**: the effective rate comes from your Moesif application configuration, not
   from `deployment.toml`, so a low global, per-user or per-company rate reduces what you see
3. **Check the aggregate metrics rather than the event list**: published events carry a weight, so request
   counts and metrics still reflect full traffic even though individual calls are missing, see
   [Sampling Weights and Metric Accuracy]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-sampling-and-reliability/#sampling-weights-and-metric-accuracy)

If sampling is disabled and events are still missing, confirm that Moesif is reachable. While the retry
queue is enabled, which it is by default, events that cannot be published are queued rather than sent and
appear once Moesif recovers. If you have set `retry_buffer_enabled = false`, they are dropped instead. See
[Verifying and Troubleshooting the Retry Queue]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-sampling-and-reliability/#verifying-and-troubleshooting-the-retry-queue).

### Common Configuration Errors

- **Missing or Invalid API Key**: Double-check that the Moesif API key is correctly copied without extra spaces
- **Configuration Syntax Errors**: Ensure proper TOML syntax in `deployment.toml` (proper quotes, brackets, etc.)
- **Firewall Issues**: Ensure outbound HTTPS connections to Moesif are allowed
- **Invalid Payload Size Limit**: A `payload_size_limit` that is not a positive integer is ignored, and the default of `100000` bytes is used instead. A warning is logged when this happens

### Performance Considerations

Enabling analytics introduces minimal overhead:

- **Latency Impact**: Typically less than 5ms per API call (asynchronous processing)
- **Resource Usage**: Minimal CPU and memory impact due to efficient event batching
- **Network**: Events are batched and sent in the background to minimize network calls

These figures apply to the default configuration. Two options change the picture:

- Enabling `send_payloads` adds a measurably larger overhead, because each captured message is held in
  memory and re-serialized, see
  [Performance and Memory Considerations]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-data-capture/#performance-and-memory-considerations).
- The retry queue is enabled by default and holds events **in heap** while Moesif is unreachable, up to
  `retry_buffer_size` events per Moesif API key. Size that against your event size, especially with body
  capture enabled, see
  [Memory and Sizing Considerations]({{base_path}}/monitoring/api-analytics/moesif-analytics/moesif-sampling-and-reliability/#memory-and-sizing-considerations).

## Additional Resources

- [Moesif Documentation](https://www.moesif.com/docs)
- [WSO2 API Manager Documentation](https://apim.docs.wso2.com/)
- [Moesif Support](https://www.moesif.com/)
- [WSO2 Support](https://wso2.com/support/)

For questions or issues specific to WSO2 API Manager configuration, please refer to the WSO2 support channels.
