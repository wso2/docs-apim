# Configuring Transports

A transport protocol is responsible for carrying messages that are in a specific format. WSO2 Micro Integrator supports all the widely used transports including HTTP/S, JMS, VFS, as well as domain-specific transports like FIX. Each transport provides a receiver implementation for receiving messages, and a sender implementation for sending messages.

## Configuring the HTTP/HTTPS transport

The HTTP and HTTPS passthrough transports are enabled by default in the Micro Integrator.

See the following sections for a complete list of HTTP/HTTPS parameter.

- [HTTP/S Transport (non-blocking mode)]({{base_path}}/reference/config-catalog-mi/#https-transport-non-blocking-mode)
- [HTTP/S Transport (blocking mode)]({{base_path}}/reference/config-catalog-mi/#https-transport-blocking-mode)

### Number of HTTP Listeners

The default HTTP transport (PassThrough transport) of WSO2 Micro Integrator has 4 HTTP/HTTPS listeners configured. This includes 2 `PassThroughHttpListener` threads and 2 `PassThroughHttpSSLListener` threads.

You can configure the number of listeners for the HTTP transport in the deployment.toml file:

```toml
[passthru_properties]
io_threads_per_reactor=2
```

You are able to define any number of listeners (by updating the `io_threads_per_reactor` value) as there is no maximum limit defined in the code level.

!!! Note
    The number of listener threads is double the value of the `io_threads_per_reactor` property because the same number of `PassThroughHttpListener` and `PassThroughHttpSSLListener` threads are created. For example, if you defined the value for the `io_threads_per_reactor` property as 5, you have 5 `PassThroughHttpListener` threads and 5 `PassThroughHttpSSLListener` threads. Therefore, the total number of listeners are 10.

### Connection Throttling

With the default HTTP transport (PassThrough transport) you can enable connection throttling to restrict the number of simultaneous open connections.

To enable connection throttling, update the following property in the `deployment.toml` file:

```toml
[transport.http]
max_open_connections = 2
```

This will restrict simultaneous open incoming connections to 2. To disable throttling, delete the `max_open_connections` setting or set it to -1.

!!! Info
    Connection throttling is never exact. For example, setting this property to 2 will result in roughly two simultaneous open connections at any given time.

### Verifying certificate revocation

The default HTTPS transport listener (Secured Passthrough) and transport sender can verify with the certificate authority whether a certificate is still trusted before it completes an SSL connection. If the certificate authority has revoked the certificate, a connection will not be completed.

When this feature is enabled, the transport listener verifies client
certificates when a client tries to make an HTTPS connection with the
Micro Integrator. The transport sender verifies server
certificates when the Micro Integrator tries to make an HTTPS
connection with a backend server. 

When this feature is enabled, the Micro Integrator attempts to
use the Online Certificate Status Protocol (OCSP) to verify with the
certificate authority at the handshake phase of the SSL protocol. If the
OCSP is not supported by the certificate authority, the Micro Integrator uses Certified Revocation Lists (CRL) instead. The verification
process checks all the certificates in a certificate chain.

To enable this feature for the HTTP passthrough, add the following parameters for the HTTP transport receiver and sender in the deployment.toml file:

```toml tab='Passthrough Listener'
[transport.http]
listener.certificate_revocation_verifier_enable = true
listener.certificate_revocation_cache_size = 1024
listener.certificate_revocation_cache_delay = 1000

```

```toml tab='Passthrough Sender'
[transport.http]
sender.certificate_revocation_verifier_enable = true
sender.certificate_revocation_cache_size = 1024
sender.certificate_revocation_cache_delay = 1000
```

### Configuring Transport Level Security  

Micro Integrator supports both SSL and TLS protocols. But since the SSL protocol is vulnerable to Poodle attacks, it is necessary to make sure that only TLS protocol versions are enabled.

!!! Note
    It is necessary to disable SSL in Carbon servers because of a bug (Poodle Attack) in the SSL protocol that could expose critical data encrypted between clients and servers. The Poodle Attack makes the system vulnerable by telling the client that the server does not support the more secure TLS (Transport Layer Security) protocol, and thereby forces it to connect via SSL. The effect of this bug can be mitigated by disabling the SSL protocol for your server.

To configure the enabled protocols, update the following property in the deployment.toml file:
```toml
[transport.http]
listener.secured_protocols = "TLSv1,TLSv1.1,TLSv1.2"
sender.secured_protocols = "TLSv1,TLSv1.1,TLSv1.2"
```
### Disabling weak ciphers

A cipher is an algorithm for performing encryption or decryption. When you set the sslprotocol of your server to TLS, the TLS and the default ciphers get enabled without considering the strength of the ciphers. This is a security risk as weak ciphers, also known as EXPORT ciphers, can make your system vulnerable to attacks such as the Logjam attack on Diffie-Hellman key exchange. The Logjam attack is also called the Man-in-the-Middle attack. It downgrades your connection's encryption to a less-secured level (e.g., 512 bit) that can be decrypted with sufficient processing power.

To prevent these types of security attacks, it is encouraged to disable the weak ciphers. You can enable only the ciphers that you want the server to support in a comma-separated list in the ciphers  attribute.

To configure the enabled ciphers, update the following property in the deployment.toml file:
```toml
[transport.https]
listener.parameter.PreferredCiphers = "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256"
```

!!! Note
    To check the above configuration changes related to SSL. Download [TestSSLServer.jar](https://docs.wso2.com/download/attachments/53125465/TestSSLServer.jar?version=1&modificationDate=1471859455000&api=v2) and test with the following command.

    $ java -jar TestSSLServer.jar localhost 8253

## Configuring the VFS transport

This transport is used to process files in a specified source directory. After processing the files, the files are moved to a specified location or deleted. Note that files cannot remain in the source directory after processing because they will be processed again. Therefore, if you need to maintain these files or keep track of which files have been processed, specify the option to move them instead of deleting them after processing. If you want to move files into a database, use the VFS transport and the [DBReport Mediator]({{base_path}}/reference/mediators/db-report-mediator).

!!! Note
    When you transfer a file to a remote FTP location via VFS, the integrator tries to detect the FTP location by navigating from the root folder first. If the integrator does not have <b>at least list permission</b> to the root (/), the file transfer fails.

The VFS transport is enabled in the Micro Integrator server by default. Also, the VFS transport does not have any global parameters that can apply to all VFS use cases. Rather, it has a set of service-level parameters that must be specified when you create a proxy service or REST API artifact. The VFS transport supports the **SFTP protocol** with **Secure Sockets Layer (SSL)**. The configuration is identical to other protocols with the only difference being the URL prefixes and parameters.

For more information, see [service-level VFS parameters]({{base_path}}/reference/synapse-properties/transport-parameters/vfs-transport-parameters).

## Configuring the TCP transport

To enable the TCP transport listener and sender, set the following parameters to `true` in the deployment.toml file (stored in the `MI_HOME/conf` directory).

Change the listener port as required.

```toml
[transport.tcp]
listener.enable = true
listener.port = 6060
sender.enable = true
```

## Configuring the MSMQ transport

To enable the MSMQ transport listener and sender, set the following parameters to `true` in the deployment.toml file (stored in the `MI_HOME/conf` directory).

```toml
[transport.msmq]
listener.enable = false
sender.enable = false
```
<b>Note</b> the following:
<ul>
    <li>The MSMQ examples only work on Windows since they invoke the Microsoft C++ API for MSMQ via JNDI invocation.</li>
    <li>Download the `axis2-transport-msmq-2.0.0-wso2v2.jar` file and add it to the `MI_HOME/dropins` directory. This file provides the JNI invocation required by MSMQ bridging.</li>
    <li>Make sure that MQ is installed and running. For more information, see <http://msdn.microsoft.com/en-us/library/aa967729.aspx>.
    </li>
    <li>Make sure that you have installed Visual C++ 2008 (VC9) and that it works with Microsoft Visual Studio 2008 Express.
    </li>
</ul>

<!--

## Configuring the HL7 transport

To enable the HL7 transport listener and sender, set the following parameters to `true` in the deployment.toml file (stored in the `MI_HOME/conf` directory).

```toml
[transport.hl7]
listener.enable = false
sender.enable = false
```

Add the following sections to the deployment.toml file to enable the required message builders and formatters:

```toml tab='Message Builder'
[[custom_message_builders]]
content_type = "application/edi-hl7"
class="org.wso2.carbon.business.messaging.hl7.message.HL7MessageBuilder"
```

```toml tab='Message Formatter'
[[custom_message_formatters]]
content_type = "application/edi-hl7"
class="org.wso2.carbon.business.messaging.hl7.message.HL7MessageFormatter"
```
-->

## Configuring the FIX transport

This transport implementation is a module developed under the Apache Synapse project and it supports JMX. This transport is mainly used in conjunction with proxy services. FIX transport does not support any global parameters. All the FIX configuration parameters should be specified at service level. QuickFix 4J configuration parameters can be found <a href="http://www.quickfixengine.org/quickfix/doc/html/configuration.html">here</a>.

To enable the FIX transport listener and sender, set the following parameters to `true` in the deployment.toml file (stored in the `MI_HOME/conf` directory).

```toml
[transport.fix]
listener.enable = false
sender.enable = false   
```

Download **Quickfix/J**. In the distribution archive you will find all the dependencies listed below. Add these JARs to the `<MI_HOME>/libs` folder.

!!! Note
    See the [Quickfix/J](https://www.quickfixj.org/) documentation on configuring FIX acceptors and initiators.

-	mina-core.jar
-	quickfixj-core.jar
-	quickfixj-messages-fix40.jar
-	quickfixj-messages-fix41.jar
-	quickfixj-messages-fix42.jar
-	quickfixj-messages-fix43.jar
-	quickfixj-messages-fix44.jar
-	slf4j-api.jar
-	slf4j-log4j12.jar

Also [download](https://logging.apache.org/log4j/1.2/download.html) the following JAR and add it to the `<MI_HOME>/libs` folder.

-   log4j-1.2.17.jar

### Configuring Sample FIX Applications

If you are using a binary distribution of Quickfix/J, the two samples (FIX messages sender/reveiver) and their configuration files are all packed to two JAR files called
`quickfixj-examples-banzai-2.1.1.jar` and `quickfixj-examples-executor-2.1.1.jar`. You will have to extract the
JAR file, modify the configuration files and pack them to a JAR file
again under the same name.

Change the banzai.cfg file in quickfixj-examples-banzai-2.1.1.jar (/quickfix/examples/banzai) by changing `TargetCompID` to `SYNAPSE`

```
[default]
FileStorePath=target/data/banzai
ConnectionType=initiator
SenderCompID=BANZAI
TargetCompID=SYNAPSE
SocketConnectHost=localhost
StartTime=00:00:00
EndTime=00:00:00
HeartBtInt=30
ReconnectInterval=5

[session]
BeginString=FIX.4.0
SocketConnectPort=9876

[session]
BeginString=FIX.4.1
SocketConnectPort=9877

[session]
BeginString=FIX.4.2
SocketConnectPort=9878

[session]
BeginString=FIX.4.3
SocketConnectPort=9879

[session]
BeginString=FIX.4.4
SocketConnectPort=9880

[session]
BeginString=FIXT.1.1
DefaultApplVerID=FIX.5.0
SocketConnectPort=9881
```

Edit the executor.cfg file in quickfixj-examples-executor-2.1.1.jar (/quickfix/examples/executor) by changing `TargetCompID` to `SYNAPSE` and changing `SocketAcceptPort` to `19876`.

```
[default]
FileStorePath=target/data/executor
ConnectionType=acceptor
StartTime=00:00:00
EndTime=00:00:00
HeartBtInt=30
ValidOrderTypes=1,2,F
SenderCompID=EXEC
TargetCompID=SYNAPSE
UseDataDictionary=Y
DefaultMarketPrice=12.30

[session]
BeginString=FIX.4.0
SocketAcceptPort=19876

[session]
BeginString=FIX.4.1
SocketAcceptPort=9877

[session]
BeginString=FIX.4.2
SocketAcceptPort=9878

[session]
BeginString=FIX.4.3
SocketAcceptPort=9879

[session]
BeginString=FIX.4.4
SocketAcceptPort=9880

[session]
BeginString=FIXT.1.1
DefaultApplVerID=FIX.5.0
SocketAcceptPort=9881
```

## Configuring the MQTT transport

To enable the MQTT transport listener and sender, set the following parameters to `true` in the `deployment.toml` file (stored in the `MI_HOME/conf` directory).

```toml
[transport.mqtt]
listener.enable = false
sender.enable = false
```
## Configuring the Websocket transport

To enable the Websocket transport sender, set the following parameters to `true` in the `deployment.toml` file (stored in the `MI_HOME/conf` directory).

```toml
[transport.ws]
sender.enable = false
```

To enable the **secured** Websocket transport sender, set the following parameters to `true` in the `deployment.toml` file (stored in the `MI_HOME/conf` directory.

```toml
[transport.wss]
sender.enable = false
```

## Configuring the UDP transport

To enable the MSMQ transport listener and sender, set the following parameters to `true` in the `deployment.toml` file (stored in the `MI_HOME/conf` directory).

```toml
[transport.udp]
listener.enable = false
sender.enable =false
```

## Configuring custom transports
Other than the transports defined above, you can use a custom transport that enables you to add a new transport to the Micro Integrator. Custom transport configurations contain senders and listeners that you can define. A custom transport configuration is as follows.

```toml tab='Custom Listener'
[[custom_transport.listener]]
class="org.wso2.micro.integrator.TransportListener"
protocol = "protocol"
```

```toml tab='Custom Sender'
[[custom_transport.sender]]
class="org.wso2.micro.integrator.TransportSender"
protocol = "protocol"
parameter.'transport.param' = true
```

You can define the listener and sender classes in the `class` parameter. Any additional parameter can be passed to the configuration using `parameter`. The following section involves using a custom transport to configure HL7 transport.

## Configuring the HL7 transport

The HL7 transport allows you to handle Health Level 7 International (HL7) messages. 

### Adding the transport

HL7 is not shipped by default in the pack. To make the transport available, download the [HL7_ZIP](https://github
.com/wso2-docs/WSO2_EI/raw/master/micro-integrator-resources/hl7/1.2.0/wso2mi-hl7-1.2.0.zip), extract it, and copy both
 the .jar files inside it to the `<MI_HOME>/dropins` folder.

### Enabling the transport

Add the following configurations to the `deployment.toml` file (stored in the `<MI_HOME>/conf` folder): 

```toml tab='HL7 Listener'
[[custom_transport.listener]]
class="org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportListener"
protocol = "hl7"
parameter.'transport.hl7.TimeOut' = 10000
```

```toml tab='HL7 Sender'
[[custom_transport.sender]]
class="org.wso2.micro.integrator.business.messaging.hl7.transport.HL7TransportSender"
protocol = "hl7"
```

You can configure how long request threads wait for the application's response by specifying the `parameter.'transport.hl7.TimeOut'` parameter as shown above. This configures the timeout in milliseconds at the transport level.

### Change message encoding type

To control the encoding type of incoming HL7 messages, set the following JAVA system property: `ca.uhn.hl7v2.llp.charset`.

## Configuring the MailTo transport

When you use the Micro Integrator to mediate messages, the mediation sequence can be configured to send emails (over SMTP) or receive emails (Over POP3 or IMAP) by using the MailTo transport protocol.

The MailTo transport listener implementation can be configured by setting the parameters as described in the JavaMail API documentation. For IMAP related properties, see [IMAP Package Summary](https://javaee.github.io/javamail/docs/api/com/sun/mail/imap/package-summary.html). For POP3 properties, see [POP3 Package Summary](https://javaee.github.io/javamail/docs/api/com/sun/mail/pop3/package-summary.html). The MailTo transport listener also supports the following transport parameters in addition to the parameters described in the JavaMail API documentation.

- Configuring the MailTo listener

    The MailTo transport listener is enabled by default. For more information, see [About MailTo Transport]({{base_path}}/reference/synapse-properties/transport-parameters/mailto-transport-parameters).

    See the [complete list of MailTo parameters]({{base_path}}/reference/config-catalog-mi/#mail-transport-listener-non-blocking-mode).

- Configuring the MailTo sender

	```toml
	[[transport.mail.sender]]
	name = "mailto"
	parameter.hostname = "smtp.gmail.com"
	parameter.port = "587"
	parameter.enable_tls = true
	parameter.auth = true
	parameter.username = "demo_user"
	parameter.password = "mailpassword"
	parameter.from = "demo_user@wso2.com"
	```

	!!! Note
		In addition to enabling the MailTO transport, the following parameters are used in the above configuration to set a default email account as the mail sender. You can override this default mail sender by specifying an email sender account within your mediation sequence.

		-	`parameter.from` : The email address from which mails will be sent.
		-	`parameter.username` : The user name of the email account (mail sender). Note that in some email service providers, the user name is the same as the email address specified for the 'From' parameter.
		-	`parameter.password` : The password of the email account (mail sender).

	If you want to use multiple mail boxes to send emails, make a copy of the default MailTo sender configuration in the `MI_HOME/conf/deployment.toml` file and change the transport sender name. For example, add `mailtoWSO2` as the name.

	For a list of parameters supported by the MailTo transport sender, see [SMTP Package Summary](https://javaee.github.io/javamail/docs/api/com/sun/mail/smtp/package-summary.html). You can add these parameters into the mail transport as custom parameters by appending relevant parameters surrounded by single quotes into the parameter section. For example, to add `mail.smtp.localport` parameter into the mail transport, toml configuration would be `parameter.'mail.smtp.localport'=5000`.

	In addition to the parameters described there, the MailTo transport sender supports the following custom parameters.

	-	`transport.mail.SMTPBccAddresses`: If one or more e-mail addresses need to be specified as BCC addresses for outgoing mails, this parameter can be used. You can enter a comma-separated list of e-mail addresses.
	-	`transport.mail.Format`: Format of the outgoing mail. Possible values are <b>Text</b> and <b>Multipart</b>.

## Configuring the JMS transport

The Java Message Service (JMS) transport in WSO2 Micro Integrator allows you to easily send and receive messages to queues and topics of any JMS service that implements the JMS specification.

Java Message Service (JMS) is a widely used API in Java-based Message Oriented Middleware(MOM) applications. It facilitates loosely coupled, reliable, and asynchronous communication between different components of a distributed application. It supports two asynchronous communication models for messaging as follows:

<ul>
   <li><b>Point-to-point model</b>: In this model message communication happens from one JMS client to another JMS client through a dedicated queue.</li>
   <li><b>Publish and subscribe model</b>:  In this model message communication happens from one JMS client(publisher) to many JMS clients(subscribers) through a topic.</li>
</ul>
JMS supports two models for messaging as follows:
<ul>
   <li><b>Queues</b>: point-to-point.</li>
   <li><b>Topics</b>: publish and subscribe.</li>
</ul>
The Micro Integrator supports the following messaging features introduced with JMS 2.0:
<ul>
   <li>Shared Topic Subscription</li>
   <li>JMSX Delivery Count</li>
   <li>JMS Message Delivery Delay</li>
</ul>

The JMS transport implementation comes from the WS-Commons Transports project, and it makes use of JNDI to connect to various JMS brokers. As a result, WSO2 Micro Integrator can work with any JMS broker that offers JNDI support.

To enable the JMS transport sender and listener in the Micro Integrator, you need to update the deployment.toml file (stored in the `MI_HOME/conf` directory) with the connection parameters for your JMS broker you are using. **Be sure** to add the required libraries to the `MI_HOME/lib` directory.

See the following topics for instructions on how to configure the Micro Integrator with different types of brokers:

-	[Connecting to ActiveMQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-activemq)
-	[Connecting to Apache Artemis]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-apache-artemis)
-	[Connecting to HornetQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-hornetq)
-	[Connecting to IBM WebSphere App Server]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-ibm-websphere-app-server)
-	[Connecting to IBM WebSphere MQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-ibm-webspheremq)
-	[Connecting to JBossMQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-jbossmq)
-	[Connecting to MSMQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-msmq)
-	[Connecting to RabbitMQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-rabbitmq)
-	[Connecting to SwiftMQ]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-swiftmq)
-	[Connecting to Tibco EMS]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-tibco-ems)
-	[Connecting to Oracle Weblogic]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-weblogic)
-	[Connecting to WSO2 MB]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-wso2-mb)
-	[Connecting to Multiple Brokers]({{base_path}}/install-and-setup/setup/mi-setup/brokers/configure-with-multiple-brokers)


## Configuring the Multi-HTTPS transport

This transport is similar to the HTTPS passthrough transport, but it allows you to have different SSL profiles with separate truststores and keystores for different hosts using the same WSO2 Micro Integrator. It can listen to different host IPs and ports for incoming HTTPS connections, and each IP/Port will have a separate SSL profile configured.
