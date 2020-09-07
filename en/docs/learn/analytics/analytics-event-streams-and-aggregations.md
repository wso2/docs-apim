# Analytics Event Streams and Aggregations

## Introduction

WSO2 API Manager has a statistic publishing and generating model that comprises of internal components of API Manager, external analyzers, and other data retrieval components. API Manager generates events based on the API Manager invocation pattern and publishes them to all the listening event analyzers. The analyzer is responsible for the accumulation of all the events and generates summarized data based on the defined summarization logic. After the summarized data is generated, the API Manager Analytics Dashboard can retrieve and display the respective statistics, from the analyzer data-source, via its UI.

## API Manager usage Publisher

The internal API Manager component listens to the API Manager invocations and its behavior. Based on the request and responses, the event is generated and published to all the event receivers. This publisher publishes the following event streams.

- `org.wso2.apimgt.statistics.request:3.2.0`
- `org.wso2.apimgt.statistics.fault:3.2.0`
- `org.wso2.apimgt.statistics.throttle:3.2.0`

## API Manager event streams

API-M provides the following types of event streams.

### org.wso2.apimgt.statistics.request:3.2.0

This stream tracks information for the API request.

|**Attribute**                                             |**Type**                             |**Description**                 |
|----------------------------------------------------------|-------------------------------------|--------------------------------|
| `meta_clientType`| string | The meta information of client type.|
| `applicationConsumerKey`| string | The consumer key of the API invoked client application.|
| `applicationName`| string | The name of the client application.|
| `applicationId`| string | The ID of the client application.|
| `applicationOwner`| string | The name of the owner of the application.|
| `apiContext`| string | The API context depending on the user's request.|
| `apiName`| string | The API name.|
| `apiVersion`| string | The API version.|
| `apiResourcePath`| string | The API resource path of the API request.|
| `apiResourceTemplate`| string | The API resource URL pattern of the API request.|
| `apiMethod`| string | The HTTP verb of the API request [e.g.,GET/POST].|
| `apiCreator`| string| The creator of the API.|
| `apiCreatorTenantDomain`| string | The tenant domain of the API creator.|
| `apiTier`| string | The subscription tier associated with the API request.|
| `apiHostname`| string | The hostname or Datacenter ID (if specified).|
| `username`| string | The end-user of the API request.|
| `userTenantDomain`| string | The tenant domain of the user that is associated with the request.|
| `userIp`| string | The IP address of the client.|
| `userAgent`| string | The user agent of the user.|
| `requestTimestamp`| long| The timestamp of the API request when received at the Gateway.|
| `throttledOut`| bool| This describes whether the request was allowed after hitting the throttle tier. |
| `responseTime`| long| The timestamp of the API response when received at the Gateway.|
| `serviceTime`| long| The time that is taken to serve the API request at the API-M side.|
| `backendTime`| long| The time taken to process the request at the backend.|
| `responseCacheHit`| bool| This describes if response caching is enabled or not.|
| `responseSize`| long| The response message size in bytes.|
| `protocol`| string | The protocol used to send the response (HTTP/HTTPS) and the port.|
| `responseCode`| int| The HTTP response code.|
| `destination`| string | The URL of the endpoint.|
| `securityLatency`| long| The time taken for authentication.|
| `throttlingLatency`| long| The time taken for throttling the request/response.|
| `requestMedLat`| long| The time taken to mediate the request.|
| `responseMedLat` | long| The time taken to mediate the response.|
| `backendLatency`| long| The time taken by the backend to return the response.|
| `otherLatency`| long| The time taken to process tasks other than mentioned above.|
| `gatewayType`| string | The Gateway type (Synapse/Micro).|
| `label`| string | The label of the API (if specified).|
| `properties`| string | The JSON string with custom attributes (if specified).|

### org.wso2.apimgt.statistics.fault:3.2.0

This stream contains the fault API invocations. It includes the API with back end errors, timeout etc.

