# DataDog Based Analytics Solution For API Manager

<a href="{{base_path}}/assets/img/analytics/datadog/architecture.png"><img src="{{base_path}}/assets/img/analytics/datadog/architecture.png" width="70%" alt="Deployment diagram"></a>

### Deployment

As explained in the above deployment diagram, API Manager analytics will be written asynchronously into the `apim_metrics.log` file. 
The log file will be read by the Datadog agent and published the data into the Datadog analytics platform. 

In the Datadog end a pipeline is created to pre-process the data. This pipeline tokenizes the log into attributes, which are then converted into facets. The purpose of this is to allow for the creation of dashboards.

### Step 1 - Configuring API Manager

#### Step 1.1 - Configuring the deployment.toml file.

The Choreo based analytics will be enabled by default. Specify the `type` as `elk` to enable ELK analytics as shown below.
Edit `apim.analytics` configurations in the `deployment.toml` file located inside the `wso2am-4.x.x/repository/conf` directory with the following configuration.

```toml
[apim.analytics]
enable = true
type = "log"
```

#### Step 1.2 - Enabling Logs

To enable logging for a reporter, edit the `log4j2.properties` file located inside the `wso2am-4.x.x/repository/conf` directory. 


1. Add APIM_METRICS_APPENDER to the appenders list:

    ```properties
    appenders = APIM_METRICS_APPENDER, .... (list of other available appenders)
    ```
   
2. Add the following configuration after the appenders:

    ```properties
    appender.APIM_METRICS_APPENDER.type = RollingFile
    appender.APIM_METRICS_APPENDER.name = APIM_METRICS_APPENDER
    appender.APIM_METRICS_APPENDER.fileName = ${sys:carbon.home}/repository/logs/apim_metrics.log
    appender.APIM_METRICS_APPENDER.filePattern = ${sys:carbon.home}/repository/logs/apim_metrics-%d{MM-dd-yyyy}-%i.log
    appender.APIM_METRICS_APPENDER.layout.type = PatternLayout
    appender.APIM_METRICS_APPENDER.layout.pattern = %d{HH:mm:ss,SSS} [%X{ip}-%X{host}] [%t] %5p %c{1} %m%n
    appender.APIM_METRICS_APPENDER.policies.type = Policies
    appender.APIM_METRICS_APPENDER.policies.time.type = TimeBasedTriggeringPolicy
    appender.APIM_METRICS_APPENDER.policies.time.interval = 1
    appender.APIM_METRICS_APPENDER.policies.time.modulate = true
    appender.APIM_METRICS_APPENDER.policies.size.type = SizeBasedTriggeringPolicy
    appender.APIM_METRICS_APPENDER.policies.size.size=1000MB
    appender.APIM_METRICS_APPENDER.strategy.type = DefaultRolloverStrategy
    appender.APIM_METRICS_APPENDER.strategy.max = 10
    ```
   
3. Add a reporter to the loggers list:

    ```properties
    loggers = reporter, ...(list of other available loggers)
    ```

4. Add the following configurations after the loggers:

    ```properties
    logger.reporter.name = org.wso2.am.analytics.publisher.reporter.elk
    logger.reporter.level = INFO
    logger.reporter.additivity = false
    logger.reporter.appenderRef.APIM_METRICS_APPENDER.ref = APIM_METRICS_APPENDER
    ```
   
!!! note
    The `apim_metrics.log` file be rolled each day or when the log size reaches the limit of 1000 MB by default. Note that only 10 revisions will be kept and older revisions will be deleted automatically. You can change these configurations by updating the configurations provided in step 2 of this section given above.

### Step 2 - Configuring DataDog

