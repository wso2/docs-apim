# Send Mediator

The **Send Mediator** is used to send messages out of Synapse to an endpoint. The Send Mediator also copies any message context properties from the current message context to the reply message received on the execution of the send operation, so that the response could be correlated back to the request. Messages may be correlated by WS-A MessageID, or even simple custom text labels.

!!! Info
    - The Send mediator is a [content-unaware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.
    - A send operation can be blocking or non-blocking depending on the actual transport implementation used. The default NIO-based http/s implementation does not block on a send. Therefore, if a message should be sent and further processed (e.g. transformed) afterwards, it is required to clone the message into two copies and then perform the processing to avoid conflicts.
    - Do not add any mediator configurations after Send mediator in the same sequence, because the Micro Integrator does not process them. Any mediator configuration after the Send mediator should go to the outSequence or receive sequence.

## Syntax

``` java
<send/>
```

If the message is to be sent to one or more endpoints, use the following syntax:

``` java
<send>
   (endpointref | endpoint)+
</send>
```

-   The `          endpointref         ` token refers to the following:
    ``` java
    <endpoint key="name"/>
    ```
-   The `          endpoint         ` token refers to an anonymous endpoint definition.

## Configuration

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Select Endpoint Type</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to specify the endpoint type to which the message should be sent. The available options are as follows.</p>
<ul>
<li><strong>None</strong>: If this is selected for a Send mediator included in the Out sequence, the message is not sent to any endpoint, but it will be sent back to the client. If this option is selected for a Send mediator included in the In sequence, the message will be sent to the URL specified in its <code>                To               </code> header.</li>
<li><strong>Define Inline</strong>: If this is selected, the endpoint to which the message should be sent can be included within the Send mediator configuration. Click <strong>Add</strong> to add the required endpoint.</li>
<li><strong>Pick from Registry</strong>: If this is selected, the message can be sent to a pre-defined endpoint which is currently saved as a resource in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required endpoint from the resource tree.</li>
<li><p><strong>XPath</strong>: If this is selected, the endpoint to which the message should be sent will be derived via an XPath expression. You are required to enter the relevant XPath expression in the text field that appears when this option is selected.</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</p></li>
</ul>
</div></td>
</tr>
<tr class="even">
<td><strong>Receiving Sequence Type</strong></td>
<td><div class="content-wrapper">
<p>The sequence to use for handling the response from the endpoint. Possible options are as follows.</p>
<ul>
<li><strong>Default</strong>: If this is selected, the mediation sequence in the Out sequence will be used.</li>
<li><strong>Static</strong>: If this is selected, the sequence will be static. You can select a pre-defined sequence that is currently saved as a resource in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required sequence from the resource tree.</li>
<li><p><strong>Dynamic</strong>: If this is selected, the sequence will be derived via an XPath expression. The XPath expression should be entered in the <strong>Receiving Sequence</strong> parameter which appears when this option is selected.</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</p></li>
</ul>
</div></td>
</tr>
<tr class="odd">
<td><strong>Build Message Before Sending</strong></td>
<td><p>This parameter is used to specify whether the message should be built before sending or not. The possible values are as follows.</p>
<ul>
<li><strong>Yes</strong>: If this is selected, the full message XML is built in the memory before the message is sent. <strong>Yes</strong> should be selected if your configuration includes a logic that is performed after the Send has initiated.</li>
<li><strong>No</strong>: If this is selected, the full message XML is not built in the memory before the message is sent. This improves performance.</li>
</ul></td>
</tr>
</tbody>
</table>

## Examples

### Send mediator used in the In sequence and Out sequence

In this example, the first send operation is included in the In
mediator. Both the request and response will go through the main
sequence, but only request messages will go through the In mediator.
Similarly, only response messages will go through the Out mediator. The
request will be forwarded to the endpoint with the given address. The
response will go through the second send operation, which in this
example just sends it back to the client because there is no Out
endpoint specified.

``` java
<proxy name="SimpleProxy" transports="http https" startonload="true" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
    <target>
         <inSequence>
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
</proxy>
```

### Specifying a response handling sequence (service chaining) 

```
<send receive="personInfoSeq">
    <endpoint key="PersonInfoEpr"/>
</send>
```

In this example, requests are sent to the
`         PersonInfoEpr        ` endpoint, and responses from the
service at that endpoint are handled by a sequence named personInfoSeq.
This approach is particularly useful for service chaining. For example,
if you want to take the responses from the
`         PersonInfoEpr        ` service and send them to the
`         CreditEpr        ` service for additional processing before
sending the final response back to the client. In this case, you can
configure the `         personInfoSeq        ` sequence to send the
response to the `         CreditEpr        ` service and also specify
another receive sequence named `         creditSeq        ` that sends
the response from the `         CreditEpr        ` service back to the
client. Following is the configuration of these sequences.

```
<sequence name="personInfoSeq">
    <xslt key="xslt">
        <property name="amount" expression="get-property('ORG_AMOUNT')"/>
    </xslt>
    <send receive="creditSeq">
        <endpoint key="CreditEpr"/>
    </send>
</sequence>

<sequence name="creditSeq">
    <log level="full"/>
    <send/>
</sequence>
```

### Configuring a blocking/non-blocking send operation

In this example, the Send mediator in a proxy service using the [VFS
transport]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-vfs-transport) is
transferring a file to a VFS endpoint. VFS is a non-blocking transport
by default, which means a new thread is spawned for each outgoing
message. The [Property mediator](_Property_Mediator_) added before the
Send mediator removes the [ClientAPINonBlocking](_Generic_Properties_)
property from the message to perform the mediation in a single thread.
This is required when the file being transferred is large and you want
to avoid out-of-memory failures.

```
<inSequence>
   <property name="ClientApiNonBlocking"
           value="true"
           scope="axis2"
           action="remove"/>
   <send>
      <endpoint name="FileEpr">
         <address uri="vfs:file:////home/shammi/file-out"/>
      </endpoint>
   </send>
</inSequence>
```
