# Setting up Logging in API Manager

Logging is one of the most important aspects of a production-grade server. A properly configured logging system is vital for identifying errors, security threats, and usage patterns.

WSO2 API Manager uses various types of logs to track real-time internal and external activities. Separate log files are created for each of those log types in the `<APIM_HOME>/repository/logs` directory. The following illustrates the log types supported by the WSO2 API-M and how those logs can be configured.

## Carbon Logs

WSO2 API Manager is shipped with the log4j2 logging capabilities that generate logs for administrative and server-side activities. By default, Carbon Logs are persisted in the `wso2carbon.log` file, which is located in thee `<APIM_HOME>/repository/logs` directory. You can configure the details that are captured in this log file by configuring the `<APIM_HOME>/repository/conf/log4j2.properties` file.

!!! text "Java Logging and Log4j integration"
    In addition to the logs from libraries that use Log4j, all logs from libraries such as, Tomcat and Hazelcast that use Java logging framework are also visible in the same log files. That is, when Java logging is enabled in Carbon, only the Log4j appenders will write to the log files. If the Java Logging Handlers have logs, these logs will be delegated to the log events of the corresponding Log4j appenders. A Pub/Sub registry pattern implementation has been used in the latter mentioned scenario to plug the handlers and appenders. 
    
### Configuring Carbon Logs

The following is the default configuration for Carbon Logs and the default values can be changed by manually updating the log4j2.properties file.

```
appender.CARBON_LOGFILE.type = RollingFile
appender.CARBON_LOGFILE.name = CARBON_LOGFILE
appender.CARBON_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/wso2carbon.log
appender.CARBON_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2carbon-%d{MM-dd-yyyy}.log
appender.CARBON_LOGFILE.layout.type = PatternLayout
appender.CARBON_LOGFILE.layout.pattern = TID: [%tenantId] [%appName] [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
appender.CARBON_LOGFILE.policies.type = Policies
appender.CARBON_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
appender.CARBON_LOGFILE.policies.time.interval = 1
appender.CARBON_LOGFILE.policies.time.modulate = true
appender.CARBON_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
appender.CARBON_LOGFILE.policies.size.size=10MB
appender.CARBON_LOGFILE.strategy.type = DefaultRolloverStrategy
appender.CARBON_LOGFILE.strategy.max = 20
appender.CARBON_LOGFILE.filter.threshold.type = ThresholdFilter
appender.CARBON_LOGFILE.filter.threshold.level = DEBUG

appenders = CARBON_LOGFILE, CARBON_CONSOLE, AUDIT_LOGFILE, ATOMIKOS_LOGFILE, CARBON_TRACE_LOGFILE, CARBON_MEMORY, 
DELETE_EVENT_LOGFILE, TRANSACTION_LOGFILE
```
   
The log growth of Carbon Logs can be managed using the configurations mentioned in the [Managing log growth]({{base_path}}/administer/product-administration/monitoring/logging/managing-log-growth) guide.
   
### Enable logs for a component

Follow the instructions below to enable logs for a given service component available in WSO2 API Manager.

