# Publishing a Custom WSDL
When you create a proxy service, a default WSDL is automatically
generated. You can access this WSDL by suffixing the service URL
with ?wsdl. See the example given below, where the proxy service name is
'sample_service' and IP is localhost:

[http://localhost:8290/services/sample_service?wsdl](http://localhost:8290/services/Logging?wsdl)

However, this default WSDL only shows the `mediate`
operation. This can be a limitation because your proxy service may be
exposing a back-end service that expects additional information such as
the message format. Therefore, the proxy service should be able to
publish a custom WSDL based on the back-end service's WSDL or a modified
version of that WSDL. For example, if the back-end service expects a
message that includes the name, department, and permission level, and
you want the proxy service to inject the permission level as it
processes the message, you could publish a WSDL that includes just the
name and department without the permission level parameter.
    
## Synapse configuration
Following is a sample proxy service configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<proxy name="StockQuoteProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <endpoint>
            <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
        </endpoint>
        <outSequence>
            <send/>
        </outSequence>
    </target>
    <publishWSDL uri="file:/path/to/sample_proxy_1.wsdl"/>
</proxy>
```

## Build and run

The wsdl file `sample_proxy_1.wsdl` can be downloaded from  [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl). 
The wsdl uri needs to be updated with the path to the sample_proxy_1.wsdl file

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
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Set up the SOAP client: 

1. Download and install [SoapUI](https://www.soapui.org/downloads/soapui.html) to run this SOAP service.
2. Create a new SOAP project in the SoapUI using the following wsdl file:

   ```bash
   http://localhost:8290/services/StockQuoteProxy?wsdl
   ```
 
3.  Use the `getQuote` operation.
4.  Enter the following payload. This will return a response containing the last sales price for the stock.

    ```xml
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

You will receive the following response:

```xml
HTTP/1.1 200 OK
server: ballerina
content-encoding: gzip
content-type: application/xml
Transfer-Encoding: chunked
Connection: Keep-Alive

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://services.samples" xmlns:ax21="http://services.samples/xsd">
   <soapenv:Body>
      <ns:getQuoteResponse>
         <ax21:change>-2.86843917118114</ax21:change>
         <ax21:earnings>-8.540305401672558</ax21:earnings>
         <ax21:high>-176.67958828498735</ax21:high>
         <ax21:last>177.66987465262923</ax21:last>
         <ax21:low>-176.30898912339075</ax21:low>
         <ax21:marketCap>5.649557998178506E7</ax21:marketCap>
         <ax21:name>IBM Company</ax21:name>
         <ax21:open>185.62740369461244</ax21:open>
         <ax21:peRatio>24.341353665128693</ax21:peRatio>
         <ax21:percentageChange>-1.4930577008849097</ax21:percentageChange>
         <ax21:prevClose>192.11844053187397</ax21:prevClose>
         <ax21:symbol>IBM</ax21:symbol>
         <ax21:volume>7791</ax21:volume>
      </ns:getQuoteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```
