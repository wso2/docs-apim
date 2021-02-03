# VFS Transport

The Micro Integrator can access the local file system using the [VFS transport]({{base_path}}/reference/synapse-properties/transport-parameters/vfs-transport-parameters) sender and
receiver. This example demonstrates the VFS transport by using the file system as a transport medium.

## Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario.

```xml
    <proxy xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteProxy" transports="vfs">
        <parameter name="transport.vfs.FileURI">file:///home/user/test/in</parameter>  
        <parameter name="transport.vfs.ContentType">text/xml</parameter>
        <parameter name="transport.vfs.FileNamePattern">.*\.xml</parameter>
        <parameter name="transport.PollInterval">15</parameter>
        <parameter name="transport.vfs.MoveAfterProcess">file:///home/user/test/original</parameter> 
        <parameter name="transport.vfs.MoveAfterFailure">file:///home/user/test/original</parameter>
        <parameter name="transport.vfs.ActionAfterProcess">MOVE</parameter>
        <parameter name="transport.vfs.ActionAfterFailure">MOVE</parameter>
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
                <property name="transport.vfs.ReplyFileName"
                          expression="fn:concat(fn:substring-after(get-property('MessageID'), 'urn:uuid:'), '.xml')"
                          scope="transport"/>
                <property action="set" name="OUT_ONLY" value="true"/>
                <send>
                    <endpoint>
                        <address uri="vfs:file:///home/user/test/out"/> 
                    </endpoint>
                </send>
            </outSequence>
        </target>
        <publishWSDL uri="conf:custom//sample_proxy_1.wsdl"/>
    </proxy>
```

To configure a VFS endpoint, use the `vfs:file` prefix in the URI. For example:

```xml
<endpoint>
    <address uri="vfs:file:///home/user/test/out"/>
</endpoint>
```

## Build and run

To test this sample, the following files and directories should be created:

1. Create the file directories:

    -   Create 3 new directories (folders) named **in** , **out**, and **original** in a suitable location in a test directory (e.g.,
        /home/user/test) in the local file system. 
    -   Be sure to update the **in**, **out**, and **original** directory locations with the values given as the 
        `transport.vfs.FileURI`,
        `transport.vfs.MoveAfterProcess`,
        `transport.vfs.MoveAfterFailure` parameter values in your synapse configuration. 
    -   You need to set both
        `          transport.vfs.MoveAfterProcess         ` and
        `          transport.vfs.MoveAfterFailure         ` parameter
        values to point to the **original** directory location.
    -   Be sure that the endpoint in the `<outSequence>` points to the **out** directory location. Make sure that the prefix
        `          vfs:         ` in the endpoint URL is not removed or changed.

2. Add [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl) as a [registry resource]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources). Change the registry path of the proxy accordingly. 

3. Set up the back-end service.

    - Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip)
    - Extract the downloaded zip file.
    - Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
    - Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
        ```bash tab='On MacOS/Linux/CentOS'
        sh axis2server.sh
        ```
          
        ```bash tab='On Windows'
        axis2server.bat
        ```
        
4. Create the `test.xml` file shown below and copy it to the location specified by the `transport.vfs.FileURI` property in the configuration (i.e., the **in** directory). This contains a simple stock quote request in XML/SOAP format.

    ```xml
    <?xml version='1.0' encoding='UTF-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsa="http://www.w3.org/2005/08/addressing">
        <soapenv:Body>
            <m0:getQuote xmlns:m0="http://services.samples">
                <m0:request>
                    <m0:symbol>IBM</m0:symbol>
                </m0:request>
            </m0:getQuote>
        </soapenv:Body>
    </soapenv:Envelope>
    ```

When the sample is executed, the VFS transport listener picks the file from the **in** directory and sends it to the back service over HTTP. Then the request XML file is moved to the **original** directory and the response is saved to the **out** directory.
