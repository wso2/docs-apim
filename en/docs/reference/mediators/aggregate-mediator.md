# Aggregate Mediator

The **Aggregate mediator** implements the [Aggregator enterprise integration pattern](https://docs.wso2.com/display/EIP/Aggregator). It
combines (aggregates) the **response messages** of messages that were split by the split by the [Clone]({{base_path}}/reference/mediators/clone-mediator) or
[Iterate]({{base_path}}/reference/mediators/iterate-mediator) mediator. Note that the responses are not necessarily aggregated in the same order that the requests were sent,
even if you set the `         sequential        ` attribute to `         true        ` on the Iterate mediator.

!!! Info
    The Aggregate mediator is a [content-aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

```xml
<aggregate>
   <correlateOn expression="xpath | json-eval(JSON-Path)"/>?
   <completeCondition [timeout="time-in-seconds"]>
     <messageCount min="int-min" max="int-max"/>?
   </completeCondition>?
   <onComplete expression="xpath |  json-eval(JSON-Path)" [sequence="sequence-ref"]>
     (mediator +)?
   </onComplete>
</aggregate>
```

## Configuration

The parameters available for configuring the Aggregate mediator are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Aggregate ID</strong></td>
<td>This optional attribute can be used to aggregate only responses for split messages that are created by a specific clone/iterate mediator. Aggregate ID should be the same as the ID of the corresponding clone/iterate mediator that creates split messages. This is particularly useful when aggregating responses for messages that are created using nested clone/iterate mediators.</td>
</tr>
<tr class="even">
<td><strong>Aggregation Expression</strong></td>
<td>An XPath expression specifying which elements should be aggregated. A set of messages that are selected for aggregation is determined by the value specified in the <strong>Correlation Expression</strong> field.</td>
</tr>
<tr class="odd">
<td><strong>Completion Timeout</strong></td>
<td>The number of seconds taken by the Aggregate mediator to wait for messages. When this time duration elapses, the aggregation will be completed. If the number of response messages reaches the number specified in the <strong>Completion Max-messages</strong> field, the aggregation will be completed even if the time duration specified for the <strong>Completion Timeout</strong> field has not elapsed.</td>
</tr>
<tr class="even">
<td><strong>Completion Max-messages</strong></td>
<td>Maximum number of messages that can exist in an aggregation. When the number of response messages received reaches this number, the aggregation will be completed.</td>
</tr>
<tr class="odd">
<td><strong>Completion Min-messages</strong></td>
<td>Minimum number of messages required for the aggregation to complete. When the time duration entered in the <strong>Completion Timeout</strong> field is elapsed, the aggregation will be completed even if the number of minimum response messages specified has not been received. If no value is entered in the <strong>Completion Timeout</strong> field, the aggregation will not be completed until the number of response messages entered in the <strong>Completion Min-messages</strong> field is received.</td>
</tr>
<tr class="even">
<td><strong>Correlation Expression</strong></td>
<td><div class="content-wrapper">
<p>This is an XPath expression which provides the basis on which response messages should be selected for aggregation. This is done by specifying a set of elements for which the messages selected should have matching values. A specific aggregation condition is set via the <strong>Aggregation Expression</strong> field.</p>
    <p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Enclosing Element Property</strong></td>
<td>This parameter is used to accumulate the aggregated messages inside a single property. The name of the relevant property is entered in this field.</td>
</tr>
<tr class="even">
<td><strong>On Complete</strong></td>
<td><p>The sequence to run when the aggregation is complete. You can select one of the following options:</p>
<ul>
<li><strong>Anonymous</strong>: Select this value if you want to specify the sequence to run by adding child mediators to the Aggregate mediator instead of selecting an existing sequence. For example, if you want to send the aggregated message via the <a href="{{base_path}}/reference/mediators/send-mediator">Send mediator</a>, you can add the Send mediator as a child mediator.</li>
<li><strong>Pick from Registry</strong>: Select this option if you want to specify a sequence which is already defined and saved in the registry. You can select the sequence from the Configuration Registry or Governance Registry.</li>
</ul></td>
</tr>
</tbody>
</table>

## Examples

### Example 1 - Sending aggregated messages through the send mediator

``` java
<outSequence>
    <aggregate>
        <onComplete expression="//m0:getQuoteResponse"
                xmlns:m0="http://services.samples">
            <send/>
        </onComplete>
    </aggregate>
</outSequence>
```

In this example, the mediator aggregates the responses coming into the Micro Integrator, and on completion it sends the aggregated message through
the Send mediator.

### Example 2 - Sending aggregated messages with the enclosing element

The following example shows how to configure the Aggregate mediator to
annotate the responses sent from multiple backends before forwarding
them to the client.

``` xml
<outSequence>
   <property name="info" scope="default">
      <ns:Information xmlns:ns="www.asankatechtalks.com" />
   </property>
   <aggregate id="sa">
      <completeCondition />
      <onComplete expression="$body/*[1]" enclosingElementProperty="info">
         <send />
      </onComplete>
   </aggregate>
</outSequence>
```

The above configuration includes the following:
<table>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>&lt;property name=&quot;info&quot; scope=&quot;default&quot;&gt;
      &lt;ns:Information xmlns:ns=&quot;www.asankatechtalks.com&quot; /&gt;
   &lt;/property&gt;</code></pre></td>
<td>This creates the property named <code>             info            </code> of the <code>             OM            </code> type in which all the aggregated responses are accumulated.</td>
</tr>
<tr class="even">
<td><code class="sourceCode xml">             <span class="er">&lt;</span>            </code> <code class="sourceCode xml">             aggregate            </code> <code class="sourceCode xml">             id            </code> <code class="sourceCode xml">             =            </code> <code class="sourceCode xml">             &quot;sa&quot;            </code> <code class="sourceCode xml">             &gt;            </code></td>
<td>The ID of the corresponding Clone mediator that splits the messages to be aggregated by the Aggregate mediator.</td>
</tr>
<tr class="odd">
<td><code class="sourceCode xml">             <span class="er">&lt;</span>            </code> <code class="sourceCode xml">             onComplete            </code> <code class="sourceCode xml">             expression            </code> <code class="sourceCode xml">             =            </code> <code class="sourceCode xml">             &quot;$body/*[1]&quot;            </code> <code class="sourceCode xml">             enclosingElementProperty            </code> <code class="sourceCode xml">             =            </code> <code class="sourceCode xml">             &quot;info&quot;            </code> <code class="sourceCode xml">             &gt;            </code></td>
<td>This expression is used to add the <code>             info            </code> property (created earlier in this configuration) to be added to the payload of the message and for accumulating all the aggregated messages from different endpoints inside the tag created inside this property.</td>
</tr>
<tr class="even">
<td><code class="sourceCode xml">             <span class="er">&lt;</span>            </code> <code class="sourceCode xml">             send            </code> <code class="sourceCode xml">             /&gt;            </code></td>
<td>This is the Send mediator added as a child mediator to the Aggregate mediator in order to send the aggregated and annotated messages back to the client once the aggregation is complete.</td>
</tr>
</tbody>
</table>
