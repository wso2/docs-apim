# admin\_TCP Transport

The TCP transport implementation is in the Apache WS-Commons Transports project. The two classes that act as the transport listener and the sender are `         org.apache.axis2.transport.tcp.TCPServer        ` and `         org.apache.axis2.transport.tcp.TCPTransportSender        ` respectively. In order to use the transport `         axis2-transport-tcp.jar        ` should be added to the Carbon classpath.

### Transport receiver parameters

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
<th><p>Requried</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>port</p></td>
<td><p>The port on which the TCP server should listen for incoming messages</p></td>
<td><p>No</p></td>
<td><p>A positive integer less than 65535</p></td>
<td><p>8000</p></td>
</tr>
<tr class="even">
<td><p>hostname</p></td>
<td><p>The host name of the server to be displayed in WSDLs etc</p></td>
<td><p>No</p></td>
<td><p>A valid host name or an IP address</p></td>
<td><p></p></td>
</tr>
</tbody>
</table>

### Transport sender parameters

The TCP transport sender does not accept any configuration parameters as of now.

To enable the TCP transport for samples, simply open the `         repository/conf/axis2.xml        ` file in a text editor and add the following transport receiver configuration and sender configuration. TCP transport module is shipped with WSO2 ESB by default.

``` java
    <transportReceiver name="tcp">
        <parameter name="transport.tcp.port">6060</parameter>
    </transportReceiver>
<transportSender name="tcp"/>
```
If you wish to use the sample Axis2 client to send TCP messages, you have to remove the comment of the TCP transport sender configuration in the `         following file:        `

`         samples/axis2Client/client_repo/conf/axis2.xml        `
