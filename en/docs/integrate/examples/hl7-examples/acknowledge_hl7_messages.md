# Acknowledging HL7 Messages

Automatic message acknowledgement for HL7 messages is enabled in the Micro Integrator by default. With this setting, an ACK is immediately returned to the client when a message is received. 

If required, you can disable automatic acknowledgement. This allows you to control how and when ACK/NACK messages should be returned to the client. That is, you can define the integration logic to generate an ack/nack message after message validations or related tasks.

## Configuring message acknowldegement for HL7

When auto acknowledgement for HL7 messages is disabled in the Micro Integrator, you can manually configure ACK/NACK messages in the mediation logic by using the Property mediator. 

!!! Info
    Add the following parameter to the proxy service to disable auto acknowledgement and validation:
    ```xml
    <parameter name="transport.hl7.AutoAck">false</parameter>
    ```

- Specify an axis2 scope message context property `HL7_GENERATE_ACK` and set its value to true as shown below.

    ```xml
    <property name="HL7_GENERATE_ACK" value="true" scope="axis2"/>
    ```

    This ensures that an ACK/NACK message is created automatically when a message is sent (using the HL7 formatter). By default, an ACK message is created.

- If a NACK message is required instead, set the result mode to `NACK` and provide a custom NACK message as shown below. 

    ```xml tab='HL7 Result Mode'
    <property name="HL7_RESULT_MODE" value="NACK" scope="axis2" />
    ```

    ```xml tab='NACK Message'
    <property name="HL7_NACK_MESSAGE" value="ERROR MESSAGE" scope="axis2" />
    ```

- You can use the `HL7_RAW_MESSAGE` property in the axis2 scope to retrieve the original raw EDI format HL7 message in an InSequence. The user doesn't have to convert from XML to EDI again. Therefore, this may be particularly helpful inside a custom mediator.

    ```xml
    <property name="HL7_RAW_MESSAGE" value="$axis2:HL7_RAW_MESSAGE" scope="axis2" />
    ```

- To control the encoding type of incoming messages, set the Java system property `ca.uhn.hl7v2.llp.charset`.

- If you do want to wait for the back-end application's response before sending the ACK/NACK message to the client, define the following property in the InSequence:

    ```xml
    <property name="HL7_APPLICATION_ACK" value="true" scope="axis2"/> 
    ```

    In this case, the request thread will wait until the back-end application returns the response before sending the "accept-acknowledgement" message to the client. 

## Example 1: Generate ACK/NACK before the backend responds

Consider an example where the client sending the message only requires an acknowledgement from the proxy service that the message was received. It does not need to wait for the back-end service to process the message before receiving this acknowledgement.

### Synapse configuration

Given below is a sample proxy service that is configured to send an ACK/NACK as soon as the message is received. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse" name="HL7Proxy" transports="hl7" startOnLoad="true" trace="disable">
    <description/>
    <target>
        <inSequence>
            <property name="HL7_RESULT_MODE" value="ACK" scope="axis2"/>
            <property name="HL7_GENERATE_ACK" value="true" scope="axis2"/>
            <send>
               <endpoint name="hl7_endpoint">
                    <address uri="hl7://localhost:9988"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <log level="custom">
                <property name="OUT" value="***********out sequence proxy2***********"/>
            </log>
           <drop/>
        </outSequence>
     </target>
     <parameter name="transport.hl7.AutoAck">false</parameter>
     <parameter name="transport.hl7.ValidateMessage">false</parameter>
     <parameter name="transport.hl7.Port">9293</parameter>
</proxy>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Configure the HL7 transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport) in your Micro Integrator.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

To test this scenario, you need the following:

- An HL7 client that sends messages to the port specified by the `transport.hl7.Port` parameter.
- An HL7 back-end application that recieves messages from the Micro Integrator.

You can simulate the HL7 client and back-end application using a tool such as <b>HAPI</b>.

## Example 2: Generate ACK/NACK after the backend responds

Consider an example where the client sending the message requires an acknowledgement from the proxy service only after the back-end service has processed the message.

### Synapse configuration

The following proxy service is configured to send a NACK message after the backend has processed the message.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse" name="HL7Proxy" transports="hl7" statistics="disable" trace="disable" startOnLoad="true">
  <target>
      <inSequence>
           <property name="HL7_APPLICATION_ACK" value="true" scope="axis2"/> 
            <send>
                  <endpoint name="endpoint_urn_uuid_9CB8D06C91A1E996796270828144799-1418795938">
                          <address uri="hl7://localhost:9988"/>
                  </endpoint>
            </send>
      </inSequence>
      <outSequence> 
           <property name="HL7_RESULT_MODE" value="NACK" scope="axis2"/>
           <property name="HL7_NACK_MESSAGE" value="error msg" scope="axis2"/>
           <send/>
      </outSequence>
  </target>
  <parameter name="transport.hl7.AutoAck">false</parameter>
  <parameter name="transport.hl7.ValidateMessage">true</parameter>
  <parameter name="transport.hl7.Port">9294</parameter>
  <description></description>
</proxy>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Configure the HL7 transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport) in your Micro Integrator.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

To test this scenario, you need the following:

- An HL7 client that sends messages to the port specified by the `transport.hl7.Port` parameter.
- An HL7 back-end application that recieves messages from the Micro Integrator.

You can simulate the HL7 client and back-end application using a tool such as <b>HAPI</b>.