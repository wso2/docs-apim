# Switching from UDP to HTTP/S

This example demonstrates how WSO2 Micro Integrator receives SOAP messages over UDP and forwards them over HTTP.

## Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml 
<?xml version="1.0" encoding="UTF-8"?>
<proxy name="StockQuoteProxy" startOnLoad="true" transports="udp" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            <log level="full"/>
            <property name="OUT_ONLY" value="true"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </inSequence>
    </target>
    <publishWSDL key="conf:UDP_WSDL/sample_proxy_1.wsdl" preservePolicy="true"/>
    <parameter name="transport.udp.port">9999</parameter>
    <parameter name="transport.udp.contentType">text/xml</parameter>
</proxy>
```

## Build and Run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Add [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl) as a [registry resource]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources) (change the registry path of the proxy accordingly). 
4. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the back-end service:

* Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
* Extract the downloaded zip file.
* Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
* Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

[Enable the UDP transport]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-udp-transport) and start the Micro-Integrator.

Send the following message via UDP to the UDP listener port (9999).
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <soapenv:Header xmlns:wsa="http://www.w3.org/2005/08/addressing">
        <wsa:To>udp://localhost:9999/services/StockQuoteProxy</wsa:To>
        <wsa:ReplyTo>
            <wsa:Address>http://www.w3.org/2005/08/addressing/none</wsa:Address>
        </wsa:ReplyTo>
        <wsa:MessageID>urn:uuid:464d2e2a-cd47-4c63-a7c6-550c282a1e3c</wsa:MessageID>
        <wsa:Action>urn:placeOrder</wsa:Action>
    </soapenv:Header>
    <soapenv:Body>
        <m0:placeOrder xmlns:m0="http://services.samples">
            <m0:order>
                <m0:price>172.23182849731984</m0:price>
                <m0:quantity>18398</m0:quantity>
                <m0:symbol>IBM</m0:symbol>
            </m0:order>
        </m0:placeOrder>
    </soapenv:Body>
</soapenv:Envelope>
``` 
In linux, we can save the above request in a <strong>request.xml</strong> file and use netcat to send the UDP request. 

```bash
nc -u localhost 9999 < request.xml
```
