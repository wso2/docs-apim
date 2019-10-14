# Viewing API Statistics

API statistics are provided in both the API Publisher and the API Store. For instructions on how to set up Analytics, see [Configuring APIM Analytics](_Configuring_APIM_Analytics_) . Once Analytics is set up, follow the instructions below to view statistics through the API Publisher and API Store.

First, [invoke a few APIs](https://docs.wso2.com/display/AM260/Quick+Start+Guide#QuickStartGuide-InvokingtheAPI) to generate traffic and see the statistics.

!!! note
The following gadgets on the API Manager statistical dashboards, display real runtime statistics even when Analytics is not set up (as described in [Configuring APIM Analytics](_Configuring_APIM_Analytics_) ).

-   Published APIs Over Time
-   Applications Created Over Time
-   Developer Signups Over Time
-   Subscriptions Created Over Time
-   API subscriptions

The other gadgets you see on the API Manager statistical dashboards without setting up Analytics, are just samples and are not based on real runtime statistics of your server.

!!! warning
Please note that our data summarization logic summarizes the data on a **per day** basis.


The sections below explain how to access the statistical dashboards:

-   [API Publisher statistics](#ViewingAPIStatistics-APIPublisherstatistics)
-   [API Store statistics](#ViewingAPIStatistics-APIStorestatistics)
-   [Admin Portal Statistics](#ViewingAPIStatistics-AdminPortalStatistics)

### API Publisher statistics

!!! info
The gadgets that display publisher statistics can only be viewed via users that have permission to create APIs. For more information, see [Managing Users and Roles](https://docs.wso2.com/display/AM260/Managing+Users+and+Roles) .


Log in to the API Publisher. Anyone who can create and/or publish APIs can view the API-level usage and subscription statistics by clicking on a selected API and referring to its **Versions** and **Users** tabs.

![]({{base_path}}/assets/attachments/103335072/103335085.png)
![]({{base_path}}/assets/attachments/103335072/103335086.png)
Given below are the statistical dashboards that are available from the **Analytics** menu.

![]({{base_path}}/assets/attachments/103335072/103335079.png)![]({{base_path}}/assets/attachments/103335072/103335080.png)
In each of the dashboards, you can choose to view all APIs or if you are an API creator, only the APIs that you have created. You can also select the time period for which you wish to view the statistics.
![]({{base_path}}/assets/attachments/103335072/103335092.png)

Several examples of usage and performance statistics are given below:

-   [Created APIs Over Time](#ViewingAPIStatistics-CreatedAPIsOverTime)
-   [API Usage](#ViewingAPIStatistics-APIUsage)
-   [API Last Access Times](#ViewingAPIStatistics-APILastAccessTimes)
-   [Usage by Resource Path](#ViewingAPIStatistics-UsagebyResourcePath)
-   [Usage by Destination](#ViewingAPIStatistics-UsagebyDestination)
-   [API Usage Comparison](#ViewingAPIStatistics-APIUsageComparison)
-   [API Throttled Requests](#ViewingAPIStatistics-APIThrottledRequests)
-   [Faulty Invocations](#ViewingAPIStatistics-FaultyInvocations)
-   [API Latency Time](#ViewingAPIStatistics-APILatencyTime)
-   [API Usage Across Geo Locations](#ViewingAPIStatistics-APIUsageAcrossGeoLocations)
-   [API Usage Across User Agent](#ViewingAPIStatistics-APIUsageAcrossUserAgent)
-   [App Throttled Requests](#ViewingAPIStatistics-AppThrottledRequests)
-   [Applications Created Over Time](#ViewingAPIStatistics-ApplicationsCreatedOverTime)
-   [API Subscriptions](#ViewingAPIStatistics-APISubscriptions)
-   [Developer Signups Over Time](#ViewingAPIStatistics-DeveloperSignupsOverTime)
-   [Subscriptions Created Over Time](#ViewingAPIStatistics-SubscriptionsCreatedOverTime)
-   [API Usage per Application](#ViewingAPIStatistics-APIUsageperApplication)
-   [Top Users per Application](#ViewingAPIStatistics-TopUsersperApplication)
-   [Resource Usage per Application](#ViewingAPIStatistics-ResourceUsageperApplication)
-   [Faulty Invocations per Application](#ViewingAPIStatistics-FaultyInvocationsperApplication)
-   [Availability of APIs](#ViewingAPIStatistics-AvailabilityOfAPIsAvailabilityofAPIs)

##### Created APIs Over Time

The number of APIs published over a given time period.
![]({{base_path}}/assets/attachments/103335072/103335084.png)
##### API Usage

The number of subscriptions of each API with a grahical view of the count.
![]({{base_path}}/assets/attachments/103335072/103335106.png)
##### API Last Access Times

A tabular representation of the last access times of an API, according to the version and the accessed subscriber.
![]({{base_path}}/assets/attachments/103335072/103335104.png)
##### Usage by Resource Path

The number of invocations made by resources for an API, represented in a tabular view.
![]({{base_path}}/assets/attachments/103335072/103335089.png)
##### Usage by Destination

The number of times an API was accessed based on the destination, represented in a tabular view.
![]({{base_path}}/assets/attachments/103335072/103335103.png)
##### API Usage Comparison

The number of invocations made for an API represented as a combination of all resources and all versions of the API.
![]({{base_path}}/assets/attachments/103335072/103335102.png)
##### API Throttled Requests

The total count of the successful request count and throttled request count towards an API over time.
![]({{base_path}}/assets/attachments/103335072/103335074.png)
##### Faulty Invocations

A successful invocation is when an API receives the expected response. If it results in any kind of error response, that invocation is considered a faulty invocation. The total number of invocations of an API represented as a combination of successful and faulty invocations is denoted in the faulty invocations graph.
![]({{base_path}}/assets/attachments/103335072/103335073.png)
##### API Latency Time

The execution time of the APIs represented as a combination of throttling, In mediation, Out mediation, backend response time, and authentication time.

You can also see a comparison view of the latencies.

![]({{base_path}}/assets/attachments/103335072/103335101.png)
##### API Usage Across Geo Locations

The data script that updates statistics related to geo locations is executed once a day. Therefore, at a given time, some of the statistics generated within the last 24 hours may not be displayed in this gadget.
![]({{base_path}}/assets/attachments/103335072/103335077.png)

##### API Usage Across User Agent

The proportional distribution of the usage (invocation) of each API differentiated by the user agent HTTP header received in requests towards the API.
![]({{base_path}}/assets/attachments/103335072/103335099.png)
##### App Throttled Requests

The successful request count and throttled request count of each API invoked by each application.
![]({{base_path}}/assets/attachments/103335072/103335098.png)
##### Applications Created Over Time

The number of applications created over a given time period.
![]({{base_path}}/assets/attachments/103335072/103335097.png)
##### API Subscriptions

The subscriptions created for each of the APIs as a distribution of API versions.
![]({{base_path}}/assets/attachments/103335072/103335096.png)
##### Developer Signups Over Time

The number of developers who signed up to the API Store over time.
![]({{base_path}}/assets/attachments/103335072/103335095.png)
##### Subscriptions Created Over Time

The number of subscriptions created for an API over a given period.

First, select the API for which you wish to view subscriptions.

![]({{base_path}}/assets/attachments/103335072/103335083.png)
![]({{base_path}}/assets/attachments/103335072/103335093.png)
### API Store statistics

Log in to the API Store. You can [self-subscribe](https://docs.wso2.com/display/AM260/Customizing+the+API+Store#CustomizingtheAPIStore-Enablingordisablingselfsignup) to the store. Next, click the **Statistics** menu.

![]({{base_path}}/assets/attachments/103335072/103335078.png)
Given below are the statistical dashboards that are available:

-   **APIUsage** : The usage of the API per application.
-   **Top Users** : Users who make the most API invocations per application and the number of registered users per application.
-   **Resource Usage** : The usage of an API and from which resource path per application.
-   **Faulty Invocations** : The number of faulty API invocations per application.
    In a faulty API invocation, the message is mediated though the `fault` sequence. By default, the API Manager considers an API invocation to be faulty when the backend service is unavailable.

Several examples of usage and performance statistics are given below:

##### API Usage per Application

The number of invocations made for each API by each application.
![]({{base_path}}/assets/attachments/103335072/103335114.png)
##### Top Users per Application

The users who made the largest number of API calls per application.
![]({{base_path}}/assets/attachments/103335072/103335088.png)
!!! note
The statistics for the registered users for applications takes the number of users shared across each application in to consideration. To enable application sharing among users within the same organization, see [Sharing Applications](https://docs.wso2.com/display/AM260/Sharing+Applications) .

Only users who have generated access tokens using the [password grant](https://docs.wso2.com/display/AM260/Password+Grant) type are considered in these statistics.


##### Resource Usage per Application

The usage of resources of the APIs by each application.
![]({{base_path}}/assets/attachments/103335072/103335112.png)
##### Faulty Invocations per Application

The total number of invocations made by each application that are unsuccessful (faulty).

![]({{base_path}}/assets/attachments/103335072/103335111.png)
### Admin Portal Statistics

Log in to the Admin Portal ( `https://localhost:9443/admin` ). API Availability is the only statistical view that exists in the Admin Portal. Admin users can view API Availability statistics by navigating to **ANALYTICS &gt; API AVAILABILITY** .

##### Availability of APIs

The status of the APIs (all API versions) represented in a tabular view.

![]({{base_path}}/assets/attachments/103335072/103335076.png)
<table>
<tbody>
<tr class="odd">
<td>Status</td>
<td><div class="content-wrapper">
<p>This indicates the status of the API. There are two possible values; <strong>Available</strong> and <strong>Limited</strong> .</p>
<p><strong>Available</strong> - This status indicates that the API has traffic with normal successful invocations. By default, if an API receives successful invocations for at least one out of five invocations within 30000 milliseconds, the status of the API becomes <strong>Available</strong> .</p>
!!! note
<p>Note that only the APIs that have traffic are represented in this tabular representation.</p>

<p><strong>Limited</strong> - If an API receives an alert due to one of the reasons indicated in <a href="Alert-Types_103335140.html#AlertTypes-AvailabilityofAPIs(healthmonitoring)">Availability of APIs (health monitoring)</a> , the API status changes to <strong>Limited</strong> .</p>
!!! note
<p>For more information on how to view the generated alerts, see <a href="_Viewing_Alerts_">Viewing Alerts</a> .</p>

</div></td>
</tr>
</tbody>
</table>

The availability of APIs statistics is directly related to the [Availability of APIs (health monitoring)](Alert-Types_103335140.html#AlertTypes-AvailabilityofAPIs(healthmonitoring)) alert type. You can edit the default configurations of the numbers set as parameters to cumstomize generating alerts by navigating to **SETTINGS &gt; ANALYTICS** and by going to the **Edit** view of **HealthAvailabilityPerMinAlert** as shown below.

![]({{base_path}}/assets/attachments/103335072/103335075.png)

The parameter configurations of this alert type are given below.

|                                             |                                                                                                                                                                                                                                                               |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Number of continuous responses              | Considering the aspect of generating the alerts, number of responses that should fail to pass the lower percentile. The default value is 5 responses.                                                                                                         |
| Number of continuous response time failures | The number of minutes that responses should fail to pass the lower percentile for the alert to be generated. The default value is 5 minutes.                                                                                                                  |
| Time interval                               | The time duration taken to recheck and change the availability of an API. The availability of the API is rechecked after this time interval and the new status is retrieved if the behaviour changes. The default value is 300 seconds (300000 milliseconds). |
| Cache time-out                              | The cache time-out value in seconds.                                                                                                                                                                                                                          |
| Severity level                              | The severity level of the alert, which you can specify as 1, 2 or 3 where 1 is severe, 2 is moderate and 3 is mild.                                                                                                                                           |


