# Viewing API Statistics

API statistics are provided for both the API Publisher and the Developer Portal. 

From API-M Analytics 3.0.0 release onwards, Publisher and Developer Portal statistics are moved out from the Publisher and Developer portal apps.
And those can be viewed using the **dashboard** runtime of the API-M Analytics server.

For instructions on how to set up Analytics, see [Configuring APIM Analytics](../configuring-apim-analytics.md) . 
Once Analytics is set up, follow the instructions below to view statistics relevant to API Publisher and Developer Portal.

First, [invoke a few APIs](../../../ConsumeAPI/InvokeApis/InvokeApisUsingTools/invoke-an-api-using-the-integrated-api-console/) to generate traffic and see the statistics.

!!! note
      The following widgets on the API Manager statistical dashboards, display real runtime statistics even when Analytics is not set up (as described in [Configuring APIM Analytics](_Configuring_APIM_Analytics_) ).
      
      **Publisher Dashboard**
      
      + Overview Page
        + Total Api Count
        + Total App Count
        + Total Subscriptions
        + Total Signups
        + Top Api Creators
        + Top App Creators
        + Top Subscriptions per API Provider
      + API and Application Statistics Page
        + Apis Created Over Time
        + Apps Created Over Time
      + Developer Statistics Page
        + Subscriptions Over Time
        + Developer Signups Over Time
      + Faults Page
        + Top Faulty Apis
        + Top Throttled Apis
      
      **Developer Portal Dashboard**
      
      + Registered Application Users


!!! warning
      Please note that our data summarization logic summarizes the data on a **per day** basis.


The sections below explain how to access the statistical dashboards:

+ Log in to the Analytics Dashboard by accessing `<Protocol>://<Host>:<Port>/analytics-dashboard` (ex: [https://localhost:9643/analytics-dashboard](https://localhost:9643/analytics-dashboard)). 
+ After login in, you will see the **APIM Publisher** and the **APIM Developer Portal** dashboards listed.
  
       ![](../../../assets/img/Learn/analytics-dashboard-listing.png)

+ Click on the card of any desired dashboard to view that particular dashboard.
+ Admin Portal Statistics can be viewed from the admin app.
    
Please refer below sub sections for more details about each dashboard.
    
-   [**API Publisher statistics**](#api-publisher-statistics)
-   [**API Store statistics**](#api-store-statistics)
-   [**Admin Portal Statistics**](#admin-portal-statistics)

### API Publisher statistics

!!! info
      Unlike the previous releases of API-M Analytics dashboards, Publisher statistics dashboard can be viewed by any user having Analytics role, Creator role or Publisher role.
      And these permissions can be changed as per your preferences by going to **Settings** options of the dashboard. More information can be found at [Managing Analytics Dashboard Permissions]() page.
      
 API Publisher dashboard has 8 main pages namely **Overview**, **API and Application Statistics**, **Developer Statistics**, **Usage Summary**, **Devices**, **API Proxy Performance**, **Faults**, and **Geo Map**.
 
#### Overview 
##### Total API Count
This widget displays the total number of apis created and the number of apis created within the last week by the publishers of logged in user's tenant.

  ![](../../../assets/img/Learn/publisher-overview-total-api-count.png)

##### Total App Count
This widget displays the total number of applications created and the number of applications created within the last week by the subscribers of the logged in user's tenant.

 ![](../../../assets/img/Learn/publisher-overview-total-app-count.png)

##### Total Subscriptions
This widget displays the total api subscriptions by the subscribers of the logged in user's tenant and its last weeks statistics of the same factor.

 ![](../../../assets/img/Learn/publisher-overview-total-subscriptions.png)
 
##### Total Signups
This widget displays count of the unique subscribers logged in to the developer portal app and its last week statistics of the same factor.

 ![](../../../assets/img/Learn/publisher-overview-total-signups.png)

##### Overal API Stats

This widget has two sections where one section displays a percentage of api availability and the other section displays the total number of stars received (ratings) by each api for that particualr tenant.

!!! Note
      In order to view statistics of **Api Availability** widget, it is required to enable alerts as described in [Configuring Alerts](../../ManagingAlertsWithRealTimeAnalytics/configuring-alerts).
      
  The availability of APIs statistics is directly related to the [Availability of APIs (health monitoring)](../../ManagingAlertsWithRealTimeAnalytics/alert-types/#availability-of-apis-api-health-monitoring) alert type. 
  
  ![](../../../assets/img/Learn/publisher-overview-overall-api-stats.png)
  
