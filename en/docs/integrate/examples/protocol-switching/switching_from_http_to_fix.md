# Switching from HTTP to FIX

This example demonstrates how WSO2 Micro Integrator receives messages in HTTP and forwards them through FIX.

Synapse will create a session with the **Executor** and forward the order request. The first response coming from the Executor will be sent back over HTTP. The Executor generally sends two responses for each incoming order request. But since the response has to be forwarded over HTTP, only one can be sent back to the client.

## Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse" name="HTTPToFIXProxy" startOnLoad="true">
    <description />
    <target>
        <inSequence>
            <log level="full"></log>
            <property name="transport.fix.ServiceName" value="HTTPToFIXProxy" scope="axis2-client" />
            <send>
                <endpoint>
                    <address uri="fix://localhost:19876?BeginString=FIX.4.0&amp;SenderCompID=SYNAPSE&amp;TargetCompID=EXEC" />
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <log level="full"></log>
            <send />
        </outSequence>
    </target>
    <parameter name="transport.fix.InitiatorConfigURL">file:/{file_path}/synapse-sender.cfg</parameter>
    <parameter name="transport.fix.InitiatorMessageStore">file</parameter>
    <parameter name="transport.fix.SendAllToInSequence">false</parameter>
    <parameter name="transport.fix.DropExtraResponses">true</parameter>
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

Run the quickfixj **Executor** sample application.

```bash
java -jar quickfixj-examples-executor-2.1.1.jar
```

Send the following request to EI and we will receive the response from the executor application.

```bash
curl -X POST \
  http://localhost:8290/services/HTTPToFIXProxy \
  -H 'cache-control: no-cache' \
  -H 'content-type: text/xml' \
  -H 'soapaction: \"urn:mediate\"' \
  -d '<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header />
   <soapenv:Body>
      <message>
         <header>
            <field id="35">D</field>
            <field id="52">Fri Nov 08 11:04:31 IST 2019</field>
         </header>
         <body>
            <field id="11">122333</field>
            <field id="21">1</field>
            <field id="38">5</field>
            <field id="40">1</field>
            <field id="54">1</field>
            <field id="55">IBM</field>
            <field id="59">0</field>
         </body>
         <trailer />
      </message>
   </soapenv:Body>
</soapenv:Envelope>'
```