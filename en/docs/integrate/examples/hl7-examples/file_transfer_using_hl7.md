# Using HL7 Messages with File Systems

The Micro Integrator of WSO2 EI allows messages to be transferred between HL7 and the file system using the HL7 
and VFS transports.

## Transferring HL7 messages between file systems

Let's look at how a proxy service reads HL7 messages stored in a file system and transfers them to another file system.

### Synapse configuration

Given below is a proxy service that is configured to detect HL7 files (`.hl7`) in the folder specified by the `transport.vfs.FileURI` parameter. Note that the VFS content type is set to `application/edi-hl7` MIME type with an optional charset encoding. When you save the .hl7 file to the `home/user/test/in` folder, the proxy service invokes the HL7 builders/formatters and builds the HL7 message into its equivalent XML format. It then forwards the message to the VFS endpoint `/tmp/out`.

!!! Info
    Be sure to replace file directories specied below with actual directories in your own file system.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse" name="FileSystemToFileSystem" transports="vfs">
  <target>
    <inSequence>
      <property name="OUT_ONLY" value="true" scope="default" type="STRING"/>
      <property name="transport.vfs.ReplyFileName" expression="get-property('transport','FILE_NAME')" scope="transport" type="STRING"/>
      <log level="full"/>
      <send>
        <endpoint>
          <address uri="vfs:file:///home/user/test/out"/>
        </endpoint>
      </send>
    </inSequence>
  </target>
  <parameter name="transport.PollInterval">5</parameter>
  <parameter name="transport.vfs.FileURI">file:///home/user/test/in</parameter>
  <parameter name="transport.vfs.FileNamePattern">.*\.hl7</parameter>
  <parameter name="transport.vfs.ContentType">application/edi-hl7;charset="iso-8859-15"</parameter>
  <parameter name="transport.hl7.ValidateMessage">false</parameter>
</proxy>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Configure the HL7 transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport) in your Micro Integrator.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

To test this scenario:

1.	Copy the following HL7 message into a text editor and save it with the `.hl7` extension inside the directory you specified with the `transport.vfs.FileURI` parameter in the above example.

	```bash
	MSH|^~\&|Abc|Def|Ghi|JKL|20131231000000||ADT^A01|1234567|P|2.6|||NE|NE|CH|
	```
	
2.	See that the files are immediately moved to the folder specified by the endpoint.

## Transferring messages from HL7 to file system

Now, let's look at how we can receive an HL7 message and transfer it to a file system. 

### Synapse configuration

When the following proxy service runs, an HL7 service will start listening on the port defined by the `transport.hl7.Port` parameter. When the HL7 message arrives, the proxy will send an ACK back to the client as specified in the `HL7_RESULT_MODE` property. The HL7 message is then processed and sent to the VFS endpoint, which will save the HL7 message to the given directory.

!!! Info
    Be sure to replace file directories specied below with actual directories in your own file system. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
     name="HL7ToFileSystem"
     transports="hl7"
     statistics="disable"
     trace="disable"
     startOnLoad="true">
 <target>
    <inSequence>
       <log level="full"/>
       <property name="HL7_RESULT_MODE" value="ACK" scope="axis2"/>
       <property name="OUT_ONLY" value="true"/>
       <property name="transport.vfs.ReplyFileName"
                 expression="fn:concat(get-property('SYSTEM_DATE', 'yyyyMMdd.HHmmssSSS'), '.xml')"
                 scope="transport"/>
       <send>
          <endpoint>
             <address uri="vfs:file:///home/user/test/out"/>
          </endpoint>
       </send>
    </inSequence>
 </target>
 <parameter name="transport.hl7.AutoAck">false</parameter>
 <parameter name="transport.hl7.Port">55555</parameter>
 <parameter name="transport.hl7.ValidateMessage">false</parameter>
 <description/>
</proxy>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Configure the HL7 transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport) in your Micro Integrator.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

To test this scenario: 

1.	Use an HL7 client (such as <b>HAPI</b>) to send a message to the port specified by the `transport.hl7.Port` parameter. 
2.	See that the message is successfully saved to the file system specified as the endpoint.

## Transferring messages from HL7 to FTP

The following configuration is similar to the previous example, but it illustrates how to process files between an HL7 endpoint and files accessed through FTP.

### Synapse configuration

Given below is a proxy service that will detect .hl7 files in the `transport.vfs.FileURI` directory and send them to the HL7 endpoint.

!!! Info
    Be sure to replace file directories specied below with actual directories in your own file system.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="SFTPToHL7"
       transports="vfs"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
   <target>
      <inSequence>
         <property name="OUT_ONLY" value="true" scope="default" type="STRING"/>
         <log level="full"/>
         <send>
            <endpoint>
               <address uri="hl7://localhost:9988"/>
            </endpoint>
         </send>
      </inSequence>
      <outSequence>
         <drop/>
      </outSequence>
   </target>
   <parameter name="transport.vfs.ReconnectTimeout">2</parameter>
   <parameter name="transport.vfs.ActionAfterProcess">MOVE</parameter>
   <parameter name="transport.PollInterval">5</parameter>
   <parameter name="transport.hl7.AutoAck">false</parameter>
   <parameter name="transport.vfs.MoveAfterProcess">vfs:sftp://user:pass@localhost/vfs/out</parameter>
   <parameter name="transport.vfs.FileURI">vfs:sftp://user:pass@localhost/vfs/in</parameter>
   <parameter name="transport.vfs.MoveAfterFailure">vfs:sftp://user:pass@localhost/vfs/failed</parameter>
   <parameter name="transport.vfs.FileNamePattern">.*\.hl7</parameter>
   <parameter name="transport.vfs.ContentType">application/edi-hl7;charset="iso-8859-15"</parameter>
   <parameter name="transport.vfs.ActionAfterFailure">MOVE</parameter>
   <parameter name="transport.hl7.ValidateMessage">false</parameter>
   <description/>
</proxy>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Configure the HL7 transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport) in your Micro Integrator.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

To test this scenario: 

1.	Use an HL7 client (such as <b>HAPI</b>) to receive HL7 messages on the port specified as the endpoint (which is `9988`) in the above proxy service. 
2.	Place an HL7 message in the `transport.vfs.FileURI` directory and see that the message passed to the HL7 endpoint in the HL7 client.
