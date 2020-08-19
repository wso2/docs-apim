# Monitoring dashboard

## Overview

## API usage analysis

### API usage summary

![API usage summary]({{base_path}}/assets/img/learn/analytics/monitoring_usage_summary.png)

This provides aggregated API invocation count in a selected time period. When an API request is received to the API gateway there can be multiple validations before the request goes to the backend service. Ex like API can be successfully forward to the backend or rejected due to authentication failure, throttling, or in case of internal errors/faulty. This widget successful, faulty, and throttled out API requested counts are visualized. If an API request dispatched the backend and received a response, consider as a successful request. In case a runtime error or a backend connection error occurred consider them as faulty requests. Currently, only the runtime or backend errors consider as faulty and authentication or throttled out requests don’t consider as faulty. If a request is throttled out due to any throttling level policy consider as throttled out request. So if a request comes to the gateway it can be either success, faulty, or throttled out. Hence total request GW received should equal success + faulty + throttle out.

Usage summary can be broken into APIs, Versions, and Resources level. Drill down can be changed by selecting the provided radio buttons. By clicking on the bars can change the drill down from API, Versions, and Resources. Users can decide the expected summarization of the result data. The initial view is set to API and usage data are loaded against the APIs. When the view type is selected to version aggregating are done and return data against the version. Resource view types also work in the same manner. 

There 3 separate stacked bars in each bar to represent it’s a success, faulty, and throttled out count. These are represented in a stacked bar chart for easily compare against these dimensions. Any dimensions (success, faulty, and throttled) can be enabled/disabled using the provided tickbox for a better view. 

Version and Resource wise aggregations help to point out the issues or usage in depth. Filters support APIs, Version, and resources when a user needs to check data on a specific API when there are multiple APIs, Version, or Resources. Click on a specific data unit or bar in the chart redirect the user to the API USAGE OVER TIME widget for further analysis. 


### API usage over time

![API usage over time]({{base_path}}/assets/img/learn/analytics/monitoring_usage_overtime.png)

This widget provides the same information but in a time series. The same data including the success, Faulty, and throttled out usages are plotted as a line chart in this widget. A Time series graph is provided for analytics usage patterns over time. It can be used to identify anomalies and abnormal access patterns.
 
Example:

    Observation:  Sudden drop in the success count and continue the same count
    Reason: Connection issue to backend service limitation

    Observation:  Multiple spikes in the throttled out a request in over the past few days
    Reason: Planned rate limiting is not enough with the application growth

Multiple filtering level support similar to the previous behavior and API, Version and resource level filtering can be applied to drill down to resource level. An issue or pattern can be identified in each version and resource. Similar to the previous chart, the required dimensions can be enabled or disabled to clearly identify the lines. 

## Viewing API Health and System Alert

Widgets in this section are mainly focusing on the API Health and System related alerts. Details about the generated alerts are shown under these widgets.

### API availability summary

!!! note
    In order to view statistics of API Availability widget, it is required to enable alerts as described in [Configuring Alerts]({{base_path}}/learn/analytics/managing-alerts-with-real-time-analytics/configuring-alerts/).

API availability summary widget provides an overall look on the availability of the APIs. It shows whether the API is available(which means API is in good health), whether the Response time of the API is high or whether a server error occurred when accessing the API as percentages for the APIs of the logged in user's tenant. 
The availability of API statistics are directly related to the [Availability of APIs (health monitoring)]({{base_path}}/learn/analytics/managing-alerts-with-real-time-analytics/alert-types/#availability-of-apis-api-health-monitoring) alert type. 
Moreover, once the user clicks on one of the available three status for the API availability, it drills down to the API availability widget and shows details of the APIs which have the selected status.

!!! note
    This widget works only when the alerts are enabled. If alerts are disabled, the chart will show 100% availability.

![API availability summary]({{base_path}}/assets/img/learn/analytics/api_availability_summary.png)

### API availability

API availability widget shows detailed view of the availability of the APIs. If the API is in a healthy position it shows Available and if not it shows Limited as the status.

![API availability]({{base_path}}/assets/img/learn/analytics/api_availability.png)

Availability of the APIs can be queried by the status(Available, High Response Time, Server Malfunction).

![API availability query]({{base_path}}/assets/img/learn/analytics/api_availability_query.png)

Furthermore, results can be filtered by API NAME, VERSION or STATUS by clicking on the search icon
<html>
<body>
<img src="{{base_path}}/assets/img/learn/analytics/search_icon.png" width="25"/>
</body>
</html>
.

![API availability filter]({{base_path}}/assets/img/learn/analytics/api_availability_filter.png)

### Top API by alert count

By going through the Top API by alert count widget, the user can easily identify the top APIs that the alerts have generated in the past 7 days and act accordingly. 
It shows the total number of alerts generated for a particular API in the last 7 days. 
In this widget, the user can filter the results by API NAME or COUNT. 
Moreover, once the user clicks on the name of an API in the table, it drills down to the Alerts summary widget and it shows a summary of alerts generated for the selected API.

![Top API by alert count]({{base_path}}/assets/img/learn/analytics/top_api_by_alert_count.png)

### Alert summary

Alerts summary widget provides the user with a summary of all the alerts generated in the past. 
It provides API NAME, ALERT TYPE, SEVERITY, DETAILS and the ALERT TIME for a generated alert and the user can filter alerts by the aforementioned fields.

![Alert summary all]({{base_path}}/assets/img/learn/analytics/alert_summary_all.png)

In this widget, the user has the option to query generated alerts for a single API as well.

![Alert summary API]({{base_path}}/assets/img/learn/analytics/alert_summary_api.png)
