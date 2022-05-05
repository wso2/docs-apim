# Publishing Analytics Events to External Systems

WSO2 API Manager allows publishing its analytics data to external systems in the same way it publishes the data to the cloud. For this purpose you need to create a custom event publisher. This guide will explain and walk through the steps required to implement, deploy, and configure a custom event publisher.

For demonstration purposes, let’s assume ELK as the external system.

## Step 1 - Create an Event Publisher

Follow the instructions below to create the custom event publisher.

!!! Note
    If you are not interested in creating the custom event publisher from scratch, you can use the already created [sample event publisher](https://github.com/wso2/samples-apim/tree/master/analytics-event-publisher) instead and resume the guide from here.

### Step 1.1 - Set up a Maven project

1. Create a new Maven-based Java project.

2. Add the required dependency.
     
     The Maven-based Java project uses the [WSO2 Analytics Publisher](https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/am/analytics/publisher/) library, which is available in the WSO2 Nexus repository. Therefore, you need to add this library as a dependency.

     1. Navigate and open the `<PROJECT_DIR>/pom.xml` file.
     
     2. Define the `wso2-nexus` repository in the `pom.xml` file.

         ```
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
         ```

     3.  Add the dependency in the `pom.xml` file.

        ```
          <dependency>
              <groupId>org.wso2.am.analytics.publisher</groupId>
              <artifactId>org.wso2.am.analytics.publisher.client</artifactId>
              <version>1.0.1</version>
          </dependency>
        ```

### Step 1.2 - Implement the required classes

You need to implement two interfaces from the above dependency, (i.e., `CounterMetric` and `MetricReporter`) in order to implement the rest of the functionality.

- **org.wso2.am.analytics.publisher.reporter.CounterMetric**

     You can use the `CounterMetric` class type to log accumulated analytics data. You can override its `incrementCount()` method to log the required analytics data.

- **org.wso2.am.analytics.publisher.reporter.MetricReporter**

     You can use the `MetricReporter` class type to publish analytics data to an external party. You can override its `createCounterMetric()` method to return an instance of the `CounterMetric` implementation which is mentioned above. This allows logging accumulated analytics data.

---

1. Create a new class implementing the `org.wso2.am.analytics.publisher.reporter.CounterMetric` interface and override its methods. 
     
     You can find a sample implementation [here](https://github.com/wso2/samples-apim/blob/master/analytics-event-publisher/src/main/java/org.wso2.am.analytics.publisher.sample.reporter/LogCounterMetric.java).

2. Create a new class implementing the `org.wso2.am.analytics.publisher.reporter.MetricReporter` interface and override its methods. 

     You can find a sample implementation [here](https://github.com/wso2/samples-apim/blob/master/analytics-event-publisher/src/main/java/org.wso2.am.analytics.publisher.sample.reporter/CustomReporter.java).

### Step 1.3 - Build the project

1. Navigate to the project root directory.
2. Build the project by executing the following command.

     ```
     mvn clean install
     ```

## Step 2 - Deploy the Event Publisher

After the project is implemented and built, you need to deploy and configure the resulting library within WSO2 API Manager. This section will guide you through the steps required to deploy and configure the above-created library in WSO2 API Manager Gateway and/or Choreo Connect.

Follow the instructions below to configure WSO2 API Gateway and Choreo Connect for the sample created above:

??? info "API Manager Gateway"
    
    Follow the instructions below to configure WSO2 API Gateway for the sample created above:
    1. Copy the JAR file to the `<API-M_HOME>/repository/components/lib` directory.
    2. Open the `<API-M_HOME>/repository/conf/deployment.toml` file in a text editor and modify the `apim.analytics` section as follows:
       
         ```
         [apim.analytics]
         enable = true
         properties."publisher.reporter.class" = "<FullyQualifiedClassNameOfMetricReporterImplClass>"
         logger.reporter.level = "INFO"
         ```

    3. Open the `<API-M_HOME>/repository/conf/log4j2.properties` file in a text editor and do the following modifications.

         1. Add `reporter` to the loggers list.

             ```
             loggers = reporter, ...(list of other available loggers)
             ```

         2. Add the following configurations after the loggers.

             ```
             logger.reporter.name = <PackageName>
             logger.reporter.level = INFO
             ```

??? info "Choreo Connect"
    Follow the instructions below to configure Choreo Connect for the sample created above:
    1. Copy the JAR file to the `choreo-connect-1.0.0/docker-compose/resources/enforcer/dropins` directory.
    2. Open the `choreo-connect-1.0.0/docker-compose/choreo-connect-with-apim/conf/config.toml` file in a text editor and modify the `analytics` section as follows:

         ```
          [analytics]
              enabled = true
              [analytics.enforcer]
              [analytics.enforcer.configProperties]
                  authURL = "$env{analytics_authURL}"
                  authToken = "$env{analytics_authToken}"
                  "publisher.reporter.class" = "org.wso2.am.analytics.publisher.sample.reporter.CustomReporter"
        ```

    3. Open the `choreo-connect-1.0.0/docker-compose/choreo-connect-with-apim/conf/log4j2.properties` file in a text editor and do the following modifications.

         1. Add an appender to the appenders list.

             ```
             appenders = ENFORCER_ANALYTICS, ...(list of other available appenders)
             ```

         2. Add the following configurations after the appenders.

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

         3. Add `reporter` to the loggers list.

              ```
              loggers = reporter, ...(list of other available loggers)
              ```

         4. Add the following configurations after the loggers.

              ```
              logger.reporter.name = org.wso2.am.analytics.publisher.sample.reporter
              logger.reporter.level = INFO
              logger.reporter.additivity = false
              logger.reporter.appenderRef.rolling.ref = ENFORCER_ANALYTICS
              ```


## Step 3 - Visualize analytics data

After publishing the analytics data, the next step is to visualize them in a manner in which the end-user can get more information out of it. WSO2 API Manager logs are structured in a way that allows us to easily plug them into a visualization tool to visualize them. 

This section will guide you through the steps required to visualize the published data in a data visualization platform. For this guide, ELK is used as the data visualization platform.

### Step 3.1 - Set up ELK

#### Step 3.1.1 - Install the Elasticsearch

1. [Install Elasticsearch](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#install-elasticsearch) based on your operating system.

2. Make sure Elasticsearch is [up and running](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#_make_sure_elasticsearch_is_up_and_running).

#### Step 3.1.2 - Install Kibana

1. [Install Kibana](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#install-kibana) based on your operating system.

2. [Launch](https://www.elastic.co/guide/en/elastic-stack-get-started/7.13/get-started-elastic-stack.html#_launch_the_kibana_web_interface) the Kibana web interface.

#### Step 3.1.3 - Install Filebeat

1. [Install Filebeat](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#installation) based on your operating system.

2. [Connect](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#set-connection) to Elastic Stack.

#### Step 3.1.4 - Collect Log Data

1. Add the following configurations to feed WSO2 API-M logs in to Filebeat.

    ??? info "API-M Gateway"
         
         Open the `<FILEBEAT_HOME>/config/filebeat.yml` file in a text editor and modify it as follows. 
         
         Replace `<API-M_HOME>` with the location of your API Manager root directory.

        ```
          filebeat.inputs:
          - type: log
          enabled: true
          paths:
              - /<API-M_HOME>/repository/logs/wso2carbon.log
        ```

    ??? info "Choreo Connect"
         Modify the Filebeat configuration file as follows:
         
         The log data is available in `enforcer_analytics.log`.

         ```
         filebeat.inputs:
         - type: log
         enabled: true
         paths:
             - /home/wso2/logs/enforcer_analytics.log
         ```

2. [Set up assets]((https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#setup-assets)). 
         
    !!! tip
        In case of a failure with the above command, run the following command to set up assets.

        ```
        filebeat -e
        ```

3. [Start](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#start) Filebeat.

### Step 3.2 - View analytics data on Kibana

Filebeat comes with pre-built Kibana dashboards and UIs for visualizing log data. 

#### Step 3.2.1 - Configure the visualization

     [Launch Kibana and discover](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#view-data) log data.

     Once you have followed and completed the above steps successfully, you will be able to visualize log data as follows.

     [![Logs listed in kibana]({{base_path}}/assets/img/analytics/samples/logs-listed-in-kibana.png)]({{base_path}}/assets/img/analytics/samples/logs-listed-in-kibana.png)

#### Step 3.2.2 - Filter total analytics traffic

The total analytics traffic can be visualized by applying a filter as follows:

Replace `<MetricReporterImplClass>` with the class name given to the `MetricReporter` implementation class that you have created with your sample.

[![Total analytics traffic filter]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic-filter.png)]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic-filter.png)

After applying this filter you will be able to visualize analytics traffic as shown below.

[![Filtered total analytics traffic]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic.png)]({{base_path}}/assets/img/analytics/samples/total-analytics-traffic.png)

#### Step 3.2.3 - Optionally, filter analytics traffic for a specific API

The analytics traffic for a specific API can be visualized by applying a filter on top of the above filter as follows:

Replace `<API_Name>` with the name of the API in which you want to visualize traffic.

[![Analytics traffic for a specific API filter]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api-filter.png)]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api-filter.png)

After applying this filter you will be able to visualize the analytics traffic for a specific API as shown below. In the logs you will notice that both the filters are applied.

[![Filtered analytics traffic for a specific API]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api.png)]({{base_path}}/assets/img/analytics/samples/analytics-traffic-for-a-specific-api.png)
