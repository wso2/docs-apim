# Using Fault Sequences 
WSO2 Micro Integrator provides fault sequences for dealing with errors. Whenever an error occurs, the mediation engine attempts to provide as much information as possible on the error to the user by initializing the following properties on the erroneous message:

-	ERROR_CODE
-   ERROR_MESSAGE
-   ERROR_DETAIL
-   ERROR_EXCEPTION

## Synapse configuration
Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

-   Proxy service:
    ```xml
    <proxy name="FaultTestProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
        <target faultSequence="fault">
            <inSequence>
                <switch source="//m0:getQuote/m0:request/m0:symbol" xmlns:m0="http://services.samples">
                    <case regex="IBM">
                        <send>
                            <endpoint><address uri="http://localhost:9000/services/SimpleStockQuoteService"/></endpoint>
                        </send>
                    </case>
                    <case regex="MSFT">
                        <send>
                            <endpoint key="bogus"/>
                        </send>
                    </case>
                    <case regex="SUN">
                        <sequence key="sunSequence"/>
                    </case>
                </switch>
                <drop/>
            </inSequence>
            <outSequence>
                <send/>
            </outSequence>
        </target>
    </proxy>
    ```
    
-   Mediation sequences:

    ```xml tab='Fault Sequence'
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="fault">
        <log level="custom">
            <property name="text" value="An unexpected error occured"/>
            <property name="message" expression="get-property('ERROR_MESSAGE')"/>
        </log>
        <drop/>
    </sequence>
    ```

    ```xml tab='Error Handling Sequence with Logs'
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="sunErrorHandler">
        <log level="custom">
            <property name="text" value="An unexpected error occured for stock SUN"/>
            <property name="message" expression="get-property('ERROR_MESSAGE')"/>
        </log>
        <drop/>
    </sequence>
    ```

    ```xml tab='Error Handling Sequence'
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="sunSequence" onError="sunErrorHandler">
        <send>
            <endpoint key="sunPort"/>
        </send>
    </sequence>
    ```

Note how the `ERROR_MESSAGE` property is being used to get the error message text. Within the fault sequence, you can access these property values using
the `get-property` XPath function. The following log mediator logs the actual error message:

```xml
<log level="custom">  
    <property name="text" value="An unexpected error occured"/>
    <property name="message" expression="get-property('ERROR_MESSAGE')"/>
</log>
``` 



The following is a sample of the configurations to use the Fault sequence in an API. Make note of the "faultSequence" attribute in the "resource" element.

```xml
<api context="/testFault" name="FaultTestAPI">
    <resource faultSequence="fault" methods="POST" uri-template="/v1">
        <inSequence>
            <switch source="//m0:getQuote/m0:request/m0:symbol" xmlns:m0="http://services.samples">
                <case regex="IBM">
                    <send>
                        <endpoint><address uri="http://localhost:9000/services/SimpleStockQuoteService"/></endpoint>
                    </send>
                </case>
                <case regex="MSFT">
                    <send>
                        <endpoint key="bogus"/>
                    </send>
                </case>
                <case regex="SUN">
                    <sequence key="sunSequence"/>
                </case>
            </switch>
            <drop/>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
    </resource>
</api>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service), and the [mediation sequences]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) with the configurations given above.
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

Send a request to invoke the proxy service:
```xml
POST http://localhost:8290/services/FaultTestProxy HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: text/xml;charset=UTF-8
SOAPAction: "urn:mediate"
Content-Length: 263
Host: Chanikas-MacBook-Pro.local:8290
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header />
   <soapenv:Body>
      <m0:getQuote xmlns:m0="http://services.samples">
         <m0:request>
            <m0:price>50</m0:price>
            <m0:quantity>10</m0:quantity>
            <m0:symbol>SUN</m0:symbol>
         </m0:request>
      </m0:getQuote>
   </soapenv:Body>
</soapenv:Envelope>
```

The following line is logged:
```bash
INFO {org.apache.synapse.mediators.builtin.LogMediator} - text = An unexpected error occured for stock SUN, message = Couldn't find the endpoint with the key : sunPort
```
