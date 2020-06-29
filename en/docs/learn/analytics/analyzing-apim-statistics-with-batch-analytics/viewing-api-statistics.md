# Viewing API Statistics

API statistics related to both the API Publisher and the Developer Portal can be viewed using the **dashboard** runtime of the API-M Analytics server.

For instructions on how to set up Analytics, see [Configuring APIM Analytics]({{base_path}}/learn/analytics/configuring-apim-analytics). 
Once Analytics is set up, follow the instructions below to view statistics relevant to API Publisher and Developer Portal.

First, [invoke a few APIs]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console) to generate traffic and see the statistics.

!!! note
      The following widgets on the API Manager statistical dashboards, display real runtime statistics even when Analytics is not set up (as described in [Configuring APIM Analytics]({{base_path}}/learn/analytics/configuring-apim-analytics)).
      
      **Publisher Dashboard**
      
      + Overview Page
        + API Faults Summary
        + API Throttled Summary
        + Subscriptions Summary
        + Top Api Creators
        + Top App Creators
        + Top Subscriptions per API Provider
      + API and Application Statistics Page
        + APIs Created Over Time
        + Apps Created Over Time
      + Developer Statistics Page
        + Subscriptions Over Time
        + Developer Signups Over Time
      + Faults Page
        + Top Faulty APIs
        + Top Throttled APIs
      
      **Developer Portal Dashboard**
      
      + Registered Application Users


!!! warning
      Please note that our data summarization logic summarizes the data on a **per day** basis.


The sections below explain how to access the statistical dashboards:

+ Log in to the Analytics Dashboard by accessing `<Protocol>://<Host>:<Port>/analytics-dashboard` (ex: [https://localhost:9643/analytics-dashboard](https://localhost:9643/analytics-dashboard)). 
+ After login in, you will see the **APIM Publisher**, **APIM Developer Portal** and the **APIM Admin** dashboards listed.
  
       [![Analytics Dashboards]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)]({{base_path}}/assets/img/learn/analytics-dashboard-listing.png)

+ Click on the card of any desired dashboard to view that particular dashboard.
+ By using APIM Admin dashboard, administrators can generate a monthly API usage report. For more
 information see [Monthly API Usage Report]({{base_path}}/learn/analytics/monthly-api-usage-report).
+ Admin Portal Statistics can be viewed from the admin app.
    
Please refer below sub sections for more details about each dashboard.
    
-   [**API Publisher statistics**](#api-publisher-statistics)
-   [**Developer Portal statistics**](#developer-portal-statistics)
-   [**Admin Portal Statistics**](#admin-portal-statistics)

## API Publisher statistics

!!! info
      Unlike the previous releases of API-M Analytics dashboards, Publisher statistics dashboard can be viewed by any user having Analytics role, Creator role or Publisher role.
      And these permissions can be changed as per your preferences by going to **Settings** options of the dashboard. More information can be found at [Managing Analytics Dashboard Permissions]({{base_path}}/learn/analytics/managing-dashboard-permissions/) page.
      
 API Publisher dashboard has 8 main pages namely **Overview**, **API and Application Statistics**, **Developer Statistics**, **Usage Summary**, **Devices**, **API Proxy Performance**, **Faults**, and **Geo Map**.
 
### Overview 
#### API Usage Summary
This widget displays the total number of API invocations within the last week by the subscribers of the logged in user's tenant and also displays the increase/decrease of API invocations compared to last week.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-api-usage-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-api-usage-summary.png', '_self');" 
     alt="failover" width="55%" height="55%"/>
</body>
</html>

#### API Faults Summary
This widget displays the total number of fault API invocations within the last week by the subscribers of the logged in user's tenant and also displays the increase/decrease of fault API invocations compared to last week.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-api-faults-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-api-faults-summary.png', '_self');" 
     alt="failover" width="55%" height="55%"/>
</body>
</html>

#### API Throttled Summary
This widget displays the total number of throttled API invocations by the subscribers of the logged in user's tenant and also displays the increase/decrease of throttled API invocations compared to last week.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-api-throttled-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-api-throttled-summary.png', '_self');" 
     alt="failover" width="55%" height="55%"/>
</body>
</html>
 
#### Subscriptions Summary
This widget displays the total number of API subscriptions crated by the subscribers of the logged in user's tenant and also displays the increase/decrease of number of subscriptions created compared to last week.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-subscription-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-subscription-summary.png', '_self');" 
     alt="failover" width="55%" height="55%"/>
