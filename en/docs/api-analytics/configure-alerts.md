# Configuring Alerts for API Analytics

Choreo Insights allows you to configure alerts. These alerts allow you to proactively monitor your API ecosystem and take corrective measures for any abnormalities you find. 

You can configure alerts for each environment within your organization separately. Alerts are configured per API and you can also modify/remove already-added alert configurations. Optionally, you can specify a list of emails for each alert configuration. 

Alerts are subject to a suppression policy to ensure you are not overwhelmed with duplicate alert notifications. For each alert rule that you configure, there is a 10-minute suppression window applied by default. The suppression interval is currently not configurable. In addition, note that the suppression policy is applicable per alert rule.

!!! Info

	- Maxium number of alerts which can be configured is 20 for each organization, env, tenant combination.
	- Adding an email to an alert configuration is optional. The maximum number of emails per alert configuration is limited to 5.

Please refer [Configure Alerts](https://wso2.com/choreo/docs/insights/configure-alerts/) for more information.
