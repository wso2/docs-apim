# Switching from FTP Listener to Mail Sender

This example demonstrates how WSO2 Micro Integrator receives messages through the FTP transport listener and forwards the messages through the mail transport sender.

VFS transport listener will pick the file from the directory in the FTP server. The file in the FTP directory will be deleted. The response will be sent to the given e-mail address.

## Synapse configuration

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<proxy name="SFTPtoMailToProxy" startOnLoad="true" transports="vfs" xmlns="http://ws.apache.org/ns/synapse">
    <parameter name="transport.vfs.FileURI">vfs:sftp://guest:guest@localhost/test?vfs.passive=true</parameter> <!--CHANGE-->
    <parameter name="transport.vfs.ContentType">text/xml</parameter>
    <parameter name="transport.vfs.FileNamePattern">.*\.xml</parameter>
    <parameter name="transport.PollInterval">15</parameter>
    <target>
        <inSequence>
            <header name="Action" value="urn:getQuote"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <property action="set" name="OUT_ONLY" value="true"/>
            <send>
                <endpoint>
                    <address uri="mailto:user@host"/>
                </endpoint>
            </send>
        </outSequence>
    </target>
    <publishWSDL key="conf:custom/sample_proxy_1.wsdl" preservePolicy="true"/>
</proxy>
```

## Build and Run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Add [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl) as a [registry resource]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources) (change the registry path of the proxy accordingly). 
4. Create the proxy service with the [VFS configurations parameters given above]({{base_path}}/reference/config-catalog/#vfs-transport).
5. Configure [MailTo transport sender]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-mailto-transport).
6. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator and start the Micro Integrator.

Set up the back-end service.

1.	Download the [back-end service](
https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```
      
Add the following request.xml file to the sftp location and verify the content received via the mailto transport.

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header/>
<soapenv:Body>
	<m0:getQuote xmlns:m0="http://services.samples">
        <m0:request>
            <m0:symbol>WSO2</m0:symbol>
        </m0:request>
     </m0:getQuote>
</soapenv:Body>
</soapenv:Envelope> 
```
