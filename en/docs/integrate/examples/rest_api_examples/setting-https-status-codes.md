# Handling HTTP Status Codes
A REST service typically sends HTTP status codes with its response. When you configure an API that send messages to a SOAP back-end service, you can set the status code of the HTTP response within the configuration. To achieve this, set the status code parameter within the **Out** sequence of the API definition.

## Synapse configuration  

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteAPI" context="/stockquote">`
    <resource uri-template="/view/{symbol}" methods="GET">
         <inSequence>
              <payloadFactory>
                  <format>
                     <m0:getQuote xmlns:m0="http://services.samples">
                        <m0:request>
                           <m0:symbol>$1</m0:symbol>
                        </m0:request>
                     </m0:getQuote>
                   </format>
                   <args>
                    <arg expression="get-property('uri.var.symbol')"/>
                   </args>
              </payloadFactory>
              <header name="Action" value="urn:getQuote"/>
              <send>
                  <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService" format="soap11"/>
                  </endpoint>
              </send>
        </inSequence>
        <outSequence>
            <property name="HTTP_SC" value="201" scope="axis2" />
            <send/>
        </outSequence>  
    </resource>
 </api>
```  

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the rest api]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
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

Send the following request to the Micro Integrator:
    
```bash
curl -v http://127.0.0.1:8290/stockquote/view/IBM
```

The response message will contain the following response code (201) and the requeste stock quote information.  

```bash
< HTTP/1.1 201 Created
< server: ballerina
< Access-Control-Allow-Methods: GET
< content-type: text/plain
< Access-Control-Allow-Headers: 
< Date: Tue, 29 Oct 2019 15:41:05 GMT
< Transfer-Encoding: chunked
```

The requested stock quote information:

```xml
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
```