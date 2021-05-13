# Fetch API-M Analytics Data via Siddhi REST API

You can view the analytics related data that is published to the WSO2 API-M Analytics Server via the analytics dashboard portal. In addition, interested parties can fetch this data via REST APIs to external dashboards/applications. The following section explains the usage of the Siddhi Store REST API to achieve the latter mentioned requirement.

## Retrieving records from aggregation tables

WSO2 API-M Analytic Server persists analytics related data in the aggregation tables. You can retrieve data from these tables by executing a cURL command with a Siddhi query that adheres to the following syntax.

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


### Sample cURL command

``` java tab="Format"
curl -X POST -u "username:password" -H "Content-Type: application/json"  -d '{"appName" : "APIM_ACCESS_SUMMARY", "query" : "from <aggregatiom_table> on <condition> within <from_timestamp>, <to_timestamp> per \"<granularity>\" select <comma separated column list> order by <required_column_to_order> DESC"}' "https://<hostname>:<port>/stores/query" -k
```

``` java tab="Sample"
curl -X POST -H "content-type: application/json" -u "admin:admin" -d '{"appName" : "APIM_ACCESS_SUMMARY", "query" : "from ApiUserPerAppAgg on apiName==\"PizzaShackAPI\" within 1537333194000L, 1539752394000L per \"days\" select username, apiCreator, sum(totalRequestCount) as net_total_requests group by username, apiCreator order by net_total_requests DESC" }' "https://localhost:7444/stores/query" -k
```


### Sample Response

```{"records":[["admin@carbon.super","admin",45]]}```

## Constructing a Siddhi Query to fetch data

The available aggregation tables in WSO2 API-M Analytics and its schema listed [here]({{base_path}}/observe/api-manager-analytics/analytics-event-streams-and-aggregations/#api-manager-aggregate-tables). 

You need to inspect the schema of each aggregation table and thereafter modify the query accordingly, in order to fetch the required data via the API from the REST clients.
