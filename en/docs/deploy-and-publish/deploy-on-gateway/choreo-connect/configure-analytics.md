# Configuring Analytics for Choreo Connect

Choreo Connect is capable of publishing fine-grained analytics events which can then be used to generate reports, dashboards, statistics, and graphs for the APIs deployed on Choreo Connect.
Choreo Connect can not only publish analytics data to the Choreo platform but also to platforms that support the ELK stack. The following subsections will explain in detail how you could enable and configure analytics for each platform to gain insights into the services exposed via Choreo Connect.

!!! tip
    To learn more on the analytics-related concepts, see [Choreo Connect Analytics - Concepts]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/).

Configure Analytics for Choreo Connect using one of the following methods:

- [Choreo Portal Analytics for Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configure-analytics/#configuring-choreo-portal-analytics)
- [ELK Analytics for Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configure-analytics/#configuring-elk-analytics)

## Configuring Choreo Portal Analytics

Follow the instructions below to configure Choreo Portal Analytics for Choreo Connect.

### Step 1 - Set up Analytics

Follow the instructions below to configure analytics with Choreo:

1. Sign in to <a href="https://console.choreo.dev/login/">https://console.choreo.dev/login/</a>.
2. Go to <a href="https://console.choreo.dev/user-settings/onpremkeys">https://console.choreo.dev/user-settings/onpremkeys</a> and generate an on-prem-key.
3. Open the `docker-compose.yaml` file, which based on your setup is located in the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect` or `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim` directory.

    !!! info
        You can configure Choreo Connect to publish Analytics to the Choreo cloud via the [standalone mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-docker/#step-3-start-choreo-connect) or via the [with Control Plane mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/#step-3-start-choreo-connect-and-api-manager).

4. Locate the environment variables section under the `enforcer` and change the following variables.

    ``` yml
    environment:
        ...
        analytics_authURL=https://analytics-event-auth.choreo.dev/auth/v1
        analytics_authToken=<your-on-prem-key>
    ```

5. Enable analytics before starting Choreo Connect. First of all, navigate to the configuration file location. {!includes/deploy/cc-configuration-file.md!}

    1. Locate the [Analytics]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/analytics-configurations/) section.

    1. Enable analytics by using the following configurations. 

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

Follow the instructions below to generate some traffic in order to be able to view the Analytics in the Choreo cloud:

1. Deploy your API.
    
     [Deploy your API in API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/#step-3-deploy-the-api-in-api-manager) based on your setup.

2. Invoke the API a few times.

     For more information, see [Invoke the API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/#step-4-invoke-the-api).

3. Go to <a href="https://console.choreo.dev/insights">Choreo Insights</a> to view the statistics. 

     Here are some of the graphs generated in the Choreo cloud.

     [![Choreo Analytics Overview]({{base_path}}/assets/img/deploy/choreo-analytics-overview.png)]({{base_path}}/assets/img/deploy/choreo-analytics-overview.png)

     [![Choreo Analytics Traffic]({{base_path}}/assets/img/deploy/choreo-analytics-traffic.png)]({{base_path}}/assets/img/deploy/choreo-analytics-traffic.png)

     [![Choreo Analytics Latency]({{base_path}}/assets/img/deploy/choreo-analytics-latency.png)]({{base_path}}/assets/img/deploy/choreo-analytics-latency.png)

##  Configuring ELK Analytics

Follow the instructions below to configure ELK Analytics for Choreo Connect:

[![Choreo ELK Analytics Data Flow]({{base_path}}/assets/img/deploy/choreo-elk-analytics-data-flow.png)]({{base_path}}/assets/img/deploy choreo-elk-analytics-data-flow.png)

The Enforcer component in Choreo Connect can log analytics-related data to be used by Filebeat in ELK Stack. Data flow for the ELK Analytics can be depicted as given above.

### Step 1 - Configure Choreo Connect

#### Step 1.1 - Configure the config.toml file

1. {!includes/deploy/cc-configuration-file.md!}

2. Change the analytics section based on the following configurations.

	The following configuration will enable the default reporter class (`org.wso2.am.analytics.publisher.reporter.elk.ELKMetricReporter`).

    ``` toml
    [analytics]
       enabled = true
       type = "ELK"
    ```
   
!!! note "If you want to use a custom reporter class"
    If you want to use any other reporter class, follow the instructions below:
     
    1. Compile the new custom reporter implementation as a JAR file.</br>
    2. Mount it to the `/home/wso2/lib/dropins` directory within the Enforcer by adding the JAR file to the choreo-connect-1.x.x/docker-compose/resources/enforcer/dropins directory.</br>

        !!! note 
            If you use Choreo Connect with Helm Charts, please refer to the documentation [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/production-deployment-guideline/#mount-files-into-the-dropins-directory-optional) to add a JAR file into the dropins directory.
    3. Set the value of the `publisher.reporter.class` property to the class name of the new reporter implementation in the `config.toml` file as follows:
    	
        ```toml
        [analytics]
           enabled = true
           type = "ELK"

        [analytics.enforcer]
           [analytics.enforcer.configProperties]
              "publisher.reporter.class" = "org.wso2.am.analytics.publisher.sample.reporter.CustomReporter"
        ```

#### Step 1.2 - Enable logs

The following are the two options that are available to retrieve the analytics logs.

- <a href="#logtoconsole">Log to console</a>
- <a href="#logtofile">Log to file</a>

Update the `choreo-connect-1.x.x/docker-compose/choreo-connect(-with-apim)/conf/log4j2.properties` file based on the selected analytics logs retrival method as follows in order to configure the Filebeat agent.

<a name="logtoconsole">
<b>Log to console</b>
</a>

1. Add a reporter to the loggers list.

     ```
     loggers = reporter, ... (list of other available loggers)
     ```

2. Add the following configurations after the loggers.

    ```
    logger.reporter.name = org.wso2.am.analytics.publisher.reporter.elk
    logger.reporter.level = INFO
    logger.reporter.additivity = false
    logger.reporter.appenderRef.rolling.ref = ENFORCER_CONSOLE
    ```

<a name="logtofile">
<b>Log to file</b>
</a>

1. Add `ENFORCER_ANALYTICS` to the appenders list.

    ```
    appenders = ENFORCER_ANALYTICS, ... (list of other available appenders)
    ```

2. Add the following configuration after the appenders.

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

3. Add a reporter to the loggers list.

    ```
    loggers = reporter, ... (list of other available loggers)
    ```

4. Add the following configurations after the loggers.

    ```
    logger.reporter.name = org.wso2.am.analytics.publisher.reporter.elk
    logger.reporter.level = INFO
    logger.reporter.additivity = false
    logger.reporter.appenderRef.rolling.ref = ENFORCER_ANALYTICS
    ```

!!! note 
    If you use a custom reporter class, update the `logger.reporter.name` property accordingly.

### Step 2 - Set up the ELK Stack

1. [Configure and setup the following elements in ELK Stack]({{base_path}}/api-analytics/on-prem/elk-installation-guide/#step-3-configure-security-in-elk).

     - Elasticsearch 
     - Kibana 
     - Logstash
     - Filebeat

2. Configure the log file input source.

     1. Open the `filebeat.yml` file.
     2. Configure the container log files as the input source.

        ```yml
          filebeat.inputs:
          - type: container
            enabled: true
            paths:
              - /var/lib/docker/containers/*/*.log
            include_lines: ['(apimMetrics):']
        ```

### Step 3 - Publish an API

Publish an API to Choreo Connect either via API Manager or apictl.

### Step 4 - Invoke requests

Invoke a few requests (success and failure).

### Step 5 - View the dashboards

Check the Kibana dashboard. 

You will notice that the populated data appears in [different dashboards]({{base_path}}/api-analytics/on-prem/elk-installation-guide/#dashboards).


## See Also

- [Publishing Analytics Events to External Systems]({{base_path}}/api-analytics/samples/publishing-analytics-events-to-external-systems)
