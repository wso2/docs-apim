# Accessing a Windows Share using VFS
This example demonstrates how the [VFS transport](../../setup/transport_configurations/configuring-transports/configuring-the-vfs-transport) in WSO2 Micro Integrator can be used to access a windows share.

## Synapse configuration

Following are the integration artifacts (proxy service) that we can used to implement this scenario.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteProxy" transports="vfs">
    <parameter name="transport.vfs.FileURI">smb://host/test/in</parameter> 
    <parameter name="transport.vfs.ContentType">text/xml</parameter>
    <parameter name="transport.vfs.FileNamePattern">.*\.xml</parameter>
    <parameter name="transport.PollInterval">15</parameter>
    <parameter name="transport.vfs.MoveAfterProcess">smb://host/test/original</parameter> 
    <parameter name="transport.vfs.MoveAfterFailure">smb://host/test/original</parameter>
    <parameter name="transport.vfs.ActionAfterProcess">MOVE</parameter>
    <parameter name="transport.vfs.ActionAfterFailure">MOVE</parameter>

    <target>
        <inSequence>=
            <header name="Action" value="urn:getQuote"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <property name="transport.vfs.ReplyFileName"
                      expression="fn:concat(fn:substring-after(get-property('MessageID'), 'urn:uuid:'), '.xml')" scope="transport"/>
            <property action="set" name="OUT_ONLY" value="true"/>
            <send>
                <endpoint>
                    <address uri="vfs:smb://host/test/out"/>
                </endpoint>
            </send>
        </outSequence>
    </target>
    <publishWSDL key="conf:custom/sample_proxy_1.wsdl"/>
</proxy>
```

## Build and run

To test this sample, the following files and directories should be created:
1.  Download the provider [jar](https://repo1.maven.org/maven2/jcifs/jcifs/1.3.17/jcifs-1.3.17.jar) and place it in <MI_HOME>/lib directory and continue with the feature.
    Please note that, since the above library is licensed under LGPL version 2.1 and by downloading and 
    installing the library you will have to comply with the terms of LGPL version 2.1 and its restrictions as found in https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html."
    
2.  Create the file directories:

    -   Create a directory named **test** on a windows machine and create
        three sub directories named **in** , **out** and **original** within
        the test directory.
    -   Grant permission to the network users to read from and write to the
        **test** directory and sub directories.
    -   Be sure to update the **in**, **original**, and **original** directory locations with the values given as the 
        `transport.vfs.FileURI`,
        `transport.vfs.MoveAfterProcess`,
        `transport.vfs.MoveAfterFailure` parameter values in your synapse configuration. 
    -   You need to set both `transport.vfs.MoveAfterProcess` and `transport.vfs.MoveAfterFailure` parameter values to point to the **original** directory location.
    -   Be sure that the endpoint in the `<outSequence>` points to the **out** directory location. Make sure that the prefix `vfs:` in the endpoint URL is not removed or changed.

3.  Add [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl) as a [registry resource]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources). Change the registry path of the proxy accordingly. 
    
4.  Set up the back-end service.
        
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
    
5.  Create the `test.xml` file shown below and copy it to the location specified by `transport.vfs.FileURI` in the configuration (i.e., the **in** directory). This contains a simple stock quote request in XML/SOAP format.

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