|**Attribute**                                      |**Type**                             | **Description**                                                                               |
|---------------------------------------------------|-------------------------------------|-------------------------------------------------------------------------------------------|
| `meta_clientType`| string | The meta information of client type.|
| `applicationConsumerKey` | string | The consumer key of the API invoked client application.|
| `apiName`| string | The API name.|
| `apiVersion`| string | The API version.|
| `apiContext`| string | The API context depending on the user's request.|
| `apiResourcePath`| string | The API resource path of the API request.|
| `apiResourceTemplate`| string | The API resource URL pattern of the API request.|
| `apiMethod`| string | The HTTP verb of API request [e.g.,GET/POST].|
| `apiCreator`| string | The creator of the API.|
| `username`| string | The end-user of the API request.|
| `userTenantDomain`| string | The tenant domain of the user that is associated with the request.|
| `apiCreatorTenantDomain` | string | The tenant domain of the API creator.|
| `hostname`| string | The hostname or datacenter ID (if specified).|
| `applicationId`| string | The ID of the client application.|
| `applicationName`| string | The name of the client application.|
| `applicationOwner`| string | The name of the owner of the application.|
| `protocol`| string | The protocol used to send the response (HTTP/HTTPS) and the port. |
| `errorCode`| string | The Synapse error code.|
| `errorMessage`| string | The description of the Synapse error message.|
| `requestTimestamp`| long | The timestamp of the API request when received at the Gateway.|
| `properties`| string | The JSON string with custom attributes (if specified).|

### org.wso2.apimgt.statistics.throttle:3.2.0

This stream contains the API invocation with throttle information. Throttling can happen due to any of the following reasons:

-   The application limit has exceeded.
-   The resource limit has exceeded.
-   The API limit has exceeded.
-   The hard level limit has exceeded.

|**Attribute**                                      |**Type**                             |**Description**                                                                                |
|---------------------------------------------------|-------------------------------------|-------------------------------------------------------------------------------------------|
| `meta_clientType`| string | The meta information of client type.|
| `username`| string | The end-user of the API request.|
| `userTenantDomain`| string | The tenant domain of the user that is associated with the request.|
| `apiName`| string | The API name.|
| `apiVersion`| string | The APIversion.|
| `apiContext`| string | The API context depending on the user's request.|
| `apiCreator`| string | The creator of the API.|
| `apiCreatorTenantDomain` | string | The tenant domain of the API creator.|
| `apiResourceTemplate`| string | The API resource URL pattern of the API request.|
| `apiMethod`| string | The HTTP verb of API request [e.g.,GET/POST].|
| `applicationId`| string | The ID of the client application.|
| `applicationName`| string | The name of the client application.|
| `subscriber`| string | The name of the subscriber of the application.|
| `throttledOutReason`| string | The reason describing why the request has been throttled out. |
| `gatewayType`| string | The Gateway type (Synapse/Micro).|
| `throttledOutTimestamp`| long| The timestamp when the request is throttled out.|
| `hostname`| string | The hostname or datacenter ID (if specified).|
| `properties`| string | The JSON string with custom attributes (if specified).|

## API Manager aggregate tables

The summarized tables are stored in the API-M Analytics internal storage. All events are stored in tables based on granularity (`SECONDS`, `MINUTES`, `HOURS`, `DAYS`, `MONTHS`, and `YEARS`). Each such table contains the aggregation of stream data per granularity level. For example, each record of the `_HOURS` table contains the aggregate of the events that arrived each hour.

