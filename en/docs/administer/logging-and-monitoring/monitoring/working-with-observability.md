# Working with Observability

Observability in WSO2 API Manager (WSO2 API-M) is really important to debug issues in a short period. WSO2 API-M facilitates observability by logging the following important points of the system with the time taken to achieve them. 

-   Method Calls
-   External Calls (HTTP/HTTPS)
-   Database Calls (JDBC and LDAP)

Furthermore, when observability is enabled in WSO2 API-M, a random correlation ID is generated within the WSO2 API-M for each transaction allowing you to correlate the latter three types of calls. Thereby, the requests and the responses that correspond to a specific API call will be logged under one correlation ID making it easier to analyze the information. If required, you can provide a unique correlation ID by adding the `activityid` in the header to the request sent to WSO2 API-M.

!!! note
    Observability is not enabled by default as it slightly impacts WSO2 API Manager's performance.

### Enabling observability on WSO2 API-M

Enabling observability is simple in the new API Manager. All that needs to be done is to find the following system property in the product startup script (stored in the `<API-M_HOME>/bin/` directory) and set it to true. By default, this is set to false.
```java
-DenableCorrelationLogs=true
```

!!! tip
    Alternatively, observability can be enabled at the time of starting the WSO2 API-M server as follows:
    
    Linux/Mac OS
    ```java
    sh wso2server.sh -DenableCorrelationLogs=true start
    ```

    Windows
    ```java
    wso2server.bat --run -DenableCorrelationLogs=true start
    ```

!!! note
    When observability is enabled in WSO2 API Manager, a separate log file named `correlation.log` is created in the `<API-M_HOME>/repository/logs` directory.

### Method call logs

When correlation logging is enabled, the API Manager logs the time taken to execute certain important methods of the following modules.

-   `org.wso2.carbon.apimgt.gateway`
-   `org.wso2.carbon.apimgt.keymgt`
-   `org.wso2.carbon.apimgt.impl`

In API Manager, by default the important methods are marked with the `@MethodStats` annotation, and this annotation can be found at both the method level and the class level. All the methods of the respective class are included for logging for the classes that have the latter mentioned annotation. The format of a method log entry is as follows:

*Format*

`timestamp | correlationID | threadName | duration | callType | className | methodName | methodArguments`

!!! example
    `2018-11-28 10:10:56,293|a783f7c3-647f-4d10-9b72-106faa01bba8|PassThroughMessageProcessor-3|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.CORSRequestHandler|handleRequest|[messageContext]`

??? "Click here for more details on the method call log entry."
    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>timestamp</td>
    <td>
        The time at which the log is created.<br/>
        <strong>Example: </strong><code>2018-11-28 10:10:56,293</code>
    </td>
    </tr>
    <tr class="even">
    <td>correlationID</td>
    <td>
        Each log contains a correlation ID, which is unique to the HTTP request. A client can send a unique correlation ID in the `activityID` header of the HTTP request. If this correlation ID is missing in the incoming request, WSO2 API-M will generate a random correlation ID for the request.<br/>
        <strong>Example: </strong><code>a783f7c3-647f-4d10-9b72-106faa01bba8</code>
    </td>
    </tr>
    <tr class="odd">
    <td>threadName</td>
    <td>
        The identifier of the thread.<br/>
        <strong>Example: </strong><code>PassThroughMessageProcessor-3</code>
    </td>
    </tr>
    <tr class="even">
    <td>duration</td>
    <td>
        The time gap (in milliseconds) between two states of the message.<br/>
        <strong>Example: </strong><code>0</code>
    </td>
    </tr>
    <tr class="odd">
    <td>callType</td>
    <td>
        METHOD - The call type is METHOD in order to indicate that it is a method level log.
    </td>
    </tr>
    <tr class="even">
    <td>className</td>
    <td>
        Class name of the method which was invoked.
    </td>
    </tr>
    <tr class="odd">
    <td>methodName</td>
    <td>
        Name of the method which was invoked.
    </td>
    </tr>
    <tr class="even">
    <td>methodArguments</td>
    <td>
        Parameters of the method that was invoked.
    </td>
    </tr>
    </tbody>
    </table>

