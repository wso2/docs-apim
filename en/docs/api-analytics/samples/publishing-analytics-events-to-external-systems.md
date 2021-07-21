---
title: Publishing Analytics Events to External Systems - API Manager Documentation 4.0.0
---

# Publishing Analytics Events to External Systems

## Introduction

Instead of publishing analytics events to the cloud, It is also possible to log the same events and publish them to external systems. This guide will explain the steps required to do it. For demonstration purposes, we have selected ELK as the external system.

This section will cover the steps required to create a sample, configure the created sample with WSO2 API-M and publish them to an external System (ELK).

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

Implementation of this class should look something similar to this,

    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.wso2.am.analytics.publisher.exception.MetricReportingException;
    import org.wso2.am.analytics.publisher.reporter.CounterMetric;
    import org.wso2.am.analytics.publisher.reporter.MetricEventBuilder;
    import org.wso2.am.analytics.publisher.reporter.MetricSchema;
    import org.wso2.am.analytics.publisher.reporter.cloud.DefaultResponseMetricEventBuilder;

    import java.util.Map;

    public class <CounterMetricImplClassName> implements CounterMetric {

        private static final Logger log = LoggerFactory.getLogger(<CounterMetricImplClassName>.class);
        private String name;
        private MetricSchema schema;

        public <CounterMetricImplClassName>(String name, MetricSchema schema) {
            this.name = name;
            this.schema = schema;
        }

        @Override
        public int incrementCount(MetricEventBuilder metricEventBuilder) throws MetricReportingException {
            Map<String, Object> properties = metricEventBuilder.build();
            log.info("Metric Name: " + name.replaceAll("[\r\n]", "") + " Metric Value: "
                + properties.toString().replaceAll("[\r\n]", ""));
            return 0;
        }

        @Override
        public String getName() {
            return this.name;
        }

        @Override
        public MetricSchema getSchema() {
        return this.schema;
        }

        @Override
        public MetricEventBuilder getEventBuilder() {
        return new DefaultResponseMetricEventBuilder();
        }
    }

#### MetricReporter Implementation Class

Analytics data can be published to outside only through a class of type `MetricReporter`.
Therefore, it is required to implement a class from `MetricReporter` Interface.
By overriding the `createCounterMetric` Method of `MetricReporter` interface it is possible to return an instance of `CounterMetercImplClass` created with the above step. This gives the opportunity to log analytics data accumulated.

In order to achieve this behavior, create a class implementing the `MetricReporter` Interface of `org.wso2.am.analytics.publisher.reporter` and override its methods.

Implementation of this class should look something similar to this,

    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.wso2.am.analytics.publisher.exception.MetricCreationException;
    import org.wso2.am.analytics.publisher.reporter.CounterMetric;
    import org.wso2.am.analytics.publisher.reporter.MetricReporter;
    import org.wso2.am.analytics.publisher.reporter.MetricSchema;
    import org.wso2.am.analytics.publisher.reporter.TimerMetric;
    
    import java.util.Map;
    
    public class <MetricReporterImplClass> implements MetricReporter {
    
        private static final Logger log = LoggerFactory.getLogger(<MetricReporterImplClass>.class);
    
        public <MetricReporterImplClass>(Map<String, String> properties) {
            log.info("Successfully initialized");
        }
    
        @Override
        public CounterMetric createCounterMetric(String name, MetricSchema metricSchema) throws MetricCreationException {
            <CounterMetricImplClassName> counterMetric = new <CounterMetricImplClassName>(name, metricSchema);
            return counterMetric;
        }
    
        @Override
        public TimerMetric createTimerMetric(String s) {
            return null;
        }
        @Override
        public Map<String, String> getConfiguration() {
            return null;
        }
    }

#### Build the Project

Build the project using,

    mvn clean install

## Configuring the Sample

This section will cover the steps required to configure WSO2 API-M for the sample created above. The steps covered are adding the jar, configuring deployment.toml and enabling the logs.

### Adding the jar

Place the created jar file inside `wso2am-4.0.0/repository/components/lib`

### Configuring deployment.toml

Edit `apim.analytics` configurations in the `deployment.toml` located inside `wso2am-4.0.0/repository/conf` with the following configuration.

    [apim.analytics]
    enable = true
    properties."publisher.reporter.class" = "<FullyQualifiedClassNameOfMetricReporterImplClass>"
    logger.reporter.level = "INFO"

### Enabling Logs

To enable logging for reporter, edit `log4j2.properties` file located inside `wso2am-4.0.0/repository/conf` 

Add reporter to the loggers list,

    loggers = reporter, ...(list of other available loggers)

Add bellow configurations after the loggers,

    logger.reporter.name = <PackageName>
    logger.reporter.level = INFO

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

Replace `<API-M HOME>` with the location of your `API-M Home` directory.

    filebeat.inputs:
    - type: log
    enabled: true
    paths:
        - /<API-M HOME>/repository/logs/wso2carbon.log

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
