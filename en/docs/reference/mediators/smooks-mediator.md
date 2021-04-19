# Smooks Mediator

The **Smooks Mediator** can be used to apply lightweight transformations on messages in an efficient manner. Smooks is a powerful framework for
processing, manipulating and transforming XML. More information about Smooks can be obtained from the official [Smooks website](http://www.smooks.org/).

## Syntax

``` java
<smooks [config-key="string"]>
   <input [type="|text|xml"]/>
   <output [type="|text|xml|java"] [property="string"] [action="string"]/>
</smooks>
```

## Configuration

The parameters available for configuring the Smooks mediator are as follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Config-Key</strong></td>
<td>The key to access the Smooks configuration. The Smooks configuration should be saved in the Registry as a local entry before it can be used here. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> to select the Smooks configuration from the resource tree.</td>
</tr>
<tr class="even">
<td><strong>Input</strong></td>
<td>You can select either <strong>XML</strong> or <strong>Text</strong> as the input.</td>
</tr>
<tr class="odd">
<td><strong>Expression</strong></td>
<td>This parameter is used to enter an XPath expression to select the exact message block to which the transformation should be applied. If no expression is entered, the transformation would apply to the entire message body by default.</td>
</tr>
<tr class="even">
<td><strong>Output</strong></td>
<td><p>The format of the output. The output type can be XML, Text or Java, and the output can be one of the following.</p>
<ul>
<li><strong>Property</strong>: If this is selected, the output defined as a property will be saved in the message context for future use.</li>
<li><strong>Expression</strong>: If this is selected, the output is defined as an expression and the following additional actions can be performed.
<ul>
<li><ul>
<li><strong>Add</strong>: The selected node will be added as a child to the message.</li>
<li><strong>Replace</strong>: Selected node will be replaced in the message.</li>
<li><strong>Sibling</strong>: Selected node will be added as a sibling.</li>
</ul></li>
</ul></li>
</ul></td>
</tr>
</tbody>
</table>

## Examples

### Performance tuning

Smooks can be used to split a file and send split results to a JMS
endpoint. In this case, having a value other than -1 for
`         jms:highWaterMark        ` in the Smooks configuration file
can result in a low throughput for message publishing, since Smooks will
spend resources on message counting while the messages are being
published. Therefore, it is recommended to use -1 as the
`         highWaterMark        ` value for high throughput values. The
following is a sample Smooks configuration file with this setting. For
more information on creating the Smooks configuration file, see the
documentation in the official [Smooks website](http://www.smooks.org/) .

**Sample Smooks configuration**

```
<?xml version="1.0" encoding="UTF-8"?>
 <smooks-resource-list xmlns="http://www.milyn.org/xsd/smooks-1.1.xsd" xmlns:core="http://www.milyn.org/xsd/smooks/smooks-core-1.3.xsd" xmlns:ftl="http://www.milyn.org/xsd/smooks/freemarker-1.1.xsd" xmlns:jms="http://www.milyn.org/xsd/smooks/jms-routing-1.2.xsd">
   <!--
   Filter the message using the SAX Filter (i.e. not DOM, so no
   intermediate DOM, so we can process huge messages...
   -->
   <core:filterSettings type="SAX" />
   <!-- Capture the message data 2 seperate DOM model, for "order" and "order-item" fragments... -->
   <resource-config selector="order,order-item">
     <resource>org.milyn.delivery.DomModelCreator</resource>
   </resource-config>
   <!-- At each "order-iteam", apply a template to the "order" and "order-item" DOM model... -->
   <ftl:freemarker applyOnElement="order-item">
     <!--
     Note in the template that we need to use the special FreeMarker variable ".vars"
     because of the hyphenated variable names ("order-item"). See http://freemarker.org/docs/ref_specvar.html.
     -->
     <ftl:template>/repository/resources/orderitem-split.ftl.txt</ftl:template>
     <ftl:use>
       <!-- Bind the templating result into the bean context, from where
       it can be accessed by the JMSRouter (configured above). -->
       <ftl:bindTo id="orderItem_xml" />
     </ftl:use>
   </ftl:freemarker>
   <!-- At each "order-item", route the "orderItem_xml" to the ActiveMQ JMS Queue... -->
   <jms:router routeOnElement="order-item" beanId="orderItem_xml" destination="smooks.exampleQueue">
     <jms:message>
       <!-- Need to use special FreeMarker variable ".vars" -->
       <jms:correlationIdPattern>${order.@id}-${.vars["order-item"].@id}</jms:correlationIdPattern>
     </jms:message>
     <jms:jndi properties="/repository/conf/jndi.properties" />
     <jms:highWaterMark mark="-1" />
   </jms:router>
 </smooks-resource-list>
```

### Referring files from the Smooks configuration

The following Smooks configuration refers a bindings file named
`         mapping.xml        ` . This file should be saved in
via the class path. These bindings will be applied during mediation when
the Smooks configuration is included in a Smooks mediator configuration
via the Registry.

``` xml
<smooks-resource-list xmlns="http://www.milyn.org/xsd/smooks-1.0.xsd"> 
    <resource-config selector="org.xml.sax.driver"> 
        <resource>org.milyn.smooks.edi.EDIReader</resource> 
</resource-config> 
</smooks-resource-list>
```
