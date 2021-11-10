# Timeout

In a scenario where the backend endpoint is taking an unusual time to respond, Choreo Connect supports setting up a timeout allowing the client get a timely response.

Timeout is used to gracefully handle connections that takes an unexpected amount of time to respond. This ensures that the client does not hang indefinitely, and gets a success or an error response within the specified amount of time, letting both the client and the backend free its resources allocated for the connection.

## Endpoint Level Timeouts

The timeout parameter can also be specified in the `x-wso2-production-endpoint` and/or `x-wso2-sandbox-endpoint` open API extension.

```
x-wso2-production-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      timeoutInMillis: 7000
```

The [timeout covers the entire duration](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries) for all retry requests including the time gaps between the requests, and therefore has a direct relation to the time the client would have to wait for a response. A default global timeout will be applied if not set at an endpoint level. 

## Global Level Timeouts

The following global timeouts can be set in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/config.toml`. These are applied globally for all the APIs deployed in Choreo Connect.

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

| **Configuration Parameter**         | **Description**                                            |
| ---------------------------------- | ------------------------------------------------------------ |
| clusterTimeoutInSeconds | The amount of time the Router will wait for an upstream TCP connection to be established. |
| requestTimeoutInSeconds | The amount of time that the Router will wait for the entire request to be received by the upstream, from the time the request was initiated by the client. |
| requestHeadersTimeoutInSeconds | The amount of time that the Router will wait for the request headers to be received by the upstream, from the time the request was initiated by the client. |
| streamIdleTimeoutInSeconds | The amount of time that the Router will allow a stream to exist with no upstream or downstream activity. This timeout is applied to regular requests/responses as well as streaming requests/responses, and can be overridden by `router.upstream.timeouts.routeIdleTimeoutInSeconds`. |
| idleTimeoutInSeconds | The time at which a downstream connection will be terminated if there are no active streams. |
| routeTimeoutInSeconds | This is the value that gets overridden by the timeout set at the endpoint level. If not set at either places, the default value 60s is applied. |
| maxRouteTimeoutInSeconds | Maximum value accepted as the endpoint level timeout. If a larger timeout is set, `maxRouteTimeoutInSeconds` will replace the provided endpoint level timeout. |
| routeIdleTimeoutInSeconds | The backend (upstream) connection idle timeout. The amount of time the request’s stream may be idle. |

!!! Info

    For more in-depth information on how the above configurations affect the router, refer to [this documentation](https://www.envoyproxy.io/docs/envoy/latest/faq/configuration/timeouts). Below is a mapping between the above configs and the Envoy (Router) specific terms.

    | **Choreo Connect Configuration Parameter**     | **Envoy (Router) Specific Term**             |
    | ---------------------------------------------- | -------------------------------------------- |
    | clusterTimeoutInSeconds | connect_timeout (TCP) |
    | requestTimeoutInSeconds | request_timeout (HTTP Stream Timeouts) |
    | requestHeadersTimeoutInSeconds | request_headers_timeout (HTTP Stream Timeouts) |
    | streamIdleTimeoutInSeconds | stream_idle_timeout (HTTP Stream Timeouts) |
    | idleTimeoutInSeconds | idle_timeout defined in HTTP connection manager (HTTP Connection Timeouts) |
    | routeTimeoutInSeconds | timeout (HTTP Route Timeouts) |
    | routeIdleTimeoutInSeconds | idle_timeout (HTTP Route Timeouts) |
