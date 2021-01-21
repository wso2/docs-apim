# Injecting Parameters

When deploying integration artifacts in different environments, it is necessary to change the synapse parameters used in the artifacts according to the environment. For example, the 'endpoint URL' will be different in each environment. If you define the synapse parameters in your artifacts as explained below, you can inject the required parameter values for each environment using system variables. Without this feature, you need to create and maintain separate artifacts for each environment. This feature is useful for container deployments.

There are two ways to inject parameters into synapse configurations: By injecting values using environment variables, or by using a file to inject the parameter values.

## Using Environment Variables

If you want to inject parameter values as environment variables, you need to apply the following.

**Configuring the synapse artifacts**

Define your synapse artifacts using "$SYSTEM:parameter_key" as the parameter value. Note that parameter_key represents a place holder representing the parameter. For example, shown below is an endpoint artifact, where the endpoint uri configured for this feature:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteEndPoint">
  <address uri="$SYSTEM:stockQuoteEP"/>
</endpoint>
```

**Exporting the environment variable**

In a VM deployment, you can export the environment variables as shown below. Here VAR is the url you need to have set as environment property.

```bash
export stockQuoteEP=http://localhost:61616/...
```

## Using a File

If you want to inject parameter values using a configuration file, you need to apply the following configurations.

**Configuring the synapse artifacts**

Define your synapse artifacts using "$FILE:parameter_key" as the parameter value. For example, shown below is an endpoint artifact, where the endpoint uri is configured for the purpose injecting values using a configuration file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteEndPoint">
  <address uri="$FILE:stockQuoteEP"/>
</endpoint>
```

**Setting up the file**

You can use a configuration file to load the parameter values for each environment. By default, the Micro Integrator is shipped with the file.properties file (stored in the `<MI_HOME>/conf` directory), which you can use to store the parameter values that should be injected to your synapse configuration. The parameter values should be specified as a key-value pair as shown below.

```text
stockQuoteEP=http://localhost:9000/services/SimpleStockQuoteService
```

Alternatively, you can use a custom file stored in a file system instead of the default `file.properties` file. For example, a file named `dev.properties` can be used to inject parameter values to the development environment and a file named `prod.properties` can be used to inject parameter values to the production environment.

!!! Tip
    It is possible to use a file from a network file system mount (NFS mount) as the file path. We can then use the environment specific configurations from the file in the NFS mount and inject the parameter values to the environment.

**Updating the System property**

In the product startup scripts (integrator.sh and integrator.bat file), which are available in the `<MI_HOME>/bin` directory, a system variable is defined as shown below and the value is set to default. When the system property is set to default as shown below, the system reads the parameters from the file.properties file that is available in the `MI_HOME/conf` directory.

```bash
-Dproperties.file.path=default
```

If you are using a custom configuration file, instead of the `file.properties` file, you need to configure the particular file path in the product startup script as shown below.

```bash tab='On Linux/MacOs'
-Dproperties.file.path=/home/user/ei_configs/dev/dev.properties
```

```bash tab='On Windows'
-Dproperties.file.path="%CONFIG_DIR%\dev\dev.properties
```

## Supported Parameters

Listed below are the synapse artifact parameters to which you can dynamically inject values. Note that there are two ways to inject parameters as discussed above.

### Endpoint parameters

Listed below are the Endpoint parameters that can be dynamically injected.

<table>
    <tr>
        <th>Endpoint Type</th>
        <th>Parameters</th>
    </tr>
    <tr>
        <td>Address Endpoint</td>
        <td><code>uri</code></td>
    </tr>
    <tr>
        <td>HTTP Endpoint</td>
        <td><code>uri</code></td>
    </tr>
    <tr>
        <td>Loadbalance Endpoint</td>
        <td>
            <code>hostname</code> and <code>port</code>
        </td>
    </tr>
    <tr>
        <td>RecipientList Endpoint</td>
        <td>
            <code>hostname</code> and <code>port</code>
        </td>
    </tr>
    <tr>
        <td>Template Endpoint</td>
        <td>
            <code>uri</code>
        </td>
    </tr>
    <tr>
        <td>WSDL Endpoint</td>
        <td>
            <code>wsdlURI</code>
        </td>
    </tr>
</table>

#### Example

In the following example, the endpoint URL is configured as a dynamic value.

```xml tab='Using Environment Variables'
<?xml version="1.0" encoding="UTF-8"?>
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="JSON_EP">
  <address uri="$SYSTEM:VAR"/>
</endpoint>
```

