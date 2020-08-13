# Business Analytics dashboard

## Overview

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
