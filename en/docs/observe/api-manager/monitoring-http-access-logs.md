# Monitoring HTTP Access Logs

HTTP access logs help you monitor your application's usage with information such as the persons who access it, how many hits it received, what the errors are, etc. This information is useful for troubleshooting errors. 

In API Manager, access logs can be configured for both servlet transport and PassThrough or NIO transports in API Gateway.

## Configuring access logs for the HTTP Servlet transport

In WSO2 API Manager, the access logs can be generated for HTTP servlet transport which works on 9443/9763 default ports. HTTP servlet transport access logs are useful for analyzing operational/admin-level access details. 

In the API Manager, access logs of applications get recorded or written into the `<APIM_HOME>repository/logs/http_access_.log` file. The following config enables a new valve that allows logs to get written into the `<APIM_HOME>repository/logs/wso2carbon.log` or any other log file and show up on the console.

1. Open the <API-M_HOME>/repository/conf/deployment.toml file.

2. Add the following configuration.

    ```properties
    [http_access_log]
    useLogger = true
    ```

 3. Open <APIM_HOME>/repository/conf/log4j2.properties file:
 
 Add HTTP_ACCESS to the existing "appenders"
```Sample
appenders = CARBON_CONSOLE, CARBON_LOGFILE, AUDIT_LOGFILE, ATOMIKOS_LOGFILE, CARBON_TRACE_LOGFILE, DELETE_EVENT_LOGFILE, TRANSACTION_LOGFILE, osgi, HTTP_ACCESS
```

 Add HTTP_ACCESS to existing "loggers"
```Sample
loggers = AUDIT_LOG, trace-messages, org-apache-coyote, com-hazelcast, Owasp-CsrfGuard, org-apache-axis2-wsdl-codegen-writer-PrettyPrinter, org-apache-axis2-clustering, org-apache-catalina, org-apache-tomcat, org-wso2-carbon-apacheds, org-apache-directory-server-ldap, org-apache-directory-server-core-event, com-atomikos, org-quartz, org-apache-jackrabbit-webdav, org-apache-juddi, org-apache-commons-digester-Digester, org-apache-jasper-compiler-TldLocationsCache, org-apache-qpid, org-apache-qpid-server-Main, qpid-message, qpid-message-broker-listening, org-apache-tiles, org-apache-commons-httpclient, org-apache-solr, me-prettyprint-cassandra-hector-TimingLogger, org-apache-axis-enterprise, org-apache-directory-shared-ldap, org-apache-directory-server-ldap-handlers, org-apache-directory-shared-ldap-entry-DefaultServerAttribute, org-apache-directory-server-core-DefaultDirectoryService, org-apache-directory-shared-ldap-ldif-LdifReader, org-apache-directory-server-ldap-LdapProtocolHandler, org-apache-directory-server-core, org-apache-directory-server-ldap-LdapSession, DataNucleus, Datastore, Datastore-Schema, JPOX-Datastore, JPOX-Plugin, JPOX-MetaData, JPOX-Query, JPOX-General, JPOX-Enhancer, org-apache-hadoop-hive, hive, ExecMapper, ExecReducer, net-sf-ehcache, axis2Deployment, equinox, tomcat2, StAXDialectDetector, org-apache-directory-api, org-apache-directory-api-ldap-model-entry, TRANSACTION_LOGGER, DELETE_EVENT_LOGGER, org-springframework, org-opensaml-xml-security-credential-criteria, org-wso2-carbon-user-core, org-wso2-carbon-identity, org-wso2-carbon-identity-sso-saml, HTTP_ACCESS
```

Add logger configurations for HTTP_ACCESS log
```
logger.HTTP_ACCESS.name = HTTP_ACCESS
logger.HTTP_ACCESS.level = INFO
logger.HTTP_ACCESS.appenderRef.HTTP_ACCESS.ref = HTTP_ACCESS
logger.HTTP_ACCESS.additivity = false
```

Add appender configurations for HTTP_ACCESS log
```
appender.HTTP_ACCESS.type = RollingFile
appender.HTTP_ACCESS.name = HTTP_ACCESS
appender.HTTP_ACCESS.fileName =${sys:carbon.home}/repository/logs/wso2carbon.log
appender.HTTP_ACCESS.filePattern =${sys:carbon.home}/repository/logs/wso2carbon-%d{MM-dd-yyyy}.log
appender.HTTP_ACCESS.layout.type = PatternLayout
appender.HTTP_ACCESS.layout.pattern = [%X{Correlation-ID}] %mm%n
appender.HTTP_ACCESS.policies.type = Policies
appender.HTTP_ACCESS.policies.time.type = TimeBasedTriggeringPolicy
appender.HTTP_ACCESS.policies.time.interval = 1
appender.HTTP_ACCESS.policies.time.modulate = true
appender.HTTP_ACCESS.policies.size.type = SizeBasedTriggeringPolicy
appender.HTTP_ACCESS.policies.size.size=10MB
appender.HTTP_ACCESS.strategy.type = DefaultRolloverStrategy
appender.HTTP_ACCESS.strategy.max = 20
appender.HTTP_ACCESS.filter.threshold.type = ThresholdFilter
appender.HTTP_ACCESS.filter.threshold.level = INFO
```
 
