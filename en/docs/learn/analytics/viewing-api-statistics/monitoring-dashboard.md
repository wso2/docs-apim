# Monitoring dashboard

## Overview

## API usage analysis

### Api usage summary

![Api usage summary]({{base_path}}/assets/img/learn/analytics/monitoring_usage_summary.png)

This provides aggregated API invocation count in a selected time period. When an API request is received to the API gateway there can be multiple validations before the request goes to the backend service. Ex like API can be successfully forward to the backend or rejected due to authentication failure, throttling, or in case of internal errors/faulty. This widget successful, faulty, and throttled out API requested counts are visualized. If an API request dispatched the backend and received a response, consider as a successful request. In case a runtime error or a backend connection error occurred consider them as faulty requests. Currently, only the runtime or backend errors consider as faulty and authentication or throttled out requests don’t consider as faulty. If a request is throttled out due to any throttling level policy consider as throttled out request. So if a request comes to the gateway it can be either success, faulty, or throttled out. Hence total request GW received should equal success + faulty + throttle out.

Usage summary can be broken into APIs, Versions, and Resources level. Drill down can be changed by selecting the provided radio buttons. By clicking on the bars can change the drill down from API, Versions, and Resources. Users can decide the expected summarization of the result data. The initial view is set to API and usage data are loaded against the APIs. When the view type is selected to version aggregating are done and return data against the version. Resource view types also work in the same manner. 

There 3 separate stacked bars in each bar to represent it’s a success, faulty, and throttled out count. These are represented in a stacked bar chart for easily compare against these dimensions. Any dimensions (success, faulty, and throttled) can be enabled/disabled using the provided tickbox for a better view. 

Version and Resource wise aggregations help to point out the issues or usage in depth. Filters support APIs, Version, and resources when a user needs to check data on a specific API when there are multiple APIs, Version, or Resources. Click on a specific data unit or bar in the chart redirect the user to the API USAGE OVER TIME widget for further analysis. 


### Api usage over time

![Api usage over time]({{base_path}}/assets/img/learn/analytics/monitoring_usage_overtime.png)

This widget provides the same information but in a time series. The same data including the success, Faulty, and throttled out usages are plotted as a line chart in this widget. A Time series graph is provided for analytics usage patterns over time. It can be used to identify anomalies and abnormal access patterns.
 
Example:

    Observation:  Sudden drop in the success count and continue the same count
    Reason: Connection issue to backend service limitation

    Observation:  Multiple spikes in the throttled out a request in over the past few days
    Reason: Planned rate limiting is not enough with the application growth

Multiple filtering level support similar to the previous behavior and API, Version and resource level filtering can be applied to drill down to resource level. An issue or pattern can be identified in each version and resource. Similar to the previous chart, the required dimensions can be enabled or disabled to clearly identify the lines. 

