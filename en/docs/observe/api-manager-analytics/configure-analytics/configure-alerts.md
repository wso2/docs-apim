# Working with Alerts
![alert config page]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)

One of the most useful features in APIM cloud analytics is Alerting. You can configure several types of alerts and receive alerts either within the portal or as emails. These alerts allow you to proactively monitor your API ecosystem and take corrective measures for any abnormalities you find.

You can configure alerts for each environment within your organization separately. Alerts are configured per API and you can also modify/remove already-added alert configurations.

Alerts are subjected to a suppression policy to ensure you are not overwhelmed with duplicate alert notifications. For each alert rule that you configure, there is a 10-minute suppression window applied by default. The suppression interval is currently not configurable. Also, note that suppression works per the alert rule.

As the document progresses we will talk about different alert types and how to configure them.
    
## Alert Types
### Latency Alert 
Configure Latency alerts to identify if the response latency of APIs is greater than a predefined threshold. This is useful when you have APIs that should honor SLAs and when you want to know about slow APIs proactively.

The following topics explain how to create, modify, and remove latency alerts.
  
#### Create Latency Alert
To configure a latency alerts:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The first part of the UI shows the alert-creation controls and the latter half shows the existing alerts and modify/remove controls.

		 ![latency alert config]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)

2.	Verify that you are in the correct 
		[organization]({{base_path}}/observe/api-manager-analytics/configure-analytics/working-with-organizations) and select
		 the desired [environment]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-introduction). 

3.	Select the API for which you want to create the alert by typing the API name in the **API Name** field. 

	!!! Info
	     -	As you type, the APIs that match the text you enter are listed. You can select the desired API from there. 
	     - Note that only the APIs you have invoked at least once are populated here. For other APIs, you need to give the API name in the desired format as instructed in the UI.
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

When added successfully the alert is shown in the lower table.
![latency success]({{base_path}}/assets/img/observe/alerts/latency-success.png)
- This will take you to **Latency Alert Configuration** section by default.

  ![latency alert config]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)
- First part of the UI has the alert creation controls and later half will showcase existing alerts and modify/remove
 controls.
- To configure an alert first make sure you are in the correct 
[organization]({{base_path}}/observe/api-manager-analytics/configure-analytics/working-with-organizations) and selected
 the desired [environment]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-introduction). 
- In the API name text box start typing the API you want to create alerts. Dropdown will appear with APIs which match
 the text you have entered. Select the desired API from there. Please note that you have to invoke the API at least
  once for the API name to be populated here. Else you will have to provide the name in the desired format as
   instructed in the UI.
   
   ![api name dropdown]({{base_path}}/assets/img/observe/alerts/api-name-dropdown.png)
- In the next column you can select the desired metric against which you evaluate the alert rule. Dropdown will show
 all available options. If there are multiple options then you can select the desired metric. If there is only one
  selection dropdown will be disabled.
  
  ![latency metric type]({{base_path}}/assets/img/observe/alerts/latency-metric-type.png)
- In the next column you can specify the threshold in milliseconds. When the 95th percentile of the selected metric
 exceed the threshold provided here alerts will be triggered.
 
  ![latency threshold]({{base_path}}/assets/img/observe/alerts/latency-threshold.png)
- Once all required information is added you can add the alert configuration using **Add** button. 
- When added successfully it will be shown in the lower table.
  
  ![latency success]({{base_path}}/assets/img/observe/alerts/latency-success.png)
  
#### Modify Latency Alerts
- Click on 'User Profile' icon on the top right-hand corner and select **Settings**.
- This will take you to **Latency Alert Configuration** section by default.
  
  ![latency alert config]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)
- Later table shows the already configured alerts. From the table select the alert you want to modify and click the edit
 icon under **Action** column. It will make that row editable.
 
  ![latency config modify]({{base_path}}/assets/img/observe/alerts/latency-config-modify.png)
- Change the parameters as you desire and click submit icon. If you want to discard the changes click on the stop
/remove icon.

