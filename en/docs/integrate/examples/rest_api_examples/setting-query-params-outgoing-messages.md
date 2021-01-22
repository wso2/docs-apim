# Setting Query Parameters on Outgoing Messages

REST clients use query parameters to provide inputs for the relevant operation. These query parameters may be required to carry out the back-end operations either in a REST service or a proxy service.

Shown below is an example request that uses query parameters.

```bash
curl -v -X GET "http://localhost:8290/stockquote/view/IBM?param1=value1&param2=value2"
```

## Synapse configuration

Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

There are two query parameters (customer name and ID) that must be set in the outgoing message from the Micro Integrator. We can configure the API to set those parameters as shown below. The query parameter values can be accessed through the `get-property` function by specifying the parameter number as highlighted in the request (given above).

```xml 
<api xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteAPI" context="/stockquote">
   <resource methods="GET" uri-template="/view/{symbol}">
      <inSequence>
         <payloadFactory media-type="xml">
            <format>
               <m0:getQuote xmlns:m0="http://services.samples">
                  <m0:request>
                     <m0:symbol>$1</m0:symbol>
                     <m0:customerName>$2</m0:customerName>
                     <m0:customerId>$3</m0:customerId>
                  </m0:request>
               </m0:getQuote>
            </format>
            <args>
               <arg evaluator="xml" expression="get-property('uri.var.symbol')"/>
               <arg evaluator="xml" expression="get-property('query.param.param1')"/>
               <arg evaluator="xml" expression="get-property('query.param.param2')"/>
            </args>
         </payloadFactory>
         <property name="SOAPAction" value="urn:getQuote" scope="transport"/>
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
</api>                  
```

## Reading a query or path parameter

You can define a REST API and access the query parameters or path parameters by defining them in expressions. The following is a sample code that shows how the resource is defined.

```xml
<resource methods="GET" uri-template="/{val1}/groups/{val2}/json?q1={v1}&q2={v2}">
```

**Reading a query parameter**

The following sample indicates how the expressions can be defined using `get-property('query.param.xxx')` to read a query parameter.

```xml
<property name="queryParam" expression="get-property('query.param.q1')"></property>
```

Alternately, you can use the following.

```xml
<property name="queryParam" expression="$url:q1"></property>
```

**Readng a path parameter**

The following sample indicates how the expressions can be defined using `get-property('uri.var.yyy')` to read a path parameter.

```xml
<property name="pathParam" expression="get-property('uri.var.val1')"></property>
```

## Build and run

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

Invoke the sample API by executing the following command:

```bash
curl -v -X GET "http://localhost:8290/stockquote/view/IBM?param1=value1&param2=value2"
```

You will receive the following response:

```xml
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
```