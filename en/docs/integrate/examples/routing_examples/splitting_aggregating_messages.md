# Splitting Messages and Aggregating Responses

This example scenario uses a back-end service with two stock quote inventories (IBM and SUN). A proxy service is configured in the Micro Integrator with the **Iterate** mediator (to split the incoming message) and the **Aggregate** mediator (to aggregate the responses).

When a stock quote request is received by the Micro Integrator, the proxy service will read the **message payload** and first identify the parts of the message that are intended for each of the inventories. The Iterate mediator will then split the message and route the parts to the relevant inventories in the backend. These messages will be processed asynchronously. 

When the response messages are received from the backend, the Aggregate mediator will aggregate the responses into one and send to the client.

## Synapse configuration
    
Listed below are the synapse configurations (proxy service) for implementing this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy name="SplitAggregateProxy" xmlns="http://ws.apache.org/ns/synapse" transports="https http" startOnLoad="true" trace="disable">
    <target>
        <inSequence>
            <iterate expression="//m0:getQuote/m0:request" preservePayload="true"
                     attachPath="//m0:getQuote"
                     xmlns:m0="http://services.samples">
                <target>
                    <sequence>
                        <header name="Action" scope="default" value="urn:getQuote"/>
                        <send>
                            <endpoint>
                                <address
                                    uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                            </endpoint>
                        </send>
                    </sequence>
                </target>
            </iterate>
        </inSequence>
        <outSequence>
            <property name="enclose" scope="default">
            <ns:Results xmlns:ns="http://services.samples" />
            </property>
             <aggregate>
                <onComplete expression="$body/*[1]" enclosingElementProperty="enclose">
                    <send/>
                </onComplete>
           </aggregate>
        </outSequence>
    </target>
</proxy>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
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

Invoke the sample proxy service:

```xml
HTTP method: POST 
Request URL: http://localhost:8290/services/SplitAggregateProxy
Content-Type: text/xml;charset=UTF-8
SOAPAction: "urn:mediate"
CustomHeader: application/json
Message Body:
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header/>
   <soapenv:Body>
   <m0:getQuote xmlns:m0="http://services.samples" xmlns:xsd="http://services.samples/xsd">
        <m0:request>
            <m0:symbol>IBM</m0:symbol>
        </m0:request>
        <m0:request>
            <m0:symbol>SUN</m0:symbol>
        </m0:request>
    </m0:getQuote>
   </soapenv:Body>
</soapenv:Envelope>
```

You can then observe that the response from the proxy service is the aggregated response received for each of the `getQuote` requests that were sent to the backend.

```xml
<ns:Results xmlns:ns="http://services.samples">
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ax21="http://services.samples/xsd">
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
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ax21="http://services.samples/xsd">
        <soapenv:Body>
            <ns:getQuoteResponse>
                <ax21:change>-2.86843917118114</ax21:change>
                <ax21:earnings>-8.540305401672558</ax21:earnings>
                <ax21:high>-176.67958828498735</ax21:high>
                <ax21:last>177.66987465262923</ax21:last>
                <ax21:low>-176.30898912339075</ax21:low>
                <ax21:marketCap>5.649557998178506E7</ax21:marketCap>
                <ax21:name>SUN Company</ax21:name>
                <ax21:open>185.62740369461244</ax21:open>
                <ax21:peRatio>24.341353665128693</ax21:peRatio>
                <ax21:percentageChange>-1.4930577008849097</ax21:percentageChange>
                <ax21:prevClose>192.11844053187397</ax21:prevClose>
                <ax21:symbol>SUN</ax21:symbol>
                <ax21:volume>7791</ax21:volume>
            </ns:getQuoteResponse>
        </soapenv:Body>
    </soapenv:Envelope>
</ns:Results>
```
