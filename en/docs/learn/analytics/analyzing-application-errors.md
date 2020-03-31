# Analyzing Application Errors

To analyze the Application Errors Statistics,

1.  Login to admin portal (https://&lt;ip\_address&gt;:&lt;port&gt;/admin).
2.  In the left navigation, Click **APPLICATION ERRORS** under **LOG ANALYZER.**

-   [Introduction](#AnalyzingApplicationErrors-Introduction)
-   [Purpose](#AnalyzingApplicationErrors-Purpose)
-   [Recommended action](#AnalyzingApplicationErrors-Recommendedaction)

!!! info
At any given time, this page displays the statistics for a selected time interval.

-   If you want to view statistics for a pre-defined time interval, click on the relevant time interval (e.g., **Last 30 Days** ).
    ![]({{base_path}}/assets/attachments/103335217/103335221.gif)
-   If you want to define a custom time interval, click **Custom** and select the start and end dates of the required time interval in the calendar that appears. Then click **Apply.
    ![]({{base_path}}/assets/attachments/103335217/103335220.gif)**


### Introduction

This page displays information relating to application errors that have occurred in the WSO2 API Manager.

##### Errors Distribution

![]({{base_path}}/assets/attachments/103335217/103335219.gif)

This gadget displays the count of application errors for each day/time over the selected time interval in a bar chart as shown in the example below. Each bar provides a breakdown of errors based on their exception category. If you move the cursor over a specific category, the following information is displayed as demonstrated above.

-   **ID** : The ID of the exception category.
-   **Count** : The number of times an exception belonging to the exception category has occurred.
-   **Day** : The date on which the exception occurred.

##### Filtered Messages

![]({{base_path}}/assets/attachments/103335217/103335218.gif)

If you click on a coloured block representing an exception category, the **Filtered Messages** section is populated with details of all the individual occurrences of that exception category as shown above. At a give time, it displays only messages that belong to a selected category. You can sort the records in this table in the ascending/descending order based on the time stamp.

##### Log viewer

**![]({{base_path}}/assets/attachments/103335217/103335222.gif)**

If you want to view more details about an individual exception occurrence displayed in the **Filtered Messages** section, click **View** on the relevant row. As a result, the **Log Viewer** section displays the log in which the exception was recorded, including the 100 rows that were logged before the exception as well as the 100 rows that were logged after the exception. Different log levels are highlighted in different colours (i.e. **ERROR** level in red, **WARN** level in yellow, and **INFO** level in blue).

### Purpose

This page allows you to:

-   Identify the exception categories that have occurred for you APIM Manager installation for different time intervals.
-   Compare counts for different exception categories during selected time intervals.
-   Check detailed information relating to each exception to identify its cause.
-   Identify related logs for each exception to identify its cause.

### Recommended action

-   Observe the most frequently occurring exception categories. Identify their causes and take corrective action (e.g., configuration corrections etc.)
-   Compare counts for exception categories for different time intervals. If the count is high for any exception category at specific time intervals, check whether any unusual activity has taken place during that time (e.g., system downtime).

