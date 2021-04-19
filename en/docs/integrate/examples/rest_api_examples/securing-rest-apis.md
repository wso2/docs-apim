# Securing REST APIs
In most of the real-world use cases of REST, when a consumer attempts to access a privileged resource, access will be denied unless the consumer's credentials are provided in an Authorization header. By default, the Micro Integrator validates the credentials of the consumer (that is provided in the Authorization header) against the credentials of users that are registered in the [user store connected to the server]({{base_path}}/install-and-setup/setup/mi-setup/setup/user_stores/setting_up_a_userstore). 

!!! Info
    The Micro Integrator uses a <b>Basic Auth handler</b> for this purpose. If required, you can use a custom basic auth handler or other security implementations. Find out more about [applying security to REST APIs]({{base_path}}/integrate/develop/advanced-development/applying-security-to-an-api).

## Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

!!! Note
    The basic auth handler is engaged in the API as follows:
    ```xml
    <handlers>
        <handler class="org.wso2.micro.integrator.security.handler.RESTBasicAuthHandler"/>
    </handlers>
    ```

See the REST API given below for an example of how the default basic auth handler is used.

```xml
<api xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteAPI" context="/stockquote">
       <resource methods="GET" uri-template="/view/{symbol}">
          <inSequence>
             <payloadFactory media-type="xml">
                <format>
                   <m0:getQuote xmlns:m0="http://services.samples">
                      <m0:request>
                         <m0:symbol>$1</m0:symbol>
                      </m0:request>
                   </m0:getQuote>
                </format>
                <args>
                   <arg evaluator="xml" expression="get-property('uri.var.symbol')"/>
                </args>
             </payloadFactory>
             <header name="Action" scope="default" value="urn:getQuote"/>
             <send>
                <endpoint>
                   <address uri="http://localhost:9000/services/SimpleStockQuoteService" format="soap11"/>
                </endpoint>
             </send>
          </inSequence>
          <outSequence>
             <send/>
          </outSequence>
          <faultSequence/>
       </resource>
       <handlers>
        <handler class="org.wso2.micro.integrator.security.handler.RESTBasicAuthHandler"/>
       </handlers>
</api>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. [Create the rest api]({{base_path}}/integrate/develop/creating-artifacts/creating-an-api) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

[Configure an external user store]({{base_path}}/install-and-setup/setup/mi-setup/setup/user_stores/setting_up_a_userstore).

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

Test the API:

1.  First, invoke the service using the following service URL without providing any user credentials: `http://127.0.0.1:8290/stockquote/view/IBM`

    !!! Info
        You can invoke the service using Postman or Curl.
        
    ```bash
    curl -v http://127.0.0.1:8290/stockquote/view/IBM
    ```
    
    Note that you will receive the following error because the username and password are not passed and the service cannot be authenticated: `401 Unauthorized`

2.  Now, invoke the service again by providing the credentials of a user that is registered in the user store that is hosted.

    ```bash
    curl -v http://127.0.0.1:8290/stockquote/view/IBM -H "Authorization: Basic YWRtaW46YWRtaW4="
    ```
    !!! Info
         Note that the credentials (`YWRtaW46YWRtaW4=`) given in the authorization header (`Authorization: Basic YWRtaW46YWRtaW4=`) are the Base64-encoded username and password in the following format: `username:password`.

    The request is passed to the back-end service and you will receive a response similar to what is shown below:

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
            <soapenv:Body>
                <ns:getQuoteResponse xmlns:ns="http://services.samples">
                    <ns:return xmlns:ax21="http://services.samples/xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ax21:GetQuoteResponse">
                        <ax21:change>-2.6989539095024164</ax21:change>
                        <ax21:earnings>12.851852793420885</ax21:earnings>
                        <ax21:high>-166.81703170012037</ax21:high>
                        <ax21:last>170.03627716039932</ax21:last>
                        <ax21:lastTradeTimestamp>Mon Jul 30 15:10:56 IST 2018</ax21:lastTradeTimestamp>
                        <ax21:low>178.02122263133768</ax21:low>
                        <ax21:marketCap>-7306984.135450081</ax21:marketCap>
                        <ax21:name>IBM Company</ax21:name>
                        <ax21:open>-165.86249647643422</ax21:open>
                        <ax21:peRatio>23.443106773044992</ax21:peRatio>
                        <ax21:percentageChange>1.5959734616866617</ax21:percentageChange>
                        <ax21:prevClose>-169.11019978052138</ax21:prevClose>
                        <ax21:symbol>IBM</ax21:symbol>
                        <ax21:volume>9897</ax21:volume>
                    </ns:return>
                </ns:getQuoteResponse>
            </soapenv:Body>
    </soapenv:Envelope>
    ```
