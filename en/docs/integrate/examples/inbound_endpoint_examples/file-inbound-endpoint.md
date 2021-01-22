# Using the File Inbound Endpoint
## Failure tracking using File Inbound
To track failures in file processing that can occur when a resource
becomes unavailable, the VFS transport creates and maintains a failed
records file. This text file contains a list of files that failed to
processed. When a failure occurs, an entry with the failed file name and
timestamp is logged in the text file. When the next polling iteration
occurs, the VFS transport checks each file against the failed records
file, and if a file is listed as a failed record, it will skip
processing and schedule a move task to move that file.

### Synapse configuration

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Inbound Endpoint'
<?xml version="1.0" encoding="UTF-8"?>
<inboundEndpoint xmlns="http://ws.apache.org/ns/synapse" 
                 name="file" sequence="request" 
                 onError="fault" 
                 protocol="file" 
                 suspend="false">
   <parameters>
      <parameter name="interval">1000</parameter>
      <parameter name="sequential">true</parameter> 
      <parameter name="coordination">true</parameter> 
      <parameter name="transport.vfs.ActionAfterProcess">MOVE</parameter>
      <parameter name="transport.vfs.MoveAfterProcess">file:///home/user/test/out</parameter>
      <parameter name="transport.vfs.FileURI">file:///home/user/test/in</parameter>
      <parameter name="transport.vfs.MoveAfterFailure">file:///home/user/test/failed</parameter>
      <parameter name="transport.vfs.FileNamePattern">.*.xml</parameter>
      <parameter name="transport.vfs.ContentType">text/xml</parameter>
      <parameter name="transport.vfs.ActionAfterFailure">MOVE</parameter>
   </parameters>
</inboundEndpoint>
```

```xml tab='Sequence'
<?xml version="1.0" encoding="UTF-8"?>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="request">
    <log level="full"/>
</sequence>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create a [mediation sequence]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) and [inbound endpoint]({{base_path}}/integrate/develop/creating-an-inbound-endpoint) with configurations given in the above example.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

To invoke the inbound endpoint, you can create a file with the below content and save it as `request.xml` in the `/home/user/test/in` directory.

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

Once the file is created, the inbound endpoint's sequence (request) is triggered and the following content is logged:

```xml
To: , MessageID: urn:uuid:CA46833F184F7EAA0E1585819580883, Direction: request, Envelope: <?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsa="http://www.w3.org/2005/08/addressing"><soapenv:Body>
       <m0:getQuote xmlns:m0="http://services.samples">
           <m0:request>
               <m0:symbol>IBM</m0:symbol>
           </m0:request>
       </m0:getQuote>
   </soapenv:Body></soapenv:Envelope>
```

## Configuring FTP, SFTP, and FILE Connections

The following section describes how to configure the file inbound protocol for FTP, SFTP, and FILE connections.

-   To configure the file inbound protocol for FTP connections, you should specify the URL as `ftp://{username}:{password}@{hostname/ip_address}/{source_filepath}`:

    ```bash 
    ftp://admin:pass@localhost/orders
    ```

-   To configure the file inbound protocol for SFTP connections, you should specify the URL as `sftp://{username}:{password}@{hostname/ip_address}/{source_filepath}`:

    ```bash 
    sftp://admin:pass@localhost/orders
    ```

!!! Tip
    If the password contains special characters, these characters will need to be replaced with their hexadecimal representation.
    
-   To configure the file inbound protocol for FILE connections, you should specify the URL as `file://{local_file_system_path}`:

    ```bash
    file:///home/user/test/in
    ```
