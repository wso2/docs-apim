# Elastic Stack-Based Operational Analytics for Micro Integrator

As an alternative for WSO2 EI Analytics, from version 4.2.0 onwards, Micro Integrator now supports publishing operational analytics for Elastic Stack. As a part of the feature, WSO2 will provide some dashboards that include operational data from the following entities.

- APIs
- Sequences
- Endpoints
- Inbound Endpoints
- Proxy Services

!!! note 
    Enabling Elasticsearch analytics will disable data publishing to WSO2 EI Analytics. 

## Required components from Elastic Stack

The following components are required from the Elastic stack to enable operational analytics on WSO2 Micro Integrator.

- Kibana
- Elasticsearch
- Logstash
- Filebeats

## Analytics dataflow

Micro Integrator will publish the analytics data to a log file (synapse-analytics.log). This log file will be read using Filebeat, and a JSON file will be sent to Elasticsearch through Logstash with the data required for analytics.

Example Analytic log line:

``` log
12:30:57,396 [-] [message-flow-reporter-1-tenant--1234]  INFO ElasticStatisticsPublisher SYNAPSE_ANALYTICS_DATA {"serverInfo":{"hostname":"sulochana","serverName":"localhost","ipAddress":"192.168.1.5","id":"localhost"},"timestamp":"2022-08-18T07:00:57.346Z","schemaVersion":1,"payload":{"metadata":{},"entityType":"API","failure":false,"latency":0,"messageId":"urn:uuid:0541cbe6-0424-4b91-9461-7550b278673c","correlation_id":"b187ecca-100c-4af5-854e-6759a364f6c7","apiDetails":{"method":"POST","apiContext":"/hotels","api":"hotels","transport":"http","subRequestPath":"/cancel"},"faultResponse":false,"entityClassName":"org.apache.synapse.api.API"}}
```

## Setup procedure

The setup procedure consists of 3 main stages:

- Setup Elastic Stack
- Configure Micro Integrator
- Configure Integration Projects to support custom analytics (Optional)

### Setup Elastic Stack

In this stage, we download and install the components required from Elastic stack. 

!!! note
    Note that this guide is to set up the ELK stack at an entry-level, and in a production environment, it is highly recommended to configure each component separately for security, performance, and high availability.

### Install Elasticsearch

1. [Install Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/8.3/install-elasticsearch.html) according to your operating system.

