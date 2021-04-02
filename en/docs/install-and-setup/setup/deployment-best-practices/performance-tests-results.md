# Performance Test Results

The performance tests were conducted for streaming APIs of WSO2 API Manager. Tests were conducted for following three
 protocols and the following sections will present the results and key observations.
 
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
    <td>2</td>
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
    <td>2</td>
  </tr>
</tbody>
</table>

- Token type: JWT
- The operating system is Ubuntu 18.04
- MySQL version in RDS instance is 5.7
- Java version is JDK 11

### Performance test scripts

All scripts used to run the performance tests and analyze results are in the following repositories.

- [https://github.com/wso2/performance-common](https://github.com/wso2/performance-common)

- [https://github.com/wso2/performance-apim](https://github.com/wso2/performance-apim)

## Results

## Server Sent Events

Test for SSE API was done by using an SSE back end which emitted events in different frequency. The error rate with 
concurrent users and the CPU and memory percentage consumed was recorded at that time.

The following graph depicts the Error %, CPU % and Memory % variation in the server during the time in which the 
request was processed.

[![sse_perf_test_results]({{base_path}}/assets/img/setup-and-install/performance-test-results/sse_perf_test_results.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/sse_perf_test_results.png)

**Key observations:**

- Five thousand (5000) concurrent connections can we handled with zero error with an event rate of 10Events/sec (Average size of an Event used was 82B)

- CPU spike is expected during the processing time, however it will settle out once the requests are served.

## WebSub 

Test for WebSub API was done varying the number of subscribers and measuring the associated error, CPU and Memory % 
consumed.

The following graph depicts the variation of Error, CPU and Memory % with concurrent users.

[![websub_sse_perf_test_results]({{base_path}}/assets/img/setup-and-install/performance-test-results/websub_sse_perf_test_results.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/websub_sse_perf_test_results.png)

**Key observations:**

- Ten thousand subscribers can be handled with zero error rate serving a payload of average size of 8kB.

- CPU spike is expected during the processing time as higher number of requests are server simultaneously, however 
this will settle out when the events are delivered.


!!! note
    10 000 concurrent users mean a lot, and it is not very common. It is recommended to scale horizontally or 
    vertically to support more concurrent users with acceptable response times. When scaling horizontally, two or more Gateway nodes need to be used with a load balancer. Another load test must be carried out to measure the performance after scaling.
