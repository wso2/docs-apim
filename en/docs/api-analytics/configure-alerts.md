# Working with Alerts

The Analytics Portal allows you to configure alerts. These alerts allow you to proactively monitor your API ecosystem and take corrective measures for any abnormalities you find.

You can configure alerts for each environment within your organization separately. Alerts are configured per API and you can also modify/remove already-added alert configurations.

Alerts are subject to a suppression policy to ensure you are not overwhelmed with duplicate alert notifications. For each alert rule that you configure, there is a 10-minute suppression window applied by default. The suppression interval is currently not configurable. In addition, note that the suppression policy is applicable per alert rule.

The following topics explain how to use the different alert types.
    
## Alert Types

The following are the alert types that you can configure via the Analytics Portal.

### Latency Alerts 

Configure Latency alerts to identify if the response latency of APIs is greater than a predefined threshold. This is useful when you have APIs that should honor SLAs and when you want to know about slow APIs proactively.

The following topics explain how to create, modify, and remove latency alerts.
  
#### Create a Latency Alert

Follow the instructions below to configure a Latency Alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and modify/remove controls.

      [![latency alert config]({{base_path}}/assets/img/analytics/alerts/alert-config-full.png)]({{base_path}}/assets/img/analytics/alerts/alert-config-full.png)

2.	Verify that you are in the correct [organization]({{base_path}}/api-analytics/role-based-access-control) and select
		 the desired [environment]({{base_path}}/api-analytics/viewing/analytics-pages-introduction). 

3.	Select the API for which you want to create the alert by typing the API name in the **API Name** field. 

	!!! Info
	
	     -	As you type, the APIs that match the text that you enter are listed. You can select the desired API from there. 
	     -  Note that only the APIs you have invoked at least once are populated here. For other APIs, you need to give the API name in the desired format as instructed in the UI.
	
	<a href="{{base_path}}/assets/img/analytics/alerts/api-name-dropdown.png"><img src="{{base_path}}/assets/img/analytics/alerts/api-name-dropdown.png" alt="API name dropdown" width="50%"></a>

4.	Go to the next column and select the desired metric against which you want to evaluate the alert rule. 

	!!! Info
	     The dropdown shows all available options. If there are multiple options, you can select the desired metric. If there is only one
		 option to select, the dropdown is disabled.
		
	[![latency metric type]({{base_path}}/assets/img/analytics/alerts/latency-metric-type.png)]({{base_path}}/assets/img/analytics/alerts/latency-metric-type.png)

5.	Go to the next column and specify the threshold in milliseconds. 

	!!! Info
	    When the 95th percentile of the selected metric exceeds the threshold provided here, alerts are triggered.
		
	 [![latency threshold]({{base_path}}/assets/img/analytics/alerts/latency-threshold.png)]({{base_path}}/assets/img/analytics/alerts/latency-threshold.png)

6.	Click **ADD** after all the required alert configurations are specified. 

When added successfully, the alert is shown in the lower table.

[![latency success]({{base_path}}/assets/img/analytics/alerts/latency-success.png)]({{base_path}}/assets/img/analytics/alerts/latency-success.png)
  
#### Modify a Latency Alert

Follow the instructions below to modify an existing Latency Alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The latter table shows the already configured alerts. 

2.	Select the alert you want to modify from the table and click the **Edit** option under **Action**. 

	[![latency config modify]({{base_path}}/assets/img/analytics/alerts/latency-config-modify.png)]({{base_path}}/assets/img/analytics/alerts/latency-config-modify.png)

3.	Change the parameters as you desire and click **Submit**. 
4.	If you want to discard the changes, click the stop/remove option.

#### Remove a Latency Alert

Follow the instructions below to remove an existing Latency Alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The latter table shows the already configured alerts. 

	[![latency alert config]({{base_path}}/assets/img/analytics/alerts/alert-config-full.png)]({{base_path}}/assets/img/analytics/alerts/alert-config-full.png)

2.	Select the alert that you want to remove from the table and click the **bin** option under **Action**. 
 
### Traffic Alerts 

