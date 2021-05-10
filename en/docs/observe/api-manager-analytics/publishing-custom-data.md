# Publishing Custom Attributes 

WSO2 API Manager's gateway component publishes attributes related to each API call to the Analytics Server. These details are published in the form of events and then summarized and persisted in the database. However, not all information related to the request is published to the Analytics Server by default (e.g header, payload). 

It can be a common requirement to publish custom attribites related to an API call for later analysis. This can be done by engaging a custom mediation sequence in request or response path. 

## Request path

A sample mediation sequence for the request path is given below. Note that the sequence includes a property named <b>apim.analytics.request.properties</b> and it's value specifies which of the subsequent properties should be included in the event published to Analytics Server. This paerticular example publishes a header named 'name' and the query parameter named 'age'.

```
<?xml version="1.0" encoding="UTF-8"?><sequence xmlns="http://ws.apache.org/ns/synapse" name="request">
    <propertyGroup description="A group of properties to include.">
	    <property name="apim.analytics.request.properties" scope="default" type="STRING" value="name,age"/>

	    <property name="name" scope="default" type="STRING" expression="$trp:name" />
	    <property name="age" expression="$url:age" scope="default" type="STRING"/>

	</propertyGroup>
</sequence>
```
## Response path

Following is a sample sequence for the response path. Note the property named <b>apim.analytics.response.properties</b> and it's values specifying the properties which should be published. 

```
<?xml version="1.0" encoding="UTF-8"?><sequence xmlns="http://ws.apache.org/ns/synapse" name="response">
    <propertyGroup description="A group of properties to include in the greeting.">
	    <property name="apim.analytics.response.properties" scope="default" type="STRING" value="Server"/>
	    
	    <property name="Server" scope="default" type="STRING" expression="$trp:Server" />
	</propertyGroup>
</sequence>
```

Once the sequences are created, they can be engaged to the in-sequence or out-sequence via the publisher portal. More information on engaging custom sequences can be found [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/message-mediation/changing-the-default-mediation-flow-of-api-requests/#changing-the-default-mediation-flow-of-api-requests). 


## Persisting published custom attributes 

Although custom attributes can be published to the Analytics Server by following the above steps, these custom attributes are not persisted in any of the aggregation tables in the analytics database. 

In order to persist these attributes, a custom siddhi application has to be deployed in the analytics server. Following siddhi app can be used as a sample to persist custom attributes to the database.

```

@App:name("APIM_EVENT_RECEIVER_CUSTOM")

@source(type = 'wso2event', wso2.stream.id = 'org.wso2.apimgt.statistics.request:3.1.0', @map(type = 'wso2event'))
define stream InComingRequestStream (meta_clientType string,
    applicationConsumerKey string,
    applicationName string,
    applicationId string,
    applicationOwner string,
    apiContext string,  
    apiName string,
    apiVersion string,
    apiResourcePath string,
    apiResourceTemplate string,
    apiMethod string,
    apiCreator string,
    apiCreatorTenantDomain string,
    apiTier string,
    apiHostname string,
    username string,
    userTenantDomain string,
    userIp string,
    userAgent string,
    requestTimestamp long,
    throttledOut bool,
    responseTime long,
    serviceTime long,
    backendTime long,
    responseCacheHit bool,
    responseSize long,
    protocol string,
    responseCode int,
    destination string,
    securityLatency long,
    throttlingLatency long,
    requestMedLat long,
    responseMedLat long,
    backendLatency long,
    otherLatency long,
    gatewayType string,
    label string,
    properties string
);

@source(type='inMemory' , topic='APIM_REQUEST_CUSTOM_ATTRIBUTES')
define stream RequestWithCustomAttributesSource (meta_clientType string, applicationConsumerKey string, applicationName string, applicationId string, applicationOwner string, apiContext string,apiName string, apiVersion string, apiResourcePath string, apiResourceTemplate string, apiMethod string, apiCreator string, apiCreatorTenantDomain string, apiTier string, apiHostname string, username string, userTenantDomain string, userIp string, userAgent string, requestTimestamp long, throttledOut bool, responseTime long, serviceTime long, backendTime long, responseCacheHit bool, responseSize long, protocol string, responseCode int, destination string, securityLatency long, throttlingLatency long, requestMedLat long, responseMedLat long, backendLatency long, otherLatency long, gatewayType string, label string, properties string);

@sink(type='inMemory' , topic='APIM_REQUEST_CUSTOM_ATTRIBUTES')
define stream RequestWithCustomAttributes (meta_clientType string,
    applicationConsumerKey string,
    applicationName string,
    applicationId string,
    applicationOwner string,
    apiContext string,
    apiName string,
    apiVersion string,
    apiResourcePath string,
    apiResourceTemplate string,
    apiMethod string,
    apiCreator string,
    apiCreatorTenantDomain string,
    apiTier string,
    apiHostname string,
    username string,
    userTenantDomain string,
    userIp string,
    userAgent string,
    requestTimestamp long,
    throttledOut bool,
    responseTime long,
    serviceTime long,
    backendTime long,
    responseCacheHit bool,
    responseSize long,
    protocol string,
    responseCode int,
    destination string,
    securityLatency long,
    throttlingLatency long,
    requestMedLat long,
    responseMedLat long,
    backendLatency long,
    otherLatency long,
    gatewayType string,
    label string,
    properties string);

@store(type = 'rdbms', datasource = 'APIM_ANALYTICS_DB')
@purge(enable='true', interval='60 min', @retentionPeriod(sec='5 minutes', min='72 hours', hours='90 days', days='1 year', months='10 years'))
define aggregation CustomApiAgg
from RequestWithCustomAttributesSource
select apiName, apiVersion, apiContext, apiHostname, applicationId, applicationOwner, username, userTenantDomain, count() as totalRequestCount, properties
group by apiContext, apiHostname, applicationId, username, userTenantDomain
aggregate by requestTimestamp every seconds...years;

from InComingRequestStream
select  meta_clientType, applicationConsumerKey, applicationName, applicationId, applicationOwner, apiContext,apiName, apiVersion,
apiResourcePath, apiResourceTemplate, ifThenElse(str:length(apiMethod)>20,str:substr(apiMethod,0,20),apiMethod) as apiMethod,
ifThenElse(str:length(apiCreator) > 150,str:substr(apiCreator,0,150), apiCreator) as  apiCreator,
ifThenElse(str:length(apiCreatorTenantDomain) > 150,str:substr(apiCreatorTenantDomain,0,150), apiCreatorTenantDomain) as apiCreatorTenantDomain,
apiTier, ifThenElse(str:length(apiHostname)>200, str:substr(apiHostname,0,200), apiHostname) as apiHostname, ifThenElse(str:length(username) > 150,
str:substr(username,0,150), username) as username, ifThenElse(str:length(userTenantDomain) > 150,str:substr(userTenantDomain,0,150),
userTenantDomain) as userTenantDomain, userIp, userAgent, requestTimestamp, throttledOut, responseTime, serviceTime, backendTime, responseCacheHit,
responseSize, protocol, responseCode, destination, securityLatency, throttlingLatency, requestMedLat, responseMedLat, backendLatency, otherLatency, gatewayType, label, properties
insert into RequestWithCustomAttributes;

```

!!! note
    
    The custom attributes are published in a field name 'properties'. Once the events are persisted using a custom siddhi app as above, these data will be persisted in a column named 'properties' in JSON format in the aggregation table. 