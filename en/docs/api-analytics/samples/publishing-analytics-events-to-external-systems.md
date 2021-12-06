---
title: Publishing Analytics Events to External Systems - API Manager Documentation 4.0.0
---

# Publishing Analytics Events to External Systems

## Introduction

Instead of publishing analytics events to the cloud, It is also possible to log the same events and publish them to external systems. This guide will explain the steps required to do it. For demonstration purposes, we have selected ELK as the external system.

This section will cover the steps required to create a sample, configure the created sample with WSO2 API-M or Choreo Connect, and then publish it to an external System (ELK).

## Creating the Sample

You have to create a new `Java/Maven project`. 

With the use of `WSO2 Analytics Publisher` extension which is available at `WSO2 nexus` repository it is possible to create the sample. Created sample can be used to log and publish analytics events to external systems.

There is an already [created sample](https://github.com/wso2/samples-apim/tree/master/analytics-event-publisher) and if you wish to use that sample instead of developing the sample from scratch, then you can ignore the steps of creating the sample and start from [here]({{base_path}}/api-analytics/samples/publishing-analytics-events-to-external-systems/#build-the-project).

This section will cover how to configure the `pom.xml`, class implementations and building the created sample.

### Configuring pom.xml

Add wso2-nexus repository to `pom.xml`,

    <repository>
        <id>wso2-nexus</id>
        <name>WSO2 internal Repository</name>
        <url>https://maven.wso2.org/nexus/content/groups/wso2-public/</url>
        <releases>
            <enabled>true</enabled>
            <updatePolicy>daily</updatePolicy>
            <checksumPolicy>ignore</checksumPolicy>
        </releases>
    </repository>

Add dependency,

    <dependency>
        <groupId>org.wso2.am.analytics.publisher</groupId>
        <artifactId>org.wso2.am.analytics.publisher.client</artifactId>
        <version>1.0.1</version>
    </dependency>

### Implementing Required Classes

#### CounterMetric Implementation Class

Accumulated analytics data can be logged with the use of a class of type `CounterMetric`. Therefore, it is required to implement a class from the `CounterMetric` interface. By overriding the `incrementCount` method it is possible to log analytics data.

In order to achieve this behavior, create a class implementing the `CounterMetric` Interface of `org.wso2.am.analytics.publisher.reporter` and override its methods.

Implementation of this class should look something similar to [this](https://github.com/wso2/samples-apim/blob/master/analytics-event-publisher/src/main/java/org.wso2.am.analytics.publisher.sample.reporter/LogCounterMetric.java).

#### MetricReporter Implementation Class

Analytics data can be published to outside only through a class of type `MetricReporter`.
Therefore, it is required to implement a class from `MetricReporter` Interface.
By overriding the `createCounterMetric` Method of `MetricReporter` interface it is possible to return an instance of `CounterMetercImplClass` created with the above step. This gives the opportunity to log analytics data accumulated.

In order to achieve this behavior, create a class implementing the `MetricReporter` Interface of `org.wso2.am.analytics.publisher.reporter` and override its methods.

Implementation of this class should look something similar to [this](https://github.com/wso2/samples-apim/blob/master/analytics-event-publisher/src/main/java/org.wso2.am.analytics.publisher.sample.reporter/CustomReporter.java).

#### Build the Project

Build the project using,

    mvn clean install

## Configuring the Sample

This section will cover the steps required to configure WSO2 API Gateway and Choreo Connect for the sample created above. The steps covered are adding the .jar file, configuring the deployment.toml file, and enabling the logs.

```text tab="API-M Gateway"
i) Adding the .jar file.

    Place the created .jar file inside the `wso2am-4.0.0/repository/components/lib` file.

ii) Configuring deployment.toml

    Edit `apim.analytics` configurations in the `deployment.toml` located inside `wso2am-4.0.0/repository/conf` with the following configuration.

        [apim.analytics]
        enable = true
        properties."publisher.reporter.class" = "<FullyQualifiedClassNameOfMetricReporterImplClass>"
        logger.reporter.level = "INFO"

iii) Enabling Logs

    To enable logging for a reporter, edit `log4j2.properties` file located inside `wso2am-4.0.0/repository/conf` 

    a) Add reporter to the loggers list,

        loggers = reporter, ...(list of other available loggers)

    b) Add bellow configurations after the loggers,

        logger.reporter.name = <PackageName>
        logger.reporter.level = INFO

```

```text tab="Choreo Connect"
i) Adding the jar

    Place the created jar file inside `choreo-connect-1.0.0/docker-compose/resources/enforcer/dropins`

ii) Configuring config.toml

    Edit `analytics` configurations in the `config.toml` located inside `choreo-connect-1.0.0/docker-compose/choreo-connect-with-apim/conf` with the following configuration.

    [analytics]
        enabled = true
        [analytics.enforcer]
        [analytics.enforcer.configProperties]
            authURL = "$env{analytics_authURL}"
            authToken = "$env{analytics_authToken}"
            "publisher.reporter.class" = "org.wso2.am.analytics.publisher.sample.reporter.CustomReporter"

iii) Enabling Logs

    To enable logging for reporter, edit `log4j2.properties` file located inside `choreo-connect-1.0.0/docker-compose/choreo-connect-with-apim/conf` 

    a) Add an appender to the appenders list,

        appenders = ENFORCER_ANALYTICS, ...(list of other available appenders)

    b) Add bellow configurations after the appenders,

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

    c) Add reporter to the loggers list,

        loggers = reporter, ...(list of other available loggers)

    d) Add bellow configurations after the loggers,

        logger.reporter.name = org.wso2.am.analytics.publisher.sample.reporter
        logger.reporter.level = INFO
        logger.reporter.additivity = false
        logger.reporter.appenderRef.rolling.ref = ENFORCER_ANALYTICS

```

## Visualizing Logs

WSO2 API-M logs are structured in a way that we can easily plug them into a log visualization tool in order to visualize them. As a result, this gives the capability to monitor analytics traffic for a particular API. For this purpose, ELK is selected.

### Configuring ELK

#### Installing Elasticsearch

[Install Elasticsearch](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#install-elasticsearch) according to your operating system.

Make sure Elasticsearch is [up and running](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#_make_sure_elasticsearch_is_up_and_running).

#### Installing Kibana

[Install Kibana](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#install-kibana) according to your operating system.

[Launch](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#_launch_the_kibana_web_interface) the Kibana web interface.

#### Installing Filebeat

[Install Filebeat](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#installation) according to your operating system.

[Connect](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#set-connection) to Elastic Stack.

#### Collecting Log Data

Add bellow configurations to feed WSO2 API-M logs in to Filebeat,

```text tab="API-M Gateway"
Replace `<API-M HOME>` with the location of your `API-M Home` directory.

    filebeat.inputs:
    - type: log
    enabled: true
    paths:
        - /<API-M HOME>/repository/logs/wso2carbon.log
```

```text tab="Choreo Connect"
Log data is available in `enforcer_analytics.log`

    filebeat.inputs:
    - type: log
    enabled: true
    paths:
        - /home/wso2/logs/enforcer_analytics.log
```

[Set up](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#setup-assets) assets

In case of a failure with the above command, use below to set up assets,

    filebeat -e

[Start](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#start) Filebeat

### View Data on Kibana

Filebeat comes with pre-built Kibana dashboards and UIs for visualizing log data.

[Launch Kibana and discover](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#view-data) log data.

Once you have followed and completed the above steps successfully, you will be able to visualize log data as shown below,

[![Logs listed in kibana]({{base_path}}/assets/img/analytics/samples/logs-listed-in-kibana.png)]({{base_path}}/assets/img/analytics/samples/logs-listed-in-kibana.png)

#### Filtering Total Analytics Traffic

It is possible to view the analytics traffic by applying a filter as shown below,

Replace `<MetricReporterImplClass>` with the class name given to the MetricReporter implementation class that you have created with your sample.

[![Total analytics traffic filter]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic-filter.png)]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic-filter.png)

Once this filter is applied you will be able to visualize analytics traffic as shown below,

[![Filtered total Analytics traffic]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic.png)]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic.png)

#### Filtering Analytics Traffic for a Specific API

It is possible to view the analytics traffic for a specific API by applying a filter on top of the above filter as shown below,

Replace `<API_Name>` with the name of the API in which you want to visualize traffic.

[![Analytics traffic for a specific API filter]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api-filter.png)]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api-filter.png)

Once this filter is applied you will be able to visualize analytics traffic for a specific API as shown below. And you can notice that both the filters are applied on logs.

[![Filtered Analytics traffic for a specific API]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api.png)]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api.png)