!!! tip
    By default, we log only certain methods we suspect that can introduce a latency. If you need to log all the methods that correspond to a package, you need to specify the package name as the value of the `logAllMethods` system property. This is further explained lateron.

### External call logs

You can enable correlation logs in WSO2 API-M to track the complete round trip of an individual HTTP message, which means the monitoring of individual HTTP requests from the point that a message is received by WSO2 API-M until the corresponding response message is sent back to the original message sender (client → API-M → back-end → API-M → client). Thereby, you can use the correlation log file to monitor and analyze external calls in detail. The following are the two types of external call logs that can be tracked via observability in WSO2 API-M.

#### External call logs with APIM specific information

All external calls done by the API Manager is logged via this category. Note that this does not include DB calls. This is done via a Synapse Global Handler that logs the important information of the external calls. The format for a Synapse global handler level external call log entry is as follows:

*Format*

`timestamp | correlationID | threadName | duration(BE latency) | callType | apiName | apiMethod | apiContext | apiResourcePath | authHeader | orgIdHeader | SrcIdHeader | applIdHeader | uuIdHeader | requestSize | responseSize | apiResponseStatusCode | applicationName | consumerKey | responseTime`

!!! example
    `2018-11-28` `10:10:56,316|a783f7c3-647f-4d10-9b72-106faa01bba8|PassThroughMessageProcessor-4|20|HTTP|admin--PizzaShackAPI:v1.0.0|GET|/pizzashack/1.0.0/menu|pizzashack/1.0.0/menu|null|null|null|null|null|71|2238|200|DefaultApplication|AwlPOz2aDf2i1gZFWgITEgf4oPsa|21`

??? "Click here for more details on the Synapse global handler level external call log entry."
    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>timestamp</td>
    <td>
        The time at which the log is created.<br/>
        <strong>Example: </strong><code>2018-11-28 10:10:56,293</code>
    </td>
    </tr>
    <tr class="even">
    <td>correlationID</td>
    <td>
        Each log contains a correlation ID, which is unique to the HTTP request. A client can send a unique correlation ID in the `activityID` header of the HTTP request. If this correlation ID is missing in the incoming request, WSO2 API-M will generate a random correlation ID for the request.<br/>
        <strong>Example: </strong><code>a783f7c3-647f-4d10-9b72-106faa01bba8</code>
    </td>
    </tr>
    <tr class="odd">
    <td>threadName</td>
    <td>
        The identifier of the thread.<br/>
        <strong>Example: </strong><code>PassThroughMessageProcessor-4</code>
    </td>
    </tr>
    <tr class="even">
    <td>duration (BE Latency)</td>
    <td>
        The time gap (in milliseconds) between two states of the message.<br/>
        <strong>Example: </strong><code>0</code>
    </td>
    </tr>
    <tr class="odd">
    <td>callType</td>
    <td>
        HTTP - The call type identifies logs that correspond to either back-end latency or round-trip latency states. Thereby, in the case of an individual request, one log will be recorded to identify back-end latency, and another log for the round-trip latency. These logs are categorized using the HTTP call type because these logs relate to HTTP calls between WSO2 API-M and external clients.
    </td>
    </tr>
    <tr class="even">
    <td>apiName</td>
    <td>
        Name of the API that was invoked.<br/>
        <strong>Example: </strong><code>admin--PizzaShackAPI:v1.0.0</code>
    </td>
    </tr>
    <tr class="odd">
    <td>apiMethod</td>
    <td>
        HTTP method utilized.<br/>
        <strong>Example: </strong><code>GET</code>
    </td>
    </tr>
    <tr class="even">
    <td>apiContext</td>
    <td>
        The API context which was invoked.
    </td>
    </tr>
    <tr class="odd">
    <td>apiResourcePath</td>
    <td>
        Resource path of the API that was invoked.<br/>
        <strong>Example: </strong><code>/pizzashack/1.0.0/menu</code>
    </td>
    </tr>
    <tr class="even">
    <td>authHeader</td>
    <td>
        Logs the Authorization header.
    </td>
    </tr>
    <tr class="odd">
    <td>orgIdHeader</td>
    <td>
        Logs the organization-id header.
    </td>
    </tr>
    <tr class="even">
    <td>SrcIdHeader</td>
    <td>
        Logs the source-id header.
    </td>
    </tr>
    <tr class="odd">
    <td>applIdHeader</td>
    <td>
        Logs the application-id header.
    </td>
    </tr>
    <tr class="even">
    <td>uuIdHeader</td>
    <td>
        Logs the uuid header.
    </td>
    </tr>
    <tr class="odd">
    <td>requestSize</td>
    <td>
        Size of the request payload.<br/>
        <strong>Example: </strong><code>71</code>
    </td>
    </tr>
    <tr class="even">
    <td>responseSize</td>
    <td>
        Size of the response payload.<br/>
        <strong>Example: </strong><code>2238</code>
    </td>
    </tr>
    <tr class="odd">
    <td>apiResponseStatusCode</td>
    <td>
        Status code of the response.<br/>
        <strong>Example: </strong><code>200</code>
    </td>
    </tr>
    <tr class="even">
    <td>applicationName</td>
    <td>
        Name of the application that was used to subscribe to the API.<br/>
        <strong>Example: </strong><code>DefaultApplication</code>
    </td>
    </tr>
    <tr class="odd">
    <td>consumerKey</td>
    <td>
        This refers to the consumer key that you get when you generate keys for your production and sandbox environments.<br/>
        <strong>Example: </strong><code>AwlPOz2aDf2i1gZFWgITEgf4oPsa</code>
    </td>
    </tr>
    <tr class="even">
    <td>responseTime</td>
    <td>
        Roundtrip time of the request.<br/>
        <strong>Example: </strong><code>21</code>
    </td>
    </tr>
    </tbody>
    </table>

