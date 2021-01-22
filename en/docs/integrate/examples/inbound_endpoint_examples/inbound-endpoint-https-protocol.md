# Using the HTTPS Inbound Endpoint
This sample demonstrates how an HTTPS inbound endpoint can act as a
dynamic https listener. Many https listeners can be added without
restarting the server. When a message arrives at a port it will bypass
the inbound side axis2 layer and will be sent directly to the sequence
for mediation.The response also behaves in the same way.

## Synapse configuration

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Inbound Endpoint'
<?xml version="1.0" encoding="UTF-8"?>
<inboundEndpoint name="HttpsListenerEP"
                 protocol="https"
                 suspend="false" sequence="TestIn" onError="fault" >
    <p:parameters xmlns:p="http://ws.apache.org/ns/synapse">
        <p:parameter  name="inbound.http.port">8085</p:parameter>
        <p:parameter name="keystore">
            <KeyStore xmlns="">
                <Location>repository/resources/security/wso2carbon.jks</Location>
                <Type>JKS</Type>
                <Password>wso2carbon</Password>
                <KeyPassword>wso2carbon</KeyPassword>
            </KeyStore>
        </p:parameter>
        <p:parameter name="truststore">
            <TrustStore xmlns="">
                <Location>repository/resources/security/client-truststore.jks</Location>
                <Type>JKS</Type>
                <Password>wso2carbon</Password>
            </TrustStore>
        </p:parameter>
    </p:parameters>
</inboundEndpoint>
```

```xml tab='Sequence 1'
<?xml version="1.0" encoding="UTF-8"?>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="TestIn">
    <call>
        <endpoint>
            <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
        </endpoint>
    </call>
    <respond/>
</sequence>
```

## Build and run

Set up the back-end service:

1. Download the [back-end service](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/axis2Server.zip).
2. Extract the downloaded zip file.
3. Open a terminal, navigate to the `axis2Server/bin/` directory inside the extracted folder.
4. Execute the following command to start the axis2server with the SimpleStockQuote back-end service:
   
      ```bash tab='On MacOS/Linux/CentOS'
      sh axis2server.sh
      ```
          
      ```bash tab='On Windows'
      axis2server.bat
      ```

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. See the instructions on [creating mediation sequences]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) to define the two sequences given above ('Sequence 1' and 'Sequence 2'). 
4. See the instructions on [creating an inbound endpoint]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint) to define the inbound endpoint given above.

    !!! Tip
        Be sure to add an empty namespace for the keystore and truststore elements (`xmlns=""`) in the inbound endpoint as shown above. This is necessary when you run this example in the embedded Micro Integrator of WSO2 Integration Studio.
        
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Invoke the inbound endpoint with the below request. 

!!! Tip
    Be sure to add **basic auth** from the http client you use.

```xml
POST https://localhost:8085 HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: text/xml;charset=UTF-8
SOAPAction: "urn:getQuote"
Content-Length: 492
Host: localhost:8290
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
Authorization: Basic YWRtaW46YWRtaW4=

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getQuote xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
         <!--Optional:-->
         <ser:request>
            <!--Optional:-->
            <xsd:symbol>IBM</xsd:symbol>
         </ser:request>
      </ser:getQuote>
   </soapenv:Body>
</soapenv:Envelope>
```

Analyze the output debug messages for the actions in the dumb client mode. You will see that the Micro Integrator receives a message when the Micro Integrator Inbound is set as the ultimate receiver. You will also see the response from the back
end in the client.
