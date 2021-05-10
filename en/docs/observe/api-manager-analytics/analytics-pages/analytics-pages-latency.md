# Latency Page

The latency page shows information related to the latency of API calls within the API management deployment. You can view a summary of the slowest APIs and then drill down into the API view for further analysis. Use this page as the starting point for debugging API slowness. 

![latency page full]({{base_path}}/assets/img/observe/latency/latency-page-full.png)

See the topics given below to get details of the available widgets.

## Page Walk Through
The following topics walk you through the main features available for monitoring API latency.

### Top 10 Slowest API Chart
Use line charts to find the slowest APIs of the API management system at a glance. Since these are the APIs that contribute to the higher 95th percentile of the system, improving these APIs lowers the 95th percentile of latency in the API Management system.

![slowest apis]({{base_path}}/assets/img/observe/latency/slowest-apis.png)
### Latencies by Category
This widget allows you to further drill down details in the above chart. Use the API selector in this widget to select the slow API you identified in the earlier step and then troubleshoot further. Use the charts available in the widget to view the 95th percentile and the median latency of the components given below over the selected period.
- Backend
- Request mediation
- Response mediation

![latency by category]({{base_path}}/assets/img/observe/latency/latency-by-category.png)

You can use these charts to drill down to the component level where the slowness occurs. Also, because you can see both the median and 95th percentile, you can easily identify whether the slowness is occurring in each request or whether it is intermittent.
is occurring in each request or whether it is intermittent.
