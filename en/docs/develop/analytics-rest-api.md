# Fetch APIM Analytics Data via Siddhi REST API

Analytics data published to the WSO2 APIM Analytics Server can be viewed via the analytics dashboard portal. In addition to this, these data can be fetched via REST APIs to external dashboards/applications for interested parties. Following section explains the usage of the Siddhi Store REST API to achieve this requirement.


## Retrieving records from aggregation tables

WSO2 APIM Analytic Server persists analytics data in aggregation tables. Data can be retrieved from these tables by execurting a cURL command with a siddhi query which adheres to the following syntax.

```
from <aggregation> 
  <on condition>?
  within <time range>
  per <time granularity>
select <attribute name>, <attribute name>, ...
  <groupby>?
  <having>?
  <order by>?
  <limit>? 
```


### Sample cURL Command

``` java tab="Format"
curl -X POST -u "username:password" -H "Content-Type: application/json"  -d '{"appName" : "APIM_ACCESS_SUMMARY", "query" : "from <aggregatiom_table> on <condition> within <from_timestamp>, <to_timestamp> per \"<granularity>\" select <comma separated column list> order by <required_column_to_order> DESC"}' "https://<hostname>:<port>/stores/query" -k
```

``` java tab="Sample"
curl -X POST -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "APIM_ACCESS_SUMMARY", "query" : "from ApiUserPerAppAgg on apiName==\"PizzaShackAPI\" within 1537333194000L, 1539752394000L per \"days\" select username, apiCreator, sum(totalRequestCount) as net_total_requests group by username, apiCreator order by net_total_requests DESC" }' "https://localhost:7444/stores/query" -k
```


### Sample Response

```{"records":[["admin@carbon.super","admin",45]]}```

## Constructing a Siddhi Query to Fetch Data

Available aggregation tables in APIM Analytics and its schema are listed in [here]({{base_path}}/learn/analytics/analyzing-apim-statistics-with-batch-analytics/introducing-the-wso2-api-manager-statistics-model/#api-manager-aggregate-tables). By inspecting the schema of each aggregation table, and modifying the query accordingly, required data can be fetched via the API from REST clients. 



