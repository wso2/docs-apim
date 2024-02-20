# Using the Load Balance Endpoint

**Session Affinity Load Balancing between Three Endpoints**

This sample demonstrates how the Micro Integrator can handle load balancing with
session affinity using simple client sessions. Here the
session type is specified as `         simpleClientSession        ` .
This is a client initiated session, which means that the client
generates the session identifier and sends it with each request. In this
sample session type, the client adds a SOAP header named ClientID
containing the identifier of the client. The MI binds this ID with a
server on the first request and sends all successive requests containing
that ID to the same server.

## Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario.

```xml tab='Proxy Service'
<proxy name="LoadBalanceProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
   <target>
       <inSequence>
            <header name="Action" value="urn:placeOrder"/>
            <call>
                <endpoint>
                    <!-- specify the session as the simple client session provided by Synapse for
                    testing purpose -->
                    <session type="simpleClientSession"/>

                    <loadbalance>
                        <endpoint>
                            <address uri="http://localhost:9001/services/SimpleStockQuoteService">
                                <enableAddressing/>
                            </address>
                        </endpoint>
                        <endpoint>
                            <address uri="http://localhost:9002/services/SimpleStockQuoteService">
                                <enableAddressing/>
                            </address>
                        </endpoint>
                        <endpoint>
                            <address uri="http://localhost:9003/services/SimpleStockQuoteService">
                                <enableAddressing/>
                            </address>
                        </endpoint>
                    </loadbalance>
                </endpoint>
            </call>
            <respond/>
       </inSequence>
       <outSequence>
            <send/>
       </outSequence>
       <faultSequence>
            <sequence key="errorHandler"/>
       </faultSequence>
   </target>
</proxy>
```

```xml tab='Sequence'
<sequence name="errorHandler"> 
    <makefault version="soap11">
        <code value="soap11Env:VersionMismatch" xmlns:soap11Env="http://schemas.xmlsoap.org/soap/envelope/"/>
        <reason value="COULDN'T SEND THE MESSAGE TO THE SERVER."/>
    </makefault>

    <header name="To" action="remove"/>
    <property name="RESPONSE" value="true"/>
    <send/>
</sequence>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the Proxy]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) and the Sequence with the configurations given above.
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
      
3. Open the `tcpmon` application, which is in `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/bin/` (in MacOS) or `MI_TOOLING_HOME/runtime/microesb/bin` (in Windows/Linux) directory.
4. Configure `tcpmon` to listen to ports `9001, 9002, and 9003` and set the target hostname to `localhost` and target port to `9000` in each instance.

Invoking the proxy service:

Send the following request  **3 or more times**. Make sure to include a `simpleClientSession` to the header.

```xml
POST http://localhost:8290/services/LoadBalanceProxy HTTP/1.1
Content-Type: text/xml;charset=UTF-8
simpleClientSession: 123

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header/>
   <soapenv:Body>
   <m0:placeOrder xmlns:m0="http://services.samples">
            <m0:order>
                <m0:price>172.23182849731984</m0:price>
                <m0:quantity>18398</m0:quantity>
                <m0:symbol>IBM</m0:symbol>
            </m0:order>
        </m0:placeOrder>
   </soapenv:Body>
</soapenv:Envelope>
```

Analyzing the output:

When inspecting the `tcpmon`, you will see that each listener 
has received a request (If you have only sent 3 requests, otherwise more than 1). This is because,
when multiple requests are sent with the same session ID, they are distributed across
the three endpoints in a round robin manner. 
