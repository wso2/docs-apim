#Overview Page
![overview page full]({{base_path}}/assets/img/observe/overview/overview-page-full.png)
This is the welcome page of the analytics portal. This page will mainly display a quick overview of the whole
 management system. Targeted audience for the page are managers and business users who need quick insight. Also this
  page can be used as a dashboard displaying current system status.
 
### Total Traffic Widget
![overview page total traffic]({{base_path}}/assets/img/observe/overview/overview-page-total-traffic.png)

Total traffic widget displays the total traffic your selected environment received during the selected time range
. This includes both successful requests and error requests. If you want to further investigate the traffic, see the [traffic page]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-traffic).
 [traffic page]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-traffic).
 
### Latency Widget
![overview page latency]({{base_path}}/assets/img/observe/overview/overview-page-latency.png)

Latency widget displays the 95th percentile of all API latencies in your selected environment for the selected time
 period. You can utilize this widget to know whether the whole system operates under given SLAs. This metric
  will give the first indication into whether there are any slow APIs. To investigate further please visit 
  [latency page]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-latency).
  
## Error Rate Widget
![overview page latency]({{base_path}}/assets/img/observe/overview/overview-page-error-rate.png)

This widget will display the average error rate (error count/total request count) in your selected environment for
 the selected time period. You can utilize this widget as an indicator to know the health of the system. If error
  rate is high you will need to investigate more via 
  [error page]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-erros).
  
## API Request Summary Timeline
![overview page latency]({{base_path}}/assets/img/observe/overview/overview-page-timeline.png)

This chart combine above three widgets and plot them as a timeline. Left y-axis will show the 'request count' and 'error
 count. x-axis displays time and right y-axis shows latency in milliseconds. Granularity of the data points will be
  decided based on the time range you have selected. Tooltip will provide the exact value of all three metrics
   accurately. 
