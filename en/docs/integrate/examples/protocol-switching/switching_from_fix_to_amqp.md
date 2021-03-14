# Switch from FIX to AMQP

This example demonstrates how WSO2 Micro Integrator receives messages through FIX and forwards them through AMQP.

Synapse will forward the order request by binding it to a JMS message payload and sending it to the AMQP consumer. The AMQP consumer will send an execution back to Banzai.

## Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml 
<proxy name="FIXProxy" transports="fix" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <endpoint>
            <address uri="jms:/QpidStockQuoteService?transport.jms.ConnectionFactoryJNDIName=qpidConnectionfactory&amp;java.naming.factory.initial=org.apache.qpid.jndi.PropertiesFileInitialContextFactory&amp;java.naming.provider.url=repository/samples/resources/fix/con.properties&amp;transport.jms.ReplyDestination=replyQueue"/>
        </endpoint>
        <inSequence>
            <log level="full" />
        </inSequence>
        <outSequence>
            <property name="transport.fix.ServiceName" value="FIXProxy" scope="axis2-client" />
            <log level="full" />
            <send />
        </outSequence>
    </target>
    <parameter name="transport.fix.AcceptorConfigURL">file:/{file_path}/fix-synapse.cfg</parameter>
    <parameter name="transport.fix.AcceptorMessageStore">file</parameter>
</proxy>
```
## Build and Run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. Download the FIX transport resources from [here](https://github.com/wso2-docs/WSO2_EI/tree/master/FIX-transport-resources) and change the `{file_path}` of the proxy with the downloaded location.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

[Enable the FIX transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-fix-transport) and start the Micro-Integrator.

Run the quickfixj **Banzai** sample application.

```bash
java -jar quickfixj-examples-banzai-2.1.1.jar
```
Send a sample request from Banzai to Synapse. Then the message count of the queue should be increased.