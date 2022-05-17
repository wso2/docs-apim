# JMX Monitoring

Java Management Extensions (JMX) is a technology that lets you implement management interfaces for Java applications. **JConsole** is a JMX-compliant monitoring tool, which comes with the Java Development Kit (JDK). Therefore, when you use a WSO2 product, JMX is enabled by default, which allows you to monitor the product using JConsole.

!!! info
Go to the [WSO2 Administration Guide](https://docs.wso2.com/display/ADMIN44x/JMX-Based+Monitoring) for detailed instructions on how to configure JMX for a WSO2 product and how to use **JConsole** for monitoring a product.


### MBeans for WSO2 API Manager

When JMX is enabled, WSO2 ESBAPI Manager exposes a number of management resources as JMX MBeans that can be used for managing and monitoring the running server. When you start JConsole, you can monitor these MBeans from the **MBeans** tab. While some of these MBeans (**ServerAdmin** and **DataSource**) are common to all WSO2 products, some MBeans are specific to WSO2 API Manager.

!!! tip
The common MBeans are explained in detail in the [WSO2 Administration Guide](https://docs.wso2.com/display/ADMIN44x/JMX-Based+Monitoring) . Listed below are the MBeans that are specific to WSO2 API Manager.

This section summarizes the attributes and operations available for the following ESB specific MBeans:

-   Connection MBeans
-   Latency MBeans
-   Threading MBeans
-   Transport MBeans

#### Connection MBeans

These MBeans provide connection statistics for the HTTP and HTTPS transports.

You can view the following Connection MBeans:

-`org.apache.synapse/PassThroughConnections/http-listener`
-`org.apache.synapse/PassThroughConnections/http-sender`
-`org.apache.synapse/PassThroughConnections/https-listener`
-`org.apache.synapse/PassThroughConnections/https-sender`

**Attributes**

| Attribute Name     | Description                                                |
|--------------------|------------------------------------------------------------|
| ActiveConnections  | Number of currently active connections.                    |
| LastXxxConnections | Number of connections created during last Xxx time period. |
| RequestSizesMap    | A map of number of requests against their sizes.           |
| ResponseSizesMap   | A map of number of responses against their sizes.          |
| LastResetTime      | Last time connection statistic recordings was reset.       |

**Operations**

| Operation Name | Description                                                 |
|----------------|-------------------------------------------------------------|
| reset()        | Clear recorded connection statistics and restart recording. |

#### Latency MBeans

This view provides statistics of the latencies from all backend services connected through the HTTP  and HTTPS transports. These statistics are provided as an aggregate value.

You can view the following Latency MBeans:

-`org.apache.synapse/PassthroughLatencyView/nio-http-http`
-`org.apache.synapse/PassthroughLatencyView/nio-https-https`

**Attributes**

| Attribute Name                               | Description                                                                                                                                                                                                                                                         |
|----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Avg\_Latency                                 | Average latency since latency recording was last reset.                                                                                                                                                                                                             |
| txxx\_AvgLatency                             | Average latency for last xxx time period. For example, LastHourAvgLatency returns the average latency for the last hour.                                                                                                                                            |
| LastResetTime                                | Last time latency statistic recording was reset.                                                                                                                                                                                                                    |
| Avg\_Client\_To\_Esb\_RequestReadTime        | Average Time taken to read request by API Manager which is sent by the client                                                                                                                                                                                       |
| xxx\_Avg\_Client\_To\_Esb\_RequestReadTime   | Average Time taken to read request by gateway which is sent by the client for last xxx time period. For example 15m\_Avg\_Client\_To\_Esb\_RequestReadTime means average Time taken to read request by API Manager which is sent by the client for last 15 minutes. |
| Avg\_Esb\_To\_Backend\_RequestWriteTime      | Average Time taken to write the request from gateway to the backend.                                                                                                                                                                                                |
| xxx\_Avg\_Esb\_To\_Backend\_RequestWriteTime | Average Time taken to write the request from gateway to the backend in last xxx time period. For example 15m\_Avg\_Esb\_To\_Backend\_RequestWriteTime is average Time taken to write the request from gateway to the backend in last 15 minutes.                    |
| Avg\_Backend\_To\_Esb\_ResponseReadTime      | Average Time taken to read the response from gateway to backend.                                                                                                                                                                                                    |
| xxx\_Avg\_Backend\_To\_Esb\_ResponseReadTime | Average Time taken to read the response from gateway to backend in last xxx time period.                                                                                                                                                                            |
| Avg\_Esb\_To\_Client\_ResponseWriteTime      | Average time taken to write the response from gateway to the client application.                                                                                                                                                                                    |
| xxx\_Avg\_Esb\_To\_Client\_ResponseWriteTime | Average time taken to write the response from gateway to the client application in last xxx time period.                                                                                                                                                            |
| Avg\_ClientWorker\_Queued\_Time              | Average time where the ClientWorker get queued.                                                                                                                                                                                                                     |
| xxx\_Avg\_ClientWorker\_Queued\_Time         | Average time where the ClientWorker get queued in last xxx time period.                                                                                                                                                                                             |
| Avg\_ServeWorker\_Queued\_Time               | Average time where the ServerWorker get queued.                                                                                                                                                                                                                     |
| xxx\_Avg\_ClientWorker\_Queued\_Time         | Average time where the ServerWorker get queued in last xxx time period.                                                                                                                                                                                             |
| Avg\_Latency\_Backend                        | Average backend latency.                                                                                                                                                                                                                                            |
| xxx\_Avg\_Latency\_Backend                   | Average backend latency in last xxx time period.                                                                                                                                                                                                                    |
| Avg\_Request\_Mediation\_Latency             | Average latency of mediating the requests.                                                                                                                                                                                                                          |
| Avg\_Response\_Mediation\_Latency            | Average latency of mediating the responses.                                                                                                                                                                                                                         |

**Operations**

| Operation Name | Description                                              |
|----------------|----------------------------------------------------------|
| reset()        | Clear recorded latency statistics and restart recording. |

#### Threading MBeans

These MBeans are only available in the NHTTP transport and not in the default Pass Through transport.

You can view the following Threading MBeans:

-`org.apache.synapse/Threading/PassThroughHttpServerWorker`

**Attributes**

| Attribute Name                 | Description                                                         |
|--------------------------------|---------------------------------------------------------------------|
| TotalWorkerCount               | Total worker threads related to this server/client.                 |
| AvgUnblockedWorkerPercentage   | Time-averaged unblocked worker thread percentage.                   |
| AvgBlockedWorkerPercentage     | Time-averaged blocked worker thread percentage.                     |
| LastXxxBlockedWorkerPercentage | Blocked worker thread percentage averaged for last Xxx time period. |
| DeadLockedWorkers              | Number of deadlocked worker threads since last statistics reset.    |
| LastResetTime                  | Last time thread statistic recordings was reset.                    |

**Operations**

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th><div>
Operation Name
</div></th>
<th><div>
Description
</div></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>reset()</td>
<td>Clear recorded thread statistic and restart recording.</td>
</tr>
</tbody>
</table>

#### Transport MBeans

For each transport listener and sender enabled in the ESB, there will be an MBean under the `org.apache.axis2/Transport` domain. For example, when the JMS transport is enabled, the following MBean will be exposed:

-`org.apache.axis2/Transport/jms-sender-n`

You can also view the following Transport MBeans:

-`org.apache.synapse/Transport/passthru-http-receiver`
-`org.apache.synapse/Transport/passthru-http-sender`
-`org.apache.synapse/Transport/passthru-https-receiver`
-`org.apache.synapse/Transport/passthru-https-sender`

**Attributes**

Attribute Name

Description

Attribute Name

Description

ActiveThreadCount
Threads active in this transport listener/sender.
AvgSizeReceived
Average size of received messages.
AvgSizeSent
Average size of sent messages.
BytesReceived
Number of bytes received through this transport.
BytesSent
Number of bytes sent through this transport.
FaultsReceiving
Number of faults encountered while receiving.
FaultsSending
Number of faults encountered while sending.
LastResetTime
Last time transport listener/sender statistic recording was reset.
MaxSizeReceived
Maximum message size of received messages.
MaxSizeSent
Maximum message size of sent messages.
MetricsWindow
Time difference between current time and last reset time in milliseconds.
MinSizeReceived
Minimum message size of received messages.
MinSizeSent
Minimum message size of sent messages.
MessagesReceived
Total number of messages received through this transport.
MessagesSent
Total number of messages sent through this transport.
QueueSize
Number of messages currently queued. Messages get queued if all the worker threads in this transport thread pool are busy.
ResponseCodeTable
Number of messages sent against their response codes.
TimeoutsReceiving
Message receiving timeout.
TimeoutsSending
Message sending timeout.

**Operations**

| Operation Name                        | Description                                                                                                                                        |
|---------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| start()                               | Start this transport listener/sender.                                                                                                              |
| stop()                                | Stop this transport listener/sender.                                                                                                               |
| resume()                              | Resume this transport listener/sender which is currently paused.                                                                                   |
| resetStatistics()                     | Clear recorded transport listener/sender statistics and restart recording.                                                                         |
| pause()                               | Pause this transport listener/sender which has been started.                                                                                       |
| maintenenceShutdown(long gracePeriod) | Stop processing new messages, and wait the specified maximum time for in-flight requests to complete before a controlled shutdown for maintenance. |


