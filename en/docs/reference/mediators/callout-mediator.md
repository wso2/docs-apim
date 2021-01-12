# Callout Mediator

The **Callout** mediator performs a blocking external service invocation during mediation. As the Callout mediator performs a blocking call, it cannot use the default non-blocking HTTP/S transports based on Java NIO.

!!! Tip
    The [Call mediator]({{base_path}}/reference/mediators/call-Mediator) leverages the non-blocking transports for much greater performance than the Callout mediator. Therefore, you should use the Call mediator in most cases. However, the Callout mediator is recommended in situations where you need to execute the mediation flow in a single thread.

## Enabling mutual SSL

The Callout mediators default https transport sender is `org.apache.axis2.transport.http.CommonsHTTPTransportSender`. Therefore, the Callout mediator does not have access to the required key store to handle mutual SSL. To enable the Callout mediator to handle mutual SSL, the following JVM settings should be added to the `MI_HOME/bin/micro-integrator.sh` file.

```
-Djavax.net.ssl.keyStore="$CARBON_HOME/repository/resources/security/wso2carbon.jks" \
-Djavax.net.ssl.keyStorePassword="wso2carbon" \
-Djavax.net.ssl.keyPassword="wso2carbon" \
```

## Disabling chunking

The Callout mediator is not affected by the [DISABLE_CHUNKING property]({{base_path}}/reference/mediators/property-reference/http-transport-properties). Instead, you can disable chunking for the Callout mediator by setting the following paramters in the `MI_HOME/conf/deployment.toml` file:

```toml
[transport.blocking.http]
sender.transfer_encoding = "chunked"
```

This will disable chunking for all Callout mediators present in the Micro Integrator.

If you want to disable chunking for only a single Callout mediator instance, create a new `axis2.xml` file by copying the `         MI_HOME/conf/axis2/axis2_blocking_client.xml        ` file, set the `         Transfer-Encoding        ` parameter as shown, and then configure that Callout mediator to use this new `         axis2.xml        ` file as described below.

## Syntax

``` java
<callout [serviceURL="string"] [action="string"] [initAxis2ClientOptions="true|false"] [endpointKey="string"]>
      <configuration [axis2xml="string"] [repository="string"]/>?
      <source xpath="expression" | key="string" | type="envelope"/>
      <target xpath="expression" | key="string"/>
      <enableSec policy="string" | outboundPolicy="String" | inboundPolicy="String" />?
</callout>
```

## Configuration

The parameters available for configuring the Callout mediator are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Specify As</strong></td>
<td><div class="content-wrapper">
<p>This parameter determines whether the target external service should be configured by using either a <code>serviceURL</code> attribute or an <code>endpointKey</code> attribute.</p>
<p>Callout mediator does not support endpoint configurations such as <code>               timeout              </code> , <code>               suspendOnFailure              </code>, and <code>               markForSuspension              </code> when the <code>               endpointKey              </code> attribute is used to specify an existing endpoint.</p>
<ul>
<li><strong>URL</strong> : Select <strong>URL</strong> if you want to call the external service by specifying its URL in the Call mediator configuration.</li>
<li><strong>Address Endpoint</strong>: Select <strong>Address Endpoint</strong> if you want to call the external service via an <b>Endpoint</b>, which is already saved in the <b>Registry</b>. This option should be selected if you want to make use of the WSO2 functionality related to endpoints such as format conversions, security etc. Note that only Leaf endpoint types (i.e. <code>                Address               </code>, <code>WSDL</code>, <code>Default</code> and <code>Http</code>) are supported for the Callout mediator.</li>
</ul>
<p>If neither a URL or an address endpoint is specified, the <code>To</code> header on the request is used as the target endpoint.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>URL</strong></td>
<td>If you selected <strong>URL</strong> for the <strong>Specify As</strong> parameter, use this parameter to enter the URL of the external service that you want to call. This URL will be used as the End Point Reference (EPR) of the external service.</td>
</tr>
<tr class="odd">
<td><strong>Address Endpoint</strong></td>
<td>If you selected <strong>Address Endpoint</strong> for the <strong>Specify As</strong> parameter, use this parameter to enter a key to access the endpoint that should be used to call the external service. Click <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required endpoint from the resource tree.</td>
</tr>
<tr class="even">
<td><strong>Action</strong></td>
<td>The SOAP action which should be appended to the service call.</td>
</tr>
<tr class="odd">
<td><strong>Axis2 Repository</strong></td>
<td>The path to Axis2 client repository where the services and modules are located. The purpose of this parameter is to make the Callout mediator initialize with the required client repository.</td>
</tr>
<tr class="even">
<td><strong>Axis2 XML</strong></td>
<td>The path to the location of the axis2.xml configuration file. The purpose of this parameter is to make the Callout mediator initialize with the relevant Axis2 configurations.</td>
</tr>
<tr class="odd">
<td><strong>initAxis2ClientOptions</strong></td>
<td>If this parameter is set to <code>false</code>, the existing Axis2 client options available in the Synapse message context will be reused when the Callout mediator is invoked. This is useful when you want to use NLTM authentication. The default value for this parameter is <code>true</code>.</td>
</tr>
<tr class="even">
<td><strong>Source</strong></td>
<td><div class="content-wrapper">
<p>This parameter defines the payload for the request. It can be defined using one of the following options.</p>
<ul>
<li><p><strong>XPath</strong> - This option allows you to specify an expression that defines the location in the message.</p>
<b>Tip</b>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</p></li>
<li><strong>Property</strong>: This option allows you to specify the payload for a request via a property included in the mediation flow.</li>
<li><strong>Envelope</strong>: This option allows you to select the entire envelope which is available in the message flow as the source.</li>
</ul>
</div></td>
</tr>
<tr class="odd">
<td><strong>Target</strong></td>
<td><div class="content-wrapper">
<p>The node or the property of the request message to which the payload (resulting from the value specified for the <strong>Source</strong> parameter) would be attached. The target can be specified using one of the following options.</p>
<ul>
<li><p><strong>XPath</strong>: This option allows you to specify an expression that defines the location in the message.</p>
<b>Tip</b>:
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</p></li>
<li><strong>Property</strong>: This option allows you to specify a property included in the mediation flow.</li>
</ul>
</div></td>
</tr>
<tr class="even">
<td><strong>WS-Security</strong></td>
<td><div class="content-wrapper">
<p>If you select the check box, WS-Security is enabled for the Callout mediator. This section would expand as shown below when you select this check box.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Specify as Inbound and Outbound Policies</strong></td>
<td><div class="content-wrapper">
<p>If this check box is selected, you can define separate security policies for the inbound and outbound messages (flows). This is done by entering the required policy keys in the <strong>Outbound Policy Key</strong> and <strong>Inbound Policy Key</strong> parameters which are displayed as follows when this check box is selected. You can click <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> to select a security policy saved in the <b>Registry</b> from the resource tree.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Policy Key</strong></td>
<td>If the <strong>Specify as Inbound and Outbound Policies</strong> check box is not selected, this parameter is used to enter a key to access a security policy which will be applied to both inbound and outbound messages. You can click <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> to select a security policy saved in the <b>Registry</b> from the resource tree.</td>
</tr>
</tbody>
</table>

