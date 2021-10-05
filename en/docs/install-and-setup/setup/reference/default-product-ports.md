# Default Product Ports

This page describes the default ports used by each runtime of WSO2 API Manager.

!!! Note
    If you [change the default runtime ports]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset), most of the runtime ports change automatically based on the offset.

## API-M ports

Listed below are the ports used by the API-M runtime when the [port offset]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#configuring-the-port-offset) is 0.

!!! Info
    See the instructions on [changing the default API-I ports]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#changing-the-default-api-m-ports).

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

!!! Info
    See the instructions on [changing the default MI ports]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#changing-the-default-mi-ports).

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

## Streaming Integrator Ports

Listed below are the default ports used by the Streaming Integrator runtime and the Streaming Integrator Tooling runtime. The default port offset in these runtimes are `0` and `3` respectively.

!!! Info
    See the instructions on [changing the default SI ports]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#changing-the-default-si-ports).

-  Thrift and Binary ports:

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
                  <code>7611</code>
            </td>
            <td>
                  Thrift TCP port to receive events from clients.
            </td>
         </tr>
         <tr>
            <td>
                  <code>7711</code>
            </td>
            <td>
                  Thrift SSL port for the secure transport where the client is authenticated.
            </td>
         </tr>
         <tr>
            <td>
                  <code>9611</code>
            </td>
            <td>
                  Binary TCP port to receive events from clients.
            </td>
         </tr>
         <tr>
            <td>
                  <code>9711 </code>
            </td>
            <td>
                  Binary SSL port for the secure transport where the client is authenticated.
            </td>
         </tr>
      </table>


-  Management ports:

    **Streaming Integrator runtime**

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
                  <code>9090</code>
            </td>
            <td>
                  HTTP netty transport.
            </td>
         </tr>
         <tr>
            <td>
                  <code>9443</code>
            </td>
            <td>
                  HTTPS netty transport.
            </td>
         </tr>
      </table>

    **Streaming Integrator Tooling runtime**:

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
                  <code>9390</code>
            </td>
            <td>
                  HTTP netty transport.
            </td>
         </tr>
         <tr>
            <td>
                  <code>9743</code>
            </td>
            <td>
                  HTTPS netty transport.
            </td>
         </tr>
      </table>

-  Streaming Integrator clustering ports:

      **Minimum High Availability (HA) Deployment**

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
                  <code>9090</code>
            </td>
            <td>
                  HTTP netty transport.
            </td>
         </tr>
         <tr>
            <td>
                  <code>9090</code>
            </td>
            <td>
                  The port of the node for the <code>advertisedPort</code> parameter in the <code>liveSync</code> section. The HTTP netty transport port is considered the default port.
            </td>
         </tr>
         <tr>
            <td>
                  <code>9443</code>
            </td>
            <td>
                  HTTPS netty transport.
            </td>
         </tr>
      </table>

      **Multi Datacenter High-Availability Deployment**

      In addition to the ports used in clustering setups (i.e. a minimum HA deployment or a scalable cluster), the following port is required:

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
                  <code>9092</code>
            </td>
            <td>
                  Ports of the two separate instances of the broker deployed in each data center (e.g., `bootstrap.servers= 'host1:9092, host2:9092'. The default is `9092` where the external kafka servers start.).
            </td>
         </tr>
      </table>

## Random ports

Certain ports are randomly opened during server startup. This is due to the specific properties and configurations that become effective when the product is started. Note that the IDs of these random ports will change every time the server is started.

-   A random TCP port will open at server startup because the `-Dcom.sun.management.jmxremote` property is set in the server startup script. This property is used for the JMX monitoring facility in JVM.

-   A random UDP port is opened at server startup due to the log4j appender (`SyslogAppender`), which is configured in the `<PRODUCT_HOME>/repository/conf/log4j2.properties` file.
