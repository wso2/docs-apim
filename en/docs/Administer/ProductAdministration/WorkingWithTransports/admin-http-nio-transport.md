# admin\_HTTP-NIO Transport

**HTTP-NIO transport** is a module of the Apache Synapse project. Apache Synapse (as well as the WSO2 ESB) ships the HTTP-NIO transport as the default HTTP transport implementation; however, other products can install the feature that has this transport if needed. The two classes that implement the receiver and sender APIs are `         org.apache.synapse.transport.nhttp.HttpCoreNIOListener        ` and `         org.apache.synapse.transport.nhttp.HttpCoreNIOSender        ` respectively. These classes are available in the JAR file named `         synapse-nhttp-transport.jar        ` . This non-blocking transport implementation is one of the secrets behind the superior performance figures of the WSO2 ESB. The transport implementation is based on Apache HTTP Core - NIO and uses a configurable pool of non-blocking worker threads to grab incoming HTTP messages off the wire.

### HTTP relay transport

Message Relay in older versions of Carbon was simply a message builder-formatter pair. You engage it on a per-content basis. Once engaged for a given content type, messages with that content type are streamed through Carbon. It ran on same old NHTTP transport.

The Relay transport in newer versions of Carbon, is an entire HTTP transport implementation based on HTTP Core NIO. This can be used as an alternative to the NHTTP transport. It doesn't really care about the content type and simply streams all received messages through. It's as if the old Message Relay was engaged on all possible content types. The new transport also has a simpler and cleaner model for forwarding messages back and forth.

To enable this, remove the comment of the relevant HTTP transport entries in the `         axis2.xml        ` . Also, comment out the usual settings for NHTTP transport receiver and sender.

### Transport receiver parameters

!!! tip
In transport parameter tables, literals displayed in italic mode under the "Possible Values" column should be considered as fixed literal constant values. Those values can be directly put in transport configurations.


<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>port</p></td>
<td><p>The port on which this transport receiver should listen for incoming messages.</p></td>
<td><p>No</p></td>
<td><p>A positive integer less than 65535</p></td>
<td><p>8280</p></td>
</tr>
<tr class="even">
<td><p>non-blocking</p></td>
<td><p>Setting this parameter to true is vital for reliable messaging and a number of other scenarios to work properly.</p></td>
<td><p>Yes</p></td>
<td><p><em>true</em></p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>bind-address</p></td>
<td><p>The address of the interface to which the transport listener should bind.</p></td>
<td><p>No</p></td>
<td><p>A host name or an IP address</p></td>
<td><p>127.0.0.1</p></td>
</tr>
<tr class="even">
<td><p>hostname</p></td>
<td><p>The host name of the server to be displayed in service EPRs, WSDLs etc. This parameter takes effect only when the WSDLEPRPrefix parameter is not set.</p></td>
<td><p>No</p></td>
<td><p>A host name or an IP address</p></td>
<td><p>localhost</p></td>
</tr>
<tr class="odd">
<td><p>WSDLEPRPrefix</p></td>
<td><p>A URL prefix which will be added to all service EPRs and EPRs in WSDLs etc.</p></td>
<td><p>No</p></td>
<td><p>A URL of the form &lt;protocol&gt;://&lt;hostname&gt;:&lt;port&gt;/</p></td>
<td><p></p></td>
</tr>
</tbody>
</table>

### Transport sender parameters

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Required</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>http.proxyHost</p></td>
<td><p>If the outgoing messages should be sent through an HTTP proxy server, use this parameter to specify the target proxy.</p></td>
<td><p>No</p></td>
<td><p>A host name or an IP address</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>http.proxyPort</p></td>
<td><p>The port through which the target proxy accepts HTTP traffic.</p></td>
<td><p>No</p></td>
<td><p>A positive integer less than 65535</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>http.nonProxyHosts</p></td>
<td><p>The list of hosts to which the HTTP traffic should be sent directly without going through the proxy.</p></td>
<td><p>No</p></td>
<td><p>A list of host names or IP addresses separated by '|'</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>non-blocking</p></td>
<td><p>Setting this parameter to true is vital for reliable messaging and a number of other scenarios to work properly.</p></td>
<td><p>Yes</p></td>
<td><p><em>true</em></p></td>
<td><p></p></td>
</tr>
</tbody>
</table>


