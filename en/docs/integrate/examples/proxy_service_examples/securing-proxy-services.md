# Securing a Proxy Service
This sample demonstrates how you can use WS-Security signing and encryption with proxy services through a WS policy.

In this example, the proxy service expects to receive a signed and encrypted message as specified by the security policy. To understand the format of the policy file, have a look at the Apache Rampart and Axis2 documentation. The `engageSec` element specifies that Apache Rampart should be engaged on this proxy service. Hence, if Rampart rejects any request message that does not conform to the specified policy, that message will never reach the `inSequence` for processing. Since the proxy service is forwarding the received request to the simple stock quote service that does not use WS-Security, you are instructing the Micro Integrator to remove the `wsse:Security` header from the outgoing message.

## Synapse configuration
Following is a sample proxy service configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

```xml tab='Proxy Service'
<proxy name="StockQuoteProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
    <target>
        <inSequence>
            <header name="wsse:Security" action="remove"
                    xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"/>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
    </target>
    <publishWSDL uri="file:/path/to/sample_proxy_1.wsdl"/>
    <policy key="sec_policy"/>
    <enableSec/>
</proxy>
```

```xml tab='Local Entry'
<localEntry xmlns="http://ws.apache.org/ns/synapse" key="sec_policy" src="file:/path/to/policy1.xml"/>
```

## Build and run

The wsdl file `sample_proxy_1.wsdl` can be downloaded from  [sample_proxy_1.wsdl](https://github.com/wso2-docs/WSO2_EI/blob/master/samples-protocol-switching/sample_proxy_1.wsdl). 
The wsdl uri needs to be updated with the path to the `sample_proxy_1.wsdl` file.

The security policy file `policy1.xml` can be downloaded from  [policy1.xml](https://github.com/wso2-docs/WSO2_EI/blob/master/sec-policies/policy1.xml). 
The security policy file uri needs to be updated with the path to the policy1.xml file.
This sample security policy file validates username token and admin role is allowed to invoke the service. 

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

Be sure to [configure a user store](../../../../setup/user_stores/setting_up_a_userstore) for the Micro Integrator and add the required users and roles.

Set up the SOAP client:

1. Download and install [SoapUI](https://www.soapui.org/downloads/soapui.html) to run this SOAP service.
2. Create a new SOAP project in the SoapUI using following wsdl file:

   ```bash
   https://localhost:8253/services/StockQuoteProxy?wsdl
   ```
3.  Use the `getQuote` operation. 
4.  Set [Authorization](https://www.soapui.org/soap-and-wsdl/authenticating-soap-requests.html) in the SoapUI request. You will need this to call a secure service.

Send a simple request to invoke the service:

```xml
POST https://localhost:8253/services/StockQuoteProxy.StockQuoteProxyHttpSoap11Endpoint HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: text/xml;charset=UTF-8
SOAPAction: "urn:getQuote"
Content-Length: 492
Host: localhost:8253
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
Authorization: Basic YWRtaW46YWRtaW4=

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

You will receive the following response:

```xml
HTTP/1.1 200 OK
server: ballerina
content-encoding: gzip
content-type: application/xml
Content-Type: application/xml; charset=UTF-8
Date: Thu, 31 Oct 2019 04:44:45 GMT
Transfer-Encoding: chunked
Connection: Keep-Alive

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ax21="http://services.samples/xsd" xmlns:ns="http://services.samples">
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

By analyzing the debug log output or the TCPMon output, you will see that the request received by the proxy service is signed and encrypted.

You can look up the WSDL of the proxy service by requesting the `http://localhost:8290/services/StockQuoteProxy?wsdl` URL. This confirms the security policy attachment to the supplied base WSDL.

When sending the message to the backend service, you can verify that the security headers were removed, the response received does not use WS-Security, and that the response being forwarded back to the client is signed and encrypted as expected by the client.
