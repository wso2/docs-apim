# Call Mediator

The **Call mediator** is used to send messages out of the Micro Integrator to an **endpoint**. You can invoke services either in blocking or non-blocking manner.

When you invoke a service in non-blocking mode, the underlying worker
thread returns without waiting for the response. In blocking mode, the
underlying worker thread gets blocked and waits for the response after
sending the request to the endpoint. Call mediator in blocking mode is
very much similar to the [Callout mediator]({{base_path}}/reference/mediators/callout-Mediator).

In both blocking and non-blocking modes, Call mediator behaves in a synchronous manner. Hence, mediation pauses after the service invocation, and resumes from the next mediator in the sequence when the response is received. Call mediator allows you to create your configuration independent from the underlying architecture.

Non-blocking mode of the Call mediator leverages the non-blocking transports for better performance. Therefore, it is recommended to use it in non-blocking mode as much as possible. However, there are scenarios where you need to use the blocking mode. For example, when you implement a scenario related to JMS transactions, it is vital to use the underlying threads in blocking mode.

You can obtain the service endpoint for the Call mediator as follows:

-   Pick from message-level information
-   Pick from a pre-defined endpoint

If you do not specify an endpoint, the Call mediator tries to send the
message using the `         WSA:TO        ` address of the message. If
you specify an endpoint, the Call mediator sends the message based on
the specified endpoint.

The endpoint type can be Leaf Endpoint (i.e. Address/WSDL/Default/HTTP)
or Group Endpoint (i.e. Failover/Load balance/Recipient list). Group
Endpoint is only supported in non-blocking mode.

By default, when you use the Call mediator, the current message body in the mediation is sent out 
as the request payload. The response you receive replaces the current message body.

!!! Info
    The Call mediator is a [conditionally content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators).

## Enabling mutual SSL in the blocking mode

When using the Call mediator in **blocking mode** (blocking=true), enable the mediator to handle mutual SSL by adding the following JVM settings to the `MI_HOME/bin/micro-integrator.sh` file:

``` java
-Djavax.net.ssl.keyStore="$CARBON_HOME/repository/resources/security/wso2carbon.jks" \
-Djavax.net.ssl.keyStorePassword="wso2carbon" \
-Djavax.net.ssl.keyPassword="wso2carbon" \
-Drampart.axiom.parser.pool=false \
```

## Syntax

``` java
<call [blocking="true|false"]>
   <source contentType=" " type="custom|inline|property">{xpath|inline|property}</source>?
   <target type=”property”>{property_name}</target>?
   (endpointref | endpoint)
</call>
```

!!! Note
    The call mediator in the **blocking mode** (blocking=true), builds the message from the response payload. If no response message is expected by the client, you can set the OUT_ONLY property before the call mediator to avoid building the response payload.
    ``` xml
    <property name="OUT_ONLY" value="true"/>
    ```

If the message is to be sent to one or more endpoints, use the following syntax:

``` java
<call [blocking="true"]>
   (endpointref | endpoint)+
</call>
```

-   The `          endpointref         ` token refers to the following:
    ``` java
    <endpoint key="name"/>
    ```

-   The `          endpoint         ` token refers to an anonymous
    endpoint definition.

## Configuration

### Endpoint configuration

Select one of the following options to define the endpoint to which the message should be delivered.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>None</strong></td>
<td>Select this option if you do not want to provide an endpoint. The Call mediator will send the message using its <code>             wsa:to            </code> address.</td>
</tr>
<tr class="even">
<td><strong>Define Inline</strong></td>
<td>If this is selected, the endpoint to which the message should be sent can be included within the Call mediator configuration. Click <strong>Add</strong> to add the required endpoint. For more information on Adding an endpoint, see <a href="{{base_path}}/integrate/develop/creating-artifacts/creating-endpoints">Adding an Endpoint</a> .</td>
</tr>
<tr class="odd">
<td><strong>Pick From Registry</strong></td>
<td>If this is selected, the message can be sent to a pre-defined endpoint, which is currently saved as a resource in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required endpoint from the resource tree.</td>
</tr>
<tr class="even">
<td><strong>XPath</strong></td>
<td><div class="content-wrapper">
<p>If this is selected, the endpoint to which the message should be sent will be derived via an XPath expression. You are required to enter the relevant XPath expression in the text field that appears when this option is selected.</p>
<b>Note</b>:<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Blocking</strong></td>
<td>If set to <code>true</code>, you can use the call mediator in blocking mode.</td>
</tr>
</tbody>
</table>

### Source configuration

The following properties are available when you want to configure the source of the request payload.

