# Introducing the WSO2 API Manager Statistics Model

## Introduction

This section describes and illustrates the API Manager statistic publishing and generating model. It describes the internal components of API Manager, external analyzer information and other data retrieval components. API Manager generates events based on the API Manager invocation pattern and publishes them to all the listening event analyzers. The analyzer is responsible for the accumulation of all events and generates summary data based on the defined summarisation logic. After the summarized data is generated, the API Manager Analytics Dashboard can retrieve statistics from the analyzer data-source to the UI.

## API Manager usage publisher

The internal API Manager component listens to the API Manager invocations and its behavior. Based on the request and responses, the event is generated and published to all the event receivers. This publisher publishes the following event streams,

- `org.wso2.apimgt.statistics.request`
- `org.wso2.apimgt.statistics.fault`
- `org.wso2.apimgt.statistics.throttle`

## API Manager event streams

API-M provides the following types of event streams as listed below.

### **org.wso2.apimgt.statistics.request**

This stream tracks information for the API request.

|**Attribute**                                             |**Type**                             |**Description**                 |
|----------------------------------------------------------|-------------------------------------|--------------------------------|
| `meta_clientType`| string | Meta information of Client type|
| `applicationConsumerKey`| string | Consumer key of API invoked client application|
| `applicationName`| string | Name of the client application|
| `applicationId`| string | ID of the client application|
| `applicationOwner`| string | Name of the Owner of the Application|
| `apiContext`| string | API context depending on the user's request|
| `apiName`| string | API Name|
| `apiVersion`| string | API version|
| `apiResourcePath`| string | API resource path of the API request|
| `apiResourceTemplate`| string | API resource URL pattern of API request|
| `apiMethod`| string | HTTP Verb of API request [e.g.,GET/POST]|
| `apiCreator`| string| Creator of the API|
| `apiCreatorTenantDomain`| string | Tenant domain of the API creator|
| `apiTier`| string | Subscription tier associated with the API request|
| `apiHostname`| string | Hostname or Datacenter ID (if specified)|
| `username`| string | Enduser of the API request|
| `userTenantDomain`| string | Tenant domain of the user associated with the request|
| `userIp`| string | IP address of the client|
| `userAgent`| string | User agent of the user|
| `requestTimestamp`| long| Timestamp of the API request when received to the gateway|
| `throttledOut`| bool| Describes whether the request was allowed after hitting the throttle tier |
| `responseTime`| long| Timestamp of the API response when received to the gateway|
| `serviceTime`| long| Time taken to serve the API request in APIM side|
| `backendTime`| long| Time taken to process the request at the backend|
| `responseCacheHit`| bool| Describes if response caching is enabled or not|
| `responseSize`| long| Response message size in bytes|
| `protocol`| string | Protocol used to send the response (HTTP/HTTPS) and the port|
| `responseCode`| int| HTTP Response Code|
| `destination`| string | URL of the endpoint|
| `securityLatency`| long| Time taken for authentication|
| `throttlingLatency`| long| Time taken for throttling the request/response|
| `requestMediationLatency`| long| Time taken to mediate the request|
| `responseMediationLatency` | long| Time taken to mediate the response|
| `backendLatency`| long| Time taken by the backend to return the response|
| `otherLatency`| long| Time taken to process tasks other than mentioned above|
| `gatewayType`| string | The gateway type (Synapse/Micro)|
| `label`| string | The label of the API (if specified)|

### **org.wso2.apimgt.statistics.fault**

This stream contains the fault API invocations. It includes the API with back end errors, timeout etc.

|**Attribute**                                      |**Type**                             | **Description**                                                                               |
|---------------------------------------------------|-------------------------------------|-------------------------------------------------------------------------------------------|
| `meta_clientType`| string | Meta information of Client type|
| `applicationConsumerKey` | string | Consumer key of API invoked client application|
| `apiName`| string | API Name|
| `apiVersion`| string | API Version|
| `apiContext`| string | API context depending on the user's request|
| `apiResourcePath`| string | API resource path of the API request|
| `apiMethod`| string | HTTP Verb of API request [e.g.,GET/POST]|
| `apiCreator`| string | Creator of the API|
| `username`| string | Enduser of the API request|
| `userTenantDomain`| string | Tenant domain of the user associated with the request|
| `apiCreatorTenantDomain` | string | Tenant domain of the API creator|
| `hostname`| string | Hostname or Datacenter ID (if specified)|
| `applicationId`| string | ID of the client application|
| `applicationName`| string | Name of the client application|
| `protocol`| string | Protocol used to send the response (HTTP/HTTPS) and the port |
| `errorCode`| string | Synapse error code|
| `errorMessage`| string | Description of the synapse error message|
| `requestTimestamp`| long| Timestamp of the API request when received to the gateway|

