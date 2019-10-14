# Analyzing the Log Overview

To analyze the Log Overview,

1.  Login to admin portal (https://&lt;ip\_address&gt;:&lt;port&gt;/admin).
2.  In the left navigation, Click **OVERVIEW** under **LOG ANALYZER.**

-   [Introduction](#AnalyzingtheLogOverview-Introduction)
-   [Purpose](#AnalyzingtheLogOverview-Purpose)
-   [Recommended Action](#AnalyzingtheLogOverview-RecommendedAction)

!!! info
At any given time, this page displays the statistics for a selected time interval.

-   If you want to view statistics for a pre-defined time interval, click on the relevant time interval (e.g., **Last 30 Days** ).
    ![]({{base_path}}/assets/attachments/103335208/103335209.gif)
-   If you want to define a custom time interval, click **Custom** and select the start and end dates of the required time interval in the calendar that appears. Then click **Apply.
    ![]({{base_path}}/assets/attachments/103335223/103335224.gif)**


### Introduction

This page displays the overall statistics for all the available types of log events (i.e. **INFO** , **DEBUG** , **ERROR** , **WARN** and **FATAL** ) that were created during the selected time interval. The information displayed allows you to understand the overall health of the API Manager installation. The exact count for each log event type can be viewed by moving the cursor over the relevant bar. The following is an example of this report.

![]({{base_path}}/assets/attachments/103335223/103335225.gif)

### Purpose

This gadget allows you to:

-   Check the count for each type of log event at different time intervals in order to identify any correlation between frequency of their occurrence and time.
-   Compare the count for different types of log events.

### Recommended Action

-   If the count for log events of `ERROR` and `FATAL` types are particularly high at a specific time, carry out further investigations for unusual occurrences (e.g., API failure corresponding to the same time interval(s)).
-   If the count for log events of ERROR, WARN and FATAL is always high, recheck the configurations for your WSO2 API Manager installation and do the necessary changes to improve the overall health of your setup.
-   Compare the count for different type of log events  different times and identify any patterns relating to the correlation between the occurrence of log events and time. When major deviations from these patterns are identified, carry out further investigations to identify the causes (e.g., increase/decrease in the load handled by WSO2 API Manager.).

