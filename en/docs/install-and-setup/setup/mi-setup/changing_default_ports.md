# Changing the Default Ports

When you run multiple WSO2 Micro Integrator instances or a cluster of instances on a single server or virtual machine (VM),
you must change the default ports to avoid port conflicts.

## Micro Integrator ports

### Default ports

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

### Changing default MI ports

There are two ways to manually offset the [default ports](#default-ports).

!!! Tip
	-	The internal offset of 10 is overriden by this manual offset. That is, if the manual offset is 3, the default ports will change as follows:
		- `8290` -> `8283` (8290 - 10 + 3)
		- `8253` -> `8246` (8253 - 10 + 3)
		- `9164` -> `9157` (9164 - 10 + 3)
	-	Note that if you manually set an offset of 10 using the following method, you will get the same [default ports](#default-ports).

-   Pass the port offset to the server during startup.

    ```bash tab='On MacOS/Linux/Centos'
    ./micro-integrator.sh -DportOffset=3
    ```

    ```bash tab='On Windows'
    micro-integrator.bat -DportOffset=3
    ```

-   Open the `deployment.toml` file (stored in the `MI_HOME/conf` folder) and add the port offset as follows:

    ```toml
    [server]
    offset = 3
    ```

## EI Analytics ports

By default, EI Analytics is **internally** configured with a port offset of 1. Listed below are the ports that are effective in EI Analytics by default (due to the internal port offset of 1).

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
    		<code>9645</code>
    	</td>
    	<td>
    		The port of the EI Analytics Portal.
    	</td>
    </tr>
	<tr>
		<td>
			<code>9091</code>
		</td>
		<td>
			The HTTP port of the management API of EI Analytics.
		</td>
	</tr>
	<tr>
		<td>
			<code>9444</code>
		</td>
		<td>
			The HTTPS port of the management API of EI Analytics.
		</td>
	</tr>    
	<tr>
    	<td>
    		<code>7712</code>
    	</td>
    	<td>
    		Thrift SSL port (for the secure transport) on which the client is authenticated when accessing EI Analytics.
    	</td>
    </tr>
	<tr>
    	<td>
    		<code>7612</code>
    	</td>
    	<td>
    		Thrift TCP port on which EI Analytics receives events from clients
    	</td>
    </tr>
</table>

### Changing default EI Analytics ports

If required, you can manually change the HTTP/HTTPS ports in the <code>deployment.yaml</code> file (stored in <code>EI_ANALYTICS_HOME/conf/server</code> folder) as shown below.

!!! Note
    	With the default internal port offset, the effective port will be <code>https_port + 1</code>.

```yaml tab='HTTPS Port'
wso2.transport.http:            
listenerConfigurations:
-
	id: "msf4j-https"
	host: "0.0.0.0"
	port: https_port
	scheme: https
```

```yaml tab='HTTP Port'
wso2.transport.http:
listenerConfigurations:
-
  id: "default"
  host: "0.0.0.0"
  port: http_port
```

## Random ports

Certain ports are randomly opened during server startup. This is due to
specific properties and configurations that become effective when the
product is started. Note that the IDs of these random ports will change
every time the server is started.

-   A random TCP port will open during server startup because of the
    `-Dcom.sun.management.jmxremote` property set in
    the server startup script. This property is used for the
    JMX monitoring facility in JVM.
-   A random UDP port is opened at server startup due to the log4j
    appender (`SyslogAppender`), which is configured in the `<MI_HOME>/conf/log4j2.properties` file.
