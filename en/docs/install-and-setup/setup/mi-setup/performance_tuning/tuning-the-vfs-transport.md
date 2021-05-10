# Tuning the VFS Transport

When you work with the [VFS transport]({{base_path}}/reference/synapse-properties/transport-parameters/vfs-transport-parameters), you might have a scenario where you need to send large files to a destination. If you use the normal VFS configuration, the memory consumption will be very high since WSO2 Micro Integrator builds the files that are within. The Micro Integrator provides VFS file streaming support to overcome this issue. With VFS file streaming, only the stream is
passed and therefore memory consumption is less.

!!! Tip
    When you transfer a file to a remote FTP location via VFS, the Micro Integrator tries to detect the FTP location by navigating from the root folder first. If the Micro Integrator does not have **at least list permission** to the root (/), the file transfer fails.

To use the streaming mode with the VFS transport, see the following instructions:

## Update server-level configurations

1. Open the `deployment.toml` file from the `MI_HOME/conf` directory.
2. Binary message builder and formatter are enabled by default. Be sure that the following configurations unchanged in the `deployment.toml` file.

    ```toml
    [message_builders]
    application_binary = "org.apache.axis2.format.BinaryBuilder"   
 
    [message_formatters]
    application_binary = "org.apache.axis2.format.BinaryFormatter"
    ```

    See the complete list of [parameters]({{base_path}}/reference/config-catalog-mi) for configuring message builders and formatters.

## Update service-level configurations

Apply the following configurations when you create a proxy service.

1.  In the proxy service where you use the VFS transport, add the following parameter to enable streaming:

    ```xml
    <parameter name="transport.vfs.Streaming">true</parameter>
    ```

2.  In the same proxy service, add the following property before the Send mediator:

    !!! Info
        You also need to add the following property if you want to use the VFS transport to transfer files from VFS to VFS.
    
        ```xml
        <property name="ClientApiNonBlocking" value="true" scope="axis2" action="remove"/>
        ```

Following is a sample configuration that uses the VFS transport to handle large files:

```xml
    <proxy xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteProxy" transports="vfs">
        <parameter name="transport.vfs.FileURI">smb://host/test/in</parameter>        
        <parameter name="transport.vfs.ContentType">text/xml</parameter>
        <parameter name="transport.vfs.FileNamePattern">.*\.xml</parameter>
        <parameter name="transport.PollInterval">15</parameter>
        <parameter name="transport.vfs.Streaming">true</parameter>
        <parameter name="transport.vfs.MoveAfterProcess">smb://host/test/original</parameter>            
        <parameter name="transport.vfs.MoveAfterFailure">smb://host/test/original</parameter>          
        <parameter name="transport.vfs.ActionAfterProcess">MOVE</parameter>
        <parameter name="transport.vfs.ActionAfterFailure">MOVE</parameter>
        <target>
             <inSequence>
                <property name="transport.vfs.ReplyFileName"
                          expression="fn:concat(fn:substring-after(get-property('MessageID'), 'urn:uuid:'), '.xml')" scope="transport"/>
                <property action="set" name="OUT_ONLY" value="true"/>
                <property name="ClientApiNonBlocking" value="true" scope="axis2" action="remove"/>
                <send>
                    <endpoint>
                        <address uri="vfs:smb://host/test/out"/> 
                    </endpoint>
                </send>
            </inSequence>
        </target>
        <publishWSDL uri="file:repository/samples/resources/proxy/sample_proxy_1.wsdl"/>
    </proxy>
```
