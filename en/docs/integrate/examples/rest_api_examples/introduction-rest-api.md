# Using a Simple REST API

You can configure REST endpoints in the Micro Integrator by directly specifying HTTP verbs, URL patterns, URI templates, HTTP media types, and other related headers. You can define REST APIs and the associated resources by combining REST APIs with mediation features provided by the underlying messaging framework.

## Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

This is a REST api with two api resources. The GET calls are handled by the first resource. These REST calls will get converted into SOAP calls and sent to the back-end service. The response will be sent to the client in POX format.

```xml
<api name="StockQuoteAPI" context="/stockquote" xmlns="http://ws.apache.org/ns/synapse">
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
         <send/>
      </outSequence>
   </resource>
   <resource methods="POST" url-mapping="/order/*">
      <inSequence>
         <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2"/>
         <property name="OUT_ONLY" value="true"/>
         <header name="Action" value="urn:placeOrder"/>
         <send>
            <endpoint>
                <address uri="http://localhost:9000/services/SimpleStockQuoteService" format="soap11"/>
            </endpoint>
         </send>
      </inSequence>      
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

Invoke the sample Api:

-   Sending a GET request.
   
      Open a terminal and execute the following command. This sends a simple GET request to the Micro Integrator.
        
      ```bash
      curl http://127.0.0.1:8290/stockquote/view/IBM
      ```
    
      The Micro Integrator returns the following response to the client.

      ```xml
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

-  Sending a POST request.
    1. Save the following sample request as `placeorder.xml` in your local file system. 
    
        ```bash
        <placeOrder xmlns="http://services.samples">
          <order>
             <price>50</price>
             <quantity>10</quantity>
             <symbol>IBM</symbol>
          </order>
        </placeOrder>
        ```
    
    2.  Open a terminal, navigate to the location of your `placeorder.xml` file, and execute the following command. This posts a simple XML request to the Micro Integrator.
    
        ```bash
        curl -v -d @placeorder.xml -H "Content-type: application/xml" http://127.0.0.1:8290/stockquote/order/
        ```
    
        The Micro Integrator returns the 202 response back to the client.
    
        ```xml
        < HTTP/1.1 202 Accepted
        < Date: Wed, 30 Oct 2019 05:33:49 GMT
        < Transfer-Encoding: chunked
        ```