<table>
  <tr>
    <th>Parameter Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>
      Type
    </td>
    <td>
      You can use one of the following source types:
      <ul>
        <li>
          <b>Custom</b>: Provide a valid XPATH/json-eval expression as the source element. The result that is derived from this expression will be the payload.
        </li>
        <li>
          <b>Inline</b>: Provide a static payload inline as the payload source. Be sure to use proper encording and escaping.
        </li>
        <li>
          <b>Property</b>: Provide a property as the payload source. You can only refer properties with the <code>synpase</code> scope. For other properties, use an XPath with the <b>Custom</b> source type.
        </li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      contentType
    </td>
    <td>
      Use this paramter to define the content type that is used when sending the message to the endpoint specified in the Call mediator. When the response from the endpoint is received, the original content type is restored.
    </td>
  </tr>
</table>

### Target configuration

The following properties are available when you want to configure a target property to store the response (received from the endpoint).

<table>
  <tr>
    <th>Paramete Name</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>
      Type
    </td>
    <td>
      Use <b>property</b> as the target type to store the response (received from the endpoint) to a property. The property name has to be provided as the value of this element. When you use this target type, a new property is generated for the mediation sequence with the correct data type. 
    </td>
  </tr>
</table>

## Examples - Using Endpoint configurations

### Example 1 - Service orchestration

In this example, the Call mediator invokes a backend service. An [Enrich mediator]({{base_path}}/reference/mediators/enrich-Mediator) stores the response received for
that service invocation.

The [Filter Mediator]({{base_path}}/reference/mediators/filter-Mediator) added after the Call mediator
carries out a filter to determine whether the first call has been
successful. If it is successful, second backend service is invoked. The
payload of the request to the second backend is the response of the
first service invocation .

After a successful second backend service invocation, response of the
first service is retrieved by the [Enrich mediator]({{base_path}}/reference/mediators/enrich-Mediator)
from the property where it was formerly stored. This response is sent to
the client by the [Respond mediator]({{base_path}}/reference/mediators/respond-Mediator).

If it is not successful, a custom JSON error message is sent with HTTP
500. If the first call itself is not successful, the output is just sent
back with the relevant error code.

``` xml
<target>
      <inSequence>
         <log/>
         <call>
            <endpoint>
               <http method="get" uri-template="http://192.168.1.10:8088/mockaxis2service"/>
            </endpoint>
         </call>
         <enrich>
            <source type="body" clone="true"/>
            <target type="property" action="child" property="body_of_first_call"/>
         </enrich>
         <filter source="get-property('axis2', 'HTTP_SC')" regex="200">
            <then>
               <log level="custom">
                  <property name="switchlog" value="Case: first call successful"/>
               </log>
               <call>
                  <endpoint>
                     <http method="get" uri-template="http://localhost:8080/MockService1"/>
                  </endpoint>
               </call>
               <filter source="get-property('axis2', 'HTTP_SC')" regex="200">
                  <then>
                     <log level="custom">
                        <property name="switchlog" value="Case: second call successful"/>
                     </log>
                     <enrich>
                        <source type="property" clone="true" property="body_of_first_call"/>
                        <target type="body"/>
                     </enrich>
                     <respond/>
                  </then>
                  <else>
                     <log level="custom">
                        <property name="switchlog" value="Case: second call unsuccessful"/>
                     </log>
                     <property name="HTTP_SC" value="500" scope="axis2"/>
                     <payloadFactory media-type="json">
                        <format>{ "status": "ERROR!"}</format>
                        <args/>
                     </payloadFactory>
                     <respond/>
                  </else>
               </filter>
            </then>
            <else>
               <log level="custom">
                  <property name="switchlog" value="Case: first call unsuccessful"/>
               </log>
               <respond/>
            </else>
         </filter>
      </inSequence>
   </target>
```

### Example 2 - Continuing mediation without waiting for responses

In this example, the message will be cloned by the [Clone Mediator]({{base_path}}/reference/mediators/clone-Mediator) and sent via the Call mediator. The Drop mediator drops the response so that no further mediation is carried out for the cloned message. However, since the `         continueParent        ` attribute of the [Clone mediator]({{base_path}}/reference/mediators/clone-Mediator) is set to `         true        ` , the original message is mediated in parallel. Therefore, the [Log Mediator]({{base_path}}/reference/mediators/log-Mediator) at the end of the configuration will log the `         After call mediator        ` log message without waiting for
the Call mediator response.

``` xml
...
<log level="full"/>
<clone continueParent="true">
<target>
<sequence>
<call>
<endpoint>
<address uri="http://localhost:8080/echoString"/>
</endpoint>
</call>
<drop/>
</sequence>
</target>
</clone>
<log level="custom">
<property name="MESSAGE" value="After call mediator"/>
</log>
...
```

### Example 3 - Call mediator in blocking mode

