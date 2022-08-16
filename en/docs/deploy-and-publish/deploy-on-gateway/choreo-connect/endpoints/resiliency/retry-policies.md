# Configuring Retry Policies in Choreo Connect

The backend endpoint can be unavailable for a short period of time due to various reasons, such as due to the load or due to a transient error. Choreo Connect handles such scenarios by configuring a Retry Policy which would make the router retry the HTTP request on behalf of the client. You can configure a Retry Policy at the [endpoint level](#endpoint-level-retry-policy). In addition, you can set [Global Level Retry Policy Configurations](#global-level-retry-policy-configurations), which you can use to enforce limitations on the defined Endpoint Level Retry Policies.

## Endpoint Level Retry Policy

You can define a Retry Policy for an endpoint in the `x-wso2-production-endpoint` and/or `x-wso2-sandbox-endpoint` OpenAPI extension of the API's OpenAPI definition, based on the endpoint type (i.e., production or sandbox), when [deploying an API **via the apictl (CLI Tool)**]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/#choreo-connect-as-a-standalone-gateway/).

**Example:**

For example, if the Retry Policy is defined as follows, it will result in the router retrying three times if the backend responds with a 504 status code.

``` bash tab="Production Endpoint"
x-wso2-production-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      retryConfig:
        count: 3
        statusCodes:
          - 504
```

``` bash tab="Sandbox Endpoint"
x-wso2-sandbox-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      retryConfig:
        count: 3
        statusCodes:
          - 504
```

| **Field** | **Description** |
|-------|-------------|
| count | The number of additional retry attempts before giving up. |
| statusCodes | The HTTP status codes to retry. The accepted HTTP status code range is as follows: 401 to 598 |

When a Retry Policy is executed, the interval between two retries is a random number between `0` and `(2^N-1)B`. 

- `N` is the retry number.
- `B` is the default base interval of `25ms` (milliseconds). 
- The interval between the retries being random prevents a backend from getting a spike of retry requests (when triggered by many clients) and mitigates the potential unavailability of the backend that could occur due to the retries. 

For more information, see [x-envoy-max-retries]({{envoy_path}}/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries) in the official Envoy documentation.

!!! note
    - At the moment, WSO2 API Manager does not support adding a Retry Policy via the WSO2 API Manager (WSO2 API-M) UI.
    - If required, when configuring the production and sandbox endpoints, you can also specify the retry count in the Endpoints page via the WSO2 API Manager UI. For more information, see [Endpoint timeouts]({{base_path}}/design/endpoints/resiliency/endpoint-timeouts/).
    - The retry functionality in Choreo Connect will work when the value for **Retries Before Suspension** is set via the WSO2 API-M UI. However, when run with Choreo Connect, this **does not lead to a suspension of the endpoint**, unlike when run with an API Gateway.
    - If the retry functionality is set via the **Retries Before Suspension** field in the WSO2 API-M UI, the global level status codes in Choreo Connect will be considered when the retrying process takes place.

## Global Level Retry Policy Configurations

!!! note
    The Global Level Retry Policy Configurations are **applicable only when Endpoint Level Retry Policies are defined**. 

1. {!includes/deploy/cc-configuration-file.md!}

2. Use the following configurations to define the Global Level Retry Policy.

    !!! note
        If the Endpoint Level Retry Policies and the Global Level Retry Policies are not defined, the default values available for the Global Level Retry Policies are applied.

    ```
    [router.upstream.retry]
      maxRetryCount = 5
      baseIntervalInMillis = 25
      statusCodes = [ 504 ]
    ```

     | **Field** | **Description** |
     |-----------|-----------------|
     | maxRetryCount | Maximum value that can be set as the count within the retry configurations in an OpenAPI definition or when configured via the WSO2 API-M UI. |
     | baseIntervalInMillis | Base interval for the Envoy's exponential retry back off algorithm. |
     | statusCodes | The retry mechanism will be enabled for the HTTP status codes that are specified in this list. This is used when the retry configuration is set via the WSO2 API-M UI by setting the [**Retries Before Suspension** field]({{base_path}}/design/endpoints/resiliency/endpoint-timeouts/) or when all the status codes specified in the Endpoint Level Retry Policy are out of range. |

     For more information with regard to the Global Level Retry Policy Configurations, see [Upstream Retry]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/router-configurations/#upstream-retry).

## See Also

- [Timeout]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/resiliency/timeout)
