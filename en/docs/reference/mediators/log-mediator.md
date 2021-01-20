# Log Mediator

The **Log mediator** is used to log mediated messages. For more information on logging, see [Monitoring Logs]({{base_path}}/observe/mi-observe/logs/monitoring_logs.md).

!!! Info
	The Log mediator is a [conditionally]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) [content aware]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) mediator.

## Syntax

The log token refers to a `         <log>        ` element, which may be
used to log messages being mediated.

``` java
<log [level="string"] [separator="string"]>
   <property name="string" (value="literal" | expression="[XPath|json-eval(JSON Path)]")/>*
</log>
```

## Configuration

The general parameters available to configure the Log mediator are as
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
<td><strong>Log Category</strong></td>
<td><p>This parameter is used to specify the log category. Possible values are as follows. Following log levels correspond to the ESB profile service level logs.</p>
<ul>
<li><strong>TRACE</strong> - This designates fine-grained informational events than the DEBUG.</li>
<li><strong>DEBUG</strong> - This designates fine-grained informational events that are most useful to debug an application.</li>
<li><strong>INFO</strong> - This designates informational messages that highlight the progress of the application at coarse-grained level.</li>
<li><strong>WARN</strong> - This designates potentially harmful situations.</li>
<li><strong>ERROR</strong> - This designates error events that might still allow the application to continue running.</li>
<li><p><strong>FATAL</strong> - This designate s very severe error events that will presumably lead the application to abort.</p></li>
</ul></td>
</tr>
<tr class="even">
<td><div class="content-wrapper">
<p><strong>Log Level</strong></p>
</div></td>
<td><div class="content-wrapper">
<p>This parameter is used to specify the log level. The possible values are as follows.</p>
<ul>
<li><strong>Full</strong> : If this is selected, all the standard headers logged at the <strong>Simple</strong> level as well as the full payload of the message will be logged. This log level causes the message content to be parsed and hence incurs a performance overhead.</li>
<li><strong>Simple</strong> : If this is selected, the standard headers (i.e. <code>                To               </code> , <code>                From               </code> , <code>                WSAction               </code> , <code>                SOAPAction               </code> , <code>                ReplyTo               </code> , and <code>                MessageID               </code> ) will be logged.</li>
<li><strong>Headers</strong> : If this is selected, all the SOAP header blocks are logged.</li>
<li><strong>Custom</strong> : If this is selected, only the properties added to the Log mediator configuration will be logged.</li>
</ul>
<p>The properties included in the Log mediator configuration will be logged regardless of the log level selected.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Log Separator</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to specify a value to be used in the log to separate attributes. The <code>               ,              </code> comma is default.</p>
<p>Use only the <strong>Source View</strong> to add a tab (i.e., by defining the <code>               separator="&amp;#x9;"              </code> parameter in the syntax) or a new line (i.e., by defining the <code>               separator="&amp;#xA;"              </code> parameter in the syntax ) as the <strong>Log Separator</strong> , since the <strong>Design View</strong> does not support this.</p>
</div></td>
</tr>
</tbody>
</table>

The parameters available to configure a property are as follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Property Name</strong></td>
<td>The name of the property to be logged.</td>
</tr>
<tr class="even">
<td><strong>Property Value</strong></td>
<td><p>The possible values for this parameter are as follows:</p>
<ul>
<li><strong>Value</strong>: If this is selected, a static value would be considered as the property value and this value should be entered in the <strong>Value/Expression</strong> parameter.</li>
<li><p><strong>Expression</strong>: If this is selected, the property value will be determined during mediation by evaluating an expression. This expression should be entered in the <strong>Value/Expression</strong> parameter.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td><strong>Value/Expression</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to enter a status value as the property value, or to enter an expression to evaluate the property value based on the what you entered for the <strong>Property Value</strong> parameter. When specifying a JSONPath, use the format <code>json-eval(&lt;JSON_PATH&gt;)</code> , such as <code>json-eval(getQuote.request.symbol)</code>.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Action</strong></td>
<td>This parameter allows the property to be deleted.</td>
</tr>
</tbody>
</table>

## Examples

### Using Full log

In this example, everything is logged including the complete SOAP
message.

``` java
<log level="full" xmlns="http://ws.apache.org/ns/synapse"/>
```

### Using Custom logs

In this example, the log level is `         custom        ` . A property
with an XPath expression which is used to get a stock price from a
message is included. This results in logging the stock, price which is a
dynamic value.

``` 
<log level="custom" xmlns="http://ws.apache.org/ns/synapse">
    <property name="text"
              expression="fn:concat('Stock price - ',get-property('stock_price'))"/>
</log>
```
