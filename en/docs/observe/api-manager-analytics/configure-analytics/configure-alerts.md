# Working with Alerts

One of the most useful features in APIM cloud analytics is Alerting. You can configure several types of alerts and receive alerts either within the portal or as emails. These alerts allow you to proactively monitor your API ecosystem and take corrective measures for any abnormalities you find.

You can configure alerts for each environment within your organization separately. Alerts are configured per API and you can also modify/remove already-added alert configurations.

Alerts are subject to a suppression policy to ensure you are not overwhelmed with duplicate alert notifications. For each alert rule that you configure, there is a 10-minute suppression window applied by default. The suppression interval is currently not configurable. Also, note that suppression works per the alert rule.

See the topics below for details on how to use the different alert types.
    
## Alert Types

Listed below are the alert types that you can configure.

### Latency Alert 

Configure Latency alerts to identify if the response latency of APIs is greater than a predefined threshold. This is useful when you have APIs that should honor SLAs and when you want to know about slow APIs proactively.

The following topics explain how to create, modify, and remove latency alerts.
  
#### Create Latency Alert

To configure a latency alerts:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and modify/remove controls.

      ![latency alert config]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)

2.	Verify that you are in the correct [organization]({{base_path}}/observe/api-manager-analytics/configure-analytics/working-with-organizations) and select
		 the desired [environment]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-introduction). 

3.	Select the API for which you want to create the alert by typing the API name in the **API Name** field. 

	!!! Info
	
	     -	As you type, the APIs that match the text you enter are listed. You can select the desired API from there. 
	     -  Note that only the APIs you have invoked at least once are populated here. For other APIs, you need to give the API name in the desired format as instructed in the UI.
	
	![api name dropdown]({{base_path}}/assets/img/observe/alerts/api-name-dropdown.png)

4.	Go to the next column and select the desired metric against which you want to evaluate the alert rule. 

	!!! Info
	     The dropdown shows all available options. If there are multiple options, you can select the desired metric. If there is only one
		 option to select, the dropdown is disabled.
		
	![latency metric type]({{base_path}}/assets/img/observe/alerts/latency-metric-type.png)

5.	Go to the next column and specify the threshold in milliseconds. 

	!!! Info
	    When the 95th percentile of the selected metric exceeds the threshold provided here, alerts are triggered.
		
	 ![latency threshold]({{base_path}}/assets/img/observe/alerts/latency-threshold.png)

6.	Click **Add** once all the required alert configurations are specified. 

When added successfully, the alert is shown in the lower table.

![latency success]({{base_path}}/assets/img/observe/alerts/latency-success.png)
  
#### Modify Latency Alerts

To modify an existing alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The latter table shows the already configured alerts. 

2.	Select the alert you want to modify from the table and click the **Edit** option under **Action**. 

	![latency config modify]({{base_path}}/assets/img/observe/alerts/latency-config-modify.png)

3.	Change the parameters as you desire and click **Submit**. 
4.	If you want to discard the changes, click the stop/remove option.

#### Remove Latency Alerts

To remove an existing latency alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The latter table shows the already configured alerts. 

	![latency alert config]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)

2.	Select the alert you want to remove from the table and click the **bin** option under **Action**. 
 
### Traffic Alert 

Configure Traffic alerts to identify if the request count of APIs is greater than a predefined threshold. This is useful when you have APIs that are using backends with traffic limits or monetized backends that require your system to proactively scale depending on the incoming traffic. 

The following topics explain how to create, modify, and remove traffic alerts.
   
#### Create Traffic Alert
 
To create a new Traffic alert:

1.	Click User Profile on the upper-right corner and select Settings.
2.	Go to the **Traffic** tab.  

	This takes you to the **Traffic Alert Configuration** section. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and the modify/remove controls.

	![traffic alert config]({{base_path}}/assets/img/observe/alerts/traffic-alert-config-full.png)

3.	Verify that you are in the correct [organization]({{base_path}}/observe/api-manager-analytics/configure-analytics/working-with-organizations) and select the desired [environment]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-introduction). 

4.	Select the API for which you want to create the alert by typing the API name in the API Name field.

	!!! Info
		- As you type, the APIs that match the text you enter are listed. You can select the desired API from there.
		- Note that only the APIs you have invoked at least once are populated here. For other APIs, you need to give the API name in the desired format as instructed in the UI.

	![api name dropdown]({{base_path}}/assets/img/observe/alerts/api-name-dropdown.png)

5.	Go to the next column and select the desired metric against which you want to evaluate the alert rule.

	!!! Info
	    The dropdown shows all available options. If there are multiple options, you can select the desired metric. If there is only one
option to select, the dropdown is disabled.
	
	![traffic metric type]({{base_path}}/assets/img/observe/alerts/traffic-metric-type.png)

6.	Specify the threshold in requests per minute.

	!!! Info
	     When the per-minute request count for the given API exceeds the given threshold, the alerts are triggered.

	![traffic threshold]({{base_path}}/assets/img/observe/alerts/traffic-threshold.png)

7.	Click Add once all the required alert configurations are specified.

When added successfully, the alert is shown in the lower table.
		
![traffic success]({{base_path}}/assets/img/observe/alerts/traffic-success.png)
   
#### Modify Traffic Alerts
 
To modify an existing alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.	
2.	Go to the **Traffic** tab. 
	
	This takes you to the **Traffic Alert Configuration** section. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and the modify/remove controls.

	![traffic config pic]({{base_path}}/assets/img/observe/alerts/traffic-alert-config-full.png)

2.	Select the alert you want to modify from the table and click the **Edit** option under **Action**. 
		 
	![traffic config editable]({{base_path}}/assets/img/observe/alerts/traffic-config-editable.png)

3.	Change the parameters as you desire and click **Submit**. 

5.	If you want to discard the changes, click the stop/remove option.
 
#### Remove Traffic Alerts
 
To remove an existing Traffic alert:
	
1.	Click **User Profile** on the upper-right corner and select **Settings**.	

2.	Go to the **Traffic** tab. 
		
	This takes you to the **Traffic Alert Configuration** section. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and the modify/remove controls.
	
	![traffic config pic]({{base_path}}/assets/img/observe/alerts/traffic-alert-config-full.png)

3.	Select the alert you want to remove from the table and click the bin option under Action.

Your alert configuration is now removed.