#### Remove Latency Alerts
To remove an existing latency alert:

1.	Click **User Profile** on the upper-right corner and select **Settings**.

	This takes you to the **Latency Alert Configuration** section by default. The latter table shows the already configured alerts. 

	![latency alert config]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)

2.	Select the alert you want to remove from the table and click the **bin** option under **Action**. 

Your alert configuration is now removed.
- This will take you to **Latency Alert Configuration** section by default.
  
  ![latency alert config]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)
- Later table shows the already configured alerts. From the table select the alert you want to remove and click the
 bin icon under **Action** column. Your alert configuration will be removed.
 
 ### Traffic Alert 
 Traffic alerts allows users to configure alerts if request count of their APIs are greater than a predefined
  threshold. This is useful when you have APIs which are using traffic limited backends or monetized backends
   where you need to proactively scale depending on your incoming traffic. Following sections will discuss how to
    create, modify and remove traffic alerts.
   
 #### Create Traffic Alert
 - Click on 'User Profile' icon on the top right-hand corner and select **Settings**.
 - Once settings page is loaded, click on the **Traffic** tab. This will take you to **Traffic Alert Configuration**
  section.
 
   ![traffic alert config]({{base_path}}/assets/img/observe/alerts/traffic-alert-config-full.png)
 - First part of the UI has the alert creation controls and later half will showcase existing alerts and modify/remove
  controls.
 - To configure an alert first make sure you are in the correct 
 [organization]({{base_path}}/observe/api-manager-analytics/configure-analytics/working-with-organizations) and selected
  the desired [environment]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-introduction). 
 - In the API name text box start typing the API you want to create alerts. Dropdown will appear with APIs which match
  the text you have entered. Select the desired API from there. Please note that you have to invoke the API at least
   once for the API name to be populated here. Else you will have to provide the name in the desired format as
    instructed in the UI.
    
    ![api name dropdown]({{base_path}}/assets/img/observe/alerts/api-name-dropdown.png)
 - In the next column you can select the desired metric against which you evaluate the alert rule. Dropdown will show
  all available options. If there are multiple options then you can select the desired metric. If there is only one
   selection dropdown will be disabled.
   
   ![traffic metric type]({{base_path}}/assets/img/observe/alerts/traffic-metric-type.png)
 - In the next column you can specify the threshold in requests per minute. When per minute request count for the
  given API exceeds the threshold provided here alerts will be triggered.
  
   ![traffic threshold]({{base_path}}/assets/img/observe/alerts/traffic-threshold.png)
 - Once all required information is added you can add the alert configuration using **Add** button. 
 - When added successfully it will be shown in the lower table.
   
   ![traffic success]({{base_path}}/assets/img/observe/alerts/traffic-success.png)
   
 #### Modify Traffic Alerts
 - Click on 'User Profile' icon on the top right-hand corner and select **Settings**.
 - Once settings page is loaded, click on the **Traffic** tab. This will take you to **Traffic Alert Configuration**
  section.
 
   ![traffic config pic]({{base_path}}/assets/img/observe/alerts/traffic-alert-config-full.png)
 - Later table shows the already configured alerts. From the table select the alert you want to modify and click the edit
  icon under **Action** column. It will make that row editable.
  
   ![traffic config editable]({{base_path}}/assets/img/observe/alerts/traffic-config-editable.png)
 - Change the parameters as you desire and click submit icon. If you want to discard the changes click on the stop
 /remove icon.
 
 #### Remove Traffic Alerts
 - Click on 'User Profile' icon on the top right-hand corner and select **Settings**.
 
 - Once settings page is loaded, click on the **Traffic** tab. This will take you to **Traffic Alert Configuration**
  section.
 
   ![traffic config pic]({{base_path}}/assets/img/observe/alerts/traffic-alert-config-full.png)
 - Later table shows the already configured alerts. From the table select the alert you want to remove and click the
  bin icon under **Action** column. Your alert configuration will be removed.
