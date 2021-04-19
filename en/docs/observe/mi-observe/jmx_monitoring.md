# JMX Monitoring

Java Management Extensions (JMX) is a technology that lets you implement management interfaces for Java applications. A management interface, as defined by JMX is composed of named objects called MBeans (Management Beans). MBeans are registered with a name (an ObjectName) in an MBeanServer. To manage a resource or many resources in your application, you can write an MBean defining its management interface and register that MBean in your MBeanServer. The content of the MBeanServer can then be exposed through various protocols, implemented by protocol connectors, or protocol adaptors.

## Configuring JMX in Micro Integrator

With [**JConsole**](#monitoring-with-jconsole), you can attach the Micro Integrator as a local process and monitor the MBeans that are provided. There is nothing explicitly enable. 

## Monitoring with JConsole

Jconsole is a JMX-compliant monitoring tool, which comes with the Java
Development Kit (JDK) 1.5 and newer versions. You can find this tool
inside your `<JDK_HOME>/bin` directory.

### Starting JConsole
        
Once the **product server is started**, you can start the `JConsole` tool as follows:

1.  Open a command prompt and navigate to the `<JDK_HOME>/bin` directory.
2.  Execute the `jconsole` command to open the log-in screen of the **Java Monitoring & Management Console** as
    shown below.  
    
    ![jconsole_process]({{base_path}}/assets/img/integrate/jmx/jconsole-new-connection.png)

3.  Click on the  `org.wso2.micro.integrator.bootstrap.Bootstrap` process (which is the Micro Integrator) under the Local Process.
4.  Click **Connect** to open the **Java Monitoring & Management Console**. See the **Oracle** documentation on [using
    JConsole](http://docs.oracle.com/javase/7/docs/technotes/guides/management/jconsole.html). The following tabs will be available:  

    -   **Overview**
        ![jconsole overview]({{base_path}}/assets/img/integrate/jmx/jconsole-overview.png)
    -   **Memory**
        ![jconsole memory]({{base_path}}/assets/img/integrate/jmx/jconsole-memory.png)
    -   **Threads**
        ![jconsole threads]({{base_path}}/assets/img/integrate/jmx/jconsole-threads.png)
    -   **Classes**
        ![jconsole classes]({{base_path}}/assets/img/integrate/jmx/jconsole-classes.png)
    -   **VM**
        ![jconsole VM]({{base_path}}/assets/img/integrate/jmx/jconsole-vm-summary.png)
    -   **MBeans**
        ![jconsole MBeans]({{base_path}}/assets/img/integrate/jmx/jconsole-mbeans.png)

See the list of [Micro Integrator MBeans](#mbeans-for-wso2-micro-integrator) that you can monitor.

## MBeans for the Micro Integrator

When JMX is enabled, the Micro Integrator exposes a number of management resources as
JMX Management Beans (MBeans) that can be used for managing and
monitoring the running server.  When you start JConsole, you can monitor
these MBeans from the **MBeans** tab. Most of the MBeans are exposed from the underlying Synapse mediation engine.

![micro integrator mbeans]({{base_path}}/assets/img/integrate/jmx/mi-mbeans.png)

The following section summarizes the common MBeans for all WSO2 products:

### Connection MBeans

These MBeans provide connection statistics for the HTTP and HTTPS
transports.

You can view the following Connection MBeans:

-   `          org.apache.synapse/PassThroughConnections/http-listener         `
-   `          org.apache.synapse/PassThroughConnections/http-sender         `
-   `          org.apache.synapse/PassThroughConnections/https-listener         `
-   `          org.apache.synapse/PassThroughConnections/https-sender         `

**Attributes**

| Attribute Name                                       | Description                                                        |
|------------------------------------------------------|--------------------------------------------------------------------|
| `             ActiveConnections            `         | Number of currently active connections.                            |
| `             ActiveConnectionsPerHosts            ` | A map of the number of connections against hosts.                  |
| `             LastXxxConnections            `        | The number of connections created during last Xxx time period.     |
| `             RequestSizesMap            `           | A map of the number of requests against their sizes.               |
| `             ResponseSizesMap            `          | A map of the number of responses against their sizes.              |
| `             LastResetTime            `             | The time when the connection-statistic recordings were last reset. |

**Operations**

| Operation Name                     | Description                                                 |
|------------------------------------|-------------------------------------------------------------|
| `             reset()            ` | Clear recorded connection statistics and restart recording. |

### Latency MBeans

This view provides statistics of the latencies from all backend services
connected through the HTTP  and HTTPS transports. These statistics are
provided as an aggregate value.

You can view the following Latency MBeans:

-   `          org.apache.synapse/PassthroughLatencyView/nio-http-http         `
-   `          org.apache.synapse/PassthroughLatencyView/nio-https-https         `

**Attributes**

| Attribute Name                               | Description                                                                                                              |
|----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| `             AllTimeAvgLatency            ` | Average latency since the latency recording was last reset.                                                              |
| `             LastxxxAvgLatency            ` | Average latency for last xxx time period. For example, LastHourAvgLatency returns the average latency for the last hour. |
| `             LastResetTime            `     | The time when the latency-statistic recordings were last reset.                                                          |

**Operations**

| Operation Name                     | Description                                              |
|------------------------------------|----------------------------------------------------------|
| `             reset()            ` | Clear recorded latency statistics and restart recording. |

### Transport MBeans

For each transport listener and sender enabled in the Micro Integrator, there will be
an MBean under the `         org.apache.axis2/Transport        ` domain.
For example, when the JMS transport is enabled, the following MBean will
be exposed:

-   `          org.apache.axis2/Transport/jms-sender-                     n                   `

You can also view the following Transport MBeans:

-   `          org.apache.synapse/Transport/passthru-http-receiver         `
-   `          org.apache.synapse/Transport/passthru-http-sender         `
-   `          org.apache.synapse/Transport/passthru-https-receiver         `
-   `          org.apache.synapse/Transport/passthru-https-sender         `

**Attributes**

| Attribute Name                               | Description                                                                                                                    |
|----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| `             ActiveThreadCount            ` | Threads active in this transport listener/sender.                                                                              |
| `             AvgSizeReceived            `   | The average size of received messages.                                                                                         |
| `             AvgSizeSent            `       | The average size of sent messages.                                                                                             |
| `             BytesReceived            `     | The number of bytes received through this transport.                                                                           |
| `             BytesSent            `         | The number of bytes sent through this transport.                                                                               |
| `             FaultsReceiving            `   | The number of faults encountered while receiving.                                                                              |
| `             FaultsSending            `     | The number of faults encountered while sending.                                                                                |
| `             LastResetTime            `     | The time when the last transport listener/sender statistic recording was reset.                                                |
| `             MaxSizeReceived            `   | Maximum message size of received messages.                                                                                     |
| `             MaxSizeSent            `       | Maximum message size of sent messages.                                                                                         |
| `             MetricsWindow            `     | Time difference between current time and last reset time in milliseconds.                                                      |
| `             MinSizeReceived            `   | Minimum message size of received messages.                                                                                     |
| `             MinSizeSent            `       | Minimum message size of sent messages.                                                                                         |
| `             MessagesReceived            `  | The total number of messages received through this transport.                                                                  |
| `             MessagesSent            `      | The total number of messages sent through this transport.                                                                      |
| `             QueueSize            `         | The number of messages currently queued. Messages get queued if all the worker threads in this transport thread pool are busy. |
| `             ResponseCodeTable            ` | The number of messages sent against their response codes.                                                                      |
| `             TimeoutsReceiving            ` | Message receiving timeout.                                                                                                     |
| `             TimeoutsSending            `   | Message sending timeout.                                                                                                       |

**Operations**

| Operation Name                                                   | Description                                                                                                                                        |
|------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `             start()            `                               | Start this transport listener/sender.                                                                                                              |
| `             stop()            `                                | Stop this transport listener/sender.                                                                                                               |
| `             resume()            `                              | Resume this transport listener/sender which is currently paused.                                                                                   |
| `             resetStatistics()            `                     | Clear recorded transport listener/sender statistics and restart recording.                                                                         |
| `             pause()            `                               | Pause this transport listener/sender which has been started.                                                                                       |
| `             maintenenceShutdown(long gracePeriod)            ` | Stop processing new messages, and wait the specified maximum time for in-flight requests to complete before a controlled shutdown for maintenence. |

<!--
## Disabling the JMX thread view

Dumping JMX threads is an expensive operation that affects the CPU
consumption when many threads are being processed at the same time.

The Micro Integrator has enabled thread dumping by default. Therefore, to avoid
dumping all the threads
[here](https://github.com/wso2/wso2-synapse/blob/master/modules/commons/src/main/java/org/apache/synapse/commons/jmx/ThreadingView.java#L268), you can configure the property given below.

!!! Info
    It is recommended not to dump the thread especially when you have enabled analytics in a production environment.

1.  Open the `MI_HOME/conf/deployment.toml` file.
2.  Add the following property to the file and save the file.
    ```toml
    [synapse_properties]
    'synapse.jmx.thread.view.enabled'=false
    ```
-->
