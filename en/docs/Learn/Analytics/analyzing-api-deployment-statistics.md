# Analyzing API Deployment Statistics

To analyze the API Deployment Statistics,

1.  Login to admin portal (https://&lt;ip\_address&gt;:&lt;port&gt;/admin).
2.  In the left navigation, Click **API DEPLOYMENT STATS** under **LOG ANALYZER.**

-   [Introduction](#AnalyzingAPIDeploymentStatistics-Introduction)
-   [Purpose](#AnalyzingAPIDeploymentStatistics-Purpose)
-   [Recommended Action](#AnalyzingAPIDeploymentStatistics-RecommendedAction)

!!! info
At any given time, this page displays the statistics for a selected time interval.

-   If you want to view statistics for a pre-defined time interval, click on the relevant time interval (e.g., **Last 30 Days** ).
    ![](attachments/103335204/103335207.gif)
-   If you want to define a custom time interval, click **Custom** and select the start and end dates of the required time interval in the calendar that appears. Then click **Apply.
    ![](attachments/103335204/103335206.gif)**


### Introduction

This page shows the artifacts that were deployed as well as the artifacts that were deleted during the selected time period. It also indicates the number of times each artifact was deployed/deleted. In each gadget, you can search for a specific API and sort the APIs in the ascending/descending order by the available fields

![](attachments/103335204/103335205.gif)

### Purpose

This page allows you to:

-   View statistics for all the APIs deployed in your WSO2 API Manager installation.
-   Check the status for each API (i.e. whether it is available for use or deleted).
-   Understand the extent to which each API is used by checking the frequency with which they were deployed/deleted.

### Recommended Action

Compare the frequency with which different APIs are deployed/deleted to identify the most frequently used APIs.

