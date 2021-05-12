# Default Product Ports

This page describes the default ports used by each runtime of WSO2 API Manager.

!!! Attention
    **Note** that it is recommended to disable the HTTP transport in an API Manager production setup. Using the `Bearer` token over HTTP is a violation of the OAuth specification and can lead to security vulnerabilities.

!!! Note
    If you change the default runtime ports with a port offset, most of the runtime ports change automatically based on the offset.

## API-M ports

Listed below are the ports used by the API-M runtime when the [port offset]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#configuring-the-port-offset) is 0.

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
            <code>9443</code>
        </td>
        <td>
            Port of the HTTPS servlet transport. The default HTTPS URL of the management console is <code>https://localhost:9443/carbon</code>.
        </td>
    </tr>
    <tr>
        <td>
            <code>9763</code>
        </td>
        <td>
            Port of the HTTP servlet transport. The default HTTP URL of the management console is <code>http://localhost:9763/carbon</code>.
        </td>
    </tr>
    <tr>
        <td>
            <code>10389</code>
        </td>
        <td>
            Port of the embedded LDAP server.
        </td>
    </tr>
    <tr>
        <td>
            <code>5672</code>
        </td>
        <td>
            Port of the internal Message Broker of the API-M runtime.
        </td>
    </tr>
    <tr>
        <td>
            <code>8280</code>
        </td>
        <td>
            Port of the Passthrough or NIO HTTP transport.
        </td>
    </tr>
    <tr>
        <td>
            <code>8243</code>
        </td>
        <td>
            Port of the Passthrough or NIO HTTPS transport.
        </td>
    </tr>
    <tr>
        <td>
            <code>9611</code>
        </td>
        <td>
            TCP port to receive throttling events. This is required when the binary data publisher is used for throttling.
        </td>
    </tr>
    <tr>
        <td>
            <code>9711</code>
        </td>
        <td>
            SSL port of the secure transport for receiving throttling events. This is required when the binary data publisher is used for throttling.
        </td>
    </tr>
    <tr>
        <td>
            <code>9099</code>
        </td>
        <td>
            Web Socket ports.
        </td>
    </tr>
    <tr>
        <td>
            <code>8000</code>
        </td>
        <td>
            Port exposing the Kerberos key distribution center server.
        </td>
    </tr>
    <tr>
        <td>
            <code>45564</code>
        </td>
        <td>
            Opened if the membership scheme is multicast.
        </td>
    </tr>
    <tr>
        <td>
            <code>4000</code>
        </td>
        <td>
            Opened if the membership scheme is WKA.
        </td>
    </tr>
    <tr>
        <td>
            <code>11111</code>
        </td>
        <td>
            The RMIRegistry port. Used to monitor Carbon remotely.
        </td>
    </tr>
    <tr>
        <td>
            <code>9999</code>
        </td>
        <td>
            The MIServer port. Used along with the RMIRegistry port when Carbon is monitored from a JMX client that is behind a firewall
        </td>
    </tr>
</table>

## Micro Integrator ports

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

## Random ports

Certain ports are randomly opened during server startup. This is due to the specific properties and configurations that become effective when the product is started. Note that the IDs of these random ports will change every time the server is started.

-   A random TCP port will open at server startup because the `-Dcom.sun.management.jmxremote` property is set in the server startup script. This property is used for the JMX monitoring facility in JVM.

-   A random UDP port is opened at server startup due to the log4j appender (`SyslogAppender`), which is configured in the `<PRODUCT_HOME>/repository/conf/log4j2.properties` file.

## Disabling HTTP Transports

API Manager has two HTTP transports. See below for instructions on how to disable the following:

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

!!! Note
    You need to restart the server for these changes to take effect.