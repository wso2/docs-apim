# MTOM and SwA Optimizations and Request/Response Correlation

This sample demonstrates how you can use content optimization mechanisms such as **Message Transmission Optimization Mechanism** (MTOM) and **SOAP with
Attachments** (SwA) with the Micro Integrator.

By default, the Micro Integrator serializes binary data as Base64 encoded strings and sends them in the SOAP payload. MTOM and SwA define mechanisms over which files with binary content can be transmitted over SOAP web services.

The configuration sets a local message context property, and forwards
the message to
`http://localhost:9000/services/MTOMSwASampleService`
optimizing the binary content as MTOM. You can see the actual message
sent over the http transport if required by sending this message through
TCPMon.

During response processing, the
Micro Integrator can identify the past information (by checking the local message property) about the current message context,
and use this knowledge to transfer the response back to the client
in the same format as the original request.  

!!! Note
    In a content aware mediation scenario (where the message gets built), you can use the following property to decode the 
    multipart message that is being sent to the backend. Otherwise, the outgoing message will be in encoded form.
    ```xml
    <property name="DECODE_MULTIPART_DATA" value="true" scope="axis2" action="set" type="BOOLEAN"/>
    ```
    
## Synapse configuration

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<sequence name="main">
    <in>
        <filter source="get-property('Action')" regex="urn:uploadFileUsingMTOM">
            <property name="example" value="mtom"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/MTOMSwASampleService" optimize="mtom"/>
                </endpoint>
            </send>
        </filter>
        <filter source="get-property('Action')" regex="urn:uploadFileUsingSwA">
            <property name="example" value="swa"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/MTOMSwASampleService" optimize="swa"/>
                </endpoint>
            </send>
        </filter>
    </in>
    <out>
        <filter source="get-property('example')" regex="mtom">
            <property name="enableMTOM" value="true" scope="axis2"/>
        </filter>
        <filter source="get-property('example')" regex="swa">
            <property name="enableSwA" value="true" scope="axis2"/>
        </filter>
        <send/>
    </out>
</sequence>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2.  Open the `deployment.toml` file (stored in the `MI_HOME/conf` directory) and add the following configurations:

    - To enable MTOM:
       ```toml
       [server]
       enable_mtom = true
       ```
      When this is enabled, all outgoing messages will be serialized and
        sent as MTOM optimized MIME messages.You can override this
        configuration per service in the `services.xml`
        configuration file.

    - To enable SwA:
       ```toml
       [server]
       enable_swa = true
       ```
      When this is enabled, incoming SwA messages are automatically
        identified by the Micro Integrator. 

3. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
4. Create the [main sequence]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) with the configurations given above.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

When your client executes successfully, it will upload a file containing
the ASF logo, receive its response, and save the response to a
temporary file.

<!--
When you analyze the log once the client is run specifying MTOM
optimization, you will see an output as follows:
```bash
[java] Sending file : ./../../repository/samples/resources/mtom/asf-logo.gif as MTOM
[java] Saved response to file : ./../../work/temp/sampleClient/mtom-49258.gif
```
-->

If you use TCPMon and send the message through it, you will see that the requests and responses sent are MTOM/SwA optimized or sent as http
attachments as follows:

- **MTOM**

    ```xml
    POST http://localhost:9000/services/MTOMSwASampleService HTTP/1.1
    Host: 127.0.0.1
    SOAPAction: urn:uploadFileUsingMTOM
    Content-Type: multipart/related; boundary=MIMEBoundaryurn_uuid_B94996494E1DD5F9B51177413845353; type="application/xop+xml";
    start="<0.urn:uuid:B94996494E1DD5F9B51177413845354@apache.org>"; start-info="text/xml"; charset=UTF-8
    Transfer-Encoding: chunked
    Connection: Keep-Alive
    User-Agent: Synapse-HttpComponents-NIO

    --MIMEBoundaryurn_uuid_B94996494E1DD5F9B51177413845353241
    Content-Type: application/xop+xml; charset=UTF-8; type="text/xml"
    Content-Transfer-Encoding: binary
    Content-ID:
       <0.urn:uuid:B94996494E1DD5F9B51177413845354@apache.org>221b1
          <?xml version='1.0' encoding='UTF-8'?>
             <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
                <soapenv:Body>
                   <m0:uploadFileUsingMTOM xmlns:m0="http://www.apache-synapse.org/test">
                      <m0:request>
                         <m0:image>
                            <xop:Include href="cid:1.urn:uuid:78F94BC50B68D76FB41177413845003@apache.org" xmlns:xop="http://www.w3.org/2004/08/xop/include" />
                         </m0:image>
                      </m0:request>
                   </m0:uploadFileUsingMTOM>
                </soapenv:Body>
             </soapenv:Envelope>
    --MIMEBoundaryurn_uuid_B94996494E1DD5F9B51177413845353217
    Content-Type: image/gif
    Content-Transfer-Encoding: binary
    Content-ID:
             <1.urn:uuid:78F94BC50B68D76FB41177413845003@apache.org>22800GIF89a... << binary content >>
    ```

- **SWA**

    ```xml
    POST http://localhost:9000/services/MTOMSwASampleService HTTP/1.1
    Host: 127.0.0.1
    SOAPAction: urn:uploadFileUsingSwA
    Content-Type: multipart/related; boundary=MIMEBoundaryurn_uuid_B94996494E1DD5F9B51177414170491; type="text/xml";
    start="<0.urn:uuid:B94996494E1DD5F9B51177414170492@apache.org>"; charset=UTF-8
    Transfer-Encoding: chunked
    Connection: Keep-Alive
    User-Agent: Synapse-HttpComponents-NIO

    --MIMEBoundaryurn_uuid_B94996494E1DD5F9B51177414170491225
    Content-Type: text/xml; charset=UTF-8
    Content-Transfer-Encoding: 8bit
    Content-ID:
       <0.urn:uuid:B94996494E1DD5F9B51177414170492@apache.org>22159
          <?xml version='1.0' encoding='UTF-8'?>
             <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
                <soapenv:Body>
                   <m0:uploadFileUsingSwA xmlns:m0="http://www.apache-synapse.org/test">
                      <m0:request>
                         <m0:imageId>urn:uuid:15FD2DA2584A32BF7C1177414169826</m0:imageId>
                      </m0:request>
                   </m0:uploadFileUsingSwA>
                </soapenv:Body>
             </soapenv:Envelope>22--34MIMEBoundaryurn_uuid_B94996494E1DD5F9B511774141704912
    17
    Content-Type: image/gif
    Content-Transfer-Encoding: binary
    Content-ID:
             <urn:uuid:15FD2DA2584A32BF7C1177414169826>22800GIF89a... << binary content >>
    ```
