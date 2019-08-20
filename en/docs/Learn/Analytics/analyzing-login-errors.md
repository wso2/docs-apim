# Analyzing Login Errors

To analyze the Login Errors,

1.  Login to admin portal (https://&lt;ip\_address&gt;:&lt;port&gt;/admin).
2.  In the left navigation, Click **LOGIN ERRORS** under **LOG ANALYZER.**

-   [Introduction](#AnalyzingLoginErrors-Introduction)
-   [Purpose](#AnalyzingLoginErrors-Purpose)
-   [Recommended action](#AnalyzingLoginErrors-Recommendedaction)

!!! info
At any given time, this page displays the statistics for a selected time interval.

-   If you want to view statistics for a pre-defined time interval, click on the relevant time interval (e.g., **Last 30 Days** ).
    ![](attachments/103335204/103335207.gif)
-   If you want to define a custom time interval, click **Custom** and select the start and end dates of the required time interval in the calendar that appears. Then click **Apply.
    ![](attachments/103335201/103335203.gif)**


### Introduction

This page indicates the number of login attempt failures that have occurred during the selected time interval in a bar chart as shown in the example below. The exact count for a specific unit of time (e.g., day, hour, etc.) can be viewed by moving the cursor over the relevant bar.
![](attachments/103335201/103335202.gif)

### Purpose

This page allows you to identify the time periods during which login errors have occurred to understand what caused them.

### Recommended action

Compare the count for failed login errors at different time intervals. If the count is particularly high during specific time intervals, check for any unusual occurrences that may have taken place during that time (e.g., system downtime). If a high count for login errors is observed for all time intervals, check the relevant configurations in WSO2 API Manager (e.g., configuration of users and user roles).