### **org.wso2.apimgt.statistics.throttle**

This stream contains the API invocation with throttle information. Throttling can happen due to any of the following reasons:

-   The application limit has exceeded.
-   The resource limit has exceeded.
-   The API limit has exceeded.
-   The hard level limit has exceeded.

|**Attribute**                                      |**Type**                             |**Description**                                                                                |
|---------------------------------------------------|-------------------------------------|-------------------------------------------------------------------------------------------|
| `meta_clientType`| string | Meta information of Client type|
| `username`| string | Enduser of the API request|
| `userTenantDomain`| string | Tenant domain of the user associated with the request|
| `apiName`| string | API Name|
| `apiVersion`| string | API Version|
| `apiContext`| string | API context depending on the user's request|
| `apiCreator`| string | Creator of the API|
| `apiCreatorTenantDomain` | string | Tenant domain of the API creator|
| `applicationId`| string | ID of the client application|
| `applicationName`| string | Name of the client application|
| `subscriber`| string | Name of the subscriber of the Application|
| `throttledOutReason`| string | The reason describing why the request has been throttled out |
| `gatewayType`| string | The gateway type (Synapse/Micro)|
| `throttledOutTimestamp`| long| Timestamp when the request is throttled out|

## API Manager aggregate tables

The summarized tables are stored in the APIM Analytics internal storage. All events are stored in tables based on granularity (`SECONDS`, `MINUTES`, `HOURS`, `DAYS`, `MONTHS`, `YEARS`). Each such table contains the aggregation of stream data per granularity level. For example, each record of the `_HOURS` table contains the aggregate of the events that arrived each hour.

It is important to note that directly querying the tables is not recommended and instead you can use the [WSO2 Streaming Integrator REST APIs](https://ei.docs.wso2.com/en/latest/streaming-integrator/setup/setting-up-physical-databases/#managing-stored-data-via-rest-apis) for retrieving data from aggregations.

The reason for this recommendation is, because of the granular level aggregations that are present for a single event use case. Events are processed in-memory before adding them to the granular level tables. Therefore, if queried directly from the database, and if there are any aggregate data related to an ongoing operation, such aggregated data will not be taken into consideration. Furthermore, retrieving information directly from the tables will result in complex queries. Therefore, you can use the Streaming Integrator REST APIs for querying the tables in order to easily obtain accurate information, because all workings are handled internally by the Streaming Integrator REST APIs.

Siddhi Apps, which are deployed in the Worker profile of API Manager Analytics instance, are used in order to populate data to the aggregate tables. The latter mentioned Siddhi Apps are available in the `<API-M_ANALYTICS_HOME>/wso2/worker/deployment/siddhi-files` directory. The following are the Siddhi Apps that are used for storing data required for charts and graphs:

- APIM_ACCESS_SUMMARY.siddhi
- APIM_FAULT_SUMMARY.siddhi
- APIM_THROTTLED_OUT_SUMMARY.siddhi

The following subsections describe the table schema of each of the Aggregate tables that are present in the Statistics DB.

###**ApiUserPerAppAgg**
This aggregation contains summary data from the request event stream and you can use it to obtain information about each API request.

####ApiUserPerAppAgg Table Schema
This schema resembles the API_REQUEST_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiUserPerAppAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(254) NOT NULL,
  `applicationId` varchar(254) NOT NULL,
  `username` varchar(254) NOT NULL,
  `userTenantDomain` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `applicationOwner` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`applicationId`,`username`,`userTenantDomain`)
)
```
??? note "Click here for detailed descriptions on the ApiUserPerAppAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiContext` | API context depending on the user's request |
    | `apiHostname` | Hostname or Datacenter ID (if specified) |
    | `applicationId` | ID of the client application which is used to invoke the API |
    | `username` | End user of the API request |
    | `userTenantDomain` | Tenant domain of the user associated with the request |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `applicationName` | Name of the client application used to invoke the API |
    | `applicationOwner` | Name of the owner of the client application |
    | `gatewayType` |	Type of the gateway (Synapse/Micro) |
    | `label` | The label of the API (if specified) |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_COUNT` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |

###**ApiResPathPerApp**
This aggregation contains summarized data about API usage by resources and it is also derived from the request event stream.

####ApiResPathPerApp Table Schema
This schema resembles the API_Resource_USAGE_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiResPathPerApp_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(254) NOT NULL,
  `applicationId` varchar(254) NOT NULL,
  `apiResourceTemplate` varchar(254) NOT NULL,
  `apiMethod` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`applicationId`,`apiResourceTemplate`,`apiMethod`)
)
```

