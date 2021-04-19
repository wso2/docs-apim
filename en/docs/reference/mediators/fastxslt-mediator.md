# FastXSLT Mediator

The **FastXSLT Mediator** is similar to the [XSLT mediator]({{base_path}}/reference/mediators/xslt-mediator), but it uses the [Streaming XPath Parser](http://wso2.com/library/articles/2013/01/streaming-xpath-parser-wso2-esb) and applies the XSLT transformation to the message stream instead of to the XML message payload. The result is a faster transformation, but you cannot specify the source, properties, features, or resources as you can with the XSLT mediator. Therefore, the FastXSLT mediator is intended to be used to gain performance in cases where the original message remains unmodified. Any pre-processing performed on the message payload will not be visible to the FastXSLT mediator, because the transformation logic is applied on the original message stream instead of the message payload. In cases where the message payload needs to be pre-processed, use the XSLT mediator instead of the FastXSLT mediator.

!!! Note
    The streaming XPath parser used in the Fast XSLT mediator does not support Xpath functions specified with the prefix " fn: ". Examples are " `         fn:contains        ` ", " `         fn:count        ` ", and " `         fn:concat        ` ".

For example, if you are using the VFS transport to handle files, you might want to read the content of the file as a stream and directly send the content for XSLT transformation. If you need to pre-process the message payload, such as adding or removing properties, use the XSLT mediator instead.

In summary, following are the key differences between the XSLT and FastXSLT mediators:

| XSLT Mediator                                                                                | FastXSLT Mediator                                                                                                                          |
|----------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| Performs XSLT transformations on the message **payload** .                                                                 | Performs XSLT transformations on the message **stream** .                                                                                  |
| The message is built before processing. Therefore, you can pre-process the message payload before the XSLT transformation. | The message is not built before processing. Therefore, any pre-processing on the message will not be reflected in the XSLT transformation. |
| The performance is slower than the FastXSLT mediator.                                                                      | The performance is faster than the XSLT mediator.                                                                                          |

!!! Note
    To enable the FastXSLT mediator, your XSLT script must include the following parameter in the XSL output. 
    `         omit-xml-declaration="yes"        `
    For example:
    ``` xml
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
    ```   
    If you do not include this parameter in your XSLT when using the FastXSLT mediator, you will get the following error.
    ``` java
    ERROR XSLTMediator Error creating XSLT transformer
    ```
    
!!! Info
    The FastXSLT mediator is a [conditionally content-aware]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) mediator.

## Syntax

``` java
<fastXSLT key="string"/>
```

For example, specify the XSLT by the key `         transform/example.xslt        `, which is used to transform the message stream as shown below.

``` java
<fastxslt xmlns="http://ws.apache.org/ns/synapse" key="transform/example.xslt"/>
```

## Configuration

The parameters available to configure the FastXSLT mediator are as follows.

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
<li><strong>Static Key</strong>: If this is selected, an existing key can be selected from the registry for the <strong>Key</strong> parameter.</li>
<li><strong>Dynamic Key</strong>: If this is selected, the key can be entered dynamically in the <strong>Key</strong> parameter.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Key</strong></td>
<td><div class="content-wrapper">
<p>This specifies the registry key to refer the XSLT to. This supports static and dynamic keys.</p>
<p>Tip</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>
</div></td>
</tr>
</tbody>
</table>

## Example

The following example applies a simple XSLT stylesheet to a message payload via the FastXSLT mediator. The FastXSLT mediator reads values
from the current XML payload using XPath and populates them into the
stylesheet to create a new or different payload as the response. The API configuration of this example is as follows:

``` xml
<api xmlns="http://ws.apache.org/ns/synapse" context="/xslt" name="XSLTAPI">
   <resource methods="POST">
      <inSequence>
         <fastXSLT key="conf:myresources/discountPayment.xsl" />
         <log level="full" />
         <respond />
      </inSequence>
      <outSequence />
      <faultSequence />
   </resource>
</api>
```

Follow the steps below to specify the stylesheet as a Registry entry in the above API.

1.  Double click on the API and click the following link in the
    **Properties** tab.  
    ![]({{base_path}}/assets/img/integrate/mediators/fastxslt-props.png)
2.  Click **Create & point to a new resource...** link.  
    ![]({{base_path}}/assets/img/integrate/mediators/new-reg-resource.png)
3.  Enter the following details to create the empty XSL file in which
    you enter the stylesheet, in the Registry.  
    ![]({{base_path}}/assets/img/integrate/mediators/create-xsl.png)
4.  Double-click the stylesheet file in the **Project Explorer**, and add the following stylesheet as the content of the XSL file.

    **discountPayment.xsl**

    ``` xml
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:m0="http://services.samples" version="2.0" exclude-result-prefixes="m0 fn">
       <xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />
       <xsl:template match="/">
          <Payment>
             <xsl:for-each select="//order/lunch[contains(drinkName, 'Coffee')]">
                <discount>
                   <xsl:value-of select="drinkPrice" />
                </discount>
             </xsl:for-each>
          </Payment>
       </xsl:template>
    </xsl:stylesheet>
    ```

Pass the following XML payload using SOAP UI.

!!! Info
    You pass this payload into the XSLT mediator specifying a certain
    `         drinkName        ` as a parameter to the style sheet. For
    example, the following payload passes the `         drinkName        `
    as 'Coffee'. The style sheet traverses through the incoming payload and
    finds the `         <lunch>        ` elements, which contains 'Coffee'
    as `         drinkName        ` . When it finds matching ectries, it
    adds the prices of those elements under a new
    `         <Payment>        ` element. Therefore, when the message flow
    comes out of XSLT mediator, the payload changes the
    `         <Payment>        ` entry, where it contains the
    `         drinkPrice        ` values of matching elements.

``` xml
<order>
<lunch>
<meal> Rice and Curry </meal>
<mealPrice> USD 10 </mealPrice>
<drinkName> Dark Coffee </drinkName>
<drinkPrice> USD 1.8 </drinkPrice>
</lunch>
<lunch>
<meal> Sandwiches </meal>
<mealPrice> USD 4 </mealPrice>
<drinkName> Milk Shake </drinkName>
<drinkPrice> USD 2.6 </drinkPrice>
</lunch>
<lunch>
<meal> Chicken Burger </meal>
<mealPrice> USD 5 </mealPrice>
<drinkName> Iced Coffee </drinkName>
<drinkPrice> USD 1.5 </drinkPrice>
</lunch>
<lunch>
<meal> Noodles </meal>
<mealPrice> USD 8 </mealPrice>
<drinkName> Bottled Water </drinkName>
<drinkPrice> USD 2.5 </drinkPrice>
</lunch>
</order>
```