```xml tab='Using a File'
<?xml version="1.0" encoding="UTF-8"?>
<endpoint xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteEndPoint">
  <address uri="$FILE:stockQuoteEP"/>
</endpoint>
```

### Data service parameters

!!! Tip
    Note that you cannot inject parameters to data service using a file. You can only use environment variables.

Listed below are the data service parameters that can be dynamically injected.

-   `Driver`
-   `URL`
-   `Username`
-   `Password`

#### Example

In the following example, parameters are configured as dynamic values in the data service.

```xml tab='Inline Datasource'
<data name="DataServiceSample" serviceGroup="" serviceNamespace="">
    <description/>
    <config id="SourceSample">
        <property name="org.wso2.ws.dataservice.user">$SYSTEM:uname</property>
        <property name="org.wso2.ws.dataservice.password">$SYSTEM:pass</property>
        <property name="org.wso2.ws.dataservice.protocol">$SYSTEM:url1</property>
        <property name="org.wso2.ws.dataservice.driver">$SYSTEM:driver1</property>
    </config>
    <query>
    --------------------
    </query>
    <operation>
    --------------------
    </operation>
</data>
```

```xml tab='External Datasource'
<datasource>
    <name>MySQLConnection</name>
    <description>MySQL Connection</description>
    <definition type="RDBMS">
        <configuration>
            <driverClassName>$SYSTEM:driver1</driverClassName>
            <url>$SYSTEM:url1</url>
            <username>$SYSTEM:uname</username>
            <password>$SYSTEM:pass</password>
        </configuration>
    </definition>
</datasource>
```

### Scheduled Task parameters

The <b>pinned servers</b> parameter can be dynamically injected to a scheduled task or proxy service. See the example given below.

#### Example

```xml tab='Using Environment Variables'
<?xml version="1.0" encoding="UTF-8"?>
<task class="org.apache.synapse.startup.tasks.MessageInjector" group="synapse.simple.quartz" name="ProxytestInject" pinnedServers="$SYSTEM:pinned" xmlns="http://ws.apache.org/ns/synapse">
    <trigger count="5" interval="10"/>
    <property name="injectTo" value="proxy" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="proxyName" value="testProxy" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="soapAction" value="mediate" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="message" xmlns:task="http://www.wso2.org/products/wso2commons/tasks">
        ----------
    </property>
</task>
```

```xml tab='Using a File'
<?xml version="1.0" encoding="UTF-8"?>
<task class="org.apache.synapse.startup.tasks.MessageInjector" group="synapse.simple.quartz" name="ProxytestInject" pinnedServers="$FILE:pinned" xmlns="http://ws.apache.org/ns/synapse">
    <trigger count="5" interval="10"/>
    <property name="injectTo" value="proxy" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="proxyName" value="testProxy" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="soapAction" value="mediate" xmlns:task="http://www.wso2.org/products/wso2commons/tasks"/>
    <property name="message" xmlns:task="http://www.wso2.org/products/wso2commons/tasks">
        ----------
    </property>
</task>
```

### Inbound Endpoint parameters

See the list of inbound endpoint parameters that can be dynamically injected.

-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/http-inbound-endpoint-properties">HTTP/HTTPS Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/hl7-inbound-endpoint-properties">HL7 Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/cxf-ws-rm-inbound-endpoint-properties">CXF WS-RM Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/websocket-inbound-endpoint-properties">Websocket Inbound Protocol</a>

-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/file-inbound-endpoint-properties">File Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/jms-inbound-endpoint-properties">JMS Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/kafka-inbound-endpoint-properties">Kafka Inbound Protocol</a>

-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/event-based-inbound-endpoints/mqtt-inbound-endpoint-properties">MQTT Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/event-based-inbound-endpoints/rabbitmq-inbound-endpoint-properties">RabbitMQ Inbound Protocol</a>

#### Example

In the following example, JMS transport parameters in an inbound endpoint are configured as dynamic values.

