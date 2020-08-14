# Business Analytics
The business analytics dashboard provides business insights on APIs enabling users to take proactive actions to improve profitability and the quality of the service provided. 

!!! note
    During drill downs across dashboard pages, the date range selection will be preserved. 
    
## Overview
The overview page comprises 4 summary widgets that shows an overview of the APIs during the past 30 days. These widgets consist of the following:

- [Usage of the top 10 most used APIs]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#top-10-api-usage-during-past-30-days)
- [Performance of the top 10 most used APIs]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#top-10-apis-performance-summary)
- [Top 10 most throttled out APIs]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#top-10-throttle-out-apis-during-past-30-days)
- [Errors incurred during innovations]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#faults-during-past-30-days)

### Top 10 API usage during past 30 days
This widget shows an overtime breakdown of the usage of the top 10 most used API over the past 30 days. Upon clicking on this widget, it will be redirected to the API usage over time page with the top 10 APIs selected and the time range set to 1 month. 

![Top 10 API usage during past 30 days]({{base_path}}/assets/img/learn/analytics/analytics_top_10_api_usage_during_past_30_days.png)

### Top 10 API’s performance summary
This widget shows an overtime breakdown of the performance of the top 10 most used APIs during the past 30 days. Upon clicking on this, it will be redirected to the Performance summary page with the top 10 APIs selected and the time perioranged set to 1 month.

![Top 10 API’s performance summary]({{base_path}}/assets/img/learn/analytics/analytics_top_10_apis_performance_during_past_30_days.png)

### Top 10 throttle out APIs during past 30 days
This widget shows an overtime breakdown of the throttle count of the top 10 most throttled out APIs during the past 30 day. Upon clicking on this, it will be redirected to the Throttle summary widget with the top 10 throttled APIs selected and the time range set to 1 month.

![Top 10 throttle out APIs during past 30 days]({{base_path}}/assets/img/learn/analytics/analytics_top_10_throttled_out_apis_during_past_30_days.png)

### Faults during past 30 days
This widget shows an overtime breakdown of the total number of faults(of all APIs) during the past 30 day. Upon clicking this, it will be redirected to the Error summary page with the time range set to 1 month.

![Faults during past 30 days]({{base_path}}/assets/img/learn/analytics/analytics_error_during_past_30_days.png)

## API usage analysis
API usage related data is represented through overall and over time graphs in the business dashboard. Information related to API usage can be found in the following 2 pages of the business analytics dashboard:

-   [Usage summary]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#usage-summary)
-   [API usage]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#api-usage)

### Usage summary
The usage summary page provides a summarized view of the usage of the selected API(s) for the specified time period.

#### Overall API usage
This graph shows the usage count of the selected API(s) for the specified time period along with their subscription count. This widget contains 2 graphs;

- A 3D scatter plot matrix which shows the API, usage count and the subscription count. The API name is taken as the X axis and the subscription count is shown in the Y axis while the size of the data point indicates the usage count.
- A table which shows the usage count of each API.

The default view of these graphs will be;

- The scatter plot points will be ordered from left to right by the API name in ascending order
- The table will be ordered by the usage count in descending order

Upon clicking on a specific API entry in the table, it will be redirected to the API usage over time page so that the user can view the breakdown of the usage count over time.

![Usage summary]({{base_path}}/assets/img/learn/analytics/analytics_overall_api_usage_widget.png)


#### API usage by application
The API usage by application graph shows an application wise breakdown of the usage count of the selected API(s) for the specified time period. The default view will be ordered by the usage count in descending order. Upon clicking on a specific entry in the table, it will be redirected to the API usage over time page so that the user can view the breakdown of the usage of the selected API over time by the selected application.

![API usage by application]({{base_path}}/assets/img/learn/analytics/analytics_api_usage_by_app_widget.png)


#### API backend usage summary
The API backend usage summary shows the usage count of the backends of the selected API(s)  for the specified time period. The default view will be ordered by the usage count in descending order. 

![API backend usage summary]({{base_path}}/assets/img/learn/analytics/analytics_api_backend_usage_widget.png)