??? note "Click here for detailed descriptions on the ApiResPathPerApp Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiContext` | API context depending on the user's request |
    | `apiHostname` | Hostname or Datacenter ID (if specified) |
    | `applicationId` | ID of the client application which is used to invoke the API |
    | `apiResourceTemplate` | API resource URL pattern of API request |
    | `apiMethod` | HTTP Verb of API request [e.g.,GET/POST] |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `applicationName` | Name of the client application used to invoke the API |
    | `gatewayType` |	Type of the gateway (Synapse/Micro) |
    | `label` | The label of the API (if specified) |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_COUNT` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |

###**ApiPerDestinationAgg**
This aggregation contains summarized data of API destinations and is derived from the request event stream.

####ApiPerDestinationAgg Table Schema
This schema resembles the API_DESTINATION_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiPerDestinationAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(254) NOT NULL,
  `destination` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`destination`)
)
```

??? note "Click here for detailed descriptions on the ApiPerDestinationAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiContext` | API context depending on the user's request |
    | `apiHostname` | Hostname or Datacenter ID (if specified) |
    | `destination` | URL of the endpoint |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `gatewayType` |	Type of the gateway (Synapse/Micro) |
    | `label` | The label of the API (if specified) |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_COUNT` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |

###**ApiVersionPerAppAgg**
This aggregation contains summarized data about API usage and is also derived from the request event stream.

####ApiVersionPerAppAgg Table Schema
This schema resembles the API_VERSION_USAGE_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiVersionPerAppAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(254) NOT NULL,
  `applicationId` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  `AGG_SUM_quotaExceededValue` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`applicationId`)
)
```

??? note "Click here for detailed descriptions on the ApiVersionPerAppAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiContext` | API context depending on the user's request |
    | `apiHostname` | Hostname or Datacenter ID (if specified) |
    | `applicationId` | ID of the client application which is used to invoke the API |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `applicationName` | Name of the client application used to invoke the API |
    | `gatewayType` |	Type of the gateway (Synapse/Micro) |
    | `label` | The label of the API (if specified) |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_COUNT` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |
    | `AGG_SUM_quotaExceededValue` | A binary value (0 or 1) to indicate whether the request is throttled(1) or not(0). |


###**ApiExeTime**
This aggregation contains information related to API invocation including timestamps and the time taken by the API at different stages of invocation such as service time, backend time etc. This is also derived from the request event stream.

####ApiExeTime Table Schema
This schema resembles the API_EXE_TIME_`<time>`_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiExeTime_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(254) NOT NULL,
  `apiResourceTemplate` varchar(254) NOT NULL,
  `apiMethod` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_SUM_responseTime` bigint(20) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  `AGG_SUM_serviceTime` bigint(20) DEFAULT NULL,
  `AGG_SUM_backendTime` bigint(20) DEFAULT NULL,
  `AGG_SUM_securityLatency` bigint(20) DEFAULT NULL,
  `AGG_SUM_throttlingLatency` bigint(20) DEFAULT NULL,
  `AGG_SUM_requestMedLat` bigint(20) DEFAULT NULL,
  `AGG_SUM_responseMedLat` bigint(20) DEFAULT NULL,
  `AGG_SUM_backendLatency` bigint(20) DEFAULT NULL,
  `AGG_SUM_otherLatency` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`apiResourceTemplate`,`apiMethod`)
)
```

??? note "Click here for detailed descriptions on the ApiExeTime Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiContext` | API context depending on the user's request |
    | `apiHostname` | Hostname or Datacenter ID (if specified) |
    | `apiResourceTemplate` | API resource URL pattern of API request |
    | `apiMethod` | HTTP Verb of API request [e.g.,GET/POST] |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_SUM_responseTime` | Average time of the API response when received to the gateway |
    | `AGG_COUNT` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |
    | `AGG_SUM_serviceTime` | Average time taken to serve the API request at the API-M server end |
    | `AGG_SUM_backendTime` | Average time taken to process the request at the backend |
    | `AGG_SUM_securityLatency` | Average time taken for authentication |
    | `AGG_SUM_throttlingLatency` | Average time taken for throttling the request/response |
    | `AGG_SUM_requestMedLat` | Average time taken to mediate the request |
    | `AGG_SUM_responseMedLat` | Average time taken to mediate the response |
    | `AGG_SUM_backendLatency` | Average time taken by the backend to return the response |
    | `AGG_SUM_otherLatency` | Average time taken to process tasks other than those mentioned above | 

###**ApiUserBrowserAgg**

This aggregation contains information regarding the user browser summary derived from the request event stream.

####ApiUserBrowserAgg Table Schema
This schema resembles the API_REQ_USER_BROW_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiUserBrowserAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiCreator` varchar(254) NOT NULL,
  `apiCreatorTenantDomain` varchar(254) NOT NULL,
  `operatingSystem` varchar(254) NOT NULL,
  `browser` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiCreator`,`apiCreatorTenantDomain`,`operatingSystem`,`browser`)
)
```

