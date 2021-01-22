# Switch from FIX to HTTP

This example demonstrates how WSO2 Micro Integrator receives messages through FIX and forwards them through HTTP.

The Micro Integrator will forward the order request to a one-way `placeOrder` operation in the back-end service. Micro Integrator uses a simple XSLT Mediator to transform the incoming FIX to a SOAP message.

## Synapse configuration

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy name="FIXToHTTPProxy" startOnLoad="true" transports="fix" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            <log level="full"/>
            <xslt key="{reg_path}/FIX_XSLT.xslt"/>
            <log level="full"/>
            <header name="Action" value="urn:placeOrder"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService">
                    </address>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <log level="full"/>
        </outSequence>
        <faultSequence/>
    </target>
    <parameter name="transport.fix.AcceptorConfigURL">file:/{file_path}/fix-synapse.cfg</parameter>
    <parameter name="transport.fix.AcceptorMessageStore">file</parameter>
</proxy>

```

FIX_XSLT:

```xml 
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/02/xpath-functions">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
    <xsl:template match="/">
        <m0:placeOrder xmlns:m0="http://services.samples">
            <m0:order>
                <m0:price>
                    <xsl:value-of select="//message/body/field[@id='44']"/>
                </m0:price>
                <m0:quantity>
                    <xsl:value-of select="//message/body/field[@id='38']"/>
                </m0:quantity>
                <m0:symbol>
                    <xsl:value-of select="//message/body/field[@id='55']"/>
                </m0:symbol>
            </m0:order>
        </m0:placeOrder>
    </xsl:template>
</xsl:stylesheet>

```

## Build and Run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Add the above XSLT as a registry resource.
4. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
5. Download the FIX transport resources from [here](https://github.com/wso2-docs/WSO2_EI/tree/master/FIX-transport-resources) and change the `{file_path}` of the proxy with the downloaded location.
6. Change the `{reg_path}` with the XSLT registry location. 
6. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

[Enable the FIX transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-fix-transport) and start the Micro-Integrator.

Set up the back-end service:

1. Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

Run the quickfixj **Banzai** sample application.

```bash
java -jar quickfixj-examples-banzai-2.1.1.jar
```
Send an order request from Banzai to Synapse. For example, Buy DELL 1000 @ 100. User has to send a "Limit" Order because price is a mandatory field for placeOrder operation.