1. Open the `APIM_HOME>/repository/conf/log4j2.properties` file.
2. Add a new logger specifying the component name that you need to enable logs and the [log level](#setting-the-log-levels) as shown below.

    ``` tab="Format"
    logger.<logger_name>.name = <component_name>
    logger.<logger_name>.level = <log_level>
    ```

    ``` tab="Example"
    logger.org-wso2-carbon-user-core.name = org.wso2.carbon.user.core
    logger.org-wso2-carbon-user-core.level = DEBUG
    ```

3.  Append the newly added logger name to the `loggers` configuration, which is a comma separated list of all active loggers.

    ``` tab="Format"
    loggers = <logger_name>, trace-messages, org-apache-coyote,com-hazelcast
    ```

    ``` tab="Example"
    loggers = org-wso2-carbon-user-core, trace-messages, org-apache-coyote,com-hazelcast
    ```

### Enable logs for a component via the UI

!!! note
    You need to get the [latest product updates for your product]({{base_path}}/administer/updating-wso2-api-manager/) to use this feature in the current version of WSO2 API-M. This feature is available as a product update in WSO2 API-M 3.1.0 from September 19, 2020 onwards.

    !!! warning
        Note that you can deploy updates in a production environment only if you have a valid subscription with WSO2. Read more about [WSO2 Updates](https://wso2.com/updates).

Follow the instructions below to enable logs for a given service component available in WSO2 API Manager.

1. Navigate to the Carbon console [https://localhost:9443/carbon](https://localhost:9443/carbon) and sign in with **`admin/admin`** as the credentials.

2. Go to **Configure** -> **Logging**
                                                 
     [![Logger Carbon UI]({{base_path}}/assets/img/administer/logging.png)]({{base_path}}/assets/img/administer/logging.png)

3. Add a new logger specifying the logger name, logger class name, and log level that you need to enable logs as shown below and click **Update**.

     [![Add Logger Carbon UI]({{base_path}}/assets/img/administer/add-logger.png)]({{base_path}}/assets/img/administer/add-logger.png)

     After you add the logger, it will be shown on the logger page as shown below.
     
     [![List Logger Carbon UI]({{base_path}}/assets/img/administer/list-logger.png)]({{base_path}}/assets/img/administer/list-logger.png)

4. Optionally, update the log level OR disable the logs.

     Navigate to the specific logger and change the log level as shown below.

     [![Update Logger Carbon UI]({{base_path}}/assets/img/administer/update-logger.png)]({{base_path}}/assets/img/administer/update-logger.png)


### Setting the log levels

The log level can be set specifically for each appender in the `log4j2.properties` file by setting the threshold value. If a log level is not specifically defined for an appender as explained below, the root log level (INFO) will apply to all appenders by default.

For example, shown below is how the log level is set to DEBUG for the `CARBON_LOGFILE` appender:

```bash
appender.CARBON_LOGFILE.filter.threshold.level = DEBUG
```

Listed below are the log levels that can be configured:

| **Level** | **Description**                                                                                                                                                                                                                                                                     |
|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| OFF   | The highest possible log level. This is intended for disabling logging.                                                                                                                                                                                                         |
| FATAL | Indicates server errors that cause premature termination. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                          |
| ERROR | Indicates other runtime errors or unexpected conditions. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                           |
| WARN  | Indicates the use of deprecated APIs, poor use of API, possible errors, and other runtime situations that are undesirable or unexpected but not necessarily wrong. These logs are expected to be immediately visible on the command line that you used for starting the server. |
| INFO  | Indicates important runtime events, such as server startup/shutdown. These logs are expected to be immediately visible on the command line that you used for starting the server. It is recommended to keep these logs to a minimum.                                           |
| DEBUG | Provides detailed information on the flow through the system. This information is expected to be written to logs only. Generally, most lines logged by your application should be written as DEBUG logs.                                                                        |
| TRACE | Provides additional details on the behavior of events and services. This information is expected to be written to logs only.          

## Gateway Wire Logs

Gateway Wire Logs can be configured to monitor the HTTP message flow through the API Gateway. Wire logs allow you to track the request headers, request payloads, response headers, response payloads, etc. of incoming and outgoing HTTP traffic. 

!!!Warning
    Please note that wire logs should be enabled for troubleshooting purposes only. It is not recommended to run production systems with wire logs enabled.
    
In order to read the wire logs, you must first identify the message direction.

<table>
    <tr>
        <td><b>DEBUG - wire >></b></td>
        <td>Represents the message coming into the API Gateway from the wire.</td>
    </tr>
    <tr>
        <td><b>DEBUG - wire <<</b></td>
        <td>Represents the message that goes to the wire from the API Gateway.</td>
    </tr>
</table>  

In a single roundtrip of an API request/response, you can observe the following message flows via the wire log.

-   Incoming request to the API Gateway from the API client (>>).
-   Outgoing request from the API Gateway to the actual backend (<<).
-   Incoming response from the actual backend to the API Gateway (>>).
-   Outgoing response from the API Gateway to the API client (<<).

The following is a sample Gateway Wire Log for an API request. 

```yaml
[2019-12-12 17:30:08,091] DEBUG - wire HTTPS-Listener I/O dispatcher-5 >> "GET /helloWorld/1.0.0 HTTP/1.1[\r][\n]"
[2019-12-12 17:30:08,093] DEBUG - wire HTTPS-Listener I/O dispatcher-5 >> "Host: localhost:8243[\r][\n]"
[2019-12-12 17:30:08,094] DEBUG - wire HTTPS-Listener I/O dispatcher-5 >> "User-Agent: curl/7.54.0[\r][\n]"
[2019-12-12 17:30:08,095] DEBUG - wire HTTPS-Listener I/O dispatcher-5 >> "accept: */*[\r][\n]"
[2019-12-12 17:30:08,096] DEBUG - wire HTTPS-Listener I/O dispatcher-5 >> "Authorization: Bearer 07f6b26d-0f8d-312a-8d38-797e054566cd[\r][\n]"
[2019-12-12 17:30:08,097] DEBUG - wire HTTPS-Listener I/O dispatcher-5 >> "[\r][\n]"
[2019-12-12 17:30:08,105] DEBUG - wire HTTP-Sender I/O dispatcher-1 << "GET /v2/5df22aa131000084009a30a9 HTTP/1.1[\r][\n]"
[2019-12-12 17:30:08,106] DEBUG - wire HTTP-Sender I/O dispatcher-1 << "accept: */*[\r][\n]"
[2019-12-12 17:30:08,107] DEBUG - wire HTTP-Sender I/O dispatcher-1 << "Host: www.mocky.io[\r][\n]"
[2019-12-12 17:30:08,108] DEBUG - wire HTTP-Sender I/O dispatcher-1 << "Connection: Keep-Alive[\r][\n]"
[2019-12-12 17:30:08,109] DEBUG - wire HTTP-Sender I/O dispatcher-1 << "User-Agent: Synapse-PT-HttpComponents-NIO[\r][\n]"
[2019-12-12 17:30:08,110] DEBUG - wire HTTP-Sender I/O dispatcher-1 << "[\r][\n]"
[2019-12-12 17:30:08,266] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "HTTP/1.1 200 OK[\r][\n]"
[2019-12-12 17:30:08,268] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "Server: Cowboy[\r][\n]"
[2019-12-12 17:30:08,269] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "Connection: keep-alive[\r][\n]"
[2019-12-12 17:30:08,271] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "Date: Thu, 12 Dec 2019 12:00:08 GMT[\r][\n]"
[2019-12-12 17:30:08,272] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "Content-Type: application/json[\r][\n]"
[2019-12-12 17:30:08,273] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "Content-Length: 20[\r][\n]"
[2019-12-12 17:30:08,274] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "Via: 1.1 vegur[\r][\n]"
[2019-12-12 17:30:08,275] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "[\r][\n]"
[2019-12-12 17:30:08,276] DEBUG - wire HTTP-Sender I/O dispatcher-1 >> "{ "hello": "world" }"
[2019-12-12 17:30:08,282] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "HTTP/1.1 200 OK[\r][\n]"
[2019-12-12 17:30:08,283] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Access-Control-Expose-Headers: [\r][\n]"
[2019-12-12 17:30:08,284] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Access-Control-Allow-Origin: *[\r][\n]"
[2019-12-12 17:30:08,285] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Access-Control-Allow-Methods: GET[\r][\n]"
[2019-12-12 17:30:08,286] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Access-Control-Allow-Headers: authorization,Access-Control-Allow-Origin,Content-Type,SOAPAction,Authorization[\r][\n]"
[2019-12-12 17:30:08,287] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Content-Type: application/json[\r][\n]"
[2019-12-12 17:30:08,287] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Via: 1.1 vegur[\r][\n]"
[2019-12-12 17:30:08,288] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Date: Thu, 12 Dec 2019 12:00:08 GMT[\r][\n]"
[2019-12-12 17:30:08,289] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "Transfer-Encoding: chunked[\r][\n]"
[2019-12-12 17:30:08,290] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "[\r][\n]"
[2019-12-12 17:30:08,290] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "14[\r][\n]"
[2019-12-12 17:30:08,291] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "{ "hello": "world" }[\r][\n]"
[2019-12-12 17:30:08,292] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "0[\r][\n]"
[2019-12-12 17:30:08,293] DEBUG - wire HTTPS-Listener I/O dispatcher-5 << "[\r][\n]"
```

### Enable Gateway wire logs

1. Open the `<APIM_HOME>/repository/conf/log4j2.properties` file.

     The `synapse-wire` logger which is already defined by default will appear in the `log4j2.properties` file.

    ``` 
    logger.synapse-wire.name = org.apache.synapse.transport.http.wire
    logger.synapse-wire.level = DEBUG
    ```

    The `synapse-headers` logger can be used to log request and response headers only.
    
    ``` 
    logger.synapse-headers.name = org.apache.synapse.transport.http.headers
    logger.synapse-headers.level = DEBUG
    ```
 
2. Append the `synapse-wire` logger name to the `loggers` configuration, which is a comma-separated list of all the active loggers. 

    ```
    loggers = synapse-wire, trace-messages, org-apache-coyote,com-hazelcast
    ```

    If you want to activate the wire logs only for message headers, you can activate the `synapse-headers` logger.

    ```
    loggers = synapse-headers, trace-messages, org-apache-coyote,com-hazelcast
    ```

3.  Observe the logs for incoming and outgoing traffic in the `<APIM_HOME>/repository/logs/wso2carbon.log` file.

## HTTP Access Logs

HTTP requests/responses are logged in Access Logs to monitor the activities related to an application's usage. For instructions on how to configure and use the HTTP access logs in WSO2 API Manager, see [Monitoring HTTP Access Logs]({{base_path}}/administer/product-administration/monitoring/logging/monitoring-http-access-logs/). 

## Audit Logs

Audit Logs are used for tracking the sequence of actions that affect a particular task carried out on the server. For instructions on how to configure and use the audit logs in WSO2 API Manager, see [Monitoring Audit Logs]({{base_path}}/administer/product-administration/monitoring/logging/monitoring-audit-logs/).
