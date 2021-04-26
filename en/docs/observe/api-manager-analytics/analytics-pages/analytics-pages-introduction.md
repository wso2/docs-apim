# Analytics Pages Introduction
New cloud analytics portal consists of several pages where pages are divided based on different stats(Ex: traffic
, latency). There are set of common controls which will govern the data shown in pages. Each page will refer these
 common controls and page specific controls to visualize the information requested by the user.
 
## Common Controls
### Time Picker
![APIM Analytics TIme Picker]({{base_path}}/assets/img/observe/time-picker.png)

Time picker is located in the top left hand corner of the analytics dashboard. Once you choose a given time frame
, all dashboards will use that time range when you move between different pages. However if you reload the page then
 time picker will be reverted to the default setting which is 'Past 24 Hours'.
 
 Time picker consist of several pre-defined time intervals. Below image illustrates those predefined time intervals.
 
 ![APIM Analytics TIme Picker List]({{base_path}}/assets/img/observe/time-picker-list.png)
 
 You can select any of these pre-defined intervals to view stats relevant to that time frame. However granularity of
  each time range is pre-defined too and you can't change the granularity of a pre-defined range. 
  
  If you need to select a custom time range with a custom granuarity, Then you have to use the custom selector which
   is show below.
   
![APIM Analytics TIme Picker List]({{base_path}}/assets/img/observe/time-picker-custom.png)

In the custom picker first you have to select the granularity that you need to view the data. Then from the calendar
 widget you can select the date range and if applicable clock widget will be also enabled to select the time. However,
  there are certain restrictions applied on the range that you can view based on the selected granularity
  . Restrictions are based on the length of the selected range and time from current date to starting date of
   selected range. Time picker will automatically apply these restrictions. If you need to look at the restrictions
    in details, please visit deep dive section of our docs.
    
### Environment Picker

![APIM Analytics Environment Picker List]({{base_path}}/assets/img/observe/environment-picker.png)

This widget allows you to select the environment you need to view statistics for. When you are 
[Registering for Analytics]({{base_path}}/observe/api-manager-analytics/configure-analytics/register-for-analytics) 
at the On-Prem Key generation step, you are required to provide an 'Key Name'. This serves as your environment name
. Suppose you have two different environments for two different business units of your organization. In such a case
 you can generate two On-Premise Keys and add them to respective Gateways of each deployment. Once that is done
  'Environment Picker' will show two options and based on the selection dashboards will only show statistics relevant
   to selected environment.
   
### Tenant Picker

![APIM Analytics Tenant Picker List]({{base_path}}/assets/img/observe/tenant-picker.png)

Tenant Picker will be enabled if your selected environment uses multi-tenancy. If multi-tenancy is enabled then using
 this picker you have to select the tenant that you need to observe abalytics data. When tenancy is enabled
 , data will only be show in per tenant basis. If you want to view cumulative analytics data for all tenants, Then
  you have to select **carbon.super** as the tenant which is the default super tenant name. All tenant data will be
   aggregated and show under super tenant.