#### External call logs with transport level information

In contrast to the information provided by the Synapse global handler level, the passthrough transport level gives certain additional data such as, the Synapse internal state of the request. The format for a Synapse passthrough transport level external call log entry is as follows:

*Format*

`timestamp|correlationID|threadName|duration|callType|connectionName|methodType|connectionURL|httpState`

!!! example
    `2018-11-28` `10:10:56,314|a783f7c3-647f-4d10-9b72-106faa01bba8|HTTPS-Sender I/O dispatcher-1|1|HTTP State Transition|http-outgoing-1|GET|https://localhost:9443/am/sample/pizzashack/v1/api/menu|RESPONSE_DONE`

??? "Click here for more details on the Synapse passthrough transport level external call log entry."
    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>timestamp</td>
    <td>
        The time at which the log is created.<br/>
        <strong>Example: </strong><code>2018-11-28 10:10:56,314</code>
    </td>
    </tr>
    <tr class="even">
    <td>correlationID</td>
    <td>
        Each log contains a correlation ID, which is unique to the HTTP request. A client can send a unique correlation ID in the `activityID` header of the HTTP request. If this correlation ID is missing in the incoming request, WSO2 API-M will generate a random correlation ID for the request.<br/>
        <strong>Example: </strong><code>a783f7c3-647f-4d10-9b72-106faa01bba8</code>
    </td>
    </tr>
    <tr class="odd">
    <td>threadName</td>
    <td>
        The identifier of the thread.<br/>
        <strong>Example: </strong><code>HTTPS-Sender I/O dispatcher-1</code>
    </td>
    </tr>
    <tr class="even">
    <td>duration</td>
    <td>
        The time gap (in milliseconds) between two states of the message.<br/>
        <strong>Example: </strong><code>1</code>
    </td>
    </tr>
    <tr class="odd">
    <td>callType</td>
    <td>
        The following are the two possible call types:
        <ul>
        <li><strong>HTTP</strong> - This call type identifies logs that correspond to either back-end latency or round-trip latency states. Thereby, in the case of an individual request, one log will be recorded to identify back-end latency, and another log for the round-trip latency. These logs are categorized using the HTTP call type because these logs relate to HTTP calls between WSO2 API-M and external clients.</li>
        <li><strong>HTTP State Transition</strong> - This call type idenfities logs that correspond to the state transition in the HTTP transport related to a particular message.</li>
        </ul>
    </td>
    </tr>
    <tr class="even">
    <td>connectionName</td>
    <td>
        This is a name that is generated to identify the connection between WSO2 API-M and the external client (back-end or message sender).<br/>
        <strong>Example: </strong><code>http-outgoing-1</code>
    </td>
    </tr>
    <tr class="odd">
    <td>methodType</td>
    <td>
        The HTTP method used for the request.<br/>
        <strong>Example: </strong><code>GET</code>
    </td>
    </tr>
    <tr class="even">
    <td>connectionURL</td>
    <td>
        The connection URL of external client to which the message is passed from WSO2 API-M.<br/>
        <strong>Example: </strong><code>https://localhost:9443/am/sample/pizzashack/v1/api/menu</code>
    </td>
    </tr>
    <tr class="odd">
    <td>httpState</td>
    <td>
        Listed below are the state changes that a message goes through when it flows through WSO2 API-M, and when the message flows between WSO2 API-M and exernal clients. A new log is generated for the message to record each of the following states.
        <ul>
        <li><strong>REQUEST_HEAD</strong>: All HTTP headers in the incoming request are being written to the backend.</li>
        <li><strong>REQUEST_BODY</strong>: The body of the incoming request is being written to the backend.</li>
        <li><strong>REQUEST_DONE</strong>: The request is completely received (content decoded) and written to the backend.</li>
        <li><strong>BACKEND LATENCY</strong>: The response message is received by WSO2 API-M. This status corresponds to the time total time taken by the backend to process the message.</li>
        <li><strong>RESPONSE_HEAD</strong>: All HTTP headers in the response message are being written to the client.</li>
        <li><strong>RESPONSE_BODY</strong>: The body of the response message is being written to the client.</li>
        <li><strong>RESPONSE_DONE</strong>: The response is completely received and written to the client.</li>
        <li><strong>ROUND-TRIP LATENCY</strong>: The response message is completely writtent to the client. This status corresponds to the total time taken by the HTTP request to compete the round trip (from the point of receiving the HTTP request from a client until the response message is sent back to the client).</li>
        </ul>
    </td>
    </tr>
    </tbody>
    </table>

