# Filter Mediator

The **Filter Mediator** can be used for filtering messages based on an
XPath, JSONPath or a regular expression. If the test succeeds, the
Filter mediator executes the other mediators enclosed in the sequence.

The Filter Mediator closely resembles the "If-else" control structure.

!!! Info
    The Filter mediator is a [conditionally]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) [content aware]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) mediator.

## Syntax

``` java
<filter (source="[XPath|json-eval(JSONPath)]" regex="string") | xpath="[XPath|json-eval(JSONPath)]">
   mediator+
</filter>
```

This mediator could also be used to handle a scenario where two
different sequences are applied to messages that meet the filter
criteria and messages that do not meet the filter criteria.

``` java
<filter (source="[XPath|json-eval(JSONPath)]" regex="string") | xpath="[XPath|json-eval(JSONPath)]">
   <then [sequence="string"]>
     mediator+
   </then>
   <else [sequence="string"]>
     mediator+
   </else>
</filter>
```

In this case, the Filter condition remains the same. The messages that
match the filter criteria will be mediated using the set of mediators
enclosed in the `         then        ` element. The messages that do
not match the filter criteria will be mediated using the set of
mediators enclosed in the `         else        ` element.

## Configuration

The parameters available for configuring the Filter mediator are as
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
<td><strong>Specify As</strong></td>
<td><p>This is used to specify whether you want to specify the filter criteria via an XPath expression or a regular expression.</p>
<ul>
<li><strong>XPath</strong> : If this option is selected, the Filter mediator tests the given XPath/JSONPath expression as a Boolean expression. When specifying a JSONPath, use the format <code>               json-eval(&lt;JSON_PATH&gt;)              </code> , such as <code>               json-eval(getQuote.request.symbol)              </code>.</li>
<li><strong>Source and Regular Expression</strong> : If this option is selected, the Filter mediator matches the evaluation result of a source XPath/JSONPath expression as a string against the given regular expression.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Source</strong></td>
<td><div class="content-wrapper">
<p>The expression to locate the value that matches the regular expression that you can define in the <strong>Regex</strong> parameter.</p>
<p>Tip</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>

</div></td>
</tr>
<tr class="odd">
<td><strong>Regex</strong></td>
<td>The regular expression to match the source value.</td>
</tr>
</tbody>
</table>

##  Examples

### Sending only messages matching the filter criteria

In this example, the Filter will get the `         To        ` header
value and match it against the given regular expression. If this
evaluation returns `         true        ` , it will send the message.
If the evaluation returns `         false        ` , it will drop the
message.

``` java
<filter source="get-property('To')" regex=".*/StockQuote.*">
      <then>
          <send/>
      </then>
      <else>
          <drop/>
      </else>
</filter>
```

### Applying separate sequences

In this example, the [Log mediator]({{base_path}}/reference/mediators/log-mediator) is used to log
information from a service named Bus Services via a property when the
request matches the filter criteria. When the request does not match the
filter criteria, another log mediator configuration is used log
information from a service named Train Service in a similar way.

```
<filter source="get-property('Action')" regex=".*getBusNo"> 
   <then> 
      <log level="custom"> 
         <property name="service" value="Bus Services is called"/> 
      </log> 
   </then> 
   <else> 
      <log level="custom"> 
         <property name="service" value="Train Service is called"/> 
      </log> 
   </else> 
</filter>
```
