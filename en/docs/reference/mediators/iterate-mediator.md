# Iterate Mediator

The **Iterate Mediator** implements the [Splitter enterprise integration
pattern](http://docs.wso2.org/wiki/display/IntegrationPatterns/Splitter)
and splits the message into a number of different messages derived from
the parent message. The Iterate mediator is similar to the [Clone mediator]({{base_path}}/reference/mediators/clone-Mediator). The difference between the two mediators
is, the Iterate mediator splits a message into different parts, whereas the Clone mediator makes multiple identical copies of the message.

!!! Info
    -   The Iterate mediator is a [content aware]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) mediator.
    -   Iterate Mediator is quite similar to the [ForEach mediator]({{base_path}}/reference/mediators/foreach-mediator). You can use complex XPath expressions or JSON expressions to conditionally select elements to iterate over in both mediators. Following are the main difference between ForEach and Iterate mediators:
        -   Use the ForEach mediator only for message transformations. If you
        need to make back-end calls from each iteration, then use the
        iterate mediator.
        -   ForEach supports modifying the original payload. You can use Iterate
        for situations where you send the split messages to a target and
        collect them by an Aggregate in a different flow
        -   You need to always accompany an Iterate with an Aggregate mediator.
        ForEach loops over the sub-messages and merges them back to the same
        parent element of the message.
        -   In Iterate you need to send the split messages to an endpoint to continue the message flow. However, ForEach does not allow using [Call]({{base_path}}/reference/mediators/call-mediator), [Send]({{base_path}}/reference/mediators/send-mediator) and
        [Callout]({{base_path}}/reference/mediators/callout-mediator) mediators in the sequence.
        -   ForEach does not split the message flow, unlike Iterate Mediator. It
        guarantees to execute in the same thread until all iterations are
        complete.

When you use ForEach mediator, you can only loop through segments of the
message and do changes to a particular segment. For example, you can
change the payload using payload factory mediator. But you cannot send
the split message out to a service. Once you exit from the for-each
loop, it automatically aggregates the split segments. This replaces the
for-each function of the complex XSLT mediators using a ForEach mediator
and a Payload Factory mediator. However, to implement the
split-aggregate pattern, you still need to use Iterate mediator.

## Syntax

``` java
<iterate [sequential=(true | false)] [continueParent=(true | false)] [preservePayload=(true | false)] [(attachPath="XPath|json-eval(JSON Path)")? expression="XPath|json-eval(JSON Path)"]>
   <target [to="uri"] [soapAction="qname"] [sequence="sequence_ref"] [endpoint="endpoint_ref"]>
     <sequence>
       (mediator)+
     </sequence>?
     <endpoint>
       endpoint
     </endpoint>?
   </target>+
</iterate>
```

## Configuration

The parameters available to configure the Iterate mediator are as
follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Iterate ID</strong></td>
<td>The iterate ID can be used to identify messages created by the iterate mediator. This is particularly useful when aggregating responses of messages that are created using nested iterate mediators.</td>
</tr>
<tr class="even">
<td><strong>Sequential Mediation</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to specify whether the split messages should be processed sequentially or not. The processing is carried based on the information relating to the sequence and endpoint specified in the <a href="#target-configuration">target configuration</a> . The possible values are as follows.</p>
<ul>
<li><strong>True</strong> : If this is selected, the split messages will be processed sequentially. Note that selecting <strong>True</strong> might cause delays due to high resource consumption.</li>
<li><strong>False</strong> : If this is selected, the split messages will not be processed sequentially. This is the default value and it results in better performance.</li>
</ul>
<p>The responses will not necessarily be aggregated in the same order that the requests were sent, even if the <code>               sequential Mediation              </code> parameter is set to <code>               true              </code> .</p>