### Database call logs

The database call logging for observability includes two types of DB calls, namely LDAP calls and JDBC calls. This will help to track down any latencies caused by a database calls in an instance.

####JDBC call logs

*Format*

`timestamp | correlationID | threadID | duration | callType | startTime | methodName | query | connectionUrl`

!!! example
    `2018-11-28` `10:10:43,202|a783f7c3-647f-4d10-9b72-106faa01bba8|PassThroughMessageProcessor-1|0|jdbc|1543380043202|executeQuery|SELECT REG_NAME, REG_VALUE FROM REG_PROPERTY P, REG_RESOURCE_PROPERTY RP WHERE P.REG_ID=RP.REG_PROPERTY_ID AND RP.REG_VERSION=? AND P.REG_TENANT_ID=RP.REG_TENANT_ID AND RP.REG_TENANT_ID=?|jdbc:h2:repository/database/WSO2CARBON_DB`

??? "Click here for more details on the the JDBC call log entry."
    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>timestamp</td>
    <td>
        The time at which the log is created.<br/>
        <strong>Example: </strong><code>2018-11-28 10:10:43,202</code>
    </td>
    </tr>
    <tr class="even">
    <td>correlationID</td>
    <td>
        Each log contains a correlation ID, which is unique to the HTTP request. A client can send a unique correlation ID in the `activityID` header of the HTTP request. If this correlation ID is missing in the incoming request, WSO2 API-M will generate a random correlation ID for the request.<br/>
        <strong>Example: </strong><code>a783f7c3-647f-4d10-9b72-106faa01bba8</code>
    </td>
    </tr>
    <tr class="odd">
    <td>threadName</td>
    <td>
        The identifier of the thread.<br/>
        <strong>Example: </strong><code>PassThroughMessageProcessor-1</code>
    </td>
    </tr>
    <tr class="even">
    <td>duration</td>
    <td>
        The time gap (in milliseconds) between two states of the message.<br/>
        <strong>Example: </strong><code>0</code>
    </td>
    </tr>
    <tr class="odd">
    <td>callType</td>
    <td>
        jdbc - This indicates JDBC level logs
    </td>
    </tr>
    <tr class="even">
    <td>startTime</td>
    <td>
        Time in milliseconds at which the query started.<br/>
        <strong>Example: </strong><code>1543380043202</code>
    </td>
    </tr>
    <tr class="odd">
    <td>methodName</td>
    <td>
        SQL statement method type that was called.<br/>
        <strong>Example: </strong><code>executeQuery</code>
    </td>
    </tr>
    <tr class="even">
    <td>query</td>
    <td>
        SQL query.<br/>
        <strong>Example: </strong><code>SELECT REG_NAME, REG_VALUE FROM REG_PROPERTY P, REG_RESOURCE_PROPERTY RP WHERE P.REG_ID=RP.REG_PROPERTY_ID AND RP.REG_VERSION=? AND P.REG_TENANT_ID=RP.REG_TENANT_ID AND RP.REG_TENANT_ID=?</code>
    </td>
    </tr>
    <tr class="odd">
    <td>connectionUrl</td>
    <td>
        Database connection URL.<br/>
        <strong>Example: </strong><code>jdbc:h2:repository/database/WSO2CARBON_DB</code>
    </td>
    </tr>
    </tbody>
    </table>