```xml tab='Using Environment Variables'
<?xml version="1.0" encoding="UTF-8"?>
<inboundEndpoint name="jms" onError="fault" protocol="jms" sequence="LogMsgSeq" suspend="false" xmlns="http://ws.apache.org/ns/synapse">
    <parameters>
        <parameter name="interval">15000</parameter>
        <parameter name="sequential">true</parameter>
        <parameter name="coordination">true</parameter>
        <parameter name="transport.jms.Destination">myq</parameter>
        <parameter name="transport.jms.CacheLevel">3</parameter>
        <parameter name="transport.jms.ConnectionFactoryJNDIName">$SYSTEM:jmsconfac</parameter>
        <parameter name="java.naming.factory.initial">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
        <parameter name="java.naming.provider.url">$SYSTEM:jmsurl</parameter>
        <parameter name="transport.jms.UserName">$SYSTEM:jmsuname</parameter>
        <parameter name="transport.jms.SessionAcknowledgement">AUTO_ACKNOWLEDGE</parameter>
        <parameter name="transport.jms.Password">$SYSTEM:jmspass</parameter>
        <parameter name="transport.jms.SessionTransacted">false</parameter>
        <parameter name="transport.jms.ConnectionFactoryType">queue</parameter>
        <parameter name="transport.jms.ContentType">application/xml</parameter>
        <parameter name="transport.jms.SharedSubscription">false</parameter>
        <parameter name="pinnedServers">$SYSTEM:pinned</parameter>
        <parameter name="transport.jms.ResetConnectionOnPollingSuspension">false</parameter>
    </parameters>
</inboundEndpoint>
```

```xml tab='Using a File'
<?xml version="1.0" encoding="UTF-8"?>
<inboundEndpoint name="jms" onError="fault" protocol="jms" sequence="LogMsgSeq" suspend="false" xmlns="http://ws.apache.org/ns/synapse">
    <parameters>
        <parameter name="interval">15000</parameter>
        <parameter name="sequential">true</parameter>
        <parameter name="coordination">true</parameter>
        <parameter name="transport.jms.Destination">myq</parameter>
        <parameter name="transport.jms.CacheLevel">3</parameter>
        <parameter name="transport.jms.ConnectionFactoryJNDIName">$FILE:jmsconfac</parameter>
        <parameter name="java.naming.factory.initial">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
        <parameter name="java.naming.provider.url">$FILE:jmsurl</parameter>
        <parameter name="transport.jms.UserName">$FILE:jmsuname</parameter>
        <parameter name="transport.jms.SessionAcknowledgement">AUTO_ACKNOWLEDGE</parameter>
        <parameter name="transport.jms.Password">$FILE:jmspass</parameter>
        <parameter name="transport.jms.SessionTransacted">false</parameter>
        <parameter name="transport.jms.ConnectionFactoryType">queue</parameter>
        <parameter name="transport.jms.ContentType">application/xml</parameter>
        <parameter name="transport.jms.SharedSubscription">false</parameter>
        <parameter name="pinnedServers">$FILE:pinned</parameter>
        <parameter name="transport.jms.ResetConnectionOnPollingSuspension">false</parameter>
    </parameters>
</inboundEndpoint>
```

### Proxy Service parameters

The <b>pinned servers</b> parameter as well as all the service-level <b>transport parameters</b> can be dynamically injected to a proxy service.

-   [JMS parameters]({{base_path}}/reference/synapse-properties/transport-parameters/jms-transport-parameters)
-   [FIX parameters]({{base_path}}/reference/synapse-properties/transport-parameters/fix-transport-parameters)
-   [MailTo parameters]({{base_path}}/reference/synapse-properties/transport-parameters/mailto-transport-parameters)
-   [MQTT parameters]({{base_path}}/reference/synapse-properties/transport-parameters/mqtt-transport-parameters)
-   [RabbitMQ parameters]({{base_path}}/reference/synapse-properties/transport-parameters/rabbitmq-transport-parameters)
-   [VFS parameters]({{base_path}}/reference/synapse-properties/transport-parameters/vfs-transport-parameters)

#### Example

In the following example, JMS transport parameters are dynamically injected to the proxy service.

```xml tab='Using Environment Variables'
<?xml version="1.0" encoding="UTF-8"?>
<proxy name="JmsListner" pinnedServers="localhost" startOnLoad="true" transports="http https jms" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            -------------
            <drop/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </target>
    <parameter name="transport.jms.SessionAcknowledgement">AUTO_ACKNOWLEDGE</parameter>
    <parameter name="transport.jms.Destination">myq</parameter>
    <parameter name="transport.jms.ConnectionFactoryType">queue</parameter>
    <parameter name="transport.jms.ContentType">application/xml</parameter>
    <parameter name="java.naming.factory.initial">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
    <parameter name="java.naming.provider.url">$SYSTEM:jmsurl</parameter>
    <parameter name="transport.jms.SessionTransacted">false</parameter>
    <parameter name="transport.jms.ConnectionFactoryJNDIName">$SYSTEM:jmsconfac</parameter>
    <parameter name="transport.jms.UserName">$SYSTEM:jmsuname</parameter>
    <parameter name="transport.jms.Password">$SYSTEM:jmspass</parameter>
</proxy>
```

