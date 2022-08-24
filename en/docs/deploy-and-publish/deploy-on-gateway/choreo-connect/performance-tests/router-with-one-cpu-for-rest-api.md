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

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-110-1cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/throughput-110-1cpu.png" width="90%" ></a>

**Key observations:**

- More concurrent users mean more requests to the Choreo Connect. For a given payload size, Choreo Connect provides a most likely consistent throughput level. But for large payload sizes you will get a low throughput value when compared to the small payload sizes.

## Average Response time (ms) vs. concurrent users

Backend delay is assigned as zero milliseconds when obtaining test results. The below graph shows how response time varied for different concurrent user counts. Also, the same graph shows the impact of the payload size considering the same two parameters.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-110-1cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/response-time-110-1cpu.png" width="90%" ></a>

**Key observations:**

- When increasing concurrent users for given payload size, Choreo Connect consumes steady growth for the response time. But when considering the same user count for large payloads, response time is high compared to the small payloads.

## Response time percentiles vs. concurrent users

Below graphs show 90th, 95th, and 99th Response Time percentiles for 0ms backend delay. This is useful to measure the percentage of requests that exceeded the response time value for a given percentile. A percentile can also tell the percentage of requests completed below the particular response time value.

<a href="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-110-1cpu.png"><img src="{{base_path}}/assets/img/deploy/mgw/performance-test/percentiles-110-1cpu.png" width="90%" ></a>

Data relevant to the test scenarios listed in the below table.

|Concurrent Users|Message Size (Bytes)|Total requests|Average Response Time (ms)|Throughput (Requests/sec)|Error %|Error Count|Little's law verification|90th Percentile of Response Time (ms)|95th Percentile of Response Time (ms)|99th Percentile of Response Time (ms)|
|----------------|--------------------|--------------|--------------------------|-------------------------|-------|-----------|-------------------------|-------------------------------------|-------------------------------------|-------------------------------------|
|10              |50B                 |2073910       |3                         |2303.8                   |0      |0          |6.9114                   |5                                    |5                                    |8                                    |
|50              |50B                 |2709454       |16                        |3010.2                   |0      |0          |48.1632                  |52                                   |56                                   |60                                   |
|100             |50B                 |2774645       |31                        |3082.4                   |0      |0          |95.5544                  |68                                   |70                                   |75                                   |
|200             |50B                 |2763400       |64                        |3069.1                   |0      |0          |196.4224                 |101                                  |105                                  |149                                  |
|500             |50B                 |2785153       |160                       |3093.3                   |0      |0          |494.928                  |197                                  |203                                  |254                                  |
|1000            |50B                 |2751126       |326                       |3055.3                   |0      |0          |996.0278                 |380                                  |389                                  |408                                  |
|10              |1KiB                |2091911       |3                         |2323.7                   |0      |0          |6.9711                   |5                                    |5                                    |8                                    |
|50              |1KiB                |2793064       |15                        |3102.9                   |0      |0          |46.5435                  |51                                   |55                                   |59                                   |
|100             |1KiB                |2843694       |31                        |3158.8                   |0      |0          |97.9228                  |66                                   |69                                   |73                                   |
|200             |1KiB                |3665465       |62                        |3162.9                   |0      |0          |196.0998                 |88                                   |91                                   |98                                   |
|500             |1KiB                |2853269       |157                       |3168.8                   |0      |0          |497.5016                 |194                                  |200                                  |220                                  |
|1000            |1KiB                |2837340       |316                       |3149.5                   |0      |0          |995.242                  |371                                  |382                                  |402                                  |
|10              |10KiB               |1813196       |4                         |2014                     |0      |0          |8.056                    |5                                    |6                                    |9                                    |
|50              |10KiB               |2292107       |19                        |2546.3                   |0      |0          |48.3797                  |55                                   |58                                   |63                                   |
|100             |10KiB               |2283122       |38                        |2532.6                   |0      |0          |96.2388                  |72                                   |75                                   |81                                   |
|200             |10KiB               |2325698       |76                        |2583.4                   |0      |0          |196.3384                 |102                                  |107                                  |150                                  |
|500             |10KiB               |2389789       |187                       |2654.5                   |0      |0          |496.3915                 |222                                  |251                                  |275                                  |
|1000            |10KiB               |2446750       |367                       |2717.2                   |0      |0          |997.2124                 |416                                  |439                                  |481                                  |
|10              |100KiB              |1039416       |8                         |1154.6                   |0      |0          |9.2368                   |11                                   |13                                   |17                                   |
|50              |100KiB              |1202718       |36                        |1336.1                   |0      |0          |48.0996                  |60                                   |68                                   |83                                   |
|100             |100KiB              |1225628       |72                        |1361.4                   |0      |0          |98.0208                  |109                                  |117                                  |140                                  |
|200             |100KiB              |1166856       |153                       |1296.1                   |0      |0          |198.3033                 |214                                  |232                                  |271                                  |
|500             |100KiB              |1619551       |365                       |1349.1                   |0      |0          |492.4215                 |363                                  |446                                  |473                                  |
|1000            |100KiB              |1167844       |770                       |1296.6                   |0      |0          |998.382                  |863                                  |897                                  |979                                  |
