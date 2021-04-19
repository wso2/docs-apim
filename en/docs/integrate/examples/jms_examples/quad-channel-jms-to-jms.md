__# JMS Synchronous Invocations: Quad Channel JMS-to-JMS

The example demonstrates how WSO2 Micro Integrator handles quad-channel JMS synchronous invocations.

## Synapse configuration 

Given below is the synapse configuration of the proxy service that mediates the above use case. Note that you need to update the JMS connection URL according to your broker as explained below. 

See the instructions on how to [build and run](#build-and-run) this example.

```xml
<proxy name="QuadJMS" transports="jms" xmlns="http://ws.apache.org/ns/synapse">
          <target>
              <inSequence>
                  <property action="set" name="transport.jms.ContentTypeProperty" value="Content-Type" scope="axis2"/>
                  <log level="full" xmlns="http://ws.apache.org/ns/synapse"/>
                  <send>
                      <endpoint>
                          <address uri="jms:/BEReq?transport.jms.ConnectionFactoryJNDIName=QueueConnectionFactory&amp;java.naming.factory.initial=org.apache.activemq.jndi.ActiveMQInitialContextFactory&amp;java.naming.provider.url=tcp://localhost:61616&amp;transport.jms.DestinationType=queue&amp;transport.jms.ReplyDestination=BERes"/>
                      </endpoint>
                  </send>
              </inSequence>
              <outSequence>
                  <send/>
              </outSequence>
          </target>
          <parameter name="transport.jms.ContentType">
              <rules>
                  <jmsProperty>contentType</jmsProperty>
                  <default>text/xml</default>
              </rules>
          </parameter>
          <parameter name="transport.jms.Destination">ClientReq</parameter>
</proxy>
```

The message flow handled by the sample configuration is as follows:

1.  The **JMSReplyTo** property of the JMS message is set to **ClientRes** . Therefore, the client sends a JMS message to the
    **ClientReq** queue.  
2.  The **transport.jms.ReplyDestination** value is set to **BERes**. This enables the Micro Integrator proxy to pick messages from the **ClientReq** queue and send to the **BEReq** queue.  
3.  The back-end picks messages from the **BEReq** queue, processes and places response messages to the **BERes** queue.  
4.  Once a response is available in **BERes** queue, the proxy service picks the response message, and sends it back to the **ClientRes** queue.  
5.  The client the message as the response message.  

The Synapse artifacts used are explained below.

<table>
    <tr>
        <th>Artifact Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>
            Proxy Service
        </td>
        <td>
            A proxy service is used to receive messages and to define the message flow.
        </td>
    </tr>
    <tr>
        <td>Property Mediator</td>
        <td>
            The JMS transport uses the <code>transport.jms.ContentTypeProperty</code> property in the above configuration to determine the content type of the response message. If this property is not set, the JMS transport treats the incoming message as plain text. 
        </td>
    </tr>
    <tr>
        <td>Send Mediator</td>
        <td>
           To send a message to a JMS queue, you should define the JMS connection URL as the endpoint address (which should be invoked via the <b>Send</b> mediator). There are two ways to specify the endpoint URL: 
           <ul>
               <li>
                    Specify the JNDI name of the JMS queue and the connection factory parameters in the JMS connection URL as shown in the exampe. Values of connection factory parameters depend on the type of JMS broker.
               </li></br>
               <li>
                    If you have already specified the endpoint's connection factory parameters (for the JMS sender configuration) in the <code>deployment.toml</code> file, the connection URL in the proxy service should be as shown below. In this example, the endpoint URL of the proxy service refers the relevant connection factory in the <code>deployment.toml</code> file: </br></br>
                    <b>When the broker is ActiveMQ</b></br>
                    <code>jms:/BEReq?transport.jms.ConnectionFactory=QueueConnectionFactory</code></br></br>
                    <b>When the broker is WSO2 Message Broker</b></br>
                    <code>jms:/BEReq?transport.jms.ConnectionFactory=QueueConnectionFactory</code>
               </li>
           </ul>
        </td>
    </tr>
</table>

!!! Note
    Be sure to replace the ' `& ` ' character in the endpoint URL with '`&amp;`' to avoid the following exception:
    ```java
    com.ctc.wstx.exc.WstxUnexpectedCharException: Unexpected character '=' (code 61); expected a semi-colon after the reference for entity 'java.naming.factory.initial' at [row,col {unknown-source}
    ``` 

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the broker:

1.  [Configure a broker]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transport#configuring-the-jms-transport) with your Micro Integrator instance. Let's use Active MQ for this example.
2.  Start the broker.
3.  Start the Micro Integrator (after starting the broker).

Set up the back-end service:

1. Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```
    
Invoke the proxy service by send a simple message.