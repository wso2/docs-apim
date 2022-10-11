---
title: Publishing Custom Analytics Events Data - API Manager Documentation 4.2.0
---

# Publishing Custom Analytics Events Data

## Introduction

Instead of publishing already available analytics events data, it is also possible to publish custom analytics data with the existing event schema. This guide will explain the steps required to do it.

This section will cover the steps required to create a sample and configure the created sample with WSO2 API-M.

## Creating the Sample

You have to create a new `Java/Maven project`. 

There is an already [created sample](https://github.com/wso2/samples-apim/tree/master/analytics-custom-data-provider) and if you wish to use that sample instead of developing the sample from scratch, then you can ignore the steps of creating the sample and start from [here]({{base_path}}/api-analytics/samples/publishing-custom-analytics-data/#build-the-project).

This section will cover how to configure the `pom.xml`, class implementations and building the created sample.

### Configuring pom.xml

Add the `wso2-nexus` repository to the `pom.xml` file.

```code
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

Add dependencies,

```code
    <dependency>
        <groupId>org.wso2.carbon.apimgt</groupId>
        <artifactId>org.wso2.carbon.apimgt.gateway</artifactId>
        <version>${carbon.apimgt.version}</version>
    </dependency>
    <dependency>
        <groupId>org.wso2.carbon.apimgt</groupId>
        <artifactId>org.wso2.carbon.apimgt.common.analytics</artifactId>
        <version>${carbon.apimgt.version}</version>
    </dependency>
    <dependency>
        <groupId>org.apache.synapse</groupId>
        <artifactId>synapse-extensions</artifactId>
        <version>${synapse.version}</version>
    </dependency>
    <dependency>
        <groupId>org.apache.synapse</groupId>
        <artifactId>synapse-core</artifactId>
        <version>${synapse.version}</version>
        <exclusions>
            <exclusion>
                <groupId>org.apache.axis2</groupId>
                <artifactId>axis2-codegen</artifactId>
            </exclusion>
            <exclusion>
                <groupId>org.wso2.orbit.com.github.fge</groupId>
                <artifactId>json-schema-validator-all</artifactId>
            </exclusion>
        </exclusions>
    </dependency>
```

!!! Info

	- The versions for {carbon.apimgt.version} and ${synapse.version} can be found in the jar versions available in the current API Manager package.

### Implementing Required Class

#### AnalyticsCustomDataProvider Implementation Class

Custom analytics data can be added to the existing event schema with the use of a class of type `AnalyticsCustomDataProvider`. Therefore, it is required to implement a class from the `AnalyticsCustomDataProvider` interface. By overriding the `getCustomProperties` method it is possible to push custom analytics data.

In order to achieve this behavior, create a class implementing the `AnalyticsCustomDataProvider` Interface of `org.wso2.carbon.apimgt.common.analytics.collectors`.

Implementation of this class should look something similar to [this](https://github.com/wso2/samples-apim/blob/master/analytics-custom-data-provider/src/main/java/org/wso2/carbon/apimgt/gateway/sample/publisher/CustomDataProvider.java).

#### Build the Project

Build the project using,

```code
    mvn clean install
```

## Configuring the Sample

This section will cover the steps required to configure WSO2 API-M Gateway for the sample created above. The steps covered are adding the .jar file, configuring the deployment.toml file, and enabling the logs.

1. Add the .jar file created in the target directory after building the project.

    Place the created .jar file inside the `wso2am-4.2.0/repository/components/lib` directory.

2. Configure the deployment.toml file.

    Edit the `apim.analytics` configurations in the `deployment.toml` file located inside `wso2am-4.2.0/repository/conf` with the following configuration.

```code
        [apim.analytics]
        enable = true
        properties."publisher.custom.data.provider.class" = "<FullyQualifiedClassNameOfAnalyticsCustomDataProviderImplClass>"
        type = "elk"
```

This configuration will be used when engaging the custom data provider class.

!!! Important
    Type should be given as `elk` as this property value is filtered out in cloud implementation.

3. Enabling Logs

    To [enable trace logs]({{base_path}}/administer/logging-and-monitoring/logging/configuring-logging/#enabling-logs-for-a-component) for the component: `org.wso2.am.analytics.publisher`, edit `log4j2.properties` file located inside `wso2am-4.2.0/repository/conf` directory. 

    1. Add new publisher to the loggers list:

    ```code
        loggers = org-wso2-analytics-publisher, ...(list of other available loggers)
    ```

    2. Add the following configurations after the loggers:

    ```code
        logger.org-wso2-analytics-publisher.name = org.wso2.am.analytics.publisher
        logger.org-wso2-analytics-publisher.level = TRACE
        logger.org-wso2-analytics-publisher.appenderRef.CARBON_TRACE_LOGFILE.ref = CARBON_TRACE_LOGFILE
    ```

4. Now you can trigger an event and check the `<WSO2AM-4.2.0-HOME>/repository/logs/wso2carbon-trace-messages.log` to find the event object passed out from API Manager.

```log
TRACE {org.wso2.am.analytics.publisher.client.EventHubClient} - [{ Cloud-Analytics-Queue-Worker-pool-2-thread-1 }] - 
 Adding event: 
 {
    "apiName":"API1",
    "proxyResponseCode":200,
    "destination":"https://run.mocky.io/v3/d14fad1d-d57b-41bc-8be3-146b6aaddfaf",
    "apiCreatorTenantDomain":"carbon.super",
    "platform":"Linux",
    "apiMethod":"GET",
    "apiVersion":"2.0.0",
    "gatewayType":"SYNAPSE",
    "apiCreator":"admin",
    "responseCacheHit":false,
    "backendLatency":1866,
    "correlationId":"00a94b54-5579-4f5d-95c1-4bd909fd4c20",
    "requestMediationLatency":578,
    "keyType":"SANDBOX",
    "apiId":"fd5a22ee-144f-4fc1-9f22-ce5ff0382023",
    "applicationName":"AppUser",
    "targetResponseCode":200,
    "requestTimestamp":"2022-07-18T06:49:19Z",
    "applicationOwner":"admin",
    "userAgent":"Chrome",
    "eventType":"response",
    "apiResourceTemplate":"/test",
    "properties":{
         "tokenIssuer":"https://localhost:9443/oauth2/token",
         "apiContext":"/api1/2.0.0",
         "userName":"admin@carbon.super"
    },
    "responseLatency":2446,
    "regionId":"default",
    "responseMediationLatency":2,
    "userIp":"127.0.0.1",
    "applicationId":"5d6d0135-810a-4b4e-8f9a-45187e943fff",
    "apiType":"HTTP"
 }
```