## Examples

Following examples demonstrate the usage of the Callout mediator.

### Example 1 - Performing a direct service invocation

In this example, the Callout Mediator does the direct service invocation to the `StockQuoteService` using the client request, gets the response, and sets the response as the first child of the SOAP message body. You can then use the [Send Mediator]({{base_path}}/reference/mediators/send-Mediator) to send the message back to the client.

``` java
<callout serviceURL="http://localhost:9000/services/SimpleStockQuoteService"
         action="urn:getQuote">
    <source xmlns:s11="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:s12="http://www.w3.org/2003/05/soap-envelope"
            xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
    <target xmlns:s11="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:s12="http://www.w3.org/2003/05/soap-envelope"
            xpath="s11:Body/child::*[fn:position()=1] | s12:Body/child::*[fn:position()=1]"/>
</callout>
```

### Example 2 - Setting an HTTP method when invoking a REST service

The below example uses a C allout mediator to set a HTTP method when invoking a REST service.

!!! Info
    For this, you need to define the following property: `         <property name="HTTP_METHOD" expression="$axis2:HTTP_METHOD" scope="axis2-client"/>        `

``` java
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="CalloutProxy"
       startOnLoad="true"
       statistics="disable"
       trace="disable"
       transports="http,https">
   <target>
      <inSequence>
         <property name="enableREST"
                   scope="axis2-client"
                   type="BOOLEAN"
                   value="true"/>
         <property expression="$axis2:HTTP_METHOD"
                   name="HTTP_METHOD"
                   scope="axis2-client"/>
         <callout initAxis2ClientOptions="false"
                  serviceURL="http://localhost:8280/callout/CalloutRESTApi">
            <source type="envelope"/>
            <target key="response"/>
         </callout>
         <log level="custom">
            <property expression="$ctx:response" name="MESSAGE###########################3"/>
         </log>
         <property expression="$ctx:response" name="res" type="OM"/>
         <property action="remove" name="NO_ENTITY_BODY" scope="axis2"/>
         <property name="RESPONSE" value="true"/>
         <property name="messageType" scope="axis2" value="application/xml"/>
         <header action="remove" name="To"/>
         <payloadFactory media-type="xml">
            <format>
               <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
                  <soapenv:Header/>
                  <soapenv:Body>$1
                  </soapenv:Body>
               </soapenv:Envelope>
            </format>
            <args>
               <arg evaluator="xml" expression="$ctx:res"/>
            </args>
         </payloadFactory>
         <send/>
      </inSequence>
   </target>
   <description/>
</proxy>
```