It is important to note that directly querying the tables is not recommended and instead you can use the [WSO2 Streaming Integrator REST APIs](https://ei.docs.wso2.com/en/latest/streaming-integrator/setup/setting-up-physical-databases/#managing-stored-data-via-rest-apis) for retrieving data from aggregations.

The reason for this recommendation is because of the granular level aggregations that are present for a single event use case. Events are processed in-memory before adding them to the granular level tables. Therefore, if queried directly from the database, and if there are any aggregate data related to an ongoing operation, such aggregated data will not be taken into consideration. Furthermore, retrieving information directly from the tables will result in complex queries. Therefore, you can use the Streaming Integrator REST APIs for querying the tables in order to easily obtain accurate information, because all workings are handled internally by the Streaming Integrator REST APIs.

The Siddhi applications, which are deployed in the Worker profile of API Manager Analytics instance, are used in order to populate data to the aggregate tables. The latter mentioned Siddhi applications are available in the `<API-M_ANALYTICS_HOME>/wso2/worker/deployment/siddhi-files` directory. The following are the Siddhi applications that are used for storing the data required for charts and graphs.

- APIM_ACCESS_SUMMARY.siddhi
- APIM_FAULT_SUMMARY.siddhi
- APIM_THROTTLED_OUT_SUMMARY.siddhi
- APIM_ERROR_SUMMARY.siddhi

The following subsections describe the table schema of each of the aggregate tables that are present in the Statistics DB.

### ApiUserPerAppAgg
This aggregation contains summary data from the request event stream and you can use it to obtain information about each API request.

#### ApiUserPerAppAgg table schema
This schema resembles the `API_REQUEST_SUMMARY` table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiUserPerAppAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(200) NOT NULL,
  `applicationId` varchar(40) NOT NULL,
  `username` varchar(150) NOT NULL,
  `userTenantDomain` varchar(150) NOT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `applicationOwner` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(20) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`applicationId`,`username`,`userTenantDomain`)
)
```

??? note "Click here for detailed descriptions on the ApiUserPerAppAgg table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with `_HOURS` granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for the hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request. |
    | `apiHostname` | The hostname or datacenter ID (if specified). |
    | `applicationId` | The ID of the client application that is used to invoke the API. |
    | `username` | The end-user of the API request.|
    | `userTenantDomain` | The tenant domain of the user that is associated with the request. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request (event) belonging to the respective time range starting from when the `AGG_TIMESTAMP` was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `applicationName` | The name of the client application used to invoke the API. |
    | `applicationOwner` | The name of the owner of the client application. |
    | `gatewayType` | The type of the Gateway (Synapse/Micro). |
    | `label` | The label of the API (if specified). |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by the `AGG_TIMESTAMP` based on the granularity. |

### ApiResPathPerApp
This aggregation contains summarized data about API usage by resources and it is also derived from the request event stream.

#### ApiResPathPerApp table schema
This schema resembles the `API_Resource_USAGE_SUMMARY` table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiResPathPerApp_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(200) NOT NULL,
  `applicationId` varchar(40) NOT NULL,
  `apiResourceTemplate` varchar(254) NOT NULL,
  `apiMethod` varchar(20) NOT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(20) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`applicationId`,`apiResourceTemplate`,`apiMethod`)
)
```

??? note "Click here for detailed descriptions on the ApiResPathPerApp table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with `_HOURS` granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request. |
    | `apiHostname` | The hostname or datacenter ID (if specified). |
    | `applicationId` | The ID of the client application which is used to invoke the API. |
    | `apiResourceTemplate` | The API resource URL pattern of the API request. |
    | `apiMethod` | The HTTP verb of API request [e.g.,GET/POST]. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `applicationName` | The name of the client application used to invoke the API. |
    | `gatewayType` | The type of the Gateway (Synapse/Micro). |
    | `label` | The label of the API (if specified). |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on the granularity. |

### **ApiPerDestinationAgg**
This aggregation contains summarized data of API destinations and is derived from the request event stream.

#### ApiPerDestinationAgg table schema
This schema resembles the `API_DESTINATION_SUMMARY` table from the previous Stat DB schema.

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

