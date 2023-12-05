# Publish Custom Attributes With Analytics

Choreo Connect provides default set of attributes with the analytics data when an API invocation happens. Additional to that, users
can add custom analytics data with an analytics event due to this feature. If there are specific request headers, response 
headers, response trailers relevant to the event, users can retrieve those values and use with Chore Connect analytics. 
This guide will explain the steps required to do it.

!!! attention "Update Level 14"
    This feature is available only as an update. After the Update of level 1.0.0.14 (released on 31st October 2022) and further.
    For more information regarding Choreo Connect updates, refer to the documentation available in [here.]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/update-choreo-connect/)

!!! note
    **Request headers** (headers sent to the upstream), **Response headers** (headers coming from the upstream) and **Response 
    trailers** can only use with this feature.

## Creating The Custom Analytics Data Provider JAR

You need to create a new `Java Maven` project to obtain this JAR.

There is an existing sample project in [here](https://github.com/wso2/product-microgateway/tree/main/samples/analytics-custom-data-provider).
If you wish to use that sample instead of developing the sample from scratch, then you can ignore the steps of creating 
the sample and start from [here](../../../../deploy-on-gateway/choreo-connect/analytics/pulbish-custom-analytics-attributes/#build-the-project-jar-addition-to-the-enforcer).

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
        <artifactId>org.wso2.carbon.apimgt.gateway</artifactId>
        <version>${carbon.apimgt.version}</version>
    </dependency>
    <dependency>
        <groupId>org.wso2.carbon.apimgt</groupId>
        <artifactId>org.wso2.carbon.apimgt.common.analytics</artifactId>
        <version>${carbon.apimgt.version}</version>
    </dependency>
    ```

!!! Info

	- If you need above mentioned JARs, you can find them from [here](https://github.com/wso2/product-microgateway/tree/main/samples/analytics-custom-data-provider/jars).
    - When working with above sample project, you have to follow the below steps to add the required artifacts to the local m2 repository and point it as a repository in pom file.
        1. Find the `org.wso2.carbon.apimgt.gateway` and `org.wso2.carbon.apimgt.common.analytics` .jar files [here](https://github.com/wso2/product-microgateway/tree/main/samples/analytics-custom-data-provider/jars).
        2. Add the above .jar files to the local m2 repository manually.
        ```code
        mvn install:install-file -Dfile=<PATH_TO_FILE>/org.wso2.carbon.apimgt.gateway_<COMPENENT_VERSION>.jar -DgroupId=org.wso2.carbon.apimgt -DartifactId=org.wso2.carbon.apimgt.gateway -Dversion=<COMPENENT_VERSION> -Dpackaging=jar
        mvn install:install-file -Dfile=<PATH_TO_FILE>/org.wso2.carbon.apimgt.common.analytics_<COMPENENT_VERSION>.jar -DgroupId=org.wso2.carbon.apimgt -DartifactId=org.wso2.carbon.apimgt.common.analytics -Dversion=<COMPENENT_VERSION> -Dpackaging=jar
        ```
        3. Point to the local m2 repository in the project pom file.
        ```code
        <repository>
            <id> local-maven-repo </id>
            <url> file://home/user/.m2/repository </url>
        </repository>
        ```
        Follow the same URL pattern when providing the repo url.

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

1. In order to log the custom attributes for the event occurrences, you need to add Custom Reporter JAR to the dropins folder.
You can follow the `Step 1.1` explained [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configure-analytics/#step-11-compile-the-reporter-implementation}) 
to obtain the JAR. Similar to the above after obtaining the JAR mount it to the `enforcer/dropins` folder.

   1. Configure the `log4j2.properties` file with the following configurations.
      1. Add a new logger to the Enforcer by adding the following configuration

          ```bash
          logger.org-wso2-analytics-publisher.name = org.wso2.am.analytics.publisher
          logger.org-wso2-analytics-publisher.level = TRACE
          logger.org-wso2-analytics-publisher.appenderRef.CARBON_TRACE_LOGFILE.ref = ENFORCER_ACCESS_LOG
          ```

      2. Append the newly added logger as shown below.
      
         ```bash
             loggers = org-wso2-analytics-publisher, other_available_loggers...
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
