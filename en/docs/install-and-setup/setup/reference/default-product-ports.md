# Default Product Ports

This page describes the default ports used by each runtime of WSO2 API Manager.

!!! Attention
    **Note** that it is recommended to disable the HTTP transport in an API Manager production setup. Using the `Bearer` token over HTTP is a violation of the OAuth specification and can lead to security vulnerabilities.

!!! Note
    If you change the default runtime ports with a port offset, most of the runtime ports change automatically based on the offset.

## WSO2 API-M ports

Listed below are the ports used by the API-M runtime when the [port offset]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#configuring-the-port-offset) is 0.

-   5672 - Used by the internal Message Broker.
-   7611 - TCP port to receive throttling events. Required when Thrift data publisher is used for throttling.
-   7711 - SSL port for secure transport to receive throttling events. Required when Thrift data publisher is used for throttling.
-   8280 - Passthrough or NIO HTTP transport
-   8243 - Passthrough or NIO HTTPS transport
-   9611 - TCP port to receive throttling events. Required when Binary data publisher is used for throttling.
-   9711 - SSL port for secure transport to receive throttling events. Required when Binary data publisher is used for throttling.
-   9099 - Web Socket ports.

## WSO2 Micro Integrator ports

By default, the Micro Integrator is **internally** configured with a port offset of 10. Listed below are the ports that are effective in the Micro Integrator by default (due to the internal port offset of 10).

<table>
	<tr>
		<th>
			Default Port
		</th>
		<th>
			Description
		</th>
	</tr>
	<tr>
		<td>
			<code>8290</code>
		</td>
		<td>
			The port of the HTTP Passthrough transport.
		</td>
	</tr>
	<tr>
		<td>
			<code>8253</code>
		</td>
		<td>
			The port of the HTTPS Passthrough transport.
		</td>
	</tr>
	<tr>
		<td>
			<code>9201</code>
		</td>
		<td>
			The HTTP port of the <a href="{{base_path}}/observe/mi-observe/working-with-management-api">Management API</a> of WSO2 Micro Integrator.</br></br>
			<b>Configuring the default HTTP port</b></br>
			If required, you can manually change the HTTP port in the <code>deployment.toml</code> file (stored in the <code>MI_HOME/conf</code> folder) as shown below.</br></br>
			<div>
				<code>[mediation]</code></br>
				<code>internal.http.api.port = http_port </code></br>
			</div></br>
			<b>Note</b>: With the default internal port offset, the effective port will be <code>http_port + 10</code>.
		</td>
	</tr>
	<tr>
		<td>
			<code>9164</code>
		</td>
		<td>
			The HTTPS port of the <a href="{{base_path}}/observe/mi-observe/working-with-management-api">Management API</a> of WSO2 Micro Integrator.</br></br>
			<b>Configuring the default HTTPS port</b></br>
			If required, you can manually change the HTTPS port in the <code>deployment.toml</code> file (stored in the <code>MI_HOME/conf</code> folder) as shown below.</br></br>
			<div>
				<code>[mediation]</code></br>
				<code>internal_https_api_port = https_port </code>
			</div></br>
			<b>Note</b>: With the default internal port offset, the effective port will be <code>https_port + 10</code>.
		</td>
	</tr>
</table>

## Common ports

The following ports are common to all WSO2 products that provide the given feature. Some features are bundled in the WSO2 Carbon platform itself and therefore are available in all WSO2 products by default.

### Management console ports

WSO2 products that provide a management console use the following servlet transport ports:

-   9443 - HTTPS servlet transport (the default URL of the management console is https://localhost:9443/carbon)
-   9763 - HTTP servlet transport

### LDAP server ports

Provided by default in the WSO2 Carbon platform.

-   10389 - Used in WSO2 products that provide an embedded LDAP server

### KDC ports

-   8000 - Used to expose the Kerberos key distribution center server

### JMX monitoring ports

WSO2 Carbon platform uses TCP ports to monitor a running Carbon instance using a JMX client such as JConsole. By default, JMX is enabled in all products. You can disable it by adding the following configuration to `<PRODUCT_HOME>/repository/conf/deployment.toml` file.

``` toml
[monitoring.jmx]
rmi_server_start = false
```

-   11111 - RMIRegistry port. Used to monitor Carbon remotely
-   9999 - RMIServer port. Used along with the RMIRegistry port when Carbon is monitored from a JMX client that is behind a firewall

### Clustering ports

To cluster any running Carbon instance, either one of the following ports must be opened.

-   45564 - Opened if the membership scheme is multicast
-   4000 - Opened if the membership scheme is WKA

### Random ports

Certain ports are randomly opened during server startup. This is due to the specific properties and configurations that become effective when the product is started. Note that the IDs of these random ports will change every time the server is started.

-   A random TCP port will open at server startup because of the `-Dcom.sun.management.jmxremote` property is set in the server startup script. This property is used for the JMX monitoring facility in JVM.

-   A random UDP port is opened at server startup due to the log4j appender (`SyslogAppender`), which is configured in the `<PRODUCT_HOME>/repository/conf/log4j2.properties` file.

## Disabling HTTP Transports

API Manager has two HTTP transports. See below for instructions on how to disable the following:

1.  Passthru (API Traffic) Transport
2.  Servlet (UI Traffic and Admin service access) Transport

### Disabling Passthrough Transport

Add the following configuration in the `deployment.toml` file which resides in the `<API-M_HOME>/repository/conf` directory.

``` toml
[transport.passthru_http.listener]
enable = false
```

### Disabling Servlet Transport

1.  Open the `<API-M_HOME>/repository/conf/tomcat/catalina-server.xml` file.
2.  Locate the Connector with port 9763 as shown below:

    **HTTP Transport Receiver**

    ``` xml
    <Connector protocol="org.apache.coyote.http11.Http11NioProtocol" port="9763"
        ...
    />
    ```

3.  Comment out the HTTP connector section.

!!! note
    You need to restart the server for these changes to take effect.
