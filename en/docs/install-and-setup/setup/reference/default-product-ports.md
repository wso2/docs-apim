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
            <code>10711</code>
        </td>
        <td>
            SSL port for the secure transport used in data publishing and analytics. This port is used for secure communication with analytics servers.
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
            <code>8099</code>
        </td>
        <td>
            Web Socket secure port (WSS).
        </td>
    </tr>
    <tr>
        <td>
            <code>9021</code>
        </td>
        <td>
            TCP port used for internal event streaming and communication between API-M components.
        </td>
    </tr>
    <tr>
        <td>
            <code>8021</code>
        </td>
        <td>
            Port used for internal event streaming communication.
        </td>
    </tr>
    <tr>
        <td>
            <code>8672</code>
        </td>
        <td>
            Port used for message broker AMQP transport with SSL.
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

## Random ports

Certain ports are randomly opened during server startup. This is due to the specific properties and configurations that become effective when the product is started. Note that the IDs of these random ports will change every time the server is started.

-   A random TCP port will open at server startup because the `-Dcom.sun.management.jmxremote` property is set in the server startup script. This property is used for the JMX monitoring facility in JVM.

-   A random UDP port is opened at server startup due to the log4j appender (`SyslogAppender`), which is configured in the `<PRODUCT_HOME>/repository/conf/log4j2.properties` file.