Before you begin, an application Key should be generated following the steps in this [documentation.](https://docs.datadoghq.com/account_management/api-app-keys/#add-application-keys)(Do not assign any scopes while creating the key)

#### Step 2.1 - Configure Datadog Agent 

Follow the steps [here](https://docs.datadoghq.com/logs/log_collection/?tab=host#setup) to configure the Datadog Agent to read and publish the `apim_metrics.log` file.

#### Step 2.2 - Create Log Pipeline

The published have to be pre-processed and extracted the attributes so that facets and measures can be created to generate dashboards and widgets.

To create the log pipeline, execute the following curl command providing the API Key and the Application Key to invoke the Log Pipeline Rest API.

```
curl --location --request POST 'https://api.datadoghq.com/api/v1/logs/config/pipelines' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'DD_API_KEY:  <API_KEY>\
--header 'DD_APPLICATION_KEY: <APPLICATION_KEY>\ \
--data-raw '{
 "filter": {
   "query": "source:apim_node"
 },
 "is_enabled": true,
 "name": "PreProcessing",
 "processors": [
   {
     "is_enabled": true,
     "grok": {
       "support_rules": "",
       "match_rules": "rules_1 %{date(\"HH:mm:ss,SSS\")}%{regex(\"[^a-zA-Z0-9]*\\\\w+[^a-zA-Z0-9]*\\\\w+[^a-zA-Z0-9]*\\\\w+ \\\\w+ [a-zA-Z0-9]*[^a-zA-Z0-9]*\\\\w+[^a-zA-Z0-9]\")}%{regex(\"\\\\w+\"):eventType}%{regex(\"[^a-zA-Z0-9]* \\\\w+ [^a-zA-Z0-9]\")}%{data::json}\n"
     },
     "name": "Grok Parser",
     "source": "message",
     "samples": ["08:23:34,898 [-] [PassThroughMessageProcessor-188]  INFO ELKCounterMetric apimMetrics: apim:response, properties :{\"apiName\":\"PizzaShackAPI\",\"proxyResponseCode\":200,\"destination\":\"https://localhost:9443/am/sample/pizzashack/v1/api/\",\"apiCreatorTenantDomain\":\"carbon.super\",\"platform\":\"Other\",\"apiMethod\":\"GET\",\"apiVersion\":\"1.0.0\",\"gatewayType\":\"SYNAPSE\",\"apiCreator\":\"admin\",\"responseCacheHit\":false,\"backendLatency\":3,\"correlationId\":\"02951f10-5934-456d-b608-7cd85b3f7c9d\",\"requestMediationLatency\":1,\"keyType\":\"SANDBOX\",\"apiId\":\"af88b5f8-594a-4f57-a729-7eb86b6a63ab\",\"applicationName\":\"DefaultApplication\",\"targetResponseCode\":200,\"requestTimestamp\":\"2022-12-15T02:53:34.894Z\",\"applicationOwner\":\"admin\",\"userAgent\":\"curl\",\"userName\":\"admin@carbon.super\",\"apiResourceTemplate\":\"/menu\",\"responseLatency\":4,\"regionId\":\"default\",\"responseMediationLatency\":0,\"userIp\":\"127.0.0.1\",\"apiContext\":\"/pizzashack/1.0.0\",\"applicationId\":\"87c8da4c-aa3f-43d3-89ac-dc3dc3b19d3e\",\"apiType\":\"HTTP\",\"properties\":{}}"],
     "type": "grok-parser"
   }
 ]
}'

```

After creating the above pipeline, invoke a few APIs through API Manager to generate few Analytics events(both Success and Faulty events have to be generated). 

The published analytics events will be available in `Logs -> Search` view on the DataDog web UI.

#### Step 2.3 - Create Facets and Mesures.

1. For the following attributes, create facets by following this [documentation.](https://docs.datadoghq.com/logs/explorer/facets/#create-facets)

    ```
    apiContext
    apiCreator
    apiName
    apiType
    apiVersion
    apiResourceTemplate
    apiMethod
    applicationName
    applicationOwner
    errorType
    eventType
    Destination
    Platform
    responseCacheHit
    userAgent
    userName
    userIp
    ```

2. Create a measure for following attributes

    ```
    backendLatency - Type Integer - Unit Milliseconds
    responseLatency - Type Integer - Unit Milliseconds
    responseMediationLatency - Type Integer - Unit Milliseconds
    requestMediationLatency - Type Integer - Unit Milliseconds

    targetResponseCode - Type Integer - Unit None
    proxyResponseCode - Type Integer - Unit None
    errorCode - Type Integer - Unit None
    ```

#### Step 2.4 - Import Dashboards

Import the [dashboards.zip]({{base_path}}/assets/attachments/apim-elk/dashboards.zip) following the steps [here.](https://docs.datadoghq.com/dashboards/#copy-import-or-export-dashboard-json)