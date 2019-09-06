# Analyzing Access Token Errors

To analyze the statistics of Access Token Errors,

1.  Login to admin portal (https://&lt;ip\_address&gt;:&lt;port&gt;/admin).
2.  In the left navigation, Click **ACCESS TOKEN ERRORS** under **LOG ANALYZER.**

-   [Introduction](#AnalyzingAccessTokenErrors-Introduction)
-   [Purpose](#AnalyzingAccessTokenErrors-Purpose)
-   [Recommended action](#AnalyzingAccessTokenErrors-Recommendedaction)

!!! info
At any given time, this page displays the statistics for a selected time interval.

-   If you want to view statistics for a pre-defined time interval, click on the relevant time interval (e.g., **Last 30 Days** ).
    ![](attachments/103335208/103335209.gif)
-   If you want to define a custom time interval, click **Custom** and select the start and end dates of the required time interval in the calendar that appears. Then click **Apply.
    ![](attachments/103335208/103335210.gif)**


### Introduction

This page displays information about the access token violations that have taken place during a selected time interval.

-   The **API Token Status** gadget provides a comparison of the count for each access token violation type that has taken place during the selected time interval in a bar chard. Each violation type is displayed with a specific status in the relevant bar. Move the cursor over the relevant bar as demonstrated below to view the exact count for each violation type.
    ![](attachments/103335208/103335216.gif)
-   The **APIKey Status** gadget at a given time displays all the records for a selected API token status in a table. To populate this table, click on the required status in the **API Token Status** gadget as demonstrated below.
    ![](attachments/103335208/103335215.gif)
    The records in this table can be sorted in the ascending or the descending order by the timestamp as demonstrated below.
    ![](attachments/103335208/103335214.gif)
-   The **Log Viewer** gadget displays the detailed log for a selected record in the **API Key Status** table s demonstrated below.
    ![](attachments/103335208/103335213.gif)

### Purpose

This gadget allows you to:

-   View the overall count of different errors that have occurred relating to application errors during a selected time interval.
-   View detailed information for each occurrence under a selected access token error category to investigate the reason for its occurrence.
-   View the 100 logs before and after an error to carry out further investigations about the reason for its occurrence.

### Recommended action

-   Compare the access token error count for different time periods. If the count is particularly high for a specific time interval, check for unusual events that have occurred during that time interval (e.g., system downtime).
-   Click on individual error categories and view all the records for that category in the **API Key Status** table. View the details of the individual errors and identify any common issues that cause those errors (e.g., a specific user requiring a change in his/her credentials).
-   If an error is unique and the its cause cannot be identified by checking detailed information in the **API Key Status** table, view other logs that were generated immediately before and after the error in the **Log Viewer** gadget.

