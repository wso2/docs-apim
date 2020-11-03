# Default Product Ports

This page describes the default ports that are used for each WSO2 product when the [port offset](_Changing_the_Default_Ports_with_Offset_) is 0.

!!! warning
    **Note** that it is recommended to disable the HTTP transport in an API Manager production setup. Using the `Bearer` token over HTTP is a violation of the OAuth specification and can lead to security vulnerabilities.


-   [Product-specific ports](#product-specific-ports)
-   [Disabling HTTP Transports](#disabling-http-transports)

#### Common ports

The following ports are common to all WSO2 products that provide the given feature. Some features are bundled in the WSO2 Carbon platform itself and therefore are available in all WSO2 products by default.

[Common ports](#common-ports) | [Management console ports](#management-console-ports) | [LDAP server ports](#ldap-server-ports) | [KDC ports](#kdc-ports) | [JMX monitoring ports](#jmx-monitoring-ports) | [Clustering ports](#clustering-ports) | [Random ports](#random-ports)

#### Management console ports

WSO2 products that provide a management console use the following servlet transport ports:

-   9443 - HTTPS servlet transport (the default URL of the management console is https://localhost:9443/carbon )
-   9763 - HTTP servlet transport

WSO2 API Manager (WSO2 APIM) uses the following ports to access the management console:

-   9443 - HTTPS servlet transport for the **APIM** runtime (the default URL of the management console is https://localhost:9443/carbon )
-   9444 - Used for the **APIM-Analytics** management console

#### LDAP server ports

Provided by default in the WSO2 Carbon platform.

-   10389 - Used in WSO2 products that provide an embedded LDAP server

#### KDC ports

-   8000 - Used to expose the Kerberos key distribution center server

#### JMX monitoring ports

WSO2 Carbon platform uses TCP ports to monitor a running Carbon instance using a JMX client such as JConsole. By default, JMX is enabled in all products. You can disable it by adding following configuration to `<PRODUCT_HOME>/repository/conf/deployment.toml` file.

``` java
    [monitoring.jmx]
    rmi_server_start = false
```

-   11111 - RMIRegistry port. Used to monitor Carbon remotely
-   9999 - RMIServer port. Used along with the RMIRegistry port when Carbon is monitored from a JMX client that is behind a firewall

#### Clustering ports

To cluster any running Carbon instance, either one of the following ports must be opened.

-   45564 - Opened if the membership scheme is multicast
-   4000 - Opened if the membership scheme is wka

#### Random ports

Certain ports are randomly opened during server startup. This is due to specific properties and configurations that become effective when the product is started. Note that the IDs of these random ports will change every time the server is started.

-   A random TCP port will open at server startup because of the `-Dcom.sun.management.jmxremote` property is set in the server startup script. This property is used for the JMX monitoring facility in JVM.
-   A random UDP port is opened at server startup due to the log4j appender ( `SyslogAppender` ), which is configured in the `<PRODUCT_HOME>/repository/conf/log4j.properties` file.

### Product-specific ports

Some products open additional ports.

[API Manager](#api-manager) | [BPS](#bps) | [Data Analytics Server](#data-analytics-server) | [Complex Event Processor](#complex-event-processor) | [Elastic Load Balancer](#elastic-load-balancer) | [ESB](#esb) | [Enterprise Integrator](#enterprise-integrator) | [Identity Server](#identity-server) | [Message Broker](#message-broker) | [Machine Learner](#machine-learner) | [Storage Server](#storage-server) | [Enterprise Mobility Manager](#enterprise-mobility-manager) | [IoT Server](#iot-server)

##### API Manager

-   5672 - Used by the internal Message Broker.
-   7611 - Authenticate data published when Thrift data publisher is used for throttling.
-   7612 - Publish Analytics to the API Manager Analytics server.
-   7711 - Port for secure transport when Thrift data publisher is used for throttling.
-   7711 + `Port offset of the APIM Analytics Server` - Thrift SSL port for secure transport when publishing analytics to the API Manager Analytics server.
-   8280, 8243 - NIO/PT transport ports.
-   9611 - Publish data to the Traffic Manager. Required when binary data publisher for throttling.
-   9711 - Authenticate data published to the Traffic Manager. Required when binary data publisher for throttling.
-   10397 - Thrift client and server ports.
-   9099 - Web Socket ports.

!!! note
    If you change the default API Manager ports with a port offset, most of its ports will be changed automatically according to the offset except a few exceptions described in the [APIM Manager documentation]({{base_path}}/reference/guides/changing-the-default-ports-with-offset/) .


##### BPS

-   2199 - RMI registry port (datasources provider port)

##### Data Analytics Server

Given below are the specific ports used by WSO2 DAS.

###### Ports inherited from WSO2 BAM

WSO2 DAS inherits the following port configurations used in its predecessor, [WSO2 Business Activity Monitor (BAM)](http://wso2.com/products/business-activity-monitor/) .

-   7711 - Thrift SSL port for secure transport, where the client is authenticated to use WSO2 DAS.
-   7611 - Thrift TCP port where WSO2 DAS receives events from clients.

###### Ports used by the Spark Analytics Engine

The Spark Analytics engine is used in 3 separate modes in WSO2 DAS as follows.

-   Local mode
-   Cluster mode
-   Client mode

Default port configurations for these modes are as follows.

!!! info
    For more information on these ports, go to [Apache Spark Documentation](http://spark.apache.org/docs/latest/security.html) .


-   **Ports available for all modes**
    The following ports are available for all three modes explained above.

    | Description                | Port number |
    |----------------------------|-------------|
    | spark.ui.port              | 4040        |
    | spark.history.ui.port      | 18080       |
    | spark.blockManager.port    | 12000       |
    | spark.broadcast.port       | 12500       |
    | spark.driver.port          | 13000       |
    | spark.executor.port        | 13500       |
    | spark.fileserver.port      | 14000       |
    | spark.replClassServer.port | 14500       |

-   **Ports available for the cluster mode**
    The following ports are available only for the cluster mode.

    | Description             | Port number |
    |-------------------------|-------------|
    | spark.master.port       | 7077        |
    | spark.master.rest.port  | 6066        |
    | spark.master.webui.port | 8081        |
    | spark.worker.port       | 11000       |
    | spark.worker.webui.port | 11500       |

##### Complex Event Processor

-   9160 - Cassandra port on which Thrift listens to clients
-   7711 - Thrift SSL port for secure transport, where the client is authenticated to CEP
-   7611 - Thrift TCP port to receive events from clients to CEP
-   11224 - Thrift TCP port for HA management of CEP

##### Elastic Load Balancer

-   8280, 8243 - NIO/PT transport ports

##### ESB

Non-blocking HTTP/S transport ports: Used to accept message mediation requests. If you want to send a request to an API or a proxy service for example, you must use these ports. ESB\_HOME}/repository/conf/axis2/axis2.xml file.

-   8243 - Passthrough or NIO HTTPS transport
-   8280 - Passthrough or NIO HTTP transport

##### Enterprise Integrator

###### Integration runtime ports

-   9443 - HTTPS servlet transport (the default URL of the management console is https://localhost:9443/carbon )

Non-blocking HTTP/S transport ports: Used to accept message mediation requests. If you want to send a request to an API or a proxy service for example, you must use these ports: `<EI_HOME>/conf/axis2/axis2.xml` file.

-   8243 - Passthrough or NIO HTTPS transport
-   8280 - Passthrough or NIO HTTP transport

###### EI-Analytics runtime ports

-   9444 - Management console port
-   9161 - Cassandra port on which Thrift listens to clients
-   7712 - Thrift SSL port for secure transport, where the client is authenticated to DAS
-   7612 - Thrift TCP port to receive events from clients to DAS

###### EI-Business Process runtime ports

-   9445 - HTTPS servlet transport (the default URL of the management console is https://localhost:9445/carbon )
-   9765 - HTTP servlet transport

###### EI-Broker runtime ports

-   9446 - HTTPS servlet transport (the default URL of the management console is https://localhost:9446/carbon )
-   9766 - HTTP servlet transport

EI-Broker uses the following JMS ports to communicate with external clients over the JMS transport.

-   5675 - Port for listening for messages on TCP when the AMQP transport is used.
-   8675 - Port for listening for messages on TCP/SSL when the AMQP Transport is used.
-   1886 - Port for listening for messages on TCP when the MQTT transport is used.
-   8836 - Port for listening for messages on TCP/SSL when the MQTT Transport is used.
-   7614 - The port for Apache Thrift Server.

##### Identity Server

-   8000 - KDCServerPort. Port which KDC (Kerberos Key Distribution Center) server runs
-   10500 - ThriftEntitlementReceivePort

##### Message Broker

Message Broker uses the following JMS ports to communicate with external clients over the JMS transport.

-   5672 - Port for listening for messages on TCP when the AMQP transport is used.
-   8672 - Port for listening for messages on TCP/SSL when the AMQP Transport is used.
-   1883 - Port for listening for messages on TCP when the MQTT transport is used.
-   8833 - Port for listening for messages on TCP/SSL when the MQTT Transport is used.
-   7611 - The port for Apache Thrift Server.

##### Machine Learner

-   7077 - The default port for Apache Spark.
-   54321 - The default port for H2O.
-   4040 - The default port for Spark UI.

##### Storage Server

Cassandra:

-   7000 - For Inter node communication within cluster nodes
-   7001 - For inter node communication within cluster nodes vis SSL
-   9160 - For Thrift client connections
-   7199 - For JMX

HDFS:

-   54310 - Port used to connect to the default file system.
-   54311 - Port used by the MapRed job tracker
-   50470 - Name node secure HTTP server port
-   50475 - Data node secure HTTP server port
-   50010 - Data node server port for data transferring
-   50075 - Data node HTTP server port
-   50020 - Data node IPC server port

##### Enterprise Mobility Manager

The following ports need to be opened for Android and iOS devices so that it can connect to Google Cloud Messaging (GCM)/Firebase Cloud Messaging (FCM) and APNS (Apple Push Notification Service) and enroll to WSO2 EMM.

Android:
The ports to open are 5228, 5229 and 5230. GCM/FCM typically only uses 5228, but it sometimes uses 5229 and 5230.
GCM/FCM does not provide specific IPs, so it is recommended to allow the firewall to accept outgoing connections to all IP addresses contained in the IP blocks listed in Google's ASN of 15169.

iOS:

-   5223 - TCP port used by devices to communicate to APNs servers
-   2195 - TCP port used to send notifications to APNs
-   2196 - TCP port  used by the APNs feedback service
-   443 - TCP port used as a fallback on Wi-Fi, only when devices are unable to communicate to APNs on port 5223
    The APNs servers use load balancing. The devices will not always connect to the same public IP address for notifications. The entire 17.0.0.0/8 address block is assigned to Apple, so it is best to allow this range in the firewall settings.

API Manager:

!!! info
    The following WSO2 API Manager ports are only applicable to WSO2 EMM 1.1.0 onwards.


-   10397 - Thrift client and server ports
-   8280, 8243 - NIO/PT transport ports

##### IoT Server

The following ports need to be opened for WSO2 IoT Server, and Android and iOS devices so that it can connect to Google Cloud Messaging (GCM)/Firebase Cloud Messaging (FCM) and APNS (Apple Push Notification Service), and enroll to WSO2 IoT Server.

###### Default ports

|      |                                       |
|------|---------------------------------------|
| 8243 | HTTPS gateway port.                   |
| 9443 | HTTPS port for the core profile.      |
| 8280 | HTTP gateway port.                    |
| 9763 | HTTP port for the core profile.       |
| 1886 | Default MQTT port.                    |
| 9445 | HTTPS port for the analytics profile. |
| 9765 | HTTP port for the analytics profile.  |
| 1039 | HTTP port for the analytics profile   |

###### Ports required for mobile devices to communicate with the server and the respective notification servers.

<table>
<thead>
<tr class="header">
<th><br />
</th>
<th>Android</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>5228</p>
<p>5229</p>
<p>5230</p></td>
<td>The ports to open are 5228, 5229 and 5230. Google Cloud Messaging (GCM) and Firebase Cloud Messaging (FCM) typically only uses 5228, but it sometimes uses 5229 and 5230.<br />
GCM/FCM does not provide specific IPs, so it is recommended to allow the firewall to accept outgoing connections to all IP addresses contained in the IP blocks listed in Google's ASN of 15169.</td>
</tr>
<tr class="even">
<td><br />
</td>
<td>iOS</td>
</tr>
<tr class="odd">
<td>5223</td>
<td>Transmission Control Protocol (TCP) port used by devices to communicate to APNs servers.</td>
</tr>
<tr class="even">
<td>2195</td>
<td>TCP port used to send notifications to APNs.</td>
</tr>
<tr class="odd">
<td>2196</td>
<td>TCP port used by the APNs feedback service.</td>
</tr>
<tr class="even">
<td>443</td>
<td><p>TCP port used as a fallback on Wi-Fi, only when devices are unable to communicate to APNs on port 5223.</p>
<p>The APNs servers use load balancing. The devices will not always connect to the same public IP address for notifications. The entire 17.0.0.0/8 address block is assigned to Apple, so it is best to allow this range in the firewall settings.</p></td>
</tr>
</tbody>
</table>

### Disabling HTTP Transports

API Manager has two HTTP transports. See below for instructions on how to disable the following:

1.  Passthru (API Traffic) Transport
2.  Servlet (UI Traffic and Admin service access) Transport

##### Disabling Passthrough Transport

1.  Open the `<API-M_HOME>/repository/conf/axis2/axis2.xml` file.
2.  Locate the Transport receiver http as shown below:

    **HTTP Transport Receiver**

    ``` xml
        <transportReceiver name="http" class="org.apache.synapse.transport.passthru.PassThroughHttpListener">
            ...     
        </transportReceiver>
    ```

3.  Comment out the http transport receiver section.

##### Disabling Servlet Transport

1.  Open the `<API-M_HOME>/repository/conf/tomcat/catalina-server.xml` file.
2.  Locate the Connector with the port 9763 as shown below:

    **HTTP Transport Receiver**

    ``` xml
            <Connector protocol="org.apache.coyote.http11.Http11NioProtocol" port="9763"
                ...
            />
    ```

3.  Comment out the http connector section.

!!! note
The Server needs to be restarted for these changes to be effective.