```xml tab='Using a File'
<?xml version="1.0" encoding="UTF-8"?>
<proxy name="JmsListner" pinnedServers="localhost" startOnLoad="true" transports="http https jms" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            -------------
            <drop/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </target>
    <parameter name="transport.jms.SessionAcknowledgement">AUTO_ACKNOWLEDGE</parameter>
    <parameter name="transport.jms.Destination">myq</parameter>
    <parameter name="transport.jms.ConnectionFactoryType">queue</parameter>
    <parameter name="transport.jms.ContentType">application/xml</parameter>
    <parameter name="java.naming.factory.initial">org.apache.activemq.jndi.ActiveMQInitialContextFactory</parameter>
    <parameter name="java.naming.provider.url">$FILE:jmsurl</parameter>
    <parameter name="transport.jms.SessionTransacted">false</parameter>
    <parameter name="transport.jms.ConnectionFactoryJNDIName">$FILE:jmsconfac</parameter>
    <parameter name="transport.jms.UserName">$FILE:jmsuname</parameter>
    <parameter name="transport.jms.Password">$FILE:jmspass</parameter>
</proxy>
```

### Message Store parameters

Listed below are the message store parameters that can be dynamically injected.

<table>
    <tr>
        <th>Message Store Type</th>
        <th>Parameters</th>
    </tr>
    <tr>
        <td>JMS Message Store</td>
        <td rowspan="2">
            <ul>
                <li>
                    <code>store.jms.username</code>
                </li>
                <li>
                    <code>store.jms.password</code>
                </li>
                <li>
                    <code>store.jms.connection.factory</code>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>WSO2 MB Message Store</td>
    </tr>
    <tr>
        <td>RabbitMQ Message Store</td>
        <td>
            <ul>
                <li>
                    <code>store.rabbitmq.host.name</code>
                </li>
                <li>
                    <code>store.rabbitmq.host.port</code>
                </li>
                <li>
                    <code>store.rabbitmq.username</code>
                </li>
                <li>
                    <code>store.rabbitmq.password</code>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>JDBC Message Store</td>
        <td rowspan="2">
            <ul>
                <li>
                    <code>store.jdbc.drive</code>
                </li>
                <li>
                    <code>store.jdbc.connection.url</code>
                </li>
                <li>
                    <code>store.jdbc.username</code>
                </li>
                <li>
                    <code>store.jdbc.password</code>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Resequence Message Store</td>
    </tr>
</table>

#### Example

In the following example, the parameters in the RabbitMQ message store are configured as dynamic values.

```xml tab='Using Environment Variables'
<?xml version="1.0" encoding="UTF-8"?>
<messageStore class="org.apache.synapse.message.store.impl.rabbitmq.RabbitMQStore" name="InboundStore" xmlns="http://ws.apache.org/ns/synapse">
    <parameter name="store.rabbitmq.host.name">$SYSTEM:rabbithost</parameter>
    <parameter name="store.producer.guaranteed.delivery.enable">false</parameter>
    <parameter name="store.rabbitmq.host.port">$SYSTEM:rabbitport</parameter>
    <parameter name="store.rabbitmq.route.key"/>
    <parameter name="store.rabbitmq.username">$SYSTEM:rabbitname</parameter>
    <parameter name="store.rabbitmq.virtual.host"/>
    <parameter name="rabbitmq.connection.ssl.enabled">false</parameter>
    <parameter name="store.rabbitmq.exchange.name">exchange3</parameter>
    <parameter name="store.rabbitmq.queue.name">queue3</parameter>
    <parameter name="store.rabbitmq.password">$SYSTEM:rabbitpass</parameter>
</messageStore>
```

```xml tab='Using a File'
<?xml version="1.0" encoding="UTF-8"?>
<messageStore class="org.apache.synapse.message.store.impl.rabbitmq.RabbitMQStore" name="InboundStore" xmlns="http://ws.apache.org/ns/synapse">
    <parameter name="store.rabbitmq.host.name">$FILE:rabbithost</parameter>
    <parameter name="store.producer.guaranteed.delivery.enable">false</parameter>
    <parameter name="store.rabbitmq.host.port">$FILE:rabbitport</parameter>
    <parameter name="store.rabbitmq.route.key"/>
    <parameter name="store.rabbitmq.username">$FILE:rabbitname</parameter>
    <parameter name="store.rabbitmq.virtual.host"/>
    <parameter name="rabbitmq.connection.ssl.enabled">false</parameter>
    <parameter name="store.rabbitmq.exchange.name">exchange3</parameter>
    <parameter name="store.rabbitmq.queue.name">queue3</parameter>
    <parameter name="store.rabbitmq.password">$FILE:rabbitpass</parameter>
</messageStore>
```
