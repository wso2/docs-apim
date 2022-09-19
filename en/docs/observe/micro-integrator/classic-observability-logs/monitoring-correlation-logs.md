# Monitoring Correlation Logs

Product observability enables rapid debugging of product issues. The Micro Integrator enables observability using Correlation logs. Correlation logs allow you to monitor individual HTTP requests from the point that a message is received by the Micro Integrator until the corresponding response message is sent back to the original message sender. That is, the complete round trip of an HTTP message (client → Micro Integrator → back-end → Micro Integrator → client) can be tracked and analyzed using a log
file.

When Correlation logs are enabled for the Micro Integrator server, a separate log file named `correlation.log` is created in the `<MI_HOME>/repository/logs/` directory. Every HTTP message that flows through the ESB and between the Micro Integrator and external clients undergoes several state changes. A new log entry is created in the `correlation.log` file corresponding to the state changes in the round trip of a single HTTP request. A Correlation ID assigned to the incoming HTTP request is assigned to all the log entries corresponding to the request. Therefore, you can use this Correlation ID to easily locate the logs relevant to the round trip of a specific HTTP request and, thereby, analyze the behavior of the message flow.
 
## Enabling Correlation logs

### At the server start-up

You can enable Correlation logging by passing a system property.

-   If you want Correlation logs to be enabled every time the server starts, add the following system property to the product start-up script (stored in the `<MI_HOME>/bin/` directory) and set it to `true`.

    ```bash
    -DenableCorrelationLogs=true \
    ```

-   Alternatively, you can pass the system property at the time of starting the server by executing the following command:

    - On **Linux/MacOS/CentOS**: `sh micro-integrator.sh -DenableCorrelationLogs=true`
    - On **Windows**: `micro-integrator.bat -DenableCorrelationLogs=true`


Now when you start the Micro Integrator, the `correlation.log` file is created in the `<MI_HOME>/repository/logs/` directory.

### During the runtime 

