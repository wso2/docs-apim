# Performance Test Results for Router with One CPU

These test results were obtained considering a Choreo Connect deployment with default values. Therefore the concurrency level used for the tests was two. Below table shows resource allocations for the Choreo Connect components.

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
    <td>1000</td>
    <td>1000</td>
    <td>1000</td>
    <td>1000</td>
  </tr>
  <tr>
    <td>Router</td>
    <td>500</td>
    <td>1000</td>
    <td>500</td>
    <td>1000</td>
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

 Below graphs depict performance test results considering different test parameters.

# Comparison of results

## Throughput (requests/sec) vs. concurrent users
The following graph illustrates the throughput against the number of concurrent users.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-120-1cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-120-1cpu.png" width="90%" ></a>

**Key observations:**

- More concurrent users mean more requests to the Choreo Connect. For a given payload size, Choreo Connect provides a most likely consistent throughput level. But for large payload sizes you will get a low throughput value when compared to the small payload sizes.

## Average Response time (ms) vs. concurrent users

Backend delay is assigned as zero milliseconds when obtaining test results. The below graph shows how response time varied for different concurrent user counts. Also, the same graph shows the impact of the payload size considering the same two parameters.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-120-1cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-120-1cpu.png" width="90%" ></a>

**Key observations:**

- When increasing concurrent users for given payload size, Choreo Connect consumes steady growth for the response time. But when considering the same user count for large payloads, response time is high compared to the small payloads.

## Response time percentiles vs. concurrent users

Below graphs show 90th, 95th, and 99th Response Time percentiles for 0ms backend delay. This is useful to measure the percentage of requests that exceeded the response time value for a given percentile. A percentile can also tell the percentage of requests completed below the particular response time value.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-120-1cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-120-1cpu.png" width="90%" ></a>

Data relevant to the test scenarios listed in the below table.

|Concurrent Users|Message Size (Bytes)|Total requests|Average Response Time (ms)|Throughput (Requests/sec)|Error %|Error Count|Little's law verification|90th Percentile of Response Time (ms)|95th Percentile of Response Time (ms)|99th Percentile of Response Time (ms)|
|----------------|--------------------|--------------|--------------------------|-------------------------|-------|-----------|-------------------------|-------------------------------------|-------------------------------------|-------------------------------------|
|10              |50B                 |2140425       |4.13                      |2374.69                  |0      |0          |9.81                     |5                                    |5                                    |12                                   |
|50              |50B                 |2899163       |15.44                     |3215.34                  |0      |0          |49.64                    |50                                   |54                                   |58                                   |
|100             |50B                 |2938040       |30.55                     |3260.78                  |0      |0          |99.62                    |66                                   |69                                   |74                                   |
|200             |50B                 |2822101       |63.72                     |3131.36                  |0      |0          |199.53                   |89                                   |92                                   |99                                   |
|500             |50B                 |2840020       |158.43                    |3150.38                  |0      |0          |499.11                   |194                                  |199                                  |220                                  |
|1000            |50B                 |2907110       |310.24                    |3218.49                  |0      |0          |998.50                   |371                                  |381                                  |401                                  |
|10              |1KiB                |2116976       |4.17                      |2350                     |0      |0          |9.80                     |5                                    |5                                    |12                                   |
|50              |1KiB                |2905703       |15.40                     |3225.4                   |0      |0          |49.67                    |48                                   |52                                   |57                                   |
|100             |1KiB                |2902109       |30.93                     |3220.87                  |0      |0          |99.62                    |66                                   |69                                   |73                                   |
|200             |1KiB                |2860810       |62.85                     |3174.2                   |0      |0          |199.50                   |89                                   |92                                   |99                                   |
|500             |1KiB                |2845235       |158.16                    |3154.25                  |0      |0          |498.88                   |196                                  |202                                  |257                                  |
|1000            |1KiB                |2838028       |317.68                    |3140.8                   |0      |0          |997.77                   |379                                  |391                                  |409                                  |
|10              |10KiB               |1938931       |4.55                      |2149.61                  |0      |0          |9.78                     |5                                    |5                                    |13                                   |
|50              |10KiB               |2385220       |18.77                     |2647.29                  |0      |0          |49.69                    |54                                   |57                                   |61                                   |
|100             |10KiB               |2425520       |37.00                     |2692.01                  |0      |0          |99.60                    |72                                   |75                                   |80                                   |
|200             |10KiB               |2381251       |75.54                     |2639.64                  |0      |0          |199.40                   |98                                   |102                                  |111                                  |
|500             |10KiB               |2489860       |180.85                    |2759                     |0      |0          |498.97                   |207                                  |217                                  |267                                  |
|1000            |10KiB               |2534124       |355.98                    |2801.6                   |0      |0          |997.31                   |405                                  |415                                  |469                                  |
|10              |100KiB              |1086595       |8.11                      |1205.67                  |0      |0          |9.78                     |10                                   |17                                   |23                                   |
|50              |100KiB              |1139416       |39.28                     |1264.48                  |0      |0          |49.67                    |74                                   |79                                   |88                                   |
|100             |100KiB              |1195828       |75.05                     |1326.94                  |0      |0          |99.59                    |116                                  |138                                  |163                                  |
|200             |100KiB              |1238292       |145.20                    |1373.8                   |0      |0          |199.48                   |205                                  |216                                  |241                                  |
|500             |100KiB              |1263209       |356.89                    |1399.63                  |0      |0          |499.51                   |409                                  |425                                  |459                                  |
|1000            |100KiB              |1251678       |719.45                    |1380.16                  |0      |0          |992.96                   |811                                  |831                                  |895                                  |
