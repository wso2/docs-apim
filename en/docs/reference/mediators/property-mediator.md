# Property Mediator

The **Property Mediator** has no direct impact on the message, but rather on the message context flowing through Synapse. You can retrieve
the properties set on a message later through the Synapse XPath Variables or the `get-property()` extension function. A property can have a defined scope for which it is valid. If a property has no defined scope, it defaults to the Synapse message context scope. Using the property element with the **action** specified as `remove`, you can remove any existing message context properties.

!!! Info
    The Property mediator is a [conditionally content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

```
<property name="string" [action=set|remove] [type="string"] (value="literal" | expression="xpath") [scope=default|transport|axis2|axis2-client] [pattern="regex" [group="integer"]]>
    <xml-element/>?
</property>
```

## Configuration

The parameters available for configuring the Property mediator are as follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Name</strong></td>
<td><div class="content-wrapper">
<p>A name for the property.</p>
<p>You can provide a static value or a dynamic value for the property name. A dynamic property name can be retrieved
by using an XPath function. You can use any of the <a href="{{base_path}}/reference/mediators/property-reference/accessing-properties-with-xpath">XPath functions</a> that you use for the property <b>value</b> or property <b>expression</b>.</p>
<p>Note that the XPath function should be contained within curly brackets (<code>{}</code>) as well as double quotations (<code>""</code>). See the examples given below.</p>
  <ul>
    <li>
      <code>property name="{get-property('propertyName')}"</code>
    </li>
    <li>
      <code>property name="{$ctx:propertyName}"</code>
    </li>
    <li>
      <code>property name="{json-eval({$ctx:propertyName})}"</code>
    </li>
  </ul>
<p>For names of the generic properties that come by default, see <a href="{{base_path}}/reference/mediators/property-reference/generic-Properties">Generic Properties</a> . You can select them from the drop-down list if you are adding the Property Mediator as shown below.</p>
<p><img src="{{base_path}}/assets/img/integrate/mediators/119131214/119131215.png" title="generic properties list" width="800" alt="generic properties list" /></p>
</div></td>
</tr>
<tr class="even">
<td><strong>Action</strong></td>
<td><p>The action to be performed for the property.</p>
<ul>
<li><strong>Set</strong>: If this is selected, the property will be set in the message context.</li>
<li><strong>Remove</strong>: If this is selected, the property will be removed from the message context.</li>
</ul></td>
</tr>
<tr class="odd">
<td><strong>Set Action As</strong></td>
<td><p>The possible values for this parameter are as follows:</p>
<ul>
<li><strong>Value</strong>: If this is selected, a static value would be considered as the property value and this value should be entered in the <strong>Value</strong> parameter.</li>
<li><p><strong>Expression</strong>: If this is selected, the property value will be determined during mediation by evaluating an expression. This expression should be entered in the <strong>Expression</strong> parameter.</p></li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Type</strong></td>
<td><div class="content-wrapper">
<p>The data type for the property. Property mediator will handle the property as a property of selected type. Available values are as follows:</p>
<ul>
<li><strong>STRING</strong></li>
<li><strong>INTEGER</strong></li>
<li><strong>BOOLEAN</strong></li>
<li><strong>DOUBLE</strong></li>
<li><strong>FLOAT</strong></li>
<li><strong>LONG</strong></li>
<li><strong>SHORT</strong></li>
<li><p><strong>OM</strong></p></li>
<li><p><strong>JSON</strong></p></li>
</ul>
<p><strong>String</strong> is the default type.</p>
<p>The <code>OM</code> type is used to set xml property values on the message context. This is useful when the expression associated with the property mediator evaluates to an XML node during mediation. When the <code>OM</code> type is used, the XML is converted to an AXIOM OMElement before it is assigned to a property.</p>
<p>The <code>JSON</code> type is used to set JSON values on the message context. It is recommended to use the JSON
 data type (rather than the STRING data type) for JSON payloads.
</p>
<p>
  Note that when the JSON is just a string, you need to add quotes around them. This is due to the restrictions in 
  <a href="https://tools.ietf.org/html/rfc7159">RFC</a>.
</p>
<p>
  Example 1: Creating a property with a JSON string by giving the value.</br>
  <code><property name="Greeting" value="&quot;Hello World&quot;" type="JSON"/></code></br></br>
  Example 2 : Creating a property with a JSON object via expression evaluation.</br>
  <code><property name="studentObject" expression="json-eval($.student)" type="JSON"/></code>
</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Value</strong></td>
<td>If the <strong>Value</strong> option is selected for the <strong>Set Action As</strong> <strong></strong> parameter, the property value should be entered as a constant in this parameter.</td>
</tr>
<tr class="even">
<td><strong>Expression</strong></td>
<td><div class="content-wrapper">
If the <strong>Expression</strong> option is selected for the <strong>Set Action As</strong> parameter, the expression which determines the property value should be entered in this parameter. This expression can be an XPath expression or a JSONPath expression.
<p>When specifying a JSONPath, use the format <code>json-eval(&lt;JSON_PATH&gt;)</code> , such as <code>json-eval(getQuote.request.symbol)</code>. In both XPath and JSONPath expressions, you can return the value of another property by calling <code>get-property(property-name)</code>. For example, you might create a property called <code>JSON_PATH</code> of which the value is <code>json-eval(pizza.toppings)</code> , and then you could create another property called <code>SON_PRINT</code> of which the value is <code>get-property('JSON_PATH')</code>, allowing you to use the value of the JSON_PATH property in the JSON_PRINT property.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Pattern</strong></td>
<td>This parameter is used to enter a regular expression that will be evaluated against the value of the property or result of the XPath/JSON Path expression.</td>
</tr>
<tr class="even">
<td><strong>Group</strong></td>
<td>The number (index) of the matching item evaluated using the regular expression entered in the <strong>Pattern</strong> parameter.</td>
</tr>
<tr class="odd">
<td><strong>Scope</strong></td>
<td><p>The scope at which the property will be set or removed from. Possible values are as follows.</p>
<ul>
<li><strong>Synapse</strong>: This is the default scope. The properties set in this scope last as long as the transaction (request-response) exists.</li>
<li><strong>Transport</strong>: The properties set in this scope will be considered transport headers. For example, if it is required to send an HTTP header named 'CustomHeader' with an outgoing request, you can use the property mediator configuration with this scope.</li>
<li><strong>Axis2</strong>: Properties set in this scope have a shorter life span than those set in the <strong>Synapse</strong> scope. They are mainly used for passing parameters to the underlying Axis2 engine</li>
<li><strong>axis2-client</strong>: This is similar to the <strong>Synapse</strong> scope. The difference between the two scopes is that the <strong>axis2-client</strong> scope can be accessed inside the <b>mediate()</b> method of a mediator via a custom mediator created using the <a href="../../mediators/class-Mediator">Class mediator</a>.</li>
<li><strong>Operation</strong>: This scope is used to retrieve a property in the operation context level.</li>
<li><strong>Registry</strong>: This scope is used to retrieve properties within the registry .</li>
<li><strong>System</strong>: This scope is used to retrieve Java system properties.</li>
<li><strong>Environment</strong>: This scope is used to retrieve environment variables ('env').</li>
</ul>
<p>For a detailed explanation of each scope, see <a href="{{base_path}}/reference/mediators/property-reference/accessing-properties-with-xpath">Accessing Properties with XPath</a>.</p></td>
</tr>
</tbody>
</table>

!!! Note
    There are predefined XPath variables (such as `$ctx` ) that you can directly use in the Synapse configuration, instead of using the synapse:get-property() function. These XPath variables get properties of various scopes and have better performance than the `get-property()` function, which can have much lower performance because it does a registry lookup. These XPath variables get properties of various scopes. For more information on these XPath variables, see [Accessing Properties with XPath]({{base_path}}/reference/mediators/property-reference/accessing-properties-with-xpath).

## Examples

### Setting and logging and property

In this example, we are setting the property symbol and later we can log it using the [Log Mediator]({{base_path}}/reference/mediators/log-Mediator).

```xml
<property name="symbol" expression="fn:concat('Normal Stock - ', //m0:getQuote/m0:request/m0:symbol)" xmlns:m0="http://services.samples/xsd"/>

<log level="custom">
    <property name="symbol" expression="$ctx:symbol"/>
</log>
```

### Sending a fault message based on the Accept http header

In this configuration, a response is sent to the client based on the `         Accept        ` header. The [PayloadFactory mediator]({{base_path}}/reference/mediators/payloadfactory-mediator) transforms the message contents. Then a [Property mediator]({{base_path}}/reference/mediators/property-mediator) sets the message type
based on the `Accept` header using the `$ctx:accept` expression. The message is then sent back to the client via the [Respond mediator]({{base_path}}/reference/mediators/respond-mediator).

``` xml
<payloadFactory media-type="xml">
    <format>
        <m:getQuote xmlns:m="http://services.samples">
            <m:request>
                <m:symbol>Error</m:symbol>
            </m:request>
        </m:getQuote>
    </format>
</payloadFactory>
<property name="messageType" expression="$ctx:accept" scope="axis2" />
<respond/>
```

### Reading a property stored in the Registry

You can read a property that is stored in the Registry by using the
`         get-property()        ` method in your Synapse configuration.
For example, the following Synapse configuration retrieves the
`         abc        ` property of the collection
`         gov:/data/xml/collectionx        ` , and stores it in the
`         regProperty        ` property.

``` xml
<property name="regProperty" expression="get-property('registry', 'gov:/data/xml/collectionx@abc')"/>
```

!!! Info
    You can use the following syntaxes to read properties or resources stored in the `         gov        ` or `         conf        ` Registries. When specifying the path to the resource, do not give the absolute path. Instead, use the `         gov        ` or `         conf        ` prefixes.

#### Reading a property stored under a collection

-   `          get-property('registry','gov:<path to resource from governance>@<propertyname>')         `
-   `          get-property('registry','conf:<path to resource from config>@<propertyname>')         `

#### Reading a property stored under a resource

-   `          get-property('registry','gov:<path to resource from governance>/@<propertyname>')         `
-   `          get-property('registry','conf:<path to resource from config>/@<propertyname>')         `

#### Reading an XML resource

-   `          get-property('registry','gov:<path to resource from governance>')         `
-   `          get-property('registry','conf:<path to resource from config>')         `


### Reading a file stored in the Registry

Following is an example, in which you read an XML file that is stored in the registry using XPath, to retrieve a value from it. Assume you have
the following XML file stored in the Registry (i.e., `         gov:/test.xml        ` ).

**test.xml**

```xml
<root>
  <book>A Song of Ice and Fire</book>
  <author>George R. R. Martin</author>
</root>
```

Your Synapse configuration should be as follows. This uses XPath to read XML.

**reg_xpath.xml**

``` xml
<property name="xmlFile" expression="get-property('registry','gov:/test.xml')" scope="default" type="OM"></property>
<log level="custom">
    <property name="Book_Name" expression="$ctx:xmlFile//book"></property>
</log>
```

Your output log will look like this.

``` text
[2015-09-21 16:01:28,750]  INFO - LogMediator Book_Name = A Song of Ice and Fire
```

### Reading SOAP headers

SOAP headers provide information about the message, such as the To and From values. You can use the `         get-property()        ` function of the Property mediator to retrieve these headers. You can also add Custom SOAP Headers using the [PayloadFactory mediator]({{base_path}}/reference/mediators/payloadfactory-mediator) and the [Script Mediator]({{base_path}}/reference/mediators/script-mediator).

#### To

| Property            |             Description       |
|---------------------|-------------------------------|
| **Header Name**     | To                            |
| **Possible Values** | Any URI                       |
| **Description**     | The To header of the message. |
| **Example**         | get-property("To")            |

#### From

| Property            |             Description         |
|---------------------|---------------------------------|
| **Header Name**     | From                            |
| **Possible Values** | Any URI                         |
| **Description**     | The From header of the message. |
| **Example**         | get-property("From")            |

#### Action

| Property            |             Description               |
|---------------------|---------------------------------------|
| **Header Name**     | Action                                |
| **Possible Values** | Any URI                               |
| **Description**     | The SOAPAction header of the message. |
| **Example**         | get-property("Action")                |

#### ReplyTo

| Property            |             Description                    |
|---------------------|--------------------------------------------|
| **Header Name**     | ReplyTo                                    |
| **Possible Values** | Any URI                                    |
| **Description**     | The ReplyTo header of the message.         |
| **Example**         | <header name="ReplyTo" action="remove"/\> |

#### MessageID

| Property            |             Description                                                                                      |
|---------------------|----------------------------------------------------------------------------------------------------------------|
| **Header Name**     | MessageID                                                                                                      |
| **Possible Values** | UUID                                                                                                           |
| **Description**     | The unique message ID of the message. It is not recommended to make alterations to this property of a message. |
| **Example**         | get-property("MessageID")                                                                                      |

#### RelatesTo

| Property            |             Description                                                                                      |
|---------------------|--------------------------------------------------------------------------------------------------------------|
| **Header Name**     | RelatesTo                                                                                                    |
| **Possible Values** | UUID                                                                                                         |
| **Description**     | The unique ID of the request to which the current message is related. It is not recommended to make changes. |
| **Example**         | get-property("RelatesTo")                                                                                    |

#### FaultTo

<table>
<tr>
    <th>Property</th>
    <th>Description</th>
</tr>
<tr class="odd">
<td><p><strong>Header Name</strong></p></td>
<td><p>FaultTo</p></td>
</tr>
<tr class="even">
<td><p><strong>Possible Values</strong></p></td>
<td><p>Any URI</p></td>
</tr>
<tr class="odd">
<td><p><strong>Description</strong></p></td>
<td><p>The FaultTo header of the message.</p></td>
</tr>
<tr class="even">
<td><p><strong>Example</strong></p></td>
<td><div class="content-wrapper">
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;header name=<span class="st">&quot;FaultTo&quot;</span> value=<span class="st">&quot;http://localhost:9000&quot;</span>/&gt;</span></code></pre></div>
</div>
</div>
</div></td>
</tr>
</table>
