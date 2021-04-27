# Performance Test Results

The performance of WSO2 Micro Integrator Manager was measured using the following scenarios.

- Direct Proxy: This is a passthrough Proxy Service, which directly invokes the back-end service.
- Direct API: This is a passthrough API Service, which directly invokes the back-end service.
- CBR Transport Header Proxy: This is a Proxy Service which routes the message based on an HTTP header in the message.
- XSLT Proxy: This is a Proxy Service which has XSLT transformations in request and response paths.

Our test client is Apache JMeter. We test each scenario for a fixed duration of time. We split the test results into warmup 
and measurement parts and use the measurement part to compute the performance metrics.
Test scenarios use a Netty based back-end service which echoes back any request
posted to it after a specified period of time. (All the tests were executed with a 0ms
backend delay)

Tests were done using 100, 200, 500, and 2000 concurrent users. Concurrent Users mean that it consists of multiple users 
sending requests at the same time. Different Message Sizes (Payloads) were used for the tests : 500B, 1kB, 10kB, and 100kB.


Two key performance metrics were used to measure the performance of each test. 

- Throughput: The number of requests that the WSO2 Micro Integrator processes during a specific time interval (e.g. per second).. 
- Response Time: The end-to-end latency for an operation of invoking a service in WSO2 Micro Integrator. The complete distribution of response times was recorded.

All the performance results were done on the default Micro Integrator distribution. The
following performance results may become invalid if configurations are changed. For
example, the default passthru io_buffer_size is 16KB. Hence the throughput significantly
decreases for payload sizes above 16KB. If the buffer size is increased, the throughput
might differ. Similarly when worker pool thread counts are changed, the performance of
Micro Integrator changes significantly. Hence, for accurate results doing a performance
test with the exact configuration and scenarios is a must.

## Deployment used for the test

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
    <td>Netty HTTP Backend</td>
    <td>c5.xlarge</td>
    <td>4</td>
    <td>4</td>
  </tr>
  <tr>
    <td>WSO2 Micro Manager</td>
    <td>c5.large</td>
    <td>2</td>
    <td>2</td>
  </tr>
</tbody>
</table>

- The operating system is Ubuntu 18.04.5 LTS
- Java version is JDK 8

### Performance test scripts

All scripts used to run the performance tests and analyze results are in the following repositories.

- [https://github.com/wso2/performance-common](https://github.com/wso2/performance-common)

- [https://github.com/wso2/performance-ei](https://github.com/wso2/performance-ei