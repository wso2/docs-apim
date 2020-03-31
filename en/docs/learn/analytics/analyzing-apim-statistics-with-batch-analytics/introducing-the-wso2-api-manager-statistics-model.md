# Introducing the WSO2 API Manager Statistics Model

-   [Introduction](#IntroducingtheWSO2APIManagerStatisticsModel-Introduction)
-   [API Manager usage publisher](#IntroducingtheWSO2APIManagerStatisticsModel-APIManagerusagepublisher)
-   [API Manager event streams](#IntroducingtheWSO2APIManagerStatisticsModel-APIManagereventstreams)
-   [API Manager statistics](#IntroducingtheWSO2APIManagerStatisticsModel-APIManagerstatistics)

### Introduction

This section describes and illustrates the API Manager statistic publishing and generating model. It describes the internal components of API Manager, external analyzer information and other data retrieval components. API Manager generates events based on the API Manager invocation pattern and publishes them to all the listening event analyzers. The analyzer is responsible for the accumulation of all events and generates summary data based on the defined summarisation logic. After the summarized data is generated, the API Manager Dashboard can retrieve statistics from the analyzer data-source to the UI via the API Manager analytics client.

### API Manager usage publisher

The internal API Manager component listens to the API Manager invocations and its behavior. Based on the request and responses, the event is generated and published to all the event receivers. This publisher publishes the following event streams,

-`org.wso2.apimgt.statistics.request          `

-`org.wso2.apimgt.statistics.fault          `

-`org.wso2.apimgt.statistics.throttle          `

### API Manager event streams

API-M provides the following types of event streams as listed below.

#### org.wso2.apimgt.statistics.request

This stream tracks information for the API request.

|                                                     |                                     |                                                                                                        |
|-----------------------------------------------------|-------------------------------------|--------------------------------------------------------------------------------------------------------|
| `meta_clientType`| `: string` | `: Meta information of Client type`|
| `applicationConsumerKey`| `: string` | `: Consumer key of API invoked client application`|
| `applicationName`| `: string` | `: Name of the client application`|
| `applicationId`| `: string` | `: ID of the client application`|
| `applicationOwner`| `: string` | `: Name of the Owner of the Application`|
| `apiContext`| `: string` | `: API context depending on the user's request`|
| `apiName`| `: string` | `: API Name`|
| `apiVersion`| `: string` | `: API version`|
| `apiResourcePath`| `: string` | `: API resource path of the API request`|
| `apiResourceTemplate`| `: string` | `: API resource URL pattern of API request`|
| `apiMethod`| `: string` | `: HTTP Verb of API request [e.g.,GET/POST]`|
| `apiCreator`| `: string` | `: Creator of the API`|
| `apiCreatorTenantDomain`| `: string` | `: Tenant domain of the API creator`|
| `apiTier`| `: string` | `: Subscription tier associated with the API request`|
| `apiHostname`| `: string` | `: Hostname or Datacenter ID (if specified)`|
| `username`| `: string` | `: Enduser of the API request`|
| `userTenantDomain`| `: string` | `: Tenant domain of the user associated with the request`|
| `userIp`| `: string` | `: IP address of the client`|
| `userAgent`| `: string` | `: User agent of the user`|
| `requestTimestamp`| `: long`| `: Timestamp of the API request when received to the gateway`|
| `throttledOut`| `: bool`| `: Describes whether the request was allowed after hitting the throttle tier` |
| `responseTime`| `: long`| `: Timestamp of the API response when received to the gateway`|
| `serviceTime`| `: long`| `: Time taken to serve the API request in APIM side`|
| `backendTime`| `: long`| `: Time taken to process the request at the backend`|
| `responseCacheHit`| `: bool`| `: Describes if response caching is enabled or not`|
| `responseSize`| `: long`| `: Response message size in bytes`|
| `protocol`| `: string` | `: Protocol used to send the response (HTTP/HTTPS) and the port`|
| `responseCode`| `: int`| `: HTTP Response Code`|
| `destination`| `: string` | `: URL of the endpoint`|
| `securityLatency`| `: long`| `: Time taken for authentication`|
| `throttlingLatency`| `: long`| `: Time taken for throttling the request/response`|
| `requestMediationLatency`| `: long`| `: Time taken to mediate the request`|
| `responseMediationLatency` | `: long`| `: Time taken to mediate the response`|
| `backendLatency`| `: long`| `: Time taken by the backend to return the response`|
| `otherLatency`| `: long`| `: Time taken to process tasks other than mentioned above`|
| `gatewayType`| `: string` | `: The gateway type (Synapse/Micro)`|
| `label`| `: string` | `: The label of the API (if specified`|

#### org.wso2.apimgt.statistics.fault

This stream contains the fault API invocations. It includes the API with back end errors, timeout etc.

|                                                   |                                     |                                                                                           |
|---------------------------------------------------|-------------------------------------|-------------------------------------------------------------------------------------------|
| `meta_clientType`| `: string` | `: Meta information of Client type`|
| `applicationConsumerKey` | `: string` | `: Consumer key of API invoked client application`|
| `apiName`| `: string` | `: API Name`|
| `apiVersion`| `: string` | `: API Version`|
| `apiContext`| `: string` | `: API context depending on the user's request`|
| `apiResourcePath`| `: string` | `: API resource path of the API request`|
| `apiMethod`| `: string` | `: HTTP Verb of API request [e.g.,GET/POST]`|
| `apiCreator`| `: string` | `: Creator of the API`|
| `username`| `: string` | `: Enduser of the API request`|
| `userTenantDomain`| `: string` | `: Tenant domain of the user associated with the request`|
| `apiCreatorTenantDomain` | `: string` | `: Tenant domain of the API creator`|
| `hostname`| `: string` | `: Hostname or Datacenter ID (if specified)`|
| `applicationId`| `: string` | `: ID of the client application`|
| `applicationName`| `: string` | `: Name of the client application`|
| `protocol`| `: string` | `: Protocol used to send the response (HTTP/HTTPS) and the port` |
| `errorCode`| `: string` | `: Synapse error code`|
| `errorMessage`| `: string` | `: Description of the synapse error message`|
| `requestTimestamp`| `: long`| `: Timestamp of the API request when received to the gateway`|

#### org.wso2.apimgt.statistics.throttle

This stream contains the API invocation with throttle information. Throttling can happen due to any of the following reasons:

-   The application limit has exceeded.

-   The resource limit has exceeded.

-   The API limit has exceeded.

-   The hard level limit has exceeded.

|                                                   |                                     |                                                                                           |
|---------------------------------------------------|-------------------------------------|-------------------------------------------------------------------------------------------|
| `meta_clientType`| `: string` | `: Meta information of Client type`|
| `username`| `: string` | `: Enduser of the API request`|
| `userTenantDomain`| `: string` | `: Tenant domain of the user associated with the request`|
| `apiName`| `: string` | `: API Name`|
| `apiVersion`| `: string` | `: API Version`|
| `apiContext`| `: string` | `: API context depending on the user's request`|
| `apiCreator`| `: string` | `: Creator of the API`|
| `apiCreatorTenantDomain` | `: string` | `: Tenant domain of the API creator`|
| `applicationId`| `: string` | `: ID of the client application`|
| `applicationName`| `: string` | `: Name of the client application`|
| `subscriber`| `: string` | `: Name of the subscriber of the Application`|
| `throttledOutReason`| `: string` | `: The reason describing why the request has been throttled out` |
| `gatewayType`| `: string` | `: The gateway type (Synapse/Micro)`|
| `throttledOutTimestamp`| `: long`| `: Timestamp when the request is throttled out`|

### API Manager statistics

API statistics are provided in both the API Publisher and the API Store. Apart from the number of subscriptions per API, all other statistical dashboards require an instance of WSO2 Data Analytics Server installed. For information on the available statistics and how to view them, see [Viewing API Statistics](_Viewing_API_Statistics_) .
