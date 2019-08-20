# Analyzing the Number of API Failures

To analyze the number of API failures,

1.  Login to admin portal (https://&lt;ip\_address&gt;:&lt;port&gt;/admin).
2.  In the left navigation, Click **NUMBER OF API FAILURES** under **LOG ANALYZER.**

-   [Introduction](#AnalyzingtheNumberofAPIFailures-Introduction)
-   [Purpose](#AnalyzingtheNumberofAPIFailures-Purpose)
-   [Recommended Action](#AnalyzingtheNumberofAPIFailures-RecommendedAction)

!!! info
At any given time, this page displays the statistics for a selected time interval.

-   If you want to view statistics for a pre-defined time interval, click on the relevant time interval (e.g., **Last 30 Days** ).
    ![](attachments/103335197/103335198.gif)
-   If you want to define a custom time interval, click **Custom** and select the start and end dates of the required time interval in the calendar that appears. Then click **Apply.
    ![](attachments/103335197/103335200.gif)**


### Introduction

This report indicates the number of API failures that have occurred during the selected time interval. Each API is represented by a different colour. To check the exact failure count for an API on a specific date, move the cursor over the relevant colour block as demonstrated below.

![](attachments/103335197/103335199.gif)

### Purpose

This page allows you to:

-   Check the API failure count at different time intervals, and identify any correlations that may exist between API failure and time.
-   Compare the number of failures for different APIs and identify APIs with highest number of failures and identify the corrective action that needs to be taken.

### Recommended Action

-   Identify time intervals with the highest API failure counts and investigate further to find the causes.
-   Identify APIs with the highest number of failures and investigate further by checking logs relating to these APIS to find the causes, and take corrective action (e.g., correct the message formats).

