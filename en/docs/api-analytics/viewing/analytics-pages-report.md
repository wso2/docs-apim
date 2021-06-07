# Download Reports on API Analytics

This page allows you to download monthly usage reports for your system. There are pre-configured reports to get
 system wide stats and a custom report generator to generate reports based on a subset of APIs/applications.

![report page full]({{base_path}}/assets/img/analytics/report/report-page-full.png)

## Page Walk Through
The following topics walk you through the main features available for downloading API reports.

### Custom Report Download Widget
This widget allows you to generate a custom report with available stats and download it. 

![custom report]({{base_path}}/assets/img/analytics/report/custom-report.png)

Follow the steps below to generate a custom report.
1. From the API selector select an API or set of APIs that you need to download the report for. You also have the option of selecting all APIs.
2. Then from the application selector you can further filter down the results. If your selected set of APIs are subscribed by multiple applications then all those applications will be selected by default. 
However, dropdown allows you to select one or subset of those applications.
3. There is an option to filter based on the subscriber too. To do that switch the toggle by the application selector. This will convert application selector into the subscriber selector. 
You can only select a single subscriber for any given set of APIs or All the available subscribers. There is no option to select set of subscribers
4. Once either application or subscriber level filtering is done using the bottom two selectors you can select the year and month for which you need the report.
5. Finally, click on the **Download** button and choose your desired format. PDF report is given below.

![custom report sample]({{base_path}}/assets/img/analytics/report/custom-report-sample.png)

As you can observe, the report will contain:
- Generated time: Date and time when the report was generated.
- Organization: The organization the report belongs to. Reports will always be in per organization basis.
- Environment: Environment report belongs to. Reports will always be in per environment basis.
- Tenant: Tenant report belongs to. Reports will always be in per tenant basis.
- Reporting period: Time period for which the report is generated for
- Total request count: Total request count received by all selected APIs during the report time period

The chart will contain the following rows.

- API name: Name of the API
- Application name: Name of the application and name of the subscriber within brackets
- Usage count: Request count

### Pre-configured Report Download Widgets
These widgets allow you to download monthly report for last three months.

![configured report]({{base_path}}/assets/img/analytics/report/configured-report.png)

You just have to simply click **Download** link for desired month and choose the expected format. Report contains stat for All APIs and applications. Report format is as same as the above example.