2. Make sure Elasticsearch is [up and running](https://www.elastic.co/guide/en/elasticsearch/reference/8.3/starting-elasticsearch.html).


### Install Kibana.

1. [Install Kibana](https://www.elastic.co/guide/en/kibana/8.3/install.html) according to your operating system.

2. [Launch the Kibana web interface](https://www.elastic.co/guide/en/kibana/8.3/start-stop.html).

3. Log in to the Kibana dashboards.

4. [Create a user](https://www.elastic.co/guide/en/kibana/8.3/tutorial-secure-access-to-kibana.html#_users) with <b>cluster privileges :manage_index_templates, monitor </b> and <b>index privileges: create_index, create, write </b> to wso2-mi-analytics-* indices pattern.The credentials of this user need to be included in the Logstash configuration.

### Installing Logstash

1. [Install Logstash](https://www.elastic.co/guide/en/logstash/8.3/installing-logstash.html) according to your operating system.

2. Use the following [configuration file]({{base_path}}/assets/attachments/mi-elk/config.conf) when starting Logstash. Update the `logstash_internal_user_password` and `elasticsearch_home` placeholders in the configuration file.

    ``` conf
        input {
            beats {
                port => 5044
            }
        }

        filter {
            grok {
                match => ["message", "%{GREEDYDATA:UNWANTED}\ SYNAPSE_ANALYTICS_DATA %{GREEDYDATA:analyticJson}"]
            }
            json {
                source => "analyticJson"
                target => "analytic"
            }

            mutate {
                copy => {"[analytic][payload][entityType]" => "[@metadata][appNameIndex]"}
            }

            mutate {
                remove_field => [ "UNWANTED", "analyticJson", "message" ]
            }

            mutate {
                lowercase => ["[@metadata][appNameIndex]"]
            }
        }
        output {
            elasticsearch {
                hosts => ["https://localhost:9200"]
                user => "logstash_username"
                password => "<logstash_user_password>"
                index => "wso2-mi-analytics-%{[@metadata][appNameIndex]}"
                ssl => true
                ssl_certificate_verification => true
                cacert => "<elasticsearch_home>/config/certs/http_ca.crt"       
            }
        }

    ```

### Installing Filebeat

1. [Install Filebeat](https://www.elastic.co/guide/en/beats/filebeat/8.3/filebeat-installation-configuration.html) according to your operating system.

2. Download the [sample configuration file]({{base_path}}/assets/attachments/mi-elk/filebeat.yml) and replace <MI_HOME> with the Micro Integrator’s home directory and <LOGSTASH_URL> with Logstash URL.

    ``` yaml
    filebeat.inputs:
    - type: filestream
      id: wso2mi-analytics
      enabled: true
      paths:
        - <MI_HOME>/repository/logs/synapse-analytics.log

    output.logstash:
      # The Logstash hosts
      hosts: ["<LOGSTASH_URL>:5044"]

    ```

3. Make sure Filebeat is [up and running](https://www.elastic.co/guide/en/beats/filebeat/8.3/filebeat-installation-configuration.html#start).

### Import Dashboards and DataViews

1. Download the [dashboards.ndjson]({{base_path}}/assets/attachments/mi-elk/dashboards.ndjson) file.

2. On Kibana UI go to **Stack Management** → **Saved objects** and **Import** the downloaded file. This should import the following objects into Kibana.

### Configure Security in ELK

ElasticSearch supports basic authentication via an internal user store. To set up basic authentication in ElasticSearch and Kibana, refer to the [ElasticSearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html).

## Configure Micro Integrator

To enable operational analytics, you must update the deployment.toml file with the required configurations and add a new log appender so that the analytics data will be stored in a dedicated log file.

### Enabling statistics for artifacts

You must enable statistics for the integration artifacts you wish to monitor. If you want to collect statistics for all your integration artifacts, be sure to add the `flow.statistics.capture_all` parameter to the deployment.toml file

``` toml
[mediation]
flow.statistics.enable=true
flow.statistics.capture_all=true
```

### Enable Analytics

Add the following configuration to the deployment.toml file to enable analytics, which includes custom analytics. 

``` toml
[analytics]
enabled=true
```

You can have more control over the analytics data with the following additional configurations.

``` toml
[analytics]
enabled = true
publisher = "log"
id = "wso2mi_server_1234"
prefix = "SYNAPSE_ANALYTICS_DATA"
api_analytics.enabled = true
proxy_service_analytics.enabled = true
sequence_analytics.enabled = true
endpoint_analytics.enabled = true
inbound_endpoint_analytics.enabled = true

```

|Config Key|Data Type|Default Value|Description|
|:----|:----|:----|:----|
|api_analytics.enabled|bool|TRUE|If set to false, analytics for APIs will not be published|
|proxy_service_analytics.enabled|bool|TRUE|If set to false, analytics for Proxy Services will not be published|
|sequence_analytics.enabled|bool|TRUE|If set to false, analytics for Sequences will not be published|
|endpoint_analytics.enabled|bool|TRUE|If set to false, analytics for Endpoints will not be published|
|inbound_endpoint_analytics.enabled|bool|TRUE|If set to false, analytics for Inbound Endpoints will not be published|
|prefix|string|SYNAPSE_ANALYTICS_DATA|This string will be used as a prefix when Elasticsearch analytics are being published. The purpose of this prefix is to distinguish log lines that hold analytics data from others. If you override this default value, you will have to update the Logstash and Filebeat configuration files accordingly.|
|enabled|bool|FALSE|If set to true, Elasticsearch service will be enabled|
|id|string|hostname|An identifier that will be published with the analytic|

### Creating Log Appender

Open the `<MI_HOME>/repository/conf` directory and edit the `log4j2.properties` file following the instructions given below.

1. Add `ELK_ANALYTICS_APPENDER` to the appenders list.

    ```
    appenders = ELK_ANALYTICS_APPENDER,.... (list of other available appenders)
    ```

2. Add the following configuration after the appenders:

    !!! note

        Any changes to the layout pattern may require changes in the Logstash configuration file. 

    The `synapse-analytics.log` file is rolled each day or when the log size reaches the limit of 1000 MB by default. Furthermore, only ten revisions will be kept, and older revisions will be deleted automatically. You can change these configurations by updating the configurations provided in step 2 above.

    ``` log
    appender.ELK_ANALYTICS_APPENDER.type = RollingFile
    appender.ELK_ANALYTICS_APPENDER.name = ELK_ANALYTICS_APPENDER
    appender.ELK_ANALYTICS_APPENDER.fileName = ${sys:carbon.home}/repository/logs/synapse-analytics.log
    appender.ELK_ANALYTICS_APPENDER.filePattern = ${sys:carbon.home}/repository/logs/synapse-analytics-%d{MM-dd-yyyy}-%i.log
    appender.ELK_ANALYTICS_APPENDER.layout.type = PatternLayout
    appender.ELK_ANALYTICS_APPENDER.layout.pattern = %d{HH:mm:ss,SSS} [%X{ip}-%X{host}] [%t] %5p %c{1} %m%n
    appender.ELK_ANALYTICS_APPENDER.policies.type = Policies
    appender.ELK_ANALYTICS_APPENDER.policies.time.type = TimeBasedTriggeringPolicy
    appender.ELK_ANALYTICS_APPENDER.policies.time.interval = 1
    appender.ELK_ANALYTICS_APPENDER.policies.time.modulate = true
    appender.ELK_ANALYTICS_APPENDER.policies.size.type = SizeBasedTriggeringPolicy
    appender.ELK_ANALYTICS_APPENDER.policies.size.size=1000MB
    appender.ELK_ANALYTICS_APPENDER.strategy.type = DefaultRolloverStrategy
    appender.ELK_ANALYTICS_APPENDER.strategy.max = 10
    ```

3. Add ELKAnalytics to the loggers list:

    ``` log
    loggers = ELKAnalytics, ...(list of other available loggers)
    ```

4. Add the following configurations after the loggers.

    ``` log
    logger.ELKAnalytics.name = org.wso2.micro.integrator.analytics.messageflow.data.publisher.publish.elasticsearch.ElasticStatisticsPublisher
    logger.ELKAnalytics.level = DEBUG
    logger.ELKAnalytics.additivity = false
    logger.ELKAnalytics.appenderRef.ELK_ANALYTICS_APPENDER.ref = ELK_ANALYTICS_APPENDER
    ```



