# Analytics for Choreo Connect

Choreo Connect Analytics provides reports, dashboards, statistics, and graphs for the APIs deployed on Choreo Connect.
WSO2 Choreo Connect has the capability to publish events to the Choreo platform in order to generate analytics. This page describes the feature and explains how the feature could be used to generate useful analytics in order to gain important insights into the APIs deployed on the Choreo Connect. To learn more concepts on analytics, follow the [concepts]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/).


## Configuring Analytics for Choreo Connect

The following steps will describe how to configure Choreo Connect Analytics with Choreo portal.

!!! note 
    Before you begin, make sure to go through [main configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configuration-overview/) and [Configurations for Analytics]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/analytics-configurations/) and familiar with the configurations.

### Step 1 - Set up Analytics

To configure analytics with Choreo,

1. Sign up to [https://console.choreo.dev/login/](https://console.choreo.dev/login/).
2. Go to [https://console.choreo.dev/user-settings/onpremkeys](https://console.choreo.dev/user-settings/onpremkeys) and generate a on-prem-key.
3. Open the `docker-compose.yaml` file located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect` or `CHOREO-CONNECT_HOME/docker-compose/choreo-connect-with-apim` based on your choice on the setup.

    !!! info
        Choreo Connect can be configured to pulish Analytics to Choreo cloud in both [standalone mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-docker/#step-3-start-choreo-connect) and [with Control Plane mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/#step-3-start-choreo-connect-and-api-manager).

4. Find the environment variables section under the `enforcer` and change the below variables.

    ``` yml
    environment:
        ...
        analytics_authURL=https://analytics-event-auth.choreo.dev/auth/v1
        analytics_authToken=<your-on-prem-key>
    ```

5. Now open the `config.toml` located in `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory and find the [Analytics]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/analytics-configurations/) section and enable analytics by using the following configurations.

    ``` toml
    [analytics]
    enabled = true
    [analytics.adapter]
        bufferFlushInterval = "1s"
        bufferSizeBytes = 16384
        gRPCRequestTimeout = "20s"
    [analytics.enforcer]
        [analytics.enforcer.configProperties]
        authURL = "$env{analytics_authURL}"
        authToken = "$env{analytics_authToken}"

        [analytics.enforcer.LogReceiver]
        port = 18090
        maxMessageSize = 1000000000
        maxHeaderLimit = 8192
        #keep alive time of the external authz connection
        keepAliveTime = 600

        [analytics.enforcer.LogReceiver.threadPool]
            coreSize = 10
            maxSize = 100
            #keep alive time of threads in seconds
            keepAliveTime = 600
            queueSize = 1000
    ```

### Step 2 - Try it out

Let's generate some traffic to see the Analytics in Choreo cloud.

1. Deploy your API - Follow [this]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/#step-3-deploy-the-api-in-api-manager) according to your setup.

2. Let's Invoke the API few times - [Invoke the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/#step-4-invoke-the-api)

3. Go to [Choreo Insights](https://console.choreo.dev/insights) to view statistics. 

Here are some of the graphs generated in Choreo cloud.

[![Choreo Analytics Overview]({{base_path}}/assets/img/deploy/choreo-analytics-overview.png)]({{base_path}}/assets/img/deploy/choreo-analytics-overview.png)

[![Choreo Analytics Traffic]({{base_path}}/assets/img/deploy/choreo-analytics-traffic.png)]({{base_path}}/assets/img/deploy/choreo-analytics-traffic.png)

[![Choreo Analytics Latency]({{base_path}}/assets/img/deploy/choreo-analytics-latency.png)]({{base_path}}/assets/img/deploy/choreo-analytics-latency.png)


## ELK Analytics for Choreo Connect

[![Choreo ELK Analytics Data Flow]({{base_path}}/assets/img/deploy/choreo-elk-analytics-data-flow.png)]({{base_path}}/assets/img/deploy choreo-elk-analytics-data-flow.png)

Enforcer component in Choreo Connect can log analytics data to be used by Filebeat in ELK Stack. Data flow for the ELK Analitics can be depicted as given above.

## Setting up

### Step 1 - Configuring Choreo Connect

#### Step 1.1 - Preparing the JAR

Checkout the [wso2/samples-apim](https://github.com/wso2/samples-apim) and build the repo. Go to `analytics-event-publisher/target` directory and copy and paste the generated JAR into `choreo-connect-1.x.x/docker-compose/resources/enforcer/dropins`. This JAR is added to the java class path when the Enforcer starts.

#### Step 1.2 - Configuring the config.toml file
Open the `choreo-connect-1.x.x/docker-compose/choreo-connect(-with-apim)/conf/config.toml` file and update the analytics section according to the below configuration.
``` toml
[analytics]
 enabled = true
    
[analytics.enforcer]
[analytics.enforcer.configProperties]
 type = "elk"
 "publisher.reporter.class" = "org.wso2.am.analytics.publisher.sample.reporter.CustomReporter"
```
If you want to use any other reporter class then you need to compile the new reporter implementation as a JAR file and copy it to `choreo-connect-1.x.x/docker-compose/resources/enforcer/dropins`. Then set the `publisher.reporter.class` to the class name of the new reporter implementation.

#### Step 1.3 - Enabling logs

Update the `choreo-connect-1.x.x/docker-compose/choreo-connect(-with-apim)/conf/log4j2.properties` file as described below:
<br/>

Log to console

1. Add a reporter to the loggers list:
<br/>
```
loggers = reporter, ... (list of other available loggers)
```
2. Add the following configurations after the loggers:
<br/>
```
logger.reporter.name = org.wso2.am.analytics.publisher.sample.reporter
logger.reporter.level = INFO
logger.reporter.additivity = false
logger.reporter.appenderRef.rolling.ref = ENFORCER_CONSOLE
```

Log to file

1. Add `ENFORCER_ANALYTICS` to the appenders list:
<br/>
```
appenders = ENFORCER_ANALYTICS, ... (list of other available appenders)
```
2. Add the following configuration after the appenders:
</br>
```
appender.ENFORCER_ANALYTICS.type = RollingFile
appender.ENFORCER_ANALYTICS.name = ENFORCER_ANALYTICS
appender.ENFORCER_ANALYTICS.fileName = logs/enforcer_analytics.log
appender.ENFORCER_ANALYTICS.filePattern = /logs/enforcer_analytics-%d{MM-dd-yyyy}.log
appender.ENFORCER_ANALYTICS.layout.type = PatternLayout
appender.ENFORCER_ANALYTICS.layout.pattern = [%d] - %m%ex%n
appender.ENFORCER_ANALYTICS.policies.type = Policies
appender.ENFORCER_ANALYTICS.policies.time.type = TimeBasedTriggeringPolicy
appender.ENFORCER_ANALYTICS.policies.time.interval = 1
appender.ENFORCER_ANALYTICS.policies.time.modulate = true
appender.ENFORCER_ANALYTICS.policies.size.type = SizeBasedTriggeringPolicy
appender.ENFORCER_ANALYTICS.policies.size.size=10MB
appender.ENFORCER_ANALYTICS.strategy.type = DefaultRolloverStrategy
appender.ENFORCER_ANALYTICS.strategy.max = 20
appender.ENFORCER_ANALYTICS.filter.threshold.type = ThresholdFilter
appender.ENFORCER_ANALYTICS.filter.threshold.level = DEBUG
```
3. Add a reporter to the loggers list:
</br>
```
loggers = reporter, ... (list of other available loggers)
```
4. Add the following configurations after the loggers:
<br/>
```
logger.reporter.name = org.wso2.am.analytics.publisher.sample.reporter
logger.reporter.level = INFO
logger.reporter.additivity = false
logger.reporter.appenderRef.rolling.ref = ENFORCER_ANALYTICS
```

!!! note 
    If you use a custome reporter class, make sure to update the `logger.reporter.name` property accordingly.

### Step 2 - Setting up the ELK Stack

Follow the steps documented under [Configuring ELK]({{base_path}}/api-analytics/on-prem/elk-installation-guide/#step-3-configure-security-in-elk) to setup following elements in ELK Stack:

1. Elasticsearch 
2. Kibana 
3. Logstash
4. Filebeat
<br/>
Use the following configuration for inputs`filebeat.yml` use the container log files.
```yml
filebeat.inputs:
- type: container
  enabled: true
  paths:
    - /var/lib/docker/containers/*/*.log
  include_lines: ['(apimMetrics):']
```

Publish an API to the Choreo Connect using either using `APIM` or using `APICTL`. Next, invoke few requests (success and failure) and check the Kibana dashboard. You should be able to see the data has been populated to [different dashboards]({{base_path}}/api-analytics/on-prem/elk-installation-guide/#dashboards).

## See Also

- [Publishing Analytics Events to External Systems]({{base_path}}/api-analytics/samples/publishing-analytics-events-to-external-systems)