Configure Traffic alerts to identify if the request count of APIs is greater than a predefined threshold. This is useful when you have APIs that are using backends with traffic limits or monetized backends that require your system to proactively scale depending on the incoming traffic. 

The following topics explain how to create, modify, and remove traffic alerts.
   
#### Create a Traffic Alert
 
Follow the instructions below to create a new Traffic Alert:

1.	Click User Profile on the upper-right corner and select Settings.
2.	Go to the **Traffic** tab.  

	This takes you to the **Traffic Alert Configuration** section. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and the modify/remove controls.

	[![traffic alert config]({{base_path}}/assets/img/analytics/alerts/traffic-alert-config-full.png)]({{base_path}}/assets/img/analytics/alerts/traffic-alert-config-full.png)

3.	Verify that you are in the correct [organization]({{base_path}}/api-analytics/role-based-access-control/#viewing-and-modifying-organization-related-settings) and select the desired [environment]({{base_path}}/api-analytics/viewing/analytics-pages-introduction). 

4.	Select the API for which you want to create the alert by typing the API name in the API Name field.

	!!! Info
		- As you type, the APIs that match the text that you enter are listed. You can select the desired API from there.
		- Note that only the APIs you have invoked at least once are populated here. For other APIs, you need to give the API name in the desired format as instructed in the UI.

	<a href="{{base_path}}/assets/img/analytics/alerts/api-name-dropdown.png"><img src="{{base_path}}/assets/img/analytics/alerts/api-name-dropdown.png" alt="API name dropdown" width="50%"></a>

5.	Go to the next column and select the desired metric against which you want to evaluate the alert rule.

	!!! Info
	    The dropdown shows all available options. If there are multiple options, you can select the desired metric. If there is only one option to select, the dropdown is disabled.
	
	 [![traffic metric type]({{base_path}}/assets/img/analytics/alerts/traffic-metric-type.png)]({{base_path}}/assets/img/analytics/alerts/traffic-metric-type.png)

6.	Specify the threshold in requests per minute.

	!!! Info
	     When the per-minute request count for the given API exceeds the given threshold, the alerts are triggered.

	[![traffic threshold]({{base_path}}/assets/img/analytics/alerts/traffic-threshold.png)]({{base_path}}/assets/img/analytics/alerts/traffic-threshold.png)

7.	Click **ADD** after all the required alert configurations are specified.

When added successfully, the alert is shown in the lower table.
		
[![Traffic success]({{base_path}}/assets/img/analytics/alerts/traffic-success.png)]({{base_path}}/assets/img/analytics/alerts/traffic-success.png)
   
#### Modify a Traffic Alert
 
Follow the instructions below to modify an existing Traffic Alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.	
2.	Go to the **Traffic** tab. 
	
	This takes you to the **Traffic Alert Configuration** section. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and the modify/remove controls.

	[![Traffic configuration]({{base_path}}/assets/img/analytics/alerts/traffic-alert-config-full.png)]({{base_path}}/assets/img/analytics/alerts/traffic-alert-config-full.png)

2.	Select the alert you want to modify from the table and click the **Edit** option under **Action**. 
		 
	[![Traffic config editable]({{base_path}}/assets/img/analytics/alerts/traffic-config-editable.png)]({{base_path}}/assets/img/analytics/alerts/traffic-config-editable.png)

3.	Change the parameters as you desire and click **Submit**. 

5.	If you want to discard the changes, click the stop/remove option.
 
#### Remove a Traffic Alert
 
Follow the instructions below to remove an existing Traffic Alert:
	
1.	Click **User Profile** on the upper-right corner and select **Settings**.	

2.	Go to the **Traffic** tab. 
		
	This takes you to the **Traffic Alert Configuration** section. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and the modify/remove controls.
	
	[![Traffic configuration]({{base_path}}/assets/img/analytics/alerts/traffic-alert-config-full.png)]({{base_path}}/assets/img/analytics/alerts/traffic-alert-config-full.png)

3.	Select the alert that you want to remove from the table and click the bin option under Action.

Your alert configuration is now removed.
