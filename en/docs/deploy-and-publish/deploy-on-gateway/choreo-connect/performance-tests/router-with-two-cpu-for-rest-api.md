# Performance Test Results for Router with Two CPU

Test results explained in below obtained assigning Router's concurrency level as four. For the Choreo Connect components, below resource amounts are allocated. Same test setup diagram includes in [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/performance-tests/performance-test-results-overview-cc/#deployment-used-for-the-test) .

<table>
<thead>
  <tr>
    <th>Container Name</th>
    <th>Requesting Memory Amount (Mi)</th>
    <th>Requesting CPU Amount (m)</th>
    <th>Limiting Memory Amount (Mi)</th>
    <th>Limiting CPU Amount (m)</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Adapter</td>
    <td>500</td>
    <td>500</td>
    <td>500</td>
    <td>500</td>
  </tr>
  <tr>
    <td>Enforcer</td>
    <td>2000</td>
    <td>1000</td>
    <td>2000</td>
    <td>1000</td>
  </tr>
  <tr>
    <td>Router</td>
    <td>500</td>
    <td>2000 (2 CPUs)</td>
    <td>500</td>
    <td>2000 (2 CPUs)</td>
  </tr>
  <tr>
    <td>Netty Backend</td>
    <td>4096</td>
    <td>2000</td>
    <td>6114</td>
    <td>2000</td>
  </tr>
</tbody>
</table>

For the Enforcer's Java Virtual Machine (JVM), memory allocation changed as below. 

- `Xmx1500m (Maximum memory allocation for the JVM)`
- `Xms1500m (Satrting memory allocation for the JVM)`

In order to handle high request counts in Enforcer, `authService`'s resource allocation changed as below.

``` toml

[enforcer.authService]
    # Port of the Enforcer auth service
    port = 8081
    # Maximum message size in bytes
    maxMessageSize = 1000000000
    # Maximum header size in bytes
    maxHeaderLimit = 8192
    # Keep alive time in seconds for connection with the router via external authz service
    keepAliveTime = 600
    # Thread pool configurations of gRPC netty based server in Enforcer that handles the incoming requests in the Choreo Connect
    [enforcer.authService.threadPool]
        # Minimum number of workers to keep alive
        coreSize = 400
        # Maximum pool size
        maxSize = 1000
        # Timeout in seconds for idle threads waiting for work
        keepAliveTime = 600
        # Queue size of the worker threads
        queueSize = 2000

```

Below graphs depict performance test results considering different test parameters.


# Comparison of results

## Throughput (requests/sec) vs. concurrent users
The following graph illustrates the throughput against the number of concurrent users.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-110-2cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-110-2cpu.png" width="90%" ></a>

**Key observations:**

- For large payload sizes you will get a low throughput value when compared to the small payload sizes.

## Average Response time (ms) vs. concurrent users

Backend delay is assigned as zero milliseconds when obtaining test results. The below graph shows how response time varied for different concurrent user counts. Also, the same graph shows the impact of the payload size for the average response time.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-110-2cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-110-2cpu.png" width="90%" ></a>

**Key observations:**

- When increasing concurrent users for given payload size, Choreo Connect consumes steady growth for the response time. But when considering the same user count for large payloads, response time is high compared to the small payloads.

## Response time percentiles vs. concurrent users

Below graphs show 90th, 95th, and 99th Response Time percentiles for 0ms backend delay. This is useful to measure the percentage of requests that exceeded the response time value for a given percentile. A percentile can also tell the percentage of requests completed below the particular response time value.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-110-2cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-110-2cpu.png" width="90%" ></a>

Test scenario results in CSV format are available [here](https://raw.githubusercontent.com/wso2/product-microgateway/main/performance/benchmarks/cpus-2/summary.csv)