??? note "Click here for detailed descriptions on the ApiUserBrowserAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiContext` | API context depending on the user's request |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `operatingSystem` | Operating system |
    | `browser` | Browser |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `gatewayType` | Type of the gateway (Synapse/Micro) |
    | `label` | The label of the API (if specified) |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_COUNT` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |

###**APIM_ReqCountAgg**

This aggregation is derived from the throttle event stream and the request event stream and provides information regarding the throttled out counts and success counts for a particular API.

####APIM_ReqCountAgg Table Schema

```sql
CREATE TABLE `APIM_ReqCountAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiName` varchar(254) NOT NULL,
  `apiVersion` varchar(254) NOT NULL,
  `apiCreator` varchar(254) NOT NULL,
  `apiCreatorTenantDomain` varchar(254) NOT NULL,
  `applicationName` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_SUM_successCount` bigint(20) DEFAULT NULL,
  `AGG_SUM_throttleCount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiName`,`apiVersion`,`apiCreator`,`apiCreatorTenantDomain`,`applicationName`)
)
```

??? note "Click here for detailed descriptions on the APIM_ReqCountAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `applicationName` | Name of the client application used to invoke the API |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_SUM_successCount` | Total successful API request count for the particular API |
    | `AGG_SUM_throttleCount` | Total throttled out API request count for the particular API |

###**ApiLastAccessSummary**

This table is not an aggregation. It contains information regarding the last access times of the APIs and is derived from the request event stream.

###ApiLastAccessSummary Table Schema

This schema resembles the API_LAST_ACCESS_TIME_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiLastAccessSummary` (
  `apiContext` varchar(254) DEFAULT NULL,
  `apiName` varchar(254) NOT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) NOT NULL,
  `apiCreatorTenantDomain` varchar(254) NOT NULL,
  `applicationOwner` varchar(254) DEFAULT NULL,
  `lastAccessTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`apiName`,`apiCreator`,`apiCreatorTenantDomain`)
)
```

??? note "Click here for detailed descriptions on the ApiLastAccessSummary Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `apiContext` | API context depending on the user's request |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `applicationOwner` | Name of the owner of the client application |
    | `lastAccessTime` | Timestamp of the latest API request occurrence |

###**GeoLocationAgg**

This aggregation contains summarized information regarding the geolocation statistics of API requests and is derived from the request event stream.

####GeoLocationAgg Table Schema

This schema resembles the API_REQ_GEO_LOC_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `GeoLocationAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `country` varchar(254) NOT NULL,
  `city` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `username` varchar(254) DEFAULT NULL,
  `userTenantDomain` varchar(254) DEFAULT NULL,
  `totalCount` bigint(20) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`country`,`city`)
)
```

??? note "Click here for detailed descriptions on the GeoLocationAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table (e.g., the start timestamp of the hour in the table with the _HOURS granularity). |
    | `AGG_EVENT_TIMESTAMP` | The time at which the event is received at the event receiver |
    | `apiContext` | API context depending on the user's request |
    | `country` | Country |
    | `city` | City |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `username` | End user of the API request |
    | `userTenantDomain` | Tenant domain of the user associated with the request |
    | `totalCount` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |


###**ApiFaultyInvocationAgg**

This aggregation contains summarized data of the faulty API invocations and is derived from the fault event stream.

####ApiFaultyInvocationAgg Table Schema

This schema resembles the API_FAULT_SUMMARY table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiFaultyInvocationAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `applicationId` varchar(254) NOT NULL,
  `hostname` varchar(254) NOT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `applicationConsumerKey` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `requestTimestamp` bigint(20) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`applicationId`,`hostname`)
)
```

??? note "Click here for detailed descriptions on the ApiFaultyInvocationAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity) |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00) |
    | `apiContext` | API context depending on the user's request |
    | `applicationId` | ID of the client application |
    | `hostname` | Hostname or Datacenter ID (if specified) |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made |
    | `apiName` | API Name |
    | `apiVersion` | API Version |
    | `apiCreator` | API Creator |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator |
    | `applicationConsumerKey` | Consumer key of API invoking client application |
    | `applicationName` | Name of the client application used to invoke the API |
    | `requestTimestamp` | Timestamp of the API request when received to the gateway |
    | `regionalID` | The region ID if multi-data centers are configured for analytics |
    | `AGG_COUNT` | The number of API requests that occured within the relevant time interval specified by AGG_TIMESTAMP based on granularity |

---

## API Manager statistics

API statistics are provided for both the API Publisher and the API Developer Portal. For information on the available statistics and how to view them, see [Viewing API Statistics](../viewing-api-statistics).
