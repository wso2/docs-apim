# Performance Test Results

The performance tests were conducted for streaming APIs of WSO2 API Manager. Tests were conducted for the three
 protocols listed below and the subsequent sections present the results and key observations.
 
 1. Server Sent Event APIs (SSE)
 2. WebSub / WebHook APIs
 3. WebSocket APIs
 
## Deployment used for the test

[![API-M performance test all-in-one deployment]({{base_path}}/assets/img/setup-and-install/performance-test-results/apim_performance_test_all_in_one_deployment.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/apim_performance_test_all_in_one_deployment.png)

<table>
<thead>
  <tr>
    <th>Name</th>
    <th>EC2 Instance Type</th>
    <th>vCPU</th>
    <th>Mem(GiB)</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Apache JMeter Client</td>
    <td>c5.large</td>
    <td>2</td>
    <td>4</td>
  </tr>
  <tr>
    <td>Apache JMeter Server 01</td>
    <td>c5.xlarge</td>
    <td>4</td>
    <td>4</td>
  </tr>
  <tr>
    <td>Apache JMeter Server 02</td>
    <td>c5.xlarge</td>
    <td>4</td>
    <td>4</td>
  </tr>
  <tr>
    <td>MySQL</td>
    <td>db.m5.large</td>
    <td>2</td>
    <td>8</td>
  </tr>
  <tr>
    <td>Netty HTTP Backend</td>
    <td>c5.xlarge</td>
    <td>4</td>
    <td>4</td>
  </tr>
  <tr>
    <td>WSO2 API Manager</td>
    <td>c5.large</td>
    <td>2</td>
    <td>4</td>
  </tr>
</tbody>
</table>

- Token type: JWT
- The operating system is Ubuntu 18.04
- MySQL version in RDS instance is 8.0
- Java version is Temurin JDK 17

### Performance test scripts

All scripts used to run the performance tests and analyze results are in the following repositories.

- [https://github.com/wso2/performance-apim](https://github.com/wso2/performance-apim)

## Results

### WebSub 

Test for WebSub API was done for varying number of subscribers and measuring the associated error, CPU and Memory % 
consumed.

The following graph depicts the variation of Error, CPU and Memory % with concurrent users.

[![WebSub Test Results]({{base_path}}/assets/img/setup-and-install/performance-test-results/websub_sse_perf_test_results.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/websub_sse_perf_test_results.png)

**Key observations:**

- 10,000 subscribers can be handled with zero error rate serving a payload of average size of 8kB.

- CPU spike is expected during the processing time as higher number of requests are server simultaneously, however 
this will settle when the events are delivered.


!!! note
    10,000 concurrent users mean a lot, and it is not very common. It is recommended to scale horizontally or 
    vertically to support more concurrent users with acceptable response times. When scaling horizontally, two or more Gateway nodes need to be used with a load balancer. Another load test must be carried out to measure the performance after scaling.

### WebSocket

Test for WebSocket API was done using a WebSocket server, which sends back the reversed message received from the client. The CPU and memory usages for concurrent connections were recorded during that time. The tests were run for 30 seconds.

The following table shows the number of concurrent connections with error rate. A 500 bytes string payload was used as the message.

| Events/second  | Message Size | Attempted Concurrent Connections | Failed Connections | Error Rate |
|----------------|--------------|----------------------------------|--------------------|------------|
| 1              | 500 bytes    | 100                              | 0                  | 0%         |
|                |              | 200                              | 0                  | 0%         |
|                |              | 300                              | 0                  | 0%         |
|                |              | 400                              | 0                  | 0%         |
|                |              | 600                              | 0                  | 0%         |
|                |              | 800                              | 0                  | 0%         |
|                |              | 1000                             | 0                  | 0%         |
| 5              | 500 bytes    | 100                              | 0                  | 0%         |
|                |              | 200                              | 0                  | 0%         |
|                |              | 300                              | 0                  | 0%         |
|                |              | 400                              | 0                  | 0%         |
|                |              | 600                              | 0                  | 3.24%      |
|                |              | 800                              | 0                  | 44.54%     |
|                |              | 1000                             | 0                  | 45.59%     |
| 10             | 500 bytes    | 100                              | 0                  | 0%         |
|                |              | 200                              | 0                  | 0%         |
|                |              | 300                              | 0                  | 0%         |
|                |              | 400                              | 0                  | 16.72%     |
|                |              | 600                              | 0                  | 57.60%     |

!!! note
      The backend used here is a Tornado backend. The error rates observed in the above graph are due to limitations in the Tornado backend. API Manager
      was able to successfully handle upto 1000 concurrent connections even in the 10 events per second scenario.

**Key observations:**

- 1000 concurrent connections can be made without any failed connections, at ten events per second.

The following graphs depict the variation of CPU and Memory % with concurrent connections.

<img src="{{base_path}}/assets/img/setup-and-install/performance-test-results/websocket-cpu-mem-graphs/cpu_usage_430.png" alt="CPU Usage" width="900"/>

<img src="{{base_path}}/assets/img/setup-and-install/performance-test-results/websocket-cpu-mem-graphs/mem_usage_430.png" alt="Memory Usage" width="900"/>
