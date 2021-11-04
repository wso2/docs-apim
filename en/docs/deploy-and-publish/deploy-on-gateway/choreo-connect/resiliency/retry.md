# Retry

There can be scenarios where the backend endpoint is unavailable for a short period of time, due to the load or due to a transient error. Choreo Connect supports handling such sceraios by configuring a retry policy which would make the router retry the HTTP request on befalf of the client.

## Configuring a Retry Policy

Choreo Connect accepts a retry policy in following format. This can be included in the OpenAPI definition under `x-wso2-production-endpoint` and/or `x-wso2-sandbox-endpoint` when deploying via apictl.

```
x-wso2-production-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      retryConfig:
        count: 3
        statusCodes:
          - 504
```

!!! note ""
    - count       - The number of additional retry attempts before giving up   
    - statusCodes - The HTTP status codes to retry

Having the above retry policy would make the router retry atmost three times if the backend responds with a 504. 

!!! note "Important to Note"
    Adding the retry policy via the OpenAPI definition in API-M is not yet supported. In the API-M UI, a retry count can be specified via the [Endpoints tab]({{base_path}}/design/endpoints/resiliency/endpoint-timeouts/) when configuring production and sandbox endpoints. The retry functionality in Choreo Connect would work when the value for "retries before suspension" is set. Please not that this value does not lead to a suspension of the endpoint when run with Choreo Connect. The status codes to retry would be the list of status codes defined in Choreo Connect at a global level. 

Here the interval between two retries is a random number between 0 and (2^N-1)B. N is the retry number and B is the default base interval of 25ms. The interval between the retries being random, prevents a backend from getting spike of retry requests (when triggered by many clients), and mitigates a potential unavailability of the backend that could occur due to the retries itself. For more information, click [here](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries)

!!! tip

    The following global values can be set in config.toml related to the retry behaviour.

    ```
    [router.upstream.retry]
      # Maximum value that can be set as the count within retry configs in an OpenAPI definition or API-M UI
      maxRetryCount = 5
      # Base interval for the Envoy's exponential retry back off algorithm
      baseIntervalInMillis = 25
      # HTTP status codes, the retry mechanism will be enabled for.
      # Used when retry config is set via API-M UI or all given status codes are out of range.
      statusCodes = [ 504 ]
    ```

The next section explains the timeout. It is recommended to always set a timeout when a retry policy is added. If not, the default global timeout will be applied.


 
