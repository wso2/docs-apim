# Connecting to HornetQ

This section describes how to configure WSO2 WSO2 Micro Integrator to connect with
HornetQ, which is an open source project to build a multi-protocol, asynchronous messaging system.

You can either use a standalone HornetQ server or the HornetQ embedded in a JBoss Enterprise Application Platform (JBoss EAP) server.

## Configure with a standalone HornetQ server

Follow the instructions below to configure WSO2 Micro Integrator JMS transport with a
a standalone HornetQ server.

1.  Download HornetQ from the [HornetQ Downloads](http://hornetq.jboss.org/downloads.html) site.  
2.  Download and install WSO2 Micro Integrator.
3.  Create a sample queue by editing the `HORNET_HOME/config/stand-alone/non-clustered/hornetq-jms.xml` file as follows:
    ```xml
    <queue name="wso2">
          <entry name="/queue/mySampleQueue"/>
    </queue>
    ```

4.  Add the following two connection entries to the same file. These entries are required to enable WSO2 Micro Integrator to act as a JMS consumer.
    ```xml
    <connection-factory name="QueueConnectionFactory">
          <xa>false</xa>
          <connectors>
             <connector-ref connector-name="netty"/>
          </connectors>
          <entries>
             <entry name="/QueueConnectionFactory"/>
          </entries>
    </connection-factory>
    <connection-factory name="TopicConnectionFactory">
          <xa>false</xa>
          <connectors>
             <connector-ref connector-name="netty"/>
          </connectors>
          <entries>
             <entry name="/TopicConnectionFactory"/>
          </entries>
    </connection-factory>
    ```

5.  If you have not already done so, download and install WSO2 Micro Integrator.
6.  Download the [hornet-all-new.jar](https://github.com/wso2-docs/WSO2_EI/raw/master/Broker-Setup-Artifacts/HornetQ/hornetq-all-new.jar) file and copy it into the `MI_HOME/lib/` directory.

    !!! Info
        If you are packing the JARs yourself, make sure you remove the javax.jms package from the assembled JAR to avoid the carbon runtime from picking this implementation of JMS over the bundled-in distribution.

7.  If you want the Micro Integrator to receive messages from a HornetQ instance, or to send messages to a HornetQ instance, you need to update the deployment.toml file with the relevant connection parameters.

    Add the following configurations to `MI_HOME/conf/deployment.toml` file to enable the JMS sender and listener with HornetQ connection parameters.
    ```toml
    [transport.jms]
    sender_enable = true

    [[transport.jms.listener]]
    name = "myTopicConnectionFactory"
    parameter.initial_naming_factory = "org.jnp.interfaces.NamingContextFactory"
    parameter.provider_url = "jnp://localhost:1099"
    parameter.connection_factory_name = "TopicConnectionFactory"
    parameter.connection_factory_type = "topic"
    parameter.'java.naming.factory.url.pkgs' = "org.jboss.naming:org.jnp.interfaces"

    [[transport.jms.listener]]
    name = "myQueueConnectionFactory"
    parameter.initial_naming_factory = "org.jnp.interfaces.NamingContextFactory"
    parameter.provider_url = "jnp://localhost:1099"
    parameter.connection_factory_name = "QueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    parameter.'java.naming.factory.url.pkgs' = "org.jboss.naming:org.jnp.interfaces"

    [[transport.jms.listener]]
    name = "default"
    parameter.initial_naming_factory = "org.jnp.interfaces.NamingContextFactory"
    parameter.provider_url = "jnp://localhost:1099"
    parameter.connection_factory_name = "QueueConnectionFactory"
    parameter.connection_factory_type = "queue"
    parameter.'java.naming.factory.url.pkgs' = "org.jboss.naming:org.jnp.interfaces"
    ```
    !!! Info
        For details on the JMS configuration parameters used in the code segments above, see [JMS connection factory parameters]({{base_path}}/reference/config-catalog-mi/#jms-transport-listener-non-blocking-mode).

8.  Start HornetQ with the following command.
    -   On Windows:
        `HORNETQ_HOME\bin\run.bat --run              `
    -   On Linux/Solaris:
        `sh HORNETQ_HOME/bin/run.sh`

Now you have configured WSO2 Micro Integrator with a standalone HornetQ server. 

### Testing the configuration

To test the configuration, create a proxy service named `JMSPublisher` that will publish messages from the Micro Integrator to a sample queue in HornetQ, and create the `JMSListener` queue to read messages from the HornetQ sample queue.

1.  Create the `JMSPublisher` proxy service with the following configuration:

    ```xml
    <proxy xmlns="http://ws.apache.org/ns/synapse"
           name="JMSPublisher"
           transports="https,http"
           statistics="enable"
           trace="enable"
           startOnLoad="true">
       <target>
          <inSequence>
             <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
             <property name="Accept-Encoding" scope="transport" action="remove"/>
             <property name="Content-Length" scope="transport" action="remove"/>
             <property name="Content-Type" scope="transport" action="remove"/>
             <property name="User-Agent" scope="transport" action="remove"/>
             <property name="OUT_ONLY" value="true"/>
             <log level="full"/>
             <send>
                <endpoint>
                   <address uri="jms:/queue/mySampleQueue?transport.jms.ConnectionFactoryJNDIName=QueueConnectionFactory&amp;java.naming.factory.initial=org.jnp.interfaces.NamingContextFactory&amp;java.naming.provider.url=jnp://localhost:1099&amp;transport.jms.DestinationType=queue"/>
                </endpoint>
             </send>
          </inSequence>
       </target>
       <publishWSDL uri="file:samples/service-bus/resources/proxy/sample_proxy_1.wsdl"/>
       <description>HornetQ-WSO2 ESB sample</description>
    </proxy>
    ```

    !!! Info  
        -   The `OUT_ONLY` parameter is set to `true` since this proxy service is created only for the purpose of publishing the messages from WSO2 Micro Integrator to the `mySampleQueue` queue specified in the address URI.
        -   You may have to change the host name, port etc. of the JMS string based on your environment.

2.  Create the `JMSListener` proxy service with the following configuration:

    ```xml
    <proxy xmlns="http://ws.apache.org/ns/synapse"
           name="JMSListener"
           transports="jms"
           statistics="disable"
           trace="disable"
           startOnLoad="true">
       <target>
          <inSequence>
             <log level="custom">
                <property name="JMS LISTENER PROXY" value="LOCATED"/>
             </log>
             <log level="full"/>
             <drop/>
          </inSequence>
       </target>
       <parameter name="transport.jms.ContentType">
          <rules>
             <jmsProperty>contentType</jmsProperty>
             <default>application/xml</default>
          </rules>
       </parameter>
       <parameter name="transport.jms.Destination">queue/mySampleQueue</parameter>
       <description/>
    </proxy>
    ```

4.  Send the following request:

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
       <soapenv:Header/>
       <soapenv:Body>
          <ser:placeOrder>
             <!--Optional:-->
             <ser:order>
                <!--Optional:-->
                <xsd:price>20</xsd:price>
                <!--Optional:-->
                <xsd:quantity>20</xsd:quantity>
                <!--Optional:-->
                <xsd:symbol>IBM</xsd:symbol>
             </ser:order>
          </ser:placeOrder>
       </soapenv:Body>
    </soapenv:Envelope>
    ```

5.  Check the log on your WSO2 Micro Integrator terminal. You will see the following log, which indicates that the request published in the queue is picked up by the `JMSListener` proxy.

    ```xml
    [<TIME Stamp>]  INFO - LogMediator JMS LISTENER PROXY = LOCATED
    [<TIME Stamp>]  INFO - LogMediator To: , WSAction: "urn:placeOrder", SOAPAction: "urn:placeOrder", MessageID: ID:be08707e-033d-11e4-8307-25263fbb9173, Direction: request, Envelope: 

    <?xml version="1.0" encoding="utf-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><soapenv:Envelope xmlns:xsd="http://services.samples/xsd" xmlns:ser="http://services.samples"><soapenv:Body>

          <ser:placeOrder>
             <!--Optional:-->
             <ser:order>
                <!--Optional:-->
                <xsd:price>20</xsd:price>
                <!--Optional:-->
                <xsd:quantity>20</xsd:quantity>
                <!--Optional:-->
                <xsd:symbol>IBM</xsd:symbol>
             </ser:order>
          </ser:placeOrder>
       </soapenv:Body></soapenv:Envelope></soapenv:Body></soapenv:Envelope>
    ```

## Configure with HornetQ embedded in a JBoss EAP server

Follow the instructions below to configure WSO2 Micro Integrator JMS transport with HornetQ embedded in a JBoss EAP server.

**Setting up JBoss EAP**

Install JBoss EAP server and create a message queue within the server.

1.  Download JBoss EAP Server 7.0.0 from [JBoss EAP Downloads](http://developers.redhat.com/products/eap/download/) and run the JBoss EAP installer as described [here](https://access.redhat.com/documentation/en/red-hat-jboss-enterprise-application-platform/version-7.0/installation-guide/#running_the_jboss_eap_installer).
2.  Execute one of the following commands in command prompt to create a new application user.  
    -   On Windows:
        `<EAP_HOME>\bin\add-user.bat -a -u 'SampleUser' -p 'SamplePwd1!' -g 'guest'`
    -   On Linux/Mac:
        `<EAP_HOME>/bin/add-user.sh -a -u 'SampleUser' -p 'SamplePwd1!' -g 'guest'`
3.  Create a sample queue by editing the `<EAP_HOME>/standalone/configuration/standalone-full.xml` file. Add the following content within the `<hornetq-server>` element:
    ```xml
    <jms-destinations>
          <jms-queue name="sampleQueue">
              <entry name="queue/test"/>
              <entry name="java:jboss/exported/jms/queue/test"/>
          </jms-queue>
    </jms-destinations>
    ```
    
4.  Start the JBoss EAP server by executing one of the following commands in command prompt:
    -   On Windows: `<EAP_HOME>\bin\standalone.bat -c standalone-full.xml`
    -   On Linux/Mac: `<EAP_HOME>/bin/standalone.sh -c standalone-full.xml`

5.  Acess the management console of the JBoss EAP server using the following URL: `http://127.0.0.1:9990`
6.  Log in to the Management Console using **admin** as both the username and password. In the **Profile** menu, click **Messaging ->
    Destinations** and you will be able to see the queue you added in Step 4 in the **Queues/Topics** section.

    [![sample queue]({{base_path}}/assets/img/integrate/broker-configs/hornetq/sample-queue.png)]({{base_path}}/assets/img/integrate/broker-configs/hornetq/sample-queue.png)

Now you have configured the JBoss EAP Server. The next section describes how to configure the Micro Integrator to listen and fetch messages from the queue that you created above.

**Configuring WSO2 Micro Integrator**

1.  Download and install WSO2 Micro Integrator.
2.  If you want the Micro Integrator to receive messages from an HornetQ instance, or to send messages to an HornetQ instance, you need to update the deployment.toml file with the relevant connection parameters.

    Add the following configurations to enable the JMS listener with ActiveMQ connection parameters.
    ```toml
    [[transport.jms.listener]]
    name = "QueueConnectionFactory"
    parameter.initial_naming_factory = "org.jboss.naming.remote.client.InitialContextFactory"
    parameter.provider_url = "remote://localhost:4447"
    parameter.connection_factory_name = "jms/RemoteConnectionFactory"
    parameter.connection_factory_type = "topic"
    parameter.username = "SampleUser"
    parameter.password = "SamplePwd1!"
    parameter.naming_security_principal = "SampleUser"
    parameter.naming_security_credential = "SamplePwd1!"
    ```
    !!! Info
        The username and password created for the guest user in the above section are used in the configuration.

3.  Copy the `jboss-client.jar` file from the `EAP_HOME/bin/client` directory to the `MI_HOME/lib` directory.

    !!! Note
        After copying the `jboss-client.jar` file from the `EAP_HOME/bin/client` directory to the `MI_HOME/lib` directory, be sure to remove the `javax.jms` package from the `jboss-client.jar` file.

        [![delete package]({{base_path}}/assets/img/integrate/broker-configs/hornetq/delete-package.png)]({{base_path}}/assets/img/assets/img/integrate/broker-configs/hornetq/delete-package.png)

Now you have configured WSO2 Micro Integrator with HornetQ embedded in a JBoss EAP server.

### Testing the configuration

To test the configuration, create a proxy service named `JMSPublisher` that publishes messages from the Micro Integrator to the HornetQ sample queue, and create the `JMSListener` queue to read messages from the HornetQ sample queue.

1.  Create the `JMSPublisher` proxy service with the following configuration:
    ```xml
    <proxy xmlns="http://ws.apache.org/ns/synapse"
           name="JMSPublisher"
           transports="https,http"
           statistics="enable"
           trace="enable"
           startOnLoad="true">
       <target>
          <inSequence>
             <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
             <property name="Accept-Encoding" scope="transport" action="remove"/>
             <property name="Content-Length" scope="transport" action="remove"/>
             <property name="Content-Type" scope="transport" action="remove"/>
             <property name="User-Agent" scope="transport" action="remove"/>
             <property name="OUT_ONLY" value="true"/>
             <log level="full"/>
             <send>
                <endpoint>
                   <address uri="jms:/jms/queue/test?transport.jms.ConnectionFactoryJNDIName=jms/RemoteConnectionFactory&amp;java.naming.factory.initial=org.jboss.naming.remote.client.InitialContextFactory&amp;java.naming.provider.url=remote://localhost:4447&amp;transport.jms.DestinationType=queue&amp;transport.jms.UserName=SampleUser&amp;transport.jms.Password=SamplePwd1!&amp;java.naming.security.principal=SampleUser&amp;java.naming.security.credentials=SamplePwd1!"/>            </endpoint>
    </send>
          </inSequence>
       </target>
       <publishWSDL uri="file:samples/service-bus/resources/proxy/sample_proxy_1.wsdl"/>
       <description>HornetQ-WSO2 ESB sample</description>
    </proxy>
    ```

    !!! Info
        -   The `OUT_ONLY` parameter is set to `true` since this proxy service is created only for the purpose of publishing the messages to the `mySampleQueue` queue specified in the address URI.
        -   You may have to change the host name, port etc. of the JMS string based on your environment.

2.  Create the `JMSListener` proxy service with the following configuration:

    ```xml
    <proxy xmlns="http://ws.apache.org/ns/synapse"
           name="JMSListener"
           transports="jms"
           statistics="disable"
           trace="disable"
           startOnLoad="true">
       <target>
          <inSequence>
             <log level="custom">
                <property name="JMS LISTENER PROXY" value="LOCATED"/>
             </log>
             <log level="full"/>
             <drop/>
          </inSequence>
       </target>
       <parameter name="transport.jms.ContentType">
          <rules>
             <jmsProperty>contentType</jmsProperty>
             <default>text/plain</default>
          </rules>
       </parameter>
    <parameter name="transport.jms.ConnectionFactory">QueueConnectionFactory</parameter>
       <parameter name="transport.jms.Destination">jms/queue/test</parameter>
    <description/>
    </proxy>
    ```

3.  Send the following request to the Micro Integrator.

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
       <soapenv:Header/>
       <soapenv:Body>
          <ser:placeOrder>
             <!--Optional:-->
             <ser:order>
                <!--Optional:-->
                <xsd:price>20</xsd:price>
                <!--Optional:-->
                <xsd:quantity>20</xsd:quantity>
                <!--Optional:-->
                <xsd:symbol>IBM</xsd:symbol>
             </ser:order>
          </ser:placeOrder>
       </soapenv:Body>
    </soapenv:Envelope>
    ```

4.  Check the log on your WSO2 Micro Integrator terminal. You will see the following log, which indicates that the request published in the queue is picked up by the `JMSListener` proxy.

    ```xml
    [<TIME Stamp>]  INFO - LogMediator JMS LISTENER PROXY = LOCATED

    [<TIME Stamp>]  INFO - LogMediator To: , WSAction: "urn:placeOrder", SOAPAction: "urn:placeOrder", MessageID: ID:be08707e-033d-11e4-8307-25263fbb9173, Direction: request, Envelope:
    <?xml version="1.0" encoding="utf-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><soapenv:Envelope xmlns:xsd="http://services.samples/xsd" xmlns:ser="http://services.samples"><soapenv:Body>
          <ser:placeOrder>
             <!--Optional:-->
             <ser:order>
                <!--Optional:-->
                <xsd:price>20</xsd:price>
                <!--Optional:-->
                <xsd:quantity>20</xsd:quantity>
                <!--Optional:-->
                <xsd:symbol>IBM</xsd:symbol>
             </ser:order>
          </ser:placeOrder>
       </soapenv:Body></soapenv:Envelope></soapenv:Body></soapenv:Envelope>
    ```