??? note "Click here for detailed descriptions on the ApiPerDestinationAgg table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with `_HOURS` granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request. |
    | `apiHostname` | The hostname or Datacenter ID (if specified). |
    | `destination` | The URL of the endpoint. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request (event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `gatewayType` | The type of the Gateway (Synapse/Micro). |
    | `label` | The label of the API (if specified). |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on the granularity. |

### **ApiVersionPerAppAgg**
This aggregation contains summarized data about API usage and is also derived from the request event stream.

#### ApiVersionPerAppAgg table schema
This schema resembles the `API_VERSION_USAGE_SUMMARY` table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiVersionPerAppAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiHostname` varchar(254) NOT NULL,
  `applicationId` varchar(254) NOT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  `AGG_SUM_quotaExceededValue` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiHostname`,`applicationId`)
)
```

??? note "Click here for detailed descriptions on the ApiVersionPerAppAgg table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with `_HOURS` granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request. |
    | `apiHostname` | The hostname or datacenter ID (if specified). |
    | `applicationId` | The ID of the client application which is used to invoke the API. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request (event) belonging to the respective time range starting from when the `AGG_TIMESTAMP` was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `applicationName` | The name of the client application used to invoke the API. |
    | `gatewayType` | The type of the gateway (Synapse/Micro). |
    | `label` | The label of the API (if specified). |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on the granularity. |
    | `AGG_SUM_quotaExceededValue` | A binary value (0 or 1) to indicate whether the request is throttled (1) or not (0). |


### ApiExeTime
This aggregation contains information related to API invocation including timestamps and the time taken by the API at different stages of invocation such as service time, backend time etc. This is also derived from the request event stream.

#### ApiExeTime table schema
This schema resembles the `API_EXE_TIME_<time>_SUMMARY` table from the previous Stat DB schema.

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

??? note "Click here for detailed descriptions on the ApiExeTime table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request. |
    | `apiHostname` | The hostname or Datacenter ID (if specified). |
    | `apiResourceTemplate` | The API resource URL pattern of the API request.|
    | `apiMethod` | The HTTP Verb of API request [e.g.,GET/POST]. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_SUM_responseTime` | The average time of the API response when received to the gateway. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on the granularity. |
    | `AGG_SUM_serviceTime` | The average time taken to serve the API request at the API-M server end. |
    | `AGG_SUM_backendTime` | The average time taken to process the request at the backend. |
    | `AGG_SUM_securityLatency` | The average time taken for authentication. |
    | `AGG_SUM_throttlingLatency` | The average time taken for throttling the request/response. |
    | `AGG_SUM_requestMedLat` | The average time taken to mediate the request. |
    | `AGG_SUM_responseMedLat` | The average time taken to mediate the response. |
    | `AGG_SUM_backendLatency` | The average time taken by the backend to return the response. |
    | `AGG_SUM_otherLatency` | The average time taken to process tasks other than those mentioned above. | 

### ApiUserBrowserAgg

This aggregation contains information regarding the user browser summary derived from the request event stream.

#### ApiUserBrowserAgg table schema
This schema resembles the `API_REQ_USER_BROW_SUMMARY` table from the previous Stat DB schema.

```sql
CREATE TABLE `ApiUserBrowserAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `apiCreator` varchar(150) NOT NULL,
  `apiCreatorTenantDomain` varchar(150) NOT NULL,
  `operatingSystem` varchar(100) NOT NULL,
  `browser` varchar(100) NOT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `regionalID` varchar(20) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`apiCreator`,`apiCreatorTenantDomain`,`operatingSystem`,`browser`)
)
```

??? note "Click here for detailed descriptions on the ApiUserBrowserAgg table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with `_HOURS` granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request.|
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `operatingSystem` | The operating system. |
    | `browser` | The browser. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request (event) belonging to the respective time range starting from when the `AGG_TIMESTAMP` was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `gatewayType` | The type of the gateway (Synapse/Micro). |
    | `label` | The label of the API (if specified). |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on the granularity. |

### APIM_ReqCountAgg

This aggregation is derived from the throttle event stream and the request event stream and it provides information regarding the throttled out counts and success counts for a particular API.

#### APIM_ReqCountAgg table schema

```sql
CREATE TABLE `APIM_ReqCountAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiName` varchar(200) NOT NULL,
  `apiVersion` varchar(30) NOT NULL,
  `apiCreator` varchar(150) NOT NULL,
  `apiCreatorTenantDomain` varchar(100) NOT NULL,
  `applicationName` varchar(100) NOT NULL,
  `regionalID` varchar(20) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_SUM_successCount` bigint(20) DEFAULT NULL,
  `AGG_SUM_throttleCount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiName`,`apiVersion`,`apiCreator`,`apiCreatorTenantDomain`,`applicationName`)
)
```

??? note "Click here for detailed descriptions on the APIM_ReqCountAgg Table Schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with `_HOURS` granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for hour granularity is 11:00:00). |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `applicationName` | The name of the client application used to invoke the API. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request (event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made. |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_SUM_successCount` | The total successful API request count for the particular API. |
    | `AGG_SUM_throttleCount` | The total throttled out API request count for the particular API. |

### ApiLastAccessSummary

This table is not an aggregation. It contains information regarding the last access times of the APIs and is derived from the request event stream.