####LDAP call logs

*Format*

`timestamp | correlationID | threadID | duration | callType | startTime | methodName | providerUrl | principal | argsLengeth | args`

!!! example
    `2018-11-0514:05:18,599|86b56b19-7872-4e2f-84f3-5a14f92e18c1|http-nio-9443-exec-8|200|ldap|1541406918591|search|ldap://localhost:10389|uid=admin,ou=system|3| uid=admin,ou=Users,dc=WSO2,dc=ORG,(&(objectClass=person)(uid=admin)),javax.naming.directory.SearchControls@548e9a48`

??? "Click here for more details on the the LDAP call log entry."
    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>timestamp</td>
    <td>
        The time at which the log is created.<br/>
        <strong>Example: </strong><code>2018-11-0514:05:18,599</code>
    </td>
    </tr>
    <tr class="even">
    <td>correlationID</td>
    <td>
        Each log contains a correlation ID, which is unique to the HTTP request. A client can send a unique correlation ID in the `activityID` header of the HTTP request. If this correlation ID is missing in the incoming request, WSO2 API-M will generate a random correlation ID for the request.<br/>
        <strong>Example: </strong><code>a783f7c3-647f-4d10-9b72-106faa01bba8</code>
    </td>
    </tr>
    <tr class="odd">
    <td>threadName</td>
    <td>
        The identifier of the thread.<br/>
        <strong>Example: </strong><code>http-nio-9443-exec-8</code>
    </td>
    </tr>
    <tr class="even">
    <td>duration</td>
    <td>
        The time gap (in milliseconds) between two states of the message.<br/>
        <strong>Example: </strong><code>200</code>
    </td>
    </tr>
    <tr class="odd">
    <td>callType</td>
    <td>
        ldap - Determines the LDAP level logs.
    </td>
    </tr>
    <tr class="even">
    <td>startTime</td>
    <td>
        Time in milliseconds at which the query started.<br/>
        <strong>Example: </strong><code>1541406918591</code>
    </td>
    </tr>
    <tr class="odd">
    <td>methodName</td>
    <td>
        LDAP method type that was called.<br/>
        <strong>Example: </strong><code>search</code>
    </td>
    </tr>
    <tr class="even">
    <td>providerUrl</td>
    <td>
        LDAP connection URL.<br/>
        <strong>Example: </strong><code>ldap://localhost:10389</code>
    </td>
    </tr>
    <tr class="odd">
    <td>principal</td>
    <td>
        Login name of the user.<br/>
        <strong>Example: </strong><code>uid=admin,ou=system</code>
    </td>
    </tr>
    <tr class="even">
    <td>argsLength</td>
    <td>
        Length of arguments.<br/>
        <strong>Example: </strong><code>3</code>
    </td>
    </tr>
    <tr class="odd">
    <td>args</td>
    <td>
        Arguments in the LDAP query.<br/>
        <strong>Example: </strong><code>uid=admin,ou=Users,dc=WSO2,dc=ORG,(&(objectClass=person)(uid=admin)),javax.naming.directory.SearchControls@548e9a48</code>
    </td>
    </tr>
    </tbody>
    </table>