4. Restart the server.


Following is a sample of access log entries which can be monitored via `<API-M_HOME>/repository/logs/http_access_.log` file by default.

```
- 127.0.0.1 - - [12/Dec/2019:16:53:29 +0530] "POST /token HTTP/1.1" - 125 "-" "-"
- 127.0.0.1  - [12/Dec/2019:16:53:29 +0530] "- - " 200 - "-" "-"
- 127.0.0.1 - - [12/Dec/2019:16:53:29 +0530] "POST /oauth2/token HTTP/1.1" - - "-" "Synapse-PT-HttpComponents-NIO"
- 127.0.0.1  - [12/Dec/2019:16:53:29 +0530] "- - " 200 - "-" "-"
- 127.0.0.1 - - [12/Dec/2019:16:54:38 +0530] "OPTIONS /pizzashack/1.0.0/menu HTTP/1.1" - - "https://localhost:9443/devportal/apis/462a90a2-9f2b-423f-9f58-28b95c30a184/test" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"
- 127.0.0.1  - [12/Dec/2019:16:54:38 +0530] "- - " 200 - "-" "-"
- 127.0.0.1 - - [12/Dec/2019:16:54:38 +0530] "GET /pizzashack/1.0.0/menu HTTP/1.1" - - "https://localhost:9443/devportal/apis/462a90a2-9f2b-423f-9f58-28b95c30a184/test" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"
- 127.0.0.1 - - [12/Dec/2019:16:54:38 +0530] "GET /am/sample/pizzashack/v1/api/menu HTTP/1.1" - - "https://localhost:9443/devportal/apis/462a90a2-9f2b-423f-9f58-28b95c30a184/test" "Synapse-PT-HttpComponents-NIO"
```

As the runtime of WSO2 API Manager is based on Apache Tomcat, you can use the `Access_Log_Valve` variable in Tomcat as explained below to configure access logs to the HTTP servlet transport.

## Configuring access logs for PassThrough or NIO transports in API Gateway

By default, access logs related to service/API invocation are disabled for performance reasons in the above products. You should enable these access log only for troubleshooting errors. 

Follow the steps given below to enable access logs for the PassThrough or NIO transport.

1.  Open `<API-M_HOME>/conf/log4j2.properties` file and add following configuration for `PassThroughAccess` logger.

    ```
    logger.PassThroughAccess.name = org.apache.synapse.transport.http.access
    logger.PassThroughAccess.level = INFO
    ```

2.  Append `PassThroughAccess` logger name to `loggers` configuration, which is a comma-separated list of all active loggers.

    ```
    loggers = PassThroughAccess, AUDIT_LOG, SERVICE_LOGGER, trace-messages,
    ```
    
