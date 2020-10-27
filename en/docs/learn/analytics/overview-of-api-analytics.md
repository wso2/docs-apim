# Overview of API Analytics

APIs are widely used in Business Integrations and are becoming a key part of driving an Organization's Business strategy. Ensuring the proper functioning of the APIs, getting feedback on the performance and deriving business insights from APIs are becoming equally important. WSO2 API Manager Analytics does this by integrating with WSO2 API Manager to provide statistics, reports, and graphs on the APIs deployed in WSO2 API Manager. It further allows configuring Alerts to notify about unusual behaviours and error conditions in near real-time.

In order to make the data easily available, WSO2 API Manager Analytics offers different Dashboards that show different views of the APIs to different user groups. Application Developers, API Publishers, DevOps and Program Managers can use these Dashboards to learn about different perspectives of the underlying API ecosystem. 

The sections below explain how to access the statistical dashboards. For instructions on how to set up Analytics, see [Configuring APIM Analytics]({{base_path}}/learn/analytics/configuring-apim-analytics)

+ Log in to the Analytics Dashboard by accessing `<Protocol>://<Host>:<Port>/analytics-dashboard` (ex: [https://localhost:9643/analytics-dashboard](https://localhost:9643/analytics-dashboard)). 
+ After login in, you will see the **Business Analytics**, **Application Analytics**, **API Analytics**, **Monitoring** and the **APIM Admin** dashboards listed.
  
       [![Analytics Dashboards]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)

+ Click on the card of any desired dashboard to view that particular dashboard.

**[Business Analytics]({{base_path}}/learn/analytics/viewing-api-statistics/business-analytics-dashboard)** - Provides long-term historical trends about API Latency, Traffic Volume, Errors, and other statistics like most used APIs, API Subscribing frequency, and Developer Sign-Ups over time that shows different aspects of the API adoption. This is targeted for Program Managers who need to see a holistic view of the APIs, Developers, and Application and shows data about all APIs without any restriction. The internal/analytics role is needed to view this Dashboard.

**[Application Analytics]({{base_path}}/learn/analytics/viewing-api-statistics/application-analytics-dashboard)** - Provided for Application Developers to view the statistics related to their Applications. A user needs to have the internal/subscriber role to view this Dashboard. Please note that what’s shown in the Dashboard are statistics for Apps created by the viewer assuming a Developer role. This includes registered application users, top application users, API usage of an application, etc.

**[API Analytics]({{base_path}}/learn/analytics/viewing-api-statistics/api-analytics-dashboard)** - Provided for the API creators to view the statistics related to their APIs. This provides the ability to compare and contrast the usage of different APIs created by the logged-in user. Further provides the performance and fault statistics of individual APIs. When an API is restricted to a Publisher it wouldn’t appear under this Dashboard. The internal/publisher role is needed to view this Dashboard.

**[Monitoring]({{base_path}}/learn/analytics/viewing-api-statistics/monitoring-dashboard)** - Provides a short-term historical view about Latency, Traffic Volume, and Errors of APIs with drill-downs to narrow down errors and isolate the cause of the issues. This dashboard is targeted for DevOps and SysAdmins who overlook the health and availability aspects of the APIs. Currently, the internal/analytics role is needed to view this Dashboard. But a different role can be assigned by editing role mappings as described in [Managing Analytics Dashboard Permissions]({{base_path}}/learn/analytics/managing-dashboard-permissions)

**[Reports]({{base_path}}/learn/analytics/monthly-api-usage-report)** - This can be used to accomplish the API monetization use cases. Currently, this is restricted to users with admin role only. Users can download a PDF report of the API usage statistics for the selected month. Later this report can be used for billing purposes. You can customize the format and structure of this Dashboard as described in [Monthly API Usage Report]({{base_path}}/learn/analytics/monthly-api-usage-report/#customizing-the-report)

!!! note
    Apart from these default Dashboards, users can create custom Dashboards according to their specific requirements as described in [Customizing Analytics Dashboards]({{base_path}}/learn/analytics/customizing-analytics-dashboards).
