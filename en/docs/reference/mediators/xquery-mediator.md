# XQuery Mediator

The **XQuery Mediator** performs an XQuery transformation on messages.

!!! Info
    The XQuery mediator is a [content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` java
<xquery key="string" [target="xpath"]>
    <variable name="string" type="string" [key="string"] [expression="xpath"] [value="string"]/>?
</xquery>
```

## Configuration

The parameters available to configure the XQuery mediator are as follows.

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
         <td>
            <p>This parameter specifies whether the key which represents the XQuery transformation should be a static key or a dynamic key.</p>
            <ul>
               <li><strong>Static</strong> : If this is selected, the key would be a static value. This value should be selected from the Registry for the <strong>Key</strong> parameter.</li>
               <li><strong>Dynamic</strong> : If this is selected, the key would be a dynamic value which has to be evaluated via an XPath expression. The relevant XPath expression can be entered in the <strong>Key</strong> parameter.</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td><strong>Key</strong></td>
         <td>
            <div class="content-wrapper">
               <p>The key that represents the XQuery transformation. The value you enter depends on the value you selected for the <strong>Key Type</strong> parameter. If you selected <strong>Static</strong> for the <strong>Key Type</strong> parameter, click <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the key from the resource tree. If you selected <strong>Dynamic</strong> for the <strong>Key Type</strong> parameter, enter the XPatch expression which calculates the dynamic key.</p>
               You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.
               <p><br /></p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td><strong>Target</strong></td>
         <td>
            <div class="content-wrapper">
               <p>This parameter specifies the node of the message to which the XQuery transformation should be applied. The node is evaluated via an XPath expression. If no value is specified for this parameter, the XQuery transformation is applied to the first child of the SOAP body.</p>
               You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.
            </div>
         </td>
      </tr>
      <tr class="even">
         <td><strong>Add Variable</strong></td>
         <td>
            <div class="content-wrapper">
               <p>This link allows you to define one or more variables that could be bound to the dynamic context of the XQuery engine in order to be accessed during the XQuery script invocation.</p>
               <p>Click <strong>Add Variable</strong> to add a variable to the XQuery mediator configuration. The page will expand to display parameters relating to variables. The parameters displayed would differ depending on whether you select <strong>Value</strong> or <strong>Expression</strong> as the variable value type. Click on the relevant tab below to view the relevant UI configuration for variables.</p>
               <div class="localtabs-macro">
                  <div class="aui-tabs horizontal-tabs" data-aui-responsive="true" role="application">
                     <b>Value</b> parameters:
                     <div id="f93bf791e94343a6ba9c94150c7b6080" class="tabs-pane active-pane" name="Value">
                        <div class="table-wrap">
                           <table>
                              <thead>
                                 <tr class="header">
                                    <th>Parameter Name</th>
                                    <th>Description</th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr class="odd">
                                    <td><strong>Variable Type</strong></td>
                                    <td>
                                       The data type of the variable. Supported values are as follows.
                                       <ul>
                                          <li><strong>INT</strong></li>
                                          <li><strong>INTEGER</strong></li>
                                          <li><strong>BOOLEAN</strong></li>
                                          <li><strong>BYTE</strong></li>
                                          <li><strong>DOUBLE</strong></li>
                                          <li><strong>SHORT</strong></li>
                                          <li><strong>LONG</strong></li>
                                          <li><strong>FLOAT</strong></li>
                                          <li><strong>STRING</strong></li>
                                          <li><strong>DOCUMENT</strong></li>
                                          <li><strong>ELEMENT</strong></li>
                                       </ul>
                                    </td>
                                 </tr>
                                 <tr class="even">
                                    <td><strong>Variable Name</strong></td>
                                    <td>The name of the variable. It should correspond to the name of the variable declaration in the XQuery script.</td>
                                 </tr>
                                 <tr class="odd">
                                    <td><strong>Value Type</strong></td>
                                    <td>
                                       <p>This parameter specifies whether the variable value should be a static value or a dynamic value</p>
                                       <ul>
                                          <li><strong>Value</strong> : If this is selected, the variable value is a static value. The static value should be entered in the <strong>Value/Experession</strong> parameter.</li>
                                          <li><strong>Expression</strong> : If this is selected the variable value is a dynamic value. The XPath expression to calculate it should be entered in the <strong>Value/Experession</strong> parameter.</li>
                                       </ul>
                                    </td>
                                 </tr>
                                 <tr class="even">
                                    <td><strong>Value/Expression</strong></td>
                                    <td>This parameter is used to enter the variable value. This can be a static value or an expression based on the value you selected for the <strong>Value Type</strong> parameter.</td>
                                 </tr>
                                 <tr class="odd">
                                    <td><strong>Action</strong></td>
                                    <td>This parameter allows the variable to be deleted.</td>
                                 </tr>
                              </tbody>
                           </table>
                        </div>
                     </div>
                     <b>Expression</b> parameters:
                     <div id="f8e8fb688b254743af3851bec097eb40" class="tabs-pane" name="Expression">
                        <div class="table-wrap">
                           <table>
                              <thead>
                                 <tr class="header">
                                    <th>Parameter Name</th>
                                    <th>Description</th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr class="odd">
                                    <td><strong>Variable Type</strong></td>
                                    <td>
                                       The data type of the variable. This should be a valid type defined by the JSR-000225 (XQJ API). Supported values are as follows.
                                       <ul>
                                          <li><strong>INT</strong></li>
                                          <li><strong>INTEGER</strong></li>
                                          <li><strong>BOOLEAN</strong></li>
                                          <li><strong>BYTE</strong></li>
                                          <li><strong>DOUBLE</strong></li>
                                          <li><strong>SHORT</strong></li>
                                          <li><strong>LONG</strong></li>
                                          <li><strong>FLOAT</strong></li>
                                          <li><strong>STRING</strong></li>
                                          <li><strong>DOCUMENT</strong></li>
                                          <li><strong>DOCUMENT_ELEMENT</strong></li>
                                          <li><strong>ELEMENT</strong></li>
                                       </ul>
                                    </td>
                                 </tr>
                                 <tr class="even">
                                    <td><strong>Variable Name</strong></td>
                                    <td>The name of the variable. It should correspond to the name of the variable declaration in the XQuery script.</td>
                                 </tr>
                                 <tr class="odd">
                                    <td><strong>Value Type</strong></td>
                                    <td>
                                       <p>This parameter specifies whether the variable value should be a static value or a dynamic value</p>
                                       <ul>
                                          <li><strong>Value</strong> : If this is selected, the variable value is a static value. The static value should be entered in the <strong>Value/Experession</strong> parameter.</li>
                                          <li><strong>Expression</strong> : If this is selected the variable value is a dynamic value. The XPath expression to calculate it should be entered in the <strong>Value/Experession</strong> parameter.</li>
                                       </ul>
                                    </td>
                                 </tr>
                                 <tr class="even">
                                    <td><strong>Value/Expression</strong></td>
                                    <td>This parameter is used to enter the variable value. This can be a static value or an expression based on the value you selected for the <strong>Value Type</strong> parameter.</td>
                                 </tr>
                                 <tr class="odd">
                                    <td><strong>Registry Key</strong></td>
                                    <td>The key to acces the variable value if it is saved in the Registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> in the <strong>Registry Browser</strong> parameter as relevant to select the required key from the resource tree.</td>
                                 </tr>
                                 <tr class="even">
                                    <td><strong>Registry Browser</strong></td>
                                    <td>If the variable value is saved in the Registry, click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> in the <strong>Registry Browser</strong> parameter as relevant to select the required key from the resource tree.</td>
                                 </tr>
                                 <tr class="odd">
                                    <td><strong>NS Editor</strong></td>
                                    <td>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</td>
                                 </tr>
                                 <tr class="even">
                                    <td><strong>Action</strong></td>
                                    <td>This parameter allows the variable to be deleted.</td>
                                 </tr>
                              </tbody>
                           </table>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
   </tbody>
</table>
  
## Examples

In this configuration, the XQuery script is saved in the registry, and
it can be accessed via the `         xquery\example.xq        ` key. The
XQuery configuration has one variable named `         payload        `
of which the variable type is `         ELEMENT        ` .  As there is
no expression in the variable definitions, the default value of the
first child of the SOAP Body is used as the value of the variable `payload        ` . Within the XQuery script, you can access
this variable by defining `         declare variable $payload as document-node() external;        `.

``` java
<xquery key="xquery\example.xq">
      <variable name="payload" type="ELEMENT"/>
</xquery>
```

## Variables

The following variable picks an XML resource from the registry using key
`         misc/commission.xml        ` and binds into XQuery Runtime so
that it can be accessed within the XQuery script.

``` java
<variable name="commission" type="ELEMENT" key="misc/commission.xml"></variable>
```
  
The value of the following variable is calculated from the current
message SOAP Payload using an expression. The value type of the variable
is DOUBLE .

``` java
<variable name="price" type="DOUBLE" expression="self::node()//m0:return/m0:last/child::text()" xmlns:m0="http://services.samples/xsd"/>
```