- You can enable correlation logging by invoking the configs resource of the Management API. For more information, see 
[enable/disable correlation logs using the Management API]({{base_path}}/observe/mi-observe/working-with-management-api/#enabledisable-correlation-logging-during-runtime).

- Alternatively, you can enable correlation logging using the MI dashboard. 

- You cannot disable the correlation logs during runtime if the correlation logs are enabled using the system property. 

## Sending an HTTP request with a Correlation ID

When the client sends an HTTP request to the Micro Integrator, a Correlation ID for the request can be passed using the Correlation header that is configured in the Micro Integrator. By default, the Correlation header is `activity_id`. If you want to change the default Correlation header, see the topic on [configuring Correlation logs]({{base_path}}/observe/micro-integrator/classic-observability-logs/configuring-log4j2-properties/#correlations-logs). If the client does not pass a Correlation ID in the request, the Micro Integrator will generate an internal value and assign it to the request. The Correlation ID assigned to the incoming request is assigned to all the log entries that are related to the same request.

Shown below is the POST request that is sent using the CURL client. Note that the Correlation ID is set in this request.

```bash
curl -X POST --data @request.json http://localhost:8280/healthcare/categories/surgery/reserve -H "Content-Type:application/json" -H "activityid:correlationID"
```

## Accessing the Correlation logs

If you know the Correlation ID of the HTTP request that you want to analyze, you can isolate the relevant logs as explained below.

1.  Open a terminal and navigate to the `<MI_HOME>/repository/logs/` directory where the `correlation.log` file is saved.

2.  Execute the following command with the required Correlation ID.
     
     Replace `<correlation_ID>` with the required value.

     ```bash
     cat correlation.log | grep "<correlation_ID>"
    ```

Shown below is an example of Correlation log entries corresponding to the round trip of a single HTTP request.

```xml
2021-11-30 15:27:27,262|correlationID|HTTP-Listener I/O dispatcher-5|0|HTTP State Transition|http-incoming-17|POST|/healthcare/categories/surgery/reserve|REQUEST_HEAD
2021-11-30 15:27:27,262|correlationID|HTTP-Listener I/O dispatcher-5|0|HTTP State Transition|http-incoming-17|POST|/healthcare/categories/surgery/reserve|REQUEST_BODY
2021-11-30 15:27:27,263|correlationID|HTTP-Listener I/O dispatcher-5|1|HTTP State Transition|http-incoming-17|POST|/healthcare/categories/surgery/reserve|REQUEST_DONE
2021-11-30 15:27:27,265|correlationID|HTTP-Sender I/O dispatcher-4|42173|HTTP State Transition|http-outgoing-4|POST|http://localhost:9090/grandoaks/categories/surgery/reserve|REQUEST_HEAD
2021-11-30 15:27:27,265|correlationID|HTTP-Sender I/O dispatcher-4|0|HTTP State Transition|http-outgoing-4|POST|http://localhost:9090/grandoaks/categories/surgery/reserve|REQUEST_DONE
2021-11-30 15:27:27,267|correlationID|HTTP-Sender I/O dispatcher-4|2 |HTTP|sourhttp://localhost:9090/grandoaks/categories/surgery/reserve|BACKEND LATENCY
2021-11-30 15:27:27,267|correlationID|HTTP-Sender I/O dispatcher-4|2|HTTP State Transition|http-outgoing-4|POST|http://localhost:9090/grandoaks/categories/surgery/reserve|RESPONSE_HEAD
2021-11-30 15:27:27,267|correlationID|HTTP-Sender I/O dispatcher-4|0|HTTP State Transition|http-outgoing-4|POST|http://localhost:9090/grandoaks/categories/surgery/reserve|RESPONSE_BODY
2021-11-30 15:27:27,267|correlationID|HTTP-Sender I/O dispatcher-4|0|HTTP State Transition|http-outgoing-4|POST|http://localhost:9090/grandoaks/categories/surgery/reserve|RESPONSE_DONE
2021-11-30 15:27:27,269|correlationID|HTTP-Listener I/O dispatcher-5|6|HTTP State Transition|http-incoming-17|POST|/healthcare/categories/surgery/reserve|RESPONSE_HEAD
2021-11-30 15:27:27,269|correlationID|HTTP-Listener I/O dispatcher-5|0|HTTP State Transition|http-incoming-17|POST|/healthcare/categories/surgery/reserve|RESPONSE_BODY
2021-11-30 15:27:27,269|correlationID|HTTP-Listener I/O dispatcher-5|0|HTTP State Transition|http-incoming-17|POST|/healthcare/categories/surgery/reserve|RESPONSE_DONE
2021-11-30 15:27:27,269|correlationID|HTTP-Listener I/O dispatcher-5|7|HTTP|http-incoming-17|POST|/healthcare/categories/surgery/reserve|ROUND-TRIP LATENCY
```

## Reading Correlation logs

The pattern/format of a Correlation log is shown below along with an example log entry.

```bash tab="Log Pattern"
Time Stamp|Correlation ID|Thread name|Duration|Call type|Connection name|Method type|Connection URL|HTTP state
```

```bash tab="Example Log"
2021-10-26 17:34:40,464|de461a83-fc74-4660-93ed-1b609ecfac23|HTTP-Listener I/O dispatcher-3|535|HTTP|http-incoming-3|GET|/api/querydoctor/surgery|ROUND-TRIP LATENCY
```

The detail recorded in a log entry is described below.

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 86%" />
</colgroup>
<tbody>
<tr>
    <th>State</th>
    <th>Description</th>
</tr>
<tr class="odd">
<td>Time Stamp</td>
<td><div class="content-wrapper">
<p>The time at which the log is created.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>Example</strong>
</div>
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a><span class="dv">2021</span>-<span class="dv">10</span>-<span class="dv">26</span> <span class="dv">17</span>:<span class="dv">34</span>:<span class="dv">40</span>,<span class="dv">464</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>Correlation ID</td>
<td><div class="content-wrapper">
<p>Each log contains a Correlation ID, which is unique to the HTTP request. A client can send the Correlation ID in the header of the HTTP request. If this Correlation ID is missing in the incoming request, the ESB will generate one for the request.</p>
<p>The HTTP header that carries the Correlation ID is configured in the ESB.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>Example</strong>
</div>
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb2-1"><a href="#cb2-1"></a>de461a83-fc74-<span class="dv">4660</span>-93ed-1b609ecfac23</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Thread name</td>
<td><div class="content-wrapper">
<p>The identifier of the thread.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>Example</strong>
</div>
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb3-1"><a href="#cb3-1"></a>HTTP-Listener I/O dispatcher-<span class="dv">3</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td>Duration</td>
<td><div class="content-wrapper">
<p>The duration (given in milliseconds) depends on the type of log entry:</p>
<ul>
<li>If the state in the log entry is ROUND-TRIP LATENCY, the duration corresponds to the time gap between the REQUEST_HEAD state and the ROUND-TRIP LATENCY state, which is the total time of the round trip.</li>
<li>If the state in the log entry is BACKEND LATENCY, the duration corresponds to the total time taken by the backend to process the message.</li>
<li>For all other log entries, the duration corresponds to the time gap between the current log entry and the immediately previous log entry, which is the time taken for the HTTP request to move from one state to another.</li>
</ul>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>Example</strong>
</div>
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb4" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb4-1"><a href="#cb4-1"></a><span class="dv">535</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Call type</td>
<td><p>There are two possible call types:</p>
<ul>
<li><strong>HTTP</strong> call type identifies logs that correspond to either back-end latency or round-trip latency states. That is, in the case of an individual request, one log will be recorded to identify back-end latency, and another log for round-trip latency. Since these logs relate to HTTP calls between the ESB and external clients, these logs are categorized using the HTTP call type.</li>
<li><strong>HTTP State Transition</strong> call type identifies logs that correspond to the state transitions in the HTTP transport related to a particular message.</li>
</ul></td>
</tr>
<tr class="even">
<td>Connection name</td>
<td><div class="content-wrapper">
<p>This is a name that is generated to identify the connection between the ESB and the external client (back-end or message sender).</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>Example</strong>
</div>
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb5" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb5-1"><a href="#cb5-1"></a>http-incoming-<span class="dv">3</span></span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Method type</td>
<td><div class="content-wrapper">
<p>The HTTP method used for the request.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>Example</strong>
</div>
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb6" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb6-1"><a href="#cb6-1"></a>GET</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td id="connection-url">Connection URL</td>
<td><div class="content-wrapper">
<p>The connection URL of the external client with which the message is being communicated. For example, if the message is being read from the client, the connection URL corresponds to the client sending the message. However, if the message is being written to the backend, the URL corresponds to the backend client.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeHeader panelHeader pdl" style="border-bottom-width: 1px;">
<strong>Example</strong>
</div>
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb7" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb7-1"><a href="#cb7-1"></a>/api/querydoctor/surgery</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>HTTP state</td>
<td><p>Listed below are the state changes that a message goes through when it flows through the ESB, and when the message flows between the ESB and external clients. Typically, a new log entry is generated for each of the states. However, there can be two separate log entries created for one particular state (except for BACKEND LATENCY and ROUND-TRIP LATENCY) depending on whether the message is being read or written. You can identify the two separate log entries from the <a href="#connection-url">connection URL</a> explained above.</p>
<ul>
<li><strong>REQUEST_HEAD:</strong> All HTTP headers in the incoming request are being read/or being written to the backend.</li>
<li><strong>REQUEST_BODY</strong> : The body of the incoming request is being read/or being written to the backend.</li>
<li><strong>REQUEST_DONE</strong> : The request is completely read (content decoded)/ or is completely written to the backend.</li>
<li><strong>BACKEND LATENCY</strong> : The response message is received by the ESB. This status corresponds to the time total time taken by the backend to process the message.</li>
<li><strong>RESPONSE_HEAD</strong> : All HTTP headers in the response message are being read/or being written to the client.</li>
<li><strong>RESPONSE_BODY</strong> : The body of the response message is being read/or being written to the client.</li>
<li><strong>RESPONSE_DONE</strong> : The response is completely read/ or completely written to the client.</li>
<li><strong>ROUND-TRIP LATENCY</strong> : The response message is completely written to the client. This status corresponds to the total time taken by the HTTP request to complete the round trip (from the point of receiving the HTTP request from a client until the response message is sent back to the client)</li>
</ul></td>
</tr>
</tbody>
</table>

## Configuring Correlation Logs (Optional)

For information, see [Configuring Correlation Logs]({{base_path}}/observe/micro-integrator/classic-observability-logs/configuring-log4j2-properties/#correlations-logs).