In the following sample configuration, the [Header Mediator]({{base_path}}/reference/mediators/header-Mediator) is used to add the action, the [PayloadFactory Mediator]({{base_path}}/reference/mediators/payloadFactory-Mediator) is used to store the the request message and the Call mediator is used to invoke a backend service. You will see that the payload of the request and header action are sent to the backend. After successful backend service invocation, you will see that the response of the service is retrieved by the Micro Integrator and sent to the client as the response using the [Respond Mediator]({{base_path}}/reference/mediators/respond-Mediator).

```
<target>
   <inSequence>
      <header name="Action" value="urn:getQuote" />
      <payloadFactory media-type="xml">
         <format>
            <m0:getQuote xmlns:m0="http://services.samples">
               <m0:request>
                  <m0:symbol>WSO2</m0:symbol>
               </m0:request>
            </m0:getQuote>
         </format>
         <args />
      </payloadFactory>
      <call blocking="true">
         <endpoint>
            <address uri="http://localhost:9000/services/SimpleStockQuoteService" />
         </endpoint>
      </call>
      <respond />
   </inSequence>
</target>
```

### Example 4 - Receiving response headers in blocking mode

If you want to receive the response message headers, when you use the Call mediator in blocking mode, add the `BLOCKING_SENDER_PRESERVE_REQ_HEADERS` property within the proxy service, or in a sequence as shown in the sample proxy configuration below.

!!! Info
    Set the value of the `BLOCKING_SENDER_PRESERVE_REQ_HEADERS` property to `false` to receive the response message headers. If you set it to `true`, you cannot get the response headers, but the request headers will be preserved.

```
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="sample"
       transports="https"
       statistics="enable"
       trace="enable"
       startOnLoad="true">
   <target>
      <inSequence>
         <property name="FORCE_ERROR_ON_SOAP_FAULT"
                   value="true"
                   scope="default"
                   type="STRING"/>
         <property name="HTTP_METHOD" value="POST" scope="axis2" type="STRING"/>
         <property name="messageType" value="text/xml" scope="axis2" type="STRING"/>
         <property name="BLOCKING_SENDER_PRESERVE_REQ_HEADERS" value="false"/>
         <call blocking="true">
            <endpoint>
               <address uri="https://localhost:8243/services/sampleBE"
                        trace="enable"
                        statistics="enable"/>
            </endpoint>
         </call>
         
      </inSequence>
      <outSequence/>
   </target>
   <description/>
</proxy>
```

## Examples - Using Source and Target configurations

Consider the following payload that is sent to the example sequences listed below. 
The content type used for this request is `application/json`.

```json
{"INCOMING" : {"INCOMING2":"INCOMING2"}}
```

In all of the following example sequences, the `contentType` property of the Call mediator's **source configuration** is set to `application/xml`. Therefore, the sequence receives `application/json` as the content type and converts it to `application/xml` before sending the request to the endpoint. The Call mediator's **target configuration** will store the response (received from the endpoint) to a property. Thereafter, the mediation continues with the original payload that was received by the sequence.

### Example 1 - Using a property as the payload source

```xml
<inSequence>
  <property name= "SOURCE" expression="$body//INCOMING" type="OM"/>
  <log level="custom">
     <property name="log" expression="$ctx:SOURCE"/>
  </log>
  <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
  <call>
     <endpoint name="Sample">
        <address uri="BACKEND_URL"></address>
     </endpoint>
     <source contentType="application/xml" type="property">SOURCE</source>
     <target type="property">TARGET</target>
  </call>
  <log level="custom">
     <property name="TARGET PAYLOAD" expression="$ctx:TARGET"/>
  </log>
  <respond/>
</inSequence>
```

### Example 2 - Using an XPath as the payload source

```xml
<inSequence>
  <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
  <call>
     <endpoint name="Sample">
        <address uri="BACKEND_URL"></address>
     </endpoint>
     <source contentType="application/xml" type="custom">$body//INCOMING2</source>
     <target type="property">TARGET</target>
  </call>
  <log level="custom">
     <property name="TARGET PAYLOAD" expression="$ctx:TARGET"/>
  </log>
  <respond/>
</inSequence>
```

### Example 3 - Using an inline payload as the source

```xml
<inSequence>
  <property name="REST_URL_POSTFIX" scope="axis2" action="remove"/>
  <call>
     <endpoint name="Sample">
        <address uri="BACKEND_URL"></address>
     </endpoint>
     <source contentType="application/xml" type="inline"><Intermediate><Intermediate1>Intermediate</Intermediate1></Intermediate></source>
     <target type="property">TARGET</target>
  </call>
  <log level="custom">
     <property name="TARGET PAYLOAD" expression="$ctx:TARGET"/>
  </log>
  <respond/>
</inSequence>
```
