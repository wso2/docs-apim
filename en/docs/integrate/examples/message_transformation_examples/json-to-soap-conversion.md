# Converting JSON to SOAP 

Let's consider a scenario where you have a SOAP-based backend and a JSON client. The SOAP backend is exposed as a REST API in the Micro Integrator. 

When the JSON client sends a message to the SOAP backend, the REST Api in the Micro Integrator should convert the JSON message to SOAP. The backend will process the SOAP request and generate a response for the JSON client. The Micro Integrator should then convert the SOAP response back to JSON and return it to the client.

The following examples explain different methods of converting JSON messages to SOAP using the Micro Integrator.

## Using the PayloadFactory Mediator

Let's convert JSON messages to SOAP using the [PayloadFactory mediator]({{base_path}}/reference/mediators/payloadfactory-mediator).

### Synapse configuration
Following is a sample REST Api configuration that we can use to implement this scenario. 
See the instructions on how to [build and run](#build-and-run-example-1) this example.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/stockorder_api" name="JSONToSOAP" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST PUT GET">
        <inSequence>
            <payloadFactory media-type="xml">
                <format>
                    <soapenv:Envelope xmlns:ns="http://www.viewstar.com/webservices/2002/11" xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">
                        <soapenv:Header/>
                        <soapenv:Body>
                            <ns:placeOrder>
                                <ns:order>
                                    <ns:symbol>$1</ns:symbol>
                                    <ns:price>$2</ns:price>
                                    <ns:quantity>$3</ns:quantity>
                                </ns:order>
                            </ns:placeOrder>
                        </soapenv:Body>
                    </soapenv:Envelope>
                </format>
                <args>
                    <arg evaluator="json" expression="$.placeOrder.order.symbol"/>
                    <arg evaluator="json" expression="$.placeOrder.order.price"/>
                    <arg evaluator="json" expression="$.placeOrder.order.quantity"/>
                </args>
            </payloadFactory>
            <log level="full"/>
            <call>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService">
                        <suspendOnFailure>
                            <initialDuration>-1</initialDuration>
                            <progressionFactor>-1</progressionFactor>
                            <maximumDuration>0</maximumDuration>
                        </suspendOnFailure>
                        <markForSuspension>
                            <retriesBeforeSuspension>0</retriesBeforeSuspension>
                        </markForSuspension>
                    </address>
                </endpoint>
            </call>
            <property name="messageType" scope="axis2" value="application/json"/>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>
```

### Build and run (example 1)

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
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

Invoke the REST Api:

- HTTP method: POST
- Request URL: http://localhost:8290/stockorder_api
- Content-Type: application/json
- SoapAction: urn:placeOrder
- Message Body:
    ```json
    {"placeOrder":
      {"order":
        {
          "symbol":"IBM",
          "price":"3.141593E0",
          "quantity":"4"
        }
      }
    }
    ```

Check the log printed on the back-end service's terminal to confirm that the order is successfully placed.

```xml
2020-01-30 16:39:51,902 INFO  [wso2/stockquote_service] - Stock quote service invoked. 
2020-01-30 16:39:51,904 INFO  [wso2/stockquote_service] - Generating placeOrder response 
2020-01-30 16:39:51,904 INFO  [wso2/stockquote_service] - The order was placed. 
```

The JSON client will receive the following response from the backend confirming that the stock order is placed:

```json
{
    "Envelope": {
        "Body": {
            "placeOrderResponse": {
                "status": "created"
            }
        }
    }
}
```

## Using the XSLT Mediator

Let's convert JSON messages to SOAP using the [XSLT mediator]({{base_path}}/reference/mediators/xslt-mediator). The XSLT, which specifies the message conversion parameters, is stored in the product registry as a **local entry**.

### Synapse configuration
Following are the synapse configurations for implementing this scenario. 
See the instructions on how to [build and run](#build-and-run-example-2) this example.

```xml tab='REST Api'
<?xml version="1.0" encoding="UTF-8"?>
<api context="/stockorder_api" name="Convert_JSON_To_Soap_Using_XSLT" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="POST GET">
        <inSequence>
            <log level="full"/>
            <xslt key="in_transform"/>
            <header name="Action" scope="default" value="urn:getQuote"/>
            <enrich>
                <source clone="true" xmlns:m0="http://services.samples" xpath="//m0:getQuote"/>
                <target type="body"/>
            </enrich>
            <call>
                <endpoint>
                    <address format="soap11" uri="http://localhost:9000/services/SimpleStockQuoteService">
                        <suspendOnFailure>
                            <initialDuration>-1</initialDuration>
                            <progressionFactor>1</progressionFactor>
                        </suspendOnFailure>
                        <markForSuspension>
                            <retriesBeforeSuspension>0</retriesBeforeSuspension>
                        </markForSuspension>
                    </address>
                </endpoint>
            </call>
            <property name="messageType" scope="axis2" type="STRING" value="application/json"/>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
</api>
```

```xml tab='Local Entry - In Transform XSLT'
<?xml version="1.0" encoding="UTF-8"?>
<localEntry key="in_transform" xmlns="http://ws.apache.org/ns/synapse">
    <xsl:stylesheet exclude-result-prefixes="m0 fn" version="2.0" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:m0="http://services.samples" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
        <xsl:template match="*">
            <xsl:element name="{local-name()}" namespace="http://services.samples">
                <xsl:copy-of select="attribute::*"/>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:template>
    </xsl:stylesheet>
</localEntry>
```

### Build and run (example 2)

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project).
3. [Create the REST API]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
4. [Create a local entry]({{base_path}}/integrate/develop/creating-artifacts/registry/creating-local-registry-entries) named **in_transform** with the above XSLT configuration.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-and-run) in your Micro Integrator.

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

Invoke the REST Api:

- HTTP method: POST
- Request URL: http://localhost:8290/stockorder_api
- Content-Type: application/json
- SoapAction: urn:getQuote
- Message Body:
    ```json
    {"getQuote":
      {"request":
        {"symbol":"IBM"}
      }
    }
    ```

Check the log printed on the back-end service's terminal to confirm that the request is successfully sent.

```xml
2020-01-30 15:35:28,088 INFO  [wso2/stockquote_service] - Stock quote service invoked. 
2020-01-30 15:35:28,090 INFO  [wso2/stockquote_service] - Generating getQuote response for IBM 
2020-01-30 15:35:28,091 INFO  [wso2/stockquote_service] - Stock quote generated. 
```

The JSON client will receive the following response from the backend with the relevant stock quote:

```json
{
    "Envelope": {
        "Body": {
            "getQuoteResponse": {
                "change": -2.86843917118114,
                "earnings": -8.540305401672558,
                "high": -176.67958828498735,
                "last": 177.66987465262923,
                "low": -176.30898912339075,
                "marketCap": 56495579.98178506,
                "name": "IBM Company",
                "open": 185.62740369461244,
                "peRatio": 24.341353665128693,
                "percentageChange": -1.4930577008849097,
                "prevClose": 192.11844053187397,
                "symbol": "IBM",
                "volume": 7791
            }
        }
    }
}
```