</body>
</html>

#### API Availability

This widget displays a percentage of API availability for the logged in users's tenant.

!!! Note
      In order to view statistics of **API Availability** widget, it is required to enable alerts as described in [Configuring Alerts]({{base_path}}/learn/analytics/managing-alerts-with-real-time-analytics/configuring-alerts).
      
  The availability of APIs statistics is directly related to the [Availability of APIs (health monitoring)]({{base_path}}/learn/analytics/managing-alerts-with-real-time-analytics/alert-types/#availability-of-apis-api-health-monitoring) alert type. 
  
<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-overall-api-stats.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-overall-api-stats.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>
  
#### Top Rated APIs

This widget displays the total number of stars received (ratings) for each API of the logged in users's tenant. Along 
with the total number of stars received for each API, Top Rated APIs section of the widget displays the API creator of each API as well. 
By clicking on the search icon
<html>
<body>
<img src="{{base_path}}/assets/img/learn/analytics-search.png" width="25"/>
</body>
</html>
, you can search by **API name** and **Ratings**.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-overall-api-stats-ratings.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-overall-api-stats-ratings.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

#### Top API Creators

As the name depicts this widget displays the top API creators and the percerntage of APIs that each of them have created.
You can choose the limit of API creators that you want to see by giving the number under the limit field.

You also get a list view of API creators along with the number of APIs created by each API creator. 
This list can be searched either via API name or API count.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-top-api-creators.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-top-api-creators.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

#### Top App Creators

As same as Top API Creators widget, Top App Creators widget displays a percentage of apps created by each app creator and also a list of app creators along with the number of apps they created with the filtering capabilities.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-top-app-creators.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-top-app-creators.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>
  
#### Top Subscriptions per API Provider

This widget displays the percentage of subscription count against each API provider. It also has a list view with the subscription count with the filtering capability based on the provider name and count.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-overview-top-subscription-per-provider.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-overview-top-subscription-per-provider.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

###API and Application Statistics 
#### APIs Created Over Time

This widget displays the number of APIs published over a given time period.
You can filter based on the API created by you or APIs created by all.
It also has a list view along with the filtering capability based on API Name.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-api-and-app-api-created-over-time.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-api-and-app-api-created-over-time.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### Apps Created Over Time

This widget displays number of applications created over a given period of time. Statistics can be filtered based on API creator, app creator and subscribed API.
This also has a list view with app name and created time which can be filtered based on the app name.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-api-and-app-app-created-over-time.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-api-and-app-app-created-over-time.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

### Developer Statistics

#### Subscriptions Over Time

This widget displays the number of subscriptions created for an API over a given period.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-dev-stats-subscription-over-time.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-dev-stats-subscription-over-time.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### Developer Signups Over Time

This widget displays the number of developers who signed up to the developer portal over time. 

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-dev-stats-developer-signups-over-time.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-dev-stats-developer-signups-over-time.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

### Usage Summary

#### Overall API Usage

This widget displays the number of subscriptions of each API with a graphical view of number of API invocations. 
It also has a list view of total number of API invocations across all versions.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-usage-summary-overall-api-usage.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-usage-summary-overall-api-usage.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### API Version Usage Summary

This widget displays the API invocation counts for each of the APIs grouped by each API version.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-usage-summary-api-version-usage-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-usage-summary-api-version-usage-summary.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### Top API Users

This widget lists the users who has done the most number of API invocations. 
It also has several filters to search based on the creator of the API (either All or Me), API Name and API Version.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-usage-summary-top-api-users.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-usage-summary-top-api-users.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### API Resource Usage Summary

This widget displays the number of API invocations made by resources for an API in a list view.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-usage-summary-api-resource-usage-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-usage-summary-api-resource-usage-summary.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### API Backend Usage Summary

This widget displays the number of total API invocations aggregated based on API Name, API Version, API Creator, API Context  and API Backend endpoint.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-usage-summary-api-backend-usage-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-usage-summary-api-backend-usage-summary.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### API usage by application

This widget displays the number of total invocations made for each API by each application.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-api-usage-by-application.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-api-usage-by-application.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### API Last Access Summary

This widget is a list view of the last access times of an API, according to the version and the accessed subscriber.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-usage-summary-api-last-access-summary.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-usage-summary-api-last-access-summary.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

### Devices

#### Top User Agents

This widget displays the percentage of API invocations using each browser. And the results can be filtered based on API Creator (either All or Me), API Name and API version.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-devices-top-user-agents.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-devices-top-user-agents.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### Top Platforms

This widget displays the percentage of API invocations done using different operating systems.
Results of this widget also can be filtered based on API Creator (either All or Me), API Name and API version.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-devices-top-platforms.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-devices-top-platforms.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

!!! note
        The above User-Agent and Platform information are extracted from the User-Agent header of the API requests. To customize the information to be extracted follow [Configuring User-Agent Parser]({{base_path}}/learn/analytics/configuring-apim-analytics/#step-7-configure-user-agent-parser).

### API Proxy Performance

#### API Latency Time

This widget displays the execution time of the APIs represented as a combination of throttling, In mediation, Out mediation, backend response time, and authentication time.
It also displays a comparison view of the latencies.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-api-proxy-performance-api-latency-time.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-api-proxy-performance-api-latency-time.png', '_self');" 
     alt="failover" width="80%" height="80%"/>
</body>
</html>

### Faults

#### Top Faulty APIs

A successful invocation is when an API receives the expected response. 
In Analytics, if a runtime exception that is related to the backend communication occurs, it is considered as a faulty invocation. 
However, authentication related issues are not considered as faulty invocations. 
A percentage of faulty invocations for each API is displayed in this widget and it also has a list view which displays the total number of faulty invocations for each API.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-fault-top-faulty-apis.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-fault-top-faulty-apis.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

#### Top Throttled Out APIs

This widget displays a percentage of throttled out request counts for each API as well as a list view with throttled out request count.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-fault-top-throttled-out-apis.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-fault-top-throttled-out-apis.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

### Geo Map

#### Geo Location Based Invocations

Geolocation based statistics are used to carryout detailed monitoring of geographic locations. 
You need to pass an x-forwarded-for header with the relevant IP in the API request in order to generate Geolocation based statistics. 
For more information, see [Using Geolocation Based Statistics]({{base_path}}/learn/analytics/analyzing-apim-statistics-with-batch-analytics/using-geo-location-based-statistics/configuring-geolocation-based-statistics/). 

The data script that updates statistics related to geo locations is executed once a day. 
Therefore, at a given time, some statistics generated within the last 24 hours may not be displayed in this widget.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-geo-map-geo-based-invocation.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/publisher-geo-map-geo-based-invocation.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>
 
## Developer Portal Statistics

!!! info
      Similar to the Publisher statistics dashboard, Developer Portal statistics dashboard can be viewed by any user having Analytics role or subscriber role. 
      And these permissions can be changed as per your preferences by going to **Settings** options of the dashboard. More information can be found at [Managing Analytics Dashboard Permissions]({{base_path}}/learn/analytics/managing-dashboard-permissions/) page.


Log into the analytics-dashboard application and access developer portal statistics (ex: [https://localhost:9643/analytics-dashboard/dashboards/apimdevportal](https://localhost:9643/analytics-dashboard/dashboards/apimdevportal)) dashboard from there.

#### Faulty Invocation per Application

In a faulty API invocation, the message is mediated though the fault sequence. 
By default, the API Manager considers an API invocation to be faulty when the backend service is unavailable or if a runtime exception occurs that is related to the backend communication.
The total number of invocations made by each application that are faulty are represented in these statistics.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/devportal-faulty-invocations-per-application.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/devportal-faulty-invocations-per-application.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

#### Top Application Users

This widget displays the users who made the largest number of API calls per application. 
You also can limit the number of users that needs to be listed by changing the limit filter in the UI.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/devportal-top-application-users.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/devportal-top-application-users.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>
     
#### Registered Application Users

The statistics for this widget takes the number of users shared across each application in to consideration. 

To enable application sharing among users within the same organization, see [Sharing Applications]({{base_path}}/learn/consume-api/manage-application/sharing-applications/sharing-applications/).

<html>
<body>
<img src="{{base_path}}/assets/img/learn/devportal-registered-application-users.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/devportal-registered-application-users.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

#### Resource Usage of Application

This widget displays the usage of resources of the APIs by each application.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/devportal-resource-usage-of-application.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/devportal-resource-usage-of-application.png', '_self');" 
     alt="failover" width="70%" height="70%"/>
</body>
</html>

#### API Usage of Application

This widget displays the number of invocations made for each API by each application.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/devportal-api-usage-of-application.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/devportal-api-usage-of-application.png', '_self');" 
     alt="failover" width="60%" height="60%"/>
</body>
</html>

## Admin Portal Statistics

Log in to the Admin Portal (`https://localhost:9443/admin`). 
API Availability is the only statistical view that exists in the Admin Portal. Admin users can view API Availability statistics by navigating to **ANALYTICS &gt; API AVAILABILITY**.

#### Availability of APIs

The status of the APIs (all API versions) represented in a tabular view.

<html>
<body>
<img src="{{base_path}}/assets/img/learn/admin-portal-api-availability.png" 
     onclick="window.open('{{base_path}}/assets/img/learn/admin-portal-api-availability.png', '_self');" 
     alt="failover" width="100%" height="100%"/>
</body>
</html>

<html>
<table>
<thead></thead>
<tbody>
<tr class="odd">
<td>Status</td>
<td><div class="content-wrapper">
<p>This indicates the status of the API. There are two possible values; <strong>Available</strong> and <strong>Limited</strong>.</p>
<p><strong>Available</strong> - This status indicates that the API has traffic with normal successful invocations. By default, if an API receives successful invocations for at least one out of five invocations within 30000 milliseconds, the status of the API becomes <strong>Available</strong>.</p>

<html><div class="admonition info">
<p class="admonition-title">Note</p>
<p>Note that only the APIs that have traffic are represented in this tabular representation.</p>
</div>
</html>

<html><p><strong>Limited</strong> - If an API receives an alert due to one of the reasons indicated in [Availability of APIs (health monitoring)]({{base_path}}/learn/analytics/managing-alerts-with-real-time-analytics/alert-types/#availability-of-apis-api-health-monitoring), the API status changes to <strong>Limited</strong>.</p></html>

<html><div class="admonition info">
<p class="admonition-title">Note</p>
<p>For more information on how to view the generated alerts, see [Viewing Alerts]({{base_path}}/learn/analytics/managing-alerts-with-real-time-analytics/viewing-alerts/)</p>
</div>
</html>

</div></td>
</tr>
</tbody>
</table>
</html>

The availability of APIs statistics is directly related to the [Availability of APIs (health monitoring)]({{base_path}}/learn/analytics/managing-alerts-with-real-time-analytics/alert-types/#availability-of-apis-api-health-monitoring) alert type.

## Date Range Picker

This can be used to configure the **time period** and **granularity mode** of the data which should be visualized in the widgets listed above.

The following diagram shows the configurable options in this widget.  

<html>
<body>
<img src="{{base_path}}/assets/img/learn/publisher-date-time-picker.png" width="500"/>
</body>
</html>

The time period can be defined, either choosing from `Quick Ranges` or defining `Custom Ranges`. For the quick ranges `1 Min`, `15 Min`, `1 Hour`, `1 Day`, `7 Days`, `1 Month`, `3 Months`, `6 Months`, and `1 Year` options are provided.
For `Custom Ranges` users can define the start date as `From` and end date as `To`.

For `Quick Ranges` the **granularity mode** selected as default and for `Custom Ranges`, users can choose from `second`, `minute`, `hour`, `day`, `month` and `year`.

Generally, the widgets will visualize the data retrieved during the initialization. But if the users are required to update the widget with new data since the widget's initial load, they can toggle the `sync button`
(
<html>
<body>
<img src="{{base_path}}/assets/img/learn/analytics-sync-button.png" width="20"/>
</body>
</html> 
) marked at the upper right corner of the diagram.

!!! note
        During the `synced mode` the `To` value of the Date Range Picker will be updated to the current timestamp every 30 seconds and all the widgets will retrieve the data for the updated time period. This mode can be useful to present the dashboard in a non-interactive display.    
