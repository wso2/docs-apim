# Viewing the API Analytics Overview

[![overview page full]({{base_path}}/assets/img/analytics/overview/overview-page-full.png)]({{base_path}}/assets/img/analytics/overview/overview-page-full.png)

This is the welcome page of the analytics portal. This page gives you a quick overview of the whole
 management system. Targeted audience for the page are managers and business users who need quick insight. Also, this
  page can be used as a dashboard to view the current system status.
 
### Total Traffic Widget
<img src="{{base_path}}/assets/img/analytics/overview/overview-page-total-traffic.png" title="overview page total traffic" width="380"/>  

Total traffic widget displays the total traffic your selected environment received during the selected time range
. This includes both successful requests and error requests. If you want to further investigate the traffic, see [Viewing API Analytics on Traffic]({{base_path}}/api-analytics/viewing/analytics-pages-traffic).
 
### Latency Widget
<img src="{{base_path}}/assets/img/analytics/overview/overview-page-latency.png" title="overview page latency" width="380"/>

Latency widget displays the 95th percentile of all API latencies in your selected environment for the selected time
 period. You can use this widget to know whether the whole system operates under given SLAs. This metric
 gives the first indication of slow APIs. To investigate further, see [Viewing API Analytics on Latency]({{base_path}}/api-analytics/viewing/analytics-pages-latency).
  
## Error Rate Widget
<img src="{{base_path}}/assets/img/analytics/overview/overview-page-error-rate.png" title="overview page error rate" width="380"/>

This widget displays the average error rate (error count/total request count) in your selected environment for
 the selected time period. You can use this widget as an indicator to know the health of the system. If the error
  rate is high, investigate further using the [Viewing API Analytics on Errors]({{base_path}}/api-analytics/viewing/analytics-pages-errors).
  
## API Request Summary Timeline

![overview page latency]({{base_path}}/assets/img/analytics/overview/overview-page-timeline.png)

This chart combines the above three widgets and plots them in a timeline. The y-axis on the left shows the 'request count' and 'error
 count. The x-axis displays time and right y-axis on the right shows latency in milliseconds. Granularity of the data points are
  decided based on the time range you have selected. The tooltip accurately provides the exact value of all three metrics.
   accurately. 
