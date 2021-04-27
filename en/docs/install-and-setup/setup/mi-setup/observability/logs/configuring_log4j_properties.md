# Configuring Logs

## Introduction

All WSO2 products are shipped with log4j2 logging capabilities, which generate server side logs. The `log4j2.properties` file, which governs how logging is performed by the server can be found in the `MI_HOME/conf` directory.

??? note "Java logging and Log4j2 integration"
    In addition to the logs from libraries that use Log4j2, all logs from libraries that use the Java logging framework are also visible in the same log files. That is, when Java logging is enabled in Carbon, only the Log4j2 appenders will write to the log files. If the Java Logging Handlers have logs, these logs will be delegated to the log events of the corresponding Log4j2 appenders. A Pub/Sub registry pattern implementation has been used in the latter mentioned scenario to plug the handlers and appenders. The following default log4j2 appenders in the `log4j2.properties` file are used for this implementation:<br/><br/>
    - org.wso2.carbon.logging.appenders.CarbonConsoleAppender<br/>
    - org.wso2.carbon.logging.appenders.CarbonDailyRollingFileAppender

There are three main components when configuring log4j2: **Loggers**, **Appenders**, and **Layouts**.

### Log4j2 loggers

```xml
logger.<LOGGER_NAME>.name = <COMPONENT_NAME>
logger.<LOGGER_NAME>.level = INFO
logger.<LOGGER_NAME>.additivity = false
logger.<LOGGER_NAME>.appenderRef.<APPENDER_NAME>.ref = <APPENDER_NAME>
```

The logger attributes are described below.

<table>
    <tr>
        <th>
            name
        </th>
        <td>
            The name of the component (class) for which the logger is defined. That is, this logger is responsible for generating logs for the activities of the specified component.
        </td>
    </tr>
    <tr>
        <th>
            level
        </th>
        <td>
            Allows to configure level (threshold). After you specify the level for a certain logger, a log request for that logger will only be enabled if its level is equal or higher to the logger’s level. If a given logger is not assigned a level, then it inherits one from its closest ancestor with an assigned level. Refer to the hierarchy of levels given above. See descriptions of the available log levels.
        </td>
    </tr>
    <tr>
        <th>
            additivity
        </th>
        <td>
           Allows to inherit all the appenders of the parent Logger if set as `true`.
        </td>
    </tr>
    <tr>
        <th>
            appenderRef.APPENDER_NAME.ref
        </th>
        <td>
            This element is used to attach appenders to the logger.
        </td>
    </tr>
</table>

The loggers are then listed in the `log4j2.properties` file using the logger name as shown below.

```xml
loggers = <LOGGER_NAME>, <LOGGER_NAME_1>, <LOGGER_NAME_2>,
```
### Log4j2 Appenders

Log4j2 allows logging requests to print to multiple destinations. These output destinations are called 'Appenders'. All the defined appenders should be listed as shown below in the `log4j2.properties` file.

