# Performance Test Results

The performance of WSO2 API Manager was measured for GraphQL APIs. While the schema, the queries, and the responses were mimicked using the [Starwars API](https://github.com/wso2/samples-apim/tree/master/graphql-backend), the backend used for the test is a Netty backend. The Netty service is configured so that the response is aligned with the GraphQL request in order to only provide the data requested by a particular query.

Tests were done using **50**, **100**, **200**, **500**, and **1000** concurrent users. Concurrent users mean that it consists of multiple users accessing the API Gateway at the same time. Three GraphQL queries were used for the tests. These queries were constructed with varying operation counts. First query with 1 operation, second with 4 operations, and third with 9 operations. It is important to note that when this operation count increases, the higher the workload for API Manager. Details regarding the query variations are outlined below. The three queries and their responses can be found [here](https://github.com/ashera96/performance-apim/tree/master/resources).

<table>
<thead>
  <tr>
    <th><b>Query</b></th>
    <th><b>No. of Operations</b></th>
    <th><b>Query Depth</b></th>
    <th><b>Query Size</b></th>
    <th><b>Response Size</b></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Query 1</td>
    <td>1</td>
    <td>2</td>
    <td>157B</td>
    <td>790B</td>
  </tr>
  <tr>
    <td>Query 2</td>
    <td>4</td>
    <td>2</td>
    <td>1KB</td>
    <td>5KB</td>
  </tr>
  <tr>
    <td>Query 3</td>
    <td>9</td>
    <td>2</td>
    <td>2KB</td>
    <td>27KB</td>
  </tr>
</tbody>
</table>

Two key performance metrics were used to measure the performance of each test. 

- Throughput: This measures the number of API invocations that the API Manager Gateway server processed during a specific time interval (e.g., per second). 
- Response Time: This measures end-to-end processing time for an operation (of invoking an API using HTTPS protocol). The complete distribution of response times was recorded.

## Deployment used for the test

[![API-M GraphQL performance test all-in-one deployment]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/apim_performance_test_all_in_one_deployment_graphql.png){: style="width:80%"}]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/apim_performance_test_all_in_one_deployment_graphql.png)

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

All scripts used to run the performance tests and analyze results are in the following repositories:

- [performance-common](https://github.com/ashera96/performance-common)

- [performance-apim](https://github.com/ashera96/performance-apim)

## Results

The complete results can be found [here](https://github.com/wso2/performance-apim/blob/performance-test-378-2022-07-08_14-57-52/performance/benchmarks/summary.md).

The following graph depicts the throughput changes based on the number of concurrent users for different GraphQL queries.

[![lineplot throughput vs concurrent users]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/thrpt_0ms.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/thrpt_0ms.png)

**Key observations:**

- More concurrent users mean more requests to the API Manager Gateway. Therefore, the throughput of the API Manager Gateway increases as the number of concurrent users accessing the APIs increases. The maximum throughput is observed around 50 and 100 concurrent users, and the throughput degrades slightly after 100 concurrent users due to resource contentions in the system. The degradation point mainly depends on hardware resources. Note that a similar pattern can be seen across all three queries.

- The highest throughput values were observed for Query 1, while the lowest values were observed for Query 3. For a given API invocation, the request payload, which includes the GraphQL query, is processed by the API Manager Gateway before the request is sent to the backend. Operation count within this query has an effect on performance as we provide QoS (quality of service) based on operations. Similarly, the query size has an effect on the performance as the number of fields requested by the query is increased eventhough the query depth is kept constant. The API Manager observes a considerable overhead when the query size and operation count keeps increasing due to the payload processing time. As the query sizes used for the tests are 157B, 1KB and 2KB, and the operation counts used for the tests are 1, 4 and 9, the growth is exponential and that justifies the throughput numbers depicted in the above plot.


The following graph depicts the average response time changes based on the number of concurrent users for different GraphQL queries.

[![lineplot average response time 2G 1KiB 0ms]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/avgt_0ms.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/avgt_0ms.png)

**Key observations:**

- The average response time increases with the number of concurrent users. As the number of requests to serve increases with more users, there are more resource contentions. Therefore, the number of concurrent users served by the API Gateway needs to be decided on the required response time limits. Again, the average response time also varies as the hardware resources change. For example, a user can achieve a lower response time if the number of CPUs allocated is increased.

- Query 3 shows the highest response time due to the performance overhead caused by the payload processing time at the API Manager Gateway.


Let’s look at the 90th, 95th, and 99th response time percentiles. It is useful to measure the percentage of requests that exceeded the response time value for a given percentile. A percentile can be used to determine the percentage of requests completed below the particular response time value.

For example, when there are 100 concurrent users, the 90th response time percentile for Query 1 is 102ms. This means that 10% of the requests have taken more than 102ms to respond. Similarly, the 99th response time percentile for Query 1 is 201ms, which means that 99% of the requests have been completed within 201ms.

The figure below represents the percentile values for Query 1.

[![Response time 0ms 1KiB]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/response-time-summary-query1-0ms.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/response-time-summary-query1-0ms.png)

**Key observations:**

- Query 2 and Query 3 scenarios are relatively slower than the preceding results due to the performance overhead caused by the payload processing at the API Manager Gateway.

- Response Times percentiles are less than 750ms up to 300 concurrent users for all three queries.

!!! note
    1000 concurrent users mean a lot, and it is not very common. It is recommended to scale horizontally or vertically to support more concurrent users with acceptable response times. When scaling horizontally, two or more Gateway nodes need to be used with a load balancer. Another load test must be carried out to measure the performance after scaling.

In order to see the memory usage, the Garbage Collection (GC) logs in the API Manager were enabled using the following flags.

```
-XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:"$CARBON_HOME/repository/logs/gc.log
```

In addition, the GC log for each performance test was analyzed using the GCViewer.
The GC Throughput was calculated for each test to check whether GC operations are not impacting the performance of the server. The GC Throughput is the time percentage of the application, which was not busy with GC operations. For example, if the application ran for 10 minutes and 30 seconds were taken for GC operations, the GC Throughput is (1 - 30/(10*60)) * 100 = 95%. A GC Throughput over 90% is good, and that means the allocated heap was enough to handle all concurrent requests, which allocate objects in the memory. On the contrary, if the GC throughput is a lower value, it indicates that the allocated memory is not enough for API Manager to function efficiently.

The following chart depicts the GC Throughput (%) based on the number of concurrent users for different GraphQL queries.

[![Lineplot WSO2 Api Manager GC throughput 2G 50B 0ms]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/gc_0ms.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/graphql/gc_0ms.png)

