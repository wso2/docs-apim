# Latency Page

The latency page shows information related to the latency of API calls within the API management deployment. You can view a summary of the slowest APIs and then drill down into the API view for further analysis. Use this page as the starting point for debugging API slowness. 

![latency page full]({{base_path}}/assets/img/observe/latency/latency-page-full.png)

See the topics given below to get details of the available widgets.

## Page Walk Through
The following topics walk you through the main features available for monitoring API latency.

### Top 10 Slowest API Chart
You can use line chart to figure out the slowest APIs of the API Management system at a glance. Since these are the APIs that contribute to the higher 95th percentile of the system, 
improving these APIs will lower the 95th percentile of latency in the API Management system.

![slowest apis]({{base_path}}/assets/img/observe/latency/slowest-apis.png)
### Latencies by Category
This widget provides further drill down to the above chart. You can use the API selector in this widget to select the slow API you identified in the earlier step to troubleshoot further.
Using the charts available in the widget you can now view the 95th percentile and median latency of below three components over the selected time period.
- Backend
- Request mediation
- Response mediation

![latency by category]({{base_path}}/assets/img/observe/latency/latency-by-category.png)

By referring these charts now you can narrow it down to the component level where the slowness occurs. Also since both median and 95th percentile is present you can decide whether the slowness
is occurring in each request or whether it is intermittent.

