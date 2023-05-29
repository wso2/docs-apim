# Performance Test Results

The performance of Choreo Connect was measured using an API that invokes a simple "Netty Echo Service". The task covered by the Netty service is to echo back any request posted to the service. The API used for the test cases was a secured API, which directly invokes the backend through Choreo Connect using JWT tokens.

Tests were performed considering 10, 50, 100, 200, 500, 1000 concurrent users. Concurrent users mean that it consists of multiple users accessing Choreo Connect at the same time. Different Message Sizes (Payloads) were used for the tests. The message sizes used are 50B, 1KiB, 10KiB, and 100KiB. The back-end delay was 0ms. The test client was Apache JMeter. Test scenarios were executed for 20 minutes including a warmup period of 5 minutes. When analyzing test results, test outcomes relevant to that period were removed.

Two key performance metrics were used to measure the performance of each test. 

- **Throughput**: The number of requests that the Choreo Connect processes during a specific time interval (e.g. per second).
- **Response Time**: The end-to-end latency for an operation of invoking a service in Choreo Connect. The complete distribution of response times was recorded.

## Deployment used for the test

Given below are the details of the deployment that was used for the performance test that is recorded in this documentation.

[![CC performance test all-in-one deployment]({{base_path}}/assets/img/deploy/mgw/performance-test/test-deployment.png)]({{base_path}}/assets/img/deploy/mgw/performance-test/test-deployment.png)


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
    <td>8</td>
  </tr>
  <tr>
    <td>Apache JMeter Server 02</td>
    <td>c5.xlarge</td>
    <td>4</td>
    <td>8</td>
  </tr>
  <tr>
    <td>AWS EKS cluster (three nodes)</td>
    <td>c6i.xlarge</td>
    <td>4</td>
    <td>8</td>
  </tr>
</tbody>
</table>

!!! important
    For better throughput and performance, it is able to use computer optimized nodes for the cluster. For this test we have used **c6i.xlarge** EC2 instances.

- The operating system is Amazon Linux 2018.03
- Java version is JDK 8

## Performance test scripts

All scripts used to run the performance tests and analyze results are in the following repositories.

- [https://github.com/wso2/performance-common](https://github.com/wso2/performance-common)

- [https://github.com/wso2/performance-apim](https://github.com/wso2/performance-apim)

## Results

[Choreo Connect](https://wso2.com/choreo/choreo-connect/) is powered by the open source project called [Envoy Proxy](https://www.envoyproxy.io/). Envoy allows to change number of worker threads used for the computations. More details regarding the envoy `--concurrency` configuration are available in [here](https://www.envoyproxy.io/docs/envoy/latest/operations/cli#cmdoption-concurrency). Additionally, an explanation for the **Envoy Threading Model** includes [here](https://www.envoyproxy.io/docs/envoy/latest/operations/cli#cmdoption-concurrency).

Since we used the `c6i.xlarge` instances (CPU count = 4) for the performance tests and to do a test result comparison, we executed the above-mentioned user counts and payload sizes considering two concurrency levels. We assigned below describing `CPU amount` and `concurrency count` to the Router when applying Choreo Connect test deployments. In order to match the increased concurrency level, we increased the CPU allocation to the Router also. Below table lists the test scenarios explained in this documentation.

<table>
<thead>
  <tr>
    <th>Test Scenario</th>
    <th>CPU allocation for the Router (m)</th>
    <th>Router concurrency level</th>
    <th>Test results</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>1</td>
    <td>1000 (1CPU)</td>
    <td>2</td>
    <td><a href="{{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/performance-tests/router-with-one-cpu-for-rest-api">Router with one CPU</a</td>
  </tr>
  <tr>
    <td>2</td>
    <td>2000 (2CPU)</td>
    <td>4</td>
    <td><a href="{{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/performance-tests/router-with-two-cpu-for-rest-api/">Router with two CPU</a</td>
  </tr>
</tbody>
</table>