### ApiLastAccessSummary table schema

This schema resembles the `API_LAST_ACCESS_TIME_SUMMARY` table from the previous Stat DB schema.

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

??? note "Click here for detailed descriptions on the ApiLastAccessSummary table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `apiContext` | The API context depending on the user's request. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `applicationOwner` | The name of the owner of the client application. |
    | `lastAccessTime` | The timestamp of the latest API request occurrence. |

### GeoLocationAgg

This aggregation contains summarized information regarding the geolocation statistics of API requests and is derived from the request event stream.

#### GeoLocationAgg table schema

This schema resembles the `API_REQ_GEO_LOC_SUMMARY` table from the previous Stat DB schema.

```sql
CREATE TABLE `GeoLocationAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `country` varchar(254) NOT NULL,
  `city` varchar(254) NOT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `username` varchar(254) DEFAULT NULL,
  `userTenantDomain` varchar(254) DEFAULT NULL,
  `regionalID` varchar(254) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`country`,`city`)
)
```

??? note "Click here for detailed descriptions on the GeoLocationAgg Table Schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range based on the granularity of the table (e.g., the start timestamp of the hour in the table with the _HOURS granularity). |
    | `AGG_EVENT_TIMESTAMP` | The time at which the event is received at the event receiver. |
    | `apiContext` | The API context depending on the user's request. |
    | `country` | The country. |
    | `city` | The city. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `username` | The end-user of the API request. |
    | `userTenantDomain` | The tenant domain of the user that is associated with the request. |
    | `totalCount` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on granularity. |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |


### ApiFaultyInvocationAgg

This aggregation contains summarized data of the faulty API invocations and is derived from the fault event stream.

#### ApiFaultyInvocationAgg table schema

This schema resembles the `API_FAULT_SUMMARY` table from the previous Stat DB schema.

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

??? note "Click here for detailed descriptions on the ApiFaultyInvocationAgg table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with `_HOURS` granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request. |
    | `applicationId` | The ID of the client application. |
    | `hostname` | The hostname or datacenter ID (if specified). |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made. |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | Tenant domain of the API creator. |
    | `applicationConsumerKey` | The consumer key of API invoking client application. |
    | `applicationName` | The name of the client application used to invoke the API. |
    | `requestTimestamp` | The timestamp of the API request when received to the gateway. |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on granularity. |


### ApiThrottledOutAgg

This aggregation contains summarized data of the throttled out API invocations and is derived from the throttled event stream.

#### ApiThrottledOutAgg table schema

```sql
CREATE TABLE `ApiThrottledOutAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiContext` varchar(254) NOT NULL,
  `applicationId` varchar(40) NOT NULL,
  `hostname` varchar(254) NOT NULL,
  `apiName` varchar(254) DEFAULT NULL,
  `apiVersion` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `username` varchar(254) DEFAULT NULL,
  `userTenantDomain` varchar(254) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `subscriber` varchar(254) DEFAULT NULL,
  `throttledOutReason` varchar(254) DEFAULT NULL,
  `gatewayType` varchar(254) DEFAULT NULL,
  `regionalID` varchar(20) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_COUNT` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiContext`,`applicationId`,`hostname`)
)
```

??? note "Click here for detailed descriptions on the ApiThrottledOutAgg table schema"
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the agg_event_timestamp for hour granularity is 11:00:00). |
    | `apiContext` | The API context depending on the user's request.|
    | `applicationId` | The ID of the client application. |
    | `hostname` | The hostname or Datacenter ID (if specified). |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `username` | The end-user of the API request. |
    | `userTenantDomain` | The tenant domain of the user that is associated with the request. |
    | `applicationName` | The name of the client application used to invoke the API. |
    | `subscriber`| The name of the subscriber of the Application.|
    | `throttledOutReason`| The reason describing why the request has been throttled out. |
    | `gatewayType` | The type of the gateway (Synapse/Micro). |
    | `regionalID` | The region ID if multi-data centers are configured for analytics. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request(event) belonging to the respective time range starting from when the AGG_TIMESTAMP was made. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by `AGG_TIMESTAMP` based on granularity. |


### ApiErrorAnalysisAgg

This aggregation contains summarized data of the API errors and is derived from the request, throttled, and faulty event streams.

#### ApiErrorAnalysisAgg Table Schema


```sql
CREATE TABLE `ApiErrorAnalysisAgg_<granularity>` (
  `AGG_TIMESTAMP` bigint(20) NOT NULL,
  `AGG_EVENT_TIMESTAMP` bigint(20) NOT NULL,
  `apiName` varchar(254) NOT NULL,
  `apiVersion` varchar(254) NOT NULL,
  `responseCode` int(11) NOT NULL,
  `apiResourceTemplate` varchar(254) NOT NULL,
  `applicationId` varchar(40) NOT NULL,
  `apiMethod` varchar(40) DEFAULT NULL,
  `applicationName` varchar(254) DEFAULT NULL,
  `applicationOwner` varchar(254) DEFAULT NULL,
  `apiCreator` varchar(254) DEFAULT NULL,
  `apiCreatorTenantDomain` varchar(254) DEFAULT NULL,
  `AGG_LAST_EVENT_TIMESTAMP` bigint(20) DEFAULT NULL,
  `AGG_SUM__2xx` bigint(20) DEFAULT NULL,
  `AGG_SUM__4xx` bigint(20) DEFAULT NULL,
  `AGG_SUM__5xx` bigint(20) DEFAULT NULL,
  `AGG_SUM_responseCount` bigint(20) DEFAULT NULL,
  `AGG_SUM_faultCount` bigint(20) DEFAULT NULL,
  `AGG_SUM_throttledCount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`AGG_TIMESTAMP`,`AGG_EVENT_TIMESTAMP`,`apiName`,`apiVersion`,`responseCode`,`apiResourceTemplate`,`applicationId`)
)
```

??? note "Click here for detailed descriptions on the ApiErrorAnalysisAgg Table Schema."
    |**Field Name**                                     |**Description**                      |
    |---------------------------------------------------|-------------------------------------|
    | `AGG_TIMESTAMP` | The start timestamp of the time range that is based on the granularity of the table. (e.g., start timestamp of the hour in the table with _HOURS granularity). |
    | `AGG_EVENT_TIMESTAMP` | The start timestamp of the time range based in the granularity for the event timestamp (For instance if the event is generated at 11:30:21, the `agg_event_timestamp` for hour granularity is 11:00:00). |
    | `apiName` | The API name. |
    | `apiVersion` | The API version. |
    | `responseCode`| The HTTP response code |
    | `apiResourceTemplate` | The API resource URL pattern of the API request. |
    | `applicationId` | The ID of the client application. |
    | `apiMethod` | The HTTP verb of API request [e.g.,GET/POST]. |
    | `applicationName` | The name of the client application used to invoke the API. |
    | `applicationOwner` | The name of the owner of the client application. |
    | `apiCreator` | The API creator. |
    | `apiCreatorTenantDomain` | The tenant domain of the API creator. |
    | `AGG_LAST_EVENT_TIMESTAMP` | The timestamp at which the latest API request (event) belonging to the respective time range starting from when the `AGG_TIMESTAMP` was made. |
    | `AGG_SUM__2xx` | The number of 2xx response codes that occurred within the relevant time interval specified by the `AGG_TIMESTAMP` based on the granularity. |
    | `AGG_SUM__4xx` | The number of 4xx response codes that occurred within the relevant time interval specified by the `AGG_TIMESTAMP` based on the granularity. |
    | `AGG_SUM__5xx` | The number of 5xx response codes that occurred within the relevant time interval specified by the `AGG_TIMESTAMP` based on the granularity. |
    | `AGG_SUM_responseCount` | The number of responses received from the backend within the relevant time interval specified by `AGG_TIMESTAMP` based on the granularity. |
    | `AGG_SUM_faultCount` | The number of faulty invocation that occurred within the relevant time interval specified by th`AGG_TIMESTAMP` based on the granularity. |
    | `AGG_SUM_throttledCount` | The number of throttled out requests that occurred within the relevant time interval specified by the `AGG_TIMESTAMP` based on the granularity. |
    | `AGG_COUNT` | The number of API requests that occurred within the relevant time interval specified by the `AGG_TIMESTAMP` based on granularity. |
