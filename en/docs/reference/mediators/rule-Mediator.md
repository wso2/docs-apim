# Rule Mediator

The **Rule Mediator** integrates the WSO2 Rules component to the the Micro Integrator in order to define dynamic integration decisions in terms of
rules.

The Rule mediator uses an XML message as an input and produces a processed XML message after applying a set of rules. The result xml message can be used as the new soap body message. Alternatively, the information in the processed XML message can be used route the message or do any further processing. or the information can be used to route the message. The use the information to route the message or do any other processing.

!!! Info
    The Rule mediator is a [content aware](../../../references/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

```xml
<rule>
    <ruleset>
        <source [ key="xs:string" ]>
            [ in-Lined ]
        </source>
        <creation>
            <property name="xs:string" value="xs:string"/>*
        </creation>
    </ruleset>

    <session type="[stateless|stateful]"/>*

    <facts>
        <fact name="xs:string" type="xs:string" expression="xs:string" value="xs:string"/>+
    </facts>

    <results>
        <result name="xs:string" type="xs:string" expression="xs:string" value="xs:string"/>*
    </results>

    [ <childMediators>
        <mediator/>*
      </childMediators> ]
</rule>
```

## Configuration

The parameters available to configure the Rule mediator are categorised into the following main elements.

### Source

This section is used to enter the source from which the XML input for the mediator should be taken. The parameters available in this section are as follows.

| Parameter Name | Description                                                                                                                                                                                                                                                             |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Value**      | This parameter can be used to enter a static value as the source.                                                                                                                                                                                                       |
| **XPath**      | This parameter enables you to use an XPath expression to obtain the input facts of the message from a SOAP body, a SOAP header or a property. This XPath expression can be used to specify the message path for the relevant fact type even when creating fact objects. |

### Target

This section is used to enter details of the destination to which the result of the mediation should be added. The parameters available in this section are as follows.

| Parameter Name   | Description                                                                                                                                |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| **Value**        | This parameter is used to enter a static value to specify the location go which the resulting message should be added.                     |
| **Result Xpath** | This parameter is used to derive the location to which the resulting message should be added via an Xpath expression.                      |
| **Xpath**        | This parameter is used to enter a Xpath expression to specify a part of the generated result XML to be added to the target.                |
| **Action**       | This parameter is used to specify whether the result XML should replace the target, or whether it should be added as a child or a sibling. |

### Rule Set

The rule set contains the rules that apply to the input and output facts
based on which WSO2 BRS can create the web service WSDL. input facts are
the facts that are sent by the rule service client and the output facts
are the facts which are received by the client.

The parameters available in this section are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Rule Script As</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to specify how you want to enter the rule script. Possible options are as follows.</p>
<ul>
<li><strong>In-Lined</strong>: If this is selected, the rule script can be added within the mediator configuration.</li>
<li><strong>Key</strong>: If this is selected, the rule script can be saved in the Registry and accessed via a key.</li>
<li><strong>URL</strong>: If this is selected, you can refer to a rule script via a URL.</li>
</ul>
<p>If the rule set is non-XML, you may need to wrap it with a CDATA section inside a XML tag as shown in the example below.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;X&gt;&lt;![CDATA[ <span class="kw">native</span> code]]&gt;&lt;/X&gt;</span></code></pre></div>
</div>
</div>
<b>Note</b>: 
<p>The key or inline Rule script must be defined. Otherwise, the Rule Mediator configuration will be invalid.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Rule Type</strong></td>
<td>This parameter is used to specify whether the rule type is <strong>Regular</strong> or <strong>Decision Table</strong> .</td>
</tr>
</tbody>
</table>

### Input Facts

Input facts are facts that are sent by the rule service client. This section contains parameters that can be used to configure the input facts. Values should be defined for the following parameters before you add the individual input facts.

| Parameter Name   | Description                                         |
|------------------|-----------------------------------------------------|
| **Wrapper Name** | The name of the wrapping element for all the facts. |
| **NameSpace**    | The namespace for the wrapping element.             |

The parameters available to configure an input fact are as follows.

| Parameter Name   | Description                                                                                                                                                                            |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Type**         | The fact type. You can select any of the [registered fact types](http://www.1keydata.com/datawarehousing/fact-table-types.html).                                                      |
| **Element Name** | The element name of the fact in the XML configuration.                                                                                                                                 |
| **NameSpace**    | The namespace for the element.                                                                                                                                                         |
| **XPath**        | This parameter can be used to enter an XPath expression to create an input fact using a part of the input XML.                                                                         |
| **NS Editor**    | Click this link to edit the namespaces. Then the **Namespace Editor** panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression. |
| **Action**       | This parameter can be used to delete and existing fact.                                                                                                                                |

### Output Facts

Output facts are the facts received by the rule service client after the rules in the rule set are applied.

| Parameter Name   | Description                                                |
|------------------|------------------------------------------------------------|
| **Wrapper Name** | The name of the wrapping element for all the output facts. |
| **NameSpace**    | The namespace for the wrapping element.                    |

The parameters available to configure an output fact are as follows.

| Parameter Name   | Description                                                                                                                       |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| **Type**         | The fact type. You can select any of the [registered fact types](http://www.1keydata.com/datawarehousing/fact-table-types.html). |
| **Element Name** | The fact type. You can select any of the [registered fact types](http://www.1keydata.com/datawarehousing/fact-table-types.html). |
| **NameSpace**    | The namespace of the element.                                                                                                     |
| **Action**       | This parameter can be used to delete and existing fact.                                                                           |

## Examples

In this example, the rule script is picked from the registry with key `rule/sample.xml`. There is one fact and it is a string variable. Its value is calculated from the current SOAP message using an expression. The Rule engine uses these facts to decide what rules should be applied.

``` java
<rule>
    <ruleset>
    <source key="rule/sample.xml"/>
    </ruleset>
    <facts>
        <fact name="symbol" type="java.lang.String"
              expression="//m0:getQuote/m0:request/m0:symbol/child::text()"
              xmlns:m0="http://services.samples"/>
    </facts>
    <childMediators>
        <send>
            <endpoint>
                <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
            </endpoint>
        </send>
            <drop/>
    </childMediators>
</rule>
```