!!! Note
    If the output destination is in another environment (such as a cloud storage), you need to [use custom log appenders](#using-custom-log-appenders).

```xml
appenders = CARBON_CONSOLE, CARBON_LOGFILE, AUDIT_LOGFILE, ATOMIKOS_LOGFILE, CARBON_TRACE_LOGFILE, osgi, SERVICE_LOGFILE, API_LOGFILE, ERROR_LOGFILE, CORRELATION
```

Once the appenders are defined, a logger can refer the appender by using the `appenderRef.APPENDER_NAME.ref` element. You can also attach several appenders to one logger. For example, see how the [<b>root logger</b>](#root-logs) is linked to three appenders. Also, see how [other loggers](#configuring-log4j2-logs) in the `log4j2.properties` file are configured to use appenders.

## Configuring Log4j2 Logs

The list below shows some of the main loggers (excluding the [root logger](#root-logger)) that are configured by default in the Micro Integrator. Open the `log4j2.properties` file to see the complete list.

```xml
loggers = SERVICE_LOGGER, API_LOGGER, AUDIT_LOG, correlation, trace-messages, org.apache.synapse.transport.http.headers, org.apache.synapse.transport.http.wire, httpclient.wire.header, httpclient.wire.content,
```

The above logger configurations are explained below.

### Root Logs

Given below is the <b>root logger</b> that is configured by default for the Micro Integrator. All loggers that do not have specific appenders defined will refer the appenders from the root logger.

This logger generates INFO-level logs and prints them to three destinations as per the <b>appenders</b> linked to the logger. The `appenderRef.<APPENDER_NAME>.ref` attribute is used for referring the appenders.

```xml
rootLogger.level = INFO
rootLogger.appenderRef.CARBON_CONSOLE.ref = CARBON_CONSOLE
rootLogger.appenderRef.CARBON_LOGFILE.ref = CARBON_LOGFILE
rootLogger.appenderRef.ERROR_LOGFILE.ref = ERROR_LOGFILE
```

Listed below are the default log destinations (appenders) used by the root logger:

-   `CARBON_CONSOLE`: This is the consoleAppender that prints logs to the server's console. These logs are printed to the `wso2carbon.log` file and the `wso2error.log` file through the two appenders given below.

    ```xml tab='CARBON_CONSOLE'
    # CARBON_CONSOLE is set to be a ConsoleAppender using a PatternLayout.
    appender.CARBON_CONSOLE.type = Console
    appender.CARBON_CONSOLE.name = CARBON_CONSOLE
    appender.CARBON_CONSOLE.layout.type = PatternLayout
    appender.CARBON_CONSOLE.layout.pattern = [%d] %5p {% raw %}{%c{1}}{% endraw %} - %m%ex%n
    appender.CARBON_CONSOLE.filter.threshold.type = ThresholdFilter
    appender.CARBON_CONSOLE.filter.threshold.level = DEBUG
    ```
    
-   `CARBON_LOGFILE`: This is a RollingFile appender that generates management logs of the server. Logs are printed to the `<MI_HOME>/repository/logs/wso2carbon.log`.

    ```xml tab='CARBON_LOGFILE'
    # CARBON_LOGFILE is set to be a DailyRollingFileAppender using a PatternLayout.
    appender.CARBON_LOGFILE.type = RollingFile
    appender.CARBON_LOGFILE.name = CARBON_LOGFILE
    appender.CARBON_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/wso2carbon.log
    appender.CARBON_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2carbon-%d{MM-dd-yyyy}.log
    appender.CARBON_LOGFILE.layout.type = PatternLayout
    appender.CARBON_LOGFILE.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
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
    ```

-   `ERROR_LOGFILE`: This is a RollingFile appender that print the error logs to the `<MI_HOME>/repository/logs/wso2error.log` file.


    ```xml tab='ERROR_LOGFILE'
    # Appender config to SERVICE_APPENDER
    appender.ERROR_LOGFILE.type = RollingFile
    appender.ERROR_LOGFILE.name = ERROR_LOGFILE
    appender.ERROR_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/wso2error.log
    appender.ERROR_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2error-%d{MM-dd-yyyy}.log
    appender.ERROR_LOGFILE.layout.type = PatternLayout
    appender.ERROR_LOGFILE.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
    appender.ERROR_LOGFILE.policies.type = Policies
    appender.ERROR_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
    appender.ERROR_LOGFILE.policies.time.interval = 1
    appender.ERROR_LOGFILE.policies.time.modulate = true
    appender.ERROR_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
    appender.ERROR_LOGFILE.policies.size.size=10MB
    appender.ERROR_LOGFILE.strategy.type = DefaultRolloverStrategy
    appender.ERROR_LOGFILE.strategy.max = 20
    appender.ERROR_LOGFILE.filter.threshold.type = ThresholdFilter
    appender.ERROR_LOGFILE.filter.threshold.level = WARN
    ```

### Service Logs

This logger generates logs for services deployed in the Micro Integrator. It refers the `SERVICE_LOGFILE` appender and prints logs to the `MI_HOME/repository/logs/wso2-mi-service.log` file.

!!! Note
    If you want to have separate log files for individual services, you need to add loggers for each service and then specify appenders for the loggers. Note that the service name has to be suffixed to `SERVICE_LOGGER` as follows:

    ```xml
    logger.SERVICE_LOGGER.name = SERVICE_LOGGER.TestProxy
    ```

    See the instructions on [monitoring per-service logs]({{base_path}}/integrate/develop/enabling-logs-for-services).

```xml tab='SERVICE_LOGGER'
logger.SERVICE_LOGGER.name= SERVICE_LOGGER
logger.SERVICE_LOGGER.level = INFO
logger.SERVICE_LOGGER.appenderRef.SERVICE_LOGFILE.ref = SERVICE_LOGFILE
logger.SERVICE_LOGGER.additivity = false
```

```xml tab='APPENDER'
# Appender config to SERVICE_LOGFILE
appender.SERVICE_LOGFILE.type = RollingFile
appender.SERVICE_LOGFILE.name = SERVICE_LOGFILE
appender.SERVICE_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/wso2-mi-service.log
appender.SERVICE_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2-mi-service-%d{MM-dd-yyyy}.log
appender.SERVICE_LOGFILE.layout.type = PatternLayout
appender.SERVICE_LOGFILE.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
appender.SERVICE_LOGFILE.policies.type = Policies
appender.SERVICE_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
appender.SERVICE_LOGFILE.policies.size.size=10MB
appender.SERVICE_LOGFILE.strategy.type = DefaultRolloverStrategy
appender.SERVICE_LOGFILE.strategy.max = 20
```

### API Logs

This logger generates logs for APIs deployed in the Micro Integrator. It refers the `API_LOGFILE` appender and prints logs to the `MI_HOME/repository/logs/wso2-mi-api.log` file.

!!! Note
    If you want to have separate log files for individual APIs, you need to add loggers for each API and then specify appenders for the loggers. Note that the service name has to be suffixed to `SERVICE_LOGGER` as follows:

    ```xml
    logger.API_LOG.name=API_LOGGER.TestAPI
    ```

    See the instructions on [monitoring per-API logs]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/enabling-logs-for-api).

```xml tab='API_LOGGER'
logger.API_LOGGER.name= API_LOGGER
logger.API_LOGGER.level = INFO
logger.API_LOGGER.appenderRef.SERVICE_LOGFILE.ref = API_LOGFILE
logger.API_LOGGER.additivity = false
```

```xml tab='APPENDER'
# Appender config to API_APPENDER
appender.API_LOGFILE.type = RollingFile
appender.API_LOGFILE.name = API_LOGFILE
appender.API_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/wso2-mi-api.log
appender.API_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2-mi-api-%d{MM-dd-yyyy}.log
appender.API_LOGFILE.layout.type = PatternLayout
appender.API_LOGFILE.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
appender.API_LOGFILE.policies.type = Policies
appender.API_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
appender.API_LOGFILE.policies.size.size=10MB
appender.API_LOGFILE.strategy.type = DefaultRolloverStrategy
appender.API_LOGFILE.strategy.max = 20
```

### Audit Logs

This is a `RollingFile` appender that writes logs to the `MI_HOME/repository/logs/audit.log` file. By default, the `AUDIT_LOG` logger is configured to write logs using this appender.

```xml tab='AUDIT_LOGGER'
logger.AUDIT_LOG.name = AUDIT_LOG
logger.AUDIT_LOG.level = INFO
logger.AUDIT_LOG.appenderRef.AUDIT_LOGFILE.ref = AUDIT_LOGFILE
logger.AUDIT_LOG.additivity = false
```

```xml tab='APPENDER'
# Appender config to AUDIT_LOGFILE
appender.AUDIT_LOGFILE.type = RollingFile
appender.AUDIT_LOGFILE.name = AUDIT_LOGFILE
appender.AUDIT_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/audit.log
appender.AUDIT_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/audit-%d{MM-dd-yyyy}.log
appender.AUDIT_LOGFILE.layout.type = PatternLayout
appender.AUDIT_LOGFILE.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
appender.AUDIT_LOGFILE.policies.type = Policies
appender.AUDIT_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
appender.AUDIT_LOGFILE.policies.time.interval = 1
appender.AUDIT_LOGFILE.policies.time.modulate = true
appender.AUDIT_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
appender.AUDIT_LOGFILE.policies.size.size=10MB
appender.AUDIT_LOGFILE.strategy.type = DefaultRolloverStrategy
appender.AUDIT_LOGFILE.strategy.max = 20
appender.AUDIT_LOGFILE.filter.threshold.type = ThresholdFilter
appender.AUDIT_LOGFILE.filter.threshold.level = INFO
```

### Correlations Logs

This loggger generates correlation logs for monitoring individual HTTP requests from the point that a message is received by the Micro Integrator until the corresponding response message is sent back to the original message sender. It refers the `CORRELATION` appender and prints logs to the `MI_HOME/repository/logs/correlation.log` file.

!!! Note
    The maximum file size of the correlation log is set to
    10MB in the following <b>appender</b>. That is, when the size of the file
    exceeds 10MB, a new log file is created. If required, you can change
    this file size.

```xml tab='correlation'
logger.correlation.name = correlation
logger.correlation.level = INFO
logger.correlation.appenderRef.CORRELATION.ref = CORRELATION
logger.correlation.additivity = false
```

```xml tab='APPENDER'
# Appender config to put correlation Log.
appender.CORRELATION.type = RollingFile
appender.CORRELATION.name = CORRELATION
appender.CORRELATION.fileName =${sys:carbon.home}/repository/logs/correlation.log
appender.CORRELATION.filePattern =${sys:carbon.home}/repository/logs/correlation-%d{MM-dd-yyyy}.log
appender.CORRELATION.layout.type = PatternLayout
appender.CORRELATION.layout.pattern = %d{yyyy-MM-dd HH:mm:ss,SSS}|%X{Correlation-ID}|%t|%m%n
appender.CORRELATION.policies.type = Policies
appender.CORRELATION.policies.time.type = TimeBasedTriggeringPolicy
appender.CORRELATION.policies.time.interval = 1
appender.CORRELATION.policies.time.modulate = true
appender.CORRELATION.policies.size.type = SizeBasedTriggeringPolicy
appender.CORRELATION.policies.size.size=10MB
appender.CORRELATION.strategy.type = DefaultRolloverStrategy
appender.CORRELATION.strategy.max = 20
appender.CORRELATION.filter.threshold.type = ThresholdFilter
appender.CORRELATION.filter.threshold.level = INFO
```

<b>Additional configurations</b>:

If required, you can change the default HTTP header (which is
    'activity_id') that is used to carry the correlation ID by adding
    the following property to the
    `deployment.toml` file (stored in the `MI_HOME/conf/` directory). Replace
    `<correlation_id>` with a value of your choice.

```toml
[passthru_properties]
correlation_header_name="<correlation_id>"
```

Once you have configured this logger, see the instructions on [monitoring correlation logs]({{base_path}}/install-and-setup/setup/mi-setup/observability/observability).

### Message Tracing Logs

This is a `RollingFile` appender that writes logs to the `MI_HOME/repository/logs/wso2carbon-trace-messages.log` file. By default, the `trace.messages` logger is configured to write logs using this appender.

```xml tab='trace-messages'
logger.trace-messages.name = trace.messages
logger.trace-messages.level = TRACE
logger.trace-messages.appenderRef.CARBON_TRACE_LOGFILE.ref = CARBON_TRACE_LOGFILE
```

```xml tab='APPENDER'
# Appender config to CARBON_TRACE_LOGFILE
appender.CARBON_TRACE_LOGFILE.type = RollingFile
appender.CARBON_TRACE_LOGFILE.name = CARBON_TRACE_LOGFILE
appender.CARBON_TRACE_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/wso2carbon-trace-messages.log
appender.CARBON_TRACE_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2carbon-trace-messages-%d{MM-dd-yyyy}.log
appender.CARBON_TRACE_LOGFILE.layout.type = PatternLayout
appender.CARBON_TRACE_LOGFILE.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
appender.CARBON_TRACE_LOGFILE.policies.type = Policies
appender.CARBON_TRACE_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
appender.CARBON_TRACE_LOGFILE.policies.time.interval = 1
appender.CARBON_TRACE_LOGFILE.policies.time.modulate = true
appender.CARBON_TRACE_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
appender.CARBON_TRACE_LOGFILE.policies.size.size=10MB
appender.CARBON_TRACE_LOGFILE.strategy.type = DefaultRolloverStrategy
appender.CARBON_TRACE_LOGFILE.strategy.max = 20
```

### Wire Logs and Header Logs

These logs are disabled by default by setting the log level to `OFF`. You can enable these logs by [changing the log level](#updating-the-log4j2-log-level) of the loggers to `DEBUG`.

!!! Info
    It is not recommended to use these logs in production environments. Developers can enable them for testing and troubleshooting purposes. Note that appenders are not specified for these loggers, and therefore, the logs will be printed as specified for the [root logger](#root-logs).

-   The following loggers configure wire logs for the Passthrough HTTP transport:

    !!! Tip
        The Passthrough HTTP transport is the main transport that handles HTTP/HTTPS messages in the Micro Integrator.

    ```xml tab='Synapse HTTP Headers'
    # Following are to log HTTP headers and messages
    logger.synapse-transport-http-headers.name=org.apache.synapse.transport.http.headers
    logger.synapse-transport-http-headers.level=OFF
    ```

    ```xml tab='Synapse Wire Logs'
    logger.synapse-transport-http-wire.name=org.apache.synapse.transport.http.wire
    logger.synapse-transport-http-wire.level=OFF
    ```

-   The following loggers configure wire logs for the Callout mediator/MessageProcessor.

    ```xml tab='Client Headers'
    logger.httpclient-wire-header.name=httpclient.wire.header
    logger.httpclient-wire-header.level=OFF
    ```

    ```xml tab='Client Wire Content'
    logger.httpclient-wire-content.name=httpclient.wire.content
    logger.httpclient-wire-content.level=OFF
    ```

See the instructions on [using wire logs to debug]({{base_path}}/integrate/develop/using-wire-logs) your integration solution during development.

## Configuring HTTP Access Logs

Access logs related to service/API invocations are enabled by default in the Micro Integrator. Access logs for the PassThrough transport will record the request and the response on **two** separate log lines.

By default, access logs are printed to the `http_acces_.log` file (stored in the `MI_HOME/repository/logs` folder). If required, you can use the log4j2 configurations to print the access logs to other destinations. Simply apply the following [logger](#log4j2-loggers) with an [appender](#log4j2-appenders).

-   <b>Logger Name</b>: PassThroughAccess
-   <b>Logger Class</b>: org.apache.synapse.transport.http.access

### Customizing the Access Log Format

You can customize the format of this access log by changing the following property values in the `MI_HOME/conf/access-log.properties` configuration file. If this file does not exist in the product by default, you can create a new file.

1.  Open the `access-log.properties` file and add the following properties.

    <table>
    <tbody>
      <tr class="odd">
         <td>access_log_directory</td>
         <td>Add this property ONLY if you want to change the default location of the log file. By default, the product is configured to store access logs in the <code>MI_HOME/repository/logs</code> directory.</td>
      </tr>
      <tr class="even">
         <td>access_log_prefix</td>
         <td>
            <div class="content-wrapper">
               <p>The prefix added to the log file's name. The default value is as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>access_log_prefix=http_access_</span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>access_log_suffix</td>
         <td>
            <div class="content-wrapper">
               <p>The suffix added to the log file's name. The default value is as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb2-1"><a href="#cb2-1"></a>access_log_suffix=.<span class="fu">log</span></span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>access_log_file_date_format</td>
         <td>
            <div class="content-wrapper">
               <p>The date format used in access logs. The default value is as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb3-1"><a href="#cb3-1"></a>access_log_file_date_format=yyyy-MM-dd</span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>access_log_pattern</td>
         <td>
            <div class="content-wrapper">
               <p>The attribute defines the format for the log pattern, which consists of the information fields from the requests and responses that should be logged. The pattern format is created using the following attributes:</p>
               <ul>
                  <li>
                     <p>A standard value to represent a particular string. For example, "%h" represents the remote host name in the request. Note that all the <a href="https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/catalina/valves/AccessLogValve.html">string replacement values supported by Tomcat</a> are NOT supported for the PassThrough transport's access logs. The list of supported values are <a href="#supported-log-pattern-formats-for-the-passthrough-and-nio-transports">given below</a> .</p>
                  </li>
                  <li><strong>%{xxx}i</strong> is used to represent the header in the incoming request (xxx=header value).</li>
                  <li><strong>%{xxx}o</strong> is used to represents the header in the outgoing request (xxx=header value).</li>
               </ul>
               <p>While you can use the above attributes to define a custom pattern, the standard patterns shown below can be used.</p>
               <ul>
                  <li>
                     <p><strong>common</strong> ( <a href="http://httpd.apache.org/docs/1.3/logs.html#common">Apache common log pattern</a> ):</p>
                     <div class="code panel pdl" style="border-width: 1px;">
                        <div class="codeContent panelContent pdl">
                           <div class="sourceCode" id="cb4" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                              <pre class="sourceCode java"><code class="sourceCode java"><span id="cb4-1"><a href="#cb4-1"></a>access_log_pattern=%h %l %u %t <span class="st">&quot;%r&quot;</span> %s %b</span></code></pre>
                           </div>
                        </div>
                     </div>
                  </li>
                  <li>
                     <p><strong>combined</strong> ( <a href="http://httpd.apache.org/docs/1.3/logs.html#combined">Apache combined log pattern</a> ):</p>
                     <div class="code panel pdl" style="border-width: 1px;">
                        <div class="codeContent panelContent pdl">
                           <div class="sourceCode" id="cb5" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                              <pre class="sourceCode java"><code class="sourceCode java"><span id="cb5-1"><a href="#cb5-1"></a>access_log_pattern=%h %l %u %t <span class="st">&quot;%r&quot;</span> %s %b <span class="st">&quot;%{Referer}i&quot;</span> <span class="st">&quot;%{User-Agent}i&quot;</span></span></code></pre>
                           </div>
                        </div>
                     </div>
                  </li>
               </ul>
               <p>By default, a modified version of the <a href="http://httpd.apache.org/docs/1.3/logs.html#combined">Apache combined log format</a> is enabled in the ESB as shown below. Note that the "X-Forwarded-For" header is appended to the beginning of the usually <strong>combined</strong> log format. This correctly identifies the original node that sent the request (in situations where requests go through a proxy such as a load balancer). The "X-Forwarded-For" header must be present in the incoming request for this to be logged.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb6" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb6-1"><a href="#cb6-1"></a>access_log_pattern=%{X-Forwarded-For}i %h %l %u %t \<span class="st">&quot;%r</span><span class="sc">\&quot;</span><span class="st"> %s %b </span><span class="sc">\&quot;</span><span class="st">%{Referer}i</span><span class="sc">\&quot;</span><span class="st"> </span><span class="sc">\&quot;</span><span class="st">%{User-Agent}i</span><span class="sc">\&quot;</span></span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
    </tbody>
    </table>

3.  Restart the server.
4.  Invoke a proxy service or REST API that is deployed in the Micro Integrator. The access log file for the service/API will be created in the `MI_HOME/repository/logs` directory. The default name of the log file is `http_access_.log` .

    !!! Tip
        Note that there will be a delay in printing the logs to the log file.

### Supported Log Pattern Formats

<table>
<thead>
<tr class="header">
<th>Attribute</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>%a</code></pre></td>
<td><p>Remote IP address</p></td>
</tr>
<tr class="even">
<td><pre><code>%A</code></pre></td>
<td><p>Local IP address</p></td>
</tr>
<tr class="odd">
<td><pre><code>%b</code></pre></td>
<td><p>Bytes sent, excluding HTTP headers, or '-' if zero</p></td>
</tr>
<tr class="even">
<td><pre><code>%B</code></pre></td>
<td><p>Bytes sent, excluding HTTP headers</p></td>
</tr>
<tr class="odd">
<td><pre><code>%c</code></pre></td>
<td><p>Cookie value</p></td>
</tr>
<tr class="even">
<td><pre><code>%C</code></pre></td>
<td><p>Accept header</p></td>
</tr>
<tr class="odd">
<td><pre><code>%e</code></pre></td>
<td><p>Accept Encoding</p></td>
</tr>
<tr class="even">
<td><pre><code>%E</code></pre></td>
<td><p>Transfer Encoding</p></td>
</tr>
<tr class="odd">
<td><pre><code>%h</code></pre></td>
<td><p>Remote host name (or IP address if enableLookups for the connector is false)</p></td>
</tr>
<tr class="even">
<td><pre><code>%l</code></pre></td>
<td><p>Remote logical username from identd (always returns '-')</p></td>
</tr>
<tr class="odd">
<td><pre><code>%L</code></pre></td>
<td><p>Accept Language</p></td>
</tr>
<tr class="even">
<td><pre><code>%k</code></pre></td>
<td><p>Keep Alive</p></td>
</tr>
<tr class="odd">
<td><pre><code>%m</code></pre></td>
<td><p>Request method (GET, POST, etc.)</p></td>
</tr>
<tr class="even">
<td><pre><code>%n</code></pre></td>
<td><p>Content Encoding</p></td>
</tr>
<tr class="odd">
<td><pre><code>%r</code></pre></td>
<td><p>Request Element</p></td>
</tr>
<tr class="even">
<td><pre><code>%s</code></pre></td>
<td><p>HTTP status code of the response</p></td>
</tr>
<tr class="odd">
<td><pre><code>%S</code></pre></td>
<td><p>Accept Chatset</p></td>
</tr>
<tr class="even">
<td><pre><code>%t</code></pre></td>
<td><p>Date and time, in Common Log Format</p></td>
</tr>
<tr class="odd">
<td><pre><code>%T</code></pre></td>
<td><p>Time taken to process the request in seconds.</p></td>
</tr>
<tr class="even">
<td><pre><code>%u</code></pre></td>
<td><p>Remote user that was authenticated (if any), else '-'</p></td>
</tr>
<tr class="odd">
<td><pre><code>%U</code></pre></td>
<td><p>Requested URL path</p></td>
</tr>
<tr class="even">
<td><pre><code>%v</code></pre></td>
<td><p>Local server name</p></td>
</tr>
<tr class="odd">
<td><pre><code>%V</code></pre></td>
<td><p>Vary Header</p></td>
</tr>
<tr class="even">
<td><pre><code>%x</code></pre></td>
<td><p>Connection Header</p></td>
</tr>
<tr class="odd">
<td><pre><code>%Z</code></pre></td>
<td><p>Server Header</p></td>
</tr>
</tbody>
</table>

## Updating the Log4j2 Log Level

You can <b>dynamically</b> update the log level for a specific logger by using the Micro Integrator [dashboard](#using-the-dashboard) or [CLI](#using-the-cli). If you change the wire log configuration directly from the `log4j2.properties` file (without using the dashboard or CLI), the Micro Integrator needs to be restarted for the changes to become effective.

??? Info "Log Levels"
    The following table explains the log4j2 log levels you can use. Refer <b>Log4j2 documentation</b> for more information.

    | Level | Description                                                                                                                                                                                                                                                                     |
    |-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | OFF   | The highest possible log level. This is intended for disabling logging.                                                                                                                                                                                                         |
    | FATAL | Indicates server errors that cause premature termination. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                          |
    | ERROR | Indicates other runtime errors or unexpected conditions. These logs are expected to be immediately visible on the command line that you used for starting the server.                                                                                                           |
    | WARN  | Indicates the use of deprecated APIs, poor use of API, possible errors, and other runtime situations that are undesirable or unexpected but not necessarily wrong. These logs are expected to be immediately visible on the command line that you used for starting the server. |
    | INFO  | Indicates important runtime events, such as server startup/shutdown. These logs are expected to be immediately visible on the command line that you used for starting the server . It is recommended to keep these logs to a minimum.                                           |
    | DEBUG | Provides detailed information on the flow through the system. This information is expected to be written to logs only. Generally, most lines logged by your application should be written as DEBUG logs.                                                                        |
    | TRACE | Provides additional details on the behavior of events and services. This information is expected to be written to logs only.                                                                                                                                                    |

### Using the dashboard

1.  Sign in to the [Micro Integrator dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard).
2.  Click <b>Log Configs</b> on the left-hand navigator to open the <b>Logging Management</b> window.

    <img alt="change log level from dashboard" src="{{base_path}}/assets/img/integrate/monitoring-dashboard/change-log-level-dashboard.png">

3.  Use the <b>Search</b> option to find the required logger, and change the log level as shown above.

### Using the CLI

1.  Download and set up the [API Controller]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller).

2.  Issue commands to view logs for the required Micro Integrator artifacts. For more information, see [Managing Integrations with apictl]({{base_path}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl).


## Updating the Threshold Level

The threshold value filters log entries based on the [log level](#updating-the-log4j2-log-level). This value is set for the log appender in the `log4j2.properties` file. For example, a threshold set to 'WARN' allows the log entry to pass into the appender. If its level is 'WARN', 'ERROR' or 'FATAL', other entries will be discarded. This is the minimum log level at which you can log a message.

Shown below is how the log level is set to DEBUG for the `CARBON_LOGFILE` appender:

```bash
appender.CARBON_LOGFILE.filter.threshold.level = DEBUG
```

## Updating the Log4j2 Log Pattern

The log pattern defines the output format of the log file. This is the layout pattern that describes the log message format.

**Identifying forged messages**:
The conversion character 'u' can be used in the pattern layout to log a UUID. For example, the log pattern can be  [%u] [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n, where [%u] is the UUID.

## Hide Current Parameters in the Printed Log

By default, when an error occurs while invoking a data service, the Micro Integrator logs a set of parameters in the error message.

For example:

```xml
DS Code: INCOMPATIBLE_PARAMETERS_ERROR
Source Data Service:-
Name: RDBMSSample
Location: /RDBMSSample.dbs
Description: N/A
Default Namespace: http://ws.wso2.org/dataservice
Current Request Name: _addEmployee
Current Params: {% raw %}{firstName=Will, lastName=Smith, salary=1200, email=will@abc.com}{% endraw %}
```

You can hide the 'Current Params' in the printed logs by passing the following system property:

```xml
-Ddss.disable.current.params=true \
```

## Using Custom Log Appenders

Custom log appenders for Log4j2 can be used to store application logs in various environments/systems such as cloud storages.

However, since WSO2 Micro Integrator works in an OSGi environment, such Log4j2 extensions cannot be used as they are. Therefore, you need to modify those extensions to be compatible with WSO2 Micro Integrator. Follow the steps given below to modify an existing Log4j2 extension:

1. In the custom log appender, open the `pom.xml` file of the module that contains the `Log4j2Appender` class.

2. Under the `build` section, add `maven-compiler-plugin` and `maven-bundle-plugin` as follows.

    ```xml
    <plugins>
       ...
       <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <executions>
                <execution>
                   <id>log4j-plugin-processor</id>
                   <goals>
                      <goal>compile</goal>
                   </goals>
                   <phase>process-classes</phase>
                   <configuration>
                      <proc>only</proc>
                      <annotationProcessors>
                            <annotationProcessor>
                               org.apache.logging.log4j.core.config.plugins.processor.PluginProcessor
                            </annotationProcessor>
                      </annotationProcessors>
                   </configuration>
                </execution>
          </executions>
       </plugin>
       <plugin>
          <groupId>org.apache.felix</groupId>
          <artifactId>maven-bundle-plugin</artifactId>
          <extensions>true</extensions>
          <configuration>
                <instructions>
                   <Bundle-SymbolicName>${project.artifactId}</Bundle-SymbolicName>
                   <Bundle-Name>${project.artifactId}</Bundle-Name>
                   <Fragment-Host>org.ops4j.pax.logging.pax-logging-log4j2</Fragment-Host>
                   <Export-Package>
                      <PACKAGE_CONTAINS_THE_APPENDER_CLASS>
                   </Export-Package>
                  <DynamicImport-Package>*</DynamicImport-Package>
                   <Import-Package></Import-Package>
                   <Include-Resource>${project.build.directory}/classes/</Include-Resource>
                </instructions>
          </configuration>
       </plugin>
       ...
    ```

3. Rebuild the related module and copy the built JAR file from the `target` directory to `<MI_HOME>/dropins` directory.

4. Configure the custom appender in the `log4j2.properties` file as follows.

    ```properties
    appender.log4j2Custom.type = Log4j2Appender
    appender.log4j2Custom.name = log4j2Custom
    appender.log4j2Custom.layout.type = PatternLayout
    appender.log4j2Custom.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
    ```
    
5. The custom appender should be added to the list of registered appenders in the `log4j2.properties` file as shown below.

    ```properties
    appenders = log4j2Custom, ....
    ```

6. Restart the server.

## What's Next?

Once you have configured the logs, you can start [using the logs]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/monitoring_logs).

