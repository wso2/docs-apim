# Fault Mediator

The **Fault Mediator** (also called the **Makefault Mediator**) transforms the current message into a fault message. However, this
mediator does not send the converted message. The [Send Mediator]({{base_path}}/reference/mediators/send-mediator) needs to be invoked to send a fault message
created via the Fault mediator. The fault message's `         To        ` header is set to the `         Fault-To        ` of the original message (if such a header exists in the original message). You can create the fault message as a SOAP 1.1, SOAP 1.2, or plain-old XML (POX) fault.

For more information on faults and errors, see [Error Handling]({{base_path}}/reference/error_handling).

## Syntax

``` java
<makefault [version="soap11|soap12|pox"]>
<code (value="literal" | expression="xpath")/>
<reason (value="literal" | expression="xpath")>
<node>?
<role>?
<detail>?
</makefault>
```

## Configuration

The parameters available to configure the Fault mediator to create a SOAP 1.1 fault are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Fault Code</strong></td>
<td><p>This parameter is used to select the fault code for which the fault string should be defined. Possible values are as follows.</p>
<ul>
<li><strong>versionMismatch</strong>: Select this to specify the fault string for a SOAP version mismatch.</li>
<li><strong>mustUnderstand</strong>: Select this to specify the fault string for the <code>                  mustUnderstand                 </code> error in SOAP.</li>
<li><strong>Client</strong>: Select this to specify the fault string for client side errors.</li>
<li><strong>Server</strong>: Select this to specify the fault string for server side errors.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Fault String</strong></td>
<td><div class="content-wrapper">
<p>The detailed fault string of the fault code. The following options are available.</p>
<ul>
<li><strong>value</strong>: If this option is selected, the fault string is specified as a string value.</li>
<li><strong>expression</strong>: If this option is selected, the fault string is specified as an expression.</li>
</ul>
<b>Tip</b>:
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Fault Actor</strong></td>
<td>The element of the SOAP fault message which is used to capture the party which caused the fault.</td>
</tr>
<tr class="even">
<td><strong>Detail</strong></td>
<td>This parameter is used to enter a custom description of the error.</td>
</tr>
</tbody>
</table>

The parameters available to configure the Fault mediator to create a
SOAP 1.2 fault are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Code</strong></td>
<td><p>This parameter is used to select the fault code for which the reason should be defined. Possible values are as follows.</p>
<ul>
<li><strong>versionMismatch</strong>: Select this to specify the reason for a SOAP version mismatch.</li>
<li><strong>mustUnderstand</strong>: Select this to specify the reason for the <code>                  mustUnderstand                 </code> error in SOAP.</li>
<li><strong>dataEncodingUnknown</strong>: Select this to specify the reason for a SOAP encoding error.</li>
<li><strong>Sender</strong>: Select this ti specify the reason for a sender-side error.</li>
<li><strong>Receiver</strong>: Select this to specify the reason for a receiver-side error.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Reason</strong></td>
<td><div class="content-wrapper">
This parameter is used to specify the reason for the error code selected in the <strong>Code</strong> parameter. The following options are available.
<ul>
<li><strong>value</strong>: If this option is selected, the reason is specified as a string value.</li>
<li><strong>expression</strong>: If this option is selected, the reason is specified as an expression.</li>
</ul>
<b>Tip</b>:
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Role</strong></td>
<td>The SOAP 1.1 role name.</td>
</tr>
<tr class="even">
<td><strong>Node</strong></td>
<td>The SOAP 1.2 node name.</td>
</tr>
<tr class="odd">
<td><strong>Detail</strong></td>
<td>This parameter is used to enter a custom description of the error.</td>
</tr>
</tbody>
</table>

The parameters available to configure the Fault mediator to create a plain-old XML (POX) fault are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Reason</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to enter a custom fault message. The following options are available.</p>
<ul>
<li><strong>value</strong>: If this option is selected, the fault message is specified as a string value.</li>
<li><strong>expression</strong>: If this option is selected, the fault message is specified as an expression.</li>
</ul>
<b>Tip</b>:
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Detail</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to enter details for the fault message. The following options are available.</p>
<ul>
<li><strong>value</strong>: If this option is selected, the detail is specified as a string value.</li>
<li><strong>expression</strong>: If this option is selected, the detail is specified as an expression.</li>
</ul>
<b>Tip</b>:
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
</tbody>
</table>

## Examples

Following are examples of different usages of the Fault Mediator.

### Example 1

In the following example, the `         testmessage        `
string value is given as the reason for the SOAP error
`         versionMismatch        ` .

``` java
<makefault xmlns="http://ws.apache.org/ns/synapse" version="soap11">
   <code xmlns:soap11Env="http://schemas.xmlsoap.org/soap/envelope/" value="soap11Env:VersionMismatch" />
   <reason value="test message " />
   <role></role>
</makefault>
```

### Example 2

The following sample proxy validates the content type using the Filter
Mediator based on the `         Content-Type        ` header property.
If the result is true, it sends an exception back to the client using
the Fault Mediator. Else, if the result is false, it continues the flow.

``` xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="CheckContentType" transports="https http" startOnLoad="true" trace="disable">
<description/>
<target>
    <inSequence>
        <log level="custom">
            <property name="_______Content-Type" expression="get-property('transport','Content-Type')"/>
        </log>
        <filter source="get-property('transport','Content-Type')" regex="application/xhtml\+xml">
        <then>
            <log>
                <property name="Content-Type" expression="get-property('transport','Content-Type')"/>
                <property name="Decision" value="Exception, due to unexpected Content-Type."/>
            </log>
            <makefault version="soap11">
                <code xmlns:soap11Env="http://schemas.xmlsoap.org/soap/envelope/" value="soap11Env:Client"/>
                <reason value="Content-Type Error"/>
                <role/>
                <detail>Content-Type: application/xhtml+xml is not a valid content type.</detail>
            </makefault>
            <header name="To" scope="default" action="remove"/>
            <send/>
        </then>
        <else>
            <log>
                <property name="Content-Type" expression="get-property('transport','Content-Type')"/>
                <property name="Decision" value="Continue the mediation flow..."/>
            </log>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </else>
    </filter>
</inSequence>
<outSequence>
    <send/>
</outSequence>
</target>
<publishWSDL uri="http://localhost:9000/services/SimpleStockQuoteService?wsdl"/>
</proxy>
```

<!--
### Samples

[Sample 5: Creating SOAP Fault Messages and Changing the Direction of a
Message](https://docs.wso2.com/display/EI6xx/Sample+5%3A+Creating+SOAP+Fault+Messages+and+Changing+the+Direction+of+a+Message).
-->
