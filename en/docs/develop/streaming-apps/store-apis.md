# Store APIs

## Query records in Siddhi store

### Overview

<table>
<tbody>
<tr class="odd">
<th>Description</th>
<td>Queries records in the Siddhi store. For more information, see [Integrating Data Stores in Streaming Integration]({{base_path}}/use-cases/streaming-tutorials/integrating-stores#perform-crud-operations-via-rest-api).</td>
</tr>
<tr class="even">
<th>API Context</th>
<td><code>/stores/query</code></td>
</tr>
<tr class="odd">
<th>HTTP Method</th>
<td>POST</td>
</tr>
<tr class="even">
<th>Request/Response format</th>
<td>application/json</td>
</tr>
<tr class="odd">
<th>Authentication</th>
<td>Basic</td>
</tr>
<tr class="even">
<th>Username</th>
<td>admin</td>
</tr>
<tr class="odd">
<th>Password</th>
<td>admin</td>
</tr>
<tr class="even">
<th>Runtime</th>
<td>server/tooling</td>
</tr>
</tbody>
</table>

### curl command syntax

``` java
curl -X POST https://localhost:9443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "AggregationTest", "query" : "from stockAggregation select *" }' -k
```

### Sample curl command

``` java
curl -X POST https://localhost:7443/stores/query -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "ApiRequestSummary", "query" : "from API_REQUEST_SUMMARY within 1586249325000L, 1586335725000L per \"days\" select userId, apiPublisher, sum(totalRequestCount) as net_total_requests group by userId, apiPublisher order by net_total_requests DESC;" }' -k
```

### Sample output

``` java
{"records":[["admin","admin",66]]}
```

### Response

<table>
<tbody>
<tr class="odd">
<th>HTTP Status Code</th>
<td><p>200 or 404</p>
<p>For descriptions of the HTTP status codes, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/ref/hTTP-Status-Codes/">HTTP Status Codes</a> .</p></td>
</tr>
</tbody>
</table>

