# Viewing API Analytics on Traffic

This page shows information related to the traffic that goes through your API management system. This includes API usage, Application usage, Resource usage, etc. You can use this page to investigate the usage of APIs and Applications, traffic patterns, etc.

![traffic page full]({{base_path}}/assets/img/analytics/traffic/traffic-page-full.png)

See the topics given below to get details of the available widgets.
 
## Common Controls

The Traffic page offers you the two additional common controls listed below.

![common controls]({{base_path}}/assets/img/analytics/traffic/common-controls.png)

### API Selector

Use the **API Selector** to select the APIs for which you want to view analytics. By default, this is set to **All**. You can select one or multiple APIs from this selector and view the aggregated result. The **Application** control (described below) is populated based on your API selector configuration.
  
### Application Selector

Use the **Application Selector** to narrow down the API search to the application level. If the same API is used by multiple applications,
use this selector to get the traffic per application or a set of applications. The options available for this selector depend on what you specified for the API selector.
  
## Page Walk Through

The following topics walk you through the main features available for monitoring traffic.

### API Usage Overtime

This timeline shows the count of API hits for the APIs you selected using the above-mentioned selectors. If multiple APIs are
 selected, the timeline shows each API in a separate line with a legend separating each line. You can also zoom in on a selected time range by selecting that area in the chart.
 To restore to the original view use the 'zoom out' button on top right-hand corner of the plot.
 
![api usage timeline]({{base_path}}/assets/img/analytics/traffic/api-usage-timeline.png)
 
## API Usage by Application

This widget shows the per-application breakdown of requests for the APIs you selected. You can use the pie chart view or the line chart view. You can switch between the two views using the small icon at the upper-right corner 
of the widget.
<img src="{{base_path}}/assets/img/analytics/traffic/usage-by-application.png" title="usage by application" width="380"/>
  
## API Usage by Backend

This widget shows the per-backend breakdown of requests for the APIs you selected. This is useful when multiple APIs are sharing the same backend, which has traffic restrictions. You can use these stats to proactively scale your backends. You can switch between the two views using the small icon at the upper-right corner 
of the widget.
<img src="{{base_path}}/assets/img/analytics/traffic/usage-by-backend.png" title="usage by backend" width="380"/>

## API Resource Usage Summary

This table shows a resource-level breakdown of API traffic. Each row represents an API resource and it shows the
 API name, resource path, API method, and the hit count for that combination. 
 
!!! Note
    The **API Selector** and **Application Selector** controls do not apply to this widget.

![resource usage]({{base_path}}/assets/img/analytics/traffic/resource-usage.png)
