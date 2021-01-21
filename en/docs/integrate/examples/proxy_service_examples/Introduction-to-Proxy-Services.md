# Using a Simple Proxy Service
This example demonstrates how to use a simple proxy service to expose a back-end service. In this example, a request received by the proxy service is forwarded to the sample service hosted in the backend.

## Synapse configuration
Following is a sample proxy service configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

An `inSequence` or `endpoint` or both of these would decide how the message would be handled after the proxy service receives the message. The
`outSequence` defines how the response is handled before it is sent back to the client.

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

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.

    !!! Tip
        Download the wsdl file (`sample_proxy_1.wsdl`) from [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl).
        The wsdl uri in the proxy service needs to be updated with the path to this `sample_proxy_1.wsdl` file.

4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

When the Micro Integrator starts, you could go to the following URL and view the WSDL generated for the proxy service defined in the configuration. 

```bash
http://localhost:8290/services/StockQuoteProxy?wsdl
```

This WSDL is based on the source WSDL supplied in the proxy service definition and is updated to reflect the proxy service EPR.

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

Set up the SOAPUI client. 

1. Download and Install [SoapUI](https://www.soapui.org/downloads/soapui.html) to run this SOAP service.
2. Create a new SOAP project in the SoapUI using following wsdl file:

   ```bash
   http://localhost:8290/services/StockQuoteProxy?wsdl
   ```
   
Send requests to the proxy service:

-   Send the following payload to receive a response containing the last sales price for the stock. You can 
use the `getQuote` operation.
       
    ```xml
    <ser:getQuote xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
        <ser:request>
            <xsd:symbol>IBM</xsd:symbol>
        </ser:request>
    </ser:getQuote>
    ```

-   Send the following payload to get simple quote response containing the last sales price for stock. You can 
use the `getSimpleQuote` operation.

    ```xml
    <ser:getSimpleQuote xmlns:ser="http://services.samples">
        <ser:symbol>IBM</ser:symbol>
    </ser:getSimpleQuote>
    ```

-   Send the following payload to get quote reports for the stock over a number of days (i.e. last 100 days of the year). You can use the `getFullQuote` operation.

    ```xml
    <ser:getFullQuote xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
        <ser:request>
            <xsd:symbol>IBM</xsd:symbol>
        </ser:request>
    </ser:getFullQuote>
    ```

-   Send the following payload as an order for stocks using a
    one way request. You can use the `placeOrder` operation.

    ```xml
    <ser:placeOrder xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
        <ser:order>
            <xsd:price>3.141593E0</xsd:price>
            <xsd:quantity>4</xsd:quantity>
            <xsd:symbol>IBM</xsd:symbol>
        </ser:order>
    </ser:placeOrder>
    ```

-   Send the following paylaod to get a market activity report
    for the day (i.e. quotes for multiple symbols). You can use the `getMarketActivity` operation.

    ```xml
    <ser:getMarketActivity xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
        <ser:request>
            <xsd:symbols>IBM</xsd:symbols>
            ...
            <xsd:symbols>MSFT</xsd:symbols>
        </ser:request>
    </ser:getMarketActivity>
    ```
