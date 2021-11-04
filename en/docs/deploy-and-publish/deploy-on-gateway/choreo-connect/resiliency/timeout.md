# Timeout

In a scenario where the backend endpoint is taking an unusual time to respond, Choreo Connect supports setting up a timeout allowing the client get a timely response.

Timeout is used to gracefully handle connections that takes an unexpected amount of time to respond. This ensures that the client does not hang indefinitely, and gets a success or an error response within the specified amount of time, letting both the client and the backend free its resources allocated for the connection.

## Configuring a Timeout 

The timeout parameter can also be specified in the `x-wso2-production-endpoint` and/or `x-wso2-sandbox-endpoint` open API extension.

```
x-wso2-production-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      timeoutInMillis: 7000
```

The [timeout covers the entire duration](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries) for all retry requests including the time gaps between the requests, and therefore has a direct relation to the time the client would have to wait for a response. A default global timeout will be applied if not set at an endpoint level. 

!!! tip

    The following global values can be set in config.toml related to the above timeouts.

    ```
    # Configure timeout settings related to routes. This will be applicable globally for all the routes in router.
    [router.upstream.timeouts]
      # Upstream timeout for the route. If not specified, the default is 60s.
      routeTimeoutInSeconds = 60
      # Maximum upstream timeout allowed in an OpenAPI definition or API-M UI. A larger value will be replaced by this.
      maxRouteTimeoutInSeconds = 60
      # Backend (upstream) connection idle timeout. The amount of time the request’s stream may be idle.
      routeIdleTimeoutInSeconds = 300
    ```

    For other timeouts, the following global values can also be set in the config.toml.

    ```
    [router]

    # The timeout for new network connections to hosts in the cluster in seconds
    clusterTimeoutInSeconds = 20

    # Timeouts managed by the connection manager
    [router.connectionTimeout]
      # The amount of time that Envoy will wait for the entire request to be received. Time from client to upstream.
      requestTimeoutInSeconds = 0
      # The amount of time that Envoy will wait for the request headers to be received. Time from client to upstream.
      requestHeadersTimeoutInSeconds = 0 
      # The stream idle timeout for connections managed by the connection manager. This can be overriden by the `routeIdleTimeoutInSeconds`
      streamIdleTimeoutInSeconds = 300
      # The idle timeout for connections. The idle timeout is defined as the period in which there are no active requests. When the idle timeout is reached the connection will be closed. 
      # If the connection is an HTTP/2 downstream connection a drain sequence will occur prior to closing the connection
      idleTimeoutInSeconds = 3600

    ```
