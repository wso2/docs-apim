# Performance Test Results

The performance of WSO2 API Manager was measured for GraphQL APIs. While the schema, the queries, and the responses were mimicked using the [Starwars API](https://github.com/wso2/samples-apim/tree/master/graphql-backend), the backend used for the test is a Netty backend. The netty service is configured so that the response is aligned with the GraphQL request in order to only provide the data requested by a particular query.

Tests were done using 50, 100, 200, 500, and 1000 concurrent users. Concurrent users mean that it consists of multiple users accessing the API Gateway at the same time. Three GraphQL queries were used for the tests. These queries were constructed with varying operation counts. First query with 1 operation, second with 4 operations, and third with 9 operations. It is important to note that when this operation count increases, the higher the workload for API Manager. Details regarding the query variations are listed down below:

<table>
<thead>
  <tr>
    <th>Query</th>
    <th>No. of Operations</th>
    <th>Query Depth</th>
    <th>Query Size</th>
    <th>Response Size</th>
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


The key performance metric used to measure the performance of GraphQL APIs is: 

- Throughput: This measures the number of API invocations that the API Manager Gateway server processed during a specific time interval (e.g., per second).

## Deployment used for the test

[![API-M graphql performance test all-in-one deployment]({{base_path}}/assets/img/setup-and-install/performance-test-results/apim_performance_test_all_in_one_deployment_graphql.png){: style="width:80%"}]({{base_path}}/assets/img/setup-and-install/performance-test-results/apim_performance_test_all_in_one_deployment_graphql.png)

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
- The operating system is Ubuntu 20.04
- Java version is JDK 11

### Performance test scripts

All scripts used to run the performance tests and analyze results are in the following repositories.

- [https://github.com/wso2/performance-common](https://github.com/wso2/performance-common)

- [https://github.com/wso2/performance-apim](https://github.com/wso2/performance-apim)

## Results

The following graph depicts the throughput changes based on the number of concurrent users for different GraphQL queries.

[![lineplot throughput vs concurrent users]({{base_path}}/assets/img/setup-and-install/performance-test-results/lineplot-throughput-vs-concurrent-users-graphql.png)]({{base_path}}/assets/img/setup-and-install/performance-test-results/lineplot-throughput-vs-concurrent-users-graphql.png)

**Key observations:**
