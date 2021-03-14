# Exposing a Proxy Service via Inbound Endpoint
If a proxy service is to be exposed only via inbound endpoints, the `inbound.only` service parameter has to be set in the proxy configuration.

## Synapse configuration
Following is a sample proxy service configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Proxy Service'
<proxy xmlns="http://ws.apache.org/ns/synapse" name="InboundProxy" transports="https,http" statistics="disable" trace="disable" startOnLoad="true">
        <target>
            <outSequence>
                <send/>
            </outSequence>
            <endpoint>
                <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
            </endpoint>
        </target>
        <parameter name="inbound.only">true</parameter>
</proxy>
```

```xml tab='Inbound Endpoint'
<inboundEndpoint xmlns="http://ws.apache.org/ns/synapse"
                 name="inbound1"
                 sequence="super"
                 onError="fault"
                 protocol="http"
                 suspend="false">
   <parameters>
      <parameter name="dispatch.filter.pattern">.*</parameter>
      <parameter name="inbound.http.port">9090</parameter>
   </parameters>
</inboundEndpoint>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) and [security policy]({{base_path}}/integrate/develop/creating-artifacts/registry/creating-local-registry-entries) with the configurations given above.
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

Send the following request to the Micro Integrator.

```xml
POST http://localhost:9090/services/InboundProxy HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: text/xml;charset=UTF-8
SOAPAction: "urn:getQuote"
Content-Length: 492
Host: localhost:9090
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.samples" xmlns:xsd="http://services.samples/xsd">
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

You will get the following response:

```xml
HTTP/1.1 200 OK
server: ballerina
content-encoding: gzip
content-type: application/xml
Date: Thu, 31 Oct 2019 05:18:32 GMT
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

When the proxy service is directly invoked, you will not get the response payload.