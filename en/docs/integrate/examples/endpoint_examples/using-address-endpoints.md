# Using the Address Endpoint
This sample demonstrates how you can convert a POX message to a SOAP request using an <b>Address</b> endpoint.

## Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<?xml version="1.0" encoding="UTF-8"?>
 <proxy name="SimpleStockQuoteProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
     <target>
         <inSequence>
             <!-- filtering of messages with XPath and regex matches -->
             <filter regex=".*StockQuote.*" source="get-property('To')">
                 <then>
                     <header name="Action" scope="default" value="urn:getQuote"/>
                     <call>
                         <endpoint>
                             <address format="soap11" uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                         </endpoint>
                     </call>
                     <respond/>
                 </then>
                 <else/>
             </filter>
         </inSequence>
         <outSequence/>
         <faultSequence/>
     </target>
</proxy>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create a proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

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

Send the following request:

```bash
POST /services/SimpleStockQuoteProxy/StockQuote HTTP/1.1
Content-Type: application/xml; charset=UTF-8;action="urn:getQuote";
SOAPAction: urn:getQuote
User-Agent: Axis2
Host: 127.0.0.1
Transfer-Encoding: chunked

<m0:getQuote xmlns:m0="http://services.samples" xmlns:xsd="http://services.samples/xsd">
   <m0:request>
      <m0:symbol>IBM</m0:symbol>
   </m0:request>
</m0:getQuote>
```

This HTTP REST request will be transformed into a SOAP request and forwarded to the stock quote service.