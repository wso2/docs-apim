# Purging Analytics Data

Data purging is an option to remove historical data in WSO2 API Manager Analytics. This is important because it is not possible to delete tables or table data in WSO2 API Manager Analytics. By purging data, you can achieve high performance in data analysis without removing analyzed summary data.

!!! warning
    Make sure you do not purge data in tables other than those mentioned tables related to alerts, because data purging deletes your summarized historical data.


Purging alert related tables

Data Purging is enabled by default for all the aggregation tables. However, you can purge data in certain alert tables, namely `APIMIpAccessSummary` and `APIMIpAccessAlertCount` tables, which have the potential to grow quickly like aggregation tables. Follow the instructions below to purge the data in the latter mentioned alert tables.

1. Configure WSO2 API Manager (WSO2 API-M) with WSO2 API-M Analytics, and start WSO2 API-M Analytics, WSO2 API Manager, and the WSO2 API-M Analytics Dashboard node in the latter mentioned order.
    For more information, see [Configuring APIM Analytics]({{base_path}}/observe/api-manager-analytics/configuring-apim-analytics).

2.  Access the Business Rules via the WSO2 API-M Analytics dashboard. `https://<HOSTNAME>:<DASHBOARD_PORT>/business-rules`

    For example: [https://localhost:9643/business-rules](https://localhost:9643/business-rules)

3.  Click the **edit** link that corresponds to the APIM DATA PURGING business rule.

    ![]({{base_path}}/assets/img/learn/business-rules-manager.png)

4.  Click **Save and Deploy** to enable data purging in the `APIMIpAccessSummary` and `APIMIpAccessAlertCount` tables. When the above business rule is enabled, it will purge data from `APIMIpAccessSummary` and `APIMIpAccessAlertCount` tables every time the trigger is triggered. The default time interval for the trigger is 1 years.

    ![]({{base_path}}/assets/img/learn/apim-data-purging-businees-rules-template.png)

!!! info
    If you need to purge the data immediately or cannot wait for the next trigger, then you need to reduce the default time interval to trigger data purging by changing the **Time Interval For Trigger** value to a smaller value (e.g., one minute). You can set the time interval for trigger in seconds, minutes, hours, days, months, and years.
