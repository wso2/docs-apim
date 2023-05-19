# Default Product Ports

!!! Note
    If you [change the default runtime ports]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset-mi), most of the runtime ports change automatically based on the offset.

## Micro Integrator ports

By default, the Micro Integrator is **internally** configured with a port offset of 10. Listed below are the ports that are effective in the Micro Integrator by default (due to the internal port offset of 10).

!!! Info
    See the instructions on [changing the default MI ports]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset-mi/#changing-the-default-mi-ports).

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
                <code>internal_http_api_port = http_port </code></br>
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
