---
title: Publishing Custom Analytics Events Data - API Manager Documentation 4.0.0
---

# Publishing Custom Analytics Events Data

## Introduction

Instead of publishing already available analytics events data, it is also possible to publish custom analytics data with the existing event schema. This guide will explain the steps required to do it.

!!! Important
    - Note that, support for publishing custom analytics events data has been introduced to WSO2 API Manager 4.0.0 via an U2 update (Update level 130) and is effective from 27th July 2022.
    - You can check if this feature is available in your current pack by viewing the trace logs without adding the jar containing the implemented class as [here]({{base_path}}/api-analytics/samples/publishing-custom-analytics-data/#build-the-project).
    - If the feature is available in the pack you will be able to see a property object named `property` which includes `apiContext` and `userName` as default values.

    ```json
    "properties":{
        "apiContext":"/api/1.0.0",
        "userName":"admin@carbon.super"
    },
    ```

This section will cover the steps required to create a sample and configure the created sample with WSO2 API-M.

## Creating the Sample

You have to create a new `Java/Maven project`. 

There is an already [created sample](https://github.com/wso2/samples-apim/tree/4.0.0/analytics-custom-data-provider) and if you wish to use that sample instead of developing the sample from scratch, then you can ignore the steps of creating the sample and start from [here]({{base_path}}/api-analytics/samples/publishing-custom-analytics-data/#build-the-project).

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

Add dependencies,

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

!!! Info

	- The versions for ${carbon.apimgt.version}, and ${synapse.version} can be found in the jar versions available in the current API Manager 4.0.0 package.
    - Since this feature support available in the latest update levels, you have to follow the below steps to add the required artifacts to the local m2 repository and point it as a repository in pom file.
        1. Find the `org.wso2.carbon.apimgt.gateway` and `org.wso2.carbon.apimgt.common.analytics` jars inside the `<APIM_HOME>/repository/components/plugins` directory in latest U2 updated APIM pack.
        2. Add the above jars to the local m2 manually.
        ```code
        mvn install:install-file -Dfile=<PATH_TO_FILE>/org.wso2.carbon.apimgt.gateway_<COMPENENT_VERSION>.jar -DgroupId=org.wso2.carbon.apimgt -DartifactId=org.wso2.carbon.apimgt.gateway -Dversion=<COMPENENT_VERSION> -Dpackaging=jar
        mvn install:install-file -Dfile=<PATH_TO_FILE>/org.wso2.carbon.apimgt.common.analytics_<COMPENENT_VERSION>.jar -DgroupId=org.wso2.carbon.apimgt -DartifactId=org.wso2.carbon.apimgt.common.analytics -Dversion=<COMPENENT_VERSION> -Dpackaging=jar
        ```
        3. Point local m2 repository in project pom
        ```code
        <repository>
            <id>local-maven-repo</id>
            <url>file://home/user/.m2/repository</url>
        </repository>
        ```
        Follow the URL pattern when providing the repo url

### Implementing Required Class

#### AnalyticsCustomDataProvider Implementation Class

Custom analytics data can be added to the existing event schema with the use of a class of type `AnalyticsCustomDataProvider`. Therefore, it is required to implement a class from the `AnalyticsCustomDataProvider` interface. By overriding the `getCustomProperties` method it is possible to push custom analytics data.

In order to achieve this behavior, create a class implementing the `AnalyticsCustomDataProvider` Interface of `org.wso2.carbon.apimgt.common.analytics.collectors`.

Implementation of this class should look something similar to [this](https://github.com/wso2/samples-apim/blob/4.0.0/analytics-custom-data-provider/src/main/java/org/wso2/carbon/apimgt/gateway/sample/publisher/CustomDataProvider.java).

#### Build the Project

Build the project using,

    mvn clean install

## Configuring the Sample

This section will cover the steps required to configure WSO2 API-M Gateway for the sample created above. The steps covered are adding the .jar file, configuring the deployment.toml file, and enabling the logs.

!!! Warning
    Note that WSO2 API Manager 3.0.0, 3.1.0, 3.2.0, and 4.0.0 are affected by the **Log4j2 zero-day** vulnerability, which has been reported to WSO2 on 10th December 2021. You can mitigate this vulnerability in your product by following our [instructions and guidelines](https://docs.wso2.com/pages/viewpage.action?pageId=180948677).

1. Adding the .jar file.

    Place the created .jar file inside the `wso2am-4.0.0/repository/components/lib` directory.

2. Configuring the deployment.toml file.

    Edit `apim.analytics` configurations in the `deployment.toml` file located inside `wso2am-4.0.0/repository/conf` with the following configuration.

        [apim.analytics]
        enable = true
        properties."publisher.custom.data.provider.class" = "<FullyQualifiedClassNameOfAnalyticsCustomDataProviderImplClass>"
        type = "elk"

    !!! Important
        Type should be given as `elk` as this property value is filtered out in cloud implementation.

3. Enabling Logs

    To [enable trace logs]({{base_path}}/administer/logging-and-monitoring/logging/configuring-logging/#enabling-logs-for-a-component) for the component: `org.wso2.am.analytics.publisher`, edit `log4j2.properties` file located inside `wso2am-4.0.0/repository/conf` directory. 

    a) Add a reporter to the loggers list:

        loggers = org-wso2-analytics-publisher, ...(list of other available loggers)

    b) Add the following configurations after the loggers:

        logger.org-wso2-analytics-publisher.name = org.wso2.am.analytics.publisher
        logger.org-wso2-analytics-publisher.level = TRACE
        logger.org-wso2-analytics-publisher.appenderRef.CARBON_TRACE_LOGFILE.ref = CARBON_TRACE_LOGFILE

4. Now you can trigger an event and check the `<WSO2AM-4.0.0-HOME>/repository/logs/wso2carbon-trace-messages.log` to find the event object passed out from API Manager.

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