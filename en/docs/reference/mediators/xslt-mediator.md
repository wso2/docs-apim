# XSLT Mediator

The **XSLT Mediator** applies a specified XSLT transformation to a
selected element of the current message payload. In addition, you can:

-   Specify properties already included in the mediation flow to be
    added to the XSLT script as XSLT parameters.
-   Specify features to be enabled/disabled in the XSLT transformation.
-   Import external XSLT scripts to the main XSLT script of the XSLT
    mediator by adding them as resources.

!!! Info
    The XSLT mediator is a [content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` java
    <xslt key="string" [source="xpath"]>
         <property name="string" (value="literal" | expression="xpath")/>*
         <feature name="string" value="true| false" />*
         <resource location="string" key="string"/>*
    </xslt>
```

## Configuration

The parameters available for configuring the XSLT mediator are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Key Type</strong></td>
<td><p>You can select one of the following options.</p>
<ul>
<li><strong>Static Key</strong> : If this is selected, an existing key can be selected from the registry for the <strong>Key</strong> parameter.</li>
<li><strong>Dynamic Key</strong> : If this is selected, the key can be entered dynamically in the <strong>Key</strong> parameter.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Key</strong></td>
<td>This specifies the registry key to refer the XSLT to. This supports static and dynamic keys.</td>
</tr>
<tr class="odd">
<td><strong>Source</strong></td>
<td><div class="content-wrapper">
<p>This determines the element to which the given XSLT transformation should be applied via an XPath expression. If the source element is not specified, the XSLT transformation is applied to the first child of the SOAP body.</p>
<p>Tip</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Properties of the</strong> <strong>XSLT mediator</strong></td>
<td><div class="content-wrapper">
<p>This section is used to inject properties set in the mediation flow to the XSLT script as XSLT parameters. These are referred from the XSLT in transformation using the <code>               get-property(prop-name)              </code> XPath extension function.</p>
<p>Parameters relating to the properties are as follows.</p>
<ul>
<li><strong>Property Name</strong> : The name of the property to be passed into the transformations.</li>
<li><strong>Property Type</strong> : This specifies whether the property is given as a static value or an XPath expression.</li>
<li><strong>Value/Expression</strong> - This defines the static value or the XPath expression.</li>
<li><strong>Action</strong> - This parameter allows the property to be removed from the XSLT script if required.</li>
</ul>
<p>For example, define the <code>               transform.xslt.result.disableBuild              </code> property as shown below, to escape building the message at the XSLT transformation. It avoids replacing encoded values with real characters. E.g., If you do not add this property, " <code>               &amp;#10;              </code> " in your XML content will be replaced by a new line, when the XML content is built at the XSLT mediator.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Features of the XSLT mediator</strong></td>
<td><p>This section is used to specify features to be enabled/disabled in the XSLT transformation. For example, adding the <a href="http://ws.apache.org/ns/synapse/transform/feature/dom">http://ws.apache.org/ns/synapse/transform/feature/dom</a> feature turns on DOM-based transformations instead of serializing elements into byte streams and/or temporary files. This approach can improve performance but might not work for all transformations.</p>
<p>Parameters relating to the features are as follows.</p>
<ul>
<li><strong>Feature Name</strong> : The name of the feature to be enabled/disabled in the XSLT transformation.</li>
<li><strong>Feature Value</strong> : This specified whether the feature is enabled or not. Select <strong>True</strong> to enable the feature or <strong>False</strong> to disable it.<br />
</li>
<li><strong>Action</strong> : This allows you to remove the feature from the XSLT transformation if required.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Resources of the XSLT mediator</strong></td>
<td><p>This section is used to import external XSLT scripts to the main XSLT scripts defined in the XSLT mediator. The XSLT scripts to be imported are first added as resources in the registry.</p>
<p>Parameters relating to the resources are as follows.</p>
<ul>
<li><strong>Location</strong> : The location where the XSLT script to be imported is saved as a resource.</li>
<li><strong>Key</strong> : The registry key to which the XSLT should be referred. Browse for the relevant key in the Configuration registry or the Governance registry.</li>
<li><strong>Action</strong> : This allows you to remove the imported XSLT script added as a resource if required.</li>
</ul></td>
</tr>
</tbody>
</table>


## Example 1 - Applying an XSLT transformation to a element selected based on an XPath expression

In this example, the XSLT can be picked by the key
`         transform/example.xslt        ` and the XSLT would be applied
to a part of the message that is specified as an XPath expression. In
this case, it is applied to `         s11:Body/child        ` the
message.

``` java
    <xslt xmlns="http://ws.apache.org/ns/synapse" key="transform/example.xslt" source="s11:Body/child" />
```

## Example 2 -  Adding properties as XSLT parameters

In this example, a property named `         PARAM_NAME        ` is added
to the XSLT script as an XSLT parameter. A XPath expression is used to
assign this property the value of the `         ORDER_ID        `
property in the default scope.

``` xml
    <xslt key="keyToXSLTFile">
         <property expression="$ctx:ORDER_ID" name="PARAM_NAME">
    </property></xslt>
```

The XSLT script with the `         PARAM_NAME        ` property added
would look as follows.

``` xml
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
          <xsl:param name="PARAM_NAME"></xsl:param>
          <xsl:template match="/">
             <orders xmlns="http://services.samples">
                <xsl:attribute name="id">
                   <xsl:value-of select="$PARAM_NAME">
                </xsl:value-of></xsl:attribute>
             </orders>
          </xsl:template>
    </xsl:stylesheet>
```

## Example 3 - Adding XSLT imports as resources

In this example, two XSLT files saved in the registry under
`         conf:/        ` as resources are imported to the main XSLT
script of the XSLT mediator.

xslt1.xslt

``` java
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
        <xsl:template match="//people/person" name="FILL_PPL"> 
            <client> 
                <firstname> 
                    <xsl:value-of select="firstname"> 
                </xsl:value-of></firstname> 
                <lastname> 
                    <xsl:value-of select="lastname"> 
                </xsl:value-of></lastname> 
                <age> 
                    <xsl:value-of select="age"> 
                </xsl:value-of></age> 
                <country> 
                    <xsl:value-of select="country"> 
                </xsl:value-of></country> 
            </client> 
        </xsl:template> 
    </xsl:stylesheet>
```

xslt2.xslt

``` java
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:import href="xslt1.xslt" />
        <xsl:template match="/">
            <clients>
                <xsl:for-each select="//people/person">
                    <xsl:call-template name="FILL_PPL"></xsl:call-template>
                </xsl:for-each>
            </clients>
        </xsl:template>
    </xsl:stylesheet>
```

\<xsl:include href="xslt1.xslt"\> element indicates that the
`         xslt1.xslt        ` is included in
`         xslt2.xslt        ` .

These two files can be imported to the script of the XSLT mediator as
follows.

``` xml
    <xslt key="conf:/xslt2.xslt"> 
          <resource key="conf:/xslt1.xslt" location="xslt1.xslt"> 
    </resource></xslt>
```

The following SOAP request can be used to test the above configuration
of the XSLT mediator included in a proxy configuration.

``` xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"> 
        <soapenv:Header> 
        <soapenv:Body> 
            <people> 
                <person> 
                    <firstname>Isuru</firstname> 
                    <lastname>Udana</lastname> 
                    <gender>Male</gender> 
                    <age>26</age> 
                    <country>SriLanka</country> 
                </person> 
                <person> 
                    <firstname>Ishan</firstname> 
                    <lastname>Jayawardena</lastname> 
                    <gender>Male</gender> 
                    <age>26</age> 
                    <country>SriLanka</country> 
                </person> 
            </people> 
        </soapenv:Body> 
    </soapenv:Header></soapenv:Envelope>
```

## Example 4 - Adding CDATA to be displayed in the output

Follow the steps below to add CDATA to display them in the output
without processing them via the XSLT transformation.

1.  Create a file named `          XMLInputFactory.properties         `
    inside the `          <EI_HOME>         ` directory, and include the
    following property in it:
    `          javax.xml.stream.isCoalescing=         `
    `          false         `
2.  Add the
    `          <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>         `
    attribute to the XSL stylesheet.
3.  In the XSL stylesheet, wrap the encoded CDATA within the
    `           <xsl:text>          ` elements with the
    `           disable-output-escaping="yes"          ` parameter as
    shown below.

    ``` java
            <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
            <xsl:copy-of select="*"/>
            <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
    ```

The following is an example of a XSL stylesheet, which includes CDATA to
be displayed in the output.

``` xml
    <xsl:stylesheet version="2.0"
                    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
        <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
        <xsl:template match="/">
          <root>
    <xsl:copy>
    <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
    <xsl:copy-of select="*"/>
    <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
    </xsl:copy>
          </root>
    </xsl:template>
    </xsl:stylesheet>
```

You can use the following Synapse configuration to process the above XSL
stylesheet via a XSLT mediator. In the above configuration, the XSL
stylesheet is defined as a local entry named `         XSLTTest        `
, and it is referred in the XSLT mediator configuration via the
`         key        ` attribute within the proxy service named
`         XSLTProxy        ` .

``` xml
    <proxy name="XSLTProxy" startOnLoad="true" transports="http https">
            <description/>
            <target>
                <inSequence>
                    <xslt key="XSLTTest"/>
                    <log level="full"/>
                    <respond/>
                </inSequence>
            </target>
    </proxy>
    <localEntry key="XSLTTest">
            <xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
               <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
               <xsl:template match="/">
               <root>
                  <xsl:copy>
                    <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                    <xsl:copy-of select="*"/>
                    <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                  </xsl:copy>
               </root>
               </xsl:template>
           </xsl:stylesheet>
            <description/>
    </localEntry>
```

For example, pass the following payload to the `         XSLTProxy        ` proxy service of the above configuration.

``` xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
       <soapenv:Header/>
       <soapenv:Body>
          <abc>testabc</abc>
       </soapenv:Body>   
    </soapenv:Envelope>
```

You view the output with the CDATA displayed as follows in the Console
logs of the WSO2 EI server.

``` text
    INFO - LogMediator To: /services/XSLTProxy.XSLTProxyHttpSoap11Endpoint, WSAction: urn:mediate, SOAPAction: urn:mediate, MessageID: urn:uuid:266d380f-800f-479b-bee9-c30897efe562, Direction: request, Envelope: <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <soapenv:Body>
       <root xmlns="http://ws.apache.org/ns/synapse"><![CDATA[<abc xmlns="">testabc</abc>]]></root>
    </soapenv:Body></soapenv:Envelope>
```

<!--
### Samples

[Sample 440: Converting JSON to XML Using
XSLT](https://docs.wso2.com/display/EI6xx/Sample+440%3A+Converting+JSON+to+XML+Using+XSLT)

[Sample 8: Introduction to Static and Dynamic Registry Resources and
Using XSLT
Transformations](https://docs.wso2.com/display/EI6xx/Sample+8%3A+Introduction+to+Static+and+Dynamic+Registry+Resources+and+Using+XSLT+Transformations)
-->
