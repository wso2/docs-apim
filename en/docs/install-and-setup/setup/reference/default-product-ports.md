# Default Product Ports

This page describes the default ports that are used for each WSO2 product when the [port offset]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset/#configuring-the-port-offset) is 0.

!!! Attention
    **Note** that it is recommended to disable the HTTP transport in an API Manager production setup. Using the `Bearer` token over HTTP is a violation of the OAuth specification and can lead to security vulnerabilities.


-   [Product-specific ports](#product-specific-ports)
-   [Disabling HTTP Transports](#disabling-http-transports)

## Common ports

The following ports are common to all WSO2 products that provide the given feature. Some features are bundled in the WSO2 Carbon platform itself and therefore are available in all WSO2 products by default.

### Management console ports

WSO2 products that provide a management console use the following servlet transport ports:

-   9443 - HTTPS servlet transport (the default URL of the management console is https://localhost:9443/carbon )
-   9763 - HTTP servlet transport

### LDAP server ports

Provided by default in the WSO2 Carbon platform.

-   10389 - Used in WSO2 products that provide an embedded LDAP server

### KDC ports

-   8000 - Used to expose the Kerberos key distribution center server

### JMX monitoring ports

WSO2 Carbon platform uses TCP ports to monitor a running Carbon instance using a JMX client such as JConsole. By default, JMX is enabled in all products. You can disable it by adding following configuration to `<PRODUCT_HOME>/repository/conf/deployment.toml` file.

``` toml
[monitoring.jmx]
rmi_server_start = false
```

-   11111 - RMIRegistry port. Used to monitor Carbon remotely
-   9999 - RMIServer port. Used along with the RMIRegistry port when Carbon is monitored from a JMX client that is behind a firewall

### Clustering ports

To cluster any running Carbon instance, either one of the following ports must be opened.

-   45564 - Opened if the membership scheme is multicast
-   4000 - Opened if the membership scheme is wka

### Random ports

Certain ports are randomly opened during server startup. This is due to specific properties and configurations that become effective when the product is started. Note that the IDs of these random ports will change every time the server is started.

-   A random TCP port will open at server startup because of the `-Dcom.sun.management.jmxremote` property is set in the server startup script. This property is used for the JMX monitoring facility in JVM.

-   A random UDP port is opened at server startup due to the log4j appender ( `SyslogAppender` ), which is configured in the `<PRODUCT_HOME>/repository/conf/log4j2.properties` file.

### WSO2 API Manager ports

-   5672 - Used by the internal Message Broker.
-   7611 - Authenticate data published when Thrift data publisher is used for throttling.
-   7612 - Publish Analytics to the API Manager Analytics server.
-   7711 - Port for secure transport when Thrift data publisher is used for throttling.
-   7711 + `Port offset of the APIM Analytics Server` - Thrift SSL port for secure transport when publishing analytics to the API Manager Analytics server.
-   8280 - Passthrough or NIO HTTP transport
-   8243 - Passthrough or NIO HTTPS transport
-   9611 - Publish data to the Traffic Manager. Required when binary data publisher for throttling.
-   9711 - Authenticate data published to the Traffic Manager. Required when binary data publisher for throttling.
-   10397 - Thrift client and server ports.
-   9099 - Web Socket ports.
-   1886 - Default MQTT port.

### WSO2 API Manager Analytics ports

-   7712 - Thrift SSL port for secure transport, where the client(gateway) is authenticated to use WSO2 API-M Analytics.
-   7612 - Thrift TCP port where WSO2 API-M Analytics receives events from clients(gateways).
-   7444 - The default port for the Siddhi Store REST API.
-   9444 - MSF4J HTTPS Port used to upload analytics data from the microgateway.
-   9643 - Default port for the analytics dashboard portal. 

!!! note
    If you change the default API Manager ports with a port offset, most of its ports will be changed automatically according to the offset.

## Disabling HTTP Transports

API Manager has two HTTP transports. See below for instructions on how to disable the following:

1.  Passthru (API Traffic) Transport
2.  Servlet (UI Traffic and Admin service access) Transport

### Disabling Passthrough Transport

Add the following configuration in deployment.toml file resides in the `<API-M_HOME>/repository/conf` directory.

``` toml
[transport.passthru_http.listener]
enable = false
```

### Disabling Servlet Transport

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
