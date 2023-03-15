# Publish Custom Attributes With Analytics

Choreo Connect provides default set of attributes with the analytics data when an API invocation happens. In addition to that, users
can add custom analytics data with an analytics event due to this feature. If there are specific request headers, response
headers, and response trailers relevant to the event, users can retrieve those values and use them with Choreo Connect analytics.
This guide will explain the steps required to do it.

!!! note
    This feature is only available with **ELK based Analytics**. Only **Request headers** (headers sent to the upstream), **Response headers** (headers coming from the upstream), and **Response trailers** can be used with this feature.

## Creating The Custom Analytics Data Provider JAR

You need to create a new `Java Maven` project to obtain this JAR.

There is an existing sample project available [here](https://github.com/wso2/product-microgateway/tree/main/samples/analytics-custom-data-provider).
If you wish to use that sample instead of developing the sample from scratch, you can ignore the steps of creating
the sample and start from [here]({{base_path}}/deploy-on-gateway/choreo-connect/analytics/publish-custom-analytics-attributes/#build-the-project-jar-addition-to-the-enforcer).

### Configuring the pom.xml file

1. Add the wso2-nexus repository to the pom.xml file.

    ```xml
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
2. Add relevant dependencies.

    ```xml
    <dependency>
        <groupId>org.wso2.carbon.apimgt</groupId>
        <artifactId>org.wso2.carbon.apimgt.common.analytics</artifactId>
        <version>${carbon.apimgt.version}</version>
    </dependency>
    ```

!!! Info

	- You need to add `org.wso2.carbon.apimgt.common.analytics_<COMPENENT_VERSION>.jar` to the local m2 mannually and provide path to the local m2 as mentioned below.
        1. Add the above .jar files to the local m2 manually.
        ```code
        mvn install:install-file -Dfile=<PATH_TO_FILE>/org.wso2.carbon.apimgt.common.analytics_<COMPENENT_VERSION>.jar -DgroupId=org.wso2.carbon.apimgt -DartifactId=org.wso2.carbon.apimgt.common.analytics -Dversion=<COMPENENT_VERSION> -Dpackaging=jar
        ```
        2. Point local m2 repository in project pom
        ```code
        <repository>
            <id> local-maven-repo </id>
            <url> file://home/user/.m2/repository </url>
        </repository>
        ```
        Follow the same URL pattern when providing the repository URL.

### Implementing the required class

#### AnalyticsCustomDataProvider Implementation Class

Analytics with custom attributes feature can be customized by implementing the `AnalyticsCustomDataProvider` interface.
Therefore, it is required to implement a class from the `AnalyticsCustomDataProvider` interface. By overriding the
`getCustomProperties` method it is possible to push custom analytics data. From Choreo Connect analytics implementation,
all the header values (request, response headers, response trailers) relevant to the request will be sent in a `HashMap`.
Therefore, by processing it you can obtain the required headers.

### Build the project JAR addition to the Enforcer

- Build the project using the following command.

    ```bash
    mvn clean install
    ```

- Obtain the relevant JAR from target folder and mount it to the `{CC_HOME}/resources/enforcer/dropins` folder.

## Creating The Custom Reporter JAR to log analytics data

1. In order to log the custom attributes for the event occurrences, you need to add the Custom Reporter JAR to the `dropins` folder.
   You can follow the `Step 1.1` explained [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configure-analytics/#step-11-compile-the-reporter-implementation})
   to obtain the JAR. Similar to the above after obtaining the JAR mount it to the `enforcer/dropins` folder.

    1. Configure the `log4j2.properties` file with the following configurations.
        1. Add a new logger to the Enforcer by adding the following configuration.

            ```bash
            logger.org-wso2-analytics-publisher.name = org.wso2.am.analytics.publisher
            logger.org-wso2-analytics-publisher.level = TRACE
            logger.org-wso2-analytics-publisher.appenderRef.CARBON_TRACE_LOGFILE.ref = ENFORCER_ACCESS_LOG
            ```

        2. Append the newly added logger as indicated below.

           ```bash
           loggers = org-wso2-analytics-publisher, other_available_loggers...
           ```

    2. Update the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect(-with-apim)/conf/config.toml` file with the following configurations.

        ```
        [analytics]
            enabled = true
            type = "ELK"
        [analytics.adapter.customProperties]
            enabled = true
            requestHeaders = ["request_headers_to_pass_from_router_to_enforcer"]
            responseHeaders = ["response_headers_to_pass_from_router_to_enforcer"]
            responseTrailers = ["response_trailers_to_pass_from_router_to_enforcer"]
        [analytics.enforcer]
            [analytics.enforcer.configProperties]
            "publisher.custom.data.provider.class" = "fully qualified class name of the customDataProvider"
        ```

## Obtaining Custom Attributes with Analytics

1. Enable Choreo Connect analytics.
2. Initiate an event to publish analytics data.
3. In the Enforcer logs you will see the relevant attribute related to the API invocation under the `properties` field.

    ```bash
      choreo-connect-with-apim-enforcer-1  | ... Info -
      {
         "apiName":"TestAPI",
         "proxyResponseCode":401,
         "errorType":"AUTH",
         .
         .
         .
         "errorMessage":"AUTHENTICATION_FAILURE",
         "eventType":"fault",
         "regionId":"UNKNOWN",
         "applicationId":"UNKNOWN",
         "apiType":"HTTP",
         "properties":{
            "user-agent":"curl/7.83.0"
         }
      }
    ```
