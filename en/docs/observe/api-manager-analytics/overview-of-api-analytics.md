# Overview of API Analytics
![APIM Analytics Overview Page]({{base_path}}/assets/img/observe/apim-analytics-overview-page.png)

APIs are widely used in Business Integrations and are becoming a key part of driving an organization's business 
strategy. Ensuring the proper functioning of the APIs, getting feedback on the performance, and deriving business 
insights from APIs are becoming equally important.

With the API Manager 4.0.0 release, API Analytics was completely revamped and offered as a cloud-based analytics solution
 to provide users with an unparalleled analytics experience addressing many customer concerns we received for earlier 
 releases.

## Highlights
### Hassle Free Setting Up
With all new API Manager 4.0.0 cloud-based analytics model setting up analytics is as easy as it had ever been. You just follow below two steps to setup analytics and get it working.

 - [Register for API Manager Analytics]({{base_path}}/observe/api-manager-analytics/configure-analytics/register-for-analytics)
 - [Configure API Gateway]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-synapse-gateway) or [Choreo Connect Gateway]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-microgateway)

These are the only two steps that are needed to setup analytics with the new solution.

### Modern Responsive UIs
With cloud-based analytics now we have sleek and modern responsive UIs with improved 
 filtering and drill down capabilities. 
You can access the new analytics portal from [here](https://analytics.choreo.dev/).
To get an overview of the available dashboards and its capabilities, see the [introduction]({{base_path}}/observe/api-manager-analytics/analytics-pages/analytics-pages-introduction).

### One Portal to View and Configure Alerts
In the earlier versions, customers had to log on to a separate console to configure alerts related to analytics. With
 the cloud-based analytics now you can configure alerts using the same console you used to view analytics. 
 Please refer this documentation to configure alerts

## Design
All above highly user-friendly features are possible through the new design adopted by the analytics solution. 
The following diagram illustrates the basic architecture of the solution.

![APIM Analytics Simplified Design]({{base_path}}/assets/img/observe/apim-analytics-simplified.png)

As you can observe, Gateways will now publish analytics stats directly to the analytics cloud over the internet. 
Analytics cloud will have regional deployments to reduce publishing latencies and honor data privacy. 
Analytics console is deployed as a separate web application that will query the processing to visualize
 API statistics.
