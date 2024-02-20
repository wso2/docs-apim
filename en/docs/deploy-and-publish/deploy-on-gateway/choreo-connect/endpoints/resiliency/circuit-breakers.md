# Circuit Breakers

In case of backend failure, it is always better to fail quickly and relieve the back pressure from the actual backend, so it can recover quickly. Choreo Connect supports various types of distributed circuit breakers offered by Envoy. 
Based on the circuit breaker configuration, the router (i.e. Envoy) will open the circuit and handle the consequent request by itself till the backend recovers. 

## Enable circuit breakers for API endpoints

!!! note
    Circuit breakers are enabled by default and have moderate default values.

The following is the format of the vendor extension that is required to enable circuit breaking for an endpoint cluster in Choreo Connect.

```yaml tab="Production Endpoint"
x-wso2-production-endpoints:
  urls:
  - https://localhost:2380/v3
  advanceEndpointConfig:
    circuitBreakers:
      maxConnections: 1024
      maxRequests: 75
      maxPendingRequests: 35
      maxConnectionPools: 1024
      maxRetries: 3
```

```yaml tab="Sandbox Endpoint"
x-wso2-sandbox-endpoints:
  urls:
  - https://localhost:2381/v3
  advanceEndpointConfig:
    circuitBreakers:
      maxConnections: 1024
      maxRequests: 75
      maxPendingRequests: 35
      maxConnectionPools: 1024
      maxRetries: 3
```

!!! note 
    The following is the default values for each circuit breaker which will be enable for each endpoint cluster by default.
    ```toml
    maxConnections: 1024
    maxRequests: 75
    maxPendingRequests: 35
    maxConnectionPools: 1024
    maxRetries: 3
    ```
    if you want to disable any of the above circuit breaker, you can set it to the maximum value it is allowed. Following are the highest thresholds which allows for above circuit breakers.
    ```toml
    maxConnections: 1000000000
    maxRequests: 1000000000
    maxPendingRequests: 1000000000
    maxConnectionPools: 1000000000
    maxRetries: 1000000000
    ```
#### maxConnections
The maximum number of connections that Router will establish to all endpoints in the cluster. 
All connections regardless of the active, idle will be counted. 
Even that the count of this circuit breaker exceeded for an endpoint cluster, router will always allocate at least one connection for the selected load balanced endpoint.

#### maxRequests
The maximum number of requests that can be outstanding to all endpoints in a cluster at any given time.

#### maxPendingRequests
The requests will be added to a pending list  when there is no readily available connection to serve the request immediately.
This circuit breaker will exercise the maximum number of requests that will be queued while waiting for a ready connection pool connection.

#### maxConnectionPools
This defines the maximum concurrent initiations of connection pools. When a cluster has exhausted its concurrent connection pools, it will attempt to reclaim an idle one. 
If it failed to reclaim, then the circuit will be opened.

#### maxRetries
The maximum number of retries that can be served to any endpoint in a cluster at any given time concurrently. 
This will be helpful to avoid cascading failures and overloading endpoints due to undesirable retries.

For more information on above circuit breakers, refer [the Envoy documentation]({{envoy_path}}/intro/arch_overview/upstream/circuit_breaking)

## See Also

- [Timeout]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/resiliency/timeout)


