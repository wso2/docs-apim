# Working with Alerts
![alert config page]({{base_path}}/assets/img/observe/alerts/alert-config-full.png)

One of the most useful features in APIM cloud analytics is the **Alerting support**. New analytics solution allows
 your configure several types of alert and then receive alerts based on the configurations, either within
  the portal or as emails. These alerts allow you to proactively monitor your API ecosystem and take corrective
   meassures for any abnormalities you find. 
   
Users can configure alerts for each environment they have separately withing their organizations. Alert
 configurations will always be per API basis. Users can also modify/remove already added alerting configurations. 
 
Alert issuance is subjected to a suppression policy so that users will not be overwhelmed with duplicate alert
 notifications. For each alert rule that you configure, there will be a 10 minute suppression window applied by
  default. Suppression interval is currently not configurable. Also, please note that suppression will work on a per
   alert rule basis. As the document progresses we will talk about different alert types and how to configure them.
    
## Alert Types
### Latency Alert 
Latency alerts allows users to configure alerts if response latency of their APIs are greater than a predefined
 threshold. This is useful when you have APIs which should honor SLAs and to get to know about slow APIs
  proactively. Following sections will discuss how to create, modify and remove latency alerts.
  
#### Create Latency Alert
- Click on 'User Profile' icon on the top right-hand corner and select **Settings**.
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
- Click on 'User Profile' icon on the top right-hand corner and select **Settings**.
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