# WSO2 API-M Performance and Capacity Planning

The following sections analyze the results of WSO2 API Manager performance tests.

## Summary

During each release, WSO2 executes various automated performance test scenarios and publishes the results.

| **Test Scenarios** | **Description**                                                      |
|------------------|--------------------------------------------------------------------------|
| Passthrough      |   A secured API, which directly invokes the back\-end service\.          |
| Transformation   |   A secured API, which has a mediation extension to modify the message\. |
 

WSO2 uses [Apache JMeter](https://jmeter.apache.org/index.html) as the test client. WSO2 tests each scenario for a fixed duration of time. Thereafter, WSO2 splits the test results into warmup and measurement parts and uses the measurement part to compute the performance metrics.

Test scenarios use a [Netty](https://netty.io/) based back-end service which echoes back any request posted to it after a specified period of time.

WSO2 runs the performance tests with different concurrent user loads, message sizes (payloads), and back-end service delays.

The main performance metrics:

- **Throughput**: The number of requests that the WSO2 API Manager processes during a specific time interval (e.g. per second).
- **Response Time**: The end-to-end latency for an operation of invoking an API. The complete distribution of response times was recorded.

In addition to the above metrics, WSO2 measures the load average and several memory-related metrics.

The duration of each test is 900 seconds. The warm-up period is 300 seconds. The measurement results are collected after the warm-up period.

A [c5.large Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install WSO2 API Manager.

## Test parameters
<table>
  <tr>
   <th><strong>Test Parameter</strong>
   </th>
   <th><strong>Description</strong>
   </th>
   <th><strong>Values</strong>
   </th>
  </tr>
  <tr>
   <td>Scenario Name
   </td>
   <td>The name of the test scenario.
   </td>
   <td> - 
   </td>
  </tr>
  <tr>
   <td>Heap Size
   </td>
   <td>The amount of memory allocated to the application
   </td>
   <td>2G
   </td>
  </tr>
  <tr>
   <td>Concurrent Users
   </td>
   <td>The number of users accessing the application at the same time.
   </td>
   <td>50, 100, 200, 300, 500, 1000
   </td>
  </tr>
  <tr>
   <td>Message Size (Bytes)
   </td>
   <td>The request payload size in Bytes.
   </td>
   <td>50, 1024, 10240, 102400
   </td>
  </tr>
  <tr>
   <td>Back-end Delay (ms)
   </td>
   <td>The delay added by the back-end service.
   </td>
   <td>0
   </td>
  </tr>
</table>

## Measurements collected
The following are the measurements collected from each performance test conducted for a given combination of test parameters.

<table>
  <tr>
   <th><strong>Measurement</strong>
   </th>
   <th><strong>Description</strong>
   </th>
  </tr>
  <tr>
   <td>Error %
   </td>
   <td>The percentage of requests with errors.
   </td>
  </tr>
  <tr>
   <td>Average Response Time (ms)
   </td>
   <td>The average response time of a set of results.
   </td>
  </tr>
  <tr>
   <td>Standard Deviation of Response Time (ms)
   </td>
   <td>The “Standard Deviation” of the response time.
   </td>
  </tr>
  <tr>
   <td>99th Percentile of Response Time (ms)
   </td>
   <td>99% of the requests took no more than this time. The remaining samples took at least as long as this.
   </td>
  </tr>
  <tr>
   <td>Throughput (Requests/sec)
   </td>
   <td>The throughput is measured in requests per second.
   </td>
  </tr>
  <tr>
   <td>Average Memory Footprint After Full GC (M)
   </td>
   <td>The average memory consumed by the application after a full garbage collection event.
   </td>
  </tr>
</table>

For a detailed analysis of the performance of API-M 3.2.0, see [API-M 3.2.0 Performance graphs on Github](https://github.com/wso2/performance-apim/tree/performance-test-276-2020-08-03_08-47-25/performance/benchmarks/3.2.0%20graphs-all).

## Observations from all results

There are key observations for the average user scenario of accessing APIs with 1KiB messages and the back-end service having 30ms delay.

The following are the key observations from the all performance tests done with different message sizes and different backend delays. (See **Comparison of results** for all charts used to derive the pointed mentioned below)

#### Throughput comparison:

A throughput increase is observed in the transformation scenario in API-M 3.2.0, in comparison to API-M 3.1.0

The throughput increases up to a certain limit when the number of concurrent users increases. The Mediation API throughput increase rate is much lower than the Echo API. Throughput decreases when the message sizes increase. Throughput decreases when the backend sleep time increase. This observation is similar to both APIs. This means that if the backend takes more time, the request processing rate at the API Manager Gateway will be less.

#### Key observations related to response time:

The average response time increases when the number of concurrent users increases. The increasing rate of average response time for both API-M 3.2.0 and API-M 3.1.0 is similar.

The average response time increases when the number of concurrent users increases. The average response time increases considerably for Mediation API when the message sizes increase due to the message processing. The average response time of the Echo API does not increase as much as the Mediation API. The average response time increases when the backend sleep time increases. This observation is similar to both APIs.

#### Key observations related to GC throughput:

The GC throughput decreases when the number of concurrent users increases. When there are more concurrent users, the object allocation rate increases. The GC throughput increases when the message size increases. The request processing rate slows down due to the time taken to process large messages. Therefore, the object allocation rate decreases  when the message size increases. The GC throughput increases when the backend sleep time increases. The object allocation rate will be low when the backend takes more time to respond.

## Comparison of 3.1.0 and 3.2.0

### Average response time comparison

#### Average response time vs concurrent users

  [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/average_time_0ms_50b.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/average_time_0ms_50b.png)
  [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/average_time_0ms_1kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/average_time_0ms_1kib.png)
  [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/average_time_0ms_10kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/average_time_0ms_10kib.png)

### GC Throughput comparison 

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_1kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_1kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_10kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_10kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_100kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_100kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_50b.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/gc_throughput_0ms_50b.png)

#### GC throughput vs concurrent users

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/comparison_gc.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/comparison_gc.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_concurrent_users.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_concurrent_users.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_concurrent_users_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_concurrent_users_with_hue.png)

#### GC throughput with 0ms backend delay

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/comparison_gc_0ms.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/comparison_gc_0ms.png)

#### GC throughput vs message size

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_message_size.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_message_size.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_message_size_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_message_size_with_hue.png)

