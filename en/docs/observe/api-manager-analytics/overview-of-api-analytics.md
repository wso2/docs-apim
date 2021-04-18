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
One of the major concerns customers had earlier was the effort taken up to setup the analytics environment. This 
involves setting up a minimum of two node deployment with tuned parameters which is a considerable effort and utilizes 
considerable amount of resources. 
With all new API Manager 4.0.0 cloud-based analytics model all that you need to do is,
 - [Register for API Manager Analytics]({{base_path}}/observe/api-manager-analytics/configure-analytics/register-for-analytics)
 - [Configure Synapse Gateway]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-synapse-gateway) or [Choreo Connect Gateway]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-microgateway)

These are the only two steps that is needed to setup analytics with the new solution

### Modern Responsive UIs
Earlier versions on API Manager analytics relied on home drown dashbaording solution for which We received the
 feedback that UIs look outdated. With cloud-based analytics now we have sleek and modern responsive UIs with improved 
 filtering and drill down capabilities. 
You can access the all new analytics portal through here. Use this document as a reference to composition of each
 dashboard and information that is available through them. This document will guide you through different usecases
  you can achieve through analytics portal.

### One Portal to View and Configure Alerts
In the earlier versions customers had to log in to a separate console to configure alerts related to analytics. With
 the cloud-based analytics now you can configure alerts using the same console you used to view analytics. 
 Please refer this documentation to configure alerts

## Design
All above highly user-friendly features are possible through the new design adopted by the analytics solution. 
Below diagram illustrate the basic architecture of the solution.

![APIM Analytics Simplified Design]({{base_path}}/assets/img/observe/apim-analytics-simplified.jpg)

As you can observe Gateways will now publish analytics stat directly to analytics cloud over the internet. 
Analytics cloud will have regional deployments to reduce publishing latencies and honor data privacy. 
Analytics console is deployed as a separate web application which will query the processing later to visualize
 API statistics.
