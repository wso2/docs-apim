# ForEach Mediator

The ForEach mediator requires an XPath/JSONPath expression and a sequence (inline or referred). It splits the message into a number of different messages
derived from the original message by finding matching elements for the
XPath/JSONPath expression specified. Based on the matching elements, new messages
are created for each iteration and processed sequentially. The
processing is carried out based on a specified sequence. The behaviour
of ForEach mediator is similar to a generic loop. After mediation, the
sub-messages are merged back to their original parent element in the
original message sequentially.

The ForEach mediator creates the following properties during mediation.

| Property                   | Description                                                                                           |
|----------------------------|-------------------------------------------------------------------------------------------------------|
| FOREACH_ORIGINAL_MESSAGE | This contains the original envelop of the messages split by the ForEach mediator.                     |
| FOREACH_COUNTER           | This contains the count of the messages processed. The message count increases during each iteration. |

!!! Note
    [Iterate Mediator]({{base_path}}/reference/mediators/iterate-Mediator) is quite similar to the ForEach
    mediator. You can use complex XPath expressions to conditionally select
    elements to iterate over in both mediators. Following are the main
    difference between ForEach and Iterate mediators:
    
    -   Use the ForEach mediator only for message transformations. If you
        need to make back-end calls from each iteration, then use the
        iterate mediator.
    -   ForEach supports modifying the original payload. You can use Iterate
        for situations where you send the split messages to a target and
        collect them by an Aggregate in a different flow
    -   You need to always accompany an Iterate with an Aggregate mediator.
        ForEach loops over the sub-messages and merges them back to the same
        parent element of the message.
    -   In Iterate you need to send the split messages to an endpoint to
        continue the message flow. However, ForEach does not allow using
        [Call]({{base_path}}/reference/mediators/call-Mediator), [Send]({{base_path}}/reference/mediators/send-Mediator) and
        [Callout]({{base_path}}/reference/mediators/callout-Mediator) mediators in the sequence.
    -   ForEach does not split the message flow, unlike Iterate Mediator. It
        guarantees to execute in the same thread until all iterations are
        complete.

When you use ForEach mediator, you can only loop through segments of the
message and do changes to a particular segment. For example, you can
change the payload using payload factory mediator. But you cannot send
the split message out to a service. Once you exit from the ForEach loop,
it automatically aggregates the split segments. This replaces the
ForEach function of the complex XSLT mediators using a ForEach mediator
and a Payload Factory mediator. However, to implement the
split-aggregate pattern, you still need to use Iterate mediator.

## Syntax

```
<foreach expression="xpath|jsonpath" [sequence="sequence_ref"] [id="foreach_id"] >
    <sequence>
      (mediator)+
    </sequence>?
</foreach>
```

## Configuration

The parameters available to configure the ForEach mediator are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>ForEach ID</strong></td>
<td>If a value is entered for this parameter, it will be used as the prefix for the <code>             FOREACH_ORIGINAL_MESSAGE            </code> and <code>             FOREACH_COUNTER            </code> properties created during mediation. This is an optional parameter. However, it is recommended to define a ForEach ID in nested ForEach scenarios to avoid the properties mentioned from being overwritten.</td>
</tr>
<tr class="even">
<td><strong>Expression</strong></td>
<td><div class="content-wrapper">
<p>The XPath/JSONPath expression with which different messages are derived by splitting the parent message. This expression should have matching elements based on which the splitting is carried out.</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces when you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Sequence</strong></td>
<td><p>The mediation sequence that should be applied to the messages derived from the parent message. ForEach mediator is used only for transformations, thereby, you should not include <a href="{{base_path}}/reference/mediators/call-mediator">Call</a> , <a href="{{base_path}}/reference/mediators/send-mediator">Send</a> and <a href="{{base_path}}/reference/mediators/callout-mediator">Callout</a> mediators, which are used to invoke endpoints, in t his sequence.</p>
<p>You can select one of the following options.</p>
<ul>
<li><strong>Anonymous</strong>: This allows you to define an anonymous sequence to be applied to the split messages by adding the required mediators as children of the ForEach mediator in the mediator tree.</li>
<li><strong>Pick from Registry</strong>: This allows you to pick an existing mediation sequence that is saved in the Registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required mediation sequence from the Resource Tree.</li>
</ul></td>
</tr>
</tbody>
</table>

## Examples

In this configuration, the `         "//m0:getQuote/m0:request"        `
XPath and `         "json-eval($.getQuote.request)"        ` JSONPath expression evaluates the split messages to be derived from the
parent message. Then the split messages pass through a sequence which
includes a [Log mediator]({{base_path}}/reference/mediators/log-Mediator) with the log level set to
`         full        ` .

``` java tab='Using a XPath expression'
<foreach id="foreach_1" expression="//m0:getQuote/m0:request" xmlns:m0="http://services.samples">
        <sequence>
             <log level="full"/>
        </sequence>
</foreach>
```

``` java tab='Using a JSONPath expression'
<foreach id="foreach_1" expression="json-eval($.getQuote.request)">
        <sequence>
             <log level="full"/>
        </sequence>
</foreach>
```

