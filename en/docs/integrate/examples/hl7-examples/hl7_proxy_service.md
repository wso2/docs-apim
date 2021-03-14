# Mediating HL7 Messages

You can create a proxy service that uses the HL7 transport to connect to an HL7 server. This proxy service will receive HL7-client connections and send them to the HL7 server. It can also receive XML messages over HTTP/HTTPS and transform them into HL7 before sending them to the server, and it will transform the HL7 responses back into XML.

## Synapse configuration

Given below is an example proxy that receives HL7 messages from a client and relays the message to an HL7 server. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="hl7testproxy" transports="https,http,hl7" statistics="disable" trace="disable" startOnLoad="true">
 <target>
    <inSequence>
       <log level="full" />
    </inSequence>
    <outSequence>
       <log level="full" />
       <send />
    </outSequence>
    <endpoint name="hl7_endpoint">
       <address uri="hl7://localhost:9988" />
    </endpoint>
 </target>
 <parameter name="transport.hl7.Port">9292</parameter>
</proxy>
```

## Build and run

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