</div></td>
</tr>
<tr class="odd">
<td><strong>Continue Parent</strong></td>
<td><p>This parameter is used to specify whether the original message should be preserved or not. Possible values are as follows.</p>
<ul>
<li><strong>True</strong> : If this is selected, the original message will be preserved.</li>
<li><strong>False</strong> : If this is selected, the original message will be discarded. This is the default value.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Preserve Payload</strong></td>
<td><p>This parameter is used to specify whether the original message payload should be used as a template when creating split messages. Possible values are as follows.</p>
<ul>
<li><strong>True</strong> : If this is selected, the original message payload will be used as a template.</li>
<li><strong>False</strong> : If this is selected, the original message payload will not be used as a template. This is the default value.</li>
</ul></td>
</tr>
<tr class="odd">
<td><strong>Iterate Expression</strong></td>
<td><div class="content-wrapper">
<p>The XPath expression used to split the message.. This expression selects the set of XML elements from the request payload that are applied to the mediation defined within the iterate target. E ach iteration of the iterate mediator will get one element from that set. New messages are created for each and every matching element and processed in parallel or in sequence based on the value specified for the <strong>Sequential Mediation</strong> parameter.</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>

</div></td>
</tr>
<tr class="even">
<td><strong>Attach Path</strong></td>
<td><div class="content-wrapper">
<p>To form new messages, you can specify an XPath expression or a JSONPath expression to identify the parent element to which the split elements are attached (as expressed in Iterate expression).</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>

</div></td>
</tr>
</tbody>
</table>

### Target configuration

Each Iterate mediator has its own target by default. It appears in the
mediation tree once you configure the above parameters
and save them.

The parameters available to configure the target configuration are as
follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>SOAP Action</strong></td>
<td>The SOAP action of the message.</td>
</tr>
<tr class="even">
<td><strong>To Address</strong></td>
<td>The target endpoint address.</td>
</tr>
<tr class="odd">
<td><strong>Sequence</strong></td>
<td><p>This parameter is used to specify whether split messages should be mediated via a sequence or not, and to specify the sequence if they are to be further mediated. Possible options are as follows.</p>
<ul>
<li><strong>None</strong> : If this is selected, no further mediation will be performed for the split messages.</li>
<li><strong>Anonymous</strong> : If this is selected, you can define an anonymous sequence for the split messages by adding the required mediators as children to <strong>Target</strong> in the mediator tree.</li>
<li><strong>Pick From Registry</strong> : If this is selected, you can refer to a pre-defined sequence that is currently saved as a resource in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required sequence from the resource tree.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Endpoint</strong></td>
<td><p>The endpoint to which the split messages should be sent. Possible options are as follows.</p>
<ul>
<li><strong>None</strong>: If this is selected, the split messages are not sent to an endpoint.</li>
<li><strong>Anonymous</strong>: If this is selected, you can define an anonymous endpoint within the iterate target configuration to which the split messages should be sent.</li>
<li><strong>Pick from Registry</strong>: If this is selected, you can refer to a pre-defined endpoint that is currently saves as a resource in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required endpoint from the resource tree.</li>
</ul></td>
</tr>
</tbody>
</table>

## Examples

In these examples, the **Iterate** mediator splits the messages into parts and processes them asynchronously. Also see [Splitting Messages into Parts and Processing in Parallel (Iterate/Aggregate)](https://docs.wso2.com/pages/viewpage.action?pageId=119129658).

``` java tab='Using an XPath expression'
    <iterate expression="//m0:getQuote/m0:request" preservePayload="true"
             attachPath="//m0:getQuote"
             xmlns:m0="http://services.samples">
        <target>
            <sequence>
                <send>
                    <endpoint>
                        <address
                            uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                    </endpoint>
                </send>
            </sequence>
        </target>
    </iterate>
```

``` java tab='Using a JSONpath expression'
    <iterate id="jsonIterator" preservePayload="true" 
             attachPath="json-eval($.placeHolder)" 
             expression="json-eval($.students.studentlist)">
       <target>
          <sequence>
             <send>
                 <endpoint>
                       <http method="POST" uri-template="http://localhost:8280/iteratesample/echojson"/>
                 </endpoint>
             </send>
          </sequence>
       </target>
    </iterate>
```

