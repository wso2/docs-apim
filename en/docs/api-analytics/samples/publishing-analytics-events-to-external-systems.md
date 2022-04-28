---
title: Publishing Analytics Events to External Systems - API Manager Documentation 4.0.0
---

# Publishing Analytics Events to External Systems

## Introduction

WSO2 API Manager allows publishing its analytics data to external systems the same way it publishes the data to the cloud. For that, it is required to create a custom event publisher. This guide will explain and walk through the steps required to implement, deploy and configure a custom event publisher.

For the demonstration purpose, let’s assume ELK as the external system.

## Creating an Event Publisher

This section will guide you through the steps required to create the custom event publisher.

Note:<br />
If you are not interested in creating the custom event publisher from scratch, you can use the already created [sample event publisher](https://github.com/wso2/samples-apim/tree/master/analytics-event-publisher) instead and resume the guide from here.

### Setting up a Maven project

1. Create a new Maven-based Java project.
2. To create the event publisher, this project will use the "[WSO2 Analytics Publisher](https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/am/analytics/publisher/)" library which is available in the WSO2 Nexus repository. To add it as a dependency, open the `pom.xml` file of your project and add the following two sections.

Add wso2-nexus repository to `pom.xml`:

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

Add dependency:

    <dependency>
        <groupId>org.wso2.am.analytics.publisher</groupId>
        <artifactId>org.wso2.am.analytics.publisher.client</artifactId>
        <version>1.0.1</version>
    </dependency>

### Implementing Required Classes

To implement the rest of the functionality, we need to implement two interfaces from the above dependency, i.e. `CounterMetric` and `MetricReporter`.

**org.wso2.am.analytics.publisher.reporter.CounterMetric:**<br/>
A class of type `CounterMetric` can be used to log accumulated analytics data. By overriding its `incrementCount()` method, it is possible to log the required analytics data. 

**org.wso2.am.analytics.publisher.reporter.MetricReporter:**<br/>
A class of type `MetricReporter` can be used to publish analytics data to an external party. By overriding its `createCounterMetric()` method, it is possible to return an instance of `CounterMetric` implementation which is mentioned above. This allows logging accumulated analytics data.

1. Create a new class implementing the `org.wso2.am.analytics.publisher.reporter.CounterMetric` interface and override its methods. A sample implementation can be found at [here](https://github.com/wso2/samples-apim/blob/master/analytics-event-publisher/src/main/java/org.wso2.am.analytics.publisher.sample.reporter/LogCounterMetric.java).
2. Create a new class implementing the `org.wso2.am.analytics.publisher.reporter.MetricReporter` interface and override its methods. A sample implementation can be found at [here](https://github.com/wso2/samples-apim/blob/master/analytics-event-publisher/src/main/java/org.wso2.am.analytics.publisher.sample.reporter/CustomReporter.java).

### Building the Project

Once the above steps are completed, build the project by executing the following command from the project root directory.

    mvn clean install

## Deploying the Event Publisher

Once the project is implemented and built, the resulting library needs to be deployed within WSO2 API Manager and configured. This section will guide you through the steps required to deploy and configure the above-created library in WSO2 API Manager Gateway and/or Choreo Connect. 



---

## Configuring the Sample

This section will cover the steps required to configure WSO2 API Gateway and Choreo Connect for the sample created above. The steps covered are adding the .jar file, configuring the deployment.toml file, and enabling the logs.

```text tab="API Manager Gateway"
1. Copy the JAR file to <WSO2_AM_HOME>/repository/components/lib directory.
2. Open <WSO2_AM_HOME>/repository/conf/deployment.toml file in a text editor and modify the "apim.analytics" section as follows.

    [apim.analytics]
    enable = true
    properties."publisher.reporter.class" = "<FullyQualifiedClassNameOfMetricReporterImplClass>"
    logger.reporter.level = "INFO"

3. Open <WSO2_AM_HOME>/repository/conf/log4j2.properties file in a text editor and do the following modifications.

    a) Add reporter to the loggers list.

        loggers = reporter, ...(list of other available loggers)

    b) Add the following configurations after the loggers.

        logger.reporter.name = <PackageName>
        logger.reporter.level = INFO

```

```text tab="Choreo Connect"
1. Copy the JAR file to choreo-connect-1.0.0/docker-compose/resources/enforcer/dropins directory.
2. Open choreo-connect-1.0.0/docker-compose/choreo-connect-with-apim/conf/config.toml file in a text editor and modify the "analytics" section as follows.

    [analytics]
        enabled = true
        [analytics.enforcer]
        [analytics.enforcer.configProperties]
            authURL = "$env{analytics_authURL}"
            authToken = "$env{analytics_authToken}"
            "publisher.reporter.class" = "org.wso2.am.analytics.publisher.sample.reporter.CustomReporter"

3. Open choreo-connect-1.0.0/docker-compose/choreo-connect-with-apim/conf/log4j2.properties file in a text editor and do the following modifications.

    a) Add an appender to the appenders list,

        appenders = ENFORCER_ANALYTICS, ...(list of other available appenders)

    b) Add the following configurations after the appenders,

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

    d) Add the following configurations after the loggers:

        logger.reporter.name = org.wso2.am.analytics.publisher.sample.reporter
        logger.reporter.level = INFO
        logger.reporter.additivity = false
        logger.reporter.appenderRef.rolling.ref = ENFORCER_ANALYTICS

```

## Visualizing Analytics Data

After publishing the analytics data, the next step is to visualize them in a manner in which the end-user can get more information out of it. WSO2 API Manager logs are structured in a way that allows us to easily plug them into a visualization tool to visualize them. 

This section will guide you through the steps required to visualize the published data in a data visualization platform. For this guide, ELK is used as the data visualization platform.

### Setting Up ELK

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

Add bellow configurations to feed WSO2 API-M logs in to Filebeat.

```text tab="API-M Gateway"
Open the <FILEBEAT_HOME>/config/filebeat.yml file in a text editor and modify it as follows. Replace <APIM_HOME> with the location of your API Manager root directory.

    filebeat.inputs:
    - type: log
    enabled: true
    paths:
        - /<APIM_HOME>/repository/logs/wso2carbon.log
```

```text tab="Choreo Connect"
Modify the filebeat configuration file as follows. Log data is available in `enforcer_analytics.log`.

    filebeat.inputs:
    - type: log
    enabled: true
    paths:
        - /home/wso2/logs/enforcer_analytics.log
```

Set up assets as mentioned in [here]((https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#setup-assets)). In case of a failure with the above command, run the below command to set up assets.

    filebeat -e

[Start](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#start) Filebeat.

### View Analytics Data on Kibana

Filebeat comes with pre-built Kibana dashboards and UIs for visualizing log data. Follow the steps below to configure the visualization.

1. [Launch Kibana and discover](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#view-data) log data.

Once you have followed and completed the above steps successfully, you will be able to visualize log data as follows.

[![Logs listed in kibana]({{base_path}}/assets/img/analytics/samples/logs-listed-in-kibana.png)]({{base_path}}/assets/img/analytics/samples/logs-listed-in-kibana.png)

#### Filtering Total Analytics Traffic

The total analytics traffic can be visualized by applying a filter as follows.

Replace `<MetricReporterImplClass>` with the class name given to the MetricReporter implementation class that you have created with your sample.

[![Total analytics traffic filter]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic-filter.png)]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic-filter.png)

Once this filter is applied you will be able to visualize analytics traffic as shown below.

[![Filtered total Analytics traffic]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic.png)]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic.png)

#### Filtering Analytics Traffic for a Specific API

The analytics traffic for a specific API can be visualized by applying a filter on top of the above filter as follows.

Replace `<API_Name>` with the name of the API in which you want to visualize traffic.

[![Analytics traffic for a specific API filter]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api-filter.png)]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api-filter.png)

Once this filter is applied you will be able to visualize analytics traffic for a specific API as shown below. And you can notice that both the filters are applied on logs.

[![Filtered Analytics traffic for a specific API]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api.png)]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api.png)