### Using the correlation logs to track a specific request

Follow the instructions below to check the correlation logs of a specific request sent:

#### Step 1 - Setup WSO2 API-M

Enable observability with WSO2 API-M and start the WSO2 API-M server as explained above.

#### Step 2 - Invoke an API

If you don't have an API to access, follow the following links: 

1. [Creating an API]({{base_path}}/learn/design-api/create-api/create-a-rest-api)

2. [Publish the API]({{base_path}}/learn/design-api/publish-api/publish-an-api)

3. [Subscribe to the API]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api)

Use the following command to invoke the API.

``` java
curl -k "Authorization :Bearer <access-token>" -H "activityid:<example-correlation-ID>" --data "<payload>" <api_url>
```

!!! note
    If curl is not available, you can use any tool to invoke the API. But make sure the add the `activityid` header

#### Step 3 - Check the correlation logs

1.  Open a terminal and navigate to the `<API-M_HOME>/repository/logs` directory where the `correlation.log` file is saved.
2.  Isolate the logs that are correlated.<br/>
    Replace `<correlation_ID>` with the `<example-correlation-ID>` given above.

    `cat correlation.log | grep "<correlation_ID>"`

### Reading and analyzing the correlation logs

Let's analyze the following sample correlation log.

```python
1 `2018-11-29 15:19:13,859|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Listener I/O dispatcher-2|1|HTTP State Transition|http-incoming-2|GET|/testing/1|REQUEST_HEAD`
2 `2018-11-29 15:19:13,859|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Listener I/O dispatcher-2|0|HTTP State Transition|http-incoming-2|GET|/testing/1|REQUEST_DONE`
3 `2018-11-29 15:19:13,862|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.CORSRequestHandler|handleRequest|[messageContext]`
4 `2018-11-29 15:19:13,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.APIKeyValidator|getResourceCache|[]`
5 `2018-11-29 15:19:13,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.APIKeyValidator|getResourceAuthenticationScheme|[synCtx]`
6 `2018-11-29 15:19:13,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.AuthenticationContext|getCallerToken|[]`
7 `2018-11-29 15:19:13,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.oauth.OAuthAuthenticator|authenticate|[synCtx]`
8 `2018-11-29 15:19:13,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler|handleRequest|[messageContext]`
9 `2018-11-29 15:19:13,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.throttling.ThrottleHandler|doThrottle|[messageContext]`
10 `2018-11-29 15:19:13,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtUsageHandler|handleRequest|[mc]`
11 `2018-11-29 15:19:13,864|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtGoogleAnalyticsTrackingHandler|handleRequest|[msgCtx]`
12 `2018-11-29 15:19:13,864|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler|mediate|[messageContext, direction]`
13 `2018-11-29 15:19:13,864|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-17|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler|handleRequest|[messageContext]`
14 `2018-11-29 15:19:13,984||pool-10-thread-1|0|jdbc|1543484953984|executeQuery|SELECT REG_PATH, REG_USER_ID, REG_LOGGED_TIME, REG_ACTION, REG_ACTION_DATA FROM REG_LOG WHERE REG_LOGGED_TIME>? AND REG_LOGGED_TIME<? AND REG_TENANT_ID=? ORDER BY REG_LOGGED_TIME DESC|jdbc:h2:repository/database/WSO2CARBON_DB`
15 `2018-11-29 15:19:13,984||pool-10-thread-1|0|jdbc|1543484953984|executeQuery|SELECT UM_ID, UM_DOMAIN_NAME, UM_EMAIL, UM_CREATED_DATE, UM_ACTIVE FROM UM_TENANT ORDER BY UM_ID|jdbc:h2:repository/database/WSO2CARBON_DB`
16 `2018-11-29 15:19:14,031|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Sender I/O dispatcher-3|3|HTTP State Transition|http-outgoing-3|GET|http://0.0.0.0:10080/hello/sayHello|REQUEST_DONE`
17 `2018-11-29 15:19:14,863|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Sender I/O dispatcher-3|832 |HTTP|http://0.0.0.0:10080/hello/sayHello|BACKEND LATENCY`
18 `2018-11-29 15:19:14,864|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Sender I/O dispatcher-3|832|HTTP State Transition|http-outgoing-3|GET|http://0.0.0.0:10080/hello/sayHello|RESPONSE_HEAD`
19 `2018-11-29 15:19:14,864|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Sender I/O dispatcher-3|1|HTTP State Transition|http-outgoing-3|GET|http://0.0.0.0:10080/hello/sayHello|RESPONSE_BODY`
20 `2018-11-29 15:19:14,864|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Sender I/O dispatcher-3|0|HTTP State Transition|http-outgoing-3|GET|http://0.0.0.0:10080/hello/sayHello|RESPONSE_DONE`
21 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|1003|HTTP|admin--test:v1|GET|/testing/1/*|testing/1|null|null|null|null|null|71|73|200|DefaultApplication|AwlPOz2aDf2i1gZFWgITEgf4oPsa|1005`
22 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.CORSRequestHandler|handleResponse|[messageContext]`
23 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler|handleResponse|[messageContext]`
24 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.throttling.ThrottleHandler|handleResponse|[messageContext]`
25 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtUsageHandler|handleResponse|[mc]`
26 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtGoogleAnalyticsTrackingHandler|handleResponse|[arg0]`
27 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler|mediate|[messageContext, direction]`
28 `2018-11-29 15:19:14,868|ff0c8866-d8a8-4189-930d-016b9d92f1e8|PassThroughMessageProcessor-18|0|METHOD|org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler|handleResponse|[messageContext]`
29 `2018-11-29 15:19:14,870|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Listener I/O dispatcher-2|1011|HTTP State Transition|http-incoming-2|GET|/testing/1|RESPONSE_HEAD`
30 `2018-11-29 15:19:14,871|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Listener I/O dispatcher-2|1|HTTP State Transition|http-incoming-2|GET|/testing/1|RESPONSE_BODY`
31 `2018-11-29 15:19:14,871|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Listener I/O dispatcher-2|0|HTTP State Transition|http-incoming-2|GET|/testing/1|RESPONSE_DONE`
32 `2018-11-29 15:19:14,871|ff0c8866-d8a8-4189-930d-016b9d92f1e8|HTTP-Listener I/O dispatcher-2|1012|HTTP|http-incoming-2|GET|/testing/1|ROUND-TRIP LATENCY`
```
<table>
<thead>
<tr class="header">
<th>Line No</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1-2</td>
<td>HTTP State Transition when receiving the request</td>
</tr>
<tr class="even">
<td>3-13</td>
<td>Methods invoked in Gateway handlers in the request path</td>
</tr>
<tr class="odd">
<td>14-15</td>
<td>Database calls irrelevant to the API call</td>
</tr>
<tr class="even">
<td>16</td>
<td>HTTP State Transition for the request</td>
</tr>
<tr class="odd">
<td>17</td>
<td>
    Backend Latency<br/>
    Here the backend latency log have reflected the 800ms delay that was added to the backend for this example.
</td>
</tr>
<tr class="even">
<td>18-20</td>
<td>HTTP State Transition for response</td>
</tr>
<tr class="odd">
<td>21</td>
<td>Synapse global handler level for the backend call log</td>
</tr>
<tr class="even">
<td>22-28</td>
<td>Methods invoked in the Gateway handlers in the response path</td>
</tr>
<tr class="odd">
<td>29-31</td>
<td>HTTP State Transition for dispatching response</td>
</tr>
<tr class="even">
<td>32</td>
<td>HTTP Roundtrip Latency</td>
</tr>
</tbody>
</table>

### Narrowing down a bottleneck using Observability

#### Scenario: A request sent to the API Manager takes a lot of time to respond back

This can happen due to several reasons,

1. Due to an programming error
2. Due to a backend service call taking time
3. Due to a database/ ldap call taking time

Follow the following steps to pinpoint the bottleneck,

You can list the times consumed by the code level, using the following command. This will help you to pinpoint method level latencies.
``` java
cat correlation.log | grep “|METHOD|” | cut -d “|” -f4 | sort -n
```
This will give the time consumed by each method in ascending order. If a method with a high time consumption is identified, then take the 5 most time consuming service and database calls, with the same correlation ID of the method logs, and find out the unusually time consuming call.

``` java
cat correlation.log | grep “correlationID” | grep “|HTTP” | cut -d “|” -f4 | sort -n
cat correlation.log | grep “correlationID” | grep “|jdbc|” | cut -d “|” -f4 | sort -n
cat correlation.log | grep “correlationID” | grep “|ldap|” | cut -d “|” -f4 | sort -n
```

!!! note
    If a method with a high time consumption cannot be identified, but still a high latency is observed, the following command can be executed to find the highest time recorded.

    ``` java
    cat correlation.log | cut -d “|” -f4 | sort -n
    ```
    Then the entry that bears the highest duration can be found by serching the file for this time.

    ``` java
    cat correlation.log | grep "<highest_time>"
    ```

!!! tip
    Alternatively a log analyzing tool can be used as well to derive these information.

### Advanced Use Cases

The following are the advanced use cases that you may run into when working with observability in WSO2 API-M.

#### Logging all methods

Currently, when using method logging, it only logs special methods that are suspected to give latencies, because logging all methods can pose performance issues. There can be instances where you may need to log other methods too.

In order to configure the logging of all methods, add the following configuration as a system property to the APIM startup script. This will log all methods executied in the given package.

*Format*

```java
-DlogAllMethods=<package_name>
```

!!! example
    For example, let's consider that you need to log all the methods for the gateway package.
    ```java
    -DlogAllMethods=org.wso2.carbon.apimgt.gateway
    ```

!!! note
    Make sure to add it before `org.wso2.carbon.bootstrap.Bootstrap $*`.

#### Blacklisting threads

Blacklisting of threads is needed because some threads keep on printing unnecessary jdbc logs continuously. Therefore, by blacklisting these unwanted threads from printing logs, it helps to reduce the cluttering of the logs.

In order to enable blacklisting of threads, add the following configuration as a system property to the the APIM startup script.

*Format*

```java
-Dorg.wso2.CorrelationLogInterceptor.BlacklistedThreads=<threadName1>,<threadName2> 
```

!!! example
    For example, let's assume you need to blacklist threads: `pool-10-thread-1` and `metrics-jdbc-reporter-1-thread-1`    
    ```java
    -Dorg.wso2.CorrelationLogInterceptor.BlacklistedThreads=pool-10-thread-1,metrics-jdbc-reporter-1-thread-1
    ```

!!! note
    Make sure to add it before `org.wso2.carbon.bootstrap.Bootstrap $*`.

If the above configuration is not added, by default the `MessageDeliveryTaskThreadPool` thread will be blacklisted as it is found to print a considerable amount for messages for API-M instances. However, if the above configuration is added the default value will be overridden. 

Blacklisting of threads is not needed by default, as all unnecessary threads are already blacklisted.
