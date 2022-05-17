# Configuring Timeouts in Choreo Connect

You can use timeouts to gracefully handle connections that take an unusual amount of time to respond. Timeouts mainly ensure that the client gets a success or an error response within the specified amount of time, and thereby the client does not hang indefinitely. Timeouts also enable both the client and the backend to free its resources, allocated for the connection, within the time gap defined.

Timeouts can be defined at two levels.

- [Endpoint Level]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/resiliency/timeout/#endpoint-level-upstream-timeouts) 
    - Only upstream timeouts can be defined at this level
    - Must be explicitly defined
- [Global Level]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/resiliency/timeout/#global-level-timeouts)
    - Multiple types of timeouts including upstream timeout can be defined
    - If not specified, default values are assigned 

## Endpoint Level Upstream Timeouts

You can define the Endpoint Level Upstream Timeout in the `x-wso2-production-endpoint` and/or `x-wso2-sandbox-endpoint` OpenAPI extension of the API's OpenAPI definition, based on the endpoint type (i.e., production or sandbox), when [deploying an API **via the apictl (CLI Tool)**]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/#choreo-connect-as-a-standalone-gateway/).

``` bash tab="Production Endpoint"
x-wso2-production-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      timeoutInMillis: 7000
```

``` bash tab="Sandbox Endpoint"
x-wso2-sandbox-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      timeoutInMillis: 7000
```

| **Field** | **Description** |
|-------|-------------|
| timeoutInMillis | The time duration that the Router waits for the response from the backend, starting from the time the request arrived at the router. The response maybe a success or an error response. |

The timeout covers the entire duration for all retry requests, including the time gaps between the requests, and therefore directly relates to the time the client would have to wait for a response. For more information, see [x-envoy-max-retries]({{envoy_path}}/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries) in the official Envoy documentation. The Global Level Route Timeout is applied if you have not set an Endpoint Level Upstream Timeout.

## Global Level Timeouts

The following is a list of the Global Level Timeouts that you can set in Choreo Connect.

<table>
<tr>
<td>
<ul>
<li>Cluster Timeout</li>
<li>Request Timeout</li>
<li>Request Headers Timeout</li>
<li>Stream Idle Timeout</li>
</ul>
</td>
<td>
</td>
<td>
</td>
<td>
<ul>
<li>Idle Timeout</li>
<li>Route Timeout</li>
<li>Max Route Timeout</li>
<li>Route Idle Timeout</li>
</ul>
</tr>
</table>

Follow the instructions below to define Global Level Timeouts:

1. {!includes/deploy/cc-configuration-file.md!}

2. Use the following configurations to define the Global Level Timeouts.

    !!! note
        These timeouts are applied for all the APIs that are deployed in Choreo Connect. Out of the above list of timeouts, only the Route Timeout can be defined at the Endpoint Level if required. If the Endpoint Level Upstream Timeouts and Global Level Timeouts are not defined, the default values available for the Global Level Timeouts are applied.

``` 
[router]
clusterTimeoutInSeconds = 20

[router.connectionTimeout]
  requestTimeoutInSeconds = 0
  requestHeadersTimeoutInSeconds = 0 
  streamIdleTimeoutInSeconds = 300
  idleTimeoutInSeconds = 3600

[router.upstream.timeouts]
  routeTimeoutInSeconds = 60
  maxRouteTimeoutInSeconds = 60
  routeIdleTimeoutInSeconds = 300
```

| **Field**         | **Description**                                            |
| ---------------------------------- | ------------------------------------------------------------ |
| clusterTimeoutInSeconds | The amount of time the Router will wait for an upstream TCP connection to be established. |
| requestTimeoutInSeconds | The time duration that the Router waits for the request to be received by the upstream, starting from the time it was initiated at the client. |
| requestHeadersTimeoutInSeconds | The time duration that the Router waits for the request headers to be received by the upstream, starting from the time it was initiated at the client. |
| streamIdleTimeoutInSeconds | The time duration that the Router will allow a stream to exist with no upstream or downstream activity. This timeout is applied to regular requests/responses as well as streaming requests/responses, and can be overridden by the following configuration:`router.upstream.timeouts.routeIdleTimeoutInSeconds` |
| idleTimeoutInSeconds | The time at which a downstream connection will be terminated if there are no active streams. |
| routeTimeoutInSeconds | The time duration that the Router waits for the response from the backend, starting from the time the request arrived at the router. This is the value that gets overridden by the timeout set at the endpoint level. If not set at either places, the default value of 60s is applied. |
| maxRouteTimeoutInSeconds | Maximum value accepted as the Endpoint Level Upstream Timeout. If a larger Route Timeout value is set at the endpoint level using the `timeoutInMillis` configuration, the `maxRouteTimeoutInSeconds` value will override the latter mentioned Endpoint Level Upstream Timeout value. |
| routeIdleTimeoutInSeconds | The backend (upstream) connection idle timeout. The amount of time the request’s stream may be idle. |

For more information with regard to the latter mentioned configurations with regard to the Global Level Timeouts, see [Router]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/router-configurations/#router), [Connection Timeout]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/router-configurations/#connection-timeout), and [Upstream Timeout]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/router-configurations/#upstream-timeout).

!!! Info

    For more in-depth information on how the above configurations affect the router, refer to the [Timeouts]({{envoy_path}}/faq/configuration/timeouts) in the official Envoy documentation. The following is a mapping between the above configuration and the Envoy (Router) specific configurations.

    | **Choreo Connect Specific Term**     | **Envoy (Router) Specific Term**             |
    | ---------------------------------------------- | -------------------------------------------- |
    | clusterTimeoutInSeconds | connect_timeout (TCP) |
    | requestTimeoutInSeconds | request_timeout (HTTP Stream Timeouts) |
    | requestHeadersTimeoutInSeconds | request_headers_timeout (HTTP Stream Timeouts) |
    | streamIdleTimeoutInSeconds | stream_idle_timeout (HTTP Stream Timeouts) |
    | idleTimeoutInSeconds | idle_timeout defined in HTTP connection manager (HTTP Connection Timeouts) |
    | routeTimeoutInSeconds | timeout (HTTP Route Timeouts) |
    | routeIdleTimeoutInSeconds | idle_timeout (HTTP Route Timeouts) |

## See Also

- [Circuit Breakers]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/resiliency/circuit-breakers)

