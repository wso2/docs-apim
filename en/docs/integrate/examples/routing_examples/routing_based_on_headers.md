# Routing Based on Message Headers

This example scenario uses an inventory of stocks as the back-end service. A proxy service is configured in the Micro Integrator to use separate mediation sequences for processing request messages with different **message headers**. 

When a stock quote request is received, the Micro Integrator will read the **request header** and then route the message to the relevant mediation sequence for processing. The relevant sequence will forward the message to the backend, receive the response, process it, and return it to the client.
    
## Synapse configuration
    
Listed below are the synapse configurations for implementing this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab="Proxy Service"
<?xml version="1.0" encoding="UTF-8"?>
<proxy name="HeaderBasedRoutingProxy" xmlns="http://ws.apache.org/ns/synapse" transports="https http" startOnLoad="true" trace="disable">
  <target>
     <!-- When a request arrives the following sequence will be followed -->   
     <inSequence>
       <switch xmlns:ns="http://org.apache.synapse/xsd" source="get-property('transport','CustomHeader')">
              <case regex="application/json">
                  <log level="custom"> 
                   <property name="'CustomHeader'" value="application/json" /> 
                  </log> 
                  <sequence key="sequence1" />
              </case>
              <case regex="text/xml">
                  <log level="custom"> 
                    <property name="'CustomHeader'" value="text/xml" /> 
                  </log> 
                  <sequence key="sequence2" />
              </case>
              <default>
              <log level="custom"> 
                  <property name="AcceptHeader" value="other" /> 
              </log> 
              <sequence key="sequence3" />
              </default>
      </switch>      
      </inSequence>
  </target>
</proxy>
```

```xml tab="Sequence 1"
<?xml version="1.0" encoding="UTF-8"?>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="sequence1"> 
        <sequence key="send_seq"/> 
        <property name="messageType" value="application/json" scope="axis2"/>
        <respond/>
</sequence>
```

```xml tab="Sequence 2"
<?xml version="1.0" encoding="UTF-8"?>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="sequence2"> 
        <sequence key="send_seq"/> 
        <property name="messageType" value="text/xml" scope="axis2"/>
        <respond/>
</sequence>
```

```xml tab="Sequence 3"
<?xml version="1.0" encoding="UTF-8"?>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="sequence3"> 
        <sequence key="send_seq"/> 
        <respond/>
</sequence>
```    

```xml tab="Send Seq"
<?xml version="1.0" encoding="UTF-8"?>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="send_seq"> 
    <header name="Action" scope="default" value="urn:getQuote"/>
    <call> 
      <endpoint name="simple">
       <address uri="http://localhost:9000/services/SimpleStockQuoteService"/> 
      </endpoint> 
    </call> 
</sequence>
```   

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) and [mediation sequences]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) with the configurations given above.
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

Invoke the proxy service:

- Send a request with the 'application/json' header and see that a JSON response is received.

    ```xml tab='Request (application/json)'
    HTTP method: POST 
    Request URL: http://localhost:8290/services/HeaderBasedRoutingProxy
    Content-Type: text/xml;charset=UTF-8
    CustomHeader: application/json
    Message Body:
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
       <soapenv:Header/>
       <soapenv:Body>
       <ser:getQuote xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
            <ser:request>
                <xsd:symbol>IBM</xsd:symbol>
            </ser:request>
        </ser:getQuote>
       </soapenv:Body>
    </soapenv:Envelope>
    ```

    ```json tab='Response'
    {"Envelope":
      {"Body":
        {"getQuoteResponse":
          {"change":-2.86843917118114,
           "earnings":-8.540305401672558,
           "high":-176.67958828498735,
           "last":177.66987465262923,
           "low":-176.30898912339075,
           "marketCap":56495579.98178506,
           "name":"IBM Company",
           "open":185.62740369461244,
           "peRatio":24.341353665128693,
           "percentageChange":-1.4930577008849097,
           "prevClose":192.11844053187397,
           "symbol":"IBM","volume":7791}
        }
      }
    }
    ```

- Send a request with the 'text/xml' header and see that an XML response is received.

    ```xml tab='Request (text/xml)'
    HTTP method: POST 
    Request URL: http://localhost:8290/services/HeaderBasedRoutingProxy
    Content-Type: text/xml;charset=UTF-8
    CustomHeader: text/xml
    Message Body:
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
       <soapenv:Header/>
       <soapenv:Body>
       <ser:getQuote xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
            <ser:request>
                <xsd:symbol>IBM</xsd:symbol>
            </ser:request>
        </ser:getQuote>
       </soapenv:Body>
    </soapenv:Envelope>
    ```

    ```xml tab='Response'
    <?xml version='1.0' encoding='UTF-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
        <soapenv:Body>
            <soapenv:Envelope xmlns:ax21="http://services.samples/xsd" xmlns:ns="http://services.samples">
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
        </soapenv:Body>
    </soapenv:Envelope>
    ```
