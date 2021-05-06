# Analytics Pages Introduction
The new cloud analytics portal consists of several pages, which are divided based on different functional aspects (e.g., traffic, latency).
You can use these pages to get the complete business analytics on your API management system. 

See the topics given below to get an overview of the main capabilities of **Analytics Pages**.
   
Let's start with the common controls that govern Analytics pages. See the related links in each topic given below for more details.
 
## Common Controls
These are the common controls that enable you to govern the data shown in Analytics pages. Each page uses these common controls and page-specific controls to visualize the information requested by the user. 

Explained below are these common controls and their usage.
### Time Picker
![APIM Analytics TIme Picker]({{base_path}}/assets/img/observe/time-picker.png)

Time picker is located in the top left hand corner of the analytics dashboard. Once you choose a given time frame
, all dashboards will use that time range when you move between different pages. However, if you reload the page then
 the time picker will revert to the default setting, which is 'Past 24 Hours'.
 
 The time picker consists of several pre-defined time intervals. The following image illustrates those predefined time intervals.
 
 ![APIM Analytics TIme Picker List]({{base_path}}/assets/img/observe/time-picker-list.png)
 
 You can select any of these pre-defined intervals to view stats relevant to that time frame. However, granularity of
  each time range is pre-defined too and you cannot change the granularity of a pre-defined range. 
  
  If you need to select a custom time range with a custom granularity, you have to use the custom selector that
   is shown below.
   
![APIM Analytics TIme Picker List]({{base_path}}/assets/img/observe/time-picker-custom.png)

In the custom picker first you have to select the granularity that you need to view the data. Then from the calendar
 widget you can select the date range and if applicable the clock widget will be also enabled to select the time. However,
  there are certain restrictions applied on the range that you can view based on the selected granularity
  . Restrictions are based on the length of the selected range and time from current date to starting date of
   selected range. Time picker will automatically apply these restrictions. If you need to look at the restrictions
    in details, please visit deep dive section of our docs.
    
### Environment Picker

![APIM Analytics Environment Picker List]({{base_path}}/assets/img/observe/environment-picker.png)

This widget allows you to select the environment you need to view statistics for. When you are 
[Registering for Analytics]({{base_path}}/observe/api-manager-analytics/configure-analytics/register-for-analytics) 
at the On-Prem Key generation step, you are required to provide a 'Key Name'. This serves as your environment name
. Suppose you have two different environments for two different business units of your organization. In such a case
 you can generate two On-Premise Keys and add them to respective Gateways of each deployment. Once that is done
  'Environment Picker' will show two options and based on the selection dashboards will only show statistics relevant
   to the selected environment.
   
### Tenant Picker

![APIM Analytics Tenant Picker List]({{base_path}}/assets/img/observe/tenant-picker.png)

Tenant Picker will be enabled if your selected environment uses multi-tenancy. If multi-tenancy is enabled then using
 this picker you have to select the tenant that you need to observe analytics data. When tenancy is enabled
 , data will only be shown per tenant basis. If you want to view cumulative analytics data for all tenants,
  you have to select **carbon.super** as the tenant, which is the default super tenant name. All tenant data will be
   aggregated and shown under super tenant.
   
## Pages

### Overview Page
This is the welcome page of the analytics portal. This page will mainly display a quick overview of the whole
 deployment. This page is targeted towards providing business users with a quick overview. For more information
  please refer [this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-overview) 
  documentation.
  
### Traffic Page
This page displays all traffic related information available in the system such as API Usage, Application Usage
, Resource Usage, etc. For more information please refer 
[this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-traffic) documentation.

### Errors Page
The error page displays analytics stats related to erroneous API calls that happened within the system. It will include error
 categorization based on the error type and then further drills down into sub types. This page can be used as the
  starting point for debugging API errors. For more information please refer 
  [this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-erros) documentation.
  
### Latency Page 
This page illustrates API latency related information such as slowest APIs, latency by category, etc. This page is a
 good starting point if you are investigating about slowness of the system of any particular API. For more
  information please refer 
  [this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-latency) documentation.
  
### Cache Page
This page visualizes details on API caching functionality including cache hit rate, hit percentage, etc. You can use
 this page to decide the effectiveness of API caching and also as additional information when investigating API
  slowness. For more information please refer 
  [this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-cache) documentation.
  
### Devices Page

This page displays information about OS platforms and HTTP Agents end users are using to invoke the APIs. You can use
 this page to get an idea of the distribution of your user-base and improve your APIs to match the audience. For
  more information please refer 
  [this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-devices) documentation.
  
### Alerts Page

This page shows the information related to business alerts issued by the system for your currently selected
environment and organization. You can use this page as a health monitoring dashboard and make it visible to
the whole team. You can use this page to drill down on each alert and discover possible anomalies or errors in your published APIs.

For more information, see [Alerts Page]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-alerts)
  
### Reports Page

This page allows you to download monthly usage reports for your system. There are pre-configured reports to get
 system wide stats and a custom report generator to generate reports based on a subset of APIs/applications. For more
  information please refer 
  [this]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-report) documentation.