#### GC throughput vs sleep time

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_sleep_time.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_sleep_time.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_sleep_time_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_gc_throughput_vs_sleep_time_with_hue.png)

### Load average comparison

#### Load average vs concurrent users

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_concurrent_users.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_concurrent_users.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_concurrent_users_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_concurrent_users_with_hue.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_concurrent_users.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_concurrent_users.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_concurrent_users_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_concurrent_users_with_hue.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_concurrent_users.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_concurrent_users.png) 
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_concurrent_users_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_concurrent_users_with_hue.png)

#### Load average vs message size

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_message_size.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_message_size.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_message_size_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_message_size_with_hue.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_message_size.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_message_size.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_message_size_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_message_size_with_hue.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_message_size.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_message_size.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_message_size_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_message_size_with_hue.png)
 
#### Load average vs sleep time

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_sleep_time.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_sleep_time.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_sleep_time_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_1_vs_sleep_time_with_hue.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_sleep_time.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_sleep_time.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_sleep_time_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_5_vs_sleep_time_with_hue.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_sleep_time.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_sleep_time.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_sleep_time_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_loadavg_15_vs_sleep_time_with_hue.png)


### Throughput comparison

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_100kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_100kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_10kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_10kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_1kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_1kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_50b.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/throughput_0ms_50b.png)

#### Throughput vs concurrent users

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_concurrent_users.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_concurrent_users.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_concurrent_users_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_concurrent_users_with_hue.png)

#### Throughput vs message size

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_message_size.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_message_size.png) 
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_message_size_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_message_size_with_hue.png)

#### Throughput vs sleep time

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_sleep_time.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_sleep_time.png) 
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_sleep_time_with_hue.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lmplot_throughput_vs_sleep_time_with_hue.png)

### Response time comparison

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_100kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_100kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_10kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_10kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_1kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_1kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_50b.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/response_time_0ms_50b.png)


### Percentile comparison

 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_10kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_10kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_10kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_10kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_1kib.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_1kib.png)
 [![]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_50b.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/p90_0ms_50b.png)

 For more comparisons, see [the comparison graphs on GitHub](https://github.com/wso2/performance-apim/tree/performance-test-276-2020-08-03_08-47-25/performance/benchmarks/3.2.0%20vs%203.1.0%20comparison)