#### API resource usage summary
The API resource usage summary shows the usage count of the resources of the selected API(s) for the specified time period. The default view will be ordered by the usage count in descending order. 

![API resource usage summary]({{base_path}}/assets/img/learn/analytics/analytics_api_resource_usage_widget.png)

#### Top API users 
The top API users widget will display the list of users who have done the most number of API invocations ordered in descending order by usage count.

![Top API users]({{base_path}}/assets/img/learn/analytics/analytics_top_api_users_widget.png)

### API usage
The API usage page provides an overtime representation of the usage of the selected API(s) for the specified time range.  

#### API usage over time
API usage over time widget shows the usage of the selected API(s) for the specified time range.  The usage patterns displayed in this graph will help to identify the trending APIs and to decide which API(s) to deprecate.

![API usage over time]({{base_path}}/assets/img/learn/analytics/analytics_api_usage_overtime_widget.png)

This graph can also be used to view the usage of the selected API(s) by a specific application over time for the specified time period. The applications listed will be those with subscriptions to the selected API(s).

![API usage over time by app]({{base_path}}/assets/img/learn/analytics/analytics_api_usage_overtime_by_app_widget.png)

## Viewing API Performance
Analyzing performance of APIs will help identify problematic APIs. Information related to API performance can be found in the following 2 pages of the business analytics dashboard:

- [Performance summary]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#performance-summary)
- [API performance]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard/#api-performance)

### Performance summary

#### Performance summary
The performance summary widget displays the performance of selected API(s) over time for the specified time period. In this widget the average response time is taken as the performance of an API. Upon clicking on a data point in this graph, it will be redirected to the API latency time widget for the selected API.

![Performance summary]({{base_path}}/assets/img/learn/analytics/analytics_performance_summary_widget.png)

### API performance

#### API latency time
The API  latency time graph shows the latency breakdown of the selected resource of the selected API for the specified time period. The latencies displayed in this widget are

- Response time

    Total time taken for request/response flow
    
- Security latency

    Time taken for authentication
    
- Throttling latency

    Time taken for throttling the request/response
    
- Request mediation latency

    Time taken to mediate the request
    
- Response mediation latency

    Time taken to mediate the response
    
- Backend latency

    Time taken by the backend to return the response
    
- Other latency

    Time taken to process tasks other than mentioned above

![API latency time]({{base_path}}/assets/img/learn/analytics/analytics_api_latency_widget.png)

## Devices and User agent analysis

Platforms(OS) and User agent-based analytics are presented on the devices page in the business analytics dashboard. There are two widgets to show Platforms and User agent-based API Invocations. API Dimension selector is available to filter multiple APIs and aggregated results will display in both widgets. The day time range is also applicable here to get data within a selected time range. 

### Top platforms

![Top platforms]({{base_path}}/assets/img/learn/analytics/top_platforms.png)

This shows the top platform APIs are accessed. It represents in a pie chart for easy comparison and shows the percentage of the API invocation count. This widget can be used to identify the top platform used to access the APIs and top platform applications use. 

### Top user agents

This is also a pie chart and shows the top agents this API is accessed. It shows the percentage of the invocations and pie chart makes it easy to easily compare the agent types.

![Top user agents]({{base_path}}/assets/img/learn/analytics/top_user_agents.png)

Platforms and user agents are extracts from the information in the API request. X-forwarded-for Header is used in this case and this header needs to be there in the request headers to make these widgets work correctly. There are some scenarios this header values can be injected into the request when it flows through the network hops. But it is required to send this header by the actual end-user or device to make with the chart populate correctly. 

A library is used to extract this information from the header. By default API Analytics defined limited platforms and user agents to identify in a header. This is to improve performance and having too many could increase the searching time. Values to be identified can be configured by defining in the <Analytics_HOME>/conf/worker/regexes.yaml as a set of regular expressions. Dev-ops or administrators can define possible values as per the expected environment. As an example, if the applications are developed only for the android and IOS platforms it is unnecessary to search the “Windows” platform. If the user agent or platform not defined in the configurations these requests are counts as “other” and widgets will be labeled them as others. 
