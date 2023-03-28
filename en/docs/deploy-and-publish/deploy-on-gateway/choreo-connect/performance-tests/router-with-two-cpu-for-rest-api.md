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

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-120-2cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-120-2cpu.png" width="90%" ></a>

**Key observations:**

- For large payload sizes you will get a low throughput value when compared to the small payload sizes.

## Average Response time (ms) vs. concurrent users

Backend delay is assigned as zero milliseconds when obtaining test results. The below graph shows how response time varied for different concurrent user counts. Also, the same graph shows the impact of the payload size for the average response time.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-120-2cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-120-2cpu.png" width="90%" ></a>

**Key observations:**

- When increasing concurrent users for given payload size, Choreo Connect consumes steady growth for the response time. But when considering the same user count for large payloads, response time is high compared to the small payloads.

## Response time percentiles vs. concurrent users

Below graphs show 90th, 95th, and 99th Response Time percentiles for 0ms backend delay. This is useful to measure the percentage of requests that exceeded the response time value for a given percentile. A percentile can also tell the percentage of requests completed below the particular response time value.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-120-2cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-120-2cpu.png" width="90%" ></a>

Data relevant to the test scenarios listed in the below table.

|Concurrent Users|Message Size (Bytes)|Total requests|Average Response Time (ms)|Throughput (Requests/sec)|Error %|Error Count|Little's law verification|90th Percentile of Response Time (ms)|95th Percentile of Response Time (ms)|99th Percentile of Response Time (ms)|
|----------------|--------------------|--------------|--------------------------|-------------------------|-------|-----------|-------------------------|-------------------------------------|-------------------------------------|-------------------------------------|
|10              |50B                 |3057387       |2.86                      |3393.33                  |0      |0          |9.70                     |3                                    |4                                    |18                                   |
|50              |50B                 |4683200       |9.53                      |5193.08                  |0      |0          |49.49                    |22                                   |32                                   |38                                   |
|100             |50B                 |5083655       |17.62                     |5641.29                  |0      |0          |99.40                    |38                                   |43                                   |54                                   |
|200             |50B                 |5402601       |33.24                     |5995.48                  |0      |0          |199.29                   |57                                   |64                                   |80                                   |
|500             |50B                 |5289304       |85.03                     |5865.37                  |0      |0          |498.73                   |115                                  |129                                  |164                                  |
|1000            |50B                 |4967924       |181.26                    |5482.02                  |0      |0          |993.67                   |228                                  |251                                  |277                                  |
|10              |1KiB                |3052933       |2.87                      |3385.21                  |0      |0          |9.72                     |3                                    |4                                    |17                                   |
|50              |1KiB                |4479198       |9.96                      |4971.6                   |0      |0          |49.52                    |26                                   |34                                   |40                                   |
|100             |1KiB                |5049299       |17.75                     |5597.31                  |0      |0          |99.35                    |38                                   |43                                   |54                                   |
|200             |1KiB                |5527835       |32.49                     |6129.22                  |0      |0          |199.14                   |56                                   |65                                   |85                                   |
|500             |1KiB                |5332405       |84.32                     |5911.65                  |0      |0          |498.47                   |110                                  |120                                  |152                                  |
|1000            |1KiB                |4966629       |181.23                    |5502.79                  |0      |0          |997.27                   |235                                  |255                                  |283                                  |
|10              |10KiB               |2902065       |3.01                      |3220.43                  |0      |0          |9.69                     |4                                    |4                                    |10                                   |
|50              |10KiB               |4176029       |10.68                     |4630.91                  |0      |0          |49.46                    |23                                   |29                                   |36                                   |
|100             |10KiB               |4601055       |19.45                     |5106.83                  |0      |0          |99.33                    |37                                   |42                                   |54                                   |
|200             |10KiB               |4668818       |38.45                     |5179.92                  |0      |0          |199.17                   |62                                   |68                                   |80                                   |
|500             |10KiB               |4369813       |102.92                    |4847.29                  |0      |0          |498.88                   |151                                  |166                                  |187                                  |
|1000            |10KiB               |4282270       |210.37                    |4733.29                  |0      |0          |995.74                   |267                                  |281                                  |309                                  |
|10              |100KiB              |1474497       |5.92                      |1636.62                  |0      |0          |9.69                     |8                                    |9                                    |13                                   |
|50              |100KiB              |1952292       |22.82                     |2166.6                   |0      |0          |49.44                    |37                                   |43                                   |56                                   |
|100             |100KiB              |1894368       |47.28                     |2102.73                  |0      |0          |99.42                    |83                                   |96                                   |125                                  |
|200             |100KiB              |1877891       |95.64                     |2083.4                   |0      |0          |199.26                   |187                                  |226                                  |291                                  |
|500             |100KiB              |1796616       |250.55                    |1991.32                  |0      |0          |498.93                   |397                                  |439                                  |535                                  |
|1000            |100KiB              |1788542       |503.43                    |1969.33                  |0      |0          |991.42                   |655                                  |715                                  |855                                  |