3.  Create a file named `access-log.properties` in `<API-M_HOME>/repository/conf/` location with the following configuration and customize it as required.

    !!!Warning
        All the supported options are in the following file. Therefore, make sure to uncomment the required options to enable them as required.
        
    ```properties
    # Default access log pattern
    #access_log_pattern=%{X-Forwarded-For}i %h %l %u %t \”%r\” %s %b \”%{Referer}i\” \”%{User-Agent}i\”
    # combinded log pattern
    #access_log_pattern=%h %l %u %t \”%r\” %s %b \”%{Referer}i\” \”%{User-Agent}i\”
    access_log_pattern=time=%t remoteHostname=%h localPort=%p localIP=%A requestMethod=%m requestURL=%U remoteIP=%a requestProtocol=%H HTTPStatusCode=%s queryString=%q
    # common log pattern
    #access_log_pattern=%h %l %u %t \”%r\” %s %b
    # file prefix
    access_log_prefix=http_gw
    # file suffix
    access_log_suffix=.log
    # file date format
    access_log_file_date_format=yyyy-MM-dd
    #access_log_directory=”/logs”
    ```
    
    You can customize the default format and the configurations of gateway access logs using the following properties that you can define in `access-log.properties`.

    <table>
        <tbody>
          <tr class="odd">
             <td>access_log_directory</td>
             <td>Add this property ONLY if you want to change the default location of the log file. By default, the product is configured to store access logs in the <code>&lt;APIM_HOME&gt;/repository/logs</code> directory.</td>
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
                         <p>A standard value to represent a particular string. For example, "%h" represents the remote hostname in the request. Note that all the <a href="https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/catalina/valves/AccessLogValve.html">string replacement values supported by Tomcat</a> are NOT supported for the PassThrough transport's access logs. The list of supported values are <a href="#supported-log-pattern-formats-for-the-passthrough-transport">given below</a>.</p>
                      </li>
                      <li><strong>%{xxx}i</strong> is used to represent the header in the incoming request (xxx=header value).</li>
                      <li><strong>%{xxx}o</strong> is used to represents the header in the outgoing request (xxx=header value).</li>
                   </ul>
                   <p>While you can use the above attributes to define a custom pattern, the standard patterns shown below can be used.</p>
                   <ul>
                      <li>
                         <p><strong>common</strong> ( <a href="http://httpd.apache.org/docs/2.4/logs.html#common">Apache common log pattern</a> ):</p>
                         <div class="code panel pdl" style="border-width: 1px;">
                            <div class="codeContent panelContent pdl">
                               <div class="sourceCode" id="cb4" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                                  <pre class="sourceCode java"><code class="sourceCode java"><span id="cb4-1"><a href="#cb4-1"></a>access_log_pattern=%h %l %u %t <span class="st">&quot;%r&quot;</span> %s %b</span></code></pre>
                               </div>
                            </div>
                         </div>
                      </li>
                      <li>
                         <p><strong>combined</strong> ( <a href="http://httpd.apache.org/docs/2.4/logs.html#combined">Apache combined log pattern</a> ):</p>
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
    
4.  Add the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file. You need to add this configuration in order to make sure that the access logs related to the PassThrough and NIO transports are rotated on a daily basis. If this configuration is not set, all the access log details related to the PassThrough and NIO transports will get logged in a single file. The date will be appended to the access log when it is rotated.        
    
    ```properties
    [n_http]
    "nhttp.is.log.rotatable" = "true"
    ```
    
5.  Then [Restart the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

6.  Invoke an API in API Gateway. Then, navigate to `<API-M_HOME>/repository/logs/` directory, and you will see a newly created log file called `http_gw.log`, which contains API invocation related access logs.

### Supported log pattern formats for the PassThrough transport

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
<td><p>User Agent</p></td>
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
<td><pre><code>%f</code></pre></td>
<td><p>Referer</p></td>
</tr>
<tr class="odd">
<td><pre><code>%E</code></pre></td>
<td><p>Transfer Encoding</p></td>
</tr>
<tr class="even">
<td><pre><code>%h</code></pre></td>
<td><p>Remote hostname (or IP address if enableLookups for the connector is false)</p></td>
</tr>
<tr class="odd">
<td><pre><code>%l</code></pre></td>
<td><p>Remote logical username from identd (always returns '-')</p></td>
</tr>
<tr class="even">
<td><pre><code>%L</code></pre></td>
<td><p>Accept Language</p></td>
</tr>
<tr class="odd">
<td><pre><code>%k</code></pre></td>
<td><p>Keep Alive</p></td>
</tr>
<tr class="even">
<td><pre><code>%m</code></pre></td>
<td><p>Request method (GET, POST, etc.)</p></td>
</tr>
<tr class="odd">
<td><pre><code>%n</code></pre></td>
<td><p>Content Encoding</p></td>
</tr>
<tr class="even">
<td><pre><code>%r</code></pre></td>
<td><p>Request Element</p></td>
</tr>
<tr class="odd">
<td><pre><code>%s</code></pre></td>
<td><p>HTTP status code of the response</p></td>
</tr>
<tr class="even">
<td><pre><code>%S</code></pre></td>
<td><p>Accept Charset</p></td>
</tr>
<tr class="odd">
<td><pre><code>%t</code></pre></td>
<td><p>Date and time, in Common Log Format</p></td>
</tr>
<tr class="even">
<td><pre><code>%T</code></pre></td>
<td><p>Content Type</p></td>
</tr>
<tr class="odd">
<td><pre><code>%u</code></pre></td>
<td><p>Remote user that was authenticated (if any), else '-'</p></td>
</tr>
<tr class="even">
<td><pre><code>%U</code></pre></td>
<td><p>Requested URL path</p></td>
</tr>
<tr class="odd">
<td><pre><code>%v</code></pre></td>
<td><p>Local server name</p></td>
</tr>
<tr class="even">
<td><pre><code>%V</code></pre></td>
<td><p>Vary Header</p></td>
</tr>
<tr class="odd">
<td><pre><code>%x</code></pre></td>
<td><p>Connection Header</p></td>
</tr>
<tr class="even">
<td><pre><code>%Z</code></pre></td>
<td><p>Server Header</p></td>
</tr>
</tbody>
</table>
